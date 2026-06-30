Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7F3E8C74
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805753; cv=none; b=VnzkUeNKUWjzW50etvjB7efZT081yU7JT6zMhBf3RQuJoYq/AMAYf7Yxr8LffO0JELsYFx+xXuebk+m2yLhgh1ekofnFjIif3LBoI60xfwmRlR3leo7npJThdDn7YYdOY56cX4+PjW1oRGZsy60kXH7lxlbZ468kxkzVm4fM3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805753; c=relaxed/simple;
	bh=uLOeasSEYWAvpT8ERSE9h3DlJwiheu4obyaLXpGYn9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lbws3qUKCycqvldvIP2pI6OG1AV87lQctv7Xdm4FFyoQ+IOVSFg+9gVBjPSuDij3pcRSNQJimXQdvjZ59UzpZrWllCEoXMLfuybl2KOkaKJFEaIp/o1cfXGMNWXtqUYmXYujyAHbmZohGACfZNYiBsSDBZgg7OhSwxEQ+9x5zf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1yPDjPN; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1yPDjPN"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2c82538b6c0so24615085ad.2
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805751; x=1783410551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcszoUDc7316A03Dx3QXGOd8FcU7DWvjuNUEWPnVcI4=;
        b=T1yPDjPNcWOvZS0erpveW510X4++HFrycaDTJnLpRd5O4ANGqhqfau3TJaKMT+Uh9c
         gnKfb8wMtlOWJDH6u5ia1q16kdJ1T2r8k7zl7XfRr5wOF8uDnfmGb4VXvKCRsCjFhLWe
         YOIP+in+s5gM5mDpKVkhqtKCK8YY8C3q7YUo1vLo1DX275AFCfoq+gmlDvM0DS6GG69G
         w0VI+Uzk5NlB1aseRNzVLaFt1JXkxdsEvFQvglSflW5XaHXCxYcTcueoagDzHbRD43bn
         MV/+l3vv4DOwOD2L/1hyQDxRBYCzNd0MPMuI0Z6A/NSAOiuqaNrt6jWoxYOL2C+BEwOM
         qKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805751; x=1783410551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcszoUDc7316A03Dx3QXGOd8FcU7DWvjuNUEWPnVcI4=;
        b=J11ONp83lygAGrTwNHwEB0DuidpaJzOXRLngxWNNJM0SHOdbKCTy5Nxe7uTbO7PA7T
         ipUCkbDF6Ks6qnekGk7a4XeZZ6y4oNpyx77CtCRVQ9YBRnsylGh78PMFakzIpbt2vSIr
         jx22V8cwi8lrFUAFtJjLLCIXcG0c8py78vhLYFPWDRVvtaFNDuZbgnq9jqBed5b9hCOP
         4ofIV3S5pxIr4OKpxohMbPaVIfeTKNZFWy4uHFImjEBAhjh67qHpXdyFBDcSkwHNzTQ8
         OlrdOTETb/gSupeU88/H25lHo6HB1hp8zVpU5sKJJeEkYOYRxrzxjPLA+QbA7eYTY5Eo
         chLg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2iVD6ULbyR5lbM4HnKcEKLWw9KiNMkTxD4t9vuqGXamlvyiehaOfzPTESwP4bmWi+bJUHrw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1hRaI/gz/DWLB9r4Bx60Ejr4rw6M1wG4D3hx+V0LdQPD7IX/m
	q5mLsVHACEHxl4EOL58p450VTwck8WItPtARLY5Z43KEWW4Dc2P14jE3
X-Gm-Gg: AfdE7cnd0RSIooj583SqnLv5TqRz6P1lgO+LYtPyeBlxmNl+bhWM4gihsrql1WSdM/1
	/Be68vnfLhOpqEfbajoVKxYF09ddh561DhcONSMS6XzeflF0xXH0c2CBTd5Z4FTXKFhhauXR3iU
	8/fpBJOuvbH9xJJ3FgfG3+oJnTYYcUCXL+N+2NvlnX98jZhJHnjJqaM8Rnc5NEnbqx/YXgjXyix
	KwWNsbXb7pYjmS9jAdPw0thDI48jVd+Q+BGJ9KNLVcEey2vyKVI8LuDOYrCI04l18i69uCLBmwC
	XVxhMNttZ4tf6MmD5I5OEGKga7Kx4djdMssIkRWc1/BxPeHEMwKGNCmm2KzF4U1tQ8E19yrZ6I4
	cgy81gKq/mZOXue8y0iJP1Vt5d52kYMmCrHBdqwj6X1sQPSsPmCk7ZjZ+bStYXDjQF/+DpvyEC2
	/sq9m7i+sAWxhkcskvtQxnPQ3pZw==
X-Received: by 2002:a17:902:c94c:b0:2c0:cb0e:ac3a with SMTP id d9443c01a7336-2ca2e71832cmr21250665ad.23.1782805751208;
        Tue, 30 Jun 2026 00:49:11 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:49:10 -0700 (PDT)
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
Subject: [PATCH v4 10/10] loongarch: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Tue, 30 Jun 2026 15:47:14 +0800
Message-ID: <20260630074715.4126796-11-chenwandun1@gmail.com>
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

Apply the same non-dumpable reserved memory filtering to LoongArch
kdump as was done for arm64. Use of_reserved_mem_kdump_exclude() to
drop flagged regions from the elfcorehdr PT_LOAD segments, and
of_reserved_mem_kdump_nr_ranges() to pre-size the crash_mem array.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 arch/loongarch/kernel/machine_kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 5584b798ba46..4b918c3d4a28 100644
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
+	if (ret)
+		goto out;
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
-- 
2.43.0

