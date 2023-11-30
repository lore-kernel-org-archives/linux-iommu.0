Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810B168BD
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Sgqx60g8Mz17MKq;
	Thu, 30 Nov 2023 17:03:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 17:05:31 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Thu, 30 Nov 2023 09:05:29 +0000
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
Subject: RE: [PATCH 3/5] iommu/arm-smmu-v3: Add read_and_clear_dirty() support
Thread-Topic: [PATCH 3/5] iommu/arm-smmu-v3: Add read_and_clear_dirty()
 support
Thread-Index: AQHaIeBW6UH91H0G8kmtzlEDGUzUpLCRso4AgADiScA=
Date: Thu, 30 Nov 2023 09:05:29 +0000
Message-ID: <acdd6b446d164d52957f436964d46de1@huawei.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-4-shameerali.kolothum.thodi@huawei.com>
 <20231129193506.GB436702@nvidia.com>
In-Reply-To: <20231129193506.GB436702@nvidia.com>
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
> Sent: Wednesday, November 29, 2023 7:35 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> kevin.tian@intel.com; nicolinc@nvidia.com; mshavit@google.com;
> eric.auger@redhat.com; joao.m.martins@oracle.com; jiangkunkun
> <jiangkunkun@huawei.com>; zhukeqian <zhukeqian1@huawei.com>; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH 3/5] iommu/arm-smmu-v3: Add read_and_clear_dirty()
> support
>=20
> On Tue, Nov 28, 2023 at 09:49:38AM +0000, Shameer Kolothum wrote:
>=20
> > +static int arm_smmu_read_and_clear_dirty(struct iommu_domain *domain,
> > +					 unsigned long iova, size_t size,
> > +					 unsigned long flags,
> > +					 struct iommu_dirty_bitmap *dirty)
> > +{
> > +	struct arm_smmu_domain *smmu_domain =3D
> to_smmu_domain(domain);
> > +	struct io_pgtable_ops *ops =3D smmu_domain->pgtbl_ops;
> > +	int ret;
> > +
> > +	if (smmu_domain->stage !=3D ARM_SMMU_DOMAIN_S1)
> > +		return -EINVAL;
> > +
> > +	if (!ops || !ops->read_and_clear_dirty) {
> > +		pr_err_once("io-pgtable don't support dirty tracking\n");
> > +		return -ENODEV;
>=20
> All these prints concern me, either these can never happen due to
> constraints on the caller, eg iommufd, in which case use WARN_ON_ONCe
>=20
> Or iommufd does allow these improper things and thus it should
> silently fail.
>=20
Ok. Will revisit these for next revision.

Thanks,
Shameer
