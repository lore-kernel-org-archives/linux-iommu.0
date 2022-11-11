Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4124F2E;
	Fri, 11 Nov 2022 15:51:20 +0000 (UTC)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N836C0vygz683hj;
	Fri, 11 Nov 2022 23:49:07 +0800 (CST)
Received: from lhrpeml100002.china.huawei.com (7.191.160.241) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 16:51:17 +0100
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 15:51:16 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2375.031;
 Fri, 11 Nov 2022 15:51:16 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, David Woodhouse
	<dwmw2@infradead.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg
 Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Shuah Khan
	<shuah@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Cornelia Huck <cohuck@redhat.com>, Daniel Jordan
	<daniel.m.jordan@oracle.com>, David Gibson <david@gibson.dropbear.id.au>,
	Eric Auger <eric.auger@redhat.com>, Eric Farman <farman@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joao Martins <joao.m.martins@oracle.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Yi Liu <yi.l.liu@intel.com>, zhukeqian
	<zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 00/17] IOMMUFD Generic interface
Thread-Topic: [PATCH v4 00/17] IOMMUFD Generic interface
Thread-Index: AQHY8wv6WqOaN9m/WUKJgvcZCnpZkK454qzg
Date: Fri, 11 Nov 2022 15:51:16 +0000
Message-ID: <3a20e56423f544dab312bca1bcb56ce4@huawei.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
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
> Sent: 08 November 2022 00:49
> To: bpf@vger.kernel.org; Jonathan Corbet <corbet@lwn.net>; David
> Woodhouse <dwmw2@infradead.org>; iommu@lists.linux.dev; Joerg Roedel
> <joro@8bytes.org>; Kevin Tian <kevin.tian@intel.com>;
> linux-doc@vger.kernel.org; linux-kselftest@vger.kernel.org;
> llvm@lists.linux.dev; Nathan Chancellor <nathan@kernel.org>; Nick
> Desaulniers <ndesaulniers@google.com>; Miguel Ojeda <ojeda@kernel.org>;
> Robin Murphy <robin.murphy@arm.com>; Shuah Khan <shuah@kernel.org>;
> Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>; Tom Rix
> <trix@redhat.com>; Will Deacon <will@kernel.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>; Lu Baolu
> <baolu.lu@linux.intel.com>; Chaitanya Kulkarni <chaitanyak@nvidia.com>;
> Cornelia Huck <cohuck@redhat.com>; Daniel Jordan
> <daniel.m.jordan@oracle.com>; David Gibson
> <david@gibson.dropbear.id.au>; Eric Auger <eric.auger@redhat.com>; Eric
> Farman <farman@linux.ibm.com>; Jason Wang <jasowang@redhat.com>;
> Jean-Philippe Brucker <jean-philippe@linaro.org>; Joao Martins
> <joao.m.martins@oracle.com>; kvm@vger.kernel.org; Matthew Rosato
> <mjrosato@linux.ibm.com>; Michael S. Tsirkin <mst@redhat.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Niklas Schnelle <schnelle@linux.ibm.com>;
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>; Yi
> Liu <yi.l.liu@intel.com>; zhukeqian <zhukeqian1@huawei.com>
> Subject: [PATCH v4 00/17] IOMMUFD Generic interface
[...]
>=20
> - Userspace page tables aka 'nested translation' for ARM and Intel iommu
>   drivers:
>   https://github.com/nicolinc/iommufd/commits/iommufd_nesting

Hi Eric/Yi/Nicolin,

Could you please provide a latest Kernel/Qemu branch for the ARM nesting su=
pport?
The above link points to Yi's git, but not sure which one is latest/stable =
to=20
have a play.

Thanks,
Shameer

