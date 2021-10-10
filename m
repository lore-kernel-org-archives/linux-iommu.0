Return-Path: <SRS0=jhW9=O6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D56EC433F5
	for <iommu@archiver.kernel.org>; Sun, 10 Oct 2021 02:34:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B7AE60F58
	for <iommu@archiver.kernel.org>; Sun, 10 Oct 2021 02:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B7AE60F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2D164013A;
	Sun, 10 Oct 2021 02:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QJah4Lm6A9jy; Sun, 10 Oct 2021 02:33:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 43E9640148;
	Sun, 10 Oct 2021 02:33:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BC27C0011;
	Sun, 10 Oct 2021 02:33:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DA16C000D
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 02:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44D296067D
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 02:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mxAFnzpiLnXC for <iommu@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 02:33:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDE016062B
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 02:33:54 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id u18so56594612lfd.12
 for <iommu@lists.linux-foundation.org>; Sat, 09 Oct 2021 19:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H8MR/G+R6dUa+Wsak7wjS+wkWi7PQwjwNuQYwbKSDbs=;
 b=zsm4QGk8rPd0xznOtFQ4jM80KtqL6ElVzYNVtbULnt2VHGFGaqGQ7IBeRCpToy8QqY
 jhZJajveM8niezxDR4oPUnd6i2H+QSkDf0koHaqlaS/jjfuhzl1LDxD5n3UrISdt612y
 3QOjwAj8MnSWmCzR4bLzRBMKSxRgRuLZQkxq2ZM1CZttdVdZfbI8blnawJ+G5wHMimro
 OEcln7Qkhx0sFcTamb0Aa6vJloLkLAyPGGJm4pclFSG8/0/6zUpdjepSBRWKJwPIceKm
 RJtGgOkyHwxbcllHuO0MHDiJvyN3jRzuQAZUnei00npwrQaDOPCkpuhPqSSKi8XF0wTX
 xIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H8MR/G+R6dUa+Wsak7wjS+wkWi7PQwjwNuQYwbKSDbs=;
 b=o9LSXcGbPziNNUaFMOx/0WGm+6og96PASvTY4hLoLnKeGaehYLIHVzf3ribhXgBACI
 x1ymNlYlLNzJjmHLzi/F4D5VnPeel33G+VBFPPZnO3T76V/nEuHTCgR1+Fi5+0xKwaek
 bdW1n1cdgf7WN7L3/kwOF54FYTP7CXF2chwswcfGd522/+uGCdtr4fgfAMge4cQnjrKI
 XiEaxzK9w6TnBt/K0G3EtlUMC1aPvj/KH5Bol7QejhB5S2KeDqsh2XQwsfrEGeRtZJMp
 FqWztOT97iEsSsREfF04iGlnYYTiBAZhJTR65Q4etLzmQUrsggO4fn2dYG40NsEt6IkJ
 rWzw==
X-Gm-Message-State: AOAM5316jnoZ/XNCkA6heVWT6XxyrTBn5A6tSe/Ee9xJLzYuUuqZkpeN
 d8UAOoNmO51UDb3Ca5iKw0QaZA==
X-Google-Smtp-Source: ABdhPJwSGRHUjgYDj6ZuRGbJ8leAofMXLbnvvETRVb2XglZdualtHhvMW4bmUmSAHrmweRUkmAHnFw==
X-Received: by 2002:a2e:6e0b:: with SMTP id j11mr13538657ljc.527.1633833232637; 
 Sat, 09 Oct 2021 19:33:52 -0700 (PDT)
Received: from umbar.lan ([37.153.55.125])
 by smtp.gmail.com with ESMTPSA id p23sm345322lfd.127.2021.10.09.19.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Oct 2021 19:33:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kalle Valo <kvalo@codeaurora.org>,
 Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>
Subject: [PATCH] iommu: fix ARM_SMMU vs QCOM_SCM compilation
Date: Sun, 10 Oct 2021 05:33:50 +0300
Message-Id: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>, linux-arm-kernel@lists.infradead.org
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

After commit 424953cf3c66 ("qcom_scm: hide Kconfig symbol") arm-smmu got
qcom_smmu_impl_init() call guarded by IS_ENABLED(CONFIG_ARM_SMMU_QCOM).
However the CONFIG_ARM_SMMU_QCOM Kconfig entry does not exist, so the
qcom_smmu_impl_init() is never called.

So, let's fix this by always calling qcom_smmu_impl_init(). It does not
touch the smmu passed unless the device is a non-Qualcomm one. Make
ARM_SMMU select QCOM_SCM for ARCH_QCOM.

Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
Cc: Arnd Bergmann <arnd@arndb.de>
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/Kconfig                      | 1 +
 drivers/iommu/arm/arm-smmu/Makefile        | 3 +--
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 9 +++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c5c71b7ab7e8..a4593e53fe7d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -309,6 +309,7 @@ config ARM_SMMU
 	tristate "ARM Ltd. System MMU (SMMU) Support"
 	depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	select IOMMU_API
+	select QCOM_SCM
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU if ARM
 	help
diff --git a/drivers/iommu/arm/arm-smmu/Makefile b/drivers/iommu/arm/arm-smmu/Makefile
index b0cc01aa20c9..e240a7bcf310 100644
--- a/drivers/iommu/arm/arm-smmu/Makefile
+++ b/drivers/iommu/arm/arm-smmu/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
-arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o
-arm_smmu-$(CONFIG_ARM_SMMU_QCOM) += arm-smmu-qcom.o
+arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 2c25cce38060..8199185dd262 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -215,8 +215,13 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	    of_device_is_compatible(np, "nvidia,tegra186-smmu"))
 		return nvidia_smmu_impl_init(smmu);
 
-	if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM))
-		smmu = qcom_smmu_impl_init(smmu);
+	/*
+	 * qcom_smmu_impl_init() will not touch smmu if the device is not
+	 * a Qualcomm one.
+	 */
+	smmu = qcom_smmu_impl_init(smmu);
+	if (IS_ERR(smmu))
+		return smmu;
 
 	if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
 		smmu->impl = &mrvl_mmu500_impl;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
