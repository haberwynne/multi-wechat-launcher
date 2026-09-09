#!/bin/bash
# =============================================================================
#  Mac WeChat Multi-Instance Launcher
#  macOS 微信多开脚本
#
#  Usage:
#    chmod +x multi_wechat_mac.sh
#    ./multi_wechat_mac.sh
#
#  Requirements:
#    - macOS 10.13+
#    - 微信 (WeChat.app) 已安装在 /Applications
# =============================================================================

set -u

# ---- Configurable variables -------------------------------------------------
WECHAT_APP="/Applications/WeChat.app"
LAUNCH_DELAY=1            # seconds between launches
COPY_PREFIX="/tmp/wechat_multi_"   # temp dir for app copies (Method 2)
# -----------------------------------------------------------------------------

echo "================================================"
echo "  Mac WeChat Multi-Instance Launcher"
echo "================================================"

# ---- Pre-check: app exists --------------------------------------------------
if [ ! -d "$WECHAT_APP" ]; then
    echo "[ERROR] WeChat.app not found at: $WECHAT_APP"
    echo "Please install WeChat from the App Store, or update WECHAT_APP in this script."
    exit 1
fi

# ---- Prompt user for count --------------------------------------------------
read -r -p "Please enter the number of WeChat instances to launch: " NUM

# Validate input
if ! [[ "$NUM" =~ ^[0-9]+$ ]]; then
    echo "[ERROR] Please enter a valid positive integer."
    exit 1
fi
if [ "$NUM" -le 0 ]; then
    echo "[ERROR] Number must be greater than 0."
    exit 1
fi

echo ""
echo "[INFO] About to launch $NUM WeChat instance(s)..."
echo ""

# ---- Method selection --------------------------------------------------------
# Method 1: open -n (simpler, works in most macOS versions)
# Method 2: copy .app to a temp dir, then open (more reliable, recommended)
# We use Method 2 by default. Set USE_METHOD_1=1 to switch to Method 1.

USE_METHOD_1=${USE_METHOD_1:-0}

if [ "$USE_METHOD_1" -eq 1 ]; then
    # Method 1: open -n (may show "already running" alert on newer macOS)
    for i in $(seq 1 "$NUM"); do
        echo "[$i/$NUM] Launching WeChat via 'open -n'..."
        open -n "$WECHAT_APP" 2>/dev/null
        sleep "$LAUNCH_DELAY"
    done
else
    # Method 2: copy .app and launch each copy (most reliable)
    echo "[INFO] Using Method 2: copying WeChat.app per instance"
    echo "[INFO] Temp directory: $COPY_PREFIX"
    echo ""

    # Cleanup any old copies
    rm -rf ${COPY_PREFIX}* 2>/dev/null

    for i in $(seq 1 "$NUM"); do
        INSTANCE_DIR="${COPY_PREFIX}${i}"
        echo "[$i/$NUM] Preparing $INSTANCE_DIR ..."
        cp -R "$WECHAT_APP" "$INSTANCE_DIR" 2>/dev/null

        if [ ! -d "$INSTANCE_DIR" ]; then
            echo "        [WARN] Copy failed. Falling back to 'open -n' for this instance."
            open -n "$WECHAT_APP" 2>/dev/null
        else
            open -n "$INSTANCE_DIR" 2>/dev/null
        fi
        sleep "$LAUNCH_DELAY"
    done
fi

echo ""
echo "[OK] All $NUM WeChat instance(s) launched."
echo "[TIP] You can close the temp copies later with:"
echo "      rm -rf ${COPY_PREFIX}*"
echo ""
