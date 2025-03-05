Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B5E1FCF4F
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165305; cv=none; b=dylo90DfIyz2w7k2DCdtmJSs70qi8mRQXZyIpj0RfIaFfii66dhvo1Ijyf57NUO3yBoC06J7XGFZ7KVi1ALDxIxjBzXqO4LCCW5NxpkRSnBFYGUKu1MgHiitSNJpLe9Y2buW9juWOolY4lyJSOqAb+ElmIposreqNWw5YEHa1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165305; c=relaxed/simple;
	bh=uP/SEkCzYTQjIt8VzhDbROc2ozcbQU/gyoGZ8KY3o+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IxujyoZtyvkonzkZ/rcx5tarM+dT/IVggB3lHnKtm2YOAhbHilAXezX3dMj2R0W21J170DQBDAhN8oVtek4UVlCpTvn5NXJIRDS6UWYjDLmw3HarIwknZDDOb3366Zo+D6OgfWZfhBteju2suUkAiOHgsF9a3rotLdcS9XZwZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z761V0THHz6K9SH;
	Wed,  5 Mar 2025 16:59:26 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id F119A140A08;
	Wed,  5 Mar 2025 17:01:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:01:40 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 5 Mar 2025 10:01:40 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 4/4] iommu/arm-smmu-v3-iommufd: Allow a shared
 s2_parent to allocate vSMMU
Thread-Topic: [PATCH v1 4/4] iommu/arm-smmu-v3-iommufd: Allow a shared
 s2_parent to allocate vSMMU
Thread-Index: AQHbjYw+IgurA9LM5k6RyZlCF36C1bNkPq7A
Date: Wed, 5 Mar 2025 09:01:40 +0000
Message-ID: <1b51a7f7bfc0419b8941cf7ee0601b70@huawei.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <564eda8dee4bbf4c6e1d1dd9ed6bd40cc1a2df26.1741150594.git.nicolinc@nvidia.com>
In-Reply-To: <564eda8dee4bbf4c6e1d1dd9ed6bd40cc1a2df26.1741150594.git.nicolinc@nvidia.com>
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
> Sent: Wednesday, March 5, 2025 5:04 AM
> To: will@kernel.org; robin.murphy@arm.com; jgg@nvidia.com
> Cc: joro@8bytes.org; linux-arm-kernel@lists.infradead.org;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; Shameerali Kolothum
> Thodi <shameerali.kolothum.thodi@huawei.com>
> Subject: [PATCH v1 4/4] iommu/arm-smmu-v3-iommufd: Allow a shared
> s2_parent to allocate vSMMU
>=20
> Now, vmids are stored in vSMMU objects. So all vSMMUs assigned to the
> same
> VM can share a s2_parent domain. This means a vIOMMU allocation per
> device
> behind one SMMU can be given with a s2_parent domain that's allocated
> per
> another device behind another SMMU, i.e. s2_parent->smmu !=3D master-
> >smmu.
>=20
> Remove the validation line to allow this use case.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 2c5a9d0abed5..9bfa5fa5bafa 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -378,9 +378,6 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct
> device *dev,
>  	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
>  		return ERR_PTR(-EOPNOTSUPP);
>=20
> -	if (s2_parent->smmu !=3D master->smmu)
> -		return ERR_PTR(-EINVAL);
> -

Not sure we can just relax this like this. What if the two physical SMMUs a=
re different in
functionality/features? Do we need some kind of sanity check here?

Thanks,
Shameer

