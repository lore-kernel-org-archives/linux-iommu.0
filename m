Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE08C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 15:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 569DC411F8;
	Thu,  9 Dec 2021 15:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2JsTUMCmo38C; Thu,  9 Dec 2021 15:57:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EE25D411F6;
	Thu,  9 Dec 2021 15:57:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAB2CC0012;
	Thu,  9 Dec 2021 15:57:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABB0FC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 15:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A130855B8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 15:57:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="HCnrcDa+";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="DKDiLSaR"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0SmCbGZE05gh for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 15:57:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC191855B5
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 15:57:45 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639065462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=14WfH/W9sOwaA03mQuVJyudscZd8WKKilKyxkGeP1Hw=;
 b=HCnrcDa+Sd1Yzr0vMT8kki/nF8ipIgyipTqwXdOzeZinp2yaxN8sm1WNHLP21Gp+swfRpp
 f29snYGC1/WGXp6pKw/cS6C0tguav4K/7I2vc7jBjSDmBUQuncoO4NcOHKy4rYLgmFrBT3
 gwtfj2OT0HjurIb/3AKMY0DDZ8ZzFCVMiS/lIQlfFXXJtVZ1038ixvnF8xhu+nJOCX1Okk
 pRgQnQcbzcy5e2n1eNkl5RXWynG+9UnjsxwO/xzXwpGtrB5p5sQTSbqMZEfIljcqx7FxRi
 wX6wWYyzc0y5QnZyX+lAFl7jQ6Eork7125vWq/JPWbxTKMSIbJTuvaNlNDItig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639065462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=14WfH/W9sOwaA03mQuVJyudscZd8WKKilKyxkGeP1Hw=;
 b=DKDiLSaRvv2XXelF8ez4TJ6EltJjEdm9z7/GJ40dlFn3aKyC+g77C3gyh+cNvJoGbZH7bG
 iHpBOeolc5jWWsCw==
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <BN9PR11MB5276BDE2AC58ADA7A66CAFBA8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87pmq6ywu3.ffs@tglx>
 <BN9PR11MB5276BDE2AC58ADA7A66CAFBA8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Date: Thu, 09 Dec 2021 16:57:41 +0100
Message-ID: <87mtl9zs7e.ffs@tglx>
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

On Thu, Dec 09 2021 at 12:17, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> I think you are looking at that from the internal implementation details
>> of IDXD. But you can just model it in an IDXD implementation agnostic
>> way:
>> 
>>      ENQCMD(PASID, IMS-ENTRY,.....)
>
> Not exactly IMS-ENTRY. MSI-ENTRY also works.

Sure.

>> 
>> implies an on demand allocation of a virtual queue, which is deallocated
>> when the command completes. The PASID and IMS-ENTRY act as the 'queue'
>> identifier.
>> 
>> The implementation detail of IDXD that it executes these computations on
>> an internal shared workqueue does not change that.
>> 
>> Such a workqueue can only execute one enqueued command at a time,
>> which
>> means that during the execution of a particular command that IDXD
>> internal workqueue represents the 'virtual queue' which is identified by
>> the unique PASID/IMS-ENTRY pair.
>
> While it's one way of looking at this model do we want to actually
> create some objects to represent this 'virtual queue' concept? that
> implies each ENQCMD must be moderated to create such short-lifespan
> objects and I'm not sure the benefit of doing so.

You don't have to create anything. The PASID/ENTRY pair represents that
'virtual queue', right?

> If not then from driver p.o.v it's still one queue resource and driver 
> needs to manage its association with multiple interrupt entries and 
> PASIDs when it's connected to multiple clients.

That's correct, but there is nothing problematic with it. It's like
allocating multiple interrupts for any other hardware device or
subdevice, right?

What's probably more interresting is how the PASID/interrupt/RID
relations are managed.

Thanks,

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
