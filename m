Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E37C19F3C
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 18:45:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7084610FE
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 18:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7084610FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87DAA40679;
	Wed,  4 Aug 2021 18:45:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KGpf9Q9SphEr; Wed,  4 Aug 2021 18:45:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 50FAC40686;
	Wed,  4 Aug 2021 18:45:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ECD0C001A;
	Wed,  4 Aug 2021 18:45:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1E31C000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF96240673
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fo7PaksvDUfB for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 18:45:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 32B6A40679
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:45:47 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id q2so3976138plr.11
 for <iommu@lists.linux-foundation.org>; Wed, 04 Aug 2021 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X/FF6IBH0iDucy7fFb53vXAVZJZGw+kDZnNdV+cRcX4=;
 b=nbfSc3WWTmlyhJWBau6jlhMtetGCpWCMIMIt6dnUfkuMu4BYLdh/LGCyzU2IAB+H/R
 5DlfUB34I1HtalUYR0dWkXNEbfqYIfDcJPW9CGPUl7lgRMc+SkCTRxtBoBX+iH5g1IJz
 JfXT4DiEzigmUnD/oJm8GTIidzjWEQbgD3ANS4b/8vlU/mo1rBMJMn0shnYuXDuarjDz
 OiHchOI6rdLJ/Kl1u/kbD6SW02EJ7vf6K8usO4VwWtaH7PvwjxMiCqoL8heS4oMTkQUO
 8Rr4YPXj7xmREGXtO5SzoI+QcTEhISbE5uqksbkpHkW6Nv3ZKehaiVVucBEeoOp+nibW
 z6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X/FF6IBH0iDucy7fFb53vXAVZJZGw+kDZnNdV+cRcX4=;
 b=NejXNhiK3qX8S2Fx1CryTLqyN9dQTZmixoA7luTaRJ8sRO8XbgChZ/fcn1ZonSwLke
 nxLNyQ6EW0emsDIiNvCe8dbRwp/Lapl+TLEf+hNxTz+vtvabKAavYZ7iAdPm55/1BJbi
 ep+UwljGd9sgqGyLP5+0B7jsLxXPwIkxlobJZpmIQbV9epZ/N050TZpM1hqY91JVYqKf
 ajigTOYGz0WlvnnmAE2yZVapq3YJglTNCoMKX9o5bTv4cHwn4XUTp+RxPpboSF6V7ZOS
 2JiOblsDPA2Q7YjJIC/DXortx4zMGorI3E9jo7bGxKNfl1NL9DqtpGV0qWqjltR9XXQn
 2vjg==
X-Gm-Message-State: AOAM533L4jwKqPYJpztPHEuRf9kSZa3RmWN6Flre/Szy11TWcAtjT223
 IYVUgkkfbIplRCzQH5W4qcU=
X-Google-Smtp-Source: ABdhPJyijHhiHC6ZPRqEWrxy/BZ8YZr4h+pTK5pZlYtlGaCrTdCCEixqAygkAVFceUDUgDiXmk86bg==
X-Received: by 2002:a65:63cf:: with SMTP id n15mr525280pgv.392.1628102746706; 
 Wed, 04 Aug 2021 11:45:46 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:f:1947:6842:b8a8:6f83])
 by smtp.gmail.com with ESMTPSA id f5sm3325647pjo.23.2021.08.04.11.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Aug 2021 11:45:46 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, Tianyu.Lan@microsoft.com,
 rppt@kernel.org, kirill.shutemov@linux.intel.com,
 akpm@linux-foundation.org, brijesh.singh@amd.com, thomas.lendacky@amd.com,
 pgonda@google.com, david@redhat.com, krish.sadhukhan@oracle.com,
 saravanand@fb.com, aneesh.kumar@linux.ibm.com,
 xen-devel@lists.xenproject.org, martin.b.radev@gmail.com, ardb@kernel.org,
 rientjes@google.com, tj@kernel.org, keescook@chromium.org,
 michael.h.kelley@microsoft.com
Subject: [PATCH V2 09/14] HV/Vmbus: Initialize VMbus ring buffer for Isolation
 VM
Date: Wed,  4 Aug 2021 14:45:05 -0400
Message-Id: <20210804184513.512888-10-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804184513.512888-1-ltykernel@gmail.com>
References: <20210804184513.512888-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com
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
 drivers/hv/Kconfig        |  1 +
 drivers/hv/channel.c      | 10 +++++
 drivers/hv/hyperv_vmbus.h |  2 +
 drivers/hv/ring_buffer.c  | 84 ++++++++++++++++++++++++++++++---------
 4 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 66c794d92391..a8386998be40 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -7,6 +7,7 @@ config HYPERV
 	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR
+	select VMAP_PFN
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 4c4717c26240..60ef881a700c 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -712,6 +712,16 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
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
index 40bc0eff6665..15cd23a561f3 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -172,6 +172,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
 /* Interface */
 
 void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
