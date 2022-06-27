Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766F7C43334
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 13:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0215660E00;
	Mon, 27 Jun 2022 13:25:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0215660E00
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ghh3gKK4h3VE; Mon, 27 Jun 2022 13:25:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BFCB260AFA;
	Mon, 27 Jun 2022 13:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFCB260AFA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AC46C0039;
	Mon, 27 Jun 2022 13:25:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5C0DC002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 13:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C4A160B4F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 13:25:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C4A160B4F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Znk0tVL75cfb for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 13:25:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42DBC60AFA
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42DBC60AFA
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 13:25:47 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LWpPD2x5mz9srs;
 Mon, 27 Jun 2022 21:25:04 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 21:25:42 +0800
Subject: Re: [PATCH v9 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
To: Greg KH <gregkh@linuxfoundation.org>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
 <Yrms2cI05O2yZRKU@kroah.com>
Message-ID: <e737393a-56dd-7d24-33d3-e935b14ba758@huawei.com>
Date: Mon, 27 Jun 2022 21:25:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <Yrms2cI05O2yZRKU@kroah.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, prime.zeng@huawei.com, peterz@infradead.org,
 linux-pci@vger.kernel.org, linuxarm@huawei.com, yangyicong@hisilicon.com,
 james.clark@arm.com, will@kernel.org, alexander.shishkin@linux.intel.com,
 mingo@redhat.com, helgaas@kernel.org, liuqi115@huawei.com,
 suzuki.poulose@arm.com, acme@kernel.org, zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org, leo.yan@linaro.org, robin.murphy@arm.com
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

On 2022/6/27 21:12, Greg KH wrote:
> On Mon, Jun 27, 2022 at 07:18:12PM +0800, Yicong Yang wrote:
>> Hi Greg,
>>
>> Since the kernel side of this device has been reviewed for 8 versions with
>> all comments addressed and no more comment since v9 posted in 5.19-rc1,
>> is it ok to merge it first (for Patch 1-3 and 7-8)?
> 
> I am not the maintainer of this subsystem, so I do not understand why
> you are asking me :(
> 

I checked the log of drivers/hwtracing and seems patches of coresight/intel_th/stm
applied by different maintainers and I see you applied some patches of intel_th/stm.
Should any of these three maintainers or you can help applied this?

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
