Return-Path: <SRS0=VAik=NT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A35C4320A
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B274F60E52
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B274F60E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BBE083E78;
	Sat, 28 Aug 2021 15:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mD2SeizAA-9T; Sat, 28 Aug 2021 15:38:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CC59D83E4C;
	Sat, 28 Aug 2021 15:38:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A912DC0010;
	Sat, 28 Aug 2021 15:38:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C228C000E
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8807F40330
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="YkoMDdT/";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="FnxDWvPr"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hFtuPXWn2_AA for <iommu@lists.linux-foundation.org>;
 Sat, 28 Aug 2021 15:38:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18E2C400C4
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:27 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 5AF3D580A6E;
 Sat, 28 Aug 2021 11:38:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sat, 28 Aug 2021 11:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=CS8lpBDlbS1UJ
 6ySK75MXPRXLnRGvABr606Ey2hH1vQ=; b=YkoMDdT/TdLNc7bTMVpfEBjGjr0Ap
 0umsopYTDeMEY8rBSk3zT2wuWJTmorm8/7pthF2ePhJUA5nJA61m9P1jaCp+Jg1g
 /0NLNyVTfKDP0jQYQksRSCyh1QPHo5e4358wVVy9zwGvnR3aQfvVqIwdsd483WXn
 sG4pZ1HqruJhl3FvCqs9HrZRl0OYeBwazV5GXhLhQ9yumPY0a3CdI3LbTKAPBOh7
 ZHsxPCBiSWBsK+uKS3UR8IytqhAW/GeAi5uW0zD3tOL7Px8UC78hcTIY8cjWHdSR
 leyAHfu7IIpngorttqf1Znzw83SSGh+qtDqV/y5RMFnJicnc9m1OFqx8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=CS8lpBDlbS1UJ6ySK75MXPRXLnRGvABr606Ey2hH1vQ=; b=FnxDWvPr
 cmTLUO7bMyA/4o2klq5B5fFMp3RlJ7k/6hEw5sHd7pkUX9JPfhygN2RfH5EGnZim
 j8Q/mMR3Rp47kz5wGqtuEe4QKlhALQ+H9fWgYuv4lUnNNBXqMjxUl2/LHnO2H5hh
 rIzsY2UKsG7xelLVhu33/H/56lHV24X74Ktrj6KfyCvKUCyMVVtMtjsLBrHqIpqh
 /MafJuNcbkYjs+9Wdhnqa1DHiMAaQ/wCM1hECclFOEOSrfs+lsQYA+JLWjDggjhX
 3Wh44xXUzja/WndIv1dBhS/JewNq/zh7lAjoYjNhI7O/mK0Pc+K2MFUA+/C21GVe
 sucQS5hyb063XQ==
X-ME-Sender: <xms:cVgqYZp2K04N84W-4GbPnR5S76_7DPvPMmVMggQzsn84a4UDiqmJrw>
 <xme:cVgqYbr3_X6zny24vFKHlYvSu_jrmoEIvKaMvwCxIVMBJFXHHQLsnUvpnU5VGr_X8
 gFMenYZI2jhCwmkSo4>
X-ME-Received: <xmr:cVgqYWPui-H96YeE8MW9kFFOoEluzotn5NWt_xlnNx9yoxw7ocSBYRaShdQSZvC7x_n9fIRk21OrhyH-6BMoliqU4IIGK2AnEAnLwmVRc2qumDv_Ka_Zkn21DUpYag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:cVgqYU7e6KKrncwVjdeWdnEItdIuvx3tX2sw_55auFV5pa73kZqFPg>
 <xmx:cVgqYY5_DGXJQirn63kTaCrOnmKn1krSQ2_Z7CyTpWxlCa994TpVzg>
 <xmx:cVgqYch_unxPYWsnGKQnRUcZxPE4MBkCG6LS9rWGhuQUMjACuV2fYw>
 <xmx:clgqYZEuSkcbuGDZnrTE3ah5U_fSqhCK_wT1MHHvYp5qtNSQjkwNNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:23 -0400 (EDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 6/8] iommu: Move IOMMU pagesize check to attach_device
Date: Sat, 28 Aug 2021 17:36:40 +0200
Message-Id: <20210828153642.19396-7-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210828153642.19396-1-sven@svenpeter.dev>
References: <20210828153642.19396-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, Sven Peter <sven@svenpeter.dev>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Robin Murphy <robin.murphy@arm.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

The iova allocator is capable of handling any granularity which is a power
of two. Remove the much stronger condition that the granularity must be
smaller or equal to the CPU page size from a BUG_ON there.
Instead, check this condition during __iommu_attach_device and fail
gracefully.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/iommu.c | 34 +++++++++++++++++++++++++++++++---
 drivers/iommu/iova.c  |  7 ++++---
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b4499b1915fa..f02b727d3054 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -79,6 +79,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
+static void __iommu_detach_device(struct iommu_domain *domain,
+				  struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
 static void __iommu_detach_group(struct iommu_domain *domain,
@@ -1974,6 +1976,18 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
+static int iommu_check_page_size(struct iommu_domain *domain)
+{
+	if (!(domain->type & __IOMMU_DOMAIN_PAGING))
+		return 0;
+
+	if ((1 << __ffs(domain->pgsize_bitmap)) > PAGE_SIZE) {
+		pr_warn("IOMMU page size cannot represent CPU pages.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
@@ -1983,9 +1997,23 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	ret = domain->ops->attach_dev(domain, dev);
-	if (!ret)
-		trace_attach_device_to_domain(dev);
-	return ret;
+	if (ret)
+		return ret;
+
+	/*
+	 * Check that CPU pages can be represented by the IOVA granularity.
+	 * This has to be done after ops->attach_dev since many IOMMU drivers
+	 * only limit domain->pgsize_bitmap after having attached the first
+	 * device.
+	 */
+	ret = iommu_check_page_size(domain);
+	if (ret) {
+		__iommu_detach_device(domain, dev);
+		return ret;
+	}
+
+	trace_attach_device_to_domain(dev);
+	return 0;
 }
 
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0af42fb93a49..302e6dfa7cdc 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -50,10 +50,11 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 {
 	/*
 	 * IOVA granularity will normally be equal to the smallest
-	 * supported IOMMU page size; both *must* be capable of
-	 * representing individual CPU pages exactly.
+	 * supported IOMMU page size; while both usually are capable of
+	 * representing individual CPU pages exactly the IOVA allocator
+	 * supports any granularities that are an exact power of two.
 	 */
-	BUG_ON((granule > PAGE_SIZE) || !is_power_of_2(granule));
+	BUG_ON(!is_power_of_2(granule));
 
 	spin_lock_init(&iovad->iova_rbtree_lock);
 	iovad->rbroot = RB_ROOT;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