+int hv_ringbuffer_post_init(struct hv_ring_buffer_info *ring_info,
+		struct page *pages, u32 page_cnt);
 
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 		       struct page *pages, u32 pagecnt, u32 max_pkt_size);
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 2aee356840a2..d4f93fca1108 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -17,6 +17,8 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/prefetch.h>
+#include <linux/io.h>
+#include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
 
@@ -179,43 +181,89 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *channel)
 	mutex_init(&channel->outbound.ring_buffer_mutex);
 }
 
-/* Initialize the ring buffer. */
-int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
-		       struct page *pages, u32 page_cnt, u32 max_pkt_size)
+int hv_ringbuffer_post_init(struct hv_ring_buffer_info *ring_info,
+		       struct page *pages, u32 page_cnt)
 {
+	u64 physic_addr = page_to_pfn(pages) << PAGE_SHIFT;
+	unsigned long *pfns_wraparound;
+	void *vaddr;
 	int i;
-	struct page **pages_wraparound;
 
-	BUILD_BUG_ON((sizeof(struct hv_ring_buffer) != PAGE_SIZE));
+	if (!hv_isolation_type_snp())
+		return 0;
+
+	physic_addr += ms_hyperv.shared_gpa_boundary;
 
 	/*
 	 * First page holds struct hv_ring_buffer, do wraparound mapping for
 	 * the rest.
 	 */
-	pages_wraparound = kcalloc(page_cnt * 2 - 1, sizeof(struct page *),
+	pfns_wraparound = kcalloc(page_cnt * 2 - 1, sizeof(unsigned long),
 				   GFP_KERNEL);
-	if (!pages_wraparound)
+	if (!pfns_wraparound)
 		return -ENOMEM;
 
-	pages_wraparound[0] = pages;
+	pfns_wraparound[0] = physic_addr >> PAGE_SHIFT;
 	for (i = 0; i < 2 * (page_cnt - 1); i++)
-		pages_wraparound[i + 1] = &pages[i % (page_cnt - 1) + 1];
-
-	ring_info->ring_buffer = (struct hv_ring_buffer *)
-		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP, PAGE_KERNEL);
-
-	kfree(pages_wraparound);
+		pfns_wraparound[i + 1] = (physic_addr >> PAGE_SHIFT) +
+			i % (page_cnt - 1) + 1;
 
-
-	if (!ring_info->ring_buffer)
+	vaddr = vmap_pfn(pfns_wraparound, page_cnt * 2 - 1, PAGE_KERNEL_IO);
+	kfree(pfns_wraparound);
+	if (!vaddr)
 		return -ENOMEM;
 
-	ring_info->ring_buffer->read_index =
-		ring_info->ring_buffer->write_index = 0;
+	/* Clean memory after setting host visibility. */
+	memset((void *)vaddr, 0x00, page_cnt * PAGE_SIZE);
+
+	ring_info->ring_buffer = (struct hv_ring_buffer *)vaddr;
+	ring_info->ring_buffer->read_index = 0;
+	ring_info->ring_buffer->write_index = 0;
 
 	/* Set the feature bit for enabling flow control. */
 	ring_info->ring_buffer->feature_bits.value = 1;
 
+	return 0;
+}
+
+/* Initialize the ring buffer. */
+int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
+		       struct page *pages, u32 page_cnt, u32 max_pkt_size)
+{
+	int i;
+	struct page **pages_wraparound;
+
+	BUILD_BUG_ON((sizeof(struct hv_ring_buffer) != PAGE_SIZE));
+
+	if (!hv_isolation_type_snp()) {
+		/*
+		 * First page holds struct hv_ring_buffer, do wraparound mapping for
+		 * the rest.
+		 */
+		pages_wraparound = kcalloc(page_cnt * 2 - 1, sizeof(struct page *),
+					   GFP_KERNEL);
+		if (!pages_wraparound)
+			return -ENOMEM;
+
+		pages_wraparound[0] = pages;
+		for (i = 0; i < 2 * (page_cnt - 1); i++)
+			pages_wraparound[i + 1] = &pages[i % (page_cnt - 1) + 1];
+
+		ring_info->ring_buffer = (struct hv_ring_buffer *)
+			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP, PAGE_KERNEL);
+
+		kfree(pages_wraparound);
+
+		if (!ring_info->ring_buffer)
+			return -ENOMEM;
+
+		ring_info->ring_buffer->read_index =
+			ring_info->ring_buffer->write_index = 0;
+
+		/* Set the feature bit for enabling flow control. */
+		ring_info->ring_buffer->feature_bits.value = 1;
+	}
+
 	ring_info->ring_size = page_cnt << PAGE_SHIFT;
 	ring_info->ring_size_div10_reciprocal =
 		reciprocal_value(ring_info->ring_size / 10);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
