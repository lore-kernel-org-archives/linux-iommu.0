Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A9DCA9EBC
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 18:08:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601B721E6F
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 18:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601B721E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DE702DD1;
	Fri, 25 Oct 2019 18:08:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E70EBDBB
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 18:08:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 794D889D
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 18:08:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F46D337;
	Fri, 25 Oct 2019 11:08:44 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7DF453F6C4; 
	Fri, 25 Oct 2019 11:08:43 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH v2 01/10] iommu/io-pgtable: Make selftest gubbins consistently
	__init
Date: Fri, 25 Oct 2019 19:08:30 +0100
Message-Id: <2924fef301cd302135fa0e37e3523f1b465a5456.1572024120.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1572024119.git.robin.murphy@arm.com>
References: <cover.1572024119.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The selftests run as an initcall, but the annotation of the various
callbacks and data seems to be somewhat arbitrary. Add it consistently
for everything related to the selftests.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 15 ++++++++-------
 drivers/iommu/io-pgtable-arm.c     | 13 +++++++------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 4cb394937700..7c3bd2c3cdca 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -846,27 +846,28 @@ struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns = {
 
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
-static struct io_pgtable_cfg *cfg_cookie;
+static struct io_pgtable_cfg *cfg_cookie __initdata;
 
-static void dummy_tlb_flush_all(void *cookie)
+static void __init dummy_tlb_flush_all(void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void dummy_tlb_flush(unsigned long iova, size_t size, size_t granule,
-			    void *cookie)
+static void __init dummy_tlb_flush(unsigned long iova, size_t size,
+				   size_t granule, void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
-			       unsigned long iova, size_t granule, void *cookie)
+static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+				      unsigned long iova, size_t granule,
+				      void *cookie)
 {
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
 
-static const struct iommu_flush_ops dummy_tlb_ops = {
+static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_flush_walk	= dummy_tlb_flush,
 	.tlb_flush_leaf	= dummy_tlb_flush,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index fdc1a8308a1c..afa61b32b052 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1100,22 +1100,23 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
 
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
-static struct io_pgtable_cfg *cfg_cookie;
+static struct io_pgtable_cfg *cfg_cookie __initdata;
 
-static void dummy_tlb_flush_all(void *cookie)
+static void __init dummy_tlb_flush_all(void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void dummy_tlb_flush(unsigned long iova, size_t size, size_t granule,
-			    void *cookie)
+static void __init dummy_tlb_flush(unsigned long iova, size_t size,
+				   size_t granule, void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
-			       unsigned long iova, size_t granule, void *cookie)
+static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+				      unsigned long iova, size_t granule,
+				      void *cookie)
 {
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
