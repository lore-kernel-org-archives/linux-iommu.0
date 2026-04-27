Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E64F3E6DD2
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312612; cv=none; b=PNQgZKvjXBW/SIsX2n1LL9ZsNVIgPR1nq3/uG5/Je0zUuHHQjyA7DQfjRGjI2SCEp9hqKiaIWRoXD5BRbAhwI8kBSbK3wjbQTjxaqTFqmat9hAiSUxm3v3bayExEq92G6FhDzqG8EcEI1jEcxVtiwUbABtnUKYmQFWm6DXUTC2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312612; c=relaxed/simple;
	bh=sBm8294TNdUcIBVgUwjRvPM2U1FxVSvIDKu5ER4NCvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JpDNiLf0i7RmPRforSUGHQgFeGfDh27muSCluVQ7n6e6Bd6x5it0pKhbGexYXAA5JykiQ2+w7oxGoxNBtcC95+yT1VNnhBDM8Dv7oRNrNIGiDySCzKsLAGA6kOWQA0/cveQSoemRTH2obGPKm10Q7qdhWZfDL0U8iLzEppZMiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBPdmvvb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBPdmvvb"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so5522662a12.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312609; x=1777917409; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=45Z53JRaHhbBRvhdHfvMVMSYTgLthbdvGJ/oBaNMAlw=;
        b=kBPdmvvbaw/7jgiaAGGmE1PeiYd3KKgpAVIvBzjFtsrPuIRmeAI0Uo7YUckw4Gzrhy
         01aRlXlYdtZJCHbbQUBgs0+pLzPoB4QN/eKJKnKWQzS/MecCmprXzJKZBdxkU+JbIltp
         O/vB8ozIcBsisLMQQyNQedEJGKbho+tQ8X271O4oJuolG1X/srzbCokwmeug+2kUn+3G
         IcvRNlCpNPGIRmzYdV69Ki0TmtoEoRjAoI4rIQEIgLMCzV/+58oi6wlqp4RLgHX80M8e
         9W+lIacxXM/fxyJBQ65L601FmpNbzQ2wrH1/KOle98lZgOtp4999FcgKYteNQiqOxvRu
         9WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312609; x=1777917409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45Z53JRaHhbBRvhdHfvMVMSYTgLthbdvGJ/oBaNMAlw=;
        b=nF4+L0m5QbFoMOn/g6KfVGnxmT2c9nBUiB4u/c+YGnAG5CekSQzXftWkMAvwyMbb/9
         RyKvGf67DMDL4T3aHGxRzTK9XHyEfWLCqfJSriwolijB6flAXwtr1TJMAsPH0rx43wii
         w77HIbj40hfuFug+S5s8NwHdsoUvxjsCt6hEU4jc+Plsuk0rARfbU3/4eNcph+W+N/Tp
         hLwvq7+IoagLukN3r1QpvOJ0A0Z8Z1O7cmZGMTvb/7WuKJJH278OYy0yayM8V9ntzEmU
         B3194orff7MQFE3FKZwGQ7bzDWvSj5TpNxHUhENuGuVbZTD2avt+dsByXIrl02o8Rnt2
         4xGg==
X-Forwarded-Encrypted: i=1; AFNElJ8ydNvbKxt/hUr3tNow0i0K97kIobcQSRPLIuAjc9qYrexKOEcDeoNyBrvwWoKBQRMlQq1CJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJZEmew9FoQ5rdd+gMcxJxQSG9/nr6eYlJn86naIEc6TWVkEXE
	gHpXndMqCbk/FaLEs+JIyLOJzdZpMZUeGutyXc7uO1KIaEp9MZNh57JHEuLPa+6NHGo9Zc63XrV
	RHN4G+RcQsJzX7Q==
X-Received: from pfbli8.prod.google.com ([2002:a05:6a00:7188:b0:82f:54e9:c13e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d27:b0:82f:3017:6168 with SMTP id d2e1a72fcca58-834daeccd4amr117065b3a.1.1777312608853;
 Mon, 27 Apr 2026 10:56:48 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:25 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-9-skhawaja@google.com>
Subject: [PATCH v2 08/16] iommu: Add APIs to get iommu and device preserved state
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

The preserved state of the device and IOMMU needs to be fetched during
shutdown and boot in the next kernel. Add APIs that can be used to fetch
the preserved state of a device and IOMMU. The APIs will only be used
during shutdown and after liveupdate so no locking needed.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c       | 57 ++++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h | 31 +++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 765d042e22e3..60ee29b0c6bd 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -17,6 +17,14 @@
 #define iommu_max_objs_per_page(_array) \
 	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
 
+#define iommu_liveupdate_for_each_obj(_arr, _obj, _idx)				\
+	for (; (_arr);								\
+	     (_arr) = (_arr)->hdr.next_array_phys ?				\
+	     phys_to_virt((_arr)->hdr.next_array_phys) : NULL)			\
+		for ((_idx) = 0, (_obj) = (_arr)->objects;			\
+		     (_idx) < (_arr)->hdr.nr_objects; (_idx)++, (_obj)++)	\
+			if (!(_obj)->hdr.deleted)
+
 static void *iommu_liveupdate_restore_array(u64 array_phys)
 {
 	struct iommu_array_hdr_ser *array_hdr;
@@ -201,6 +209,55 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
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
+	array = phys_to_virt(flb_obj->ser->device_array_phys);
+	iommu_liveupdate_for_each_obj(array, device_ser, idx) {
+		ret = fn(device_ser, arg);
+		if (ret)
+			goto out;
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
+	if (ret)
+		return NULL;
+
+	array = phys_to_virt(flb_obj->ser->iommu_array_phys);
+	iommu_liveupdate_for_each_obj(array, iommu_ser, idx) {
+		if (iommu_ser->token == token && iommu_ser->type == type)
+			goto out;
+	}
+
+	iommu_ser = NULL;
+out:
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return iommu_ser;
+}
+EXPORT_SYMBOL(iommu_get_preserved_data);
+
 static int alloc_object_ser(struct iommu_array_hdr_ser **curr_array_ptr, u64 max_objs)
 {
 	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index c9d75c6b3be9..0baf6bc2d93f 100644
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
+	if (ser && ser->hdr.incoming)
+		return ser;
+
+	return NULL;
+}
+
+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
+				    void *arg);
+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
 int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_domain_unpreserve(struct iommu_domain *domain);
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
 static inline int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
 {
 	return -EOPNOTSUPP;
-- 
2.54.0.545.g6539524ca2-goog

