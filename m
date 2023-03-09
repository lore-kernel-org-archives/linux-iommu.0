Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F29D50B
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 15:51:45 +0000 (UTC)
Received: from lhrpeml100005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PXYWX5s9sz688wM;
	Thu,  9 Mar 2023 23:48:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100005.china.huawei.com (7.191.160.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 15:51:42 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.021;
 Thu, 9 Mar 2023 15:51:42 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen
	<nicolinc@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>
Subject: RE: [PATCH v1 02/14] iommufd: Add nesting related data structures for
 ARM SMMUv3
Thread-Topic: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Thread-Index: AQHZUnWTVXhuXoh0OkWPSyQY1srSfq7ydQKAgAAVzLCAAAsqAIAAANyQ
Date: Thu, 9 Mar 2023 15:51:42 +0000
Message-ID: <39979642ba8042ba9d4de651fecfeffb@huawei.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <213a05ef06944a55a148995053b187f8@huawei.com> <ZAn94BXkjiJKQ66O@nvidia.com>
In-Reply-To: <ZAn94BXkjiJKQ66O@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.202.227.178]
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
> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> Sent: 09 March 2023 15:40
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>; Nicolin Chen
> <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
> eric.auger@redhat.com; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> joro@8bytes.org; linux-arm-kernel@lists.infradead.org;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; yi.l.liu@intel.com
> Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structure=
s
> for ARM SMMUv3
>=20
> On Thu, Mar 09, 2023 at 03:26:12PM +0000, Shameerali Kolothum Thodi
> wrote:
>=20
> > On platforms that supports BTM [1], we may need the VMID allocated by
> KVM.
> > But again getting that from user pace doesn't look safe. I have attempt=
ed
> to revise
> > the earlier RFC to pin and use the KVM VMID from SMMUv3 here[2].
>=20
> Gurk
>=20
> > " In the new design we can require from the start that creating a nesti=
ng
> IOMMU
> > container through /dev/iommu *must* come with a KVM context, that way
> > we're sure to reuse the existing VMID. "
>=20
> I've been dreading this but yes I execpt we will eventually need to
> connect kvm and iommufd together. The iommu driver can receive a kvm
> pointer as part of the alloc domain operation to do any setups like
> this.

That will make life easier :)
=20
> If there is no KVM it should either fail to setup the domain or setup
> a domain disconnected from KVM.
>=20

If no KVM the SMMUv3 can fall back to its internal VMID allocation I guess.
And my intention was to use KVM VMID only if the platform supports
BTM.

> If IOMMU HW and KVM HW are using the same ID number space then
> arguably the two kernel drivers need to use a shared ID allocator in
> the arch, regardless of what iommufd/etc does. Using KVM should not be
> mandatory for iommufd.
>=20
> For ARM cases where there is no shared VMID space with KVM, the ARM
> VMID should be somehow assigned to the iommfd_ctx itself and the alloc
> domain op should receive it from there.

Is there any use of VMID outside SMMUv3? I was thinking if nested domain al=
loc
doesn't provide the KVM instance, then SMMUv3 can use its internal VMID.=20

Thanks,
Shameer

> Nicolin, that seems to be missing in this series? I'm not entirely
> sure how to elegantly code it :\
>=20
> Jason
