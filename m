Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD03BED4A
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268824; cv=none; b=XPIlt/+efGkbrr1E2lxw2SVtfSrZMDiLDCmtPbneSWXwIb3AhE8N8CiAopQNxQOH2O5+uJiMTWrLDrONhf1HgBOTaYmfZxCNyNpmVSs5Pamyg7jOTllQ448jzgu413DyScwdqYlGB4HSFo/D75pll3hiutRzyk//c0+UeOZVCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268824; c=relaxed/simple;
	bh=vEY3z8jVj8nmsWJisxSq9AhqFt0JmI3xyGszSp/YCcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrOZDbqSbjrmLWWV4gFjUGrcMLDGOR0ztx2O8G+Hfi5siRpiLv/VX4HSOt6lCrqxr60giwbGxxciD11F+gyWI+oSsZf21IvvIGQnN9eB0m7RmT3WrIb6ZvJkThzXFSpSEcaeRk9OpuXmox7fr+23QYqYNsD7+PM1q3QJ1Ujqu30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdz7gXoa; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdz7gXoa"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-83d5bbef760so1952786b3a.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 02:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268823; x=1779873623; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF4iEePz0efKjWWczqPvkzIUeB6xqHtDsvairyfmeUg=;
        b=sdz7gXoar5r+7ki1Ezr1y2i7c4cjI/bmgFlQEnegSz54fcInIIFANHhlq56wZtsKiU
         +yvqNKiWsLqF9GrlOAIhOny1Q41I7XkJtdDCHPAqY+DmMGwGgL98Gqx5IizhY/qpcCFs
         JJL2P8U5gEz3qDPnwFjfL33e1FLas0oapaBTq1bCqjIOWhFTp8PB/34LC7LWBg9LPMc+
         E/5P2BfehZWeVQYmADyycActvYAz3JW2Js4KwwD8zTQ7GfPqvLUHpuPZ16iQ4tZATwAJ
         h1e/zE+5mTu4+ALkGv9No11TnDu8NjRHclC/CqL55x6q7clGT9ntkOqNuJYKXuDPQ7dR
         YrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268823; x=1779873623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yF4iEePz0efKjWWczqPvkzIUeB6xqHtDsvairyfmeUg=;
        b=AqZGzP8s89qOeoEkVvePSMIJOHvl4J+5bYEPMUhWaEbkHgPCfpMUf2FZMwp0Ujr6RD
         mM+h48WPJfRJBgDZBpcQEz308ZlLTcmfOTcc+z2Y5Wji/Z7ORXPGDm3xVBuP7VmVzp+j
         yV6PhN6btgXfqvnSFszKqR4xMDBBCidjcla1FzxUuYhy/ScNDMU1wHe1a7240HheSOHd
         svHoAWMYPm5CpRXMWayOaGm+GblIrt00/FGNtbYj/K/znsn0wCw+8nGXfsIV25SL9kxN
         WQL5T1hS03A07v9nBDwj09MtoMuMGsV4rkSIr50D7V9jQgmPeUe9jggCzMEEOpqgtXfd
         77/w==
X-Forwarded-Encrypted: i=1; AFNElJ9qcpX+s9Y4J5UGkZkPBQ3r1T58rnNQSLxwk/AjLZ4crzOG9CQO3WISiAo1mev+13bCoi1yWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq88YSdSV1tO6Hnwiy+YVHWFy/uqyBETaev4y9qN8nOJCmKcuc
	t4D+aLIdv6NL3/8yzmVXz+oxocX4/2nNTRbcIRkFPmbVKIVeDzh8LpA3
X-Gm-Gg: Acq92OETMKKOel7KBADL707kBAABVu7t3612f43wkfx8fkh5MoupCOmBNWNS3d1RCbL
	El7XegxoVEylFFZ2eGD3CX2CR+TdpLNw5vy/YILgXgG9YpFi+nrMDfJdErXVbDT4oMPhxet7IWH
	NOb0QrAdfHGeDmuo6vEyvckvAAkUEfBX0gK9bogLXLN6N8+lfSaY3NDPJhaCFGCP+cFuIYAMasG
	1tZ1Dbyw0R5G+snD/CqTC1Q3vphjB8FoBqX+yQ58iN2OpI1Q0OETIKTPt4K1xEFoddjb2+ScrM1
	JX6oorC+2hHhkkI+BcrplA29cKLkI3Bu7LvHLskJksS+Z5EX3ZFU0fhm+gVojza4gj03MERWJ5X
	sMmH2SoE4+aaNtbPeKHd9z5Rnz/wqwtdwnynEwFiFDv2Q4W1UvNGX0qZ03jkkaJP/EMjH2h5jkq
	YXJ1JwRfKB9l/RmMcukS19fS2ZjBiNBV6efQOZKg==
X-Received: by 2002:a05:6a00:2e9f:b0:82f:6e7:152d with SMTP id d2e1a72fcca58-83f33c391cfmr24600140b3a.21.1779268822961;
        Wed, 20 May 2026 02:20:22 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:20:22 -0700 (PDT)
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
Subject: [PATCH v2 8/8] loongarch: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Wed, 20 May 2026 17:18:44 +0800
Message-ID: <20260520091844.592753-9-chenwandun@lixiang.com>
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

Apply the same non-dumpable reserved memory filtering to LoongArch
kdump as was done for arm64. Use of_reserved_mem_kdump_exclude() to
drop flagged regions from the elfcorehdr PT_LOAD segments, and
of_reserved_mem_kdump_nr_ranges() to pre-size the crash_mem array.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 arch/loongarch/kernel/machine_kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 5584b798ba46..c5cead362d2d 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -67,6 +68,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
+	nr_ranges += of_reserved_mem_kdump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -91,6 +93,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
+	ret = of_reserved_mem_kdump_exclude(cmem);
+	if (ret < 0)
+		goto out;
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
-- 
2.43.0

