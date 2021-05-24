Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA6C04FF3
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 18:18:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDE461413
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 18:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDE461413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6879B40384;
	Mon, 24 May 2021 18:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WH9CX6YicCUp; Mon, 24 May 2021 18:18:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 311B24010C;
	Mon, 24 May 2021 18:18:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18DC3C000D;
	Mon, 24 May 2021 18:18:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59DF3C0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 18:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D5CA400B5
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 18:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pa6bpI0PORAM for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 18:18:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F4DD4039C
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 18:18:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6FE26D;
 Mon, 24 May 2021 11:18:40 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45FC53F73B;
 Mon, 24 May 2021 11:18:39 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <YKJf7mphTHZoi7Qr@8bytes.org> <20210517123010.GO1096940@ziepe.ca>
 <YKJnPGonR+d8rbu/@8bytes.org> <20210517133500.GP1096940@ziepe.ca>
 <YKKNLrdQ4QjhLrKX@8bytes.org>
 <131327e3-5066-7a88-5b3c-07013585eb01@arm.com>
 <20210519180635.GT1096940@ziepe.ca>
 <MWHPR11MB1886C64EAEB752DE9E1633358C2B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210519232459.GV1096940@ziepe.ca>
 <1d154445-f762-1147-0b8c-6e244e7c66dc@arm.com>
 <20210520143420.GW1096940@ziepe.ca>
Message-ID: <9d34b473-3a37-5de2-95f8-b508d85e558c@arm.com>
Date: Mon, 24 May 2021 19:18:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520143420.GW1096940@ziepe.ca>
Content-Language: en-GB
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On 2021-05-20 15:34, Jason Gunthorpe wrote:
> On Thu, May 20, 2021 at 03:13:55PM +0100, Robin Murphy wrote:
> 
>> By "mdev-like" I mean it's very similar in shape to the general SIOV-style
>> mediated device concept - i.e. a physical device with an awareness of
>> operating on multiple contexts at once, using a Substream ID/PASID for each
>> one - but instead of exposing control of the contexts to anyone else, they
>> remain hidden behind the kernel driver which already has its own abstracted
>> uAPI, so overall it ends up as more just internal housekeeping than any
>> actual mediation. We were looking at the mdev code for inspiration, but
>> directly using it was never the plan.
> 
> Well:
>   - Who maps memory into the IOASID (ie the specific sub stream id)?

Sorry to nitpick, but I think it's important to get terminology right 
here to avoid unnecessary misunderstanding. You can't map memory into an 
address space ID; it's just a number. Ultimately that identifier ends up 
pointing at some actual address space, and most of the current work is 
focused on the case of that address space being provided by an mm where 
things are mapped implicitly by a userspace process; I care about the 
case of it being provided by an iommu_domain where things are mapped 
explicitly by a kernel driver. I would be extremely wary of creating 
some new third *address space* abstraction.

>   - What memory must be mapped?
>   - Who triggers DMA to this memory?

