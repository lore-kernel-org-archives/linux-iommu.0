Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D751AC433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E74061076
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E74061076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00637405C8;
	Tue, 20 Apr 2021 17:25:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y62fIWU143l0; Tue, 20 Apr 2021 17:25:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70ACD405C3;
	Tue, 20 Apr 2021 17:25:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AB04C000E;
	Tue, 20 Apr 2021 17:25:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5B02C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7F2D405CD
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VLgaA-vQPzeS for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:25:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCE20405C3
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:50 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id sd23so50811286ejb.12
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p2ZJr/xZleVG5vuo3vPYmm91QfUd+NNqHlfpozdoe+o=;
 b=jsa3AkWNBDjgamJbXDaljolIixvaPZTNVV8eniMr+VOD+kTy4Fj29gy79z7XKq9ykE
 3gv2/EAkhd1gsGruvhDqp4wEjnxIiCimFU/RgrQqGSiQjRR4eFBlPrh6zBc0BKERnw5F
 1qyUSbxcCq5tFgj6BuuNvb0LuuLnGYNWHaES+USLwewwJlOR+Gx5msYK59HjmCWZndl4
 i7ew+P/BDjt1IOwlOzH9k+hIULL915piRp0lNPCuJ0C9Uo8E1ydT1RU01gaecdS8Wqf8
 4TfDnfckvXCJzgb/IEVkd7fdiGAwSSlT1SPFv2MwTGzAI5IaxaPAM+KeJ7q/GxX38Dn/
 hBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p2ZJr/xZleVG5vuo3vPYmm91QfUd+NNqHlfpozdoe+o=;
 b=MOvjbzBdog7WkYPS/6mMTjVIQONDSO0ZhQkBSuc9yv96UWn4iUCXPw4a1v9G/3x+FI
 733MMyjR27evdSln7H/NZActe6BP9I20SjTBcwrGg6aXIVhxcilemjfjxZmHqQHPp946
 3WABaG6BCcUoCTwKdWTOz6NDwHvqnEecWEj/6uh9BdOyd8HoR1k6RwGfqhlMogfS7DdA
 qqrgwDKHc68hO3oV/kry4xmHLfU1TG0WNdVf+GeUFaarPDj8f9UWWpznmQVXaAAFfPCM
 vWMXjaXM7mbEl7og2sCVOgTsNIZcBZiKWMzK8xB+kYeCsrMEJJuKt9n9BHhnIobl/Vgn
 7KEA==
X-Gm-Message-State: AOAM533NNths3unPaRMH55L2HzoI/njxN+lKhBhkaS7qlUmhq8gIaPFx
 RPKF0f0U1kd2hgi9b89pkTE=
X-Google-Smtp-Source: ABdhPJwzCWpVw7Ve1FfA3VZFd2TaFsdaYTJrv8OF17ztwD6A/Jl0H4QyQKbqByeQhd5d35kji3SBew==
X-Received: by 2002:a17:906:4ec3:: with SMTP id
 i3mr29149586ejv.119.1618939549020; 
 Tue, 20 Apr 2021 10:25:49 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id y11sm16781977eds.10.2021.04.20.10.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 10:25:48 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 06/10] iommu/arm-smmu: Use Tegra implementation on Tegra186
Date: Tue, 20 Apr 2021 19:26:15 +0200
Message-Id: <20210420172619.3782831-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420172619.3782831-1-thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
