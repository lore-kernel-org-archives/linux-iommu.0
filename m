Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F822578A
	for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858266; cv=none; b=GjOXpiKhyztOtnWU9zXFm8bqhU1LikYUjE/jf/MFnTolX5yTxtSCcHohoLXjbyrTveFl2RIAjWojD/xB42PWvUTMe7CIopzBtnmNmLwU8ho3RFTZDwj4SegOI0JgBK7GBdhiUJO6XHvdaMWozACgNbtxik9operk5J+HdKmPfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858266; c=relaxed/simple;
	bh=ei0++g+qQ8J1uQVOXHShP/rF0mLO8S0X6PGGPQVsUQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIbkOZ7zshoDDQ66rPrWiB6sCIv7vHRr1qrng8nPRrwGydgozQ9QeueOuyg/AFJcUMeOrlcmICnQTjWUE/GuZV2dvJlhLRd112jPex5cy8JY+dbIntMip1i0Q1t+P4sc4n0iq0YUqJz/zNhkoRU6jTenTXvWxR6KvIwgbfQ4bXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KMy1pMQV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KMy1pMQV"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b83122f9d78so354338966b.0
        for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 09:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766858263; x=1767463063; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kE4f2srVbqp2cJELTyA1b101NU/Xz+fZ0icl34hpHg=;
        b=KMy1pMQVb9HDjL6wZgky2MJSUWtx6BF8454zpDsnq5bukYzy3PrnW9b7XUpbRjoMkH
         iMoPRbk92TpjU4gjYvcmy0MX8nHm1b4RmgWdaAbIUMreFNIUhnIxAc+Jb4dWSw20I8nH
         qE4Y6zCdtnW2uxpczZDjjczC860S6Ncn9KlGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766858263; x=1767463063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2kE4f2srVbqp2cJELTyA1b101NU/Xz+fZ0icl34hpHg=;
        b=UmvuWFDUNxRBNKno3pkGqds4knX7R5byX1MH3Qcr8Z97yV5xZeJB/qXnUpDedXM9qO
         XP0an0ygCydSFwNbQPkqW4IW4NiH4d3A6sUYI1/zY7RnLkxZmuOvISm70c0vJiDoGwv+
         W5W6VCF1h7QRbh0qWD6TjqxpBQMaRwjzdcqx0sVAl7b0aacPmYrx5twjw7XibgVvvAej
         dFT9J+LWW1Ank7V4KJZULNkR2ihsmApZzWlgYROnOTsH0sXFbIdvMMiFBw/DaCHek1k4
         oJlIQx+ejkvtdAdCcUyLVMBgb70ABDtl1x+3k9E04Ojb2a44wmpHcjbFBtJ50jUEnAnp
         B8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUhfKgIGJYgk5UIpwVuKJbroMW+l51IjgGcSG3Hv+/CIoGrFNrEJWTU+6AWIq+TTQ+yKBTNhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqwbZgr+R+Q2ZBmEoIA7leBa9bqXVoOcuUbZa5K82eR511Z2xw
	qYEKqH+sxpIaHiNInr4fDV8j/q4tF6Y4cgRRYI1MBorOxt5dyeqeSXHwoNjRs7KM8Q==
X-Gm-Gg: AY/fxX4XupNXdZmPE1RKcu0HhWGcQ17jtWnpelpYn8udJB3F9JDWx+0BHVLvXxZyG8w
	fiRCtVY/30DMpOwtpq2lyRdrSbM4l5tbctfZkn7YCk3PlOmi9QVKxzayNiyMgwz6YLZ5IzGAmJT
	8lxRWNAmRRd8PfZ1oXjpdak+nR+krL5b/EqIWQZpmYOLZardbzLccOiOQBnJRLK5hgVgfgCM0hi
	+vQ21rzT/QjCGaLCZuizZ6zkqMmg5qHRCy5NEwnRMwdDlW7sTDesEMygmqcnrX1oJrKjm5sRBCC
	iED4pdIY6b+SrdAAGp/kFSpAzPJ5sU00lGCQcXCEdPsAN2iijLD49BP4H1NMqETVnNUOSEXgRw3
	luCLTIGQqS6Wfl68np5YFlAcAJiQaFxpaQNPBLHWyPIgjX2ROYcUKV34qm694iWQhF6FTvz0Aa0
	o/OgC0+XS4uvxDDy63sPsritftoZKyxA==
X-Google-Smtp-Source: AGHT+IG1gJF/WWL1ToH5KDze6NLDbu3QNa70g1dv2jxhMVU4b+kriwJ6AKUTsYYe9uFC3C4IftQyUg==
X-Received: by 2002:a17:907:94c6:b0:b72:6a39:49d7 with SMTP id a640c23a62f3a-b803704ffb1mr3076499566b.33.1766858262584;
        Sat, 27 Dec 2025 09:57:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:a31b:20c3:6680:3d12:d2ea:4ee0:347a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de1421sm2793889166b.41.2025.12.27.09.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 09:57:42 -0800 (PST)
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
Subject: [PATCH v2 3/5] iommu/vt-d: Ensure memory ordering in context entry updates
Date: Sat, 27 Dec 2025 18:57:26 +0100
Message-ID: <20251227175728.4358-4-dmaluka@chromium.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251227175728.4358-1-dmaluka@chromium.org>
References: <20251227175728.4358-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do take care to not set the present bit in a context table entry via
context_set_present() earlier than setting up all other bits in it.
However, we don't do anything to actually ensure this order, i.e. to
prevent the compiler from reordering it. And since context entries may
be updated at runtime when translation is already enabled, this is a
potential source of bugs or security issues.

