Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7A353A88;
	Fri,  2 Oct 2026 05:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790918776; cv=none; b=nuQ64d/3MEdqhMkMgBtfsEQGppshKisZLpqECGDzdAtEydhSb41EcQIM/m5kMver69s9BDNkM8wMFz7dtGPGJMWdvqUldbqUvSuq7mCRvD1+ndbOSX4MPOPkp92cz2b1r2ctQQld8kxd9tEbODGWaWevly6Pd0sOc2OPkRsNe6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790918776; c=relaxed/simple;
	bh=YlkxD2FRDsRnwLsQylg3tobY+DHUi6fR7Udg+UrkSWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f2u4xpQKYaXCyMIcv1wZJS9GbiGtxaNwoVPvQR1Od3zcorZ5gXid2tlzAZkU2c7i7Jw4QIPgyl/n/ZK8R9sVAVg7zwMHoxxwvCzd02FRbAmpxQPx0/760CkP1EtNm143jdVr9AVHHSjj1cfap/ik43iaU+jWsjLOKFMeuE9COJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifqz3ID8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifqz3ID8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A141F000FF;
	Fri,  2 Oct 2026 05:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790918774;
	bh=wqEd61paSK0lZtnAaPVyFzjg1xp1PL90xru5qjSKVT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ifqz3ID85TTlv0qXCW7sIt7jdz7DR/CScCpnrAmcjwX13qJNlxbWgzHpeJWWrngKA
	 JNYy0MAHlJe1SXd2XF0edqzrYA95/32tZr5QzZDxXnvavvnaR+UID1DGVcjrBRxrQb
	 omfK6YopdOKRs8Be50Blq2fclL3UbRbxaJV4t+WGET524lhRC6tWqjX/hyLILqkLfx
	 whu0EBDNR00BoiBzQx1bbMG0RCRxzG9BHCE4wFf4gJ00uVbJI7ze2bO1aMDpcAg566
	 Q2qkDEl+T8d4Qe3agUauhpAIi0mEjkzlmcCjQYlN7juR11I8iEDUXqlE3DGJfgGfhU
	 MZiF6aJW1WT5g==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Vasant Hegde <vasant.hegde@amd.com>, linux-coco@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 04/11] iommufd/viommu: Keep a reference to the
 KVM file
In-Reply-To: <76d51545-47d3-4ef7-bb10-551c898c0968@amd.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-5-aneesh.kumar@kernel.org>
 <76d51545-47d3-4ef7-bb10-551c898c0968@amd.com>
Date: Fri, 02 Oct 2026 10:56:03 +0530
Message-ID: <yq5ay0cgu104.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Vasant Hegde <vasant.hegde@amd.com> writes:

> On 9/17/2026 7:31 PM, Aneesh Kumar K.V (Arm) wrote:
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> 
>> The TSM vDevice operations need access to the KVM associated with the
>> device's vIOMMU. Save the device's KVM file in the iommufd_viommu when the
>> vIOMMU is allocated, and take a file reference so it remains valid for the
>> lifetime of the vIOMMU.
>> 
>> Release the reference when the vIOMMU is destroyed.
>> 
>> Based on an original patch by Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> 
>> [nicolinc: hold kvm's users_count]
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> [aneesh.kumar: Switch to use kvm_file]
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  drivers/iommu/iommufd/viommu.c | 5 +++++
>>  include/linux/iommufd.h        | 1 +
>>  2 files changed, 6 insertions(+)
>> 
>> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
>> index 4081deda9b33..bf5d58d55939 100644
>> --- a/drivers/iommu/iommufd/viommu.c
>> +++ b/drivers/iommu/iommufd/viommu.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
>>   */
>> +#include <linux/file.h>
>>  #include "iommufd_private.h"
>>  
>>  void iommufd_viommu_destroy(struct iommufd_object *obj)
>> @@ -11,6 +12,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
>>  	if (viommu->ops && viommu->ops->destroy)
>>  		viommu->ops->destroy(viommu);
>>  	refcount_dec(&viommu->hwpt->common.obj.users);
>> +	if (viommu->kvm_file)
>> +		fput(viommu->kvm_file);
>>  	xa_destroy(&viommu->vdevs);
>>  }
>>  
>> @@ -76,6 +79,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>>  	}
>>  
>>  	xa_init(&viommu->vdevs);
>> +	if (idev->kvm_file)
>> +		viommu->kvm_file = get_file(idev->kvm_file);
>
> Nice! This is needed for AMD IOMMU as well!
>
> Minor nit. You have to add fput() in error path.

The error path is handled by iommufd_viommu_destroy().
iommufd_fops_ioctl() calls either destroy or finalize, as required.

-aneesh
