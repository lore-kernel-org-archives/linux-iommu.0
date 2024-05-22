Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE361E49F
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386610; cv=none; b=eTzJygx6G9p4kQGTroJhSenlnPiLytt+QBdd4mKdrE/CUJvldvjlgRTkYlly1ZVTpLH9foBkTWqXDoe7J+sXhJ3H/dxbrHV7BK1xTzEUNs0ovpvtkVPjQgGlUJgkoFndqqwp9Yi+s+ydqcA6RPjY/ovHj5sSbl9MqlMhxUzHFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386610; c=relaxed/simple;
	bh=T72HAX3jbHcynWpGPOFlk62PaAnZnsiXB9uf5fiBMiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HUmMBk5uzsZZOlxhnkSEznZIrEtDWzIMxei8x8wqGrGHSQSwdEbzUR7IAPHZZM2tGxyIOiEqCGUz14WwziEFG1839Mw/UvA7zaLh8QdEMg6P1g0IgdWaat0wVefU2ulUTUZ3bBWSB/CvO1gf28UT87Ns2OQpPgYZb4aK33xaOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VktKB2gT4zcjD6;
	Wed, 22 May 2024 22:02:06 +0800 (CST)
Received: from dggems703-chm.china.huawei.com (unknown [10.3.19.180])
	by mail.maildlp.com (Postfix) with ESMTPS id 07470180070;
	Wed, 22 May 2024 22:03:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 22:03:22 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039;
 Wed, 22 May 2024 15:03:20 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "mshavit@google.com"
	<mshavit@google.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, jiangkunkun
	<jiangkunkun@huawei.com>, zhukeqian <zhukeqian1@huawei.com>, Linuxarm
	<linuxarm@huawei.com>
Subject: RE: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Thread-Topic: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Thread-Index: AQHamwTYcB87crbtOk2Rfptbt6wAgbGi6ACAgAB7wVA=
Date: Wed, 22 May 2024 14:03:20 +0000
Message-ID: <13e93238f21b42539097d7e347be684e@huawei.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
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
> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Wednesday, May 22, 2024 8:12 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> Cc: robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> jgg@nvidia.com; ryan.roberts@arm.com; nicolinc@nvidia.com;
> mshavit@google.com; eric.auger@redhat.com; joao.m.martins@oracle.com;
> jiangkunkun <jiangkunkun@huawei.com>; zhukeqian
> <zhukeqian1@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: RE: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirt=
y()
> support
>=20
> > From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > Sent: Tuesday, April 30, 2024 9:43 PM
> >
> > @@ -92,7 +93,11 @@
> >
> >  /* Stage-1 PTE */
> >  #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
> > -#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)2) << 6)
> > +#define ARM_LPAE_PTE_AP_RDONLY_BIT	7
> > +#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)1) << \
> > +					   ARM_LPAE_PTE_AP_RDONLY_BIT)
> > +#define ARM_LPAE_PTE_AP_WRITABLE_CLEAN
> > 	(ARM_LPAE_PTE_AP_RDONLY | \
> > +					 ARM_LPAE_PTE_DBM)
>=20
> based on the usage is it clearer to be xxx_WRITEABLE_MASK?

I think in patch 4 we use this to set the PTE Writeable Clean. Anyway I wil=
l
revisit this following Jason's comment on just setting the DBM bit there.

>=20
> >  #define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
> >  #define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
> >
> > @@ -138,6 +143,9 @@
> >
> >  #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
> >
> > +#define iopte_hw_dirty(pte)	(((pte) &
> > ARM_LPAE_PTE_AP_WRITABLE_CLEAN) =3D=3D \
> > +				   ARM_LPAE_PTE_DBM)
> > +
>=20
> iopte_is_writeable_dirty()?
>=20
> and the following "set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT,
> (unsigned long *)ptep);" could be wrapped as:
>=20
> 	iopte_set_writable_clean(ptep);

Ok. Will consider this during respin.
=20
> > +
> > +static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
> > +					 unsigned long iova, size_t size,
> > +					 unsigned long flags,
> > +					 struct iommu_dirty_bitmap *dirty)
> > +{
> > +	struct arm_lpae_io_pgtable *data =3D io_pgtable_ops_to_data(ops);
> > +	struct io_pgtable_cfg *cfg =3D &data->iop.cfg;
> > +	struct io_pgtable_walk_data walk_data =3D {
> > +		.dirty =3D dirty,
> > +		.flags =3D flags,
> > +		.addr =3D iova,
> > +		.end =3D iova + size,
> > +	};
> > +	arm_lpae_iopte *ptep =3D data->pgd;
> > +	int lvl =3D data->start_level;
> > +
> > +	if (WARN_ON(!size))
> > +		return -EINVAL;
> > +	if (WARN_ON((iova + size - 1) & ~(BIT(cfg->ias) - 1)))
> > +		return -EINVAL;
> > +	if (data->iop.fmt !=3D ARM_64_LPAE_S1)
> > +		return -EINVAL;
> > +
> > +	return __arm_lpae_iopte_walk_dirty(data, &walk_data, ptep, lvl);
>=20
> Intel/AMD drivers also checks:
>=20
>         if (!dmar_domain->dirty_tracking && dirty->bitmap)
>                 return -EINVAL;

Is that really required? Is the concern here is user may issue
GET_DIRTY_BITMAP IOCTL without any validation and that may
result in unnecessary scanning of page tables? May be we should
handle it in core code then I think.

Thanks,
Shameer