It's a pretty typical DMA flow, as far as I understand. Userspace 
allocates some buffers (in this case, via the kernel driver, but in 
general I'm not sure it makes much difference), puts data in the 
buffers, issues an ioctl to say "process this data", and polls for 
completion; the kernel driver makes sure the buffers are mapped in the 
device address space (at allocation time in this case, but in general I 
assume it could equally be done at request time for user pages), and 
deals with scheduling requests onto the hardware. I understand this 
interface is already deployed in a driver stack which supports a single 
client process at once; extending the internals to allow requests from 
multiple processes to run in parallel using Substream IDs for isolation 
is the future goal. The interface itself shouldn't change, only some 
internal arbitration details.

>> The driver simply needs to keep track of the domains and PASIDs -
>> when a process submits some work, it can look up the relevant
>> domain, iommu_map() the user pages to the right addresses, dma_map()
>> them for coherency, then poke in the PASID as part of scheduling the
>> work on the physical device.
> 
> If you are doing stuff like this then the /dev/ioasid is what you
> actually want. The userprocess can create its own IOASID, program the
> io page tables for that IOASID to point to pages as it wants and then
> just hand over a fully instantiated io page table to the device
> driver.

No. In our case, the device does not need to operate on userspace 
addresses, in fact quite the opposite. There may need to be additional 
things mapped into the device address space which are not, and should 
not be, visible to userspace. There are also some quite weird criteria 
for optimal address space layout which frankly are best left hidden 
inside the kernel driver. Said driver is already explicitly managing its 
own iommu_domain in the same manner as various DRM drivers and others, 
so growing that to multiple parallel domains really isn't a big leap. 
Moving any of this responsibility into userspace would be unwanted and 
unnecessary upheaval.

> What you are describing is the literal use case of /dev/ioasid - a
> clean seperation of managing the IOMMU related parts through
> /dev/ioasid and the device driver itself is only concerned with
> generating device DMA that has the proper PASID/substream tag.
> 
> The entire point is to not duplicate all the iommu code you are
> describing having written into every driver that just wants an IOASID.
> 
> In particular, you are talking about having a substream capable device
> and driver but your driver's uAPI is so limited it can't address the
> full range of substream configurations:
> 
>   - A substream pointing at a SVA
>   - A substream pointing a IO page table nested under another
>   - A substream pointing at an IOMMU page table shared by many users
> 
> And more. Which is bad.

None of which make much if any sense for the way this device and the 
rest of its software stack are designed to work, though. Anyway, the 
actual uAPI in question is essentially just chucking buffer fds about in 
a very abstract manner, so I don't see that it has any relevance here. 
We're talking about a kernel driver *internally* managing how it chooses 
to expose the buffers backing those fds to the hardware. SVA has no 
meaning in that context (there's nothing to share), and I don't even 
understand your second case, but attaching multiple SSIDs to a single 
domain is absolutely something which _could_ be done, there's just zero 
point in a single driver doing that privately when it could simply run 
the relevant jobs under the same SSID instead.

>>> We already talked about this on the "how to use PASID from the kernel"
>>> thread.
>>
>> Do you have a pointer to the right thread so I can catch up? It's not the
>> easiest thing to search for on lore amongst all the other PASID-related
>> business :(
> 
> Somewhere in here:
> 
> http://lore.kernel.org/r/20210517143758.GP1002214@nvidia.com

Thanks, along with our discussion here that kind of confirms my concern. 
Assuming IOASID can wrap up a whole encapsulated thing which is either 
SVA or IOMMU_DOMAIN_DMA is too much of an overabstraction. There 
definitely *are* uses for IOMMU_DOMAIN_DMA - say you want to put some 
SIOV ADIs to work for the host kernel using their regular 
non-IOMMU-aware driver - but there will also be cases for 
IOMMU_DOMAIN_UNMANAGED, although I do mostly expect those to be SoC 
devices whose drivers are already IOMMU-aware and just want to be so at 
a finer-grained level, not PCI devices. Even IOMMU_DOMAIN_PASSTHROUGH 
for IOASIDs _could_ be doable if a sufficiently compelling reason came 
along. I agree that SVA on init_mm is pretty bonkers, but don't get too 
hung up on the DMA API angle which is really orthogonal - passthrough 
domains with dma-direct ops have been working fine for years.

>> FWIW my non-SVA view is that a PASID is merely an index into a set of
>> iommu_domains, and in that context it doesn't even really matter *who*
>> allocates them, only that the device driver and IOMMU driver are in sync :)
> 
> Right, this is where /dev/ioasid is going.
> 
> However it gets worked out at the kAPI level in the iommu layer the
> things you asked for are intended to be solved, and lots more.

Great! It feels like one of the major things will be that, at least 
without major surgery to the DMA API, most of the use-cases will likely 
still need a struct device wrapped around the IOASID. I think the 
particular one I want to solve is actually the odd one out in that it 
doesn't really care, and could be made to work either way.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
