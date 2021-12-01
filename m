Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87195C433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 21:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 233358105B;
	Wed,  1 Dec 2021 21:49:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gbl8vN9do8Br; Wed,  1 Dec 2021 21:49:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D686D80FF8;
	Wed,  1 Dec 2021 21:49:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A87E4C000A;
	Wed,  1 Dec 2021 21:49:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42273C000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 21:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A34D60765
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 21:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A2mIaA49EvR0 for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 21:49:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE6BE605BF
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 21:49:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236380391"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; d="scan'208";a="236380391"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2021 13:49:21 -0800
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; d="scan'208";a="602315926"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.64.69])
 ([10.212.64.69])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2021 13:49:19 -0800
Message-ID: <45302c9d-f7a0-5a47-d0be-127d0dea45fb@intel.com>
Date: Wed, 1 Dec 2021 14:49:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Jason Gunthorpe <jgg@nvidia.com>
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
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <878rx480fk.ffs@tglx>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


On 12/1/2021 2:44 PM, Thomas Gleixner wrote:
> On Wed, Dec 01 2021 at 14:21, Dave Jiang wrote:
>> On 12/1/2021 1:25 PM, Thomas Gleixner wrote:
>>>> The hardware implementation does not have enough MSIX vectors for
>>>> guests. There are only 9 MSIX vectors total (8 for queues) and 2048 IMS
>>>> vectors. So if we are to do MSI-X for all of them, then we need to do
>>>> the IMS backed MSIX scheme rather than passthrough IMS to guests.
>>> Confused. Are you talking about passing a full IDXD device to the guest
>>> or about passing a carved out subdevice, aka. queue?
>> I'm talking about carving out a subdevice. I had the impression of you
>> wanting IMS passed through for all variations. But it sounds like for a
>> sub-device, you are ok with the implementation of MSIX backed by IMS?
> I don't see anything wrong with that. A subdevice is it's own entity and
> VFIO can chose the most conveniant representation of it to the guest
> obviously.
>
> How that is backed on the host does not really matter. You can expose
> MSI-X to the guest with a INTx backing as well.
>
> I'm still failing to see the connection between the 9 MSIX vectors and
> the 2048 IMS vectors which I assume that this is the limitation of the
> physical device, right?

I think I was confused with what you were asking and was thinking you 
are saying why can't we just have MSIX on guest backed by the MSIX on 
the physical device and thought there would not be enough vectors to 
service the many guests. I think I understand what your position is now 
with the clarification above.


>
> What needs a subdevice to expose?
>
> Thanks,
>
>          tglx
>
>
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
