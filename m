Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894786;
	b=ZyQQKI9XwpC1RTvqfQeUhijRM9IIw3LUO0iG2os7h3tBxkWZs1VQ+pSPXYadxjl7JXT/
	 glZWzawhGwz9I47U5kMBbmLv5nomFFRXA747Fx55Gmr8NAiL8bba6CdYbHx36FUR0lwKP
	 tPwt6xr9NUEHIPHPCTOla5QZjjbIJUqpIvMz+zIS6l24kfklbw6qCNi2ZXwCA7ZLiPbwD
	 EMyi7xGREoozAtLL9XFTECPiyxpalu8FoYTZUtmnD7cF/tFvdumLJor7VEiZDgAt6hqWH
	 tbE1p8M66bRoIEJlN4et7L7NGaL9Hw9vlkB4ejXUUmSUflz6g9O28tMFCVnILVveN3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/RIAPOqL9hETjf54EaDpXVAyHqnHiFUIOigAQ/IbEpk=;
	b=H7AQOsmDIscGXxUwMNfvlTb70sCRF98SUDAb2FLD5+zFgmZVPI9vxnWQPeJVuuaPeJfI
	 QxZZzMOb31WPKRCFQEDOy1TuspoXM9ZWZKRV43LgO4mahVvG+rbRl1sjpIRaMM3uwjjlR
	 gkTpHrPD6FaV2KfLS6vM7tcjuQODqWLxzbsIokyINjdMXR/v3CEWZH1/DCwNL0AU3lG9Z
	 4mlaBUGHfP/0ybzTlqarCjCZU7v9GckNZIvZ6pDfs9z25VU5JdnUEf62R5Xe7+eFgdoHo
	 6SwRUpIlwg9fTAgnnXEzDfqW+J7uN02J5QAnOI9G226OH7Rp8WrBQvBZuEwaSRfCKaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Rn1Q3TJE;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20C2606BF4C
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 02:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B20C2606BF4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Rn1Q3TJE
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd3e7a65fa8so1235529a12.2
        for <iommu@lists.linux.dev>; Sat, 24 Oct 2026 19:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894785; x=1793499585; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RIAPOqL9hETjf54EaDpXVAyHqnHiFUIOigAQ/IbEpk=;
        b=Rn1Q3TJEXJqwUsFwN5mw4doJQYTCqPCseeaSJLpehslNSiSW/wloJyHGG/rf/a0yhf
         K038+gQFxKGjHVqmo0Tv2oh8yf2HIsGZSaOF5Ru2uPV+RYSQ4nyxDr9hHpFbg3jg1E3y
         pP1zJMUlnhUKa/jJvGP2IaX9VZlogWNP6T6RGh+qeFm1QLhCGNmIpTGYT2+hXefFplNS
         6kCyKwxJ8I/ZqI2GiWtV6j4G4mfihjzQFQD3jqgvpVXtV/03+5dKyqb/7Nn/MYVZKCZf
         vhydtRSWzEK44NKaY8LvnHIT87yX3Psa0p5UCF2+z5RdzNkZA/DfRNP/wZnaKm1tCtC0
         VaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894785; x=1793499585;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RIAPOqL9hETjf54EaDpXVAyHqnHiFUIOigAQ/IbEpk=;
        b=tp9ldjjR/zqTJg0IK1lqtB9YlIwYPZat2+gou5bk8z2rw7g0olF8xd9/9u4rw/+cS6
         wxZ0Q3a8blt2mFO4yNzv2na30MxZfX9Ns5Bd+P7ioEGdKwz5pxrHTa9TsT+l+j/pwC7Z
         yMdmhor3txbEn7NZcBl4heifLBXAduH7dB2WIUUCxKfiFNLK9vEYdhTBO7FpAl95U1fw
         p7kEnEUI7ogVD6mnM5QSX2z0sY04aO0MoBpHenS1Er+/vmv3M5T/58LEpl5Mv0GLQPow
         +brr0d19q+L7oJEB+XGGOVXPSyY+mFcIr3AHAfa5MzoAP6yDCboPTnG3PJf2VE2o+YQL
         7zXA==
X-Forwarded-Encrypted: i=1; AKwUvByQs9V4pKFDq1IgnsZKLqoLpcm57DBns1+qqLdWBOzd0ysPm/gvwuFUpMul9tCJr7J/X5X8+Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYJMfSCDnZY0QRWcrKioCtNTyywydEZMTVmH2v4v3NteojNuHrP8
	ftrSc6+7R1aWxq6FCSIdZDSw+axHe5yuF86vnNj3fWfUs7k0bnjJ0A3hhviMiIFunI97ue1HVA5
	sAi0PSzeAJXcQsA==
X-Received: from pghk14.prod.google.com ([2002:a63:f00e:0:b0:ccd:4f9e:b577])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:398:b0:3e2:97ce:b571 with SMTP id adf61e73a8af0-3e7cd52340fmr2358508637.62.1792894784802;
 Sat, 24 Oct 2026 19:19:44 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:19 +0000
