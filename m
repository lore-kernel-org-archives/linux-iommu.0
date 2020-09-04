Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CADEC433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:03:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FB52074D
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nq7Yq52d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FB52074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 512BA85D3D;
	Fri,  4 Sep 2020 16:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id azJafVL7AKAo; Fri,  4 Sep 2020 16:03:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3A10285792;
	Fri,  4 Sep 2020 16:03:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25947C07FF;
	Fri,  4 Sep 2020 16:03:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE20C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4CB3120025
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ygJQwchSW6Rr for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 16:03:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 3ED9B1FE65
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:03:34 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id n133so6709160qkn.11
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2fCr1AJs9wuitAEKSrgAGHFGKqH8nNlJ97BjXbXmjcA=;
 b=nq7Yq52dWK2MdT4FH7gxEZp0TjsJOGIfGdo6BK1+4OqJeoDIhKTf2aDFJDTv6cwKiL
 AAfJNraihxLVh8bWslR94j/0QKdKlYNtwIv3yMrxjDSCQOWEIxYc6ZiE65lUItOWUTtY
 BqFB1frX+GcyJ5SqFnJy0mLNzYc7wuu3R+iYFenJhV6MSs9oxnxjXrbEGZ1RDpM5GY+T
 y8WqyyGYcT8oYzHDGnZ8tQ7tfYTprXqknoa5mg/+T0r8ub6dJ9lD13U53ryGD9+UKow6
 LAJ62Z/mLSjcPYmkMHcOGBIr5g7C3xlrml3u8u7TkDz6TWwCAA8+9cceeXtB6w+uWVVB
 vqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2fCr1AJs9wuitAEKSrgAGHFGKqH8nNlJ97BjXbXmjcA=;
 b=hbU91oyumZ32renNh3NCugtznB54F7UNFZ6N16ZODgsC8pnuWAa7nUqJ83zBy0SYDs
 wJ1pxOcVqjc2pCOd1NXtBmkaUvzzBh1X2hQuhlFG8ygjMK2/gDatZdQLpRW9lD/2hsY3
 J9veVMak1HZ3CGJF7bed9tssA/FY+3KXC6+Lt8fktXUJ3NsCTpCzu0D3qBvfe5qZjxPz
 9UW4cPk8sy6bG9G3eCK8w0QujopSprnstO7nRo0cSXlW22xPiWi2a8Vi6f6mpg7MaC3I
 o5rX3Aycbt6TLqYlbT/qnNNjiMXoKlumHEMrynI1XvzjUBCG2DeETfRhD7wHZQ7Uqr6u
 M7cw==
X-Gm-Message-State: AOAM532YOI+6IR7u2BJVInXvZDiUWnobc/h13Tsq1z6PgLaIMhLLIazX
 u7PnKt+m/mJIsoR2hhSIB21sE5OuJAL90g==
X-Google-Smtp-Source: ABdhPJx6yG/QL52OZ4xkujRCTRW3+fj5Lott15EzPUVbvzCJ+ggkUIXMR0Jjrj7i70Ud68y/ORLM9w==
X-Received: by 2002:ac8:66d3:: with SMTP id m19mr9426297qtp.276.1599234920832; 
 Fri, 04 Sep 2020 08:55:20 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:55:20 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v3 5/8] iommu/arm-smmu-qcom: Consistently initialize stream
 mappings
Date: Fri,  4 Sep 2020 15:55:10 +0000
Message-Id: <20200904155513.282067-6-bjorn.andersson@linaro.org>
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

Firmware that traps writes to S2CR to translate BYPASS into FAULT also
ignores writes of type FAULT. As such booting with "disable_bypass" set
will result in all S2CR registers left as configured by the bootloader.

This has been seen to result in indeterministic results, as these
mappings might linger and reference context banks that Linux is
reconfiguring.

Use the fact that BYPASS writes result in FAULT type to force all stream
mappings to FAULT.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 284761a1cd8e..70a1eaa52e14 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -195,6 +195,7 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
 	u32 reg;
+	int i;
 
 	/*
 	 * With some firmware writes to S2CR of type FAULT are ignored, and
@@ -206,9 +207,24 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT);
 	arm_smmu_gr0_write(smmu, last_s2cr, reg);
 	reg = arm_smmu_gr0_read(smmu, last_s2cr);
-	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS)
+	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
 		qsmmu->bypass_broken = true;
 
+		/*
+		 * With firmware ignoring writes of type FAULT, booting the
+		 * Linux kernel with disable_bypass disabled (i.e. "enable
+		 * bypass") the initialization during probe will leave mappings
+		 * in an inconsistent state. Avoid this by configuring all
+		 * S2CRs to BYPASS.
+		 */
+		for (i = 0; i < smmu->num_mapping_groups; i++) {
+			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
+			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+			smmu->s2crs[i].cbndx = 0xff;
+			smmu->s2crs[i].count = 0;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
