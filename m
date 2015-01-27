From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH v1 2/3] arm64: dts: Add the APM X-Gene AHBC IOMMU DTS node.
Date: Tue, 27 Jan 2015 22:55:53 +0530
Message-ID: <1422379554-10328-3-git-send-email-stripathi@apm.com>
References: <1422379554-10328-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422379554-10328-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds the device tree node for APM X-Gene AHBC IOMMU and
master node as SDHCI.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 arch/arm64/boot/dts/apm-storm.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 52de7d3..22bc9d1 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -621,6 +621,12 @@
 			phy-names = "sata-phy";
 		};

+		ahbc_iommu: ahbc_iommu@0x1f2a0080 {
+			compatible = "apm,xgene-ahbc-iommu";
+			#iommu-cells = <0>;
+			reg = <0x0 0x1f2a0080 0x0 0x90>;
+		};
+
 		rtc: rtc@10510000 {
 			compatible = "apm,xgene-rtc";
 			reg = <0x0 0x10510000 0x0 0x400>;
@@ -636,6 +642,7 @@
 			interrupts = <0x0 0x49 0x4>;
 			clock-names = "clk_xin", "clk_ahb";
 			clocks = <&sdioclk 0>, <&ahbclk 0>;
+			iommus = <&ahbc_iommu>;
 		};

 		menet: ethernet@17020000 {
--
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
