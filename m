Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34AEC4332F
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 12:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A8FA60BB0;
	Wed,  9 Feb 2022 12:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AgkNhA61zzaw; Wed,  9 Feb 2022 12:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 05E3C60B25;
	Wed,  9 Feb 2022 12:23:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE91FC0011;
	Wed,  9 Feb 2022 12:23:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87F47C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 12:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7736A410E0
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 12:23:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HVcVQ3f4Y7zJ for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:23:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1E09410E4
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 12:23:26 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id 10so2072192plj.1
 for <iommu@lists.linux-foundation.org>; Wed, 09 Feb 2022 04:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hh4jMpg8FB1udogjbNB+Sii1QdXJESjYTwcDUY5y0oA=;
 b=cF+q4qc+10FcqXJ8k2pqRoWI7jFembF/aqdarCrJ1AO8/X3Oj/pMSLDWR3uFLaiqbx
 ogg4igUDarQ6aNTxpXknpQQdyqMlx2Ofte7Q3OUbMyCX8Zua829jgVwALeSVW+iY0Sbu
 N4AeJqVaOgXcus8bPtpRdjgBs4QLjAj3fSQ8fuCFMXa6yzpyGhHrDrf1WyQqQL4aSCi2
 njAAlOijFTduqU6h/7zBbE3IRPqrsln+A+GHDRbn37vHXXPAUulgOyZQ9qbtzP0HN2L7
 phuu7tbw6SxC6CvkqubBW9GD/UztSvCy+22LSQfLferlOFm0+21yNOO/FDVA1Y2khjCz
 nAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hh4jMpg8FB1udogjbNB+Sii1QdXJESjYTwcDUY5y0oA=;
 b=WUl2Yi7t56e4buM0tJJPqGck+I5O1T/hWKpC9X9Pq3d5cAy5znCYs/Ve+sGtUPcXlU
 4IaA8Ao3ZHFPWgXngnaWuF2i230OiNuaLYo0bm2lbIKUxxUz7h4CHBJnjNFRE/PMdmSD
 1JycLK3B53bXqqf0xRp6MjiAXJev66SUpt3aiZoS6y0MS2IBhA5AmroGJY/7/rAeh5Wt
 /i2D1HeVbLdCb+zBGeEJPYb01ts9pu+xlHEpilXPUOn4Y8AFktzzvdUBqPlnpYTnBLFG
 gcetS4wDJnWO2ZVy9ho5FFLaZH4P7ISNJYcaC3vjzdh8bmJfnPmlCK+hN2A8Jw8izdyz
 yfRQ==
X-Gm-Message-State: AOAM530q0U5BWB/azdwiQF80MCpTAtG/ctFMP4MKKyCzrL/23c+Lcjyt
 Zy7Fn1TH0b72/E6oeZnbod0=
X-Google-Smtp-Source: ABdhPJwnZIrLHzT8/ZP+XssNQ0ZTkXO6ZjeqNb4h3vsPFa2mZJZ7cvEKT6w/iNJdXHcvAllSyeKYjg==
X-Received: by 2002:a17:90b:4acb:: with SMTP id
 mh11mr2285572pjb.72.1644409406297; 
 Wed, 09 Feb 2022 04:23:26 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:a:9d5c:32bf:5c81:da87])
 by smtp.gmail.com with ESMTPSA id lb3sm6300990pjb.47.2022.02.09.04.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 04:23:26 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, hch@infradead.org, m.szyprowski@samsung.com,
 robin.murphy@arm.com, michael.h.kelley@microsoft.com
Subject: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Date: Wed,  9 Feb 2022 07:23:01 -0500
Message-Id: <20220209122302.213882-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209122302.213882-1-ltykernel@gmail.com>
References: <20220209122302.213882-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 hch@lst.de
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

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V Isolation VM and AMD SEV VM uses swiotlb bounce buffer to
share memory with hypervisor. Current swiotlb bounce buffer is only
allocated from 0 to ARCH_LOW_ADDRESS_LIMIT which is default to
0xffffffffUL. Isolation VM and AMD SEV VM needs 1G bounce buffer at most.
This will fail when there is not enough memory from 0 to 4G address
space and devices also may use memory above 4G address space as DMA memory.
Expose swiotlb_alloc_from_low_pages and platform mey set it to false when
it's not necessary to limit bounce buffer from 0 to 4G memory.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/swiotlb.h |  1 +
 kernel/dma/swiotlb.c    | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f6c3638255d5..2b4f92668bc7 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -39,6 +39,7 @@ enum swiotlb_force {
 extern void swiotlb_init(int verbose);
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 unsigned long swiotlb_size_or_default(void);
+void swiotlb_set_alloc_from_low_pages(bool low);
 extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
 extern int swiotlb_late_init_with_default_size(size_t default_size);
 extern void __init swiotlb_update_mem_attributes(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b43..62bf8b5cc3e4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -73,6 +73,8 @@ enum swiotlb_force swiotlb_force;
 
 struct io_tlb_mem io_tlb_default_mem;
 
+static bool swiotlb_alloc_from_low_pages = true;
+
 phys_addr_t swiotlb_unencrypted_base;
 
 /*
@@ -116,6 +118,11 @@ void swiotlb_set_max_segment(unsigned int val)
 		max_segment = rounddown(val, PAGE_SIZE);
 }
 
+void swiotlb_set_alloc_from_low_pages(bool low)
+{
+	swiotlb_alloc_from_low_pages = low;
+}
+
 unsigned long swiotlb_size_or_default(void)
 {
 	return default_nslabs << IO_TLB_SHIFT;
@@ -284,8 +291,15 @@ swiotlb_init(int verbose)
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
 		return;
 
-	/* Get IO TLB memory from the low pages */
-	tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+	/*
+	 * Get IO TLB memory from the low pages if swiotlb_alloc_from_low_pages
+	 * is set.
+	 */
+	if (swiotlb_alloc_from_low_pages)
+		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+	else
+		tlb = memblock_alloc(bytes, PAGE_SIZE);
+
 	if (!tlb)
 		goto fail;
 	if (swiotlb_init_with_tbl(tlb, default_nslabs, verbose))
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
