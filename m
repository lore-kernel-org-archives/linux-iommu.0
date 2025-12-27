Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EA93176F2
	for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858264; cv=none; b=Jk77asFNqSpJct7ZZaNi+9ChC0Ul/b8np7SfTen+wqFezC5Bm471e0IYwo+cnwdNtwyJkIVcM/CRgZhJFyyGqnIIiMXy0dKTlLlYAyZq2e7p2RZeTtf0bjdrwHFjKeIbx6iWMhjfJTGOW33GRkKuLCcW3u9cpb/JpFp+h2TNohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858264; c=relaxed/simple;
	bh=L2cWEnsnmqmCQzCnbYA8nIWFQ0fDcP2mowaYRIAu7wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no3SRtfzFIIUahO/rTZ91PRp6RoEFXggBJZ5jWRhAt03ZhEMjWDl9oDodITEuY1AMc8l5cy9duFZz79lxzTIxuPA6muPRApU+p6Vq8NBDsTkj4RY4oeVoeIygQEPTyvOynvcsLJ+JmTGcwe2BgAeacDOrKwBC+/+JY3Hwiw4nWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LEZMej3d; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LEZMej3d"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b79ea617f55so1488823966b.3
        for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 09:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766858261; x=1767463061; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by93Ld+GfKq9Xqr4JG5suCzUM+FwELjVjEj4XbD8EvU=;
        b=LEZMej3dwgJ3xauNYY8CFMo7K9oAa0DOeNny/uq8C3yTWi94//Z3eqOfbrc/DzE2pM
         iV1I7gDfFom2gozR1KEzej7Ix05zv9ntc0sicEIQ/8cvJ/9c3N9jhdljURxS2KZ5jQe4
         W8UahNyZB3UZdrjFhTAvtQr5m4nEhsctGvCf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766858261; x=1767463061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=by93Ld+GfKq9Xqr4JG5suCzUM+FwELjVjEj4XbD8EvU=;
        b=whSYI2IOur3S5/IGQL+SoVQGtEiAItTWQ0nsPqK+CiGUnAKlGnr9Xw/MSTt4LkskZw
         OqvQcyIf9z4hT+Y2jFRqXM1AZLsDlLhVxCBVMSabn3WZNx/oEbOiN5agu0z81h1Nt4Kw
         Q/JiMM/dftbcoGpH4TekuNdfV7oM1P2A8kTq/UUrZNibaiOgsrWopL0JIffiC7Xtz8+G
         yYgZApkROzmue9s8W2EDQjboVqPb6U9uLGAt1HBbg1d4C3V9ZGdHgzzMBcvwbQKQLcVQ
         /OdrMaJ1xqREjAsYAsh2pUlGprwRncIG7gJ6820C68PWw/PAjfSD7BCVg9YgEBbbRnOK
         d4wA==
X-Forwarded-Encrypted: i=1; AJvYcCWegmg/xxY+/BKWPyYRhL8JplbZAED0fk6DgdhxAQcECn61tSaTy9PIarEs6MizTS8Ih/m0Kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLF2K6UVRKnHfdaI0v00gzDLblhLLzi80cpLe9zp7VsistFfw4
	xK62MjU2bKPEd401y6Z5U/mV8vZ26/XRq5mgjK4ryR6hZhkdwLwdzulsLxgJbbED/w==
X-Gm-Gg: AY/fxX74r9cq6Hw9wvQsyPq10WP1Y/UZcQ3K30QtnOeHQZ0fmNOI0DimXoQJLl2Nzil
	KXNkMUnl5x0DgxXqP/+OcVuS9E6abdHctr8RMNpFYG52hM5HooUrDNUanO7/R6Yv42uvHC5dfuY
	wDUUjew050RoCw5wbhMLb/MCthOYANX5gc8EF/XpP3/7MyfFEJm4yvFcezN15XphXcLKrO+nm5+
	Zx5KalFoUVff+Ve7vVRtE0UFW3CzZPz2zxwXsEhZ8FWNpOEjxugiM2iY/TmLHbdiA4ALKazonHc
	8s2O63+AmEtTOUGO1xe3BO8026ipm/X2X1L/A3rjMpFqmi8h0xgKHLbNQIv1IstwejFu9kFAqU3
	U6sHruVeltG4YqF7GHyCmYYjEbZgSKtTN/ZNge4GG4exm5fc97TvQviJFVxa5q+HoOFrmSDgfAO
	KntBlY89VDafGf8wRw7e3yTvn3K8RjbA==
