Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3FF280A5A
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758004601; cv=none; b=UY+sprez1byRdJBxFKv4cqi48XxtWlsdwx6bYzA1c5qd6IWJHZwA8MNRPTL0x8Ixr2rvs+QUWDjJFeGs/2mlULYMsE0So2AzK16/o+noiWT1VSL88MEZFXS0gLwq3llEKnWEj+5LnO7YJZB/8q+2WqAILzn/f97iGDvtNaMBiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758004601; c=relaxed/simple;
	bh=rUvcScBLoZU8fzKtqY5cbasx953IQcO448w5T9XTDZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=PBYcZSzcbT7C2mwaPS9WLuhoZ1+ESWi4O9oY4jykpUCFEq7yZUBf4gvb/TuBMr/Yct/G7neUJ3PWwZAW2dAzaDtv7uzxUP2caOb5HJvLBjR8/oR3s8bc/Q3h/KFwV3Cf7NzPP1vQ4l6gqOAXp7T7vibBaPEu72SWjR4MtSwrVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VHzeaEHq; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VHzeaEHq"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250916063631euoutp0131ff2741e4145bec42a3358c3f3419c0~lr9ySg4uy2334623346euoutp01W
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 06:36:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250916063631euoutp0131ff2741e4145bec42a3358c3f3419c0~lr9ySg4uy2334623346euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758004591;
	bh=e8zCzPxkp38sYJ95jM1nxXGrrOQtRyH8XIFlD4ueBWE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=VHzeaEHqHwGfn+4pr3kDK8XLLKG0XL5u51knFHg2jfFzzPq65p2DmiBILMSPyh9Ba
	 AIb7R2/Ts1MDS2gPI2C9A/ULnq0BgyP2lWP2b6RN+C9QW4rkJK8hRnKyaJFfXa3GGF
	 8+fb531Til+wVYLKhT5zPdCMSjKz62r6bzZooeYU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250916063631eucas1p2ac9679f96c1dd56f0b8780fb6577dbd6~lr9x6lV142077820778eucas1p2-;
	Tue, 16 Sep 2025 06:36:31 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250916063630eusmtip1a946e2bd904c9117f10cfd349b47a889~lr9xMO4HL1411414114eusmtip1Y;
	Tue, 16 Sep 2025 06:36:30 +0000 (GMT)
Message-ID: <65e3d97e-4a24-4696-9bca-c3f7833144d2@samsung.com>
Date: Tue, 16 Sep 2025 08:36:29 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/2] iommu/exynos: Implement register set and fault
 handling on SysMMU v9
To: "myunggeun.ji" <myunggeun.ji@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: Jongho Park <jongho0910.park@samsung.com>, kiisung lee
	<kiisung.lee@samsung.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250915051320.3378957-2-myunggeun.ji@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250916063631eucas1p2ac9679f96c1dd56f0b8780fb6577dbd6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250915051106epcas2p1c1bdb06ec2ec65aad8a96ffe155ed8b6
X-EPHeader: CA
X-CMS-RootMailID: 20250915051106epcas2p1c1bdb06ec2ec65aad8a96ffe155ed8b6
References: <20250915051320.3378957-1-myunggeun.ji@samsung.com>
	<CGME20250915051106epcas2p1c1bdb06ec2ec65aad8a96ffe155ed8b6@epcas2p1.samsung.com>
	<20250915051320.3378957-2-myunggeun.ji@samsung.com>

