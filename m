Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97893C7618B
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 07:41:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65ED72199C
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 07:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltPJ4U+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65ED72199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2C80CDAC;
	Wed, 24 Jul 2019 07:41:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9C97CCC3
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 07:41:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4F073F1
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 07:41:36 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id E24F22190F;
	Wed, 24 Jul 2019 07:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563954096;
	bh=eBPyN0PgCrovmWFPtyhyO8yHJEocBNniNZDr8behyEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltPJ4U+OkYKsJmfoOjomxVIKNg3UiktNd55vjoHqM9JcYJk/xGkqXrHN/Wcu/FENr
	Qh5Nm19eP0IHyokhTGNsx28PUNFk/8rRGMpsiSKCiZqOQEwCAs/NA23kQWGQQEkqmh
	YKQZGNGiq9QMAHM7j869Q2KricRVkPlrnFPQ6otg=
Date: Wed, 24 Jul 2019 08:41:30 +0100
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH v2 04/19] iommu: Introduce struct iommu_iotlb_gather
	for batching TLB flushes
Message-ID: <20190724074129.6pkcmutsoazrrklq@willie-the-truck>
References: <20190711171927.28803-1-will@kernel.org>
	<20190711171927.28803-5-will@kernel.org>
	<20190724071959.GE1524@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190724071959.GE1524@8bytes.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Joerg,

On Wed, Jul 24, 2019 at 09:19:59AM +0200, Joerg Roedel wrote:
> On Thu, Jul 11, 2019 at 06:19:12PM +0100, Will Deacon wrote:
> >  static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
> >  		size_t size)
> >  {
> > +	struct iommu_iotlb_gather iotlb_gather;
> >  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> >  	struct iova_domain *iovad = &cookie->iovad;
> >  	size_t iova_off = iova_offset(iovad, dma_addr);
> > +	size_t unmapped;
> >  
> >  	dma_addr -= iova_off;
> >  	size = iova_align(iovad, size + iova_off);
> > +	iommu_iotlb_gather_init(&iotlb_gather);
> > +
> > +	unmapped = iommu_unmap_fast(domain, dma_addr, size, &iotlb_gather);
> > +	WARN_ON(unmapped != size);
> >  
> > -	WARN_ON(iommu_unmap_fast(domain, dma_addr, size) != size);
> >  	if (!cookie->fq_domain)
> > -		iommu_tlb_sync(domain);
> > +		iommu_tlb_sync(domain, &iotlb_gather);
> >  	iommu_dma_free_iova(cookie, dma_addr, size);
> 
> I looked through your patches and was wondering if we can't make the
> 'struct iotlb_gather' a member of 'struct iommu_domain' and update it
> transparently for the user? That would make things easier for users of
> the iommu-api.

Thanks for having a look.

My first (private) attempt at this series did exactly what you suggest, but
the problem there is that you can have concurrent, disjoint map()/unmap()
operations on the same 'struct iommu_domain', so you end up needing either
multiple 'iotlb_gather' structures to support these callers or you end up
massively over-invalidating. Worse, you can't just make things per-cpu
without disabling preemption, so whatever you do you end up re-introducing
synchronization to maintain these things. The /huge/ advantage of getting
the caller to allocate the 'iotlb_gather' structure on their stack is that
you don't have to worry about object lifetime at all, so all of the
synchronization disappears. There is also precedent for this when unmapping
things on the CPU side -- see the use of 'struct mmu_gather' and
tlb_gather_mmu() in unmap_region() [mm/mmap.c], for example.

There aren't tonnes of (direct) users of the iommu-api, and the additional
complexity introduced by the 'struct iotlb_gather' only applies to users of
iommu_unmap_fast(), which I think is a reasonable trade-off in return for
the potential for improved performance.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
