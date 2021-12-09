Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7344C433FE
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 09:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5ADCE4036B;
	Thu,  9 Dec 2021 09:03:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zvNLitha8dlV; Thu,  9 Dec 2021 09:03:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 653DD4036A;
	Thu,  9 Dec 2021 09:03:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 316AEC0012;
	Thu,  9 Dec 2021 09:03:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36D47C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 09:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 156724022E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 09:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="UBAjhrFq";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="Jyj5PjJV"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pjr4R_X1vuQD for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 09:03:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58CD140197
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 09:03:03 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639040580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E26dnRV33umx8ChJ6qCSA81TgS29bOEnlTFznvEPm70=;
 b=UBAjhrFqIfvy92gOjMu/92luLZEtQxcB8EnSkIXWAFQBXMfp6FG+CIy6k5fzSZFuMERG/8
 xFfVtetcOEbsB3znL7bUlgxjs4cz7rEv4z2maPrBY4od7F+YFZUnlxgZiVyKf7nPqzKqZo
 P6WDalcMWkcD1E4tHNsUxBCWBhcJQXXL67VA9WD/pk40bDo6014XJfmtDBLxn8Zj3ILXcm
 Fm2H1blgC+OVRbQuDp50QNRDGU4OLKHx5WuixE2ZlDDNvNG1GPQlUnkRK7WMjm0z4QOn5K
 7+pEpTjkMsQM6XtjDYmPSwQbt/B5mBUSba2zDYbSeit7s9Szp5MWWI+4e9OCpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639040580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E26dnRV33umx8ChJ6qCSA81TgS29bOEnlTFznvEPm70=;
 b=Jyj5PjJVVV9UfiYBlLmlLN+yWi9guY+BWs5hyOKN3TpwCmfxKHuQbAic8qnXl2XG/UWEI9
 pik8o3FpwATUUiAg==
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Date: Thu, 09 Dec 2021 10:03:00 +0100
Message-ID: <87pmq6ywu3.ffs@tglx>
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

Kevin,

On Thu, Dec 09 2021 at 06:26, Kevin Tian wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> I don't know of any use case for more than one interrupt on a queue,
>> and if it did come up I'd probably approach it by making the queue
>> handle above also specify the 'queue relative HW index'
>
> We have such use case with IDXD.
>
> Basically the IDXD queue allows software to put an interrupt handle
> (the index of MSI-X or IMS entry) in the submitted descriptor. Upon
> completion of the descriptor the hardware finds the specified entry 
> and then generate interrupt to notify software.
>
> Conceptually descriptors submitted to a same queue can use different
> handles, implying one queue can be associated to multiple interrupts.

I think you are looking at that from the internal implementation details
of IDXD. But you can just model it in an IDXD implementation agnostic
way:

     ENQCMD(PASID, IMS-ENTRY,.....)

implies an on demand allocation of a virtual queue, which is deallocated
when the command completes. The PASID and IMS-ENTRY act as the 'queue'
identifier.

The implementation detail of IDXD that it executes these computations on
an internal shared workqueue does not change that.

Such a workqueue can only execute one enqueued command at a time, which
means that during the execution of a particular command that IDXD
internal workqueue represents the 'virtual queue' which is identified by
the unique PASID/IMS-ENTRY pair.

No?

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
