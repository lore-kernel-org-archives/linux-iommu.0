Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C93A260
	for <iommu@lists.linux.dev>; Wed,  5 Jun 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600924; cv=none; b=RovNMkyikFDE1cbCTdHbCp33qI3Nj/YqytoOeson7cNRqDHNeSr2YBYUl8o8I5YlkLwSNrx3au52XnEnVGIHNt2Vf8osDhnWKyqKq/DOMJzPx2h14xI0Iv9rq2Z7DI3/7b+pZIAIl4tdcU+W9M737RWEmWxBAQ/OtWbFZ8Ot3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600924; c=relaxed/simple;
	bh=1Uz2z+o3kloYqbO8y1TL1OU4KerZPW3PKRzQPalppi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jcWoGPD71rIqgDdnp7l2RfTYoi02hj/4B3eKz/nvIsboXnN7n97Soz788spAH8eP7fwOG24Yw2xbXJiBN7R93ug+gcl7hF7drQSU9hUIlxo0ZzKgvZgAxBbPgsu+YmUyUxAk++7ATdNijhSHUU5o5GegRfAom71f3cHiAFyld4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VvWLJ1WVjzsShQ;
	Wed,  5 Jun 2024 23:18:00 +0800 (CST)
Received: from dggems705-chm.china.huawei.com (unknown [10.3.19.182])
	by mail.maildlp.com (Postfix) with ESMTPS id 35B801800CB;
	Wed,  5 Jun 2024 23:21:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 23:19:12 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039;
 Wed, 5 Jun 2024 16:19:09 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "mshavit@google.com"
	<mshavit@google.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, jiangkunkun
	<jiangkunkun@huawei.com>, zhukeqian <zhukeqian1@huawei.com>, Linuxarm
	<linuxarm@huawei.com>
Subject: RE: [PATCH v4 2/7] iommu/arm-smmu-v3: Factor out a common
 arm_smmu_domain_alloc()
Thread-Topic: [PATCH v4 2/7] iommu/arm-smmu-v3: Factor out a common
 arm_smmu_domain_alloc()
Thread-Index: AQHasM+khiD4CP1qnE6UTTUODRhpdbGzXOCAgAX4qaA=
Date: Wed, 5 Jun 2024 15:19:09 +0000
Message-ID: <b459e54b6a324eb8993c6c7f37dfde06@huawei.com>
References: <20240528071831.17560-1-shameerali.kolothum.thodi@huawei.com>
 <20240528071831.17560-3-shameerali.kolothum.thodi@huawei.com>
 <ZluNbvTNlABEz0QT@nvidia.com>
In-Reply-To: <ZluNbvTNlABEz0QT@nvidia.com>
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
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, June 1, 2024 10:07 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> ryan.roberts@arm.com; kevin.tian@intel.com; nicolinc@nvidia.com;
> mshavit@google.com; eric.auger@redhat.com; joao.m.martins@oracle.com;
> jiangkunkun <jiangkunkun@huawei.com>; zhukeqian
> <zhukeqian1@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v4 2/7] iommu/arm-smmu-v3: Factor out a common
> arm_smmu_domain_alloc()
>=20
> On Tue, May 28, 2024 at 08:18:26AM +0100, Shameer Kolothum wrote:
>=20
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > @@ -648,7 +648,7 @@ static int arm_smmu_sva_set_dev_pasid(struct
> iommu_domain *domain,
> >
> >  static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
> >  {
> > -	kfree(domain);
> > +	kfree(to_smmu_domain(domain));
> >  }
>=20
>=20
> > @@ -659,13 +659,16 @@ static const struct iommu_domain_ops
> arm_smmu_sva_domain_ops =3D {
> >  struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
> >  					       struct mm_struct *mm)
> >  {
> > -	struct iommu_domain *domain;
> > +	struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> > +	struct arm_smmu_device *smmu =3D master->smmu;
> > +	struct arm_smmu_domain *smmu_domain;
> >
> > -	domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> > -	if (!domain)
> > -		return ERR_PTR(-ENOMEM);
> > -	domain->type =3D IOMMU_DOMAIN_SVA;
> > -	domain->ops =3D &arm_smmu_sva_domain_ops;
> > +	smmu_domain =3D arm_smmu_domain_alloc();
> > +	if (IS_ERR(smmu_domain))
> > +		return ERR_CAST(smmu_domain);
> > +	smmu_domain->domain.type =3D IOMMU_DOMAIN_SVA;
> > +	smmu_domain->domain.ops =3D &arm_smmu_sva_domain_ops;
> > +	smmu_domain->smmu =3D smmu;
> >
> > -	return domain;
> > +	return &smmu_domain->domain;
> >  }
>=20
> If you drop these two hunks you can drop the first patch as well. There
> is no need to touch SVA in this series

That is right. I will make those changes and re-spin soon.

Thanks,
SHameer
