Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737126;
	b=eRBkPfzK2NBlvFEaB/NE/oc1RX6VYj+WG0ZNgtLqqRsDTCx/PsiyDI8ySpz2JLhslKkW
	 gbYZ5jkj6SfCENmiWnlZNybwid5w+NfOShZ6eHyVRPDtUePmPewci0/nwxxJAH4YhPCIn
	 sBmfNvdvLSDJUFCXvPU/N0D65nCoy7xvOxUjYSZg8Fst6rHpe3qjoz5d2YMnSF11tBIzV
	 4avV+c2AdTLl+To/Xk0i2XJ8+F+8w2Xm+G+m2SdeP0lFg0gJnYW6MhpIFrFFAavNPPqzF
	 12rUhWaXmA9pV6fr774OMsNCAUn9Jr5J5Yh3s3DQ7L9+aVG2nBR4AgIa6v+9SrAZqRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737126;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=oIr0fqj99M6zbhKwpxysFhLjpIn4bALWywxuRR1DN1s=;
	b=ubRA4ro/zythx6q4wS4jT2d5kxiPH/D5eG/ufXGcGIkY5OoWioV+Sgn0+VBjgKvsjZCn
	 IJ3gdNN8XEvsQQ9L9MJwh0B/wdK+a1kLuDLxb4/EWMoHitnoXaD4GuG4YI8rmuqiPG0jF
	 u1Hy89rPI8RO0F42AUXDTa3G7/nPGMu2oGlwzUk2LqqfL71tbp34tMMuyyol23Lrsk8Fc
	 cSV5xUIFO4uTS/oypGDlKAkbzLL1X7AHFpNymSUmrp1IusZW4n5aQ2uT6AZ3oEmglc/z8
	 W82v0684UvphpFK+X83Z0ZtJjuHhj5mirm8X8X/BwotgJSrQ6clf3CyJD5XKqBEe+hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GYnS+mja;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA99606A326
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 20:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA99606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GYnS+mja
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBD0F1595;
	Tue,  3 Nov 2026 12:18:40 -0800 (PST)
Received: from [10.57.17.5] (unknown [10.57.17.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A318C3F628;
	Tue,  3 Nov 2026 12:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793737124; bh=pOlmng10gT/2DVXXo/ZSmPsjwL9pj6J3zgx/5plS2KY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GYnS+mjaANJ8KeKuIxkQsXqvwKdwwtNq0qE5yu7epLfE6KepxCJhs8oNq/OSdw2Hp
	 cgPps8AY4R6nKA1GF52uznutYFlEB261zaFYCd5MYZnrHF6L8GYkq/Oq83iHhOsiCq
	 qFnebu0CoHn5TvLXS10qzkGyYACofMWvIOgrd+pU=
Message-ID: <9c64eeb4-66cb-4e82-a00d-ae5ef5cba360@arm.com>
Date: Tue, 3 Nov 2026 20:18:40 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: free dev->iommu when iommu_fwspec_init()
 cannot allocate the fwspec
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tal Zussman <tz2294@columbia.edu>, Kevin Tian <kevin.tian@intel.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean-Philippe Brucker <jpb@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261031-iommufd-folio-dirty-v1-0-2cef66d2d6d1@columbia.edu>
 <20261031-iommufd-folio-dirty-v1-1-2cef66d2d6d1@columbia.edu>
 <7e209fb2-4bda-4207-9109-c67c8df41e05@arm.com>
 <20261103193253.GN3889730@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261103193253.GN3889730@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-03 7:32 pm, Jason Gunthorpe wrote:
> On Mon, Nov 02, 2026 at 04:51:05PM +0000, Robin Murphy wrote:
>> On 31/10/2026 8:33 pm, Tal Zussman wrote:
>>> iommu_fwspec_init() allocates dev->iommu with dev_iommu_get() and then
>>> the fwspec. If the fwspec allocation fails it returns -ENOMEM but leaves
>>> dev->iommu allocated, and it leaks.
>>>
>>> kmemleak reports it when iommufd_fail_nth injects the allocation
>>> failure:
>>>
>>>     unreferenced object 0xffff88811c138b00 (size 192):
>>>       comm "iommufd_fail_nt", pid 783
>>>       backtrace:
>>>         __kmalloc_cache_noprof
>>>         dev_iommu_get
>>>         iommu_fwspec_init
>>>         iommu_mock_device_add
>>>         iommufd_test
>>>         iommufd_fops_ioctl
>>>
>>> Free dev->iommu on failure if this call allocated it. iommu_init_device()
>>> allocates it before calling into the driver and frees it on its own
>>> error path, so leave it alone in that case.
>>>
>>> Fixes: 72acd9df18f1 ("iommu: Move iommu_fwspec to struct dev_iommu")
>>
>> No, the bug is clearly the early return in 2a918911ed3d ("iommufd: Register
>> iommufd mock devices with fwspec"), so fix it there please.
>> iommu_fwspec_init() has always been designed to be called in conjunction
>> with iommu_probe_device() which handles cleanup appropriately.
> 
> Asking AI to audit this found the other case I remember...
> 
> Yes: ACPI DMA configuration during driver binding can leave dev->iommu
> allocated after failure:
> 
>   really_probe()
>    -> dev->bus->dma_configure()
>      -> acpi_dma_configure_id()
>        -> acpi_iommu_configure_id()
>          -> IORT / RIMT / VIOT
>            -> acpi_iommu_fwspec_init()
>              -> iommu_fwspec_init()
> 
>   If dev_iommu_get() allocates successfully and the subsequent fwspec
>   allocation fails, acpi_iommu_configure_id() (line 1614) does no
>   cleanup. acpi_dma_configure_id() (line 1670) ignores errors other than
>   -EPROBE_DEFER. This invocation has no enclosing iommu_init_device() to
>   unwind it.

Yes, because that path will no longer allocate - if we reach 
iommu_fwspec_init() from the really_probe path at all now it's because 
the IOMMU is not yet registered, thus we'll always take the early return.

In fact I think the only reason to still have dev_iommu_get() in 
iommu_fwspec_init(), rather than just dereferencing dev->iommu directly, 
is for the sake of those few remaining drivers which abuse 
of_dma_configure() directly that I'm not sure what to do about.

Thanks,
Robin.
> The OF path has its own manual free fix already, it doesn't rely on
> iommu_probe_device() to clean it. The other driver users are the only
> things actually protected by ops->probe_device().
> 
>>> @@ -3074,6 +3074,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
>>>    {
>>>    	const struct iommu_device *iommu = iommu_from_fwnode(iommu_fwnode);
>>>    	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>>> +	bool new_iommu = !dev->iommu;
>>>    	if (!iommu)
>>>    		return driver_deferred_probe_check_state(dev);
>>> @@ -3088,8 +3089,11 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
>>>    	/* Preallocate for the overwhelmingly common case of 1 ID */
>>>    	fwspec = kzalloc_flex(*fwspec, ids, 1);
>>> -	if (!fwspec)
>>> +	if (!fwspec) {
>>> +		if (new_iommu)
>>> +			dev_iommu_free(dev);
>>>    		return -ENOMEM;
>>> +	}
> 
> Just move this allocation before the dev_iommu_get() and free it if
> the get fails. Then the function has a more sensible calling
> convention that error means it doesn't need any unwinding. The
> new_iommu is a little too weird.
> 
> Jason

