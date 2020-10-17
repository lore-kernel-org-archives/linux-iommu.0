Return-Path: <SRS0=0/ZC=DY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD37C433DF
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 04:38:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F572072C
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 04:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d49Vti2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F572072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 380EF884BA;
	Sat, 17 Oct 2020 04:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P5AbBpHoCU86; Sat, 17 Oct 2020 04:38:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8173D88498;
	Sat, 17 Oct 2020 04:38:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74F07C07FF;
	Sat, 17 Oct 2020 04:38:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA6A7C0051
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C9DFE88EB0
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VFa4XUrcLaV7 for <iommu@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 04:38:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9BEE088EA9
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:38:29 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id h62so707474oth.9
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 21:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AOjoMftzfUgquuonXm8ecKALCf35LLgxoRywnILvYmM=;
 b=d49Vti2ocqeySl7P9/9hAzXFqHuY26zRhnG4D5kODBWt7wOSQnaVdBrmHcNsY8o4zC
 wribtUA0xR6AfDS7810YK0Ia/ckWr7kzwXIuvVSz3U3C7D8H1WmhIY/F/C07ki2GhpqA
 IIWSRC9r9uzgAnaIJbfT0BSyxSYjIfiT2F4VPqnFilmwMEAAqyf4BiJG4Bn4Gpsx+DXm
 NuQ89kFrTA3k9Mvxt0vPlefFqDjm8ex6yvLO5HCL3rCuvFQGX3yHTVEmbE/LHmCj7+0y
 ShtfrggLu5Rto8X6HJ2UEqXUBWE59sy/+Qp9uNdlaMgUNUUJlk4A6MwkDvX7QpN6/WYR
 hyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AOjoMftzfUgquuonXm8ecKALCf35LLgxoRywnILvYmM=;
 b=BUOBlxjBm5TLiLOuJj4/eQWR4nSEKIM1fTqk5hCjhSGZSVNyEp6sAYM+btHYmjBLVF
 Z1Gt8cRM75Xl1e8kktKu7M4DaF4mU6F4ZfcMhaK3KHhIHclAbQeMrm23UcMWlTxck4F2
 yzDdMueDe0fsqHmasW5MumC1Po+sQHHZx4UZA+bJWNE1NvY5Dx176wOKMI4bJDoPE6Iz
 T9NNn6WM3F1BAVW9GH4xYIuZ4rn5NPXJT2O0U5TfqI32UPCEkrr0ZPq/mTv7/s4BDc6u
 qw7daMN364HaPLJGUfe31sQjtVC4yMWOIwlmRKDQe0gXlzaMiwpAQP6R7W3neX6nU9wc
 5Upg==
X-Gm-Message-State: AOAM532aVYiMz0AM2kcv9FcNU+dIWZxpTU8sgUIYeEPiZ2u1F9nzFPUs
 eoqv5hJTjfDG5fOMSs7o14Vnag==
X-Google-Smtp-Source: ABdhPJz3lO0k/8MmBGaECH28vrQgBXaTzrSnujfffItvlwzznAn3LCUQ2mYeix59JGLH13hqdqBk7Q==
X-Received: by 2002:a9d:7993:: with SMTP id h19mr5086092otm.129.1602909508902; 
 Fri, 16 Oct 2020 21:38:28 -0700 (PDT)
Received: from localhost.localdomain
 (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id t65sm1640038oib.50.2020.10.16.21.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 21:38:28 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 Thierry Reding <treding@nvidia.com>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v4 2/3] iommu/arm-smmu-qcom: Read back stream mappings
Date: Fri, 16 Oct 2020 21:39:06 -0700
Message-Id: <20201017043907.2656013-3-bjorn.andersson@linaro.org>
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

The Qualcomm boot loader configures stream mapping for the peripherals
that it accesses and in particular it sets up the stream mapping for the
display controller to be allowed to scan out a splash screen or EFI
framebuffer.

Read back the stream mappings during initialization and make the
arm-smmu driver maintain the streams in bypass mode.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Extracted from different patch in v3.
- Now configures the stream as BYPASS, rather than translate, which should work
  for platforms with working S2CR handling as well.

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index be4318044f96..0089048342dd 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -23,6 +23,29 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ }
 };
 
+static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
+{
+	u32 smr;
+	int i;
+
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
+
+		if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
+			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
+			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
+			smmu->smrs[i].valid = true;
+
+			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
+			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+			smmu->s2crs[i].cbndx = 0xff;
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
@@ -61,6 +84,7 @@ static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
 }
 
 static const struct arm_smmu_impl qcom_smmu_impl = {
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
