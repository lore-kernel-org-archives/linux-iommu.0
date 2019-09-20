Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F907C4CEC9
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 14:03:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D37920644
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 14:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D37920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D0782BE7;
	Fri, 20 Sep 2019 14:03:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4F7C7BA0
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 14:03:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DDF1E108
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 14:03:09 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3067C047B68;
	Fri, 20 Sep 2019 14:03:08 +0000 (UTC)
Received: from gondolin (dhcp-192-230.str.redhat.com [10.33.192.230])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 485445C1B5;
	Fri, 20 Sep 2019 14:03:01 +0000 (UTC)
Date: Fri, 20 Sep 2019 16:02:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 3/4] vfio: zpci: defining the VFIO headers
Message-ID: <20190920160258.70631905.cohuck@redhat.com>
In-Reply-To: <0a62aba7-578a-6875-da4d-13e8b145cf9b@linux.ibm.com>
References: <1567815231-17940-1-git-send-email-mjrosato@linux.ibm.com>
	<1567815231-17940-4-git-send-email-mjrosato@linux.ibm.com>
	<20190919172009.71b1c246.cohuck@redhat.com>
	<0a62aba7-578a-6875-da4d-13e8b145cf9b@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 20 Sep 2019 14:03:09 +0000 (UTC)
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

On Thu, 19 Sep 2019 16:55:57 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 9/19/19 11:20 AM, Cornelia Huck wrote:
> > On Fri,  6 Sep 2019 20:13:50 -0400
> > Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >   
> >> From: Pierre Morel <pmorel@linux.ibm.com>
> >>
> >> We define a new device region in vfio.h to be able to
> >> get the ZPCI CLP information by reading this region from
> >> userland.
> >>
> >> We create a new file, vfio_zdev.h to define the structure
> >> of the new region we defined in vfio.h
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> >> ---
> >>  include/uapi/linux/vfio.h      |  1 +
> >>  include/uapi/linux/vfio_zdev.h | 35 +++++++++++++++++++++++++++++++++++
> >>  2 files changed, 36 insertions(+)
> >>  create mode 100644 include/uapi/linux/vfio_zdev.h

> >> diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
> >> new file mode 100644
> >> index 0000000..55e0d6d
> >> --- /dev/null
> >> +++ b/include/uapi/linux/vfio_zdev.h
> >> @@ -0,0 +1,35 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> >> +/*
> >> + * Region definition for ZPCI devices
> >> + *
> >> + * Copyright IBM Corp. 2019
> >> + *
> >> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
> >> + */
> >> +
> >> +#ifndef _VFIO_ZDEV_H_
> >> +#define _VFIO_ZDEV_H_
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +/**
> >> + * struct vfio_region_zpci_info - ZPCI information.  
> > 
> > Hm... probably should also get some more explanation. E.g. is that
> > derived from a hardware structure?
> >   
> 
> The structure itself is not mapped 1:1 to a hardware structure, but it
> does serve as a collection of information that was derived from other
> hardware structures.
> 
> "Used for passing hardware feature information about a zpci device
> between the host and guest" ?

"zPCI specific hardware feature information for a device"?

Are we reasonably sure that this is complete for now? I'm not sure if
expanding this structure would work; adding another should always be
possible, though (if a bit annoying).

> 
> >> + *
> >> + */
> >> +struct vfio_region_zpci_info {
> >> +	__u64 dasm;
> >> +	__u64 start_dma;
> >> +	__u64 end_dma;
> >> +	__u64 msi_addr;
> >> +	__u64 flags;
> >> +	__u16 pchid;
> >> +	__u16 mui;
> >> +	__u16 noi;
> >> +	__u16 maxstbl;
> >> +	__u8 version;
> >> +	__u8 gid;
> >> +#define VFIO_PCI_ZDEV_FLAGS_REFRESH 1
> >> +	__u8 util_str[];
> >> +} __packed;
> >> +
> >> +#endif  
> > 
> >   
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
