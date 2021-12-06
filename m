Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80630C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 15:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20344607DD;
	Mon,  6 Dec 2021 15:06:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k3N7u4vnk8x6; Mon,  6 Dec 2021 15:06:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D54BF60791;
	Mon,  6 Dec 2021 15:06:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85D34C0012;
	Mon,  6 Dec 2021 15:06:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0E60C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFD47403F8
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:06:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="xjheNe0r";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="jx9TJD41"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z48w7EKAGUBa for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 15:06:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47AFF4033F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:06:25 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638803180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5DFKQyDJzCq+mYQ4+RqEzYuEHbWxZbUzi+iE4nicGGk=;
 b=xjheNe0r00mefgEAfeh0NfIOC10o4cEVd0lHlR9g5sO1j/Am2HEeg1glaoSsDM0SpK/rUs
 jNV8s5Thc++G62jsHUxPPkA8QSc9+VxFPCl6lGcvt2hvrRGWXgsEko2DgLKFncSJplt2tX
 jA0W7IBgusGmSyd0A3OlWxVn21edi9lm5YSGfmI9yePehpHHli3nQi3riDWMwe9DA5ijJq
 TBL/d7RKGs2GJoDpug1MCqRUq17Rg3mUC9Kn9UkGWM3GWcFVGusxzdc4qa+IOxm7nwaenL
 zCAk/erK6Pz91WUHf4M584ulEQmKUpREQvllbElpUTC+IkWX/ZsnpLPdYMIUdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638803180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5DFKQyDJzCq+mYQ4+RqEzYuEHbWxZbUzi+iE4nicGGk=;
 b=jx9TJD418UmzxHtiaJhWrn9vJKP8dB7Crk/q/a/U3wDTaJXTw+tAxd8JTUzTh5y8n3ri++
 AEyviiCwJ4Ahj4DA==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211206141922.GZ4670@nvidia.com>
References: <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com> <87v9044fkb.ffs@tglx>
 <20211206141922.GZ4670@nvidia.com>
Date: Mon, 06 Dec 2021 16:06:20 +0100
Message-ID: <87lf0x4vtf.ffs@tglx>
MIME-Version: 1.0
Cc: Allen Hubbe <allenbh@gmail.com>, linux-s390@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, x86@kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
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

Jason,

On Mon, Dec 06 2021 at 10:19, Jason Gunthorpe wrote:
> On Sat, Dec 04, 2021 at 03:20:36PM +0100, Thomas Gleixner wrote:
>> even try to make the irqchip/domain code mangled into the other device
>> code. It should create the irqdomain with the associated chip and that
>> creation process returns a cookie which is passed to the actual device
>> specific code. Allocation then can use that cookie and not the irqdomain
>> pointer itself.
>
> Sounds like your cookie == my msi_table? Maybe we are all agreeing at
> this point then?

I think so. It's going to be something the driver can use as a
reference. Same for the actual interrupt allocated through this domain
reference.

>> So thanks for being patient in educating me here.
>
> I'm happy you got something out of all these words!

Definitely so. That's why we are having these discussions, right?

The shiny irq subsystem is not so shiny when the drivers cannot use
it. OTOH, it's often enough the case that driver folks want to use it
the wrong way just because.

> Yes, it is amazing how many patches this is at already.

Don't worry. You'll get a few more patch bombs in your inbox until IMS
is supported, unless you want to be "unsubscribed".

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