To easily fix this, convert the context_set_*() and context_clear_*()
helpers to use entry_set_bits() which uses READ_ONCE/WRITE_ONCE, to
ensure that the ordering between updates of individual bits in context
entries matches the order of calling those helpers, just like we already
do that for PASID table entries.

Link: https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 drivers/iommu/intel/iommu.h | 30 ++++++++++++++----------------
 drivers/iommu/intel/pasid.c |  3 ++-
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 2fab7ff4b932..5bc69ffc7c8e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -869,7 +869,7 @@ static inline bool dma_pte_superpage(struct dma_pte *pte)
 
 static inline bool context_present(struct context_entry *context)
 {
-	return (context->lo & 1);
+	return READ_ONCE(context->lo) & 1;
 }
 
 #define LEVEL_STRIDE		(9)
@@ -909,43 +909,41 @@ static inline void entry_set_bits(u64 *ptr, u64 mask, u64 bits)
 
 static inline void context_set_present(struct context_entry *context)
 {
-	context->lo |= 1;
+	entry_set_bits(&context->lo, 1ULL << 0, 1ULL);
 }
 
 static inline void context_set_fault_enable(struct context_entry *context)
 {
-	context->lo &= (((u64)-1) << 2) | 1;
+	entry_set_bits(&context->lo, 1ULL << 1, 0ULL);
 }
 
 static inline void context_set_translation_type(struct context_entry *context,
 						unsigned long value)
 {
-	context->lo &= (((u64)-1) << 4) | 3;
-	context->lo |= (value & 3) << 2;
+	entry_set_bits(&context->lo, GENMASK_ULL(3, 2), value << 2);
 }
 
 static inline void context_set_address_root(struct context_entry *context,
 					    unsigned long value)
 {
-	context->lo &= ~VTD_PAGE_MASK;
-	context->lo |= value & VTD_PAGE_MASK;
+	entry_set_bits(&context->lo, VTD_PAGE_MASK, value);
 }
 
 static inline void context_set_address_width(struct context_entry *context,
 					     unsigned long value)
 {
-	context->hi |= value & 7;
+	entry_set_bits(&context->hi, GENMASK_ULL(2, 0), value);
 }
 
 static inline void context_set_domain_id(struct context_entry *context,
 					 unsigned long value)
 {
-	context->hi |= (value & ((1 << 16) - 1)) << 8;
+	entry_set_bits(&context->hi, GENMASK_ULL(23, 8), value << 8);
 }
 
 static inline void context_set_pasid(struct context_entry *context)
 {
-	context->lo |= CONTEXT_PASIDE;
+	entry_set_bits(&context->lo, CONTEXT_PASIDE, CONTEXT_PASIDE);
 }
 
 static inline int context_domain_id(struct context_entry *c)
@@ -955,8 +953,8 @@ static inline int context_domain_id(struct context_entry *c)
 
 static inline void context_clear_entry(struct context_entry *context)
 {
-	context->lo = 0;
-	context->hi = 0;
+	WRITE_ONCE(context->lo, 0);
+	WRITE_ONCE(context->hi, 0);
 }
 
 #ifdef CONFIG_INTEL_IOMMU
@@ -989,7 +987,7 @@ clear_context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
 static inline void
 context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
 {
-	context->hi |= pasid & ((1 << 20) - 1);
+	entry_set_bits(&context->hi, GENMASK_ULL(19, 0), pasid);
 }
 
 /*
@@ -998,7 +996,7 @@ context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
  */
 static inline void context_set_sm_dte(struct context_entry *context)
 {
-	context->lo |= BIT_ULL(2);
+	entry_set_bits(&context->lo, BIT_ULL(2), BIT_ULL(2));
 }
 
 /*
@@ -1007,7 +1005,7 @@ static inline void context_set_sm_dte(struct context_entry *context)
  */
 static inline void context_set_sm_pre(struct context_entry *context)
 {
-	context->lo |= BIT_ULL(4);
+	entry_set_bits(&context->lo, BIT_ULL(4), BIT_ULL(4));
 }
 
 /*
@@ -1016,7 +1014,7 @@ static inline void context_set_sm_pre(struct context_entry *context)
  */
 static inline void context_clear_sm_pre(struct context_entry *context)
 {
-	context->lo &= ~BIT_ULL(4);
+	entry_set_bits(&context->lo, BIT_ULL(4), 0);
 }
 
 /* Returns a number of VTD pages, but aligned to MM page size */
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3e2255057079..10bc1908d892 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -983,7 +983,8 @@ static int context_entry_set_pasid_table(struct context_entry *context,
 	context_clear_entry(context);
 
 	pds = context_get_sm_pds(table);
-	context->lo = (u64)virt_to_phys(table->table) | context_pdts(pds);
+	WRITE_ONCE(context->lo,
+		   (u64)virt_to_phys(table->table) | context_pdts(pds));
 	context_set_sm_rid2pasid(context, IOMMU_NO_PASID);
 
 	if (info->ats_supported)
-- 
2.47.3

