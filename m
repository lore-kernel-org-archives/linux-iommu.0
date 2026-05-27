Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8473383C86
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852627; cv=none; b=qlSTRp4uotD6qe4Jp5Jo3g0SxuiEUN1tFW53FjdhcdioD5EgLhfk9bGX09v5HdujCVVIuwo76RpnUC9GwH3csvNmYEbFvoVX09ATYlGeVGWnVMj8tX2UxE4cdocjv+2mC35dHiUwQy2URsM8UqsLXAbUoQW+EW6qREdzAfDPfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852627; c=relaxed/simple;
	bh=7kxqwwsFAI12NVUnaU7kq1LIiiUSTsB+7iEGWDm4OPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTzZ8SmtqHON9iQdwVb1xeDkxYpRPhWsgZH/Q0ttM1iedVO0AEdbxmvOePBAEnLFmqp2lbEGEeBAQVXOiDra7SFFXinM0LrF/FIOxIBWTHHgLoFEd2WprJ1sA6vl8LHinG30VKekhbTiSfG+A0S09dLWSB5GBIOM3Uu1lmwzuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0q7L6VX; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0q7L6VX"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso4703174a12.0
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 20:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852625; x=1780457425; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuujAuF8eXBWdShhG/kW229CX67XgkUB6V+YnX45VpI=;
        b=D0q7L6VXReTrcBEFxFJXq2jPxo6XfXdbXcP+Ep56CmhJzfw95JX16pVcxL232b63rU
         u5u3pw8SgLqSn2yTO7z8R6ZORz1Us0E1zjIHv6MquPPVOu3XkziklIYCuZ10CDm4XQ5D
         ynqnPj7QD6J3lTJl9quPc5kXdQ1Zm0XDIYai4GWL/bxuSC7wy+WDvkJlYzz84n7Jd3Pz
         S+clMeZSU1suerf+oTOAZZkKzVS0dax/bimNc2Bt+fTRJzN3xfTWGxTOx5fBt7AdamlG
         cf2YBaWdb3wsTN3G64DJA0vcBTP+VYVUlLdiRdBTAD3TWoc9lEtr/r/ptD+J0pdnXka3
         ngpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852625; x=1780457425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DuujAuF8eXBWdShhG/kW229CX67XgkUB6V+YnX45VpI=;
        b=nP00aCNDLj/OVxQY2dFobYBnLDm36VDTgkw/QdiEB6FwdHd/QhfFn7U0FYw0bHHcRT
         Q07Fg1WGBdzAQDukkAGYAGgcDzdxbpnuOtrZiWFYDF4S34D5+49XiHCjUIYwjDfhrCxT
         bEiJHlLGO8kkMoU1zw+Qvk+F7g9YoDYHI5UGb1vovi2p/Tywy8cu7yzlha8dkdyOBjW0
         WYJWuhuUYpSPtTjhmSw9MGyWeil8Yh1Os5d1FNnWGIUBppVLXUXQFB5qU/ceR937Yoez
         syj437vz5Zx9Uq7fXR12jnD5HgkLdGmqrrR3Et3XfXJ2q11ZjxTS2XzRdhTDeix0qGwr
         ToBw==
X-Forwarded-Encrypted: i=1; AFNElJ/HWIi+hgjkYB8sKc67hH3ZvzeEiYBEg4rP/gDUfw8CvJhjafiaE0RgqJpvtARsSxse7n0ytw==@lists.linux.dev
X-Gm-Message-State: AOJu0YySeM+/N0DUtB1sqU4onEPLCk51hF00nOH61muaCfn7X4dZUr9i
	ylz+jZKU2HAU1+6BRGAxKxY4+JSYCzbA3JzjslH3C1uq2DBxxEdwuewX
