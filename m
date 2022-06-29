Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B267EB
	for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 07:43:33 +0000 (UTC)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXtgT3zScz6H7fy;
	Wed, 29 Jun 2022 15:41:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 09:43:29 +0200
Received: from [10.195.245.77] (10.195.245.77) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 08:43:28 +0100
Message-ID: <65e05dd1-8e92-5f6b-d68e-72987fcebf59@huawei.com>
Date: Wed, 29 Jun 2022 08:43:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>, Christoph Hellwig
	<hch@lst.de>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
	<joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <m.szyprowski@samsung.com>,
	<robin.murphy@arm.com>
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
 <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
 <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
 <38ae1cc8-1411-bb54-e082-0f7b91cb9e63@huawei.com>
 <20220629054027.GB16297@lst.de>
 <da7027d9-bd81-cfb0-f70e-2405f40023fa@opensource.wdc.com>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <da7027d9-bd81-cfb0-f70e-2405f40023fa@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.245.77]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Message-ID: <20220629074330.Q-cbyNnyyOp8R4W0t2qYDinr7oHQEwk1uRfbmufesvo@z>

On 29/06/2022 06:58, Damien Le Moal wrote:
> On 6/29/22 14:40, Christoph Hellwig wrote:
>> On Tue, Jun 28, 2022 at 12:33:58PM +0100, John Garry wrote:
>>> Well Christoph originally offered to take this series via the dma-mapping
>>> tree.
>>>
>>> @Christoph, is that still ok with you? If so, would you rather I send this
>>> libata patch separately?
>>
>> The offer still stands, and I don't really care where the libata
>> patch is routed.  Just tell me what you prefer.

Cheers.

> 
> If it is 100% independent from the other patches, I can take it.
> Otherwise, feel free to take it !
> 

I'll just keep the all together - it's easier in case I need to change 
anything.

Thanks!
