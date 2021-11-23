Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167BAC433EF
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 14:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A3A9240157;
	Tue, 23 Nov 2021 14:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-BcBzfRL-ZG; Tue, 23 Nov 2021 14:37:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4E44D403F7;
	Tue, 23 Nov 2021 14:37:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26A93C001E;
	Tue, 23 Nov 2021 14:37:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1045AC0036
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA31380EEE
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:36:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nb6PZ4sQoze4 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 14:36:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3EA380E11
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:36:57 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id np3so16766079pjb.4
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 06:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QpP/dVmOy5UI+0bbwin5PnSriAWO01VAYDyEmLKe5Fk=;
 b=Tns3ImBlGwbXQEnuXBDpy3hfX/I57KzAQqzM3rfc/vmFboVTSl/I6VWtckE0lrNt9f
 9o0hG/IsvIqRXsVDJbm9KcQ491JrNXQNp5gLdD/ePiEHl32ytjY9MFvU/nXa0CKrfIL9
 NhvqWfjcpDbShn56ZLrJVZd0maDUipkSoZtT8lZpz0DsD5IlZB4rsMuH6DkT7kLsWa2T
 qnZHRJS1wKCoPc+cxZhcwYsqCV4QcXrRxBLsG67ibI0aEf+xl101z94jp0ZDHru7b+mC
 LjCXAjCKBarnhztxXaod+KRBPc77VtIyPBL3hDRuKpWjn9GSug0LMVfy7qo5aZN7XV/W
 bC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QpP/dVmOy5UI+0bbwin5PnSriAWO01VAYDyEmLKe5Fk=;
 b=cA6rgwoSBVKMTuaFM7I7DjVwbka5kAwHbyGoc4ERcyJPjNgRisCSLgSf+YGZ8vv6Iv
 R6xRhS2eflzM5nlRxxsOms2ZwVp7+IkY1iV5oAofY5GEALgVriZJfNWCKPbmJP5DVQk/
 UjEHIiD1lcASrHdo9hNOdRzAQT/werz44pBfshSqyWpFHGlpRjHBx2SJegGQSJGGaUhC
 kVi16t1XXqKUnEYwPxwApzdDm6uvwn+Ign03/tA8dKcgK+xc12aaTcH/6zvQiFTXPH9T
 ephDVVZvqUVEJ86s1oFLx0QJmawMyjpXKGzAJ9rMOEsg9ux315KbjsTkP3OiV44A1Gc9
 HYsA==
X-Gm-Message-State: AOAM530zZAiXklzhiNm6rYTHmC1ARkvHI/R5shuE0sHFYgounahqc0ij
 rzYpnKfyxajAJFZUcR2x4tk=
X-Google-Smtp-Source: ABdhPJwD/E686Op6vkRlhXfD+ipZl5W4QS/7JsYfB5j69XU4jttPeJXYmrrgxGuPk3lE+qDj7Iz0QA==
X-Received: by 2002:a17:90a:7086:: with SMTP id
 g6mr3595594pjk.34.1637678217055; 
 Tue, 23 Nov 2021 06:36:57 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:1:af65:c3d4:6df:5a8b])
 by smtp.gmail.com with ESMTPSA id j13sm11926127pfc.151.2021.11.23.06.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 06:36:56 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, jgross@suse.com,
 sstabellini@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, joro@8bytes.org, will@kernel.org, davem@davemloft.net,
 kuba@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
 hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com,
 xen-devel@lists.xenproject.org, michael.h.kelley@microsoft.com
Subject: [PATCH V2 2/6] dma-mapping: Add vmap/vunmap_noncontiguous() callback
 in dma ops
Date: Tue, 23 Nov 2021 09:30:33 -0500
Message-Id: <20211123143039.331929-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123143039.331929-1-ltykernel@gmail.com>
References: <20211123143039.331929-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
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
