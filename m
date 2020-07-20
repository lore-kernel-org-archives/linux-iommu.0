Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D16C433ED
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2E7206E9
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZT0n3IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2E7206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2F2D92042B;
	Mon, 20 Jul 2020 15:51:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-HABoT3wFwT; Mon, 20 Jul 2020 15:51:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1C09F2040E;
	Mon, 20 Jul 2020 15:51:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9457C089F;
	Mon, 20 Jul 2020 15:51:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E299DC016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D152A877DB
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:51:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7fcOTBDyyl7z for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 15:51:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 06B49877D1
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:51:45 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id j20so9235528pfe.5
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J3DxpFDz2en6MDVSIDSJcw1EYyuDLb4b/ATPWNGpNV8=;
 b=JZT0n3IZ2gmQ8fpJFxdKTwqEWfpNF++ce0QdDWhdVdxr95qPcbh12WKSRwbsQLeSSF
 vAT5atm2XlURTCu3d+jZSJCMxlZNyPAOO2j0kNv8yW0UOfJDr+zQQBgzZ5CeDlnY3Ptf
 jGJTd5Xt11Y0jEMIIqDZPJk75Bpb4IrrNV36FiMwXtJiUQS50pxXu7P39aIG2aiRlvHN
 KEqVgJcjiVJlsd5cNwVYM1g45AHN/FEGXcd+gixlyZTmyGViSl/DU97wDlm14vYG9Nxu
 1BZbiZ1wHE+1mNtgl3942CsfrPTStdowCFujfvelJCYljzBDFDIojreFa2jBdiMik/eM
 p3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J3DxpFDz2en6MDVSIDSJcw1EYyuDLb4b/ATPWNGpNV8=;
 b=r+RvDcGWVPHoTqpkBhAWwB4CbAAUgXtBR8/UBR+CBhJqh9N0RMB5OH3Ol/xvHnL9Mw
 pVi36ybDj7wvgqdqGKrDMOzir0VMubpzKrNnybd1MUS3OCpGoESJT8vA7fvC8O4Ka3Z7
 Kar+PJ5ddI0z+GdSrkq0KxnwwzFe+hk3Jfv6wQjchdXLfOVLqNWtz6rytK+CRmcx3oC3
 uynF3cNVniM6Bf6Xpj7PDkSm+R80FvHBKtJs6S+ciB9lEnWI3Gs8LJcEznOXQec9EoPL
 q1OQQqdm2//jOmeHyMTBqvxfaLlZ3iXuhNne+BEmGxztbv760Ses6/fGL6/AVCqyrxre
 LgZQ==
X-Gm-Message-State: AOAM530HtvozNBVIO0dSydsFzGZb8KoGhaGzM8DmAo71O9E2rHjXKIwO
 gpRdF/0Rq7/HPKXe1eST3q6NA4lu+Zo=
X-Google-Smtp-Source: ABdhPJzC1AV8b2NC4pIEODxLLgIgLr/0Kx8Shaq9WssLYQ8JPbaXLtX5iMiXFAjy+mcm9+SNoW4n6Q==
X-Received: by 2002:aa7:9570:: with SMTP id x16mr21351591pfq.124.1595260304185; 
 Mon, 20 Jul 2020 08:51:44 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 z9sm15604146pgh.94.2020.07.20.08.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 08:51:42 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/qcom: Use domain rather than dev as tlb cookie
Date: Mon, 20 Jul 2020 08:52:17 -0700
Message-Id: <20200720155217.274994-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

From: Rob Clark <robdclark@chromium.org>

The device may be torn down, but the domain should still be valid.  Lets
use that as the tlb flush ops cookie.

Fixes a problem reported in [1]

[1] https://lkml.org/lkml/2020/7/20/104

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Note I don't have a good setup to test this atm, but I think it should
work.

 drivers/iommu/qcom_iommu.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c3e1fbd1988c..d176df569af8 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -65,6 +65,7 @@ struct qcom_iommu_domain {
 	struct mutex		 init_mutex; /* Protects iommu pointer */
 	struct iommu_domain	 domain;
 	struct qcom_iommu_dev	*iommu;
+	struct iommu_fwspec	*fwspec;
 };
 
 static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
@@ -84,9 +85,9 @@ static struct qcom_iommu_dev * to_iommu(struct device *dev)
 	return dev_iommu_priv_get(dev);
 }
 
-static struct qcom_iommu_ctx * to_ctx(struct device *dev, unsigned asid)
+static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid)
 {
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
+	struct qcom_iommu_dev *qcom_iommu = d->iommu;
 	if (!qcom_iommu)
 		return NULL;
 	return qcom_iommu->ctxs[asid - 1];
@@ -118,14 +119,12 @@ iommu_readq(struct qcom_iommu_ctx *ctx, unsigned reg)
 
 static void qcom_iommu_tlb_sync(void *cookie)
 {
-	struct iommu_fwspec *fwspec;
-	struct device *dev = cookie;
+	struct qcom_iommu_domain *qcom_domain = cookie;
+	struct iommu_fwspec *fwspec = qcom_domain->fwspec;
 	unsigned i;
 
-	fwspec = dev_iommu_fwspec_get(dev);
-
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(dev, fwspec->ids[i]);
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 		unsigned int val, ret;
 
 		iommu_writel(ctx, ARM_SMMU_CB_TLBSYNC, 0);
@@ -139,14 +138,12 @@ static void qcom_iommu_tlb_sync(void *cookie)
 
 static void qcom_iommu_tlb_inv_context(void *cookie)
 {
-	struct device *dev = cookie;
-	struct iommu_fwspec *fwspec;
+	struct qcom_iommu_domain *qcom_domain = cookie;
+	struct iommu_fwspec *fwspec = qcom_domain->fwspec;
 	unsigned i;
 
-	fwspec = dev_iommu_fwspec_get(dev);
-
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(dev, fwspec->ids[i]);
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 		iommu_writel(ctx, ARM_SMMU_CB_S1_TLBIASID, ctx->asid);
 	}
 
@@ -156,16 +153,14 @@ static void qcom_iommu_tlb_inv_context(void *cookie)
 static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 					    size_t granule, bool leaf, void *cookie)
 {
-	struct device *dev = cookie;
-	struct iommu_fwspec *fwspec;
+	struct qcom_iommu_domain *qcom_domain = cookie;
+	struct iommu_fwspec *fwspec = qcom_domain->fwspec;
 	unsigned i, reg;
 
 	reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
 
-	fwspec = dev_iommu_fwspec_get(dev);
-
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(dev, fwspec->ids[i]);
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 		size_t s = size;
 
 		iova = (iova >> 12) << 12;
@@ -256,7 +251,9 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	};
 
 	qcom_domain->iommu = qcom_iommu;
-	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, dev);
+	qcom_domain->fwspec = fwspec;
+
+	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, qcom_domain);
 	if (!pgtbl_ops) {
 		dev_err(qcom_iommu->dev, "failed to allocate pagetable ops\n");
 		ret = -ENOMEM;
@@ -269,7 +266,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	domain->geometry.force_aperture = true;
 
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(dev, fwspec->ids[i]);
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 
 		if (!ctx->secure_init) {
 			ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, ctx->asid);
@@ -419,7 +416,7 @@ static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *de
 
 	pm_runtime_get_sync(qcom_iommu->dev);
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(dev, fwspec->ids[i]);
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 
 		/* Disable the context bank: */
 		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
