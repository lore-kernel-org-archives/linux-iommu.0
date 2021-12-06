Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AB7C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 22:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1CBE8404C2;
	Mon,  6 Dec 2021 22:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gQgMcRke7X6j; Mon,  6 Dec 2021 22:21:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 61EAA4015F;
	Mon,  6 Dec 2021 22:21:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41BEFC0012;
	Mon,  6 Dec 2021 22:21:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C1F0C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 869D541C4D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="0J9687id";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="Wx4gi6Bj"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tNyYvELlhp42 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 22:21:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C618D41C4C
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:21:25 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638829282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N49gEhli14ajV1XqLRb5F9ss4iZ1ZN+8bFDUJvAuM3M=;
 b=0J9687idATq3eSU8opoNI/aOkzjdbjjUpMWjHV3Qabs9RqhCNQPNJBr+5i+m3099/jmwq6
 g+ZAiliCpYaXekUHvIKQ2pI4cx3rTI+UFvB0BfqfMIO6f6uBoQUW7LsfXWTS6j+C6mS+3V
 VftXiEs/guGu3i3k6vp77PkuLjxC1mDHeeGcz4MKif8n/65DKd403BVDutNlFXLJZLL5IP
 0VoEExR2BtW7/b8MSBB2ynUXeBvvYayWrW2i+L7o18ENw2U9MeEcyaqsLWKHXD+P38wGGq
 mBPhQZklZdrOsB58eh0sUEXK2m7IfLSHId+27nhXNBKURzAaEPdripwxy+a3+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638829282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N49gEhli14ajV1XqLRb5F9ss4iZ1ZN+8bFDUJvAuM3M=;
 b=Wx4gi6Bj1U8lrQ5ISmceY0XquUUW6+HVPKcwkr02uxE46QEl5SfZX1pDjpJhD0CY+dlfk/
 g6Qu7fTSIpyIBKCw==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211206210609.GN4670@nvidia.com>
References: <87o85y63m8.ffs@tglx> <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx> <20211203164104.GX4670@nvidia.com>
 <87v9044fkb.ffs@tglx> <87o85v3znb.ffs@tglx>
 <20211206144344.GA4670@nvidia.com> <87fsr54tw1.ffs@tglx>
 <20211206170035.GJ4670@nvidia.com> <875ys14gw0.ffs@tglx>
 <20211206210609.GN4670@nvidia.com>
Date: Mon, 06 Dec 2021 23:21:21 +0100
Message-ID: <87zgpd2x3y.ffs@tglx>
MIME-Version: 1.0
Cc: Allen Hubbe <allenbh@gmail.com>, linux-s390@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, x86@kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zygnier <maz@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 linux-pci@vger.kernel.org, linux-ntb@googlegroups.com,
 Logan Gunthorpe <logang@deltatee.com>, Megha Dey <megha.dey@intel.com>
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

On Mon, Dec 06 2021 at 17:06, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 09:28:47PM +0100, Thomas Gleixner wrote:
>> I wish I could mask underneath for some stuff on x86. Though that would
>> not help with the worst problem vs. affinity settings. See the horrible
>> dance in:
>
> My thinking here is that this stuff in ARM is one of the different
> cases (ie not using MSI_FLAG_USE_DEF_CHIP_OPS), and I guess we can
> just handle it cleanly by having the core call both the irq_chip->mask
> and the msi_storage_ops->mask and we don't need ARM to be different,
> x86 just won't provide a mask at destination op.
>
>>     x86/kernel/apic/msi.c::msi_set_affinity()
>
> Okay, so it is complicated, but it is just calling
>    irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);
>
> So, from a msi_storage_ops perspective, things are still clean.

Yes.

>> You forgot IO/APIC which is a MSI endpoint too, just more convoluted but
>> it's not using MSI domains so it's not in the way. I'm not going to
>> touch that with a ten foot pole. :)
>
> I left off IOAPIC because I view it as conceptually different. I used
> the phrasse "device that originated the interrupt" deliberately,
> IOAPIC is just a middle box that converts from a physical interrupt
> line to a message world, it belongs with the physical interrupt
> infrastructure.

I mentioned it because there is mbigen on arm64 which is the same thing,
translates hundreds of wire inputs into MSI. It's even worse than
IO/APIC. There is a horrible hack to make it "work" which Marc and I are
looking at whether we can kill it on the way.

> Possibly the IOAPIC considerations is what motivated some of this to
> look the way it does today, because it really was trying to hide MSI
> under normal PCI INTX physical pins with full compatability. We kind
> of kept doing that as MSI grew into its own thing.

Not really. It was more to avoid having a complete separate
infrastructure for irqdomain based MSI[X]. Lazyness and lack of time
added the rest of non-motivation :)

> I'm curious to see if you end up with irq_domains and irq_chips along
> with what I labeled as the msi_storage above, or if those turn out to
> be unnecesary for the driver to provide MSI programming.

I cant avoid irq chips because from the interrupt handling side of view
that's unavoidable unless we create a duplicate zoo there. What I have
in mind is to convert the msi ops provided by the device driver into a
real chip as that just falls in place without further changes.

The irqdomain will be real as well just to make things consistent and to
share as much code as possible.

> Also, if msi_storage_ops can be robust enough you'd be comfortable
> with it in a driver .c file and just a regex match in the MAINTAINERS
> file :)

That might work. Let's see when we are there.

>>    - Have a transition mechanism to convert one part at a time to keep
>>      the patch sizes reviewable and the whole mess bisectable.
>
> This seems difficult all on its own..

I've done that before. It just needs some thought.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
