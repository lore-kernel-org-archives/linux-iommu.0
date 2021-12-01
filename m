Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C4DC433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 18:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 042A082D17;
	Wed,  1 Dec 2021 18:41:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PCxd2MPIxQA4; Wed,  1 Dec 2021 18:41:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E5CDA82A6C;
	Wed,  1 Dec 2021 18:41:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBF4DC000A;
	Wed,  1 Dec 2021 18:41:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3649C000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 18:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C010640200
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 18:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="agHzhYjA";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="TUbiaXym"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u466A0T32nMr for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 18:41:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6FEBB40540
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 18:41:09 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638384066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bhEQ++VjG+PbbDX/TL/y2PNwVGcmNGkMLPfFWSCRFRg=;
 b=agHzhYjACT4x3oSSvJ5fOd6AYVcAl+deHne0yglVQuC/xGnXGYrjYvqtxd/BFYwrP2st5s
 dmum8JsI5po8i518PwfB97/CKWjAcaOMSEJBqJ+kSyo7TwewXq8/1YBRC2q/PaGUT/+hBy
 0W0sf3FPBvlmfDwCW2z88FkHiC7u8nojGT9JCekmtbVS14LIIbazKoX2RR1rJGTsm77J6V
 jzqVWJaXQNFdK/UZTzjbOUiE+WcsDd+mq6GAsIusqJw6BQvcrzFp769DeZ4R+IDsOcDkvc
 b9gn5fETZ1uhLBdFrJjOEFgKdHYcJYu7F+XplHyi4WzDqi1lZCPBUu2OQ+Frtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638384066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bhEQ++VjG+PbbDX/TL/y2PNwVGcmNGkMLPfFWSCRFRg=;
 b=TUbiaXymVThVmwvRi5kHv4ue+jn8XuRm2m9I9z04Kji8zwA82A6uSywSrcuib7TBuNMJjb
 fO7i3twMyhNJC4DA==
To: Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
Date: Wed, 01 Dec 2021 19:41:05 +0100
Message-ID: <87pmqg88xq.ffs@tglx>
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

Dave,

please trim your replies.

On Wed, Dec 01 2021 at 09:28, Dave Jiang wrote:

> On 12/1/2021 3:16 AM, Thomas Gleixner wrote:
>> Jason,
>>
>> CC+ IOMMU folks
>>
>> On Tue, Nov 30 2021 at 20:17, Jason Gunthorpe wrote:
>>> On Tue, Nov 30, 2021 at 10:23:16PM +0100, Thomas Gleixner wrote:
>>
>> Though I fear there is also a use case for MSI-X and IMS tied to the
>> same device. That network card you are talking about might end up using
>> MSI-X for a control block and then IMS for the actual network queues
>> when it is used as physical function device as a whole, but that's
>> conceptually a different case.
>
> Hi Thomas. This is actually the IDXD usage for a mediated device passed 
> to a guest kernel when we plumb the pass through of IMS to the guest 
> rather than doing previous implementation of having a MSIX vector on 
> guest backed by IMS.

Which makes a lot of sense.

> The control block for the mediated device is emulated and therefore an
> emulated MSIX vector will be surfaced as vector 0. However the queues
> will backed by IMS vectors. So we end up needing MSIX and IMS coexist
> running on the guest kernel for the same device.

Why? What's wrong with using straight MSI-X for all of them?

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
