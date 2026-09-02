Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE51191F91
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334425; cv=none; b=c/43aHV9pDdiCpxIG5xi2ek95grAy3srGK04iglkNtojFen7ByQt/heF6vMblyfyclinhvhpXIpgenKbV3s+E/AYQV2hWJvwhdkyKqBL0fW8bLSOHz0q2FGs3cbmKOxfYMtvA+xbXQFqwyv2/UqF6utGCR1w0yN0yHGgyPbf97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334425; c=relaxed/simple;
	bh=6GXqlO1brxizpptoYGP5WQbPTfAaEuWm5XYjrZWlTlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RB6NQQ8qYTkvs3QAB+gMxmZzw3/X/DyVCnxJ6bV54S/ixsyUFwJmzlY8MbQXcXV2Bf1aTKWwtZIctfrB2PLGo9Fbnop3N+p56NQNxAKKY6XO8adUk08P0JZdh8/bNnUqKfOOC9WFi8Rk/zzSuboksd+n31nbP5Z3+Z7O0EguFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw4Z33TQ; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw4Z33TQ"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cc1cb94b583so255265a12.0
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334423; x=1788939223; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nb5Q2Se78rLq0fXFEmBN2MgTVK3UgvxyIXmhlVfKh+w=;
        b=cw4Z33TQffAYqpVVmyN5CpI4i/XFBDBmvRD/nxDa80qPMIMrVmQv+X4fIlAw4ywtms
         CRjD3kcqdopqGCIpHjGO74o4QnQzfq0UHuYzr7CvuEwPAQqSVDcOSaFX5zZ4NKnxdLC8
         Yt2XC+8zrjh+YNKPkd1doY92teC1dpdEg4MGqCDFz98poYiOZU1fNeX0xYRm1ih2DOro
         eB91aYsigwgw5sWAF7i1MIhLBz9yGjSrwZ4qeT8d4wI+aYBj4QrCTIGuRXXYs4A6vVkJ
         gPJS3fputEbih5vkvRVZCvEZXHVPvCAATDX4k9U3hcy/iVoR8nePc//36s25y0j60574
         DOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334423; x=1788939223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nb5Q2Se78rLq0fXFEmBN2MgTVK3UgvxyIXmhlVfKh+w=;
        b=WKOE0rsMq5cXC4t4ixNYCksFeOkXuK89wkDG0TmxLLo1kAeo4vxMc9Sx9O5dSzoQlT
         6txQEngjyirZeoMM27HMtBlu3zoXk8kfzZ2Vx5P34ZhWynCEGBuD7LzlrRnjw3eG0tCz
         PMq47dlYwuLY0EwebRNEA40qRWoJHOjoQ6OrJ4ykCrnEKeSMHWhQ/dzyneg0ewUqy/r2
         8i/dYtocjZggghKBNrVh1bTX3OSJKXu1GdLHAdbchXAoihuwXpKubnJ8QSzTNgRa4L3k
         cNjK186M1ZpAICRsI8NVn/bv8DqQUfJSwU3SeKQJfSyMzMZmwJi/HBFnfc19gvdhf6pM
         Nl4g==
X-Forwarded-Encrypted: i=1; AKwUvBwEeTKuuC7zn7tN1xCFKqyvW5lsQwT5v7dF0AdGHFc6JD4bdZlSaRzOJrEyaXixPRFE85l0ew==@lists.linux.dev
X-Gm-Message-State: AFuF++mATSJUvoYhbiiPOPyF4efhuuR+twy+Eks2GTGylpuv2e4PUaa+
	4NHVLWajOsuk+jB/nJCPMCf7eTY0AkXo2GGciAc7FNalDb92G5c/A5LUDVDfryV5
X-Gm-Gg: AYBFou2DH1sICRMKTAGusncJhBKg5n9UZEY6Mbof8HPXs06fYKPFfGmCMVlfPqQeYx7
	tnv14EsDd27pXtgR9puezSdpXPsEViJcA5kvcTF/ncJpnBnKY6LuBscpIYfdbs1IBJBbHwpTeuA
	VRWDww8olkIBAV1K8E3oB5k84eemoYXrCFgNbcuJjeLqAZKQOXXslRaCodexp5Usii+HZjeLDyd
	U3vPp6R61XpuDs8IS8CXiaHHsuk7A3qYQxk8KwHIP3yCbAbzsiCeTTPaRAyiDU171ZxdFHq5gfD
	qga7r4YNRCrIC7/3Me/l1/PRKaPE26IsmWORC8ow5T8UfKPXt0S6ETCZIbu37SdpFD2fsztJzbx
	EBEnwBtOOsZVMoJ1CsicyNf4OjqE1wiZq0poYIODXxvnzEdPJp/2QAuhPD/kpKmCJkDLgvYKeOl
	1gGhz355PFfv4l7e3wGDwNh0A3MvCZgyj1IPRwrUZ2pdcsWNsnBklpBmn4wbQYlA2cJGakGU10
X-Received: by 2002:a05:6a00:6ca9:b0:84f:77cc:63cd with SMTP id d2e1a72fcca58-85ed4449927mr5116039b3a.17.1788334423379;
        Wed, 02 Sep 2026 00:33:43 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:33:41 -0700 (PDT)
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
Subject: [PATCH v6 10/10] crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF header
Date: Wed,  2 Sep 2026 15:31:16 +0800
Message-ID: <20260902073116.802752-11-chenwandun1@gmail.com>
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

Reserve regions (for GPU, DSP, ...) carry no data useful for crash
analysis. Exclude MEMBLOCK_NODUMP regions from the vmcore ELF header to
reduce vmcore size and capture time. crash_should_skip_region() now also
returns true for MEMBLOCK_NODUMP.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index bd64cf585795..b0e618e13588 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -270,10 +270,10 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	return 0;
 }
 
-/* Exclude NOMAP regions from the vmcore. */
+/* Exclude NOMAP and NODUMP regions from the vmcore. */
 static bool crash_should_skip_region(struct memblock_region *reg)
 {
-	return memblock_is_nomap(reg);
+	return memblock_is_nomap(reg) || memblock_is_nodump(reg);
 }
 
 static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
-- 
2.43.0

