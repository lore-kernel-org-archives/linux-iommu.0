Return-Path: <SRS0=497D=MR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FACC4338F
	for <iommu@archiver.kernel.org>; Sun, 25 Jul 2021 12:41:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8821260F37
	for <iommu@archiver.kernel.org>; Sun, 25 Jul 2021 12:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8821260F37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 420D882A0B;
	Sun, 25 Jul 2021 12:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvJ89NwkdqDq; Sun, 25 Jul 2021 12:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8B171826C1;
	Sun, 25 Jul 2021 12:41:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E4D2C001A;
	Sun, 25 Jul 2021 12:41:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DBD0C000E
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 12:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4447940154
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 12:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="ZBkKjtZ/";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="Kgho/LE9"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7_zcS9UqmAjU for <iommu@lists.linux-foundation.org>;
 Sun, 25 Jul 2021 12:41:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5415400E5
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 12:41:16 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id BF1F2580447;
 Sun, 25 Jul 2021 08:41:13 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Sun, 25 Jul 2021 08:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=9Vxtwp0zDM7hmdE838Qhd0C2fpYY
 IhzFdv/zN3orH/E=; b=ZBkKjtZ/p+iJv+ypBsDPVbWyt0K0Yv1PaIgL6zPdycJD
 cyCkNSs+Mnqx0WtDPk0aQwYl9v+zvyRm24V0Em+jrInt8erb3gFpLG+we3turqTy
 2in6I0qehD8yL74RP219VRGdiSwVfna/3UTFCP05bN/oZI4UgGDXhh21MVna6nFi
 T6Fwvn0mo36lhhWEJsVIzCpE8btY5N4HQpds44qO6adeOAq0C7K1+ZQ062gS+ICR
 bw6KmAEp25o8P92mFCaVPlFvySrXJQALcFz6R86CK2bamYDHPAF3vfFGT0cNdyG2
 hvS4bS9UesGrY6jxh6i8Gu1BFA11j+Vjx0h8LaqOtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9Vxtwp
 0zDM7hmdE838Qhd0C2fpYYIhzFdv/zN3orH/E=; b=Kgho/LE9ekfsCahxeIaC/N
 gdmTg4LlM50NHCPBiE4xb/rZvY4nQeC9DG7paeFnSxj8jjqz3EPyG0QMlz7Guwm3
 7sGGhQ8lGAHrBicULrVCQDZG3QMReQ1VnEJP1I+ptlttbcow3G0qyBpJbGHdJ0xT
 abDT6YKFNV2gUSRCVQBqmSCmu/9CM6SheFiSeD3VUgq+2HY0PDVkC4EkGkGIaXOv
 z4O4AwjqdRcAmG7p4qvxvUBJhEnB44QelM/047cYImvyf9aDSgANCBYhQ0GrFBqg
 3sXUjBejTrEK+g3z+VZ0WJ5oiwnxvuID9hgAWCcKofxsAyZznIUDhonuytEi6YVg
 ==
X-ME-Sender: <xms:51v9YCGedN4lKPdI6MhqfqyNn0Wm8xf1WAViIeGBjDMXO_0hZEqdRg>
 <xme:51v9YDUWGyohKo9IQcHXf2cZEbIjkgeS5uXI81FZlOw4ImQQva0xJwwglKaGJY5Ky
 Fw7xlyVrvT_uNe75ro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgedvgdehgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
 ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
 htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
 keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
 hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:51v9YMJquKmqBO80PG3-9QLvQyJ-1TCvxUqGLrF5nchBqiNaKQmwGw>
 <xmx:51v9YMEsK99YndIA_qhwX6vzCT3eoYQXLP37yFm0Q3AllIGXUXxUog>
 <xmx:51v9YIU4x6vY3xaxkkc6QN6jXumNwW-HlsIzesZ2O85lZ9gxPKODJQ>
 <xmx:6Vv9YJsHiGm437hPUOiTmwUKZvPLbcs4OEWCKidxWhgNJ78eflOmmQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C3DA651C0061; Sun, 25 Jul 2021 08:41:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-540-g21c5be8f1e-fm-20210722.001-g21c5be8f
