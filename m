Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2759442F
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384453; cv=none; b=U2zv0w72IWQb4FwU0NaMXHXryLhEBCKV4AtCJyS/cd+4Y38VQl9m8Duk9iGd8xYy7XoLTEvXe7lv9Dh3a5qwoNddCeWnL96/wlFGjJixDSH0OgpCAqkhmd73Z3DjU8n1TOw8Oj1AVok2hV3SWyVBN1JKNN12EGQeUm152fmcNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384453; c=relaxed/simple;
	bh=IewUF/eBLpepM9Sas9JNt7+EV9BxNGHjGQixZJXAim4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O8LOwuwRy6PbtARqml8ednUJkMoaqWv3wBY7OwwI/n5EgQ7an93zVtzwpgXmLx6x2OmWTVNF3ZE7TsdQ8sVaG9zYACGTh/dlyp0+q52I8j28g0Vo9KXV2h+KYwtLcWBytFKKfIYqNdXC2W8wz11e5XTneOZspOX+eL1vvEd9r+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VksSx0YGPzxPmd;
	Wed, 22 May 2024 21:23:45 +0800 (CST)
Received: from dggems701-chm.china.huawei.com (unknown [10.3.19.178])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EA5F180070;
	Wed, 22 May 2024 21:27:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 21:26:23 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039;
 Wed, 22 May 2024 14:26:21 +0100
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
Subject: RE: [PATCH v3 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Thread-Topic: [PATCH v3 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Thread-Index: AQHamwThMu7b7TneXEy+tpkYg8efUbGTg3mAgA/bbNA=
Date: Wed, 22 May 2024 13:26:20 +0000
Message-ID: <3d0aa20bbb97452cb78b3bb94af24ebd@huawei.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-5-shameerali.kolothum.thodi@huawei.com>
 <ZkCxTWbkK0Domuwr@nvidia.com>
In-Reply-To: <ZkCxTWbkK0Domuwr@nvidia.com>
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
> Sent: Sunday, May 12, 2024 1:09 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> ryan.roberts@arm.com; kevin.tian@intel.com; nicolinc@nvidia.com;
> mshavit@google.com; eric.auger@redhat.com; joao.m.martins@oracle.com;
> jiangkunkun <jiangkunkun@huawei.com>; zhukeqian
> <zhukeqian1@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v3 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1
> with io-pgtable mapping
>=20
> On Tue, Apr 30, 2024 at 02:43:08PM +0100, Shameer Kolothum wrote:
>=20
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-
> arm.c
> > index da6cc52859ba..20ac0e833c7b 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -433,6 +433,8 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct
> arm_lpae_io_pgtable *data,
> >  		pte =3D ARM_LPAE_PTE_nG;
> >  		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> >  			pte |=3D ARM_LPAE_PTE_AP_RDONLY;
> > +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_HD)
> > +			pte |=3D ARM_LPAE_PTE_AP_WRITABLE_CLEAN;
>=20
> This seems a bit suboptimal, it means the HTTU will be generating
> dirty's before the tracking is turned on. As I understand it if the
> SMMU wants to write a dirty bit it has to do an atomic RMW to memory,
> so this would be a drag on baseline performance?

Our initial tests has not shown any difference so far. But it is a possibil=
ity.
=20
> Should this start out as dirty and let the enable flow clean it to
> turn it on?

Ok. Just to be clear, so the suggestion is just set the DBM bit here and le=
t the
read_and_clear_dirty() set the  AP_RDONLY_BIT through the iopt_set_dirty_tr=
acking()
path.

>=20
> Looks fine otherwise:
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Shameer
