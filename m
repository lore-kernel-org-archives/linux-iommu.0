Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CD579E1
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 10:34:42 +0000 (UTC)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QPv191cTFz67hqY;
	Mon, 22 May 2023 18:33:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 11:34:33 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.023;
 Mon, 22 May 2023 11:34:32 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Joao Martins <joao.m.martins@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>, Yi Y Sun
	<yi.y.sun@intel.com>, Eric Auger <eric.auger@redhat.com>, Nicolin Chen
	<nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Alex Williamson <alex.williamson@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH RFCv2 21/24] iommu/arm-smmu-v3: Enable HTTU for stage1
 with io-pgtable mapping
Thread-Topic: [PATCH RFCv2 21/24] iommu/arm-smmu-v3: Enable HTTU for stage1
 with io-pgtable mapping
Thread-Index: AQHZico50POrCq6Z9ESUTUA7KQEZ/a9mHK1Q
Date: Mon, 22 May 2023 10:34:32 +0000
Message-ID: <e16e35b399044e4f825a453e1b325e40@huawei.com>
References: <20230518204650.14541-1-joao.m.martins@oracle.com>
 <20230518204650.14541-22-joao.m.martins@oracle.com>
In-Reply-To: <20230518204650.14541-22-joao.m.martins@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-CFilter-Loop: Reflected



> -----Original Message-----
> From: Joao Martins [mailto:joao.m.martins@oracle.com]
> Sent: 18 May 2023 21:47
> To: iommu@lists.linux.dev
> Cc: Jason Gunthorpe <jgg@nvidia.com>; Kevin Tian <kevin.tian@intel.com>;
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>; Lu
> Baolu <baolu.lu@linux.intel.com>; Yi Liu <yi.l.liu@intel.com>; Yi Y Sun
> <yi.y.sun@intel.com>; Eric Auger <eric.auger@redhat.com>; Nicolin Chen
> <nicolinc@nvidia.com>; Joerg Roedel <joro@8bytes.org>; Jean-Philippe
> Brucker <jean-philippe@linaro.org>; Suravee Suthikulpanit
> <suravee.suthikulpanit@amd.com>; Will Deacon <will@kernel.org>; Robin
> Murphy <robin.murphy@arm.com>; Alex Williamson
> <alex.williamson@redhat.com>; kvm@vger.kernel.org; Joao Martins
> <joao.m.martins@oracle.com>
> Subject: [PATCH RFCv2 21/24] iommu/arm-smmu-v3: Enable HTTU for
> stage1 with io-pgtable mapping
>=20
> From: Kunkun Jiang <jiangkunkun@huawei.com>
>=20
> As nested mode is not upstreamed now, we just aim to support dirty
> log tracking for stage1 with io-pgtable mapping (means not support
> SVA mapping). If HTTU is supported, we enable HA/HD bits in the SMMU
> CD and transfer ARM_HD quirk to io-pgtable.
>=20
> We additionally filter out HD|HA if not supportted. The CD.HD bit
> is not particularly useful unless we toggle the DBM bit in the PTE
> entries.
>=20
> Link:
> https://lore.kernel.org/lkml/20210413085457.25400-6-zhukeqian1@huawei
> .com/
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> [joaomart:Convey HD|HA bits over to the context descriptor
>  and update commit message; original in Link, where this is based on]
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +++
>  drivers/iommu/io-pgtable-arm.c              | 11 +++++++++--
>  include/linux/io-pgtable.h                  |  4 ++++
>  4 files changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e110ff4710bf..e2b98a6a6b74 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1998,6 +1998,11 @@ static const struct iommu_flush_ops
> arm_smmu_flush_ops =3D {
>  	.tlb_add_page	=3D arm_smmu_tlb_inv_page_nosync,
>  };
>=20
> +static bool arm_smmu_dbm_capable(struct arm_smmu_device *smmu)
> +{
> +	return smmu->features & (ARM_SMMU_FEAT_HD |
> ARM_SMMU_FEAT_COHERENCY);
> +}
> +

This will claim DBM capability for systems with just ARM_SMMU_FEAT_COHERENC=
Y.

Thanks,
Shameer

