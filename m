Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAC32E13B;
	Mon, 16 Mar 2026 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650716; cv=none; b=uIpNlCjiBYyxEh9Qb92N6aAIZackJ/IEV2hl/JUunazwG0LgH5OruHrmaNB9r0vKfcK//EQq+5RrGb3wLqarhik6JjOEVnLBAWZwhVMHzV9WPaU0Pzksu7uV216jEopMeRwUaqWXS5ZWWc9Zsa5IFkLDOpRE2oAxT6SjSlzAn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650716; c=relaxed/simple;
	bh=J3yZAEV7Vvin2RGvd9ZYHV0Kmsob2iw721LP9Geamok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LvyaB6t9SezI5Zom3bNQ3oNI7Hutdr2J9HNsBflUrrSpmz73lGZr5SSX6uPKlSPaIQosC4vTWS6nBqujguGYODCZ1SS8UVyavTI7A8u3lZN4c6eOL/6is+rTIaJUzBigIzAzkn1fE2nCRefFHJBKR5ytwJFnI6Q6PwzcSBGZ1Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/ZnG9uS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/ZnG9uS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A5BC19421;
	Mon, 16 Mar 2026 08:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773650716;
	bh=J3yZAEV7Vvin2RGvd9ZYHV0Kmsob2iw721LP9Geamok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M/ZnG9uSWZL0KGhRVodzbqi6sbwcNFAwPotrGMq2aFLsJ+ScxCVSZ1Q15dcTOmJeN
	 X/Cn1iCmLTLHiR7tZD8kXz42b8Q6wAhpj9xP6oWZSoGhMsY4CZiy7JhtQ749v7GQtM
	 nznrsk2G/BQPCTxRR1ax4PAlWjBcumEBVJ2l781g0MTEK2KQfxPDW4AllMvtQ1+okt
	 GaZJZRHtksoEozhpcz7IKKVbFNSazmZhfaAt/AM3y0chLRV8ku/vZ4jF8PuQu0EXP8
	 5p/aza/BaKpVCL0+00N0WAdm74+rVKMSyCRljZEsBD8rm7naJu/BAmxMAQU9JXcU1J
	 cA4wwlLClJhGA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Williams,
	Dan J" <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: RE: [PATCH v2 2/3] iommufd/tsm: add vdevice TSM bind/unbind ioctl
In-Reply-To: <BN9PR11MB5276585EAEC4C80D4D45DD8A8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-3-aneesh.kumar@kernel.org>
 <BN9PR11MB5276585EAEC4C80D4D45DD8A8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
Date: Mon, 16 Mar 2026 14:15:06 +0530
Message-ID: <yq5ay0js6u3x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Tian, Kevin" <kevin.tian@intel.com> writes:

>> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> Sent: Monday, March 9, 2026 7:17 PM
>> 
>> Introduce IOMMU_VDEVICE_TSM_OP to allow userspace to issue TSM
>> bind/unbind
>> operations for an iommufd vdevice.
>
> How many ops are planned? If just a few I'd prefer to openly defining
> it:
>
> 	IOMMU_VDEVICE_ALLOC,
> 	IOMMU_VDEVICE_TSM_BIND,
> 	IOMMU_VDEVICE_TSM_UNBIND,
>
> just like how we did for IOAS.
>

Right now only TSM_BIND and TSM_UNBIND. This was done based on earlier
review feedback.

https://lore.kernel.org/all/20250530181842.GU233377@nvidia.com/

>
>> @@ -432,6 +432,7 @@ union ucmd_buffer {
>>  	struct iommu_veventq_alloc veventq;
>>  	struct iommu_vfio_ioas vfio_ioas;
>>  	struct iommu_viommu_alloc viommu;
>> +	struct iommu_vdevice_tsm_op tsm_op;
>
> please follow the alphabetical order
>
>> @@ -493,6 +494,8 @@ static const struct iommufd_ioctl_op
>> iommufd_ioctl_ops[] = {
>>  		 __reserved),
>>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>>  		 struct iommu_viommu_alloc, out_viommu_id),
>> +	IOCTL_OP(IOMMU_VDEVICE_TSM_OP,
>> iommufd_vdevice_tsm_op_ioctl,
>> +		 struct iommu_vdevice_tsm_op, vdevice_id),
>
> ditto
>
>> +int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
>> +{
>> +	int rc;
>> +	struct kvm *kvm;
>> +	struct iommufd_vdevice *vdev;
>> +	struct iommu_vdevice_tsm_op *cmd = ucmd->cmd;
>> +
>> +	if (cmd->flags)
>> +		return -EOPNOTSUPP;
>> +
>> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd-
>> >vdevice_id,
>> +					       IOMMUFD_OBJ_VDEVICE),
>> +			    struct iommufd_vdevice, obj);
>> +	if (IS_ERR(vdev))
>> +		return PTR_ERR(vdev);
>> +
>> +	if (!vdev->viommu->kvm_filp) {
>> +		rc = -ENODEV;
>> +		goto out_put_vdev;
>> +	}
>> +
>> +	kvm = vdev->viommu->kvm_filp->private_data;
>> +	if (!kvm) {
>> +		rc = -ENODEV;
>> +		goto out_put_vdev;
>> +	}
>
> 	if (!vdev->viommu->kvm_filp ||
> 	    !vdev->viommu->kvm_filp->private_data) {
> 		rc = -ENODEV;
> 		goto out_put_vdev;
> 	}
>
> 	kvm = vdev->viommu->kvm_filp->private_data;

-aneesh
