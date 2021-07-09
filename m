Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8686AC07E99
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 10:27:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E987613CC
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 10:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E987613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD36C6065A;
	Fri,  9 Jul 2021 10:27:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O95UChIdboA2; Fri,  9 Jul 2021 10:27:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6BDA60649;
	Fri,  9 Jul 2021 10:27:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FBECC0010;
	Fri,  9 Jul 2021 10:27:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35DB0C000E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 10:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B8A1421E9
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 10:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TcqnTr29D_UY for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 10:27:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id B7BFE421E2
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 10:27:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D53F5ED1;
 Fri,  9 Jul 2021 03:26:59 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B37B33F5A1;
 Fri,  9 Jul 2021 03:26:58 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
References: <YOgK8fdv7dOQtkET@T590>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
Date: Fri, 9 Jul 2021 11:26:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOgK8fdv7dOQtkET@T590>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org
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

On 2021-07-09 09:38, Ming Lei wrote:
> Hello,
> 
> I observed that NVMe performance is very bad when running fio on one
> CPU(aarch64) in remote numa node compared with the nvme pci numa node.
> 
> Please see the test result[1] 327K vs. 34.9K.
> 
> Latency trace shows that one big difference is in iommu_dma_unmap_sg(),
> 1111 nsecs vs 25437 nsecs.

Are you able to dig down further into that? iommu_dma_unmap_sg() itself 
doesn't do anything particularly special, so whatever makes a difference 
is probably happening at a lower level, and I suspect there's probably 
an SMMU involved. If for instance it turns out to go all the way down to 
__arm_smmu_cmdq_poll_until_consumed() because polling MMIO from the 
wrong node is slow, there's unlikely to be much you can do about that 
other than the global "go faster" knobs (iommu.strict and 
iommu.passthrough) with their associated compromises.

Robin.

> [1] fio test & results
> 
> 1) fio test result:
> 
> - run fio on local CPU
> taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> 
> IOPS: 327K
> avg latency of iommu_dma_unmap_sg(): 1111 nsecs
> 
> 
> - run fio on remote CPU
> taskset -c 80 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> 
> IOPS: 34.9K
> avg latency of iommu_dma_unmap_sg(): 25437 nsecs
> 
> 2) system info
> [root@ampere-mtjade-04 ~]# lscpu | grep NUMA
> NUMA node(s):                    2
> NUMA node0 CPU(s):               0-79
> NUMA node1 CPU(s):               80-159
> 
> lspci | grep NVMe
> 0003:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> 
> [root@ampere-mtjade-04 ~]# cat /sys/block/nvme1n1/device/device/numa_node
> 0
> 
> 
> 
> Thanks,
> Ming
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
