Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11E7C34049
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFFA2465A
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFFA2465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 668CE83F08;
	Tue, 18 Feb 2020 18:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gKtCO49urRnj; Tue, 18 Feb 2020 18:12:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B7A9C80ACD;
	Tue, 18 Feb 2020 18:12:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 989DFC08A0;
	Tue, 18 Feb 2020 18:12:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32A1FC013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2159E85BE4
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zFZUWxsLijea for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 18:12:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 37C5B85BD8
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:12:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FE9D101E;
 Tue, 18 Feb 2020 10:12:49 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82C723F73B;
 Tue, 18 Feb 2020 10:12:48 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	robdclark@gmail.com
Subject: [PATCH] iommu/qcom: Fix bogus detach logic
Date: Tue, 18 Feb 2020 18:12:41 +0000
Message-Id: <be92829c6e5467634b109add002351e6cf9e18d2.1582049382.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
MIME-Version: 1.0
Cc: stephan@gerhold.net, linux-arm-msm@vger.kernel.org,
 Naresh Kamboju <naresh.kamboju@linaro.org>, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, Brian Masney <masneyb@onstation.org>
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

Currently, the implementation of qcom_iommu_domain_free() is guaranteed
to do one of two things: WARN() and leak everything, or dereference NULL
and crash. That alone is terrible, but in fact the whole idea of trying
to track the liveness of a domain via the qcom_domain->iommu pointer as
a sanity check is full of fundamentally flawed assumptions. Make things
robust and actually functional by not trying to be quite so clever.

Reported-by: Brian Masney <masneyb@onstation.org>
Tested-by: Brian Masney <masneyb@onstation.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/qcom_iommu.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 39759db4f003..4328da0b0a9f 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -344,21 +344,19 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 
-	if (WARN_ON(qcom_domain->iommu))    /* forgot to detach? */
-		return;
-
 	iommu_put_dma_cookie(domain);
 
-	/* NOTE: unmap can be called after client device is powered off,
-	 * for example, with GPUs or anything involving dma-buf.  So we
-	 * cannot rely on the device_link.  Make sure the IOMMU is on to
-	 * avoid unclocked accesses in the TLB inv path:
-	 */
-	pm_runtime_get_sync(qcom_domain->iommu->dev);
-
-	free_io_pgtable_ops(qcom_domain->pgtbl_ops);
-
-	pm_runtime_put_sync(qcom_domain->iommu->dev);
+	if (qcom_domain->iommu) {
+		/*
+		 * NOTE: unmap can be called after client device is powered
+		 * off, for example, with GPUs or anything involving dma-buf.
+		 * So we cannot rely on the device_link.  Make sure the IOMMU
+		 * is on to avoid unclocked accesses in the TLB inv path:
+		 */
+		pm_runtime_get_sync(qcom_domain->iommu->dev);
+		free_io_pgtable_ops(qcom_domain->pgtbl_ops);
+		pm_runtime_put_sync(qcom_domain->iommu->dev);
+	}
 
 	kfree(qcom_domain);
 }
@@ -404,7 +402,7 @@ static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *de
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	unsigned i;
 
-	if (!qcom_domain->iommu)
+	if (WARN_ON(!qcom_domain->iommu))
 		return;
 
 	pm_runtime_get_sync(qcom_iommu->dev);
@@ -417,8 +415,6 @@ static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *de
 		ctx->domain = NULL;
 	}
 	pm_runtime_put_sync(qcom_iommu->dev);
-
-	qcom_domain->iommu = NULL;
 }
 
 static int qcom_iommu_map(struct iommu_domain *domain, unsigned long iova,
-- 
2.23.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
