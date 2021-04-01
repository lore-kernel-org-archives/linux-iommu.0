Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A66C433B4
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 16:37:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB1F61379
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 16:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB1F61379
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 227874184E;
	Thu,  1 Apr 2021 16:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZSxS7rJE7MRf; Thu,  1 Apr 2021 16:37:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9CC541839;
	Thu,  1 Apr 2021 16:37:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FC28C000C;
	Thu,  1 Apr 2021 16:37:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81553C000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 16:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D77884AB8
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 16:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id geDl9F80WI4I for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 16:37:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDED384AB7
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 16:37:10 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AF1D61381;
 Thu,  1 Apr 2021 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617295030;
 bh=lG+TWfk7eaKMXsCJqSFbYRKMSY/gdieOG0Af7e+PYzM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R71UWyGk75+TUWGfKPCgLoLl7BOgooOxhSXZeMxybZ4w/K6v4RuzPmaG4E17codkc
 PyyrynpAX4bStub9bda7ywXz/x66SIH8Lk/BLBYco3A3HZFoh6LDK7ywoSZhIrbAA0
 r01mFUBTgMgy2Grlz2UyuZamx1P3F10TyFn8/GiCUt+TLRXrcAmLSq4xCYubqYxYwl
 F6HFYr7OY5R9auJdmDc8Ijf/lJNqH5BV7MjNYrQDmuS20N85B/4ymA5McTLVocm7lA
 S/xtGEGA0V7REJyek7xDkGqywqryZ6bGf79ngv30l5+F1BXE1b3x39URgoSuWk8mlf
 zikwnXbH6S4DQ==
Date: Thu, 1 Apr 2021 17:37:05 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH 3/5] iommu: Add support for the unmap_pages IOMMU
 callback
Message-ID: <20210401163705.GA9281@willie-the-truck>
References: <20210331030042.13348-1-isaacm@codeaurora.org>
 <20210331030042.13348-4-isaacm@codeaurora.org>
 <f57e2151-1199-46f0-21ed-e401be358857@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f57e2151-1199-46f0-21ed-e401be358857@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 iommu@lists.linux-foundation.org, pratikp@codeaurora.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Apr 01, 2021 at 04:34:37PM +0100, Robin Murphy wrote:
> On 2021-03-31 04:00, Isaac J. Manjarres wrote:
> > The IOMMU framework currently unmaps memory one page block at a time,
> > per the page block sizes that are supported by the IOMMU hardware.
> > Now that IOMMU drivers can supply a callback for unmapping multiple
> > in one call, add support in the IOMMU framework to calculate how many
> > page mappings of the same size can be unmapped in one shot, and invoke the
> > IOMMU driver's unmap_pages callback if it has one. Otherwise, the
> > existing behavior will be used.
> > 
> > Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> > Suggested-by: Will Deacon <will@kernel.org>
> > ---
> >   drivers/iommu/iommu.c | 44 +++++++++++++++++++++++++++++++++++++------
> >   1 file changed, 38 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index d0b0a15dba84..dc4295f6bc7f 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2356,8 +2356,8 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
> >   }
> >   EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
> > -static size_t iommu_pgsize(struct iommu_domain *domain,
> > -			   unsigned long addr_merge, size_t size)
> > +static size_t __iommu_pgsize(struct iommu_domain *domain,
> > +			     unsigned long addr_merge, size_t size)
> >   {
> >   	unsigned int pgsize_idx;
> >   	size_t pgsize;
> > @@ -2388,6 +2388,24 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
> >   	return pgsize;
> >   }
> > +static size_t iommu_pgsize(struct iommu_domain *domain,
> > +			   unsigned long addr_merge, size_t size,
> > +			   size_t *pgcount)
> > +{
> > +	size_t pgsize = __iommu_pgsize(domain, addr_merge, size);
> > +	size_t pgs = 0;
> > +
> > +	do {
> > +		pgs++;
> > +		size -= pgsize;
> > +		addr_merge += pgsize;
> > +	} while (size && __iommu_pgsize(domain, addr_merge, size) == pgsize);
> 
> This looks horrifically inefficient. As part of calculating the best current
> page size it should then be pretty trivial to calculate "(size &
> next_pgsize_up - 1) >> pgsize_idx" for the number of current-size pages up
> to the next-better-size boundary (with next_pgsize_up being 0 if pgsize is
> already the largest possible for the relative alignment of physical and
> virtual address). A loop is just... yuck :(

Hehe, I'm glad you said that as I was thinking the same thing. It's
surprisingly fiddly to get this right, but I spent some time hacking it
today and I _think_ I have something that Isaac could build on (and
hopefully won't be too hairy for ->map either).

I'll post it as an RFC in a sec...

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
