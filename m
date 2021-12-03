Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F91C433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Dec 2021 15:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80ACC83026;
	Fri,  3 Dec 2021 15:08:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qufnnTpMANlV; Fri,  3 Dec 2021 15:08:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7EB8783004;
	Fri,  3 Dec 2021 15:08:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FCD8C0012;
	Fri,  3 Dec 2021 15:08:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D46B0C0012
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 15:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CEFB860AB0
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 15:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="0uGHErG9";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="WGN48Z7D"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1EYYzyPnXYYf for <iommu@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 15:08:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 986E560AA9
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 15:08:02 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638544079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5DWEYeg5U2h8L+FTX54oEQ7W1kCRjbyOxlwP1Aeuss=;
 b=0uGHErG9mpHWAfpsEG65MpOtRbqWHOA57Gj0pSXaGsfjqUo65SiX+XfK8UO8iE8lxZb5Pg
 BzLrMIaCE2Ope09kd5DmRrRGzploXrfNzAdMAIyElgsPirCgPtrnc1DXUofFIneOIGveDb
 DzJJFoP+TqDevGvq01vir2UBC52MxQ+Ok1+VtERMT3Yj7qZtC2h8D9sMphlim44+IZPSfy
 bTREIxnjnKs5Yki5D7SH/LzzE3k0P3oJESJj99xv0E0ZNF0TttQjytTNHIu45puCwpoAHU
 7yGQuSw00td0LrZIclXJBFHm4sgNG6nu1bMwz/4tGRz7Mws9AHr7hFSXWyOjkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638544079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5DWEYeg5U2h8L+FTX54oEQ7W1kCRjbyOxlwP1Aeuss=;
 b=WGN48Z7DE8Oad1PtlNxETJXcPKvYQyjdAzWC5hhLrOgIZ3gQvDkiUKvS0yeV9L6zxgJW/Y
 VabFETLAopC4ijDw==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211203003749.GT4670@nvidia.com>
References: <87mtlkaauo.ffs@tglx> <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com>
Date: Fri, 03 Dec 2021 16:07:58 +0100
Message-ID: <877dcl681d.ffs@tglx>
MIME-Version: 1.0
Cc: Allen Hubbe <allenbh@gmail.com>, linux-s390@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, x86@kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zygnier <maz@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-ntb@googlegroups.com, Logan Gunthorpe <logang@deltatee.com>,
 Megha Dey <megha.dey@intel.com>
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

On Thu, Dec 02 2021 at 20:37, Jason Gunthorpe wrote:
> On Thu, Dec 02, 2021 at 11:31:11PM +0100, Thomas Gleixner wrote:
>> >> Of course we can store them in pci_dev.dev.msi.data.store. Either with a
>> >> dedicated xarray or by partitioning the xarray space. Both have their
>> >> pro and cons.
>> >
>> > This decision seems to drive the question of how many 'struct devices'
>> > do we need, and where do we get them..
>> 
>> Not really. There is nothing what enforces to make the MSI irqdomain
>> storage strictly hang off struct device. There has to be a connection to
>> a struct device in some way obviously to make IOMMU happy.
>
> Yes, I thought this too, OK we agree

One thing which just occured to me and I missed so far is the
association of the irqdomain.

Right now we know for each device which irqdomain it belongs to. That's
part of device discovery (PCI, device tree or whatever) which set's up

     device->irqdomain

That obviously cannot work for that device specific IMS domain. Why?

Because the PCIe device provides MSI[x] which obviously requires that
device->irqdomain is pointing to the PCI/MSI irqdomain. Otherwise the
PCI/MSI allocation mechanism wont work.

Sure each driver can have

     mystruct->ims_irqdomain

and then do the allocation via

    msi_irq_domain_alloc(mystruct->ims_irqdomain....)

but I really need to look at all of the MSI infrastructure code whether
it makes assumptions about this:

   msi_desc->dev->irqdomain

being the correct one. Which would obviously just be correct when we'd
have a per queue struct device :)

>> Just badly named because the table itself is where the resulting message
>> is stored, which is composed with the help of the relevant MSI
>> descriptor. See above.
>
> I picked the name because it looks like it will primarily contain an
> xarray and the API you suggested to query it is idx based. To me that
> is a table. A table of msi_desc storage to be specific.
>
> It seems we have some agreement here as your lfunc also included the
> same xarray and uses an idx as part of the API, right?

It's a per lfunc xarray, yes.

>> We really should not try to make up an artifical table representation
>> for something which does not necessarily have a table at all, i.e. the
>> devices you talk about which store the message in queue specific system
>> memory. Pretending that this is a table is just silly.
>
> Now I'm a bit confused, what is the idx in the lfunc? 
>
> I think this is language again, I would call idx an artificial table
> representation?

Ok. I prefer the term indexed storage, but yeah.