Mime-Version: 1.0
Message-Id: <de9dcabd-a3c3-4f34-9f09-6e23deed3a98@www.fastmail.com>
In-Reply-To: <69259ab4-0da9-ddc7-97b0-9ef1e33a39ec@arm.com>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-4-sven@svenpeter.dev>
 <f3574c75-db2d-47fc-bda5-0f0f627fb524@arm.com>
 <30b00cf1-6366-4075-be8a-992fb1778306@www.fastmail.com>
 <69259ab4-0da9-ddc7-97b0-9ef1e33a39ec@arm.com>
Date: Sun, 25 Jul 2021 14:40:51 +0200
To: "Robin Murphy" <robin.murphy@arm.com>
Subject: Re: [PATCH v4 3/3] iommu: dart: Add DART iommu driver
Cc: Arnd Bergmann <arnd@kernel.org>,
 Rouven Czerwinski <r.czerwinski@pengutronix.de>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Stan Skowronek <stan@corellium.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Kettenis <mark.kettenis@xs4all.nl>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On Mon, Jul 19, 2021, at 20:15, Robin Murphy wrote:
> On 2021-07-15 17:41, Sven Peter via iommu wrote:
> [...]
> >>> +	u64 sw_bypass_cpu_start;
> >>> +	u64 sw_bypass_dma_start;
> >>> +	u64 sw_bypass_len;
> >>> +
> >>> +	struct list_head streams;
> >>
> >> I'm staring to think this could just be a bitmap, in a u16 even.
> > 
> > The problem is that these streams may come from two different
> > DART instances. That is required for e.g. the dwc3 controller which
> > has a weird quirk where DMA transactions go through two separate
> > DARTs with no clear pattern (e.g. some xhci control structures use the
> > first dart while other structures use the second one).
> 
> Ah right, I do remember discussing that situation, but I think I 
> misinterpreted dart_domain->dart representing "the DART instance" here 
> to mean we weren't trying to accommodate that just yet.
> 
> > Both of them need to point to the same pagetable.
> > In the device tree the node will have an entry like this:
> > 
> > dwc3_0: usb@382280000{
> >     ...
> >     iommus = <&dwc3_0_dart_0 0>, <&dwc3_0_dart_1 1>;
> > };
> > 
> > There's no need for a linked list though once I do this properly with
> > groups. I can just use an array allocated when the first device is
> > attached, which just contains apple_dart* and streamid values.
> > 
> > 
> >>
> >>> +
> >>> +	spinlock_t lock;
> >>> +
> >>> +	struct iommu_domain domain;
> >>> +};
> >>> +
> >>> +/*
> >>> + * This structure is attached to devices with dev_iommu_priv_set() on of_xlate
> >>> + * and contains a list of streams bound to this device as defined in the
> >>> + * device tree. Multiple DART instances can be attached to a single device
> >>> + * and each stream is identified by its stream id.
> >>> + * It's usually reference by a pointer called *cfg.
> >>> + *
> >>> + * A dynamic array instead of a linked list is used here since in almost
> >>> + * all cases a device will just be attached to a single stream and streams
> >>> + * are never removed after they have been added.
> >>> + *
> >>> + * @num_streams: number of streams attached
> >>> + * @streams: array of structs to identify attached streams and the device link
> >>> + *           to the iommu
> >>> + */
> >>> +struct apple_dart_master_cfg {
> >>> +	int num_streams;
> >>> +	struct {
> >>> +		struct apple_dart *dart;
> >>> +		u32 sid;
> >>
> >> Can't you use the fwspec for this?
> > 
> > 
> > I'd be happy to use the fwspec code if that's somehow possible.
> > I'm not sure how though since I need to store both the reference to the DART
> > _and_ to the stream id. As far as I can tell the fwspec code would only allow
> > to store the stream ids.
> > (see also the previous comment regarding the dwc3 node which requires stream
> > ids from two separate DART instances)
> 
> Hmm, yes, as above I was overlooking that, although there are still 
> various ideas that come to mind; the question becomes whether they're 
> actually worthwhile or just too-clever-for-their-own-good hacks. The 
> exact format of fwspec->ids is not fixed (other than the ACPI IORT code 
> having a common understanding with the Arm SMMU drivers) so in principle 
> you could munge some sort of DART instance index or indeed anything, but 
> if it remains cleaner to manage your own data internally then by all 
> means keep doing that.

Yeah, I can think of some hacks as well (like storing a global id->apple_dart* map
or stuffing the 64bit pointer into two ints) and I've tried a few of them in the past
days but didn't like either of them.

I do like the idea to just put two (struct apple_dart *dart, u16 sidmap)
in there though which will be plenty for all current configurations.

> 
> >>> +		struct device_link *link;
> >>
> >> Is it necessary to use stateless links, or could you use
> >> DL_FLAG_AUTOREMOVE_SUPPLIER and not have to keep track of them manually?
> > 
> > I'll just use DL_FLAG_AUTOREMOVE_SUPPLIER. No idea why I went for stateless links.
> > 
> >>
> > [...]
> >>> +	/* restore stream identity map */
> >>> +	writel(0x03020100, dart->regs + DART_STREAM_REMAP);
> >>> +	writel(0x07060504, dart->regs + DART_STREAM_REMAP + 4);
> >>> +	writel(0x0b0a0908, dart->regs + DART_STREAM_REMAP + 8);
> >>> +	writel(0x0f0e0d0c, dart->regs + DART_STREAM_REMAP + 12);
> >>
> >> Any hint of what the magic numbers mean?
> > 
> > Yes, it's just 0,1,2,3...,0xe,0xf but I can't do 8bit writes to the bus
> > and 32 bit writes then require these slightly awkward "swapped" numbers.
> > I'll add a comment since it's not obvious at first glance.
> 
> Sure, I guessed that much from "identity map" - it was more a question 
> of why that means 0x03020100... rather than, say, 0x0c0d0e0f... or 
> 0x76543210..., and perhaps the reason for "restoring" it in the first place.

So what this feature does is to allow the DART to take an incoming DMA stream
tagged with id i and pretend that it's actually been tagged with
readb(dart->regs + 0x80 + i) instead. That's as much as I can figure out by
poking the hardware. More details are probably only available to Apple.

Now the reason I thought I needed this was that I assumed we are handed these DARTs
in an unclean state because Apple makes use of this internally:
In their device tree they have a sid-remap property which I believe is a hack to make
their driver simpler. The dwc3 controller requires stream 0 of dartA and stream 1 of
dartB to be configured the same way. They configure dartB to remap stream 1 to stream 0
and then just mirror all MMIO writes from dartA to dartB and pretend that dwc3 only
needs a single DART.

As it actually turns out though, iBoot doesn't use the USB DARTs and we already get
them in the sane state. I can just drop this code. (And if we actually need it
for other DARTs I can also just restore those in our bootloader or add it in a
follow up).

> 
> [...]
> >>> +	/*
> >>> +	 * we can't mix and match DARTs that support bypass mode with those who don't
> >>> +	 * because the iova space in fake bypass mode generally has an offset
> >>> +	 */
> >>
> >> Erm, something doesn't sound right there... IOMMU_DOMAIN_IDENTITY should
> >> be exactly what it says, regardless of how it's implemented. If you
> >> can't provide a true identity mapping then you're probably better off
> >> not pretending to support them in the first place.
> > 
> > Some background: the PCIe DART only supports a 32bit VA space but RAM
> > on these machines starts at 0x8_0000_0000. I have something like
> >    dma-ranges = <0x42000000 0 0 0x8 0 0 0xffff0000>;
> > in the pcie nodes to add that offset to dma addresses.
> > 
> > What I want to do here then is to setup an identity mapping with respect
> > to the DMA layer understanding of addresses encoded in bus_dma_region.
> > Now this will always just be a constant offset of 0x8_0000_0000 for
> > all M1s but I didn't want to hardcode that.
> > The code here is just there to guard against a situation where someone
> > somehow manages to attach two devices with different offsets to the same
> > domain.
> 
> Urgh, *now* I think I get it - the addressing limitation WRT the 
> physical memory map layout had also slipped my mind. So you describe the 
> RC *as if* it had a physical bus offset, rely on iommu-dma ignoring it 
> when active (which is more by luck than design - we don't expect to ever 
> see a device with a real hard-wired offset upstream of an IOMMU, 
> although I did initially try to support it back in the very early days), 
> and otherwise statically program a translation such that anyone else who 
> *does* respect bus_dma_regions finds things work as expected.

Yes, exactly. It's not very nice but it works...

> 
> That actually seems like an even stronger argument for having the 
> fake-bypass table belong to the DART rather than the domain, and at that 
> point you shouldn't even need the mismatch restriction, since as long as 
> you haven't described the fake offset for any devices who *can* achieve 
> real bypass, then "attach to an identity domain" simply comes down to 
> doing the appropriate thing for each individual stream, regardless of 
> whether it's the same nominal identity domain that another device is 
> using or a distinct one (it's highly unlikely that two groups would ever 
> get attached to one identity domain rather than simply having their own 
> anyway, but it is technically possible).
> 

Agreed. That sounds a lot nicer actually.


> > If that's not how the abstraction is supposed to work and/or too big of a hack
> > I'll just remove the software bypass mode altogether.
> > PCIe won't work on 4k kernels then but the only people using this so far
> > build their own kernels with patches either way and won't complain.
> > And by the time Linux will actually be useful for "normal" setups
> > the dma-iommu layer can hopefully just handle a larger page granularity.
> 
> It's certainly... "creative", and TBH I don't hate it (in a "play the 
> hand you've been given" kind of way), but the one significant downside 
> is that if the DART driver isn't loaded for any reason, PCI DMA will 
> look like it should be usable but then just silently (or not so 
> silently) fail.

Good point!

> 
> FWIW if you do want to keep the option open, I'd be inclined to have the 
> DT just give an "honest" description of just the 32-bit limitation, then 
> have the DART driver's .probe_device sneakily modify the bus_dma_region 
> to match the relevant fake-bypass table as appropriate. It's possible 
> other folks might hate that even more though :D

I've given that one a try and I kinda like it so far :D
I'll keep it for v5 and just drop it in case someone complains.

> 
> >>> +	if (WARN_ON(domain->type == IOMMU_DOMAIN_IDENTITY &&
> >>> +		    (domain->dart->supports_bypass != dart->supports_bypass)))
> >>> +		return -EINVAL;
> >>> +
> >>> +	list_for_each_entry(stream, &domain->streams, stream_head) {
> >>> +		if (stream->dart == dart && stream->sid == sid) {
> >>> +			stream->num_devices++;
> >>> +			return 0;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	spin_lock_irqsave(&dart->lock, flags);
> >>> +
> >>> +	if (WARN_ON(dart->used_sids & BIT(sid))) {
> >>> +		ret = -EINVAL;
> >>> +		goto error;
> >>> +	}
> >>> +
> >>> +	stream = kzalloc(sizeof(*stream), GFP_ATOMIC);
> >>> +	if (!stream) {
> >>> +		ret = -ENOMEM;
> >>> +		goto error;
> >>> +	}
> >>
> >> Couldn't you do this outside the lock? (If, calling back to other
> >> comments, it can't get refactored out of existence anyway)
> > 
> > Probably, but I'll first see if I can just refactor it away.
> 
> Actually I missed that we're already under dart_domain->lock at this 
> point anyway, so it's not going to make much difference, but it does 
> mean that the spin_lock_irqsave() above could just be spin_lock(), 
> unless it's possible to relax the domain locking a bit such that we 
> don't have to do the whole domain init with IRQs masked.

I can relax the locking quite a bit.
Right now, I only need a spinlock around the TLB flush MMIO writes
and a mutex to protect domain initialization.

> 
> [...]
> >>> +static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
> >>> +{
> >>> +	struct apple_dart_domain *dart_domain;
> >>> +
> >>> +	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED &&
> >>> +	    type != IOMMU_DOMAIN_IDENTITY && type != IOMMU_DOMAIN_BLOCKED)
> >>> +		return NULL;
> >>
> >> I want to say there's not much point in that, but then I realise I've
> >> spent the last couple of days writing patches to add a new domain type :)
> > 
> > Hah! Just because I'm curious: What is that new domain type going to be? :)
> 
> Splitting IOMMU_DOMAIN_DMA into two to replace iommu_dma_strict being an 
> orthogonal thing.
> 
> [...]
> >>> +static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
> >>> +{
> >>> +	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
> >>> +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> >>> +	unsigned int num_streams = cfg ? cfg->num_streams : 0;
> >>> +	struct apple_dart_master_cfg *cfg_new;
> >>> +	struct apple_dart *dart = platform_get_drvdata(iommu_pdev);
> >>> +
> >>> +	if (args->args_count != 1)
> >>> +		return -EINVAL;
> >>> +
> >>> +	cfg_new = krealloc(cfg, struct_size(cfg, streams, num_streams + 1),
> >>> +			   GFP_KERNEL);
> >>> +	if (!cfg_new)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	cfg = cfg_new;
> >>> +	dev_iommu_priv_set(dev, cfg);
> >>> +
> >>> +	cfg->num_streams = num_streams;
> >>> +	cfg->streams[cfg->num_streams].dart = dart;
> >>> +	cfg->streams[cfg->num_streams].sid = args->args[0];
> >>> +	cfg->num_streams++;
> >>
> >> Yeah, this is way too reminiscent of the fwspec code for comfort. Even
> >> if you can't use autoremove links for some reason, an array of 16
> >> device_link pointers hung off apple_dart still wins over these little
> >> pointer-heavy structures if you need more than a few of them.
> > 
> > I can get rid of the links, but I'll still need some way to store
> > both the apple_dart and the sid here. Like mentioned above, I'll
> > be happy to reuse the fwspec code but I don't see how yet.
> 
> As before, if you can fit in some kind of DART instance identifier which 
> isn't impractical to unpack than it makes sense to use the fwspec since 
> it's already there. However if you still need to allocate something 
> per-device rather than just stashing an existing pointer in iommu_priv, 
> then you may as well keep everything together there. If the worst known 
> case could still fit in just two DART pointers and two 64-bit bitmaps, 
> I'd be inclined to just have that as a fixed structure and save all the 
> extra bother - you're not cross-architecture like the fwspec code, and 
> arm64's minimum kmalloc granularity has just gone back up to 128 bytes 
> (but even at 64 bytes you'd have had plenty of room).

That's a very good point, I somehow tried to make this part as general
as possible and didn't realize that this only has to work on essentially
one SoC for now. I also don't expect Apple to require more than two
DARTs for a single master in the future.

I've tried the fixed structure now and I really like it so far.

> 
> [...]
> >>> +static int apple_dart_remove(struct platform_device *pdev)
> >>> +{
> >>> +	struct apple_dart *dart = platform_get_drvdata(pdev);
> >>> +
> >>> +	devm_free_irq(dart->dev, dart->irq, dart);
> >>> +
> >>> +	iommu_device_unregister(&dart->iommu);
> >>> +	iommu_device_sysfs_remove(&dart->iommu);
> >>> +
> >>> +	clk_bulk_disable(dart->num_clks, dart->clks);
> >>> +	clk_bulk_unprepare(dart->num_clks, dart->clks);
> >>
> >> Ditto.
> >>
> >> And again the bus ops are still installed - that'll get really fun if
> >> this is a module unload...
> > 
> > Ugh, yeah. I'll fix that as well. I'll have to see how to make this work
> > correctly with multiple DART instances. I guess I should only remove the
> > bus ops once the last one is removed. Now that I think about it, this
> > could also get tricky in the cleanup paths of apple_dart_probe.
> > 
> > Maybe just add a module_init that sets up the bus ops when it finds at
> > least one DART node and module_exit to tear them down again?
> 
> Actually by this point it was late and I wasn't thinking as clearly as I 
> could have been, apologies ;)
> 
> I believe a module unload is in fact the *only* time you should expect 
> to see .remove called - you want to set .suppress_bind_attrs in your 
> driver data because there's basically no way to prevent manual unbinding 
> from blowing up - so it should be fine to unconditionally clear the ops 
> at this point (being removed means you must have successfully probed, so 
> any ops must be yours).

Makes sense, thanks!

I'll let my current version simmer for a bit and wait until it's been
tested by a few people and will send it in a week or so then!


Best,

Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
