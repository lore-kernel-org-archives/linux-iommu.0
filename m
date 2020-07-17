Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE7FC433EC
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90927207CB
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiQXSDCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90927207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5678D203E4;
	Fri, 17 Jul 2020 00:16:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDcdRjuvfSRC; Fri, 17 Jul 2020 00:16:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 05EDC203FE;
	Fri, 17 Jul 2020 00:16:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E73B5C07FF;
	Fri, 17 Jul 2020 00:16:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31A20C0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 16D57203FF
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TEopMgl79NE7 for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 00:16:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 1EDF5203EF
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:30 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id s189so5762812pgc.13
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 17:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jlkntRV846aUEo1Gl28BULv9E1NJaLJ91w5u0IdGAqY=;
 b=OiQXSDCWqV8zDFUYVBAxlH0S9CUnxu5iNny+Dixx/cJuAc+BjwJxXZk2NeYdMn/4JM
 po5lfGXXIcu237rEjN9QS6alFZsksWl0OsLnUjjmyoaa2VSLFxdsx9c0wclqDlpeCrG+
 HRYy2HNZYiYfhM2z1JteVTx0DOTm7aLn3aPGOp6Yk9NTjXrXsTnLwm+GzAFBMlrvxdCO
 5WvH2VytlFQke6xH+sVsHW2uCY9veYAsGGSk8znuUpUCJso0sxiUmXUosE/WnKW05fVp
 9FfENWzbuDXCv41HbdfGyWbqsblDV4Cjq1n/ZcglHrIDq1Ec1+Wt0ywHHY9bNqrHZcHq
 rA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jlkntRV846aUEo1Gl28BULv9E1NJaLJ91w5u0IdGAqY=;
 b=Mkk8QjcSm7+nsR0UB8/NZM8qhu7KCNZGz22zhjxFzQTQ2StNGVlqJu5VFRfNPGoJ6g
 BsX2bX9z4dSJP1l/2hB43Bs2DR0F6grHLCvU3n0QaJClvDOjgbY97b5recDMeP6RJ/LJ
 yVyaRTAidj4cxdJDkw82wNr/X0oCsxKJ3IY1kQGv/GxtsuNhEVIDPzV5TTNQzxX+I8iy
 PWZL/cSnYl47XdeJH39GlEqtFWq9z99yjouXoK3emCFkL8tOWlGn7hsJEUSusFOGYY2d
 MQuihjalLfzoQ51TVFg7jz82T6M4hrHh24WwuJ8h91zlDHqGoOYLskZkY+9h3TskP/J/
 ViFA==
X-Gm-Message-State: AOAM530QgIWtxxKcGPuM8WG4c2sk6Opso4E+3BtbjqtmNmFJ+Ukz+ETv
 VcdfPMYml/ZVX7B2k/kHoGrRBA==
X-Google-Smtp-Source: ABdhPJyOw+rZ5tyQFkUplkrS1otZKw4EmrIzCvAXE7cq7d57IJm0Q+MOF5/GsoqJxLnC2KC8CmI1AQ==
X-Received: by 2002:a63:d40d:: with SMTP id a13mr6437251pgh.225.1594944989377; 
 Thu, 16 Jul 2020 17:16:29 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id r7sm6211950pgu.51.2020.07.16.17.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 17:16:28 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 5/5] iommu/arm-smmu: Setup identity domain for boot mappings
Date: Thu, 16 Jul 2020 17:16:19 -0700
Message-Id: <20200717001619.325317-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717001619.325317-1-bjorn.andersson@linaro.org>
References: <20200717001619.325317-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Marek <jonathan@marek.ca>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>,
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

Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Rebased to avoid conflict
- Picked up tested-by

 drivers/iommu/arm-smmu-qcom.c | 11 +++++
 drivers/iommu/arm-smmu.c      | 79 +++++++++++++++++++++++++++++++++--
 drivers/iommu/arm-smmu.h      |  3 ++
 3 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index 10eb024981d1..147af11049eb 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -26,6 +26,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
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
index 08a650fe02e3..69bd8ee03516 100644
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
 
@@ -1190,9 +1203,33 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto rpm_put;
 	}
 
+	/* Decrement use counter for any references to the identity domain */
+	mutex_lock(&smmu->stream_map_mutex);
+	if (smmu->identity) {
+		struct arm_smmu_domain *identity = to_smmu_domain(smmu->identity);
+
+		for_each_cfg_sme(cfg, fwspec, i, idx) {
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
@@ -1922,17 +1959,51 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 static int arm_smmu_setup_identity(struct arm_smmu_device *smmu)
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
