Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D60442F
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384509; cv=none; b=Nj/ACNxnYPyDVvNvvRZlgvJWIMaKflIfr7fvigI9z4mNC+qB7U9k3DBE13NeekCk9aJGU2z2hFUpaBajUqnj2w/zlcZWdlbrrRdZyc83WwEwrEQ7L1YUmh82Od4g7F8rJCUdgflxgIicER1FTstyHSrh6CXWgqNZdczZYpcRTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384509; c=relaxed/simple;
	bh=V/0g7D6/hDse1tjqKT0K5O8O3xwRc8TmPIgiHgzBx1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VrDUysoq31q8LzjlDdGYzNOyaeO3/+JR6XQK1x7nV3NiiGPdiuNkOnrI+SM4R1JrIADmRdOhcMVXYNy6lGNXEnhCYgsLRnCOt46LVTaaZCSZAJz/RK0MSD39d9dHf7GpSbNZkrq9yU7CKUuZcic9mybYVZPZoAt44QE4J5wmQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VksTR4x3qzXp35;
	Wed, 22 May 2024 21:24:11 +0800 (CST)
Received: from dggems702-chm.china.huawei.com (unknown [10.3.19.179])
	by mail.maildlp.com (Postfix) with ESMTPS id D2004180080;
	Wed, 22 May 2024 21:28:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 21:28:22 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039;
 Wed, 22 May 2024 14:28:19 +0100
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
Subject: RE: [PATCH v3 0/4] iommu/smmuv3: Add IOMMUFD dirty tracking support
 for SMMUv3
Thread-Topic: [PATCH v3 0/4] iommu/smmuv3: Add IOMMUFD dirty tracking support
 for SMMUv3
Thread-Index: AQHamwTPK2EGuP63sEyRgeU3TMeaQLGTkXUAgA/QABA=
Date: Wed, 22 May 2024 13:28:19 +0000
Message-ID: <c4e6a33578e14f71a48b07ed49e2c0f1@huawei.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <ZkC9CK2bLPpqpSaP@nvidia.com>
In-Reply-To: <ZkC9CK2bLPpqpSaP@nvidia.com>
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
> Sent: Sunday, May 12, 2024 1:59 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> ryan.roberts@arm.com; kevin.tian@intel.com; nicolinc@nvidia.com;
> mshavit@google.com; eric.auger@redhat.com; joao.m.martins@oracle.com;
> jiangkunkun <jiangkunkun@huawei.com>; zhukeqian
> <zhukeqian1@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v3 0/4] iommu/smmuv3: Add IOMMUFD dirty tracking
> support for SMMUv3
>=20
> On Tue, Apr 30, 2024 at 02:43:04PM +0100, Shameer Kolothum wrote:
> > This is revisiting the earlier attempts [1, 2] to use SMMUv3 HTTU featu=
re
> > for dirty page tracking. The Intel/AMD support is already mainline.
> >
> > Basic sanity tests are done using an emulation setup and on a test
> > hardware setup. Block page split/merge(BBML) is not part of this
> > series. I am planning to send it separately.
>=20
> This looks good to me, lets have it go after the merge window. As I
> mentioned please post a version rebased on top of v6.10-rc1. (ie
> based on the patches only in Joerg's current tree) in two weeks.

Ok. I will cherry pick the ones required to make this independent and
post it soon after addressing all the pending comments.

Thanks,
Shameer
