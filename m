Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9718D647
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727036; cv=none; b=pM/BE3mnvJz/hnAbYF6i7yipl9GDhPgW/IfdRJ1imPqJwrGEJF4/jjAU4k4Ni/5oAqMx2vxccXbX9tGUk5YfGzt0OydBJgyCW+Voh8ioWl8B3okKeElZov0be/RA0ZsBaqaC5MFXH+cWA04bfcBd8NHRKQ8pE2Lf+jwSfqarlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727036; c=relaxed/simple;
	bh=x9o4Z9egIeMfXj7TtgkdZQCXnCjreD361HEnOwUrCEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TWHtdrABSaUg8mRN8ag8mDbyAMjXJpJq42QQtgMoXJkJkmxKnNAfDD0nTs38A8vtd71ldvCWjPv8qWHkOfC2iDi2Kr1IVZsxDxikurRC6GgGhnHWFrijkJ2KhjC5Y8MnLRrEq1JF5CCt54flpRs1bvc/GlyeIvg1icVkwaCbog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wl4xd4jCQz6K98G;
	Thu, 15 Aug 2024 21:01:09 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
	by mail.maildlp.com (Postfix) with ESMTPS id B00F0140B73;
	Thu, 15 Aug 2024 21:03:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 14:03:50 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039;
 Thu, 15 Aug 2024 14:03:50 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
	<nicolinc@nvidia.com>, Michael Shavit <mshavit@google.com>, Mostafa Saleh
	<smostafa@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] iommu/arm-smmu-v3: Fix a NULL vs IS_ERR() check
Thread-Topic: [PATCH] iommu/arm-smmu-v3: Fix a NULL vs IS_ERR() check
Thread-Index: AQHa7wXNPo+CG2I9vkChFeAuisDOE7IoSPZg
Date: Thu, 15 Aug 2024 13:03:50 +0000
Message-ID: <cc6b31a1cb334ecf8458e888d66e362a@huawei.com>
References: <9208cd0d-8105-40df-93e9-bdcdf0d55eec@stanley.mountain>
In-Reply-To: <9208cd0d-8105-40df-93e9-bdcdf0d55eec@stanley.mountain>
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
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Thursday, August 15, 2024 12:25 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Will Deacon <will@kernel.org>; Robin Murphy
> <robin.murphy@arm.com>; Joerg Roedel <joro@8bytes.org>; Jason
> Gunthorpe <jgg@ziepe.ca>; Nicolin Chen <nicolinc@nvidia.com>; Michael
> Shavit <mshavit@google.com>; Mostafa Saleh <smostafa@google.com>; Lu
> Baolu <baolu.lu@linux.intel.com>; Kevin Tian <kevin.tian@intel.com>; linu=
x-
> arm-kernel@lists.infradead.org; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] iommu/arm-smmu-v3: Fix a NULL vs IS_ERR() check
>=20
> The arm_smmu_domain_alloc() function returns error pointers on error.  It
> doesn't return NULL.  Update the error checking to match.
>=20
> Fixes: 52acd7d8a413 ("iommu/arm-smmu-v3: Add support for
> domain_alloc_user fn")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Thanks,
Shameer
