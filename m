Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993D882C
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 15:44:12 +0000 (UTC)
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PY9Lh6fFLz6J6rP;
	Fri, 10 Mar 2023 23:43:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 15:44:03 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.021;
 Fri, 10 Mar 2023 15:44:03 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "robin.murphy@arm.com"
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
Thread-Index: AQHZUnWRmBwtrmleCk69JH8tQLhaPq7zzWuAgABY2gCAAAIMsA==
Date: Fri, 10 Mar 2023 15:44:02 +0000
Message-ID: <f61ca5693d8845eba0a2139324e52d98@huawei.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com>
In-Reply-To: <ZAtNrFAEHvmM4FOW@nvidia.com>
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
> Sent: 10 March 2023 15:33
> To: Eric Auger <eric.auger@redhat.com>
> Cc: Nicolin Chen <nicolinc@nvidia.com>; robin.murphy@arm.com;
> will@kernel.org; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> joro@8bytes.org; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; jean-philippe@linaro.org;
> linux-arm-kernel@lists.infradead.org; iommu@lists.linux.dev;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain
> helper
>=20
> On Fri, Mar 10, 2023 at 11:14:59AM +0100, Eric Auger wrote:
> > Hi Nicolin,
> >
> > On 3/9/23 11:53, Nicolin Chen wrote:
> > > The nature of ITS virtualization on ARM is done via hypercalls, so
> > > kernel handles all IOVA mappings for the MSI doorbell in
> > > iommu_dma_prepare_msi() and iommu_dma_compose_msi_msg(). The
> current
> > > virtualization solution with a 2-stage nested translation setup is
> > > to do 1:1 IOVA mappings at stage-1
> > Note that if we still intend to use that trick there is a known issue
> > at kernel side that needs to be fixed.
> >
> > ARM DEN 0049E.b IORT specification mandates that when RMRs are
> > present, the OS must preserve PCIe configuration performed by the boot
> > FW.
>=20
> This limitation doesn't seem necessary for this MSI stuff?
>=20
> What is it for?

That is to make sure the Stream Ids specified in RMR are still valid and is=
 not being
reassigned by OS. The kernel checks for this(iort_rmr_has_dev()),
https://lore.kernel.org/linux-arm-kernel/20220420164836.1181-5-shameerali.k=
olothum.thodi@huawei.com/

Thanks,
Shameer



