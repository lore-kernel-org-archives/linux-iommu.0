Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23F15B15C
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964864; cv=none; b=KONYns4S6MOpLq6LbxnnmRxa8711Jix/DB1Ek9nsk4k77B1b9gvYLYFNYv2SbaZxPiiqDiDt71oQLwABpg1ZU8h1lrQuy+vJc7czyyYgcIA1xwBgwPXO2XtZQsS2AwLHgBHfPN6I+NBooC7iPa0m4QJzmcUMmi+bxt7vGwCABgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964864; c=relaxed/simple;
	bh=4X4w9Ip9WgUC082rsuWxVuyZce+m6SBKio4Pu6WE9lE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VfStyDpHYn1xiaSj+5Pmj8GSjY+I9LaH9Ye/WQdH6sL7LCV5X1X9LASTt2ev0p02qHSgYrlt/SVut2hdSvtrR0x1ggahaIQc5VxNTFDHUz4xlDJ+otHhmTrZxDfiMG8mhYQ8Tvbz7qlOmN7dLlwCq9FL92e0bIVD0Y4vy/h0JsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VPffb0x3dzXlQG;
	Wed, 24 Apr 2024 21:17:27 +0800 (CST)
Received: from dggems705-chm.china.huawei.com (unknown [10.3.19.182])
	by mail.maildlp.com (Postfix) with ESMTPS id BCED51400D8;
	Wed, 24 Apr 2024 21:20:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:20:55 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Wed, 24 Apr 2024 14:20:53 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "mshavit@google.com" <mshavit@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	jiangkunkun <jiangkunkun@huawei.com>, zhukeqian <zhukeqian1@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Thread-Topic: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Thread-Index: AQHaZXTEskP344GHbEaXPEKyEBg1Q7F2PPsAgAADG4CAAUHkgIAAJt6AgAAf0tA=
Date: Wed, 24 Apr 2024 13:20:53 +0000
Message-ID: <6e434a9e97be4abfad8c19dafe88456d@huawei.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-2-shameerali.kolothum.thodi@huawei.com>
 <3733929c-657e-4d24-b5e9-a5d946645abe@arm.com>
 <20240423145237.GD772409@nvidia.com>
 <90985ae5-fa1c-40f5-b4b3-57350a16e011@arm.com>
 <20240424122349.GH941030@nvidia.com>
In-Reply-To: <20240424122349.GH941030@nvidia.com>
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
> Sent: Wednesday, April 24, 2024 1:24 PM
> To: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org; joro@8bytes.=
org;
> kevin.tian@intel.com; nicolinc@nvidia.com; mshavit@google.com;
> robin.murphy@arm.com; will@kernel.org; joao.m.martins@oracle.com;
> jiangkunkun <jiangkunkun@huawei.com>; zhukeqian
> <zhukeqian1@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for
> HTTU
>=20
> On Wed, Apr 24, 2024 at 11:04:43AM +0100, Ryan Roberts wrote:
> > On 23/04/2024 15:52, Jason Gunthorpe wrote:
> > > On Tue, Apr 23, 2024 at 03:41:30PM +0100, Ryan Roberts wrote:
> > >> Hi,
> > >>
> > >> I'm aiming to (slowly) get more involved with SMMU activities, altho=
ugh I'm
> sure
> > >> it will take a while to get up to speed and provide useful input. It=
 was
> > >> suggested that this series would be a useful starting point to dip m=
y toe in.
> > >> Please bear with me while I ask stupid questions...
> > >
> > > Nice!
> > >
> > > I would like to see this merged as it was part of the original three
> > > implementations for iommufd dirty tracking. The other two have been
> > > merged for a long time now..
> >
> > My understanding is that this series should pretty much apply on top of
> > mainline, is that correct? (in practice there are some conflicts, but I=
 think
> > they are trivial).
>=20
> It was originally based on my part 2, but I suspect it could apply
> easially on top of part 2a. I don't think it is worth rebasing to
> v6.9-rc since I expect Will to take 2a.

But isn't arm_smmu_domain_alloc_user() gets introduced only in part 3
of the series? Do we plan to support DIRTY_TRACKING with domain_alloc( )
itself by default?=20

Thanks,
Shameer
