Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26DB3B0AC4
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131467; cv=none; b=jPSfXU/tCGHZa9kysCKaoqH5FBFquRmfZnXmi7h2lNSUIai1nLgScF1AgVzCwcY/rs4iaJjCpwFONEhYQFcbp9Zyk2ILNzZrvs/f0QrLWTuxfkCEsUu74yCiwDJDfKd6NdyFfhmulCTlYaMtm4YcZUQfc0vBcerqm1JGAPqOcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131467; c=relaxed/simple;
	bh=euWXYByltiCr6eLT3Uvt/s/e9D4RAaciKKJ13Szz3HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruCQUp4R35qKFRfJxr38l7iu8vwDFDTWBhICYzM5bsGZmEF/oEE/LN8t4rtJejse+A1hxnpnkf9zaS8mRUAkZrxT2Nr1+3dY0Fuia1o1LM7bA08Ir4XToYrTpaD8O3/mwQdNuGw9zJnGCFcsd65NhOzMoywLZ4CPfjrj3Kr93uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hH9f2jlE; arc=none smtp.client-ip=74.125.228.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH9f2jlE"
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-ccb794ce92fso507629a12.1
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 23:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131465; x=1792736265; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
        b=hH9f2jlEmItTJ5UYV95QhfiBVXolewt/F4yrIieb2GltSUInNfXooKxVFEDCJ3t8L0
         fjXW6lIiof6ezS6rK9dxv+J5wsPQvq3vHi3JpxKqmAS+o8of1jzaC87xEmMdIJMQG/v5
         8JbQHd9MdAqm5Z9yjUzRiX6q+xB+wpESsnWdc/R0WdURgARy8GGUD+rtou5VSiIEGlUR
         zGV99l6zzJ8sPF+4u2SO6xZgaUpZCjnY/z80y7S2xLI0a5v94PGTBNbmJH/dCes5nNME
         dvu6azxsdDWmQzjFGOmR8MtRsO+n4OX37Rut+UxnbKq7ucsniLWYt0qtLEufNK4DkUT1
         nVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131465; x=1792736265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
        b=cj11nG2oa2wt5hyJgw3iZgBhEm6tLI4LXs/TuI3BV35QlqoB3Ijns9yQPiIdE3Z+Y9
         CiAJDp1k7DhqMhIrkVcYZ82huR4W1ReLH9VbM4C0NsVWgRbkEI5gvoamaZBtV2+YAbNM
         t6Oxaj+lySS0k0RWuCP3zIzi71UphB3fQYova1D7lrMF0UcX9ICSAydAx6LgI2nhdRIC
         wjpMkDSdaQtAfZdTjbdwRtH+eMvNbKQsdPg56915b0+6Sr9YRJEEzEmA+4qR8HniJkeo
         doPW5hNaVvjRBU3xkktPMoNsnB+B2Fy8XVPWa6iwvFHlzv8WVM/qNDX8sVmJTbzi8Bee
         NdIQ==
X-Forwarded-Encrypted: i=1; AKwUvByEm9Wt0iEFEsBw45w+CHXZ+VBaMj3Eivo7uP086/UBLgV/CV4hTR4bMsz085szdi7K9vL8DQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKAKARh6kyk1IfrvGKIVvtohjAXsEY2hdDuOBkhQKZZUgk69AmI
	22lU2Kj3Uxl3PqFKStz3vF17cGOtN9WaRhwlqtXeFwz4WMAbl+c/mE1E
X-Gm-Gg: AYBFou05HXl9a55GVH5Oa5eNWM256MOHDlDSSiylm30TDcVuf1IfKzanFVRTu7yaJrl
	3H49uD2XD8z1fEDxDH2abYocJg+Assx5yZC2xzLXIhhjoo7nVe59+wQ3aNe4Zz6ByPlDv4ejgZs
	YF4d10blYqq2pCQA7tHP9OOYHqXI75avG49eg69YRGbjP/naMY6IIXpg4rr1DT5tNSI7mN+s50w
	pjdnGghSsqMb2y3xOKl8Yp8jg9l1gPUutIo7Z8uJMmcVRDPqdCUuICrsBxGfAQqFAO8IOJFvs9j
	GvEiFpvN776a9sQsPr1vlm9nDmncH47HeWSgLh6NlauHpNCx60Q8POa+Qudk6BDFFWN2/kbUNDA
	2mRFGvbdYzc0atDchUzT2TDP9GyA5Ekam4vNBAkPPhMVmlcbLq8CHTz1W9iuNEKqnzdFXve+TjH
	PAQTZT4pWOu9VhzK53ebWxrHql/V+F1anGHyOgxeB8Sa/ajAL/uho0g1FbMQOUOf+R/dyWb0bUN
	WGLO1kaC9bWXCsBW+PdVA==
X-Received: by 2002:aa7:88c2:0:b0:886:cae0:fb64 with SMTP id d2e1a72fcca58-897c700e74emr16786375b3a.31.1792131465299;
        Thu, 15 Oct 2026 23:17:45 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm586375b3a.42.2026.10.15.23.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:17:44 -0700 (PDT)
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
Subject: [RESEND PATCH v8 8/8] crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF header
Date: Fri, 16 Oct 2026 14:15:49 +0800
Message-ID: <20261016061549.4181390-9-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016061549.4181390-1-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
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
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index e161c8b65e00..0e2ddc933b22 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -283,10 +283,10 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 }
 
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
-/* Exclude NOMAP regions from the vmcore. */
+/* Exclude NOMAP and NODUMP regions from the vmcore. */
 static bool crash_should_skip_region(struct memblock_region *reg)
 {
-	return memblock_is_nomap(reg);
+	return memblock_is_nomap(reg) || memblock_is_nodump(reg);
 }
 
 unsigned int __weak arch_get_system_nr_ranges(void)
-- 
2.43.0

