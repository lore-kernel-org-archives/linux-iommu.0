Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2284371
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 10:29:23 +0000 (UTC)
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCCGd3Dh7z6J6Yh;
	Thu,  9 Feb 2023 18:07:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Feb 2023 10:11:43 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.017;
 Thu, 9 Feb 2023 10:11:42 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Yi Liu <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "lulu@redhat.com"
	<lulu@redhat.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "zhangfei.gao@linaro.org"
	<zhangfei.gao@linaro.org>
Subject: RE: [PATCH 00/17] Add Intel VT-d nested translation
Thread-Topic: [PATCH 00/17] Add Intel VT-d nested translation
Thread-Index: AQHZPD95hqLckmeZEk+opw51qnHtYq7GX1jw
Date: Thu, 9 Feb 2023 10:11:42 +0000
Message-ID: <0bea6077f0634587b744ec2b421205e1@huawei.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.195.245.52]
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
> From: Yi Liu [mailto:yi.l.liu@intel.com]
> Sent: 09 February 2023 04:32
> To: joro@8bytes.org; alex.williamson@redhat.com; jgg@nvidia.com;
> kevin.tian@intel.com; robin.murphy@arm.com
> Cc: cohuck@redhat.com; eric.auger@redhat.com; nicolinc@nvidia.com;
> kvm@vger.kernel.org; mjrosato@linux.ibm.com;
> chao.p.peng@linux.intel.com; yi.l.liu@intel.com; yi.y.sun@linux.intel.com=
;
> peterx@redhat.com; jasowang@redhat.com; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; lulu@redhat.com;
> suravee.suthikulpanit@amd.com; iommu@lists.linux.dev;
> linux-kernel@vger.kernel.org; linux-kselftest@vger.kernel.org;
> baolu.lu@linux.intel.com
> Subject: [PATCH 00/17] Add Intel VT-d nested translation
>=20
> Nested translation has two stage address translations to get the final
> physical addresses. Take Intel VT-d as an example, the first stage transl=
ation
> structure is I/O page table. As the below diagram shows, guest I/O page
> table pointer in GPA (guest physical address) is passed to host to do the
> first stage translation. Along with it, guest modifications to present
> mappings in the first stage page should be followed with an iotlb invalid=
ation
> to sync host iotlb.
>=20
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest I/O page table      |
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush --+
>     '-------------'                        |
>     |             |                        V
>     |             |           I/O page table pointer in GPA
>     '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>       v        v                          v
> Host
>     .-------------.  .------------------------.
>     |   pIOMMU    |  |  FS for GIOVA->GPA      |
>     |             |  '------------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.----------------------------------.
>     |             |   | SS for GPA->HPA, unmanaged domain|
>     |             |   '----------------------------------'
>     '-------------'
> Where:
>  - FS =3D First stage page tables
>  - SS =3D Second stage page tables
> <Intel VT-d Nested translation>
>=20
> Different platform vendors have different first stage translation formats=
,
> so userspace should query the underlying iommu capability before setting
> first stage translation structures to host.[1]
>=20
> In iommufd subsystem, I/O page tables would be tracked by hw_pagetable
> objects.
> First stage page table is owned by userspace (guest), while second stage
> page
> table is owned by kernel for security. So First stage page tables are tra=
cked
> by user-managed hw_pagetable, second stage page tables are tracked by
> kernel-
> managed hw_pagetable.
>=20
> This series first introduces new iommu op for allocating domains for
> iommufd,
> and op for syncing iotlb for first stage page table modifications, and th=
en
> add the implementation of the new ops in intel-iommu driver. After this
> preparation, adds kernel-managed and user-managed hw_pagetable
> allocation for
> userspace. Last, add self-test for the new ioctls.
>=20
> This series is based on "[PATCH 0/6] iommufd: Add iommu capability
> reporting"[1]
> and Nicolin's "[PATCH v2 00/10] Add IO page table replacement support"[2]=
.
> Complete
> code can be found in[3]. Draft Qemu code can be found in[4].
>=20
> Basic test done with DSA device on VT-d. Where the guest has a vIOMMU
> built
> with nested translation.

Hi Yi Liu,

Thanks for sending this out. Will go through this one. As I informed before=
 we keep
an internal branch based on your work and rebase few patches to get the ARM
SMMUv3 nesting support. The recent one is based on your "iommufd-v6.2-rc4-n=
esting"
branch and is here,

https://github.com/hisilicon/kernel-dev/commits/iommufd-v6.2-rc4-nesting-ar=
m

Just wondering any chance the latest "Add SMMUv3 nesting support" series wi=
ll
be send out soon? Please let me know if you need any help with that.

Thanks,
Shameer
>=20
> [1]
> https://lore.kernel.org/linux-iommu/20230209041642.9346-1-yi.l.liu@intel.
> com/
> [2]
> https://lore.kernel.org/linux-iommu/cover.1675802050.git.nicolinc@nvidia.=
c
> om/
> [3] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting_vtd_v1
> [4] https://github.com/yiliu1765/qemu/tree/wip/iommufd_rfcv3%2Bnesting
>=20
> Regards,
> 	Yi Liu
>=20
> Lu Baolu (5):
>   iommu: Add new iommu op to create domains owned by userspace
>   iommu: Add nested domain support
>   iommu/vt-d: Extend dmar_domain to support nested domain
>   iommu/vt-d: Add helper to setup pasid nested translation
>   iommu/vt-d: Add nested domain support
>=20
> Nicolin Chen (6):
>   iommufd: Add/del hwpt to IOAS at alloc/destroy()
>   iommufd/device: Move IOAS attaching and detaching operations into
>     helpers
>   iommufd/selftest: Add IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE test
> op
>   iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC ioctl
>   iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
>   iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
>=20
> Yi Liu (6):
>   iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
>   iommufd: Split iommufd_hw_pagetable_alloc()
>   iommufd: Add kernel-managed hw_pagetable allocation for userspace
>   iommufd: Add infrastructure for user-managed hw_pagetable allocation
>   iommufd: Add user-managed hw_pagetable allocation
>   iommufd/device: Report supported stage-1 page table types
>=20
>  drivers/iommu/intel/Makefile                  |   2 +-
>  drivers/iommu/intel/iommu.c                   |  38 ++-
>  drivers/iommu/intel/iommu.h                   |  50 +++-
>  drivers/iommu/intel/nested.c                  | 143 +++++++++
>  drivers/iommu/intel/pasid.c                   | 142 +++++++++
>  drivers/iommu/intel/pasid.h                   |   2 +
>  drivers/iommu/iommufd/device.c                | 117 ++++----
>  drivers/iommu/iommufd/hw_pagetable.c          | 280
> +++++++++++++++++-
>  drivers/iommu/iommufd/iommufd_private.h       |  23 +-
>  drivers/iommu/iommufd/iommufd_test.h          |  35 +++
>  drivers/iommu/iommufd/main.c                  |  11 +
>  drivers/iommu/iommufd/selftest.c              | 149 +++++++++-
>  include/linux/iommu.h                         |  11 +
>  include/uapi/linux/iommufd.h                  | 196 ++++++++++++
>  tools/testing/selftests/iommu/iommufd.c       | 124 +++++++-
>  tools/testing/selftests/iommu/iommufd_utils.h | 106 +++++++
>  16 files changed, 1329 insertions(+), 100 deletions(-)
>  create mode 100644 drivers/iommu/intel/nested.c
>=20
> --
> 2.34.1
>=20

