Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD032C433FE
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 11:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E68A610A9;
	Tue, 26 Apr 2022 11:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OD_B90V7TM-9; Tue, 26 Apr 2022 11:43:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 04664605DB;
	Tue, 26 Apr 2022 11:43:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE701C0039;
	Tue, 26 Apr 2022 11:43:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05F14C002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 11:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3EF3610BC
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 11:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pYcdBn_ws8ii for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 11:43:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E1A6610A9
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 11:43:38 +0000 (UTC)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kng4Q1L81zgYqW;
 Tue, 26 Apr 2022 19:43:18 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 19:43:35 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 19:43:33 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Tue, 26 Apr 2022 12:43:32 +0100
To: kernel test robot <lkp@intel.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v11 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Topic: [PATCH v11 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Index: AQHYVmZKfsv4Ue0JXEuZq1FbubftY6z9MaGAgATjIbA=
Date: Tue, 26 Apr 2022 11:43:31 +0000
Message-ID: <ada9f0011e544fc5be9b61b7700f44d5@huawei.com>
References: <20220422162907.1276-5-shameerali.kolothum.thodi@huawei.com>
 <202204231737.0jkKpxZk-lkp@intel.com>
In-Reply-To: <202204231737.0jkKpxZk-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "will@kernel.org" <will@kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
 "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Shameerali Kolothum Thodi via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: kernel test robot [mailto:lkp@intel.com]
> Sent: 23 April 2022 10:51
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: llvm@lists.linux.dev; kbuild-all@lists.01.org; Linuxarm
> <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com; joro@8bytes.org;
> robin.murphy@arm.com; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; steven.price@arm.com; Sami.Mujawar@arm.com;
> jon@solid-run.com; eric.auger@redhat.com; laurentiu.tudor@nxp.com;
> hch@infradead.org
> Subject: Re: [PATCH v11 4/9] ACPI/IORT: Add support to retrieve IORT RMR
> reserved regions
> 

[...]
 
> >> drivers/acpi/arm64/iort.c:801:29: warning: no previous prototype for
> function 'iort_rmr_alloc' [-Wmissing-prototypes]
>    struct iommu_iort_rmr_data *iort_rmr_alloc(struct acpi_iort_rmr_desc
> *rmr_desc,
>                                ^
>    drivers/acpi/arm64/iort.c:801:1: note: declare 'static' if the function is not
> intended to be used outside of this translation unit
>    struct iommu_iort_rmr_data *iort_rmr_alloc(struct acpi_iort_rmr_desc
> *rmr_desc,

Oops..missed the 'static' here. The rest of the warnings are because of the dependency
with ACPICA header patch here[1].

Hi Robin/Lorenzo,

I am planning to send out an updated series soon with that 'static' added and the R-by
tag received for patch #1 from Christoph. Appreciate if you can take a look and let me 
know if you have any further comments on this series.

Thanks,
Shameer

[1] https://lore.kernel.org/all/44610361.fMDQidcC6G@kreacher/


>    ^
>    static
>    drivers/acpi/arm64/iort.c:896:20: error: use of undeclared identifier
> 'ACPI_IORT_RMR_REMAP_PERMITTED'
>                    if (rmr->flags & ACPI_IORT_RMR_REMAP_PERMITTED)
>                                     ^
>    drivers/acpi/arm64/iort.c:901:20: error: use of undeclared identifier
> 'ACPI_IORT_RMR_ACCESS_PRIVILEGE'
>                    if (rmr->flags & ACPI_IORT_RMR_ACCESS_PRIVILEGE)
>                                     ^
>    drivers/acpi/arm64/iort.c:905:7: error: call to undeclared function
> 'ACPI_IORT_RMR_ACCESS_ATTRIBUTES'; ISO C99 and later do not support
> implicit function declarations [-Wimplicit-function-declaration]
>                    if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) <=
>                        ^
>    drivers/acpi/arm64/iort.c:906:5: error: use of undeclared identifier
> 'ACPI_IORT_RMR_ATTR_DEVICE_GRE'
>                                    ACPI_IORT_RMR_ATTR_DEVICE_GRE)
>                                    ^
>    drivers/acpi/arm64/iort.c:909:5: error: use of undeclared identifier
> 'ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB'
> 
> ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB)
>                                    ^
>    1 warning and 5 errors generated.
> 
> 
> vim +/iort_rmr_alloc +801 drivers/acpi/arm64/iort.c
> 
>    800
>  > 801	struct iommu_iort_rmr_data *iort_rmr_alloc(struct
> acpi_iort_rmr_desc *rmr_desc,
>    802						   int prot, enum iommu_resv_type type,
>    803						   u32 *sids, u32 num_sids)
>    804	{
>    805		struct iommu_iort_rmr_data *rmr_data;
>    806		struct iommu_resv_region *region;
>    807		u32 *sids_copy;
>    808		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
>    809
>    810		rmr_data = kmalloc(sizeof(*rmr_data), GFP_KERNEL);
>    811		if (!rmr_data)
>    812			return NULL;
>    813
>    814		/* Create a copy of SIDs array to associate with this rmr_data */
>    815		sids_copy = kmemdup(sids, num_sids * sizeof(*sids),
> GFP_KERNEL);
>    816		if (!sids_copy) {
>    817			kfree(rmr_data);
>    818			return NULL;
>    819		}
>    820		rmr_data->sids = sids_copy;
>    821		rmr_data->num_sids = num_sids;
>    822
>    823		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
>    824			/* PAGE align base addr and size */
>    825			addr &= PAGE_MASK;
>    826			size = PAGE_ALIGN(size +
> offset_in_page(rmr_desc->base_address));
>    827
>    828			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not
> aligned to 64K, continue with [0x%llx - 0x%llx]\n",
>    829			       rmr_desc->base_address,
>    830			       rmr_desc->base_address + rmr_desc->length - 1,
>    831			       addr, addr + size - 1);
>    832		}
>    833
>    834		region = &rmr_data->rr;
>    835		INIT_LIST_HEAD(&region->list);
>    836		region->start = addr;
>    837		region->length = size;
>    838		region->prot = prot;
>    839		region->type = type;
>    840		region->free = iort_rmr_free;
>    841
>    842		return rmr_data;
>    843	}
>    844
> 
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
