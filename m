Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88920C433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 09:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3566C61180;
	Tue, 17 May 2022 09:02:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rswzskPA1tRT; Tue, 17 May 2022 09:02:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0E2CB60BDD;
	Tue, 17 May 2022 09:02:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3CB1C0039;
	Tue, 17 May 2022 09:02:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 412B0C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 09:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2EABC828F2
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 09:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8XW36sRDs2S1 for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 09:02:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD9D0824F4
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 09:02:06 +0000 (UTC)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L2VR854Wrz67L0F;
 Tue, 17 May 2022 16:59:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 11:02:01 +0200
Received: from [10.47.88.19] (10.47.88.19) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 10:02:00 +0100
Message-ID: <3e7c4d27-a0cb-2d9e-ca79-248ce26c6787@huawei.com>
Date: Tue, 17 May 2022 10:02:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
To: Christoph Hellwig <hch@lst.de>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <20220517083834.GA16965@lst.de>
In-Reply-To: <20220517083834.GA16965@lst.de>
X-Originating-IP: [10.47.88.19]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: will@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 liyihang6@hisilicon.com
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

On 17/05/2022 09:38, Christoph Hellwig wrote:
> On Mon, May 16, 2022 at 09:06:01PM +0800, John Garry wrote:
>> For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
>> exceeds the IOVA rcache upper limit (meaning that they are not cached),
>> performance can be reduced.
>>
>> Add the IOMMU callback for DMA mapping API dma_max_mapping_size(), which
>> allows the drivers to know the mapping limit and thus limit the requested
>> IOVA lengths.
>>
>> This resolves the performance issue originally reported in [0] for a SCSI
>> HBA driver which was regularly mapping SGLs which required IOVAs in
>> excess of the IOVA caching limit. In this case the block layer limits the
>> max sectors per request - as configured in __scsi_init_queue() - which
>> will limit the total SGL length the driver tries to map and in turn limits
>> IOVA lengths requested.

BTW, on a separate topic, I noticed that even with this change my ATA 
devices have max_hw_sectors_kb of 32767, as opposed to 128 for SAS 
devices. It seems that libata-scsi - specifically ata_scsi_dev_config() 
- doesn't honour the shost max_sectors limit. I guess that is not 
intentional.

>>
>> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>> Sending as an RFC as iommu_dma_max_mapping_size() is a soft limit, and not
>> a hard limit which I expect is the semantics of dma_map_ops.max_mapping_size
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 09f6e1c0f9c0..e2d5205cde37 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -1442,6 +1442,21 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>>   	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>>   }
>>   
> 
>> +	if (!domain)
>> +		return 0;
>> +
>> +	cookie = domain->iova_cookie;
>> +	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
>> +		return 0;
> 
> Can these conditions even be true here?

I don't think so. Paranoia on my part.

> 
>> +static inline unsigned long iova_rcache_range(void)
>> +{
>> +	return 0;
>> +}
> 
> Given that IOMMU_DMA select IOMMU_IOVA there is no need for this stub.

hmmm.. ok. Policy was to be stub everything but I think that it has changed.

> 
> Otherwise this looks sensible to me.
> 
> .

Great, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
