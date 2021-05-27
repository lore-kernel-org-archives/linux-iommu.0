Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1B5C4708E
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 12:59:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F24860FE6
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 12:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F24860FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23025403B3;
	Thu, 27 May 2021 12:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qtqj71K9i33p; Thu, 27 May 2021 12:59:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5D0940251;
	Thu, 27 May 2021 12:59:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9F31C000E;
	Thu, 27 May 2021 12:59:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEAF7C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 12:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF8BA4028C
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 12:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JuEdHOGwDrCT for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 12:59:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8FBD44023D
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 12:59:04 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id f22so3622095pgb.9
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TTF4vDbD9vQ1KC1jLpuRC6SYDBZGWhbxeMIB/CCcXbM=;
 b=Ql518PoKOfY5r4efBKvH9DmAfXHTzOTlD7cQCPHv4pwiDJMplS9HGrBounYOm/uHrf
 /J12Wcg/AjGjzAJHhjxJJIQiFQkUIqzSfolO8gn7+iXITH1Ou9qg/tKyKRsiVDL/Q70X
 wZNWq4zxBO11T+ZAQUrcXnBAK+2h+MWriKags=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TTF4vDbD9vQ1KC1jLpuRC6SYDBZGWhbxeMIB/CCcXbM=;
 b=C1up/L+VcY5xCIy/zwCey/fWGJ0SpG1gUed5BqGcztRBVRROa5roBIKDRkwJiJX9H4
 fZac8wQNPXWZ2IEbo+40ov5k3xovsDlCcTnrLQZ8AuTqhyZlLe1JFnP6iYGsm4XDzPvr
 RJSM1y/Mvki7WFIdAdUOGD/wt5iw9X6Uzn7LJH2pdqF0sSq63gMsqD2bojpng4/NE8yu
 mvKYLI2iFAPc5orXJ1sneo7XmmGytnCQdJqfP8HRMXA2P8klwXO5lGIGADOvKWG7akWj
 1OnnHdQ8j3VhkUX6KanD7X15Eufgdjur3bE94RrZ8WEu01pyjdk/mRkoNf7BknR+1XaB
 Z4wg==
X-Gm-Message-State: AOAM532qiDDnjLsoWJbsDQ4D3fYF1Yvp2t/agTsUOP5Y2JMpOqzTTNf7
 GlgMgslJZdwPG8N082wjUOrmug==
X-Google-Smtp-Source: ABdhPJyp2dRY1SU48NJaQCKs+dJX/2XsN+WDKmaiBpTycmpdiWBGW8lmfuldLoK+B+T5ST+S6ZG9/g==
X-Received: by 2002:a63:f248:: with SMTP id d8mr3579481pgk.219.1622120343937; 
 Thu, 27 May 2021 05:59:03 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:a93:378d:9a9e:3b70])
 by smtp.gmail.com with UTF8SMTPSA id o17sm1723677pjp.33.2021.05.27.05.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 05:59:03 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v8 01/15] swiotlb: Refactor swiotlb init functions
Date: Thu, 27 May 2021 20:58:31 +0800
Message-Id: <20210527125845.1852284-2-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527125845.1852284-1-tientzu@chromium.org>
References: <20210527125845.1852284-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, jxgao@google.com, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, rodrigo.vivi@intel.com,
 bhelgaas@google.com, tientzu@chromium.org,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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

Add a new function, swiotlb_init_io_tlb_mem, for the io_tlb_mem struct
initialization to make the code reusable.

Note that we now also call set_memory_decrypted in swiotlb_init_with_tbl.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 51 ++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ca7d505d61c..d3232fc19385 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -168,9 +168,30 @@ void __init swiotlb_update_mem_attributes(void)
 	memset(vaddr, 0, bytes);
 }
 
-int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
+static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
+				    unsigned long nslabs, bool late_alloc)
 {
+	void *vaddr = phys_to_virt(start);
 	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
+
+	mem->nslabs = nslabs;
+	mem->start = start;
+	mem->end = mem->start + bytes;
+	mem->index = 0;
+	mem->late_alloc = late_alloc;
+	spin_lock_init(&mem->lock);
+	for (i = 0; i < mem->nslabs; i++) {
+		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
+		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
+		mem->slots[i].alloc_size = 0;
+	}
+
+	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
+	memset(vaddr, 0, bytes);
+}
+
+int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
+{
 	struct io_tlb_mem *mem;
 	size_t alloc_size;
 
@@ -186,16 +207,8 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	if (!mem)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
-	mem->nslabs = nslabs;
-	mem->start = __pa(tlb);
-	mem->end = mem->start + bytes;
-	mem->index = 0;
-	spin_lock_init(&mem->lock);
-	for (i = 0; i < mem->nslabs; i++) {
-		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
-		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
-		mem->slots[i].alloc_size = 0;
-	}
+
+	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
 
 	io_tlb_default_mem = mem;
 	if (verbose)
@@ -282,7 +295,6 @@ swiotlb_late_init_with_default_size(size_t default_size)
 int
 swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 {
-	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
 	struct io_tlb_mem *mem;
 
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
@@ -297,20 +309,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	if (!mem)
 		return -ENOMEM;
 
-	mem->nslabs = nslabs;
-	mem->start = virt_to_phys(tlb);
-	mem->end = mem->start + bytes;
-	mem->index = 0;
-	mem->late_alloc = 1;
-	spin_lock_init(&mem->lock);
-	for (i = 0; i < mem->nslabs; i++) {
-		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
-		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
-		mem->slots[i].alloc_size = 0;
-	}
-
-	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
-	memset(tlb, 0, bytes);
+	swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
 
 	io_tlb_default_mem = mem;
 	swiotlb_print_info();
-- 
2.31.1.818.g46aad6cb9e-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
