Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6CCC4338F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:39:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762CA6100A
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 762CA6100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2670F4015E;
	Wed, 28 Jul 2021 15:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jS40YrKKa9aT; Wed, 28 Jul 2021 15:39:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A30D44013C;
	Wed, 28 Jul 2021 15:39:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AC58C001A;
	Wed, 28 Jul 2021 15:39:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FBA1C000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 819F04026E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:39:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OzgrDksfUKi1 for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 15:39:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85ED640232
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:39:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 937221FB;
 Wed, 28 Jul 2021 08:39:29 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 750F13F70D;
 Wed, 28 Jul 2021 08:39:28 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>, John Garry <john.garry@huawei.com>
References: <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
 <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com> <YQF1AKS6Y14dLU/A@T590>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e1ec45e5-8e8b-7295-4a95-af6fe92573ee@arm.com>
Date: Wed, 28 Jul 2021 16:39:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQF1AKS6Y14dLU/A@T590>
Content-Language: en-GB
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
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

On 2021-07-28 16:17, Ming Lei wrote:
> On Wed, Jul 28, 2021 at 11:38:18AM +0100, John Garry wrote:
>> On 28/07/2021 02:32, Ming Lei wrote:
>>> On Mon, Jul 26, 2021 at 3:51 PM John Garry<john.garry@huawei.com>  wrote:
>>>> On 23/07/2021 11:21, Ming Lei wrote:
>>>>>> Thanks, I was also going to suggest the latter, since it's what
>>>>>> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
>>>>>> indicative of where the slowness most likely stems from.
>>>>> The improvement from 'iommu.strict=0' is very small:
>>>>>
>>>> Have you tried turning off the IOMMU to ensure that this is really just
>>>> an IOMMU problem?
>>>>
>>>> You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
>>>> cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
>>>> disabling for kernel drivers).
>>> Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
>>> on this issue.
>>
>> A ~90% throughput drop still seems to me to be too high to be a software
>> issue. More so since I don't see similar on my system. And that throughput
>> drop does not lead to a total CPU usage drop, from the fio log.

Indeed, it now sounds like $SUBJECT has been a complete red herring, and 
although the SMMU may be reflecting the underlying slowness it is not in 
fact a significant contributor to it. Presumably perf shows any 
difference in CPU time moving elsewhere once iommu_dma_unmap_sg() is out 
of the picture?

>> Do you know if anyone has run memory benchmark tests on this board to find
>> out NUMA effect? I think lmbench or stream could be used for this.
> 
> https://lore.kernel.org/lkml/YOhbc5C47IzC893B@T590/

Hmm, a ~4x discrepancy in CPU<->memory bandwidth is pretty significant, 
but it's still not the ~10x discrepancy in NVMe throughput. Possibly 
CPU<->PCIe and/or PCIe<->memory bandwidth is even further impacted 
between sockets, or perhaps all the individual latencies just add up - 
that level of detailed performance analysis is beyond my expertise. 
Either way I guess it's probably time to take it up with the system 
vendor to see if there's anything which can be tuned in hardware/firmware.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
