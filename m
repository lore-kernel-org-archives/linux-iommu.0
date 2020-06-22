Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31486C433E1
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 17:32:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1402320767
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 17:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1402320767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E49E08919B;
	Mon, 22 Jun 2020 17:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIMNR0FUnhiI; Mon, 22 Jun 2020 17:32:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 60B0588DA6;
	Mon, 22 Jun 2020 17:32:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26CF9C0891;
	Mon, 22 Jun 2020 17:32:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C822AC016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B4F4B8918B
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DBuEO3YUpSMI for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 17:32:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AB2C888DA6
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:32:51 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 791CB6476C5AEFFEEC27;
 Tue, 23 Jun 2020 01:32:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 23 Jun 2020 01:32:39 +0800
From: John Garry <john.garry@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
Date: Tue, 23 Jun 2020 01:28:36 +0800
Message-ID: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: trivial@kernel.org, maz@kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

As mentioned in [0], the CPU may consume many cycles processing
arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
get space on the queue takes approx 25% of the cycles for this function.

This series removes that cmpxchg().

For my NVMe test with 3x NVMe SSDs, I'm getting a ~24% throughput
increase:
Before: 1310 IOPs
After: 1630 IOPs

I also have a test harness to check the rate of DMA map+unmaps we can
achieve:

CPU count	32	64	128
Before:		63187	19418	10169
After:		93287	44789	15862

(unit is map+unmaps per CPU per second)

[0] https://lore.kernel.org/linux-iommu/B926444035E5E2439431908E3842AFD24B86DB@DGGEMI525-MBS.china.huawei.com/T/#ma02e301c38c3e94b7725e685757c27e39c7cbde3

John Garry (4):
  iommu/arm-smmu-v3: Fix trivial typo
  iommu/arm-smmu-v3: Calculate bits for prod and owner
  iommu/arm-smmu-v3: Always issue a CMD_SYNC per batch
  iommu/arm-smmu-v3: Remove cmpxchg() in arm_smmu_cmdq_issue_cmdlist()

 drivers/iommu/arm-smmu-v3.c | 233 +++++++++++++++++++++++-------------
 1 file changed, 151 insertions(+), 82 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
