Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D53806D6
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852602; cv=none; b=KNpogLh4jiKavam7LT5vzKIYjeGlzRZCN3A/dukoA2Y+5Ahm8nRPpU5I2szdirAdtSoue0hN3nmXiOX8wdrdNI/unMOSaoHmXnu/fwzq36DEhXKxnxHjoxVtOxDjfrvKjwdcj8C+oC1l5Ap2nhvxG7jF/uMBie7GH2jTB0J56rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852602; c=relaxed/simple;
	bh=xH1JOzQprSl00bucZAjsEsVNgmNvdSYAgclnF834gwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nlpsx3LZ2ybx0ZidevcJrmGfTqF9eHc7B9SBsgnKgBPIeS9dNPVTm76i1ZURwLBDnopJtUsR9LvsUaxEW/d0VFRpYxVecU0ygijV4jUy44eXJbCb08bfHnl88DqUXODXhc7N3tIxEmW1XX8HOTHnUvLpWccsJx9e9+NB2qxHyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFlKSLQ0; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFlKSLQ0"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-83945063f70so5571497b3a.0
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 20:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852600; x=1780457400; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nz17AGesBxrxvpMg+ldtjUwMkbrsU+FQ5Omh3mR+f58=;
        b=WFlKSLQ0/mdIBCds8B28tbjLmv44JApG34Jf46mUAENvxOJ4H24D3oIpuz9Lg1ngGx
         GFYBs6vLVAzccLk5bj5NevHK4Fk2LRyr+8dnO4OIPC8otMKkztE2Mk8xrZe4Lwjb6sWs
         nSSgJ/gS8OgO7MtWzw3YORozOfRZ44UvwIIApe22mfchNm4z1Hk7ekkSRTKPL5bbgCv2
         Fb1LTqDVoFieT03KMnqEXYXBi1Tj7oXWPYV6W9MhtQjVYF52TAot0Zy7eckQskmA/Dkz
         yhfbb91sT/JDvU/srDBVEXuOD8Lcvr2E4ZeAHZ/mEe9KF7krL6ijv1JjkPEGFh+b7Qzp
         ky/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852600; x=1780457400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nz17AGesBxrxvpMg+ldtjUwMkbrsU+FQ5Omh3mR+f58=;
        b=DJJEbWQ25V2C8KG4EnY/cZoWhwxPI9ghCojA7ZuvsPAsXeaypvTKRoRSRESuFsEslf
         LbqztWzui1Sd0rEwOgL/NC8Bo1X4D1Eb3GgFV1xQZfLNW+kXk1RkzZQKoua9hdwVk+p2
         1Pfaa86U7TrC9SmK+35MuS5cTEZaUSe/2wog1Bn5J2Or3rXXA8nDrlJHzNbQGtnwaWEv
         u5MkCDpFzEg/v4PCOgZKlGahx3/Wmw9vFn0I3AVUfc4cf51CuOAAOZv7TQh14lmei2Qn
         3UJRmt7v6vQml6H2FsOugkpf3hthrVTZ88Gr/Pv9sEkgQPWkc/AvG17ky3SN4ozcFE9t
         C7LA==
X-Forwarded-Encrypted: i=1; AFNElJ+Y2ujkL/nLLVznMNVsM7gGDpeSdNHPRHazoQOznMLW6nizK6hAPFMQniuJFn6AQMXT94wyIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4bf8A+7CNMuSRE6sllIG0cDj+6PaMljegFiGCcME+QJVWlunL
	LR5eNDBnyUzzYyH4tkC7eK0wyaen9sUx9xw8BmQxKkNndP6TPLBuh6mC
X-Gm-Gg: Acq92OF9/7lmYqqckQEO2iDlsY6/4eM/6IbfCMqIykarn2Y1qrXhGRjUGBQgVEYPs35
	XNja+sYL7OPXsEMlxpjNr1hQCDcSvO50hDOYVxphVGhof9LA5x9plcy1R4yzmXGzDdvVDnlBVLJ
	SuqpmqRycgw/cRpkOCbFHo7Q1N/Vf17IX4sO7o4ihrfSMTQUoKwGl10qowZ84EGgrdoZo3MIPDk
	hJNHPyN0pjMKYWMjE0KCv6zVQvGTyCA00BAO6SrgBBWza2+9g3gdAGVcn6bn/HfGsrhWgFiwFCF
	QjrYOnb2nCyK9KfDBX4PFB6c6JOfbakyC5kgzhSFFAW7zt6jDnQvH20Rc49L6Ma5Cw/l/79z7Zl
	cW+03h+Q6fw1Iy5snGq4WZcwQRYlaMC6SO0jDw5JllQ7dErSVmSOG6ZNZWdDhG8qyDotjvO8nKC
	tUyNlrPcIwxFstU4o0IPMJ2hdJzCRAga9yi7vFmoYbfNBsmmM=
X-Received: by 2002:a05:6a00:ab86:b0:82f:7cb7:63c7 with SMTP id d2e1a72fcca58-8414b427c3emr17125755b3a.11.1779852599870;
        Tue, 26 May 2026 20:29:59 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:29:59 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 03/11] of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array() fails
Date: Wed, 27 May 2026 11:29:09 +0800
Message-ID: <20260527032917.3385849-4-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

The global pointer 'reserved_mem' continues to reference the
reserved_mem_array which lives in __initdata if
alloc_reserved_mem_array() fails. of_reserved_mem_lookup() is
exported for post-init use, that would dereference freed memory
and trigger a use-after-free.

So reset reserved_mem_count to 0 when alloc_reserved_mem_array()
fails.

Fixes: 00c9a452a235 ("of: reserved_mem: Add code to dynamically allocate reserved_mem array")
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 313cbc57aa45..6d479381ff1f 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -69,29 +69,31 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
  * the initial static array is copied over to this new array and
  * the new array is used from this point on.
  */
-static void __init alloc_reserved_mem_array(void)
+static bool __init alloc_reserved_mem_array(void)
 {
 	struct reserved_mem *new_array;
 	size_t alloc_size, copy_size, memset_size;
 
+	if (!total_reserved_mem_cnt)
+		return true;
+
 	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
 	if (alloc_size == SIZE_MAX) {
 		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
-		return;
+		goto fail;
 	}
 
 	new_array = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
 	if (!new_array) {
 		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -ENOMEM);
-		return;
+		goto fail;
 	}
 
 	copy_size = array_size(reserved_mem_count, sizeof(*new_array));
 	if (copy_size == SIZE_MAX) {
 		memblock_free(new_array, alloc_size);
-		total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
 		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
-		return;
+		goto fail;
 	}
 
 	memset_size = alloc_size - copy_size;
@@ -100,6 +102,11 @@ static void __init alloc_reserved_mem_array(void)
 	memset(new_array + reserved_mem_count, 0, memset_size);
 
 	reserved_mem = new_array;
+	return true;
+
+fail:
+	reserved_mem_count = 0;
+	return false;
 }
 
 static void fdt_init_reserved_mem_node(unsigned long node, const char *uname,
@@ -266,7 +273,8 @@ void __init fdt_scan_reserved_mem_late(void)
 	}
 
 	/* Attempt dynamic allocation of a new reserved_mem array */
-	alloc_reserved_mem_array();
+	if (!alloc_reserved_mem_array())
+		return;
 
 	if (__reserved_mem_check_root(node)) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
-- 
2.43.0

