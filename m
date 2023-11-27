Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33AE2D623
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sf9Xq3Fmfz6JBR6;
	Tue, 28 Nov 2023 00:10:19 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id B49E9140C98;
	Tue, 28 Nov 2023 00:10:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 Nov 2023 16:10:33 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Mon, 27 Nov 2023 16:10:33 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
CC: Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 00/19] Update SMMUv3 to the modern iommu API (part 1/3)
Thread-Topic: [PATCH v2 00/19] Update SMMUv3 to the modern iommu API (part
 1/3)
Thread-Index: AQHaFlpcboVCOVh91k2mJ0kS0C1kaLCOZrqw
Date: Mon, 27 Nov 2023 16:10:33 +0000
Message-ID: <daa2f15d7f6b475d8388cbea7a9f4cb5@huawei.com>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0



> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> Sent: 13 November 2023 17:53
> To: iommu@lists.linux.dev; Joerg Roedel <joro@8bytes.org>;
> linux-arm-kernel@lists.infradead.org; Robin Murphy
> <robin.murphy@arm.com>; Will Deacon <will@kernel.org>
> Cc: Michael Shavit <mshavit@google.com>; Nicolin Chen
> <nicolinc@nvidia.com>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> Subject: [PATCH v2 00/19] Update SMMUv3 to the modern iommu API (part
> 1/3)
>=20
> The SMMUv3 driver was originally written in 2015 when the iommu driver
> facing API looked quite different. The API has evolved, especially lately=
,
> and the driver has fallen behind.
>=20
> This work aims to bring make the SMMUv3 driver the best IOMMU driver
> with
> the most comprehensive implementation of the API. After all parts it
> addresses:
>=20
>  - Global static BLOCKED and IDENTITY domains with 'never fail' attach
>    semantics. BLOCKED is desired for efficient VFIO.
>=20
>  - Support map before attach for PAGING iommu_domains.
>=20
>  - attach_dev failure does not change the HW configuration.
>=20
>  - Fully hitless transitions between IDENTITY -> DMA -> IDENTITY.
>    The API has IOMMU_RESV_DIRECT which is expected to be
>    continuously translating.
>=20
>  - Safe transitions between PAGING -> BLOCKED, do not ever temporarily
>    do IDENTITY. This is required for iommufd security.
>=20
>  - Full PASID API support including:
>     - S1/SVA domains attached to PASIDs
>     - IDENTITY/BLOCKED/S1 attached to RID
>     - Change of the RID domain while PASIDs are attached
>=20
>  - Streamlined SVA support using the core infrastructure
>=20
>  - Hitless, whenever possible, change between two domains
>=20
>  - iommufd IOMMU_GET_HW_INFO, IOMMU_HWPT_ALLOC_NEST_PARENT,
> and
>    IOMMU_DOMAIN_NESTED support
>=20
> Over all these things are going to become more accessible to iommufd, and
> exposed to VMs, so it is important for the driver to have a robust
> implementation of the API.
>=20
> The work is split into three parts, with this part largely focusing on th=
e
> STE and building up to the BLOCKED & IDENTITY global static domains.
>=20
> The second part largely focuses on the CD and builds up to having a commo=
n
> PASID infrastructure that SVA and S1 domains equally use.
>=20
> The third part has some random cleanups and the iommufd related parts.
>=20
> Overall this takes the approach of turning the STE/CD programming upside
> down where the CD/STE value is computed right at a driver callback
> function and then pushed down into programming logic. The programming
> logic hides the details of the required CD/STE tear-less update. This
> makes the CD/STE functions independent of the arm_smmu_domain which
> makes
> it fairly straightforward to untangle all the different call chains, and
> add news ones.
>=20
> Further, this frees the arm_smmu_domain related logic from keeping track
> of what state the STE/CD is currently in so it can carefully sequence the
> correct update. There are many new update pairs that are subtly introduce=
d
> as the work progresses.
>=20
> The locking to support BTM via arm_smmu_asid_lock is a bit subtle right
> now and patches throughout this work adjust and tighten this so that it i=
s
> clearer and doesn't get broken.
>=20
> Once the lower STE layers no longer need to touch arm_smmu_domain we
> can
> isolate struct arm_smmu_domain to be only used for PAGING domains, audit
> all the to_smmu_domain() calls to be only in PAGING domain ops, and
> introduce the normal global static BLOCKED/IDENTITY domains using the
> new
> STE infrastructure. Part 2 will ultimately migrate SVA over to use
> arm_smmu_domain as well.
>=20
> All parts are on github:
>=20
>  https://github.com/jgunthorpe/linux/commits/smmuv3_newapi

Hi Jason,

I had a go with the above branch on our HiSilicon D06 board(SMMUv3).

Basically covered the following functionality test runs:
-Host kernel: boot with DOMAIN_DMA.
-Host kernel: boot with DOMAIN_IDENTITY.
-Host kernel: ACC dev SVA test run with uadk/uadk_tool benchmark.

And with Qemu branch: https://github.com/yiliu1765/qemu/tree/zhenzhong/iomm=
ufd_cdev_v7

-Guest boot with a n/w VF dev assigned, legacy VFIO mode.
-Guest boot with a n/w VF dev assigned, IOMMUFD mode.
-Device Hot plug(add/del) on both VFIO and IOMMUFD modes.

All the tests seems to be fine so far.

FWIW:
Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Thanks,
Shameer

