Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253ADC433B4
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 11:40:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47612613BD
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 11:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47612613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05B6B849AD;
	Tue,  6 Apr 2021 11:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kF7wEIS6QCWZ; Tue,  6 Apr 2021 11:40:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B30C98497D;
	Tue,  6 Apr 2021 11:40:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F1FEC000B;
	Tue,  6 Apr 2021 11:40:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A6E1C000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13B5540634
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:40:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mumhJAMxxJGJ for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 11:40:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C84340632
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:40:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0501661394;
 Tue,  6 Apr 2021 11:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617709237;
 bh=D5ja3pEnQKp92DZ8GW4YTR41AKo2SyV0oqDopX8rdNc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OpOMUfXfdimDt7wzdC8WNK7hREUPjfyZIQQndYdn+Tkx33uQpTZoTjFIilbAJXtuN
 YTCM+YzmPGuDLQcpoGIEKSi9a801j11ipxVpQe5EWFD6JQTS84NvzNQ2IMfvPl6cEg
 EFR9BPemzAoKAWqVgR0X+ELCXCUVntnTDU/77GXkecVlLLMKbfhs7EMHqTCb6Sj8eO
 GHS/c1oK6fPX9swF8hhu+nxIF9YJb3z+pJuCrCza0LFRXwL79eMZOxTuSbQF2ZUhM3
 xTJ5JNe+qdehkT88kDwtPEzUqBFYiSUqaSRzBN3BRJiDLQio1CVP8noPt6/9O6X8BJ
 pekY/RBlDs43g==
Date: Tue, 6 Apr 2021 12:40:32 +0100
From: Will Deacon <will@kernel.org>
To: isaacm@codeaurora.org
Subject: Re: [RFC PATCH 3/6] iommu: Use bitmap to calculate page size in
 iommu_pgsize()
Message-ID: <20210406114032.GA13747@willie-the-truck>
References: <20210401164738.9513-1-will@kernel.org>
 <20210401164738.9513-4-will@kernel.org>
 <7c012a63e8a5ad1856aac08995e6f154@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7c012a63e8a5ad1856aac08995e6f154@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Pratik Patel <pratikp@codeaurora.org>, linux-arm-kernel@lists.infradead.org
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

On Thu, Apr 01, 2021 at 06:39:35PM -0700, isaacm@codeaurora.org wrote:
> On 2021-04-01 09:47, Will Deacon wrote:
> > Avoid the potential for shifting values by amounts greater than the
> > width of their type by using a bitmap to compute page size in
> > iommu_pgsize().
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  drivers/iommu/iommu.c | 31 ++++++++++++-------------------
> >  1 file changed, 12 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index d0b0a15dba84..bcd623862bf9 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -8,6 +8,7 @@
> > 
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> > +#include <linux/bits.h>
> >  #include <linux/bug.h>
> >  #include <linux/types.h>
> >  #include <linux/init.h>
> > @@ -2360,30 +2361,22 @@ static size_t iommu_pgsize(struct iommu_domain
> > *domain,
> >  			   unsigned long addr_merge, size_t size)
> >  {
> >  	unsigned int pgsize_idx;
> > +	unsigned long pgsizes;
> >  	size_t pgsize;
> > 
> > -	/* Max page size that still fits into 'size' */
> > -	pgsize_idx = __fls(size);
> > +	/* Page sizes supported by the hardware and small enough for @size */
> > +	pgsizes = domain->pgsize_bitmap & GENMASK(__fls(size), 0);
> I've fixed this in the latest RFC for the iommu_map/unmap optimization
> patches,
> but for the sake of completeness: I think this should be GENMASK_ULL, in
> case
> __fls(size) >= 32.

Hmm, but 'size' is a size_t; which architectures have sizeof(size_t) >
sizeof(unsigned long)?

> > -	/* need to consider alignment requirements ? */
> > -	if (likely(addr_merge)) {
> > -		/* Max page size allowed by address */
> > -		unsigned int align_pgsize_idx = __ffs(addr_merge);
> > -		pgsize_idx = min(pgsize_idx, align_pgsize_idx);
> > -	}
> > -
> > -	/* build a mask of acceptable page sizes */
> > -	pgsize = (1UL << (pgsize_idx + 1)) - 1;
> > -
> > -	/* throw away page sizes not supported by the hardware */
> > -	pgsize &= domain->pgsize_bitmap;
> > +	/* Constrain the page sizes further based on the maximum alignment */
> > +	if (likely(addr_merge))
> > +		pgsizes &= GENMASK(__ffs(addr_merge), 0);

This one looks like more of an issue, though, as addr_merge is a
phys_addr_t, which certainly can be 64-bit where unsigned long is 32-bit
(e.g. Armv7 + LPAE)

Rather than make everything _ULL, please can you just do it where we're
actually using the larger types?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
