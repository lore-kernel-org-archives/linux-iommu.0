Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22E3E3C73
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805713; cv=none; b=LY4v0C1ylZ73/zm0ShKduwJCo05foObqrLLF6OrKYiCvW7VmtN+0wr7Quy44fD+ljTRPXH8+2vG+9WXnl4DzYf7HKKtNmdPg1nm3drXHNL/L0zeG7NCRd4wTDy+IeY5dIKeth0FDYeP62zaVB6dHboSulYR2es/ubg+88QelTuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805713; c=relaxed/simple;
	bh=5VDdvOioCyiv7v0NuhryTu7UmcEbfixHAtdpdJcVQrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKdHBcf258i3UgYSeilGrXu2+ihDqxfEpeo5q6AlLGLCDJ+MXrWkXC3HeevOW3trTbiaG1sUHqDwK4znZiXZ052GSQhOtRNJmy8+AOvAfi+eKZOxMj+Ouj9dMtIfMFe0E6FStSjDnaX2vVeLo0mUyopi4OBNfvXk+8VVViylR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA/DeFgy; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA/DeFgy"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2c825308c4cso1968935ad.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 00:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805710; x=1783410510; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOeOq8JJcDQksJBuje0bYH/ntMqvxfxyxa0O7Jz9Ya0=;
        b=VA/DeFgytl4uZ6Uta+jK+4wzpEnHPFBS0pfptEQQFOL0h4uyLyQKzrSinVKg6llz2t
         kN4KW3SzRaDCfLEiKP24hLMyF04AfNHhyimr4hI0URiNIC3pvO35vdOeQIv2U+yTCVVe
         rOLLTO0RYkKKi3d8ZaxfiQFIwxVg8+JvyXEcWXBBYYWZn3wz/Oq/y4zVgyjsEs0+QiME
         X2fDXvtcOFMsx86wWfr7Gkp/79ZAH70g7sQ/BFlNvBpDh7x4d+VT+hjbdUo5rqFwzJ34
         yT1L1oJ9YKAYqpC/c9EiRwQJE8BfEaKPWvibafTBfAwqwPkW8J1SB3jN7/1OCbQvuj0T
         0THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805710; x=1783410510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kOeOq8JJcDQksJBuje0bYH/ntMqvxfxyxa0O7Jz9Ya0=;
        b=LdDzIe2deROblVyC3y1ldiZIZmS7UQGPS+qolXfKHbaXVH+i0TnLO6y4fze9un7GX5
         MqUjIOdPaApMqY1KC0cZ1gbJQCKRb7HTSrX9iL758BgaISD1zV+eWiCmZGPq+izqBV1d
         g9baOijUxH3AE2NCzQFI/gA8FG+/HW9s6CLkhuBImppy2jNRzYBFwplrgmUvXsxedoj4
         pFGQdnpENqTAjoS8H/X7fyJb1DobPUsA0xZx64x+5DlgMg2tHmMw41PThnU8j/fm9Zn8
         gnzlZYRVRDWo6wD8Ss1eu63qGEeesCY3wxljJFt0JZdX6ZNBHwbXja1MLgKasj0T2DAK
         XkUA==
X-Forwarded-Encrypted: i=1; AHgh+RpoAQBgN19apXJYjjqLwYXUl/wP876y7qwboDiSVNsekd/+urZqfw1ECQX2eNNhTZ1d9l5Gsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWW8YVa1deKZUzQN/tIaW8oOYyMC3MuB61IKHPDsdazNWcx5oY
	dYplKZMjlQgUtmp1mnrPlNAQ/N9pn9eEMX7l//76s391GWWolPk/l6JI
X-Gm-Gg: AfdE7ckTiqm8At7Fbtj71yEvWBMNOqVx7A2Vve86/DwRSfwHGsKFbewEtHZdqS6fbDc
	XaG8tYc00GT70AD+st+2cExDHFvy/LCf2krFVOPFR3vRwDEkUOfg7i2jk0FvQjMcguzVseCMS6b
	XSHlYOuWS238iwGw/uti66wK5+IXxy90cKTvrT34Me0CEgy6+tBBKi1nVX7v7KMLJf24OgzMiBo
	+UDH4Pyhzb7v7N0KrNdl8JA+y+IFmbdLRNOI0cjlq8ubt+FlAMwy0MpQh/Lwr92ZMDaCm2LFq/l
	RjNgGs9blHeFwlZd4I0z8UWtaDgSY3+OL3lL6+mM6t9xZdMXOgjD7H4ltllRQ/I2kWFRvo0quAM
	ihr9ITJb4jx9/IvzjSqg4lP8TJG1pK2E3rfSxO8fBMpXcxXOstUnCp7pryanwAKSZGuYaqxsvDC
	ny2xT1A6y4gzceyHffPDJixTEskA==