>  /* IOMMU API */
>  static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>  {
> @@ -2124,6 +2129,8 @@ static int arm_smmu_domain_finalise_s1(struct
> arm_smmu_domain *smmu_domain,
>  			  FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
>  			  FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
>  			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
> +	if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_HD)
> +		cfg->cd.tcr |=3D CTXDESC_CD_0_TCR_HA | CTXDESC_CD_0_TCR_HD;
>  	cfg->cd.mair	=3D pgtbl_cfg->arm_lpae_s1_cfg.mair;
>=20
>  	/*
> @@ -2226,6 +2233,9 @@ static int arm_smmu_domain_finalise(struct
> iommu_domain *domain,
>  		.iommu_dev	=3D smmu->dev,
>  	};
>=20
> +	if (smmu->features & arm_smmu_dbm_capable(smmu))
> +		pgtbl_cfg.quirks |=3D IO_PGTABLE_QUIRK_ARM_HD;
> +
>  	pgtbl_ops =3D alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>  	if (!pgtbl_ops)
>  		return -ENOMEM;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index d82dd125446c..83d6f3a2554f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -288,6 +288,9 @@
>  #define CTXDESC_CD_0_TCR_IPS		GENMASK_ULL(34, 32)
>  #define CTXDESC_CD_0_TCR_TBI0		(1ULL << 38)
>=20
> +#define CTXDESC_CD_0_TCR_HA            (1UL << 43)
> +#define CTXDESC_CD_0_TCR_HD            (1UL << 42)
> +
>  #define CTXDESC_CD_0_AA64		(1UL << 41)
>  #define CTXDESC_CD_0_S			(1UL << 44)
>  #define CTXDESC_CD_0_R			(1UL << 45)
> diff --git a/drivers/iommu/io-pgtable-arm.c
> b/drivers/iommu/io-pgtable-arm.c
> index 72dcdd468cf3..b2f470529459 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -75,6 +75,7 @@
>=20
>  #define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
>  #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
> +#define ARM_LPAE_PTE_DBM		(((arm_lpae_iopte)1) << 51)
>  #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
>  #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
>  #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
> @@ -84,7 +85,7 @@
>=20
>  #define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
>  /* Ignore the contiguous bit for block splitting */
> -#define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)6) << 52)
> +#define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)13) << 51)
>  #define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK
> |	\
>  					 ARM_LPAE_PTE_ATTR_HI_MASK)
>  /* Software bit for solving coherency races */
> @@ -93,6 +94,9 @@
>  /* Stage-1 PTE */
>  #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
>  #define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)2) << 6)
> +#define ARM_LPAE_PTE_AP_RDONLY_BIT	7
> +#define ARM_LPAE_PTE_AP_WRITABLE	(ARM_LPAE_PTE_AP_RDONLY | \
> +					 ARM_LPAE_PTE_DBM)
>  #define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
>  #define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
>=20
> @@ -407,6 +411,8 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct
> arm_lpae_io_pgtable *data,
>  		pte =3D ARM_LPAE_PTE_nG;
>  		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
>  			pte |=3D ARM_LPAE_PTE_AP_RDONLY;
> +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_HD)
> +			pte |=3D ARM_LPAE_PTE_AP_WRITABLE;
>  		if (!(prot & IOMMU_PRIV))
>  			pte |=3D ARM_LPAE_PTE_AP_UNPRIV;
>  	} else {
> @@ -804,7 +810,8 @@ arm_64_lpae_alloc_pgtable_s1(struct
> io_pgtable_cfg *cfg, void *cookie)
>=20
>  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
>  			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
> -			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
> +			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
> +			    IO_PGTABLE_QUIRK_ARM_HD))
>  		return NULL;
>=20
>  	data =3D arm_lpae_alloc_pgtable(cfg);
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 25142a0e2fc2..9a996ba7856d 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -85,6 +85,8 @@ struct io_pgtable_cfg {
>  	 *
>  	 * IO_PGTABLE_QUIRK_ARM_OUTER_WBWA: Override the
> outer-cacheability
>  	 *	attributes set in the TCR for a non-coherent page-table walker.
> +	 *
> +	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking.
>  	 */
>  	#define IO_PGTABLE_QUIRK_ARM_NS			BIT(0)
>  	#define IO_PGTABLE_QUIRK_NO_PERMS		BIT(1)
> @@ -92,6 +94,8 @@ struct io_pgtable_cfg {
>  	#define IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT	BIT(4)
>  	#define IO_PGTABLE_QUIRK_ARM_TTBR1		BIT(5)
>  	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
> +	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
> +
>  	unsigned long			quirks;
>  	unsigned long			pgsize_bitmap;
>  	unsigned int			ias;
> --
> 2.17.2