>> I really meant a container like this:
>> 
>> struct logical_function {
>>         /* Pointer to the physical device */
>>         struct device		*phys_device;
>>         /* MSI descriptor storage */
>> 	struct msi_data		msi;
>
> Up to here is basically what I thought the "message table" would
> contain. Possibly a pointer to the iommu_domain too?
>
>>         /* The queue number */
>>         unsigned int		queue_nr;
>>         /* Add more information which is common to these things */
>
> Not sure why do we need this?
>
> Lets imagine a simple probe function for a simple timer device. It has
> no cdev, vfio, queues, etc. However, the device only supports IMS. No
> MSI, MSI-X, nothing else.
>
> What does the probe function look like to get to request_irq()?

The timer device would be represented by what? A struct device?

If so then something needs to set device->irqdomain and then you can
just do:

     msi_irq_domain_alloc_irqs(dev->irqdomain, dev, ...);

> Why does this simple driver create something called a 'logical
> function' to access its only interrupt?

It does not have to when it's struct device based.

> I think you have the right idea here, just forget about VFIO, the IDXD
> use case, all of it. Provide a way to use IMS cleanly and concurrently
> with MSI.
>
> Do that and everything else should have sane solutions too.

To do that, I need to understand the bigger picture and the intended
usage because otherwise we end up with an utter mess.

>> The idea is to have a common representation for these type of things
>> which allows:
>> 
>>  1) Have common code for exposing queues to VFIO, cdev, sysfs...
>> 
>>     You still need myqueue specific code, but the common stuff which is
>>     in struct logical_function can be generic and device independent.
>
> I will quote you: "Seriously, you cannot make something uniform which
> is by definition non-uniform." :)
>
> We will find there is no common stuff here, we did this exercise
> already when we designed struct auxiliary_device, and came up
> empty.

Really?

>>  2) Having the MSI storage per logical function (queue) allows to have
>>     a queue relative 0 based MSI index space.
>
> Can you explain a bit what you see 0 meaning in this idx numbering?
>
> I also don't understand what 'queue relative' means?
>
>>     The actual index in the physical table (think IMS) would be held in
>>     the msi descriptor itself.
>
> This means that a device like IDXD would store the phsical IMS table
> entry # in the msi descriptor? What is idx then?
>
> For a device like IDXD with a simple linear table, how does the driver
> request a specific entry in the IMS table? eg maybe IMS table entry #0
> is special like we often see in MSI?

If there is a hardwired entry then this hardwired entry belongs to the
controlblock (status, error or whatever), but certainly not to a
dynamically allocatable queue as that would defeat the whole purpose.

That hardwired entry could surely exist in a IDXD type setup where the
message storage is in an defined array on the device.

But with the use case you described where you store the message at some
place in per queue system memory, the MSI index is not relevant at all,
because there is no table. So it's completely meaningless for the device
and just useful for finding the related MSI descriptor again.

If the queue or the controlblock have an internal small array of
messages in their queue or controlblock specific memory, then how would
a per device global index help?

Or has each queue and controlblock and whatever access to a shared large
array where the messages are stored and the indices are handed out to
the queues and controlblocks?

If each of them have their own small array, then queue relative indexing
makes a ton of sense, no?

> For the devices I know about there are two approaches for allocating
> interrupts. 

I'm aware of that.

> When I imagine mlx5 using IMS, I see IMS as a simple extension of the
> existing MSI-X vector pool. Every IMS vector is interchangable and the
> main PCI driver will apply exactly the same allocation algorithm we
> already have today for MSI, just with even more vectors. When VFIO
> wants a vector it may get a MSI or it may get an IMS, I don't want to
> care.
>
> All of this about logical functions just confuses
> responsibilities. The IRQ layer should be worrying about configuring
> IRQs and not dictating how the device will design its IRQ assignment
> policy or subdevice scheme.

The IRQ layer _has_ to worry about it because there is a strict
relationship between device and irqdomain today.

Now with a PCIe device having PCI/MSI[X] it's a strict 1:1
relationship. Now add IMS to the picture and we end up with a 1:2
relationship, which does not work today.

That's why my initial reaction was to partition the device into
subdevices which would have solved the problem nicely.

> IMHO this has become hyper focused on the special IDXD VFIO use case -
> step back and think about my timer example above - a simple pci_driver
> that just wants to use IMS for itself. No queues, no VFIO, no
> mess. Just how does it configure and use the interrupt source.

That would mean that the PCI device would not use MSI-X at all, right?
So it could have pci_dev.dev.irqdomain = IMSdomain.

But that sucks too because it's yet another quirk as the PCIe discovery
cannot set that up simply because the device specific IMS domain does
not exist yet.

> Is it helpful feedback?

Yes, definitely. It helps me to understand the bigger picture and to
find a proper representation of these things so that we don't end up
with the usual mess in drivers/* which makes it a fricking nightmare to
change anything at the core code at all.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
