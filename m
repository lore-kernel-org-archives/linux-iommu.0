Return-Path: <SRS0=kXp2=FW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB412C4361B
	for <iommu@archiver.kernel.org>; Fri, 18 Dec 2020 22:16:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1373923B98
	for <iommu@archiver.kernel.org>; Fri, 18 Dec 2020 22:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1373923B98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8CCF487B92;
	Fri, 18 Dec 2020 22:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JJ2L8cpVgPlO; Fri, 18 Dec 2020 22:16:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 64D2387B8F;
	Fri, 18 Dec 2020 22:16:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47A55C1787;
	Fri, 18 Dec 2020 22:16:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F309FC0893
 for <iommu@lists.linux-foundation.org>; Fri, 18 Dec 2020 22:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E684C87B91
 for <iommu@lists.linux-foundation.org>; Fri, 18 Dec 2020 22:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cenAxPdMQk0J for <iommu@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 22:15:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C1F6E87B8F
 for <iommu@lists.linux-foundation.org>; Fri, 18 Dec 2020 22:15:59 +0000 (UTC)
X-Gm-Message-State: AOAM532QdFQKkYqVNggB7Y++JcEMZaxknmZE1d7Rd/fPx07OLQ9v0G8Z
 aJMvmLmLCmeq0XT3cA69W0QeHQP7ZLDbyZaTXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608329759;
 bh=L5cHp2aBHEH2nkV21YAlr1aN5VhH2YQ9Lc4uz5DReP8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=lsoEVE30MHClxWSlfDo++WfPN3Oev8lyVreniCyTQ6iKJw39wzuNBlPUpyIsNQ46w
 HVTEFXTB7C6GJvzLda0hAdZenXbz+cW95yt5xhlBch9RVTJRtPoG5PPBNU3s+QKuF6
 SvTSEwm7wguEqDHrQgv88d9ihBANbzWbi87fcFEVcVDcmmEJ+CxiGg6+bHYhpiFcmN
 9xKoYo5R0Jxybpv3sm9j0rzxkj5nITY3RfOUR1I3Gh3goDv72Yhkr008C3OmxinNCR
 scJbDBJFurh9xSLJSuUb5aeXFUpDmLW//r1uDy6u7Yq0v7PtzDEcBpllRbGzIMOkdw
 jb+pDRasOQcoA==
X-Google-Smtp-Source: ABdhPJyIlsFlS0Zu4otFlCIT81qP3/RBN8BFoPBWsXrVJPxykPGGIf0yMslATK3IaeBON3VDpK68IO3FVpdHDp15HSE=
X-Received: by 2002:a17:907:2111:: with SMTP id
 qn17mr5904771ejb.525.1608329757408; 
 Fri, 18 Dec 2020 14:15:57 -0800 (PST)
MIME-Version: 1.0
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <20200914220829.GA330122@bogus> <20200915123648.GA3496938@ulmo>
 <20200924112725.GA2486709@ulmo> <20201105164312.GD485884@ulmo>
 <483cd043-980e-81fb-cccb-385206a699df@arm.com> <20201106152548.GA767203@ulmo>
 <20201110193309.GB2303484@ulmo> <X9tyc3t2MgtiFwwb@ulmo>
In-Reply-To: <X9tyc3t2MgtiFwwb@ulmo>
From: Rob Herring <robh@kernel.org>
Date: Fri, 18 Dec 2020 16:15:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJqupMdr8vSWPTpYEGmcjKDqoKjMCYY-BvSLpxzkovx7Q@mail.gmail.com>
Message-ID: <CAL_JsqJqupMdr8vSWPTpYEGmcjKDqoKjMCYY-BvSLpxzkovx7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
To: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>
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

