Return-Path: <SRS0=AgN4=X4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91DCC4CED1
	for <iommu@archiver.kernel.org>; Thu,  3 Oct 2019 20:51:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE782086A
	for <iommu@archiver.kernel.org>; Thu,  3 Oct 2019 20:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="xMip7plz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE782086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3C598158C;
	Thu,  3 Oct 2019 20:51:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D8B4C1583
	for <iommu@lists.linux-foundation.org>;
	Thu,  3 Oct 2019 20:51:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 25DFFD3
	for <iommu@lists.linux-foundation.org>;
	Thu,  3 Oct 2019 20:51:16 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id y19so4300264wrd.3
	for <iommu@lists.linux-foundation.org>;
	Thu, 03 Oct 2019 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gateworks-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=oT5munY2A09zpSHzYJ6m6wmIRb/RVjgLvFvW+U+KSoY=;
	b=xMip7plzqBtaMG8e7QIgtdrUd2y6V5SX/WOrz/GyKIxy13ehe0olzrNXZCKbJc13d9
	QwKm2GmW1840zwcHGUXOwYOVSuL/asmBZ1MmpK1l0JICCd9iqE1VeaY+n7liUlqi2vqZ
	dJ9rY47/oWc9gslxYiT1uKiS1yBOGY+Ex56+2xpEP9Dfr/IB0fUkiriCZGIqAfaxNU3G
	a3dkCvWXxXNecnV0MGX0M+cUsf6uVqVZIOa1M/HJzW2Gdndaf7RxSYyY26ilNeTaQ+bt
	+ewWpw++s6oJEj4OEHQ6hnQ/ohA5Ac4dAVk2cQX9O1beDM2QFJxUGeqEE1197IHvnOzq
	+XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=oT5munY2A09zpSHzYJ6m6wmIRb/RVjgLvFvW+U+KSoY=;
	b=JAEgQtq9GIcNCGj/6/66hoYyL5mYI4XSbxb9ZRsCcU1D+FtFOAal5/33CkzMXi+/mv
	2TfyheCJLA2u9JhO6J8knISv6vfmhGALCleyzPcAFZA99VSlT0tvSC78AyPUH3lTshfe
	/g+WuPrAg+p18zlH53YFVkUbsUavqQ55yLKPo3k67o+WtI60gwP25ccF+PtvzxRVBBs+
	l8amrDIQM6CG0bnILXCwlioW1y4WQElLzdinDk6OuY+iFyec/+Komuz6eJN9i8veHVil
	KyelBLj89d7PsozYW0L5Y61BZxm6Xjtn61pZkUzuMfvyajGA2ey8T+ImlvHuBJl1EGJ6
	UcCw==
X-Gm-Message-State: APjAAAVs8ZJB3ImoNLUbtme3zM+bYsbqSqP6GamDI3LIWm/mG0xtj3fZ
	AOQtEOlOhk2k+kOBxztO3GZr1yjGz9e7jihUeY9ucg==
X-Google-Smtp-Source: APXvYqxDT5OzCqjJantqJggK7nMHfDLOl2hcFlODbx4Jh6VSUctsOvtmO4GgjrDD3AHzRLRHwJWsAxNNMAXWqdPcxrM=
X-Received: by 2002:a05:6000:45:: with SMTP id
	k5mr7782985wrx.259.1570135874531; 
	Thu, 03 Oct 2019 13:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190301192017.39770-1-dianders@chromium.org>
	<CAJ+vNU0Ma5nG9_ThLO4cdO+=ivf7rmXiHZonF0HY0xx6X3R6Hw@mail.gmail.com>
	<5dce2964-8761-e7d0-8963-f0f5cb2feb02@arm.com>
In-Reply-To: <5dce2964-8761-e7d0-8963-f0f5cb2feb02@arm.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 3 Oct 2019 13:51:03 -0700
Message-ID: <CAJ+vNU0Q1-d7YDbAAEMqEcWnniqo6jLdKBbcUTar5=hJ+AC8vQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: Break insecure users by disabling
	bypass by default
To: Robin Murphy <robin.murphy@arm.com>
Cc: open list <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Douglas Anderson <dianders@chromium.org>, evgreen@chromium.org,
	iommu@lists.linux-foundation.org,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>,
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

On Thu, Oct 3, 2019 at 1:42 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Tim,
>
> On 2019-10-03 7:27 pm, Tim Harvey wrote:
> > On Fri, Mar 1, 2019 at 11:21 AM Douglas Anderson <dianders@chromium.org> wrote:
> >>
> >> If you're bisecting why your peripherals stopped working, it's
> >> probably this CL.  Specifically if you see this in your dmesg:
> >>    Unexpected global fault, this could be serious
> >> ...then it's almost certainly this CL.
> >>
> >> Running your IOMMU-enabled peripherals with the IOMMU in bypass mode
> >> is insecure and effectively disables the protection they provide.
> >> There are few reasons to allow unmatched stream bypass, and even fewer
> >> good ones.
> >>
> >> This patch starts the transition over to make it much harder to run
> >> your system insecurely.  Expected steps:
> >>
> >> 1. By default disable bypass (so anyone insecure will notice) but make
> >>     it easy for someone to re-enable bypass with just a KConfig change.
> >>     That's this patch.
> >>
> >> 2. After people have had a little time to come to grips with the fact
> >>     that they need to set their IOMMUs properly and have had time to
> >>     dig into how to do this, the KConfig will be eliminated and bypass
> >>     will simply be disabled.  Folks who are truly upset and still
> >>     haven't fixed their system can either figure out how to add
> >>     'arm-smmu.disable_bypass=n' to their command line or revert the
> >>     patch in their own private kernel.  Of course these folks will be
> >>     less secure.
> >>
> >> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> ---
> >
> > Hi Doug / Robin,
> >
> > I ran into this breaking things on OcteonTx boards based on CN80XX
> > CPU. The IOMMU configuration is a bit beyond me and I'm hoping you can
> > offer some advice. The IOMMU here is cavium,smmu-v2 as defined in
> > https://github.com/Gateworks/dts-newport/blob/master/cn81xx-linux.dtsi
> >
> > Booting with 'arm-smmu.disable_bypass=n' does indeed work around the
> > breakage as the commit suggests.
> >
> > Any suggestions for a proper fix?
>
> Ah, you're using the old "mmu-masters" binding (and in a way which isn't
> well-defined - it's never been specified what the stream ID argument(s)
> would mean for a PCI host bridge, and Linux just ignores them). The
> ideal thing would be to update the DT to generic "iommu-map" properties
> - it's been a long time since I last played with a ThunderX, but I
> believe the SMMU stream IDs should just be the same as the ITS device
> IDs (which is how the "mmu-masters" mapping would have played out anyway).
>
> The arm-smmu driver support for the old binding has always relied on
> implicit bypass - there are technical reasons why we can't realistically
> support the full functionality offered to the generic bindings, but it
> would be possible to add some degree of workaround to prevent it
> interacting quite so poorly with disable_bypass, if necessary. Do you
> have deployed systems with DTs that can't be updated, but still might
> need to run new kernels?
>

Robin,

Thanks for the response. I don't care too much about supporting new
kernels with the current DT - I'm good with fixing this with a DT
change. Would you be able to give me an example? I would love to see
Cavium mainline an cn81xx dts/dtsi in arch/arm64/boot/dts to be used
as a base as the only thing we have to go off of currently is the
Cavium SDK which has fairly old kernel support.

Thanks,

Tim
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