On 15.09.2025 07:13, myunggeun.ji wrote:
> SysMMU v9 has a bit different registers.
> - Major and Minor version BIT are changed to BIT[31:28] and BIT[27:24]
> - FLPT(First Level Page Table) offset is changed.
> - interrupt status register has different bits w.r.t. previous SysMMU
>    versions
>
> Add correct register set and fault handling  for SysMMU v9,
> according to all mentioned differences.
>
> Signed-off-by: myunggeun.ji <myunggeun.ji@samsung.com>
> ---
>   drivers/iommu/exynos-iommu.c | 73 +++++++++++++++++++++++++++++++-----
>   1 file changed, 64 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b6edd178fe25..00f4129a7bf2 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -152,7 +152,9 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>   
>   #define MMU_MAJ_VER(val)	((val) >> 7)
>   #define MMU_MIN_VER(val)	((val) & 0x7F)
> -#define MMU_RAW_VER(reg)	(((reg) >> 21) & ((1 << 11) - 1)) /* 11 bits */
> +#define MMU_RAW_VER(reg)	(((reg) >> 28 < 7) ? \
> +				(((reg) >> 21) & ((1 << 11) - 1)) : \
> +				(((reg) >> 24) & ((1 << 8) - 1)))
>   
>   #define MAKE_MMU_VER(maj, min)	((((maj) & 0xF) << 7) | ((min) & 0x7F))
>   
> @@ -171,6 +173,17 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>   #define REG_V7_CAPA1		0x874
>   #define REG_V7_CTRL_VM		0x8000
>   
> +/* v9.x registers */
> +#define REG_V9_CTRL_VM				0x8000
> +#define REG_MMU_CONTEXT0_CFG_ATTRIBUTE_VM       0x8408
> +
> +#define MMU_MAJ_VER_V9(val)		((val) >> 4)
> +#define MMU_MIN_VER_V9(val)		((val) & 0xF)
> +#define MMU_RAW_VER_V9(reg)		(((reg) >> 24) & ((1 << 8) - 1)) /* 8 bits */
> +
> +#define MAKE_MMU_VER_V9(maj, min)	((((maj) & 0xF) << 7) | ((min) & 0xF))
> +#define MAKE_MMU_VM_OFFSET(vid)		((vid) * 0x1000)
> +
>   #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
>   
>   static struct device *dma_dev;
> @@ -228,6 +241,14 @@ static const char * const sysmmu_v7_fault_names[] = {
>   	"RESERVED"
>   };
>   
> +static const char * const sysmmu_v9_fault_names[] = {
> +	"PTW",
> +	"PAGE",
> +	"ACCESS PROTECTION",
> +	"CONTEXT_FAULT",
> +	"RESERVED"
> +};
> +
>   /*
>    * This structure is attached to dev->iommu->priv of the master device
>    * on device add, contains a list of SYSMMU controllers defined by device tree,
> @@ -363,6 +384,19 @@ static int exynos_sysmmu_v7_get_fault_info(struct sysmmu_drvdata *data,
>   	return 0;
>   }
>   
> +static int exynos_sysmmu_v9_get_fault_info(struct sysmmu_drvdata *data,
> +					   unsigned int itype,
> +					   struct sysmmu_fault *fault)
> +{
> +	u32 info = readl(SYSMMU_REG(data, fault_info));
> +
> +	fault->addr = readl(SYSMMU_REG(data, fault_va));
> +	fault->name = sysmmu_v9_fault_names[itype % 5];
> +	fault->type = (info & BIT(20)) ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
> +
> +	return 0;
> +}
> +
>   /* SysMMU v1..v3 */
>   static const struct sysmmu_variant sysmmu_v1_variant = {
>   	.flush_all	= 0x0c,
> @@ -420,6 +454,21 @@ static const struct sysmmu_variant sysmmu_v7_vm_variant = {
>   	.get_fault_info	= exynos_sysmmu_v7_get_fault_info,
>   };
>   
> +/* SysMMU v9: VM capable register layout */
> +static const struct sysmmu_variant sysmmu_v9_vm_variant = {
> +	.pt_base        = 0x8404,
> +	.flush_all      = 0x8010,
> +	.flush_entry    = 0x8014,
> +	.flush_start    = 0x8020,
> +	.flush_end      = 0x8024,
> +	.int_status     = 0x8060,
> +	.int_clear      = 0x8064,
> +	.fault_va       = 0x8070,
> +	.fault_info     = 0x8074,
> +
> +	.get_fault_info = exynos_sysmmu_v9_get_fault_info,
> +};
> +
>   static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
>   {
>   	return container_of(dom, struct exynos_iommu_domain, domain);
> @@ -522,19 +571,26 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
>   	ver = readl(data->sfrbase + REG_MMU_VERSION);
>   
>   	/* controllers on some SoCs don't report proper version */
> +
>   	if (ver == 0x80000001u)
>   		data->version = MAKE_MMU_VER(1, 0);
>   	else
>   		data->version = MMU_RAW_VER(ver);
>   
> -	dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
> -		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
> +	if (data->version != 0x91)
> +		dev_err(data->sysmmu, "hardware version: %d.%d\n",
> +			MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
> +	else if (data->version == 0x91)
> +		dev_err(data->sysmmu, "hardware version: %d.%d\n",
> +			MMU_MAJ_VER_V9(data->version), MMU_MIN_VER_V9(data->version));

Sorry, this starts looking over-engineered. Simply split data->version 
into data->major_version and data->minor_version and fill them with 
proper values. There is no point storing them together differently for 
each hw version and then decoding in each use.


>   
> -	if (MMU_MAJ_VER(data->version) < 5) {
> +	if (data->version == 0x91) {
> +		data->variant = &sysmmu_v9_vm_variant;
> +	} else if (MMU_MAJ_VER(data->version) < 5) {
>   		data->variant = &sysmmu_v1_variant;
>   	} else if (MMU_MAJ_VER(data->version) < 7) {
>   		data->variant = &sysmmu_v5_variant;
> -	} else {
> +	} else if (MMU_MAJ_VER(data->version) < 9) {
>   		if (__sysmmu_has_capa1(data))
>   			__sysmmu_get_vcr(data);
>   		if (data->has_vcr)
> @@ -763,10 +819,9 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   	if (IS_ERR(data->pclk))
>   		return PTR_ERR(data->pclk);
>   
> -	if (!data->clk && (!data->aclk || !data->pclk)) {
> -		dev_err(dev, "Failed to get device clock(s)!\n");
> -		return -ENOSYS;
> -	}
> +	/* There is no clock information after v9 */
> +	if (!data->clk && (!data->aclk || !data->pclk))
> +		dev_warn(dev, "Failed to get device clock(s)!\n");

If there is really no separate clock to control, then check that 
explicitly instead of printing a misleading warning.

>   	data->clk_master = devm_clk_get_optional(dev, "master");
>   	if (IS_ERR(data->clk_master))

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

