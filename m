Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF9C433EF
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 07:16:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC291610A8
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 07:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC291610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 654B340502;
	Thu,  4 Nov 2021 07:16:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sMgJddqlDBmF; Thu,  4 Nov 2021 07:16:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 55E8640503;
	Thu,  4 Nov 2021 07:16:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D8F9C0019;
	Thu,  4 Nov 2021 07:16:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20085C000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 07:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00CBB80F34
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 07:16:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hqqCnxCbop6z for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 07:16:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BE9580F33
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 07:16:39 +0000 (UTC)
Received: from guri.lan (unknown
 [IPv6:2a0d:6fc0:11c8:f600:2430:3a4b:db98:84e5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C2C9A1F45DE0;
 Thu,  4 Nov 2021 07:16:36 +0000 (GMT)
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu: log iova range in map/unmap trace events
Date: Thu,  4 Nov 2021 09:16:20 +0200
Message-Id: <20211104071620.27290-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Cc: kernel@collabora.com, will@kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

In case of an iommu page fault, the faulting iova is logged in
trace_io_page_fault. It is therefore convenient to log the
iova range in mapping/unmapping trace events so that it is
easier to see if the faulting iova was recently in any of
those ranges.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 include/trace/events/iommu.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 72b4582322ff..29096fe12623 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -101,8 +101,9 @@ TRACE_EVENT(map,
 		__entry->size = size;
 	),
 
-	TP_printk("IOMMU: iova=0x%016llx paddr=0x%016llx size=%zu",
-			__entry->iova, __entry->paddr, __entry->size
+	TP_printk("IOMMU: iova=0x%016llx - 0x%016llx paddr=0x%016llx size=%zu",
+		  __entry->iova, __entry->iova + __entry->size, __entry->paddr,
+		  __entry->size
 	)
 );
 
@@ -124,8 +125,9 @@ TRACE_EVENT(unmap,
 		__entry->unmapped_size = unmapped_size;
 	),
 
-	TP_printk("IOMMU: iova=0x%016llx size=%zu unmapped_size=%zu",
-			__entry->iova, __entry->size, __entry->unmapped_size
+	TP_printk("IOMMU: iova=0x%016llx - 0x%016llx size=%zu unmapped_size=%zu",
+		  __entry->iova, __entry->iova + __entry->size,
+		  __entry->size, __entry->unmapped_size
 	)
 );
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
