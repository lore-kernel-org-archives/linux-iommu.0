Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442CAD21
	for <iommu@lists.linux.dev>; Thu, 16 Mar 2023 19:56:44 +0000 (UTC)
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PcycS5638z67PTQ;
	Fri, 17 Mar 2023 03:53:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 19:56:34 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.021;
 Thu, 16 Mar 2023 19:56:34 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Thread-Topic: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Thread-Index: AQHZUnWRmBwtrmleCk69JH8tQLhaPq7zzWuAgABY2gCAAAIMsIAABIwAgAABG+CAAAW9gIAAAcuwgAmm7QCAAAB98A==
Date: Thu, 16 Mar 2023 19:56:34 +0000
Message-ID: <7726b990f7c4486d9f3597979ebc4e7e@huawei.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com> <f61ca5693d8845eba0a2139324e52d98@huawei.com>
 <ZAtTNK1NbMJ4iyE0@nvidia.com> <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
 <ZAtY8S53//5P5egd@nvidia.com> <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
 <ZBNzNo96O/Cnhe2R@Asurada-Nvidia>
In-Reply-To: <ZBNzNo96O/Cnhe2R@Asurada-Nvidia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.195.246.25]
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
> From: Nicolin Chen [mailto:nicolinc@nvidia.com]
> Sent: 16 March 2023 19:51
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> Eric Auger <eric.auger@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>; robin.murphy@arm.com;
> will@kernel.org; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> joro@8bytes.org; jean-philippe@linaro.org;
> linux-arm-kernel@lists.infradead.org; iommu@lists.linux.dev;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain
> helper
>=20
> Hi Shameer/Eric,
>=20
> On Fri, Mar 10, 2023 at 04:30:03PM +0000, Shameerali Kolothum Thodi
> wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > > -----Original Message-----
> > > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > > Sent: 10 March 2023 16:21
> > > To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>; Nicolin Chen
> > > <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
> > > kevin.tian@intel.com; baolu.lu@linux.intel.com; joro@8bytes.org;
> > > jean-philippe@linaro.org; linux-arm-kernel@lists.infradead.org;
> > > iommu@lists.linux.dev; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v1 01/14] iommu: Add
> iommu_get_unmanaged_domain
> > > helper
> > >
> > > On Fri, Mar 10, 2023 at 04:07:38PM +0000, Shameerali Kolothum Thodi
> > > wrote:
> > > > >
> > >
> https://lore.kernel.org/linux-arm-kernel/20220420164836.1181-5-shame
> > > er
> > > > > > ali.kolothum.thodi@huawei.com/
> > > > >
> > > > > So "boot configration" is more like "don't change the RIDs"? Ie
> > > > > don't
> > > enable
> > > > > SRIOV?
> > > >
> > > > Yes. Don't think it will work with SR-IOV if you can't guarantee
> > > > the RMR
> > > specified
> > > > SID.
> > >
> > > So I think we are probably good them because vSR-IOV is already not
> > > supported by qemu, so it impossible for a VM to change the PCI
> > > configuration in a way that would alter the RID to SID mapping?
> > >
> >
> > Provided we fix the issue mentioned by Eric. This was discussed here
> > previously,
> >
> > https://lore.kernel.org/linux-arm-kernel/bb3688c7-8f42-039e-e22f-65290
> > 78da97d@redhat.com/
>=20
> Have we fixed the issue? I saw Lorenzo replying in that thread:
> https://lore.kernel.org/linux-arm-kernel/Yi8nV8H4Jjlpadmk@lpieralisi/
>=20
> Or, what's remaining here regarding this topic? Is it a blocker?

[+Lorenzo]

Not sure it is fixed yet. Also, assuming we take RMR path, do we plan to su=
pport=20
DT base Guests at all?

Thanks,
Shameer

