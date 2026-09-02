Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E73EC82A
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334412; cv=none; b=PDTcGUZfsjM54zwFHvERT/gV42XsUJguSQrUnogSKUiIJN8JKohWALnXVuysfxzjCD7sE9jH2RCylY8AMCqw8v3mzrWPMgQiR3jNdJAmSGqkOsl0kpd1nW95gL/31ZjJ6rx3JUXRctVz6/u8RwbE0C0PtVJoLY989ahC905dMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334412; c=relaxed/simple;
	bh=rOduSQdWEUvuONTVSGKgP+5LCjrhss6DGwsRFOyVRP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgv/uCsRvJLAAIsZqOPWoXpfGI4jyL1pLW0FPI6zsUTzfqSo4oR27jfpy0C88aWphL4A996IQN94NkGvSjWOkPXBeDgrSNC8TwGi8bIa7Tr7Kw0RJlQPJan1EyYFcpAbn/+sevsquZ0DeQe/oUGMc1k2uN12BrVJO4ytHwVgack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOA7X+PK; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOA7X+PK"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so237728a12.1
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334410; x=1788939210; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IlegJqwkFPej4fFKCV2MAr7wlJV+QNtxUfZHapDGJcw=;
        b=oOA7X+PKNVHOyBvP884+bsq0yw65wVAJppmxFBaTFce4Hya0HbkDZ86H9UHNC7tjNQ
         4I4p2AN+AebKeLaVkSF8TThJO0V0i96fKy128irqMfPZtW69qB1HJZoorS4Y1VUOezkC
         GrV5b9iUp0KPkyZ3lz/fhHEGUEnbQfrjq9P2/NbW6T9/tLg3FqX3Db067lO/MR41Jl2e
         yh0QFdMPUw7OP2IVTn/5cscn4rYBD6Kt8C1+vLSAEbeI8YCstd5+LeGjB8KuUhVAKkJ9
         jkO7AQjl88CwNGuMqgWlI7MAKZ12NZx/rcb3f11S4QVggC4HMctv3jY0lIVOuuWcEs6s
         2jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334410; x=1788939210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IlegJqwkFPej4fFKCV2MAr7wlJV+QNtxUfZHapDGJcw=;
        b=Lhe/jQSvjPN7WrGgxSGI8MSPKRL7AtU4KNm2Hl296fWZ9DnaHa5RYkR0YzexekiGYX
         HJvBu1USkFu81RsGOPsNidfgRe2Fqm2kKBvWU+HFkLYuYjtqFKn91HI/IaXucOft3qTr
         sJmjmgDUA2bY6dOZzcZZ+1AXvzsIh0bkjVPyF+H23rCNMMQ8tMCs5I1Zb2NRoNy+H0iN
         X9lQeNeOj1hJRS0THCdjRJa4sR2etmjRWhWhtyN+D5u15liqiwccQvbDttSWe6FQqPoB
         TT2/uiGhXC6xKC71TBcTAUHovX47Iq9zyX5Qu9Qi2siRD+wwjvLYsFbCs91Hir6nYkxc
         ES2g==
X-Forwarded-Encrypted: i=1; AKwUvBzmt6c74ORU2ezteyWKi0webXaGJvxMD68Sm+Vcq4+dhk6jnQri/SrSRcxc7Zgr4mJGZAuPpg==@lists.linux.dev
X-Gm-Message-State: AFuF++lIW7zr4zMPOyOf1O6F2PK9PlpiMNs7vhRyiq0+fqb6/WlEpDk/
	schEiWBlnRm8csGsLC4dPL7U3k5YVvhIk3if7x6/AMRKfMpyLqG8oapC
X-Gm-Gg: AYBFou0yYrUiS3Pf9H0OhiDZPDKfvI7qMfs5ENwI8+O+DsXS/SjkhbKu9rBOEU0SQLM
	z606tpr5Bbt2PTjIk63HoQ9m3u7bsd7fhJX+xNEI72bdKdxQK+0uCCJsW/STSPu4K6gd8TSFqGS
	Zf0pzHJXealMx1AkoeoRIR2Lh6RULNPRu1/MqjzJQVu+u/4eMBzVv2DlnVDA+9oJi0boOqf+h4o
	KIielbMF/OZhtjVAaMM2+mSk2QgQBFFoSMxkOzi6sClMGDcB7k3WdynrIZQt1TK5AiLVu0ByDY5
	RvlEsFKg15ANW/2CFYEvQB+aJ8q1Ckdm/Ak9DfXyE16KcJzOdShvQozf+nDHZJ7tCj+9H1UCz41
	RRhOvGQ6O32nuxeoR5mUGYgzEEMexuREeQhRFOGbhUGCzWXxfsCMM2GvQSGCh5O0mWLLGBN15zS
	63mam5+TKzphGqRyMVBB487PeSKm55GNYpfT82Wosr0Eh7lH3D4F8In2ueSTUORzmhmyIvnMGh
X-Received: by 2002:a05:6a00:4408:b0:857:4dea:e2fe with SMTP id d2e1a72fcca58-85ed8ed8414mr5132871b3a.13.1788334410213;
        Wed, 02 Sep 2026 00:33:30 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:33:28 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com
Cc: mark.rutland@arm.com,
	kernel@xen0n.name,
	alex@ghiti.fr,
	hpa@zytor.com,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v6 09/10] of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
Date: Wed,  2 Sep 2026 15:31:15 +0800
Message-ID: <20260902073116.802752-10-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

The /memreserve/ entries are memory reservations made by the bootloader
or firmware, their contents are not needed for kernel crash analysis,
so mark them MEMBLOCK_NODUMP to have kdump omit them from the vmcore.

Entries that overlap a dumpable region (such as CMA) are left unmarked,
because the pages of a dumpable region may carry crash-relevant data.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 drivers/of/fdt.c             |  1 +
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 286fd4db6312..9a727941b5af 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1286,6 +1286,7 @@ void __init unflatten_device_tree(void)
 	/* Save the statically-placed regions in the reserved_mem array */
 	fdt_scan_reserved_mem_late();
 	fdt_mark_reserve_mem_nodump();
+	fdt_mark_memreserve_nodump();
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 505735732c13..6497404ec751 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -188,6 +188,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
 void __init fdt_mark_reserve_mem_nodump(void);
+void __init fdt_mark_memreserve_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index f29a07e8fb23..a42cf6eac55b 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -251,6 +251,39 @@ static void __init __rmem_check_for_overlap(void)
 	}
 }
 
+void __init fdt_mark_memreserve_nodump(void)
+{
+	u64 base, size;
+	int n;
+	const void *fdt = initial_boot_params;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	if (!fdt)
+		return;
+
+	for (n = 0; ; n++) {
+		int i;
+
+		if (fdt_get_mem_rsv(fdt, n, &base, &size))
+			break;
+		if (!size)
+			break;
+
+		for (i = 0; i < reserved_mem_count; i++) {
+			struct reserved_mem *rmem = &reserved_mem[i];
+
+			if (rmem->dumpable &&
+			    base < (u64)rmem->base + (u64)rmem->size &&
+			    (u64)rmem->base < base + size)
+				break;
+		}
+		if (i == reserved_mem_count)
+			memblock_mark_nodump(base, size);
+	}
+}
+
 /**
  * fdt_scan_reserved_mem_late() - Scan FDT and initialize remaining reserved
  * memory regions.
-- 
2.43.0

