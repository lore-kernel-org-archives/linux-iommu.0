Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139447A59
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4SgyZm2fCXz1fxy5;
	Thu, 30 Nov 2023 22:03:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 22:04:07 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Thu, 30 Nov 2023 14:04:05 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, jiangkunkun <jiangkunkun@huawei.com>, zhukeqian
	<zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 4/5] iommu/arm-smmu-v3: Add set_dirty_tracking() support
Thread-Topic: [PATCH 4/5] iommu/arm-smmu-v3: Add set_dirty_tracking() support
Thread-Index: AQHaIeBbRVsBXl3gs0WmlcHaggD0FLCRtKaAgADZHNCAAEcfAIAAEjdg
Date: Thu, 30 Nov 2023 14:04:05 +0000
Message-ID: <23d034c1aca044598ae4777f7939108d@huawei.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-5-shameerali.kolothum.thodi@huawei.com>
 <20231129194235.GC436702@nvidia.com>
 <d80cd067b57345609a198aac5780e6af@huawei.com>
 <20231130125412.GH1389974@nvidia.com>
In-Reply-To: <20231130125412.GH1389974@nvidia.com>
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
X-CFilter-Loop: Reflected



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, November 30, 2023 12:54 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> kevin.tian@intel.com; nicolinc@nvidia.com; mshavit@google.com;
> eric.auger@redhat.com; joao.m.martins@oracle.com; jiangkunkun
> <jiangkunkun@huawei.com>; zhukeqian <zhukeqian1@huawei.com>;
> Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH 4/5] iommu/arm-smmu-v3: Add set_dirty_tracking()
> support
>=20
> On Thu, Nov 30, 2023 at 08:56:32AM +0000, Shameerali Kolothum Thodi
> wrote:
> > > On Tue, Nov 28, 2023 at 09:49:39AM +0000, Shameer Kolothum wrote:
> > > > From: Joao Martins <joao.m.martins@oracle.com>
> > > >
> > > > Dirty tracking will always be enabled with DBM=3D1 modifier enabled
> > > > by default when HD is supported.
> > >
> > > Is this trying to say that ARM doesn't have a per-table global enable
> > > for dirty tracking but instead pre-sets the DBM bit to avoid the cost=
?
> > >
> >
> > Yes. SMMUv3 has per-PTE DBM control and I think the initial RFC had
> > it walking the PTEs and setting the DBM on set_dirty_tracking().
>=20
> set_dirty_tracking doesn't have access to the necessary locking to
> touch the PTEs.
>=20
> > > So on smmuv3 to enable we have to clear everything and disable
> > > continues to pay a penalty since we don't go and mark all things as
> > > dirty again?
> >
> > Yes we clear everything on enable. Sorry I didn't get the second part.
> > We don't mark dirty on disable. How is that different from Intel/AMD?
>=20
> Intel/AMD have a global switch so they just turn off the tracking and
> stop paying the cost.
>=20
> This approach on ARM means once the tracking is logically turned off
> the HW will continue to generate memory traffic to set dirty bits on
> DMAs. There is no way to back to the at-start state where their is 0
> memory traffic on DMAs. Not sure that it totally matters, but it is
> worth noting someplace.

Ah..you meant the HW penalty of keeping it on always.

> If we do want to solve this then ARM would need iommufd to make a pass
> over the page table to set for disable similar to how we have to clear
> for enable.

I will try to see if there is any overhead in keeping it on. Also we could =
limit
turning it on for DOMAIN_NESTED ?

Thanks,
Shameer

