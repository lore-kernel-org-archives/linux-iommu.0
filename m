Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605861C694
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389567; cv=none; b=oFkh8oXDU4VIc2VQSQTk8+Z6BdHzQQGJqCfN6W3lvgeTGG0+1QxaatvxJdRL8iRshXNDt9MPhZX3o5rrHEfVCQH9hNZXP5BOBiQ62752Y79x1oS7AQX2G4CfEUeVqIBzN6UZubQYYhaBKcXB4AmZXfBh9eao7mvhbbJUaMKCaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389567; c=relaxed/simple;
	bh=XgV4pz/MdGo5lajqyuck0iI6Q/ZHNxb4E0FoIeJn7pw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OLQqR//3a3iEJqWxyYWXIvWwZoC/7bKDoYeXsJYjNprP9kSWDCOfFPsy/NI6Hiht0O/AAadcSe9qerAVmwPXyDieurr9tUqFNAMyeZicNGc6ibeAMMvcImeGYeleF72/lMvULgF89nJHUTFUGvN6KV2hkNBknpttjQbtOfRc3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Vkty32rtwzPmPL;
	Wed, 22 May 2024 22:30:35 +0800 (CST)
Received: from dggems704-chm.china.huawei.com (unknown [10.3.19.181])
	by mail.maildlp.com (Postfix) with ESMTPS id A38FA140427;
	Wed, 22 May 2024 22:33:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 22:30:21 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039;
 Wed, 22 May 2024 15:30:19 +0100
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
Subject: RE: [PATCH v3 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Thread-Topic: [PATCH v3 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Thread-Index: AQHamwTfifKAfWhiFEa5EoLec24A7bGi6R6AgACHNiA=
Date: Wed, 22 May 2024 14:30:19 +0000
Message-ID: <d08fcd087e9541a2a77733ec52ff931a@huawei.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-4-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB52765EF502C246B4C344CE888CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB52765EF502C246B4C344CE888CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
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
> Sent: Wednesday, May 22, 2024 8:16 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> Cc: robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> jgg@nvidia.com; ryan.roberts@arm.com; nicolinc@nvidia.com;
> mshavit@google.com; eric.auger@redhat.com; joao.m.martins@oracle.com;
> jiangkunkun <jiangkunkun@huawei.com>; zhukeqian
> <zhukeqian1@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: RE: [PATCH v3 3/4] iommu/arm-smmu-v3: Add support for dirty trac=
king
> in domain alloc
>=20
> > From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > Sent: Tuesday, April 30, 2024 9:43 PM
> >
> > @@ -2422,31 +2425,32 @@ static int arm_smmu_domain_finalise(struct
> > arm_smmu_domain *smmu_domain,
> >  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
> >  		smmu_domain->stage =3D ARM_SMMU_DOMAIN_S1;
> >
> > +	pgtbl_cfg =3D (struct io_pgtable_cfg) {
> > +		.pgsize_bitmap	=3D smmu->pgsize_bitmap,
> > +		.coherent_walk	=3D smmu->features &
> > ARM_SMMU_FEAT_COHERENCY,
> > +		.tlb		=3D &arm_smmu_flush_ops,
> > +		.iommu_dev	=3D smmu->dev,
> > +	};
> > +
> >  	switch (smmu_domain->stage) {
> >  	case ARM_SMMU_DOMAIN_S1:
> > -		ias =3D (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
> > -		ias =3D min_t(unsigned long, ias, VA_BITS);
> > -		oas =3D smmu->ias;
> > +		unsigned long ias =3D (smmu->features &
> > +				     ARM_SMMU_FEAT_VAX) ? 52 : 48;
> > +		pgtbl_cfg.ias =3D min_t(unsigned long, ias, VA_BITS);
> > +		pgtbl_cfg.oas =3D smmu->ias;
> > +		if (enable_dirty)
> > +			pgtbl_cfg.quirks |=3D IO_PGTABLE_QUIRK_ARM_HD;
>=20
> why is dirty tracking considered as a quirk?

Yes, that is a bit unconventional. But this was discussed earlier and in SM=
MUv3=20
driver the word "quirk" is considered in the broadest sense and there are
precedent for this in the driver already.

From Robin:

"Indeed these features aren't decorative grooves on a piece of furniture,=20
but in the case of io-pgtable we're merely using "quirk" in its broadest=20
sense to imply something that differs from the baseline default=20
behaviour - ARM_MTK_EXT, ARM_TTBR1 and ARM_OUTER_WBWA (or whatever it's=20
called this week) are all just indicating extra hardware features=20
entirely comparable to HTTU;..."

https://lore.kernel.org/linux-iommu/5ada4a8b-8852-f83c-040a-9ef5dac51de2@ar=
m.com/

>=20
> >  		fmt =3D ARM_64_LPAE_S1;
> >  		break;
> >  	case ARM_SMMU_DOMAIN_S2:
> > -		ias =3D smmu->ias;
> > -		oas =3D smmu->oas;
> > +		pgtbl_cfg.ias =3D smmu->ias;
> > +		pgtbl_cfg.oas =3D smmu->oas;
> >  		fmt =3D ARM_64_LPAE_S2;
> >  		break;
>=20
> so dirty-tracking is not supported by s2? what about nesting?

It will be added later when we have the nested support.
=20
> if this is desired then attempting to set dirty_tracking on a s2 domain
> should be rejected with an error.

Ok. I will add that.

Thanks,
Shameer

