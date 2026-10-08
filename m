Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8016471255
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465710; cv=none; b=V5VXpfTPaPONREN4nEy5VDT3WswMLDKhk6SGwBf0ZH3+pn3t41JKPUVFd961Wp9gTKdIzR7nU2OXSwi12EtKvHBne/IBIsAun/+07R7kEFX6EfNCnFRcvgZEyyBH0x7oo0yGKfZZP934b/r/7wpduG0e+UTpGJVdD52lD1+R8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465710; c=relaxed/simple;
	bh=L3pt2PT/hPwrXq7LAfWVr+hh3Nacq9R0SABfPWeBcZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUQZEoMUUYEo/Vo2g6vyUrJl81wajG76xWLT27LamdZ41zkxgPlEST9WUJq6VtC9DFChI5TlzUq/hVfmE1hPOA2cnRU+TRpyr3dMktXmT4tFbIa18PzEdkSvzlII9OUA659bG8MAVX3QJxh9dmqSuXy7ZzHOjR+ks4cvijjvFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Hqci3iIQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Hqci3iIQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C42CE1477;
	Thu,  8 Oct 2026 06:21:44 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76A0F3F763;
	Thu,  8 Oct 2026 06:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791465708; bh=L3pt2PT/hPwrXq7LAfWVr+hh3Nacq9R0SABfPWeBcZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hqci3iIQjlR0pfAzB9UXRgbrh5jmECHpljbCK3qydteadihdACwdJg2UVciO4Y/yy
	 P8+Nhln78zg8nk3oUdWtTFuNcsOkcZf3rZ0RBrtF0pCnEMPQ2IYqCDAj+7JHDvVnzf
	 TnzE6K/QUcbkAE+fQrQH8zCkItpqT1QNlpwvX1Pc=
Message-ID: <7626c1be-305e-478a-a017-548341d25419@arm.com>
Date: Thu, 8 Oct 2026 14:21:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 2/6] iommu/arm-smmu-v3: Allocate streams
 individually
To: Nicolin Chen <nicolinc@nvidia.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Thierry Reding <thierry.reding@kernel.org>, Krishna Reddy
 <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
 <20261006-smmu-shared-sid-v5-2-169a59c671d3@nxp.com>
 <asbTEPMJvm9T00c+@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <asbTEPMJvm9T00c+@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/10/2026 12:17 am, Nicolin Chen wrote:
> On Tue, Oct 06, 2026 at 08:19:08PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Change master->streams from an embedded array of struct arm_smmu_stream
>> to an array of pointers, with each stream individually allocated.
>>
>> Prepare for shared-SID support where multiple masters will point to the
>> same stream object. With embedded structs, sharing requires duplicating
>> stream state and manually keeping fields like ste_installed in sync.
>> With individually allocated streams, a sharing master can simply point to
>> the existing stream.
>>
>> The sort comparator is updated to dereference the pointer indirection.
>>
>> No functional change.
>>
>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>> Link: https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
>> Assisted-by: LLM
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
>> index 6644075c1431e..bc62a3d5a63f9 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
>> @@ -1257,7 +1257,7 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
>>   	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>>   	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
>>   	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
>> -	struct arm_smmu_stream *stream = &master->streams[0];
>> +	struct arm_smmu_stream *stream = master->streams[0];
> 
> Sashiko raised a concern of an out-of-bounds pointer dereference.
> 
> Though it's practically not possible, probably it would be safer
> to move this behind the check:
> 
> 	if (master->num_streams != 1)
> 		return -EOPNOTSUPP;

The IORT path unconditionally adds 1 ID via acpi_iommu_fwspec_init(), so 
num_streams==0 could only potentially happen with DT if a fwspec was 
parsed using #iommu-cells==0, except arm_smmu_device_dt_probe() would 
refuse to probe the entire SMMU if that was anything other than 1, so 
no, this definitely cannot ever be out of bounds.

Thanks,
Robin.
