Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC1C433E7
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 07:31:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649172071B
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 07:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="b7MXfKlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649172071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2D82487CE1;
	Fri, 28 Aug 2020 07:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2q33fVqJ5i6B; Fri, 28 Aug 2020 07:31:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D709587D22;
	Fri, 28 Aug 2020 07:31:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C3BAC07FF;
	Fri, 28 Aug 2020 07:31:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E561BC0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 07:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D672F86D9C
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 07:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9E-Q3PFpW0-6 for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 07:31:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 975C0857BE
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 07:31:35 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1598599900; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ok6qYeTFJS9pQDEh8V4WjrEAxhk28wu/qsnprTATYWk=;
 b=b7MXfKlxuGOR8LdZhmEeUNCtCbMoPmHJxMoYIeHaxQ/Y8P5E6BA0yhQGiWXYnG6YPXIqNr5p
 IzR0oHZy0Y7izgXPDAMxJ0ZBWZzDrfkAX5lZDNYZGfh5vSpd6MT+XQ5uXZsQgaRLRx0053f2
 EDzQuJRj0+wSBdXx1yuKnT527UY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f48b2c4f4f3e6461301a694 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 07:31:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 51501C433CB; Fri, 28 Aug 2020 07:31:15 +0000 (UTC)
Received: from [192.168.0.104] (unknown [103.248.210.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A283CC433C6;
 Fri, 28 Aug 2020 07:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A283CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v2 1/2] iommu/iova: Retry from last rb tree node if iova
 search fails
To: joro@8bytes.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
From: Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <782f5dae-4ebc-02c8-5c83-4f7efda65c9d@codeaurora.org>
Date: Fri, 28 Aug 2020 13:01:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
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



On 8/20/2020 6:19 PM, vjitta@codeaurora.org wrote:
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
> ---
>  drivers/iommu/iova.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 49fc01f..4e77116 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -184,8 +184,9 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	struct rb_node *curr, *prev;
>  	struct iova *curr_iova;
>  	unsigned long flags;
> -	unsigned long new_pfn;
> +	unsigned long new_pfn, low_pfn_new;
>  	unsigned long align_mask = ~0UL;
> +	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
>  
>  	if (size_aligned)
>  		align_mask <<= fls_long(size - 1);
> @@ -198,15 +199,25 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  
>  	curr = __get_cached_rbnode(iovad, limit_pfn);
>  	curr_iova = rb_entry(curr, struct iova, node);
> +	low_pfn_new = curr_iova->pfn_hi + 1;
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
> +		if (low_pfn == iovad->start_pfn && low_pfn_new < limit_pfn) {
> +			high_pfn = limit_pfn;
> +			low_pfn = low_pfn_new;
> +			curr = &iovad->anchor.node;
> +			curr_iova = rb_entry(curr, struct iova, node);
> +			goto retry;
> +		}
>  		iovad->max32_alloc_size = size;
>  		goto iova32_full;
>  	}
> 

ping ?

Thanks,
Vijay
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
