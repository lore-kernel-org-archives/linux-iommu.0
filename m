Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9A4D9E0
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780125; cv=none; b=pKUlHqrmjJ1uOFEOChycOP3hmVJJ0+1Cqz9RJpvrPdtjvdPhX5LPSs/nSQknSoDOhFUasE8xw3ZHFKO4oz9Y1leGMCfAkUys7tBDCLtmuX2a74akxhN9/vlGHC8VQtRbx1dfOZQrOwpIsNlne4Tw/5tnq3zhuNwXVkCYGaopY1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780125; c=relaxed/simple;
	bh=Jxy0XWbWb/nIGgYtjM7GzjVLRuuPBPaYqN1Klw6CfqM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uKG4b12WltpaxdkbDU/g2iSV2nZHdN4MOib6aKiEwKhJAeCbmie0zIJmJhSGdVBMJEAO1QC7QwQwwWP3H5R/j9zUxf2odLjizyIEl39xGBn5ALKxfeGkXB4Fs+BgThTQ5B5ApeLo8Dk43hfnbeQDMEp2RX4e+9XlSWH6fyj/U5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0sxSgduc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0sxSgduc"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eed12so1084191276.0
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 01:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706780123; x=1707384923; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JVCHyyuWn0Tx2DLVfJKCMBpt+teKIiAvPgxfHY9hPE0=;
        b=0sxSgduc7TBqu0Gz2u5Uz487XvK5fqwY/u05EmdCTexd2CJjndQmqYZO12JFNfLzuW
         hQKt7+yz2mrViwqKANTqsTGmyoD1pMa7b+fyhHnfs9s7WEhvTM/GyIAeNBIMCcaXoSDs
         eJINigzdi/UPwOMrDffB3FXxq2OUG3hCmnZvCVMU7DIlCPzX5l+K0uJbBRhZs1Emjw0i
         juJUaCMh3fQgoXMdqJ38/h+86IhyE07oqS0ssZ0vB3xo9EG7ZjR6uqp4GWcJa1kkd3eR
         BMpEMNZywd3wTiXgdemIITmzr8WkUGlefrXtv7lrIJD08YJjH9dVahmfaKvJKCsTqW7I
         MtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780123; x=1707384923;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVCHyyuWn0Tx2DLVfJKCMBpt+teKIiAvPgxfHY9hPE0=;
        b=DA2jxF+KXZn8s9UgO4GcXl8m4mD8aomWe4W4gIKZaxDIyg6OPczQV2oAlhS2Olx793
         bEpKeNjSHszYcn1UV+sCPqsMcDDVkyqSDI2IbLhLSZP2nBVCkDsoXxYOPYKeVUqa3Q67
         EevxgHA7YVWiPMBfK+Mew1tM38PdRSrtCHeQIaMVnSoJwY3e7bmlOfSWBeiy92BuVFdN
         FM4VvfUKPDkaxZ0vVzsTNRAPmDeebpOMU7VzxLUiCdJ3X9Dm0HjMCkD9Ev2bd0akDF2C
         EHuWGSx2NC6V2ivRKZssmAvVL7/tz+ucyMDnVWkvVZN3r/NOe3cuOm2rB0e6Xak6w6ER
         XeHw==
X-Gm-Message-State: AOJu0YyC7RU8fgC2Ibszq9Iwi3/3Hn6dVGQD+0eU4c+WnYYDsAukfsk2
	vNZ0r+gSa98NS5m9e3v4aBvDU2MVZOvW/yHx8l3Jr6yQxrx7N1xvezq+sYnyZQil7Yr1hyNKS9s
	o6eBFaZyCkTbJBg==
X-Google-Smtp-Source: AGHT+IGBIccH2+bx2/z4pW2hln1Ej5XqEjzys8cPg/yPdxOeiTjk6VBw47Rbp/BUJpIbfmDrx/U0eGdPHPBWCyQ=
X-Received: from howardyen2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:16f7])
 (user=howardyen job=sendgmr) by 2002:a05:6902:920:b0:dc2:26f6:fbc8 with SMTP
 id bu32-20020a056902092000b00dc226f6fbc8mr140303ybb.7.1706780123180; Thu, 01
 Feb 2024 01:35:23 -0800 (PST)
Date: Thu,  1 Feb 2024 09:35:15 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201093515.849873-1-howardyen@google.com>
Subject: [PATCH] dma-coherent: add support for multi coherent rmems per dev
From: Howard Yen <howardyen@google.com>
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	petr.tesarik.ext@huawei.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for multiple coherent rmems per device. This patch addes
dma_mem_list to device structure to store multiple rmems.