On Thu, Dec 17, 2020 at 9:00 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Nov 10, 2020 at 08:33:09PM +0100, Thierry Reding wrote:
> > On Fri, Nov 06, 2020 at 04:25:48PM +0100, Thierry Reding wrote:
> > > On Thu, Nov 05, 2020 at 05:47:21PM +0000, Robin Murphy wrote:
> > > > On 2020-11-05 16:43, Thierry Reding wrote:
> > > > > On Thu, Sep 24, 2020 at 01:27:25PM +0200, Thierry Reding wrote:
> > > > > > On Tue, Sep 15, 2020 at 02:36:48PM +0200, Thierry Reding wrote:
> > > > > > > On Mon, Sep 14, 2020 at 04:08:29PM -0600, Rob Herring wrote:
> > > > > > > > On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding wrote:
> > > > > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > > > > >
> > > > > > > > > Reserved memory regions can be marked as "active" if hardware is
> > > > > > > > > expected to access the regions during boot and before the operating
> > > > > > > > > system can take control. One example where this is useful is for the
> > > > > > > > > operating system to infer whether the region needs to be identity-
> > > > > > > > > mapped through an IOMMU.
> > > > > > > >
> > > > > > > > I like simple solutions, but this hardly seems adequate to solve the
> > > > > > > > problem of passing IOMMU setup from bootloader/firmware to the OS. Like
> > > > > > > > what is the IOVA that's supposed to be used if identity mapping is not
> > > > > > > > used?
> > > > > > >
> > > > > > > The assumption here is that if the region is not active there is no need
> > > > > > > for the IOVA to be specified because the kernel will allocate memory and
> > > > > > > assign any IOVA of its choosing.
> > > > > > >
> > > > > > > Also, note that this is not meant as a way of passing IOMMU setup from
> > > > > > > the bootloader or firmware to the OS. The purpose of this is to specify
> > > > > > > that some region of memory is actively being accessed during boot. The
> > > > > > > particular case that I'm looking at is where the bootloader set up a
> > > > > > > splash screen and keeps it on during boot. The bootloader has not set up
> > > > > > > an IOMMU mapping and the identity mapping serves as a way of keeping the
> > > > > > > accesses by the display hardware working during the transitional period
> > > > > > > after the IOMMU translations have been enabled by the kernel but before
> > > > > > > the kernel display driver has had a chance to set up its own IOMMU
> > > > > > > mappings.
> > > > > > >
> > > > > > > > If you know enough about the regions to assume identity mapping, then
> > > > > > > > can't you know if active or not?
> > > > > > >
> > > > > > > We could alternatively add some property that describes the region as
> > > > > > > requiring an identity mapping. But note that we can't make any
> > > > > > > assumptions here about the usage of these regions because the IOMMU
> > > > > > > driver simply has no way of knowing what they are being used for.
> > > > > > >
> > > > > > > Some additional information is required in device tree for the IOMMU
> > > > > > > driver to be able to make that decision.
> > > > > >
> > > > > > Rob, can you provide any hints on exactly how you want to move this
> > > > > > forward? I don't know in what direction you'd like to proceed.
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > do you have any suggestions on how to proceed with this? I'd like to get
> > > > > this moving again because it's something that's been nagging me for some
> > > > > months now. It also requires changes across two levels in the bootloader
> > > > > stack as well as Linux and it takes quite a bit of work to make all the
> > > > > changes, so before I go and rewrite everything I'd like to get the DT
> > > > > bindings sorted out first.
> > > > >
> > > > > So just to summarize why I think this simple solution is good enough: it
> > > > > tries to solve a very narrow and simple problem. This is not an attempt
> > > > > at describing the firmware's full IOMMU setup to the kernel. In fact, it
> > > > > is primarily targetted at cases where the firmware hasn't setup an IOMMU
> > > > > at all, and we just want to make sure that when the kernel takes over
> > > > > and does want to enable the IOMMU, that all the regions that are
> > > > > actively being accessed by non-quiesced hardware (the most typical
> > > > > example would be a framebuffer scanning out a splat screen or animation,
> > > > > but it could equally well be some sort of welcoming tone or music being
> > > > > played back) are described in device tree.
> > > > >
> > > > > In other words, and this is perhaps better answering your second
> > > > > question: in addition to describing reserved memory regions, we want to
> > > > > add a bit of information here about the usage of these memory regions.
> > > > > Some memory regions may contain information that the kernel may want to
> > > > > use (such an external memory frequency scaling tables) and those I would
> > > > > describe as "inactive" memory because it isn't being accessed by
> > > > > hardware. The framebuffer in this case is the opposite and it is being
> > > > > actively accessed (hence it is marked "active") by hardware while the
> > > > > kernel is busy setting everything up so that it can reconfigure that
> > > > > hardware and take over with its own framebuffer (for the console, for
> > > > > example). It's also not so much that we know enough about the region to
> > > > > assume it needs identity mapping. We don't really care about that from
> > > > > the DT point of view. In fact, depending on the rest of the system
> > > > > configuration, we may not need identity mapping (i.e. if none of the
> > > > > users of the reserved memory region are behind an IOMMU). But the point
> > > > > here is that the IOMMU drivers can use this "active" property to
> > > > > determine that if a device is using an "active" region and it is behind
> > > > > an IOMMU, then it must identity map that region in order for the
> > > > > hardware, which is not under the kernel's control yet, to be able to
> > > > > continue to access that memory through an IOMMU mapping.
> > > >
> > > > Hmm, "active" is not a property of the memory itself, though, it's really a
> > > > property of the device accessing it. If several distinct devices share a
> > > > carveout region, and for simplicity the bootloader marks it as active
> > > > because one of those devices happens to be using some part of it at boot, we
> > > > don't really want to have to do all the reserved region setup for all the
> > > > other devices unnecessarily, when all that matters is not disrupting one of
> > > > them when resetting the IOMMU.
> > > >
> > > > That leads to another possible hiccup - some bindings already have a defined
> > > > meaning for a "memory-region" property. If we use that to point to some
> > > > small region for a temporary low-resolution bootsplash screen for visibility
> > > > to an IOMMU driver, the device's own driver might also interpret it as a
> > > > private carveout from which it is expected to allocate everything, and thus
> > > > could end up failing to work well or at all.
> > > >
> > > > I agree that we should only need a relatively simple binding, and that
> > > > piggybacking off reserved-memory nodes seems like an ideal way of getting
> > > > address range descriptions without too much extra complexity; the tricky
> > > > part is how best to associate those with the other information needed, which
> > > > is really the "iommus" property of the relevant device, and how to make it
> > > > as generically discoverable as possible. Perhaps it might be workable to
> > > > follow almost the same approach but with a dedicated property (e.g.
> > > > "active-memory-region") that the IOMMU code can simply scan the DT for to
> > > > determine relevant device nodes. Otherwise properties on the IOMMU node
> > > > itself would seem the next most practical option.
> > >
> > > We did recently introduce a "memory-region-names" property that's used
> > > to add context for cases where multiple memory regions are used. Perhaps
> > > the simplest to address the above would be to describe the region as
> > > active by naming it "active". That has the disadvantage of restricting
> > > the number of active regions to 1, though I suspect that may even be
> > > enough for the vast majority of cases where we need this. This would be
> > > similar to how we use the "dma-mem" string in the "interconnect-names"
> > > property to specify the "DMA parent" of a device node.
> > >
> > > Alternatively, we could perhaps support multiple occurrences of "active"
> > > in the "memory-region-names" property. Or we could add a bit of
> > > flexibility by considering all memory regions whose names have an
> > > "active-" prefix as being active.
> > >
> > > > We've also finally got things going on the IORT RMR side[1], which helps add
> > > > a bit more shape to things too; beyond the actual firmware parsing, DT and
> > > > ACPI systems should definitely be converging on the same internal
> > > > implementation in the IOMMU layer.
> > >
> > > Yeah, from a quick look at that series, this actually sounds really
> > > close to what I'm trying to achieve here.
> > >
> > > The patch set that I have would nicely complement the code added to
> > > iommu_dma_get_resv_regions() for RMR regions. It's not exactly the same
> > > code, but it's basically the DT equivalent of
> > > iort_dev_rmr_get_resv_regions().
> >
> > Hi Rob,
> >
> > what's your preference here for DT bindings? Do you want me to reuse the
> > existing memory-region/memory-region-names properties, or do you want
> > something completely separate?

