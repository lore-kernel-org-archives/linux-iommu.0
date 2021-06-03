Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516F3C47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B31613B1
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B31613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3651E84272;
	Thu,  3 Jun 2021 16:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HL0p7rUDA7Gm; Thu,  3 Jun 2021 16:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D08284242;
	Thu,  3 Jun 2021 16:45:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E818EC0025;
	Thu,  3 Jun 2021 16:45:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32484C000D
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A93760B63
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2vTjx1LTtMI3 for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 16:45:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CF8260B48
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:07 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id g18so5897677edq.8
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VlNxvqMh2IT7k8GWqSLT7kJqPAFU4Cya45iZg+g4Vc4=;
 b=Zu/ezZh0v9MeUs3qS/pHQ9pRZvTfL/Cqwv4R0B6/VuXkpBg1uWUXtbDZlI3hXXKBGX
 OwVzW52158BlV3RzQpM8MFlBoDtFQsNlTv0orvpZoI8kGGuVBlj6+P6Uv+vRCoA3Tzox
 7QW7pTrBQ6Mfsq0SKQ+dJ+yuTvKMhcIVFrnlUxrHjIbMQ8fFZU7qyB5yxUfJz7qIZfzd
 3bwdKSNUycLAafoaEnEnRyT2SyvG8CJdJSBM5IaS2gCrtFxJbymhtrbXWkuk2Di3/9Sp
 NrS+kmNwVw/gfVNS2uf2k49gsYQtyuh7Qyj18zOPtmjaSGtf1iNaJzZjIARoFqvgVdnI
 SgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VlNxvqMh2IT7k8GWqSLT7kJqPAFU4Cya45iZg+g4Vc4=;
 b=QiTg6ZkdHxg3eJjE05BQT7j7+XXIR0GFHHvHz0bEqpAXhdbIsRQYu8UcQcilFC7YHm
 f3IDDxJS9MFsIrTMceZPMgXyWXh1cNx+i+I8IF/uvm3aZGrgc0iZuWWkK2LAv9XNF/Q5
 JB4LqaYr0xhxO4d0pbB3RSo7Ry5GsGd39uqkrD+uxiHDipQnYuIwNKIjCRS7R9vLwkV4
 kEg2Hwqb398lRTEg9T2Q2ix3F1Om2LnHJqBZY7pybl0b/4vWUo5QVgTf1WOuK+0bNwjy
 Iw8pGYgyzTOz+oOdSmgJXppQca26l6oLR9INW074fVqQ+k4uNFjex5LGuo03Vedtrcow
 UhUA==
X-Gm-Message-State: AOAM530w31Yqg64uECwQzdu64PL6aZoeHWpKzR35L9TPKpGRCimIkzB7
 ew5vT4fWRxkyX4cx5wN0MrQ=
X-Google-Smtp-Source: ABdhPJxXrXwWK4QFgB5nUksaiKnWR+sh8XjHBPlh2ZAs/Xu5vH2IbScqCAAZFdw1SPRaf2s7vskTHQ==
X-Received: by 2002:a05:6402:b17:: with SMTP id
 bm23mr411771edb.236.1622738705681; 
 Thu, 03 Jun 2021 09:45:05 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id cz14sm1972696edb.84.2021.06.03.09.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 09:45:04 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 3/9] iommu/arm-smmu: Implement ->probe_finalize()
Date: Thu,  3 Jun 2021 18:46:26 +0200
Message-Id: <20210603164632.1000458-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603164632.1000458-1-thierry.reding@gmail.com>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

Implement a ->probe_finalize() callback that can be used by vendor
implementations to perform extra programming necessary after devices
have been attached to the SMMU.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- remove unnecessarily paranoid check

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d208ca..d20ce4d57df2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1450,6 +1450,18 @@ static void arm_smmu_release_device(struct device *dev)
 	iommu_fwspec_free(dev);
 }
 
+static void arm_smmu_probe_finalize(struct device *dev)
+{
+	struct arm_smmu_master_cfg *cfg;
+	struct arm_smmu_device *smmu;
+
+	cfg = dev_iommu_priv_get(dev);
+	smmu = cfg->smmu;
+
+	if (smmu->impl->probe_finalize)
+		smmu->impl->probe_finalize(smmu, dev);
+}
+
 static struct iommu_group *arm_smmu_device_group(struct device *dev)
 {
 	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
@@ -1569,6 +1581,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
+	.probe_finalize		= arm_smmu_probe_finalize,
 	.device_group		= arm_smmu_device_group,
 	.enable_nesting		= arm_smmu_enable_nesting,
 	.set_pgtable_quirks	= arm_smmu_set_pgtable_quirks,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index c31a59d35c64..147c95e7c59c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -439,6 +439,7 @@ struct arm_smmu_impl {
 				  struct device *dev, int start);
 	void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
 	void (*write_sctlr)(struct arm_smmu_device *smmu, int idx, u32 reg);
+	void (*probe_finalize)(struct arm_smmu_device *smmu, struct device *dev);
 };
 
 #define INVALID_SMENDX			-1
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
