Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B35C3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 16:23:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994F722DD6
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 16:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F8KYPR94";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bcs9DEUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994F722DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 59A8BCDF;
	Tue, 20 Aug 2019 16:23:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7E184A49
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 16:23:25 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1623312E
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 16:23:25 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6F6BA60DB6; Tue, 20 Aug 2019 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1566318204;
	bh=Jq+WMGe8B5Go6F6LI4omy9GTq55Eu9cZlfLG8KVU6Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8KYPR94MXfilFsjxqqoJ6eVUbffAAWKMD1YWQ9ohm+lZARwFwLmUd4H//HSfsplM
	OPuNYhGAKzvDSEFhhASxqj/fox2h6rbo+1ZBMjSDXn7O1zjI7l1Bw9/ix0ENmaeaIT
	dCeNRtL9jxYdTB2TZa8JFL5UhbAKvfec9AHJ6Rpc=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 2553360AD1;
	Tue, 20 Aug 2019 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1566318203;
	bh=Jq+WMGe8B5Go6F6LI4omy9GTq55Eu9cZlfLG8KVU6Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bcs9DEUx16iQeIX8DYR8oEZHwcJU+AEVDdS88SgXUEEbPtNeLJOTA3fXC2LuJ+KqV
	TrhO3hhYeDkPp3rjnkcuKKtuRj++UA37KtPltm/Fm64Qw3idcZRgM3klI2TD7lSzAH
	0izZTnrNXoYSooB6xvPerSvXC/EM//mUs+FLPj5s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2553360AD1
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Tue, 20 Aug 2019 10:23:20 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] iommu/io-pgtable-arm: Rationalise TCR handling
Message-ID: <20190820162319.GH28465@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, joro@8bytes.org,
	iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, robdclark@gmail.com
References: <cover.1566238530.git.robin.murphy@arm.com>
	<78df4f8e2510e88f3ded59eb385f79b4442ed4f2.1566238530.git.robin.murphy@arm.com>
	<20190820103115.o7neehdethf7sbqi@willie-the-truck>
	<48ca6945-de73-116a-3230-84862ca9e60b@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48ca6945-de73-116a-3230-84862ca9e60b@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
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

On Tue, Aug 20, 2019 at 04:25:56PM +0100, Robin Murphy wrote:
> On 20/08/2019 11:31, Will Deacon wrote:
> >On Mon, Aug 19, 2019 at 07:19:30PM +0100, Robin Murphy wrote:
> >>Although it's conceptually nice for the io_pgtable_cfg to provide a
> >>standard VMSA TCR value, the reality is that no VMSA-compliant IOMMU
> >>looks exactly like an Arm CPU, and they all have various other TCR
> >>controls which io-pgtable can't be expected to understand. Thus since
> >>there is an expectation that drivers will have to add to the given TCR
> >>value anyway, let's strip it down to just the essentials that are
> >>directly relevant to io-pgatble's inner workings - namely the address
> >>sizes, walk attributes, and where appropriate, format selection.
> >>
> >>Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >>---
> >>  drivers/iommu/arm-smmu-v3.c        | 7 +------
> >>  drivers/iommu/arm-smmu.c           | 1 +
> >>  drivers/iommu/arm-smmu.h           | 2 ++
> >>  drivers/iommu/io-pgtable-arm-v7s.c | 6 ++----
> >>  drivers/iommu/io-pgtable-arm.c     | 4 ----
> >>  drivers/iommu/qcom_iommu.c         | 2 +-
> >>  6 files changed, 7 insertions(+), 15 deletions(-)
> >
> >Hmm, so I'm a bit nervous about this one since I think we really should
> >be providing a TCR with EPD1 set if we're only giving you TTBR0. Relying
> >on the driver to do this worries me. See my comments on the next patch.
> 
> The whole idea is that we already know we can't provide a *complete* TCR
> value (not least because anything above bit 31 is the wild west), thus
> there's really no point in io-pgtable trying to provide anything other than
> the parts it definitely controls. It makes sense to provide this partial TCR
> value "as if" for TTBR0, since that's the most common case, but ultimately
> io-pgatble doesn't know (or need to) which TTBR the caller intends to
> actually use for this table. Even if the caller *is* allocating it for
> TTBR0, io-pgtable doesn't know that they haven't got something live in TTBR1
> already, so it still wouldn't be in a position to make the EPD1 call either
> way.
> 
> Ultimately, it's the IOMMU drivers who decide what they put in which TTBR,
> so it's the IOMMU drivers which have to take responsibility for EPD*. Sure
> you can worry about it, but you can equally worry about them them
> misprogramming the ASID or anything else...

I agree. If the driver *does* want to use TTBR1 then it gets a bit uglier to
realize that the io-pgtable set the bit and mask it off. To me it is a lot
clearer if this is done explicitly in the driver especially if the driver is
where we are making the choice to use either ttbr0 or ttbr1.

It would probably be easier to see in actual code, and I'll have a patch
shortly on top of this series.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
