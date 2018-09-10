From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 1/7 v7] Documentation: fsl-mc: add iommu-map device-tree
	binding for fsl-mc bus
Date: Mon, 10 Sep 2018 19:19:15 +0530
Message-ID: <1536587361-11047-2-git-send-email-nipun.gupta@nxp.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta-3arQi8VN3Tc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, laurentiu.tudor-3arQi8VN3Tc@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, leoyang.li-3arQi8VN3Tc@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The existing IOMMU bindings cannot be used to specify the relationship
between fsl-mc devices and IOMMUs. This patch adds a generic binding for
mapping fsl-mc devices to IOMMUs, using iommu-map property.

Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index 6611a7c..01fdc33 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -9,6 +9,25 @@ blocks that can be used to create functional hardware objects/devices
 such as network interfaces, crypto accelerator instances, L2 switches,
 etc.
 
+For an overview of the DPAA2 architecture and fsl-mc bus see:
+Documentation/networking/dpaa2/overview.rst
+
+As described in the above overview, all DPAA2 objects in a DPRC share the
+same hardware "isolation context" and a 10-bit value called an ICID
+(isolation context id) is expressed by the hardware to identify
+the requester.
+
+The generic 'iommus' property is insufficient to describe the relationship
+between ICIDs and IOMMUs, so an iommu-map property is used to define
+the set of possible ICIDs under a root DPRC and how they map to
+an IOMMU.
+
+For generic IOMMU bindings, see
+Documentation/devicetree/bindings/iommu/iommu.txt.
+
+For arm-smmu binding, see:
+Documentation/devicetree/bindings/iommu/arm,smmu.txt.
+
 Required properties:
 
     - compatible
@@ -88,14 +107,34 @@ Sub-nodes:
               Value type: <phandle>
               Definition: Specifies the phandle to the PHY device node associated
                           with the this dpmac.
+Optional properties:
+
+- iommu-map: Maps an ICID to an IOMMU and associated iommu-specifier
+  data.
+
+  The property is an arbitrary number of tuples of
+  (icid-base,iommu,iommu-base,length).
+
+  Any ICID i in the interval [icid-base, icid-base + length) is
+  associated with the listed IOMMU, with the iommu-specifier
+  (i - icid-base + iommu-base).
 
 Example:
 
+        smmu: iommu@5000000 {
+               compatible = "arm,mmu-500";
+               #iommu-cells = <1>;
+               stream-match-mask = <0x7C00>;
+               ...
+        };
+
         fsl_mc: fsl-mc@80c000000 {
                 compatible = "fsl,qoriq-mc";
                 reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
                       <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
                 msi-parent = <&its>;
+                /* define map for ICIDs 23-64 */
+                iommu-map = <23 &smmu 23 41>;
                 #address-cells = <3>;
                 #size-cells = <1>;
 
-- 
1.9.1
