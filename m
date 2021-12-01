Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573E1C433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 20:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 017CD83133;
	Wed,  1 Dec 2021 20:26:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id id-KLCYI0ayt; Wed,  1 Dec 2021 20:25:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E78F9825B1;
	Wed,  1 Dec 2021 20:25:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9A38C000A;
	Wed,  1 Dec 2021 20:25:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A963C000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 20:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23C2E40226
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 20:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="gHLqUfYb";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="N3a4nzZm"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S9JBzbHAe-yi for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 20:25:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 52A1640004
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 20:25:56 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638390353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rILGDyAzrwQH4d0Fd/HHcQkOPeMa8khVt+2HdznW01Q=;
 b=gHLqUfYbZnA4M1RpNzxIMRcbkgK5IMmNM8uQqmKzOfgp4DBmqvlXrIHX/uMUjRoGgklvBs
 Ccc1Q+tKJH5hVLgasozL7uM/VkBxUtsvlhuoTbhleUwQEmgnq8gUijVpoorS+asFBo0txm
 yaQjBnTeOceLiedB1hF1agP53a24ebpiW3EftC34gpyb3ZzepzpNJ98kUWWrcoYZfiLn0x
 lKv0D0U5hyiOoyj6HX5i0JhsuPyjNWxIoU6XZjR+M0I00vgUGzz4K3cq6GBphvylaALi8e
 Q5WAV24XNr/XOLbR+Mr2UD42PUbzF4/vNz1XMr17gAy34SAM1sTRYv6x5BoQtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638390353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rILGDyAzrwQH4d0Fd/HHcQkOPeMa8khVt+2HdznW01Q=;
 b=N3a4nzZm8n5f6SdviSlZVeASD7pY4RVO8YgJHgB0BA+d0FshDK2md2qto/rRPHoVVkqQQI
 bL4r3PvuYgYKnwCA==
To: Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
Date: Wed, 01 Dec 2021 21:25:53 +0100
Message-ID: <87k0go8432.ffs@tglx>
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

On Wed, Dec 01 2021 at 11:47, Dave Jiang wrote:
> On 12/1/2021 11:41 AM, Thomas Gleixner wrote:
>>> Hi Thomas. This is actually the IDXD usage for a mediated device passed
>>> to a guest kernel when we plumb the pass through of IMS to the guest
>>> rather than doing previous implementation of having a MSIX vector on
>>> guest backed by IMS.
>> Which makes a lot of sense.
>>
>>> The control block for the mediated device is emulated and therefore an
>>> emulated MSIX vector will be surfaced as vector 0. However the queues
>>> will backed by IMS vectors. So we end up needing MSIX and IMS coexist
>>> running on the guest kernel for the same device.
>> Why? What's wrong with using straight MSI-X for all of them?
>
> The hardware implementation does not have enough MSIX vectors for 
> guests. There are only 9 MSIX vectors total (8 for queues) and 2048 IMS 
> vectors. So if we are to do MSI-X for all of them, then we need to do 
> the IMS backed MSIX scheme rather than passthrough IMS to guests.

Confused. Are you talking about passing a full IDXD device to the guest
or about passing a carved out subdevice, aka. queue?

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
