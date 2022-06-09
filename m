Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C57CCA473
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 17:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 170458402F;
	Thu,  9 Jun 2022 17:54:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KsuYDdJ7j1Ok; Thu,  9 Jun 2022 17:54:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 08CDB84000;
	Thu,  9 Jun 2022 17:54:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E17ABC0032;
	Thu,  9 Jun 2022 17:54:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3592CC002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15A024152D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:54:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3mMp68UYLZhL for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 17:54:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6108F41906
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:54:07 +0000 (UTC)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJs7n4GZKz67xjL;
 Fri, 10 Jun 2022 01:50:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 19:54:03 +0200
Received: from [10.47.88.201] (10.47.88.201) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 9 Jun
 2022 18:54:02 +0100
Message-ID: <9b1d155e-28cc-08dc-5a5a-8580132575e7@huawei.com>
Date: Thu, 9 Jun 2022 18:54:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
To: Bart Van Assche <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>, 
 <joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
 <martin.petersen@oracle.com>, <hch@lst.de>, <m.szyprowski@samsung.com>,
 <robin.murphy@arm.com>
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-4-git-send-email-john.garry@huawei.com>
 <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
 <31417477-953d-283e-808e-cf8701e820a8@huawei.com>
 <bccbcc9b-4750-a1a7-130f-69eeea5dcb23@acm.org>
 <5b214e95-dd95-551a-496e-a2139a74e8eb@huawei.com>
 <a2585983-75d7-c627-13ba-38a464cf716e@acm.org>
In-Reply-To: <a2585983-75d7-c627-13ba-38a464cf716e@acm.org>
X-Originating-IP: [10.47.88.201]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
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

On 09/06/2022 18:18, Bart Van Assche wrote:
>>>
>>> SCSI host bus adapters that support 64-bit DMA may support much 
>>> larger transfer sizes than 128 KiB.
>>
>> Indeed, and that is my problem today, as my storage controller is 
>> generating DMA mapping lengths which exceeds 128K and they slow 
>> everything down.
>>
>> If you say that SRP enjoys best peformance with larger transfers then 
>> can you please test this with an IOMMU enabled (iommu group type DMA 
>> or DMA-FQ)?
> 
> Hmm ... what exactly do you want me to test? Do you perhaps want me to 
> measure how much performance drops with an IOMMU enabled? 

Yes, I would like to know of any performance change with an IOMMU 
enabled and then with an IOMMU enabled and including my series.

> I don't have 
> access anymore to the SRP setup I referred to in my previous email. But 
> I do have access to devices that boot from UFS storage. For these 
> devices we need to transfer 2 MiB per request to achieve full bandwidth.

ok, but do you have a system where the UFS host controller is behind an 
IOMMU? I had the impression that UFS controllers would be mostly found 
in embedded systems and IOMMUs are not as common on there.

Thanks,
John

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
