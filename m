Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C74CC433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:36:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085992083B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t88wyukF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085992083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C245D863A3;
	Tue,  1 Sep 2020 03:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nxD-E2aZeISj; Tue,  1 Sep 2020 03:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C4D4B8638F;
	Tue,  1 Sep 2020 03:36:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD015C088B;
	Tue,  1 Sep 2020 03:36:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3878C0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C21D685DF6
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id meUOiGaK2AG2 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 03:36:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 09F23844AA
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:36:54 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id x14so2314667oic.9
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 20:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3bbR697W940r4qzYtPEkaaefcfDcXbIb27x0eRbQn1Q=;
 b=t88wyukFrGBP19mHYjYTWsz3cjpW6QpEg7Ltbz+G5xqv1PsMrwfuqtT+tsBMRaFiAe
 4gPWkDGMc/WT3t+OYUgDhDsySC1lQoBqPFXqCkKy/yNF7uKG0CBKbSLjEcYi8r99wzkD
 zJ1uKKejvBjXEpmdvoN6S1Kw1Lszf8WchWPjqE6kBvVrLaMFqaxCLB8jHPVd05sLjn5w
 Sn+IUjF1T8S8Vk2Gcxs12RcZw9Hv+7upag/QjiMCAT5OFVNyus4MjWThnyDI47KSEHer
 iinAg7zWc3pxEuBAlyWYMLY4fj4xuriYi3LKpZ+nfuCVl8br024gHoMVW+1TKqgidBXf
 4pIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3bbR697W940r4qzYtPEkaaefcfDcXbIb27x0eRbQn1Q=;
 b=ehI7ZHyJLA32/q7q+c/33+Aah28fDHnFsCG1SeyEa6c5SoFxayHkRKQR69iUJx7fYD
 VAsa8hNkY5AW+PrudB9KibdNSQvq9JCDzFuLTW3TvFaWRq//GLRpmHjeyZWUAvU3ZTOZ
 1H+osGIc7+Zy+nlfI4h3SJRbV4Wq1/kuEv2PMDuvWTQ7XSFLrhYUn5/kiTQue4R7A5oS
 SyQD9/PDBdQuqNpbLfr2O5GuG0/fAcg9+P65lTQjqYZCH36YWZiee74UEJI9Selbt3jm
 MwxPV6cELOg2R4BWwBbmYn9tTeHzBbsuzqFSNDxmSX8Ra04OcqSYT8slUHFH47H9lZjl
 htpg==
X-Gm-Message-State: AOAM532IPfrsEXijk88yZBXaclKQMrlO7BfyB0Sk15jjlHxWUWrMlN10
 US8jEq+ygDOeE8l4VM2TCfrHBQ==
X-Google-Smtp-Source: ABdhPJzjeGy+/ZDGjjXngyiAJQe6e3aEgxmZgSoz2VhDdCQaWZ2XBv1SUodwsR+dKUEuJnH+tsgDPw==
X-Received: by 2002:aca:5413:: with SMTP id i19mr16131oib.105.1598931413164;
 Mon, 31 Aug 2020 20:36:53 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id w136sm2050529oif.14.2020.08.31.20.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 20:36:52 -0700 (PDT)
Date: Mon, 31 Aug 2020 22:36:35 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 02/19] iommu/arm-smmu: Pass io-pgtable config to
 implementation specific function
Message-ID: <20200901033635.GK3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-3-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-3-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Jonathan Marek <jonathan@marek.ca>,
 Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 Stephen Boyd <swboyd@chromium.org>, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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

On Thu 13 Aug 21:40 CDT 2020, Rob Clark wrote:

> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Construct the io-pgtable config before calling the implementation specific
> init_context function and pass it so the implementation specific function
> can get a chance to change it before the io-pgtable is created.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c |  3 ++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 11 ++++++-----
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  3 ++-
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> index f4ff124a1967..a9861dcd0884 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> @@ -68,7 +68,8 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>  
> -static int cavium_init_context(struct arm_smmu_domain *smmu_domain)
> +static int cavium_init_context(struct arm_smmu_domain *smmu_domain,
> +		struct io_pgtable_cfg *pgtbl_cfg)
>  {
>  	struct cavium_smmu *cs = container_of(smmu_domain->smmu,
>  					      struct cavium_smmu, smmu);
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 09c42af9f31e..37d8d49299b4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -795,11 +795,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		cfg->asid = cfg->cbndx;
>  
>  	smmu_domain->smmu = smmu;
> -	if (smmu->impl && smmu->impl->init_context) {
> -		ret = smmu->impl->init_context(smmu_domain);
> -		if (ret)
> -			goto out_unlock;
> -	}
>  
>  	pgtbl_cfg = (struct io_pgtable_cfg) {
>  		.pgsize_bitmap	= smmu->pgsize_bitmap,
> @@ -810,6 +805,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		.iommu_dev	= smmu->dev,
>  	};
>  
> +	if (smmu->impl && smmu->impl->init_context) {
> +		ret = smmu->impl->init_context(smmu_domain, &pgtbl_cfg);
> +		if (ret)
> +			goto out_clear_smmu;
> +	}
> +
>  	if (smmu_domain->non_strict)
>  		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>  
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index d890a4a968e8..83294516ac08 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -386,7 +386,8 @@ struct arm_smmu_impl {
>  			    u64 val);
>  	int (*cfg_probe)(struct arm_smmu_device *smmu);
>  	int (*reset)(struct arm_smmu_device *smmu);
> -	int (*init_context)(struct arm_smmu_domain *smmu_domain);
> +	int (*init_context)(struct arm_smmu_domain *smmu_domain,
> +			struct io_pgtable_cfg *cfg);
>  	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
>  			 int status);
>  	int (*def_domain_type)(struct device *dev);
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
