Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30CA32ED43
	for <iommu@lists.linux.dev>; Thu, 11 Sep 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599742; cv=none; b=u30csR0x1c3pTXfboKy0QW4MEm2ITUIIS0CvaoUu1vtLyyvSIk+bqVKy541Zw1ct+G8aP/mt0Zv4KYJbOfih4shhkhGu4EPDJ3YCM3Pk1IuteHXUnuBOupnoSYmEwRxxq0I8KYTDf1JMKFZKGzRMP/nImC+n4APeJtVasgXk3fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599742; c=relaxed/simple;
	bh=2pqgafZIU6dCGuLxRRcQ4J9D0AL2bMkEFuyleWWTbWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eu0hBLpyeRFSRu0qRiOhaKgk4hSBoZkMYLsro6/L52ZiHVTkFbXHC0yAeQnspXBG32G+OBrpJ2Mke2vgeOhaeMDYXOur3GS6yoh1hjGpDpRDgCuieuUw+5JpSEHddoJ3ykuXX2TkB01d6fsW1BocDS2oQZZqfVCbpVxvqkz/JtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cMzq66vynz2VRgH;
	Thu, 11 Sep 2025 22:05:38 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 64F2F140296;
	Thu, 11 Sep 2025 22:08:56 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 22:08:55 +0800
Message-ID: <bb4c3f0b-06da-46e6-9769-efe3dc00e9fb@huawei.com>
Date: Thu, 11 Sep 2025 22:08:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu: Add io_ptdump debug interface for iommu
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<yangyicong@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
 <20250902161028.GC184112@ziepe.ca>
 <f2720f17-5e81-4f69-aaf5-791b47973178@huawei.com>
 <20250910141547.GD882933@ziepe.ca>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <20250910141547.GD882933@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/9/10 22:15:47, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Sep 10, 2025 at 11:20:08AM +0800, Qinxin Xia wrote:
>> Ok, I see, my colleague Wang Zhou also released a version of io_ptdump
>> a long time ago, which is implemented in smmu debugfs. Will recommends that
>> io_ptdump be implemented in a way similar to CPU page table dump. Using
>> debugfs to expose the data and using format-specific callbacks to implement
>> specific data dumps, I'll talk to him about this as well.
> 
> I feel we should have a iommu subsystem debugfs and per-iommu_domain
> directories to dump the page tables.
> 
> The smmu debugfs can report what iommu_domains each STE/CD is
> referencing.
> 
> This also needs RCU freeing of page table levels as a locking
> strategy.
> 
> Jason
> 

Thanks, I'll add RCU in the next version, but there's some confusion, Do 
you mean to create a directory for each domain? like：

/sys/kernel/debug/io_page_tables/domain_xxxx (xxxx=domain addr)

tree domain_xxxx like:
domain_xxxx
└── group x
│ └── device
└── io_ptdump

And the current design is such:

User Space Interface
└── DebugFS file: /sys/kernel/debug/io_page_tables
└── Operation: Reading this file triggers the entire debug information 
collection process

Kernel Space Components
├── Configuration option (CONFIG_IO_PTDUMP_DEBUGFS)
├── Initialization module (mm/io_ptdump.c)
│ └── device_initcall(io_ptdump_init)
│ └── io_ptdump_debugfs_register("io_page_tables")
├── DebugFS backend (mm/io_ptdump_debugfs.c)
│ └── DEFINE_SHOW_ATTRIBUTE(io_ptdump)
│ └── .show = io_ptdump_show
│ └── iommu_group_and_iova_dump(m)
└── IOMMU core extension (drivers/iommu/iommu.c)
└── iommu_group_and_iova_dump()
├── Traverse all IOMMU groups (via iommu_group_kset)
├── Filter groups with default domain using DMA_IOVA cookie
├── Build domain-group hierarchy
│ ├── domain_list: list head
│ ├── dump_domain: domain entry
│ │ ├── domain: pointer to iommu_domain
│ │ └── groups: list head of groups
│ └── dump_group: group entry
│ └── group: pointer to iommu_group
├── Output domain information
├── Output group and device information
└── Call iommu_iova_info_dump() to output IOVA mappings
└── Traverse IOVA red-black tree
└── Call domain->ops->dump_iova_prot() to get protection information
└── ARM SMMUv3 implementation (drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c)
└── arm_smmu_dump_iova_prot()
└── Call io_pgtable_ops->dump_iova_prot()
└── ARM LPAE implementation (drivers/iommu/io-pgtable-arm.c)
└── arm_lpae_dump_iova_prot()
├── Use __arm_lpae_iopte_walk() to traverse page tables
├── Obtain page table entry and level information
├── Format and output mapping range and information
└── Call dump_prot() to output protection flags
└── Use prot_bits array to parse permission bits

Do you mean that the interface in io-pgtable-arm.c is directly invoked 
during the process of obtaining page table information without passing 
through arm-smmu-v3.c?

I'll add STE and CD dumps to the next release. Any other suggestions?
