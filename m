Return-Path: <SRS0=zuxH=IW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F98C433DB
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 02:17:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6734F619E5
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 02:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6734F619E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 15EF5403EF;
	Wed, 24 Mar 2021 02:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7dS-fujlL_S9; Wed, 24 Mar 2021 02:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 096F0400D3;
	Wed, 24 Mar 2021 02:17:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC332C000E;
	Wed, 24 Mar 2021 02:17:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D069C000A
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 02:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4BA3C40603
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 02:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5x5L4392CdhQ for <iommu@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 02:17:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBB7540602
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 02:17:17 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4sK51D6czkf2y;
 Wed, 24 Mar 2021 10:15:37 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 10:17:03 +0800
From: Tian Tao <tiantao6@hisilicon.com>
To: <akpm@linux-foundation.org>, <peterz@infradead.org>, <paulmck@kernel.org>, 
 <ast@kernel.org>, <tglx@linutronix.de>, <rostedt@goodmis.org>, <hch@lst.de>,
 <m.szyprowski@samsung.com>, <song.bao.hua@hisilicon.com>
Subject: [PATCH] dma-mapping: make map_benchmark compile into module
Date: Wed, 24 Mar 2021 10:17:38 +0800
Message-ID: <1616552258-22282-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Cc: Tian Tao <tiantao6@hisilicon.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

under some scenarios, it is necessary to compile map_benchmark
into module to test iommu, so this patch changed Kconfig and
export_symbol to implement map_benchmark compiled into module.

On the other hand, map_benchmark is a driver, which is supposed
to be able to run as a module.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 kernel/dma/Kconfig | 2 +-
 kernel/kthread.c   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 77b4055..0468293 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -223,7 +223,7 @@ config DMA_API_DEBUG_SG
 	  If unsure, say N.
 
 config DMA_MAP_BENCHMARK
-	bool "Enable benchmarking of streaming DMA mapping"
+	tristate "Enable benchmarking of streaming DMA mapping"
 	depends on DEBUG_FS
 	help
 	  Provides /sys/kernel/debug/dma_map_benchmark that helps with testing
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1578973..fa4736f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -455,6 +455,7 @@ void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
 {
 	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
 }
+EXPORT_SYMBOL(kthread_bind_mask);
 
 /**
  * kthread_bind - bind a just-created kthread to a cpu.
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
