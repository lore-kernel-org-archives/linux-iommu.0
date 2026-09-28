Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC831F12F8;
	Mon, 28 Sep 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609957; cv=none; b=p4gzKxgMDo0Eli43/PfXPuEt4W3IHAVSd1vCnJ1664AWxRK8UDiakEsYP0sUhifuXUsoqQ0vZFkGM8VLj7zYhH5PY+m/9Fx8StzIpCOlQiM9tRGmgtcgSbT7HSGvJSOJ/NotCXcFsLNA9ukzVb4uVqqmZmf6goJZuAulYG+rlAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609957; c=relaxed/simple;
	bh=T4rEflIDWfaQfbsHhUu9H9wpN6bQ0eGXh0mkZKTX8zc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KmWUeb3kmne0KRoiCxXnXkXFF9f2qupHAyrWpbkCNPgGrsvORM72/Q2Z0suX3K8daEe6X2skJbMH0wQLbAtcXEORr+3a6sWyv52THV8Bqoqeqw7xSRvp58qEqPzaZFjUsmYmrzer2j5a5fR7hbsxbaDdGVjaAEJQBNwv6c46Lts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfyQHDVx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfyQHDVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391841F00893;
	Mon, 28 Sep 2026 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790609956;
	bh=NzWh6TDC+XXJKSXvMFMQHGa1MigG1SoSGoWh2Px4kr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LfyQHDVxeVyncOPX2JC6edrNJEYMurzdqfkRFC7TlDigy2B3j7c6UTmmiv89B3FS8
	 tgrSitsHXL4kkPdDxOcHolHey9C7g60+RL5dTlDSdqMT8qhljCys9SXX1i2O5HscoT
	 yQtJLbBOyFPSdXLQmkolaIPkNUSl+OUrs4XQdjCIai0iEZK9AOTJMC5F25E8Tddzv6
	 2t9eSHabcTLuPYvUndrIZiudyI+/cVuIdHh6l/1T2agpydr0iq7U9hvKlNoBU47D+I
	 S+CANggpDQCr6BL+zXiSWzd5X0Ro7ZPWuYEM+nXP4tG5TSwyUZsorGs+YiMMq0FEf5
	 cAwQjfOFkv2YA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Subject: Re: [RFC PATCH v6 05/11] iommu: Add a helper to validate a vIOMMU
 parent
In-Reply-To: <20260928121147.GP9354@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-6-aneesh.kumar@kernel.org>
 <179027891416.104879.10365675178574704349.b4-review@b4>
 <yq5ald8pkhj7.fsf@kernel.org> <20260925122305.GG9354@nvidia.com>
 <yq5a5wzpr7b9.fsf@kernel.org> <20260928121147.GP9354@nvidia.com>
Date: Mon, 28 Sep 2026 21:09:06 +0530
Message-ID: <yq5azex1peqt.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Sep 28, 2026 at 04:06:42PM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@nvidia.com> writes:
>> 
>> > On Fri, Sep 25, 2026 at 11:18:44AM +0530, Aneesh Kumar K.V wrote:
>> >> > The TSM viommu should use a NULL parent domain, it doesn't have an
>> >> > iommufd managed S2.
>> >> 
>> >> How would we assign an untrusted device? I currently follow these steps:
>> >
>> >> 1. Create an HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT.
>> >> 2. Allocate a vIOMMU with viommu.hwpt_id set to that hwpt_id.
>> >> 3. Allocate a vdevice with alloc_vdev.viommu_id set to that viommu_id.
>> >> 4. Use VFIO_DEVICE_ATTACH_IOMMUFD_PT with the hwpt_id.
>> >
>> > The vmiommu.hwpt_id should be 0.
>> >
>> > 1. Create a a HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT
>> > 2. VFIO_DEVICE_ATTACH_IOMMUFD_PT with the hwpt_id to establish the T=0
>> >    identity S2, no T=0 vSMMU
>> > 3. Create a VIOMMU with no hwpt_id and the RMM's type. This triggers
>> >    RMM to create the the T=1 vSMMU inside the realm
>> > 4. Allocate a vdevice on the viommu_id. This triggers RMM to create
>> >    the VDEV inside the realm
>> > 5. Setup guest ACPI tables/etc to point at the RMM's T=1 vsmmu.
>> >
>> > Now both the T=1 VSUMM and T=0 fixed translation are setup.
>> >
>> 
>> ok so iommufd_viommu_alloc_ioctl() will do this based on type.
>> 
>> +	if (iommufd_viommu_type_requires_hwpt(cmd->type)) {
>> +		hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
>> +		if (IS_ERR(hwpt_paging)) {
>
> The core code should not decode type, that's always a hack..
>
> The ideal thing is to order things so we get a viommu_ops before
> trying to get the hwpt, then use a flag in the ops
>

Does that mean the SMMU driver will return viommu_ops before
iommu_ops->viommu_init() is called? If so, should viommu_init() be moved
into viommu_ops?

Would the core then only need to do something like:

	rc = tsm_viommu_get_info(idev->dev, cmd->type, &info);
	if (not_using_tsm) // All smmu driver will now support get_viommu_info.
		rc = iommu_ops->get_viommu_info(idev->dev, cmd->type, &info);

and then call info->ops->viommu_init()?

-aneesh
