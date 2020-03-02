Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6D9C3F2D1
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 16:14:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02502146E
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 16:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4hz4wf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02502146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7C94185A0E;
	Mon,  2 Mar 2020 16:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gpLvHOeF2l_r; Mon,  2 Mar 2020 16:14:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F3AE0844B3;
	Mon,  2 Mar 2020 16:14:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDB26C07FE;
	Mon,  2 Mar 2020 16:14:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A8B4C013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 16:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 76E80876C3
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 16:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uma8lOd-JT5Y for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 16:14:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E1332865D5
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 16:14:45 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BA879217F4;
 Mon,  2 Mar 2020 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583165685;
 bh=u0EmxXyp+rF3GEHYWpR6QSZHLT5AY2Ngw5mEg4tr9R8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H4hz4wf+6hHJml4NvuPjb5b8SVGXb6yTa/96//Sq4FPBZsMkPKZqzN1nqqDzwYFnG
 k9fJz8mUPOMzLQbUbFmg1HKkm1AufXpyYZnwdjtzHlSIARuOMekMGY8/LOe5OogL8s
 GZ9UL//E8tsdAMajBkKJ3HLz/BsL64QMahi+KwMc=
Date: Mon, 2 Mar 2020 16:14:41 +0000
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Fix IOVA validation for 32-bit
Message-ID: <20200302161440.GA11427@willie-the-truck>
References: <dd330453ed31099b5b3b76db02fe79d55aa9bce3.1582899080.git.robin.murphy@arm.com>
 <20200302115300.GA9233@willie-the-truck>
 <20200302161123.GC7829@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200302161123.GC7829@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-kernel@lists.infradead.org
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

On Mon, Mar 02, 2020 at 05:11:23PM +0100, Joerg Roedel wrote:
> On Mon, Mar 02, 2020 at 11:53:01AM +0000, Will Deacon wrote:
> > On Fri, Feb 28, 2020 at 02:18:55PM +0000, Robin Murphy wrote:
> > > Since we ony support the TTB1 quirk for AArch64 contexts, and
> > > consequently only for 64-bit builds, the sign-extension aspect of the
> > > "are all bits above IAS consistent?" check should implicitly only apply
> > > to 64-bit IOVAs. Change the type of the cast to ensure that 32-bit longs
> > > don't inadvertently get sign-extended, and thus considered invalid, if
> > > they happen to be above 2GB in the TTB0 region.
> > > 
> > > Reported-by: Stephan Gerhold <stephan@gerhold.net>
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > 
> > > ---
> > > 
> > > Logically there may also have been a UBSAN "shift greater than size of
> > > type" warning too, but arch/arm doesn't support UBSAN_SANITIZE_ALL,
> > > and that's now my only easy "spin up a 32-bit VM" option to hand :)
> > > 
> > >  drivers/iommu/io-pgtable-arm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > Joerg -- pleae can you take this as a fix for 5.6?
> 
> Done, do you also have a fixes-tag for me?

Fixes: db6903010aa5 ("iommu/io-pgtable-arm: Prepare for TTBR1 usage")

Although it doesn't need to go to -stable, since this was only introduced
during the recent merge window.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
