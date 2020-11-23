Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFE4C2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 11:47:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4554E2074B
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 11:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS2ygnXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4554E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DD4DB870CF;
	Mon, 23 Nov 2020 11:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XELdfUlQfwGu; Mon, 23 Nov 2020 11:47:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 77EF58705B;
	Mon, 23 Nov 2020 11:47:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68FB2C0891;
	Mon, 23 Nov 2020 11:47:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B49DC0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 11:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 817FD870CD
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 11:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lAyUzxWOoIaD for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 11:47:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 20E598705B
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 11:47:14 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A24C82074B;
 Mon, 23 Nov 2020 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606132031;
 bh=2PtTmOJEIKueGGOEndNNTAvxa8jv28ItaoA+w5cJ7ok=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fS2ygnXRKaVKl4yrUEJ1wu6gxcKFF9B8z1SqnqIBryRZo8H3iMw8c/PuRyGBRVI4s
 Gkull3LJtsdvMhMitK/U+14Nivs7X3Og57TUZ5utLIEpOuw8cEy4sSibAXSeOSK0BF
 x9jmfc8UdRdBxKuq4H5+wxRwysi8KA/rB6mtk1ds=
Date: Mon, 23 Nov 2020 11:47:06 +0000
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 3/7] iommu: Allow the dma-iommu api to use bounce
 buffers
Message-ID: <20201123114705.GA10233@willie-the-truck>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
 <20201120101719.3172693-4-baolu.lu@linux.intel.com>
 <20201123100816.GA26619@infradead.org>
 <73ac6a6b-ede9-b306-6d8f-c73f22e1e8e3@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <73ac6a6b-ede9-b306-6d8f-c73f22e1e8e3@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Logan Gunthorpe <logang@deltatee.com>,
 linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

On Mon, Nov 23, 2020 at 07:40:57PM +0800, Lu Baolu wrote:
> On 2020/11/23 18:08, Christoph Hellwig wrote:
> > > +	/*
> > > +	 * If both the physical buffer start address and size are
> > > +	 * page aligned, we don't need to use a bounce page.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
> > > +	    iova_offset(iovad, phys | org_size)) {
> > > +		aligned_size = iova_align(iovad, org_size);
> > > +		phys = swiotlb_tbl_map_single(dev,
> > > +				phys_to_dma(dev, io_tlb_start),
> > > +				phys, org_size, aligned_size, dir, attrs);
> > 
> > swiotlb_tbl_map_single takes one less argument in 5.10-rc now.
> > 
> 
> Yes. But Will's iommu/next branch is based on 5.10-rc3. I synced with
> him, we agreed to keep it 5.10-rc3 and resolve this conflict when
> merging it.

That's right, although I failed to appreciate the conflict was due to a
change in function prototype rather than just a context collision. So
I've updated the vt-d branch to contain the stuff fron Konrad:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/iommu/vt-d

Sorry for messing you around!

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
