Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13870C433E1
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 02:44:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D51220663
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 02:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D51220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 551B1888FC;
	Wed,  3 Jun 2020 02:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZNs9mMKB4Wcj; Wed,  3 Jun 2020 02:44:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4EE2888805;
	Wed,  3 Jun 2020 02:44:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DB91C0865;
	Wed,  3 Jun 2020 02:44:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97419C016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 02:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7AFE720486
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 02:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pjwMuWotadX9 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 02:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by silver.osuosl.org (Postfix) with ESMTPS id F08E62041C
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 02:44:16 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 9B98898D0D4831E0C2FB;
 Wed,  3 Jun 2020 10:44:13 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.193) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 3 Jun 2020 10:44:04 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
 <catalin.marinas@arm.com>
Subject: [PATCH 0/3] support per-numa CMA for ARM server
Date: Wed, 3 Jun 2020 14:42:28 +1200
Message-ID: <20200603024231.61748-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.126.201.193]
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, prime.zeng@hisilicon.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

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

Barry Song (3):
  dma-direct: provide the ability to reserve per-numa CMA
  arm64: mm: reserve hugetlb CMA after numa_init
  arm64: mm: reserve per-numa CMA after numa_init

 arch/arm64/mm/init.c           | 12 ++++++----
 include/linux/dma-contiguous.h |  4 ++++
 kernel/dma/Kconfig             | 10 ++++++++
 kernel/dma/contiguous.c        | 43 +++++++++++++++++++++++++++++++++-
 4 files changed, 63 insertions(+), 6 deletions(-)

-- 
2.23.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
