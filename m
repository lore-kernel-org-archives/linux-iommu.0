Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E892C433E0
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 05:19:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093E0207D8
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 05:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WbXWYfJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093E0207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C05EF85230;
	Tue, 26 May 2020 05:19:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8lwh7+1e0AND; Tue, 26 May 2020 05:19:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D6EF48507B;
	Tue, 26 May 2020 05:19:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC755C0888;
	Tue, 26 May 2020 05:19:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B2F6C016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 05:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0219285230
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 05:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L3ohBW7uL5nR for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 05:19:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 286248507B
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 05:19:25 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1590470367; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ohp+JgoF6ma7SmGrp8A76s29bGP0dhSRyUxWeLQkWYM=;
 b=WbXWYfJUcWT9j/X4kAJbRl3j/mGRyOAAgO2yVTIVUk1ii8I6otdM6TTJirlxTtuKYBPMRmE/
 F6PZzox9JDiY5rYPBE+hLMs3SrGaFbmlInGYUoTnElz4l2wiD1tNO+R7nlikifLXi1Lbaf/J
 hPsNyZ4MUIiZPkFhrxhuA0rkZnE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ecca6d1.7f59c71b5f80-smtp-out-n02;
 Tue, 26 May 2020 05:19:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 324EAC43395; Tue, 26 May 2020 05:19:13 +0000 (UTC)
Received: from [192.168.0.104] (unknown [103.248.210.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id AF95FC433C6;
 Tue, 26 May 2020 05:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF95FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v2] iommu/iova: Retry from last rb tree node if iova
 search fails
To: joro@8bytes.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <1589195093-17129-1-git-send-email-vjitta@codeaurora.org>
From: Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <00e03593-cc31-4af5-470f-da717781fa9b@codeaurora.org>
Date: Tue, 26 May 2020 10:48:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589195093-17129-1-git-send-email-vjitta@codeaurora.org>
Content-Language: en-GB
Cc: kernel-team@android.com, vinmenon@codeaurora.org, robin.murphy@arm.com
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



On 5/11/2020 4:34 PM, vjitta@codeaurora.org wrote:
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
> if its available
> 
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> ---
>  drivers/iommu/iova.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 0e6a953..7d82afc 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -184,8 +184,9 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	struct rb_node *curr, *prev;
>  	struct iova *curr_iova;
>  	unsigned long flags;
> -	unsigned long new_pfn;
> +	unsigned long new_pfn, alloc_lo_new;
>  	unsigned long align_mask = ~0UL;
> +	unsigned long alloc_hi = limit_pfn, alloc_lo = iovad->start_pfn;
>  
>  	if (size_aligned)
>  		align_mask <<= fls_long(size - 1);
> @@ -198,15 +199,25 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  
>  	curr = __get_cached_rbnode(iovad, limit_pfn);
>  	curr_iova = rb_entry(curr, struct iova, node);
> +	alloc_lo_new = curr_iova->pfn_hi;
> +
> +retry:
>  	do {
> -		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
> -		new_pfn = (limit_pfn - size) & align_mask;
> +		alloc_hi = min(alloc_hi, curr_iova->pfn_lo);
> +		new_pfn = (alloc_hi - size) & align_mask;
>  		prev = curr;
>  		curr = rb_prev(curr);
>  		curr_iova = rb_entry(curr, struct iova, node);
>  	} while (curr && new_pfn <= curr_iova->pfn_hi);
>  
> -	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
> +	if (alloc_hi < size || new_pfn < alloc_lo) {
> +		if (alloc_lo == iovad->start_pfn && alloc_lo_new < limit_pfn) {
> +			alloc_hi = limit_pfn;
> +			alloc_lo = alloc_lo_new;
> +			curr = &iovad->anchor.node;
> +			curr_iova = rb_entry(curr, struct iova, node);
> +			goto retry;
> +		}
>  		iovad->max32_alloc_size = size;
>  		goto iova32_full;
>  	}
> 

ping?
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
