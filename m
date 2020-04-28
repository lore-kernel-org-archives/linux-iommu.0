Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA3C83007
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 12:05:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FFA206E2
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 12:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="W2xarNOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FFA206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D605686FC1;
	Tue, 28 Apr 2020 12:05:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EVAnl2YBMkTg; Tue, 28 Apr 2020 12:05:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF0D487196;
	Tue, 28 Apr 2020 12:05:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EA5EC0889;
	Tue, 28 Apr 2020 12:05:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCE7DC0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BC4D888058
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:40:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O5Nr15dGaN7p for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 11:40:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 91A0E88045
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:40:10 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588074013; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5ADv1bKSrF0UhkCFdxy491HctCoioNlQOQ7fST9NyRI=;
 b=W2xarNOxXUSSFj3hhrHLdhGiKhp1kadEY1rLoCt9JssrTHVpuYu+OkwzyHfHsHzrRomcGVv7
 41UTqlgknqLciXYKEnekVUwptJ3mU5WV/USBsgMCC2aXumI1SEjrr1HDIijcbCXHfbE64xEb
 iovX13rNAQ8jtQYomhHqE6saXyo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea8160a.7f8aacc2b618-smtp-out-n01;
 Tue, 28 Apr 2020 11:39:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id CC897C44792; Tue, 28 Apr 2020 11:39:52 +0000 (UTC)
Received: from blr-ubuntu-31.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A1BDC433BA;
 Tue, 28 Apr 2020 11:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A1BDC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
 jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Subject: [PATCH 4/5] swiotlb: Add API to register new pool
Date: Tue, 28 Apr 2020 17:09:17 +0530
Message-Id: <1588073958-1793-5-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
X-Mailman-Approved-At: Tue, 28 Apr 2020 12:05:44 +0000
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
 alex.bennee@linaro.org, vatsa@codeaurora.org, christoffer.dall@arm.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 pratikp@codeaurora.org, linux-kernel@vger.kernel.org
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

This patch adds an interface for the swiotlb driver to recognize
a new memory pool. Upon successful initialization of the pool,
swiotlb returns a handle, which needs to be passed as an argument
for any future operations on the pool (map/unmap/alloc/free).

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 include/linux/swiotlb.h |  9 ++++++++
 kernel/dma/swiotlb.c    | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 957697e..97ac82a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -182,6 +182,9 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 	return paddr >= swiotlb_start() && paddr < swiotlb_end();
 }
 
+extern struct swiotlb_pool *swiotlb_register_pool(char *name,
+		phys_addr_t start, void *vstart, size_t size);
+
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -236,6 +239,12 @@ static inline void swiotlb_free(struct swiotlb_pool *pool,
 {
 }
 
+static struct swiotlb_pool *swiotlb_register_pool(char *name,
+		phys_addr_t start, void *vstart, size_t size)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7411ce5..9883744 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -36,6 +36,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#include <linux/slab.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
@@ -736,6 +737,65 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
 }
 
+struct swiotlb_pool *swiotlb_register_pool(char *name, phys_addr_t start,
+			void *vstart, size_t size)
+{
+	struct swiotlb_pool *pool;
+	unsigned long i, bytes;
+	unsigned long nslabs;
+
+	nslabs = size >> IO_TLB_SHIFT;
+	if (!nslabs)
+		return ERR_PTR(-EINVAL);
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	bytes = nslabs << IO_TLB_SHIFT;
+
+	strncpy(pool->name, name, sizeof(pool->name));
+	spin_lock_init(&pool->io_tlb_lock);
+	pool->late_alloc = 1;
+	pool->io_tlb_start = start;
+	pool->io_tlb_end = start + bytes;
+	pool->io_tlb_vstart = vstart;
+	pool->io_tlb_nslabs = nslabs;
+	pool->max_segment = rounddown(bytes, PAGE_SIZE);
+
+	/*
+	 * Allocate and initialize the free list array.  This array is used
+	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
+	 * between io_tlb_start and io_tlb_end.
+	 */
+	pool->io_tlb_list = (unsigned int *)__get_free_pages(GFP_KERNEL,
+			get_order(pool->io_tlb_nslabs * sizeof(int)));
+	if (!pool->io_tlb_list)
+		goto cleanup;
+
+	pool->io_tlb_orig_addr = (phys_addr_t *)
+		__get_free_pages(GFP_KERNEL,
+				 get_order(pool->io_tlb_nslabs *
+					   sizeof(phys_addr_t)));
+	if (!pool->io_tlb_orig_addr)
+		goto cleanup;
+
+	for (i = 0; i < pool->io_tlb_nslabs; i++) {
+		pool->io_tlb_list[i] = IO_TLB_SEGSIZE -
+						OFFSET(i, IO_TLB_SEGSIZE);
+		pool->io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+	}
+
+	return pool;
+
+cleanup:
+	kfree(pool->io_tlb_list);
+	kfree(pool->io_tlb_orig_addr);
+	kfree(pool);
+
+	return ERR_PTR(-ENOMEM);
+}
+
 bool is_swiotlb_active(void)
 {
 	/*
-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
