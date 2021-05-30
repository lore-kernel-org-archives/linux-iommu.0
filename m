Return-Path: <SRS0=A9HU=KZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDCCC4709B
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 15:06:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3594D60FDA
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 15:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3594D60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5078403B7;
	Sun, 30 May 2021 15:06:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jWwspBiCI8kQ; Sun, 30 May 2021 15:06:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E4A7403B2;
	Sun, 30 May 2021 15:06:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CA86C000D;
	Sun, 30 May 2021 15:06:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A378C0001
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 15:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EEB9A403A4
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 15:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xV1dq6wJvJRc for <iommu@lists.linux-foundation.org>;
 Sun, 30 May 2021 15:06:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E307403A0
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 15:06:50 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 l10-20020a17090a150ab0290162974722f2so1709666pja.2
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8QttpWnu2vUzDHi+PZwCcYLiEemtutjgmMI/iodwPTk=;
 b=W8ClChNy/zGX4qaFJXG3v36CEkmNBgz6cFpUbxLY1MtMXiB3DOS0OEuklRIaJsUjfV
 CqNiLrgh8G3MDnqTm2tqCifdbbiQ71hz1sqU7R2dyMZh7qX5GiL+3tYuOVCF6CIkTiBu
 3WfmClEYRfWncVxeql61AC3bv02+aSKH2VTtSAeNX9rR2YLgnBdcXZAj+2VP8OnvpswI
 6IrYrAMKWnDk1x5midWNyrQPk4MmHUTraFR4iwofk71RKNS/2odDBr6VNdmfIBv6hgpz
 ljYhxqjLMoxzQDxzPB8RVmA3zmgl1Y0LYpfklpdG8vApkDP75Koqa6Bu6f2ftX6QddwC
 sV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8QttpWnu2vUzDHi+PZwCcYLiEemtutjgmMI/iodwPTk=;
 b=J0xCJEY9MZYrKEnicRR+P3Isre1VeGv2dH6C8urPmO3hZ9fK+SZGjY8vcztJosDiv+
 z+rBp7KM0KFZpRwt4O2PRJCsYFo57M32nLF0KGpc+sZyaaO8HTaRAm6yqXkEeadfi98H
 hZDzSjiyqb1uIanEXcKbZ267elZzSwyWlZ++JYh2k8XLwCSgxcN8Gg6pcMO1iztV+1t0
 gCAt7/X0i8XwP1BEoT9fSn7XGtqcy3Ci+Gggbb9ipPE7RkKdvv9tOjfemza0/1Scp4bc
 QuMxtARwy9DJSt99Mcma9QXiMwHBrxwWg9/35yAxHOwqBFZT6UXm2wediwJ7PWloJQae
 AUXw==
X-Gm-Message-State: AOAM533r/3A/Hw04w29dHezj2xe30Ak+HO2Q6lBphmGyk8CQPy2ninu9
 uu/eCnO1CdaR3pN5JyvG150=
X-Google-Smtp-Source: ABdhPJwOFhoVhELuBsoR0x6Bkk9R5eQShuRJkYgZiLaNrPrGgc4hr2L1c/qfttmLx9Y24CFWGvaVqQ==
X-Received: by 2002:a17:902:d2d1:b029:ef:8d29:3a64 with SMTP id
 n17-20020a170902d2d1b02900ef8d293a64mr16523183plc.38.1622387209666; 
 Sun, 30 May 2021 08:06:49 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:9:dc2d:80ab:c3f3:1524])
 by smtp.gmail.com with ESMTPSA id b15sm8679688pfi.100.2021.05.30.08.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 May 2021 08:06:49 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 arnd@arndb.de, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, hannes@cmpxchg.org,
 cai@lca.pw, krish.sadhukhan@oracle.com, saravanand@fb.com,
 Tianyu.Lan@microsoft.com, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, boris.ostrovsky@oracle.com,
 jgross@suse.com, sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 xen-devel@lists.xenproject.org, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com
Subject: [RFC PATCH V3 08/11] swiotlb: Add bounce buffer remap address setting
 function
Date: Sun, 30 May 2021 11:06:25 -0400
Message-Id: <20210530150628.2063957-9-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210530150628.2063957-1-ltykernel@gmail.com>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, sunilmut@microsoft.com
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

For Hyper-V isolation VM with AMD SEV SNP, the bounce buffer(shared memory)
needs to be accessed via extra address space(e.g address above bit39).
Hyper-V code may remap extra address space outside of swiotlb. swiotlb_
bounce() needs to use remap virtual address to copy data from/to bounce
buffer. Add new interface swiotlb_set_bounce_remap() to do that.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/swiotlb.h |  5 +++++
 kernel/dma/swiotlb.c    | 14 +++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 216854a5e513..43f53cf52f48 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -113,8 +113,13 @@ unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
 void __init swiotlb_adjust_size(unsigned long size);
+void swiotlb_set_bounce_remap(unsigned char *vaddr);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
+static inline void swiotlb_set_bounce_remap(unsigned char *vaddr)
+{
+}
+
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return false;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ca7d505d61c..fbc827ab5fb4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -70,6 +70,7 @@ struct io_tlb_mem *io_tlb_default_mem;
  * not be bounced (unless SWIOTLB_FORCE is set).
  */
 static unsigned int max_segment;
+static unsigned char *swiotlb_bounce_remap_addr;
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 
@@ -334,6 +335,11 @@ void __init swiotlb_exit(void)
 	io_tlb_default_mem = NULL;
 }
 
+void swiotlb_set_bounce_remap(unsigned char *vaddr)
+{
+	swiotlb_bounce_remap_addr = vaddr;
+}
+
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
@@ -345,7 +351,13 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
-	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	unsigned char *vaddr;
+
+	if (swiotlb_bounce_remap_addr)
+		vaddr = swiotlb_bounce_remap_addr + tlb_addr -
+			io_tlb_default_mem->start;
+	else
+		vaddr = phys_to_virt(tlb_addr);
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
