Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22177C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 18:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE56761BF2;
	Wed,  1 Dec 2021 18:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PGgbwjfUnSE6; Wed,  1 Dec 2021 18:47:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 99B0E60766;
	Wed,  1 Dec 2021 18:47:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75695C000A;
	Wed,  1 Dec 2021 18:47:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7DCCC000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 18:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C889761BEC
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 18:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4fKzTzaFiAwt for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 18:47:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A18A60766
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 18:47:37 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="235258612"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; d="scan'208";a="235258612"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2021 10:47:37 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; d="scan'208";a="602264166"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.64.69])
 ([10.212.64.69])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2021 10:47:35 -0800
Message-ID: <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
Date: Wed, 1 Dec 2021 11:47:35 -0700
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
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <87pmqg88xq.ffs@tglx>
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


On 12/1/2021 11:41 AM, Thomas Gleixner wrote:
> Dave,
>
> please trim your replies.
>
> On Wed, Dec 01 2021 at 09:28, Dave Jiang wrote:
>
>> On 12/1/2021 3:16 AM, Thomas Gleixner wrote:
>>> Jason,
>>>
>>> CC+ IOMMU folks
>>>
>>> On Tue, Nov 30 2021 at 20:17, Jason Gunthorpe wrote:
>>>> On Tue, Nov 30, 2021 at 10:23:16PM +0100, Thomas Gleixner wrote:
>>> Though I fear there is also a use case for MSI-X and IMS tied to the
>>> same device. That network card you are talking about might end up using
>>> MSI-X for a control block and then IMS for the actual network queues
>>> when it is used as physical function device as a whole, but that's
>>> conceptually a different case.
>> Hi Thomas. This is actually the IDXD usage for a mediated device passed
>> to a guest kernel when we plumb the pass through of IMS to the guest
>> rather than doing previous implementation of having a MSIX vector on
>> guest backed by IMS.
> Which makes a lot of sense.
>
>> The control block for the mediated device is emulated and therefore an
>> emulated MSIX vector will be surfaced as vector 0. However the queues
>> will backed by IMS vectors. So we end up needing MSIX and IMS coexist
>> running on the guest kernel for the same device.
> Why? What's wrong with using straight MSI-X for all of them?

The hardware implementation does not have enough MSIX vectors for 
guests. There are only 9 MSIX vectors total (8 for queues) and 2048 IMS 
vectors. So if we are to do MSI-X for all of them, then we need to do 
the IMS backed MSIX scheme rather than passthrough IMS to guests.


>
> Thanks,
>
>          tglx
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
