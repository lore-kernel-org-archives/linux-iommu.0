Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F23E316E
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805722; cv=none; b=ppEBL+gTQUAzHKONzBA9a5Rm/gDPx9iJzfFfxmD45GMZH+nsI01JGNuaAGVDyUa9PBViZUSWQuNrt3ragoKVLBHEC73NH4ywWusO0TkF4/1SBGJwKg3AZCG5K3bCnpFfRT0Bt4WIdes4qkYqoWKfOOznLtQwGwtKirP/VvThGFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805722; c=relaxed/simple;
	bh=R4rDGKMYp0Cv11TJSWOHxXf+D6RfXuYF4yaNoTScwQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggK7wDxY3nn1TBXxBjaitp2dvLVfjVkaItvUt43W+/Hf76mW8rz2IWYvv93aMbmP8KR/5wdHpaf76jaljInCFaKJuwb931OgMAcffzb03/YU09ggDypUaLVT2opgNmT3YRzMwkq3hPnCzNQg+W/RkvASU/UieEgzGUXDPg9ZVXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/tu5pU/; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/tu5pU/"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2c821a50615so21157395ad.0
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 00:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805720; x=1783410520; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nur8Ymdh1FRAljY2SkKXlWeVVD/O0p+FPkDXgbutnT4=;
        b=X/tu5pU/76RCbg0bXRaxUU0MgDonPjN8MCIAKFovzLpfhA/4fn2hBgvCjisG0ursWT
         uj5UVBB8tKij6GB403PUzcJD+g59S7FufoFX1PdhJwFZ6/ZILvCox6ItjzInwxHJoOgh
         VeSLZg52UROjChd0jK3NQVM/p8HVWNUZIrzqfHLVJuMBC9wqL7XTPuDo0IsAHXNKnf2U
         nZMyai7P0QsFdtzgHBQxfuxnGqE8yiSPL28QfXMALUiuhHFvEt2dPPQWEHKpZKVJCS2p
         qT2nkGxSI96GSWCsmpZHllmTZ5kC2+YqhtMO+L9lXDuf+YApqjsjEiG9jBDPAiUsU9wt
         uiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805720; x=1783410520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nur8Ymdh1FRAljY2SkKXlWeVVD/O0p+FPkDXgbutnT4=;
        b=Nk51F458H8wHRVibbJRhZzkGSzxy/Jzcn/WF5RmUbbO5dI8AFKjx8jw4u/++zNCe0r
         xtFv+yc0j8pVTwmUXWlRuuzGObBfUAjwMbW+uFGeJr9Ku7y6fdjFF56elfGvX3ecIJ0B
         cit0dt1Vju9MpG/VXBzpxml6gIfdMdseaYb/bCwMFjDIIcIBOCqFtxowwf5iJfNO7oC8
         PD7X3bzfgDrbDDFLIVt3/lege7t8R8MTr5myKI0cxwrdQdc6GhNHhrtgqfh2LSGTzmnf
         WWlJVx2gjzc7xvLW97pt7xwLPzEvpwVm6VarIUHxwg7g5Rur0pXKo1Yzv/GQ+gKGyC+R
         HEdA==
X-Forwarded-Encrypted: i=1; AHgh+Rprg/Ho+yt0Wtzq6pP0FWUsWA70+9J0YBMEa0HQzKxtscwCMnmvJqkaU+kiptBBYclPrU4D7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx69qKJXI5KTH/zVp6ThQQJibiYVNlR0ffDcErfT2+7oyPDkugu
	11BZMkEhaaoMLjwXbCUX0xH95REJMcm6FCafuFDdZ2ZQ5ffd2BedH1EM
