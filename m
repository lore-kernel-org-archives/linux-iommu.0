Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42454C433FE
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 21:39:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79C3C6F4C4;
	Fri, 27 May 2022 21:39:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CYEn5Owjl5YP; Fri, 27 May 2022 21:39:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 560D96F4C0;
	Fri, 27 May 2022 21:39:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3ECAC007F;
	Fri, 27 May 2022 21:39:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEBA2C0039
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C1B084C07
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Z6A8niYTTyR for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 21:38:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it
 [IPv6:2001:4b7a:2000:18::165])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12B7584C05
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:38:55 +0000 (UTC)
Received: from localhost.localdomain (abxh119.neoplus.adsl.tpnet.pl
 [83.9.1.119])
 by m-r1.th.seeweb.it (Postfix) with ESMTPA id C74EB2058B;
 Fri, 27 May 2022 23:29:40 +0200 (CEST)
From: Konrad Dybcio <konrad.dybcio@somainline.org>
To: ~postmarketos/upstreaming@lists.sr.ht, linux-arm-msm@vger.kernel.org,
 bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 4/6] iommu/qcom: Add support for AArch64 IOMMU pagetables
Date: Fri, 27 May 2022 23:28:59 +0200
Message-Id: <20220527212901.29268-5-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527212901.29268-1-konrad.dybcio@somainline.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, linux-kernel@vger.kernel.org,
 jamipkettunen@somainline.org, Rob Herring <robh+dt@kernel.org>,
 Andy Gross <agross@kernel.org>, martin.botka@somainline.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

Some IOMMUs associated with some TZ firmwares may support switching
to the AArch64 pagetable format by sending a "set pagetable format"
scm command indicating the IOMMU secure ID and the context number
to switch.

Add a DT property "qcom,use-aarch64-pagetables" for this driver to
send this command to the secure world and to switch the pagetable
format to benefit of the ARM64 IOMMU pagetables, where possible.

Note that, even though the command should be valid to switch each
context, the property is made global because:
1. It doesn't make too much sense to switch only one or two
   context(s) to AA64 instead of just the entire thing
2. Some IOMMUs will go crazy and produce spectacular results when
   trying to mix up the pagetables on a per-context basis.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../devicetree/bindings/iommu/qcom,iommu.txt  |  2 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 54 +++++++++++++++----
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index ba0b77889f02..72ae0595efff 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -47,6 +47,8 @@ to non-secure vs secure interrupt line.
                      secure lines.  (Ie. if the iommu contains secure
                      context banks)
 - qcom,ctx-num     : The number associated to the context bank
+- qcom,use-aarch64-pagetables : Switch to AArch64 pagetable format on all
+                                contexts declared in this IOMMU
 
 
 ** Examples:
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 129e322f56a6..530aa92bf6a1 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -52,6 +52,7 @@ struct qcom_iommu_dev {
 	void __iomem		*local_base;
 	u32			 sec_id;
 	u8			 num_ctxs;
+	bool			 use_aarch64_pt;
 	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid-1 */
 };
 
@@ -164,11 +165,17 @@ static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
 
 	for (i = 0; i < fwspec->num_ids; i++) {
+		struct qcom_iommu_dev *qcom_iommu = qcom_domain->iommu;
 		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 		size_t s = size;
 
-		iova = (iova >> 12) << 12;
-		iova |= ctx->asid;
+		if (qcom_iommu->use_aarch64_pt) {
+			iova >>= 12;
+			iova |= (unsigned long)ctx->asid << 48;
+		} else {
+			iova &= (1UL << 12) - 1UL;
+			iova |= ctx->asid;
+		}
 		do {
 			iommu_writel(ctx, reg, iova);
 			iova += granule;
@@ -248,6 +255,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct io_pgtable_ops *pgtbl_ops;
 	struct io_pgtable_cfg pgtbl_cfg;
+	enum io_pgtable_fmt pgtbl_fmt;
+	unsigned long ias, oas;
 	int i, ret = 0;
 	u32 reg;
 
@@ -255,10 +264,19 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	if (qcom_domain->iommu)
 		goto out_unlock;
 
+	if (qcom_iommu->use_aarch64_pt) {
+		pgtbl_fmt = ARM_64_LPAE_S1;
+		ias = oas = 48;
+	} else {
+		pgtbl_fmt = ARM_32_LPAE_S1;
+		ias = 32;
+		oas = 40;
+	}
+
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= qcom_iommu_ops.pgsize_bitmap,
-		.ias		= 32,
-		.oas		= 40,
+		.ias		= ias,
+		.oas		= oas,
 		.tlb		= &qcom_flush_ops,
 		.iommu_dev	= qcom_iommu->dev,
 	};
@@ -266,7 +284,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	qcom_domain->iommu = qcom_iommu;
 	qcom_domain->fwspec = fwspec;
 
-	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, qcom_domain);
+	pgtbl_ops = alloc_io_pgtable_ops(pgtbl_fmt, &pgtbl_cfg, qcom_domain);
 	if (!pgtbl_ops) {
 		dev_err(qcom_iommu->dev, "failed to allocate pagetable ops\n");
 		ret = -ENOMEM;
@@ -280,6 +298,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+		u32 tcr[2];
 
 		if (!ctx->secure_init) {
 			ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, ctx->asid);
@@ -292,11 +311,25 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 		qcom_iommu_reset_ctx(ctx);
 
+
+		tcr[0] = arm_smmu_lpae_tcr(&pgtbl_cfg);
+		tcr[1] = arm_smmu_lpae_tcr2(&pgtbl_cfg);
+
+		if (!qcom_iommu->use_aarch64_pt) {
+			tcr[0] |= ARM_SMMU_TCR_EAE;
+		} else {
+			/* This shall not fail, or spectacular things happen! */
+			if (qcom_scm_iommu_set_pt_format(qcom_iommu->sec_id, ctx->asid, 1)) {
+				dev_warn(qcom_iommu->dev, "Cannot set AArch64 pt format\n");
+				goto out_clear_iommu;
+			}
+
+			tcr[1] |= ARM_SMMU_TCR2_AS;
+		}
+
 		/* TCR */
-		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
-				arm_smmu_lpae_tcr2(&pgtbl_cfg));
-		iommu_writel(ctx, ARM_SMMU_CB_TCR,
-			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
+		iommu_writel(ctx, ARM_SMMU_CB_TCR2, tcr[1]);
+		iommu_writel(ctx, ARM_SMMU_CB_TCR, tcr[0]);
 
 		/* TTBRs */
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
@@ -844,6 +877,9 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (of_property_read_bool(dev->of_node, "qcom,use-aarch64-pagetables"))
+		qcom_iommu->use_aarch64_pt = true;
+
 	if (qcom_iommu_has_secure_context(qcom_iommu)) {
 		ret = qcom_iommu_sec_ptbl_init(dev);
 		if (ret) {
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
