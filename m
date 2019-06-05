Return-Path: <SRS0=DEPd=UE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC7AC28CC5
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 21:09:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC562075B
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 21:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsLf+GJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC562075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3BE93D85;
	Wed,  5 Jun 2019 21:09:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 97990D7A
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 21:09:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0C31219B
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 21:09:01 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id x7so9163486plr.12
	for <iommu@lists.linux-foundation.org>;
	Wed, 05 Jun 2019 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=doGqQfOnbpbz6KWyxr0y6OarZe4NFnZU43MXukaW24s=;
	b=zsLf+GJaoDAXKa5EdGWe2FOH0F+xp5lNHW7YtXxQp3F6tZIgoxWTg4ICtQmSyMUzFS
	b0EGjQtzqHXwjdTw3FRh9z+9C6OYT11qsbfHgjRZPZakvHnZPBN05Qfz7+TfLQvcmfZy
	k8JA698NZ2o0hx24JO+WjKTiegX0rZpAXCRvblhsB/qkNq0Pyo3Fld98laxJ++tnYiDP
	l5VuN6NUy0XCB/5KqMOTCc9277V09UY4OBy3OnP1pl5FX2/+XCRwYGMCFJZjI4mweOty
	1iAo0dUwojRJmbTkcnex3nPunwVVOrWhwSE9evn6ehy9bWiqnakAnymht15U2Vk1qBfJ
	tx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=doGqQfOnbpbz6KWyxr0y6OarZe4NFnZU43MXukaW24s=;
	b=dJ2WhKzjwyXa0byJUIksjeEnsDG2ErKDqO96mc26zwqKsLmUlW7+fM4LfObebJEt7S
	9+7et/J4OhmcDR6+bVg1yqS9Bhlvx9aNhJK8jlml+C2esm7+/qteua/1noxLxheTDED2
	WK70og2+mPLfSvv3Ko8UhxQkym8k6CAnbR7662Bur8tVLtpZ/JkQ5CFGxxW2ve6hspwS
	5d4kYf6jgf3HB2gZGrLOJBe2Jwhx/+ERgR222c1Lo0TqbF9OhSdQ4jXh8uTZtaEGyww4
	2D92Msyc0My/0BgXGvoRX4um35H0pezbPr4gwgZEL8m7TV1JYrDvQd5u30xmbDHe610d
	lRew==
X-Gm-Message-State: APjAAAWodtAgVWKECBeMuXwlO4jZI5ctsUxqpul0zOftcV066zG0+42o
	cCyQg85J6PiiQriLQ53PwbkgKQ==
X-Google-Smtp-Source: APXvYqwoS4/fIM8nKfSXqVALkUrziDsBx5YwkF6lBl7eSp+Ql0R6Eq9xI2taS6Dvk0vFthsrEHo8CA==
X-Received: by 2002:a17:902:2aab:: with SMTP id
	j40mr7623927plb.76.1559768940538; 
	Wed, 05 Jun 2019 14:09:00 -0700 (PDT)
Received: from localhost.localdomain
	(104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
	by smtp.gmail.com with ESMTPSA id
	z68sm5093374pfb.37.2019.06.05.14.08.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 14:09:00 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RFC 1/2] iommu: arm-smmu: Handoff SMR registers and context banks
Date: Wed,  5 Jun 2019 14:08:55 -0700
Message-Id: <20190605210856.20677-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190605210856.20677-1-bjorn.andersson@linaro.org>
References: <20190605210856.20677-1-bjorn.andersson@linaro.org>
Cc: Patrick Daly <pdaly@codeaurora.org>, Jeffrey Hugo <jhugo@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Boot splash screen or EFI framebuffer requires the display hardware to
operate while the Linux iommu driver probes. Therefore, we cannot simply
wipe out the SMR register settings programmed by the bootloader.

Detect which SMR registers are in use during probe, and which context
banks they are associated with. Reserve these context banks for the
first Linux device whose stream-id matches the SMR register.

Any existing page-tables will be discarded.

Heavily based on downstream implementation by Patrick Daly
<pdaly@codeaurora.org>.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm-smmu-regs.h |  2 +
 drivers/iommu/arm-smmu.c      | 80 ++++++++++++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
index e9132a926761..8c1fd84032a2 100644
--- a/drivers/iommu/arm-smmu-regs.h
+++ b/drivers/iommu/arm-smmu-regs.h
@@ -105,7 +105,9 @@
 #define ARM_SMMU_GR0_SMR(n)		(0x800 + ((n) << 2))
 #define SMR_VALID			(1 << 31)
 #define SMR_MASK_SHIFT			16
