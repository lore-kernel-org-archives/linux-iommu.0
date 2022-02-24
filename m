Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B61C433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 12:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25C4B61043;
	Thu, 24 Feb 2022 12:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AbsX4AFpzckL; Thu, 24 Feb 2022 12:57:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EE92A6102F;
	Thu, 24 Feb 2022 12:57:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B594FC001A;
	Thu, 24 Feb 2022 12:57:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A1BBC0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 12:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E85D061035
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 12:57:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0MMNvScvx6X1 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 12:57:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D71316102F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 12:57:43 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K4CZN0sHcz9t3N;
 Thu, 24 Feb 2022 20:55:56 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 20:57:40 +0800
Subject: Re: [PATCH v4 2/8] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To: John Garry <john.garry@huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
 <helgaas@kernel.org>, <alexander.shishkin@linux.intel.com>,
 <lorenzo.pieralisi@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
 <mike.leach@linaro.org>, <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>, 
 <daniel.thompson@linaro.org>, <joro@8bytes.org>,
 <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <iommu@lists.linux-foundation.org>
References: <20220221084307.33712-1-yangyicong@hisilicon.com>
 <20220221084307.33712-3-yangyicong@hisilicon.com>
 <c7d8cff4-b84e-1b73-1d54-2e221b90dac1@huawei.com>
 <e78f6e5e-a0c3-4976-4f46-e3369635ee3d@huawei.com>
 <aabd5f0a-1a54-e4da-734c-f940c45d66b4@huawei.com>
Message-ID: <a6fb3c8b-1b44-22e8-a178-ba7254a80662@huawei.com>
Date: Thu, 24 Feb 2022 20:57:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <aabd5f0a-1a54-e4da-734c-f940c45d66b4@huawei.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Cc: zhangshaokun@hisilicon.com, liuqi115@huawei.com, linuxarm@huawei.com,
 prime.zeng@huawei.com
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
From: Yicong Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/2/24 20:32, John Garry wrote:
> On 24/02/2022 03:53, Yicong Yang wrote:
>> On 2022/2/22 19:06, John Garry wrote:
>>> On 21/02/2022 08:43, Yicong Yang wrote:
>>>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
>>>> integrated Endpoint(RCiEP) device, providing the capability
>>>> to dynamically monitor and tune the PCIe traffic, and trace
>>>> the TLP headers.
>>>>
>>>> Add the driver for the device to enable the trace function.
>>>> This patch adds basic function of trace, including the device's
>>>> probe and initialization, functions for trace buffer allocation
>>>> and trace enable/disable, register an interrupt handler to
>>>> simply response to the DMA events. The user interface of trace
>>>> will be added in the following patch.
>>>>
>>>
>>> Fill commit message lines upto 75 characters
>>
>> Hi John,
>>
>> Thanks for the comments.
>>
>> The commit message is within 75 characters. I checked again and checkpatch
>> didn't warning for this.
> 
> I mean to fill the lines up as much as possible, upto 75 char max, if not already done so. I am not sure if you are doing this already, but it looks like you were not.
> 
> Checkpatch
> will
> no
> warn
> about
> a
> commit
> message
> like
> this
> :)
> 

Uh I got it. Thanks for the vivid clarification!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