X-Received: by 2002:a17:903:1a26:b0:2c8:e13a:f23a with SMTP id d9443c01a7336-2ca2e714d17mr18921635ad.28.1782805710141;
        Tue, 30 Jun 2026 00:48:30 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:48:29 -0700 (PDT)
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
Subject: [PATCH v4 06/10] of: reserved_mem: save /memreserve/ entries into the reserved_mem array
Date: Tue, 30 Jun 2026 15:47:10 +0800
Message-ID: <20260630074715.4126796-7-chenwandun1@gmail.com>
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

/memreserve/ is used by firmware or bootloaders, such regions hold no
useful data for crash analysis, they should be excluded from the
kdump vmcore, so save /memreserve/ entries into the reserved_mem array
for later exclusion.

If a /memreserve/ entry overlaps any dumpable reserved region, mark
the whole memreserve entry dumpable as well. This may keep slightly
more memory in vmcore than strictly necessary, but avoids splitting
entries and never drops data that may be useful for crash analysis.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 drivers/of/fdt.c             |  4 +++
 drivers/of/of_private.h      |  2 ++
 drivers/of/of_reserved_mem.c | 52 ++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index b97775f6c9d4..3e478d29e247 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -497,6 +497,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	int n;
 	int res;
 	u64 base, size;
+	int nr_memreserve = 0;
 
 	if (!initial_boot_params)
 		return;
@@ -514,7 +515,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		if (!size)
 			break;
 		memblock_reserve(base, size);
+		nr_memreserve++;
 	}
+	fdt_reserved_mem_account_memreserve(nr_memreserve);
 }
 
 /**
@@ -1286,6 +1289,7 @@ void __init unflatten_device_tree(void)
 	if (!alloc_reserved_mem_array()) {
 		/* Save the statically-placed regions in the reserved_mem array */
 		fdt_scan_reserved_mem_late();
+		fdt_reserved_mem_save_memreserve_entries();
 	}
 
 	/* Populate an empty root node when bootloader doesn't provide one */
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 81c8ec9378b9..a67929c0a6ec 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -188,6 +188,8 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
 int __init alloc_reserved_mem_array(void);
+void __init fdt_reserved_mem_account_memreserve(int n);
+void __init fdt_reserved_mem_save_memreserve_entries(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index f6c02b37deb7..9db0502989c3 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -251,6 +251,43 @@ static void __init __rmem_check_for_overlap(void)
 	}
 }
 
+static void __init fdt_reserved_mem_add_memreserve(phys_addr_t base,
+						   phys_addr_t size)
+{
+	struct reserved_mem *rmem;
+	bool dumpable = false;
+	int i;
+
+	if (reserved_mem_count == total_reserved_mem_cnt) {
+		pr_err("not enough space for memreserve regions.\n");
+		return;
+	}
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		rmem = &reserved_mem[i];
+
+		if (!rmem->dumpable)
+			continue;
+
+		if (base < rmem->base + rmem->size && rmem->base < base + size) {
+			dumpable = true;
+			break;
+		}
+	}
+
+	rmem = &reserved_mem[reserved_mem_count];
+	rmem->base = base;
+	rmem->size = size;
+	rmem->dumpable = dumpable;
+
+	reserved_mem_count++;
+}
+
+void __init fdt_reserved_mem_account_memreserve(int n)
+{
+	total_reserved_mem_cnt += n;
+}
+
 /**
  * fdt_scan_reserved_mem_late() - Scan FDT and initialize remaining reserved
  * memory regions.
@@ -305,6 +342,21 @@ void __init fdt_scan_reserved_mem_late(void)
 	__rmem_check_for_overlap();
 }
 
+void __init fdt_reserved_mem_save_memreserve_entries(void)
+{
+	const void *fdt = initial_boot_params;
+	u64 base, size;
+	int n;
+
+	for (n = 0; ; n++) {
+		if (fdt_get_mem_rsv(fdt, n, &base, &size))
+			break;
+		if (!size)
+			break;
+		fdt_reserved_mem_add_memreserve(base, size);
+	}
+}
+
 static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
 
 /*
-- 
2.43.0

