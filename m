Return-Path: <SRS0=4OKN=ML=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACDFC07E95
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 18:15:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0265610FB
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 18:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0265610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 969F3835D3;
	Mon, 19 Jul 2021 18:15:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15mnMxVt4Hy4; Mon, 19 Jul 2021 18:15:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C09B8331B;
	Mon, 19 Jul 2021 18:15:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2B8DC0010;
	Mon, 19 Jul 2021 18:15:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5142EC000E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 18:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40336835A9
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 18:15:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2u0PFAZY-od8 for <iommu@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 18:15:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7D6D8331B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 18:15:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0C1C6D;
 Mon, 19 Jul 2021 11:15:09 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 525573F73D;
 Mon, 19 Jul 2021 11:15:07 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] iommu: dart: Add DART iommu driver
To: Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-4-sven@svenpeter.dev>
 <f3574c75-db2d-47fc-bda5-0f0f627fb524@arm.com>
 <30b00cf1-6366-4075-be8a-992fb1778306@www.fastmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <69259ab4-0da9-ddc7-97b0-9ef1e33a39ec@arm.com>
Date: Mon, 19 Jul 2021 19:15:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <30b00cf1-6366-4075-be8a-992fb1778306@www.fastmail.com>
Content-Language: en-GB
Cc: Arnd Bergmann <arnd@kernel.org>,
 Rouven Czerwinski <r.czerwinski@pengutronix.de>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Stan Skowronek <stan@corellium.com>, linux-arm-kernel@lists.infradead.org,
 Mark Kettenis <mark.kettenis@xs4all.nl>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-07-15 17:41, Sven Peter via iommu wrote:
[...]
>>> +	u64 sw_bypass_cpu_start;
>>> +	u64 sw_bypass_dma_start;
>>> +	u64 sw_bypass_len;
>>> +
>>> +	struct list_head streams;
>>
>> I'm staring to think this could just be a bitmap, in a u16 even.
> 
> The problem is that these streams may come from two different
> DART instances. That is required for e.g. the dwc3 controller which
> has a weird quirk where DMA transactions go through two separate
> DARTs with no clear pattern (e.g. some xhci control structures use the
> first dart while other structures use the second one).

Ah right, I do remember discussing that situation, but I think I 
misinterpreted dart_domain->dart representing "the DART instance" here 
to mean we weren't trying to accommodate that just yet.

