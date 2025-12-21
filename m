Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E791FAC42
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766281396; cv=none; b=hA3oU0CDKLiVmgqvRXGOTVzn+HQIb7yzmQEu6Iuq2FkrJn135X+6mVaO27f3tJZk0Nsuyh26l6j+ltT1sJEuQ9HuyBjw+V2VkFfUcHAYVqSQqy3t3Zl5PytUOYz3JBbV4zBamZvstsAUds/HHKBWTvv9dK3c83/J8b4Yq0YFE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766281396; c=relaxed/simple;
	bh=c6l+DaU5BDXL/1UKC1uRvyXoD6pUE+hzGySChC03UOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRkppXPSLIFtvEfzPPLiwmlkHre2PSw2p1/p7UhJROYGkuCO1PfBlYecEaHy8VfM2b1DzQ0+gg66XNb1HFxjsSYdJ35nXo15a6/PHQbjnvRsHz3jg6mSXlYXP3FyhAcJkGFIuxScLvCibWsJV8QQ+C2yQh9oBCnVW4LgTU+h+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JYjCPX8f; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JYjCPX8f"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso1923098a12.0
        for <iommu@lists.linux.dev>; Sat, 20 Dec 2025 17:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766281393; x=1766886193; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzPkvFiJPIiBH8gY2E1M7voQ7WOeiTfZU7yF7kFKn4c=;
        b=JYjCPX8f24GxTrubFt4+LSo7ShJKJv9LLQZHk6WKKu6oMNrVfu35kVCKKiwUrREVJD
         WeOrQHFYltI3KaMhOQldrBRTcQhUzVNbBS5abjn34IiGWOoK7eJJME1PSmhmVLvdxmRo
         WZg5povwlfdj74SesxuqGN9vIzAephmhFTOCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766281393; x=1766886193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzPkvFiJPIiBH8gY2E1M7voQ7WOeiTfZU7yF7kFKn4c=;
        b=sIhgsWQ1wJKjC3QTSEqZItvnjM3fvL0O0ptEn4S/quRf2Le9YBWrHdxInA5Iu9KUFk
         NStnWxgRGPI8cdTnIoQpb16fRS9QS5F/KuNT2oek5EKLcICXzDPgIsi9NLN+Jx8ekgoU
         TS4N7Z3rubPcr1YYTRAqnp4GMwmmLo4yHzU431M2DPRD0Ta6Jv75Iswt1Ig7C9zE01tm
         e6dvEzogn+pmNW0h6Xk4QePIDxrWeS98RReOVnn5S0PfhXIk8xtuaFIxHKq+oMbzjeXr
         1CtCu4K4/qXcgvM/ZNjs+/kHkTWzIOOqeGqq1LTu4crHNRfYmRtT5DuqTY9jrNedqd7V
         c0YA==
X-Forwarded-Encrypted: i=1; AJvYcCXE+dWa7f2Hz8hizmtFzLS9ehA27uy0hdyXP7AM7VgS/7XbWjU2OlyVIuMMk3MQYW9F93TQGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWC6pdunzhKPLSpcuS3itZkffuwZDKqRQK1cX9VxjG3VKix7vJ
	OMwtx5VpdmK6GPMFVwIAP4x3RFS5YOBJvh4DzbfqVZ6IL7U9lYOgvkvzHjYGN8dYGA==
X-Gm-Gg: AY/fxX4ym/YZPQSWTlV8qVA0HDRzrbmaVfFWRd7TskAnGao/eg0b/yJwdTfiCSqOON7
	oxFvrrKmTcYSOetYzaFQQrPmqCuPdpCjI6TI3iQFyJrZRva9Bt7aEOsYpy05+TRrDEnT6hurApz
	mQZzst6sMHCY2mWAlNEcx2XyZrBPd1zRxQxc7K/dDbWyn8ckNUE65nt09S4K8VN40U8NtDbzjN/
	mPT28IR1ehjH6tDKYDlpT8RUWGbA75bDj6yp4EioYeOPsADWCsAZMUNO/vodzHoDlCM/KDcTgcx
	lbW0Ut5wnEaD9NnkjkpRkEGl8h289li0A2vzrL6rN7HhrzSlh65GzaOPTWymvdnTcA2yAb9bDjY
	tfyZkbmt01n3VTOj+ipdPY34VyrOKR5aCYAYdPLf93LT0u94XP2jakIJZyMLg3NAHFYB7sVlnhK
	IFy0K21dZlM6s+4mSnCPNnRf02mQMZ5Q==
X-Google-Smtp-Source: AGHT+IESd/5ZjLIUwnYgaHogwawMT0Vq1dN1amO4mHbs9tVB78ygz08actIt/pnZ5iaj+QSjD2Ia6w==
X-Received: by 2002:a05:6402:1467:b0:64b:5851:5e7b with SMTP id 4fb4d7f45d1cf-64b8d34f12dmr7723823a12.14.1766281393302;
        Sat, 20 Dec 2025 17:43:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:a31b:20c3:6680:4cc9:1698:dce5:4976])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494cd7sm6035057a12.16.2025.12.20.17.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 17:43:12 -0800 (PST)
From: Dmytro Maluka <dmaluka@chromium.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH 1/2] iommu/vt-d: Ensure memory ordering in context entry updates
Date: Sun, 21 Dec 2025 02:43:01 +0100
Message-ID: <20251221014302.17738-2-dmaluka@chromium.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251221014302.17738-1-dmaluka@chromium.org>
References: <20251221014302.17738-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When updating context table entries, we do take care to set the present
bit as the last step, i.e. in the following order:

	context_clear_entry(context);
	<set other bits>
	context_set_present(context);

