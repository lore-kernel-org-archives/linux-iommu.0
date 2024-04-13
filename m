Received: from rockwork.org (rockwork.org [45.32.92.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842AD1CFA8
	for <iommu@lists.linux.dev>; Sat, 13 Apr 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.32.92.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003734; cv=none; b=kse2N+kdP3uSIosGJEBqNg96xdRmbQKzK/g8Kp6hZoXYHtfNEP3QVH1KZeHgFQR++Qnr5nXX4Roy80/zIo/cMjl+Yf/Xt1ojOD1HJ0wal52Fao9qFnOyw+TtzuJmi6W6OI+Nq8VDCobXST848x3DqS/yuBoobnAU5gQC638sSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003734; c=relaxed/simple;
	bh=cKfJqzwn1UM58rtsZxhexJzGwK67MEdN/QUZgx3CAHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfiqQKWTtLDyLkmXcgGDd5T+GDQ3Um0SdWNIO3G6Bwvw4V7/tntjEltegDyKgKxT5R2ud4hTQtW848m+NJmm3FwoRUPTumNAYB22IG7kDIDBMasF9HAVhCnxzfW0sJwjgupa5XdqlWpgcIhBB3isix9R5nR/oHNhxDcQ2sZ0elg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rockwork.org; spf=pass smtp.mailfrom=rockwork.org; arc=none smtp.client-ip=45.32.92.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rockwork.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rockwork.org
Received: from [IPV6:2408:8340:c42:16f0:eb78:1cb0:d0a9:e8e3] (unknown [IPv6:2408:8340:c42:16f0:eb78:1cb0:d0a9:e8e3])
	by rockwork.org (Postfix) with ESMTPSA id 6537B5DD4A;
	Sat, 13 Apr 2024 10:15:11 +0000 (UTC)
Message-ID: <2688421d-37c2-4038-8d03-24ae175f137e@rockwork.org>
Date: Sat, 13 Apr 2024 18:15:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu
 support.
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux@rivosinc.com, linux-kernel@vger.kernel.org,
 Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
 Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>,
 linux-riscv@lists.infradead.org
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Xingyou Chen <rockrush@rockwork.org>
In-Reply-To: <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/20/23 03:33, Tomasz Jeznach wrote:
> ... > +#endif /* _RISCV_IOMMU_BITS_H_ */
> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
> new file mode 100644
> index 000000000000..c91f963d7a29
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-pci.c
> @@ -0,0 +1,134 @@
> ...
> +
> +static struct pci_driver riscv_iommu_pci_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = riscv_iommu_pci_tbl,
> +	.probe = riscv_iommu_pci_probe,
> +	.remove = riscv_iommu_pci_remove,
> +	.driver = {
> +		   .pm = pm_sleep_ptr(&riscv_iommu_pm_ops),
> +		   .of_match_table = riscv_iommu_of_match,
> +		   },
> +};
> +
> +module_driver(riscv_iommu_pci_driver, pci_register_driver, pci_unregister_driver);

There's helper macro to be considered, and not forced to:
   module_pci_driver(riscv_iommu_pci_driver);

> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
> new file mode 100644
> index 000000000000..e4e8ca6711e7
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -0,0 +1,94 @@
> ...
> +
> +static struct platform_driver riscv_iommu_platform_driver = {
> +	.driver = {
> +		   .name = "riscv,iommu",
> +		   .of_match_table = riscv_iommu_of_match,
> +		   .suppress_bind_attrs = true,
> +		   },
> +	.probe = riscv_iommu_platform_probe,
> +	.remove_new = riscv_iommu_platform_remove,
> +	.shutdown = riscv_iommu_platform_shutdown,
> +};
> +
> +module_driver(riscv_iommu_platform_driver, platform_driver_register,
> +	      platform_driver_unregister);

And also:
   module_platform_driver(riscv_iommu_platform_driver);
