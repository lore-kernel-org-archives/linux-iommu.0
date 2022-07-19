Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3ED7B
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 07:24:04 +0000 (UTC)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ln8sG1gt7z67QNP;
	Tue, 19 Jul 2022 15:02:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 09:05:32 +0200
Received: from [10.126.173.247] (10.126.173.247) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 08:05:31 +0100
Message-ID: <e3dbd78e-95fe-ea61-8bcf-45ea02de1647@huawei.com>
Date: Tue, 19 Jul 2022 08:05:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 4/6] scsi: sd: Allow max_sectors be capped at DMA
 optimal size limit
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
	<will@kernel.org>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>
References: <1657797329-98541-1-git-send-email-john.garry@huawei.com>
 <1657797329-98541-5-git-send-email-john.garry@huawei.com>
 <6725df4f-4e27-3320-8b7b-22ba15a07866@opensource.wdc.com>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <6725df4f-4e27-3320-8b7b-22ba15a07866@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.247]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected

On 18/07/2022 11:47, Damien Le Moal wrote:
>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>> index a1a2ac09066f..3eaee1f7aaca 100644
>> --- a/drivers/scsi/sd.c
>> +++ b/drivers/scsi/sd.c
>> @@ -3296,6 +3296,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
>>   				      (sector_t)BLK_DEF_MAX_SECTORS);
>>   	}

Hi Damien,

>>   
>> +	rw_max = min_not_zero(rw_max, sdp->host->opt_sectors);
>> +
> Adding a comment explaining what the cap is would be nice.
> 


Christoph has now applied this (thanks, BTW), so would you like me to 
follow up with a patch on top with a comment?

Thanks,
John
