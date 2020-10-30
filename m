Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEF0C2D0A3
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 01:27:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61023206BE
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 01:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61023206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DAA188643F;
	Fri, 30 Oct 2020 01:27:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eh+l1vhCp+Hw; Fri, 30 Oct 2020 01:27:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 135E184B8F;
	Fri, 30 Oct 2020 01:27:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E800EC088B;
	Fri, 30 Oct 2020 01:27:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA6EEC0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 01:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B4E6A2045C
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 01:27:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Q5EeSN6LPCJ for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 01:27:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by silver.osuosl.org (Postfix) with ESMTPS id 990EB2045B
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 01:27:38 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CMl6b5hklz70G5;
 Fri, 30 Oct 2020 09:27:35 +0800 (CST)
Received: from [10.174.179.62] (10.174.179.62) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 09:27:23 +0800
Subject: Re: [PATCH] iommu/rockchip: check return value of
 of_find_device_by_node() in rk_iommu_of_xlate()
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <heiko@sntech.de>, 
 <jeffy.chen@rock-chips.com>
References: <20201029092202.900218-1-yukuai3@huawei.com>
 <98dec09e-08a1-6550-fa4e-85a8104b90e1@arm.com>
 <35ff5111-1270-fc88-788c-4fb9e38faa85@huawei.com>
 <d5442e6b-2a6b-a8f9-2056-2c0c81e88a01@arm.com>
From: "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <e3805bee-347a-1e66-b2ca-48f06df6f702@huawei.com>
Date: Fri, 30 Oct 2020 09:27:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d5442e6b-2a6b-a8f9-2056-2c0c81e88a01@arm.com>
X-Originating-IP: [10.174.179.62]
X-CFilter-Loop: Reflected
Cc: linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 yi.zhang@huawei.com
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


On 2020/10/29 21:51, Robin Murphy wrote:
> On 2020-10-29 13:19, yukuai (C) wrote:
>>
>> On 2020/10/29 18:08, Robin Murphy wrote:
>>> On 2020-10-29 09:22, Yu Kuai wrote:
>>>> If of_find_device_by_node() failed in rk_iommu_of_xlate(), null pointer
>>>> dereference will be triggered. Thus return error code if
>>>> of_find_device_by_node() failed.
>>>
>>> How can that happen? (Given that ".suppress_bind_attrs = true")
>>>
>>> Robin.
>>
>> I'm not sure if that could happen...
>>
>> My thought is that it's better to do such checking to aviod any possible
>> problem.
> 
> ->of_xlate() is only invoked on the specific set of ops returned by 
> iommu_ops_from_fwnode(). In turn, iommu_ops_from_fwnode() will only 
> return those ops if the driver has successfully probed and called 
> iommu_register_device() with the relevant DT node. For the driver to 
> have been able to probe at all, a platform device associated with that 
> DT node must have been created, and therefore of_find_device_by_node() 
> cannot fail.
> 
> If there ever were some problem serious enough to break that fundamental 
> assumption, then I *want* these drivers to crash right here, with a nice 
> clear stack trace to start debugging from. So no, I firmly disagree that 
> adding redundant code, which will never do anything except attempt to 
> paper over catastrophic memory corruption, is "better". Sorry :)
> 

Sounds reasonable, thanks for your explanation

Yu Kuai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
