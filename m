Return-Path: <SRS0=DPil=GJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F1C433E0
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 00:50:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B559E206C0
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 00:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B559E206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 00C6022D10;
	Wed,  6 Jan 2021 00:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZqvHWY66OyDY; Wed,  6 Jan 2021 00:50:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 23F0620338;
	Wed,  6 Jan 2021 00:50:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08705C088B;
	Wed,  6 Jan 2021 00:50:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A016C013A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 00:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7E0AA845D9
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 00:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jgwXenCfM-Rl for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 00:50:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 18F06845D4
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 00:50:14 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id l207so1712570oib.4
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jan 2021 16:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MY//pdNJ1jtx+davhWjroAABUbia63fV6QVASGfH/ZU=;
 b=oCpQ9J6sRS9tagdGMQk9s4DATKdJwjlk3DmHZJHRC2a9b+/fhHiRhB5hmVEJbQizWJ
 pxRfpXLINKc/hGkmByZrBqVos+6zwTeuBY7c6ecAAYm5CPUavshOp9L3w4Jo2hR6Txq4
 kDyIGcPOBMdN7xlskaWqP6rfY0399nyWZnKY6s1MRSOaLbqY4jl3N8utB215yXpeQWFs
 atXjAIlecflorgcH03w5L3c9Mdc4dJhxomxcQr6Q79ow0pfYVJYlZiNQpoQuAOFvcuzj
 D4V23muW+fGVoTGgsHpC2yBP8rothR8pA9NFgm+SXHAdHx5VHv5TCvT8kMgnpCrOQ8GM
 7rJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MY//pdNJ1jtx+davhWjroAABUbia63fV6QVASGfH/ZU=;
 b=K9XE/XFRElgh/fm5iBbQsaUCgCHnXClzD7n6/Bd8fPyUyj5/XV//urpHTQX0hOHl6O
 2FKnQeM20aS3ji9SnE1Edf3W4Y//pcnXZXlUQ3QbU4sRI99atzLE9nWvozCRV2pZTwHr
 F1hDWf5jSD2nXdJ8eA4AObWPVCrlkGSKLtMz37jWKCqHeOg6GS4L7hca+aUGGpDK9AI7
 MHxX5ueGLNJ5Ld1fmFXi0wMfzUPf4jm3j1AvWf7wVqpTPq7VGS9Udytz/Xd6CWDX7u0A
 M/+8Mn/MwwpJqJFt2yDS63pwH6ztMImIWMuHwDm5pzBnEqM2WfHqa24MghZa2rM+bAYS
 rI4A==
X-Gm-Message-State: AOAM533YnsfPYDoAhljwNtrV73Xujstw4vWZOEetYtYQIEVfiwAQw8lt
 NW5nCRTKn3MG8yYNzoqPzc2nYQ==
X-Google-Smtp-Source: ABdhPJyeUxdYzySoOkACZH8a2ASpyGaDSsM6cIg1pK6baaLSMrtCAMOXh3ocIVAnZbnhcBBeInXHSg==
X-Received: by 2002:aca:d506:: with SMTP id m6mr1570736oig.113.1609894213201; 
 Tue, 05 Jan 2021 16:50:13 -0800 (PST)
Received: from localhost.localdomain
 (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id t24sm222562oou.4.2021.01.05.16.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 16:50:12 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/arm-smmu-qcom: Initialize SCTLR of the bypass context
Date: Tue,  5 Jan 2021 16:50:38 -0800
Message-Id: <20210106005038.4152731-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On SM8150 it's occasionally observed that the boot hangs in between the
writing of SMEs and context banks in arm_smmu_device_reset().

The problem seems to coincide with a display refresh happening after
updating the stream mapping, but before clearing - and there by
disabling translation - the context bank picked to emulate translation
bypass.

Resolve this by explicitly disabling the bypass context already in
cfg_probe.

Fixes: f9081b8ff593 ("iommu/arm-smmu-qcom: Implement S2CR quirk")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 5dff7ffbef11..1b83d140742f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -196,6 +196,8 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 
 		set_bit(qsmmu->bypass_cbndx, smmu->context_map);
 
+		arm_smmu_cb_write(smmu, qsmmu->bypass_cbndx, ARM_SMMU_CB_SCTLR, 0);
+
 		reg = FIELD_PREP(ARM_SMMU_CBAR_TYPE, CBAR_TYPE_S1_TRANS_S2_BYPASS);
 		arm_smmu_gr1_write(smmu, ARM_SMMU_GR1_CBAR(qsmmu->bypass_cbndx), reg);
 	}
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
