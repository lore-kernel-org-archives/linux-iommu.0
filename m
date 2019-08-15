Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E08C3A589
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 14:23:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B717E206C1
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 14:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B717E206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 82410EEE;
	Thu, 15 Aug 2019 14:23:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 62A6CEE6
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 14:23:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id D2BFA711
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 14:23:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54507344;
	Thu, 15 Aug 2019 07:23:39 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16AE23F706;
	Thu, 15 Aug 2019 07:23:36 -0700 (PDT)
Subject: Re: [PATCH 02/13] iommu/io-pgtable-arm: Remove redundant call to
	io_pgtable_tlb_sync()
To: Will Deacon <will@kernel.org>
References: <20190814175634.21081-1-will@kernel.org>
	<20190814175634.21081-3-will@kernel.org>
	<ec5eb9fb-4178-011f-0642-bae380086a49@arm.com>
	<20190815135723.oobxfwngoq6wttlb@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d5b7693b-7fe6-2404-f2f7-c70a5a2892f3@arm.com>
Date: Thu, 15 Aug 2019 15:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190815135723.oobxfwngoq6wttlb@willie-the-truck>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vijay Kilary <vkilari@codeaurora.org>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 15/08/2019 14:57, Will Deacon wrote:
> Hi Robin,
> 
> On Thu, Aug 15, 2019 at 01:43:11PM +0100, Robin Murphy wrote:
>> On 14/08/2019 18:56, Will Deacon wrote:
>>> Commit b6b65ca20bc9 ("iommu/io-pgtable-arm: Add support for non-strict
>>> mode") added an unconditional call to io_pgtable_tlb_sync() immediately
>>> after the case where we replace a block entry with a table entry during
>>> an unmap() call. This is redundant, since the IOMMU API will call
>>> iommu_tlb_sync() on this path and the patch in question mentions this:
>>>
>>>    | To save having to reason about it too much, make sure the invalidation
>>>    | in arm_lpae_split_blk_unmap() just performs its own unconditional sync
>>>    | to minimise the window in which we're technically violating the break-
>>>    | before-make requirement on a live mapping. This might work out redundant
>>>    | with an outer-level sync for strict unmaps, but we'll never be splitting
>>>    | blocks on a DMA fastpath anyway.
>>>
>>> However, this sync gets in the way of deferred TLB invalidation for leaf
>>> entries and is at best a questionable, unproven hack. Remove it.
>>
>> Hey, that's my questionable, unproven hack! :P
> 
> I thought you'd like to remain anonymous, but I can credit you if you like?
> ;)
> 
>> It's not entirely clear to me how this gets in the way though - AFAICS the
>> intent of tlb_flush_leaf exactly matches the desired operation here, so
>> couldn't these just wait to be converted in patch #8?
> 
> Good point. I think there are two things:
> 
> 	1. Initially, I didn't plan to have tlb_flush_leaf() at all because
> 	   I didn't think it would be needed. Then I ran into the v7s CONT
> 	   stuff and ended up needing it after all (I think it's the only
> 	   user). So that's an oversight.
> 
> 	2. If we do the tlb_flush_leaf() here, then we could potentially
> 	   put a hole in the ongoing gather structure, but I suppose we
> 	   could do both a tlb_add_page() *and* a tlb_flush_leaf() to get
> 	   around that.
> 
> So yes, I probably could move this back if the sync is necessary but...
> 
>> In principle the concern is that if the caller splits a block with
>> iommu_unmap_fast(), there's no guarantee of seeing an iommu_tlb_sync()
>> before returning to the caller, and thus there's the potential to run into a
>> TLB conflict on a subsequent access even if the endpoint was "good" and
>> didn't make any accesses *during* the unmap call.
> 
> ... this just feels pretty theoretical to me. The fact of the matter is
> that we're unable to do break before make because we can't reliably tolerate
> faults. If the hardware actually requires BBM for correctness, then we
> should probably explore proper solutions (e.g. quirks, avoiding block
> mappings, handling faults) rather than emitting a random sync and hoping
> for the best.
> 
> Did you add the sync just in case, or was it based on a real crash?

Nope, just a theoretical best-effort thing, which I'm certainly not 
going to lose sleep over either way - I just felt compelled to question 
the rationale which didn't seem to fit. Realistically, this 
partial-unmap case is not well-defined in IOMMU API terms, and other 
drivers don't handle it consistently. I think VFIO explicitly rejects 
partial unmaps, so if we see them at all it's only likely to be from 
GPU/SVA type users who in principle ought to be able to tolerate 
transient faults from BBM anyway.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
