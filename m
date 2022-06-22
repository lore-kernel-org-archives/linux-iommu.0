Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47177C43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 12:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE85B83FA3;
	Wed, 22 Jun 2022 12:46:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE85B83FA3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kx4picFqDAMA; Wed, 22 Jun 2022 12:46:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6E8DE83F96;
	Wed, 22 Jun 2022 12:46:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E8DE83F96
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 307B9C0039;
	Wed, 22 Jun 2022 12:46:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0AAEC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 12:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75C8C83F9D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 12:46:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75C8C83F9D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o3eMYpl12clE for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 12:46:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86BF783F96
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86BF783F96
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 12:46:30 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 994612D0; Wed, 22 Jun 2022 14:46:26 +0200 (CEST)
Date: Wed, 22 Jun 2022 14:46:19 +0200
From: Joerg Roedel <joro@8bytes.org>
To: yf.wang@mediatek.com
Subject: Re: [PATCH] iommu/dma: Fix race condition during iova_domain
 initialization
Message-ID: <YrMPG4dIEnFkCbi9@8bytes.org>
References: <20220530120748.31733-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220530120748.31733-1-yf.wang@mediatek.com>
Cc: Miles Chen <miles.chen@mediatek.com>, wsd_upstream@mediatek.com,
 open list <linux-kernel@vger.kernel.org>, Libo Kang <Libo.Kang@mediatek.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Ning Li <ning.li@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

Please re-send with

	Robin Murphy <robin.murphy@arm.com>

in Cc.

On Mon, May 30, 2022 at 08:07:45PM +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> When many devices share the same iova domain, iommu_dma_init_domain()
> may be called at the same time. The checking of iovad->start_pfn will
> all get false in iommu_dma_init_domain() and both enter init_iova_domain()
> to do iovad initialization.
> 
> Fix this by protecting init_iova_domain() with iommu_dma_cookie->mutex.
> 
> Exception backtrace:
> rb_insert_color(param1=0xFFFFFF80CD2BDB40, param3=1) + 64
> init_iova_domain() + 180
> iommu_setup_dma_ops() + 260
> arch_setup_dma_ops() + 132
> of_dma_configure_id() + 468
> platform_dma_configure() + 32
> really_probe() + 1168
> driver_probe_device() + 268
> __device_attach_driver() + 524
> __device_attach() + 524
> bus_probe_device() + 64
> deferred_probe_work_func() + 260
> process_one_work() + 580
> worker_thread() + 1076
> kthread() + 332
> ret_from_fork() + 16
> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>  drivers/iommu/dma-iommu.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..b38c5041eeab 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -63,6 +63,7 @@ struct iommu_dma_cookie {
>  
>  	/* Domain for flush queue callback; NULL if flush queue not in use */
>  	struct iommu_domain		*fq_domain;
> +	struct mutex			mutex;
>  };
>  
>  static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
> @@ -309,6 +310,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>  	if (!domain->iova_cookie)
>  		return -ENOMEM;
>  
> +	mutex_init(&domain->iova_cookie->mutex);
>  	return 0;
>  }
>  
> @@ -549,26 +551,33 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  	}
>  
>  	/* start_pfn is always nonzero for an already-initialised domain */
> +	mutex_lock(&cookie->mutex);
>  	if (iovad->start_pfn) {
>  		if (1UL << order != iovad->granule ||
>  		    base_pfn != iovad->start_pfn) {
>  			pr_warn("Incompatible range for DMA domain\n");
> -			return -EFAULT;
> +			ret = -EFAULT;
> +			goto done_unlock;
>  		}
>  
> -		return 0;
> +		ret = 0;
> +		goto done_unlock;
>  	}
>  
>  	init_iova_domain(iovad, 1UL << order, base_pfn);
>  	ret = iova_domain_init_rcaches(iovad);
>  	if (ret)
> -		return ret;
> +		goto done_unlock;
>  
>  	/* If the FQ fails we can simply fall back to strict mode */
>  	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
>  		domain->type = IOMMU_DOMAIN_DMA;
>  
> -	return iova_reserve_iommu_regions(dev, domain);
> +	ret = iova_reserve_iommu_regions(dev, domain);
> +
> +done_unlock:
> +	mutex_unlock(&cookie->mutex);
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
