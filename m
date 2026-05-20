Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F93BED0C
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268805; cv=none; b=Q7FyVYpzAkYDHNk1Ac4bSlK0sp+KMprpSGAQXwGkpiTF8nUIaG/1Ebruo91WG6OXITBL0KoSmt/K8fd6TARPLtM3lXN/ABa8l4rWg0WorlVOL1ngv+jfXLqpGYd3a99iV4+l32PIHKT3pAGj2FfI1H3Kui4HYygzADi3OO8BB2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268805; c=relaxed/simple;
	bh=fkGCsIowNsF/AXwiEqemLcl3yM1yUzs10iZ5x1XDEp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGGngCwHCnZzhhLyDBlTgtj/2lwExMTU1yKYJmrQDoapq1tGxD2pdhCy5gSd6+kvuJ/Z4nnEijeQvpFkSarKbX5JaoCBbB4zsRVLJw3zHy0BnqZTuJFBbJ0YtZbZ55prZPQ5BDhk3pbGfgR3hu/4CbQc7hxt//Z9LXwcxP34MQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxXuPAPs; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxXuPAPs"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-835b78c3797so1922319b3a.2
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268802; x=1779873602; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uewrEsj0ZjEAk2x/Pk2ITnSJY3Gqt9vqmVdLwg6RP/I=;
        b=fxXuPAPsyGMXL2jKJN5ibUVLIs8s5sKHbv5IzdgPe9ebCDhNWwR3HlKZ4Y+xq5xzCg
         vET2hJGSWaRhjSV1hcF3XmBenvZX17PJk0GTFrD/QidHlS35v+P0llxeRilIRUzeNDFU
         I116mZfIUVrGzP7DhGU3na0rLrsikUqwjU1sqsZkMgLaeAOeWpwZCxYjjkLwZ8GfMRTB
         otjq/QkPi43oFgJrO0jjXxkuwgu1g2OVrIiBxM7no5ddDdg0/M/cKnC3rC3ApU287kO4
         aq68FxUfDJS/+ZKLOHXzZQGvgDYET3+bkJ9D1a2jdOr2b3a+SFn8UDAxHjEScbBf6gCX
         sueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268802; x=1779873602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uewrEsj0ZjEAk2x/Pk2ITnSJY3Gqt9vqmVdLwg6RP/I=;
        b=fYsj/Xz5FOr+7RnAa2AHOHDH4RQdTET6LKw9ejSYVmsSvR31fL0yG55WXZ7ty9T61g
         Iz78d3h0mAwQEcdgtqZ80bDPZOA2hF8KYq2Tuu5a0BEPkiL/Cj809wNuzYNVgGTi7JuY
         EcrVAWzI6mQBWEjNzyakBjpImT3O+ueevdKr9n5hV1wEEErcd7axascguwd6ivRiDa3+
         0iNbVBQA6yKdCgvbywoztfS1ul0wrdd5NncIn5/qgRAbGVjt1KC6xCHTbKQYTIta/8Vw
         jZL4N6g1FqyQdZXiUEzhGhG1UFpCyQRHIIlkbBhn28oIBriYnet2MJFb7MHUeiG44RNv
         9XAA==
X-Forwarded-Encrypted: i=1; AFNElJ+8PGwY+y4TaAMj5euTEs82tO4ZCCXjGjNr64gz4oqIlYQi9e4P7z2wILRwy5dCV5tI6jECxw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8xOmPUuCT0N77jNUgyAYQNOCBtCNHJH3ctgelMKfIEkg5Vmdk
	PsxPpNJArneiQ0fVoUIxaqm3tCUY1IFkYmhF4BjO/5hMkebMiadZATLa
X-Gm-Gg: Acq92OEjE9Im9tZzrPFFaG7ScBrXbYmZ1o6oxlBUJZ8AZ925SO5FAzSfpqvQkfqVWap
	L4BCgnHvjtvsMUU081MNj9b97ZHkQlqL7alcE4Y2eGoBdsibfuquR1Iaukkeb++cenZUWy2uei9
	fguIDpaWi+Ykuh2u44Yiqx3Mvhb++fuZ5Vsr9rIY4sN7oJl2QTsHVFRTeyfRY081a7v72VyoFj5
	JqbIyaNXUcBjB5lq1SYs7eM4XI3ruHL9qaczK7tNQpmt+clkxm0V9Q16q4KBC1PXwDGeqQERYQ3
	Lt1R1FH0xlvkUz+fLzW72/TGSKADmw6DXoMbHUIyI3YMO++et/KWl/fl5E3Jxngd5fcwp1QFS77
	WqkLgd4ig2GJ2q7VftrqNLDqpMKscPBU2/fGsyyHLWqWLGZOyN8k4VXnwt2cMoR5sBRGV8+euN3
	oaG/MdOmeWopsaY0cgu2wwpPr0B2e9Z0KgGoW7Hg==
X-Received: by 2002:a05:6a00:1954:b0:835:366f:5da2 with SMTP id d2e1a72fcca58-83f33d80937mr23397364b3a.37.1779268802457;
        Wed, 20 May 2026 02:20:02 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:20:02 -0700 (PDT)
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
Subject: [PATCH v2 6/8] arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Wed, 20 May 2026 17:18:42 +0800
Message-ID: <20260520091844.592753-7-chenwandun@lixiang.com>
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

Reserved memory regions are excluded from vmcore by default unless
marked dumpable. Honor the dumpable flag to filter out device firmware
regions (e.g., GPU, DSP, modem) reserved via device tree, since they
typically contain data not useful for kernel crash analysis and can
significantly increase vmcore size.

Use of_reserved_mem_kdump_exclude() to perform the exclusion, and
pre-size the crash_mem array via of_reserved_mem_kdump_nr_ranges().

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
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

