Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332EAC433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 21:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C071E4015F;
	Wed,  1 Dec 2021 21:44:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YJtdq89f-lpZ; Wed,  1 Dec 2021 21:44:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5949C40004;
	Wed,  1 Dec 2021 21:44:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11D22C000A;
	Wed,  1 Dec 2021 21:44:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68D5BC000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 21:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A46960765
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 21:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="c9AgdUMR";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="D4Dq7GfJ"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7GMSdIW0dNb0 for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 21:44:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8456760652
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 21:44:51 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638395087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krYS43JDn9SwhYUn0VmJxoA+3m1JcN43I7KNWxc/6KA=;
 b=c9AgdUMR9JqdGWNNLAqKHjwrtKay6G/qiAgJJpfZAqmtIJw7eARlb5WF7+CLZJaQq1xJ/+
 Z2HM8EqZBlrkQlDlGKyjXi2ksTnl3P8i/RducOe/dpLAMVuKYLaLmSALzehEdDRzA6HiCJ
 up8P8Kq3RcBw3RNP7fBVHhiMhEK2uV3budj5JXwUlh60N0UnlgFolzRA2umjl/2S2VpwE+
 VS0Tt7PHV5QrcXA/NTOvcOG+XsrkcWQUoztnFh321tz9F/UoRY0JDFSWiIEhUMy8s5STdV
 ZNIzQO0+q77TkeY/G4dpVnJUuG8NfbAnwk2txV36hi6ypUJQ8R06nTeI+v9viA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638395087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krYS43JDn9SwhYUn0VmJxoA+3m1JcN43I7KNWxc/6KA=;
 b=D4Dq7GfJ0fntpaB0Dk72G+5o2ZtwQeCy8JqvMF7EWdfTcmCwWnMGLRIxNsDMBocjAoz7P5
 +59jRcriNgFyXnBQ==
To: Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com> <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
Date: Wed, 01 Dec 2021 22:44:47 +0100
Message-ID: <878rx480fk.ffs@tglx>
MIME-Version: 1.0
Cc: Allen Hubbe <allenbh@gmail.com>, linux-s390@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, x86@kernel.org,
 Ashok Raj <ashok.raj@intel.com>,
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

On Wed, Dec 01 2021 at 14:21, Dave Jiang wrote:
> On 12/1/2021 1:25 PM, Thomas Gleixner wrote:
>>> The hardware implementation does not have enough MSIX vectors for
>>> guests. There are only 9 MSIX vectors total (8 for queues) and 2048 IMS
>>> vectors. So if we are to do MSI-X for all of them, then we need to do
>>> the IMS backed MSIX scheme rather than passthrough IMS to guests.
>> Confused. Are you talking about passing a full IDXD device to the guest
>> or about passing a carved out subdevice, aka. queue?
>
> I'm talking about carving out a subdevice. I had the impression of you 
> wanting IMS passed through for all variations. But it sounds like for a 
> sub-device, you are ok with the implementation of MSIX backed by IMS?

I don't see anything wrong with that. A subdevice is it's own entity and
VFIO can chose the most conveniant representation of it to the guest
obviously.

How that is backed on the host does not really matter. You can expose
MSI-X to the guest with a INTx backing as well.

I'm still failing to see the connection between the 9 MSIX vectors and
the 2048 IMS vectors which I assume that this is the limitation of the
physical device, right?

What needs a subdevice to expose?

Thanks,

        tglx



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
