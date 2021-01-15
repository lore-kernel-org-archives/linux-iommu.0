Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E18C433DB
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 17:32:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E7A206D4
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 17:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E7A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4784E87360;
	Fri, 15 Jan 2021 17:32:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x1RebEPCWi11; Fri, 15 Jan 2021 17:32:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C23F872D4;
	Fri, 15 Jan 2021 17:32:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 257F7C088B;
	Fri, 15 Jan 2021 17:32:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBA3AC013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 17:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D0F7C86CFB
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 17:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JvTUs3V+9rE2 for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 17:32:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 658FD86CF9
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 17:32:06 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id g10so8286322wmh.2
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 09:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oqv7QfAT5DV1oDIfe2USMaVgNotzEPUcDQhlXDEIEFM=;
 b=tA0U7STuqJQUC6bVDAU+1tXQBPtKRxaDrnrV3RiBkr1xjjQvghZpIegxyTvyC+ZHo2
 D+aTy3/XYFVj9yALy8tD/4DBZO3733PxQGULqpcEfDdldLum+Yr3SqUpqdkQMG7C4hp+
 T1aBMK3dTnsyvWALdO2zK9LNISK3VBs5+KSCpi5+a50mKLKe5E2MbVzOXt6Y7JbKHRpE
 ix5xhGzoYzO/BM28Vp1UrRcNJBIRJRXxAlZXCRBtE551CteQg0wasrQajVM5gdY9DHvH
 Vt7f6mxi7cuco9irVMI3aU0CKAili3fvSzOJQdBNCsIRQSjzVyitWvG/kmUJQf9pr3q4
 SCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oqv7QfAT5DV1oDIfe2USMaVgNotzEPUcDQhlXDEIEFM=;
 b=FQ0+7yltg1dBkC/dBibDChVHtigbu9DfGnrxn4CjN1F/dqkXDUm6kbkouTIXwD36em
 lah/zxkfkIQVm/C1hXeA0xZxIejJ62gLtE38kUc6RmzEynOXV1U0DbKm2qmEUmvSxG7F
 ghsUJg1iWtDV8SvHR2I/M9ywQFgbtUmV2OLUvBpxXYL9H5yP7P2evYR/rNm0hLTtiAB8
 2oLWkx6tWo6u5KqOPtSPZ3t4rqdoGIZJK9KRGGdPJhgmUmK+vgKKZ16XPFd0CKbMV2FF
 OeKqDUCNqGSrCpp70l0B8n9AmRQmkjQ8pbd7taewoIFhX3PdktlNQg1kElOlxUG7eEXv
 WDQQ==
X-Gm-Message-State: AOAM5329ieschV6mOSigA6d0gAy1PNPYF9MQgxbNUV9YnyNJoORf3XOR
 rLTIbuQb3m9F0nH/ydT78MfaVQ==
X-Google-Smtp-Source: ABdhPJwMBg+tI2QTs3jPXfHCQqY9HkrW2RbjXihxLuD3aDagCLJVMbSLR90NBqXSVgL1B+J6Tdv19Q==
X-Received: by 2002:a05:600c:2158:: with SMTP id
 v24mr9484177wml.129.1610731924845; 
 Fri, 15 Jan 2021 09:32:04 -0800 (PST)
Received: from larix.localdomain ([2001:1715:4e26:a7e0:ed35:e18a:5e36:8c84])
 by smtp.gmail.com with ESMTPSA id v7sm13689605wma.26.2021.01.15.09.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 09:32:04 -0800 (PST)
Date: Fri, 15 Jan 2021 18:32:49 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v4 3/3] iommu/iova: Flush CPU rcache for when a depot fills
Message-ID: <YAHRwZXoRZFJkgE8@larix.localdomain>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1607538189-237944-4-git-send-email-john.garry@huawei.com>
Cc: will@kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Thu, Dec 10, 2020 at 02:23:09AM +0800, John Garry wrote:
> Leizhen reported some time ago that IOVA performance may degrade over time
> [0], but unfortunately his solution to fix this problem was not given
> attention.
> 
> To summarize, the issue is that as time goes by, the CPU rcache and depot
> rcache continue to grow. As such, IOVA RB tree access time also continues
> to grow.
> 
> At a certain point, a depot may become full, and also some CPU rcaches may
> also be full when inserting another IOVA is attempted. For this scenario,
> currently the "loaded" CPU rcache is freed and a new one is created. This
> freeing means that many IOVAs in the RB tree need to be freed, which
> makes IO throughput performance fall off a cliff in some storage scenarios:
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
> example it was required to wait 16 hours for this to occur. Also note that
> IO throughput also becomes gradually becomes more unstable leading up to
> this point.
> 
> This problem is only seen for non-strict mode. For strict mode, the rcaches
> stay quite compact.

It would be good to understand why the rcache doesn't stabilize. Could be
a bug, or just need some tuning

In strict mode, if a driver does Alloc-Free-Alloc and the first alloc
misses the rcache, the second allocation hits it. The same sequence in
non-strict mode misses the cache twice, because the IOVA is added to the
flush queue on Free. 

So rather than AFAFAF.. we get AAA..FFF.., only once the fq_timer triggers
or the FQ is full. Interestingly the FQ size is 2x IOVA_MAG_SIZE, so we
could allocate 2 magazines worth of fresh IOVAs before alloc starts
hitting the cache. If a job allocates more than that, some magazines are
going to the depot, and with multi-CPU jobs those will get used on other
CPUs during the next alloc bursts, causing the progressive increase in
rcache consumption. I wonder if setting IOVA_MAG_SIZE > IOVA_FQ_SIZE helps
reuse of IOVAs?

Then again I haven't worked out the details, might be entirely wrong. I'll
have another look next week.

Thanks,
Jean

> As a solution to this issue, judge that the IOVA caches have grown too big
> when cached magazines need to be free, and just flush all the CPUs rcaches
> instead.
> 
> The depot rcaches, however, are not flushed, as they can be used to
> immediately replenish active CPUs.
> 
> In future, some IOVA compaction could be implemented to solve the
> instability issue, which I figure could be quite complex to implement.
> 
> [0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/
> 
> Analyzed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/iova.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 732ee687e0e2..39b7488de8bb 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -841,7 +841,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>  				 struct iova_rcache *rcache,
>  				 unsigned long iova_pfn)
>  {
> -	struct iova_magazine *mag_to_free = NULL;
>  	struct iova_cpu_rcache *cpu_rcache;
>  	bool can_insert = false;
>  	unsigned long flags;
> @@ -863,13 +862,12 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>  				if (cpu_rcache->loaded)
>  					rcache->depot[rcache->depot_size++] =
>  							cpu_rcache->loaded;
> -			} else {
> -				mag_to_free = cpu_rcache->loaded;
> +				can_insert = true;
> +				cpu_rcache->loaded = new_mag;
>  			}
>  			spin_unlock(&rcache->lock);
> -
> -			cpu_rcache->loaded = new_mag;
> -			can_insert = true;
> +			if (!can_insert)
> +				iova_magazine_free(new_mag);
>  		}
>  	}
>  
> @@ -878,10 +876,8 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>  
>  	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>  
> -	if (mag_to_free) {
> -		iova_magazine_free_pfns(mag_to_free, iovad);
> -		iova_magazine_free(mag_to_free);
> -	}
> +	if (!can_insert)
> +		free_all_cpu_cached_iovas(iovad);
>  
>  	return can_insert;
>  }
> -- 
> 2.26.2
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
