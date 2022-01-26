Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F9CC2BA4C
	for <iommu@archiver.kernel.org>; Wed, 26 Jan 2022 16:11:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 833FA415B3;
	Wed, 26 Jan 2022 16:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qLspVWaYMn3U; Wed, 26 Jan 2022 16:11:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 74A2A41514;
	Wed, 26 Jan 2022 16:11:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4CDBC007B;
	Wed, 26 Jan 2022 16:11:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 401C0C0039
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 16:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 186984011C
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 16:11:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ivtd-xIF1GTS for <iommu@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 16:11:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0482400C8
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 16:11:09 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id z5so8999532plg.8
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 08:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ta2SflzlSXZZG8agKmpqIan4ZtbVoLMRMWQ8kDRos4Q=;
 b=KeTOxz6XqpTxc5dxaggxM629yBwQmVvQtgZId5U3UBgFvxPZ1ZxVX3GxKeUXUI1Wi7
 EQIxOZWEIBPDSzQcP3hXhOMCMQShm8FgF8vB/HXaqBetpVczrQstxEArvqIiQhxBCSDW
 MD4qvF5aqOWzT4oKWrOczZDWWBN8hRuJR9GRoKHkY7+pFYLB219BN4UlYsabbWQdc9Ug
 fiwC8K4Jwpn/la3wxxYK31i2FMVZYoCVJz1kuLN63NneBXwOqih0oWLsUpabFRSP3FDI
 2aKOEHL1jVnbzT1ivcb/z03ukEf6aySCPoT5McHBc+esL6LsPW5HrJQWjVNsgVNc6Eoe
 L1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ta2SflzlSXZZG8agKmpqIan4ZtbVoLMRMWQ8kDRos4Q=;
 b=zMWZ+CWSjiZg7dqUBjDEyO/lgbTQiwPLvlXjouvkDOL9bIgkFzN5LbTWBRW78JmTt/
 MKYpuIzaszrrghlXewtUHEJV1vERPM4JVSgokOlqdUgbVo3gGxqOFFSIKQRc1oS4PSXS
 9PVUlYelrJJ9VGSzhrQ0WQUikOMqPuY9s8HoovW7thWnLYF3jQmNf0Dw2pybOL2yb2Fj
 wiEnyRpYl97oA9LGVRMawPejXrw5gzfriIZWt47hSRbxPaFxYwr/THpwRuXb9xZNi7YL
 H2PUUvvgvN7Mft9U1oFu8Qoov7sbK7dafU7SrN4cp+zqgL2cry918QDXg3mSpjZV/gQz
 d8bw==
X-Gm-Message-State: AOAM532cgoZd16nqQrW52vI5tt5wD7cocoZqPv3tC2kzQ1GZfkx6QbSB
 AxuAMJrL+rdxcrjwqziPupQ=
X-Google-Smtp-Source: ABdhPJwIbquMo7YSPPxjfHKPIZFQxYpXbnBLF+REfbW0ZfxMXD0gp/Fw16HdEMsqrqPNDYDncCY6Rw==
X-Received: by 2002:a17:90a:1950:: with SMTP id
 16mr9541121pjh.28.1643213469337; 
 Wed, 26 Jan 2022 08:11:09 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:35:cf50:7507:71bb:9b04])
 by smtp.gmail.com with ESMTPSA id b9sm2555534pfm.154.2022.01.26.08.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jan 2022 08:11:09 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, hch@infradead.org, m.szyprowski@samsung.com,
 robin.murphy@arm.com, michael.h.kelley@microsoft.com
Subject: [PATCH 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Date: Wed, 26 Jan 2022 11:10:52 -0500
Message-Id: <20220126161053.297386-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126161053.297386-1-ltykernel@gmail.com>
References: <20220126161053.297386-1-ltykernel@gmail.com>
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
This will fail when there is not enough contiguous memory from 0 to 4G
address space and devices also may use memory above 4G address space as
DMA memory. Expose swiotlb_alloc_from_low_pages and platform mey set it
to false when it's not necessary to limit bounce buffer from 0 to 4G memory.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/swiotlb.h |  1 +
 kernel/dma/swiotlb.c    | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f6c3638255d5..55c178e8eee0 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -191,5 +191,6 @@ static inline bool is_swiotlb_for_alloc(struct device *dev)
 #endif /* CONFIG_DMA_RESTRICTED_POOL */
 
 extern phys_addr_t swiotlb_unencrypted_base;
+extern bool swiotlb_alloc_from_low_pages;
 
 #endif /* __LINUX_SWIOTLB_H */
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b43..159fef80f3db 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -73,6 +73,12 @@ enum swiotlb_force swiotlb_force;
 
 struct io_tlb_mem io_tlb_default_mem;
 
+/*
+ * Get IO TLB memory from the low pages if swiotlb_alloc_from_low_pages
+ * is set.
+ */
+bool swiotlb_alloc_from_low_pages = true;
+
 phys_addr_t swiotlb_unencrypted_base;
 
 /*
@@ -284,8 +290,11 @@ swiotlb_init(int verbose)
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
 		return;
 
-	/* Get IO TLB memory from the low pages */
-	tlb = memblock_alloc_low(bytes, PAGE_SIZE);
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
