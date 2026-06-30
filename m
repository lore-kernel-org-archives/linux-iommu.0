Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D43E51DE
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805737; cv=none; b=HOstNqgVumJtz9iKE6igE1DIZTHCHMO3JCErT+GFvLQH+DX1lPHGzceo1yz+z8jhilQ+IhOPLHHKlUS0/XbvQ2c5/JbyudmBu8VQb561k8YUxAakXSm5UYFX7oZbxJFo4zi7IOs7vO6BiSkJmbdwuneJXslhfQyVx0GxAGzIgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805737; c=relaxed/simple;
	bh=no62Ldx/VYtMusTTq5JG8f1ZzMtpg2aqQYYLKUw/J80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsPvJ/xM2uFiPCckgTZEpxRhXcI0jm00/6hebZq9MDx2+K8KqcN+ZiM3VcCeKX8xES7yOI5wo75S/juymK+3Ssnbj6uStCsb5udgJ8jI119KPOf4o98yZmXdG5TvaXZKgkwh9nKRHEVkJqx/wwRRTf66W3G37kYQydhkF1pfX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKv6Sze9; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKv6Sze9"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2c99784b434so2273825ad.0
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 00:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805731; x=1783410531; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kilHQAUiYtCIXGoXTLzkG+QFNETPWES64QJavnYCw8Q=;
        b=fKv6Sze91HBjtfo/RsM4YmVPY40vhB66QVFYqihyRa7KHI55umN562yzAqg6R1O1DN
         YE0QYbcWBJbPn57tAPFkzT7KxF5GN5/PhunKu2CL7O8RM1SIuoCYWz70IHkBy12OtggY
         Wc3kHi1lhklf56q6FH4c3RLIqtxXSL0r1HCq1fNq9pb1b9zw/M8JYTDACJErHwJyAQPd
         FRsBFn8rIkEaZXGumFZnH4WJEfxbejLI6Uxp6b/reRbNDP9VoW5L1nL0efFtcHieUCEv
         8L+TVhesVJp5FrN/DFKKjXbObIjDiqaLMAu/a/a1jT8Y/KIpstckbmyw5fbVTs+QMtEI
         bXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805731; x=1783410531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kilHQAUiYtCIXGoXTLzkG+QFNETPWES64QJavnYCw8Q=;
        b=Hd++U0eO7OIeE9ssjdGGxQD+cAzSbLNiPkU9QdHRnuVgzXw07bo7U69PyynJCiBmvC
         vaDseMYAh80cPp0VjUHkGinQcgnAJXi9n84HNJD1SFXpmyMecExIvD1yd3HqmK4aQzvu
         Buzoxa79sOR/k+sSZS1Tv3TXYNsEsm6IJeWbFpKxHFBtBxwkwJ008S823hvXdT8wOk/o
         n3iwV3poTH63f+GZrJmkGb5iSblQGgUf/+cUSL6P0sG0AhW1wNoAuzP7SaizbWOd8NrK
         qdykzPNtrBrNg03qumdZrIvnUpgtqOg6BABZ7LVk0OvuHJxici+DklBexEwbJ9/6CPQ+
         qmrA==
X-Forwarded-Encrypted: i=1; AHgh+RrQsmmbWkuCPGpWMo/Ko5ZE+9PSTNzZEqd/3Y2BZlOG86CY/j4utdVcKVkgl2DPsmlFc5VT9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJkckauUhvsh++OYxzsGgIfiTjmyCnRgAA45jN0B/RwXNr+BEd
	UqFA46g1ukYDQ8AZYujp/TuPDvG0uPvsam5osqFMksepvkwXl7XGu08m
X-Gm-Gg: AfdE7ckHRxvMr52Bxbe3NNZGYn/O7OMzc11PcBYSnoyJmw/CgjAXq6fzyqxavQ6A0sH
	xicAdxgEEq0qhJ60lh1c0ujnree0OCT71k00kgbt1bIFLvmZPHf5GD/1xY7ffdbqiURXGNdXhII
	U4dAj9VT6REa6r1MV1Tj9IMvUiJfxC/vh4gLuApMs71okrPYCkNpT/hMFE79uN/x/f7DtpPvoW3
	nL+zo4M+dYdAcuf6RIrdbWdxhrc8LrFbUOYOVTX0C2bu0ZFgcV1H/efQ7epzBcw1zSY4KEwOpnu
	nkWtxYbJwidskNGkLbRcTp9VqhApPar9ykSgO2XqmPkdwS8NUH5DwVu1T5xcR7CA6rN98/h62Sm
	CCaYVI87yB6toIK906xgrekwNs+hDx1o8p0ORyH+9FDoGjHAMGeg/WS8/xpajpx6S8F4OeUMdHE
	gSR3Nltlyk0zdgMwGwvW0i7RpZCw==
X-Received: by 2002:a17:902:dad1:b0:2c9:d55d:2d3 with SMTP id d9443c01a7336-2ca2d55dedbmr19212325ad.15.1782805731371;
        Tue, 30 Jun 2026 00:48:51 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:48:50 -0700 (PDT)
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
Subject: [PATCH v4 08/10] arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Tue, 30 Jun 2026 15:47:12 +0800
Message-ID: <20260630074715.4126796-9-chenwandun1@gmail.com>
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

Reserved memory regions are excluded from vmcore by default unless
marked dumpable. Honor the dumpable flag to filter out device firmware
regions (e.g., GPU, DSP, modem) reserved via device tree, since they
typically contain data not useful for kernel crash analysis and can
significantly increase vmcore size.

Use of_reserved_mem_kdump_exclude() to perform the exclusion, and
pre-size the crash_mem array via of_reserved_mem_kdump_nr_ranges().

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index e31fabed378a..1d65320c6ba4 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -17,6 +17,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -51,6 +52,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
+	nr_ranges += of_reserved_mem_kdump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -75,6 +77,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
+	ret = of_reserved_mem_kdump_exclude(cmem);
+	if (ret)
+		goto out;
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
-- 
2.43.0

