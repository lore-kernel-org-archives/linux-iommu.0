Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E49C433EF
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 21:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4CD142A8B;
	Fri, 27 May 2022 21:39:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yNIiGeCiZPCW; Fri, 27 May 2022 21:39:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1E61242A8E;
	Fri, 27 May 2022 21:39:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34D3AC008A;
	Fri, 27 May 2022 21:39:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D558C002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBB8884C03
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iN45SYsn6-eh for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 21:38:56 +0000 (UTC)
X-Greylist: delayed 00:09:13 by SQLgrey-1.8.0
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0BD6A84C00
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:38:55 +0000 (UTC)
Received: from localhost.localdomain (abxh119.neoplus.adsl.tpnet.pl
 [83.9.1.119])
 by m-r1.th.seeweb.it (Postfix) with ESMTPA id 356B520569;
 Fri, 27 May 2022 23:29:38 +0200 (CEST)
From: Konrad Dybcio <konrad.dybcio@somainline.org>
To: ~postmarketos/upstreaming@lists.sr.ht, linux-arm-msm@vger.kernel.org,
 bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access
 behavior
Date: Fri, 27 May 2022 23:28:57 +0200
Message-Id: <20220527212901.29268-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527212901.29268-1-konrad.dybcio@somainline.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, linux-kernel@vger.kernel.org,
 jamipkettunen@somainline.org, martin.botka@somainline.org,
 angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org,
 Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

As also stated in the arm-smmu driver, we must write the TCR before
writing the TTBRs, since the TCR determines the access behavior of
some fields.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 1728d4d7fe25..75f353866c40 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			ctx->secure_init = true;
 		}
 
-		/* TTBRs */
-		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
-				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
-				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
-		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
-
 		/* TCR */
 		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
 				arm_smmu_lpae_tcr2(&pgtbl_cfg));
 		iommu_writel(ctx, ARM_SMMU_CB_TCR,
 			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
 
+		/* TTBRs */
+		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
+				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
+				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
+		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
+
 		/* MAIRs (stage-1 only) */
 		iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0,
 				pgtbl_cfg.arm_lpae_s1_cfg.mair);
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
