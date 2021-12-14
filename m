Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E733C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0E4E4024D;
	Tue, 14 Dec 2021 15:16:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Stvic8FG5GLi; Tue, 14 Dec 2021 15:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B4C1A40221;
	Tue, 14 Dec 2021 15:16:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96C3CC002F;
	Tue, 14 Dec 2021 15:16:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A85F3C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 900D640228
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:16:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z0gZDrVfdnC5 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 15:16:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id C566940221
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:16:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01E9ED6E;
 Tue, 14 Dec 2021 07:16:33 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04C473F774;
 Tue, 14 Dec 2021 07:16:31 -0800 (PST)
Message-ID: <c2bad6da-5e3a-5385-25dc-107f90789d00@arm.com>
Date: Tue, 14 Dec 2021 15:16:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] Revert "iommu/arm-smmu-v3: Decrease the queue size of
 evtq and priq"
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>
References: <1638858768-9971-1-git-send-email-wangzhou1@hisilicon.com>
 <20211214144841.GB14837@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211214144841.GB14837@willie-the-truck>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 2021-12-14 14:48, Will Deacon wrote:
> On Tue, Dec 07, 2021 at 02:32:48PM +0800, Zhou Wang wrote:
>> The commit f115f3c0d5d8 ("iommu/arm-smmu-v3: Decrease the queue size of
>> evtq and priq") decreases evtq and priq, which may lead evtq/priq to be
>> full with fault events, e.g HiSilicon ZIP/SEC/HPRE have maximum 1024 queues
>> in one device, every queue could be binded with one process and trigger a
>> fault event. So let's revert f115f3c0d5d8.
>>
>> In fact, if an implementation of SMMU really does not need so long evtq
>> and priq, value of IDR1_EVTQS and IDR1_PRIQS can be set to proper ones.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> I'd like an Ack from Zhen Lei on this, as the aim of the original patch
> was to reduce memory consumption.

I wonder if it's time to start trying to be a bit cleverer than just 
allocating the smallest/largest possible queues, and try to scale them 
to some heuristic of the "size" of the system? Certainly a module 
parameter so that users can manually tune for their system/workload 
might be a reasonable compromise.

I'm also tempted by the idea of trying to dynamically reallocate larger 
queues if they fill up, but I guess that depends on whether it's already 
game over if events or PRI requests are lost...

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