These multiple rmems can be assigned to the device one by one by
of_reserved_mem_device_init_by_idx() with the memory-region
declaration in device tree as below and store the rmem to the dma_mem_list.

	device1@0 {
		...
		memory-region = <&reserved_mem0>, <&reserved_mem1>;
		...
	};

When driver tries to allocate memory from the rmems, looks for the first
available rmem and allocates the memory from this rmem.

Then if driver removed, of_reserved_mem_device_release() needs to be
invoked to release all the rmems assigned to the device.

Signed-off-by: Howard Yen <howardyen@google.com>
---
 include/linux/device.h |  1 +
 kernel/dma/coherent.c  | 66 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 97c4b046c09d..c8682ee507cf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -751,6 +751,7 @@ struct device {
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
+	struct list_head	dma_mem_list;
 #endif
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index ff5683a57f77..f31befd2e6f8 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -18,6 +18,7 @@ struct dma_coherent_mem {
 	unsigned long	*bitmap;
 	spinlock_t	spinlock;
 	bool		use_dev_dma_pfn_offset;
+	struct list_head	node;
 };
 
 static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
@@ -61,6 +62,7 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 	dma_mem->pfn_base = PFN_DOWN(phys_addr);
 	dma_mem->size = pages;
 	dma_mem->use_dev_dma_pfn_offset = use_dma_pfn_offset;
+	INIT_LIST_HEAD(&dma_mem->node);
 	spin_lock_init(&dma_mem->spinlock);
 
 	return dma_mem;
@@ -90,10 +92,13 @@ static int dma_assign_coherent_memory(struct device *dev,
 	if (!dev)
 		return -ENODEV;
 
-	if (dev->dma_mem)
-		return -EBUSY;
+	if (!dev->dma_mem) {
+		dev->dma_mem = mem;
+		INIT_LIST_HEAD(&dev->dma_mem_list);
+	}
+
+	list_add_tail(&mem->node, &dev->dma_mem_list);
 
-	dev->dma_mem = mem;
 	return 0;
 }
 
@@ -187,12 +192,17 @@ static void *__dma_alloc_from_coherent(struct device *dev,
 int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 		dma_addr_t *dma_handle, void **ret)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp, *mem = dev_get_coherent_memory(dev);
 
 	if (!mem)
 		return 0;
 
-	*ret = __dma_alloc_from_coherent(dev, mem, size, dma_handle);
+	list_for_each_entry(mem_tmp, &dev->dma_mem_list, node) {
+		*ret = __dma_alloc_from_coherent(dev, mem_tmp, size, dma_handle);
+		if (*ret)
+			break;
+	}
+
 	return 1;
 }
 
@@ -226,9 +236,19 @@ static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
  */
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp, *mem = dev_get_coherent_memory(dev);
+	int ret = 0;
 
-	return __dma_release_from_coherent(mem, order, vaddr);
+	if (!mem)
+		return ret;
+
+	list_for_each_entry(mem_tmp, &dev->dma_mem_list, node) {
+		ret = __dma_release_from_coherent(mem_tmp, order, vaddr);
+		if (ret == 1)
+			break;
+	}
+
+	return ret;
 }
 
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
@@ -271,9 +291,19 @@ static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 			   void *vaddr, size_t size, int *ret)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp, *mem = dev_get_coherent_memory(dev);
+	int retval = 0;
 
-	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
+	if (!mem)
+		return retval;
+
+	list_for_each_entry(mem_tmp, &dev->dma_mem_list, node) {
+		retval = __dma_mmap_from_coherent(mem_tmp, vma, vaddr, size, ret);
+		if (retval == 1)
+			break;
+	}
+
+	return retval;
 }
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
@@ -351,8 +381,22 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 static void rmem_dma_device_release(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-	if (dev)
-		dev->dma_mem = NULL;
+	struct dma_coherent_mem *mem, *mem_tmp, *q;
+
+	if (dev) {
+		mem = dev_get_coherent_memory(dev);
+		if (rmem->priv != mem) {
+			list_for_each_entry_safe(mem_tmp, q, &dev->dma_mem_list, node) {
+				if (mem_tmp == rmem->priv) {
+					list_del_init(&mem_tmp->node);
+					break;
+				}
+			}
+		} else {
+			list_del_init(&mem->node);
+			dev->dma_mem = NULL;
+		}
+	}
 }
 
 static const struct reserved_mem_ops rmem_dma_ops = {
-- 
2.43.0.429.g432eaa2c6b-goog

