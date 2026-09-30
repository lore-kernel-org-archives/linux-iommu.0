Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0045A2A2;
	Wed, 30 Sep 2026 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755409; cv=none; b=sXlbAeoZL5CK+kLKOtwMqjDonZoCxGe+Hdc1OXMsZDX67qKMMGqDHFS5dIMeDu9D65EvLe9taj6FGd/k+bWZMif5Xx8AbRUdxvnKyeRb7UdRXmPopGcQ5+joNhN8F3lq8nd3VERR0VT263dbo8akDqSgJkQmPb/FbWO202Kyfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755409; c=relaxed/simple;
	bh=LSD0H7hlTgsIK48icru9I/onbn3XKpj8p7mhQiQrTUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=da5x0MtzXaqEsN9+RBP84ciG7we585oqyajw6E4bbPcyX6tp5YBzmjGZhG/flbgFaINQhqu7IcI8xkyWnuu0OF69KOZaN0ArbmPL6YG1xxqd7QGQFtPhSnZbtw1L8TIOxW60c1OLsg4TBQUATNZua2rlq+8Uz4wCMqhiUP6DfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd0+t+cp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd0+t+cp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0567A1F000FF;
	Wed, 30 Sep 2026 08:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790755407;
	bh=w9zOxQ2Xp6lP5o/Tko+m/wjgpl8Fwpt+CqNeRAhSwXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Hd0+t+cpt41c4LYVSklR73f+gLWB9/zmTXMCDWih/gR4ZLXKt8iAOR+aE3Gc2Teqe
	 MbVmDnkB9qw9pZn7yV8m647PcWIVsAqpNmmQEeaWHpmPX5AaRfPlOa10AlAk3357xy
	 hfw9SYVlu4iUYm3dfgim6ms7xKQKkO4tyhJxNzLOH3cRdCpXxPs7KidEH5HsFvKJDn
	 QZA6h6OeSxVWceH7i83IXRUpr9gvM+UF+//IukGuLV0TdSgda17aNzo3owL+1mU+wX
	 QtG2j0X55ujiANkhhe3JGk05Wo9jpAyusLpGn+IgvikGlEM87PBUfqpu3szeCwdgHx
	 ljVnnt+0EpOZg==
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
Subject: Re: [RFC PATCH v6 09/11] iommufd: Add the vdevice TSM request ioctl
In-Reply-To: <179027891417.104879.282447770434616733.b4-review@b4>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-10-aneesh.kumar@kernel.org>
 <179027891417.104879.282447770434616733.b4-review@b4>
Date: Wed, 30 Sep 2026 13:33:17 +0530
Message-ID: <yq5a7bk3upx6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

>> [ ... 95 lines skipped ... ]
>> +static bool iommufd_vdevice_tsm_req_arch_valid(u32 tvm_arch)
>> +{
>> +	switch (tvm_arch) {
>> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_CCA:
>> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_SEV:
>> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_TDX:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>
> Generally speaking we should not do things like this, the viommu
> object should declare what it supports if we want to have validation
> on the iommufd side.
>
>> [ ... 140 lines skipped ... ]
>> +#ifdef CONFIG_TSM
>> +/**
>> + * struct tsm_guest_req_info - parameters for a guest-initiated TSM request
>> + * @op: operation for the guest-initiated request
>> + * @tvm_arch: guest TVM architecture
>> + * @req: request data buffer filled by guest
>> + * @req_len: the size of @req filled by guest
>> + * @resp: response data buffer filled by host
>> + * @resp_len: the size of @resp buffer filled by guest
>> + */
>> +struct tsm_guest_req_info {
>> +	enum iommu_vdevice_tsm_guest_req_op op;
>> +	enum iommu_vdevice_tsm_guest_tvm_arch tvm_arch;
>> +	sockptr_t req;
>> +	size_t req_len;
>> +	sockptr_t resp;
>> +	size_t resp_len;
>> +};
>
> Why is this struct in tsm land?
>
> I'm not seeing why the iommufd interface should be locked to tsm, as I
> said other viommus need this kind of command channel too. Can't we
> have a general one?
>
> Why would it ever not be tied to userspace pointers? I don't want
> an in kernel user ever using this kind of struct?
>


The previous discussion suggested that another kernel subsystem might
need to use this low-level TSM interface, although no concrete example
was identified. In other words, an opaque guest request could be issued
from either userspace or kernel space. 

>
>> [ ... 34 lines skipped ... ]
>> +/**
>> + * enum iommu_vdevice_tsm_guest_req_op - operation for guest TSM requests
>> + * @TSM_REQ_VALIDATE_MMIO: Validate MMIO for the TDI
>> + * @TSM_REQ_SET_TDI_STATE: Set TDI state
>> + * @TSM_REQ_SEV_ENABLE_DMA: Enable SEV DMA
>
> That seems wrong.. The hypervisor should not have control over T=1
> DMA.
>

This was added specifically for AMD SEV, which requires an IOMMU-side
update to enable DMA.

>
>> + * @TSM_REQ_SEV_DISABLE_DMA: Disable SEV DMA
>> + * @TSM_REQ_READ_OBJECT: Read a TSM object
>> + * @TSM_REQ_REGEN_OBJECT: Regenerate a TSM object
>> + * @TSM_REQ_OBJECT_INFO: Read TSM object information
>> + */
>
> These operations will need alot more commentary. Use kdocs inside the
> enum below to make that easier.
>


I will add kernel-doc comments for the operations used by CCA.

We have gone through several iterations to identify the guest
passthrough request facility we need. IIUC, both TDX and CCA give the
hypervisor some control over the request type, while SEV-TIO is more
opaque.


>
>> [ ... 10 lines skipped ... ]
>> +/**
>> + * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
>> + * @size: sizeof(struct iommu_vdevice_tsm_req)
>> + * @vdevice_id: vDevice ID the guest request is for
>> + * @op: One of enum iommu_vdevice_tsm_guest_req_op
>> + * @tvm_arch: One of enum iommu_vdevice_tsm_guest_tvm_arch
>> + * @req_len: Size in bytes of the input payload at @req_uptr
>> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
>> + * @req_uptr: Userspace pointer to the guest-provided request payload
>> + * @resp_uptr: Userspace pointer to the guest response buffer
>> + * @tsm_code: TSM-specific result code returned by the TSM implementation
>> + *
>> + * Forward a TSM request to the TSM bound vDevice. This is intended for
>> + * guest TSM/TDISP message transport where the host kernel only marshals
>> + * bytes between userspace and the TSM implementation.
>> + *
>> + * The request operation is guest initiated. The TSM backend validates
>> + * @tvm_arch against its bound TVM architecture assumptions.
>> + *
>> + * The request payload is read from @req_uptr/@req_len. If a response is
>> + * expected, userspace provides @resp_uptr/@resp_len as writable storage for
>> + * response bytes returned by the TSM path.
>> + *
>> + * The ioctl is only suitable for commands and results that the host kernel
>> + * has no use, the host is only facilitating guest to TSM communication.
>> + */
>> +struct iommu_vdevice_tsm_req {
>> +	__u32 size;
>> +	__u32 vdevice_id;
>> +	__u32 op;
>> +	__u32 tvm_arch;
>> +	__u32 req_len;
>> +	__u32 resp_len;
>> +	__aligned_u64 req_uptr;
>> +	__aligned_u64 resp_uptr;
>> +	__aligned_u64 tsm_code;
>
> out_tsm_code
>

That is required for SEV-TIO.

-aneesh
