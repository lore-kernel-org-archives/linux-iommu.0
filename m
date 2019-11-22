Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72DEC43141
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 23:31:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9917120706
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 23:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PvXSHKdF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="eep16fPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9917120706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6361320420;
	Fri, 22 Nov 2019 23:31:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mPOWgmicRMlj; Fri, 22 Nov 2019 23:31:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 44CBC20448;
	Fri, 22 Nov 2019 23:31:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26185C1DD8;
	Fri, 22 Nov 2019 23:31:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14089C1DD8
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 23:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DF587203FE
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 23:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wNRCgEUu2KRq for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 23:31:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-186.smtp-out.us-west-2.amazonses.com
 (a27-186.smtp-out.us-west-2.amazonses.com [54.240.27.186])
 by silver.osuosl.org (Postfix) with ESMTPS id 97140203DE
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 23:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574465514;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
 bh=qW229tc+fr2jBrET57nVwquLisa1FORvNLNXtsEvsi0=;
 b=PvXSHKdFoxJwat49ErH3Mt0nKrNXUXHq+uFW8SfoiCE2GxBhwhwB4Bwcej7tbNy+
 H0I2D3fe0Zxk/s75t0Nq1WTKxo8ictJ321EnADNcP1weSVNtFl75gDNL0WRc8bXFh94
 a4ngBtWw4dSH+23aVZ1wvMJWtyWIqYegHfr8FxVA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574465514;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
 bh=qW229tc+fr2jBrET57nVwquLisa1FORvNLNXtsEvsi0=;
 b=eep16fPu8Cc41dCpRwbXcOO+R2g7lqNevvjvrdvuI9tmYJntYMa+/Ljif8gu9zaE
 dkTJZuuuyPfxuj1GUF1E+PQTPxpZdRDGf2Y3wwSztrenaiFgJ2gD7XpnQQHgUmb+jrP
 /HUtas+DNdA37YEyQolOEEQcc5WVzCuHpeGnIXtQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32E32C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 3/8] iommu/arm-smmu: Pass io_pgtable_cfg to impl specific
 init_context
Date: Fri, 22 Nov 2019 23:31:53 +0000
Message-ID: <0101016e95752958-9b3f2336-263a-4f91-b1d9-b608b9babdc5-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
References: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
X-SES-Outgoing: 2019.11.22-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Cc: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Pass the propposed io_pgtable_cfg to the implementation specific
init_context() function to give the implementation an opportunity to to
modify it before it gets passed to io-pgtable.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu-impl.c |  3 ++-
 drivers/iommu/arm-smmu.c      | 11 ++++++-----
 drivers/iommu/arm-smmu.h      |  3 ++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index b2fe72a..33ed682 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -68,7 +68,8 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-static int cavium_init_context(struct arm_smmu_domain *smmu_domain)
+static int cavium_init_context(struct arm_smmu_domain *smmu_domain,
+		struct io_pgtable_cfg *pgtbl_cfg)
 {
 	struct cavium_smmu *cs = container_of(smmu_domain->smmu,
 					      struct cavium_smmu, smmu);
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c106406..5c7c32b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -775,11 +775,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		cfg->asid = cfg->cbndx;
 
 	smmu_domain->smmu = smmu;
-	if (smmu->impl && smmu->impl->init_context) {
-		ret = smmu->impl->init_context(smmu_domain);
-		if (ret)
-			goto out_unlock;
-	}
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
@@ -790,6 +785,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		.iommu_dev	= smmu->dev,
 	};
 
+	if (smmu->impl && smmu->impl->init_context) {
+		ret = smmu->impl->init_context(smmu_domain, &pgtbl_cfg);
+		if (ret)
+			goto out_unlock;
+	}
+
 	if (smmu_domain->non_strict)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index afab9de..0eb498f 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -357,7 +357,8 @@ struct arm_smmu_impl {
 			    u64 val);
 	int (*cfg_probe)(struct arm_smmu_device *smmu);
 	int (*reset)(struct arm_smmu_device *smmu);
-	int (*init_context)(struct arm_smmu_domain *smmu_domain);
+	int (*init_context)(struct arm_smmu_domain *smmu_domain,
+			struct io_pgtable_cfg *pgtbl_cfg);
 	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
 			 int status);
 };
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
