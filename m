Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA737374FE
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Sgr913zmMz1FDCJ;
	Thu, 30 Nov 2023 17:13:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 17:17:18 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Thu, 30 Nov 2023 09:17:16 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, jiangkunkun <jiangkunkun@huawei.com>, zhukeqian
	<zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 2/5] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Thread-Topic: [PATCH 2/5] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Thread-Index: AQHaIeBRc93JC1IpIk+TwCcyXKVIvbCRsV0AgADmc9A=
Date: Thu, 30 Nov 2023 09:17:16 +0000
Message-ID: <aec2cd5ae55944f8ab978b3365281883@huawei.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-3-shameerali.kolothum.thodi@huawei.com>
 <20231129193050.GA436702@nvidia.com>
In-Reply-To: <20231129193050.GA436702@nvidia.com>
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
X-CFilter-Loop: Reflected



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, November 29, 2023 7:31 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> kevin.tian@intel.com; nicolinc@nvidia.com; mshavit@google.com;
> eric.auger@redhat.com; joao.m.martins@oracle.com; jiangkunkun
> <jiangkunkun@huawei.com>; zhukeqian <zhukeqian1@huawei.com>; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH 2/5] iommu/arm-smmu-v3: Enable HTTU for stage1 with i=
o-
> pgtable mapping
>=20
> On Tue, Nov 28, 2023 at 09:49:37AM +0000, Shameer Kolothum wrote:
>=20
> >  /* IOMMU API */
> >  static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
> >  {
> > @@ -2401,6 +2413,10 @@ static int arm_smmu_domain_finalise(struct
> arm_smmu_domain *smmu_domain,
> >  		.iommu_dev	=3D smmu->dev,
> >  	};
> >
> > +	if (arm_smmu_dbm_capable(smmu) &&
> > +	    smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1)
> > +		pgtbl_cfg.quirks |=3D IO_PGTABLE_QUIRK_ARM_HD;
> > +
>=20
> This flow has become a bit wonky, the switch statement right above is
> already checking S1 and partially initializing pgtbl_cfg.
>=20
> I suggest moving the pgtbl_cfg init to above the switch and making the
> switch store directly into pgtbl_cfg values and remove the stack ios
> and oas values
>=20

Got it. Will do.

Thanks,
Shameer
