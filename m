Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05477C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 19:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EF3C4225D;
	Fri, 10 Dec 2021 19:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UsB5shCCvAnl; Fri, 10 Dec 2021 19:00:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 512714224E;
	Fri, 10 Dec 2021 19:00:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35C90C0012;
	Fri, 10 Dec 2021 19:00:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB874C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 19:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA43680E65
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 19:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="4xfvC4na";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="6Dm1RTza"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SWTtsB0XZbMW for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 19:00:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F2F280E56
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 19:00:22 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639162819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BeH0Kn3WigadkhEUoB01iDiT99PSY041SAX6KkeNTw=;
 b=4xfvC4nabHIrP128E7J3+ba2aohYO0zDXeNPk+xDnNx7Z2NZyrxL2Oe9Gh1Lch5CK7l0QO
 +45W1CLIx7HFeiPsQkgJVk0x/Qq3Cz5yUikSIO9x3qkqyLbHkptlY5WxYMsz2RNk27nUys
 Akjf2x2mwW+weMYa8w36SiS8vEvaB1FjizaSljDaxN+XAuAd0U9YZc1/KnqwvF3csRSDHS
 oZibDVLb9Fs67KpVVAJDgreCUAKD/F6+bxTo2O8pQLqBFmkPNKy94+HKEqEw1rCWDl3bBu
 EYA1E2GcDvYsOAtjGe0m3kJQb7sX0rtmaOl5lkjvc0DBhARAoiaoNtEls8gfMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639162819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BeH0Kn3WigadkhEUoB01iDiT99PSY041SAX6KkeNTw=;
 b=6Dm1RTza5oJL5j7gcbgZrAwSYr6Qrei6L2Aw/pJtG3lIhtudTxPHkn/HtZp13oVAVakIkV
 lG/H1wTRd9DQnhDw==
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211210123938.GF6385@nvidia.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
Date: Fri, 10 Dec 2021 20:00:18 +0100
Message-ID: <87fsr0xp31.ffs@tglx>
MIME-Version: 1.0
Cc: Allen Hubbe <allenbh@gmail.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Zygnier <maz@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
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

Jason,

On Fri, Dec 10 2021 at 08:39, Jason Gunthorpe wrote:

> On Fri, Dec 10, 2021 at 07:29:01AM +0000, Tian, Kevin wrote:
>> >   5) It's not possible for the kernel to reliably detect whether it is
>> >      running on bare metal or not. Yes we talked about heuristics, but
>> >      that's something I really want to avoid.
>> 
>> How would the hypercall mechanism avoid such heuristics?
>
> It is clever, we don't have an vIOMMU that supplies vIR today, so by
> definition all guests are excluded and only bare metal works.

Dammit. Now you spilled the beans. :)

>> > The charm is that his works for everything from INTx to IMS because all
>> > of them go through the same procedure, except that INTx (IO/APIC) does
>> > not support the reservation mode dance.
>
> Do we even have vIOAPIC?

It does not matter much. INTx via IOAPIC is different anyway because
INTx is shared so it's unclear from which device it originates.

> It seems reasonable - do you have any idea how this all would work on
> ARM too? IMS on baremetal ARM is surely interesting. I assume they
> have a similar issue with trapping the MSI

On baremetal it should just work once ARM is converted over. No idea
about guests. Marc should know.

>> Then Qemu needs to find out the GSI number for the vIRTE handle. 
>> Again Qemu doesn't have such information since it doesn't know 
>> which MSI[-X] entry points to this handle due to no trap.
>
> No this is already going wrong. qemu *cannot* know the MSI information
> because there is no MSI information for IMS.
>
> All qemu should get is the origin device information and data about
> how the guest wants the interrupt setup.
>
> Forget about guests and all of this complexity, design how to make
> VFIO work with IMS in pure userspace like DPDK.
>
> We must have a VFIO ioctl to acquire a addr/data pair and link it to
> an event fd.
>
> I'm not sure exactly how this should be done, it is 90% of what IMS
> is, except the VFIO irq_chip cannot touch any real HW and certainly
> cannot do mask/unmask..
>
> Maybe that is OK now that it requires IR?

IR unfortunately does not allow masking, but we surely can come up some
emergency button to press when e.g. an interrupt storm is detected.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
