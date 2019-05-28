Return-Path: <SRS0=b5RZ=T4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8D8C04AB6
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 21:43:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 053F4208CB
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 21:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053F4208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B6D18236B;
	Tue, 28 May 2019 21:43:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B9C0B230D
	for <iommu@lists.linux-foundation.org>;
	Tue, 28 May 2019 21:41:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0526D13A
	for <iommu@lists.linux-foundation.org>;
	Tue, 28 May 2019 21:41:55 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C35563162;
	Tue, 28 May 2019 21:41:55 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2E66860C4C;
	Tue, 28 May 2019 21:41:54 +0000 (UTC)
Date: Tue, 28 May 2019 15:41:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] vfio: pci: Using a device region to retrieve
	zPCI information
Message-ID: <20190528154153.590f9ad9@x1.home>
In-Reply-To: <1558614326-24711-4-git-send-email-pmorel@linux.ibm.com>
References: <1558614326-24711-1-git-send-email-pmorel@linux.ibm.com>
	<1558614326-24711-4-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 28 May 2019 21:41:55 +0000 (UTC)
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org,
	heiko.carstens@de.ibm.com, sebott@linux.vnet.ibm.com,
	walling@linux.ibm.com, linux-kernel@vger.kernel.org,
	borntraeger@de.ibm.com, iommu@lists.linux-foundation.org,
	schwidefsky@de.ibm.com, robin.murphy@arm.com, gerald.schaefer@de.ibm.com
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

On Thu, 23 May 2019 14:25:26 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We define a new configuration entry for VFIO/PCI, VFIO_PCI_ZDEV
> 
> When the VFIO_PCI_ZDEV feature is configured we initialize
> a new device region, VFIO_REGION_SUBTYPE_ZDEV_CLP, to hold
> the information from the ZPCI device the userland needs to
> give to a guest driving the zPCI function.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/vfio/pci/Kconfig            |  7 ++++
>  drivers/vfio/pci/Makefile           |  1 +
>  drivers/vfio/pci/vfio_pci.c         |  9 ++++
>  drivers/vfio/pci/vfio_pci_private.h | 10 +++++
>  drivers/vfio/pci/vfio_pci_zdev.c    | 83 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 110 insertions(+)
>  create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index d0f8e4f..9c1181c 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -44,3 +44,10 @@ config VFIO_PCI_NVLINK2
>  	depends on VFIO_PCI && PPC_POWERNV
>  	help
>  	  VFIO PCI support for P9 Witherspoon machine with NVIDIA V100 GPUs
> +
> +config VFIO_PCI_ZDEV
> +	tristate "VFIO PCI Generic for ZPCI devices"

Shouldn't this be 'bool'?

> +	depends on VFIO_PCI && S390
> +	default y
> +	help
> +	  VFIO PCI support for S390 Z-PCI devices
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 9662c06..fd53819 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -2,5 +2,6 @@
>  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
>  vfio-pci-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
> +vfio-pci-$(CONFIG_VFIO_PCI_ZDEV) += vfio_pci_zdev.o
>  
>  obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 3fa20e9..b6087d6 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -362,6 +362,15 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  		}
>  	}
>  
> +	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV)) {
> +		ret = vfio_pci_zdev_init(vdev);
> +		if (ret) {
> +			dev_warn(&vdev->pdev->dev,
> +				 "Failed to setup ZDEV regions\n");
> +			goto disable_exit;
> +		}
> +	}
> +
>  	vfio_pci_probe_mmaps(vdev);
>  
>  	return 0;
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 1812cf2..db73cdf 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -189,4 +189,14 @@ static inline int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
>  	return -ENODEV;
>  }
>  #endif
> +
> +#ifdef(IS_ENABLED_VFIO_PCI_ZDEV)

I thought this might be some clever new macro, but is it just a typo?
Seems it should just be

#ifdef CONFIG_VFIO_PCI_ZDEV

> +extern int vfio_pci_zdev_init(struct vfio_pci_device *vdev);
> +#else
> +static inline int vfio_pci_zdev_init(struct vfio_pci_device *vdev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  #endif /* VFIO_PCI_PRIVATE_H */
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> new file mode 100644
> index 0000000..230a4e4
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VFIO ZPCI devices support
> + *
> + * Copyright (C) IBM Corp. 2019.  All rights reserved.
> + *	Author: Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/io.h>
> +#include <linux/pci.h>
> +#include <linux/uaccess.h>
> +#include <linux/vfio.h>
> +#include <linux/vfio_zdev.h>
> +
> +#include "vfio_pci_private.h"
> +
> +static size_t vfio_pci_zdev_rw(struct vfio_pci_device *vdev,
> +			       char __user *buf, size_t count, loff_t *ppos,
> +			       bool iswrite)
> +{
> +	struct vfio_region_zpci_info *region;
> +	struct zpci_dev *zdev;
> +	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> +
> +	if (!vdev->pdev->bus)
> +		return -ENODEV;
> +
> +	zdev = vdev->pdev->bus->sysdata;
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	if ((*ppos & VFIO_PCI_OFFSET_MASK) || (count != sizeof(*region)))
> +		return -EINVAL;

Why?  This sort of restriction would need to be documented in the ABI.

> +
> +	region = vdev->region[index - VFIO_PCI_NUM_REGIONS].data;
> +	region->dasm = zdev->dma_mask;
> +	region->start_dma = zdev->start_dma;
> +	region->end_dma = zdev->end_dma;
> +	region->msi_addr = zdev->msi_addr;
> +	region->flags = VFIO_PCI_ZDEV_FLAGS_REFRESH;
> +	region->gid = zdev->pfgid;
> +	region->mui = zdev->fmb_update;
> +	region->noi = zdev->max_msi;
> +	memcpy(region->util_str, zdev->util_str, CLP_UTIL_STR_LEN);

Does anything here change?  Why not do this in the init function?

> +	if (copy_to_user(buf, region, count))
> +		return -EFAULT;

It's really not that difficult to make this support arbitrary reads.

> +
> +	return count;
> +}
> +
> +static void vfio_pci_zdev_release(struct vfio_pci_device *vdev,
> +				  struct vfio_pci_region *region)
> +{
> +	kfree(region->data);
> +}
> +
> +static const struct vfio_pci_regops vfio_pci_zdev_regops = {
> +	.rw		= vfio_pci_zdev_rw,
> +	.release	= vfio_pci_zdev_release,
> +};
> +
> +int vfio_pci_zdev_init(struct vfio_pci_device *vdev)
> +{
> +	struct vfio_region_zpci_info *region;
> +	int ret;
> +
> +	region = kmalloc(sizeof(*region), GFP_KERNEL);
> +	if (!region)
> +		return -ENOMEM;
> +
> +	ret = vfio_pci_register_dev_region(vdev,
> +		PCI_VENDOR_ID_IBM | VFIO_REGION_TYPE_PCI_VENDOR_TYPE,

The uapi should specify 0x1014 as the vendor ID to eliminate any
confusion.

> +		VFIO_REGION_SUBTYPE_ZDEV_CLP,
> +		&vfio_pci_zdev_regops, sizeof(*region),

'sizeof(*region) + CLP_UTIL_STR_LEN' if suggestion in previous patch is
used.

> +		VFIO_REGION_INFO_FLAG_READ, region);

This FLAG_READ only tells the user what is supported, it's up to your
.rw callback to reject iswrite.

> +
> +	return ret;
> +}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
