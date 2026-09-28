Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23F44E65F;
	Mon, 28 Sep 2026 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591812; cv=none; b=srq13U7SR/p0li9/e+tM876m8Ig/lMdeG0De5+Xa3CQgmR5BS9YjUqDX73Aoa2WV74j4TIO+5Uq6OAd3LlVmvgGzmgczbpRkJbLArIXpv+yTwvwwcqC0cMdNO2YQyogLYyAMLj3Ck1dM0wJZGAElg8Vy/J74mFPMKeUyPAEaTs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591812; c=relaxed/simple;
	bh=+eiU14WtffpsablTSQZkeXYAVRjbhnndgQrMqpPYHgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=duU2wTlnzkI0QM2aW/fBO6Oy7mBSxSy8BZtlEPpTVoPXez28YWrUBjs6eArgjXzkP6HCvx7SrAJCY7CwCgoPhmGVm6oXvGZm1vK8U0eVnfy6Qz/JcTbr9faIS/so0Kmwp2wT+SNHR34xsgSoq4iRdJ6bD7VL8+kkUCM4pbUepHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex9E14LS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex9E14LS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EFE1F000FF;
	Mon, 28 Sep 2026 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790591810;
	bh=3P2mxhk6Zs1a78JTFJDfkPQ7ymLagWRZKHkU7l2oUs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Ex9E14LSPc2TpBUWFF4DLuttqWcWR3I5aUQkGCvGQo9fb9wZJcYjuwPo+aWKDdFBO
	 mcB34+UNJlXcXuLBR/pWeuBR/2QN6O9xpdvhycb+A6lziTjuLJMTE6ADvc6lWQztDe
	 YKBRfhVDM/h87MFKcJw6UR1s0s9m1fgJPbuh+ZaRfA9pVACqz41c1UUxRybOkTGMqB
	 3SJ0Z61CJj8vxV6UBX19iRM6PaUtgiIXn6pb9EfSLOMcZQxjVL+13WluC1DQs6u76c
	 1yOWjAIThgTYnJ8+t4vQL3BGvHVc27eiJxrrBLiDCYG1PKc1pJnSIo9AsEDBqaZyab
	 UtCxiGoYp+dow==
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
In-Reply-To: <20260925122305.GG9354@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-6-aneesh.kumar@kernel.org>
 <179027891416.104879.10365675178574704349.b4-review@b4>
 <yq5ald8pkhj7.fsf@kernel.org> <20260925122305.GG9354@nvidia.com>
Date: Mon, 28 Sep 2026 16:06:42 +0530
Message-ID: <yq5a5wzpr7b9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Fri, Sep 25, 2026 at 11:18:44AM +0530, Aneesh Kumar K.V wrote:
>> > The TSM viommu should use a NULL parent domain, it doesn't have an
>> > iommufd managed S2.
>> 
>> How would we assign an untrusted device? I currently follow these steps:
>
>> 1. Create an HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT.
>> 2. Allocate a vIOMMU with viommu.hwpt_id set to that hwpt_id.
>> 3. Allocate a vdevice with alloc_vdev.viommu_id set to that viommu_id.
>> 4. Use VFIO_DEVICE_ATTACH_IOMMUFD_PT with the hwpt_id.
>
> The vmiommu.hwpt_id should be 0.
>
> 1. Create a a HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT
> 2. VFIO_DEVICE_ATTACH_IOMMUFD_PT with the hwpt_id to establish the T=0
>    identity S2, no T=0 vSMMU
> 3. Create a VIOMMU with no hwpt_id and the RMM's type. This triggers
>    RMM to create the the T=1 vSMMU inside the realm
> 4. Allocate a vdevice on the viommu_id. This triggers RMM to create
>    the VDEV inside the realm
> 5. Setup guest ACPI tables/etc to point at the RMM's T=1 vsmmu.
>
> Now both the T=1 VSUMM and T=0 fixed translation are setup.
>

ok so iommufd_viommu_alloc_ioctl() will do this based on type.

+	if (iommufd_viommu_type_requires_hwpt(cmd->type)) {
+		hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+		if (IS_ERR(hwpt_paging)) {


-aneesh