+#define SMR_MASK_MASK			0x7fff
 #define SMR_ID_SHIFT			0
+#define SMR_ID_MASK			0xffff
 
 #define ARM_SMMU_GR0_S2CR(n)		(0xc00 + ((n) << 2))
 #define S2CR_CBNDX_SHIFT		0
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5e54cc0a28b3..c8629a656b42 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -135,6 +135,7 @@ struct arm_smmu_s2cr {
 	enum arm_smmu_s2cr_type		type;
 	enum arm_smmu_s2cr_privcfg	privcfg;
 	u8				cbndx;
+	bool				handoff;
 };
 
 #define s2cr_init_val (struct arm_smmu_s2cr){				\
@@ -399,9 +400,22 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 	return err;
 }
 
-static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
+static int __arm_smmu_alloc_cb(struct arm_smmu_device *smmu, int start,
+			       struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	unsigned long *map = smmu->context_map;
+	int end = smmu->num_context_banks;
+	int cbndx;
 	int idx;
+	int i;
+
+	for_each_cfg_sme(fwspec, i, idx) {
+		if (smmu->s2crs[idx].handoff) {
+			cbndx = smmu->s2crs[idx].cbndx;
+			goto found_handoff;
+		}
+	}
 
 	do {
 		idx = find_next_zero_bit(map, end, start);
@@ -410,6 +424,17 @@ static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
 	} while (test_and_set_bit(idx, map));
 
 	return idx;
+
+found_handoff:
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		if (smmu->s2crs[i].cbndx == cbndx) {
+			smmu->s2crs[i].cbndx = 0;
+			smmu->s2crs[i].handoff = false;
+			smmu->s2crs[i].count--;
+		}
+	}
+
+	return cbndx;
 }
 
 static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
@@ -759,7 +784,8 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 }
 
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
-					struct arm_smmu_device *smmu)
+					struct arm_smmu_device *smmu,
+					struct device *dev)
 {
 	int irq, start, ret = 0;
 	unsigned long ias, oas;
@@ -873,8 +899,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
-				      smmu->num_context_banks);
+	ret = __arm_smmu_alloc_cb(smmu, start, dev);
 	if (ret < 0)
 		goto out_unlock;
 
@@ -1264,7 +1289,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return ret;
 
 	/* Ensure that the domain is finalised */
-	ret = arm_smmu_init_domain_context(domain, smmu);
+	ret = arm_smmu_init_domain_context(domain, smmu, dev);
 	if (ret < 0)
 		goto rpm_put;
 
@@ -1798,6 +1823,49 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 }
 
+static void arm_smmu_read_smr_state(struct arm_smmu_device *smmu)
+{
+	u32 privcfg;
+	u32 cbndx;
+	u32 mask;
+	u32 type;
+	u32 s2cr;
+	u32 smr;
+	u32 id;
+	int i;
+
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		smr = readl_relaxed(ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_SMR(i));
+		mask = (smr >> SMR_MASK_SHIFT) & SMR_MASK_MASK;
+		id = smr & SMR_ID_MASK;
+		if (!(smr & SMR_VALID))
+			continue;
+
+		s2cr = readl_relaxed(ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_S2CR(i));
+		type = (s2cr >> S2CR_TYPE_SHIFT) & S2CR_TYPE_MASK;
+		cbndx = (s2cr >> S2CR_CBNDX_SHIFT) & S2CR_CBNDX_MASK;
+		privcfg = (s2cr >> S2CR_PRIVCFG_SHIFT) & S2CR_PRIVCFG_MASK;
+		if (type != S2CR_TYPE_TRANS)
+			continue;
+
+		/* Populate the SMR */
+		smmu->smrs[i].mask = mask;
+		smmu->smrs[i].id = id;
+		smmu->smrs[i].valid = true;
+
+		/* Populate the S2CR */
+		smmu->s2crs[i].group = NULL;
+		smmu->s2crs[i].count = 1;
+		smmu->s2crs[i].type = type;
+		smmu->s2crs[i].privcfg = privcfg;
+		smmu->s2crs[i].cbndx = cbndx;
+		smmu->s2crs[i].handoff = true;
+
+		/* Mark the context bank as busy */
+		bitmap_set(smmu->context_map, cbndx, 1);
+	}
+}
+
 static int arm_smmu_id_size_to_bits(int size)
 {
 	switch (size) {
@@ -2023,6 +2091,8 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
 			   smmu->ipa_size, smmu->pa_size);
 
+	arm_smmu_read_smr_state(smmu);
+
 	return 0;
 }
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
