Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A76C433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:01:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECC120739
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sJK6emFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECC120739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 90D5587B5B;
	Thu,  9 Jul 2020 05:01:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UOVnu1E6Qaak; Thu,  9 Jul 2020 05:01:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DC64A87A39;
	Thu,  9 Jul 2020 05:01:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8F5DC0865;
	Thu,  9 Jul 2020 05:01:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF542C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CD01C87B40
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AGLdsknZpcIr for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 05:01:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1BB7A87A39
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:01:48 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id o13so458136pgf.0
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jul 2020 22:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fpwjVW7Z+irWop7fAETDGc/ua6yC0KP+NMCvyoQB9RI=;
 b=sJK6emFsSGA7psgbjAjtw3CRMaGl/+7BOiQ4h4025c9G/rVWUt0A6aJm2gjrW8i7Wy
 Yrym08TuQl9dY0zvkSbZ2r1/VkMl4GOvHkhCCCatBhYTHgqUtf3X/9W37MpGiTG7Ktqy
 BbCRqZIA9yjdjCFauiLj1eh/8Zc525Iq225fyNlSNCU3zACQgRcYzKxpgK5hJOf17Juy
 F/VEaHTOmE4WWQxzVIloHzKMBszVPgWKskOtDFsQo9NG/9EL3K8OFict6ASYJSd0JOfE
 Wuthn6aw7DFI318hoKqJBVPR0kKzmuVqmDzwrfqlYB1YhNi++hQtjUHpmC8jwlJllPsm
 X4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fpwjVW7Z+irWop7fAETDGc/ua6yC0KP+NMCvyoQB9RI=;
 b=cLAyy/98kCr/qMMqL5Qy8QGrDFBYyaVzR/0uWM230TTOewR5zn+TEMnZDlimE/hZPc
 qmv/F+6LdV2VFRDbr+F6WJBSI6WDIDtEFlvuDVntdmigEF/T1pnyqnaikhjSmoqWNq9M
 ptVxnX+vYc2TjWVQDrrJtU2rtPlsyw4X8LPCa/72fdQY8pmQYDQJw87+RHo4HBxBT/hZ
 rJg23Qh2Y6vYMhyn0Wv0Ds9rqVbXpxFhrPNQ2DsfhynWNXCNkXGIsnmj75iodZz0MtSz
 Lv5G5AsPct7edZSGwpaQrKoKY8dj+7hYOJ6Ch1Dzi46Ucl2ELW45GJNfBFay3sAIA5Hm
 5gXg==
X-Gm-Message-State: AOAM532UH5x0D9s9TaV7YfTZwS01Q4CPGFzFexuxH8eMoo7BEAu1bhso
 c8q3hUWCPXEr5LLO05V8/merPQ==
X-Google-Smtp-Source: ABdhPJzN6OwP8GTvSH4ENnFiwWNlVHQa4IJ6tTaqVk88twX1CJ1jwT8Jvpf9n9tYDT6X1OX3iMcKTA==
X-Received: by 2002:a63:e114:: with SMTP id z20mr45873953pgh.300.1594270907500; 
 Wed, 08 Jul 2020 22:01:47 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id h15sm999974pjc.14.2020.07.08.22.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 22:01:46 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 5/5] iommu/arm-smmu: Setup identity domain for boot mappings
Date: Wed,  8 Jul 2020 22:01:45 -0700
Message-Id: <20200709050145.3520931-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
References: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Marek <jonathan@marek.ca>, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

With many Qualcomm platforms not having functional S2CR BYPASS a
temporary IOMMU domain, without translation, needs to be allocated in
order to allow these memory transactions.

Unfortunately the boot loader uses the first few context banks, so
rather than overwriting a active bank the last context bank is used and
streams are diverted here during initialization.

This also performs the readback of SMR registers for the Qualcomm
platform, to trigger the mechanism.

This is based on prior work by Thierry Reding and Laurentiu Tudor.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm-smmu-qcom.c | 11 +++++
 drivers/iommu/arm-smmu.c      | 80 +++++++++++++++++++++++++++++++++--
 drivers/iommu/arm-smmu.h      |  3 ++
 3 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index 86b1917459a4..397df27c1d69 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -26,6 +26,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] = {
 static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
 	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
+	u32 smr;
 	u32 reg;
 	int i;
 
@@ -56,6 +57,16 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 		}
 	}
 
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
+
+		if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
+			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
+			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
+			smmu->smrs[i].valid = true;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e2d6c0aaf1ea..a7cb27c1a49e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -652,7 +652,8 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 }
 
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
-					struct arm_smmu_device *smmu)
+					struct arm_smmu_device *smmu,
+					bool boot_domain)
 {
 	int irq, start, ret = 0;
 	unsigned long ias, oas;
@@ -770,6 +771,15 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		ret = -EINVAL;
 		goto out_unlock;
 	}
