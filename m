Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D521C433FE
	for <iommu@archiver.kernel.org>; Fri, 24 Dec 2021 03:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EC1483417;
	Fri, 24 Dec 2021 03:20:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UYSuT3SOlXrI; Fri, 24 Dec 2021 03:20:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8C4AF833D3;
	Fri, 24 Dec 2021 03:20:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51044C002F;
	Fri, 24 Dec 2021 03:20:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 752D1C0012
 for <iommu@lists.linux-foundation.org>; Fri, 24 Dec 2021 03:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BEB060B1C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Dec 2021 03:20:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GvJsPpaTERhp for <iommu@lists.linux-foundation.org>;
 Fri, 24 Dec 2021 03:20:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C53F60ABC
 for <iommu@lists.linux-foundation.org>; Fri, 24 Dec 2021 03:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640316018; x=1671852018;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=wMsPZOHR5Bi7De06AcwKKVBkiYof5dOFy5ubdt3p48k=;
 b=MM0ShG0bD/R0qb3pLIoZVAdvTVSUFnewiXw7AfVaPNwcB68WgLStzWmZ
 2nwQyY5jdpkXhR+3obvf+wSPTeWMF8qNomye86/9ZgSbaAbnZxVrqWKQz
 Cp2YLvShNrhCGd2xfNxS3NDsh2jiVImafzvSwAk69FQ1Hb98H9S2qYM6P
 BTr31qwldmMOyFeKyIkhMebqX3PKdxJXkY+lLONB9b1CUnqYQkKa9Teiz
 hygcC/QRDJiRhUZWh1xSM7KSrqqrrzO+N5pBhhlHDaXvzUWZwrbIOkSfB
 GdQN1GYEM0jenhXaESwXsXrHdFxOqxihDjoenrHDNyfAXPAR6j8HBhidd g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="227764669"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; d="scan'208";a="227764669"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2021 19:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; d="scan'208";a="664757217"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 19:20:09 -0800
Subject: Re: [PATCH v4 07/13] iommu: Add iommu_at[de]tach_device_shared() for
 multi-device groups
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-8-baolu.lu@linux.intel.com>
 <dd797dcd-251a-1980-ca64-bb38e67a526f@arm.com>
 <20211221184609.GF1432915@nvidia.com>
 <aebbd9c7-a239-0f89-972b-a9059e8b218b@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b4405a5e-c4cc-f44a-ab43-8cb62b888565@linux.intel.com>
Date: Fri, 24 Dec 2021 11:19:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <aebbd9c7-a239-0f89-972b-a9059e8b218b@arm.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

