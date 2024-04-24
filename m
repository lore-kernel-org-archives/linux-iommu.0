Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3257F158DDD
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966223; cv=none; b=gf4ku+77R14RJ0mxUaHaQKmHqlgwxizFXqXy3pKwUqOfR9DaqjW1CsOmrtWc6ilvI8p0zfa2ptQq01+H+gC7w3Z/kM5kDACim1EM7nHZjaUXjY1/8+0nCoNsJEY4LpaSQ+4s+KLJ45cghX5Xrxq2hwS0+lQuKLsEQcXE51MbI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966223; c=relaxed/simple;
	bh=E5M5qHLSwA8SdVRtd/hYECTwzQkLQIAEj0b5NcBxkvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ke8ylCaCbhtwNmtrXqArj3hUwVQrev+273riSUERonHeC+nknSn0hNVfGmVgAjfSK74QA0s9O0LafyCn1N6xRsVt4R5HnDCVe+xturgLawZ7WVI46nmS1hA/yzI0222hld8MAymQ5uqOsJw8szsdNMWq1XyxjiGdPTJT+gBrRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VPg963psvzwTMC;
	Wed, 24 Apr 2024 21:40:26 +0800 (CST)
Received: from dggems701-chm.china.huawei.com (unknown [10.3.19.178])
	by mail.maildlp.com (Postfix) with ESMTPS id 720F314065B;
	Wed, 24 Apr 2024 21:43:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:43:36 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Wed, 24 Apr 2024 14:43:33 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Ryan Roberts <ryan.roberts@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "mshavit@google.com" <mshavit@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	jiangkunkun <jiangkunkun@huawei.com>, zhukeqian <zhukeqian1@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Thread-Topic: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Thread-Index: AQHaZXTEskP344GHbEaXPEKyEBg1Q7F2PPsAgAADG4CAAUHkgIAAJt6AgAAf0tD///NLAIAAE4bw
Date: Wed, 24 Apr 2024 13:43:33 +0000
Message-ID: <c318c60be2c54733ba16ae68e9c67ae0@huawei.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-2-shameerali.kolothum.thodi@huawei.com>
 <3733929c-657e-4d24-b5e9-a5d946645abe@arm.com>
 <20240423145237.GD772409@nvidia.com>
 <90985ae5-fa1c-40f5-b4b3-57350a16e011@arm.com>
 <20240424122349.GH941030@nvidia.com>
 <6e434a9e97be4abfad8c19dafe88456d@huawei.com>
 <20240424133214.GI941030@nvidia.com>
In-Reply-To: <20240424133214.GI941030@nvidia.com>
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
> Sent: Wednesday, April 24, 2024 2:32 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>; iommu@lists.linux.dev; linux-arm=
-
> kernel@lists.infradead.org; joro@8bytes.org; kevin.tian@intel.com;
> nicolinc@nvidia.com; mshavit@google.com; robin.murphy@arm.com;
> will@kernel.org; joao.m.martins@oracle.com; jiangkunkun
> <jiangkunkun@huawei.com>; zhukeqian <zhukeqian1@huawei.com>; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for
> HTTU
>=20
> On Wed, Apr 24, 2024 at 01:20:53PM +0000, Shameerali Kolothum Thodi wrote=
:
>=20
> > > On Wed, Apr 24, 2024 at 11:04:43AM +0100, Ryan Roberts wrote:
> > > > On 23/04/2024 15:52, Jason Gunthorpe wrote:
> > > > > On Tue, Apr 23, 2024 at 03:41:30PM +0100, Ryan Roberts wrote:
> > > > >> Hi,
> > > > >>
> > > > >> I'm aiming to (slowly) get more involved with SMMU activities, a=
lthough
> I'm
> > > sure
> > > > >> it will take a while to get up to speed and provide useful input=
. It was
> > > > >> suggested that this series would be a useful starting point to d=
ip my toe
> in.
> > > > >> Please bear with me while I ask stupid questions...
> > > > >
> > > > > Nice!
> > > > >
> > > > > I would like to see this merged as it was part of the original th=
ree
> > > > > implementations for iommufd dirty tracking. The other two have be=
en
> > > > > merged for a long time now..
> > > >
> > > > My understanding is that this series should pretty much apply on to=
p of
> > > > mainline, is that correct? (in practice there are some conflicts, b=
ut I think
> > > > they are trivial).
> > >
> > > It was originally based on my part 2, but I suspect it could apply
> > > easially on top of part 2a. I don't think it is worth rebasing to
> > > v6.9-rc since I expect Will to take 2a.
> >
> > But isn't arm_smmu_domain_alloc_user() gets introduced only in part 3
> > of the series?
>=20
> Right. "easially" was perhaps a bit too strong. It would have to be
> rebased and pull back a little bit of the domain_alloc_user()
> implementation.
>=20
> If it is good otherwise lets consider doing this. Maybe HTTU and part
> 2b can go together during the v6.11 cycle?

Sure. Let us target that.

Thanks,
Shameer
