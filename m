Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0FFC433E0
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:49:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C693239EF
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C693239EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 07F628738C;
	Fri, 22 Jan 2021 13:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JpjY03mq0xl6; Fri, 22 Jan 2021 13:49:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 38EEA87383;
	Fri, 22 Jan 2021 13:49:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B0D5C08A1;
	Fri, 22 Jan 2021 13:49:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61845C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5511786AC9
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0zXKtdmx2ysI for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:48:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2C67885E91
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:48:58 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id c128so4389777wme.2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 05:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ad1m73rJey7g7/OzCG7tonlhIcacIr2xTxX96uhFg44=;
 b=x2j8xXDbNuJdzg8bGiEMRcyd8Bo68lGFww74aN53kJmrZABHQquOKvZY66xjbjrht3
 V5tFbiq16HHWS+seCjMfX5fM78WxY5PCvk9jHPDRKPvBYfwY6Q2zwgq/74RlOF3Bt3cJ
 wWS17FdzdbOSphZ6181FlmwECIxeJJbqrX6cXeIE/Uww/WqKL5Wz/63ZWW8nku5rdNo0
 Y7jbqOtvarTKV+NJ92cQjbi3y3+g35xFdZcwsj4/WIbvemlq4mDoAAl4mMA0DMHhfo2W
 QiaxGv5P3TyHpD73HmjG1rejsmtUzjY+g65AVvUzXquCJylYcmJJv98MpDsK4L0TIHb9
 Dtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ad1m73rJey7g7/OzCG7tonlhIcacIr2xTxX96uhFg44=;
 b=HsSJaWQZa1DMNJfykUDgJg0RCl8Hlnbk689HaWXf/454TaEg2317VqazX0feV2/Opz
 FhOFBvE9B3IXy0BasRvS1LcvRjjIzRwR4/rrVQ4A4uGCSxSinNq0p+D3Sy1Ohx+GZoPk
 NizfXGfMuQTpNFbEw69oOWFGbj9673sHhGCFZNXiQcwrzeIpOR22FHWaHz/agUN6mIq8
 84WhCYxLYH2PPTCLl/LetlAmPIPp4Vct/q1N/ovCLHsS8eBtzW4zLSdBWYiBFVRFQICv
 zSp5O9uTkpdy5BgDLR4k35cvYP+y2BbM0MyVfUJqa33NS11nTrytwf+nMi623dEew4PS
 Mtrg==
X-Gm-Message-State: AOAM5337lDoRiYUXgR9PtjV0vaax64hrHRGT7kk/bxHxR5mPLt937+FJ
 Ed+4HgSsSoyCVwuzU0RuPSLNYA==
X-Google-Smtp-Source: ABdhPJyn7rhHjQerd2xa5zy4wGkgvFe5+cz7Crv3gRKhJM/jyeoZgsYd7YilM/k+Qw0rBoUOwYQbSw==
X-Received: by 2002:a1c:2ed2:: with SMTP id u201mr4051575wmu.79.1611323336689; 
 Fri, 22 Jan 2021 05:48:56 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id z15sm12198498wrv.67.2021.01.22.05.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 05:48:55 -0800 (PST)
Date: Fri, 22 Jan 2021 14:48:35 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove the page 1 fixup
Message-ID: <YArXswMSf5sCNe2Q@myrica>
References: <08d9bda570bb5681f11a2f250a31be9ef763b8c5.1611238182.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <08d9bda570bb5681f11a2f250a31be9ef763b8c5.1611238182.git.robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux-foundation.org,
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

