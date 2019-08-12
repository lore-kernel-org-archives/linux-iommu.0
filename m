Return-Path: <SRS0=NGNk=WI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661C3C433FF
	for <iommu@archiver.kernel.org>; Mon, 12 Aug 2019 19:03:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C2B20684
	for <iommu@archiver.kernel.org>; Mon, 12 Aug 2019 19:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l3asKrud";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nlmdTbTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C2B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D502FB3E;
	Mon, 12 Aug 2019 19:03:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6D1FFAD1
	for <iommu@lists.linux-foundation.org>;
	Mon, 12 Aug 2019 19:03:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E458F87B
	for <iommu@lists.linux-foundation.org>;
	Mon, 12 Aug 2019 19:03:14 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AD328609F3; Mon, 12 Aug 2019 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1565636594;
	bh=+MD5LElchqMbgLC+3+P9vMAxbocPXBlWdeP3RWd6oDk=;
	h=From:To:Cc:Subject:Date:From;
	b=l3asKrudoUAE7CgF87q2VGkOkp4swtEZhNPb+uskZNC2m8+HvtjsIJni+IGkUJNLI
	V5tIjeQZegsYj1k0i6cnArr7Wa9nam2m9l+VVnk8dIvzuNBUoYF06hzooz1c9Z5JIj
	ttLqRPrl9VyCeBLf2RunXtqMdhk29MR+m9Yc+Mjk=
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: isaacm@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 740ED6050D;
	Mon, 12 Aug 2019 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1565636593;
	bh=+MD5LElchqMbgLC+3+P9vMAxbocPXBlWdeP3RWd6oDk=;
	h=From:To:Cc:Subject:Date:From;
	b=nlmdTbTvm32M7IXOQXJw6f7XJyYZXQETneNM0FW5ObkoIM+j+m8FlGrtWXDJj+0Xf
	+wc1WsVcko+Bar7TibcAMab3/EpgSkldzfbi+hdKrACo/EgwnMAQzYoYKnJ0j8hnPu
	QGOfORFJQXHhb/t7H6KvvVCjJqksG6JMcct8+T3M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 740ED6050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH] dma-mapping: Use unsigned types for size checks
Date: Mon, 12 Aug 2019 12:03:02 -0700
Message-Id: <1565636582-9802-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, iommu@lists.linux-foundation.org,
	lmark@codeaurora.org, pratikp@codeaurora.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Both the size parameter in the dma_alloc_from_[dev/global]_coherent()
functions and the size field in the dma_coherent_mem structure
are represented by a signed quantity, which makes it so that any
comparisons between these two quantities is a signed comparison.

When a reserved memory region is larger than or equal to 2GB in
size, this will cause the most significant bit to be set to 1,
thus, treating the size as a negative number in signed
comparisons.

This can result in allocation failures when an amount of
memory that is strictly less than 2 GB is requested from
this region. The allocation fails because the signed comparison
to prevent from allocating more memory than what is in the
region in __dma_alloc_from_coherent() evaluates to true since
the size of the region is treated as a negative number, but the
size of the request is treated as a positive number.

Thus, change the type of the size parameter in the allocation
functions to an unsigned type, and change the type of the
size field in the dma_coherent_mem structure to an unsigned type
as well, as it does not make sense for sizes to be represented
by signed quantities.

Fixes: ee7e5516be4f ("generic: per-device coherent dma allocator")
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Cc: stable@vger.kernel.org
---
 include/linux/dma-mapping.h | 6 +++---
 kernel/dma/coherent.c       | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f7d1eea..06d446d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -159,14 +159,14 @@ static inline int is_device_dma_capable(struct device *dev)
  * These three functions are only for dma allocator.
  * Don't use them in device drivers.
  */
-int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
+int dma_alloc_from_dev_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, void **ret);
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
 
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 			    void *cpu_addr, size_t size, int *ret);
 
-void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle);
+void *dma_alloc_from_global_coherent(size_t size, dma_addr_t *dma_handle);
 int dma_release_from_global_coherent(int order, void *vaddr);
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
 				  size_t size, int *ret);
@@ -176,7 +176,7 @@ int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
 
-static inline void *dma_alloc_from_global_coherent(ssize_t size,
+static inline void *dma_alloc_from_global_coherent(size_t size,
 						   dma_addr_t *dma_handle)
 {
 	return NULL;
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 29fd659..c671d5c 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -13,7 +13,7 @@ struct dma_coherent_mem {
 	void		*virt_base;
 	dma_addr_t	device_base;
 	unsigned long	pfn_base;
-	int		size;
+	unsigned long	size;
 	unsigned long	*bitmap;
 	spinlock_t	spinlock;
 	bool		use_dev_dma_pfn_offset;
@@ -136,7 +136,7 @@ void dma_release_declared_memory(struct device *dev)
 EXPORT_SYMBOL(dma_release_declared_memory);
 
 static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
-		ssize_t size, dma_addr_t *dma_handle)
+		size_t size, dma_addr_t *dma_handle)
 {
 	int order = get_order(size);
 	unsigned long flags;
@@ -179,7 +179,7 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
  * Returns 0 if dma_alloc_coherent should continue with allocating from
  * generic memory areas, or !0 if dma_alloc_coherent should return @ret.
  */
-int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
+int dma_alloc_from_dev_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, void **ret)
 {
 	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
@@ -191,7 +191,7 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 	return 1;
 }
 
-void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
+void *dma_alloc_from_global_coherent(size_t size, dma_addr_t *dma_handle)
 {
 	if (!dma_coherent_default_memory)
 		return NULL;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
