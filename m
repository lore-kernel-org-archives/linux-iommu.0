Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232BFC3A59E
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 12:11:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86F022D6D
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 12:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBmSJWU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86F022D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EBC14FB3;
	Wed, 21 Aug 2019 12:11:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AE080F90
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 12:11:25 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 452BE89E
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 12:11:25 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 02B5622CE3;
	Wed, 21 Aug 2019 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566389485;
	bh=6SAn36luX8nPLgIwmWDCVqjtygPua5k4vP92Y24z3nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBmSJWU3G9o+VpZGtPTikOGmGHCJs/v0i06RHPyUaX5D0czOu78+XNTT6qaGIhWGn
	PKWRjhez5JQq7HW/yBx3EDz9xzQxralL2FjahCjEjKg3EgwMtIHQSYmiiWpzvhkFCD
	U1/eCGxk9zMaSZz9ovGsC7/Ir0Mw0MYXdBZFH4zQ=
Date: Wed, 21 Aug 2019 13:11:21 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] iommu/io-pgtable-arm: Rationalise TCR handling
Message-ID: <20190821121120.34wqo7vj56pqk57c@willie-the-truck>
References: <cover.1566238530.git.robin.murphy@arm.com>
	<78df4f8e2510e88f3ded59eb385f79b4442ed4f2.1566238530.git.robin.murphy@arm.com>
	<20190820103115.o7neehdethf7sbqi@willie-the-truck>
	<48ca6945-de73-116a-3230-84862ca9e60b@arm.com>
	<20190820160700.6ircxomwuo5bksqz@willie-the-truck>
	<8cc47f43-ad74-b4e2-e977-6c78780abc91@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8cc47f43-ad74-b4e2-e977-6c78780abc91@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Tue, Aug 20, 2019 at 07:41:52PM +0100, Robin Murphy wrote:
> On 20/08/2019 17:07, Will Deacon wrote:
> > On Tue, Aug 20, 2019 at 04:25:56PM +0100, Robin Murphy wrote:
> > > On 20/08/2019 11:31, Will Deacon wrote:
> > > > On Mon, Aug 19, 2019 at 07:19:30PM +0100, Robin Murphy wrote:
> > > > > Although it's conceptually nice for the io_pgtable_cfg to provide a
> > > > > standard VMSA TCR value, the reality is that no VMSA-compliant IOMMU
> > > > > looks exactly like an Arm CPU, and they all have various other TCR
> > > > > controls which io-pgtable can't be expected to understand. Thus since
> > > > > there is an expectation that drivers will have to add to the given TCR
> > > > > value anyway, let's strip it down to just the essentials that are
> > > > > directly relevant to io-pgatble's inner workings - namely the address
> > > > > sizes, walk attributes, and where appropriate, format selection.
> > > > > 
> > > > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > > > ---
> > > > >    drivers/iommu/arm-smmu-v3.c        | 7 +------
> > > > >    drivers/iommu/arm-smmu.c           | 1 +
> > > > >    drivers/iommu/arm-smmu.h           | 2 ++
> > > > >    drivers/iommu/io-pgtable-arm-v7s.c | 6 ++----
> > > > >    drivers/iommu/io-pgtable-arm.c     | 4 ----
> > > > >    drivers/iommu/qcom_iommu.c         | 2 +-
> > > > >    6 files changed, 7 insertions(+), 15 deletions(-)
> > > > 
> > > > Hmm, so I'm a bit nervous about this one since I think we really should
> > > > be providing a TCR with EPD1 set if we're only giving you TTBR0. Relying
> > > > on the driver to do this worries me. See my comments on the next patch.
> > > 
> > > The whole idea is that we already know we can't provide a *complete* TCR
> > > value (not least because anything above bit 31 is the wild west), thus
> > > there's really no point in io-pgtable trying to provide anything other than
> > > the parts it definitely controls. It makes sense to provide this partial TCR
> > > value "as if" for TTBR0, since that's the most common case, but ultimately
> > > io-pgatble doesn't know (or need to) which TTBR the caller intends to
> > > actually use for this table. Even if the caller *is* allocating it for
> > > TTBR0, io-pgtable doesn't know that they haven't got something live in TTBR1
> > > already, so it still wouldn't be in a position to make the EPD1 call either
> > > way.
> > 
> > Ok, but the driver can happily rewrite/ignore what it gets back. I suppose
> > an alternative would be scrapped the 'u64 tcr' and instead having a bunch
> > of named bitfields for the stuff we're actually providing, although I'd
> > still like EPDx to be in there.
> 
> I like the bitfield idea; it would certainly emphasise the "you have to do
> something more with this" angle that I'm pushing towards here, but still
> leave things framed in TCR terms without having to go to some more general
> abstraction. It really doesn't play into your EPD argument though - such a
> config would be providing TxSZ/TGx/IRGNx/ORGNx/SHx, but EPDy, for y = !x.
> For a driver to understand that and do the right thing with it is even more
> involved than for the driver to just set EPD1 by itself anyway.

Having considered the bitfield idea some more, I'm less attached to EPDx
because we simply wouldn't be making a statement about them, rather than a
(dangerous) zero value and expecting it to be ignored. So I think we're in
agreement on that.

The only part I'm still stuck to is that I think io-pgtable should know
whether it's targetting TTBR0 or TTBR1 so that it can sanitise input
addresses correctly. Doing this in the driver code is possible, but I'd
rather not start from that position, particularly as it would require things
like sign-extension in the TLBI callbacks.

> If only LPAE had created these bits as enables rather than disables then
> things would be logical and we could all be happy, but here we are...

I'm happy! :D:D:D

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
