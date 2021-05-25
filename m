Return-Path: <SRS0=tLZ8=KU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D4EC2B9F7
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 00:01:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02866141F
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 00:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02866141F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA8AC83C16;
	Tue, 25 May 2021 00:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K3Ebn2nruo4A; Tue, 25 May 2021 00:01:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E35783C09;
	Tue, 25 May 2021 00:01:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 267F3C000E;
	Tue, 25 May 2021 00:01:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B54D1C0001
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 00:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A389D83C28
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 00:00:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5an7de_LX3TI for <iommu@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:00:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 59CCC83C09
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 00:00:58 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id ee9so15123090qvb.8
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 17:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9Q591FllhieJXv2nQ2uaXWKAfar654swTBL1y/52ZTA=;
 b=F+Q+MuvRzv87guQNOyCkDgH2KR3SyGVJBe7Sf4+ZpaNRkmWNFlaR2E7jPfn7ua17AW
 poGNO6jtPqf2QK8paqIIMBZTFDohPJ3QX3BCx5por5OMmcNj1jxo7Fq+INTTInLXYSKY
 Ae7y44LhGyRBG3w90JhhPad3Omz2n5d6e0iPgQVPdKggsZSUt6A4lGG1YJmmtHwYpktx
 gn/coPcrYSg/f63NgO0ko9o3N6q4zqh97x96rEyWBJ6fEyMBiOKaV3ZuAIu3UtdTIw5k
 O4IQoKJgbzU2aU9IYDx1Owl5xF/EwwR+FNoHS+lgZ9DQPSo/eoTz8dKz9YQe+fxuQLPy
 +j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9Q591FllhieJXv2nQ2uaXWKAfar654swTBL1y/52ZTA=;
 b=g5XQo9RXFLeJSIZVk+BWap2Xh3nvOpHBQov8iOWDwWzrigX8J6G7gyzoJ8w13h88h/
 Fml3F7uVmgBJjhjHNSYwu2/lXvObbp3M5VllolNJ7zEaOC8frWVEup6I0BJ5WQB+A3uV
 7mqdd6jcLZ27gHJCBZiM+yP45zSNC6jHlE5jZShcmBZVJvbpELtRKbU6Dp2hXdxzoVzO
 KnGVgkssH5uZ0oP6xhKkc9dqdq99qIUUwtnSHXxg0ggV7dlaEmSXbV7Y3a3XNiBpcbDZ
 fo8RTKxG9/fRQwiY9G8+0gkeLBY0hU0xo5X7+AVbzrkWAEU7vRRnWeHTElEAAEDhc6ba
 tpsQ==
X-Gm-Message-State: AOAM530gJiSzU5n4+X7pFQw+nFDTWS7jDNJW2UJcsqdbgckCKzN4z79E
 4pw5kOYZHxFJL9CmLJT3Hc8evg==
X-Google-Smtp-Source: ABdhPJx/Mmz6eXxmbM0mHwA3KTgsZknoTEDmzQGImMrEAf341Qh4ZGYu6ZNAaNpsKShgJYiYUWgIjg==
X-Received: by 2002:ad4:53cc:: with SMTP id k12mr33396696qvv.49.1621900857085; 
 Mon, 24 May 2021 17:00:57 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id t187sm12163384qkc.56.2021.05.24.17.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 17:00:56 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1llKVC-00Dpgy-VO; Mon, 24 May 2021 21:00:55 -0300
Date: Mon, 24 May 2021 21:00:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210525000054.GY1096940@ziepe.ca>
References: <YKJnPGonR+d8rbu/@8bytes.org> <20210517133500.GP1096940@ziepe.ca>
 <YKKNLrdQ4QjhLrKX@8bytes.org>
 <131327e3-5066-7a88-5b3c-07013585eb01@arm.com>
 <20210519180635.GT1096940@ziepe.ca>
 <MWHPR11MB1886C64EAEB752DE9E1633358C2B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210519232459.GV1096940@ziepe.ca>
 <1d154445-f762-1147-0b8c-6e244e7c66dc@arm.com>
 <20210520143420.GW1096940@ziepe.ca>
 <9d34b473-3a37-5de2-95f8-b508d85e558c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9d34b473-3a37-5de2-95f8-b508d85e558c@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, May 24, 2021 at 07:18:33PM +0100, Robin Murphy wrote:
> On 2021-05-20 15:34, Jason Gunthorpe wrote:
> > On Thu, May 20, 2021 at 03:13:55PM +0100, Robin Murphy wrote:
> > 
> > > By "mdev-like" I mean it's very similar in shape to the general SIOV-style
> > > mediated device concept - i.e. a physical device with an awareness of
> > > operating on multiple contexts at once, using a Substream ID/PASID for each
> > > one - but instead of exposing control of the contexts to anyone else, they
> > > remain hidden behind the kernel driver which already has its own abstracted
> > > uAPI, so overall it ends up as more just internal housekeeping than any
> > > actual mediation. We were looking at the mdev code for inspiration, but
> > > directly using it was never the plan.
> > 
> > Well:
> >   - Who maps memory into the IOASID (ie the specific sub stream id)?
> 
> Sorry to nitpick, but I think it's important to get terminology right here
> to avoid unnecessary misunderstanding. You can't map memory into an address
> space ID; it's just a number. 

