Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32720C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 04:56:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B3D208DB
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 04:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZM/Hx5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B3D208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9D3C48668A;
	Tue,  1 Sep 2020 04:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bClwV-kvGyA4; Tue,  1 Sep 2020 04:56:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ECEC386688;
	Tue,  1 Sep 2020 04:56:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCB00C0052;
	Tue,  1 Sep 2020 04:56:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84136C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 04:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 60C8420483
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 04:56:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IjwUVsz1xaie for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 04:56:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by silver.osuosl.org (Postfix) with ESMTPS id D6EC023077
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 04:56:07 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id 37so89855oto.4
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 21:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vtOK+JdyZooaz1NAnQQXA6CpZw+KJadIhTEL2kbj1TY=;
 b=sZM/Hx5YPU8n2Dalo1uiJyMbr745uxuBPAiHY508RWFAugXsnmybzaLCEO2xBNgLhG
 OHE3C4OULSiQYqRcs6BgvhFZC+zZO/VmAeoeqk0k8gB826LBP5qidYnIAYU4rOIrINgM
 TQ+yTWu9Sxp8KC9xZ0TtcnzBbSYCkRapMjBxSKHKoL/KQMvdRc035C9nWtMEqtqRJ36N
 mxJCS9ZoY3Rle9LHVK05/P3R23ouMMKvMCxvJyUkXSUI8qASZExglvLZXweoLVSTAFGu
 Ppbut+TiK/e+1by4PrTo8/2Fewu7TTf0mn3QUYRsvS8RpzJPQ2SJY84gO+/bEYyQ2701
 WYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vtOK+JdyZooaz1NAnQQXA6CpZw+KJadIhTEL2kbj1TY=;
 b=dJdSAP0xPZ+XjB5AQoaEuzYuNjgt9tgSmmyulOJdmFRyBzm7Q6lsD8SU49bKwgWARG
 VrEp9BLllJSmzTaReZnmM046q9NaOyEfcsDCziAGAm+Xp1Ar2gmK6RyViRb19U/zsWHn
 jfQI4D3iZPtPgAWsSdSaD5uS2U6HYX06pjjhX4FOQqV/AK61HjfniFQnrrtQ2+YTXTLH
 jgOcSUen4u+aMtx7g/fGbA3/ktoOpuU06QFRM21bZH/0ryY8KHQOv1ch/SYNX5DhQs7K
 rsqw2tAsF7aCD/TynCT6Vc5ecXa9PNh1glnqdRRcv7HWvJZPJUbHRN/oXHFzh7X7BE36
 OjDQ==
X-Gm-Message-State: AOAM532aWUd2pH3GEOjUdB/ICa8lYPEN1uBi15WpIdB2sHQ9PMwqa0pd
 FZ9k3E/lI1IHnXol/1+aZLYZSw==
X-Google-Smtp-Source: ABdhPJw+EMv9TyDAnLqJQrXIIowFlV6IK//RYKVec+GZUzuKneC5cn+zskaRocfswvWbn08780xMEw==
X-Received: by 2002:a9d:7e85:: with SMTP id m5mr138888otp.330.1598936166935;
 Mon, 31 Aug 2020 21:56:06 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id r189sm2033728oih.51.2020.08.31.21.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 21:56:06 -0700 (PDT)
Date: Mon, 31 Aug 2020 23:56:03 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 08/19] iommu/arm-smmu: constify some helpers
Message-ID: <20200901045603.GO3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-9-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-9-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Stephen Boyd <swboyd@chromium.org>,
 iommu@lists.linux-foundation.org, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Pritesh Raithatha <praithatha@nvidia.com>, freedreno@lists.freedesktop.org,
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

On Thu 13 Aug 21:41 CDT 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> Sprinkle a few `const`s where helpers don't need write access.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 59ff3fc5c6c8..27c83333fc50 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -377,7 +377,7 @@ struct arm_smmu_master_cfg {
>  	s16				smendx[];
>  };
>  
> -static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
> +static inline u32 arm_smmu_lpae_tcr(const struct io_pgtable_cfg *cfg)
>  {
>  	u32 tcr = FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
>  		FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
> @@ -398,13 +398,13 @@ static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
>  	return tcr;
>  }
>  
> -static inline u32 arm_smmu_lpae_tcr2(struct io_pgtable_cfg *cfg)
> +static inline u32 arm_smmu_lpae_tcr2(const struct io_pgtable_cfg *cfg)
>  {
>  	return FIELD_PREP(ARM_SMMU_TCR2_PASIZE, cfg->arm_lpae_s1_cfg.tcr.ips) |
>  	       FIELD_PREP(ARM_SMMU_TCR2_SEP, ARM_SMMU_TCR2_SEP_UPSTREAM);
>  }
>  
> -static inline u32 arm_smmu_lpae_vtcr(struct io_pgtable_cfg *cfg)
> +static inline u32 arm_smmu_lpae_vtcr(const struct io_pgtable_cfg *cfg)
>  {
>  	return ARM_SMMU_VTCR_RES1 |
>  	       FIELD_PREP(ARM_SMMU_VTCR_PS, cfg->arm_lpae_s2_cfg.vtcr.ps) |
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