However, we don't actually ensure this order, i.e. don't prevent the
compiler from reordering it. And since context entries may be updated at
runtime when translation is already enabled, this may potentially allow
a time window when a device can already do DMA while the translation is
not properly set up yet (e.g. the context entry may point to an
arbitrary page table).

To easily fix this, change context_set_*() and context_clear_*() helpers
to use READ_ONCE/WRITE_ONCE, to ensure that the ordering between updates
of individual bits in context entries matches the order of calling those
helpers, just like we already do for PASID table entries.

Link: https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 drivers/iommu/intel/iommu.h | 37 +++++++++++++++++++++----------------
 drivers/iommu/intel/pasid.c |  3 ++-
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 25c5e22096d4..7f8f004fa756 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -869,7 +869,7 @@ static inline bool dma_pte_superpage(struct dma_pte *pte)
 
 static inline bool context_present(struct context_entry *context)
 {
-	return (context->lo & 1);
+	return READ_ONCE(context->lo) & 1;
 }
 
 #define LEVEL_STRIDE		(9)
@@ -897,46 +897,51 @@ static inline int pfn_level_offset(u64 pfn, int level)
 	return (pfn >> level_to_offset_bits(level)) & LEVEL_MASK;
 }
 
+static inline void context_set_bits(u64 *ptr, u64 mask, u64 bits)
+{
+	u64 old;
+
+	old = READ_ONCE(*ptr);
+	WRITE_ONCE(*ptr, (old & ~mask) | bits);
+}
 
 static inline void context_set_present(struct context_entry *context)
 {
-	context->lo |= 1;
+	context_set_bits(&context->lo, 1 << 0, 1);
 }
 
 static inline void context_set_fault_enable(struct context_entry *context)
 {
-	context->lo &= (((u64)-1) << 2) | 1;
+	context_set_bits(&context->lo, 1 << 1, 0);
 }
 
 static inline void context_set_translation_type(struct context_entry *context,
 						unsigned long value)
 {
-	context->lo &= (((u64)-1) << 4) | 3;
-	context->lo |= (value & 3) << 2;
+	context_set_bits(&context->lo, GENMASK_ULL(3, 2), value << 2);
 }
 
 static inline void context_set_address_root(struct context_entry *context,
 					    unsigned long value)
 {
-	context->lo &= ~VTD_PAGE_MASK;
-	context->lo |= value & VTD_PAGE_MASK;
+	context_set_bits(&context->lo, VTD_PAGE_MASK, value);
 }
 
 static inline void context_set_address_width(struct context_entry *context,
 					     unsigned long value)
 {
-	context->hi |= value & 7;
+	context_set_bits(&context->hi, GENMASK_ULL(2, 0), value);
 }
 
 static inline void context_set_domain_id(struct context_entry *context,
 					 unsigned long value)
 {
-	context->hi |= (value & ((1 << 16) - 1)) << 8;
+	context_set_bits(&context->hi, GENMASK_ULL(23, 8), value << 8);
 }
 
 static inline void context_set_pasid(struct context_entry *context)
 {
-	context->lo |= CONTEXT_PASIDE;
+	context_set_bits(&context->lo, CONTEXT_PASIDE, CONTEXT_PASIDE);
 }
 
 static inline int context_domain_id(struct context_entry *c)
@@ -946,8 +951,8 @@ static inline int context_domain_id(struct context_entry *c)
 
 static inline void context_clear_entry(struct context_entry *context)
 {
-	context->lo = 0;
-	context->hi = 0;
+	WRITE_ONCE(context->lo, 0);
+	WRITE_ONCE(context->hi, 0);
 }
 
 #ifdef CONFIG_INTEL_IOMMU
@@ -980,7 +985,7 @@ clear_context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
 static inline void
 context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
 {
-	context->hi |= pasid & ((1 << 20) - 1);
+	context_set_bits(&context->hi, GENMASK_ULL(19, 0), pasid);
 }
 
 /*
@@ -989,7 +994,7 @@ context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
  */
 static inline void context_set_sm_dte(struct context_entry *context)
 {
-	context->lo |= BIT_ULL(2);
+	context_set_bits(&context->lo, BIT_ULL(2), BIT_ULL(2));
 }
 
 /*
@@ -998,7 +1003,7 @@ static inline void context_set_sm_dte(struct context_entry *context)
  */
 static inline void context_set_sm_pre(struct context_entry *context)
 {
-	context->lo |= BIT_ULL(4);
+	context_set_bits(&context->lo, BIT_ULL(4), BIT_ULL(4));
 }
 
 /*
@@ -1007,7 +1012,7 @@ static inline void context_set_sm_pre(struct context_entry *context)
  */
 static inline void context_clear_sm_pre(struct context_entry *context)
 {
-	context->lo &= ~BIT_ULL(4);
+	context_set_bits(&context->lo, BIT_ULL(4), 0);
 }
 
 /* Returns a number of VTD pages, but aligned to MM page size */
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 77b9b147ab50..7e2b75bcecd4 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -984,7 +984,8 @@ static int context_entry_set_pasid_table(struct context_entry *context,
 	context_clear_entry(context);
 
 	pds = context_get_sm_pds(table);
-	context->lo = (u64)virt_to_phys(table->table) | context_pdts(pds);
+	WRITE_ONCE(context->lo,
+		   (u64)virt_to_phys(table->table) | context_pdts(pds));
 	context_set_sm_rid2pasid(context, IOMMU_NO_PASID);
 
 	if (info->ats_supported)
-- 
2.47.3

