Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4323B12F36E
	for <iommu@lists.linux.dev>; Thu,  7 Mar 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826520; cv=none; b=syQhqKoegslTSNHWgcMQnl5XAuk6wsQ9LLItLP8RtQaJe8zIZeGX8uu6Cs6thgEE0YM2Sd4V+yIqEOGGPOI0N+sTwLef6aX5m6cffIJnqs2zV77TfqjQv5Kp5TROWsgIcXIlnr88sxb4iZorpWGJGMdkO4H7a11RgZoqqelfvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826520; c=relaxed/simple;
	bh=YYYOROjZ4bykzGGlgE0adq5pcP/7AaunEdDwDHKG3Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiH79yJDyICsFyExU94miKdNeJGdK+iS4ntF666osVR8BvXNGCZsJp+CHSbzqff2C+wiYNx9DP9rPAICwDWkEHB43AFm4UpqZ6Vsx0dhCrTd+k46ZaM6xNVqcRT1o83TedgrF+ZQd5PgATPy2djH+LOU16SqYMkFqFmnUXOPiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83FC71FB;
	Thu,  7 Mar 2024 07:49:13 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DE7F3F73F;
	Thu,  7 Mar 2024 07:48:33 -0800 (PST)
Message-ID: <95554e96-d8b9-4325-aa73-e698b1873a79@arm.com>
Date: Thu, 7 Mar 2024 15:48:31 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: always select INTEL_IOMMU for IRQ_REMAP
Content-Language: en-GB
To: Arnd Bergmann <arnd@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@elte.hu>,
 Suresh Siddha <suresh.b.siddha@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240307140547.2201713-1-arnd@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240307140547.2201713-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/03/2024 2:05 pm, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_INTR_REMAP was originally split out of the intel iommu code to be
> shared by IRQ_REMAP. This recently broke again because the IRQ_REMAP
> code calls the global device_rbtree_find() function that is unavailable
> for builds without INTEL_IOMMU:
> 
> x86_64-linux-ld: vmlinux.o: in function `qi_submit_sync':
> (.text+0x10771e0): undefined reference to `device_rbtree_find'
> 
> It seems that the intel iommu code now contains a lot of generic helper
> functions that are not specific to intel, such as alloc_pgtable_page(),
> iommu_flush_write_buffer(), domain_attach_iommu() etc, so presumably
> it is not x86 specific any more.

No, it's still all very much Intel-specific, which in fact means it is 
just recently now x86-specific since IA-64 has departed.

Historically it's always been the case that building IRQ remapping 
support on its own without IOMMU_API was supported, and for a while we 
even had the awkward iommu_device_set_ops() wrapper and various other 
indirections and stubs in the core API solely to make it work. IMO the 
underlying issue here is that there have never been very clear lines of 
separation between the ACPI DMAR code, the IOMMU API driver, and the IRQ 
remapping driver, so unless the whole design could be improved to make 
it harder to break, it probably is time to start asking the question of 
whether anyone actually cares about this config combination any more.

Thanks,
Robin.

> Fix the build failure for now by just selectin INTEL_IOMMU by the
> code that relies on it. It might be helpful to split out all the
> functions without an intel_iommu_* prefix into a helper library
> to avoid including the x86 specific bits on non-x86, but that could
> be a follow-up.
> 
> Fixes: d3f138106b4b ("iommu: Rename the DMAR and INTR_REMAP config options")
> Fixes: 80a9b50c0b9e ("iommu/vt-d: Improve ITE fault handling if target device isn't present")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Not sure about this one, I just ran across the build regression and
> wasn't sure if the intel-iommu functions are meant to be generic
> or just misnamed. The patch description assumes the former, if that
> is wrong, it needs a different explanation or a different fix.
> ---
>   drivers/iommu/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index df156f0a1a17..da5339bdb7e7 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -196,6 +196,7 @@ config IRQ_REMAP
>   	bool "Support for Interrupt Remapping"
>   	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
>   	select DMAR_TABLE
> +	select INTEL_IOMMU
>   	help
>   	  Supports Interrupt remapping for IO-APIC and MSI devices.
>   	  To use x2apic mode in the CPU's which support x2APIC enhancements or
