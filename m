Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF34C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:00:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1B964DA5
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1B964DA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BB93C86277;
	Wed, 27 Jan 2021 20:00:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3D4ydL0hdegP; Wed, 27 Jan 2021 20:00:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7F29C8626D;
	Wed, 27 Jan 2021 20:00:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79BD2C08A1;
	Wed, 27 Jan 2021 20:00:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A743DC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 95D918738A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tU3ElFusiOYz for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 20:00:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 15BE887382
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:48 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50E8964DA4;
 Wed, 27 Jan 2021 20:00:47 +0000 (UTC)
Subject: [PATCH RFC 4/9] iommu/io-pgtable: Introduce map_sg() as a page table
 op
From: Chuck Lever <chuck.lever@oracle.com>
To: baolu.lu@linux.intel.com
Date: Wed, 27 Jan 2021 15:00:46 -0500
Message-ID: <161177764655.1311.6780394066063825590.stgit@manet.1015granger.net>
In-Reply-To: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Cc: isaacm@codeaurora.org, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, will@kernel.org
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

From: Isaac J. Manjarres <isaacm@codeaurora.org>

While mapping a scatter-gather list, iommu_map_sg() calls
into the IOMMU driver through an indirect call, which can
call into the io-pgtable code through another indirect call.

This sequence of going through the IOMMU core code, the IOMMU
driver, and finally the io-pgtable code, occurs for every
element in the scatter-gather list, in the worse case, which
is not optimal.

Introduce a map_sg callback in the io-pgtable ops so that
IOMMU drivers can invoke it with the complete scatter-gather
list, so that it can be processed within the io-pgtable
code entirely, reducing the number of indirect calls, and
boosting overall iommu_map_sg() performance.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/io-pgtable.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index ea727eb1a1a9..6d0e73172603 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -147,6 +147,9 @@ struct io_pgtable_cfg {
  * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
  *
  * @map:          Map a physically contiguous memory region.
+ * @map_sg:       Map a scatter-gather list of physically contiguous memory
+ *                chunks. The mapped pointer argument is used to store how
+ *                many bytes are mapped.
  * @unmap:        Unmap a physically contiguous memory region.
  * @iova_to_phys: Translate iova to physical address.
  *
@@ -156,6 +159,9 @@ struct io_pgtable_cfg {
 struct io_pgtable_ops {
 	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
+	int (*map_sg)(struct io_pgtable_ops *ops, unsigned long iova,
+		      struct scatterlist *sg, unsigned int nents, int prot,
+		      gfp_t gfp, size_t *mapped);
 	size_t (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
 			size_t size, struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
