Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD274C433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 15:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 80B4A4043B;
	Tue, 25 Jan 2022 15:02:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BUy4IMuq7V7O; Tue, 25 Jan 2022 15:02:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 17D244052C;
	Tue, 25 Jan 2022 15:02:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D95DDC0031;
	Tue, 25 Jan 2022 15:02:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1122C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 13:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82820403F8
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 13:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MBKERIHiM3i7 for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 13:20:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2790D400D0
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 13:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643116801; x=1674652801;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/+E6KM6MhYotob2Q+ULiwrF3HDRPvMbqv/S7snCErjQ=;
 b=ApkMvOQ0rFj2y4X64ystMfSUelZhk++et9uC/jo8nf4waaW7hJKbULzs
 SQQ3VC8VF37DiChxcnqB+HPAY7N3zVnvlqb1d/BqEAohCN+pEwUobIPTd
 bmEpYdbvTg7pnSgiXusrrYRQW13x6ariXgxF+ZCehwHYVY3M76sZE71Bw
 /c/+MsnMv6b+v7Bs2bxfOt5rCZ2tpZDCt7txxJ6h55Et1JLy8dL7adzWP
 YnZDHxRp/F9IYKfRwoI2JjqlcNwXxZtEWZO3etgSDpoe7O85HVxC2MupX
 AAnlX7dSkDF5b2F+pnfw2ulw4fN/cM1z7w5B8TG1taB6M66D7QFKdrRwR Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="307012191"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; d="scan'208";a="307012191"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2022 05:20:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; d="scan'208";a="534720623"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga008.jf.intel.com with ESMTP; 25 Jan 2022 05:19:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
 id 5193B178; Tue, 25 Jan 2022 15:20:12 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	hch@infradead.org
Subject: [PATCH] swiotlb: Do not zero buffer in set_memory_decrypted()
Date: Tue, 25 Jan 2022 16:20:01 +0300
Message-Id: <20220125132001.37380-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 25 Jan 2022 15:02:10 +0000
Cc: thomas.lendacky@amd.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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

For larger TDX VM, memset() after set_memory_decrypted() in
swiotlb_update_mem_attributes() takes substantial portion of boot time.

Zeroing doesn't serve any functional purpose. Malicious VMM can mess
with decrypted/shared buffer at any point.

Remove the memset().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 kernel/dma/swiotlb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b43..9390b38d2897 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -207,8 +207,6 @@ void __init swiotlb_update_mem_attributes(void)
 	mem->vaddr = swiotlb_mem_remap(mem, bytes);
 	if (!mem->vaddr)
 		mem->vaddr = vaddr;
-
-	memset(mem->vaddr, 0, bytes);
 }
 
 static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
