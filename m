Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E1C282DD
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:09:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F082077C
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVEyX0mD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F082077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E47FF221D5;
	Fri, 10 Jan 2020 15:09:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2YV4+rWl5CiL; Fri, 10 Jan 2020 15:09:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 40D93221C6;
	Fri, 10 Jan 2020 15:09:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28089C1796;
	Fri, 10 Jan 2020 15:09:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3E48C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9C5E2221C6
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0tD7o3hIij05 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 15:09:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 4EEAA2207F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:09:41 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B8952077C;
 Fri, 10 Jan 2020 15:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578668981;
 bh=CjM2+mej2vDfDaxx9EuNh3xVcqSR6DNAiTeKsJFz/48=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bVEyX0mDobj3Do0pvAG1R3FkaEwtSX0af1wgZOKSQacSCjRvPHrlVW6+3SS07JmwZ
 Zk/vnAuG6Ua5cT+R6mOxwXe9NpV7SpyaG887A9mw8Zpi0u5HPhwW5SEevvQCuQvV+q
 gYSgtpuRy3a1ITUiRcZMPW1KOaNAiAzaNRk2/qn8=
Date: Fri, 10 Jan 2020 15:09:36 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 00/10] iommu/io-pgtable: Cleanup and prep for split
 tables
Message-ID: <20200110150936.GA23011@willie-the-truck>
References: <cover.1572024119.git.robin.murphy@arm.com>
 <20191104192228.GL24909@willie-the-truck>
 <20191104202012.GN24909@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104202012.GN24909@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Nov 04, 2019 at 08:20:12PM +0000, Will Deacon wrote:
> On Mon, Nov 04, 2019 at 07:22:28PM +0000, Will Deacon wrote:
> > On Fri, Oct 25, 2019 at 07:08:29PM +0100, Robin Murphy wrote:
> > > Since the flawed first attempt, I've reworked things with an abstracted
> > > TCR and an explicit TTBR1 quirk. I originally envisaged the need to pass
> > > the quirk all the way down to the TLBI calls, hence getting diverted
> > > into trying to make the parameter passing less cluttered in general, but
> > > in the end it turned out fairly neat to just fix the indexing such that
> > > we can always just pass around the original unmodified IOVA. Most of the
> > > new patches come from staring at that indexing code for long enough to
> > > see the subtle inefficiencies that were worth ironing out, plus a bit of
> > > random cleanup which doesn't feel worth posting separately.
> > > 
> > > Note that these patches depend on the fixes already queued in -rc4,
> > > otherwise there will be conflicts in arm_mali_lpae_alloc_pgtable().
> > > 
> > > Robin.
> > > 
> > > 
> > > Robin Murphy (10):
> > >   iommu/io-pgtable: Make selftest gubbins consistently __init
> > >   iommu/io-pgtable-arm: Rationalise size check
> > >   iommu/io-pgtable-arm: Simplify bounds checks
> > >   iommu/io-pgtable-arm: Simplify start level lookup
> > >   iommu/io-pgtable-arm: Simplify PGD size handling
> > >   iommu/io-pgtable-arm: Simplify level indexing
> > >   iommu/io-pgtable-arm: Rationalise MAIR handling
> > >   iommu/io-pgtable-arm: Rationalise TTBRn handling
> > >   iommu/io-pgtable-arm: Rationalise TCR handling
> > >   iommu/io-pgtable-arm: Prepare for TTBR1 usage
> > 
> > Overall, this looks really good to me. There's a bit more work to do
> > (see my comments) and I'd like Jordan to have a look as well, but on the
> > whole it's a big improvement. Thanks.
> 
> Also, I've merged the first 7 patches to save you having to repost those:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates

I've now picked up the remaining three patches, but I'll post them to the
list shortly because I've ended up trying to address my own review comments
as I'd like this stuff in before we go ahead with Jordan's patches.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
