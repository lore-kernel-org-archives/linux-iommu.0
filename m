Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AE22FDE6;
	Fri, 25 Sep 2026 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790315335; cv=none; b=nQSC0RP0zluEMAn0U9YdTYWZnd9Gp+9e79IWBEEuaycuB72M+XnfSi6BtGEKqs3ZizPvYUGkyQmxyVl2IOppAc6CkXEj7r/55Ka/zVnLxCdKzG7OJRZUMsyR9N+B9xIajvS9S3b8SaTIJfJ/hWwGSjgmw4EiGOtMlJhw2Isdy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790315335; c=relaxed/simple;
	bh=CmJ1TohviW1jEy0lu47MxjXwldaBElKqbIb5EO+cb28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fcvqUcV5w3fAXfrXWHjxselWVjSGsYWdz/48mH+YzAlgFkn0oaa1EGanqwuqMiQOmg3MJkDaB+Ex7Ngk+/WBq50/1MZVAaaD6buo893plqie6YUEyII9NW3hZgQd3ERLkAE5AhfbGp2a7B0UI0JwjhpL5nhKZEsJ1SpZu6WMr5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/gC5glR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/gC5glR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D851F000FF;
	Fri, 25 Sep 2026 05:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790315334;
	bh=fVBHd/NRy8//2F5Jqnh6S0GIR69NIbQ6J/0is6XkeNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=U/gC5glR6mBemulyA6RwK8KnSXkXL/sW+AIu8vAtCEv9laYgCxOdUj2Mv0RdMX3Dj
	 i+Jv/4Bu4ChQUEXllT5T4DG2NhJhH4VxyDgtxpCPJttR7uDRI1gwLJjnTy9y2LS+qp
	 pBPdKKNFTjp7L6CNd6tT+DP218X6dmCAulMjp2gc5LggNKjM5+r4HaiTeJSfqbW6CU
	 gYcqBbkS7QtG3FTGegJRFTSkBHUDrt+i4KoqoGKDZLR5SqeNCSDOEMhXsgBvGtl6h6
	 9L8km8nqeA+OUKfxI+HVtWO1+ZRaT4sEpt8R330nxQF0NNO6BtsNem8yp6iVRdrlbP
	 +ALkO02nOGXkw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
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
In-Reply-To: <179027891416.104879.10365675178574704349.b4-review@b4>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-6-aneesh.kumar@kernel.org>
 <179027891416.104879.10365675178574704349.b4-review@b4>
Date: Fri, 25 Sep 2026 11:18:44 +0530
Message-ID: <yq5ald8pkhj7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

>> [ ... 18 lines skipped ... ]
>> +int iommu_viommu_validate_parent(struct device *dev,
>> +		enum iommu_viommu_type type, struct iommu_domain *parent_domain)
>> +{
>
> I didn't see anything that calls this? I can't imagine what it would
> be needed for?
>


That call is part of the TSM backend driver. The full backend driver is available here:

https://git.gitlab.arm.com/linux-arm/linux-cca/-/commits/cca/scratch/vdevice-tdi?ref_type=heads

int cca_viommu_init(struct iommufd_viommu *viommu, struct device *dev,
		    struct iommu_domain *parent,
		    const struct iommu_user_data *user_data)
{
	struct arm_smmu_realm_params params;
	struct cca_viommu *cca = to_cca_viommu(viommu);
	struct cca_psmmu *psmmu;
	struct kvm *kvm;
	int ret;

	(void)user_data;

	if (viommu->type != IOMMU_VIOMMU_TYPE_ARM_REALM_SMMUV3)
		return -EOPNOTSUPP;
	if (!viommu->kvm_file)
		return -EINVAL;
	kvm = viommu->kvm_file->private_data;
	ret = kvm_realm_ensure_created(kvm);
	if (ret)
		return ret;

	ret = iommu_viommu_validate_parent(dev, viommu->type, parent);
	if (ret)
		return ret;
	ret = iommu_viommu_get_params(dev, viommu->type, &params,
				      sizeof(params));
	if (ret)
		return ret;

	psmmu = cca_psmmu_get(&params);
	if (IS_ERR(psmmu))
		return PTR_ERR(psmmu);
	cca->psmmu = psmmu;
	viommu->ops = &cca_viommu_ops;
	return 0;
}


>
> The TSM viommu should use a NULL parent domain, it doesn't have an
> iommufd managed S2.
>

How would we assign an untrusted device? I currently follow these steps:

1. Create an HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT.
2. Allocate a vIOMMU with viommu.hwpt_id set to that hwpt_id.
3. Allocate a vdevice with alloc_vdev.viommu_id set to that viommu_id.
4. Use VFIO_DEVICE_ATTACH_IOMMUFD_PT with the hwpt_id.

I use the same iommufd for both trusted and untrusted devices because
the guest controls that transition. While operating in untrusted mode, I
use the iommufd to insert DMA mappings via IOMMU_IOAS_MAP.


-aneesh
