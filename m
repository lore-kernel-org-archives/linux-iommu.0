Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD724C282CE
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 21:59:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9102A2082A
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 21:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9102A2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5F6E71C21;
	Wed, 10 Apr 2019 21:59:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C36D61A8C
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 21:59:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 79135174
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 21:59:27 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA9212C971E;
	Wed, 10 Apr 2019 21:59:26 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-118-18.phx2.redhat.com [10.3.118.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 28A375D704;
	Wed, 10 Apr 2019 21:59:26 +0000 (UTC)
From: Scott Wood <swood@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] dma-debug: Only skip one stackframe entry
Date: Wed, 10 Apr 2019 16:59:25 -0500
Message-Id: <20190410215925.8458-1-swood@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 10 Apr 2019 21:59:27 +0000 (UTC)
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, Scott Wood <swood@redhat.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190410215925.6pkZ7zFMNWi5_9OLJA664X2H0Xd5CK5x8SJGNUK843I@z>

With skip set to 1, I get a traceback like this:

[  106.867637] DMA-API: Mapped at:
[  106.870784]  afu_dma_map_region+0x2cd/0x4f0 [dfl_afu]
[  106.875839]  afu_ioctl+0x258/0x380 [dfl_afu]
[  106.880108]  do_vfs_ioctl+0xa9/0x720
[  106.883688]  ksys_ioctl+0x60/0x90
[  106.887007]  __x64_sys_ioctl+0x16/0x20

With the previous value of 2, afu_dma_map_region was being omitted.  I
suspect that the code paths have simply changed since the value of 2 was
chosen a decade ago, but it's also possible that it varies based on which
mapping function was used, compiler inlining choices, etc.  In any case,
it's best to err on the side of skipping less.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 45d51e8e26f6..a218e43cc382 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -706,7 +706,7 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 #ifdef CONFIG_STACKTRACE
 	entry->stacktrace.max_entries = DMA_DEBUG_STACKTRACE_ENTRIES;
 	entry->stacktrace.entries = entry->st_entries;
-	entry->stacktrace.skip = 2;
+	entry->stacktrace.skip = 1;
 	save_stack_trace(&entry->stacktrace);
 #endif
 
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
