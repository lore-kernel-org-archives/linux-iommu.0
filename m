Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20311125C7
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 08:58:41 +0000 (UTC)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvtrW4htvz6HJyh;
	Tue, 26 Sep 2023 16:56:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 09:58:30 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.031;
 Tue, 26 Sep 2023 09:58:30 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Joao Martins <joao.m.martins@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>, Yi Y Sun
	<yi.y.sun@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel
	<joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Alex
 Williamson" <alex.williamson@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: RE: [PATCH v3 00/19] IOMMUFD Dirty Tracking
Thread-Topic: [PATCH v3 00/19] IOMMUFD Dirty Tracking
Thread-Index: AQHZ7b0Z7E1eWk1ZkEmpIRM/TUKnFbAs0xpw
Date: Tue, 26 Sep 2023 08:58:30 +0000
Message-ID: <d65b4e0872134c00b2504556f69bcb6e@huawei.com>
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
In-Reply-To: <20230923012511.10379-1-joao.m.martins@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.126.171.10]
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
> From: Joao Martins [mailto:joao.m.martins@oracle.com]
> Sent: 23 September 2023 02:25
> To: iommu@lists.linux.dev
> Cc: Jason Gunthorpe <jgg@nvidia.com>; Kevin Tian <kevin.tian@intel.com>;
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>; Lu
> Baolu <baolu.lu@linux.intel.com>; Yi Liu <yi.l.liu@intel.com>; Yi Y Sun
> <yi.y.sun@intel.com>; Nicolin Chen <nicolinc@nvidia.com>; Joerg Roedel
> <joro@8bytes.org>; Suravee Suthikulpanit
> <suravee.suthikulpanit@amd.com>; Will Deacon <will@kernel.org>; Robin
> Murphy <robin.murphy@arm.com>; Alex Williamson
> <alex.williamson@redhat.com>; kvm@vger.kernel.org; Joao Martins
> <joao.m.martins@oracle.com>
> Subject: [PATCH v3 00/19] IOMMUFD Dirty Tracking
>=20
[...]=20
> For ARM-SMMU-v3 I've made adjustments from the RFCv2 but staged this
> into a branch[6] with all the changes but didn't include here as I can't
> test this besides compilation. Shameer, if you can pick up as chatted
> sometime ago it would be great as you have the hardware. Note that
> it depends on some patches from Nicolin for hw_info() and
> domain_alloc_user() base support coming from his nesting work.

Thanks Joao. Sure will do.=20

Shameer
