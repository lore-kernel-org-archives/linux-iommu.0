Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED5DC43618
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4030B611EE
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4030B611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D6D640E4E;
	Wed, 14 Apr 2021 14:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bKUjQLW7A0ph; Wed, 14 Apr 2021 14:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E8AC4068C;
	Wed, 14 Apr 2021 14:50:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2E6EC0016;
	Wed, 14 Apr 2021 14:50:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 158F7C001B
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EFF9D40137
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P88r3_aWODiD for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:50:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EDAD400D2
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:33 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id j7so5160232pgi.3
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SNYshAOIhIfYWplCoKI3GKQhqu3xrQdJgtDgLoPsrVY=;
 b=gibuXI9Xv7PARINSU43+2rKSBQQrekXZwe4JwQ/fSldoGkdBytnFZKjdh1uWMusUxb
 BgQY9KiYPHHhszJbeOVJvpB162ge6nEZtamVklk/8VdVGikS2QFEHa3d9VbIgsDYtERj
 U1OSC2tKMrST6MfaGv0Wb6lLasokI084S8I+7JWirTDKYvAwF3mlQNItQCfKFGXibXmC
 7VRGkERZJV1hiFl4tiD76EFkxRAk795i6uHAAHh8lY4jJ7szOhMfztnOyTsBNuY9Oyph
 VepV73vkdDvoHqf5lLhBskr9fBJmbsLOV+hZuDDGaRYdMEzhtsR6nl0UPEAno8awUema
 iuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SNYshAOIhIfYWplCoKI3GKQhqu3xrQdJgtDgLoPsrVY=;
 b=ZAZ8JRRvA7Ba1ObL0X1k/wDJq6VRKtEE2Jb/VsJrgq4XL5n4+2BtAhO+lNxoUEuhvR
 N58dwkHYJtO7tuf/kW1InAC4GJOSiHo5KrniwUJxxtcL1ID+DzNwnd1Nj7jgpl3fShb9
 ezVLL6JJeFO+TlsYFfXLqiPplqh4mKEGUhuhQFlFo7cd5z6eAi7gwvqd2XAuu+SAeExn
 h8GkUwAuGDm8MnIwJ+DjUcJTwBhuDR4ci8taAZecsQ0R7FmhOYrN9bD6c/d4/G8vsmXR
 E6N+MLMMaqXpT+GICHk1o9T8zHjs8cDGsRM/q5n/O9XmOrAH15yWn363RNgsuQ3oIFaR
 mrbA==
X-Gm-Message-State: AOAM531HbnKgsdc6YTEM6yEyUo07oWyTDtlelLpiv2vHG7zfGLgSqSzI
 HCJTK21DYkmndcnCSrVD8QA=
X-Google-Smtp-Source: ABdhPJwnbnl089PfsrvpvokDoexGwlHUvaiFWcLBnccsg7u15LM3+for4Cf+c0I1NoLoEZ/CfdV9tg==
X-Received: by 2002:a63:c741:: with SMTP id v1mr37348049pgg.207.1618411832810; 
 Wed, 14 Apr 2021 07:50:32 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:35:ebad:12c1:f579:e332])
 by smtp.gmail.com with ESMTPSA id w67sm17732522pgb.87.2021.04.14.07.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 07:50:32 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Subject: [Resend RFC PATCH V2 09/12] swiotlb: Add bounce buffer remap address
 setting function
Date: Wed, 14 Apr 2021 10:49:42 -0400
Message-Id: <20210414144945.3460554-10-ltykernel@gmail.com>
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

For Hyper-V isolation VM with AMD SEV SNP, the bounce buffer(shared memory)
needs to be accessed via extra address space(e.g address above bit39).
Hyper-V code may remap extra address space outside of swiotlb. swiotlb_bounce()
needs to use remap virtual address to copy data from/to bounce buffer. Add
new interface swiotlb_set_bounce_remap() to do that.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/swiotlb.h |  5 +++++
 kernel/dma/swiotlb.c    | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index d9c9fc9ca5d2..3ccd08116683 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -82,8 +82,13 @@ unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
 void __init swiotlb_adjust_size(unsigned long new_size);
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
index 7c42df6e6100..5fd2db6aa149 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -94,6 +94,7 @@ static unsigned int io_tlb_index;
  * not be bounced (unless SWIOTLB_FORCE is set).
  */
 static unsigned int max_segment;
+static unsigned char *swiotlb_bounce_remap_addr;
 
 /*
  * We need to save away the original address corresponding to a mapped entry
@@ -421,6 +422,11 @@ void __init swiotlb_exit(void)
 	swiotlb_cleanup();
 }
 
+void swiotlb_set_bounce_remap(unsigned char *vaddr)
+{
+	swiotlb_bounce_remap_addr = vaddr;
+}
+
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
@@ -428,7 +434,12 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 			   size_t size, enum dma_data_direction dir)
 {
 	unsigned long pfn = PFN_DOWN(orig_addr);
-	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	unsigned char *vaddr;
+
+	if (swiotlb_bounce_remap_addr)
+		vaddr = swiotlb_bounce_remap_addr + tlb_addr - io_tlb_start;
+	else
+		vaddr = phys_to_virt(tlb_addr);
 
 	if (PageHighMem(pfn_to_page(pfn))) {
 		/* The buffer does not have a mapping.  Map it in and copy */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
