From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 06/26] iommu/amd: Fix IOMMU page flush when detach device from a domain
Date: Sat, 23 Feb 2019 16:10:27 -0500
Message-ID: <20190223211047.202725-6-sashal@kernel.org>
References: <20190223211047.202725-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190223211047.202725-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

[ Upstream commit 9825bd94e3a2baae1f4874767ae3a7d4c049720e ]

When a VM is terminated, the VFIO driver detaches all pass-through
devices from VFIO domain by clearing domain id and page table root
pointer from each device table entry (DTE), and then invalidates
the DTE. Then, the VFIO driver unmap pages and invalidate IOMMU pages.

Currently, the IOMMU driver keeps track of which IOMMU and how many
devices are attached to the domain. When invalidate IOMMU pages,
the driver checks if the IOMMU is still attached to the domain before
issuing the invalidate page command.

However, since VFIO has already detached all devices from the domain,
the subsequent INVALIDATE_IOMMU_PAGES commands are being skipped as
there is no IOMMU attached to the domain. This results in data
corruption and could cause the PCI device to end up in indeterministic
state.

Fix this by invalidate IOMMU pages when detach a device, and
before decrementing the per-domain device reference counts.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Suggested-by: Joerg Roedel <joro@8bytes.org>
Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Fixes: 6de8ad9b9ee0 ('x86/amd-iommu: Make iommu_flush_pages aware of multiple IOMMUs')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 52c36394dba50..0ad8b7c78a438 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1982,6 +1982,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 
 static void do_detach(struct iommu_dev_data *dev_data)
 {
+	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 	u16 alias;
 
@@ -1997,10 +1998,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
 	alias = dev_data->alias;
 
-	/* decrease reference counters */
-	dev_data->domain->dev_iommu[iommu->index] -= 1;
-	dev_data->domain->dev_cnt                 -= 1;
-
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
@@ -2010,6 +2007,16 @@ static void do_detach(struct iommu_dev_data *dev_data)
 
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
+
+	/* Flush IOTLB */
+	domain_flush_tlb_pde(domain);
+
+	/* Wait for the flushes to finish */
+	domain_flush_complete(domain);
+
+	/* decrease reference counters - needs to happen after the flushes */
+	domain->dev_iommu[iommu->index] -= 1;
+	domain->dev_cnt                 -= 1;
 }
 
 /*
-- 
2.19.1
