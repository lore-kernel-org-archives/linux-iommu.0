Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADB8C433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 15:39:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B64E60EE0
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 15:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B64E60EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECCA460805;
	Tue, 16 Nov 2021 15:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3KBvqiuhKv2K; Tue, 16 Nov 2021 15:39:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E14EE607FA;
	Tue, 16 Nov 2021 15:39:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87F51C0033;
	Tue, 16 Nov 2021 15:39:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78AECC0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66E41607F0
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RU8_kwXZh5LV for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 15:39:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDD1D607E9
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:39:36 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id z6so18550794pfe.7
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 07:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QpP/dVmOy5UI+0bbwin5PnSriAWO01VAYDyEmLKe5Fk=;
 b=SXiaG54grF6wqI5IHlO5fiT6D7ch6iSGwaSfj5F99m+GDLZKF1xq7PpdqZEGQJ2hss
 Mb2HUUEo0PbfBMirBDv6g4oprtzEt8f1KyqLwPFPHMe2qW5PRdHVfXPbxYa6dQcdLZ0U
 ih6mD3K1UTLAsmNZoFe2aO5HLz3zUaoC7GZhMz7o/9lEWJCSZfN2h2eZv1+d/CFeR7kG
 VCd4AjKJvzx8+FYzrSsfSrwbytPrb+YrlivIqNsckIs/ARb8aGx366blyrHUFlVj3W6J
 DNqULX9ETBqHxrFFpaBrQrQujnGUK1fF5SlWwlmILpygaE6keMWPQcnYgsnTLFjuQtfA
 3OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QpP/dVmOy5UI+0bbwin5PnSriAWO01VAYDyEmLKe5Fk=;
 b=lr0OZ5cvHfZdWJDLwogo/DydQ1b3fHlNZ6oThv4Lf65ou9+Uq7yUllBMx3+FLB58yl
 LOrwHv/k18d7Ev+G9u9/vUfFxE3cxpqzz+ACV1JR0/2fIEPJbIN8+13LDGpk8xBi3Kv1
 nYGHq8I+X65xk8BBZd7XJvNSG8rBz4QrVAPE+ane1y1cmGturaq/4qUp/5gmZ3kZ9G8/
 9c+silO/Fv3iadRZLtzg4TAsQbQ+KKqKBqtOh37Fq+x4G7l++/tFjrO4fdCbJyLdzbe2
 FexfbH1AJ1HQM/AzM4mMRZCAEoYwJVxxkuxSlRjeyXvlClCeVYJrGrzPe3AXttndAKUk
 WOrQ==
X-Gm-Message-State: AOAM531u054lrQW+ElRTmGCmW4DqUTjxw1CMtXLoAI6TDqx2qa6KcB/f
 hs4bD6pqvImwNg/mZk5OQ7w=
X-Google-Smtp-Source: ABdhPJylKbp6Y35YNN+QuL8Z6jQM03hSsaNsmPApoiu7+PqjtqafYcV6ZofENONej65wNPzRZ+fN4Q==
X-Received: by 2002:a63:1b5e:: with SMTP id b30mr5271860pgm.72.1637077176375; 
 Tue, 16 Nov 2021 07:39:36 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:3:57e4:b776:c854:76dd])
 by smtp.gmail.com with ESMTPSA id x64sm1981948pfd.151.2021.11.16.07.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 07:39:35 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, jgross@suse.com, sstabellini@kernel.org,
 boris.ostrovsky@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 joro@8bytes.org, will@kernel.org, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 xen-devel@lists.xenproject.org, michael.h.kelley@microsoft.com
Subject: [PATCH 2/5] dma-mapping: Add vmap/vunmap_noncontiguous() callback in
 dma ops
Date: Tue, 16 Nov 2021 10:39:20 -0500
Message-Id: <20211116153923.196763-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116153923.196763-1-ltykernel@gmail.com>
References: <20211116153923.196763-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com
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

Hyper-V netvsc driver needs to allocate noncontiguous DMA memory and
remap it into unencrypted address space before sharing with host. Add
vmap/vunmap_noncontiguous() callback and handle the remap in the Hyper-V
dma ops callback.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/dma-map-ops.h |  3 +++
 kernel/dma/mapping.c        | 18 ++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d5b06b3a4a6..f7b9958ca20a 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -27,6 +27,9 @@ struct dma_map_ops {
 			unsigned long attrs);
 	void (*free_noncontiguous)(struct device *dev, size_t size,
 			struct sg_table *sgt, enum dma_data_direction dir);
+	void *(*vmap_noncontiguous)(struct device *dev, size_t size,
+			struct sg_table *sgt);
+	void (*vunmap_noncontiguous)(struct device *dev, void *addr);
 	int (*mmap)(struct device *, struct vm_area_struct *,
 			void *, dma_addr_t, size_t, unsigned long attrs);
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9478eccd1c8e..7fd751d866cc 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -674,8 +674,14 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 
-	if (ops && ops->alloc_noncontiguous)
-		return vmap(sgt_handle(sgt)->pages, count, VM_MAP, PAGE_KERNEL);
+	if (ops) {
+		if (ops->vmap_noncontiguous)
+			return ops->vmap_noncontiguous(dev, size, sgt);
+		else if (ops->alloc_noncontiguous)
+			return vmap(sgt_handle(sgt)->pages, count, VM_MAP,
+				    PAGE_KERNEL);
+	}
+
 	return page_address(sg_page(sgt->sgl));
 }
 EXPORT_SYMBOL_GPL(dma_vmap_noncontiguous);
@@ -684,8 +690,12 @@ void dma_vunmap_noncontiguous(struct device *dev, void *vaddr)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (ops && ops->alloc_noncontiguous)
-		vunmap(vaddr);
+	if (ops) {
+		if (ops->vunmap_noncontiguous)
+			ops->vunmap_noncontiguous(dev, vaddr);
+		else if (ops->alloc_noncontiguous)
+			vunmap(vaddr);
+	}
 }
 EXPORT_SYMBOL_GPL(dma_vunmap_noncontiguous);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