Ah sorry, the naming in the other thread for the uAPI seems to trended
into the IOASID == what the kernel calls domain and what the kernel
calls ioasid (the number) is just some subproperty.

Nobody has come up with a better name to refer to an abstract io page
table object. Maybe the RFC stage will elicit a better idea.

> implicitly by a userspace process; I care about the case of it being
> provided by an iommu_domain where things are mapped explicitly by a
> kernel driver. I would be extremely wary of creating some new third
> *address space* abstraction.

Well we have lots, and every time you add new uAPI to kernel drivers
to program an IOMMU domain you are making more.

Frankly, the idea of having a PASID/substream ID that is entirely
programmed by the kernel feels like using the thing wrong.. Why do
this? The primary point of these things is to create a security
boundary, but if the kernel already controls everything there isn't a
security boundary to be had.

What is the issue with just jamming everything into the the main IO
page table for the device?
 
> >   - What memory must be mapped?
> >   - Who triggers DMA to this memory?
> 
> It's a pretty typical DMA flow, as far as I understand. Userspace allocates
> some buffers (in this case, via the kernel driver, but in general I'm not
> sure it makes much difference), puts data in the buffers, issues an ioctl to
> say "process this data", and polls for completion; the kernel driver makes
> sure the buffers are mapped in the device address space (at allocation time
> in this case, but in general I assume it could equally be done at request
> time for user pages), and deals with scheduling requests onto the hardware.

Sounds like a GPU :P

> I understand this interface is already deployed in a driver stack which
> supports a single client process at once; extending the internals to allow
> requests from multiple processes to run in parallel using Substream IDs for
> isolation is the future goal. The interface itself shouldn't change, only
> some internal arbitration details.

Using substreams for isolation makes sense, but here isolation should
really mean everything. Stuffing a mix of kernel private and
application data into the same isolation security box sounds like a
recipe for CVEs to me...

> No. In our case, the device does not need to operate on userspace addresses,
> in fact quite the opposite. There may need to be additional things mapped
> into the device address space which are not, and should not be, visible to
> userspace. There are also some quite weird criteria for optimal address
> space layout which frankly are best left hidden inside the kernel driver.
> Said driver is already explicitly managing its own iommu_domain in the same
> manner as various DRM drivers and others, so growing that to multiple
> parallel domains really isn't a big leap. Moving any of this responsibility
> into userspace would be unwanted and unnecessary upheaval.

This is all out of tree right?
 
> (there's nothing to share), and I don't even understand your second case,
> but attaching multiple SSIDs to a single domain is absolutely something
> which _could_ be done, there's just zero point in a single driver doing that
> privately when it could simply run the relevant jobs under the same SSID
> instead.

It makes sense in the virtualization context where often a goal is to
just map the guest's physical address space into the IOMMU and share
it to all DMA devices connected to the VM.

Keep in mind most of the motivation here is to do something more
robust for the virtualization story.

> > http://lore.kernel.org/r/20210517143758.GP1002214@nvidia.com
> 
> Thanks, along with our discussion here that kind of confirms my concern.
> Assuming IOASID can wrap up a whole encapsulated thing which is either SVA
> or IOMMU_DOMAIN_DMA is too much of an overabstraction.

I think it is more than just those two simple things. There are lots
of platform specific challenges to creating vIOMMUs, especially with
PASID/etc that needs to be addressed too.

> There definitely *are* uses for IOMMU_DOMAIN_DMA - say you want to
> put some SIOV ADIs to work for the host kernel using their regular
> non-IOMMU-aware driver - but there will also be cases for

Er, I don't think SIOV's work like that. Nobody is going to create a
SIOV using a completely unaware driver - that only works in
virtualization and relies on hypervisor software to build up the
fiction of a real device.

In-kernel SIOV usages are going to have to either continue to use the
real device's IOMMU page tables or to convince the DMA API to give it
another PASID/SSID/etc.

At least this is how I'm seeing real SIOV device drivers evolving
right now. We already have some real examples on this in mlx5 and
today it uses the parent device's IOMMU page tables.

> IOMMU_DOMAIN_UNMANAGED, although I do mostly expect those to be SoC
> devices whose drivers are already IOMMU-aware and just want to be so
> at a finer-grained level, not PCI devices. Even
> IOMMU_DOMAIN_PASSTHROUGH for IOASIDs _could_ be doable if a
> sufficiently compelling reason came along. I agree that SVA on
> init_mm is pretty bonkers, but don't get too hung up on the DMA API
> angle which is really orthogonal - passthrough domains with
> dma-direct ops have been working fine for years.

I've heard the DMA API maintainers refer to that "working fine" as
hacky crap, so <shrug>.

A formalization of this stuff should not be excluding the DMA API.

> Great! It feels like one of the major things will be that, at least without
> major surgery to the DMA API,

So long as the DMA is all orchestrated by userspace to userspace
buffers, the DMA API doesn't get involved. It is only the thing that
in-kernel users should use.

IMHO if your use case is to do DMA to a security domain then it should
all go through the DMA API, including the mapping of memory into the
IOMMU page tables for that domain. Having a kernel driver bypassing
the whole thing by directly using the domain directly seems quite
rough to me.

A drivers/iommu API call to take an arbitary struct device and bind
the DMA API for the struct device to a newly created PASID/SSID of a
real device seems like a reasonable direction to me for in-kernel use.

Especially if the struct device doesn't need to be device_add()'d.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