I think that's overloading memory-region-names as *-names is a name
local to a binding to augment an index.

>
> Hi Rob,
>
> I've been thinking about this some more and I think I've come up with an
> alternative that I think you might like better than what we discussed so
> far.
>
> Rather than reusing memory-region-names and guessing from the name what
> the intended purpose was, how about we add the concept of memory region
> specifiers to describe additional properties of reserved memory regions
> uses? This would allow us to address Robin's concerns about describing
> what's essentially a device property within the reserved memory region.
>
> The way I imagine that this would work is that the reserved memory
> regions would gain a new property, "#memory-region-cells", that defines
> the number of cells that make up a reserved memory region specifier,
> much like we have #clock-cells, #reset-cells, #pwm-cells, etc. Since
> these specifier are defined where the regions are used, they would allow
> us to encode information about that specific use, rather than properties
> of the regions themselves.
>
> This should also allow for backwards-compatibility where a missing
> #memory-region-cells would be interpreted as 0 specifier (i.e. no
> additional data).
>
> Here's how this would look for the specific example that I want to
> solve:
>
>         #define MEMORY_REGION_ACTIVE 0x1
>
>         / {
>                 reserved-memory {
>                         lut: lookup-table@96060000 {
>                                 reg = <0x96060000 0x00010000>;
>                                 #memory-region-cells = <1>;
>                         };
>
>                         fbc: framebuffer@96070000 {
>                                 reg = <0x96070000 0x800000>;
>                                 #memory-region-cells = <1>;
>                         };
>                 };
>
>                 ...
>
>                 host1x@50000000 {
>                         ...
>
>                         display@54200000 {
>                                 ...
>                                 memory-regions = <&fbc MEMORY_REGION_ACTIVE>,
>                                                  <&lut MEMORY_REGION_ACTIVE>;
>                                 ...
>                         };
>
>                         ...
>                 };
>         };
>
> As you can see, the reserved memory region nodes only contain properties
> that are immediately related to the regions themselves, whereas the
> "active" attribute now applies only for the specific use of the region
> within display@54200000.
>
> What do you think?

When would these regions ever not be active? Isn't just the fact that
you have the 'memory-regions' property enough to know that they are
active (possibly combined with seeing the display h/w is already
enabled)? I guess if the idea is to parse 'memory-regions' for the
whole DT and find the active ones, you'd need the flag (and presumably
an 'iommus' property too).

Do you have a usecase for this outside of the display enabled by
bootloader? Because we already have the simple-framebuffer binding of
which the memory region is just part of it. Wouldn't the presence of a
memory region there imply it's active as well?

Or maybe the iommu node(s) should just have a 'memory-regions' property?

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
