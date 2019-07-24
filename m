Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CADC7618F
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 16:11:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3BC21841
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 16:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVuuHA2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3BC21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 81B62E7B;
	Wed, 24 Jul 2019 16:11:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B0BDAE50
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 16:11:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8D12A701
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 16:11:55 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id d4so47640894edr.13
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=BcPYpR9djhaAnW7bmdaXKS87Ax5QIqkCxuLZrAiV9mQ=;
	b=cVuuHA2c2hmZ1JZ77+HbfslSKbGPv3c3+EO5CcF0SdOPaiZbD1c19Z2G6/z4E3s/wd
	6x6eglO2cwi45TxHB76FO7V4aPgD6U1mQXvolig1tck5UO13xUuAUtYZoOgADYnd58Om
	cBFBQEHNck17IEdM2yJsvobMNW6ytF+mbNF3lk/V3q21tIleWbAun5vDG4f2OD6ruckJ
	SE0FpfhHBTlHrNoYSJCdlbxOcQoeGJa3yGFv4b8UVznsu6qY/fXVtTzRQ+E3UwqeOl57
	S03mFg4EDwHc5h4nEI8fUnm4fErXaE3accQk42M0EHZOF/GAzr0ARQ3ocB1ugjoyDDyv
	ESPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=BcPYpR9djhaAnW7bmdaXKS87Ax5QIqkCxuLZrAiV9mQ=;
	b=Vmap7v1EgOy8Z0mM8ZOJGczQp/WjAx16mmrOVbwfAQH14HzWc1Ehw1FJz2ylRzVakk
	jyN/SiTa2j3ineOuq/J9wHZnroquH24oRm1Y/oJ9jbw/tiP+HM9JdBa3KYcGZKFWGjMZ
	Zqk0yAFJl/nIxFvYbQzQxAs1EtsplqxKw1+fr56GbUJ6Qp6WyMK5BltdVLbE9Dr1Cvzc
	yHN+zjSFf8ebJE5Viwp/dfLuXmeWcO9fV9JL3hFe/iLJKKvMBCDD14PTirdl/uUnaq9w
	R5TnjCP7ytmFd8bMjF7KEsURHjAYA7CAOPZJENqSSon7qy3NPHVtdhZVdZCeilwkJODJ
	i5wQ==
X-Gm-Message-State: APjAAAVRLlNX89okyXMXkVqQvWSjvz2+yd1UWnjqv2JrzZTMnnBcXAUf
	gOIwv/9EfnAbUOvQlYClkyScLxtNwrWYcOffi8s=
X-Google-Smtp-Source: APXvYqwnKz9+2R8hHcVfd0x/lvnHSBr5dPATrNP0dt3ip0omN9IfWY8hedoH3nZfWjSJPNlTslQKwkgg3Tr0lC5VCoU=
X-Received: by 2002:a17:906:3612:: with SMTP id
	q18mr64994404ejb.278.1563984714038; 
	Wed, 24 Jul 2019 09:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190702202631.32148-2-robdclark@gmail.com>
	<20190710182844.25032-1-robdclark@gmail.com>
	<20190722142833.GB12009@8bytes.org>
	<CAF6AEGvJc2RK3GkpcXiVKsuTX81D3oahnu=qWJ9LFst1eT3tMg@mail.gmail.com>
	<20190722154803.GG12009@8bytes.org>
	<CAF6AEGvWf3ZOrbyyWjORuOVEPOcPr+JSEO78aYjhL-GVhDZnTg@mail.gmail.com>
	<20190723153822.gm4ossn43nvqbyak@willie-the-truck>
	<CAF6AEGtL6gqtbmtksf7zCSGrFOEj0ynq-2nwvizLLiS0FTwHpg@mail.gmail.com>
	<20190724105116.fwhnbfuglbbojjzu@willie-the-truck>
In-Reply-To: <20190724105116.fwhnbfuglbbojjzu@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 24 Jul 2019 09:11:42 -0700
Message-ID: <CAF6AEGsmNtwjQQPjwzFBJSAV9dPLFH5=-vkchz0KHgL1yz3mYg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: add support for drivers that manage iommu
	explicitly
To: Will Deacon <will@kernel.org>
Cc: Rob Clark <robdclark@chromium.org>, aarch64-laptops@lists.linaro.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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

