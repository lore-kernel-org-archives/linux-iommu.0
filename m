Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B91990A7
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397936; cv=none; b=PiGwtvd18upaNGEKV3j06kGXZS7VZEjsJqZ2DE6RNC4aUEgCQnAWrrOJVDiNZT7pM4GQiNPbzm78CKILqXsoL5vMp6voS3nQ5SbeL8nrFUgpnEzGEulp87GyBgQ+r1K2gmldAbmtmQKjKUWLfp+hflmL+UUfoKG5NWOKG3On7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397936; c=relaxed/simple;
	bh=jugggV/LSSygdzauV++5vICVS/hJ0PZBW1Lft973NTI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b/Lg2vf0kiidBRR6nZ2F+Ru5a0/7cN430vu7tu0bz7MTKYs0rYFDYD+S5xlNEARWJ1HWQ3FAFbH69ELoKZTWgNete55u3LqMHwaAHIN3y3pZf0Ux9MExiZyLCSsl4wOHjwp1Mfns9ifvsxBN5QGDnANryTnyhFnhnfr3xSV6YR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=prKSpqA0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="prKSpqA0"
Received: from [192.168.201.246] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 24E8C20B7187;
	Tue, 28 Apr 2026 10:38:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24E8C20B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777397928;
	bh=O7rtABauihl9wqOFgiCGqnWThUeSwi+O3wmTvtqfHCw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=prKSpqA0nu5bbJsq8pUmLz0rl5TpIfeRd8x/wvD7jk7ib4btICCWyBme71PDyQGNI
	 QssSaXo8RDoZwoRQrqbtNPEawUAR854/AmU12bfQgSxZjaGKNHSqUSx/4F/lzdH49R
	 r1lxgHSY1G4VgBwaC431Tdj5kxVZ19Y48hdU1WsQ=
Message-ID: <e9de1b01-d075-487d-a00a-e2420b909f69@linux.microsoft.com>
Date: Tue, 28 Apr 2026 10:38:37 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
 easwar.hariharan@linux.microsoft.com, jgg@ziepe.ca, nicolinc@nvidia.com,
 praan@google.com, kees@kernel.org, amhetre@nvidia.com,
 Alexander.Grest@microsoft.com, baolu.lu@linux.intel.com,
 smostafa@google.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
To: Joonwon Kang <joonwonkang@google.com>
References: <20260424085339.3503582-1-joonwonkang@google.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260424085339.3503582-1-joonwonkang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/2026 1:53 AM, Joonwon Kang wrote:
> For SVA, the IOMMU core always allocates PASID from the global PASID
> space. The use of this global PASID space comes from the limitation of
> the ENQCMD instruction in Intel CPUs that it fetches its PASID operand
> from IA32_PASID, which is per-task.
> 
> Due to this nature, SVA with ARM SMMU v3 has been found not working in
> our environment when other modules/devices compete for PASID. The
> environment looks as follows:
> 
> - The device is not a PCIe device.
> - The device is to use SVA.
> - The supported SSID/PASID space is very small for the device; only 1 to
>   3 SSIDs are supported.
> - There is a custom way of transmitting the SSID from the kernel to the
>   device.
> 
> With this setup, when other modules have allocated all the PASIDs that
> our device is expected to use from the global PASID space via APIs like
> iommu_alloc_global_pasid() or iommu_sva_bind_device(), SVA binding to
> our device fails due to the lack of available PASIDs.
> 
> Since SSID/PASID is supported per-SID in ARM SMMU v3, this commit
> leverages the fact and lifts the use of the global PASID space if
> possible. What it does includes:
> 
> - Introduce a new IOMMU capability IOMMU_CAP_PER_DEV_PASID_SPACE, which
>   represents whether the IOMMU supports an independent PASID space per-
>   device, not shared across devices. ARM SMMU v3 is the case.
> - Open a new API iommu_attach_device_pasid_any() to allocate any
>   available PASID and attach an IOMMU domain to it.
> - Opt out the use of the global PASID space for SVA if the IOMMU has
>   that capability, and use the new API to allocate a PASID in that case.
> 
> Signed-off-by: Joonwon Kang <joonwonkang@google.com>
> ---
> v1: Request comments for this approach, other possible approaches and/or
>   other aspects to consider more. Code is not sanitized and commits are
>   not separated appropriately in this version.
> 
<snip>

This may be a a basic question, but how does this reconcile with the fact
that the process ID space is global? Even with PID namespacing, I understand
that each process in a PID namespace has a "parent" PID in the parent namespace,
unless I'm grossly mistaken.

Also, with the per-device PASID space, different SVA-capable devices
being used by the same process would have different PASIDs referring to the same
process address space, and would break the DSA<->IAA kind of interaction where the
device drivers can communicate the PASID among each other to operate on the same
process address space. Is that a scenario that does not matter to your use case?

Thanks,
Easwar (he/him)


