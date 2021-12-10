Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52BAC433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 00:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B2CD60A7E;
	Fri, 10 Dec 2021 00:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y1IbdhZzehV2; Fri, 10 Dec 2021 00:26:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A5CD760A63;
	Fri, 10 Dec 2021 00:26:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81BEFC0012;
	Fri, 10 Dec 2021 00:26:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F6FFC0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 00:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07496826C0
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 00:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="SGuP3jiE";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="7AvNtbOo"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EHjj4e766Dcz for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 00:26:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00BDB82681
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 00:26:20 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639095977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oyRD+ut1wwQO4SYEZeVrK3aZY2EypBixx+iW/lkFS4g=;
 b=SGuP3jiErQ98J7HDSGUIX8rDX9888+GB8LHUDw6h/Wvhfnk24FU7UD854H8TZCZlitOIbC
 /VBG/amubqvGbBLOctbw7FifJsbxNgdG2N1F81Vsj1c154aE0hfzDNsot32T25tRAMi7KS
 yzu4Uwp/Ip0ebzzC1aIGSh/bVxKieeoyfi4WcHYUkyhNjIf2WRUz7csxz8NdfWgfDQv5AF
 GxureoGLp7/dRPpAVSOuy3UmxmpBOn+KH/qZED3rba+mBhJSs5fzzOL1NTL4tGsbYkt/d7
 LIa1xm23tREl7w8hubxNLwtDgIAX/nr8NAQ/SXDXAJ0EfZI8KvhQ+lzIa6qwdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639095977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oyRD+ut1wwQO4SYEZeVrK3aZY2EypBixx+iW/lkFS4g=;
 b=7AvNtbOokh8VZBBRmmnzW2IZUOSlz4rYyL79qDJjxujomOTaW52xfFBu37qbnWJytFlDWO
 CqmJc/9fUfXi95BQ==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <8735n1zaz3.ffs@tglx>
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx> <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx> <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx>
Date: Fri, 10 Dec 2021 01:26:16 +0100
Message-ID: <87sfv1xq3b.ffs@tglx>
MIME-Version: 1.0
Cc: Allen Hubbe <allenbh@gmail.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zygnier <maz@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 Logan Gunthorpe <logang@deltatee.com>, "Dey, Megha" <megha.dey@intel.com>
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

On Thu, Dec 09 2021 at 23:09, Thomas Gleixner wrote:
> On Thu, Dec 09 2021 at 16:58, Jason Gunthorpe wrote:
>> Okay, I think I get it. Would be nice to have someone from intel
>> familiar with the vIOMMU protocols and qemu code remark what the
>> hypervisor side can look like.
>>
>> There is a bit more work here, we'd have to change VFIO to somehow
>> entirely disconnect the kernel IRQ logic from the MSI table and
>> directly pass control of it to the guest after the hypervisor IOMMU IR
>> secures it. ie directly mmap the msi-x table into the guest
>
> That makes everything consistent and a clear cut on all levels, right?

Let me give a bit more rationale here, why I think this is the right
thing to do. There are several problems with IMS both on the host and on
the guest side:

  1) Contrary to MSI/MSI-X the address/data pair is not completely
     managed by the core. It's handed off to driver writers in the
     hope they get it right.

  2) Without interrupt remapping there is a fundamental issue on x86
     for the affinity setting case, as there is no guarantee that
     the magic protocol which we came up with (see msi_set_affinity()
     in the x86 code) is correctly implemented at the driver level or
     that the update is truly atomic so that the problem does not
     arise. My interrest in chasing these things is exactly zero.

     With interrupt remapping the affinity change happens at the IRTE
     level and not at the device level. It's a one time setup for the
     device.

     Just for the record:

     The ATH11 thing does not have that problem by pure luck because
     multi-vector MSI is not supported on X86 unless interrupt
     remapping is enabled. 

     The switchtec NTB thing will fall apart w/o remapping AFAICT.

  3) With remapping the message for the device is constructed at
     allocation time. It does not change after that because the affinity
     change happens at the remapping level, which eliminates #2 above.

     That has another advantage for IMS because it does not require any
     synchronization with the queue or whatever is involved. The next
     interrupt after the change at the remapping level ends up on the
     new target.

  4) For the guest side we agreed that we need an hypercall because the
     host can't trap the write to the MSI[-X] entry anymore.

     Aside of the fact that this creates a special case for IMS which is
     undesirable in my opinion, it's not really obvious where the
     hypercall should be placed to work for all scenarios so that it can
     also solve the existing issue of silent failures.

  5) It's not possible for the kernel to reliably detect whether it is
     running on bare metal or not. Yes we talked about heuristics, but
     that's something I really want to avoid.

When looking at the above I came to the conclusion that the consistent
way is to make IMS depend on IR both on the host and the guest as this
solves all of the above in one go.

How would that work? With IR the irqdomain hierarchy looks like this:

                   |--IO/APIC
                   |--MSI
    vector -- IR --|--MIX-X
                   |--IMS

There are several context where this matters:

  1) Allocation of an interrupt, e.g. pci_alloc_irq_vectors().

  2) Activation of an interrupt which happens during allocation and/or
     at request_irq() time

  3) Interrupt affinity setting

#1 Allocation

   That allocates an IRTE, which can fail

#2 Activation

   That's the step where actually a CPU vector is allocated, where the
   IRTE is updated and where the device message is composed to target
   the IRTE.

   On X86 activation is happening twice:

   1) During allocation it allocates a special CPU vector which is
      handed out to all allocated interrupts. That's called reservation
      mode. This was introduced to prevent vector exhaustion for two
      cases:
      
       - Devices allocating tons of MSI-X vectors without using
         them. That obviously needs to be fixed at the device driver
         level, but due to the fact that post probe() allocation is not
         supported, that's not always possible

       - CPU hotunplug

         All vectors targeting the outgoing CPU need to be migrated to a
         new target CPU, which can result in exhaustion of the vector
         space.

         Reservation mode avoids that because it just uses a unique
         vector for all interrupts which are allocated but not
         requested.

    2) On request_irq()

       As the vector assigned during allocation is just a place holder
       to make the MSI hardware happy it needs to be replaced by a
       real vector.

   Both can fail and the error is propagated through the call chain

#3 Changing the interrupt affinity

   This obviously needs to allocate a new target CPU vector and update
   the IRTE.

   Allocating a new target CPU vector can fail.

When looking at it from the host side, then the host needs to do the
same things:

  1) Allocate an IRTE for #1

  2) Update the IRTE for #2 and #3

But that does not necessarily mean that we need two hypercalls. We can
get away with one in the code which updates the IRTE and that would be
the point where the host side has to allocate the backing host
interrupt, which would replace that allocate on unmask mechanism which
is used today.

It might look awkward on first sight that an IRTE update can fail, but
it's not that awkward when put into context:

  The first update happens during activation and activation can fail for
  various reasons.
  
The charm is that his works for everything from INTx to IMS because all
of them go through the same procedure, except that INTx (IO/APIC) does
not support the reservation mode dance.

Thoughts?

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
