Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490515A86B
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747614; cv=none; b=bhhd4LChpZUk+7Z8VOJNOusSEGa/h1PCTDaSzlOXHN81DW3eRmpUtN2gwL7fvKgpZ4Qq7QzXtSrAzIJgl7GyJib+/hP9DWze6xBvTGuH5KwcmWqrralQPDcvF/5tIstPqqg6K9Y/OZ97Z1C/0l6RWYJvytLUiUR7sccG9nk5U+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747614; c=relaxed/simple;
	bh=f8IGrdSExj5SxrMydYUhRWKz6Tj3lz9EgfUGrDsOcE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R4VIbza7XyXhF+vcPKOfkiW+RBZpN9PowKlLf6VrIdQ5L4fZzvU6QTJO9mFEctbx7RTTbWB+0mMSOhV6mYXMndYyw6Z9Nsb7SugQMH/YiwvYacSgaIINBpu9xcJcPfProJn4qOacUs8XlQS6Si9y7SpldZaSoQWVfnYVHuausVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwYfC3zmfzdZjq;
	Fri,  7 Jun 2024 16:05:23 +0800 (CST)
Received: from dggems704-chm.china.huawei.com (unknown [10.3.19.181])
	by mail.maildlp.com (Postfix) with ESMTPS id 88DE914037F;
	Fri,  7 Jun 2024 16:06:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 16:04:47 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039;
 Fri, 7 Jun 2024 09:04:45 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, jiangkunkun <jiangkunkun@huawei.com>, zhukeqian
	<zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v5 3/6] iommu/arm-smmu-v3: Add feature detection for HTTU
Thread-Topic: [PATCH v5 3/6] iommu/arm-smmu-v3: Add feature detection for HTTU
Thread-Index: AQHauBZ4GMbpI//3skeO1mpud6e6MLG7TJwAgACWzdA=
Date: Fri, 7 Jun 2024 08:04:45 +0000
Message-ID: <e4e6c50d181641d086cb3ef1d60b6732@huawei.com>
References: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
 <20240606133302.17540-4-shameerali.kolothum.thodi@huawei.com>
 <ZmJB/IjP+RVTKp/5@Asurada-Nvidia>
In-Reply-To: <ZmJB/IjP+RVTKp/5@Asurada-Nvidia>
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, June 7, 2024 12:11 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> jgg@nvidia.com; ryan.roberts@arm.com; kevin.tian@intel.com;
> mshavit@google.com; eric.auger@redhat.com; joao.m.martins@oracle.com;
> jiangkunkun <jiangkunkun@huawei.com>; zhukeqian
> <zhukeqian1@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v5 3/6] iommu/arm-smmu-v3: Add feature detection for
> HTTU
>=20
> Hi Shameer,
>=20
> Some nitpicking inline.

Thanks for taking a look Nicolin.

>=20
> On Thu, Jun 06, 2024 at 02:32:59PM +0100, Shameer Kolothum wrote:
>=20
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index e30ce55ed1af..c05a74aa52a4 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3738,6 +3738,29 @@ static void arm_smmu_device_iidr_probe(struct
> arm_smmu_device *smmu)
> >         }
> >  }
> >
> > +static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32
> reg)
>=20
> Following the other helper arm_smmu_device_iidr_probe, how about
> arm_smmu_device_httu_probe?

Hmm..I don't have any objection per se but "_get_" feels like more simple
and straightforward to me. Let me know if you feel strongly about this.
=20
> And we could pass in FIELD_GET(IDR0_HTTU, reg) too?

Same here.

>=20
> > +{
> > +       u32 fw_features =3D smmu->features & (ARM_SMMU_FEAT_HA |
> ARM_SMMU_FEAT_HD);
> > +       u32 httu =3D FIELD_GET(IDR0_HTTU, reg);
> > +       u32 features =3D 0;
>=20
> How about "hw_feats" v.s. "fw_feats"?

Ok.

>=20
> > +
> > +       switch (httu) {
> > +       case IDR0_HTTU_ACCESS_DIRTY:
> > +               features |=3D ARM_SMMU_FEAT_HD;
> > +               fallthrough;
> > +       case IDR0_HTTU_ACCESS:
> > +               features |=3D ARM_SMMU_FEAT_HA;
> > +       }
> > +
> > +       if (smmu->dev->of_node)
> > +               smmu->features |=3D features;
> > +       else if (features !=3D fw_features)
> > +               /* ACPI IORT sets the HTTU bits */
> > +               dev_warn(smmu->dev,
> > +                        "IDR0.HTTU(0x%x) overridden by FW configuratio=
n
> (0x%x)\n",
> > +                         httu, fw_features);
>=20
> httu and fw_features have different shifts -- could be odd to see:
> 	IDR0.HTTU(0x2) overridden by FW configuration (0x600000)
>=20
> FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags)
> seems
> to be overcomplicated to reference? So, how about just features?
> +			"IDR0.HTTU features (0x%x) overridden by FW
> configuration (0x%x)\n",

Yes. I think that make sense. Will change.

Thanks,
Shameer
