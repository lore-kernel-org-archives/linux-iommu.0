Received: from sinsgout.his.huawei.com (sinsgout.his.huawei.com [119.8.179.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4320E1
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 08:01:38 +0000 (UTC)
Received: from sinmsgout03.his.huawei.com (unknown [172.28.115.130])
	by sinsgout.his.huawei.com (SkyGuard) with ESMTP id 4Lk6Cd62Pfz3gyt1
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 15:52:29 +0800 (CST)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.156.208])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTP id 4Lk6B94QXHz9xGQ7;
	Thu, 14 Jul 2022 15:51:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 14 Jul 2022 09:52:14 +0200
Received: from [10.126.173.191] (10.126.173.191) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 08:52:13 +0100
Message-ID: <8a9d9c72-65c1-cb7d-80d7-4ac2b65871fe@huawei.com>
Date: Thu, 14 Jul 2022 08:52:15 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 0/5] DMA mapping changes for SCSI core
To: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: Christoph Hellwig <hch@lst.de>, <damien.lemoal@opensource.wdc.com>,
	<joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
	<m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
 <b5f80062-e8ef-9597-1b0c-393140950dfb@huawei.com>
 <20220706134447.GA23753@lst.de> <yq1y1x47jgn.fsf@ca-mkp.ca.oracle.com>
 <5fd4814a-81b1-0e71-58e0-57a747eb684e@huawei.com>
 <yq135f4xul0.fsf@ca-mkp.ca.oracle.com>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <yq135f4xul0.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.173.191]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected

On 14/07/2022 04:10, Martin K. Petersen wrote:

Hi Martin,

>> So I set max hw sectors at this ‘opt’ mapping size to ensure that we
>> get no mappings which exceed this size. Indeed, I think max sectors is
>> 128Kb today for my host, which would be same as dma_opt_mapping_size()
>> value with an IOMMU enabled. And I find that only a small % of request
>> size may exceed this 128kb size, but it still has a big performance
>> impact.
> The purpose of the soft limit is to pick the appropriate I/O size
> (i.e. for best performance). The purpose of the hard limit is to ensure
> we don't submit something the hardware can't handle or describe.
> 
> IOW, the hard limit is not about performance at all. The hard limit is
> mainly relevant for things that are way bigger than anything we'd issue
> as regular filesystem I/O such as multi-megabyte firmware images, etc.
> 
> It's perfectly fine for firmware download performance to be
> "suboptimal". What is typically more important in that scenario is that
> the firmware image makes it inside a single I/O.

OK, fine. I've improved the next version such that the DMA mapping opt 
limit only affects the max_sectors default.

Thanks,
John
