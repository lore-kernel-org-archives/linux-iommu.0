Return-Path: <SRS0=0/ZC=DY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD288C43457
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 04:39:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6AA2072C
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 04:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNHXsdBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6AA2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 497B9884BF;
	Sat, 17 Oct 2020 04:39:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hFwGdV+begDz; Sat, 17 Oct 2020 04:39:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 74F1A884B7;
	Sat, 17 Oct 2020 04:39:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56A32C07FF;
	Sat, 17 Oct 2020 04:39:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20952C07FF
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 11A36204AC
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S6020jMFksEd for <iommu@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 04:39:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 9FAB52E210
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:38:28 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id i12so4500491ota.5
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 21:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5h+bbZ9M5fVwhu8jO4jzrcPr8WfAxCzDHuzDwBdlOrk=;
 b=rNHXsdBXLEHyHI2RbtLF4V+RV3DtpvRb55vdaj+0vbcqNM3iyJrndgp4TiL+sSOfr3
 e0AsYtelaC5wjEzt3FP+QWDpBfk/IvCsu1QMR0dv59joHCX27jyqDodIs2L+Ckt2iwQh
 qWLIpwZTrZLpYr1AHQ7yp3zDLplJzgbWJreLhb7rZoRCc1jCPqZj/5xnwNCKjSHIjrrV
 b4Ga8ECvvDh71PkhkS0unaGFnITr5MaQUms98vloSxXVwu85ZDSMFW3jB3gmdWR6W1q9
 c7mCK5R8pvCK6yklNFi3KTy6sBzqws49gVUJ1bj6ZlYLJue4pB5ca9tewh9hEtYo+ikp
 yMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5h+bbZ9M5fVwhu8jO4jzrcPr8WfAxCzDHuzDwBdlOrk=;
 b=RWmM1rx+ZlpPdf/LR1Wq1Pc3ukgSfVnrsjKUH0MCG/VTtMDf4z3jbseW89SUpxQt5T
 nil9gLb0uPhW9EpuX3K/xOQB3XX/1/aI5WEWuWEPtnKNsxHw4c77x6XxpM60Jmf5VZHZ
 +wU6aydSA7ZD9ChLjXVc8MLl822v4YkOrXFwTcdKTPPbGz13kRYbBiGbGPmvFia5T5L+
 dST7LZuNN3iY/yvogpF82FTFDG6vPFxzmU5g/7n40/evDucBCazJkqtJrrvxChMvk3sa
 zY5D/K5GVtPOJm8Q01KELQC7oxhmdD2O1sOQ5hSFJVeiyQDO4YMUIUZFbwO5HQvKGB0n
 xlrw==
X-Gm-Message-State: AOAM5329zkMwBhupUWX8yfhYeXkYlHvr5u79cWlx2pRGp9VUnaVSfO/H
 g9CdiX9uZPfGvb8cfgmDMv7BhQ==
X-Google-Smtp-Source: ABdhPJwpoWNiZybfRwwfJoWBdmsgXLsv0purd3mFs/NFe58vM0/ReOn+i8TlD+wvf2c+ue4teZCHtQ==
X-Received: by 2002:a9d:3ee5:: with SMTP id b92mr5112404otc.156.1602909507748; 
 Fri, 16 Oct 2020 21:38:27 -0700 (PDT)
Received: from localhost.localdomain
 (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id t65sm1640038oib.50.2020.10.16.21.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 21:38:27 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 Thierry Reding <treding@nvidia.com>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v4 1/3] iommu/arm-smmu: Allow implementation specific
 write_s2cr
Date: Fri, 16 Oct 2020 21:39:05 -0700
Message-Id: <20201017043907.2656013-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
References: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

The firmware found in some Qualcomm platforms intercepts writes to the
S2CR register in order to replace the BYPASS type with FAULT. Further
more it treats faults at this level as catastrophic and restarts the
device.

Add support for providing implementation specific versions of the S2CR
write function, to allow the Qualcomm driver to work around this
behavior.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- New patch

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 22 ++++++++++++++--------
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dad7fa86fbd4..ed3f0428c110 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -929,14 +929,20 @@ static void arm_smmu_write_smr(struct arm_smmu_device *smmu, int idx)
 static void arm_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
 {
 	struct arm_smmu_s2cr *s2cr = smmu->s2crs + idx;
-	u32 reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, s2cr->type) |
-		  FIELD_PREP(ARM_SMMU_S2CR_CBNDX, s2cr->cbndx) |
-		  FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, s2cr->privcfg);
-
-	if (smmu->features & ARM_SMMU_FEAT_EXIDS && smmu->smrs &&
-	    smmu->smrs[idx].valid)
-		reg |= ARM_SMMU_S2CR_EXIDVALID;
-	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_S2CR(idx), reg);
+	u32 reg;
+
+	if (smmu->impl && smmu->impl->write_s2cr) {
+		smmu->impl->write_s2cr(smmu, idx);
+	} else {
+		reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, s2cr->type) |
+		      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, s2cr->cbndx) |
+		      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, s2cr->privcfg);
+
+		if (smmu->features & ARM_SMMU_FEAT_EXIDS && smmu->smrs &&
+		    smmu->smrs[idx].valid)
+			reg |= ARM_SMMU_S2CR_EXIDVALID;
+		arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_S2CR(idx), reg);
+	}
 }
 
 static void arm_smmu_write_sme(struct arm_smmu_device *smmu, int idx)
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 1a746476927c..b71647eaa319 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -436,6 +436,7 @@ struct arm_smmu_impl {
 	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
 				  struct arm_smmu_device *smmu,
 				  struct device *dev, int start);
+	void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
 };
 
 #define INVALID_SMENDX			-1
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
