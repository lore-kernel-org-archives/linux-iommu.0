Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B43EF0C9
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352419; cv=none; b=Buvf1L2fyhpTTwmJMtqG8aJBbo2ghcmfTcMwUuxGNPIbOnEpGWAPT62V5TWgQpkQUrjOXBkXsbNUH17edtH5DSjgotILlPq4fNZtreg6sAqLE44hoapNgkO1ynCB0OCcbAmwD3znjAYl5RQf3y7fR2zrNbBX21Jylfml6gxY9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352419; c=relaxed/simple;
	bh=t5cmH5k66x4vyuWZdylInzIFhVjZz3G/EcBlvfb5IkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vkeox8Z4mK6BwAyXt1rUb6GF9Wyd4Hv0MRL8/VXwnKs05R9nKty8rJU7dnWdsA+5N628Bl2VxMF6/YIG2c0PIdv9ulHOmifqOJi0mdOaryhsZE4krGuryIKnfjaVJ4oRgAwdByfVIEs9iOLAWCovJ5g3p7JvDU0uCxksD9Wfi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sb08j1DU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sb08j1DU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1FC21477;
	Tue, 24 Mar 2026 04:40:08 -0700 (PDT)
Received: from [10.57.76.67] (unknown [10.57.76.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7165F3FE14;
	Tue, 24 Mar 2026 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774352414; bh=t5cmH5k66x4vyuWZdylInzIFhVjZz3G/EcBlvfb5IkI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sb08j1DUqE3iHoUeZIzDlyRRn9uO1/zkckxkSz04us34juigVSoX6nO+nH39zMQfZ
	 L2TjOy/FMkLRxvc9+wLYoOW3sHJVjObO4dB03CVVShhAHlQhW1n12++7DhextAb0vI
	 LnfjazUCiMfsR/Xzt9D1Epg0EuwoGuso6qR2tpAI=
Message-ID: <13510f0d-fa8e-4094-af45-aeef59b128b3@arm.com>
Date: Tue, 24 Mar 2026 11:40:09 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Fix bypass of IOMMU readiness check for
 multi-IOMMU devices
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 peter.griffin@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com,
 jyescas@google.com, kernel-team@android.com, stable@vger.kernel.org
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-23 1:09 pm, Tudor Ambarus wrote:
> Commit da33e87bd2bf ("iommu: Handle yet another race around
> registration") introduced a readiness check in `iommu_fwspec_init()` to
> prevent client drivers from configuring their IOMMUs before
> `bus_iommu_probe()` has completed.
> 
> To optimize the replay path, the readiness check was conditionally
> gated behind `!dev->iommu`:
>      if (!dev->iommu && !READ_ONCE(iommu->ready))
>          return -EPROBE_DEFER;
> 
> However, this assumption breaks down for devices that map to multiple
> IOMMU instances. During the initialization loop over multiple IOMMUs in
> `of_iommu_configure_device()`, the first IOMMU successfully allocates
> `dev->iommu`. When `iommu_fwspec_init()` is called for the second
> IOMMU, `!dev->iommu` evaluates to false, short-circuiting the logic and
> entirely bypassing the `iommu->ready` check.
> 
> If the second IOMMU is still executing its `bus_iommu_probe()`
> concurrently, this allows the client driver to proceed prematurely,
> resulting in a late IOMMU probe warning:
>      dev: late IOMMU probe at driver bind, something fishy here!
>      WARNING: drivers/iommu/iommu.c:645 at __iommu_probe_device
> 
> Fix this by making the `iommu->ready` check unconditional, ensuring
> that a device will defer its probe until *all* of its required IOMMUs
> are fully registered and ready.

...which is obviously wrong, since the whole point is that we *do* want 
of_iommu_xlate() to succeed in the bus_iommu_probe() path before the 
IOMMU driver has finished registering, because that's how we get probe 
to actually happen correctly in the expected order. This change would 
effectively undo the whole thing, except leaving ACPI systems without 
IOMMU functionality at all - it'll only be sort-of-working for you 
because DT still has the sketchy iommu_probe_device() replay in the 
driver bind path.

Honestly we just need to get rid of that replay call, which is the root 
of almost all of the problems, but I don't know what to do about all the 
remaining of_dma_configure() abusers that are relying on it... :(

Thanks,
Robin.

> Cc: stable@vger.kernel.org
> Fixes: da33e87bd2bf ("iommu: Handle yet another race around registration")
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> The warning was observed using an Android 6.19 tree, using downstream
> drivers (exynos-decon and samsung-sysmmu-v9).
> ---
>   drivers/iommu/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 78756c3f3c40..e61927b4d41f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3042,7 +3042,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
>   
>   	if (!iommu)
>   		return driver_deferred_probe_check_state(dev);
> -	if (!dev->iommu && !READ_ONCE(iommu->ready))
> +	if (!READ_ONCE(iommu->ready))
>   		return -EPROBE_DEFER;
>   
>   	if (fwspec)
> 
> ---
> base-commit: ca3bbc9287400c1274d87ee57a16e3126ba2969a
> change-id: 20260320-iommu-ready-check-4976863957c2
> 
> Best regards,

