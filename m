Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072BEC4338F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 14:53:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C4A6101C
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 14:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7C4A6101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A499683B36;
	Wed, 28 Jul 2021 14:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JsB3P8rMqUvP; Wed, 28 Jul 2021 14:53:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8825B83AE9;
	Wed, 28 Jul 2021 14:53:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71B85C0010;
	Wed, 28 Jul 2021 14:53:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60951C000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 14:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F37B60894
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 14:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HNcr5QkL35eh for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 14:53:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6AE06073A
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 14:53:32 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id b6so5481995pji.4
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ot9NJwgdtSwny3Hz0sW1NmpmwSF9uMUFojPkk0oFEg8=;
 b=S9fynuTeK9vSXvNUDeY4KnRGKPztyWj8Fnz9B9pB5BahJ6cJS+RVcWxVYle9dJnAIB
 DXvmJ5t+++ZA0+T/R07cFZjYEvWfOBk5aAnD8gwRqttsKg4OchtPTc7bNT+bkFxS0q+T
 TS/EMh8f7+QSBU3kGVcPuPs8WY7W8CHJzLzI6CjPe3REMSyY+WNgH2eXqZDMnV2ZtFhz
 G26GNjCWgJtPCYIYclclGs7MF/0fcsoDjy+ziedykVSkxHQCeVHQSN/W73Qf/d3uXzjp
 f3+qF0i9dOE+cA2voQSGgplfosvRU8qjFeC6hKdER1BDhuJIhBrZI5zNDfVR9HgknOBd
 oryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ot9NJwgdtSwny3Hz0sW1NmpmwSF9uMUFojPkk0oFEg8=;
 b=l/O7ARlovLlai6BYoEnAurVBvXpjlRxdziaTHTU58A3DEFxpTBHKZAN3Ct+rtR3Hg8
 yXrqbl6vjY+XtncOVsZnN6xN9xMzeH1XLy1x3wz+EPzqHaddiCUKbntMLYUCZpuWxSoe
 YnpBXUys4unnb2WLAlbdHv828FR0JN5lW1QNviYKOjnRxiBpb3yrP6s/AIYR4bRdQxRU
 J2dZJfH8EPRJAQYm21cAAY3KoVTcQZr9kv1TApeXaIZnmxCtTcbWx4R7G778xiF9XZo2
 +SlVRgojG0leaw7v/vrfrNadw5dct5rdyPDe4OSNldyvkRp1xQ7V7BSBtYVHYJ2RYUU4
 /4jg==
X-Gm-Message-State: AOAM5336u0WcyyX/szuJ53w9OovJJdTtgN1jTO7slefU7SHroLqIUpjA
 xNjFjXHEZ4prevavceMLj/I=
X-Google-Smtp-Source: ABdhPJwWvL5ltGyV4xAnV2PomvPFPoswsA8DVwzJ1kj0bPYDH6cusQ3v3SJ1R0nnIFdc7ySbf7Z6SQ==
X-Received: by 2002:a17:90a:19db:: with SMTP id
 27mr10213457pjj.216.1627484012282; 
 Wed, 28 Jul 2021 07:53:32 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:0:3823:141e:6d51:f0ad])
 by smtp.gmail.com with ESMTPSA id n134sm277558pfd.89.2021.07.28.07.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jul 2021 07:53:32 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, ardb@kernel.org, Tianyu.Lan@microsoft.com,
 rientjes@google.com, martin.b.radev@gmail.com, akpm@linux-foundation.org,
 rppt@kernel.org, kirill.shutemov@linux.intel.com,
 aneesh.kumar@linux.ibm.com, krish.sadhukhan@oracle.com, saravanand@fb.com,
 xen-devel@lists.xenproject.org, pgonda@google.com, david@redhat.com,
 keescook@chromium.org, hannes@cmpxchg.org, sfr@canb.auug.org.au,
 michael.h.kelley@microsoft.com
Subject: [PATCH 10/13] x86/Swiotlb: Add Swiotlb bounce buffer remap function
 for HV IVM
Date: Wed, 28 Jul 2021 10:52:25 -0400
Message-Id: <20210728145232.285861-11-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728145232.285861-1-ltykernel@gmail.com>
References: <20210728145232.285861-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 anparri@microsoft.com, vkuznets@redhat.com
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

In Isolation VM with AMD SEV, bounce buffer needs to be accessed via
extra address space which is above shared_gpa_boundary
(E.G 39 bit address line) reported by Hyper-V CPUID ISOLATION_CONFIG.
The access physical address will be original physical address +
shared_gpa_boundary. The shared_gpa_boundary in the AMD SEV SNP
spec is called virtual top of memory(vTOM). Memory addresses below
vTOM are automatically treated as private while memory above
vTOM is treated as shared.

Use dma_map_decrypted() in the swiotlb code, store remap address returned
and use the remap address to copy data from/to swiotlb bounce buffer.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/swiotlb.h |  4 ++++
 kernel/dma/swiotlb.c    | 11 ++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f507e3eacbea..584560ecaa8e 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -72,6 +72,9 @@ extern enum swiotlb_force swiotlb_force;
  * @end:	The end address of the swiotlb memory pool. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
  *		API.
+ * @vaddr:	The vaddr of the swiotlb memory pool. The swiotlb
+ *		memory pool may be remapped in the memory encrypted case and store
+ *		virtual address for bounce buffer operation.
  * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
  *		@end. For default swiotlb, this is command line adjustable via
  *		setup_io_tlb_npages.
@@ -89,6 +92,7 @@ extern enum swiotlb_force swiotlb_force;
 struct io_tlb_mem {
 	phys_addr_t start;
 	phys_addr_t end;
+	void *vaddr;
 	unsigned long nslabs;
 	unsigned long used;
 	unsigned int index;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1fa81c096c1d..6866e5784b53 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -194,8 +194,13 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 		mem->slots[i].alloc_size = 0;
 	}
 
-	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
-	memset(vaddr, 0, bytes);
+	mem->vaddr = dma_map_decrypted(vaddr, bytes);
+	if (!mem->vaddr) {
+		pr_err("Failed to decrypt memory.\n");
+		return;
+	}
+
+	memset(mem->vaddr, 0, bytes);
 }
 
 int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
@@ -360,7 +365,7 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
-	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
 	unsigned int tlb_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
