Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2C0C433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 08:45:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489C96124A
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 08:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 489C96124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BC6C4052E;
	Tue, 21 Sep 2021 08:45:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zO3BppKyDmT4; Tue, 21 Sep 2021 08:45:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E8CB040533;
	Tue, 21 Sep 2021 08:45:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B966C0020;
	Tue, 21 Sep 2021 08:45:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11ED0C000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 08:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E77C740528
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 08:45:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id essIRKf5jLYA for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 08:45:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 428704051A
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 08:45:35 +0000 (UTC)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HDFLb5jzPz67lZq;
 Tue, 21 Sep 2021 16:43:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 10:45:31 +0200
Received: from [10.47.88.85] (10.47.88.85) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 09:45:30 +0100
Subject: Re: [PATCH v4 5/6] iova: Add iova_len argument to init_iova_domain()
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-6-git-send-email-john.garry@huawei.com>
 <20210802150644.GD28735@willie-the-truck>
 <c6be0b9f-531b-dc12-2747-3acbecfcd531@huawei.com>
 <1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <4add7fb2-e9de-9c15-1915-6a6e2596941d@huawei.com>
Date: Tue, 21 Sep 2021 09:48:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.88.85]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, sakari.ailus@linux.intel.com, mst@redhat.com,
 airlied@linux.ie, gregkh@linuxfoundation.org, linuxarm@huawei.com,
 jonathanh@nvidia.com, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, daniel@ffwll.ch, bingbu.cao@intel.com,
 digetx@gmail.com, mchehab@kernel.org, jasowang@redhat.com,
 tian.shu.qiu@intel.com
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

On 02/08/2021 17:16, Robin Murphy wrote:
>>>>
>>>> Also fix up all users to set this value (at 0, meaning use default).
>>> Wrap that in init_iova_domain_defaults() to avoid the mysterious 0?
>>
>> Sure, I can do something like that. I actually did have separate along 
>> those lines in v3 before I decided to change it.
> 
> Y'know, at this point I'm now starting to seriously wonder whether 
> moving the rcaches into iommu_dma_cookie wouldn't make a whole lot of 
> things simpler... :/
> 
> Does that sound like crazy talk to you, or an idea worth entertaining?

Hi Robin,

JFYI, to try to make inroads into my IOVA issues, I'm going to look to 
do this first, if you don't mind. I think that the fq stuff can also be 
put into a separate structure also, rather than iova_domain, and that 
can also be a member of iommu_dma_cookie.

BTW, with regards to separating the rcache magazine code out, I see 
someone already trying to introduce something similar:

https://lore.kernel.org/lkml/CAKW4uUxperg41z8Lu5QYsS-YEGt1anuD1CuiUqXC0ANFqJBosQ@mail.gmail.com/T/#me4cc5de775ad16ab3d6e7ca854b55f274ddcba08

https://lore.kernel.org/lkml/YUkErK1vVZMht4s8@casper.infradead.org/T/#t

Cheers,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