On 12/23/21 4:26 AM, Robin Murphy wrote:
> On 21/12/2021 6:46 pm, Jason Gunthorpe wrote:
>> On Tue, Dec 21, 2021 at 04:50:56PM +0000, Robin Murphy wrote:
>>
>>> this proposal is the worst of both worlds, in that drivers still have 
>>> to be
>>> just as aware of groups in order to know whether to call the _shared
>>> interface or not, except it's now entirely implicit and non-obvious.
>>
>> Drivers are not aware of groups, where did you see that?
> 
> `git grep iommu_attach_group -- :^drivers/iommu :^include`
> 
> Did I really have to explain that?
> 
> The drivers other than vfio_iommu_type1, however, do have a complete 
> failure to handle, or even consider, any group that does not fit the 
> particular set of assumptions they are making, but at least they only 
> work in a context where that should not occur.
> 
>> Drivers have to indicate their intention, based entirely on their own
>> internal design. If groups are present, or not is irrelevant to the
>> driver.
>>
>> If the driver uses a single struct device (which is most) then it uses
>> iommu_attach_device().
>>
>> If the driver uses multiple struct devices and intends to connect them
>> all to the same domain then it uses the _shared variant. The only
>> difference between the two is the _shared varient lacks some of the
>> protections against driver abuse of the API.
> 
> You've lost me again; how are those intentions any different? Attaching 
> one device to a private domain is a literal subset of attaching more 
> than one device to a private domain. There is no "abuse" of any API 
> anywhere; the singleton group restriction exists as a protective measure 
> because iommu_attach_device() was already in use before groups were 
> really a thing, in contexts where groups happened to be singleton 
> already, but anyone adding *new* uses in contexts where that assumption 
> might *not* hold would be in trouble. Thus it enforces DMA ownership by 
> the most trivial and heavy-handed means of simply preventing it ever 
> becoming shared in the first place.
> 
> Yes, I'm using the term "DMA ownership" in a slightly different context 
> to the one in which you originally proposed it. Please step out of the 
> userspace-device-assignment-focused bubble for a moment and stay with me...
> 
> So then we have the iommu_attach_group() interface for new code (and 
> still nobody has got round to updating the old code to it yet), for 
> which the basic use-case is still fundamentally "I want to attach my 
> thing to my domain", but at least now forcing explicit awareness that 
> "my thing" could possibly be inextricably intertwined with more than 
> just the one device they expect, so potential callers should have a good 
> think about that. Unfortunately this leaves the matter of who "owns" the 
> group entirely in the hands of those callers, which as we've now 
> concluded is not great.
> 
> One of the main reasons for non-singleton groups to occur is due to ID 
> aliasing or lack of isolation well beyond the scope and control of 
> endpoint devices themselves, so it's not really fair to expect every 
> IOMMU-aware driver to also be aware of that, have any idea of how to 
> actually handle it, or especially try to negotiate with random other 
> drivers as to whether it might be OK to take control of their DMA 
> address space too. The whole point is that *every* domain attach really 
> *has* to be considered "shared" because in general drivers can't know 
> otherwise. Hence the easy, if crude, fix for the original API.
> 
>> Nothing uses the group interface except for VFIO and stuff inside
>> drivers/iommu. VFIO has a uAPI tied to the group interface and it
>> is stuck with it.
> 
> Self-contradiction is getting stronger, careful...
>>> Otherwise just add the housekeeping stuff to 
>>> iommu_{attach,detach}_group() -
>>> there's no way we want *three* attach/detach interfaces all with 
>>> different
>>> semantics.
>>
>> I'm not sure why you think 3 APIs is bad thing. Threes APIs, with
>> clearly intended purposes is a lot better than one giant API with a
>> bunch of parameters that tries to do everything.
> 
> Because there's only one problem to solve! We have the original API 
> which does happen to safely enforce ownership, but in an implicit way 
> that doesn't scale; then we have the second API which got past the 
> topology constraint but unfortunately turns out to just be unsafe in a 
> slightly different way, and was supposed to replace the first one but 
> hasn't, and is a bit clunky to boot; now you're proposing a third one 
> which can correctly enforce safe ownership for any group topology, which 
> is simply combining the good bits of the first two. It makes no sense to 
> maintain two bad versions of a thing alongside one which works better.
> 
> I don't see why anything would be a giant API with a bunch of parameters 
> - depending on how you look at it, this new proposal is basically either 
> iommu_attach_device() with the ability to scale up to non-trivial groups 
> properly, or iommu_attach_group() with a potentially better interface 
> and actual safety. The former is still more prevalent (and the interface 
> argument compelling), so if we put the new implementation behind that, 
> with the one tweak of having it set DMA_OWNER_PRIVATE_DOMAIN 
> automatically, kill off iommu_attach_group() by converting its couple of 
> users, and not only have we solved the VFIO problem but we've also 
> finally updated all the legacy code for free! Of course you can have a 
> separate version for VFIO to attach with DMA_OWNER_PRIVATE_DOMAIN_USER 
> if you like, although I still fail to understand the necessity of the 
> distinction.
> 
>> In this case, it is not simple to 'add the housekeeping' to
>> iommu_attach_group() in a way that is useful to both tegra and
>> VFIO. What tegra wants is what the _shared API implements, and that
>> logic should not be open coded in drivers.
>>
>> VFIO does not want exactly that, it has its own logic to deal directly
>> with groups tied to its uAPI. Due to the uAPI it doesn't even have a
>> struct device, unfortunately.
> 
> Nope. VFIO has its own logic to deal with groups because it's the only 
> thing that's ever actually tried dealing with groups correctly 
> (unsurprisingly, given that it's where they came from), and every other 
> private IOMMU domain user is just crippled or broken to some degree. All 
> that proves is that we really should be policing groups better in the 
> IOMMU core, per this series, because actually fixing all the other users 
> to properly validate their device's group would be a ridiculous mess.
> 
> What VFIO wants is (conceptually[1]) "attach this device to my domain, 
> provided it and any other devices in its group are managed by a driver I 
> approve of." Surprise surprise, that's what any other driver wants as 
> well! For iommu_attach_device() it was originally implicit, and is now 
> further enforced by the singleton group restriction. For Tegra/host1x 
> it's implicit in the complete obliviousness to the possibility of that 
> not being the case.
> 
> Of course VFIO has a struct device if it needs one; it's trivial to 
> resolve the member(s) of a group (and even more so once we can assume 
> that a group may only ever contain mutually-compatible devices in the 
> first place). How do you think vfio_bus_type() works?
> 
> VFIO will also need a struct device anyway, because once I get back from 
> my holiday in the new year I need to start working with Simon on 
> evolving the rest of the API away from bus->iommu_ops to dev->iommu so 
> we can finally support IOMMU drivers coexisting[2].
> 
>> The reason there are three APIs is because there are three different
>> use-cases. It is not bad thing to have APIs designed for the use cases
>> they serve.
> 
> Indeed I agree with that second point, I'm just increasingly baffled how 
> it's not clear to you that there is only one fundamental use-case here. 
> Perhaps I'm too familiar with the history to objectively see how unclear 
> the current state of things might be :/
> 
>>> It's worth taking a step back and realising that overall, this is really
>>> just a more generalised and finer-grained extension of what 426a273834ea
>>> already did for non-group-aware code, so it makes little sense *not* to
>>> integrate it into the existing interfaces.
>>
>> This is taking 426a to it's logical conclusion and *removing* the
>> group API from the drivers entirely. This is desirable because drivers
>> cannot do anything sane with the group.
> 
> I am in complete agreement with that (to the point of also not liking 
> patch #6).
> 
>> The drivers have struct devices, and so we provide APIs that work in
>> terms of struct devices to cover both driver use cases today, and do
>> so more safely than what is already implemented.
> 
> I am in complete agreement with that (given "both" of the supposed 3 
> use-cases all being the same).
> 
>> Do not mix up VFIO with the driver interface, these are different
>> things. It is better VFIO stay on its own and not complicate the
>> driver world.
> 
> Nope, vfio_iommu_type1 is just a driver, calling the IOMMU API just like 
> any other driver. I like the little bit where it passes itself to 
> vfio_register_iommu_driver(), which I feel gets this across far more 
> poetically than I can manage.
> 
> Thanks,
> Robin.
> 
> [1] Yes, due to the UAPI it actually starts with the whole group rather 
> than any particular device within it. Don't nitpick.
> [2] 
> https://lore.kernel.org/linux-iommu/2021052710373173260118@rock-chips.com/

Let me summarize what I've got from above comments.

1. Essentially we only need below interfaces for device drivers to
    manage the I/O address conflict in iommu layer:

int iommu_device_set/release/query_kernel_dma(struct device *dev)

- Device driver lets the iommu layer know that driver DMAs go through
   the kernel DMA APIs. The iommu layer should use the default domain
   for DMA remapping. No other domains could be attached.
- Device driver lets the iommu layer know that driver doesn't do DMA
   anymore and other domains are allowed to be attached.
- Device driver queries "can I only do DMA through the kernel DMA API?
   In other words, can I attach my own domain?"


int iommu_device_set/release_private_dma(struct device *dev)

- Device driver lets the iommu layer know that it wants to use its own
   iommu domain. The iommu layer should detach the default domain and
   allow the driver to attach or detach its own domain through
   iommu_attach/detach_device() interfaces.
- Device driver lets the iommy layer know that it on longer needs a
   private domain.

2. iommu_attach_group() vs. iommu_attach_device()

   [HISTORY]
   The iommu_attach_device() added first by commit <fc2100eb4d096> ("add
   frontend implementation for the IOMMU API") in 2008. At that time,
   there was no concept of iommu group yet.

   The iommu group was added by commit <d72e31c937462> ("iommu: IOMMU
   Groups") four years later in 2012. The iommu_attach_group() was added
   at the same time.

   Then, people realized that iommu_attach_device() allowed different
   device in a same group to attach different domain. This was not in
   line with the concept of iommu group. The commit <426a273834eae>
   ("iommu: Limit iommu_attach/detach_device to device with their own
   group") fixed this problem in 2015.

   [REALITY]
   We have two coexisting interfaces for device drivers to do the same
   thing. But neither is perfect:

   - iommu_attach_device() only works for singleton group.
   - iommu_attach_group() asks the device drivers to handle iommu group
     related staff which is beyond the role of a device driver.

   [FUTURE]
   Considering from the perspective of a device driver, its motivation is
   very simple: "I want to manage my own I/O address space. The kernel
   DMA API is not suitable for me because it hides the I/O address space
   details in the lower layer which is transparent to me."

   We consider heading in this direction:

   Make the iommu_attach_device() the only and generic interface for the
   device drivers to use their own private domain (I/O address space)
   and replace all iommu_attach_group() uses with iommu_attach_device()
   and deprecate the former.

That's all. Did I miss or misunderstand anything?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
