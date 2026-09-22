Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0186E5326CC
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066692; cv=none; b=kDJnIw41JUyPZHHYLkSBYyjzr/5doPvNhvVgeP2OI1/OaTyXz1b7wMpJGS2a2LTFNoDHPrIhSGD9EJ8uOvH0V01AdwL1q+YFR1g6unIUnatuvW6BRGQIqCkdOnJv5OhFlqm7/0d7w8Q4WmtidCroU3Qnf8DOhkf2Xh3tcCSXTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066692; c=relaxed/simple;
	bh=vMAX5brBzncYCW3D+6UFt88v8II7ELfiaKipSUvadDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8SKwZ5Hi6kY8QbrCRA9bUGwK+ZKDhQtCLAYLoBFIYoqJdY4fgbKi7C3MI+hj/ezQZybmBX8vHQP/UGslFXnd51p93Oz/+T9zkECQ5DHrhZsvdhBijJbjSJTSKbebZ7eggQITV9RADaPoPGaYkVi7iurNCz9XgohC1ZTHPnNMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps/QmSHi; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps/QmSHi"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2d6fff25530so21343195ad.0
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066690; x=1790671490; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dBMl/FGlqf3qixhPiHBNfiW1ocejNfHGRfKnUu65etA=;
        b=Ps/QmSHilVRqavEzl7831GB9ufLxRY50a0lIej4UM82aUpG32WDn6XWBal2iiHbM3F
         KMhyxuqCPR8dzTTQ1rWe8fNxwZCp4gs+rUVvrr7nPCiONHzrZIbjaD2gETEQ82YTUUmy
         Fqnswfsxk7RVLNJhsBeNmMyjRLeNTW8PfJDgToJqNZGI7v2E1tK907WZ/Tq1vjBejPit
         FxImp6MAZDuX931Sod3SdWKZPs+ftI8dnd1zA11Chb/K6qUVtt5tDH9FJ0FONmRkBIgv
         3Vn/I2+ybytRuaDt2QqE2eNnWEz63lUqIreg+YISv4w5o7ilXEal+28vj6zX73ysGOtc
         h/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066690; x=1790671490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dBMl/FGlqf3qixhPiHBNfiW1ocejNfHGRfKnUu65etA=;
        b=JeEDFpUaeQHwnSNEnZXhsPdrAEDlW6EIocIzcYKtiOKZn9+2/zJrf2qRAziaxVu5Ni
         yH5q9JfLCAWMJpfEFHzksqyf4+QtTBcfs1giyxhVHBu0JgyLJi6cWWqYm+1M8U9KFfE6
         MhmXZ5LTUKn9ChY1ZipW5k+jZW9WphJtRe89upR3f7zVe5+wDfPQLxBVoq2VnAEs69tw
         wCTN40pPKisnCWOpmb6QyhKN0wZv5WCr+DpsuY/xz6OtZ6kYxzjbZOKBL+t00kyaVYe4
         mdEGHVK4DCdYA30Gyx+iU3WJFCo0II7z1AFA0IjCCaMJ2eBqmfxcKMwHx1yNusQcuMUH
         Bm0Q==
X-Forwarded-Encrypted: i=1; AKwUvBy6l726eSkpk6aX9MxFBpt/AKh4YfNKKsy2FUAp6mYy+HkENcH9nPwDqsvChne34VRqNfA28w==@lists.linux.dev
X-Gm-Message-State: AFuF++liebr6mBPsMTDjrTVwAnUMZVn9w6DfHryMGvra3aL1ciiHvUM0
	lMIRnITWrLgw+ojgFtt9stXWgVSlOFZkgi39ddiNQm58YQEcRESsuCR/
X-Gm-Gg: AYBFou1JeU/G1MBVF+8RkZVCpp/aZRv++4pA4GFRAwNmgwpXqxaMMm67MtDsaxWyn2H
	uji9Lt6PSM1O+7pxPynuMyE+tYBNh5u9qHx+S82u//G5PB0iWDAxTEjl1XbE0WMTJJNaOl9nmKb
	KW4U4IZ67x2laM69CXdGIq6d5w/MAt/N2uFA3KhszQaRCCDdHNjOD/qLF9NqeFiTAFsQDJj6lKG
	NJDC9v/e8A4rdIHNkG8hPWGHoRM7UTKIjddoYCqzBAwHnW4a0FzEBUyHlxTZlJDnymoVbV9tl2d
	LNMdPGW4Qj24EG84C9sf4loOGRWlTFB0Yd2pCPwu/LabfcMPEI5mp7+EFjAOlXxdgp6U9jooxRV
	ycqb3aiCg/c0Uvy3DRtvvz6Oen3Xt3et5nJusz2xjyPZkK720L91xFPxjEWY4s6v0vK/b0o9uAS
	DNEvnM2KRl1JePV9m6F6Vlg/jkXp0A2rJR2dDM3PBbzc0jwTtK6LnjKJPGpzhOviw5DfVeuvqbb
	6oXLhN8r22T9RYwNcKJIg==
X-Received: by 2002:a17:90b:35c5:b0:39e:6a80:dd9b with SMTP id 98e67ed59e1d1-3a0731f9793mr479077a91.34.1790066690219;
        Tue, 22 Sep 2026 01:44:50 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:44:49 -0700 (PDT)
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
Subject: [PATCH v7 8/9] of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
Date: Tue, 22 Sep 2026 16:42:55 +0800
Message-ID: <20260922084256.1515554-9-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922084256.1515554-1-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

The /memreserve/ entries are memory reservations made by the bootloader
or firmware, their contents are not needed for kernel crash analysis,
so mark them MEMBLOCK_NODUMP to have kdump omit them from the vmcore.

Entries that overlap a dumpable region (such as CMA) are left unmarked,
because the pages of a dumpable region may carry crash-relevant data.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/fdt.c             |  1 +
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 286fd4db6312..9a727941b5af 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1286,6 +1286,7 @@ void __init unflatten_device_tree(void)
 	/* Save the statically-placed regions in the reserved_mem array */
 	fdt_scan_reserved_mem_late();
 	fdt_mark_reserve_mem_nodump();
+	fdt_mark_memreserve_nodump();
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 505735732c13..6497404ec751 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -188,6 +188,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
 void __init fdt_mark_reserve_mem_nodump(void);
+void __init fdt_mark_memreserve_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index f29a07e8fb23..a42cf6eac55b 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -251,6 +251,39 @@ static void __init __rmem_check_for_overlap(void)
 	}
 }
 
+void __init fdt_mark_memreserve_nodump(void)
+{
+	u64 base, size;
+	int n;
+	const void *fdt = initial_boot_params;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	if (!fdt)
+		return;
+
+	for (n = 0; ; n++) {
+		int i;
+
+		if (fdt_get_mem_rsv(fdt, n, &base, &size))
+			break;
+		if (!size)
+			break;
+
+		for (i = 0; i < reserved_mem_count; i++) {
+			struct reserved_mem *rmem = &reserved_mem[i];
+
+			if (rmem->dumpable &&
+			    base < (u64)rmem->base + (u64)rmem->size &&
+			    (u64)rmem->base < base + size)
+				break;
+		}
+		if (i == reserved_mem_count)
+			memblock_mark_nodump(base, size);
+	}
+}
+
 /**
  * fdt_scan_reserved_mem_late() - Scan FDT and initialize remaining reserved
  * memory regions.
-- 
2.43.0

