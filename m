From: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [RFC PATCH v5 3/5] iommu/intel/amd: Set IOMMU_GROUP_CAP_ISOLATE_MSIX if IRQ remapping is enabled
Date: Mon,  7 Aug 2017 17:25:46 +1000
Message-ID: <20170807072548.3023-4-aik@ozlabs.ru>
References: <20170807072548.3023-1-aik@ozlabs.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807072548.3023-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>, Eric Auger <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Jike Song <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>, Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Neo Jia <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>, Vlad Tsyrklevich <vlad@tsyrklevich.net>
List-Id: iommu@lists.linux-foundation.org

This sets IOMMU_GROUP_CAP_ISOLATE_MSIX to a group if IRQ remapping
is enabled. For Intel, this checks disable_sourceid_checking in addition;
AMD ignores the "nosid" kernel parameters.

Here is some background on how the isolation works:

On Intel VT-d [1], there is an Interrupt Remapping Table, one entry per
interrupt, has a source-id (i.e. BDFN) of allowed device.

On AMD IOMMU [2], there is a Device Table, each entry is indexed by
DevideID which is BDFN.

[1] 9.10 Interrupt Remapping Table Entry (IRTE) for Remapped Interrupts
https://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf

[2] "2.2 Data Structures" and "2.2.5 Interrupt Remapping Tables"
https://support.amd.com/TechDocs/48882_IOMMU.pdf

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/iommu/amd_iommu.c   | 3 +++
 drivers/iommu/intel-iommu.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 688e77576e5a..d55fcbf3267e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -470,6 +470,9 @@ static void init_iommu_group(struct device *dev)
 	if (IS_ERR(group))
 		return;
 
+	if (irq_remapping_enabled)
+		iommu_group_set_caps(group, 0, IOMMU_GROUP_CAP_ISOLATE_MSIX);
+
 	iommu_group_put(group);
 }
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b7e670a7c243..3896c2d44bfa 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5233,6 +5233,9 @@ static int intel_iommu_add_device(struct device *dev)
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
+	if (irq_remapping_enabled && !disable_sourceid_checking)
+		iommu_group_set_caps(group, 0, IOMMU_GROUP_CAP_ISOLATE_MSIX);
+
 	iommu_group_put(group);
 	return 0;
 }
-- 
2.11.0
