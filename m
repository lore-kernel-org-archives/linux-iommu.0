Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081B8C4332F
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 14:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0A5C80ABF;
	Fri,  4 Mar 2022 14:03:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HpfEcTqo1nCt; Fri,  4 Mar 2022 14:03:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 786EC8419F;
	Fri,  4 Mar 2022 14:03:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4915BC0012;
	Fri,  4 Mar 2022 14:03:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BB20C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 14:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 548E4841A1
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 14:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xc44CWT-cSqE for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 14:03:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44A318419F
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 14:03:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7893E1424;
 Fri,  4 Mar 2022 06:03:25 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7E423F70D;
 Fri,  4 Mar 2022 06:03:23 -0800 (PST)
Message-ID: <906a446e-3e25-5813-d380-de699a84b6f4@arm.com>
Date: Fri, 4 Mar 2022 14:03:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] iommu/iova: Free all CPU rcache for retry when iova alloc
 failure
Content-Language: en-GB
To: yf.wang@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>
References: <20220304044635.4273-1-yf.wang@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220304044635.4273-1-yf.wang@mediatek.com>
Cc: stable@vger.kernel.org, Ning Li <Ning.Li@mediatek.com>,
 Libo Kang <Libo.Kang@mediatek.com>, wsd_upstream@mediatek.com
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

On 2022-03-04 04:46, yf.wang--- via iommu wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> In alloc_iova_fast function, if an iova alloc request fail,
> it will free the iova ranges present in the percpu iova
> rcaches and free global iova rcache and then retry, but
> flushing CPU iova rcaches only for each online CPU, which
> will cause incomplete rcache cleaning, and iova rcaches of
> not online CPU cannot be flushed, because iova rcaches may
> also lead to fragmentation of iova space, so the next retry
> action may still be fail.
> 
> Based on the above, so need to flushing all iova rcaches
> for each possible CPU, use for_each_possible_cpu instead of
> for_each_online_cpu like in free_iova_rcaches function,
> so that all rcaches can be completely released to try
> replenishing IOVAs.

OK, so either there's a mystery bug where IOVAs somehow get freed on 
offline CPUs, or the hotplug notifier isn't working correctly, or you've 
contrived a situation where alloc_iova_fast() is actually racing against 
iova_cpuhp_dead(). In the latter case, the solution is "don't do that".

This change should not be necessary.

Thanks,
Robin.

> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> Cc: <stable@vger.kernel.org> # 5.4.*
> ---
>   drivers/iommu/iova.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b28c9435b898..5a0637cd7bc2 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -460,7 +460,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>   
>   		/* Try replenishing IOVAs by flushing rcache. */
>   		flush_rcache = false;
> -		for_each_online_cpu(cpu)
> +		for_each_possible_cpu(cpu)
>   			free_cpu_cached_iovas(cpu, iovad);
>   		free_global_cached_iovas(iovad);
>   		goto retry;
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
