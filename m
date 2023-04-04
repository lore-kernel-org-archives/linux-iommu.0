Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4628F3
	for <iommu@lists.linux.dev>; Tue,  4 Apr 2023 16:50:23 +0000 (UTC)
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PrYYg44rVz67d2y;
	Wed,  5 Apr 2023 00:46:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 17:50:14 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.023;
 Tue, 4 Apr 2023 17:50:14 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: RE: Cache Invalidation Solution for Nested IOMMU
Thread-Topic: Cache Invalidation Solution for Nested IOMMU
Thread-Index: AQHZZcP9AmBGSPvPIkC4mL7SORjVE68ZjzWAgAAMCQCAAEmlgIAAUDeAgAERN4CAABdCsA==
Date: Tue, 4 Apr 2023 16:50:14 +0000
Message-ID: <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia> <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia> <ZCxOMSvR+6rYbIfy@nvidia.com>
In-Reply-To: <ZCxOMSvR+6rYbIfy@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.48.155.16]
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
> Sent: 04 April 2023 17:20
> To: Nicolin Chen <nicolinc@nvidia.com>
> Cc: Robin Murphy <robin.murphy@arm.com>; kevin.tian@intel.com;
> yi.l.liu@intel.com; eric.auger@redhat.com; baolu.lu@linux.intel.com;
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> jean-philippe@linaro.org; iommu@lists.linux.dev
> Subject: Re: Cache Invalidation Solution for Nested IOMMU
>=20
> On Mon, Apr 03, 2023 at 05:02:09PM -0700, Nicolin Chen wrote:
>=20
> > My preference is to have a mmap'd page, so the interface can
> > be reused later by VCMDQ too. Performance-wise, it should be
> > good enough, since it does batching, IMHO.
>=20
> You can't reuse mmaping the queue page with vcmdq, so it doesn't seem
> meaningful to me.
>=20
> There should be no mmap on the SW path. If you need a half step
> between an ioctl as a batch and a full vhost-like queue scheme then
> using iouring with pre-registered memory would be appropriate.
>=20
> I feel like this is a topic Shameerali should share some insight with
> since the Huawei implementation will rely on this SW path.

So far the tests we have done are mainly using IOCTL method without
batching and I don't have any numbers to compare against the batched
method yet.

[+Zhangfei]

Zhangfei, do you think we can run some UADK/vSVA tests with different=20
Invalidation solutions discussed here and compare?=20

Thanks,
Shameer=20
