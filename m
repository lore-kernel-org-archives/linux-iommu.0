From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Subject: [RFC 1/5] dt-bindings: iommu: Add reserved-dma-region for IOMMU device
Date: Tue,  6 Mar 2018 10:29:24 +0530
Message-ID: <1520312368-7068-2-git-send-email-jitendra.bhivare@broadcom.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Certain regions in IO virtual address space may need to be reserved to be
not used for devices configured behind IOMMU.

Add documentation of the property to allow such regions to be specified in
DT to be reserved using IOMMU_RESV_RESERVED type.

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b462..5a58ef2 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -98,6 +98,20 @@ requirements of that use-case haven't been fully determined yet. Implementing
 this is therefore not recommended without further discussion and extension of
 this binding.
 
+Optional properties:
+--------------------
+- reserved-dma-region: This specifies DMA region to be reserved with specific
+  prot in IOVA space. It is in tuples of (busno,prot,bus_addr,size).
+
+- #region-address-cells: specifies number of cells needed to encode bus_addr
+
+- #region-size-cells: specifies number of cells needed to encode size
+
+Notes:
+======
+This can be applied to IOMMU master node or to children (such as PCI host
+bridges) on the bus behind IOMMU.
+
 
 Examples:
 =========
@@ -173,6 +187,9 @@ Multiple-master IOMMU with configurable DMA window:
 			 * master (i.e. the I/O virtual address space).
 			 */
 			#iommu-cells = <4>;
+			#region-address-cells = <2>;
+			#region-size-cells = <2>;
+			reserved-dma-region = <0x0 0x0 0x04 0x0 0x04 0x0>;
 		};
 
 		master {
-- 
2.7.4
