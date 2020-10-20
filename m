Return-Path: <SRS0=/c0m=D3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD757C433E7
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 09:18:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F2B222C8
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 09:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lzOnIbEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F2B222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 773AA86C88;
	Tue, 20 Oct 2020 09:18:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4jtFAbxz9+4h; Tue, 20 Oct 2020 09:18:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7F5B886CA6;
	Tue, 20 Oct 2020 09:18:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 611D1C088B;
	Tue, 20 Oct 2020 09:18:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84391C0051
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 09:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 657F387203
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 09:18:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AMroBXe6So3Y for <iommu@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 09:18:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 61C11871D2
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 09:18:07 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1603185491; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=fRpg67/kQgrcOOelRNUriikxCORsSNuzcjvbqGQ2QS8=;
 b=lzOnIbEy/LX/ZsvG+VPN2Dwpq5asfgnwkugRTzFOrHy/0hnK+DXZBi1+RYtuw4Y/U6NAK4wa
 n3TMztaGKZy5HX6APegH36ZYPiEMaU1E7zdnk4rQwjYmv38YwVZ21DpzNSpUKNQLH0QhIp5c
 ync8TZh1h77GPALt2tKf5P3rGp0=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f8eab2b4f8cc67c3124cfb8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Oct 2020 09:17:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 0F1C9C43387; Tue, 20 Oct 2020 09:17:30 +0000 (UTC)
Received: from [192.168.0.103] (unknown [106.0.37.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 24665C433CB;
 Tue, 20 Oct 2020 09:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24665C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v5 1/2] iommu/iova: Retry from last rb tree node if iova
 search fails
To: joro@8bytes.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
From: Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <7705f57b-54d1-9c0a-2d41-c1309b0e7168@codeaurora.org>
Date: Tue, 20 Oct 2020 14:47:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
Content-Language: en-GB
Cc: robin.murphy@arm.com, vinmenon@codeaurora.org, kernel-team@android.com
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



On 9/30/2020 1:14 PM, vjitta@codeaurora.org wrote:
> From: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> When ever a new iova alloc request comes iova is always searched
> from the cached node and the nodes which are previous to cached
> node. So, even if there is free iova space available in the nodes
> which are next to the cached node iova allocation can still fail
> because of this approach.
> 
> Consider the following sequence of iova alloc and frees on
> 1GB of iova space
> 
> 1) alloc - 500MB
> 2) alloc - 12MB
> 3) alloc - 499MB
> 4) free -  12MB which was allocated in step 2
> 5) alloc - 13MB
> 
> After the above sequence we will have 12MB of free iova space and
> cached node will be pointing to the iova pfn of last alloc of 13MB
> which will be the lowest iova pfn of that iova space. Now if we get an
> alloc request of 2MB we just search from cached node and then look
> for lower iova pfn's for free iova and as they aren't any, iova alloc
> fails though there is 12MB of free iova space.
> 
> To avoid such iova search failures do a retry from the last rb tree node
> when iova search fails, this will search the entire tree and get an iova
> if its available.
> 
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iova.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 30d969a..c3a1a8e 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -184,8 +184,9 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	struct rb_node *curr, *prev;
>  	struct iova *curr_iova;
>  	unsigned long flags;
> -	unsigned long new_pfn;
> +	unsigned long new_pfn, retry_pfn;
>  	unsigned long align_mask = ~0UL;
> +	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
>  
>  	if (size_aligned)
>  		align_mask <<= fls_long(size - 1);
> @@ -198,15 +199,25 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  
>  	curr = __get_cached_rbnode(iovad, limit_pfn);
>  	curr_iova = rb_entry(curr, struct iova, node);
> +	retry_pfn = curr_iova->pfn_hi + 1;
> +
> +retry:
>  	do {
> -		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
> -		new_pfn = (limit_pfn - size) & align_mask;
> +		high_pfn = min(high_pfn, curr_iova->pfn_lo);
> +		new_pfn = (high_pfn - size) & align_mask;
>  		prev = curr;
>  		curr = rb_prev(curr);
>  		curr_iova = rb_entry(curr, struct iova, node);
> -	} while (curr && new_pfn <= curr_iova->pfn_hi);
> -
> -	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
> +	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
> +
> +	if (high_pfn < size || new_pfn < low_pfn) {
> +		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
> +			high_pfn = limit_pfn;
> +			low_pfn = retry_pfn;
> +			curr = &iovad->anchor.node;
> +			curr_iova = rb_entry(curr, struct iova, node);
> +			goto retry;
> +		}
>  		iovad->max32_alloc_size = size;
>  		goto iova32_full;
>  	}
> 

Gentle ping.

Thanks,
Vijay
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
