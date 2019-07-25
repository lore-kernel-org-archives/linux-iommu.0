Return-Path: <SRS0=la/L=VW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1511EC7618B
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 11:31:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D872054F
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 11:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D872054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AD5FCEC9;
	Thu, 25 Jul 2019 11:31:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E0090DC5
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 11:31:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2CCD2701
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 11:31:20 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 49FF142CD2EDFF41F924;
	Thu, 25 Jul 2019 19:31:18 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS414-HUB.china.huawei.com
	(10.3.19.214) with Microsoft SMTP Server id 14.3.439.0;
	Thu, 25 Jul 2019 19:31:12 +0800
Subject: Re: [RFC PATCH v2 18/19] iommu/arm-smmu-v3: Reduce contention during
	command-queue insertion
To: Will Deacon <will@kernel.org>
References: <20190711171927.28803-1-will@kernel.org>
	<20190711171927.28803-19-will@kernel.org>
	<b6302fdf-29ef-0aa2-ae7a-ed21c506c6ec@huawei.com>
	<20190724143355.r2zw6z37igwav2ki@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <de49178c-0628-e759-fcc0-aabd7e86337c@huawei.com>
Date: Thu, 25 Jul 2019 12:31:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190724143355.r2zw6z37igwav2ki@willie-the-truck>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Will,

>>> +		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
>>
>> I added some basic debug to the stress test on your branch, and this cmpxchg
>> was failing ~10 times on average on my D06.
>>
>> So we're not using the spinlock now, but this cmpxchg may lack fairness.
>
> It definitely lacks fairness, although that's going to be the case in many
> other places where locking is elided as well. If it shows up as an issue, we
> should try to address it, but queueing means serialisation and that largely
> defeats the point of this patch. I also don't expect it to be a problem
> unless the cmpxchg() is heavily contended, which shouldn't be the case if
> we're batching.
>
>> Since we're batching commands, I wonder if it's better to restore the
>> spinlock and send batched commands + CMD_SYNC under the lock, and then wait
>> for the CMD_SYNC completion outside the lock.
>
> Again, we'd need some numbers, but my concern with that approach is that
> we're serialising CPUs which is what I've been trying hard to avoid.

That makes sense about the serialisation.

I'm just concerned with the scenario when the queue is heavily 
contented; here we may be gathering multiple batches of commands, and 
owners and non-owners a. may delay each other in writing the commands b. 
also pend the final CMD_SYNC consumption, which is for all gathered 
commands, and not just the commands which a particular CPU is interested in.

It
> also doesn't let you straightforwardly remove the cmpxchg() loop, since
> the owner clears the OWNED flag and you probably wouldn't want to hold
> the lock for that.
>
>> I don't know if it improves the queue contetion, but at least the prod
>> pointer would be more closely track the issued commands, such that we're not
>> waiting to kick off many gathered batches of commands, while the SMMU HW may
>> be idle (in terms of command processing).
>
> Again, probably going to need some numbers to change this, although it
> sounds like your other suggestion about having the owner move prod twice
> would largely address your concerns.

Limited initial testing shows that it makes little difference...

  Reintroducing the lock, on the other
> hand, feels like a big step backwards to me, and the whole reason I started
> down the current route was because of vague claims that the locking was a
> problem for large systems.

To me, the biggest improvement is batching of the commands, and it may 
not make much difference either way in how we deal with submitting them 
to the queue.

Cheers,
John

>
> Thanks,
>
> Will
>
> .
>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
