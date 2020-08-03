Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B312C433E0
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 10:01:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F262420678
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 10:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lUSPcQ8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F262420678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 664CB87522;
	Mon,  3 Aug 2020 10:01:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zea8F7bzp0+b; Mon,  3 Aug 2020 10:01:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C12AC86EC0;
	Mon,  3 Aug 2020 10:01:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACAD5C0051;
	Mon,  3 Aug 2020 10:01:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F9F4C004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 10:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7B73220468
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 10:01:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3EsedOFKh1zl for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 10:01:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by silver.osuosl.org (Postfix) with ESMTPS id 69DD4203A5
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 10:01:46 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1596448911; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=0DuhPig/BdjwtnY2fgM6R8kgAL7yGAywFUS6sxjdcPY=;
 b=lUSPcQ8cO8yWAv2FjlYIjjMbILEKiE7zfKPtb2cKjEk11BT408z+ywoMgal2W1KEnkiAOuom
 iZy4JftL87VJB6n06u1fTL9vYxFFQYJsQ82TQhQB24JetMC2J9t3oxaPRiRv8DGVwF2eLoz9
 elJDrRK4seZ/LRwpsB0Zxyrxnds=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-east-1.postgun.com with SMTP id
 5f27e05690893260dd70cf39 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 03 Aug 2020 10:00:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 2FDA0C433CB; Mon,  3 Aug 2020 10:00:53 +0000 (UTC)
Received: from [192.168.0.105] (unknown [103.248.210.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B2DB4C433C6;
 Mon,  3 Aug 2020 10:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2DB4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To: joro@8bytes.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <1593785835-27250-1-git-send-email-vjitta@codeaurora.org>
 <1593785835-27250-2-git-send-email-vjitta@codeaurora.org>
From: Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <29f44540-44f8-570d-886f-2090596a3b8e@codeaurora.org>
Date: Mon, 3 Aug 2020 15:30:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1593785835-27250-2-git-send-email-vjitta@codeaurora.org>
Content-Language: en-GB
Cc: vinmenon@codeaurora.org, kernel-team@android.com
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



On 7/3/2020 7:47 PM, vjitta@codeaurora.org wrote:
> From: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> When ever an iova alloc request fails we free the iova
> ranges present in the percpu iova rcaches and then retry
> but the global iova rcache is not freed as a result we could
> still see iova alloc failure even after retry as global
> rcache is holding the iova's which can cause fragmentation.
> So, free the global iova rcache as well and then go for the
> retry.
> 
> Change-Id: Ib8236dc88ba5516b73d4fbf6bf8e68bbf09bbad2
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> ---
>  drivers/iommu/iova.c | 23 +++++++++++++++++++++++
>  include/linux/iova.h |  6 ++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 4e77116..5836c87 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -442,6 +442,7 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
>  		flush_rcache = false;
>  		for_each_online_cpu(cpu)
>  			free_cpu_cached_iovas(cpu, iovad);
> +		free_global_cached_iovas(iovad);
>  		goto retry;
>  	}
>  
> @@ -1055,5 +1056,27 @@ void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>  	}
>  }
>  
> +/*
> + * free all the IOVA ranges of global cache
> + */
> +void free_global_cached_iovas(struct iova_domain *iovad)
> +{
> +	struct iova_rcache *rcache;
> +	unsigned long flags;
> +	int i, j;
> +
> +	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +		rcache = &iovad->rcaches[i];
> +		spin_lock_irqsave(&rcache->lock, flags);
> +		for (j = 0; j < rcache->depot_size; ++j) {
> +			iova_magazine_free_pfns(rcache->depot[j], iovad);
> +			iova_magazine_free(rcache->depot[j]);
> +			rcache->depot[j] = NULL;
> +		}
> +		rcache->depot_size = 0;
> +		spin_unlock_irqrestore(&rcache->lock, flags);
> +	}
> +}
> +
>  MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index a0637ab..a905726 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -163,6 +163,7 @@ int init_iova_flush_queue(struct iova_domain *iovad,
>  struct iova *split_and_remove_iova(struct iova_domain *iovad,
>  	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
>  void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
> +void free_global_cached_iovas(struct iova_domain *iovad);
>  #else
>  static inline int iova_cache_get(void)
>  {
> @@ -270,6 +271,11 @@ static inline void free_cpu_cached_iovas(unsigned int cpu,
>  					 struct iova_domain *iovad)
>  {
>  }
> +
> +static inline void free_global_cached_iovas(struct iova_domain *iovad)
> +{
> +}
> +
>  #endif
>  
>  #endif
> 

ping?
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
