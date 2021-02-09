Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D6AC433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:22:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A1564EBC
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A1564EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 46C7786132;
	Tue,  9 Feb 2021 06:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zol2K6A9uhZT; Tue,  9 Feb 2021 06:22:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A486D85FD0;
	Tue,  9 Feb 2021 06:22:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD6DC0174;
	Tue,  9 Feb 2021 06:22:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A699C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ED04086F8D
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uhzdx5YJbbbd for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 06:22:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0868686F82
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:22:13 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id j5so3020711pgb.11
 for <iommu@lists.linux-foundation.org>; Mon, 08 Feb 2021 22:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WvKUPmchuhcE1zfso8bHoA3z2cJUHyqor/xynDrdSzc=;
 b=WmMoRPfwVrKkMTfzfSeApWYOsANXGiOgA3320pKWhEerXc+d04kio6kBo6Samikmhh
 dKY6FAm9apY748uamOD6+T+Q7zkEWfp30SA3fCJNtSNB7CjdS5M+/v04eEEHZ9JPhbQU
 oGnPa5k409EctotY2FmiW01VL+4N5+/MQmqlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WvKUPmchuhcE1zfso8bHoA3z2cJUHyqor/xynDrdSzc=;
 b=Q11yokYVCUinGBgf/AMaTfSeObo87qg5BvWGS45zTxT5MMQK6AQxCyuf5StQeUz5xo
 /bmYYdHoEfkGcYwRcRO4RHC5Wjv5eZYytWo/o4wYF+T+FYvYNkDzD4P1FSWHAgzqIJXB
 j9RwTfUUPaNAyuilFer/4WYydN+OjBsibg1izNPv33Q9toyHCqgPu3lxqdb36xuEhAjY
 k1zYms6zIcFIYcmf6k/CU5fuM/tkBQUBSMbXhetHpgFKQitCh69102i+0JhDyZUOh4uC
 Hi+/nijekBZmc/Nd/VntLgFs/N/xe/CeQvrp8P2l2NGRzkV41QJkj4B4KYrPXl2BJDzy
 vVUw==
X-Gm-Message-State: AOAM5304puE+auaHCW6/+tIR6gMcHnjCI5bFtdfOIj8hRWNGhHvXVQ7c
 8spAwzzhtwFuF5aFKDUtYy/Pbw==
X-Google-Smtp-Source: ABdhPJwPilLMeHO4izUWlTNwHOL/6AulGQdpqWdqLrBPBm35gr6jqlo9rCgrJT+lklmP7VdqmUgqQg==
X-Received: by 2002:a63:80c8:: with SMTP id j191mr1570888pgd.58.1612851732543; 
 Mon, 08 Feb 2021 22:22:12 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
 by smtp.gmail.com with UTF8SMTPSA id w1sm14605147pfg.116.2021.02.08.22.22.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 22:22:11 -0800 (PST)
From: Claire Chang <tientzu@chromium.org>
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 04/14] swiotlb: Refactor swiotlb_late_init_with_tbl
Date: Tue,  9 Feb 2021 14:21:21 +0800
Message-Id: <20210209062131.2300005-5-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Nicolas Boichat <drinkcat@chromium.org>, Claire Chang <tientzu@chromium.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>
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

Refactor swiotlb_late_init_with_tbl to make the code reusable for
restricted DMA pool initialization.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 65 ++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 28b7bfe7a2a8..dc37951c6924 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -353,20 +353,21 @@ static void swiotlb_cleanup(void)
 	max_segment = 0;
 }
 
-int
-swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+static int swiotlb_init_tlb_pool(struct swiotlb *swiotlb, phys_addr_t start,
+				size_t size)
 {
-	struct swiotlb *swiotlb = &default_swiotlb;
-	unsigned long i, bytes;
+	unsigned long i;
+	void *vaddr = phys_to_virt(start);
 
-	bytes = nslabs << IO_TLB_SHIFT;
+	size = ALIGN(size, 1 << IO_TLB_SHIFT);
+	swiotlb->nslabs = size >> IO_TLB_SHIFT;
+	swiotlb->nslabs = ALIGN(swiotlb->nslabs, IO_TLB_SEGSIZE);
 
-	swiotlb->nslabs = nslabs;
-	swiotlb->start = virt_to_phys(tlb);
-	swiotlb->end = swiotlb->start + bytes;
+	swiotlb->start = start;
+	swiotlb->end = swiotlb->start + size;
 
-	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
-	memset(tlb, 0, bytes);
+	set_memory_decrypted((unsigned long)vaddr, size >> PAGE_SHIFT);
+	memset(vaddr, 0, size);
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
@@ -390,13 +391,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 		swiotlb->orig_addr[i] = INVALID_PHYS_ADDR;
 	}
 	swiotlb->index = 0;
-	no_iotlb_memory = false;
-
-	swiotlb_print_info();
 
-	late_alloc = 1;
-
-	swiotlb_set_max_segment(swiotlb->nslabs << IO_TLB_SHIFT);
 	spin_lock_init(&swiotlb->lock);
 
 	return 0;
@@ -410,6 +405,27 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	return -ENOMEM;
 }
 
+int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+{
+	struct swiotlb *swiotlb = &default_swiotlb;
+	unsigned long bytes = nslabs << IO_TLB_SHIFT;
+	int ret;
+
+	ret = swiotlb_init_tlb_pool(swiotlb, virt_to_phys(tlb), bytes);
+	if (ret)
+		return ret;
+
+	no_iotlb_memory = false;
+
+	swiotlb_print_info();
+
+	late_alloc = 1;
+
+	swiotlb_set_max_segment(bytes);
+
+	return 0;
+}
+
 void __init swiotlb_exit(void)
 {
 	struct swiotlb *swiotlb = &default_swiotlb;
@@ -747,17 +763,20 @@ phys_addr_t get_swiotlb_start(void)
 }
 
 #ifdef CONFIG_DEBUG_FS
-
-static int __init swiotlb_create_debugfs(void)
+static void swiotlb_create_debugfs(struct swiotlb *swiotlb, const char *name,
+				   struct dentry *node)
 {
-	struct swiotlb *swiotlb = &default_swiotlb;
-
-	swiotlb->debugfs = debugfs_create_dir("swiotlb", NULL);
+	swiotlb->debugfs = debugfs_create_dir(name, node);
 	debugfs_create_ulong("io_tlb_nslabs", 0400, swiotlb->debugfs, &swiotlb->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, swiotlb->debugfs, &swiotlb->used);
-	return 0;
 }
 
-late_initcall(swiotlb_create_debugfs);
+static int __init swiotlb_create_default_debugfs(void)
+{
+	swiotlb_create_debugfs(&default_swiotlb, "swiotlb", NULL);
+
+	return 0;
+}
 
+late_initcall(swiotlb_create_default_debugfs);
 #endif
-- 
2.30.0.478.g8a0d178c01-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