X-Google-Smtp-Source: AGHT+IFmzdtl5jfVaKvWxxK43j+CYwbmf9H50vWu1IS0KH+i9ok4izITqTpUSDgTiAKLwwYd3TnYcg==
X-Received: by 2002:a17:907:7e82:b0:b79:ff94:50ff with SMTP id a640c23a62f3a-b8037178545mr2698889366b.34.1766858260857;
        Sat, 27 Dec 2025 09:57:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:a31b:20c3:6680:3d12:d2ea:4ee0:347a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de1421sm2793889166b.41.2025.12.27.09.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 09:57:40 -0800 (PST)
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
Subject: [PATCH v2 2/5] iommu/vt-d: Generalize pasid_set_bits()
Date: Sat, 27 Dec 2025 18:57:25 +0100
Message-ID: <20251227175728.4358-3-dmaluka@chromium.org>
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

To prepare for reusing the pasid_set_bits() for context entries as well,
rename it to entry_set_bits() and move its definition to iommu.h.

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 drivers/iommu/intel/iommu.h |  9 ++++++++
 drivers/iommu/intel/pasid.h | 42 +++++++++++++++----------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 25c5e22096d4..2fab7ff4b932 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -897,6 +897,15 @@ static inline int pfn_level_offset(u64 pfn, int level)
 	return (pfn >> level_to_offset_bits(level)) & LEVEL_MASK;
 }
 
+static inline void entry_set_bits(u64 *ptr, u64 mask, u64 bits)
+{
+	u64 old;
+
+	WARN_ON_ONCE(bits & ~mask);
+
+	old = READ_ONCE(*ptr);
+	WRITE_ONCE(*ptr, (old & ~mask) | (bits & mask));
+}
 
 static inline void context_set_present(struct context_entry *context)
 {
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 39acd3efa3ab..f8fc73676192 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -10,6 +10,8 @@
 #ifndef __INTEL_PASID_H
 #define __INTEL_PASID_H
 
+#include "iommu.h"
+
 #define PASID_MAX			0x100000
 #define PASID_PTE_MASK			0x3F
 #define PASID_PTE_PRESENT		1
@@ -109,16 +111,6 @@ static inline void pasid_clear_entry_with_fpd(struct pasid_entry *pe)
 	WRITE_ONCE(pe->val[7], 0);
 }
 
