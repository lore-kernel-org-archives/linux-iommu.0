Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016B30FBA
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Sgqsc3yRJz1L99B;
	Thu, 30 Nov 2023 17:00:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 17:01:31 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Thu, 30 Nov 2023 09:01:30 +0000
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
Subject: RE: [PATCH 5/5] iommu/arm-smmu-v3: Enforce dirty tracking in domain
 attach/alloc
Thread-Topic: [PATCH 5/5] iommu/arm-smmu-v3: Enforce dirty tracking in domain
 attach/alloc
Thread-Index: AQHaIeBhbjwQvTzWckukoTe4aRA5yLCRtmUAgADdCCA=
Date: Thu, 30 Nov 2023 09:01:29 +0000
Message-ID: <eea35935ad164a9cb65d0c0cbda5d464@huawei.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-6-shameerali.kolothum.thodi@huawei.com>
 <20231129194850.GD436702@nvidia.com>
In-Reply-To: <20231129194850.GD436702@nvidia.com>
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
> Sent: Wednesday, November 29, 2023 7:49 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> kevin.tian@intel.com; nicolinc@nvidia.com; mshavit@google.com;
> eric.auger@redhat.com; joao.m.martins@oracle.com; jiangkunkun
> <jiangkunkun@huawei.com>; zhukeqian <zhukeqian1@huawei.com>; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH 5/5] iommu/arm-smmu-v3: Enforce dirty tracking in dom=
ain
> attach/alloc
>=20
> On Tue, Nov 28, 2023 at 09:49:40AM +0000, Shameer Kolothum wrote:
> > @@ -2701,6 +2703,9 @@ static int arm_smmu_attach_dev(struct
> iommu_domain *domain, struct device *dev)
> >  	master =3D dev_iommu_priv_get(dev);
> >  	smmu =3D master->smmu;
> >
> > +	if (domain->dirty_ops && !arm_smmu_dbm_capable(smmu))
> > +		return -EINVAL;
> > +
>=20
> This is not necessary, a domain can be attached to a single smmu and
> finalize was run on that smmu already. So dirty ops should only be set
> if this is a S1 domain finalized ona smmu that was dbm capable.
>=20
> Otherwise none of this makes any sense.
>=20
> > @@ -3104,6 +3115,9 @@ arm_smmu_domain_alloc_user(struct device *dev,
> u32 flags,
> >
> >  	smmu_domain->domain.type =3D IOMMU_DOMAIN_UNMANAGED;
> >  	smmu_domain->domain.ops =3D arm_smmu_ops.default_domain_ops;
> > +	if (enforce_dirty)
> > +		smmu_domain->domain.dirty_ops =3D &arm_smmu_dirty_ops;
>=20
> Ah, this seems in the wrong place, perhaps that is the confusion
> everywhere?
>=20
> If the finalize actually enables dirty tracking in the pgtbl_ops then
> it should set the diryty_ops, they should not be set in alloc_user.
>=20
> Specifically, a S2 domain should never have dirty_ops set.
>=20
> IOW if domain.dirty_ops !=3D NULL then pgtbl_ops !=3D NULL && pgtbl_ops-
> >read_and_clear_dirty
>=20
> Thus no need to have all the other prints/etc then.
>=20
> So I'd move this into finalize.

Ok. Make sense. I will move it.

>=20
> > @@ -4152,11 +4166,13 @@ static void arm_smmu_get_httu(struct
> arm_smmu_device *smmu, u32 reg)
> >
> >  	if (smmu->dev->of_node)
> >  		smmu->features |=3D features;
> > -	else if (features !=3D fw_features)
> > +	else if (features !=3D fw_features) {
> >  		/* ACPI IORT sets the HTTU bits */
> >  		dev_warn(smmu->dev,
> > -			 "IDR0.HTTU overridden by FW configuration (0x%x)\n",
> > +			 "IDR0.HTTU not overridden by FW configuration
> (0x%x)\n",
> >  			 fw_features);
> > +		smmu->features |=3D features;
> > +	}
> >  }
>=20
> Is this hunk misplaced?

Oops... My bad. Added for testing.=20

Thanks,
Shameer
