Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBEAC4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:07:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9784760EB7
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9784760EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 55A2B4029B;
	Wed, 11 Aug 2021 02:07:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C2JIvJ1fnalh; Wed, 11 Aug 2021 02:07:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F23D40242;
	Wed, 11 Aug 2021 02:07:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9789C0010;
	Wed, 11 Aug 2021 02:07:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46222C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28D886079C
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:07:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rUtMbDyt96tO for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:07:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2928F60768
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:07:32 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GktQt1SnGzdZh1;
 Wed, 11 Aug 2021 10:03:50 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 10:07:29 +0800
Received: from [10.174.179.0] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 11 Aug
 2021 10:07:28 +0800
Subject: Re: [PATCH RFC 0/8] iommu/arm-smmu-v3: add support for ECMDQ register
 mode
To: Will Deacon <will@kernel.org>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
 <20210810183529.GC3296@willie-the-truck>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <af0c3116-c110-095d-d250-0b6d56614a0b@huawei.com>
Date: Wed, 11 Aug 2021 10:07:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210810183529.GC3296@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Cc: Robin Murphy <robin.murphy@arm.com>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
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



On 2021/8/11 2:35, Will Deacon wrote:
> On Sat, Jun 26, 2021 at 07:01:22PM +0800, Zhen Lei wrote:
>> SMMU v3.3 added a new feature, which is Enhanced Command queue interface
>> for reducing contention when submitting Commands to the SMMU, in this
>> patch set, ECMDQ is the abbreviation of Enhanced Command Queue.
>>
>> When the hardware supports ECMDQ and each core can exclusively use one ECMDQ,
>> each core does not need to compete with other cores when using its own ECMDQ.
>> This means that each core can insert commands in parallel. If each ECMDQ can
>> execute commands in parallel, the overall performance may be better. However,
>> our hardware currently does not support multiple ECMDQ execute commands in
>> parallel.
>>
>> In order to reuse existing code, I originally still call arm_smmu_cmdq_issue_cmdlist()
>> to insert commands. Even so, however, there was a performance improvement of nearly 12%
>> in strict mode.
>>
>> The test environment is the EMU, which simulates the connection of the 200 Gbit/s NIC.
>> Number of queues:    passthrough   lazy   strict(ECMDQ)  strict(CMDQ)
>>       6                  188        180       162           145        --> 11.7% improvement
>>       8                  188        188       184           183        --> 0.55% improvement
> 
> Sorry, I don't quite follow the numbers here. Why does the number of queues
> affect the classic "CMDQ" mode? We only have one queue there, right?

These queues indicates the network concurrency, maybe I should use channels or threads.
6 means six threads are deployed on different cores using their own channels to send
and receive network packets.

> 
>> In recent days, I implemented a new function without competition with other
>> cores to replace arm_smmu_cmdq_issue_cmdlist() when a core can have an ECMDQ.
>> I'm guessing it might get better performance results. Because the EMU is too
>> slow, it will take a while before the relevant data is available.
> 
> I'd certainly prefer to wait until we have something we know is
> representative. 

Yes, it would be better to have an actual set of performance data. Now the EMU is
used to analyze hardware problems. This test has not been numbered yet.

> However, I can take the first four prep patches now if you
> respin the second one. At least that's then less for you to carry.

Great. Thank you. I will respin the second one.

> 
> I'd also like review from the Arm side on this (and thank you for adopting
> the architecture unlike others seem to have done judging by the patches
> floating around).
> 
> Will
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
