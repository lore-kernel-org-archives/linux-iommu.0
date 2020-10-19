Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECBDC43457
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 18:22:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0C322365
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 18:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFyiA3Ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0C322365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 60D3687671;
	Mon, 19 Oct 2020 18:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id saCT+c5HiYgk; Mon, 19 Oct 2020 18:22:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B30CC87478;
	Mon, 19 Oct 2020 18:22:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A076DC088B;
	Mon, 19 Oct 2020 18:22:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0AE6C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8D2382E0F2
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8sllyzj8DL90 for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 18:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 97DA120354
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:22:46 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id n15so532913otl.8
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8WNcSTvyJjqPsluOX/aQHxo6wZkO11EjVoorR/ZeenI=;
 b=bFyiA3AgOGUPXSmlD9ln5iZpm2IIkGqCKw/60r0m/Cx4zD4T3E0nqY3ega31Z0G4VI
 HDUVN+RNPyfDT0q1cl1jJmiVwmTvX9jinwXYJYbBO3AndeqrWxw9dVVpqQzIYbBazf7H
 sFyncVWqYaHCD3gaVlMmsB9+whr4jlJXjuZGiOiz6r6vM7Capkd+ZH8KYvwXBixNTfkz
 snT5x1MjjB3Tqh6MJxwHwZXcrbpI/im+BZUPMW/HSglDnM1XQeQHpOfD//3cc8O2jngy
 gy+dOM9EIubZPx/PXHr2KXGetlHK0fHHNO46kQjJzJg3dJ32eb+R5nzuubOOtwvCFcYe
 17Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8WNcSTvyJjqPsluOX/aQHxo6wZkO11EjVoorR/ZeenI=;
 b=trUb5yMjp+XhVKN5XhqEH6OI7Xi5l3n/eta9biJWsxN56FEriVXxmJMvfVLwiwr77h
 V8VGsS4r0fHU3wRQbF/xvE9wWka4pQZ108tr9ThesRLZEYu5u+gYYPMPJpdAOaOKDC7b
 hfExBoMkRfyTuUY03JmlF95wEkRwoq5MIiHaRLgpaKus7qRUky3NvBJ6XMaqz2wGoQbh
 x+Zpc1mWNvyMf6QvSDim+qLtSLL1bn7p98ToahOkYct1QdqMVigk/0o3m+DnPUf4JW/F
 dNkalUmMqp6HFdUEjZmhaPhE0TcXUHJKHnhh9PphMi9d0av4ylgCQ3d9a9u8n+MKmZMq
 MWSg==
X-Gm-Message-State: AOAM5339N9QtTgX+Nj08l+x+2LGvaGZlRpK4UJ2owlfQj5f0k3cPJAwg
 cb4CKvhWgHtt/EVbHhbaMHNRcA==
X-Google-Smtp-Source: ABdhPJzVeqVCQDNjLcs4loM+bM++jSYOB3qz5YDAugy+gXljNRXkI2CN8pviTsuIzrWxZhciQsuOTw==
X-Received: by 2002:a05:6830:2368:: with SMTP id
 r8mr915212oth.75.1603131765704; 
 Mon, 19 Oct 2020 11:22:45 -0700 (PDT)
Received: from localhost.localdomain
 (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id o8sm175296oog.47.2020.10.19.11.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 11:22:45 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 Thierry Reding <treding@nvidia.com>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v5 1/3] iommu/arm-smmu: Allow implementation specific
 write_s2cr
Date: Mon, 19 Oct 2020 11:23:21 -0700
Message-Id: <20201019182323.3162386-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019182323.3162386-1-bjorn.andersson@linaro.org>
References: <20201019182323.3162386-1-bjorn.andersson@linaro.org>
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

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Return early instead of indenting the rest of the function

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 ++++++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dad7fa86fbd4..bcbacf22331d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -929,9 +929,16 @@ static void arm_smmu_write_smr(struct arm_smmu_device *smmu, int idx)
 static void arm_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
 {
 	struct arm_smmu_s2cr *s2cr = smmu->s2crs + idx;
-	u32 reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, s2cr->type) |
-		  FIELD_PREP(ARM_SMMU_S2CR_CBNDX, s2cr->cbndx) |
-		  FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, s2cr->privcfg);
+	u32 reg;
+
+	if (smmu->impl && smmu->impl->write_s2cr) {
+		smmu->impl->write_s2cr(smmu, idx);
+		return;
+	}
+
+	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, s2cr->type) |
+	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, s2cr->cbndx) |
+	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, s2cr->privcfg);
 
 	if (smmu->features & ARM_SMMU_FEAT_EXIDS && smmu->smrs &&
 	    smmu->smrs[idx].valid)
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
