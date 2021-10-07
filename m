Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CCCC433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 06:18:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74FC6105A
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 06:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B74FC6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 773F7401B7;
	Thu,  7 Oct 2021 06:18:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eZlhLIy1TRum; Thu,  7 Oct 2021 06:18:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55A204018A;
	Thu,  7 Oct 2021 06:18:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A7BAC0011;
	Thu,  7 Oct 2021 06:18:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FFFAC000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 06:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F420841A7
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 06:18:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oFAa-_Msk3xZ for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 06:18:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8D52841A6
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 06:18:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="224946959"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="224946959"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 23:18:33 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="478431836"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.191])
 ([10.254.214.191])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 23:18:31 -0700
Subject: Re: [PATCH v2 1/2] iommu/vt-d: convert the return type of
 first_pte_in_page to bool
To: "Longpeng(Mike)" <longpeng2@huawei.com>, dwmw2@infradead.org,
 will@kernel.org, joro@8bytes.org
References: <20211005152308.1061-1-longpeng2@huawei.com>
 <20211005152308.1061-2-longpeng2@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <62016e41-5d9d-2d42-e16f-59809f9f1f75@linux.intel.com>
Date: Thu, 7 Oct 2021 14:18:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211005152308.1061-2-longpeng2@huawei.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, arei.gonglei@huawei.com,
 linux-kernel@vger.kernel.org
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

On 2021/10/5 23:23, Longpeng(Mike) wrote:
> first_pte_in_page() returns boolean value, so let's convert its
> return type to bool.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>   include/linux/intel-iommu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 05a65eb..a590b00 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -708,7 +708,7 @@ static inline bool dma_pte_superpage(struct dma_pte *pte)
>   	return (pte->val & DMA_PTE_LARGE_PAGE);
>   }
>   
> -static inline int first_pte_in_page(struct dma_pte *pte)
> +static inline bool first_pte_in_page(struct dma_pte *pte)
>   {
>   	return !((unsigned long)pte & ~VTD_PAGE_MASK);
>   }
> 

Probably,

	return IS_ALIGNED((unsigned long)pte, VTD_PAGE_SIZE);

looks neater?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
