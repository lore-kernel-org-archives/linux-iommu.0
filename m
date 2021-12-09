Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B14C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 08:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31BC26074A;
	Thu,  9 Dec 2021 08:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E20YDgEkcoPH; Thu,  9 Dec 2021 08:37:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33682606B4;
	Thu,  9 Dec 2021 08:37:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC8EAC0012;
	Thu,  9 Dec 2021 08:37:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38E71C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 08:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17FF64059F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 08:37:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="H2fIzRBi";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="bi+8Ibnj"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bBjJLGw9pNd5 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 08:37:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 438AC4059D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 08:37:10 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639039027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzMFnVW/85YWmTw86Zk7iMM6erPIn8vff7QnFiF41HE=;
 b=H2fIzRBiecZzkrgJpASWNRz2D5zY326mVdbBNkuOsxv9stoVdblJS/rFVzIIRGAkRdSnEf
 drC7nyP/8YokJ9Oj0D0UO1sSaI0BtbvnEeGXu6362wTmW3gTypNrfMb7UX+LAScqMj3R2J
 /IMCRDSnxGJ+vMyAPKqLS8MDarmWHCRuUd0hw7ZaNyZJOGVNBBc6/Hrseu5ph1y/ip3aDy
 TdBtadiqCB3jjz2f23h/QrMIKCsvV5FbgRpjyQXtwKj3jCSgQOy/I+cb/kyZacgIa6FWFC
 riI6ed5iHo8iL/iA82Fa8MRYTAp7z+uRaMCY63FYFqPkDn2l6pjl5rXHgXSw2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639039027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzMFnVW/85YWmTw86Zk7iMM6erPIn8vff7QnFiF41HE=;
 b=bi+8IbnjSJqim1yrMqKUqz/cyLW1+6NdX2qMdIWNvgW9Q9i8LMYUfva+UJ6WnT6hFxJ4P1
 qo6SpDKNWDp8qqDA==
To: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave"
 <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com> <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com> <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Date: Thu, 09 Dec 2021 09:37:06 +0100
Message-ID: <87sfv2yy19.ffs@tglx>
MIME-Version: 1.0
Cc: Allen Hubbe <allenbh@gmail.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "Raj, Ashok" <ashok.raj@intel.com>,
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

On Thu, Dec 09 2021 at 05:23, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> I don't see anything wrong with that. A subdevice is it's own entity and
>> VFIO can chose the most conveniant representation of it to the guest
>> obviously.
>> 
>> How that is backed on the host does not really matter. You can expose
>> MSI-X to the guest with a INTx backing as well.
>> 
>
> Agree with this point. How the interrupts are represented to the guest
> is orthogonal to how the backend resource is allocated. Physically MSI-X 
> and IMS can be enabled simultaneously on an IDXD device. Once 
> dynamic allocation is allowed for both, either one can be allocated for
> a subdevice (with only difference on supported #subdevices). 
>
> When an interrupt resource is exposed to the guest with the same type 
> (e.g. MSI-on-MSI or IMS-on-IMS), it can be also passed through to the 
> guest as long as a hypercall machinery is in place to get addr/data pair 
> from the host (as you suggested earlier).

As I pointed out in the conclusion of this thread, IMS is only going to
be supported with interrupt remapping in place on both host and guest.

As these devices are requiring a vIOMMU on the guest anyway (PASID, User
IO page tables), the required hypercalls are part of the vIOMMU/IR
implementation. If you look at it from the irqdomain hierarchy view:

                         |- PCI-MSI
  VECTOR -- [v]IOMMU/IR -|- PCI-MSI-X
                         |- PCI-IMS

So host and guest use just the same representation which makes a ton of
sense.

There are two places where this matters:

  1) The activate() callback of the IR domain

  2) The irq_set_affinity() callback of the irqchip associated with the
     IR domain

Both callbacks are allowed to fail and the error code is handed back to
the originating call site.

If you look at the above hierarchy view then MSI/MSI-X/IMS are all
treated in exactly the same way. It all becomes the common case.

No?

Thanks,

        tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