X-Gm-Gg: Acq92OFC+iXXD5nKwOFRgVJncEOP2HsTGdsP3cEEx4lTRIUpnO2dIrVk+tgeFzUSIGX
	wpg4dZR/xpSWgSfdH01Ze7iVIv7WOE5cqBoup4y9bqJqrf0yO+hOX1vls4Nsfvio3f+mZHzfANJ
	5iAc9RoKWDHNjpks1Ce2ZWxnlQSNqGPULUjjhFlmWLgiZ3iOYQ+uJBags+t+7LW7t9517wBW92Q
	Xd/olRoNzkNT3OG/jZeip1SIlSOpyqHy7MY47RMjH9S0MNpmKrFZkEeV7tflq6LpSYQHvFbHkB/
	UqVg+uWNuwxJE9TNh4aknX1csXQpjZZfncDCyLkQsz9XDBEw+F+gzRfi8AHOwz/PMD1Epj1wW75
	weZEWGCEzli40XQzXlGaT2aK3gJ5JI2CX8byi4B1qQyo3VltUdku2Duu+OYP21g5WoQURlPFvsf
	aPCAtJ50zi6ny+cfPtuyZLsKHt6VLMVEikkTQT
X-Received: by 2002:a05:6a21:6d81:b0:3a3:17f8:bedd with SMTP id adf61e73a8af0-3b328cc257bmr21442620637.17.1779852624627;
        Tue, 26 May 2026 20:30:24 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:30:24 -0700 (PDT)
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
Subject: [PATCH v3 05/11] of: reserved_mem: split alloc_reserved_mem_array() from fdt_scan_reserved_mem_late()
Date: Wed, 27 May 2026 11:29:11 +0800
Message-ID: <20260527032917.3385849-6-chenwandun1@gmail.com>
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

Prepare for storing /memreserve/ entries in the reserved_mem array.
alloc_reserved_mem_array is skipped if the device tree lacks a
/reserved-memory node, pointer 'reserved_mem' continues to reference
the reserved_mem_array which lives in __initdata, storing
/memreserve/ entries into reserved_mem_array would result in metadata
loss, and an out-of-bounds memory access will occur if the device
tree contains more than MAX_RESERVED_REGIONS /memreserve/ entries.

So split alloc_reserved_mem_array() from fdt_scan_reserved_mem_late(),
and call alloc_reserved_mem_array() whether or not there is a
/reserved-memory node.

No functional change.
The actual /memreserve/ population is added in a follow-up patch.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/fdt.c             | 7 +++++--
 drivers/of/of_private.h      | 1 +
 drivers/of/of_reserved_mem.c | 6 +-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 82f7327c59ea..83a2a474831e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1284,8 +1284,11 @@ void __init unflatten_device_tree(void)
 {
 	void *fdt = initial_boot_params;
 
-	/* Save the statically-placed regions in the reserved_mem array */
-	fdt_scan_reserved_mem_late();
+	/* Attempt dynamic allocation of a new reserved_mem array */
+	if (fdt && alloc_reserved_mem_array()) {
+		/* Save the statically-placed regions in the reserved_mem array */
+		fdt_scan_reserved_mem_late();
+	}
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 0ae16da066e2..50e5a533e059 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -187,6 +187,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
+bool __init alloc_reserved_mem_array(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 05defc91e901..888dcb6bdce5 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -69,7 +69,7 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
  * the initial static array is copied over to this new array and
  * the new array is used from this point on.
  */
-static bool __init alloc_reserved_mem_array(void)
+bool __init alloc_reserved_mem_array(void)
 {
 	struct reserved_mem *new_array;
 	size_t alloc_size, copy_size, memset_size;
@@ -272,10 +272,6 @@ void __init fdt_scan_reserved_mem_late(void)
 		return;
 	}
 
-	/* Attempt dynamic allocation of a new reserved_mem array */
-	if (!alloc_reserved_mem_array())
-		return;
-
 	if (__reserved_mem_check_root(node)) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
 		return;
-- 
2.43.0

