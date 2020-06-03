Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1218BC433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 07:37:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A327D2074B
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 07:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ea0BvGOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A327D2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 615A287FB6;
	Wed,  3 Jun 2020 07:37:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NvHhdC3ram1Z; Wed,  3 Jun 2020 07:37:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 93EA785044;
	Wed,  3 Jun 2020 07:37:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7787EC0888;
	Wed,  3 Jun 2020 07:37:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE009C016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 07:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A27982044F
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 07:37:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IkIr10ZnRpB0 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 07:37:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by silver.osuosl.org (Postfix) with ESMTPS id 281A4203FE
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 07:37:18 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1591169841; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=aJvFtRy1el1NP+Z5+87GQ+m2nk+T28gjost9JU7AaP0=;
 b=Ea0BvGOXeOoJebfUPZGumI/9V0/07jxC8ZWrfUx8h5zrS8uUEKq2W5sWUFOjdmZA3KePqb3b
 sF2HT76dKIwY4F7ml16I6DBKgDZr5EBSrfFX4hrWAz9mam8+6aR4LntxS6ub9vpu0NT52+aW
 nyoR3POV6uF5QVWR0d4WILscgcI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5ed753262dd9e15ae3ab143e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Jun 2020 07:37:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 9A19AC43391; Wed,  3 Jun 2020 07:37:09 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: guptap)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D600BC433CA;
 Wed,  3 Jun 2020 07:37:08 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 03 Jun 2020 13:07:08 +0530
From: guptap@codeaurora.org
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: limit iova free size to unmmaped iova
In-Reply-To: <9b5f8501-6e6e-0cd2-7f98-7cfea13051d7@arm.com>
References: <20200521113004.12438-1-guptap@codeaurora.org>
 <7aaa8dcc-6a47-f256-431d-2a1b034b4076@arm.com>
 <90662ef3123dbf2e93f9718ee5cc14a7@codeaurora.org>
 <2d873ab9-ebb9-3c2d-f129-55a036ab47d0@arm.com>
 <4ba082d3bb965524157704ea1ffb1ff4@codeaurora.org>
 <9b5f8501-6e6e-0cd2-7f98-7cfea13051d7@arm.com>
Message-ID: <4b6a864674a9231b3ac35e5ce0c7292f@codeaurora.org>
X-Sender: guptap@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: mhocko@suse.com, owner-linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>
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

On 2020-06-02 18:37, Robin Murphy wrote:
> On 2020-05-26 08:19, guptap@codeaurora.org wrote:
>> On 2020-05-22 14:54, Robin Murphy wrote:
>>> On 2020-05-22 07:25, guptap@codeaurora.org wrote:
>>>> On 2020-05-22 01:46, Robin Murphy wrote:
>>>>> On 2020-05-21 12:30, Prakash Gupta wrote:
>> Sorry for delayed response, it was a long weekend.
>> I agree that invalid DMA API call can result in unexpected issues and 
>> client
>> should fix it, but then the present behavior makes it difficult to 
>> catch cases
>> when driver is making wrong DMA API calls. When invalid iova pfn is 
>> passed it
>> doesn't fail then and there, though DMA layer is aware of iova being 
>> invalid. It
>> fails much after that in the context of an valid map/unmap, with 
>> BUG_ON().
>> 
>> Downgrading BUG_ON() to WARN_ON() in iova_magazine_free_pfns() will 
>> not help
>> much as invalid iova will cause NULL pointer dereference.
> 
> Obviously I didn't mean a literal s/BUG/WARN/ substitution - some
> additional control flow to actually handle the error case was implied.
> 
> I'll write up the patch myself, since it's easier than further 
> debating.
> 

I think it will address the issue I am facing as well. I will wait for 
your patch.

>> I see no reason why DMA layer wants to free an iova for which unmapped 
>> failed.
>> IMHO queuing an invalid iova (which already failed unmap) to rcache 
>> which
>> eventually going to crash the system looks like iommu-dma layer issue.
> 
> What if the unmap fails because the address range is already entirely
> unmapped? Freeing the IOVA (or at least attempting to) would be
> logically appropriate in that case. In fact some IOMMU drivers might
> not even consider that a failure, so the DMA layer may not even be
> aware that it's been handed a bogus unallocated address.
> 
> The point is that unmapping *doesn't* fail under normal and correct
> operation, so the DMA layer should not expect to have to handle it.
> Even if it does happen, that's a highly exceptional case that the DMA
> layer cannot recover from by itself; at best it can just push the
> problem elsewhere. It's pretty hard to justify doing extra work to
> simply move an exceptional problem around without really addressing
> it.
> 

iommu_unmap() expects that all areas within unmap size are mapped. 
infact It
abandons further unmap if it find any chunk not mapped.  So if an IOMMU
implementation is not returning failure for already unmapped area,
then it's prone to issue where DMA API reuse the IOVA, which is already 
mapped.

In this case where iommu implementation returns error for already 
unmapped area,
currently there is no way to distinguish an unmap failure due to range 
already
unmapped or say while partially unmapping a section map, memory 
allocation fails
and thus unmap returns failure.
In second case, we will free the iova even with mapping present. And 
subsequent
dma mapping will keep on failing if it uses this freed iova. For managed 
iova
both unmap/map should be done with dma APIs, it should be safe to expect 
if a
range is unmapped with DMA APIs corresponding iova is also freed, so 
there
shouldn't be a real need to free iova where unmap fails due to range 
already
entirely unmapped.

> And in this particular case, personally I would *much* rather see
> warnings spewing from both the pagetable and IOVA code as early as
> possible to clearly indicate that the DMA layer itself has been thrown
> out of sync, than just have warnings that might represent some other
> source of pagetable corruption (or at worst, depending on the
> pagetable code, no warnings at all and only have dma_map_*() calls
> quietly start failing much, much later due to all the IOVA space
> having been leaked by bad unmaps).
> 

I am not sure how useful is this freed iova if corresponding mappings 
are not
unmapped. We won't be able to use those iova. The subsequent iommu_map 
will fail
if using this freed iova. So it's important to ensure we only free iova 
which is
unmapped successfully.

Thanks,
Prakash
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
