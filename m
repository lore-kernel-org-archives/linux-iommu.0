Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F2AC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 03:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 906A241702;
	Thu, 24 Mar 2022 03:09:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0qlm0Fm46yU; Thu, 24 Mar 2022 03:09:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F551409B6;
	Thu, 24 Mar 2022 03:09:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DBAAC001A;
	Thu, 24 Mar 2022 03:09:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22B22C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 03:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F09314012F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 03:09:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YJdzENYlI3qB for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 03:09:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF49F40128
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 03:09:49 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AE8DA3F6C5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 03:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1648091384;
 bh=yfWPx49ia0Oq9KnR/zdf6cTRm4Fx3KUjs75NQ5Bs2aQ=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=PJP5cKoML4n19Ls2rhrajAqXHps4CzA89rrHFiXiMpPb/Ihu6cMcy8l34L9mEESBb
 L1wXG51NhCrEfjAXN85JbdgrlHkSdUx0/wyZPu3yoLG2+5NG7anK/7QGtagg8qUep/
 Bs3lNRkUgqvNXwinVSDDzzGMx0LMP8AVmPdd9aaZ0Z3tyO+deOHa3SoXez4QjF9Es8
 VKbL5BrPfepvKEYJZcZ+Lw2EY0gEbzikSt25QK2h1D38xGSBtSI9D3++UNBItBRA0V
 sPnqOVmFHUXwD7gfrmZvCdJI6pTxqXcgt23Z9una8LveqjVlTaD/o/21SRyG7oXFVw
 6UJkmxJfqTsRA==
Received: by mail-io1-f72.google.com with SMTP id
 k20-20020a5e9314000000b00649d55ffa67so2280788iom.20
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 20:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yfWPx49ia0Oq9KnR/zdf6cTRm4Fx3KUjs75NQ5Bs2aQ=;
 b=jpHT892NjYR/u1SnJC/iylTEFVTJTSDgRBGSwTR3G40HC7FtqwIfPehOVshqZ6uh5W
 4WtDQJg/iAEqxhYLhtJ5n9E2o567IOQEPFO8jkg0OT1ieAzfwEqn+RHz6hzyll+HmpTA
 a1K9UZ/yBC2wv8eBE2bINot57kbQvRVvczVDQCDJbWld7t3KPlE3jzyI50VNLKOPxa8V
 e8VO+J87OIOI4aHBdrp5kM/sbsDqYyvxzquAk9R8HL5A0vcouZqHCgWgfum5MlIii/Jz
 fnukI0Yz7E2rCPG7T6oDhn2gcGYAO+j8u9pzRoeUSJ015z1rbvcFBZ5p5nqT/+XTV8kd
 kWYQ==
X-Gm-Message-State: AOAM530RphtCZITK1ETejuUfvTz2J38PZLYrmDPEdOErsO8FhQNfk7Xm
 /E6d3rye68C2uPJBW+iDYtT0rw5rnjVNbiw08geyzMaWoW1Ni33HRFMdeF2h+2yvOLz9Etp7ttt
 /KL9kbp0vgdmMDQQwnml8W8EC1xz0TuXN4CHh+VhOZe/pLmw=
X-Received: by 2002:a05:6638:4129:b0:319:f5e5:2d21 with SMTP id
 ay41-20020a056638412900b00319f5e52d21mr1775619jab.148.1648091383544; 
 Wed, 23 Mar 2022 20:09:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6e3IYZRLfskdJ+DZp2Uaz51HnZfEwes4aBSpX0UEk+ZXiYNBuaMeCuXyfqFYokd4kyWP1iQ==
X-Received: by 2002:a05:6638:4129:b0:319:f5e5:2d21 with SMTP id
 ay41-20020a056638412900b00319f5e52d21mr1775608jab.148.1648091383293; 
 Wed, 23 Mar 2022 20:09:43 -0700 (PDT)
Received: from xps13.dannf (c-73-14-97-161.hsd1.co.comcast.net. [73.14.97.161])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a92194f000000b002c25e778042sm885509ilm.73.2022.03.23.20.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 20:09:42 -0700 (PDT)
Date: Wed, 23 Mar 2022 21:09:39 -0600
From: dann frazier <dann.frazier@canonical.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iommu/dma: Explicitly sort PCI DMA windows
Message-ID: <Yjvg846XOpsAbgi6@xps13.dannf>
References: <65657c5370fa0161739ba094ea948afdfa711b8a.1647967875.git.robin.murphy@arm.com>
 <874k3pxalr.wl-maz@kernel.org> <Yjub51Ct3esuNA9B@xps13.dannf>
 <CAL_JsqLFnN46WixKwsuhPswNo8fye4ERhU7_hPdPABi=70p7HA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqLFnN46WixKwsuhPswNo8fye4ERhU7_hPdPABi=70p7HA@mail.gmail.com>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, Mar 23, 2022 at 07:55:23PM -0500, Rob Herring wrote:
> On Wed, Mar 23, 2022 at 5:15 PM dann frazier <dann.frazier@canonical.com> wrote:
> >
> > On Wed, Mar 23, 2022 at 09:49:04AM +0000, Marc Zyngier wrote:
> > > On Tue, 22 Mar 2022 17:27:36 +0000,
> > > Robin Murphy <robin.murphy@arm.com> wrote:
> > > >
> > > > Originally, creating the dma_ranges resource list in pre-sorted fashion
> > > > was the simplest and most efficient way to enforce the order required by
> > > > iova_reserve_pci_windows(). However since then at least one PCI host
> > > > driver is now re-sorting the list for its own probe-time processing,
> > > > which doesn't seem entirely unreasonable, so that basic assumption no
> > > > longer holds. Make iommu-dma robust and get the sort order it needs by
> > > > explicitly sorting, which means we can also save the effort at creation
> > > > time and just build the list in whatever natural order the DT had.
> > > >
> > > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > > ---
> > > >
> > > > Looking at this area off the back of the XGene thread[1] made me realise
> > > > that we need to do it anyway, regardless of whether it might also happen
> > > > to restore the previous XGene behaviour or not. Presumably nobody's
> > > > tried to use pcie-cadence-host behind an IOMMU yet...
> > >
> > > This definitely restores PCIe functionality on my Mustang (XGene-1).
> > > Hopefully dann can comment on whether this addresses his own issue, as
> > > his firmware is significantly different.
> >
> > Robin, Marc,
> >
> > Adding just this patch on top of v5.17 (w/ vendor dtb) isn't enough to
> > fix m400 networking:
> 
> I wouldn't expect it to given both the IB register selection changed
> and the 2nd dma-ranges entry is ignored.
> 
> Can you (and others) try out this branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git xgene-pci-fix
> 
> It should maintain the same IB register usage for both cases and
> handle the error in 'dma-ranges'.

Looks good Rob :)

https://paste.ubuntu.com/p/zJF9PKhQpS/


  -dann

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
