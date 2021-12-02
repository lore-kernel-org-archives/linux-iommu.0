Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD17C433FE
	for <iommu@archiver.kernel.org>; Thu,  2 Dec 2021 14:23:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C39C461C18;
	Thu,  2 Dec 2021 14:23:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J9A_EhEg1eoW; Thu,  2 Dec 2021 14:23:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A28EB605CC;
	Thu,  2 Dec 2021 14:23:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 724B2C000A;
	Thu,  2 Dec 2021 14:23:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC01C000A
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 14:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 085DF409AF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 14:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K_13MBHdzTU0 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 14:23:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AF17409AE
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 14:23:47 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 34D2CB82398;
 Thu,  2 Dec 2021 14:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153FEC53FCB;
 Thu,  2 Dec 2021 14:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1638455021;
 bh=oNnu/fYAquguLpIjYchK/Hyo7SQoNQsDNVEvVDkmwwk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d/aD7jGGlhRQjYD/ICQSfDKoktRiprSbgaJ8mVVH9OPYzLELURNXeF3/gTDBLQ/Yy
 6x0JCTvaCeSp9JwZ1MYyDngkR4Hcx89iyNJ+Uo/WH50ZI+87VTZs0h3TOKCOnfzt48
 o4onjuvyaKSqZ5RiWx5EzAY8TzrdsK/qMfaG0rkE=
Date: Thu, 2 Dec 2021 15:23:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <YajW6veanK4GZUkv@kroah.com>
References: <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com> <87y2548byw.ffs@tglx>
 <20211201181406.GM4670@nvidia.com> <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx> <20211202135502.GP4670@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211202135502.GP4670@nvidia.com>
Cc: Allen Hubbe <allenbh@gmail.com>, linux-s390@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, x86@kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-ntb@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
 Logan Gunthorpe <logang@deltatee.com>, Megha Dey <megha.dey@intel.com>
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

On Thu, Dec 02, 2021 at 09:55:02AM -0400, Jason Gunthorpe wrote:
> Further, there is no reason why IMS should be reserved exclusively for
> VFIO! Why shouldn't the cdev be able to use IMS vectors too? It is
> just a feature of the PCI device like MSI. If the queue has a PASID it
> can use IDXD's IMS.

No, sorry, but a cdev is not for anything resembling any real resource
at all.

It is ONLY for the /dev/NODE interface that controls the character
device api to userspace.  The struct device involved in it is ONLY for
that, nothing else.  Any attempt to add things to it will be gleefully
rejected.

The cdev api today (in the kernel) exposes too much mess and there's at
least 4 or 5 different ways to use it.  It's on my long-term TODO list
to fix this up to not even allow abuses like you are considering here,
so please don't do that.

> If we really need a 2nd struct device to turn on IMS then, I'd suggest
> picking the cdev, as it keeps IMS and its allocator inside the IDXD
> PCIe driver and not in the VFIO world.

No!  Again, a cdev is to control the lifespan/lifecycle of the /dev/NODE
only.  Anything other than that is not ok to do at all.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
