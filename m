Return-Path: <SRS0=BbwH=5W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC6AC2BA19
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 14:41:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7BB24673
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 14:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j2vrjdnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7BB24673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E36ED87EBD;
	Mon,  6 Apr 2020 14:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gSREMEpw5YxJ; Mon,  6 Apr 2020 14:41:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3B75687E9D;
	Mon,  6 Apr 2020 14:41:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 225F9C089E;
	Mon,  6 Apr 2020 14:41:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E35D5C0177
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 05:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DFD9F848A0
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 05:28:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VbIjhRUwJFUK for <iommu@lists.linux-foundation.org>;
 Mon,  6 Apr 2020 05:28:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A84A78485A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 05:28:43 +0000 (UTC)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0365SdiP033304;
 Mon, 6 Apr 2020 00:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1586150919;
 bh=bqsyJFofXwLipd6/kzIlPGP+VpCPYwO8dYIeN4RkzLo=;
 h=From:To:CC:Subject:Date;
 b=j2vrjdnRdWbm8zLqfAdyLSAcIR/Dd36bngb3I11pg/aZzwIC01gpLDDhYOGG7HhOT
 Kh38yUEW8hBNxXc4296O2Av1MOOdm2pMlr0Ltn+Y8Zjhy/GB0IH3ZaeLS9+f+VGAVo
 PkdWtAvyicg/rYMZMao2NrbrklYMjuOKHp7Dgiq4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0365SdX5020856
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Apr 2020 00:28:39 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Apr
 2020 00:28:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Apr 2020 00:28:39 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0365Sbw8020282;
 Mon, 6 Apr 2020 00:28:37 -0500
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] dma-direct: Fix data truncation in
 dma_direct_get_required_mask()
Date: Mon, 6 Apr 2020 10:58:36 +0530
Message-ID: <20200406052836.25617-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 06 Apr 2020 14:41:53 +0000
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
From: Kishon Vijay Abraham I via iommu <iommu@lists.linux-foundation.org>
Reply-To: Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The upper 32-bit physical address gets truncated inadvertently
when dma_direct_get_required_mask() invokes phys_to_dma_direct().
This results in dma_addressing_limited() return incorrect value
when used in platforms with LPAE enabled.
Fix it here by explicitly type casting 'max_pfn' to phys_addr_t
in order to prevent overflow of intermediate value while evaluating
'(max_pfn - 1) << PAGE_SHIFT'.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Fixes the following WARN DUMP (and hang thereafter) observed when
connecting NVMe card to a platform with ARM LPAE enabled
nvme 0000:01:00.0: overflow 0x000000027b3be000+270336 of DMA mask
ffffffffffffffff bus limit ffffffff
-----------[ cut here ]-----------
WARNING: CPU: 0 PID: 26 at kernel/dma/direct.c:35 report_addr+0xf0/0xf4
Modules linked in:
CPU: 0 PID: 26 Comm: kworker/u4:1 Not tainted 5.5.0-00002-g1383adf7b819 #2
Hardware name: Generic DRA74X (Flattened Device Tree)
Workqueue: writeback wb_workfn (flush-259:0)
(unwind_backtrace) from [<c020b494>] (show_stack+0x10/0x14)
(show_stack) from [<c0a2ae24>] (dump_stack+0x94/0xa8)
(dump_stack) from [<c022bbd8>] (__warn+0xbc/0xd8)
(__warn) from [<c022bc54>] (warn_slowpath_fmt+0x60/0xb8)
(warn_slowpath_fmt) from [<c0299928>] (report_addr+0xf0/0xf4)
(report_addr) from [<c0299ab8>] (dma_direct_map_page+0x18c/0x19c)
(dma_direct_map_page) from [<c0299b2c>] (dma_direct_map_sg+0x64/0xb4)
(dma_direct_map_sg) from [<c071b12c>] (nvme_queue_rq+0x778/0x9ec)
(nvme_queue_rq) from [<c050c8c8>] (__blk_mq_try_issue_directly+0x130/0x1bc)
(__blk_mq_try_issue_directly) from [<c050d1b8>]
(blk_mq_request_issue_directly+0x48/0x78)
(blk_mq_request_issue_directly) from [<c050d22c>]
(blk_mq_try_issue_list_directly+0x44/0xb8)
(blk_mq_try_issue_list_directly) from [<c0511620>]
(blk_mq_sched_insert_requests+0xe0/0x154)
(blk_mq_sched_insert_requests) from [<c050d13c>]
(blk_mq_flush_plug_list+0x150/0x184)
(blk_mq_flush_plug_list) from [<c0502ec4>] (blk_flush_plug_list+0xc8/0xe4)
(blk_flush_plug_list) from [<c050cc44>] (blk_mq_make_request+0x24c/0x3f0)
(blk_mq_make_request) from [<c0501acc>] (generic_make_request+0xb0/0x2d4)
(generic_make_request) from [<c0501d34>] (submit_bio+0x44/0x180)
(submit_bio) from [<c039ad10>] (mpage_writepages+0xac/0xe8)
(mpage_writepages) from [<c02f96dc>] (do_writepages+0x44/0xdc)
(do_writepages) from [<c0384830>] (__writeback_single_inode+0x2c/0x1bc)
(__writeback_single_inode) from [<c0384b98>]
(writeback_sb_inodes+0x1d8/0x404)
(writeback_sb_inodes) from [<c0384e1c>] (__writeback_inodes_wb+0x58/0x9c)
(__writeback_inodes_wb) from [<c0384ff4>] (wb_writeback+0x194/0x1d8)
(wb_writeback) from [<c0386104>] (wb_workfn+0x244/0x33c)
(wb_workfn) from [<c0244ff8>] (process_one_work+0x204/0x458)
(process_one_work) from [<c0245290>] (worker_thread+0x44/0x598)
(worker_thread) from [<c024ab30>] (kthread+0x14c/0x150)
(kthread) from [<c02010d8>] (ret_from_fork+0x14/0x3c)
 kernel/dma/direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index ac7956c38f69..4b24275e306a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -39,7 +39,8 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
-	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
+	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
+	u64 max_dma = phys_to_dma_direct(dev, phys);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
