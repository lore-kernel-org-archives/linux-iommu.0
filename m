Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47636C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:01:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D54920795
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f327XpYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D54920795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E0C8386EDF;
	Fri,  4 Sep 2020 16:01:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nAV0zj30YgU6; Fri,  4 Sep 2020 16:01:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6006086ED1;
	Fri,  4 Sep 2020 16:01:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A671C0052;
	Fri,  4 Sep 2020 16:01:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CF3CC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 16EE086E1D
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JSXw3ZXGoOvX for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 16:01:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1AA9086DF0
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:01:21 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id f142so6693452qke.13
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gCgPYkIuen689JCGS9C+yWcxF9Wf5xvuT4fGLsIR6s4=;
 b=f327XpYNWc6l2rv9RF9YVwix3cQ2zUGItQvb76pIc9b0ZZkAec70KgXCmFe1JTlQPX
 H7KHWTKF4ebNKtJJmF+TbCugfIYbU2jdqDcwNT+/YNzahtv31duzVXAfMO+ObDXFwd4P
 NJ5GqDhX/siqbOaqP7g3+ksdGLNPEWZWR0vlJkfD9LmXJcMQbYIk12lmuxQGqDhU7/Ru
 LxHMs6d/rjNQ0a8rObQ1GjEBRFMA5GiRpv4/MQnxJWg66Oe7gn0saucFFtw97AyPcssA
 UqaSTYkqvvnVF+4ciJRWw3mDV3o3GWfTbonqPO/r1cRQVtr3SAYaixzOl3psh9evNe5u
 e5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gCgPYkIuen689JCGS9C+yWcxF9Wf5xvuT4fGLsIR6s4=;
 b=Hg2gQOnOmgsXKh73+gp/GsmtJqJY9/9Jn1TVlaIx3oYfoFlTRUnuS3zN3uNn9IeH/W
 ecNYznFESm5r2odWbzLerxtyySzHjRn5xWxeFoqRhthLDJBchC7dqy5QMLchA9aF0zAR
 /x0NiTIFY+nItnuMlPS/QjxgJbINy5dsLMuXimAOUuRyIXUDRK/2wRh+54QtgcOo3G3a
 Fm5gXx0QaHLPt5+qGzpIV12LFYypnUo/rzfi8702IYHXDA8nU/zDokUnzwlBdkPgguqZ
 Um2iCqmiK+wQ6lFUmy7Ect0yVBhleC/Dn9FsbwxIrpl2dlbw1FsgG3bJu5B1upkQivzL
 1URA==
X-Gm-Message-State: AOAM533CNrwjzYvGqYnwIWL6qx9ChwGyshI4E11ALxww2KOMZNg/aZdT
 n/IDZfzMVJpkyWESxp/1bI9C33oMF8wMOg==
X-Google-Smtp-Source: ABdhPJwQAqxRfEZO2Wpzgm/mVc29sreI4hBEc/PRL/deVoZlJprAw461csvwoALQd2PBInXlQ29TIQ==
X-Received: by 2002:ac8:3933:: with SMTP id s48mr9112374qtb.294.1599234916004; 
 Fri, 04 Sep 2020 08:55:16 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:55:15 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v3 1/8] iommu/arm-smmu: Refactor context bank allocation
Date: Fri,  4 Sep 2020 15:55:06 +0000
Message-Id: <20200904155513.282067-2-bjorn.andersson@linaro.org>
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

Extract the conditional invocation of the platform defined
alloc_context_bank() to a separate function to keep
arm_smmu_init_domain_context() cleaner.

Instead pass a reference to the arm_smmu_device as parameter to the
call. Also remove the count parameter, as this can be read from the
newly passed object.

This allows us to not assign smmu_domain->smmu before attempting to
allocate the context bank and as such we don't need to roll back this
assignment on failure.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Note that this series applies ontop of:
https://lore.kernel.org/linux-arm-msm/20200901164707.2645413-1-robdclark@gmail.com/

This could either go on its own, or be squashed with "[PATCH v16 14/20]
iommu/arm-smmu: Prepare for the adreno-smmu implementation" from Rob's series.

Changes since v2:
- New patch

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  6 ++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 23 ++++++++++++----------
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  3 ++-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 2aa6249050ff..0663d7d26908 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -91,9 +91,10 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
 }
 
 static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
-		struct device *dev, int start, int count)
+					       struct arm_smmu_device *smmu,
+					       struct device *dev, int start)
 {
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	int count;
 
 	/*
 	 * Assign context bank 0 to the GPU device so the GPU hardware can
@@ -104,6 +105,7 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
 		count = 1;
 	} else {
 		start = 1;
+		count = smmu->num_context_banks;
 	}
 
 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index bbec5793faf8..e19d7bdc7674 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -623,6 +623,16 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
 }
 
+static int arm_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_device *smmu,
+				       struct device *dev, unsigned int start)
+{
+	if (smmu->impl && smmu->impl->alloc_context_bank)
+		return smmu->impl->alloc_context_bank(smmu_domain, smmu, dev, start);
+
+	return __arm_smmu_alloc_bitmap(smmu->context_map, start, smmu->num_context_banks);
+}
+
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 					struct arm_smmu_device *smmu,
 					struct device *dev)
@@ -741,20 +751,13 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		goto out_unlock;
 	}
 
-	smmu_domain->smmu = smmu;
-
-	if (smmu->impl && smmu->impl->alloc_context_bank)
-		ret = smmu->impl->alloc_context_bank(smmu_domain, dev,
-				start, smmu->num_context_banks);
-	else
-		ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
-				      smmu->num_context_banks);
-
+	ret = arm_smmu_alloc_context_bank(smmu_domain, smmu, dev, start);
 	if (ret < 0) {
-		smmu_domain->smmu = NULL;
 		goto out_unlock;
 	}
 
+	smmu_domain->smmu = smmu;
+
 	cfg->cbndx = ret;
 	if (smmu->version < ARM_SMMU_V2) {
 		cfg->irptndx = atomic_inc_return(&smmu->irptndx);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 2df3a70a8a41..ddf2ca4c923d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -437,7 +437,8 @@ struct arm_smmu_impl {
 	irqreturn_t (*global_fault)(int irq, void *dev);
 	irqreturn_t (*context_fault)(int irq, void *dev);
 	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
-			struct device *dev, int start, int max);
+				  struct arm_smmu_device *smmu,
+				  struct device *dev, int start);
 };
 
 #define INVALID_SMENDX			-1
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
