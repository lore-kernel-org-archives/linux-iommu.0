Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6F7C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043432074D
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e29uwL+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043432074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CFC5886E54;
	Fri,  4 Sep 2020 15:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t8yzmYok9J17; Fri,  4 Sep 2020 15:55:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 34BCC86E44;
	Fri,  4 Sep 2020 15:55:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22D6FC0052;
	Fri,  4 Sep 2020 15:55:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2D06C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A284486EDB
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qcMhU7-RUy-f for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 15:55:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5150686EC4
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:25 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id w16so6719394qkj.7
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D1yn3SCzU30h04jFGZXM8u3sA7NFVzSbPZqsPP+oWTg=;
 b=e29uwL+EpSoES/+z1K7U/GWcIt61CkRtvS0de6u87FjQ4LIGnpTSAeb20AmUaBcCZ8
 qtWzRwMAkZO+FFYyxWZgTURdUzTgq6bhfj60DTRKFmf9wWPT10+0oU/yOGpjFBtn9Yab
 oAuX8ffQuctwoR52w0eq8k+Qv0iHkXxsn4ZzCB7xDfRKFO6+vWmJc2uHQb5HuinMDXj0
 4x11oTIlnbY00jrQyfglYGC0moCfhrkmlrCmXpOejfircLaXWuz1uHJerPmGG6PAYKWP
 Bep1fwiC1Nn43wd0BDxFgDLF5fMFxZJxsemZJJfrYPg9oMu1dtnkwBanuwslteLyGari
 kW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D1yn3SCzU30h04jFGZXM8u3sA7NFVzSbPZqsPP+oWTg=;
 b=W/7Hy794bS4wNDqiUXMk0Gr1PYNXpWTU7RAYc/rj3p2UenjlTgNot3/WAZj+PexIfP
 Gm9EPLGtOnR+u0BPmWdwfsFJETnIqfgdpgq1Jy4VUV9xzM0EAS57cLNRWoTAUFAs+6bu
 yWi2T+8042yvAtGa6lbW0MFOc+oJUbwHkdY3FU+VhKo06Y+J7HXXr5toqNu7F/L+HJ58
 Y8+sTehJ2yATJJJ42zy6IVkuBECPT5hQhWO6zYexGsk4Bhsow44/i1mM83knH2M1WvuQ
 +tSmn+OFhcvzeMwUmVzHAzr8F4RwWR8HurDVAPqhLh46DOZaQrEUz5hjl5oTlHLNjbkg
 f1UQ==
X-Gm-Message-State: AOAM532vdUxQXjc0+LS08XiMvPZOR3swSB/l109A3xyLdOPVest+D/e2
 vBUHHujNbskBNIPgD5pWrAOz9Q==
X-Google-Smtp-Source: ABdhPJyFYlEUGi9gN4pbIp7iXdUMIwRXrisWYKCYwXf+631ilHcizfoLcG9kkcGDBzyGaKjC1Bz+iw==
X-Received: by 2002:a37:6108:: with SMTP id v8mr7108268qkb.264.1599234924005; 
 Fri, 04 Sep 2020 08:55:24 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:55:23 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v3 8/8] iommu/arm-smmu-qcom: Setup identity domain for boot
 mappings
Date: Fri,  4 Sep 2020 15:55:13 +0000
Message-Id: <20200904155513.282067-9-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

Changes since v2:
- Combined from pieces spread between the Qualcomm impl and generic code in v2.
- Moved to use the newly introduced inherit_mapping op.

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 70a1eaa52e14..a54302190932 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -12,6 +12,7 @@
 struct qcom_smmu {
 	struct arm_smmu_device smmu;
 	bool bypass_broken;
+	struct iommu_domain *identity;
 };
 
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
@@ -228,6 +229,37 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int qcom_smmu_inherit_mappings(struct arm_smmu_device *smmu)
+{
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	int cbndx;
+	u32 smr;
+	int i;
+
+	qsmmu->identity = arm_smmu_alloc_identity_domain(smmu);
+	if (IS_ERR(qsmmu->identity))
+		return PTR_ERR(qsmmu->identity);
+
+	cbndx = to_smmu_domain(qsmmu->identity)->cfg.cbndx;
+
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
+
+		if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
+			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
+			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
+			smmu->smrs[i].valid = true;
+
+			smmu->s2crs[i].type = S2CR_TYPE_TRANS;
+			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+			smmu->s2crs[i].cbndx = cbndx;
+			smmu->s2crs[i].count++;
+		}
+	}
+
+	return 0;
+}
+
 static int qcom_smmu_def_domain_type(struct device *dev)
 {
 	const struct of_device_id *match =
@@ -270,6 +302,7 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
 	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
+	.inherit_mappings = qcom_smmu_inherit_mappings,
 };
 
 static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
