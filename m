From: Varun Sethi <Varun.Sethi@freescale.com>
Subject: [RFC][PATCH] devicetree: Add master-id-bits property to the iommu
 device
Date: Sun, 14 Sep 2014 23:47:26 +0530
Message-ID: <1410718646-9710-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, thierry.reding@gmail.com, Mark.Rutland@arm.com, will.deacon@arm.com, hdoyu@nvidia.com, swarren@nvidia.com, arnd@arndb.de, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, stuart.yoder@freescale.com
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

"master-id-bits" property added to the IOMMU device node. This property can
be used by the IOMMU driver to match relevan bits in the master id expressed
by a DMA master.

This can be used to mask out certain bits that get added to the device master id
due to IOMMU topology. For example, in case of MMU-500 the TBUID gets appended to
the master id. This prevents sharing of a stream ID, amongst devices which are
connected to different TBUs. 

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 Documentation/devicetree/bindings/iommu/iommu.txt |   29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b462..f7c8623 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -63,6 +63,23 @@ Note that these are merely examples and real-world use-cases may use different
 definitions to represent their individual needs. Always refer to the specific
 IOMMU binding for the exact meaning of the cells that make up the specifier.
 
+Optional properties:
+--------------------
+- master-id-bits: This specifies number of master id bits used by the iommu, to
+  match master id expressed by the DMA master device. This would be typically used
+  in cases where we need DMA memory isolation between multiple masters. Each master
+  would specify a master id associated with a DMA trasaction.
+
+  The IOMMU driver can use this property to generate a mask to match only relevant
+  bits in the master id. This can be used for masking out certain bits that get
+  added to the master id as a part of the IOMMU topology.
+
+  For example, in case of MMU-500 the TBU identifier is also appended to the master id.
+  This posese issues for software implementations requiring dynamic master id allocation
+  for supporting hot pluggable devices. It's possible to have a device group, with
+  devices connected to different TBUs. Without masking the additional TBU ID bits, we
+  can't share the master id across all devices in the device group.
+
 
 IOMMU master node:
 ==================
@@ -147,6 +164,12 @@ Multiple-master IOMMU:
 	iommu {
 		/* the specifier represents the ID of the master */
 		#iommu-cells = <1>;
+
+		/*
+		 * This specifies number of master id bits used by
+		 * the iommu for matching the master id.
+		 */
+		master-id-bits = <7>
 	};
 
 	master@1 {
@@ -173,6 +196,12 @@ Multiple-master IOMMU with configurable DMA window:
 			 * master (i.e. the I/O virtual address space).
 			 */
 			#iommu-cells = <4>;
+
+			/*
+			 * This specifies number of master id bits used by
+			 * the iommu for matching the master id.
+			 */
+			master-id-bits = <7>
 		};
 
 		master {
-- 
1.7.9.5
