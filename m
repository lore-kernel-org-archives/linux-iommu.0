Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44462C43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 07:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0AA982BE5;
	Tue, 28 Jun 2022 07:17:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0AA982BE5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I0uKD24h1SJ4; Tue, 28 Jun 2022 07:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B5ABF824B4;
	Tue, 28 Jun 2022 07:17:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5ABF824B4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88B0CC0032;
	Tue, 28 Jun 2022 07:17:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CCA7C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58F7E4027A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:17:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58F7E4027A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TqvcAmAOT0Tl for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:17:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AEA9040496
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEA9040496
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:17:21 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LXG7n0lRdz1L8mG;
 Tue, 28 Jun 2022 15:15:01 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 15:17:15 +0800
Subject: Re: [PATCH v9 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
To: <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
 <suzuki.poulose@arm.com>, Peter Zijlstra <peterz@infradead.org>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
 <Yrms2cI05O2yZRKU@kroah.com>
 <e737393a-56dd-7d24-33d3-e935b14ba758@huawei.com>
 <Yrm4O+AFbgnoBVba@hirez.programming.kicks-ass.net>
Message-ID: <6c923b13-a588-9511-3f94-3241c8aacac5@huawei.com>
Date: Tue, 28 Jun 2022 15:17:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <Yrm4O+AFbgnoBVba@hirez.programming.kicks-ass.net>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Cc: prime.zeng@huawei.com, alexander.shishkin@linux.intel.com,
 linux-pci@vger.kernel.org, linuxarm@huawei.com, yangyicong@hisilicon.com,
 james.clark@arm.com, will@kernel.org, mingo@redhat.com, helgaas@kernel.org,
 liuqi115@huawei.com, acme@kernel.org, zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>,
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

On 2022/6/27 22:01, Peter Zijlstra wrote:
> On Mon, Jun 27, 2022 at 09:25:42PM +0800, Yicong Yang wrote:
>> On 2022/6/27 21:12, Greg KH wrote:
>>> On Mon, Jun 27, 2022 at 07:18:12PM +0800, Yicong Yang wrote:
>>>> Hi Greg,
>>>>
>>>> Since the kernel side of this device has been reviewed for 8 versions with
>>>> all comments addressed and no more comment since v9 posted in 5.19-rc1,
>>>> is it ok to merge it first (for Patch 1-3 and 7-8)?
>>>
>>> I am not the maintainer of this subsystem, so I do not understand why
>>> you are asking me :(
>>>
>>
>> I checked the log of drivers/hwtracing and seems patches of coresight/intel_th/stm
>> applied by different maintainers and I see you applied some patches of intel_th/stm.
>> Should any of these three maintainers or you can help applied this?
> 
> I was hoping Mark would have a look, since he knows this ARM stuff
> better than me. But ISTR he's somewhat busy atm too. But an ACK from the
> CoreSight people would also be appreciated.
> 

Thanks for the instruction.

Hi Mark, Mathieu and Suzuki,

May I have an ack from you to have the driver part of this device merged?

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
