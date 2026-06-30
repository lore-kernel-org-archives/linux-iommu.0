Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760133E316E
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805743; cv=none; b=C99zK27MRv6JzOBSNBLsfsYmiaBCooKdi9Ge98UqrxgUDRzzYemcDe/ujCReBdyjiv4Z4IKcNGfZnu/Vetx43S0EG1E211Ttcy3i1S7o/by9snHc/fORGJfoTvPbMCR1D/AjnyH6/2KOoRyzb4VPJ7QW4iQGLO/56g8YP3EC314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805743; c=relaxed/simple;
	bh=y6ocNgSkfdA76nqYi7hGDzpnjmSBmWUarRvhw+f2qaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+ExgCobdEOP8Kkf87c0rbA3pYDA+G8u1oDL4KDykkSD0KY6dJUd7Xa6IAICzs2TNF2fhIpHNCSpRJJ09+07P7GbFJFQMe1H6DWZF6nEb+ogEIGqTQv5yUEupTd5FmgRlm8B1+q5SkJGWphwIe0umf6mxUfkizA/LHaE6BWVHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESq8K7np; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESq8K7np"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2c9ed0c7fc7so12811935ad.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805742; x=1783410542; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miEM+ZI1eBAN6H+hUm7y5SHAIdsM2tNi01WsyWumT6E=;
        b=ESq8K7npjBIEu2E0gtZ0KbEJxFBAGwr2xQemqGmIu3zO2PliQ32XXNdIEljsLqqrk5
         er3rORIFj9B2as13Z64LUjILCzl0ehVG42rjqc7Vi8D0PcQU4gtKasBahN/QfU8NRKa1
         3lX42AnllJPx6dqd0xLfLeLkeL32qFv7Y3hXRFuk+qmtqGko9YU50+GI/reVAPaaGYXB
         srqFVr/CY8GnRPjyYExhE780df0dxklU4uMv2Scu/kD1RNygVL2FGhGG56j0fZiY+iq7
         x173km/XsXDv43wcZopduKDya9dDvKPhZE4cu4vg+zbd8xVJsyMZqXitVkLUHgmRpWvE
         YBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805742; x=1783410542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miEM+ZI1eBAN6H+hUm7y5SHAIdsM2tNi01WsyWumT6E=;
        b=ZJWN77QB7nluTcAUBQQBkvEvjKLk/yW1obvtzwXjuGO9dICnwNUEwf1yxL7xQr00We
         NOFncpYHDw3PBmwWpqkG3Js55zdbVfrsr9ZnXWQgaEZq3hnnGVNGx8yEZXZnJT4Pd5ih
         yGzHnTyAa68O8DilyfbkiTdFsyDq3Dw8vuSFds/RHhrSoKg6Sd34gBqxGLOBKYNHbitb
         NVj6v34Hj4vAk1MAGWZ2YIebz2FVOmFSwGK8SQ59gO7C/8plq0hqIZmkI3/FKtLjPVU0
         o+HeQ9B6j0K9Wva401O+MIY+ws8TMRoIXtIbrWwPJLkWARtW4lr4w53N3MIbbspqHCG+
         b1YA==
X-Forwarded-Encrypted: i=1; AHgh+RrzAhN5Hev+pEkdChXIFdTkVsCC10rGYUojRU1RERwDHgtDi0xwBXF/+qBuK3YcpeGkukyhGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMpEzqeuGVDTb5Mg8kLESNGpLiEa9Y5KVganLUyhJAUZgvy3jt
	hxUNU0qOzUBNO72n4VtAhOfr1kynO74PmV+Ec0g7ksT5wuS8c2+2OgtB
X-Gm-Gg: AfdE7cmX0ZDGM9s3+IAg71+H1Uu00jwMQFDrcmgbplpkXMoWA9sIqU88dId+ch5wdps
	rTE39fRAmDxvS+OadDyeo4oI8nydvLNPALC95o9soC7+x37FlFTa3ec87IVkhmcpxPpEkws1Ky5
	GSSvndeGZtxCHLMBuVqdVIxCoQTNWeWMp44ih9Wsb1HUzyivjhjn4rAWGwOkXZHp7gT0d4sLftc
	58U0tuImpIxqZNqhzrJEh+vZNUPMmXA7i/HRsxJxw2tO6iQiWvf1s6woLQd9Ex6hBinWu8xTFIv
	aK6Thvs7G34WjRyhlTaF2XXwYyK1j8QKKVwrntkYhk4VnOA+PIstmS1RgFELqwbT7r8t+VidSJw
	QAcBtty7FEWmnHwqPUtiyJyUyGUSD5jJKnZ4Einh/HwzHOKEquEZ8S5AfYU5nudEQ8yZAxqbIQl
	RcRJKAOCaz0XbXR+YjO6vfCV2+EA==
X-Received: by 2002:a17:903:186:b0:2c0:a746:7b16 with SMTP id d9443c01a7336-2ca2d8a616amr19688075ad.22.1782805741701;
        Tue, 30 Jun 2026 00:49:01 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:49:01 -0700 (PDT)
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
Subject: [PATCH v4 09/10] riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Tue, 30 Jun 2026 15:47:13 +0800
Message-ID: <20260630074715.4126796-10-chenwandun1@gmail.com>
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

Apply the same non-dumpable reserved memory filtering to RISC-V kdump
as was done for arm64. Use of_reserved_mem_kdump_exclude() to drop
flagged regions from the elfcorehdr PT_LOAD segments, and
of_reserved_mem_kdump_nr_ranges() to pre-size the crash_mem array.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 arch/riscv/kernel/machine_kexec_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 59d4bbc848a8..25359d583bc3 100644
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
@@ -64,6 +65,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	nr_ranges = 1; /* For exclusion of crashkernel region */
 	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+	nr_ranges += of_reserved_mem_kdump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -77,6 +79,8 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (!ret)
+		ret = of_reserved_mem_kdump_exclude(cmem);
 	if (!ret)
 		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
-- 
2.43.0

