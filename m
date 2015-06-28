From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iommu/arm-smmu: Delete an unnecessary check before the function
 call "free_io_pgtable_ops"
Date: Sun, 28 Jun 2015 16:05:13 +0200
Message-ID: <558FFF19.1060402@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: =?windows-1252?Q?J=F6rg_R=F6del?= <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: iommu@lists.linux-foundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 28 Jun 2015 15:55:11 +0200

The free_io_pgtable_ops() function tests whether its argument is NULL
and then returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iommu/arm-smmu-v3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f141301..8e9ec81 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1389,8 +1389,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (smmu_domain->pgtbl_ops)
-		free_io_pgtable_ops(smmu_domain->pgtbl_ops);
+	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
 	/* Free the CD and ASID, if we allocated them */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-- 
2.4.4

