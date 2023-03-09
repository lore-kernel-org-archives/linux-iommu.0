Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7EFD50B
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 16:07:57 +0000 (UTC)
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PXYwl1bqWz6J6rf;
	Fri, 10 Mar 2023 00:07:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 16:07:54 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.021;
 Thu, 9 Mar 2023 16:07:54 +0000
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
Thread-Index: AQHZUnWTVXhuXoh0OkWPSyQY1srSfq7ydQKAgAAVzLCAAAsqAIAAANyQgAAEp4CAAACeQA==
Date: Thu, 9 Mar 2023 16:07:54 +0000
Message-ID: <4c1f57adbe0c4d48849d585508595939@huawei.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <213a05ef06944a55a148995053b187f8@huawei.com> <ZAn94BXkjiJKQ66O@nvidia.com>
 <39979642ba8042ba9d4de651fecfeffb@huawei.com> <ZAoCf9+kpMof6R+4@nvidia.com>
In-Reply-To: <ZAoCf9+kpMof6R+4@nvidia.com>
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
> Sent: 09 March 2023 16:00
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
> On Thu, Mar 09, 2023 at 03:51:42PM +0000, Shameerali Kolothum Thodi
> wrote:
>=20
> > > For ARM cases where there is no shared VMID space with KVM, the ARM
> > > VMID should be somehow assigned to the iommfd_ctx itself and the allo=
c
> > > domain op should receive it from there.
> >
> > Is there any use of VMID outside SMMUv3? I was thinking if nested domai=
n
> alloc
> > doesn't provide the KVM instance, then SMMUv3 can use its internal VMID=
.
>=20
> When we talk about exposing an SMMUv3 IOMMU CMDQ directly to
> userspace then
> VMID is the security token that protects it.
>=20
> So in that environment every domain under the same iommufd should
> share the same VMID so that the CMDQ's also share the same VMID.
>=20
> I expect this to be a common sort of requirement as we will see
> userspace command queues in the other HW as well.
>=20
> So, I suppose the answer for now is that ARM SMMUv3 should just
> allocate one VMID per iommu_domain and there should be no VMID in the
> uapi at all.
>=20
> Moving all iommu_domains to share the same VMID is a future patch.
>=20
> Though.. I have no idea how vVMID is handled in the SMMUv3
> architecture. I suppose the guest IOMMU HW caps are set in a way that
> it knows it does not have VMID?

I think, Guest only sets up the SMMUv3 S1 stage and it doesn't use VMID.

Thanks,
Shameer
