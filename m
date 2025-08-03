Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42D74420
	for <iommu@lists.linux.dev>; Sun,  3 Aug 2025 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219392; cv=none; b=pcuEYJ+01BEoafeBlflEJ692YUupsbmzpMGAwQexH+KL4rvwLFsiV6oOQGYekQkwRxGjXw4BjLzFbVFsfFCZjVcIti9+/adw8GZJHnW4m+VsQReWi5yFwZQKvmyHkvaq+xBBDPhw+oVa3pmxAHYGQ/YF2BGJL+1IvV89T7nodTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219392; c=relaxed/simple;
	bh=umnoQPA6LtY/ct25HhtQ/YqOQKI2kbNOJBw5+65dlx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=f1PONeqdJ6YvV3Wt47B2ytkviAYQNw+04DDFIe8Sc8x1fk+kUqTCZhVhSkKqnlKyKoO3ZIZfGM5+vkY3rhcN3eM0tMu6+La1aJzSB4HBTw8acwXPLGPRn/NvIw61XxzMj+WtMKpmb9tt8MUaNshkEt5fZn39K7Sagcw6Z7r+EB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=QpTnQ+79; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="QpTnQ+79"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7094f298dc3so3432276d6.2
        for <iommu@lists.linux.dev>; Sun, 03 Aug 2025 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754219389; x=1754824189; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpZ0Pw1nPQOd+/0U6IoZuKEq0WcxQdvHRhbbA6toWQ4=;
        b=QpTnQ+79QOL1O643jZKfiyfBhfvNtr9YGJqalAY72HDKqPfCfD42KDZCzi2NPaOuA2
         DWc/aNRN884Q5TlnpUplgdPOWcnBAMpE/FzPXhzCMQa/eIKrGVFVT+fH3bQf44Vgcccv
         8+TOMfO0aP9XuJM4v18xX65W8hBrer8iIiLhLczc7mXKZrqkppRCRNN6GjY8zHWfsJT0
         /liYLTpeCAm3OBwQGhRP/TmKgxeCMQxoeRHXgXXIeRAdQSckaxWp4XnrXtfxdbql4b+0
         chkqxn0QISX4o3uARmO+e0gLtmciaHL7bMtJ7/KwUBT9NSMNZVf1vQ+8nyk8uo59PsxL
         O9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219389; x=1754824189;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpZ0Pw1nPQOd+/0U6IoZuKEq0WcxQdvHRhbbA6toWQ4=;
        b=aQMOIRrdoEXBKBYrI6JGU5R2PLhp1zV2g4OwHEuzWqB2K68RM0JGoAaAoo+OOdaRex
         27g06bxYQl9kETyKbY2NOtILheLjba6fwyahY5V3egji7tLDP0gaRdaXZwrhzhlx9AN/
         VBuH3N3FGuBFEM841aLVivFugj+YqSo6Gih42ZEkUSDLfc+BI7t/tfQA2LCtiJl2OyUy
         CBGmSLN9o/dzNwDdzEWS/mK88XRXlhKh6Ackqjqn/E+Irkn66THPm/PzcF01n70+d9DS
         ov1HQy/sYSPl4/FsLZhAvM5MulQAnya44f8tlX4FLYcWWrmHESpvDzlX6gIxOmoVM4fW
         J9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWp2fBfR/yMekpkiwRZfGDsVDxC0g/E24yqInW3IvvcwVeBZ6WEj6ybjP/HnTC8F7cfWWoVOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmKpQ8wmSE3PHsruC/vO+/mtpCUVqQgo8XAZqZmmDZY40EDmZY
	3msDuFA1rS8FiXXv4p6ozLU4g9UOICGOL8E6z57PBvHrgk2p6icdOF9Xbl5DL73XuyRpQ3m8QX0
	xkOCIRFcpRPTuuiorRPbUCtSGqwxpHplJQOdQIZZKdg==
