Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88FB3839A1;
	Fri, 25 Sep 2026 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324119; cv=none; b=D2IuW3/gROFFLVzSaQ3UHHokdhWzCbQ1x+YapJx4XcW4M5nvtgn/wm/J1qlFxgr6vWh5LVOeO/hUfH+hdnc8F4ln7RcEpDCRh320fYQlbipQkz1qicstCBqkplEl+wqoJ8LEa1Tjlc6yBaQ4UauGRkz9jnQjDev8Ll1D/hU8aTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324119; c=relaxed/simple;
	bh=Sq/MD1CFF/lMn7OeW4eS8v+dN6o67iz5k9bCvyWWybs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GD+Ulrd0c0IvUF04V4IVqKALkEvBbhFDBLU6hTQor0erGHJJgNBCYa+Wv0+afJiES5EAvNMbgsMjTlOALyz5WO5D1YdDz2msBWu44YoKYj4+PZOOU5Vyy9Tdi+z3T/keVvRurEOh4LAn2Z3i1nTZ+jXUzNDQ1JUcppctg95ralA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErBo7dVP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErBo7dVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA541F000FF;
	Fri, 25 Sep 2026 08:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790324117;
	bh=TMnV0+CZTZ3CTcbhvPznc395O+R0dQa3TL8v5SgEixY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ErBo7dVPdwX4a8pOrt/GeYLdIw8Y6TfCZvXL2/lgy+ZkP5xgsoVP0UiqtFyWiFOll
	 +7+fJLVfMrHcQyjAcz/U+MJPQjvAqwh27T+EenszutG4VzbQaTwdh03iyops8WAk0f
	 81XfYLQZhNwqZAItsJGjSc5UycIKJqcTql52R0Z9xOQt+oKbznnzo8j8UxWwE9P9Sw
	 XKdxRsYFshQVCfxTSKM26ZLpgefIwvaSM6S9xvOOsXrqksnI/Cu83+PwmfsC9UMgVv
	 PNbwaNIGuxRFSoVqqmxGIAhDI1n4v0LgfNMiApdccol1Yn9a25Z8ucYOXEKKPg74ZD
	 IY1VJcm7Hp4PQ==
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
Subject: Re: [RFC PATCH v6 11/11] PCI/TSM: Add reference-counted contexts
 for vdevice providers
In-Reply-To: <179027891417.104879.16761593878106297870.b4-review@b4>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-12-aneesh.kumar@kernel.org>
 <179027891417.104879.16761593878106297870.b4-review@b4>
Date: Fri, 25 Sep 2026 13:45:08 +0530
Message-ID: <yq5a5wztkar7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

>> [ ... 32 lines skipped ... ]
>> @@ -676,17 +679,21 @@ Description:	(RO) Return PCI device name of this device's DSM (Device
>>  
>>  What:		/sys/bus/pci/devices/.../tsm/bound
>>  Contact:	linux-coco@lists.linux.dev
>> -Description:	(RO) Return the device name of the TSM when the device is in a
>> -		TDISP (TEE Device Interface Security Protocol) operational state
>> -		(LOCKED, RUN, or ERROR, not UNLOCKED). Bound devices consume
>> -		platform TSM resources and depend on the device's configuration
>> -		(e.g. BME (Bus Master Enable) and MSE (Memory Space Enable)
>> -		among other settings) to remain stable for the duration of the
>> -		bound state. This attribute is only visible for devices that
>> -		support TDISP operation, and it is only populated after
>> -		successful connect and TSM bind. The TSM bind operation is
>> -		initiated by VFIO/IOMMUFD. This is a "link" TSM attribute, see
>> -		Documentation/ABI/testing/sysfs-class-tsm.
>> +Description:	(RO) Return the device name of the TSM when this PCI function
>> +		has a successfully initialized TSM-backed vdevice binding, or
>> +		an empty line when no such binding exists. The binding is
>> +		established through VFIO/IOMMUFD and remains visible until
>> +		the provider releases its context during vdevice teardown.
>> +		Merely connecting the device to a TSM or acquiring a context
>> +		does not establish a binding. Bindings of other functions
>> +		managed by the same DSM do not affect this attribute.
>> +
>> +		This reports the binding lifetime, not the current TDISP
>> +		(TEE Device Interface Security Protocol) state. A bound vdevice
>> +		may be UNLOCKED, and TDISP lock/unlock transitions do not
>> +		change this attribute. This attribute is only visible for
>> +		devices that support TDISP operation. This is a "link" TSM
>> +		attribute, see Documentation/ABI/testing/sysfs-class-tsm.
>
> Should we just delete this sysfs instead of torturing the code to
> implement it?
>
> Why would anyone ever read it? What purpose would it serve to read it?
>
> Leaking the iommufd vdevice outside the iommufd world is a horrible
> idea from a lifetime perspective. We should only do it with an
> incredibly strong reason. A debugging sysfs should be deleted. We can
> create a debugfs around the viommu if that is really important,
> somehow I doubt it is..

OK, I will drop support for the "tsm/bound" sysfs attribute.

-aneesh
