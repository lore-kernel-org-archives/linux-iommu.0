Return-Path: <SRS0=KEvp=CA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEECC433E3
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 01:34:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D1320735
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 01:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gqWN4ew2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mLsFSzy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D1320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AD9C822621;
	Sat, 22 Aug 2020 01:34:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XbXdnMcrdHWD; Sat, 22 Aug 2020 01:34:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2E46B2152E;
	Sat, 22 Aug 2020 01:34:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B1C7C0889;
	Sat, 22 Aug 2020 01:34:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B90BC0051
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 01:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3F13E21538
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 01:34:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ttU4Fk9nHI8u for <iommu@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 01:34:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 268D02152E
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 01:34:49 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598060086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nz/9GcEZiJRVQwppT3u/3DMX1VmX3CDhMpuuU+KPrYE=;
 b=gqWN4ew2Hp5FmAu1u6jlph8fiR/xZUN1x/TLB/mxoFPnUshdgAyFhWycpVI19otyAM1sWt
 gPgJUlXHnWBEIa931+Xhft5Z2XxoKuGlb/QrhkWREFGG8Xk+8hsyst9INoQDycby6ix9ZW
 Blm1MGNuQM86txgUGZavEyIxV2dXZbdkEf9SPds63RNu9Gv8PSQFjJJN5ho7QBhKScw9Sz
 3hp0K9hzzmPwdTAMsqCtc7AG8/zjpKpnCn+S+rh0lJO5lEwSO01IPTMdgxXnPkLRkNkbz0
 eGI2HfBsqEGmmwV9mhldpn0Z8Ky03jTnLPrydZFQBLRyQez69Da0h2LoQ7BX7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598060086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nz/9GcEZiJRVQwppT3u/3DMX1VmX3CDhMpuuU+KPrYE=;
 b=mLsFSzy6Tm79Wj6LjfFtlF7l657qdrqbOGQMqRhab6Wim8XLycKBLp0q/HdnaiLDDx4/kT
 vB2su76TijRGjPDg==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch RFC 38/38] irqchip: Add IMS array driver - NOT FOR MERGING
In-Reply-To: <20200822005125.GB1152540@nvidia.com>
References: <20200821002424.119492231@linutronix.de>
 <20200821002949.049867339@linutronix.de>
 <20200821124547.GY1152540@nvidia.com>
 <874kovsrvk.fsf@nanos.tec.linutronix.de>
 <20200821201705.GA2811871@nvidia.com>
 <87pn7jr27z.fsf@nanos.tec.linutronix.de>
 <20200822005125.GB1152540@nvidia.com>
Date: Sat, 22 Aug 2020 03:34:45 +0200
Message-ID: <874kovqx8q.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Wei Liu <wei.liu@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

Jason,

On Fri, Aug 21 2020 at 21:51, Jason Gunthorpe wrote:
> On Sat, Aug 22, 2020 at 01:47:12AM +0200, Thomas Gleixner wrote:
>> > If the device has died the driver has code to detect and trigger a
>> > PCI function reset which will definitely stop the interrupt.
>> 
>> If that interrupt is gone into storm mode for some reason then this will
>> render your machine unusable before you can do that.
>
> Yes, but in general the HW design is to have one-shot interrupts, it
> would have to be well off the rails to storm. The kind of off the
> rails where it could also be doing crazy stuff on PCI-E that would be
> very harmful.

Yeah. One shot should prevent most of the wreckage. I just wanted to
spell it out.

>> One question is whether the device can see partial updates to that
>> memory due to the async 'swap' of context from the device CPU.
>
> It is worse than just partial updates.. The device operation is much
> more like you'd imagine a CPU cache. There could be copies of the RAM
> in the device for long periods of time, dirty data in the device that
> will flush back to CPU RAM overwriting CPU changes, etc.

TBH, that's insane. You clearly want to think about this some more. If
you swap out device state and device control state then you definitly
want to have regions which are read only from the device POV and never
written back. The MSI msg store clearly belongs into that category.
But that's not restricted to the MSI msg store, there is certainly other
stuff which never wants to be written back by the device.

If you don't do that then you simply can't write to that space from the
CPU and you have to transport this kind information always via command
queues.

But that does not make sense. It's trivial enough to have

    | RO state |
    | RW state |

and on swap in the whole thing is DMA'd into the device and on swap out
only the RW state part. It's not rocket science and makes a huge amount
of sense.

> Without involving the device there is just no way to create data
> consistency, and no way to change the data from the CPU. 
>
> This is the down side of having device data in the RAM. It cannot be
> so simple as 'just fetch it every time before you use it' as
> performance would be horrible.

That's clear, but with a proper seperation like the above and some extra
mechanism which allows you to tickle a relaod of 'RO state' you can
avoid quite some of the problems which you create otherwise.

>> If we really can get away with atomically updating the message as
>> outlined above and just let it happen at some point in the future then
>> most problems are solved, except for the nastyness of CPU hotplug.
>
> Since we can't avoid a device command, I'm think more along the lines
> of having the affinity update trigger an async WQ to issue the command
> from a thread context. Since it doesn't need to be synchronous it can
> make it out 'eventually'.
>
> I suppose the core code could provide this as a service? Sort of a
> varient of the other lazy things above?

Kinda. That needs a lot of thought for the affinity setting stuff
because it can be called from contexts which do not allow that. It's
solvable though, but I clearly need to stare at the corner cases for a
while.

> But it would have to work with ARM - is remapping a x86 only thing?

No. ARM64 has that as well.

> Does ARM put the affinity in the GIC tables not in the MSI data?

IIRC, yes.

>> Let me summarize what I think would be the sane solution for this:
>> 
>>   1) Utilize atomic writes for either all 16 bytes or reorder the bytes
>>      and update 8 bytes atomically which is sufficient as the wide
>>      address is only used with irq remapping and the MSI message in the
>>      device is never changed after startup.
>
> Sadly not something the device can manage due to data coherence

I disagree :)

>>   2) No requirement for issuing a command for regular migration
>>      operations as they have no requirements to be synchronous.
>> 
>>      Eventually store some state to force a reload on the next regular
>>      queue operation.
>
> Would the async version above be OK?

Async is fine in any variant (except for hotplug). Though having an
async WQ or whatever there needs some thought.

>>   3) No requirement for issuing a command for mask and unmask operations.
>>      The core code uses and handles lazy masking already. So if the
>>      hardware causes the lazyness, so be it.
>
> This lazy masking thing sounds good, I'm totally unfamiliar with it
> though.

It's used to avoid irq chip (often MMIO) access in scenarios where
disable/enable of an interrupt line happens with high frequency. Serial
has that issue. So we mark it disabled, but do not mask it and the core
can handle that and masks it once an interrupt comes in in masked
state. That obviously does not work out of the box to protect against
not disabled but masked state, but conceptually it's a similar problem
and can be made work without massive changes. 

OTOH, in normal operation for MSI interrupts (edge type) masking is not
used at all and just restricted to the startup teardown.

But I clearly need to think about it with a more awake brain some more.

> This email is super helpful, I definately don't know all these corners
> of the IRQ subsystem as my past with it has mostly been SOC stuff that
> isn't as complicated!

It's differently complicated and not less horrible :)

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
