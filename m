Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C36142E73
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002041; cv=none; b=fyUk4nQuQSLWFsEhLKD0j9ZL1s06tzWmrkMRQbe4p8U3H8FaeIQqLA434TEn0KiGTdxxb0MaoXGuTcjJCXmI/UlQUTJqx0hEBzHzVkV1DPzAWSmvYXkRKaoDgDt8zVjV5pko4iwJrBl5yLDVwDsB5LCk67S2CJPhyHtUaLIK7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002041; c=relaxed/simple;
	bh=iJA3/PU+na9Cx0gQmUZsr5u767lNGvT2bvQRlw0JL/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gWRcvrp4nkWqUZ2lLBjVytNTnBaKTho+LpyHdxSDzTqupCdcdJe4jGEeTa8xFDpbj8Fjk1/gjGJ+q2CPjgosYq1ARbzYBghHb6dUzKJc/IWcvSgxMzSv21DyhppZ+58fq5vSiYlJ1XFWjsRQPJQHpx0wf44NAe6a92iuFxfNdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WDbJx5sW8zZhRq;
	Wed,  3 Jul 2024 18:16:01 +0800 (CST)
Received: from kwepemf500018.china.huawei.com (unknown [7.202.181.5])
	by mail.maildlp.com (Postfix) with ESMTPS id 44E31140361;
	Wed,  3 Jul 2024 18:20:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 kwepemf500018.china.huawei.com (7.202.181.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Jul 2024 18:20:34 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039;
 Wed, 3 Jul 2024 11:20:32 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Will Deacon <will@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, jiangkunkun <jiangkunkun@huawei.com>, zhukeqian
	<zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v6 0/6] Add IOMMUFD dirty tracking support for SMMUv3
Thread-Topic: [PATCH v6 0/6] Add IOMMUFD dirty tracking support for SMMUv3
Thread-Index: AQHavaAtXJbwpOXZKECCEVEjdmiJ9bHj1BwAgAEVujA=
Date: Wed, 3 Jul 2024 10:20:32 +0000
Message-ID: <285351de4086438e922d3698e5a86a39@huawei.com>
References: <20240613144149.38672-1-shameerali.kolothum.thodi@huawei.com>
 <20240702184551.GA5167@willie-the-truck>
In-Reply-To: <20240702184551.GA5167@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0



> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Tuesday, July 2, 2024 7:46 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> robin.murphy@arm.com; joro@8bytes.org; jgg@nvidia.com;
> ryan.roberts@arm.com; mark.rutland@arm.com; kevin.tian@intel.com;
> nicolinc@nvidia.com; mshavit@google.com; eric.auger@redhat.com;
> joao.m.martins@oracle.com; jiangkunkun <jiangkunkun@huawei.com>;
> zhukeqian <zhukeqian1@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v6 0/6] Add IOMMUFD dirty tracking support for
> SMMUv3
>=20
> Hey Shameer,
>=20
> On Thu, Jun 13, 2024 at 03:41:43PM +0100, Shameer Kolothum wrote:
> > v5 --> v6
> >  -Minor updates based on Nicolin's feedback.
> >  -Picked up R-by tags by Jason, Nicolin and Kevin(Thanks!)
> >
> > Hi Will,
> >
> > Not sure you got a chance to take a look at this=A0series yet. Hopefull=
y
> > this will make it for 6.11
>=20
> This all looks good to me, thanks.
>=20
> However, it conflicts with some of Jason's stuff that I've pushed out to
> for-joerg/smmu/updates:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=3Df=
or-
> joerg/arm-smmu/updates
>=20
> Please can you rebase, retest and repost? Hopefully it makes your life
> even easier as, for example, I don't think you need the first patch at
> all anymore thanks to "iommu/arm-smmu-v3: Make SVA allocate a normal
> arm_smmu_domain".

Done. Please see the v7 send out just now.

Thanks,
Shameer