+
+	/*
+	 * Use the last context bank for identity mappings during boot, to
+	 * avoid overwriting in-use bank configuration while we're setting up
+	 * the new mappings.
+	 */
+	if (boot_domain)
+		start = smmu->num_context_banks - 1;
+
 	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
 				      smmu->num_context_banks);
 	if (ret < 0)
@@ -1149,7 +1159,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_master_cfg *cfg;
 	struct arm_smmu_device *smmu;
+	bool free_identity_domain = false;
+	int idx;
 	int ret;
+	int i;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops) {
 		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
@@ -1174,7 +1187,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return ret;
 
 	/* Ensure that the domain is finalised */
-	ret = arm_smmu_init_domain_context(domain, smmu);
+	ret = arm_smmu_init_domain_context(domain, smmu, false);
 	if (ret < 0)
 		goto rpm_put;
 
@@ -1190,9 +1203,34 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto rpm_put;
 	}
 
+	/* Decrement use counter for any references to the identity domain */
+	mutex_lock(&smmu->stream_map_mutex);
+	if (smmu->identity) {
+		struct arm_smmu_domain *identity = to_smmu_domain(smmu->identity);
+
+		for_each_cfg_sme(cfg, fwspec, i, idx) {
+			dev_err(smmu->dev, "%s() %#x\n", __func__, smmu->smrs[idx].id);
+			if (smmu->s2crs[idx].cbndx == identity->cfg.cbndx) {
+				smmu->num_identity_masters--;
+				if (smmu->num_identity_masters == 0)
+					free_identity_domain = true;
+			}
+		}
+	}
+	mutex_unlock(&smmu->stream_map_mutex);
+
 	/* Looks ok, so add the device to the domain */
 	ret = arm_smmu_domain_add_master(smmu_domain, cfg, fwspec);
 
+	/*
+	 * The last stream map to reference the identity domain has been
+	 * overwritten, so it's now okay to free it.
+	 */
+	if (free_identity_domain) {
+		arm_smmu_domain_free(smmu->identity);
+		smmu->identity = NULL;
+	}
+
 	/*
 	 * Setup an autosuspend delay to avoid bouncing runpm state.
 	 * Otherwise, if a driver for a suspended consumer device
@@ -1922,17 +1960,51 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 int arm_smmu_setup_identity(struct arm_smmu_device *smmu)
 {
+	struct device *dev = smmu->dev;
+	int cbndx = 0xff;
+	int type = S2CR_TYPE_BYPASS;
+	int ret;
 	int i;
 
+	if (smmu->qcom_bypass_quirk) {
+		/* Create a IDENTITY domain to use for all inherited streams */
+		smmu->identity = arm_smmu_domain_alloc(IOMMU_DOMAIN_IDENTITY);
+		if (!smmu->identity) {
+			dev_err(dev, "failed to create identity domain\n");
+			return -ENOMEM;
+		}
+
+		smmu->identity->pgsize_bitmap = smmu->pgsize_bitmap;
+		smmu->identity->type = IOMMU_DOMAIN_IDENTITY;
+		smmu->identity->ops = &arm_smmu_ops;
+
+		ret = arm_smmu_init_domain_context(smmu->identity, smmu, true);
+		if (ret < 0) {
+			dev_err(dev, "failed to initialize identity domain: %d\n", ret);
+			return ret;
+		}
+
+		type = S2CR_TYPE_TRANS;
+		cbndx = to_smmu_domain(smmu->identity)->cfg.cbndx;
+	}
+
 	for (i = 0; i < smmu->num_mapping_groups; i++) {
 		if (smmu->smrs[i].valid) {
-			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
+			smmu->s2crs[i].type = type;
 			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
-			smmu->s2crs[i].cbndx = 0xff;
+			smmu->s2crs[i].cbndx = cbndx;
 			smmu->s2crs[i].count++;
+
+			smmu->num_identity_masters++;
 		}
 	}
 
+	/* If no mappings where found, free the identiy domain again */
+	if (smmu->identity && !smmu->num_identity_masters) {
+		arm_smmu_domain_free(smmu->identity);
+		smmu->identity = NULL;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index bcd160d01c53..37257ede86fa 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -321,6 +321,9 @@ struct arm_smmu_device {
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
 
+	struct iommu_domain		*identity;
+	unsigned int			num_identity_masters;
+
 	bool				qcom_bypass_quirk;
 };
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
