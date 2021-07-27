Return-Path: <SRS0=amFV=MT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B2CC43214
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 17:08:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2942861006
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 17:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2942861006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D72B560828;
	Tue, 27 Jul 2021 17:08:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d2KI4Ijv3_TP; Tue, 27 Jul 2021 17:08:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7778E6080D;
	Tue, 27 Jul 2021 17:08:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA5DC001A;
	Tue, 27 Jul 2021 17:08:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87950C000E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 17:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7608E82C61
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 17:08:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GE7OwhQbtriD for <iommu@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 17:08:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1057482A53
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 17:08:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE7981FB;
 Tue, 27 Jul 2021 10:08:11 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A11BF3F70D;
 Tue, 27 Jul 2021 10:08:10 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>
References: <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b74d7025-c452-049f-f9a9-75ba555d029d@arm.com>
Date: Tue, 27 Jul 2021 18:08:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPqYDY9/VAhfHNfU@T590>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
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

On 2021-07-23 11:21, Ming Lei wrote:
> On Thu, Jul 22, 2021 at 06:40:18PM +0100, Robin Murphy wrote:
>> On 2021-07-22 16:54, Ming Lei wrote:
>> [...]
>>>> If you are still keen to investigate more, then can try either of these:
>>>>
>>>> - add iommu.strict=0 to the cmdline
>>>>
>>>> - use perf record+annotate to find the hotspot
>>>>     - For this you need to enable psuedo-NMI with 2x steps:
>>>>       CONFIG_ARM64_PSEUDO_NMI=y in defconfig
>>>>       Add irqchip.gicv3_pseudo_nmi=1
>>>>
>>>>       See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig#n1745
>>>>       Your kernel log should show:
>>>>       [    0.000000] GICv3: Pseudo-NMIs enabled using forced ICC_PMR_EL1
>>>> synchronisation
>>>
>>> OK, will try the above tomorrow.
>>
>> Thanks, I was also going to suggest the latter, since it's what
>> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
>> indicative of where the slowness most likely stems from.
> 
> The improvement from 'iommu.strict=0' is very small:
> 
> [root@ampere-mtjade-04 ~]# cat /proc/cmdline
> BOOT_IMAGE=(hd2,gpt2)/vmlinuz-5.14.0-rc2_linus root=UUID=cff79b49-6661-4347-b366-eb48273fe0c1 ro nvme.poll_queues=2 iommu.strict=0
> 
> [root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> fio-3.27
> Starting 1 process
> Jobs: 1 (f=1): [r(1)][100.0%][r=1530MiB/s][r=392k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=2999: Fri Jul 23 06:05:15 2021
>    read: IOPS=392k, BW=1530MiB/s (1604MB/s)(14.9GiB/10001msec)
> 
> [root@ampere-mtjade-04 ~]# taskset -c 80 ~/git/tools/test/nvme/io_uring 20 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
> test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> fio-3.27
> Starting 1 process
> Jobs: 1 (f=1): [r(1)][100.0%][r=150MiB/s][r=38.4k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=3063: Fri Jul 23 06:05:49 2021
>    read: IOPS=38.4k, BW=150MiB/s (157MB/s)(3000MiB/20002msec)

OK, that appears to confirm that the invalidation overhead is more of a 
symptom than the major contributing factor, which also seems to line up 
fairly well with the other information.

>> FWIW I would expect iommu.strict=0 to give a proportional reduction in SMMU
>> overhead for both cases since it should effectively mean only 1/256 as many
>> invalidations are issued.
>>
>> Could you also check whether the SMMU platform devices have "numa_node"
>> properties exposed in sysfs (and if so whether the values look right), and
>> share all the SMMU output from the boot log?
> 
> No found numa_node attribute for smmu platform device, and the whole dmesg log is
> attached.

Thanks, so it seems like the SMMUs have MSI capability and are correctly 
described as coherent, which means completion polling should be 
happening in memory and so hopefully not contributing much more than a 
couple of cross-socket cacheline migrations and/or snoops. Combined with 
the difference in the perf traces looking a lot smaller than the 
order-of-magnitude difference in the overall IOPS throughput, I suspect 
this is overall SMMU overhead exacerbated by the missing NUMA info. If 
every new 4K block touched by the NVMe means a TLB miss where the SMMU 
has to walk pagetables from the wrong side of the system, I'm sure 
that's going to add up.

I'd suggest following John's suggestion and getting some baseline 
figures for just the cross-socket overhead between the CPU and NVMe with 
the SMMU right out of the picture, then have a hack at the firmware (or 
pester the system vendor) to see how much of the difference you can make 
back up by having the SMMU proximity domains described correctly such 
that there's minimal likelihood of the SMMUs having to make non-local 
accesses to their in-memory data. FWIW I don't think it should be *too* 
hard to disassemble the IORT, fill in the proximity domain numbers and 
valid flags on the SMMU nodes, then assemble it again to load as an 
override (it's anything involving offsets in that table that's a real pain).

Note that you might also need to make sure you have CMA set up and sized 
appropriately with CONFIG_DMA_PERNUMA_CMA enabled to get the full benefit.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
