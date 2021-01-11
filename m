Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2677BC433E0
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 04:56:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE39225A9
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 04:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE39225A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E22986BC1;
	Mon, 11 Jan 2021 04:56:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U6lrW-hc38Ye; Mon, 11 Jan 2021 04:56:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8FBB986361;
	Mon, 11 Jan 2021 04:56:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7864DC088B;
	Mon, 11 Jan 2021 04:56:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77A0AC013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 04:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5D1DD863E0
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 04:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3J-co5FM7hL9 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 04:56:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from so254-31.mailgun.net (so254-31.mailgun.net [198.61.254.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5515286361
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 04:56:50 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1610341012; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jYkO7dbOgBg1/0RRjemneHKpWx/1hw2rJ9cPf6v85BA=;
 b=pJ8DCNCNzF9xrsv6ArZ8p8jQn4Z2sNseKaQZWNA/W8gPjOAaMlSJdKU0+IPOYvp2+OlG/mDp
 w+cxhnrg+b6itrE/+rGGDWs0CVLPF7KdxKXYsdCRGAeXsIe/a+tnm8DS06PB5vQp/m4IGgMZ
 zOVy2FsJ8DXaAWuqKyVAmbz6UUc=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ffbda83f1be2d22c4e84cdc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 04:56:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 3FDA5C43461; Mon, 11 Jan 2021 04:56:34 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A2DEC433C6;
 Mon, 11 Jan 2021 04:56:32 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 11 Jan 2021 10:26:32 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Allow non-coherent masters to use
 system cache
In-Reply-To: <20210108181830.GA5457@willie-the-truck>
References: <20201224064007.2339-1-saiprakash.ranjan@codeaurora.org>
 <20210106115615.GA1763@willie-the-truck>
 <cfced52002337025088a64aa159760b2@codeaurora.org>
 <8cfefbff135a5287d177b6ab2ccc3304@codeaurora.org>
 <20210108181830.GA5457@willie-the-truck>
Message-ID: <3a776219db9f1256133920d52f864792@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: isaacm@codeaurora.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On 2021-01-08 23:48, Will Deacon wrote:
> On Fri, Jan 08, 2021 at 11:17:25AM +0530, Sai Prakash Ranjan wrote:
>> On 2021-01-07 22:27, isaacm@codeaurora.org wrote:
>> > On 2021-01-06 03:56, Will Deacon wrote:
>> > > On Thu, Dec 24, 2020 at 12:10:07PM +0530, Sai Prakash Ranjan wrote:
>> > > > commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY
>> > > > flag")
>> > > > removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
>> > > > the memory type setting required for the non-coherent masters to use
>> > > > system cache. Now that system cache support for GPU is added, we will
>> > > > need to mark the memory as normal sys-cached for GPU to use
>> > > > system cache.
>> > > > Without this, the system cache lines are not allocated for GPU.
>> > > > We use
>> > > > the IO_PGTABLE_QUIRK_ARM_OUTER_WBWA quirk instead of a page
>> > > > protection
>> > > > flag as the flag cannot be exposed via DMA api because of no in-tree
>> > > > users.
>> > > >
>> > > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> > > > ---
>> > > >  drivers/iommu/io-pgtable-arm.c | 3 +++
>> > > >  1 file changed, 3 insertions(+)
>> > > >
>> > > > diff --git a/drivers/iommu/io-pgtable-arm.c
>> > > > b/drivers/iommu/io-pgtable-arm.c
>> > > > index 7c9ea9d7874a..3fb7de8304a2 100644
>> > > > --- a/drivers/iommu/io-pgtable-arm.c
>> > > > +++ b/drivers/iommu/io-pgtable-arm.c
>> > > > @@ -415,6 +415,9 @@ static arm_lpae_iopte
>> > > > arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>> > > >  		else if (prot & IOMMU_CACHE)
>> > > >  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>> > > >  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>> > > > +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
>> > > > +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
>> > > > +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>> > > >  	}
>> > >
>> > While this approach of enabling system cache globally for both page
>> > tables and other buffers
>> > works for the GPU usecase, this isn't ideal for other clients that use
>> > system cache. For example,
>> > video clients only want to cache a subset of their buffers in the
>> > system cache, due to the sizing constraint
>> > imposed by how much of the system cache they can use. So, it would be
>> > ideal to have
>> > a way of expressing the desire to use the system cache on a per-buffer
>> > basis. Additionally,
>> > our video clients use the DMA layer, and since the requirement is for
>> > caching in the system cache
>> > to be a per buffer attribute, it seems like we would have to have a
>> > DMA attribute to express
>> > this on a per-buffer basis.
>> >
>> 
>> I did bring this up initially [1], also where is this video client
>> in upstream? AFAIK, only system cache user in upstream is GPU.
>> We cannot add any DMA attribute unless there is any user upstream
>> as per [2], so when the support for such a client is added, wouldn't
>> ((data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA) || 
>> PROT_FLAG)
>> work?
> 
> Hmm, I think this is another case where we need to separate out the
> page-table walker attributes from the access attributes. Currently,
> IO_PGTABLE_QUIRK_ARM_OUTER_WBWA applies _only_ to the page-table walker
> and I don't think it makes any sense for that to be per-buffer (how 
> would
> you even manage that?). However, if we want to extend this to data 
> accesses
> and we know that there are valid use-cases where this should be 
> per-buffer,
> then shoe-horning it in with the walker quirk does not feel like the 
> best
> thing to do.
> 
> As a starting point, we could:
> 
>   1. Rename IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to IO_PGTABLE_QUIRK_PTW_LLC
>   2. Add a new prot flag IOMMU_LLC
>   3. Have the GPU pass the new prot for its buffer mappings
> 

This looks good to me, I will work on this and post something soon.

> Does that work? One thing I'm not sure about is whether IOMMU_CACHE 
> should
> imply IOMMU_LLC, or whether there is a use-case for inner-cacheable, 
> outer
> non-cacheable mappings for a coherent device. Have you ever seen that 
> sort
> of thing before?
> 

I don't think there is such a usecase as Isaac mentioned.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
