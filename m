Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E85C433E3
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:58:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A85120720
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A85120720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3BF3184471;
	Fri, 21 Aug 2020 13:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ThbPct8nl_b0; Fri, 21 Aug 2020 13:58:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 786AA809D7;
	Fri, 21 Aug 2020 13:58:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6505FC0889;
	Fri, 21 Aug 2020 13:58:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BAEBC0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 97FAD86D2F
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:58:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gi01AVMcswU6 for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:58:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3122486D5D
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:58:21 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 1382B9333EB0FF14B947;
 Fri, 21 Aug 2020 21:58:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 21:58:04 +0800
From: John Garry <john.garry@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v2 0/2] iommu/arm-smmu-v3: Improve cmdq lock efficiency
Date: Fri, 21 Aug 2020 21:54:20 +0800
Message-ID: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
get space on the queue takes a lot of time once we start getting many
CPUs contending - from experiment, for 64 CPUs contending the cmdq,
success rate is ~ 1 in 12, which is poor, but not totally awful.

This series removes that cmpxchg() and replaces with an atomic_add,
same as how the actual cmdq deals with maintaining the prod pointer.

For my NVMe test with 3x NVMe SSDs, I'm getting a ~24% throughput
increase:
Before: 1250K IOPs
After: 1550K IOPs

I also have a test harness to check the rate of DMA map+unmaps we can
achieve:

CPU count	8	16	32	64
Before:		282K	115K	36K	11K
After:		302K	193K	80K	30K

(unit is map+unmaps per CPU per second)

[0] https://lore.kernel.org/linux-iommu/B926444035E5E2439431908E3842AFD24B86DB@DGGEMI525-MBS.china.huawei.com/T/#ma02e301c38c3e94b7725e685757c27e39c7cbde3

Differences to v1:
- Simplify by dropping patch to always issue a CMD_SYNC
- Use 64b atomic add, keeping prod in a separate 32b field

John Garry (2):
  iommu/arm-smmu-v3: Calculate max commands per batch
  iommu/arm-smmu-v3: Remove cmpxchg() in arm_smmu_cmdq_issue_cmdlist()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 166 ++++++++++++++------
 1 file changed, 114 insertions(+), 52 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
