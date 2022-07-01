Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC710E9
	for <iommu@lists.linux.dev>; Fri,  1 Jul 2022 08:02:29 +0000 (UTC)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LZ6yN5ZSQz67y8S;
	Fri,  1 Jul 2022 15:58:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 10:02:25 +0200
Received: from [10.126.173.51] (10.126.173.51) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 09:02:24 +0100
Message-ID: <17c90e55-4560-fa37-398a-4de3838704ca@huawei.com>
Date: Fri, 1 Jul 2022 09:02:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 3/5] scsi: core: Cap shost max_sectors according to DMA
 limits only once
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
	<will@kernel.org>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
 <1656590892-42307-4-git-send-email-john.garry@huawei.com>
 <5f79d8e7-0035-cfb0-d612-3e1c7f243f22@opensource.wdc.com>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <5f79d8e7-0035-cfb0-d612-3e1c7f243f22@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.51]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Message-ID: <20220701080227.rOXDVLc5SttH1Ukfel9eKj2Cp_WX4ZW5J_0EgvfrwGo@z>

On 01/07/2022 00:41, Damien Le Moal wrote:
>>   
>>   	shost->dma_dev = dma_dev;
>>   
>> +	if (dma_dev->dma_mask) {
>> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
>> +				dma_max_mapping_size(dma_dev) >> SECTOR_SHIFT);
>> +	}
> Nit: you could remove the curly brackets... But it being a multi-line
> statement, having them is OK too I think.
> 

tglx seems to think that they are ok, and I generally agree (now):

https://lore.kernel.org/linux-arm-kernel/877djwdorz.ffs@nanos.tec.linutronix.de/

AFAICT coding-style.rst is ok with them in this scenario too

Cheers,
John
