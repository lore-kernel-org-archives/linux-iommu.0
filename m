Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168E3C4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 16:41:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819A561050
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 16:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 819A561050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43DC36062D;
	Mon,  2 Aug 2021 16:41:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vpiYQPMHBLlg; Mon,  2 Aug 2021 16:41:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 239AA60644;
	Mon,  2 Aug 2021 16:41:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECC07C001B;
	Mon,  2 Aug 2021 16:41:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A80B8C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 16:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 925AA60644
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 16:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U4-RyDVVV0_D for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 16:41:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 90B876062D
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 16:41:21 +0000 (UTC)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdkKL5RtDz6FFxb;
 Tue,  3 Aug 2021 00:41:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 2 Aug 2021 18:41:18 +0200
Received: from [10.47.87.154] (10.47.87.154) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 17:41:17 +0100
Subject: Re: [PATCH v4 5/6] iova: Add iova_len argument to init_iova_domain()
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-6-git-send-email-john.garry@huawei.com>
 <20210802150644.GD28735@willie-the-truck>
 <c6be0b9f-531b-dc12-2747-3acbecfcd531@huawei.com>
 <1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <a7c2ce29-ca28-83a3-6432-a508df9825ac@huawei.com>
Date: Mon, 2 Aug 2021 17:40:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.87.154]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
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
> On 2021-08-02 17:06, John Garry wrote:
>> On 02/08/2021 16:06, Will Deacon wrote:
>>> On Wed, Jul 14, 2021 at 06:36:42PM +0800, John Garry wrote:
>>>> Add max opt argument to init_iova_domain(), and use it to set the 
>>>> rcaches
>>>> range.
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

As I see, the rcache stuff isn't really specific to IOVA anyway, so it 
seems sane.

> 
> Does that sound like crazy talk to you, or an idea worth entertaining?

If you're going to start moving things, has anyone considered putting 
rcache support in lib as a generic solution to "Magazines and Vmem: .." 
paper?

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
