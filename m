Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A833845B3
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480259; cv=none; b=bCy8jjCZhKvxn0Xf1hOaNOK9QS3hIKpD0RLvqCCX6KqxEovARasRuSlUX/Ut/tUkPZt9N+swjvqTB9Me2AUhpKTJPMWg1TGwHd6BeNGhd74GsJakXDv4XF3ZWHeFCNlTLSd8bZ5OnDLBUoe7pqYbKkuafFhtDnmMatoOmjWYCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480259; c=relaxed/simple;
	bh=Ia0KLRmyxKl2KmfjkhuvtXJUvVuNT3w4WDM8ljsL404=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XYhYEqNOUwFOYLhEc+W9AdTbW9BHcXSgScmDub2HsDn+qYjYdcxIFzXrW75krJ3WvPyn6BrGDR7LMRL1oOnK9Tb3NzOabZlR9LnxuiemdlAOYvMlFBqW6YdIUaZK8Igi1mfURusiS+FsDwxlFIQEBEwfVt8fghXPp7iri7x4nqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZuQqYoY; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZuQqYoY"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a366b61fso1519554a12.3
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480257; x=1782085057; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBaYCYKhJ727LgRzXY3UB5YUUjLtMLxXULsmkNca834=;
        b=wZuQqYoYh0AZNOODe0LYF7Hc6LSgAvm7JN9K4dVkuda2X7Kh8uOyuXCpiswXhejl/T
         JpH02Uwkym7mqYybkJP5JGfelTR/cCukHDdlYNE+2oFsqeUZJYPDKi7DShZHx5qsffz3
         tdCUor+MmOxALkyzDWoizqK4fK+3SnQDLRbeOxEPsPb735/2IyHcGQNV8E/EHEoQOowH
         nvB3HLksTErvFrGqsyBKgd27urN8PIhp3t83fh7CmGMQIxtqRmWHqkAkQzyWH0OuTuJx
         aduJ5gjfPBKMJP5DzF3M6IhU4ie7Pvz8eZmuAEMikg1Z1YhUDplNvUzPAlKR2lznYgjA
         eqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480257; x=1782085057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBaYCYKhJ727LgRzXY3UB5YUUjLtMLxXULsmkNca834=;
        b=F1j3oKKPLhMfJdmsKqs0OL/4AVkyQmnk6z65ztUjxW0NTfh2x4uiIlPyygUZ0r6/AO
         njFZL5JiKLPGXDJb0jwJpXlalVwFWuPzullgoLMq8AkG/hqccPTyu2yRY6Ll2jqCnTy3
         yKkcv9Tj031pJsiBFu3WKW7sUrdYsou1NDhGzxlRPCrHadK3oeTVn14o6aexeqaQQ0hd
         bqWULJGZYCKoy/9SqzDYpGlZfF80q9kEL+BsHH1RcJHCmbeAHLyoIIh4jOB1mkZjiJld
         OCnlrfeQ3MyJ+hWF7nnEwoE0KPv4swM+gVuHHQmFx4K+a5NHckL6KeUnIohv+xtiJwAr
         UVhA==
X-Forwarded-Encrypted: i=1; AFNElJ8jcqtV+8iZSqNgDVCQw647CAltQzubzF+oymv4h2SCvIFWs9AGYzLZgY0nG2DsImB5L8ylEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzm2rbgu8H6zyseExGzhg9oVpqW9LbHutsLWAaekaRlGFC047eG
	bu2cdBk0L80kUdnVbyWQYaxPCSuqMzmOzCQ3Wl6OkvMWd2eYmS7QZ0N+37TpzcybZFtcpzXh5wh
	z7bWKWJ3WciHhrA==
