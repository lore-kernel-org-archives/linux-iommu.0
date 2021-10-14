Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85645C433F5
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 11:49:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372C06117A
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 11:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 372C06117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 096E181DCB;
	Thu, 14 Oct 2021 11:49:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WTBhrMB_s2Dy; Thu, 14 Oct 2021 11:49:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9A13181762;
	Thu, 14 Oct 2021 11:49:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59A11C000F;
	Thu, 14 Oct 2021 11:49:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83269C000D
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 11:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5DF97401CC
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 11:49:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DG4OM24Tjxfh for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 11:49:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A058B400B5
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 11:49:33 +0000 (UTC)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HVSKk1jlKz6H71h;
 Thu, 14 Oct 2021 19:46:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 14 Oct 2021 13:49:29 +0200
Received: from [10.47.26.229] (10.47.26.229) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 12:49:29 +0100
Subject: Re: [RFC] iommu: Use put_pages_list
To: Matthew Wilcox <willy@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon
 <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210930162043.3111119-1-willy@infradead.org>
 <YV85dvlyj5LBdsro@casper.infradead.org>
 <YWgShKtp+89f1a/J@casper.infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <5e147b84-f048-b5ff-09d6-ceffe4c2364a@huawei.com>
Date: Thu, 14 Oct 2021 12:52:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YWgShKtp+89f1a/J@casper.infradead.org>
Content-Language: en-US
X-Originating-IP: [10.47.26.229]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 14/10/2021 12:20, Matthew Wilcox wrote:
> I'm going to keep pinging this patch weekly.
> 
> On Thu, Oct 07, 2021 at 07:17:02PM +0100, Matthew Wilcox wrote:
>> ping?

Robin, Were you checking this? You mentioned "I got
side-tracked trying to make io-pgtable use that freelist properly" in 
another thread, which seems related.

Thanks,
John

>>
>> On Thu, Sep 30, 2021 at 05:20:42PM +0100, Matthew Wilcox (Oracle) wrote:
>>> page->freelist is for the use of slab.  We already have the ability
>>> to free a list of pages in the core mm, but it requires the use of a
>>> list_head and for the pages to be chained together through page->lru.
>>> Switch the iommu code over to using free_pages_list().
>>>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>>   drivers/iommu/amd/io_pgtable.c | 99 +++++++++++++++-------------------
>>>   drivers/iommu/dma-iommu.c      | 11 +---
>>>   drivers/iommu/intel/iommu.c    | 89 +++++++++++-------------------
>>>   include/linux/iommu.h          |  3 +-
>>>   4 files changed, 77 insertions(+), 125 deletions(-)
>>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
