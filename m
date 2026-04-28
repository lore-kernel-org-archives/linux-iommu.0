Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D7406284;
	Tue, 28 Apr 2026 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378394; cv=none; b=HqU7k0Vrh7klFCxA/9+8JQk07LAfDS8mo/2fPyMww64jrAhrPEVMhWwq9CqxZdmMEjLl34iX/mmk2xXsBuCtXLUjqPev9WyQxA72NYEFq4X1Mm6YXdajb6kE6oenWFKZE5ZUG0PMyufAoB6JYm5n9ebulpbN01K0H8mtYyyLdmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378394; c=relaxed/simple;
	bh=ZUFQuw4rvWoKiI3smb8MrsAqF+s0KUhY5FG+o39zbPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AOk3oHxyRDdwiPrlzQJ887Y5gWEx/Cyf47hwpQmsDjbIzJbuc/3Sg6wGGQ57s16iXV/n2ZTX43jDVDlffzXKIiJlUoCGTQ8nXiX1sO0wfe6pPMdDt71cZiCjj04P0ebAtUCkN5iLNguWOSixV+zZTZTWpvZhLLB2UxT15lSc1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz3NMaGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz3NMaGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D9AC2BCAF;
	Tue, 28 Apr 2026 12:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777378393;
	bh=ZUFQuw4rvWoKiI3smb8MrsAqF+s0KUhY5FG+o39zbPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dz3NMaGWR/We9y98jgncP8+7im11YlI9TGTEB6JDWTVjfoE2XQB5Rai1dnh+CcqEc
	 Li1YQX/G/noCGcvwGlHmFd68k3faxB75+oxQNm/AAZPHQo9qQPBs6YVe9DvHS8mud3
	 IGpBCQSBfsxwj3B0nJQ3QJzTWvtR1nW+JwENXYHysYlX9LKA8zcumKSRSHsaSImNF8
	 aZI5yLci3vtsnr4g5h1BSjosc4CzlgxspwOH5eAwt9dLryXMIvQ26xSnJqsx+sciUV
	 wXczjPDENjs7cdovYGm8UgvS0Hn4EwXoXHKNfNlIijLUkVkcsufNPnjQ6ZB0273PsL
	 oVlkwiOCTkr+g==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 4/4] iommufd/vdevice: add TSM guest request ioctl
In-Reply-To: <20260427140539.GE740385@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-5-aneesh.kumar@kernel.org>
 <20260427140539.GE740385@ziepe.ca>
Date: Tue, 28 Apr 2026 17:43:05 +0530
Message-ID: <yq5acxzj1dwu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Apr 27, 2026 at 11:40:05AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> +/**
>> + * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
>> + * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
>> + * @vdevice_id: vDevice ID the guest request is for
>> + * @scope: Bus-specific scope classification for the guest request
>> + * @req_len: Size in bytes of the input payload at @req_uptr
>> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
>> + * @__reserved: Must be 0
>> + * @req_uptr: Userspace pointer to the guest-provided request payload
>> + * @resp_uptr: Userspace pointer to the guest response buffer
>> + *
>> + * Forward a guest request to the TSM bound vDevice. This is intended for
>> + * guest TSM/TDISP message transport where the host kernel only marshals
>> + * bytes between userspace and the TSM implementation.
>> + *
>> + * The meaning and valid values of @scope are defined by the TSM backend for
>> + * the device bus type.
>
> If you want to do this then you have to also provide a way to discover
> what the TSM backend is so userspace can form the correct numbers.
>

These guest-driven requests end up in the correct VMM backend, which
should already be aware of the scope value to use. In the case of ARM
CCA, the RHI calls include a device ID (vdev_id), which the VMM can use
to determine the appropriate scope value.

>
> Also, since scope is now a uapi whatever in tsm is defining the values
> must be moved to the uapi headers.
>

Sure, I will update this in the next revision. Dan, should this be part of the TSM series?

> Probably this is not a good idea and iommufd should just have its own
> enum with unique numbers for every bus and do the validation and
> translation.
>

-aneesh
