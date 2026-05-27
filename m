Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9035DA6A
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 03:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852652; cv=none; b=ubml9vFWlc09XGs5aXcybH6NGdD0XQsxQ+P/7B5uKQMOOtf9acgolRVZLMG3MmSOvPF6gVwoHjt1jmv+thXqPIir2EaeIQzs81McNQqb47QDLKoGOExD0dmtv0hN0t0pthNHX9X+KufrzLR9MasKVqZXv+d3psVwud0sWKdM3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852652; c=relaxed/simple;
	bh=IfXCRdmwexWW7Vbl6gjRH+otd/tf2AYvx96uLWwkESU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sw/kYM8pkCdrSJMcsdl4DdDI1QR/dAOBT3afx6dbt0Ws/bFLwQr2ZfCOFvrjr9GiRe+RvjDrRq53NcFHbhUZDh6hUq7f/tSxk/Z4BMmlHpmmG+CM53audwHMWACMoyEhKpvl8Sf+1vDO3IC40hVNjmXeWIvsBx4OclVlBGnSMwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv9uCfo0; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv9uCfo0"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-8419ab3a297so1122585b3a.2
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 20:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852650; x=1780457450; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p28EH8R5CXtCwys+lC44uig9HB9HdXcu6ohyUKifVw=;
        b=gv9uCfo0U4/Kfvv6rhgx7QK3+64kxYcbP/HD+fJUY47K/tv2k2od3gSjwOvNAgvyOR
         xdCtRYNvkndX1TNrIFRSz38c5ALRG3g7ABlgWE6YiUuNpEePVPTF6/a8PDd8/ysfN0uK
         ZJxipNvfs0kd9BVz5QeSYu6hdOu/BwKdhRhAV0scGOYuKvRBM9xUSV/qvBMtWtWUZM16
         9GfolI2864E8Btw2pDmvZ1rbTzyvhG0h0GsbLZaL4bR3+CLoyEXtKT549QRx00+G+bPG
         8tvc46EO3+p8BnOWZGP+MjwuCNFH/nbIeTrLFEcTXLQsBkA1+yUYhQMBn5vXGXFvuFjh
         n3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852650; x=1780457450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/p28EH8R5CXtCwys+lC44uig9HB9HdXcu6ohyUKifVw=;
        b=p1VY3NpmA1gqUFL0BgKqZy/4K5QmAOflpAL+5sI+BVvEn5Yr2xfVPQruYMneLlz/YH
         XgJ0lFnR6d4oIXf3Y8/CoZOA9GFRkQGHU92N90tNXyRCYyKILOT2iN2SDPglpeSHANLO
         Y+KYzYrdF8aY/wGuCjHVM/Z0y2CtLYvE7LR1AbUuofBW2z/bFa//tjP4rYkKvGZoYGaL
         em4vpqnn2rT7e77V4Yg3A+fDS82aXrRaNG+RNHP9m5G/nV+Jkiq+ukAOjIlWKDTFbIPE
         dBy/zNFlz0vJnZhOl0wZjB6Rg3ahA4ap3VtbXddlFwQHNjtPCZou5djn0f6NO51n4a2g
         26nw==
X-Forwarded-Encrypted: i=1; AFNElJ+c/1DofvCBgZBl99ubcFt48y6Kc0D5oA1UQRNZtrJuWaY6fi+L1qNxkGFDAmGryoEnJnJL7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdczYCTxG7aLprKxr0TcJGYRUB6pbGJuFSSyb7srtSu3UDiqfa
	aulEqN8n4KmZIUR1YtJ9CBz+l3+PYQE0nf/Adg+eu+od5oZs+O0yIK7R
X-Gm-Gg: Acq92OGh5PIYB6WKutCrTSNtbYSVi9dQ5Ami6IeXFaQFZ8a/SmsKKHPq0bifBi/jO87
	eEzQ2Qfo9lddulAtaKXK9+QOx0v2sKypEIP3dwUIXDh1XZduwXxR9sOVf3YyFtkT6+PK2ew0hxG
	4aNVHsVzDCgW48DCselM3LURI/j6JwLLOtgg5+I95uoQukv2QJj9ALw1R/CW6qCjoL0pumg9s89
	0VEzygSpEKJS4MD6eK+GzeO81z8XxkYSEQ4cmhxfVA+oq0MJlLcUJ3L4eNB7ZHJ67J1Hc+gQ/I9
	LjIeOYehCt/momTkJ3c+fvHwuJh75JM/uvig7k5ORymPtr2Rb1MgPg0SM2zIJxRKDTMEh+TG6IT
	dL6jf1ZfxytxDCJ8ZJFL3cvw4yJqwsvloXvd0EK/XCSl9NquuUiq02fs0awBtMiHEFHks3BUyQm
	1OVlJmLqsl+3lI//MeuRDd4Ckb5TousSmRz28q
X-Received: by 2002:aa7:930a:0:b0:82d:24f:2509 with SMTP id d2e1a72fcca58-8415f0e26b7mr20587500b3a.1.1779852650451;
        Tue, 26 May 2026 20:30:50 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:30:50 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
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
	quic_obabatun@quicinc.com
Subject: [PATCH v3 07/11] of: reserved_mem: save /memreserve/ entries into the reserved_mem array
Date: Wed, 27 May 2026 11:29:13 +0800
Message-ID: <20260527032917.3385849-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
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
 drivers/of/of_reserved_mem.c | 55 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 83a2a474831e..745e53b1c564 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -499,6 +499,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	int n;
 	int res;
 	u64 base, size;
+	int nr_memreserve = 0;
 
 	if (!initial_boot_params)
 		return;
@@ -516,7 +517,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		if (!size)
 			break;
 		memblock_reserve(base, size);
+		nr_memreserve++;
 	}
+	fdt_reserved_mem_account_memreserve(nr_memreserve);
 }
 
 /**
@@ -1288,6 +1291,7 @@ void __init unflatten_device_tree(void)
 	if (fdt && alloc_reserved_mem_array()) {
 		/* Save the statically-placed regions in the reserved_mem array */
 		fdt_scan_reserved_mem_late();
+		fdt_reserved_mem_save_memreserve_entries();
 	}
 
 	/* Populate an empty root node when bootloader doesn't provide one */
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 50e5a533e059..30954e859689 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -188,6 +188,8 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
 bool __init alloc_reserved_mem_array(void);
+void __init fdt_reserved_mem_account_memreserve(int n);
+void __init fdt_reserved_mem_save_memreserve_entries(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 888dcb6bdce5..5e27f9403786 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -248,6 +248,43 @@ static void __init __rmem_check_for_overlap(void)
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
@@ -305,6 +342,24 @@ void __init fdt_scan_reserved_mem_late(void)
 	__rmem_check_for_overlap();
 }
 
+void __init fdt_reserved_mem_save_memreserve_entries(void)
+{
+	const void *fdt = initial_boot_params;
+	u64 base, size;
+	int n;
+
+	if (!fdt)
+		return;
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

