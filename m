Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E453E417364
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430787; cv=none; b=HuaMI4yOSWQalbLlvow4tt2XFw2NyJRFD2awpfrOoL+DPYKPh7leL4iS2mFquOc3UCroJIZrLu50Qs4akPI4LLKSheo/d2hpQGZwPxMmHCe7XMqNo6RH9c4gpGiOnl5OR2ASWpa6hLBMcFWaVJRzk8wCTJdrumoJT5jLr4Y48tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430787; c=relaxed/simple;
	bh=a9h/UPEhXHJcQUJXaij0kLNRiuVX+h3HSouNcW4ixWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S85TpHve+8qPYpK2Do6M89Nz6002hnXV3uBKZWyZSLTZ6wh2vl+5CUiGW1I6kjUNyjfjxBryjsWO2LY3n3J/9H7yVp1T1r/GfnNc/SZG9M5/4ilq2EaqYW2/20MlBgWB5lgq/Wi3/qmVxQbqugG1b4bSBMIXa1Eb007U/H9vnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mW7bcfoI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mW7bcfoI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D940419F6;
	Tue,  7 Jul 2026 06:26:20 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E766B3F85F;
	Tue,  7 Jul 2026 06:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783430785; bh=a9h/UPEhXHJcQUJXaij0kLNRiuVX+h3HSouNcW4ixWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mW7bcfoIOacfPHTmaL5YDUPi+l4RzE6GYxxKDiZPmCku89Pv4N1JbCGHW0FesrY/f
	 o3soNc3De1LjahTmzUuMp4AG2OpdD698osyi5edFdDpHomyqDhQuuJ3bViGDqjhZeZ
	 JMRThJSD45VXhFoFymjWeyNn2IT3GHd0MGckTKJM=
Message-ID: <5786468d-a4bc-41d6-ad8b-56f9fd43f5f7@arm.com>
Date: Tue, 7 Jul 2026 14:26:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/riscv: Drop superflous zeros in pci_device_id
 array
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260522145943.774344-2-u.kleine-koenig@baylibre.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260522145943.774344-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/05/2026 3:59 pm, Uwe Kleine-König (The Capable Hub) wrote:
> The .driver_data member of the struct pci_device_id array were
> initialized by a list expressions to zero without making use of that
> value. In this case it's better to not specify a value at all and let
> the compiler fill in the zeros. Same for the list terminator that can
> better be completely empty.

I think I'd agree this counts as a nice enough cleanup in its own right.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> while being a cleanup that can stand on its own this is also a
> preparation for making driver_data an anonymous union that requires that
> .driver_data is initialized by name and not by list order. The union
> allows to make better use of the C type system and drops the need for
> casting. The change to a driver will look as follows:
> 
> 	diff --git a/arch/x86/platform/intel-mid/pwr.c b/arch/x86/platform/intel-mid/pwr.c
> 	index 1739971478ff..c0d9da81d512 100644
> 	--- a/arch/x86/platform/intel-mid/pwr.c
> 	+++ b/arch/x86/platform/intel-mid/pwr.c
> 	@@ -347,7 +347,7 @@ struct mid_pwr_device_info {
> 	
> 	 static int mid_pwr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	 {
> 	-	struct mid_pwr_device_info *info = (void *)id->driver_data;
> 	+	struct mid_pwr_device_info *info = id->driver_data_ptr;
> 		struct device *dev = &pdev->dev;
> 		struct mid_pwr *pwr;
> 		int ret;
> 	@@ -471,8 +471,8 @@ static const struct mid_pwr_device_info tng_info = {
> 	
> 	 /* This table should be in sync with the one in drivers/pci/pci-mid.c */
> 	 static const struct pci_device_id mid_pwr_pci_ids[] = {
> 	-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PENWELL), .driver_data = (kernel_ulong_t)&pnw_info },
> 	-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_TANGIER), .driver_data = (kernel_ulong_t)&tng_info },
> 	+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PENWELL), .driver_data_ptr = &pnw_info },
> 	+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_TANGIER), .driver_data_ptr = &tng_info },
> 		{}
> 	 };
>   
> which is a nice improvement dropping three casts and that will make the
> compiler say:
> 
> arch/x86/platform/intel-mid/pwr.c: In function ‘mid_pwr_probe’:
> arch/x86/platform/intel-mid/pwr.c:350:44: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    350 |         struct mid_pwr_device_info *info = id->driver_data_ptr;
>        |                                            ^~
> 
> (so it promotes that driver data is supposed to be const).
> 
> There is no iommu driver using pointers for driver data, so the example
> is from a different subsystem. Also this is the only pci driver in
> drivers/iommu, so no further patches for this part of my quest to that
> subsystem.
> 
> Best regards
> Uwe
> 
>   drivers/iommu/riscv/iommu-pci.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
> index d82d2b00904c..8abf52dfb4c9 100644
> --- a/drivers/iommu/riscv/iommu-pci.c
> +++ b/drivers/iommu/riscv/iommu-pci.c
> @@ -109,9 +109,9 @@ static void riscv_iommu_pci_shutdown(struct pci_dev *pdev)
>   }
>   
>   static const struct pci_device_id riscv_iommu_pci_tbl[] = {
> -	{PCI_VDEVICE(REDHAT, PCI_DEVICE_ID_REDHAT_RISCV_IOMMU), 0},
> -	{PCI_VDEVICE(RIVOS, PCI_DEVICE_ID_RIVOS_RISCV_IOMMU_GA), 0},
> -	{0,}
> +	{ PCI_VDEVICE(REDHAT, PCI_DEVICE_ID_REDHAT_RISCV_IOMMU) },
> +	{ PCI_VDEVICE(RIVOS, PCI_DEVICE_ID_RIVOS_RISCV_IOMMU_GA) },
> +	{ }
>   };
>   
>   static struct pci_driver riscv_iommu_pci_driver = {
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

