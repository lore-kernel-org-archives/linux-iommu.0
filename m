From: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [RFC PATCH v5 4/5] powerpc/iommu: Set IOMMU_GROUP_CAP_ISOLATE_MSIX
Date: Mon,  7 Aug 2017 17:25:47 +1000
Message-ID: <20170807072548.3023-5-aik@ozlabs.ru>
References: <20170807072548.3023-1-aik@ozlabs.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807072548.3023-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>, Eric Auger <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Jike Song <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>, Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Neo Jia <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>, Vlad Tsyrklevich <vlad@tsyrklevich.net>
List-Id: iommu@lists.linux-foundation.org

This sets IOMMU_GROUP_CAP_ISOLATE_MSIX to a group unconditionally as
there is no IOMMU-capable hardware without such a feature.

On IBM POWERPC (POWER8) [1], PCI host bridge maintains BFDN-to-PE
translation (PE stands for "partitionable endpoint"), and PE index is used
to look at Interrupt Vector Table (IVT) to identify the interrupt server.
Without these translations in place, MSIX messages won't pass PHB.

[1] 3.2.4. MSI Design
http://openpowerfoundation.org/wp-content/uploads/resources/IODA2Spec/IODA2WGSpec-1.0.0-20160217.pdf

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 233ca3fe4754..dca0a83f1560 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -936,6 +936,7 @@ void iommu_register_group(struct iommu_table_group *table_group,
 	if (!name)
 		return;
 	iommu_group_set_name(grp, name);
+	iommu_group_set_caps(grp, 0, IOMMU_GROUP_CAP_ISOLATE_MSIX);
 	kfree(name);
 }
 
-- 
2.11.0
