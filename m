Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2161C4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:48:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B086138C
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B086138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61FBE60705;
	Wed,  2 Jun 2021 07:48:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xuL2ODxxTBeh; Wed,  2 Jun 2021 07:48:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A5AE60687;
	Wed,  2 Jun 2021 07:48:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D488C000D;
	Wed,  2 Jun 2021 07:48:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68B12C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49B43401FB
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:48:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k9yBKR4UvToh for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:48:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 478E0400BA
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:48:40 +0000 (UTC)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fw16j2N0Cz6Q2kg;
 Wed,  2 Jun 2021 15:36:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 09:48:37 +0200
Received: from [10.47.91.52] (10.47.91.52) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 2 Jun 2021
 08:48:36 +0100
Subject: Re: [PATCH v3 0/7] iommu: Allow IOVA rcache range be configured
To: Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <robin.murphy@arm.com>
References: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
 <834ad35a-7310-1738-7d17-7c061ca73e4c@linux.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <1cbf8cc2-8cee-0579-2514-56f664baa9cd@huawei.com>
Date: Wed, 2 Jun 2021 08:48:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <834ad35a-7310-1738-7d17-7c061ca73e4c@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.47.91.52]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org
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

On 02/06/2021 05:37, Lu Baolu wrote:
> On 6/1/21 10:29 PM, John Garry wrote:
>> For streaming DMA mappings involving an IOMMU and whose IOVA len 
>> regularly
>> exceeds the IOVA rcache upper limit (meaning that they are not cached),
>> performance can be reduced.
>>
>> This is much more pronounced from commit 4e89dce72521 ("iommu/iova: Retry
>> from last rb tree node if iova search fails"), as discussed at [0].
>>
>> IOVAs which cannot be cached are highly involved in the IOVA ageing 
>> issue,
>> as discussed at [1].
>>
>> This series allows the IOVA rcache range be configured, so that we may
>> cache all IOVAs per domain, thus improving performance.
>>
>> A new IOMMU group sysfs file is added - max_opt_dma_size - which is used
>> indirectly to configure the IOVA rcache range:
>> /sys/kernel/iommu_groups/X/max_opt_dma_size
>>
>> This file is updated same as how the IOMMU group default domain type is
>> updated, i.e. must unbind the only device in the group first.
> 
> Could you explain why it requires singleton group and driver unbinding
> if the user only wants to increase the upper limit? I haven't dived into
> the details yet, sorry if this is a silly question.

Hi Baolu,

I did actually try increasing the range for a 'live' domain in the v1 
series, but it turned out too messy. First problem is reallocating the 
memory to hold the rcaches. Second problem is that we need to deal with 
the issue that all IOVAs in the rcache need to be a pow-of-2, which is 
difficult to enforce for IOVAs which weren't being cached before, but 
now would be.

So now I changed to work similar to how we change the default domain 
type, i.e. don't operate on a 'live' domain.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
