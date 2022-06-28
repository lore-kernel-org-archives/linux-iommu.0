Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8A2CCA479
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 07:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 420D982730;
	Tue, 28 Jun 2022 07:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 420D982730
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A-fbVzMKLS_V; Tue, 28 Jun 2022 07:54:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 278EF824DD;
	Tue, 28 Jun 2022 07:54:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 278EF824DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8A94C0032;
	Tue, 28 Jun 2022 07:54:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54797C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C5C4416CA
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:54:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C5C4416CA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tpi-Ja7qAgHa for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:54:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B163C4150F
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B163C4150F
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:54:29 +0000 (UTC)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXH0R6bZ3z6GDF1;
 Tue, 28 Jun 2022 15:53:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 09:54:26 +0200
Received: from [10.126.174.22] (10.126.174.22) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 08:54:25 +0100
Message-ID: <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
Date: Tue, 28 Jun 2022 08:54:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
 <will@kernel.org>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
 <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
In-Reply-To: <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
X-Originating-IP: [10.126.174.22]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
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

On 28/06/2022 00:24, Damien Le Moal wrote:
> On 6/28/22 00:25, John Garry wrote:
>> ATA devices (struct ata_device) have a max_sectors field which is
>> configured internally in libata. This is then used to (re)configure the
>> associated sdev request queue max_sectors value from how it is earlier set
>> in __scsi_init_queue(). In __scsi_init_queue() the max_sectors value is set
>> according to shost limits, which includes host DMA mapping limits.
>>
>> Cap the ata_device max_sectors according to shost->max_sectors to respect
>> this shost limit.
>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
>> Acked-by: Damien Le Moal<damien.lemoal@opensource.wdc.com>
> Nit: please change the patch title to "ata: libata-scsi: Cap ..."
> 

ok, but it's going to be an even longer title :)

BTW, this patch has no real dependency on the rest of the series, so 
could be taken separately if you prefer.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