X-Gm-Gg: ASbGncvyKezKfHpiQjmPn988r5s3OCC3UyZU8Yl8cxvBBji0UX+udWVNJUs8ccXFW8o
	4/8raRGUM2yoGi0rlB9v9vHZ/OZ3ZtoP7tRbPNdlOm7IY5JoSFGycgQU+9LoI79wXLJ1Z3lXQnz
	/tM/qXoRIlNv0rpOl44etu8adN1dM/uAHdkCZvGpMktVZU/+f/dWoex120oiMJOtTKLcyVTOmoo
	NIwoy7R0A==
X-Google-Smtp-Source: AGHT+IGE4v11vfh/p98G0AG/vF2vC9cU6z5JShu0YvJhCEikzGPxtEmcHa0xRmO4KkK939iTeptMMaQHPY4nddfiyU4=
X-Received: by 2002:a05:6214:262b:b0:707:4539:5183 with SMTP id
 6a1803df08f44-70935ea93cfmr80164306d6.5.1754219389258; Sun, 03 Aug 2025
 04:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
 <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
 <CAEHaoC2bi3VUEuoWKgHbgUFfdxmACrhkjaQ9Jni-4-ByP5tYJg@mail.gmail.com> <CAEHaoC3ZMvHe7D-JX9bfM9hfSPs0QV-og=om5eKFFqSL=tpjcw@mail.gmail.com>
In-Reply-To: <CAEHaoC3ZMvHe7D-JX9bfM9hfSPs0QV-og=om5eKFFqSL=tpjcw@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:09:38 +0300
X-Gm-Features: Ac12FXw6TPdY1mrvZH4xW6Is3NOum7wEeYjPg6bpbuTEJ7S6z3Br-xeYsxW2C_0
Message-ID: <CAEHaoC0Au_0yLRKSnDg=_qjnmDMmbJ=Nff+W1feEBTib0Jb_gA@mail.gmail.com>
Subject: [PATCH 3/8] Large DMA alloc/add busy_regions sysfs attribute
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

  This is the fourth patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

Add busy_regions SYSFS attribute to IOMMU group. This allows to see used
addresses and debug failed allocations.

commit b01feb650dc080f268adb5ff26bda1b9bf2193a1
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Wed Jun 25 19:49:16 2025 +0300

    Add busy_regions sysfs attribute to IOMMU group.

    This attribute shows allocated DMA regions for the group.

    Add exported function iovad_show_busy_regions() to allow other
implementations.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0b7537e9812f..6ba9be4fb64d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -761,6 +761,14 @@ static iova_align_t
dma_info_to_alignment(unsigned long attrs)
     return align;
 }

