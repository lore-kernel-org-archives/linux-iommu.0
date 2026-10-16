Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC85322C88
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120206; cv=none; b=R9NI+O1gbzIudvrVpkjDLp1JTyHrZ7pZG2Uf1/fiUgK3ZXW5+AxByPjYKfv4jWlz1/L6CfIOpebzIafwUYnId2VGs594b4eGZILr94Ddte+T7SLoJgQ3MOp17GjPqj/yku6zczFFOkoFjNrm79ekxQ5l8wsSiFI09Kz33fqlTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120206; c=relaxed/simple;
	bh=EtNWhbSSACfAtj7n0OC8kGNnI/X08sTb/SdHGhlyA3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id21aIgvHYuAp+/mfY5i+EtY1DP/sYPQNe7AE1DvuFBbzrml6NOXB9ICJSG8kFEKtBBvs4gXE4b0FwCO5hlpMr1CnHFntAIPPUgEicZnWeGv7U3XVXUsmgmWI5RyBssnF2CccCto6eJftM04y1NfoDLKtfT6kBMFBM0d/4CNRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMVRL/oe; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMVRL/oe"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac6fe4aff0so1533416a91.0
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 20:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792120203; x=1792725003; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=KMVRL/oevTZyBChDVc3sAESt0oto91B+hCmx929UWVGmNVwr1pqm3g49Hsy78hOBbW
         53ZEZ5IMIJuqZBz4vlhOASAqgH0bp08jpvhURbDLMV1xCiuq8bxf2zB80Eml3DpZxdCo
         8uglsjkiTElmcX4kHt9VHRZnl3bGn0F45x66OKobS6VzeQQt0Bn7GXQA+BF3Q0QkpRq/
         87cnuNLOANyfo3LSJo/vATl1HU/7/dFP/BhEbIQOsGbwnPw14LmHr9kHDW6M82QyUdkD
         bpAUUm15oPIo3Q95nt/AqAepdbTdQzItdJP3Bm3JSYts48ebhNphoOVasg4zIz0ragOj
         9ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120203; x=1792725003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=stbvQupPnjXxfJ7fIAtbqJxabfPiBbLc8+rQrcN150hJLqAEwAsUEHRhAGAUZPh8qS
         ZcNvOxLKROm1AvonjYrwu/J4YBjogdNKjYuMNtEx2eHMp2yRMMm67ALjDD+xW0zYbYpm
         S01ATHxLz5lJkimSoxqCgvc23t8JDleaA4WfR7B9zWoXO+zVukEpFhhRj95S5eRGjG+n
         6y/Z+ANt0M0mivkNVcaeIFTTVqs0mDBhIUFNW2VZCle8HESNc+XG1kI9zrPwGMO54NCf
         ffR2Kq2GPAXz7PbyhgOefaFunZP6iY8L1anY9bh8Jbnq0UxO08NAcQmx/oynMVAeqltv
         VLPg==
X-Forwarded-Encrypted: i=1; AKwUvBzzqBVSL03jOuY5vWVYX/7zgizPUe3UdQg43IgqRCF07YUZbZB+9aW6GG2Ab7E7JtTAQbMw8A==@lists.linux.dev
X-Gm-Message-State: AFq9FYLGLUCuQ4JBx43tV2dNGw1aw2vCWf4aQftiZ5YolIv40GBQk1yd
	ZN+yKdb6SU5aloKsD9hK8ICDYH0QV9zrSR4+2P2mNOVgPfGW7STdWa8d
X-Gm-Gg: AYBFou3XrRYupPcz6o+4S1kaO83u8QounQbvUMyvABWVFu+nR6wytva3d4dvXYGf61m
	0LSHHe8Om3guOJ8BDliJ2L9bN9hkd4rzjFA9gL1uQP4SvOvd8g0lymItRmdYVxQw9Pfc/Wp8n8Z
	Q/WlpHb7WTJPMKR3EeFUD0ZQUWqCwd61PAhhWr/Kp65gPu1EMC1IqzeE5s7GT9jDMy1jHcFiGjz
	seA5IvNmlpjzU+5zGsLFVCas83Y7GGmBdf7cxo/+x9GCZHVDQFKGWB2V/u75G1BfzC7ibgXaekr
	jyYNCUIgkiF5ly1uSPboNXYKeQUC5LgEPfZVnY1k4NKlVFXjtfL9pSKXSrhoCUDjh27yfB1x+C9
	pX+F37wl7i/s2nqtF206SUwdo4pweu/8kLluKiMS38D/YL7j7+k/TE94e/QGI4fFIrNtlTJEBs+
	sG6lVC9zZGNYCXLrhbb9m+mhie0BOoc8VlX45DlNSpD1Nj3xTvGPYNBHawPtDuQdhP/U03fzWGA
	hNkh7ML1ko=
X-Received: by 2002:a17:90b:35c2:b0:3ac:7c52:fae5 with SMTP id 98e67ed59e1d1-3ac7c52fe5amr6152592a91.50.1792120203082;
        Thu, 15 Oct 2026 20:10:03 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3cc73c7sm370085a91.4.2026.10.15.20.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:10:02 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
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
Subject: [PATCH v8 4/8] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Fri, 16 Oct 2026 11:08:51 +0800
Message-ID: <20261016030855.4062882-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016030855.4062882-1-chenwandun1@gmail.com>
References: <20261016030855.4062882-1-chenwandun1@gmail.com>
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
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 kernel/crash_core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8a861a946e26..e161c8b65e00 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -283,25 +283,34 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 }
 
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+/* Exclude NOMAP regions from the vmcore. */
+static bool crash_should_skip_region(struct memblock_region *reg)
+{
+	return memblock_is_nomap(reg);
+}
+
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

