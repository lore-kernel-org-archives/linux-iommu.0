From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 27/35] iommu/vt-d: Use memunmap to free memremap
Date: Thu, 29 Nov 2018 01:01:01 -0500
Message-ID: <20181129060110.159878-27-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Pan Bian <bianpan2016@163.com>, Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 829383e183728dec7ed9150b949cd6de64127809 ]

memunmap() should be used to free the return of memremap(), not
iounmap().

Fixes: dfddb969edf0 ('iommu/vt-d: Switch from ioremap_cache to memremap')
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index aaf3fed97477..e86c1c8ec7f6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3086,7 +3086,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 			}
 
 			if (old_ce)
-				iounmap(old_ce);
+				memunmap(old_ce);
 
 			ret = 0;
 			if (devfn < 0x80)
-- 
2.17.1
