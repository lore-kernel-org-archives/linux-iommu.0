Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845035A3A6
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265428; cv=none; b=jPGuslr8sxxqAzDTYem3G2tsdomYk/9c5InD17GWLXPFU+U5NH2JCvzFBK6jKo+UIVpR2kZKPbLKmuFlvI1omq+FgkG5mFM9b5rfngB797xzjEWm5Z8/pQfHreohw3aQB9L+9pK73nTlXzMGPsOIMBM+AQwOxTleenvwh4awoeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265428; c=relaxed/simple;
	bh=JfBpj4dEkTYducYw7y5PCtskpRaxhM6t1NTd2/Qgris=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9AFdjXggGXpZpLksDCFOhoREkebXVePgAuODulXKjTMmUb1Ie2V5BxbZxErm+5Xkb6wqT/PdAFL9c1YZWwRsGoUNpNQNUDr4aAkmVfMskG9p725vo5I+PcNjxv2IE9eguQUkQ/ECnf1OAAtHSr7+zM8gQvIOAwdHFING7KccKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWPQ10wSpzHnGd9;
	Thu, 12 Mar 2026 05:43:37 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 896C940584;
	Thu, 12 Mar 2026 05:43:45 +0800 (CST)
Received: from localhost (10.48.148.123) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 21:43:44 +0000
Date: Wed, 11 Mar 2026 21:43:43 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Bjorn Helgaas
	<helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Message-ID: <20260311214343.00004641@huawei.com>
In-Reply-To: <20260309111704.2330479-4-aneesh.kumar@kernel.org>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
	<20260309111704.2330479-4-aneesh.kumar@kernel.org>
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

On Mon,  9 Mar 2026 16:47:04 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Add IOMMU_VDEVICE_TSM_GUEST_REQUEST for issuing TSM guest request/response
> transactions against an iommufd vdevice.
> 
> The ioctl takes a vdevice_id plus request/response user buffers and length
> fields, and forwards the request through tsm_guest_req() to the PCI TSM
> backend. This provides the host-side passthrough path used by CoCo guests
> for TSM device attestation and acceptance flows after the device has been
> bound to TSM.
> 
> Also add the supporting tsm_guest_req() helper and associated TSM core
> interface definitions.
> 
> Based on changes from: Alexey Kardashevskiy <aik@amd.com>

> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Minor stuff inline.

thanks,

Jonathan

> diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
> index 401469110752..6b96d0aef25f 100644
> --- a/drivers/iommu/iommufd/tsm.c
> +++ b/drivers/iommu/iommufd/tsm.c
> @@ -65,3 +65,51 @@ int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
>  	iommufd_put_object(ucmd->ictx, &vdev->obj);
>  	return rc;
>  }
> +
> +/**
> + * iommufd_vdevice_tsm_guest_request_ioctl - Forward guest TSM requests
> + * @ucmd: user command data for IOMMU_VDEVICE_TSM_GUEST_REQUEST
> + *
> + * Resolve @iommu_vdevice_tsm_guest_request::vdevice_id to a vdevice and pass
> + * the request/response buffers to the TSM core.
> + *
> + * Return:
> + *  -errno on error.
> + *  positive residue if response/request bytes were left unconsumed.
> + *    if response buffer is provided, residue indicates the number of bytes
> + *    not used in response buffer
> + *    if there is no response buffer, residue indicates the number of bytes
> + *    not consumed in req buffer
> + *  0 otherwise.
> + */
> +int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	int rc;
> +	struct iommufd_vdevice *vdev;
> +	struct iommu_vdevice_tsm_guest_request *cmd = ucmd->cmd;
> +	struct tsm_guest_req_info info = {
> +		.scope = cmd->scope,
> +		.req   = {
> +			.user = u64_to_user_ptr(cmd->req_uptr),
> +			.is_kernel = false,
> +		},
> +		.req_len = cmd->req_len,
> +		.resp    =  {
> +			.user = u64_to_user_ptr(cmd->resp_uptr),
> +			.is_kernel = false,
> +		},
> +		.resp_len = cmd->resp_len,
> +	};
> +
> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> +					       IOMMUFD_OBJ_VDEVICE),

As in previous, can the object be PTR_ERR()?  Maybe not, but I'd
be surprised if the static analysis tools are convinced.
This might work for now if obj is first element but that's not
elegant or matainable.

> +			    struct iommufd_vdevice, obj);
> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	rc = tsm_guest_req(vdev->idev->dev, &info);

This is otherwise effectively the pattern I'm suggesting for previous patch.

> +
> +	/* No inline response, hence we don't need to copy the response */
> +	iommufd_put_object(ucmd->ictx, &vdev->obj);
> +	return rc;
> +}
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index f0e35fc38776..317fcb53e4bf 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -259,6 +259,20 @@ int tsm_unbind(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(tsm_unbind);
>  
> +ssize_t tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info)
> +{
> +	ssize_t ret;
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	ret = pci_tsm_guest_req(to_pci_dev(dev), info->scope,
> +				info->req, info->req_len,
> +				info->resp, info->resp_len, NULL);
> +	return ret;

return pci_tsm....

Given there are no more patches in this series that much change that.


> +}
> +EXPORT_SYMBOL_GPL(tsm_guest_req);


