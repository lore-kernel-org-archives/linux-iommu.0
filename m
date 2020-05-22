Return-Path: <SRS0=4l6Q=7E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADEBC433E0
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 06:26:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E37920776
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 06:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="M6SW7EPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E37920776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 322EC881C0;
	Fri, 22 May 2020 06:26:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sE7h7ykdFE7M; Fri, 22 May 2020 06:26:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 57E0A880E6;
	Fri, 22 May 2020 06:26:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4169FC0863;
	Fri, 22 May 2020 06:26:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8AAAC0176
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 06:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C0BAA874D1
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 06:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JtWCo9bTNDFN for <iommu@lists.linux-foundation.org>;
 Fri, 22 May 2020 06:25:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F399086D3C
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 06:25:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1590128757; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=H359ESmKnUtSY7Q0hAO68B/54fVOQ0qzAvK2WHo9oz8=;
 b=M6SW7EPRsHVW7ewP85o79po+dac49fuSEBE878ClmG/YxX+TnH44dmjtvJ1d5dRb99P48Z0+
 FI/yCbKAw3rxnHLCFg0rTswDB/L5vxE+vVyLrw01E+7avpzP97Wd1dpS1/SpjaP13MhqiSyc
 iQejF3VGQZC139lMJp9hoV1Gdfw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec77069.7f67d8dc24c8-smtp-out-n04;
 Fri, 22 May 2020 06:25:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id C7E49C4339C; Fri, 22 May 2020 06:25:45 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: guptap)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id EB428C433C6;
 Fri, 22 May 2020 06:25:44 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 22 May 2020 11:55:44 +0530
From: guptap@codeaurora.org
To: Robin Murphy <robin.murphy@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH] iommu/dma: limit iova free size to unmmaped iova
In-Reply-To: <7aaa8dcc-6a47-f256-431d-2a1b034b4076@arm.com>
References: <20200521113004.12438-1-guptap@codeaurora.org>
 <7aaa8dcc-6a47-f256-431d-2a1b034b4076@arm.com>
Message-ID: <90662ef3123dbf2e93f9718ee5cc14a7@codeaurora.org>
X-Sender: guptap@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: mhocko@suse.com, owner-linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org
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

On 2020-05-22 01:46, Robin Murphy wrote:
> On 2020-05-21 12:30, Prakash Gupta wrote:
>> Limit the iova size while freeing based on unmapped size. In absence 
>> of
>> this even with unmap failure, invalid iova is pushed to iova rcache 
>> and
>> subsequently can cause panic while rcache magazine is freed.
> 
> Can you elaborate on that panic?
> 
We have seen couple of stability issues around this.
Below is one such example:

kernel BUG at kernel/msm-4.19/drivers/iommu/iova.c:904!
iova_magazine_free_pfns
iova_rcache_insert
free_iova_fast
__iommu_unmap_page
iommu_dma_unmap_page


It turned out an iova pfn 0 got into iova_rcache. One possibility I see 
is
where client unmap with invalid dma_addr. The unmap call will fail and 
warn on
and still try to free iova. This will cause invalid pfn to be inserted 
into
rcache. As and when the magazine with invalid pfn will be freed
private_find_iova() will return NULL for invalid iova and meet bug 
condition.

>> Signed-off-by: Prakash Gupta <guptap@codeaurora.org>
>> 
>> :100644 100644 4959f5df21bd 098f7d377e04 M	drivers/iommu/dma-iommu.c
>> 
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 4959f5df21bd..098f7d377e04 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -472,7 +472,8 @@ static void __iommu_dma_unmap(struct device *dev, 
>> dma_addr_t dma_addr,
>>     	if (!cookie->fq_domain)
>>   		iommu_tlb_sync(domain, &iotlb_gather);
>> -	iommu_dma_free_iova(cookie, dma_addr, size);
>> +	if (unmapped)
>> +		iommu_dma_free_iova(cookie, dma_addr, unmapped);
> 
> Frankly, if any part of the unmap fails then things have gone
> catastrophically wrong already, but either way this isn't right. The
> IOVA API doesn't support partial freeing - an IOVA *must* be freed
> with its original size, or not freed at all, otherwise it will corrupt
> the state of the rcaches and risk a cascade of further misbehaviour
> for future callers.
> 
I agree, we shouldn't be freeing the partial iova. Instead just making
sure if unmap was successful should be sufficient before freeing iova. 
So change
can instead be something like this:

-	iommu_dma_free_iova(cookie, dma_addr, size);
+	if (unmapped)
+		iommu_dma_free_iova(cookie, dma_addr, size);

> TBH my gut feeling here is that you're really just trying to treat a
> symptom of another bug elsewhere, namely some driver calling
> dma_unmap_* or dma_free_* with the wrong address or size in the first
> place.
> 
This condition would arise only if driver calling dma_unmap/free_* with 
0
iova_pfn. This will be flagged with a warning during unmap but will 
trigger
panic later on while doing unrelated dma_map/unmap_*. If unmapped has 
already
failed for invalid iova, there is no reason we should consider this as 
valid
iova and free. This part should be fixed.

On 2020-05-22 00:19, Andrew Morton wrote:
> I think we need a cc:stable here?
> 
Added now.

Thanks,
Prakash
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
