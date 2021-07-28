Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84293C4320A
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 10:38:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DF460C3F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 10:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3DF460C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ADBA5400E1;
	Wed, 28 Jul 2021 10:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2XkE7cLBHXI5; Wed, 28 Jul 2021 10:38:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 34D724012C;
	Wed, 28 Jul 2021 10:38:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C599C0010;
	Wed, 28 Jul 2021 10:38:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3351CC000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 10:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21F9A605CB
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 10:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7nvgdQi-B-C3 for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 10:38:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00B4660597
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 10:38:44 +0000 (UTC)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GZVFj46N2z6L9kY;
 Wed, 28 Jul 2021 18:26:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Jul 2021 12:38:41 +0200
Received: from [10.47.27.80] (10.47.27.80) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 11:38:41 +0100
From: John Garry <john.garry@huawei.com>
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>
References: <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
Message-ID: <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
Date: Wed, 28 Jul 2021 11:38:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.47.27.80]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On 28/07/2021 02:32, Ming Lei wrote:
> On Mon, Jul 26, 2021 at 3:51 PM John Garry<john.garry@huawei.com>  wrote:
>> On 23/07/2021 11:21, Ming Lei wrote:
>>>> Thanks, I was also going to suggest the latter, since it's what
>>>> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
>>>> indicative of where the slowness most likely stems from.
>>> The improvement from 'iommu.strict=0' is very small:
>>>
>> Have you tried turning off the IOMMU to ensure that this is really just
>> an IOMMU problem?
>>
>> You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
>> cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
>> disabling for kernel drivers).
> Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
> on this issue.

A ~90% throughput drop still seems to me to be too high to be a software 
issue. More so since I don't see similar on my system. And that 
throughput drop does not lead to a total CPU usage drop, from the fio log.

Do you know if anyone has run memory benchmark tests on this board to 
find out NUMA effect? I think lmbench or stream could be used for this.

Testing network performance in an equivalent fashion to storage could 
also be an idea.

Thanks,
John

> 
> And from fio log, submission latency is good, but completion latency
> is pretty bad,
> and maybe it is something that writing to PCI memory isn't committed to HW in
> time?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
