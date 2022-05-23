Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CAFC4332F
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 11:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A025141937;
	Mon, 23 May 2022 11:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m7zFK4In0VA7; Mon, 23 May 2022 11:56:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E358F41920;
	Mon, 23 May 2022 11:56:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD33C0032;
	Mon, 23 May 2022 11:56:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA408C002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 11:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E045460D75
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 11:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vu5gG4rde5pd for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 11:56:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAB0A60BB0
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 11:56:24 +0000 (UTC)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L6G0N6q73z67njv;
 Mon, 23 May 2022 19:52:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 13:56:20 +0200
Received: from [10.47.87.6] (10.47.87.6) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 12:56:19 +0100
Message-ID: <42350b3a-193f-a1a0-3ef7-13643e1101f0@huawei.com>
Date: Mon, 23 May 2022 12:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
To: Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@lists.01.org>,
 <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>, <will@kernel.org>,
 <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
 <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
References: <202205210545.gkS834ds-lkp@intel.com>
In-Reply-To: <202205210545.gkS834ds-lkp@intel.com>
X-Originating-IP: [10.47.87.6]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: kbuild-all@lists.01.org, lkp@intel.com, linux-scsi@vger.kernel.org,
 linux-doc@vger.kernel.org, liyihang6@hisilicon.com,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

On 23/05/2022 12:08, Dan Carpenter wrote:

Thanks for the report

> 50b6cb3516365c Dexuan Cui        2021-10-07  224  	/* Use min_t(int, ...) in case shost->can_queue exceeds SHRT_MAX */
> 50b6cb3516365c Dexuan Cui        2021-10-07  225  	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
> ea2f0f77538c50 John Garry        2021-05-19  226  				   shost->can_queue);
> ea2f0f77538c50 John Garry        2021-05-19  227
> 2ad7ba6ca08593 John Garry        2022-05-20 @228  	if (dma_dev->dma_mask) {
>                                                              ^^^^^^^^^^^^^^^^^

I knew that we fixed up dma_dev to be non-NULL, but I thought it was 
earlier in this function...

> The patch adds a new unchecked dereference
> 
> 2ad7ba6ca08593 John Garry        2022-05-20  229  		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> 2ad7ba6ca08593 John Garry        2022-05-20  230  				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> 2ad7ba6ca08593 John Garry        2022-05-20  231  	}
> 2ad7ba6ca08593 John Garry        2022-05-20  232
> 0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  233  	error = scsi_init_sense_cache(shost);
> 0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  234  	if (error)
> 0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  235  		goto fail;
> 0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  236
> d285203cf647d7 Christoph Hellwig 2014-01-17  237  	error = scsi_mq_setup_tags(shost);
> 542bd1377a9630 James Bottomley   2008-04-21  238  	if (error)
> 542bd1377a9630 James Bottomley   2008-04-21  239  		goto fail;
> d285203cf647d7 Christoph Hellwig 2014-01-17  240
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  241  	if (!shost->shost_gendev.parent)
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  242  		shost->shost_gendev.parent = dev ? dev : &platform_bus;
> 3c8d9a957d0ae6 James Bottomley   2012-05-04 @243  	if (!dma_dev)
>                                                              ^^^^^^^^

Cheers,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
