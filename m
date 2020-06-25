Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4712C433E1
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 07:45:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27A420789
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 07:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27A420789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 728B3228E3;
	Thu, 25 Jun 2020 07:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id obzqOx+FT5Z4; Thu, 25 Jun 2020 07:45:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 88BA1221BB;
	Thu, 25 Jun 2020 07:45:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70744C0863;
	Thu, 25 Jun 2020 07:45:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85DDCC016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 07:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7DEAA8874A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 07:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W-g5Eu0-DYWK for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 07:45:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1A22187EAD
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 07:45:30 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id A5FAE6BBC17D19E99093;
 Thu, 25 Jun 2020 15:45:23 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.118) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 25 Jun 2020 15:45:15 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
 <will@kernel.org>, <ganapatrao.kulkarni@cavium.com>,
 <catalin.marinas@arm.com>
Subject: [PATCH v2 0/2] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
Date: Thu, 25 Jun 2020 19:43:28 +1200
Message-ID: <20200625074330.13668-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.126.203.118]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Ganapatrao Kulkarni has put some effort on making arm-smmu-v3 use local
memory to save command queues[1]. I also did similar job in patch
"iommu/arm-smmu-v3: allocate the memory of queues in local numa node"
[2] while not realizing Ganapatrao did that before.

But it seems it is much better to make dma_alloc_coherent() to be
inherently NUMA-aware on NUMA-capable systems.

Right now, smmu is using dma_alloc_coherent() to get memory to save queues
and tables. Typically, on ARM64 server, there is a default CMA located at
node0, which could be far away from node2, node3 etc.
Saving queues and tables remotely will increase the latency of ARM SMMU
significantly. For example, when SMMU is at node2 and the default global
CMA is at node0, after sending a CMD_SYNC in an empty command queue, we
have to wait more than 550ns for the completion of the command CMD_SYNC.
However, if we save them locally, we only need to wait for 240ns.

with per-numa CMA, smmu will get memory from local numa node to save command
queues and page tables. that means dma_unmap latency will be shrunk much.

Meanwhile, when iommu.passthrough is on, device drivers which call dma_
alloc_coherent() will also get local memory and avoid the travel between
numa nodes.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2017-October/024455.html
[2] https://www.spinics.net/lists/iommu/msg44767.html

-v2: fix some issues reported by kernel test robot;
     fallback to default cma to avoid regression while allocation fails in
     per-numa cma according to Jonathan Cameron's suggestion;
     free memory properly

Barry Song (2):
  dma-direct: provide the ability to reserve per-numa CMA
  arm64: mm: reserve per-numa CMA after numa_init

 arch/arm64/mm/init.c           |  2 +
 include/linux/dma-contiguous.h |  4 ++
 kernel/dma/Kconfig             | 10 ++++
 kernel/dma/contiguous.c        | 99 ++++++++++++++++++++++++++++++----
 4 files changed, 106 insertions(+), 9 deletions(-)

-- 
2.27.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
