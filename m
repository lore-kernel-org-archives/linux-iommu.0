Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F197C433E6
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:28:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC3C2065D
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC3C2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F100587603;
	Thu, 16 Jul 2020 10:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z_aLycb9Uevf; Thu, 16 Jul 2020 10:28:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3E92B87397;
	Thu, 16 Jul 2020 10:28:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C193C07FF;
	Thu, 16 Jul 2020 10:28:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB07AC0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B66CD8B012
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:28:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kYpYu7YlGRUy for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 10:28:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 80DEE8B045
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:28:22 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 3B92680604F5E70695B5;
 Thu, 16 Jul 2020 11:28:18 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.254) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Jul
 2020 11:28:17 +0100
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
To: Will Deacon <will@kernel.org>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <1592846920-45338-5-git-send-email-john.garry@huawei.com>
 <20200716102037.GB7036@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <36fe9596-745b-b01c-181c-b87a544a413b@huawei.com>
Date: Thu, 16 Jul 2020 11:26:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200716102037.GB7036@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.210.168.254]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: trivial@kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 16/07/2020 11:20, Will Deacon wrote:
> On Tue, Jun 23, 2020 at 01:28:40AM +0800, John Garry wrote:
>> It has been shown that the cmpxchg() for finding space in the cmdq can
>> be a bottleneck:
>> - for more CPUs contending the cmdq, the cmpxchg() will fail more often
>> - since the software-maintained cons pointer is updated on the same 64b
>>    memory region, the chance of cmpxchg() failure increases again
>>
>> The cmpxchg() is removed as part of 2 related changes:
>>
>> - Update prod and cmdq owner in a single atomic add operation. For this, we
>>    count the prod and owner in separate regions in prod memory.
>>
>>    As with simple binary counting, once the prod+wrap fields overflow, they
>>    will zero. They should never overflow into "owner" region, and we zero
>>    the non-owner, prod region for each owner. This maintains the prod
>>    pointer.
>>
>>    As for the "owner", we now count this value, instead of setting a flag.
>>    Similar to before, once the owner has finished gathering, it will clear
>>    a mask. As such, a CPU declares itself as the "owner" when it reads zero
>>    for this region. This zeroing will also clear possible overflow in
>>    wrap+prod region, above.
>>
>>    The owner is now responsible for all cmdq locking to avoid possible
>>    deadlock. The owner will lock the cmdq for all non-owers it has gathered
>>    when they have space in the queue and have written their entries.
>>
>> - Check for space in the cmdq after the prod pointer has been assigned.
>>
>>    We don't bother checking for space in the cmdq before assigning the prod
>>    pointer, as this would be racy.
>>
>>    So since the prod pointer is updated unconditionally, it would be common
>>    for no space to be available in the cmdq when prod is assigned - that
>>    is, according the software-maintained prod and cons pointer. So now
>>    it must be ensured that the entries are not yet written and not until
>>    there is space.
>>
>>    How the prod pointer is maintained also leads to a strange condition
>>    where the prod pointer can wrap past the cons pointer. We can detect this
>>    condition, and report no space here. However, a prod pointer progressed
>>    twice past the cons pointer cannot be detected. But it can be ensured that
>>    this that this scenario does not occur, as we limit the amount of
>>    commands any CPU can issue at any given time, such that we cannot
>>    progress prod pointer further.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 101 ++++++++++++++++++++++--------------
>>   1 file changed, 61 insertions(+), 40 deletions(-)
> 
> I must admit, you made me smile putting trivial@kernel.org on cc for this ;)
> 

Yes, quite ironic :)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
