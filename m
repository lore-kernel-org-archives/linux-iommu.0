Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25373C433E0
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 13:40:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED7B22DFB
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 13:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED7B22DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E72E84FD5;
	Tue, 19 Jan 2021 13:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TPK3yicxsPsV; Tue, 19 Jan 2021 13:40:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A22D58504B;
	Tue, 19 Jan 2021 13:40:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F2C6C088B;
	Tue, 19 Jan 2021 13:40:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EBADC013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 13:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1A3AC861F4
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 13:40:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s4WjA6axNFty for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 13:40:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id D5E71861D4
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 13:40:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B8D211B3;
 Tue, 19 Jan 2021 05:40:13 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A3303F719;
 Tue, 19 Jan 2021 05:40:11 -0800 (PST)
Subject: Re: [PATCH 2/2 v2] iommu: use the __iommu_attach_device() directly
 for deferred attach
To: Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
References: <20210119111616.12761-1-lijiang@redhat.com>
 <20210119111616.12761-3-lijiang@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1792a2eb-83e0-9849-082e-07a1602e25ed@arm.com>
Date: Tue, 19 Jan 2021 13:40:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119111616.12761-3-lijiang@redhat.com>
Content-Language: en-GB
Cc: thomas.lendacky@amd.com, iommu@lists.linux-foundation.org, will@kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-01-19 11:16, Lianbo Jiang wrote:
> Currently, because domain attach allows to be deferred from iommu
> driver to device driver, and when iommu initializes, the devices
> on the bus will be scanned and the default groups will be allocated.
> 
> Due to the above changes, some devices could be added to the same
> group as below:
> 
> [    3.859417] pci 0000:01:00.0: Adding to iommu group 16
> [    3.864572] pci 0000:01:00.1: Adding to iommu group 16
> [    3.869738] pci 0000:02:00.0: Adding to iommu group 17
> [    3.874892] pci 0000:02:00.1: Adding to iommu group 17
> 
> But when attaching these devices, it doesn't allow that a group has
> more than one device, otherwise it will return an error. This conflicts
> with the deferred attaching. Unfortunately, it has two devices in the
> same group for my side, for example:
> 
> [    9.627014] iommu_group_device_count(): device name[0]:0000:01:00.0
> [    9.633545] iommu_group_device_count(): device name[1]:0000:01:00.1
> ...
> [   10.255609] iommu_group_device_count(): device name[0]:0000:02:00.0
> [   10.262144] iommu_group_device_count(): device name[1]:0000:02:00.1
> 
> Finally, which caused the failure of tg3 driver when tg3 driver calls
> the dma_alloc_coherent() to allocate coherent memory in the tg3_test_dma().
> 
> [    9.660310] tg3 0000:01:00.0: DMA engine test failed, aborting
> [    9.754085] tg3: probe of 0000:01:00.0 failed with error -12
> [    9.997512] tg3 0000:01:00.1: DMA engine test failed, aborting
> [   10.043053] tg3: probe of 0000:01:00.1 failed with error -12
> [   10.288905] tg3 0000:02:00.0: DMA engine test failed, aborting
> [   10.334070] tg3: probe of 0000:02:00.0 failed with error -12
> [   10.578303] tg3 0000:02:00.1: DMA engine test failed, aborting
> [   10.622629] tg3: probe of 0000:02:00.1 failed with error -12
> 
> In addition, the similar situations also occur in other drivers such
> as the bnxt_en driver. That can be reproduced easily in kdump kernel
> when SME is active
> 
> Let's move the handling currently in iommu_dma_deferred_attach() into
> the iommu core code so that it can call the __iommu_attach_device()
> directly instead of the iommu_attach_device(). The external interface
> iommu_attach_device() is not suitable for handling this situation.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>   drivers/iommu/dma-iommu.c | 18 +++---------------
>   drivers/iommu/iommu.c     | 12 ++++++++++++
>   include/linux/iommu.h     |  2 ++
>   3 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 3711b4a6e4f9..fa6f9098e77d 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -380,18 +380,6 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	return iova_reserve_iommu_regions(dev, domain);
>   }
>   
> -static int iommu_dma_deferred_attach(struct device *dev,
> -		struct iommu_domain *domain)
> -{
> -	const struct iommu_ops *ops = domain->ops;
> -
> -	if (unlikely(ops->is_attach_deferred &&
> -			ops->is_attach_deferred(domain, dev)))
> -		return iommu_attach_device(domain, dev);
> -
> -	return 0;
> -}
> -
>   /**
>    * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
>    *                    page flags.
> @@ -535,7 +523,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>   	dma_addr_t iova;
>   
>   	if (static_branch_unlikely(&__deferred_attach) &&
> -	    iommu_dma_deferred_attach(dev, domain))
> +	    iommu_do_deferred_attach(dev, domain))
>   		return DMA_MAPPING_ERROR;
>   
>   	size = iova_align(iovad, size + iova_off);
> @@ -694,7 +682,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
>   	*dma_handle = DMA_MAPPING_ERROR;
>   
>   	if (static_branch_unlikely(&__deferred_attach) &&
> -	    iommu_dma_deferred_attach(dev, domain))
> +	    iommu_do_deferred_attach(dev, domain))
>   		return NULL;
>   
>   	min_size = alloc_sizes & -alloc_sizes;
> @@ -1005,7 +993,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	int i;
>   
>   	if (static_branch_unlikely(&__deferred_attach) &&
> -	    iommu_dma_deferred_attach(dev, domain))
> +	    iommu_do_deferred_attach(dev, domain))
>   		return 0;
>   
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ffeebda8d6de..32164d355d2e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1980,6 +1980,18 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(iommu_attach_device);
>   
> +int iommu_do_deferred_attach(struct device *dev,
> +			     struct iommu_domain *domain)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +
> +	if (unlikely(ops->is_attach_deferred &&
> +		     ops->is_attach_deferred(domain, dev)))
> +		return __iommu_attach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   /*
>    * Check flags and other user provided data for valid combinations. We also
>    * make sure no reserved fields or unused flags are set. This is to ensure
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b3f0e2018c62..c04bbd30aa1d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -424,6 +424,8 @@ extern struct iommu_group *iommu_group_get_by_id(int id);
>   extern void iommu_domain_free(struct iommu_domain *domain);
>   extern int iommu_attach_device(struct iommu_domain *domain,
>   			       struct device *dev);
> +extern int iommu_do_deferred_attach(struct device *dev,
> +				    struct iommu_domain *domain);
>   extern void iommu_detach_device(struct iommu_domain *domain,
>   				struct device *dev);
>   extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
