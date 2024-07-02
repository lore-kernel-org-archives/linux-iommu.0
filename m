Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0511A1B47C2
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926724; cv=none; b=Ik79B5mg5trACN3oXVy08BrAL/W1nAH+iik+ArX6KH+xQOsmajxL1PdtoIg/iygmjmwdgqHx8c7Hauv8GXQxXZEiWqx8eSjCG9hHRUXEZUqzZA2GbJd7aM2rX9z31ncTHNyxHyQg10mcwxs0AhoVawk59GpgKrCXMUThssJYT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926724; c=relaxed/simple;
	bh=qK4ldLvmfIGq11V2y4Pp1P4nll1lkxuef0jQGNGxGGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ybb6v7pIjpwCT7hwXAzVTip65eFOB8rvXmqZG+aQ1yffEmn4zUgWizOKnb2AXbJxr6sTdgizIsmowNTVnwzCfrxY+rbLdwSApRWg8IHIc9/RDqmc7xnc36KmGsinTVUhSqEZItlDnO1otLBGQt74IYLWYBFIzH52zNdFkUnMr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WD3SZ6XBxz1T4bJ;
	Tue,  2 Jul 2024 21:20:46 +0800 (CST)
Received: from dggems703-chm.china.huawei.com (unknown [10.3.19.180])
	by mail.maildlp.com (Postfix) with ESMTPS id 1696618007E;
	Tue,  2 Jul 2024 21:25:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 21:25:17 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039;
 Tue, 2 Jul 2024 14:25:15 +0100
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
Thread-Index: AQHavaAtXJbwpOXZKECCEVEjdmiJ9bHjiG1Q///wbwCAABGeIA==
Date: Tue, 2 Jul 2024 13:25:15 +0000
Message-ID: <b631cad7472a4786a935c3b2cc29e4a1@huawei.com>
References: <20240613144149.38672-1-shameerali.kolothum.thodi@huawei.com>
 <f88aeb0364884db994e4cba22b1e9ad5@huawei.com>
 <20240702131916.GA3691@willie-the-truck>
In-Reply-To: <20240702131916.GA3691@willie-the-truck>
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
> Sent: Tuesday, July 2, 2024 2:19 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> robin.murphy@arm.com; joro@8bytes.org; jgg@nvidia.com;
> ryan.roberts@arm.com; mark.rutland@arm.com; kevin.tian@intel.com;
> nicolinc@nvidia.com; mshavit@google.com; eric.auger@redhat.com;
> joao.m.martins@oracle.com; jiangkunkun <jiangkunkun@huawei.com>;
> zhukeqian <zhukeqian1@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v6 0/6] Add IOMMUFD dirty tracking support for SMMUv3
>=20
> On Tue, Jul 02, 2024 at 01:15:57PM +0000, Shameerali Kolothum Thodi wrote=
:
> > > -----Original Message-----
> > > From: linux-arm-kernel
> > > <linux-arm-kernel-bounces@lists.infradead.org> On Behalf Of Shameer
> > > Kolothum
> > > Sent: Thursday, June 13, 2024 3:42 PM
> > > To: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > Cc: robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> > > jgg@nvidia.com; ryan.roberts@arm.com; mark.rutland@arm.com;
> > > kevin.tian@intel.com; nicolinc@nvidia.com; mshavit@google.com;
> > > eric.auger@redhat.com; joao.m.martins@oracle.com; jiangkunkun
> > > <jiangkunkun@huawei.com>; zhukeqian <zhukeqian1@huawei.com>;
> > > Linuxarm <linuxarm@huawei.com>
> > > Subject: [PATCH v6 0/6] Add IOMMUFD dirty tracking support for
> > > SMMUv3
> > >
> > > Hi,
> > >
> > > v5 --> v6
> > >  -Minor updates based on Nicolin's feedback.
> > >  -Picked up R-by tags by Jason, Nicolin and Kevin(Thanks!)
> > >
> > > Hi Will,
> > >
> > > Not sure you got a chance to take a look at this=A0series yet.
> > > Hopefully this will make it for 6.11.
> >
> > A gentle ping on this.
>=20
> On the list for today! Do you depend on Jason's "2b" series? [1]

Thanks. Nope. It is now independent of Jasons's above series. Based
on 6.10-rc3. But if you try to apply Jason's on top of this, there might
be minor conflict I guess.

Shameer
