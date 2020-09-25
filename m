Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA42C4727C
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 11:53:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C4921775
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 11:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C4921775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10AF486CBB;
	Fri, 25 Sep 2020 11:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ez7vrj5DTIiw; Fri, 25 Sep 2020 11:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2448086CB2;
	Fri, 25 Sep 2020 11:53:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3E5EC0859;
	Fri, 25 Sep 2020 11:53:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D87DC0051
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 11:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 810ED20435
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 11:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1LbKnT0GfkeI for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:53:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 09FF2203A8
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 11:53:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B57F101E;
 Fri, 25 Sep 2020 04:53:09 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A52A53F70D;
 Fri, 25 Sep 2020 04:53:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] iommu/iova: Flush CPU rcache for when a depot fills
To: John Garry <john.garry@huawei.com>, joro@8bytes.org
References: <1601027469-221812-1-git-send-email-john.garry@huawei.com>
 <1601027469-221812-2-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <bede311f-9a07-98e1-e728-9acd4ad13b51@arm.com>
Date: Fri, 25 Sep 2020 12:53:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1601027469-221812-2-git-send-email-john.garry@huawei.com>
Content-Language: en-GB
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, xiyou.wangcong@gmail.com
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

On 2020-09-25 10:51, John Garry wrote:
> Leizhen reported some time ago that IOVA performance may degrade over time
> [0], but unfortunately his solution to fix this problem was not given
> attention.
> 
> To summarize, the issue is that as time goes by, the CPU rcache and depot
> rcache continue to grow. As such, IOVA RB tree access time also continues
> to grow.
> 
> At a certain point, a depot may become full, and also some CPU rcaches may
> also be full when we try to insert another IOVA. For this scenario,
> currently we free the "loaded" CPU rcache and create a new one. This
> free'ing means that we need to free many IOVAs in the RB tree, which
> makes IO throughput performance fall off a cliff in our storage scenario:
> 
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6314MB/0KB/0KB /s] [1616K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [5669MB/0KB/0KB /s] [1451K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6673MB/0KB/0KB /s] [1708K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6761MB/0KB/0KB /s] [1731K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6685MB/0KB/0KB /s] [1711K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6178MB/0KB/0KB /s] [1582K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6731MB/0KB/0KB /s] [1723K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2387MB/0KB/0KB /s] [611K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2689MB/0KB/0KB /s] [688K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2278MB/0KB/0KB /s] [583K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1288MB/0KB/0KB /s] [330K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1632MB/0KB/0KB /s] [418K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1765MB/0KB/0KB /s] [452K/0/0 iops]
> 
> And continue in this fashion, without recovering. Note that in this
> example we had to wait 16 hours for this to occur. Also note that IO
> throughput also becomes gradually becomes more unstable leading up to this
> point.
> 
> As a solution this issue, we judge that the IOVA rcaches have grown too
> big, and just flush all the CPUs rcaches instead.
> 
> The depot rcaches, however, are not flushed, as they can be used to
> immediately replenish active CPUs.
> 
> In future, some IOVA rcache compaction could be implemented to solve the
> instabilty issue, which I figure could be quite complex to implement.
> 
> [0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/
> 
> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iova.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 45a251da5453..05e0b462e0d9 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -892,9 +892,8 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   				 struct iova_rcache *rcache,
>   				 unsigned long iova_pfn)
>   {
> -	struct iova_magazine *mag_to_free = NULL;
>   	struct iova_cpu_rcache *cpu_rcache;
> -	bool can_insert = false;
> +	bool can_insert = false, flush = false;
>   	unsigned long flags;
>   
>   	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
> @@ -913,13 +912,19 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
>   				rcache->depot[rcache->depot_size++] =
>   						cpu_rcache->loaded;
> +				can_insert = true;
> +				cpu_rcache->loaded = new_mag;
>   			} else {
> -				mag_to_free = cpu_rcache->loaded;
> +				/*
> +				 * The depot is full, meaning that a very large
> +				 * cache of IOVAs has built up, which slows
> +				 * down RB tree accesses significantly
> +				 * -> let's flush at this point.
> +				 */
> +				flush = true;
> +				iova_magazine_free(new_mag);
>   			}
>   			spin_unlock(&rcache->lock);
> -
> -			cpu_rcache->loaded = new_mag;
> -			can_insert = true;
>   		}
>   	}
>   
> @@ -928,9 +933,11 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   
>   	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>   
> -	if (mag_to_free) {
> -		iova_magazine_free_pfns(mag_to_free, iovad);
> -		iova_magazine_free(mag_to_free);
> +	if (flush) {

Do you really need this flag, or is it effectively just mirroring 
"!can_insert" - in theory if there wasn't enough memory to allocate a 
new magazine, then freeing some more IOVAs wouldn't necessarily be a bad 
thing to do anyway.

Other than that, I think this looks reasonable. Every time I look at 
__iova_rcache_insert() I'm convinced there must be a way to restructure 
it to be more streamlined overall, but I can never quite see exactly how...

Thanks,
Robin.

> +		int cpu;
> +
> +		for_each_online_cpu(cpu)
> +			free_cpu_cached_iovas(cpu, iovad);
>   	}
>   
>   	return can_insert;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
