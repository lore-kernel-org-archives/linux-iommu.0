Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF455C49ED7
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 14:26:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02212184C
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 14:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02212184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7E74BC9F;
	Fri, 20 Sep 2019 14:26:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B94FEC9E
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 14:26:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4A359108
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 14:26:15 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7857F8980F5;
	Fri, 20 Sep 2019 14:26:14 +0000 (UTC)
Received: from gondolin (dhcp-192-230.str.redhat.com [10.33.192.230])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B2E2F5D717;
	Fri, 20 Sep 2019 14:26:10 +0000 (UTC)
Date: Fri, 20 Sep 2019 16:26:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] vfio: pci: Using a device region to retrieve
	zPCI information
Message-ID: <20190920162607.16198c92.cohuck@redhat.com>
In-Reply-To: <c5c5c46e-371b-5be0-064a-b89195cdc3f6@linux.ibm.com>
References: <1567815231-17940-1-git-send-email-mjrosato@linux.ibm.com>
	<1567815231-17940-5-git-send-email-mjrosato@linux.ibm.com>
	<20190919172505.2eb075f8.cohuck@redhat.com>
	<c5c5c46e-371b-5be0-064a-b89195cdc3f6@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
	(mx1.redhat.com [10.5.110.67]);
	Fri, 20 Sep 2019 14:26:14 +0000 (UTC)
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, walling@linux.ibm.com,
	alex.williamson@redhat.com, kvm@vger.kernel.org,
	sebott@linux.ibm.com, pmorel@linux.ibm.com,
	heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
	pasic@linux.ibm.com, borntraeger@de.ibm.com,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com,
	gerald.schaefer@de.ibm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, 19 Sep 2019 16:57:10 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 9/19/19 11:25 AM, Cornelia Huck wrote:
> > On Fri,  6 Sep 2019 20:13:51 -0400
> > Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >   
> >> From: Pierre Morel <pmorel@linux.ibm.com>
> >>
> >> We define a new configuration entry for VFIO/PCI, VFIO_PCI_ZDEV
> >>
> >> When the VFIO_PCI_ZDEV feature is configured we initialize
> >> a new device region, VFIO_REGION_SUBTYPE_ZDEV_CLP, to hold
> >> the information from the ZPCI device the use
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> >> ---
> >>  drivers/vfio/pci/Kconfig            |  7 +++
> >>  drivers/vfio/pci/Makefile           |  1 +
> >>  drivers/vfio/pci/vfio_pci.c         |  9 ++++
> >>  drivers/vfio/pci/vfio_pci_private.h | 10 +++++
> >>  drivers/vfio/pci/vfio_pci_zdev.c    | 85 +++++++++++++++++++++++++++++++++++++
> >>  5 files changed, 112 insertions(+)
> >>  create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c
> >>
> >> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> >> index ac3c1dd..d4562a8 100644
> >> --- a/drivers/vfio/pci/Kconfig
> >> +++ b/drivers/vfio/pci/Kconfig
> >> @@ -45,3 +45,10 @@ config VFIO_PCI_NVLINK2
> >>  	depends on VFIO_PCI && PPC_POWERNV
> >>  	help
> >>  	  VFIO PCI support for P9 Witherspoon machine with NVIDIA V100 GPUs
> >> +
> >> +config VFIO_PCI_ZDEV
> >> +	bool "VFIO PCI Generic for ZPCI devices"
> >> +	depends on VFIO_PCI && S390
> >> +	default y
> >> +	help
> >> +	  VFIO PCI support for S390 Z-PCI devices  
> >   
> >>From that description, I'd have no idea whether I'd want that or not.  
> > Is there any downside to enabling it?
> >   
> 
> :) Not really, you're just getting information from the hardware vs
> using hard-coded defaults.  The only reason I could think of to turn it
> off would be if you wanted/needed to restore this hard-coded behavior.

I'm not really sure whether that's worth adding a Kconfig switch for.
Won't older versions simply ignore the new region anyway?

Also, I don't think we have any migration compatibility issues, as
vfio-pci devices are not (yet) migrateable anyway.

> 
> bool "VFIO PCI support for generic ZPCI devices" ?

"Support zPCI-specific configuration for VFIO PCI" ?

> 
> "Support for sharing ZPCI hardware device information between the host
> and guests." ?

"Enabling this options exposes a region containing hardware
configuration for zPCI devices. This enables userspace (e.g. QEMU) to
supply proper configuration values instead of hard-coded defaults for
zPCI devices passed through via VFIO on s390.

Say Y here."

?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
