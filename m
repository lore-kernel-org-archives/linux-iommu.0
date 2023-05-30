Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFC12106F
	for <iommu@lists.linux.dev>; Tue, 30 May 2023 14:10:15 +0000 (UTC)
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QVvPC2ZFtz67blC;
	Tue, 30 May 2023 22:07:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 15:10:06 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.023;
 Tue, 30 May 2023 15:10:06 +0100
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
Subject: RE: [PATCH RFCv2 24/24] iommu/arm-smmu-v3: Advertise
 IOMMU_DOMAIN_F_ENFORCE_DIRTY
Thread-Topic: [PATCH RFCv2 24/24] iommu/arm-smmu-v3: Advertise
 IOMMU_DOMAIN_F_ENFORCE_DIRTY
Thread-Index: AQHZicpBslUZ4SR8FEqbgFGqVge/dq9y6VZw
Date: Tue, 30 May 2023 14:10:06 +0000
Message-ID: <244a1a22766e4b46b75a74d202254b0d@huawei.com>
References: <20230518204650.14541-1-joao.m.martins@oracle.com>
 <20230518204650.14541-25-joao.m.martins@oracle.com>
In-Reply-To: <20230518204650.14541-25-joao.m.martins@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.126.175.64]
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
> Subject: [PATCH RFCv2 24/24] iommu/arm-smmu-v3: Advertise
> IOMMU_DOMAIN_F_ENFORCE_DIRTY
>=20
> Now that we probe, and handle the DBM bit modifier, unblock
> the kAPI usage by exposing the IOMMU_DOMAIN_F_ENFORCE_DIRTY
> and implement it's requirement of revoking device attachment
> in the iommu_capable. Finally expose the IOMMU_CAP_DIRTY to
> users (IOMMUFD_DEVICE_GET_CAPS).
>=20
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index bf0aac333725..71dd95a687fd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2014,6 +2014,8 @@ static bool arm_smmu_capable(struct device *dev,
> enum iommu_cap cap)
>  		return master->smmu->features &
> ARM_SMMU_FEAT_COHERENCY;
>  	case IOMMU_CAP_NOEXEC:
>  		return true;
> +	case IOMMU_CAP_DIRTY:
> +		return arm_smmu_dbm_capable(master->smmu);
>  	default:
>  		return false;
>  	}
> @@ -2430,6 +2432,11 @@ static int arm_smmu_attach_dev(struct
> iommu_domain *domain, struct device *dev)
>  	master =3D dev_iommu_priv_get(dev);
>  	smmu =3D master->smmu;
>=20
> +	if (domain->flags & IOMMU_DOMAIN_F_ENFORCE_DIRTY &&
> +	    !arm_smmu_dbm_capable(smmu))
> +		return -EINVAL;
> +
> +

Since we have the supported_flags always set to " IOMMU_DOMAIN_F_ENFORCE_DI=
RTY"
below, platforms that doesn't have DBM capability will fail here, right? Or=
 the idea is to set
domain flag only if the capability is reported true? But the iommu_domain_s=
et_flags() doesn't
seems to check the capability though.=20

(This seems to be causing problem with a rebased Qemu branch for ARM I have=
 while sanity
testing on a platform that doesn't have DBM. I need to double check though)=
.

Thanks,
Shameer

  =20
>  	/*
>  	 * Checking that SVA is disabled ensures that this device isn't bound t=
o
>  	 * any mm, and can be safely detached from its old domain. Bonds
> cannot
> @@ -2913,6 +2920,7 @@ static void arm_smmu_remove_dev_pasid(struct
> device *dev, ioasid_t pasid)
>  }
>=20
>  static struct iommu_ops arm_smmu_ops =3D {
> +	.supported_flags	=3D IOMMU_DOMAIN_F_ENFORCE_DIRTY,
>  	.capable		=3D arm_smmu_capable,
>  	.domain_alloc		=3D arm_smmu_domain_alloc,
>  	.probe_device		=3D arm_smmu_probe_device,
> --
> 2.17.2

