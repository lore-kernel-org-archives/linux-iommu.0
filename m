From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 2/3] arm64: dts: Add the APM X-Gene AHBC IOMMU DTS node.
Date: Mon, 15 Dec 2014 22:25:22 +0530
Message-ID: <1418662523-8458-3-git-send-email-stripathi@apm.com>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418662523-8458-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds the device tree node for APM X-Gene AHBC IOMMU.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 arch/arm64/boot/dts/apm-storm.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index c0aceef..f0a6b71 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -389,6 +389,11 @@
 			phy-names = "sata-phy";
 		};

+		ahbc_iommu: ahbc_iommu@0x1f2a0080 {
+			compatible = "apm,xgene-ahbc-iommu";
+			reg = <0x0 0x1f2a0080 0x0 0x90>;
+		};
+
 		rtc: rtc@10510000 {
 			compatible = "apm,xgene-rtc";
 			reg = <0x0 0x10510000 0x0 0x400>;
--
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
