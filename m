Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E565C433DB
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 03:06:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCE964DD0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 03:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCE964DD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7A84387252;
	Thu, 28 Jan 2021 03:06:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aS3umLLtwo7N; Thu, 28 Jan 2021 03:06:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 68295871E3;
	Thu, 28 Jan 2021 03:06:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 501B8C08A1;
	Thu, 28 Jan 2021 03:06:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74747C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 03:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5F42520461
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 03:06:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id viimmZSsFiJE for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 03:06:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id EE7B020449
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 03:06:34 +0000 (UTC)
IronPort-SDR: kgoxMzRMnyQB7wBzfMhkubRg7JassgUv8vsZiish+m+6/OZ2gR9GT+ax7kerUd8i2+wGi+OiAq
 +ph9B1B/H1bQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="179390271"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; d="scan'208";a="179390271"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 19:06:34 -0800
IronPort-SDR: T8XEzW529+wSCH+c4TT3ndgKSSZbVRNKpfJz+NfnL1f8Zh45EeBn2e7BFViYNHSxM8uh1U4R+P
 J8fc0kd0Mi2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; d="scan'208";a="403318859"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2021 19:06:32 -0800
Subject: Re: [PATCH RFC 7/9] iommu: Introduce map_sg() as an IOMMU op for
 IOMMU drivers
To: Chuck Lever <chuck.lever@oracle.com>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
 <161177766681.1311.8296027937092927846.stgit@manet.1015granger.net>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <092dc0f4-5c9a-a811-00ae-2eb15d5c1675@linux.intel.com>
Date: Thu, 28 Jan 2021 10:58:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <161177766681.1311.8296027937092927846.stgit@manet.1015granger.net>
Content-Language: en-US
Cc: isaacm@codeaurora.org, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, will@kernel.org
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

Hi,

On 1/28/21 4:01 AM, Chuck Lever wrote:
> From: Isaac J. Manjarres <isaacm@codeaurora.org>
> 
> Add support for IOMMU drivers to have their own map_sg() callbacks.
> This completes the path for having iommu_map_sg() invoke an IOMMU
> driver's map_sg() callback, which can then invoke the io-pgtable
> map_sg() callback with the entire scatter-gather list, so that it
> can be processed entirely in the io-pgtable layer.
> 
> For IOMMU drivers that do not provide a callback, the default
> implementation of iterating through the scatter-gather list, while
> calling iommu_map() will be used.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> [ cel: adjusted new iotlb_sync_map call site ]
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   drivers/iommu/iommu.c |   12 ++++++++++++
>   include/linux/iommu.h |    5 +++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ed879a4d7fac..bd7adbd0339b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2551,6 +2551,18 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   	unsigned int i = 0;
>   	int ret;
>   
> +	if (ops->map_sg) {
> +		ret = ops->map_sg(domain, iova, sg, nents, prot, gfp, &mapped);
> +
> +		if (ops->iotlb_sync_map)
> +			ops->iotlb_sync_map(domain, iova, mapped);
> +
> +		if (ret)
> +			goto out_err;
> +
> +		return mapped;
> +	}
> +
>   	while (i <= nents) {
>   		phys_addr_t s_phys = sg_phys(sg);
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index cd5f35022a25..667edc7b034a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -192,6 +192,8 @@ struct iommu_iotlb_gather {
>    * @attach_dev: attach device to an iommu domain
>    * @detach_dev: detach device from an iommu domain
>    * @map: map a physically contiguous memory region to an iommu domain
> + * @map_sg: map a scatter-gather list of physically contiguous chunks to
> + *          an iommu domain.
>    * @unmap: unmap a physically contiguous memory region from an iommu domain
>    * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
>    * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
> @@ -243,6 +245,9 @@ struct iommu_ops {
>   	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>   	int (*map)(struct iommu_domain *domain, unsigned long iova,
>   		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> +	int (*map_sg)(struct iommu_domain *domain, unsigned long iova,
> +		      struct scatterlist *sg, unsigned int nents, int prot,
> +		      gfp_t gfp, size_t *mapped);

I might be oversensitive. But what if the vendor iommu driver uses iova
beyond the pre-allocated range? It's safer if we could pass an iova
length parameter as well, so that the iommu driver could do some sanity
check.

Best regards,
baolu

>   	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
>   		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
>   	void (*flush_iotlb_all)(struct iommu_domain *domain);
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