On Thu, Jan 21, 2021 at 02:09:42PM +0000, Robin Murphy wrote:
> Since we now keep track of page 1 via a separate pointer that already
> encapsulates aliasing to page 0 as necessary, we can remove the clunky
> fixup routine and simply use the relevant bases directly. The current
> architecture spec (IHI0070D.a) defines SMMU_{EVENTQ,PRIQ}_{PROD,CONS} as
> offsets relative to page 1, so the cleanup represents a little bit of
> convergence as well as just lines of code saved.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 42 ++++++++-------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++--
>  2 files changed, 20 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5a3492116bbc..15f4eea25148 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -90,15 +90,6 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ 0, NULL},
>  };
>  
> -static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
> -						 struct arm_smmu_device *smmu)
> -{
> -	if (offset > SZ_64K)
> -		return smmu->page1 + offset - SZ_64K;
> -
> -	return smmu->base + offset;
> -}
> -
>  static void parse_driver_options(struct arm_smmu_device *smmu)
>  {
>  	int i = 0;
> @@ -2613,6 +2604,7 @@ static struct iommu_ops arm_smmu_ops = {
>  /* Probing and initialisation functions */
>  static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  				   struct arm_smmu_queue *q,
> +				   void __iomem *page,
>  				   unsigned long prod_off,
>  				   unsigned long cons_off,
>  				   size_t dwords, const char *name)
> @@ -2641,8 +2633,8 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  			 1 << q->llq.max_n_shift, name);
>  	}
>  
> -	q->prod_reg	= arm_smmu_page1_fixup(prod_off, smmu);
> -	q->cons_reg	= arm_smmu_page1_fixup(cons_off, smmu);
> +	q->prod_reg	= page + prod_off;
> +	q->cons_reg	= page + cons_off;
>  	q->ent_dwords	= dwords;
>  
>  	q->q_base  = Q_BASE_RWA;
> @@ -2686,9 +2678,9 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  	int ret;
>  
>  	/* cmdq */
> -	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
> -				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS,
> -				      "cmdq");
> +	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, smmu->base,
> +				      ARM_SMMU_CMDQ_PROD, ARM_SMMU_CMDQ_CONS,
> +				      CMDQ_ENT_DWORDS, "cmdq");
>  	if (ret)
>  		return ret;
>  
> @@ -2697,9 +2689,9 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  		return ret;
>  
>  	/* evtq */
> -	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
> -				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS,
> -				      "evtq");
> +	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, smmu->page1,
> +				      ARM_SMMU_EVTQ_PROD, ARM_SMMU_EVTQ_CONS,
> +				      EVTQ_ENT_DWORDS, "evtq");
>  	if (ret)
>  		return ret;
>  
> @@ -2707,9 +2699,9 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
>  		return 0;
>  
> -	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
> -				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS,
> -				       "priq");
> +	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, smmu->page1,
> +				       ARM_SMMU_PRIQ_PROD, ARM_SMMU_PRIQ_CONS,
> +				       PRIQ_ENT_DWORDS, "priq");
>  }
>  
>  static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> @@ -3119,10 +3111,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  
>  	/* Event queue */
>  	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
> -	writel_relaxed(smmu->evtq.q.llq.prod,
> -		       arm_smmu_page1_fixup(ARM_SMMU_EVTQ_PROD, smmu));
> -	writel_relaxed(smmu->evtq.q.llq.cons,
> -		       arm_smmu_page1_fixup(ARM_SMMU_EVTQ_CONS, smmu));
> +	writel_relaxed(smmu->evtq.q.llq.prod, smmu->page1 + ARM_SMMU_EVTQ_PROD);
> +	writel_relaxed(smmu->evtq.q.llq.cons, smmu->page1 + ARM_SMMU_EVTQ_CONS);
>  
>  	enables |= CR0_EVTQEN;
>  	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> @@ -3137,9 +3127,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  		writeq_relaxed(smmu->priq.q.q_base,
>  			       smmu->base + ARM_SMMU_PRIQ_BASE);
>  		writel_relaxed(smmu->priq.q.llq.prod,
> -			       arm_smmu_page1_fixup(ARM_SMMU_PRIQ_PROD, smmu));
> +			       smmu->page1 + ARM_SMMU_PRIQ_PROD);
>  		writel_relaxed(smmu->priq.q.llq.cons,
> -			       arm_smmu_page1_fixup(ARM_SMMU_PRIQ_CONS, smmu));
> +			       smmu->page1 + ARM_SMMU_PRIQ_CONS);
>  
>  		enables |= CR0_PRIQEN;
>  		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index e094cd92df2d..63f1c114c810 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -139,15 +139,15 @@
>  #define ARM_SMMU_CMDQ_CONS		0x9c
>  
>  #define ARM_SMMU_EVTQ_BASE		0xa0
> -#define ARM_SMMU_EVTQ_PROD		0x100a8
> -#define ARM_SMMU_EVTQ_CONS		0x100ac
> +#define ARM_SMMU_EVTQ_PROD		0xa8
> +#define ARM_SMMU_EVTQ_CONS		0xac
>  #define ARM_SMMU_EVTQ_IRQ_CFG0		0xb0
>  #define ARM_SMMU_EVTQ_IRQ_CFG1		0xb8
>  #define ARM_SMMU_EVTQ_IRQ_CFG2		0xbc
>  
>  #define ARM_SMMU_PRIQ_BASE		0xc0
> -#define ARM_SMMU_PRIQ_PROD		0x100c8
> -#define ARM_SMMU_PRIQ_CONS		0x100cc
> +#define ARM_SMMU_PRIQ_PROD		0xc8
> +#define ARM_SMMU_PRIQ_CONS		0xcc
>  #define ARM_SMMU_PRIQ_IRQ_CFG0		0xd0
>  #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
>  #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