+ssize_t iommu_domain_show_busy_regions(struct iommu_domain *domain, char *buf)
+{
+    struct iommu_dma_cookie *cookie = domain->iova_cookie;
+    struct iova_domain *iovad = &cookie->iovad;
+
+    return iovad_show_busy_regions(iovad, buf);
+}
+
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
         size_t size, u64 dma_limit, struct device *dev, iova_align_t align)
 {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a4b606c591da..5daeb86a4aef 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -34,7 +34,9 @@
 #include <linux/sched/mm.h>
 #include <linux/msi.h>
 #include <uapi/linux/iommufd.h>
-
+#ifdef CONFIG_IOMMU_DMA
+#include <linux/iommu-dma.h>
+#endif
 #include "dma-iommu.h"
 #include "iommu-priv.h"

@@ -927,6 +929,19 @@ static ssize_t
iommu_group_show_resv_regions(struct iommu_group *group,
     return offset;
 }

+#ifdef CONFIG_IOMMU_DMA
+static ssize_t iommu_group_show_busy_regions(struct iommu_group *group,
+                         char *buf)
+{
+    if (!group->domain)
+        return 0;
+
+    return iommu_domain_show_busy_regions(group->domain, buf);
+}    int off = 0;
+
+
+#endif
+
 static ssize_t iommu_group_show_type(struct iommu_group *group,
                      char *buf)
 {
@@ -962,6 +977,11 @@ static IOMMU_GROUP_ATTR(name, S_IRUGO,
iommu_group_show_name, NULL);
 static IOMMU_GROUP_ATTR(reserved_regions, 0444,
             iommu_group_show_resv_regions, NULL);

+#ifdef CONFIG_IOMMU_DMA
+static IOMMU_GROUP_ATTR(busy_regions, 0444,
+            iommu_group_show_busy_regions, NULL);
+#endif
+
 static IOMMU_GROUP_ATTR(type, 0644, iommu_group_show_type,
             iommu_group_store_type);

@@ -1049,6 +1069,15 @@ struct iommu_group *iommu_group_alloc(void)
         return ERR_PTR(ret);
     }

+#ifdef CONFIG_IOMMU_DMA
+    ret = iommu_group_create_file(group,
+                      &iommu_group_attr_busy_regions);
+    if (ret) {
+        kobject_put(group->devices_kobj);
+        return ERR_PTR(ret);
+    }
+#endif
+
     ret = iommu_group_create_file(group, &iommu_group_attr_type);
     if (ret) {
         kobject_put(group->devices_kobj);
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 41d5d34fcc33..96144c58b386 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -280,6 +280,37 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 }
 EXPORT_SYMBOL_GPL(alloc_iova);

+/*
+ * Helper function to output allocated regions to a buffer.
+ * Can be used as a show function for a sysfs attribute.
+ * buf is page aigned buffer of PAGE_SIZE.
+*/
+ssize_t iovad_show_busy_regions(struct iova_domain *iovad, char *buf)
+{
+    int off = 0;
+    struct rb_node *curr;
+    struct iova *curr_iova;
+    unsigned long flags;
+    unsigned long shift = iova_shift(iovad);
+
+    spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+    curr = &iovad->anchor.node;
+    /* skip ancor node, it has pfn_hi = pfn_lo = IOVA_ANCHOR = -1LU */
+    curr = rb_prev(curr);
+    while(curr) {
+        curr_iova = rb_entry(curr, struct iova, node);
+        off += sysfs_emit_at(buf, off, "0x%016lx-0x%016lx\n",
curr_iova->pfn_lo << shift,
+            ((curr_iova->pfn_hi + 1) << shift) - 1);
+        curr = rb_prev(curr);
+        /* do not iterate further if the page is full */
+        if (off >= (PAGE_SIZE - 38))
+            break;
+    }
+    spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+    return off;
+}
+EXPORT_SYMBOL_GPL(iovad_show_busy_regions);
+
 static struct iova *
 private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 156732807994..5fe92c00221d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1511,6 +1511,7 @@ static inline void iommu_debugfs_setup(void) {}

 #ifdef CONFIG_IOMMU_DMA
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
+ssize_t iommu_domain_show_busy_regions(struct iommu_domain *domain, char *buf);
 #else /* CONFIG_IOMMU_DMA */
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain,
dma_addr_t base)
 {
diff --git a/include/linux/iova.h b/include/linux/iova.h
index e35762c0acdb..c09d224cce2b 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -91,8 +91,12 @@ void __free_iova(struct iova_domain *iovad, struct
iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
     unsigned long limit_pfn,
     iova_align_t align);
+
 void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
             unsigned long size);
+
+ssize_t iovad_show_busy_regions(struct iova_domain *iovad, char *buf);
+
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
                   unsigned long limit_pfn, bool flush_rcache,
iova_align_t align);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
@@ -120,6 +124,11 @@ static inline void __free_iova(struct iova_domain
*iovad, struct iova *iova)
 {
 }

+ssize_t iovad_show_busy_regions(struct iova_domain *iovad, char *buf)
+{
+    return -ENOTSUPP;
+}
+
 static inline struct iova *alloc_iova(struct iova_domain *iovad,
                       unsigned long size,
                       unsigned long limit_pfn,

-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------
