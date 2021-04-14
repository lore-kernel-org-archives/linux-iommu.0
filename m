Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8245BC433B4
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E2D611F2
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E2D611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7136B607C7;
	Wed, 14 Apr 2021 14:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BvBsxBMt9vtK; Wed, 14 Apr 2021 14:50:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE386607C8;
	Wed, 14 Apr 2021 14:50:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44894C0012;
	Wed, 14 Apr 2021 14:50:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B347FC000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A054F40E5E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fWmz_g60D3sV for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:50:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 974F6405CF
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:31 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id d124so13876723pfa.13
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J7OMHxrj++vzM3fqEEVHDpiVziTWhlJNkVZ7Vyu86JI=;
 b=KRambbjbzL1OFoz5ZZGIZ2+8tC+DkTGQ0cIvxWKddRoW/LQ4AweHdLyBespo5JogFv
 O4pIw1bGbvLu1UG7zR4YauUQQAPp1u8f1CLUDbYUfKB6nrLR8pt+BzQltCQ1tbcrwweM
 GKYcOMHH0tvd6U7nMjmTB9PrvdMhjcsuFhdHHeKD6qSUvv3LY08ZqMwkv4ll5YZIAnjT
 mduBEmfZVmF78LtAMLRglbtJegVoB6p8PHD5SjJu2c61S+r+iEsqMaew6tOHa1QrcEFA
 cfZPS62Fei9C+bRvXncXXuv+X6C50HBnBI6dgQkpHrlOKhhirE45T0PiBRd352eDRAkf
 5eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J7OMHxrj++vzM3fqEEVHDpiVziTWhlJNkVZ7Vyu86JI=;
 b=DnQAUJ5jMJC5ja/mEYl1cyf4RaPAb16lwr3rfaQCip/syaPaVG5JU25mt9M+T6LMRg
 O2Qez1vNe+hqeElfU/ZEShonhgTgdTJO7LOw29hGx+dgHH3VhOmPn0m3eq+DmEhsgwss
 s0vj5JOWP7PKRNwmupuG8lrrpfHjajXycLEVoyo+zv+N4HKLwAlZFrQyi0YB/nbZcnPk
 ThOIqmaTOznme+pimwG3etRkocEHxw47Lqg77eM6PFHXvumTrpd7G9NfYHfFqDvI/2ni
 28m610lVTrm5qEAdzO4Fz2/dyn1HtdxpSfx7swDy8l8Tb4yHQmPg+GchJ7TzojR4J5ru
 0XNQ==
X-Gm-Message-State: AOAM5337TfcXlutzndilYukGFPHgPjgTuNlYgUFpK08uVjapn70yofxZ
 mkV4EtKaXS+h9AtFmkHLb0Y=
X-Google-Smtp-Source: ABdhPJy1DmuXFvWHwxBGqhJreI4EMi/PXznrYBK3I2OIXVRIaxFUGQKwxsoi/VPGWNFQeVVlZ/LSTQ==
X-Received: by 2002:a65:6643:: with SMTP id z3mr36898952pgv.387.1618411831039; 
 Wed, 14 Apr 2021 07:50:31 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:35:ebad:12c1:f579:e332])
 by smtp.gmail.com with ESMTPSA id w67sm17732522pgb.87.2021.04.14.07.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 07:50:30 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Subject: [Resend RFC PATCH V2 07/12] HV/Vmbus: Initialize VMbus ring buffer
 for Isolation VM
Date: Wed, 14 Apr 2021 10:49:40 -0400
Message-Id: <20210414144945.3460554-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414144945.3460554-1-ltykernel@gmail.com>
References: <20210414144945.3460554-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 sunilmut@microsoft.com
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

VMbus ring buffer are shared with host and it's need to
be accessed via extra address space of Isolation VM with
SNP support. This patch is to map the ring buffer
address in extra address space via ioremap(). HV host
visibility hvcall smears data in the ring buffer and
so reset the ring buffer memory to zero after calling
visibility hvcall.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/channel.c      | 10 +++++
 drivers/hv/hyperv_vmbus.h |  2 +
 drivers/hv/ring_buffer.c  | 83 +++++++++++++++++++++++++++++----------
 mm/ioremap.c              |  1 +
 mm/vmalloc.c              |  1 +
 5 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 407b74d72f3f..4a9fb7ad4c72 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -634,6 +634,16 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	if (err)
 		goto error_clean_ring;
 
+	err = hv_ringbuffer_post_init(&newchannel->outbound,
+				      page, send_pages);
+	if (err)
+		goto error_free_gpadl;
+
+	err = hv_ringbuffer_post_init(&newchannel->inbound,
+				      &page[send_pages], recv_pages);
+	if (err)
+		goto error_free_gpadl;
+
 	/* Create and init the channel open message */
 	open_info = kzalloc(sizeof(*open_info) +
 			   sizeof(struct vmbus_channel_open_channel),
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 0778add21a9c..d78a04ad5490 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -172,6 +172,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
 /* Interface */
 
 void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
+int hv_ringbuffer_post_init(struct hv_ring_buffer_info *ring_info,
+		struct page *pages, u32 page_cnt);
 
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 		       struct page *pages, u32 pagecnt);
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 35833d4d1a1d..c8b0f7b45158 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -17,6 +17,8 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/prefetch.h>
+#include <linux/io.h>
+#include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
 
