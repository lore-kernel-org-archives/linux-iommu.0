Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEC2C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 22:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BBAF4EF03;
	Thu,  9 Dec 2021 22:10:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MHf57O9x88TM; Thu,  9 Dec 2021 22:09:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09FD94EEFF;
	Thu,  9 Dec 2021 22:09:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8A98C0012;
	Thu,  9 Dec 2021 22:09:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 238EAC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 22:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11BE585B46
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 22:09:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="WW18ExaR";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="qVn3U9HW"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UFVz7DSj5QPa for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 22:09:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0551385B36
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 22:09:56 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639087793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B+lqUDLWtnvLeY/KahuIZ2Xvfr4Bwoi1ABSMRvnITCk=;
 b=WW18ExaRnpYiWwbxv1Oo+xyj2rfXtsbPW+X7DVsTiaqB6wgXzATusvwhCl2GaS0rdR+WnS
 tJqrFACnb/P7aMyauV0Fi+Y2Ij1B/GX/eVn6EGdEM6K0YI6JQPA4aM+WtDI3/kaLnHJ2QX
 nipiipByknmKWpGePlYzrzCt1B7GA4MVVwpoZbz8+GW4x4UCOWa7s+e/WbNp3weWyzEOkB
 ChXF2+m0tC/eW9+h/iL1fdpba0kWZqBeWFWjFofAKXGAntdvIInQwwsjY75CFMBPXGsfyC
 5gDlVAIJET2FXFHnFwbuWUKB2ii1p17poTV9Hn4kr4bxvGjeaFlv5zW+2fiLpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639087793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B+lqUDLWtnvLeY/KahuIZ2Xvfr4Bwoi1ABSMRvnITCk=;
 b=qVn3U9HWxK+h6v6N25iCCmQPsywBb9D/DewlfObPZ14vxsbLUpThsREQ0c1etj4ttkaC80
 m8v8EwcoDdMel9DA==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211209205835.GZ6385@nvidia.com>
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx> <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx> <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
Date: Thu, 09 Dec 2021 23:09:52 +0100
Message-ID: <8735n1zaz3.ffs@tglx>
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

On Thu, Dec 09 2021 at 16:58, Jason Gunthorpe wrote:
> On Thu, Dec 09, 2021 at 09:32:42PM +0100, Thomas Gleixner wrote:
>> That was my thought to avoid having different mechanisms.
>> 
>> The address/data pair is computed in two places:
>> 
>>   1) Activation of an interrupt
>>   2) Affinity setting on an interrupt
>> 
>> Both configure the IRTE when interrupt remapping is in place.
>> 
>> In both cases a vector is allocated in the vector domain and based on
>> the resulting target APIC / vector number pair the IRTE is
>> (re)configured.
>> 
>> So putting the hypercall into the vIRTE update is the obvious
>> place. Both activation and affinity setting can fail and propagate an
>> error code down to the originating caller.
>> 
>> Hmm?
>
> Okay, I think I get it. Would be nice to have someone from intel
> familiar with the vIOMMU protocols and qemu code remark what the
> hypervisor side can look like.
>
> There is a bit more work here, we'd have to change VFIO to somehow
> entirely disconnect the kernel IRQ logic from the MSI table and
> directly pass control of it to the guest after the hypervisor IOMMU IR
> secures it. ie directly mmap the msi-x table into the guest

That makes everything consistent and a clear cut on all levels, right?

Thanks,

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
