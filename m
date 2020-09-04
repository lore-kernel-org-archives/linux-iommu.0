Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A622CC43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:02:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7302220796
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJb3QhpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7302220796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6667B86E3C;
	Fri,  4 Sep 2020 16:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id csQ1PIdcdDhT; Fri,  4 Sep 2020 16:02:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF00B86DF0;
	Fri,  4 Sep 2020 16:02:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCF6AC07FF;
	Fri,  4 Sep 2020 16:02:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6C6BC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B267E86EDB
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AWxjvQ5hweJU for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 16:02:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0E15D86ED1
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:02:15 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id w16so6742779qkj.7
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A7svwNgsY0UiMpV566sgNDGzXgT7VfisHtnxe6fo6Bo=;
 b=SJb3QhpYN6eU3JoTjsYO9t+QvUwc0b/xpfl5OAl/hynvIxgP9pQtQGZ7Q8P6XbdYOx
 4ZmHDqCeABKsnyHLKLa/r1yj5s7wu0jme98WGPofmclJAqP1x8v1Qtsto93CKB8eFPbS
 d0rLzoytt+cTrw2VjSrbaM+Jqq9LKRqgmjXUemY119lVYuf68vDkVWFjJVhE+nfRUonE
 c+jT35sndJqqYDxgbHkVUFha3/taxEbjypD0TJEBf074vc1FB/fhvmH75GtEaBIZeTux
 WPHSblA16beNt6kLF9KBDd0tdQPNYaE9UaVzy8GYZnTEREbL71aqBcNgXIlp/WpxPsOV
 eUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A7svwNgsY0UiMpV566sgNDGzXgT7VfisHtnxe6fo6Bo=;
 b=jFhl2T+9GvKYdMoAIaPR5FUSFbvYdxGpHGkqLRUOrinp5px6FRE8r1dbNhtJSSGV8/
 PjEe0MHrMgygDjNGdx+cN8r1UiDT0sSyX1ZaGAzHue77B+1Qp5vbUY6S1NMqg5J6oka3
 SDpr3Zs5AIQAJ+GEs6CtnIBUpocQMo9ouipGG2YNJ4hj3iuGTfx8OhSZP7Aw3vLxW75O
 oszonKu4mHoSQ1tuGL9tHAlzOPhWPFdfScoS27KmJV2FoCuLEAk65ckViwwY5L1ISvq5
 VflcCjKGzBI+7Xp7h3FktinupgFB2XZ3yzRRD2fA801lru/1YWvmNea5W8Y9C9CIVPDL
 0tvg==
X-Gm-Message-State: AOAM533VHPoyKb95++kWNcn+sRjgN1tEAHnG52lznGg+YkdwSX12BBn7
 Gm70a+t2C/luAKuw7RqDvRe8xWG2ChW50g==
X-Google-Smtp-Source: ABdhPJw7ASxjDOGw6iPxO7Q3Ca/q5gyDB0Ac6+j7ID3GwnYiQlbkA7Cf3QrRkFvCmJF9BhJscynS1w==
X-Received: by 2002:ac8:7145:: with SMTP id h5mr9707917qtp.110.1599234919674; 
 Fri, 04 Sep 2020 08:55:19 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:55:18 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v3 4/8] iommu/arm-smmu-qcom: Emulate bypass by using context
 banks
Date: Fri,  4 Sep 2020 15:55:09 +0000
Message-Id: <20200904155513.282067-5-bjorn.andersson@linaro.org>
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

Some firmware found on various Qualcomm platforms traps writes to S2CR
of type BYPASS and writes FAULT into the register. In particular, this
prevents us from marking the streams for the display controller as
BYPASS to allow continued scanout of the screen through the
initialization of the ARM SMMU.

This adds a Qualcomm specific cfg_probe function, which probes for the
broken behavior of the S2CR registers and implements a custom
alloc_context_bank() that when necessary allocates a context bank
(without translation) for these domains as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Move quirk from arm_smmudevice to qcom_smmu, as we localize the quirk
  handling to the Qualcomm specific implemntation.

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 229fc8ff8cea..284761a1cd8e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -11,8 +11,14 @@
 
 struct qcom_smmu {
 	struct arm_smmu_device smmu;
+	bool bypass_broken;
 };
 
+static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
+{
+	return container_of(smmu, struct qcom_smmu, smmu);
+}
+
 #define QCOM_ADRENO_SMMU_GPU_SID 0
 
 static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
@@ -162,6 +168,50 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ }
 };
 
+static int qcom_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
+					struct arm_smmu_device *smmu,
+					struct device *dev, int start)
+{
+	struct iommu_domain *domain = &smmu_domain->domain;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+
+	/* Keep identity domains as bypass, unless bypass is broken */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY && !qsmmu->bypass_broken)
+		return ARM_SMMU_CBNDX_BYPASS;
+
+	/*
+	 * The identity domain to emulate bypass is the only domain without a
+	 * dev, use the last context bank for this to avoid collisions with
+	 * active contexts during initialization.
+	 */
+	if (!dev)
+		start = smmu->num_context_banks - 1;
+
+	return __arm_smmu_alloc_bitmap(smmu->context_map, start, smmu->num_context_banks);
+}
+
+static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
+{
+	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	u32 reg;
+
+	/*
+	 * With some firmware writes to S2CR of type FAULT are ignored, and
+	 * writing BYPASS will end up as FAULT in the register. Perform a write
+	 * to S2CR to detect if this is the case with the current firmware.
+	 */
+	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_BYPASS) |
+	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
+	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT);
+	arm_smmu_gr0_write(smmu, last_s2cr, reg);
+	reg = arm_smmu_gr0_read(smmu, last_s2cr);
+	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS)
+		qsmmu->bypass_broken = true;
+
+	return 0;
+}
+
 static int qcom_smmu_def_domain_type(struct device *dev)
 {
 	const struct of_device_id *match =
@@ -200,6 +250,8 @@ static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
 }
 
 static const struct arm_smmu_impl qcom_smmu_impl = {
+	.alloc_context_bank = qcom_smmu_alloc_context_bank,
+	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
 };
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
