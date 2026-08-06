Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11F442109
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009021; cv=none; b=k7HFpJ0VEMFkqGIDLHNnjeKGfJ4sNcgyh5SwFWaVF/bEjcPI0bBdWr2spLSUSinT/SE0R/dYb6owDa6/STT4r7Y5aRBVIVkkl5ax4xqdkeOKHz+Wy1VBfTxamoY3nDTkpi2f5smJ7bLp1mANFsYX0YKVpKAnvnL3DcSLYDaZUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009021; c=relaxed/simple;
	bh=asV5+uk1HNpC2yg4Ca+u8e82+cUPHo9klzhytwWRRZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClCV0ldI/LtJjUTIW+7XyVdVRm1DbGqZm80Xs1JG/lriPDJX6lrTbK6ThqPgJxiDhksc++Ypx0XtUxnXC0kc8iYVVMZytM+y07YN2ds29ycmP40so5DSzMh4+9n8KR6ZESe836xtJl4ILZKgl4cIdbBPR3t8XwuoExjsEkvHAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfSHkBFy; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfSHkBFy"
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2cf02ecb572so21543065ad.1
        for <iommu@lists.linux.dev>; Thu, 06 Aug 2026 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786009018; x=1786613818; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qD4VW4BZeNXzCi3gbNaQKdLxxRurNtLyN+adWk+/0t8=;
        b=nfSHkBFy4C+aTTnFN7OzPWaKJ2uPBfWo4E0nqw/hIYr3Lc/+eidiqMlCL3WWAvRe4K
         u8YEDuTJHFN6TALWW+JUIjN8xHL/xQSqbRtOW27e7p2aaeRx5xkHjCzJiEAhkWGttF67
         ud+PyRtskQOZVx5v43Tt5dlMwgKcGj3LvskO1USlZIsMgSP/bR6cuDphYtg7HESPsgdq
         MbQXUEF7nfv58lyVRPYYmIjk6cAZmYhtHq8WVcKuS8p5IdxkM1SPKd9AhZDmKITOsL37
         vXA2YaJ9XR4Nk1nTYjpZYH9sN0SFpcxpVJ1/Mh5pYAE95qUVZvNQKrV/d5wylw+Ite6n
         HkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009018; x=1786613818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qD4VW4BZeNXzCi3gbNaQKdLxxRurNtLyN+adWk+/0t8=;
        b=HZHnQdR4d8bAG8DExBJCChx6v63ySNYr+9uazBcqyW5hSUZZiRkDIayrcpHYcIri43
         WjhvDbdy8xjqKeQorAolKUl3yImv3Nmzwp/Gi2K4dfpri1zt83KGmx6E+Y6LJTbo9Doz
         RaEWKUAE+fS8BDfOWVi6i99iNhr4xBWXHMoYHnHMlus/CXdRd9Ldsm4LqblvjlgAHACx
         A6Qqp85DK2SdZ5SHvy5Md6SGsCcf0onj+ZSyepAC/yPWubNqA2BQNPIYnHC8fVmbC+ZD
         v+cOUKFH6oeBNJ4g9Ywul7N7j6z3+U2RHcUkx0sixC2bY1bABk5v6HTwravsJ3Ndw/5H
         ecgg==
X-Forwarded-Encrypted: i=1; AHgh+RpwB9GAr3bwRfJqQHDRkESpwo80f2D3ssiKGNPfrLCZpxH1ShM61xU5o47peI9jYRUrwHgj5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzoo6e4gTThJDXDTjTVXHwHJwbko4eeq/sdzAXK727CtG7NobwS
	h5JEAWqzycHhxNYdRvQnc3dM3bWGBds4uNUqnybVJ8elRoPCYtB5B/HR
X-Gm-Gg: AR+sD136zi8orDQsyL9HoPP4tvCGCTcME15xhDTSrOA/NA2falfXFSb5bco2+PNGZW5
	i0yAWGIw3Pq4z4TJy5VvABZys9lo3r/Om3IV/x59qXu9sn2pnerA8qjC5VfQ5vVRFPZPhN4Xs0d
	Pm4wJIlU6/aEIsoaGrMjQlsWZgbkVPVgKo7CGfqLyYu+pf61A4ZzpF4BSbqR0mL765NpqZLfDzf
	tj8AIWx+zVhi3YCXvXoJhLp5l/jtffP3/Tb5J0FesHy4vYBsTrcSH9QtCIM1hcrSxIEUkpt16zO
	CKwrGd0MdNnPlbchgGPQK2F+y0/+uGUakqaafASeBVnKnpCQl5tM5b9s5ejr5rQYWZueyeLvNZW
	knAQMll4aqyHl1lpXiF/UXzmlnCDivV6Wh+C5retw4JzW4C+p87brjIPp8d7loN3ku6GSZ+mj3v
	YuAdPM3t5Ycpgad8IyLy2/jsyeYzxLWp3v3eG/L+HGSWT0DiWsgoVrKz8fadc48KEVo3p78QBZm
	A==
X-Received: by 2002:a05:6a00:2d81:b0:848:6c9c:4074 with SMTP id d2e1a72fcca58-84f2dff6cd5mr14050456b3a.1.1786009018224;
        Thu, 06 Aug 2026 02:36:58 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:36:57 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	rppt@kernel.org,
	baoquan.he@linux.dev,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev
Cc: kernel@xen0n.name,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com
Subject: [PATCH v5 7/8] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Thu,  6 Aug 2026 17:35:18 +0800
Message-ID: <20260806093519.2907771-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806093519.2907771-1-chenwandun1@gmail.com>
References: <20260806093519.2907771-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
weak defaults to for_each_mem_region(), which exposes struct
memblock_region and per-region flags, and filter NOMAP regions explicitly
via the new crash_should_skip_region() helper. This prepares for a
subsequent patch to extend the skip filter.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 kernel/crash_core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 77285ae3ce60..fb78b7814f18 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -269,6 +269,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	return 0;
 }
 
+/* Exclude NOMAP regions from the vmcore. */
+static bool crash_should_skip_region(struct memblock_region *reg)
+{
+	return memblock_is_nomap(reg);
+}
+
 static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 {
 	struct crash_mem *cmem;
@@ -284,22 +290,25 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 unsigned int __weak arch_get_system_nr_ranges(void)
 {
 	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
-	phys_addr_t start, end;
-	u64 i;
+	struct memblock_region *reg;
 
-	for_each_mem_range(i, &start, &end)
+	for_each_mem_region(reg) {
+		if (crash_should_skip_region(reg))
+			continue;
 		nr_ranges++;
+	}
 	return nr_ranges;
 }
 
 int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	phys_addr_t start, end;
-	u64 i;
+	struct memblock_region *reg;
 
-	for_each_mem_range(i, &start, &end) {
-		cmem->ranges[cmem->nr_ranges].start = start;
-		cmem->ranges[cmem->nr_ranges].end = end - 1;
+	for_each_mem_region(reg) {
+		if (crash_should_skip_region(reg))
+			continue;
+		cmem->ranges[cmem->nr_ranges].start = reg->base;
+		cmem->ranges[cmem->nr_ranges].end = reg->base + reg->size - 1;
 		cmem->nr_ranges++;
 	}
 	return 0;
-- 
2.43.0

