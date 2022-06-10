Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C04C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Jun 2022 15:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9716541989;
	Fri, 10 Jun 2022 15:38:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JTADbDYVXwn9; Fri, 10 Jun 2022 15:38:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3EF2741D28;
	Fri, 10 Jun 2022 15:38:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09C68C0039;
	Fri, 10 Jun 2022 15:38:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0A6DC002D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 15:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 884B2404F0
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 15:38:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KBtKU0WcKDeD for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 15:38:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7CA64031C
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 15:38:00 +0000 (UTC)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LKQ2n144hz689ML;
 Fri, 10 Jun 2022 23:33:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:37:56 +0200
Received: from [10.47.88.201] (10.47.88.201) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 10 Jun
 2022 16:37:55 +0100
Message-ID: <f7872ebc-dfe5-d977-c51f-91b73e6d1fbb@huawei.com>
Date: Fri, 10 Jun 2022 16:37:54 +0100
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
 <9b1d155e-28cc-08dc-5a5a-8580132575e7@huawei.com>
 <23bf4427-41c3-bf1d-903a-75928bb47627@acm.org>
In-Reply-To: <23bf4427-41c3-bf1d-903a-75928bb47627@acm.org>
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

On 09/06/2022 21:34, Bart Van Assche wrote:
> On 6/9/22 10:54, John Garry wrote:
>> ok, but do you have a system where the UFS host controller is behind 
>> an IOMMU? I had the impression that UFS controllers would be mostly 
>> found in embedded systems and IOMMUs are not as common on there.
> 
> Modern phones have an IOMMU. Below one can find an example from a Pixel 
> 6 phone. The UFS storage controller is not controller by the IOMMU as 
> far as I can see but I wouldn't be surprised if the security team would 
> ask us one day to enable the IOMMU for the UFS controller.

OK, then unfortunately it seems that you have no method to test. I might 
be able to test USB MSC but I am not even sure if I can even get DMA 
mappings who length exceeds the IOVA rcache limit there.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
