From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/3] Documentation: dt-bindings: Add device-tree binding for
	ARM SMMUv3 IOMMU
Date: Fri,  8 May 2015 19:00:44 +0100
Message-ID: <1431108046-9675-2-git-send-email-will.deacon@arm.com>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1431108046-9675-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds device-tree bindings for ARM SMMUv3 IOMMU devices.

Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
new file mode 100644
index 000000000000..c03eec116872
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -0,0 +1,37 @@
+* ARM SMMUv3 Architecture Implementation
+
+The SMMUv3 architecture is a significant deparature from previous
+revisions, replacing the MMIO register interface with in-memory command
+and event queues and adding support for the ATS and PRI components of
+the PCIe specification.
+
+** SMMUv3 required properties:
+
+- compatible        : Should include:
+
+                      * "arm,smmu-v3" for any SMMUv3 compliant
+                        implementation. This entry should be last in the
+                        compatible list.
+
+- reg               : Base address and size of the SMMU.
+
+- interrupts        : Non-secure interrupt list describing the wired
+                      interrupt sources corresponding to entries in
+                      interrupt-names. If no wired interrupts are
+                      present then this property may be omitted.
+
+- interrupt-names   : When the interrupts property is present, should
+                      include the following:
+                      * "eventq"    - Event Queue not empty
+                      * "priq"      - PRI Queue not empty
+                      * "cmdq-sync" - CMD_SYNC complete
+                      * "gerror"    - Global Error activated
+
+** SMMUv3 optional properties:
+
+- dma-coherent      : Present if DMA operations made by the SMMU (page
+                      table walks, stream table accesses etc) are cache
+                      coherent with the CPU.
+
+                      NOTE: this only applies to the SMMU itself, not
+                      masters connected upstream of the SMMU.
-- 
2.1.4
