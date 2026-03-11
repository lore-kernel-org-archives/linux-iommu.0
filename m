Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0D2FD68B
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264964; cv=none; b=jIayxeAUEPu19jEZF7eDWPs/au3Mgog5+YxTQqiUT9p5NpDlBUCF/+718rdt/ze0TkO9EN/2rjaHh640nBqUInhbrV9CZ9+B2ejST6yUy/HRrvaqId/KTSBn/pxgguDMO/oERiUh0c1iCnHFoJmQXIq12rwSs04uBlFIkR2iwTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264964; c=relaxed/simple;
	bh=KGKIobWW4qHnK1GBXmBm9IZiT2+mrhufqvLwLka5pFw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSlFbt9zbm5+JsrywcFso8s/TWz607Z14g0Tl3DsBHfYr7o0LsmZ2Rp0I9Pglc+AQkEV6V4O26s9rAUor0uYCVnREuXzPCDEY3Lnl3VasUVI8BPVy/HvklqfB1ql5f7H6JqGuanK8RkxGgY5ujCiSk+eRU3LBWU0Mu6KzzU4b4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWPF11xPNzHnGcl;
	Thu, 12 Mar 2026 05:35:49 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A79A540569;
	Thu, 12 Mar 2026 05:35:57 +0800 (CST)
Received: from localhost (10.48.148.123) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 21:35:56 +0000
Date: Wed, 11 Mar 2026 21:35:55 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Bjorn Helgaas
	<helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 2/3] iommufd/tsm: add vdevice TSM bind/unbind ioctl
Message-ID: <20260311213555.00001064@huawei.com>
In-Reply-To: <20260309111704.2330479-3-aneesh.kumar@kernel.org>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
	<20260309111704.2330479-3-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon,  9 Mar 2026 16:47:03 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Introduce IOMMU_VDEVICE_TSM_OP to allow userspace to issue TSM bind/unbind
> operations for an iommufd vdevice.
> 
> The new ioctl:
> - looks up the vdevice object from vdevice_id
> - resolves the associated KVM VM from the vIOMMU KVM file reference
> - dispatches bind/unbind via tsm_bind()/tsm_unbind()
> 
> Also add common TSM helpers in tsm-core and wire vdevice teardown to unbind
> the device from TSM state.
> 
> This provides iommufd plumbing to bind a TDI to a confidential guest through
> the TSM layer.

> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Hi Aneesh,

Some superficial code flow suggestions.  I've not gotten
my head around the broader picture yet, so may well come back with
more comments later.

Thanks,
Jonathan

> ---
>  drivers/iommu/iommufd/Makefile          |  2 +
>  drivers/iommu/iommufd/iommufd_private.h |  8 +++
>  drivers/iommu/iommufd/main.c            |  3 ++
>  drivers/iommu/iommufd/tsm.c             | 67 +++++++++++++++++++++++++
>  drivers/iommu/iommufd/viommu.c          |  3 ++
>  drivers/virt/coco/tsm-core.c            | 19 +++++++
>  include/linux/tsm.h                     | 18 +++++++
>  include/uapi/linux/iommufd.h            | 18 +++++++
>  8 files changed, 138 insertions(+)
>  create mode 100644 drivers/iommu/iommufd/tsm.c
> 
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 71d692c9a8f4..431089089ee9 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -10,6 +10,8 @@ iommufd-y := \
>  	vfio_compat.o \
>  	viommu.o
>  
> +iommufd-$(CONFIG_TSM) += tsm.o
> +
Probably no blank line here. Style choices in these are a bit random
though so this is kind of a taste thing.

>  iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>  
>  obj-$(CONFIG_IOMMUFD) += iommufd.o

> diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
> new file mode 100644
> index 000000000000..401469110752
> --- /dev/null
> +++ b/drivers/iommu/iommufd/tsm.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 ARM Ltd.
> + */
> +
> +#include "iommufd_private.h"
> +#include <linux/tsm.h>
> +
> +/**
> + * iommufd_vdevice_tsm_op_ioctl - Handle vdevice TSM operations
> + * @ucmd: user command data for IOMMU_VDEVICE_TSM_OP
> + *
> + * Currently only supports TSM bind/unbind operations
> + * Resolve @iommu_vdevice_tsm_op::vdevice_id to a vdevice and dispatch the
> + * requested bind/unbind operation through the TSM core.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	int rc;
> +	struct kvm *kvm;
> +	struct iommufd_vdevice *vdev;
> +	struct iommu_vdevice_tsm_op *cmd = ucmd->cmd;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> +					       IOMMUFD_OBJ_VDEVICE),
> +			    struct iommufd_vdevice, obj);

I'd be tempted to do something with a helper function to simplify flow.

	obj = iommufd_get_object();...

	if (IS_ERR(obj) //I think it can be?
		return PTR_ERR(obj);

	rc = iommufd_vdevice_do_tsm_op_ioctl(obj, ...) //name could be improved
	iommufd_put_object(ucmd->ictx, &vdev->obj);

	return rc;

Then the helper function can do direct returns on errors given the
iommfd_object is managed in outer function.

> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	if (!vdev->viommu->kvm_filp) {
> +		rc = -ENODEV;
> +		goto out_put_vdev;
> +	}
> +
> +	kvm = vdev->viommu->kvm_filp->private_data;
> +	if (!kvm) {
> +		rc = -ENODEV;
> +		goto out_put_vdev;
> +	}
> +
> +	/* tsm layer will take care of parallel calls to tsm_bind/unbind */
> +	switch (cmd->op) {
> +	case IOMMU_VDEVICE_TSM_BIND:
> +		rc = tsm_bind(vdev->idev->dev, kvm, vdev->virt_id);
> +		break;
> +	case IOMMU_VDEVICE_TSM_UNBIND:
> +		rc = tsm_unbind(vdev->idev->dev);
> +		break;
> +	default:
> +		rc = -EINVAL;
> +		goto out_put_vdev;
> +	}
> +
> +	if (rc)
> +		goto out_put_vdev;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +
> +out_put_vdev:
> +	iommufd_put_object(ucmd->ictx, &vdev->obj);
> +	return rc;
> +}

> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 7f72a154b6b2..9f2a7868021a 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -124,6 +124,24 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
>  void tsm_unregister(struct tsm_dev *tsm_dev);
>  struct tsm_dev *find_tsm_dev(int id);
>  struct pci_ide;
> +struct kvm;

Why up here? struct pci_ide is here for the next two calls, so no need
to group with that.

>  int tsm_ide_stream_register(struct pci_ide *ide);
>  void tsm_ide_stream_unregister(struct pci_ide *ide);

Feels like the forwards def belongs here.

> +#ifdef CONFIG_TSM
> +int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id);
> +int tsm_unbind(struct device *dev);
> +
White space is a bit inconsistent. I don't mind seeing some
here, but if so, add some around the ifdef above.

> +#else
> +
> +static inline int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int tsm_unbind(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif /* __TSM_H */

