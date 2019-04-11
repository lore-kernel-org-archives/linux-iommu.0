Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBB0C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 08:39:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BA3217D4
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 08:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BA3217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9AAB12386;
	Thu, 11 Apr 2019 08:39:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 950C622EE
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 08:39:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id D998BF4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 08:39:08 +0000 (UTC)
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
	by kirsty.vergenet.net (Postfix) with ESMTPA id DE49525BE7D;
	Thu, 11 Apr 2019 18:39:07 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
	id DE3C5940356; Thu, 11 Apr 2019 10:39:05 +0200 (CEST)
Date: Thu, 11 Apr 2019 10:39:05 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 6/6] iommu/ipmmu-vmsa: Add suspend/resume support
Message-ID: <20190411083905.fpeicn5ia3ghbphe@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
	<20190403182148.18058-7-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190403182148.18058-7-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Magnus Damm <damm+renesas@opensource.se>,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411083905.g27old_GwJWnRs-5RFHR3VjFiQGbNQKs5JMl2d5b8Hc@z>

On Wed, Apr 03, 2019 at 08:21:48PM +0200, Geert Uytterhoeven wrote:
> During PSCI system suspend, R-Car Gen3 SoCs are powered down, and all
> IPMMU state is lost.  Hence after s2ram, devices wired behind an IPMMU,
> and configured to use it, will see their DMA operations hang.
> 
> To fix this, restore all IPMMU contexts, and re-enable all active
> micro-TLBs during system resume.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This patch takes a different approach than the BSP, which implements a
> bulk save/restore of all registers during system suspend/resume.
> 
> v2:
>   - Drop PSCI checks.
> ---
>  drivers/iommu/ipmmu-vmsa.c | 47 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 56e84bcc9532e1ce..408ad0b2591925e0 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -36,7 +36,10 @@
>  #define arm_iommu_detach_device(...)	do {} while (0)
>  #endif
>  
> -#define IPMMU_CTX_MAX 8U
> +#define IPMMU_CTX_MAX		8U
> +#define IPMMU_CTX_INVALID	-1
> +
> +#define IPMMU_UTLB_MAX		48U
>  
>  struct ipmmu_features {
>  	bool use_ns_alias_offset;
> @@ -58,6 +61,7 @@ struct ipmmu_vmsa_device {
>  	spinlock_t lock;			/* Protects ctx and domains[] */
>  	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
>  	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];

It might be possible to save a bit of memory on Gen 2 systems by
making IPMMU_UTLB_MAX 32 when the driver is compiled for such systems.

> +	s8 utlb_ctx[IPMMU_UTLB_MAX];
>  
>  	struct iommu_group *group;
>  	struct dma_iommu_mapping *mapping;
> @@ -335,6 +339,7 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
>  	ipmmu_write(mmu, IMUCTR(utlb),
>  		    IMUCTR_TTSEL_MMU(domain->context_id) | IMUCTR_FLUSH |
>  		    IMUCTR_MMUEN);
> +	mmu->utlb_ctx[utlb] = domain->context_id;
>  }
>  
>  /*
> @@ -346,6 +351,7 @@ static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
>  	struct ipmmu_vmsa_device *mmu = domain->mmu;
>  
>  	ipmmu_write(mmu, IMUCTR(utlb), 0);
> +	mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
>  }
>  
>  static void ipmmu_tlb_flush_all(void *cookie)
> @@ -1043,6 +1049,7 @@ static int ipmmu_probe(struct platform_device *pdev)
>  	spin_lock_init(&mmu->lock);
>  	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
>  	mmu->features = of_device_get_match_data(&pdev->dev);
> +	memset(mmu->utlb_ctx, IPMMU_CTX_INVALID, mmu->features->num_utlbs);
>  	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
>  
>  	/* Map I/O memory and request IRQ. */
> @@ -1158,10 +1165,48 @@ static int ipmmu_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int ipmmu_resume_noirq(struct device *dev)
> +{
> +	struct ipmmu_vmsa_device *mmu = dev_get_drvdata(dev);
> +	unsigned int i;
> +
> +	/* Reset root MMU and restore contexts */
> +	if (ipmmu_is_root(mmu)) {
> +		ipmmu_device_reset(mmu);
> +
> +		for (i = 0; i < mmu->num_ctx; i++) {
> +			if (!mmu->domains[i])
> +				continue;
> +
> +			ipmmu_domain_setup_context(mmu->domains[i]);
> +		}
> +	}
> +
> +	/* Re-enable active micro-TLBs */
> +	for (i = 0; i < mmu->features->num_utlbs; i++) {
> +		if (mmu->utlb_ctx[i] == IPMMU_CTX_INVALID)
> +			continue;
> +
> +		ipmmu_utlb_enable(mmu->root->domains[mmu->utlb_ctx[i]], i);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ipmmu_pm  = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, ipmmu_resume_noirq)
> +};
> +#define DEV_PM_OPS	&ipmmu_pm
> +#else
> +#define DEV_PM_OPS	NULL
> +#endif /* CONFIG_PM_SLEEP */
> +
>  static struct platform_driver ipmmu_driver = {
>  	.driver = {
>  		.name = "ipmmu-vmsa",
>  		.of_match_table = of_match_ptr(ipmmu_of_ids),
> +		.pm = DEV_PM_OPS,
>  	},
>  	.probe = ipmmu_probe,
>  	.remove	= ipmmu_remove,
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