-static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
-{
-	u64 old;
-
-	WARN_ON_ONCE(bits & ~mask);
-
-	old = READ_ONCE(*ptr);
-	WRITE_ONCE(*ptr, (old & ~mask) | (bits & mask));
-}
-
 static inline u64 pasid_get_bits(u64 *ptr)
 {
 	return READ_ONCE(*ptr);
@@ -131,7 +123,7 @@ static inline u64 pasid_get_bits(u64 *ptr)
 static inline void
 pasid_set_domain_id(struct pasid_entry *pe, u64 value)
 {
-	pasid_set_bits(&pe->val[1], GENMASK_ULL(15, 0), value);
+	entry_set_bits(&pe->val[1], GENMASK_ULL(15, 0), value);
 }
 
 /*
@@ -150,7 +142,7 @@ pasid_get_domain_id(struct pasid_entry *pe)
 static inline void
 pasid_set_slptr(struct pasid_entry *pe, u64 value)
 {
-	pasid_set_bits(&pe->val[0], VTD_PAGE_MASK, value);
+	entry_set_bits(&pe->val[0], VTD_PAGE_MASK, value);
 }
 
 /*
@@ -160,7 +152,7 @@ pasid_set_slptr(struct pasid_entry *pe, u64 value)
 static inline void
 pasid_set_address_width(struct pasid_entry *pe, u64 value)
 {
-	pasid_set_bits(&pe->val[0], GENMASK_ULL(4, 2), value << 2);
+	entry_set_bits(&pe->val[0], GENMASK_ULL(4, 2), value << 2);
 }
 
 /*
@@ -170,7 +162,7 @@ pasid_set_address_width(struct pasid_entry *pe, u64 value)
 static inline void
 pasid_set_translation_type(struct pasid_entry *pe, u64 value)
 {
-	pasid_set_bits(&pe->val[0], GENMASK_ULL(8, 6), value << 6);
+	entry_set_bits(&pe->val[0], GENMASK_ULL(8, 6), value << 6);
 }
 
 /*
@@ -179,7 +171,7 @@ pasid_set_translation_type(struct pasid_entry *pe, u64 value)
  */
 static inline void pasid_set_fault_enable(struct pasid_entry *pe)
 {
-	pasid_set_bits(&pe->val[0], 1 << 1, 0);
+	entry_set_bits(&pe->val[0], 1 << 1, 0);
 }
 
 /*
@@ -189,7 +181,7 @@ static inline void pasid_set_fault_enable(struct pasid_entry *pe)
  */
 static inline void pasid_set_ssade(struct pasid_entry *pe)
 {
-	pasid_set_bits(&pe->val[0], 1 << 9, 1 << 9);
+	entry_set_bits(&pe->val[0], 1 << 9, 1 << 9);
 }
 
 /*
@@ -199,7 +191,7 @@ static inline void pasid_set_ssade(struct pasid_entry *pe)
  */
 static inline void pasid_clear_ssade(struct pasid_entry *pe)
 {
-	pasid_set_bits(&pe->val[0], 1 << 9, 0);
+	entry_set_bits(&pe->val[0], 1 << 9, 0);
 }
 
 /*
@@ -218,7 +210,7 @@ static inline bool pasid_get_ssade(struct pasid_entry *pe)
  */
 static inline void pasid_set_sre(struct pasid_entry *pe)
 {
-	pasid_set_bits(&pe->val[2], 1 << 0, 1);
+	entry_set_bits(&pe->val[2], 1 << 0, 1);
 }
 
 /*
@@ -227,7 +219,7 @@ static inline void pasid_set_sre(struct pasid_entry *pe)
  */
 static inline void pasid_set_wpe(struct pasid_entry *pe)
 {
-	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
+	entry_set_bits(&pe->val[2], 1 << 4, 1 << 4);
 }
 
 /*
@@ -236,7 +228,7 @@ static inline void pasid_set_wpe(struct pasid_entry *pe)
  */
 static inline void pasid_set_present(struct pasid_entry *pe)
 {
-	pasid_set_bits(&pe->val[0], 1 << 0, 1);
+	entry_set_bits(&pe->val[0], 1 << 0, 1);
 }
 
 /*
@@ -245,7 +237,7 @@ static inline void pasid_set_present(struct pasid_entry *pe)
  */
 static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
 {
-	pasid_set_bits(&pe->val[1], 1 << 23, value << 23);
+	entry_set_bits(&pe->val[1], 1 << 23, value << 23);
 }
 
 /*
@@ -255,7 +247,7 @@ static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
 static inline void
 pasid_set_pgsnp(struct pasid_entry *pe)
 {
-	pasid_set_bits(&pe->val[1], 1ULL << 24, 1ULL << 24);
+	entry_set_bits(&pe->val[1], 1ULL << 24, 1ULL << 24);
 }
 
 /*
@@ -265,7 +257,7 @@ pasid_set_pgsnp(struct pasid_entry *pe)
 static inline void
 pasid_set_flptr(struct pasid_entry *pe, u64 value)
 {
-	pasid_set_bits(&pe->val[2], VTD_PAGE_MASK, value);
+	entry_set_bits(&pe->val[2], VTD_PAGE_MASK, value);
 }
 
 /*
@@ -275,7 +267,7 @@ pasid_set_flptr(struct pasid_entry *pe, u64 value)
 static inline void
 pasid_set_flpm(struct pasid_entry *pe, u64 value)
 {
-	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
+	entry_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
 }
 
 /*
@@ -284,7 +276,7 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
  */
 static inline void pasid_set_eafe(struct pasid_entry *pe)
 {
-	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
+	entry_set_bits(&pe->val[2], 1 << 7, 1 << 7);
 }
 
 extern unsigned int intel_pasid_max_id;
-- 
2.47.3

