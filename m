Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399BDC433DF
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 11:32:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B652074B
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 11:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B652074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D10628AE5E;
	Thu, 16 Jul 2020 11:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6YIos3olMKh2; Thu, 16 Jul 2020 11:32:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A7D3B8AE41;
	Thu, 16 Jul 2020 11:32:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 708BAC0893;
	Thu, 16 Jul 2020 11:32:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F571C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 11:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6E4FC86A88
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 11:32:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7UKn_tjFDPe2 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 11:32:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 16FC386A85
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 11:32:21 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 2518E8DCE03CF4265438;
 Thu, 16 Jul 2020 12:32:19 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.254) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Jul
 2020 12:32:18 +0100
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <20200716101940.GA7036@willie-the-truck>
 <20200716102233.GC7036@willie-the-truck>
 <20200716102814.GD7036@willie-the-truck>
 <bd302efa-20d8-e1b3-6a80-db65ab5ad752@huawei.com>
 <aef1e4a4-d594-f477-9029-8f4295bb9f6c@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <eba2b8f4-2e3c-5e1d-b0b3-0d76a10c64fa@huawei.com>
Date: Thu, 16 Jul 2020 12:30:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <aef1e4a4-d594-f477-9029-8f4295bb9f6c@arm.com>
Content-Language: en-US
X-Originating-IP: [10.210.168.254]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "trivial@kernel.org" <trivial@kernel.org>,
 "maz@kernel.org" <maz@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On 16/07/2020 12:22, Robin Murphy wrote:
> On 2020-07-16 11:56, John Garry wrote:
>> On 16/07/2020 11:28, Will Deacon wrote:
>>> On Thu, Jul 16, 2020 at 11:22:33AM +0100, Will Deacon wrote:
>>>> On Thu, Jul 16, 2020 at 11:19:41AM +0100, Will Deacon wrote:
>>>>> On Tue, Jun 23, 2020 at 01:28:36AM +0800, John Garry wrote:
>>>>>> As mentioned in [0], the CPU may consume many cycles processing
>>>>>> arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg()
>>>>>> loop to
>>>>>> get space on the queue takes approx 25% of the cycles for this
>>>>>> function.
>>>>>>
>>>>>> This series removes that cmpxchg().
>>>>>
>>>>> How about something much simpler like the diff below? >>
>>>> Ah, scratch that, I don't drop the lock if we fail the cas with it held.
>>>> Let me hack it some more (I have no hardware so I can only build-test
>>>> this).
>>>
>>> Right, second attempt...
>>
>> I can try it, but if performance if not as good, then please check mine
>> further (patch 4/4 specifically) - performance is really good, IMHO.
> 
> Perhaps a silly question (I'm too engrossed in PMU world ATM to get
> properly back up to speed on this), but couldn't this be done without
> cmpxchg anyway? Instinctively it feels like instead of maintaining a
> literal software copy of the prod value, we could resolve the "claim my
> slot in the queue" part with atomic_fetch_add on a free-running 32-bit
> "pseudo-prod" index, then whoever updates the hardware deals with the
> truncation and wrap bit to convert it to an actual register value.
> 

That's what mine does. But I also need to take care of cmdq locking and 
how we unconditionally provide space.

Cheers,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
