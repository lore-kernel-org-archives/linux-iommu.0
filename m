Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D69435507;
	Fri, 25 Sep 2026 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316008; cv=none; b=KD9roqUHrs2wSm8GeS0nroCjBdEH5pjKa/9qxsB43xPl06ed6gZH5PhR+E1XnMylGyYNmq/Z1GvH0Jr8U5CPH6kAuBHIL/mcZiT8x7vQGJwK1x8mL6iycLcYHpl7DRMgP4IOp7skcm0WG8/1JUt4fCAFJYQAFCC8+1cLfmbu2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316008; c=relaxed/simple;
	bh=ie+gj7vD2ge3H67PJSiyea0c1BAmrWYHSAdR1PCENUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQta3XtULDMrEWAS4hDVSAPlqWo5TyR51x486VzGIeHF7Z+gkBNEVKfNs211CDC1oXeX7rL9Td2vymzRiPsxx3QaYS5ad5Xf5XvHV056ePbG68gwtfWOGQ1aMCbZmshcQcZUOcsTEQXaabYeeSJQBSfqqQNmzlfVzDAJf2sO9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvIKc2kN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvIKc2kN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5990A1F000FF;
	Fri, 25 Sep 2026 06:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790316006;
	bh=Ua/+25wad5qmWagy8+jsSvbxWH5vOUthiDWDmX4TdGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lvIKc2kNY81qUPvb7aD2r4Voa2NbKJXY/UV5eG4iVbMBYP7nodAMaG3fWeHZ8wvCj
	 ySPOJfyF9YnKOlN6mD33NaSDqQ2FX+Kw9nYHnqniXhsRd5Ovp4dxTWF+RiSHyCgMcw
	 vJfU1OWIw7Wh5FXuJyYyVVcGcsnIhT1j0CbhQBfy1iHXoAvs5EY8GNu1UE6mTyxmBr
	 63hzZHJC2YROfYXahHbnroOif5IVsZ1x9+zpRpJyOPn60EkMQDUJ/F2DkItpNJBCC9
	 ht4tkP+SUdwq8Wnx1+YAsbUBdlhNbL4XglUIjwXr6Px0P8xuEPt1Ua6Z9UJp3KiXl4
	 7LyonpvPyBeGw==
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
Subject: Re: [RFC PATCH v6 06/11] iommu: Add a helper to query vIOMMU
 hardware parameters
In-Reply-To: <179027891417.104879.9762824167936334166.b4-review@b4>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-7-aneesh.kumar@kernel.org>
 <179027891417.104879.9762824167936334166.b4-review@b4>
Date: Fri, 25 Sep 2026 11:29:58 +0530
Message-ID: <yq5afqyxkh0h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

>> [ ... 18 lines skipped ... ]
>> +int iommu_viommu_get_params(struct device *dev,
>> +		enum iommu_viommu_type type, void *params, size_t params_size)
>> +{
>
> I imagined this would be a direct function call from TSM to iommu
> driver? Is there a reason to do it this way? I think a TSM -> iommu
> module dependency is OK
>

Do you mean that the TSM backend should call arm_smmu_get_realm_params()
directly? I was trying to avoid that dependency. TSM depends only on
iommufd, not on the SMMU driver. Making this part of iommu_ops also
simplifies supporting different get_params implementations for different
hardware IOMMUs on the same architecture, if needed.

-aneesh

