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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8352CC47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9DB613B1
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9DB613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2780B8424C;
	Thu,  3 Jun 2021 16:45:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Son8E0kx60oY; Thu,  3 Jun 2021 16:45:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51FBA84236;
	Thu,  3 Jun 2021 16:45:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40074C000D;
	Thu,  3 Jun 2021 16:45:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 612A8C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BD3D60B48
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0uJgCuTd114x for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 16:45:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34196606C6
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:14 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id w21so7806710edv.3
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r8fGUpVpptMRBfRxglvA8AvxNT0zJcmuot8FSf94QpQ=;
 b=Mrsq9SXzuGTG87HBigTQmdjHKtQRZcvmcijXZy0iHk8e8caUNdUOM25vJm0ajCrxks
 LYbrnBw3UPxmQis3WBDa4V+KEDL1Vei8VmCI6hui5y3CzL+dbEncV0o+ivy7R8nK3dPJ
 LqZl0YI9vvPE2k5i6RP23IpMFw+1++nnZfcPnBDyKmiQYeNAKnV3H/sETmvp9DZyKvW4
 iJqLcPktC23EY6MQ7wHC/9ExVlmEDxOaypiyzfgI4ghYGOaJzQ+Oqc65RGC62bcUQO/W
 bFiz5OwCDWcaZOBlwbIHIFuUhj7BOzDLN2/G22fNMfx0ZkzawJJpiCgEAsyzAVD/4Z6Q
 uSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r8fGUpVpptMRBfRxglvA8AvxNT0zJcmuot8FSf94QpQ=;
 b=X3v7b0NebjqKfZgJvUZQ+XFCcJfPkJ0FS9e456+bYAr+INAEQFeshFcKMqym3VEJX9
 TxC6dIWRIglMCGdI4YIkHpWy8SMEqUWF9q1dhz7eYA4+QPEq22IOfuxtfttxa8LOSSUG
 WY4OUp6gD4ftnVe1s+xOJmAgo2cPgfBPgHPLJkQc74f9MA4lmQxGXVwSgXUvEEFcGv2R
 JRXzrZZprAMluPqsx3MXUul9Pg1gid3h0KAj6TPe8vTMTizKjVeIGex3CTsB5fdYC2lG
 DUnD0oIS2gseG2RqUN6lcPfo5PUbxsQ+rPaiHtDZkMwjEM69MnQ+WFveVMrvvOomUguU
 +0pQ==
X-Gm-Message-State: AOAM531/41/UyNlC5MVD4bPF350CJGvQSoazUwkY47qmAyppAxgOWxLS
 ILVt3qKsgHyPu9ncFVCBQMU=
X-Google-Smtp-Source: ABdhPJyv8jWy2m1Ygx1oXaeKL6HrcQqVoQpZlQ2h/P1i3CxsxCxRctVO/8Y/6oidTLC0t+bmxRs0TQ==
X-Received: by 2002:a05:6402:1c83:: with SMTP id
 cy3mr428442edb.108.1622738712418; 
 Thu, 03 Jun 2021 09:45:12 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id o4sm1906443edc.94.2021.06.03.09.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 09:45:11 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 6/9] iommu/arm-smmu: Use Tegra implementation on Tegra186
Date: Thu,  3 Jun 2021 18:46:29 +0200
Message-Id: <20210603164632.1000458-7-thierry.reding@gmail.com>
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

Tegra186 requires the same SID override programming as Tegra194 in order
to seamlessly transition from the firmware framebuffer to the Linux
framebuffer, so the Tegra implementation needs to be used on Tegra186
devices as well.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 136872e77195..9f465e146799 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -211,7 +211,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	if (of_property_read_bool(np, "calxeda,smmu-secure-config-access"))
 		smmu->impl = &calxeda_impl;
 
-	if (of_device_is_compatible(np, "nvidia,tegra194-smmu"))
+	if (of_device_is_compatible(np, "nvidia,tegra194-smmu") ||
+	    of_device_is_compatible(np, "nvidia,tegra186-smmu"))
 		return nvidia_smmu_impl_init(smmu);
 
 	smmu = qcom_smmu_impl_init(smmu);
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
