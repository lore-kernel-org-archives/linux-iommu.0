Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE02442FA4
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009033; cv=none; b=Qamgz05IFbG/xTPZmz3TaJlxxnuMC79WRQT6V82UQpwnH65dCNeckz+IErxxCdZLo5AO0u/N88KLo8PcOm0cS2sQtDWiWbpGaBmi2/WmcaIyrOPzBlio1vreo5GPOc0KkOAZaVOH7bSZWr/oMvbug1wy/IOUTwyDauoGgalyK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009033; c=relaxed/simple;
	bh=reK7rFNBw0BdYQ91tXN/M3BLzkC5IvWkzOQ7lbAAVK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIYABphWyFGdZybeNdeb3p01Q0rz8+Sc8ooKOBfJ2dWk2oXaYwt2G/bm1ucQVYhojEzHbVdcq+s6/PHnL0iHC6UTArGGARphq9bWVTAkHaiNT4qnJIiyePWbj/drHCRdeCJGmkbCzcsuAP+vQ6lOjAjXu8l6QyZCvMAvSUBkbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHO79RRK; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHO79RRK"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc6bb7476dso2630975ad.0
        for <iommu@lists.linux.dev>; Thu, 06 Aug 2026 02:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786009029; x=1786613829; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6uyTtFjVVo4Ow+xxdf9JzDuHeX18HS+OnizMa+EN8GU=;
        b=pHO79RRKlGxO4g4Dv15MYi/LWtk6Etf6adzk7FweZHA90VaMNkLb1+FvF9cbO/ZQro
         KTBOD9GtpxzdxQt57Yn6rirGvRRK//cjltB5F8YePtwTsG0vkmZ4RBCRMqBlwgOsmiWt
         RaxdVFaeaykuD1MPnyAwiTJ7fczJ2iTED0jtPI0lGftZRKMx2vltIFrHJxGQ5c0hYu7j
         GFFmBV/3oixZzbqzhyPTsthdMpUbd22ifmmhUR3VzHu9vcDlR7A6ujBZ/weJG/DvTMoE
         Bfqob23L5s3hIxdJcnHcn/UK1Tbs4P+bzPQfE9uxBCdpYxkmyaKuBmJa6gTGcaKK6RLo
         YoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009029; x=1786613829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6uyTtFjVVo4Ow+xxdf9JzDuHeX18HS+OnizMa+EN8GU=;
        b=iC0slmsE9VhQUXFEsvGBnvVGMLDdUeRt6u2p+ij3b8pDQFMUUnCenNjAQ7++HoppqX
         vuZquwnSJXuqMuZQcEaYWpDQU3o5FnzoZzu/ac2RitEjYqTN+BxceIfb6mYywIl/F1oY
         1DIcSWgV9y/16k4xq3qNMYHOYZuQpJcpolXOVY6wixrXxfyRsU7eZb2gyQkZQds75D5A
         XQf2lQq0Jvgv3qP80Rle4g1CYGBd2086XkOoPb3GRSf2GAvCy6g6zdZy+4z6THDmtLkE
         d/7BsjJHf//c82fgRvyAyv/VVpdqQvcetPNXN+aKD+6UG/b/FzUKqKroWyF4d+mcdZ6X
         kmtA==
X-Forwarded-Encrypted: i=1; AHgh+RoqWDkfKnj9uLm5B9ZU7MoNA0uufb95W4kqgbqL/HHESp2sY0NZjZAKz598qWlL0+lV50LL2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvQpw1GyiRw+lHEyocLlmjAzirXi9Vd6Ey8uKRtL6vki5Sr3DR
	R07RTr1IJ1yeVmapwrAei5AQLqe1/4VFqdId8EoVZOphIavl9ClvydoE
X-Gm-Gg: AR+sD10VvT3SiDr1YsIu07gsixZpMUFlR4W8otBvM8BJswySLkyigEj9tB/Jsrq8v44
	KtMshZKlLd8HRRiup3j9aFAwKR0aWHrNQFp1IxB3f8gA0l4h9WtFLmsp6tUCat5b8y4PEksYZ61
	2cZ4rpyWoSPA+18rPV1pBQp7Akx849lh/Ekvq5DrUu1kyolnlWeV+Vpyy1AsO1sL+d/8+EVK4kM
	z/UBLma0ItsM46XHUpJ0leyPliSYFIEWshD9wO6Z27dD7NO8BV/kUEiMRNVmXyRp/7yp8sQjgkC
	Y/IvTauPNZGJIoO/QuGEMWT7dllq6C4nQpqo6WAL+09JU24i0t6ig3FfHxUFDySahQ4fmvNGNQU
	eMLoyuR2KcKFJh8VOA1HTCVIIWqKhELwmPS5uesHbDmu8Jig1DvmDEYxBgOXhPZAo4X39EfbV3Y
	cyqnWLCaZdYsXk72n8k1GhxesTUJBX5seQ1H9WrvNI/gP9GvufGrWgPYe4dPdSHablMDm3r4BV3
	Q==
X-Received: by 2002:a05:6a00:464f:b0:846:5d1f:56d4 with SMTP id d2e1a72fcca58-84f47dd0b44mr3119262b3a.14.1786009028817;
        Thu, 06 Aug 2026 02:37:08 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:37:08 -0700 (PDT)
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
Subject: [PATCH v5 8/8] crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF header
Date: Thu,  6 Aug 2026 17:35:19 +0800
Message-ID: <20260806093519.2907771-9-chenwandun1@gmail.com>
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
index fb78b7814f18..8cc9d666bc54 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -269,10 +269,10 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
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

