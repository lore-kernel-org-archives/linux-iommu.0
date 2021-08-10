Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B74C432BE
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 09:37:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748A961073
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 09:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 748A961073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37B5D404C7;
	Tue, 10 Aug 2021 09:37:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cKkmdCKKc3ri; Tue, 10 Aug 2021 09:37:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 081F3404B8;
	Tue, 10 Aug 2021 09:37:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D30A3C0010;
	Tue, 10 Aug 2021 09:37:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66C2FC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F86B834F1
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tP4rjwJkfHql for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 09:37:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 09F68834EF
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:37:27 +0000 (UTC)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GkSX12Jrkz6C9JD;
 Tue, 10 Aug 2021 17:36:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 10 Aug 2021 11:37:22 +0200
Received: from [10.47.80.4] (10.47.80.4) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 10 Aug
 2021 10:37:21 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>
References: <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
 <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com> <YQF1AKS6Y14dLU/A@T590>
From: John Garry <john.garry@huawei.com>
Message-ID: <dfdd16e8-278f-3bc9-da97-a91264aec909@huawei.com>
Date: Tue, 10 Aug 2021 10:36:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YQF1AKS6Y14dLU/A@T590>
Content-Language: en-US
X-Originating-IP: [10.47.80.4]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
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

On 28/07/2021 16:17, Ming Lei wrote:
>>>> Have you tried turning off the IOMMU to ensure that this is really just
>>>> an IOMMU problem?
>>>>
>>>> You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
>>>> cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
>>>> disabling for kernel drivers).
>>> Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
>>> on this issue.
>> A ~90% throughput drop still seems to me to be too high to be a software
>> issue. More so since I don't see similar on my system. And that throughput
>> drop does not lead to a total CPU usage drop, from the fio log.
>>
>> Do you know if anyone has run memory benchmark tests on this board to find
>> out NUMA effect? I think lmbench or stream could be used for this.
> https://lore.kernel.org/lkml/YOhbc5C47IzC893B@T590/

Hi Ming,

Out of curiosity, did you investigate this topic any further?

And you also asked about my results earlier:

On 22/07/2021 16:54, Ming Lei wrote:
 >> [   52.035895] nvme 0000:81:00.0: Adding to iommu group 5
 >> [   52.047732] nvme nvme0: pci function 0000:81:00.0
 >> [   52.067216] nvme nvme0: 22/0/2 default/read/poll queues
 >> [   52.087318]  nvme0n1: p1
 >>
 >> So I get these results:
 >> cpu0 335K
 >> cpu32 346K
 >> cpu64 300K
 >> cpu96 300K
 >>
 >> So still not massive changes.
 > In your last email, the results are the following with irq mode io_uring:
 >
 >   cpu0  497K
 >   cpu4  307K
 >   cpu32 566K
 >   cpu64 488K
 >   cpu96 508K
 >
 > So looks you get much worse result with real io_polling?
 >

Would the expectation be that at least I get the same performance with 
io_polling here? Anything else to try which you can suggest to 
investigate this lower performance?

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
