Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EA0C433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 08:04:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13D164EB8
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 08:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13D164EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 77E8C85087;
	Tue,  9 Feb 2021 08:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ETJmbaovvJa; Tue,  9 Feb 2021 08:04:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D31F78495A;
	Tue,  9 Feb 2021 08:04:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C075FC0174;
	Tue,  9 Feb 2021 08:04:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58489C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 08:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 43F5085036
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 08:04:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kEwPMTMoMNOG for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 08:04:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9DF588495A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 08:04:32 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE0D664E50;
 Tue,  9 Feb 2021 08:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612857872;
 bh=zPK+5MZsx1tSvH2HRp1p3HtPtCmnOHY9jiF0A95/QwE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Avm+GfAVXF4EksYujMA/CDdtYumq9mFdLJEs2zSEghuaaGAEeAmAE8ALnUIuCt+aM
 zb7IZIEoOJxxxT8U7DM62ZovMxPGZGcVVPmz0oBWmqNTKEf33vg9GEFOaSVsNBjQo+
 fNJYB/4IPVoWeLGW/uCJ6r0XhQ7Q6Qyb82RAit68=
Date: Tue, 9 Feb 2021 09:04:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sumit Garg <sumit.garg@linaro.org>
Subject: Re: DMA direct mapping fix for 5.4 and earlier stable branches
Message-ID: <YCJCDZGa1Dhqv6Ni@kroah.com>
References: <CAFA6WYNazCmYN20irLdNV+2vcv5dqR+grvaY-FA7q2WOBMs__g@mail.gmail.com>
 <YCIym62vHfbG+dWf@kroah.com>
 <CAFA6WYM+xJ0YDKenWFPMHrTz4gLWatnog84wyk31Xy2dTiT2RA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFA6WYM+xJ0YDKenWFPMHrTz4gLWatnog84wyk31Xy2dTiT2RA@mail.gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, obayashi.yoshimasa@socionext.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de
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

On Tue, Feb 09, 2021 at 01:28:47PM +0530, Sumit Garg wrote:
> Thanks Greg for your response.
> 
> On Tue, 9 Feb 2021 at 12:28, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 09, 2021 at 11:39:25AM +0530, Sumit Garg wrote:
> > > Hi Christoph, Greg,
> > >
> > > Currently we are observing an incorrect address translation
> > > corresponding to DMA direct mapping methods on 5.4 stable kernel while
> > > sharing dmabuf from one device to another where both devices have
> > > their own coherent DMA memory pools.
> >
> > What devices have this problem?
> 
> The problem is seen with V4L2 device drivers which are currently under
> development for UniPhier PXs3 Reference Board from Socionext [1].

Ok, so it's not even a driver in the 5.4 kernel today, so there's
nothing I can do here as there is no regression of the existing source
tree.

> Following is brief description of the test framework:
> 
> The issue is observed while trying to construct a Gstreamer pipeline
> leveraging hardware video converter engine (VPE device) and hardware
> video encode/decode engine (CODEC device) where we use dmabuf
> framework for Zero-Copy.
> 
> Example GStreamer pipeline is:
> gst-launch-1.0 -v -e videotestsrc \
> > ! video/x-raw, width=480, height=270, format=NV15 \
> > ! v4l2convert device=/dev/vpe0 capture-io-mode=dmabuf-import \
> > ! video/x-raw, width=480, height=270, format=NV12 \
> > ! v4l2h265enc device=/dev/codec0 output-io-mode=dmabuf \
> > ! video/x-h265, format=byte-stream, width=480, height=270 \
> > ! filesink location=out.hevc
> 
> Using GStreamer's V4L2 plugin,
> - v4l2convert controls VPE driver,
> - v4l2h265enc controls CODEC driver.
> 
> In the above pipeline, VPE driver imports CODEC driver's DMABUF for Zero-Copy.
> 
> [1] arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
> 
> > And why can't then just use 5.10 to
> > solve this issue as that problem has always been present for them,
> > right?
> 
> As the drivers are currently under development and Socionext has
> chosen 5.4 stable kernel for their development. So I will let
> Obayashi-san answer this if it's possible for them to migrate to 5.10
> instead?

Why pick a kernel that doesn not support the features they require?
That seems very odd and unwise.

> BTW, this problem belongs to the common code, so others may experience
> this issue as well.

Then they should move to 5.10 or newer as this just doesn't work on
older kernels, right?

> > > I am able to root cause this issue which is caused by incorrect virt
> > > to phys translation for addresses belonging to vmalloc space using
> > > virt_to_page(). But while looking at the mainline kernel, this patch
> > > [1] changes address translation from virt->to->phys to dma->to->phys
> > > which fixes the issue observed on 5.4 stable kernel as well (minimal
> > > fix [2]).
> > >
> > > So I would like to seek your suggestion for backport to stable kernels
> > > (5.4 or earlier) as to whether we should backport the complete
> > > mainline commit [1] or we should just apply the minimal fix [2]?
> >
> > Whenever you try to create a "minimal" fix, 90% of the time it is wrong
> > and does not work and I end up having to deal with the mess.
> 
> I agree with your concerns for having to apply a non-mainline commit
> onto a stable kernel.
> 
> >  What
> > prevents you from doing the real thing here?  Are the patches to big?
> >
> 
> IMHO, yes the mainline patch is big enough to touch multiple
> architectures. But if that's the only way preferred then I can
> backport the mainline patch instead.
> 
> > And again, why not just use 5.10 for this hardware?  What hardware is
> > it?
> >
> 
> Please see my response above.

If a feature in the kernel was not present on older kernels, trying to
shoe-horn it into them is not wise at all.  You pick a kernel version
to reflect the features/options that you require, and it sounds like 5.4
just will not work for them, so to stick with that would be quite
foolish.

Just move to 5.10, much simpler!

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
