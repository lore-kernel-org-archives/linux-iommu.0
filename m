From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 3/3] Documentation: dt-bindings: Add the binding info for APM X-Gene AHBC IOMMU driver.
Date: Mon, 15 Dec 2014 22:25:23 +0530
Message-ID: <1418662523-8458-4-git-send-email-stripathi@apm.com>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418662523-8458-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds the device tree binding information for X-Gene
AHBC IOMMU driver.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 .../devicetree/bindings/iommu/xgene,ahbc-iommu.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/xgene,ahbc-iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/xgene,ahbc-iommu.txt b/Documentation/devicetree/bindings/iommu/xgene,ahbc-iommu.txt
new file mode 100644
index 0000000..d46af54
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/xgene,ahbc-iommu.txt
@@ -0,0 +1,17 @@
+*APM X-Gene AHBC IOMMU Architecture Implementation
+
+APM X-Gene SoC AHBC IOMMU translates the AHBC 32-bit address from
+dma master to 42-bit AXI address by using a set of AIM(AHB Inbound mapper)
+register.
+
+** AHBC IOMMU required properties:
+
+- compatible    : Should be "apm,xgene-ahbc-iommu"
+- reg           : Base address of the AHBC AXI mapper registers
+
+Example:
+
+		ahbc_iommu: ahbc_iommu@0x1f2a0080 {
+			compatible = "apm,xgene-ahbc-iommu";
+			reg = <0x0 0x1f2a0080 0x0 0x90>;
+		};
--
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
