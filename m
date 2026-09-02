Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77A3E49E8
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334385; cv=none; b=XxvVHVwYH08zTNKJWFkS9m57OkjvuOiUGr1sbWnFIr1L/bWGJB493y7uX/jaZCBKAWgw6y3+wBJT+fS0qKINXVsFhdKPB2KhNdJPz2B4jFzHgdhnC4n9iHY4pQ244/b5KCUwuanyFrBFw3AOzbUU/Lkpoz1i8i4RbeHAz7gEaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334385; c=relaxed/simple;
	bh=MwmyZtqdZD7M055LKAyuxJR4s3W7xYxs2ORY+R5rg40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCv9mpe0ND4rFhA4sF+MweFFGEznxBP1jr23wiseEm3563fI5XbGg3j1nWK1g4SfxN8oB1XeS7QBCrR9fmvL0VR56SUh4zYICbd5PrNGjssRomdaPPlOFWoVEWGLglt83g6gbNg+r9rOz+VaZnWrZ+0EPMuYvpPZRj9ygK9g8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoAMjfG0; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoAMjfG0"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cc1cb94b583so255024a12.0
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334382; x=1788939182; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+6c1mxNeRcK5OGJwTOV8Umz+CvUvEErlItanMxKc4I=;
        b=XoAMjfG03izLgUyJo7arAqAkNwXD04wQhVFv3xA7W09CzXvacV2krvKw6AvNjH4Zc9
         1/+/gkzZVZXnGZrNmrpW+DDXgvC2vupAejDFpEsKFw7iqzFi0Zi98kvJk/GbJSyH+Gpj
         akF88/V/Jvk/+2RzZQ/PpAx0+PckrAbG0ffPTIRKVBplCzCJa9dPbcycyaaEKOhGba2Y
         hM1nu5hldF02rh4CgHV/zb6/foEsmZanCZNrYwfi5QT/Zj7AjrfLKDdmTO48qk1bCkcT
         LNRAAsFB/sioaVagkFI+orLWzFCrHKrD05R4ib8BfhGvJwMfNFeS6XBkiUWuQNPGC+P8
         /Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334382; x=1788939182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c+6c1mxNeRcK5OGJwTOV8Umz+CvUvEErlItanMxKc4I=;
        b=QRvnwVDPMDiqqkcCiuxJnna6763H2DvlnfqParTKw2peYQ63PIZpOyx/C5B6e+uWhm
         o4CCSCfEnjl5ysKwbRB3AMMIJ+6f11KhaVvffyXKNSu80h3LqltmLyClZHJGXRt/ChDM
         WZbTZSAs40QGfSC3XWCMkc0yKdna9lZneEwFVU+Nih8mK03casFHImwlmVVn5ILqhqUH
         Zj1gQiS5QFFmSdHJhyy3W9jMYWQCvDps+lIR4YZDtnUiCnavwXQ4bb1f81gXzwaPDPCe
         g7lxUxuQssUQU9qvIYCFx2ar/+PMAwxKeJcZv3G61kD/Idzz31yL3m/BdhsWezjiq0O6
         wc+Q==
X-Forwarded-Encrypted: i=1; AKwUvByT7kqEk2wBLvmydXV7nTWoOPGBUFRy8q0s9kfKZiIR9hs0TIxAnrE72S1dmyAHmHBYGrz9ng==@lists.linux.dev
X-Gm-Message-State: AFuF++mt8ezIkUSzynC8Ghv64Qsnbe0UKk1uUZGQjdH+liYtXl71QISN
	dtM2jxHjtZHlND+R8dFmE6fgVAqQAIO+d/vNdWqbpOdTsaMuZM5+LJK5
X-Gm-Gg: AYBFou22TeKvEHbE0E5IeNFc3Ry04JuiqYm69TZxAAln05usx9gjo4fRtliDSkA7YoS
	J/+QX2/NAolsANWkwgNsbz8NKZ3yQOME+gIz05UhdtZUzv06jxpuXrnacz7h51PDy23YbNw9msZ
	WJtQ9B6aggDf3up7+TNmQng62g6FZniSzUn8vWR6wHafNhOnbMoOag12AGD+OXWLk+vbanJGIwN
	zDO3JrQVJjXDWjN2tssF6xurQj1A955kFI93DjU0iLxhBSk8tX+BUmMMCiQ925xhyPwKwlizqsS
	38RrRzQdfIXW3rr/1uHcJGfUFhjE273dYYvffhIjt4AAVNbgMdE7Dfdwnfv2Hc6GdAK5XqJQ7Cs
	DvLgOObf1sZGgo98lJMHta6vXrcHRPitaB9C45+/r0l8seqsL3szqrEG+68evkNgYmOdMYH4Dmv
	DNid23pg8j7pxfaHhXi7vUtTvDJZpFJlDz55ySFs09hlpiY/e3TTORI4i8N8Bppwo35LfOBUOq
X-Received: by 2002:a05:6a00:330a:b0:857:74ae:ad76 with SMTP id d2e1a72fcca58-85ed4e09b6fmr5077449b3a.26.1788334382541;
        Wed, 02 Sep 2026 00:33:02 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:33:02 -0700 (PDT)
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
Subject: [PATCH v6 07/10] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Wed,  2 Sep 2026 15:31:13 +0800
Message-ID: <20260902073116.802752-8-chenwandun1@gmail.com>
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

Add a 'dumpable' flag to struct reserved_mem to decide whether a
reserved area should be included in the kdump vmcore. Non-dumpable
regions are later marked MEMBLOCK_NODUMP;the filtering itself happens
in memblock, keeping the arch kdump code independent of the DT API.

Most reserved regions are owned by devices and do not contain data
useful for kernel crash analysis, so dumpable default to false.
Reusable CMA regions are different: their pages are handed back to the
buddy allocator and may contain key data for crash analysis, so set
dumpable to true in rmem_cma_setup().

The dumpable flag is also used to check /memreserve/ entries for overlap
with other dumpable regions.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/of_reserved_mem.h | 1 +
 kernel/dma/contiguous.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 49da515859f2..99c0f3ccc297 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -15,6 +15,7 @@ struct reserved_mem {
 	phys_addr_t			base;
 	phys_addr_t			size;
 	void				*priv;
+	bool				dumpable;
 };
 
 struct reserved_mem_ops {
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 66093460584e..caa6a5c66bd0 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -567,6 +567,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0

