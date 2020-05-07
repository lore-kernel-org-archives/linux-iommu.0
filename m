Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3933AC38A24
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 18:22:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0184721473
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 18:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r83N9YXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0184721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C31DA894EC;
	Thu,  7 May 2020 18:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bgtnl32SAJ7I; Thu,  7 May 2020 18:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7D54C89393;
	Thu,  7 May 2020 18:22:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F18DC0865;
	Thu,  7 May 2020 18:22:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5806C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 18:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A30C620460
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 18:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w7bD+8JVqHaU for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 18:22:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com
 [209.85.219.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 1AA61203AC
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 18:22:14 +0000 (UTC)
Received: by mail-yb1-f194.google.com with SMTP id i16so3406200ybq.9
 for <iommu@lists.linux-foundation.org>; Thu, 07 May 2020 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Hio9A8K2n+RsdYoc8pl4frI4S8NgtDDOmOIDiCLHFEg=;
 b=r83N9YXNHAuysfUCfvdi8Rl5DkYgLHkygL38sXx7PdanrqM5Lnz7xMFP85L4IbZCoi
 vCyj3Pl++/OcRr0eTL0YpewVfULtTz5to5XRjmXnOAmKmcIPNGdxUdhWDEn2382KDGWo
 f2uN10wq86ASCiOn1IVDTVnUvLF8VMzW3K0NrfRT2+nDaYUI+coSWuaLXUXRZdz5xcRU
 dL+SMJaFxZjMNS6kr5Jytapxopu2rlnWRCIHTYbAWxUyuoX4ndxHD2pqvVAz9KDU5Ng+
 zlcdQ7riCkAtGifkj4MT3XGpPUyT9YxVyZVOHL37IzTh0gQOsy9dd8Ti5XG+XlrKuzIJ
 HxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Hio9A8K2n+RsdYoc8pl4frI4S8NgtDDOmOIDiCLHFEg=;
 b=T+oKDnP2Zx0z8JT1piLnzwzkuH2gcA5KkGJAx3cipKf1vnTj2hK/tU4IgLiWqG4R2u
 irJpMYbS/zl72p9fN/NYBxZ+8sOCDCLZqFs0q4oTQvoWkie9zQ3dZrsGjO78Ek36khWz
 PXdOkO8syCuFHPVv3f899l+edpqFD2ooWPuK6t7xtAWlpRSNKmiAry054VpG8UMfGzRs
 F4xWvdu66JJ49Jzu7XFnKi4ULfh6RQ8PzAzk81hwPs+S/QEgBHhsu1puK4SmHeB5FGjk
 R9h4v6G7g0OvSRiZtK1YWpqhfCN+GYfYL4wMVYzxvEifwDBJFNy7qrsNe0L9P5BasX67
 zKCQ==
X-Gm-Message-State: AGi0PuZl+dqLUUSF/xGJX5SMheVwxn0O/PSUlhN+Jz04R4QrZGKps90a
 i4/hgeyQQ9O91qYq4TZVAG3urkIpOy7dJW048KM=
X-Google-Smtp-Source: APiQypIpqQ8vVP8B2JUA91YqyMOOXv9lkR2FYk7SR9OMY5dPNlw5NaEr/FYdVE0cOqUKpvZDkh2vyZCqwiGHpQ8RFXo=
X-Received: by 2002:a25:5081:: with SMTP id e123mr24424676ybb.48.1588875732811; 
 Thu, 07 May 2020 11:22:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6900:26b:0:0:0:0 with HTTP; Thu, 7 May 2020 11:22:12
 -0700 (PDT)
In-Reply-To: <d9bfde9f-8f16-bf1b-311b-ea6c2b8ab93d@arm.com>
References: <1588795317-20879-1-git-send-email-vjitta@codeaurora.org>
 <d9bfde9f-8f16-bf1b-311b-ea6c2b8ab93d@arm.com>
From: Ajay kumar <ajaynumb@gmail.com>
Date: Thu, 7 May 2020 23:52:12 +0530
Message-ID: <CAEC9eQMKc0dK9jGqOjeOQ3LT0fkJtYjgScb+ZF6MNagLERC7Jw@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: Retry from last rb tree node if iova search
 fails
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 vinmenon@codeaurora.org, vjitta@codeaurora.org, kernel-team@android.com
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

On 5/7/20, Robin Murphy <robin.murphy@arm.com> wrote:
> On 2020-05-06 9:01 pm, vjitta@codeaurora.org wrote:
>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>
>> When ever a new iova alloc request comes iova is always searched
>> from the cached node and the nodes which are previous to cached
>> node. So, even if there is free iova space available in the nodes
>> which are next to the cached node iova allocation can still fail
>> because of this approach.
>>
>> Consider the following sequence of iova alloc and frees on
>> 1GB of iova space
>>
>> 1) alloc - 500MB
>> 2) alloc - 12MB
>> 3) alloc - 499MB
>> 4) free -  12MB which was allocated in step 2
>> 5) alloc - 13MB
>>
>> After the above sequence we will have 12MB of free iova space and
>> cached node will be pointing to the iova pfn of last alloc of 13MB
>> which will be the lowest iova pfn of that iova space. Now if we get an
>> alloc request of 2MB we just search from cached node and then look
>> for lower iova pfn's for free iova and as they aren't any, iova alloc
>> fails though there is 12MB of free iova space.
>
> Yup, this could definitely do with improving. Unfortunately I think this
> particular implementation is slightly flawed...
>
>> To avoid such iova search failures do a retry from the last rb tree node
>> when iova search fails, this will search the entire tree and get an iova
>> if its available
>>
>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>> ---
>>   drivers/iommu/iova.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 0e6a953..2985222 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -186,6 +186,7 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>   	unsigned long flags;
>>   	unsigned long new_pfn;
>>   	unsigned long align_mask = ~0UL;
>> +	bool retry = false;
>>
>>   	if (size_aligned)
>>   		align_mask <<= fls_long(size - 1);
>> @@ -198,6 +199,8 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>
>>   	curr = __get_cached_rbnode(iovad, limit_pfn);
>>   	curr_iova = rb_entry(curr, struct iova, node);
>> +
>> +retry_search:
>>   	do {
>>   		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
>>   		new_pfn = (limit_pfn - size) & align_mask;
>> @@ -207,6 +210,14 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>   	} while (curr && new_pfn <= curr_iova->pfn_hi);
>>
>>   	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
>> +		if (!retry) {
>> +			curr = rb_last(&iovad->rbroot);
>
> Why walk when there's an anchor node there already? However...
+1
>
>> +			curr_iova = rb_entry(curr, struct iova, node);
>> +			limit_pfn = curr_iova->pfn_lo;
>
> ...this doesn't look right, as by now we've lost the original limit_pfn
> supplied by the caller, so are highly likely to allocate beyond the
> range our caller asked for. In fact AFAICS we'd start allocating from
> directly directly below the anchor node, beyond the end of the entire
> address space.
+1
>
> The logic I was imagining we want here was something like the rapidly
> hacked up (and untested) diff below.
>
> Thanks,
> Robin.
>
> ----->8-----
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 0e6a9536eca6..3574c19272d6 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -186,6 +186,7 @@ static int __alloc_and_insert_iova_range(struct
> iova_domain *iovad,
>          unsigned long flags;
>          unsigned long new_pfn;
>          unsigned long align_mask = ~0UL;
> +       unsigned long alloc_hi, alloc_lo;
>
>          if (size_aligned)
>                  align_mask <<= fls_long(size - 1);
> @@ -196,17 +197,27 @@ static int __alloc_and_insert_iova_range(struct
> iova_domain *iovad,
>                          size >= iovad->max32_alloc_size)
>                  goto iova32_full;
>
> +       alloc_hi = IOVA_ANCHOR;
> +       alloc_lo = iovad->start_pfn;
> +retry:
>          curr = __get_cached_rbnode(iovad, limit_pfn);
>          curr_iova = rb_entry(curr, struct iova, node);
> +       if (alloc_hi < curr_iova->pfn_hi) {
> +               alloc_lo = curr_iova->pfn_hi;
> +               alloc_hi = limit_pfn;
> +       }
> +
>          do {
> -               limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
> -               new_pfn = (limit_pfn - size) & align_mask;
> +               alloc_hi = min(alloc_hi, curr_iova->pfn_lo);
During retry case, the curr and curr_iova is not updated. Kindly check it.

Ajay
> +               new_pfn = (alloc_hi - size) & align_mask;
>                  prev = curr;
>                  curr = rb_prev(curr);
>                  curr_iova = rb_entry(curr, struct iova, node);
>          } while (curr && new_pfn <= curr_iova->pfn_hi);
>
> -       if (limit_pfn < size || new_pfn < iovad->start_pfn) {
> +       if (limit_pfn < size || new_pfn < alloc_lo) {
> +               if (alloc_lo == iovad->start_pfn)
> +                       goto retry;
>                  iovad->max32_alloc_size = size;
>                  goto iova32_full;
>          }
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
