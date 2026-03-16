Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350B223708;
	Mon, 16 Mar 2026 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773640177; cv=none; b=eRxyA133TYEvwyv02Swm3nAhxlmwCHiZesyA204cxV/TrU0Bg/mWcBPpfMCx5fSbRXtxSi3LGOly0N7Qj2ES657LuJRBs2gSkNq+GigVOSFi/qcbFTQoRmg+fUMBmU4qZZv9DzI3mghaq2vY+iRJq4lo9HMA095WdyVSF00iHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773640177; c=relaxed/simple;
	bh=pZiSm+008sCbaEsRnc7ZhunJgxcEmN5bsNlaJsNR6IQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h5Z5Xl0G8Pffq3zr223sPYer59lBAS/2yW2clYW6pEuNsxyLivTiYoF9WdW6AEuQ3M9VcYU1JDMdFVaCv0SRYImeCF4EOAe483/2dO8JfQs4uV/k67UGmD7EypgHj2dNj8PmxTOgozpcyU/dUGXe7ad0930lzhoyaVLQUJoFZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIUW6NGC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIUW6NGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836A5C19425;
	Mon, 16 Mar 2026 05:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773640177;
	bh=pZiSm+008sCbaEsRnc7ZhunJgxcEmN5bsNlaJsNR6IQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SIUW6NGCDj7drWksNlvLLOgEGhgBMLx63Kkt9AQYyu/REgCYx8tIaLlwEP+ITCybA
	 TRXAAjDfeMryGzmiNu3a47BP2AbC1U31uKttcX37YIbNyDzCwwlOp/CuFpVFVrKHhb
	 uTBoYDw8vJ4oG28UAALkMmtk1IAMyge25KiNdLey49OPwtkO9rzukStLcwtmtHWsHb
	 V5MpS5W0xyqYTgqrzXLO0/xf1hvHuTtG+o7kC5BGLMqa+vhYjiWSCG33vQtFp2DtvS
	 l1+ZEUqfspDQH+zZdH1+CFid6Z5pz4fZbs5lpZleQ6mJzt+1AmrBSCK+6s9uPjgRBB
	 PeT3MOvjSaPJA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd
 with a vIOMMU
In-Reply-To: <abOrdFR4L2n334MR@Asurada-Nvidia>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-2-aneesh.kumar@kernel.org>
 <abOrdFR4L2n334MR@Asurada-Nvidia>
Date: Mon, 16 Mar 2026 11:19:28 +0530
Message-ID: <yq5a1phk8gt3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Nicolin Chen <nicolinc@nvidia.com> writes:

> On Mon, Mar 09, 2026 at 04:47:02PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Add optional KVM association to IOMMU_VIOMMU_ALLOC by introducing
>> IOMMU_VIOMMU_KVM_FD and iommu_viommu_alloc::kvm_vm_fd.
>> 
>> When the flag is set, iommufd validates that kvm_vm_fd refers to a KVM
>> VM file and stores a referenced struct file in the vIOMMU object, so
>> later iommufd operations can safely resolve the owning VM.
>> 
>> This is preparatory plumbing for subsequent patches that bind TDI state
>> to the associated KVM VM.
>> 
>> The patch also switch file_is_kvm from EXPORT_SYMBOL_FOR_KVM_INTERNAL to
>> EXPORT_SYMBOL_GPL so that iommu module can use that.
>
> struct vfio_device has the kvm pointer already. So, I think it
> could be forwarded from VFIO side v.s. via userspace ioctl.
>
> Shammer had two patches before and Jason partially reviewed. I
> took those for a side project but haven't sent anywhere. Would
> you please check if they for you?
>
> https://github.com/nicolinc/iommufd/commits/wip/viommu_kvm
>

I will use these patches and add additional patches on top of it.

-aneesh
