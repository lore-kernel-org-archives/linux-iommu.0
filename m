Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CABD326D44
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765386935; cv=none; b=qR7rla353bzX52HkbmbKkClKgwHQ2r99A0CaFYRTZ7xgRp8fNSGUXVXco4owenlRhX5CN6Z3a9oXOMIvzNy1GE+DT9M3TrV3bb17sxKWYYtvzN2Oc3eQ5JXBvu9BdT+L4kBcr3lIhZmllsOtH9/x/iMoa3h+5Kc7clZERNA4x5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765386935; c=relaxed/simple;
	bh=LRNzVybuwbgBFh9YPtAbx0MGh2LsdLGYaXnP4far3EM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S1IIKm/6O04tGQFwo0321/hr5lJQwR5B4QYjBL5onnd6ndL9t03ArQhVqUCumqrZ0dqbPCfAza+jANZDAMbhmP9TF5obXlXgueljQNkFUfPpLyctJ7HsC7Elb0M39vX54RDhWQLknC/OTpdcBG4gifsK3tLpJQlwXNlOVDUaPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oL++Hblx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oL++Hblx"
Received: from [192.168.201.246] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4FCF12116032;
	Wed, 10 Dec 2025 09:15:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FCF12116032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765386932;
	bh=naH2dhqkC83NKYwuVneGxpeuFjL7uWm/g5PqJfAwzi8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oL++HblxZOe3KC+0dbwyS26fX1D4vysW+I8TvFOG8UAHeaZzn3tBtn7otA9Yep/f1
	 39xqqimQHAr0/IdqsoA4LknRt0YA7n2CFRetNYKDJRKdghpedMCLvXq9umx51FD+Gh
	 59tkMZ2KwY3WTMn5w1aDtmKrCFh3sopLzDubqErA=
Message-ID: <0c34e66f-7766-4b4f-a04d-77dbc330f1fe@linux.microsoft.com>
Date: Wed, 10 Dec 2025 09:15:18 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, jacob.pan@linux.microsoft.com,
 nunodasneves@linux.microsoft.com, mrathor@linux.microsoft.com,
 mhklinux@outlook.com, peterz@infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC v1 5/5] iommu/hyperv: Add para-virtualized IOMMU support for
 Hyper-V guest
To: Yu Zhang <zhangyu1@linux.microsoft.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-6-zhangyu1@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20251209051128.76913-6-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/2025 9:11 PM, Yu Zhang wrote:
> Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> This driver implements stage-1 IO translation within the guest OS.
> It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> for:
>  - Capability discovery
>  - Domain allocation, configuration, and deallocation
>  - Device attachment and detachment
>  - IOTLB invalidation
> 
> The driver constructs x86-compatible stage-1 IO page tables in the
> guest memory using consolidated IO page table helpers. This allows
> the guest to manage stage-1 translations independently of vendor-
> specific drivers (like Intel VT-d or AMD IOMMU).
> 
> Hyper-v consumes this stage-1 IO page table, when a device domain is
> created and configured, and nests it with the host's stage-2 IO page
> tables, therefore elemenating the VM exits for guest IOMMU mapping
> operations.
> 
> For guest IOMMU unmapping operations, VM exits to perform the IOTLB
> flush(and possibly the device TLB flush) is still unavoidable. For
> now, HVCALL_FLUSH_DEVICE_DOMAIN	is used to implement a domain-selective
> IOTLB flush. New hypercalls for finer-grained hypercall will be provided
> in future patches.
> 
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  drivers/iommu/hyperv/Kconfig  |  14 +
>  drivers/iommu/hyperv/Makefile |   1 +
>  drivers/iommu/hyperv/iommu.c  | 608 ++++++++++++++++++++++++++++++++++
>  drivers/iommu/hyperv/iommu.h  |  53 +++
>  4 files changed, 676 insertions(+)
>  create mode 100644 drivers/iommu/hyperv/iommu.c
>  create mode 100644 drivers/iommu/hyperv/iommu.h
> 

<snip>

> +
> +static int __init hv_iommu_init(void)
> +{
> +	int ret = 0;
> +	struct hv_iommu_dev *hv_iommu = NULL;
> +	struct hv_output_get_iommu_capabilities hv_iommu_cap = {0};
> +
> +	if (no_iommu || iommu_detected)
> +		return -ENODEV;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	if (hv_iommu_detect(&hv_iommu_cap) ||
> +	    !hv_iommu_present(hv_iommu_cap.iommu_cap) ||
> +	    !hv_iommu_s1_domain_supported(hv_iommu_cap.iommu_cap))
> +		return -ENODEV;
> +
> +	iommu_detected = 1;
> +	pci_request_acs();
> +
> +	hv_iommu = kzalloc(sizeof(*hv_iommu), GFP_KERNEL);
> +	if (!hv_iommu)
> +		return -ENOMEM;
> +
> +	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
> +
> +	ret = hv_initialize_static_domains();
> +	if (ret) {
> +		pr_err("hv_initialize_static_domains failed: %d\n", ret);
> +		goto err_sysfs_remove;

This should be goto err_free since we haven't done the sysfs_add yet

> +	}
> +
> +	ret = iommu_device_sysfs_add(&hv_iommu->iommu, NULL, NULL, "%s", "hv-iommu");
> +	if (ret) {
> +		pr_err("iommu_device_sysfs_add failed: %d\n", ret);
> +		goto err_free;

And this should be probably a goto delete_static_domains that cleans up the allocated static
domains...

> +	}
> +
> +
> +	ret = iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
> +	if (ret) {
> +		pr_err("iommu_device_register failed: %d\n", ret);
> +		goto err_sysfs_remove;
> +	}
> +
> +	register_syscore_ops(&hv_iommu_syscore_ops);
> +
> +	pr_info("Microsoft Hypervisor IOMMU initialized\n");
> +	return 0;
> +
> +err_sysfs_remove:
> +	iommu_device_sysfs_remove(&hv_iommu->iommu);
> +err_free:
> +	kfree(hv_iommu);
> +	return ret;
> +}
> +
> +device_initcall(hv_iommu_init);

<snip>
