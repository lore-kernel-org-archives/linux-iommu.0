Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954A0C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:01:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED7820796
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fH/8s/Vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED7820796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4894986E3B;
	Fri,  4 Sep 2020 16:01:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pvb7lrp2vtms; Fri,  4 Sep 2020 16:01:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 219FB86E42;
	Fri,  4 Sep 2020 16:01:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14331C0052;
	Fri,  4 Sep 2020 16:01:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72CDCC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 264D387579
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yP3k3xbgAX-8 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 16:01:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CBA10872D8
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:01:02 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id k15so4817524pfc.12
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I9v8itQxrG/5qOmlIkuGPstFjTonnbsCxHmLWx5pBPk=;
 b=fH/8s/VsjUJd9NSfQnY9KSqjr01isFkiTOEHv966Pm+qJr0SntP+xw7DkVPurY+FVA
 TGhOoJlnm9Ues2qE+3G7rkDWz7QaZWbR3ioFcET9S2eEFANNMRSLMlEwWT+67pEu3h/J
 gtFEX/W6HDjTk/bNacLk+NKv/yYQfcg4gHrZ8cvLLQd7heB4VMYFsmq5HuYBHzojcJzM
 jvbXrNuQYord9V5/QeTX2bg15dsqvN7uIXH2fypYBVmveFk3IlBSq5h0rr0SsYd92wbL
 r3AXp+pONiHH4M+LMJeGIBSd2WYLFWvUSPInCsoZgV6fJqA9+OEe5uEsFaU2oP25C6v1
 PfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I9v8itQxrG/5qOmlIkuGPstFjTonnbsCxHmLWx5pBPk=;
 b=X9FDeHcdDSNUBE+AV83o9xGtALs3fEcl4jY4AjJA/ry54Diac2uRuoHvmzgHDcRprd
 WSnvFw3htlmoIwIytKUC3eyTHenREzrRpV8jtwUyUACHHqfb63SVsnRtcI369dMNT9iY
 H6VIKGfaKBqbPMIg8vCzx35fKTjAbqTL20grGtJowzQuuDPCaLgQoVkzovmTQqwC2oQV
 UsNeeSG+wd8rH4svFgYOsgegmbx2URHMK30lxDf6Aiy/cHLdLykqFrFKNjsvgiQnVNEa
 BNaas+XK7TVeMOmEymsKqzOoxUNh3a10goeGqEeT73HT1MpQhY1XDqA5/IHFaEsisLwe
 8dyA==
X-Gm-Message-State: AOAM532WVJR1n2c7Re48iOfrugXMm5NCVTceY1xnD7coL96m+XznW6WN
 HqJGzcN7GTNztwa8l2YczMIlVpkv3wU5Wg==
X-Google-Smtp-Source: ABdhPJxQteuxg6Yjoj7fVR6WxdpZueTzVWR2/XBC+gGtJOSWv7p5AUuXED5I8jk4ofSy9cwnePazOA==
X-Received: by 2002:a0c:c988:: with SMTP id b8mr7690156qvk.192.1599234922927; 
 Fri, 04 Sep 2020 08:55:22 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:55:22 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v3 7/8] iommu/arm-smmu: Provide helper for allocating identity
 domain
Date: Fri,  4 Sep 2020 15:55:12 +0000
Message-Id: <20200904155513.282067-8-bjorn.andersson@linaro.org>
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

Some platform implementations needs to be able to allocate a domain for
emulating identity mappings using a context bank without translation.
Provide a helper function to allocate such a domain.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Extracted from previous arm_smmu_setup_identity() implementation

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 25 +++++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4c4d302cd747..3c06146dfdb9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1924,6 +1924,31 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+struct iommu_domain *arm_smmu_alloc_identity_domain(struct arm_smmu_device *smmu)
+{
+	struct iommu_domain *identity;
+	int ret;
+
+	/* Create a IDENTITY domain to use for all inherited streams */
+	identity = arm_smmu_domain_alloc(IOMMU_DOMAIN_IDENTITY);
+	if (!identity) {
+		dev_err(smmu->dev, "failed to create identity domain\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	identity->pgsize_bitmap = smmu->pgsize_bitmap;
+	identity->type = IOMMU_DOMAIN_IDENTITY;
+	identity->ops = &arm_smmu_ops;
+
+	ret = arm_smmu_init_domain_context(identity, smmu, NULL);
+	if (ret < 0) {
+		dev_err(smmu->dev, "failed to initialize identity domain: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	return identity;
+}
+
 struct arm_smmu_match_data {
 	enum arm_smmu_arch_version version;
 	enum arm_smmu_implementation model;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index f58164976e74..fbdf3d7ca70d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -537,4 +537,6 @@ struct arm_smmu_device *qcom_adreno_smmu_impl_init(struct arm_smmu_device *smmu)
 void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
 int arm_mmu500_reset(struct arm_smmu_device *smmu);
 
+struct iommu_domain *arm_smmu_alloc_identity_domain(struct arm_smmu_device *smmu);
+
 #endif /* _ARM_SMMU_H */
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