X-Gm-Gg: AfdE7cmC+inbmlVbNvk83pzHYSvoN/vpOvq3VofqUw8EG++/eRVvurYw487wxfrAYI8
	qjJJseEXIP8KAKs2bDidGNsF+5FzFDHzJNjQn+3SWbG0O5LC/7CVzRAPuPUtD0G7GJAo03EVj3O
	b4yUVRRxD/9kCHawMdJ+vyIREPqTHiXroAYw9TucmjlO+Hi3Q53Jppi8ae/Dg4HV0qwWe4ujkA6
	8uF1uIa3+n5xOpQL7IaZww/P4WFxeAK1U3jPJ0OPNXvFGzKu3CcjeI/ivZQsC5nTsBFwk11X02g
	V/OqyGPee1hVLhJJGFpZCHLgbhlLMfcuHdz+dN4KFsaHgJWadIQiP17MXKjli2W6Q1dTXRyggZM
	YVZ5Za2kV3tGT2p6iy6v04tmpvw07KX/Eriyyo6wsV2worNuDoIV6C6V6l+Y7jtGomb3hMPGf7b
	VCpkl40isfHbnzfv2y2C6AaoooOg==
X-Received: by 2002:a17:902:ecc1:b0:2ca:1b97:70c5 with SMTP id d9443c01a7336-2ca2d52aa74mr18805135ad.4.1782805719998;
        Tue, 30 Jun 2026 00:48:39 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:48:39 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	bhe@redhat.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v4 07/10] of: reserved_mem: add kdump helpers to exclude non-dumpable regions
Date: Tue, 30 Jun 2026 15:47:11 +0800
Message-ID: <20260630074715.4126796-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Add two helpers to exclude non-dumpable regions for arch-specific
code.

 - of_reserved_mem_kdump_nr_ranges() returns the count of regions
   that are not dumpable. Each excluded region may split an existing
   crash_mem range into two, so callers use this to calculate
   crash_mem allocation size.

 - of_reserved_mem_kdump_exclude() walks reserved_mem[] and calls
   crash_exclude_mem_range() for every non-dumpable region.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 drivers/of/of_reserved_mem.c    | 34 +++++++++++++++++++++++++++++++++
 include/linux/of_reserved_mem.h | 14 ++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9db0502989c3..c83ef88dffe2 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/crash_core.h>
 
 #include "of_private.h"
 
@@ -856,6 +857,39 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
 
+/*
+ * Count non-dumpable reserved regions. Excluding each one may split a
+ * crash_mem range in two, callers use this to size the allocation.
+ */
+unsigned int of_reserved_mem_kdump_nr_ranges(void)
+{
+	unsigned int i, n = 0;
+
+	for (i = 0; i < reserved_mem_count; i++)
+		if (reserved_mem[i].size && !reserved_mem[i].dumpable)
+			n++;
+	return n;
+}
+
+/* Exclude non-dumpable reserved regions from @cmem. */
+int of_reserved_mem_kdump_exclude(struct crash_mem *cmem)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserved_mem *r = &reserved_mem[i];
+
+		if (!r->size || r->dumpable)
+			continue;
+		ret = crash_exclude_mem_range(cmem, r->base,
+					      r->base + r->size - 1);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /**
  * of_reserved_mem_region_to_resource() - Get a reserved memory region as a resource
  * @np:		node containing 'memory-region' property
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 55a67cee41ea..70db99f1fbff 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -8,6 +8,7 @@
 struct of_phandle_args;
 struct reserved_mem_ops;
 struct resource;
+struct crash_mem;
 
 struct reserved_mem {
 	const char			*name;
@@ -48,6 +49,9 @@ int of_reserved_mem_region_to_resource_byname(const struct device_node *np,
 					      const char *name, struct resource *res);
 int of_reserved_mem_region_count(const struct device_node *np);
 
+unsigned int of_reserved_mem_kdump_nr_ranges(void);
+int of_reserved_mem_kdump_exclude(struct crash_mem *cmem);
+
 #else
 
 #define RESERVEDMEM_OF_DECLARE(name, compat, ops)			\
@@ -92,6 +96,16 @@ static inline int of_reserved_mem_region_count(const struct device_node *np)
 {
 	return 0;
 }
+
+static inline unsigned int of_reserved_mem_kdump_nr_ranges(void)
+{
+	return 0;
+}
+
+static inline int of_reserved_mem_kdump_exclude(struct crash_mem *cmem)
+{
+	return 0;
+}
 #endif
 
 /**
-- 
2.43.0

