Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8703B6C0E
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268794; cv=none; b=at+ZGvjcMV2gR9o63DaOZypb78PUtBqTwRtuikc92FiPY8gCCDM5J5eD0ldHl1dwkEMi7n6tQSve9+hAxeztG5l928Gzk6vL2OVCLRdc6u/IXGnFwE9wvql485JKdlE/992GMDCjiyruClA6l4VnKcJ7vMVjVijgzE6QkAwnsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268794; c=relaxed/simple;
	bh=DixxRB+/67Q1zkAFDPBGZyJxWiYRN5jMpXd6m5DN7R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxz8Md3hy5CcH89pWBo2VDzg8064KSKnohvjOvklvmDuEK8HomuxXDatFO78kmzOuMpoMwkd0DNdnlLAUBqVJDJ0qUFXeZDXMWGeb3obFQrBORXJ0mfDCP2fv0KOtkBRbBFSmw2e185Ir3qoOLGVYIJVhH0OzbCsPcbucRXyeIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0r8t8l5; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0r8t8l5"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-837b39eb078so3141698b3a.2
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268792; x=1779873592; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42F8CHAqoHCrwDp1G0wHxf9X6caXzIhKy/g2LWPqXJ4=;
        b=l0r8t8l5IFE4RBpB7yvj3HhmUvXz5sUDUjCMooNs6Yfeudtsy+Z4HcbxhzlPdNoZLQ
         EZRqGQRnvlSFxOXvQZZRd1A9gYgezZHMbI1QVSJgxfjay54hPxZsa6P+Q7mZtWA5ts0C
         c89RzGEsolOfuwHXRlbPvZxQlXpp6MJ/latrkDT6/EdCFehWBnbhNQT+k3psfilvq8Be
         BE3gcKfpnbS0hJ13ow5mIcbC5iE+VRaSUkHH04ORK3apSsimhIOzg7SDvxoRQ3uA061D
         t2+mCrc0UnMTR5piC3ueV6mhNP1qn4gWrqkC9c7KxpmZUoyGac5jChamfW2Ymw7hVycI
         +8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268792; x=1779873592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=42F8CHAqoHCrwDp1G0wHxf9X6caXzIhKy/g2LWPqXJ4=;
        b=We9fINrorDzNjb327c28LP64+drymTVEgiGGx8HJvnGVJ8LoDiUKVRhdmBCrgiwJqZ
         8j7U2kZ/XmCK1uN5MISZtfAfMqtoIyqZ6Rk1nD3xvV23Nb3qGpbs+s1O1wGpndTIE6fQ
         FRf4EKLjE0CyZtN1YF73rmjHaWAY2yG8JD39OleXuaLkbanXPRHQMIEXeNEDW8ndd7l2
         5QHcoUwr+jv7OsqXVIB+3MktpFbEQe1FNgCdr0vUGBflb6rZAura2QzRz+RPrfG9j0wM
         xITIkHjsUBn2jD4qgEdSqF94koMzmEh0QNUqZi0MxhajVgPG/kEu6n7lrnU6HP2USWzS
         xP6A==
X-Forwarded-Encrypted: i=1; AFNElJ9MjbmXxjYq7HPI0xmk4Cp0MUQcNKo6/S82cHttWSFa+5fz7x/4CMIVEj6MaWgkbvA1XF9EJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtkgK75dkoCOjZMQbFsiGyBiD4gAJX1IHEMixgQFNhCgw/iy8a
	basoaO1DwRImIKLXk1vcBeBvMHD0skPu/stEfJWumPjd9n+zgK17vdBy
X-Gm-Gg: Acq92OEvshWtAdtiR26qV716S9xiv53PJMtLOMT/x6Gft6W4xEcMpqltQnZjX8+EvHl
	byQa/GtAmBNzzWq/8cmKHHUNVE3RjedeiWg5sL9DPOxTyXlrlw3xs5GEITZNZGqn+JQPWKFMybD
	vtXKFFuTyJXiqTjy+KgDDGfnXxGqo00B93XCcT7mQ3f3pUur6kM+tkg/QVtmhotvaGPFgh1JT19
	aFU2HZYNdiDZ2zxo1mDIPa6ErNFVxFR0QNNdGd6u+eYaVC0LNbxqMT3nWiB8OJf6Nxq6KJWPx9t
	vj0dizdcT9MCC+cKcRhaZem7ZtuyQMQC576BVG3Nh/ETVjG7ZQxSOri0OVoPq89d99jr/KJAwKM
	V6J7ttpGeFxPd/d1FcONaWVLur12Z9PsF1o7cHEZ16uTKvJlY702FKH3lT3y+xwRpYwMryH9mDl
	hb0ZPRzn9EWAYYsM2EpL9S9Qk+O0HQW/w8cQgG/w==
X-Received: by 2002:a05:6a00:ab0d:b0:82a:6ef8:cb43 with SMTP id d2e1a72fcca58-83f33b34ca2mr23552441b3a.19.1779268792063;
        Wed, 20 May 2026 02:19:52 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:19:51 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
X-Google-Original-From: Wandun Chen <chenwandun@lixiang.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	leitao@debian.org,
	kees@kernel.org,
	coxu@redhat.com,
	tangyouling@kylinos.cn,
	songshuaishuai@tinylab.org
Subject: [PATCH v2 5/8] of: reserved_mem: add kdump helpers to exclude non-dumpable regions
Date: Wed, 20 May 2026 17:18:41 +0800
Message-ID: <20260520091844.592753-6-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520091844.592753-1-chenwandun@lixiang.com>
References: <20260520091844.592753-1-chenwandun@lixiang.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun1@gmail.com>

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
index 6dfe9e03c535..ef9732865783 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/crash_core.h>
 
 #include "of_private.h"
 
@@ -851,6 +852,39 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
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

