Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962CC5CA6
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 16:12:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D2CE106F;
	Wed,  7 Sep 2022 09:12:23 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 59C323F71A;
	Wed,  7 Sep 2022 09:12:16 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH] iommu/ipmmu-vmsa: Drop of_match_ptr()
Date: Wed,  7 Sep 2022 17:12:12 +0100
Message-Id: <dcab234a51ed2d9e79d2f960f6da5f59361a2931.1662566939.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop of_match_ptr() to avoid an unused variable warning when
compile-testing with CONFIG_OF=n. The driver is not actually usable in
that configuration, so there's no point trying to optimise out data.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

fixes "iommu/ipmmu-vmsa: Clean up bus_set_iommu()"

 drivers/iommu/ipmmu-vmsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 3b30c0752274..20f6a620a127 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1157,7 +1157,7 @@ static const struct dev_pm_ops ipmmu_pm  = {
 static struct platform_driver ipmmu_driver = {
 	.driver = {
 		.name = "ipmmu-vmsa",
-		.of_match_table = of_match_ptr(ipmmu_of_ids),
+		.of_match_table = ipmmu_of_ids,
 		.pm = DEV_PM_OPS,
 	},
 	.probe = ipmmu_probe,
-- 
2.36.1.dirty

