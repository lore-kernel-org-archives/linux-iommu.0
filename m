Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FE9C433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 11:39:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0086A2074B
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 11:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eja//h3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0086A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B621287EE9;
	Mon,  8 Jun 2020 11:39:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GqI0uQLHgbdA; Mon,  8 Jun 2020 11:39:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0967787EA6;
	Mon,  8 Jun 2020 11:39:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3713C0863;
	Mon,  8 Jun 2020 11:39:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20DA4C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 11:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1302E86418
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 11:39:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O0wNw6kaKhYU for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 11:38:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 525688628E
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 11:38:58 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DCCFF2074B;
 Mon,  8 Jun 2020 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591616338;
 bh=Zl/yqsOe6XvPuDsdXn5eL/LxofYRwuiRdfSA1r83qmE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eja//h3ITTR540LH3moJdaVVujXmeh4Q0guFKDFy/IV3zPH44iN2VTcSvufIwlglH
 RWrj2MGV07SXcgnxO95beb1v/pFzWIVdQ4vkcw6Mh/Vu3In/2iWdhqSnk6kXL4qzIX
 WK8pjllHjuh7g1MW6lSUGPMukmJNBI2bVPQfhWLs=
Date: Mon, 8 Jun 2020 12:38:53 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [RFC PATCH] iommu/arm-smmu: Remove shutdown callback
Message-ID: <20200608113852.GA3108@willie-the-truck>
References: <20200607110918.1733-1-saiprakash.ranjan@codeaurora.org>
 <20200608081846.GA1542@willie-the-truck>
 <08c293eefc20bc2c67f2d2639b93f0a5@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <08c293eefc20bc2c67f2d2639b93f0a5@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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

On Mon, Jun 08, 2020 at 02:43:03PM +0530, Sai Prakash Ranjan wrote:
> On 2020-06-08 13:48, Will Deacon wrote:
> > On Sun, Jun 07, 2020 at 04:39:18PM +0530, Sai Prakash Ranjan wrote:
> > > Remove SMMU shutdown callback since it seems to cause more
> > > problems than benefits. With this callback, we need to make
> > > sure that all clients/consumers of SMMU do not perform any
> > > DMA activity once the SMMU is shutdown and translation is
> > > disabled. In other words we need to add shutdown callbacks
> > > for all those clients to make sure they do not perform any
> > > DMA or else we see all kinds of weird crashes during reboot
> > > or shutdown. This is clearly not scalable as the number of
> > > clients of SMMU would vary across SoCs and we would need to
> > > add shutdown callbacks to almost all drivers eventually.
> > > This callback was added for kexec usecase where it was known
> > > to cause memory corruptions when SMMU was not shutdown but
> > > that does not directly relate to SMMU because the memory
> > > corruption could be because of the client of SMMU which is
> > > not shutdown properly before booting into new kernel. So in
> > > that case, we need to identify the client of SMMU causing
> > > the memory corruption and add appropriate shutdown callback
> > > to the client rather than to the SMMU.
> > > 
> > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > ---
> > >  drivers/iommu/arm-smmu-v3.c | 6 ------
> > >  drivers/iommu/arm-smmu.c    | 6 ------
> > >  2 files changed, 12 deletions(-)
> > 
> > This feels like a giant bodge to me and I think that any driver which
> > continues to perform DMA after its ->shutdown() function has been
> > invoked
> > is buggy. Wouldn't that cause problems with kexec(), for example?
> > 
> 
> Yes it is definitely a bug in the client driver if DMA is performed
> after shutdown callback of that respective driver is invoked and it must
> be fixed in that driver. But here the problem I was describing is not that,
> most of the drivers do not have a shutdown callback to begin with and adding
> it just because of shutdown dependency on SMMU doesn't seem so well because
> we can have many more such clients in the future and then we have to just go
> on adding the shutdown callbacks everywhere.

I'm not sure why you're trying to treat these cases differently. It's also
not "just because of SMMU", is it? Like I said, kexec() would be broken
regardless.

The bottom line is that after running ->shutdown() (or skipping it if it's
not implemented) for a driver, then the device must no longer perform DMA.

> > There's a clear shutdown dependency ordering, where the clients of the
> > SMMU need to shutdown before the SMMU itself, but that's not really
> > the SMMU driver's problem to solve.
> > 
> 
> The problem with kexec may not be directly related to SMMU as you said
> above if DMA is performed after the client shutdown callback, then its a
> bug in the client driver, so that needs to be fixed in the client driver,
> not the SMMU. So is there any point in having the SMMU shutdown callback?

Given that the SMMU mediates DMA transactions for all upstream masters
based on in-memory data (e.g. page tables), then I think it's a /very/
good idea to tear that down as part of the shutdown callback before
the memory is effectively free()d.

One thing I would be in favour of is changing the ->shutdown() code to
honour disable_bypass=1 so that we put the SMMU in an aborting state
instead of passthrough. Would that help at all? It would at least
avoid the memory corruption on missing shutdown callback.

> As you see, with this SMMU shutdown callback, we need to add shutdown
> callbacks in all the client drivers.

I don't see the problem with that. Why is it a problem?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
