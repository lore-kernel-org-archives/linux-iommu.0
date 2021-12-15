Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53429C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 01:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D608C60D70;
	Wed, 15 Dec 2021 01:59:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDWwA2r9oyuB; Wed, 15 Dec 2021 01:59:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B60EF60BEC;
	Wed, 15 Dec 2021 01:59:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 675B6C002F;
	Wed, 15 Dec 2021 01:59:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 238CBC0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 01:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09E8B40292
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 01:59:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G83uvv-37UhP for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 01:59:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA91D40156
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 01:59:16 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JDJLW6zvsz91kH;
 Wed, 15 Dec 2021 09:58:27 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 09:59:12 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 09:59:11 +0800
Subject: Re: [PATCH] Revert "iommu/arm-smmu-v3: Decrease the queue size of
 evtq and priq"
To: Will Deacon <will@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>
References: <1638858768-9971-1-git-send-email-wangzhou1@hisilicon.com>
 <20211214144841.GB14837@willie-the-truck>
Message-ID: <ded54329-b3b8-4a73-c2c6-41cf89923414@huawei.com>
Date: Wed, 15 Dec 2021 09:59:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20211214144841.GB14837@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
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
From: "Leizhen \(ThunderTown\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Leizhen \(ThunderTown\)" <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021/12/14 22:48, Will Deacon wrote:
> On Tue, Dec 07, 2021 at 02:32:48PM +0800, Zhou Wang wrote:
>> The commit f115f3c0d5d8 ("iommu/arm-smmu-v3: Decrease the queue size of
>> evtq and priq") decreases evtq and priq, which may lead evtq/priq to be
>> full with fault events, e.g HiSilicon ZIP/SEC/HPRE have maximum 1024 queues
>> in one device, every queue could be binded with one process and trigger a
>> fault event. So let's revert f115f3c0d5d8.
>>
>> In fact, if an implementation of SMMU really does not need so long evtq
>> and priq, value of IDR1_EVTQS and IDR1_PRIQS can be set to proper ones.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> I'd like an Ack from Zhen Lei on this, as the aim of the original patch
> was to reduce memory consumption.

I did it for the purpose of saving memory. At the time, I didn't think it would
have accumulated so many events. Now there is such a practical situation. Ensuring
functionality stability is more important than saving a little memory. So I have
no objection to reverting my patch.

Acked-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Will
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
