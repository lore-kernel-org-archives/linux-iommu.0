Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276643BED66
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268814; cv=none; b=pq9qVTGTZLbCf5DJQCvGb6WAg9mSN82CZD4OVv0xxvdV2BxdpQEnSvjbQwzkC1VebERCsMum7xmFbpQsyQ4l17H26MbvtGfbql+RfWdoBud/gPL9Wbi5v0QwS0wsTtCtoBZ044gKY6KTfSqsrsrYH5ZYRxjMd0M0yMCDVJGouAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268814; c=relaxed/simple;
	bh=tykyc4F6DdCin3fut0O+1NMZ9opVL5h+xA3WkGtbPlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6zYW0x1uvWxQn5TSuIZUae3evE3KosCwbhfp/0dDSyTrJJp0Dx/ndobUUFqw2xw4oP9YLLbdGMusWnVRUAS7LUk8KTQl0WeCwWfbZ1wb3dGL6eB5JyqYumLnnFLG92w4K3S7+WF4x8Wn5m0Rb2rbHDUerlqACC4PfIKlp08/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+r/wcK/; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+r/wcK/"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-839dc688d6cso1998688b3a.2
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268813; x=1779873613; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTVbMKm3/twtkQTkDovvFEvZk7HsMSG4qE1A6oaHTA8=;
        b=f+r/wcK/GMpn4fo+36MkmlFvSNlSocTFBMqCWAwCQR28ZNLENOLpQoxJe6MmhG8bI3
         ViT03lJGUQAKurmJ8QsPKVMI4DzK63pd5P0Di+uFyWnKu28kqC265WdUpv26EezAllTs
         gD5Gy2TlmIrktsM6Ot5mwAeBdFvp20l8LjTntR3XuTuHD2JjHpmdaltH5O6n4pkAWqgq
         MExO9WEby9NHZRUOHfCqahwHmgSB3ieaFvX8MlnnqQzE1yJEqCyrTpYvBNl1SIajpTu9
         K7tm0j3mBrxmQJAM8vbLv32u+TJLVmhHOKopcYdUoYjA+JHHf4xBKZYMXuNjPiWxXX7x
         wmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268813; x=1779873613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qTVbMKm3/twtkQTkDovvFEvZk7HsMSG4qE1A6oaHTA8=;
        b=FF8XNa1UlLeNAS+AiWPQCGcWPtfFBZd+RAtZH4UjyqSnd6Apu1RkwAUBPWxXUu3HXp
         sl8in409x5lLH++HhdnUlJPDftz0ezaXq/YD3SYgDeqfqf9ITFb82Da7pNBXdmFcA5Th
         G04oQvfkbBU432l92WXqP0QHdxbOCUeHL3KlbZJ+9s5Co2EZhOfjl2/sxFxJsIQGAFo8
         utF+Zui1w2fM7v7A4/2WbEFVHaIAhJkNn7+03zx3s5JDzY6VwDzfBgFrjfGbiYM8xv5K
         EWW2qOz5PV4rh0RsREmJNBHQ7xZBXm1s+SEwUC4HKYX7cUyZTbIuXt6ew+bUxNVExxHT
         PIqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+FNOWoa1WAdl2EgCaOh7zMSYB+3SZxrLvNacTILCceX7M+SQcMmlGRwitb25OYJC8oXGySA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdwSWxEW02ou/+93+nvewDxeUG6dg1T6M75VZreNWGl+sbqBZk
	Aowc2C01NrJlycT46UCSuykkiv1flGFuP8UBbcLqSw7zyecbwNTs1zVk
X-Gm-Gg: Acq92OGLkk+ZkJ3BPwFwoQH9bjsANnxDLACI1vhq3yZ8eG3cbNGdhZt15+2fHVy9vat
	5ipAgDLp1zsppts29V6PDPw9qH+9Nz7aoqo0e0abJGAp2FaAguj9fxmEf3b3DTGm3hDg+X5l3YQ
	EL6k6Z6GnnanyETkt5ushbrPlXwLHGCw6sL3nePgfXfsRyqSGGXdVTcGaSe/aV18ubpAc3gYdOQ
	OyJvG0c1/jvXHCRv7quKUvC9RdR284jbSIWnVpVVhCoMyrsClWE5gOTDH/GmYoqbZ/fFBSHPKeI
	x1OO/Iwm0frUj4ejB1r02T3g8vQmDmhrcQKJps/6kIUUxss+/7J0ZUbWfauW5nlQTwZy1E7T6xn
	ctcsK8FPMqvOXPf7upXFMZQ7/bODMfsiQlZSnZHvC9tpqVDvgxlqN+VR2Cz03xXaQAo84g8zuRE
	gFpO2z6Z7B5w6TFxJzh4jTzU/Ff7DAOIc46eKJPhfeqXzaIiKE
X-Received: by 2002:a05:6a00:2295:b0:82f:832a:75cd with SMTP id d2e1a72fcca58-83f33d547ccmr23996834b3a.39.1779268812696;
        Wed, 20 May 2026 02:20:12 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:20:12 -0700 (PDT)
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
Subject: [PATCH v2 7/8] riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Wed, 20 May 2026 17:18:43 +0800
Message-ID: <20260520091844.592753-8-chenwandun@lixiang.com>
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

Apply the same non-dumpable reserved memory filtering to RISC-V kdump
as was done for arm64. Use of_reserved_mem_kdump_exclude() to drop
flagged regions from the elfcorehdr PT_LOAD segments, and
of_reserved_mem_kdump_nr_ranges() to pre-size the crash_mem array.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 arch/riscv/kernel/machine_kexec_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 54e2d9552e93..c359cf714c79 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -10,6 +10,7 @@
 #include <linux/elf.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/libfdt.h>
 #include <linux/types.h>
 #include <linux/memblock.h>
@@ -63,6 +64,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	nr_ranges = 1; /* For exclusion of crashkernel region */
 	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+	nr_ranges += of_reserved_mem_kdump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -76,6 +78,8 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (!ret)
+		ret = of_reserved_mem_kdump_exclude(cmem);
 	if (!ret)
 		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
-- 
2.43.0

