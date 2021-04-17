Return-Path: <SRS0=S5kk=JO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1977C433ED
	for <iommu@archiver.kernel.org>; Sat, 17 Apr 2021 01:11:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8147960233
	for <iommu@archiver.kernel.org>; Sat, 17 Apr 2021 01:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8147960233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44CBB84C64;
	Sat, 17 Apr 2021 01:11:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gRQgFuoQeOIx; Sat, 17 Apr 2021 01:11:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4183784BF3;
	Sat, 17 Apr 2021 01:11:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AF77C000B;
	Sat, 17 Apr 2021 01:11:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC524C000A
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 01:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D82BC60669
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 01:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jgZ-694vlCgH for <iommu@lists.linux-foundation.org>;
 Sat, 17 Apr 2021 01:11:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 398BD6064B
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 01:11:35 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FMZjQ2G6gz7vDT;
 Sat, 17 Apr 2021 09:09:14 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.202) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0;
 Sat, 17 Apr 2021 09:11:30 +0800
Subject: Re: [PATCH 0/8] iommu: fix a couple of spelling mistakes detected by
 codespell tool
To: Joerg Roedel <joro@8bytes.org>
References: <20210326062412.1262-1-thunder.leizhen@huawei.com>
 <YHmsQtm4o5f7fAru@8bytes.org>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2025c88d-0711-22c8-3e1c-2d8c9f053fbf@huawei.com>
Date: Sat, 17 Apr 2021 09:11:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YHmsQtm4o5f7fAru@8bytes.org>
Content-Language: en-US
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Will Deacon <will@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>, iommu <iommu@lists.linux-foundation.org>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021/4/16 23:24, Joerg Roedel wrote:
> On Fri, Mar 26, 2021 at 02:24:04PM +0800, Zhen Lei wrote:
>> This detection and correction covers the entire driver/iommu directory.
>>
>> Zhen Lei (8):
>>   iommu/pamu: fix a couple of spelling mistakes
>>   iommu/omap: Fix spelling mistake "alignement" -> "alignment"
>>   iommu/mediatek: Fix spelling mistake "phyiscal" -> "physical"
>>   iommu/sun50i: Fix spelling mistake "consits" -> "consists"
>>   iommu: fix a couple of spelling mistakes
>>   iommu/amd: fix a couple of spelling mistakes
>>   iommu/arm-smmu: Fix spelling mistake "initally" -> "initially"
>>   iommu/vt-d: fix a couple of spelling mistakes
> 
> This patch-set doesn't apply. Please re-send it as a single patch when
> v5.13-rc1 is released.

OK

> 
> Thanks,
> 
> 	Joerg
> 
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
