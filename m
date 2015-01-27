From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH v1 3/3] Documentation: dt-bindings: Add the binding info for
	APM X-Gene AHBC IOMMU driver.
Date: Tue, 27 Jan 2015 22:55:54 +0530
Message-ID: <1422379554-10328-4-git-send-email-stripathi@apm.com>
References: <1422379554-10328-1-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422379554-10328-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds the device tree binding information for X-Gene
AHBC IOMMU driver.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 .../devicetree/bindings/iommu/xgene,ahbc-iommu.txt | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/xgene,ahbc-iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/xgene,ahbc-iommu.txt b/Documentation/devicetree/bindings/iommu/xgene,ahbc-iommu.txt
new file mode 100644
index 0000000..37ad3a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/xgene,ahbc-iommu.txt
@@ -0,0 +1,31 @@
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
+- iommu-cells   : It is single master IOMMU.
+
+Example:
+		/* IOMMU controller device node */
+		ahbc_iommu: ahbc_iommu@0x1f2a0080 {
+			compatible = "apm,xgene-ahbc-iommu";
+			#iommu-cells = <0>;
+			reg = <0x0 0x1f2a0080 0x0 0x90>;
+		};
+
+		/* Master node */
+		sdhc0: sdhc@1c000000 {
+			device_type = "sdhc";
+			compatible = "arasan,sdhci-8.9a";
+			reg = <0x0 0x1c000000 0x0 0x100>;
+			interrupts = <0x0 0x49 0x4>;
+			clock-names = "clk_xin", "clk_ahb";
+			clocks = <&sdioclk 0>, <&ahbclk 0>;
+			iommus = <&ahbc_iommu>;
+		};
+
--
1.8.2.1
