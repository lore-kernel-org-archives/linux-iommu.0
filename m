Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E95C433DF
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 13:09:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F42221E2
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 13:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F42221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EBD9488C3D;
	Fri, 14 Aug 2020 13:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1MiOqYUpEYQZ; Fri, 14 Aug 2020 13:09:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5728E88C0D;
	Fri, 14 Aug 2020 13:09:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34D65C07FF;
	Fri, 14 Aug 2020 13:09:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A935CC004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 13:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A44DB88C15
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 13:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d7BKQdATPUYa for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 13:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4D05988C0A
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 13:09:22 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 4B1FA15787834D3AC242;
 Fri, 14 Aug 2020 14:09:19 +0100 (IST)
Received: from [127.0.0.1] (10.47.4.107) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 14 Aug
 2020 14:09:18 +0100
Subject: Re: nvme crash - Re: linux-next: Tree for Aug 13
To: Christoph Hellwig <hch@infradead.org>
References: <20200813155009.GA2303@infradead.org>
 <81e42d30-ede3-d7b0-ad7b-8192bcf27a4c@huawei.com>
 <20200814120824.GB1872@infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <895b0c2f-52eb-bd72-7cbf-aa6808c018d2@huawei.com>
Date: Fri, 14 Aug 2020 14:07:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200814120824.GB1872@infradead.org>
Content-Language: en-US
X-Originating-IP: [10.47.4.107]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, chaitanya.kulkarni@wdc.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, iommu@lists.linux-foundation.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On 14/08/2020 13:08, Christoph Hellwig wrote:
>>>> [148.455065]__sg_alloc_table_from_pages+0xec/0x238
>>>> [148.459931]sg_alloc_table_from_pages+0x18/0x28
>>>> [148.464541]iommu_dma_alloc+0x474/0x678
>>>> [148.468455]dma_alloc_attrs+0xd8/0xf0
>>>> [148.472193]nvme_alloc_queue+0x114/0x160 [nvme]
>>>> [148.476798]nvme_reset_work+0xb34/0x14b4 [nvme]
>>>> [148.481407]process_one_work+0x1e8/0x360
>>>> [148.485405]worker_thread+0x44/0x478
>>>> [148.489055]kthread+0x150/0x158
>>>> [148.492273]ret_from_fork+0x10/0x34
>>>> [148.495838] Code: f94002c3 6b01017f 540007c2 11000486 (f8645aa5)
>>>> [148.501921] ---[ end trace 89bb2b72d59bf925 ]---
>>>>
>>>> Anything to worry about? I guess not since we're in the merge window, but
>>>> mentioning just in case ...
>> I bisected, and this patch looks to fix it (note the comments below the
>> '---'):
>>
>>  From 263891a760edc24b901085bf6e5fe2480808f86d Mon Sep 17 00:00:00 2001
>> From: John Garry<john.garry@huawei.com>
>> Date: Fri, 14 Aug 2020 12:45:18 +0100
>> Subject: [PATCH] nvme-pci: Use u32 for nvme_dev.q_depth
>>
>> Recently nvme_dev.q_depth was changed from int to u16 type.
>>
>> This falls over for the queue depth calculation in nvme_pci_enable(),
>> where NVME_CAP_MQES(dev->ctrl.cap) + 1 may overflow, as NVME_CAP_MQES()
>> gives a 16b number also. That happens for me, and this is the result:
> Oh, interesting.  Please also switch the module option parsing to
> use kstrtou32 and param_set_uint and send this as a formal patch.
> 

I'm doing it now.

BTW, as for the DMA/sg scatterlist code, it so happens in this case that 
we try the dma alloc for size=0 in nvme_alloc_queue() - I know an 
allocation for size=0 makes no sense, but couldn't we bit a bit more robust?

Cheers,
John



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