On Wed, Jul 24, 2019 at 3:51 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jul 23, 2019 at 10:40:55AM -0700, Rob Clark wrote:
> > On Tue, Jul 23, 2019 at 8:38 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Jul 22, 2019 at 09:23:48AM -0700, Rob Clark wrote:
> > > > On Mon, Jul 22, 2019 at 8:48 AM Joerg Roedel <joro@8bytes.org> wrote:
> > > > >
> > > > > On Mon, Jul 22, 2019 at 08:41:34AM -0700, Rob Clark wrote:
> > > > > > It is set by the driver:
> > > > > >
> > > > > > https://patchwork.freedesktop.org/patch/315291/
> > > > > >
> > > > > > (This doesn't really belong in devicetree, since it isn't a
> > > > > > description of the hardware, so the driver is really the only place to
> > > > > > set this.. which is fine because it is about a detail of how the
> > > > > > driver works.)
> > > > >
> > > > > It is more a detail about how the firmware works. IIUC the problem is
> > > > > that the firmware initializes the context mappings for the GPU and the
> > > > > OS doesn't know anything about that and just overwrites them, causing
> > > > > the firmware GPU driver to fail badly.
> > > > >
> > > > > So I think it is the task of the firmware to tell the OS not to touch
> > > > > the devices mappings until the OS device driver takes over. On x86 there
> > > > > is something similar with the RMRR/unity-map tables from the firmware.
> > > > >
> > > >
> > > > Bjorn had a patchset[1] to inherit the config from firmware/bootloader
> > > > when arm-smmu is probed which handles that part of the problem.  My
> > > > patch is intended to be used on top of his patchset.  This seems to me
> > > > like the best solution, if we don't have control over the firmware.
> > >
> > > Hmm, but the feedback from Robin on the thread you cite was that this should
> > > be generalised to look more like RMRR, so there seems to be a clear message
> > > here.
> > >
> >
> > Perhaps it is a lack of creativity, or lack of familiarity w/ iommu vs
> > virtualization, but I'm not quite seeing how RMRR would help.. in
> > particular when dealing with both DT and ACPI cases.
>
> Well, I suppose we'd have something for DT and something for ACPI and we'd
> try to make them look similar enough that we don't need lots of divergent
> code in the kernel. The RMRR-like description would describe that, for a
> particular device, a specific virt:phys mapping needs to exist in the
> small window between initialising the SMMU and re-initialising the device
> (GPU).

For both DT and ACPI (or perhaps more accurately UEFI and non-UEFI) we
often don't have much/any control of the firmware.  In the UEFI case,
we can at least get the physical address of the scanout buffer from
EFI GOP (since VA=PA at that point).  In either case we could get the
iova by reading back controller state.  We kinda just need the iommu
driver to not change anything about the context bank the display is
using until the display driver is ready to install it's own
pagetables.

Initially I just want to shut down display, and then bring it back up
w/ my own pagetables.. but eventually, once iommu/clk/genpd issues are
sorted upstream, I'm planning to read out more completely the display
state, and remap the existing scanout buffer at same iova in my own
pagetables/iommu_domain, for a flicker-free display handover... that
is a lot more work but at least it is self contained in the display
(and bridge/panel) drivers.

> I would prefer this to be framebuffer-specific, since we're already in
> flagrant violation of the arm64 boot requirements wrt ongoing DMA and making
> this too general could lead to all sorts of brain damage. That would
> probably also allow us to limit the flexibility, by mandating things like
> alignment and memory attributes.

I'd be pretty happy if we could convince qcom to use EFI GOP on
android devices too..

Although there is a lot more activity these days with people bringing
upstream support to various existing android phones/tablets.. and I'd
like to see that continue without downstream hacks due to lack of
control over firmware.

> Having said that, I just realised I'm still a bit confused about the
> problem: why does the bootloader require SMMU translation for the GPU at
> all? If we could limit this whole thing to be identity-mapped/bypassed,
> then all we need is a per-device flag in the firmware to indicate that the
> SMMU should be initialised to allow passthrough for transactions originating
> from that device.

I was chatting last night w/ Bjorn on IRC.. and he mentioned that it
looked like TTBRn was 0x0.  Which I wasn't expecting, and I didn't
realize was a legit thing.  Maybe the purpose is to allow display to
access memory w/ iova==pa but disallow memory access from other
devices using different context banks of the same iommu?  Maybe this
makes more sense to you?

> > So I kinda prefer, when possible, if arm-smmu can figure out what is going
> > on by looking at the hw state at boot (since that approach would work
> > equally well for DT and ACPI).
>
> That's not going to fly.
>
> Forcing Linux to infer the state of the system by effectively parsing the
> hardware configuration directly is fragile, error-prone and may not even be
> possible in the general case. Worse, if this goes wrong, the symptoms are
> very likely to be undiagnosable memory corruption, which is pretty awful in
> my opinion.

So, I guess in a DT world, we could have some boot-on; flag in the
device node.. that tells the iommu driver the stream-id(s) which might
be in use.  I guess the iommu driver would still need to map that back
to context bank, and then leave that CB and stream<->CB mapping alone.
But I think that would at least prevent "false positives", which I
think is what you are worrying about.

I'm not sure how this would work for ACPI, but tbh I haven't looked
yet at how iommu and device are connected w/ ACPI.

> Not only would you need separate parsing code for every IOMMU out there,
> but you'd also need to make Linux aware of device aspects that it otherwise
> doesn't care about, just in case the firmware decided to use them.
> Furthermore, running an older kernel on newer hardware (which may have some
> extensions), could cause the parsing to silently ignore parts of the device
> that indicate memory regions which are in use. On top of that, there made be
> device-global state that we are unable to reconfigure and that affect
> devices other than the ones in question.

I'm not sure you can avoid having *some* amount of code in each iommu
driver, since the exact meaning of iommu-cells can be different.. but
I guess we could come up with a generic way of determining which
device(s) attached to an iommu might be active when the iommu driver
probes.

> So no, I'm very much against this approach and the solution absolutely needs
> to come in the form of a more abstract description from firmware.
>
> > I *think* (but need to confirm if Bjorn hasn't already) that the
> > memory for the pagetables that firmware/bootloader sets up is already
> > removed from the memory map efi passes to kernel, so we don't need to
> > worry about kernel stomping in-use pagetables.
>
> It's precisely this sort of fragility that makes me nervous about this whole
> approach.

See above about TTBRn==null.. although if there were actually
pagetables, they would need to be reserved memory, otherwise I guess
windows would also have a problem w/ stomping pagetables.

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
