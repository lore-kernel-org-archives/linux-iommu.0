Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840C4C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 02:52:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E150B64DD0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 02:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E150B64DD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7206B8731A;
	Thu, 28 Jan 2021 02:52:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2toSSqMzHiPu; Thu, 28 Jan 2021 02:52:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7B08587317;
	Thu, 28 Jan 2021 02:52:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FB98C08A1;
	Thu, 28 Jan 2021 02:52:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1F85C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9801E86DD0
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:52:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dwhHUg1VI6vN for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 02:52:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8D34086BBE
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:52:52 +0000 (UTC)
IronPort-SDR: 0IcAf/Pw0r8zX3MJE00YvUadJVhap2wPBfE/XGRSRhgh1XuuJhFuuzUeQhK2wvum3c68V6Af/g
 FsE/nEgh486g==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="244249955"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; d="scan'208";a="244249955"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 18:52:51 -0800
IronPort-SDR: lnLg3sN5GDXacTxb3HTEfWx2SP1IOlHbUnUOZZgduxVml79LwNk3waJALlr31NNCqpUpRxWktz
 w8FlfVRNCg9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; d="scan'208";a="403315544"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2021 18:52:48 -0800
Subject: Re: [PATCH RFC 2/9] iommu: Add iova and size as parameters in
 iotlb_sync_map
To: Chuck Lever <chuck.lever@oracle.com>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
 <161177763296.1311.15197214300351076283.stgit@manet.1015granger.net>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f4cffd15-65d9-0f00-055c-d141c66ca515@linux.intel.com>
Date: Thu, 28 Jan 2021 10:44:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <161177763296.1311.15197214300351076283.stgit@manet.1015granger.net>
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

On 1/28/21 4:00 AM, Chuck Lever wrote:
> From: Yong Wu <yong.wu@mediatek.com>
> 
> iotlb_sync_map allow IOMMU drivers tlb sync after completing the whole
> mapping. This patch adds iova and size as the parameters in it. then the
> IOMMU driver could flush tlb with the whole range once after iova mapping
> to improve performance.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   drivers/iommu/iommu.c      |    4 ++--
>   drivers/iommu/tegra-gart.c |    7 +++++--
>   include/linux/iommu.h      |    3 ++-
>   3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c304a6a30d42..3d099a31ddca 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2443,7 +2443,7 @@ static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
>   
>   	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
>   	if (ret == 0 && ops->iotlb_sync_map)
> -		ops->iotlb_sync_map(domain);
> +		ops->iotlb_sync_map(domain, iova, size);
>   
>   	return ret;
>   }
> @@ -2575,7 +2575,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   	}
>   
>   	if (ops->iotlb_sync_map)
> -		ops->iotlb_sync_map(domain);
> +		ops->iotlb_sync_map(domain, iova, mapped);
>   	return mapped;
>   
>   out_err:
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index fac720273889..05e8e19b8269 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -261,7 +261,8 @@ static int gart_iommu_of_xlate(struct device *dev,
>   	return 0;
>   }
>   
> -static void gart_iommu_sync_map(struct iommu_domain *domain)
> +static void gart_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
> +				size_t size)
>   {
>   	FLUSH_GART_REGS(gart_handle);
>   }
> @@ -269,7 +270,9 @@ static void gart_iommu_sync_map(struct iommu_domain *domain)
>   static void gart_iommu_sync(struct iommu_domain *domain,
>   			    struct iommu_iotlb_gather *gather)
>   {
> -	gart_iommu_sync_map(domain);
> +	size_t length = gather->end - gather->start;
> +
> +	gart_iommu_sync_map(domain, gather->start, length);
>   }
>   
>   static const struct iommu_ops gart_iommu_ops = {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b3f0e2018c62..9ce0aa9e236b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -246,7 +246,8 @@ struct iommu_ops {
>   	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
>   		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
>   	void (*flush_iotlb_all)(struct iommu_domain *domain);
> -	void (*iotlb_sync_map)(struct iommu_domain *domain);
> +	void (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long iova,
> +			       size_t size);
>   	void (*iotlb_sync)(struct iommu_domain *domain,
>   			   struct iommu_iotlb_gather *iotlb_gather);
>   	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
> 
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
