Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85300C4338F
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 15:57:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AD6608FC
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 15:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33AD6608FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02BCB83BC2;
	Fri,  6 Aug 2021 15:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oUSnqbCuLWEe; Fri,  6 Aug 2021 15:57:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EEEE783BBC;
	Fri,  6 Aug 2021 15:57:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD01CC0010;
	Fri,  6 Aug 2021 15:57:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BD07C000E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 15:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFCF960859
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 15:56:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="RCt1xOTZ";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="hYlOzO1I"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t9MWYiCsWXoy for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 15:56:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CA3F6076A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 15:56:57 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id B74EB5C0165;
 Fri,  6 Aug 2021 11:56:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 06 Aug 2021 11:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=MjDkHStOQ/clx
 cFNpVi2F5U4aoR8QeJ+BGXLAvk/tkg=; b=RCt1xOTZ9TmHYCAFogxZycD0nOR+o
 83SDF1fFCjAjN2ErPGE43WnEqUkIYpVOjRE4ZHJ0utLqXeyIG2baKLKl9tO7uq1P
 RrC0e1dsfFvN4pbBFP2AFoJ8RHJ7eVSDkRzJyNX9Cfjx5epPxMVjP5/WdxAvkTO6
 Zdlris+q7LoWz1AKdTrFAxLBSUHI7LzMiLB9kXUMJoTfR4am9LAXqQ7QFwKxJP90
 ZRUNu+r5OXSMNtAvxk+PjsEdVu81cvvJ+nVCgzC+aGQGCT9aYNGtlFNUTb2rw0MB
 RiFatN8Z+l4PVl0DzXyiJsCySWLNEqFcTa5rid/gu3cCehMU1nU6N6rPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=MjDkHStOQ/clxcFNpVi2F5U4aoR8QeJ+BGXLAvk/tkg=; b=hYlOzO1I
 p9szTT5jd2H0Za+UbCJ86nUrzzc65QK54JfUn23K9Djj9tmUGTn80/yA9AXJ99Cl
 Z7oItiq2oKDhj/TMCg+A1QfVxM/aQXVpuCAsPuFj2shidymayNDbdLefK4kuoGHP
 ggjtfp2QJRmvcfnui+Z+hwff9vwHbrK8xSVoCmbU3QpKupMsfsT6O1tNFaKGV3nm
 rbwjb0gh5knlxfuVsG+Bx4BkbFNDkGHLBppppZZjFgAk4OcpCKH32HErYyV1cugU
 biEI+EH1Hl9mABtsk3h7gRXBs0uxQtPNk0dSzE5IEnCg9N0f9JywBB+sZ6+AZc6N
 25Oi/qOGEID3nA==
X-ME-Sender: <xms:yFsNYU36OevGbzCd6dQChzRjyBfY_23dKFI5l73elALSOSesbuKruA>
 <xme:yFsNYfHcgguL0BqxklTm0CjRy1LWSzwo3Fh7qeR6KcQaUJMlu2j0nov9EfsBqZrXE
 aLUG4RTQTX_mJp8Mbc>
X-ME-Received: <xmr:yFsNYc7wxBzuaBzdn8-LhAnf8eAgvA6ZsSPDWc2U65UfCEXVvdGYPwx3C-Wj3lwSQRrWh_4FJw9GKfZM2g4ZFRP__TPsYaXvS1F8EcvenEGLYq7rLVpCgS4rkbOlnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdelvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
 vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
 hnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfefjeen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
 esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:yFsNYd0H_xYD5vJixoy00mCbyOJm02_aGVm_ctAOf5J19lxm_ilVuQ>
 <xmx:yFsNYXGrpg0474eKInbNIxmUQDqpuJ5u38kn_vWUyJZ5Zs8H_meRWw>
 <xmx:yFsNYW8hERlqwB-UQlGtm9Ab-Bht4CjxcCZFJ0rsqQ_jA9X6uCsKjA>
 <xmx:yFsNYdao6WyIeQoL_Bhsj1HrJjJxr8lcXpemOsJ8PUPDVbNoVxJBRQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 11:56:55 -0400 (EDT)
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH 3/3] iommu: Introduce __IOMMU_DOMAIN_LARGE_PAGES
Date: Fri,  6 Aug 2021 17:55:23 +0200
Message-Id: <20210806155523.50429-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210806155523.50429-1-sven@svenpeter.dev>
References: <20210806155523.50429-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Robin Murphy <robin.murphy@arm.com>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

__IOMMU_DOMAIN_LARGE_PAGES indicates that a domain can handle
conditions where PAGE_SIZE might be smaller than the IOMMU page size.
Always allow attaching devices to such domains and set the flag for
IOMMU_DOMAIN_DMA, which can now handle these situations.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/iommu.c |  2 ++
 include/linux/iommu.h | 14 +++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5854a4ef5681..f0bfd76187b1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1970,6 +1970,8 @@ static int iommu_check_page_size(struct iommu_domain *domain)
 {
 	if (!(domain->type & __IOMMU_DOMAIN_PAGING))
 		return 0;
+	if (domain->type & __IOMMU_DOMAIN_LARGE_PAGES)
+		return 0;
 
 	if ((1 << __ffs(domain->pgsize_bitmap)) > PAGE_SIZE) {
 		pr_warn("IOMMU page size cannot represent CPU pages.\n");
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e552ecfefcf7..1f97eac8a4b0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -56,10 +56,13 @@ struct iommu_domain_geometry {
 };
 
 /* Domain feature flags */
-#define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
-#define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
-					      implementation              */
-#define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
+#define __IOMMU_DOMAIN_PAGING       (1U << 0)  /* Support for iommu_map/unmap */
+#define __IOMMU_DOMAIN_DMA_API      (1U << 1)  /* Domain for use in DMA-API
+						   implementation              */
+#define __IOMMU_DOMAIN_PT           (1U << 2)  /* Domain is identity mapped   */
+#define __IOMMU_DOMAIN_LARGE_PAGES  (1U << 3)  /* Domain can handle IOMMU page
+						  sizes larger than the CPU
+						  page size                   */
 
 /*
  * This are the possible domain-types
@@ -77,7 +80,8 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
 #define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
-				 __IOMMU_DOMAIN_DMA_API)
+				 __IOMMU_DOMAIN_DMA_API |       \
+				 __IOMMU_DOMAIN_LARGE_PAGES)
 
 struct iommu_domain {
 	unsigned type;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