@@ -188,6 +190,44 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *channel)
 	mutex_init(&channel->outbound.ring_buffer_mutex);
 }
 
+int hv_ringbuffer_post_init(struct hv_ring_buffer_info *ring_info,
+		       struct page *pages, u32 page_cnt)
+{
+	struct vm_struct *area;
+	u64 physic_addr = page_to_pfn(pages) << PAGE_SHIFT;
+	unsigned long vaddr;
+	int err = 0;
+
+	if (!hv_isolation_type_snp())
+		return 0;
+
+	physic_addr += ms_hyperv.shared_gpa_boundary;
+	area = get_vm_area((2 * page_cnt - 1) * PAGE_SIZE, VM_IOREMAP);
+	if (!area || !area->addr)
+		return -EFAULT;
+
+	vaddr = (unsigned long)area->addr;
+	err = ioremap_page_range(vaddr, vaddr + page_cnt * PAGE_SIZE,
+			   physic_addr, PAGE_KERNEL_IO);
+	err |= ioremap_page_range(vaddr + page_cnt * PAGE_SIZE,
+				  vaddr + (2 * page_cnt - 1) * PAGE_SIZE,
+				  physic_addr + PAGE_SIZE, PAGE_KERNEL_IO);
+	if (err) {
+		vunmap((void *)vaddr);
+		return -EFAULT;
+	}
+
+	/* Clean memory after setting host visibility. */
+	memset((void *)vaddr, 0x00, page_cnt * PAGE_SIZE);
+
+	ring_info->ring_buffer = (struct hv_ring_buffer *)vaddr;
+	ring_info->ring_buffer->read_index = 0;
+	ring_info->ring_buffer->write_index = 0;
+	ring_info->ring_buffer->feature_bits.value = 1;
+
+	return 0;
+}
+
 /* Initialize the ring buffer. */
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 		       struct page *pages, u32 page_cnt)
@@ -197,33 +237,34 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 	BUILD_BUG_ON((sizeof(struct hv_ring_buffer) != PAGE_SIZE));
 
-	/*
-	 * First page holds struct hv_ring_buffer, do wraparound mapping for
-	 * the rest.
-	 */
-	pages_wraparound = kcalloc(page_cnt * 2 - 1, sizeof(struct page *),
-				   GFP_KERNEL);
-	if (!pages_wraparound)
-		return -ENOMEM;
-
-	pages_wraparound[0] = pages;
-	for (i = 0; i < 2 * (page_cnt - 1); i++)
-		pages_wraparound[i + 1] = &pages[i % (page_cnt - 1) + 1];
+	if (!hv_isolation_type_snp()) {
+		/*
+		 * First page holds struct hv_ring_buffer, do wraparound mapping for
+		 * the rest.
+		 */
+		pages_wraparound = kcalloc(page_cnt * 2 - 1, sizeof(struct page *),
+					   GFP_KERNEL);
+		if (!pages_wraparound)
+			return -ENOMEM;
 
-	ring_info->ring_buffer = (struct hv_ring_buffer *)
-		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP, PAGE_KERNEL);
+		pages_wraparound[0] = pages;
+		for (i = 0; i < 2 * (page_cnt - 1); i++)
+			pages_wraparound[i + 1] = &pages[i % (page_cnt - 1) + 1];
 
-	kfree(pages_wraparound);
+		ring_info->ring_buffer = (struct hv_ring_buffer *)
+			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP, PAGE_KERNEL);
 
+		kfree(pages_wraparound);
 
-	if (!ring_info->ring_buffer)
-		return -ENOMEM;
+		if (!ring_info->ring_buffer)
+			return -ENOMEM;
 
-	ring_info->ring_buffer->read_index =
-		ring_info->ring_buffer->write_index = 0;
+		ring_info->ring_buffer->read_index =
+			ring_info->ring_buffer->write_index = 0;
 
-	/* Set the feature bit for enabling flow control. */
-	ring_info->ring_buffer->feature_bits.value = 1;
+		/* Set the feature bit for enabling flow control. */
+		ring_info->ring_buffer->feature_bits.value = 1;
+	}
 
 	ring_info->ring_size = page_cnt << PAGE_SHIFT;
 	ring_info->ring_size_div10_reciprocal =
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 5fa1ab41d152..d63c4ba067f9 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -248,6 +248,7 @@ int ioremap_page_range(unsigned long addr,
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(ioremap_page_range);
 
 #ifdef CONFIG_GENERIC_IOREMAP
 void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e6f352bf0498..19724a8ebcb7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2131,6 +2131,7 @@ struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
 				  NUMA_NO_NODE, GFP_KERNEL,
 				  __builtin_return_address(0));
 }
+EXPORT_SYMBOL_GPL(get_vm_area);
 
 struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 				const void *caller)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
