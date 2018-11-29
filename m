From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 04/35] iommu/ipmmu-vmsa: Fix crash on early domain free
Date: Thu, 29 Nov 2018 01:00:38 -0500
Message-ID: <20181129060110.159878-4-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit e5b78f2e349eef5d4fca5dc1cf5a3b4b2cc27abd ]

If iommu_ops.add_device() fails, iommu_ops.domain_free() is still
called, leading to a crash, as the domain was only partially
initialized:

    ipmmu-vmsa e67b0000.mmu: Cannot accommodate DMA translation for IOMMU page tables
    sata_rcar ee300000.sata: Unable to initialize IPMMU context
    iommu: Failed to add device ee300000.sata to group 0: -22
    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
    ...
    Call trace:
     ipmmu_domain_free+0x1c/0xa0
     iommu_group_release+0x48/0x68
     kobject_put+0x74/0xe8
     kobject_del.part.0+0x3c/0x50
     kobject_put+0x60/0xe8
     iommu_group_get_for_dev+0xa8/0x1f0
     ipmmu_add_device+0x1c/0x40
     of_iommu_configure+0x118/0x190

Fix this by checking if the domain's context already exists, before
trying to destroy it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Fixes: d25a2a16f0889 ('iommu: Add driver for Renesas VMSA-compatible IPMMU')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/ipmmu-vmsa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 5d0ba5f644c4..777aff1f549f 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -424,6 +424,9 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 
 static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
 {
+	if (!domain->mmu)
+		return;
+
 	/*
 	 * Disable the context. Flush the TLB as required when modifying the
 	 * context registers.
-- 
2.17.1
