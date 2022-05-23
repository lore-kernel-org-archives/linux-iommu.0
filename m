Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE69C433EF
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 06:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CABA60AAF;
	Mon, 23 May 2022 06:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id faRoBHkoASGF; Mon, 23 May 2022 06:53:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 856BD60BFF;
	Mon, 23 May 2022 06:53:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 457A8C0039;
	Mon, 23 May 2022 06:53:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F4C5C002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 06:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 257DE60BFF
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 06:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uUkvwhKr2Tgu for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 06:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2BD060AAF
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 06:53:53 +0000 (UTC)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L67HL5xxcz67Cp9;
 Mon, 23 May 2022 14:49:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 08:53:50 +0200
Received: from [10.47.87.6] (10.47.87.6) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 07:53:49 +0100
Message-ID: <d5a31b82-4134-a7fb-1a51-446e32db2fd0@huawei.com>
Date: Mon, 23 May 2022 07:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
 <will@kernel.org>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
 <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-4-git-send-email-john.garry@huawei.com>
 <e65e7329-67e3-016f-e213-86e51b8021d6@opensource.wdc.com>
In-Reply-To: <e65e7329-67e3-016f-e213-86e51b8021d6@opensource.wdc.com>
X-Originating-IP: [10.47.87.6]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 21/05/2022 00:30, Damien Le Moal wrote:
>> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
>> index f69b77cbf538..a3ae6345473b 100644
>> --- a/drivers/scsi/hosts.c
>> +++ b/drivers/scsi/hosts.c
>> @@ -225,6 +225,11 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
>>   	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
>>   				   shost->can_queue);
>>   

Hi Damien,

>> +	if (dma_dev->dma_mask) {
>> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
>> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
>> +	}
> Nit: you could drop the curly brackets here.

Some people prefer this style - multi-line statements have curly 
brackets, while single-line statements conform to the official coding 
style (and don't use brackets).

I'll just stick with what we have unless there is a consensus to change.

Thanks,
John

> 
>> +
>>   	error = scsi_init_sense_cache(shost);
>>   	if (error)
>>   		goto fail;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