> Both of them need to point to the same pagetable.
> In the device tree the node will have an entry like this:
> 
> dwc3_0: usb@382280000{
>     ...
>     iommus = <&dwc3_0_dart_0 0>, <&dwc3_0_dart_1 1>;
> };
> 
> There's no need for a linked list though once I do this properly with
> groups. I can just use an array allocated when the first device is
> attached, which just contains apple_dart* and streamid values.
> 
> 
>>
>>> +
>>> +	spinlock_t lock;
>>> +
>>> +	struct iommu_domain domain;
>>> +};
>>> +
>>> +/*
>>> + * This structure is attached to devices with dev_iommu_priv_set() on of_xlate
>>> + * and contains a list of streams bound to this device as defined in the
>>> + * device tree. Multiple DART instances can be attached to a single device
>>> + * and each stream is identified by its stream id.
>>> + * It's usually reference by a pointer called *cfg.
>>> + *
>>> + * A dynamic array instead of a linked list is used here since in almost
>>> + * all cases a device will just be attached to a single stream and streams
>>> + * are never removed after they have been added.
>>> + *
>>> + * @num_streams: number of streams attached
>>> + * @streams: array of structs to identify attached streams and the device link
>>> + *           to the iommu
>>> + */
>>> +struct apple_dart_master_cfg {
>>> +	int num_streams;
>>> +	struct {
>>> +		struct apple_dart *dart;
>>> +		u32 sid;
>>
>> Can't you use the fwspec for this?
> 
> 
> I'd be happy to use the fwspec code if that's somehow possible.
> I'm not sure how though since I need to store both the reference to the DART
> _and_ to the stream id. As far as I can tell the fwspec code would only allow
> to store the stream ids.
> (see also the previous comment regarding the dwc3 node which requires stream
> ids from two separate DART instances)

Hmm, yes, as above I was overlooking that, although there are still 
various ideas that come to mind; the question becomes whether they're 
actually worthwhile or just too-clever-for-their-own-good hacks. The 
exact format of fwspec->ids is not fixed (other than the ACPI IORT code 
having a common understanding with the Arm SMMU drivers) so in principle 
you could munge some sort of DART instance index or indeed anything, but 
if it remains cleaner to manage your own data internally then by all 
means keep doing that.

>>> +		struct device_link *link;
>>
>> Is it necessary to use stateless links, or could you use
>> DL_FLAG_AUTOREMOVE_SUPPLIER and not have to keep track of them manually?
> 
> I'll just use DL_FLAG_AUTOREMOVE_SUPPLIER. No idea why I went for stateless links.
> 
>>
> [...]
>>> +	/* restore stream identity map */
>>> +	writel(0x03020100, dart->regs + DART_STREAM_REMAP);
>>> +	writel(0x07060504, dart->regs + DART_STREAM_REMAP + 4);
>>> +	writel(0x0b0a0908, dart->regs + DART_STREAM_REMAP + 8);
>>> +	writel(0x0f0e0d0c, dart->regs + DART_STREAM_REMAP + 12);
>>
>> Any hint of what the magic numbers mean?
> 
> Yes, it's just 0,1,2,3...,0xe,0xf but I can't do 8bit writes to the bus
> and 32 bit writes then require these slightly awkward "swapped" numbers.
> I'll add a comment since it's not obvious at first glance.

Sure, I guessed that much from "identity map" - it was more a question 
of why that means 0x03020100... rather than, say, 0x0c0d0e0f... or 
0x76543210..., and perhaps the reason for "restoring" it in the first place.

[...]
>>> +	/*
>>> +	 * we can't mix and match DARTs that support bypass mode with those who don't
>>> +	 * because the iova space in fake bypass mode generally has an offset
>>> +	 */
>>
>> Erm, something doesn't sound right there... IOMMU_DOMAIN_IDENTITY should
>> be exactly what it says, regardless of how it's implemented. If you
>> can't provide a true identity mapping then you're probably better off
>> not pretending to support them in the first place.
> 
> Some background: the PCIe DART only supports a 32bit VA space but RAM
> on these machines starts at 0x8_0000_0000. I have something like
>    dma-ranges = <0x42000000 0 0 0x8 0 0 0xffff0000>;
> in the pcie nodes to add that offset to dma addresses.
> 
> What I want to do here then is to setup an identity mapping with respect
> to the DMA layer understanding of addresses encoded in bus_dma_region.
> Now this will always just be a constant offset of 0x8_0000_0000 for
> all M1s but I didn't want to hardcode that.
> The code here is just there to guard against a situation where someone
> somehow manages to attach two devices with different offsets to the same
> domain.

Urgh, *now* I think I get it - the addressing limitation WRT the 
physical memory map layout had also slipped my mind. So you describe the 
RC *as if* it had a physical bus offset, rely on iommu-dma ignoring it 
when active (which is more by luck than design - we don't expect to ever 
see a device with a real hard-wired offset upstream of an IOMMU, 
although I did initially try to support it back in the very early days), 
and otherwise statically program a translation such that anyone else who 
*does* respect bus_dma_regions finds things work as expected.

That actually seems like an even stronger argument for having the 
fake-bypass table belong to the DART rather than the domain, and at that 
point you shouldn't even need the mismatch restriction, since as long as 
you haven't described the fake offset for any devices who *can* achieve 
real bypass, then "attach to an identity domain" simply comes down to 
doing the appropriate thing for each individual stream, regardless of 
whether it's the same nominal identity domain that another device is 
using or a distinct one (it's highly unlikely that two groups would ever 
get attached to one identity domain rather than simply having their own 
anyway, but it is technically possible).

> If that's not how the abstraction is supposed to work and/or too big of a hack
> I'll just remove the software bypass mode altogether.
> PCIe won't work on 4k kernels then but the only people using this so far
> build their own kernels with patches either way and won't complain.
> And by the time Linux will actually be useful for "normal" setups
> the dma-iommu layer can hopefully just handle a larger page granularity.

It's certainly... "creative", and TBH I don't hate it (in a "play the 
hand you've been given" kind of way), but the one significant downside 
is that if the DART driver isn't loaded for any reason, PCI DMA will 
look like it should be usable but then just silently (or not so 
silently) fail.

FWIW if you do want to keep the option open, I'd be inclined to have the 
DT just give an "honest" description of just the 32-bit limitation, then 
have the DART driver's .probe_device sneakily modify the bus_dma_region 
to match the relevant fake-bypass table as appropriate. It's possible 
other folks might hate that even more though :D

>>> +	if (WARN_ON(domain->type == IOMMU_DOMAIN_IDENTITY &&
>>> +		    (domain->dart->supports_bypass != dart->supports_bypass)))
>>> +		return -EINVAL;
>>> +
>>> +	list_for_each_entry(stream, &domain->streams, stream_head) {
>>> +		if (stream->dart == dart && stream->sid == sid) {
>>> +			stream->num_devices++;
>>> +			return 0;
>>> +		}
>>> +	}
>>> +
>>> +	spin_lock_irqsave(&dart->lock, flags);
>>> +
>>> +	if (WARN_ON(dart->used_sids & BIT(sid))) {
>>> +		ret = -EINVAL;
>>> +		goto error;
>>> +	}
>>> +
>>> +	stream = kzalloc(sizeof(*stream), GFP_ATOMIC);
>>> +	if (!stream) {
>>> +		ret = -ENOMEM;
>>> +		goto error;
>>> +	}
>>
>> Couldn't you do this outside the lock? (If, calling back to other
>> comments, it can't get refactored out of existence anyway)
> 
> Probably, but I'll first see if I can just refactor it away.

Actually I missed that we're already under dart_domain->lock at this 
point anyway, so it's not going to make much difference, but it does 
mean that the spin_lock_irqsave() above could just be spin_lock(), 
unless it's possible to relax the domain locking a bit such that we 
don't have to do the whole domain init with IRQs masked.

[...]
>>> +static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
>>> +{
>>> +	struct apple_dart_domain *dart_domain;
>>> +
>>> +	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED &&
>>> +	    type != IOMMU_DOMAIN_IDENTITY && type != IOMMU_DOMAIN_BLOCKED)
>>> +		return NULL;
>>
>> I want to say there's not much point in that, but then I realise I've
>> spent the last couple of days writing patches to add a new domain type :)
> 
> Hah! Just because I'm curious: What is that new domain type going to be? :)

Splitting IOMMU_DOMAIN_DMA into two to replace iommu_dma_strict being an 
orthogonal thing.

[...]
>>> +static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
>>> +{
>>> +	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
>>> +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
>>> +	unsigned int num_streams = cfg ? cfg->num_streams : 0;
>>> +	struct apple_dart_master_cfg *cfg_new;
>>> +	struct apple_dart *dart = platform_get_drvdata(iommu_pdev);
>>> +
>>> +	if (args->args_count != 1)
>>> +		return -EINVAL;
>>> +
>>> +	cfg_new = krealloc(cfg, struct_size(cfg, streams, num_streams + 1),
>>> +			   GFP_KERNEL);
>>> +	if (!cfg_new)
>>> +		return -ENOMEM;
>>> +
>>> +	cfg = cfg_new;
>>> +	dev_iommu_priv_set(dev, cfg);
>>> +
>>> +	cfg->num_streams = num_streams;
>>> +	cfg->streams[cfg->num_streams].dart = dart;
>>> +	cfg->streams[cfg->num_streams].sid = args->args[0];
>>> +	cfg->num_streams++;
>>
>> Yeah, this is way too reminiscent of the fwspec code for comfort. Even
>> if you can't use autoremove links for some reason, an array of 16
>> device_link pointers hung off apple_dart still wins over these little
>> pointer-heavy structures if you need more than a few of them.
> 
> I can get rid of the links, but I'll still need some way to store
> both the apple_dart and the sid here. Like mentioned above, I'll
> be happy to reuse the fwspec code but I don't see how yet.

As before, if you can fit in some kind of DART instance identifier which 
isn't impractical to unpack than it makes sense to use the fwspec since 
it's already there. However if you still need to allocate something 
per-device rather than just stashing an existing pointer in iommu_priv, 
then you may as well keep everything together there. If the worst known 
case could still fit in just two DART pointers and two 64-bit bitmaps, 
I'd be inclined to just have that as a fixed structure and save all the 
extra bother - you're not cross-architecture like the fwspec code, and 
arm64's minimum kmalloc granularity has just gone back up to 128 bytes 
(but even at 64 bytes you'd have had plenty of room).

[...]
>>> +static int apple_dart_remove(struct platform_device *pdev)
>>> +{
>>> +	struct apple_dart *dart = platform_get_drvdata(pdev);
>>> +
>>> +	devm_free_irq(dart->dev, dart->irq, dart);
>>> +
>>> +	iommu_device_unregister(&dart->iommu);
>>> +	iommu_device_sysfs_remove(&dart->iommu);
>>> +
>>> +	clk_bulk_disable(dart->num_clks, dart->clks);
>>> +	clk_bulk_unprepare(dart->num_clks, dart->clks);
>>
>> Ditto.
>>
>> And again the bus ops are still installed - that'll get really fun if
>> this is a module unload...
> 
> Ugh, yeah. I'll fix that as well. I'll have to see how to make this work
> correctly with multiple DART instances. I guess I should only remove the
> bus ops once the last one is removed. Now that I think about it, this
> could also get tricky in the cleanup paths of apple_dart_probe.
> 
> Maybe just add a module_init that sets up the bus ops when it finds at
> least one DART node and module_exit to tear them down again?

Actually by this point it was late and I wasn't thinking as clearly as I 
could have been, apologies ;)

I believe a module unload is in fact the *only* time you should expect 
to see .remove called - you want to set .suppress_bind_attrs in your 
driver data because there's basically no way to prevent manual unbinding 
from blowing up - so it should be fine to unconditionally clear the ops 
at this point (being removed means you must have successfully probed, so 
any ops must be yours).

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