X-Received: from plgt14.prod.google.com ([2002:a17:902:e84e:b0:2bc:bdcd:c51f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:94c:b0:2c0:b5c1:8e21 with SMTP id d9443c01a7336-2c410509486mr140737925ad.16.1781480256874;
 Sun, 14 Jun 2026 16:37:36 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:19 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-10-skhawaja@google.com>
Subject: [PATCH v3 09/18] iommu: Add APIs to get iommu and device preserved state
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

The preserved state of the device and IOMMU needs to be fetched during
shutdown and boot in the next kernel. Add APIs that can be used to fetch
the preserved state of a device and IOMMU. The APIs will only be used
during shutdown and after liveupdate so no locking needed.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c       | 75 ++++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h | 31 +++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 2d782023407d..90750e78cd2a 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -18,6 +18,17 @@
 #define iommu_max_objs_per_page(_array) \
 	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
 
+#define iommu_liveupdate_for_each_obj(_arr, _obj, _idx)			\
+	for ((_idx) = 0, (_obj) = (_arr)->objects;			\
+	     (_idx) < (_arr)->hdr.nr_objects; (_idx)++, (_obj)++)	\
+		if (((_obj)->hdr.flags & IOMMU_SER_FLAG_DELETED))	\
+			continue;					\
+		else
+
+#define iommu_liveupdate_for_each_arr(_arr)				\
+	for (; (_arr); (_arr) = (_arr)->hdr.next_array_phys ?		\
+	     phys_to_virt((_arr)->hdr.next_array_phys) : NULL)
+
 struct iommu_flb_obj {
 	struct mutex lock;
 	struct iommu_flb_ser *ser;
@@ -216,6 +227,70 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 }
 EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
 
+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
+				    void *arg)
+{
+	struct iommu_flb_obj *flb_obj;
+	struct iommu_device_array_ser *array;
+	struct iommu_device_ser *device_ser;
+	int ret, idx;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return -ENOENT;
+
+	if (!flb_obj->ser->device_array_phys)
+		return -ENOENT;
+
+	array = phys_to_virt(flb_obj->ser->device_array_phys);
+	iommu_liveupdate_for_each_arr(array) {
+		iommu_liveupdate_for_each_obj(array, device_ser, idx) {
+			ret = fn(device_ser, arg);
+			if (ret)
+				goto out;
+		}
+	}
+
+out:
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return ret;
+}
+EXPORT_SYMBOL(iommu_for_each_preserved_device);
+
+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
+{
+	struct iommu_hw_ser *iommu_ser = NULL;
+	struct iommu_hw_array_ser *array;
+	struct iommu_flb_obj *flb_obj;
+	int ret, idx;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
+	if (ret == -ENODATA || ret == -ENOENT)
+		return NULL;
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!flb_obj->ser->iommu_array_phys) {
+		iommu_ser = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	array = phys_to_virt(flb_obj->ser->iommu_array_phys);
+	iommu_liveupdate_for_each_arr(array) {
+		iommu_liveupdate_for_each_obj(array, iommu_ser, idx) {
+			if (iommu_ser->token == token && iommu_ser->type == type)
+				goto out;
+		}
+	}
+
+	iommu_ser = NULL;
+out:
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return iommu_ser;
+}
+EXPORT_SYMBOL(iommu_get_preserved_data);
+
 static int alloc_object_ser(void **curr_array_ptr, u64 max_objs)
 {
 	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index f9528c94979d..5ad006892cbd 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -13,6 +13,8 @@
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
 
+typedef int (*iommu_preserved_device_iter_fn)(struct iommu_device_ser *ser,
+					      void *arg);
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 static inline void *dev_iommu_preserved_state(struct device *dev)
 {
@@ -28,6 +30,20 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
+{
+	struct iommu_domain_ser *ser;
+
+	ser = domain->preserved_state;
+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
+		return ser;
+
+	return NULL;
+}
+
+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
+				    void *arg);
+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
 int iommu_preserve_device(struct iommu_domain *domain,
@@ -44,6 +60,21 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
+{
+	return NULL;
+}
+
+static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
+{
+	return NULL;
+}
+
 static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
 {
 	return -EOPNOTSUPP;
-- 
2.54.0.1136.gdb2ca164c4-goog