In-Reply-To: <20261025021930.674647-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261025021930.674647-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025021930.674647-9-skhawaja@google.com>
Subject: [PATCH v6 08/18] iommu: Add APIs to get iommu and device preserved state
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

The preserved state of the device and IOMMU needs to be fetched during
shutdown and boot in the next kernel. Add APIs that can be used to fetch
the preserved state of a device and IOMMU. The APIs will only be used
during shutdown and after liveupdate so no locking needed.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c       | 88 ++++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h | 70 +++++++++++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index d1d11b28ae79..eace110322ec 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -61,6 +61,14 @@ struct iommu_ser_set {
 	u64 *head_pa;
 };
 
+/* Iterate over the serialized objects of a set, skipping the deleted ones */
+#define iommu_ser_set_for_each(_set, _it, _obj)				\
+	for (kho_block_set_it_init(&(_it), &(_set)->bs);		\
+	     ((_obj) = kho_block_set_it_read_entry(&(_it)));)		\
+		if ((_obj)->hdr.flags & IOMMU_SER_FLAG_DELETED)		\
+			continue;					\
+		else
+
 struct iommu_flb_obj {
 	/* Protects the serialized state and the object sets */
 	struct mutex lock;
@@ -273,6 +281,86 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 }
 EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
 
+/*
+ * iommu_liveupdate_flb_get_incoming() - Helper function to get FLB state
+ * @flb_objp: Pointer to get the restored FLB object
+ *
+ * Return: 0 if FLB state found and restored, error if no data found
+ */
+static int iommu_liveupdate_flb_get_incoming(struct iommu_flb_obj **flb_objp)
+{
+	int ret;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)flb_objp);
+	if (ret == -ENODATA || ret == -ENOENT || ret == -EOPNOTSUPP)
+		return ret;
+
+	if (ret)
+		panic("Failed to restore IOMMU Live Update FLB\n");
+
+	return 0;
+}
+
+/**
+ * iommu_for_each_preserved_device() - Iterate on preserved devices
+ * @fn: Iterator function to call for each preserved device
+ * @arg: Argument to pass to iterator function
+ *
+ * Return: 0 on success, or an error.
+ */
+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
+				    void *arg)
+{
+	struct iommu_device_ser *device_ser;
+	struct iommu_flb_obj *flb_obj;
+	struct kho_block_set_it it;
+	int ret;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return ret;
+
+	iommu_ser_set_for_each(&flb_obj->device_set, it, device_ser) {
+		ret = fn(device_ser, arg);
+		if (ret)
+			break;
+	}
+
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return ret;
+}
+EXPORT_SYMBOL(iommu_for_each_preserved_device);
+
+/**
+ * iommu_get_preserved_data() - Get preserved data for an IOMMU HW
+ * @token: Token used to preserve this IOMMU HW
+ * @type: IOMMU type in preserved state
+ *
+ * Gets the preserved state of an IOMMU HW using token and the IOMMU type.
+ *
+ * Return: struct iommu_hw_ser on success, NULL if no preserved state found.
+ */
+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
+{
+	struct iommu_hw_ser *iommu_ser;
+	struct iommu_flb_obj *flb_obj;
+	struct kho_block_set_it it;
+	int ret;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return NULL;
+
+	iommu_ser_set_for_each(&flb_obj->iommu_set, it, iommu_ser) {
+		if (iommu_ser->token == token && iommu_ser->type == type)
+			break;
+	}
+
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return iommu_ser;
+}
+EXPORT_SYMBOL(iommu_get_preserved_data);
+
 /**
  * iommu_preserve_domain() - Preserve an IOMMU domain across live update
  * @domain: Domain to preserve
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index cdf8a82b7f1d..10fcdd41c7a1 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -13,6 +13,16 @@
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
 
+/**
+ * iommu_preserved_device_iter_fn - Callback for iterating preserved devices
+ * @ser: Pointer to serialized device state
+ * @arg: User-defined context argument
+ *
+ * Return: 0 to continue iteration, or a negative error code to abort.
+ */
+typedef int (*iommu_preserved_device_iter_fn)(struct iommu_device_ser *ser,
+					      void *arg);
+
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
@@ -52,6 +62,46 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
+/**
+ * iommu_domain_restored_state() - Get restored state of an IOMMU domain
+ * @domain: Pointer to struct iommu_domain to get restored state of.
+ *
+ * Return: Pointer to restored state on success, NULL on error.
+ */
+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
+{
+	struct iommu_domain_ser *ser;
+
+	ser = domain->domain_ser;
+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
+		return ser;
+
+	return NULL;
+}
+
+/**
+ * dev_iommu_restored_state() - Get restored state of a device
+ * @dev: Target device
+ *
+ * Return: Restored state pointer or NULL.
+ */
+static inline void *dev_iommu_restored_state(struct device *dev)
+{
+	struct iommu_device_ser *ser;
+
+	if (!dev->iommu)
+		return NULL;
+
+	ser = READ_ONCE(dev->iommu->device_ser);
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
@@ -88,6 +138,26 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
+static inline void *dev_iommu_restored_state(struct device *dev)
+{
+	return NULL;
+}
+
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
2.56.0.257.gf7497c7d27-goog

