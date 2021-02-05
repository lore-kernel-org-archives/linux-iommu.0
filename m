Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BFBC433DB
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 10:34:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D065164F46
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 10:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D065164F46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8AF7787205;
	Fri,  5 Feb 2021 10:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yM4nFabYt5J5; Fri,  5 Feb 2021 10:34:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C659E86DCC;
	Fri,  5 Feb 2021 10:34:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B63B0C0174;
	Fri,  5 Feb 2021 10:34:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F877C013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 10:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2D9DF86DCC
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 10:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xrtTAg1idCps for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 10:34:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D8C37871F9
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 10:34:23 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 53C6A68AFE; Fri,  5 Feb 2021 11:34:18 +0100 (CET)
Date: Fri, 5 Feb 2021 11:34:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 7/8] swiotlb: respect min_align_mask
Message-ID: <20210205103417.GA6694@lst.de>
References: <20210204193035.2606838-1-hch@lst.de>
 <20210204193035.2606838-8-hch@lst.de>
 <2e51481c-1591-034c-3476-1a1f8891506a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e51481c-1591-034c-3476-1a1f8891506a@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 gregkh@linuxfoundation.org, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 jxgao@google.com
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

On Thu, Feb 04, 2021 at 11:13:45PM +0000, Robin Murphy wrote:
>> + */
>> +static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
>> +{
>> +	unsigned min_align_mask = dma_get_min_align_mask(dev);
>> +
>> +	if (!min_align_mask)
>> +		return 0;
>
> I doubt that's beneficial - even if the compiler can convert it into a 
> csel, it'll then be doing unnecessary work to throw away a 
> cheaply-calculated 0 in favour of hard-coded 0 in the one case it matters 

True, I'll drop the checks.

> ;)
>
>> +	return addr & min_align_mask & ((1 << IO_TLB_SHIFT) - 1);
>
> (BTW, for readability throughout, "#define IO_TLB_SIZE (1 << IO_TLB_SHIFT)" 
> sure wouldn't go amiss...)

I actually had a patch doing just that, but as it is the only patch
touching swiotlb.h it caused endless rebuilds for me, so I dropped it
as it only had a few uses anyway.  But I've added it back.

>> -	if (alloc_size >= PAGE_SIZE)
>> +	if (min_align_mask)
>> +		stride = (min_align_mask + 1) >> IO_TLB_SHIFT;
>
> So this can't underflow because "min_align_mask" is actually just the 
> high-order bits representing the number of iotlb slots needed to meet the 
> requirement, right? (It took a good 5 minutes to realise this wasn't doing 
> what I initially thought it did...)

Yes.

> In that case, a) could the local var be called something like 
> iotlb_align_mask to clarify that it's *not* just a copy of the device's 
> min_align_mask,

Ok.

> and b) maybe just have an unconditional initialisation that 
> works either way:
>
> 	stride = (min_align_mask >> IO_TLB_SHIFT) + 1;

Sure.

> In fact with that, I think could just mask orig_addr with ~IO_TLB_SIZE in 
> the call to check_alignment() below, or shift everything down by 
> IO_TLB_SHIFT in check_alignment() itself, instead of mangling 
> min_align_mask at all (I'm assuming we do need to ignore the low-order bits 
> of orig_addr at this point).

Yes, we do need to ignore the low bits as they won't ever be set in
tlb_dma_addr.  Not sure the shift helps as we need to mask first.

I ended up killing check_alignment entirely, in favor of a new
slot_addr helper that calculates the address based off the base and index
and which can be used in a few other places as this one.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
