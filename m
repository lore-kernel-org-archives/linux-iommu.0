Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998CC3D331E
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334359; cv=none; b=Ij1Z+76qhSJ8kqZR1siI3CPNsF3nAzn6PC4zktBrCuHCzRXuDJghBkeohzq2hfI328W/MQrUzb/fs+A7V3RyPhnrBEf1niAXsoJsUDCuj2ie+OC9PDnh1d56x8R3kG7mOMTtc+ggIxxr2RO/Vi1gRoHwyVEm6wgFktBCZQa6Y2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334359; c=relaxed/simple;
	bh=M8mUvhcvfnEDBFtUc0VuhdtpXKf34yjgQcgAYje1vMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9q51FdCe6NvHAflcVSDX0bY8OJiUi2pCwcueuDBM5MLCSVpzxTbmiOjuK3sXVN9sANURr633IeSNbXDFW7PRpF2wvVy3MLwsw279Lfxbb4H+mQxUhnGZ1bL6NjEN1aesNWuuYKBKiq0lOwmPMuD7BBE815FNNOeTsjxpbtY83M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISNuChhN; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISNuChhN"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so237483a12.1
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334358; x=1788939158; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QDn9kL+O/DcgCowWQhzjL1E+vRjYGvPyhLWTC672vfE=;
        b=ISNuChhNFhF0mb/ERhhvHdjkmX0FBAPZBxB7MirGoiMLVThapPJenOKmxeZplO0g1N
         ToKtkU/ESnaRxYKCwmIh170S4zSaHdzla8VVncRDxlwImDQZ4+haRcaITQ+lIn8PMcFT
         RSlj5Nt1xw+5Ufktn8Gjn7VcGSpPFL5dehsPCQH5CTc+FlPH/zzCD4amv8KYIYn5di59
         d/Cl8DwY2nNntahXmcHHjUPseWWxtIJdbCg8aOdsdocVa1GeM1PGkI+xqr8X/EwOGxkz
         Ya3oXwIMkDqO0f9NiOBuHDqqufT2Q2r33Vn6m2XlyRplgKPuX5nqAGwrd+MaLhIi9HOI
         zRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334358; x=1788939158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QDn9kL+O/DcgCowWQhzjL1E+vRjYGvPyhLWTC672vfE=;
        b=Tcwc2eCMjHkGbJHL2m8KzWV/x5HhhaK5v7xftRKbQYlqq8Jb/y0GQhB7crdD9w8/MN
         ngUAkC5s9SzNoIXR02wBg9RMqqL/BPpEiPVM5YpmhHPEc9i1aETpJ0hW5X/mmWJj26rG
         V70p2IOWOXR/CvJOu80h9ezcBJyMSFEW53L/QcYLEC4dzaGdSdFGz5j/KnhY7Y60RbuV
         nscDxni7XnYXyTh+21PRftIleDrvqxccUE+53HeDzrYO1XRr5eU7TUUZxefRADTQixto
         oEWp7kZYFJCIibK78su0A875sfxcfE/dpBDlISI5TPx9uqPelhPQTJDSBb5ErIpSf9mC
         OSjw==
X-Forwarded-Encrypted: i=1; AKwUvBzmwIs7WHkCVMcn5bXOmHh7zqAS3dwPMtm1Mns88TF+/AWbqf5jJqrL5e+dxF+NCBwGTCA5ZA==@lists.linux.dev
X-Gm-Message-State: AFuF++njJPELYIYL9Po0pgxsDGrCVl35HhIfJHc8z3EtOsdy2PptDkcz
	AR6VYZiUD3VwR7GHzP0aDNLqlbdRl1cUN8nKhpWGk6FRKxUP3Ys3Ixbs
X-Gm-Gg: AYBFou2YmQ2Ja+P5V2Ya28TMrYBS31t87BE9hkQ81a22I5qxh0T2z2w+dvBpHvV0pce
	NuuZIeZadZXAbuAcZS9pejnaesXr+wOwMrS9w9H0ri+nKCm9dxGXHTiCe1vYpcJ4HOrSjcR89F+
	GHNIWftwffrCvDy6zZSw+dU80fA/Yc/wQum/jzU50d8vvea7e23KBQEiNK7xjS0TR48P0kXLxex
	bmIp7lM7gS0xDxKx1jGUxtCoZTxIdFUoGp//2/5jcig0ynD8auT40EmseNVQ40RfthA6XK9CgHH
	zbiYny7KHuE4sJfv0glBRi1ltFP0oArsXI8ERJXotC9jydxZuGxlwZ22loHKr17pLwmzsIVNQqx
	99Tyx5UrcnQrKOTFlDHwro35uC5uCsInwVyCrxA+Wvp4u6RNmsIbzWox5uP24fQ9q/h1+lHLW9v
	Sz/L9Ej3SoqBmtF39D3BhZgiOAT7WKmN2jzwKR60p2sAPyirJvfYXBuRgn8Wh2GfYchgGLZP2k
X-Received: by 2002:a05:6a00:391c:b0:842:5b66:3c7f with SMTP id d2e1a72fcca58-85ed444854fmr4147616b3a.0.1788334358011;
        Wed, 02 Sep 2026 00:32:38 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:32:36 -0700 (PDT)
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
Subject: [PATCH v6 05/10] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Wed,  2 Sep 2026 15:31:11 +0800
Message-ID: <20260902073116.802752-6-chenwandun1@gmail.com>
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
index 3adee1ae120c..bd64cf585795 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -270,6 +270,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
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
@@ -285,22 +291,25 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
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

