Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB03E639D
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805694; cv=none; b=LySFVW1sMK5fdAPkXlWFQmHKJ5l6WOMbt6lgWGqNecR+jo5BooPZmN0xYB78a1xSnUN2c/BpHSEXmlEdkbg/62ZEgs6NmXRbx8Xy20EXIH5coOhyMx09xJrfLDHFsbwQn7VNX9VyLk0RcqFAPy673u6RbZRrBgrA/UfsTsyV3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805694; c=relaxed/simple;
	bh=3fPONwE1yui7Ecp9kezKmvS/5X4RL/p2ogE97qcl8wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eilo43h69E7mIO4H9ZZqiTeqpyn/N9F7CnGMJmIsxlJNy32D8Ysz5y7+EheQqf1rw6Lxx9B2gDMFZSPRnojOdGHKZJ0GcnngoujepWGc/9lThVdu86yeh3TwEyWAr+0CAlG5OdjUPJMewRz5q1JJEW29l+tZN2tgMaysBGM558I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBRJ6hPI; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBRJ6hPI"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2c80ff1bbb1so3652265ad.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 00:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805689; x=1783410489; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN/H1G2k/2fwCg/1D3i4ik2O19md4fRGx2OQL5vrZCY=;
        b=tBRJ6hPIZkfPCYxe6fKZ+1kOcmWn8Q5qK15Kd+hjBX599ADfvgRIUNlXrGusfNXmmc
         txG3T6efuItZiwk18HGF7VO7EgRRrvzVgGrVisMPh6ko//5tqBLHvTZcLAS9zO4LFRfy
         piUpFnxS8AMmpfyJ306S39YtqR42UtijE7pRPDsPJutVp1uDKzuZEQxAWWlwWhE1hELL
         qjZHhGkidjnWy14LL7BgWAh2tjbSlaNOI7UGH2mvxutV0TgpjSMqy0eidH8glDWY2m38
         Kwo2Hs2ZfZC0bV7sQI6V5uqkQv5QltnpFlP+ZxZIuVAkNV0xr25DOUouSm4E4w8qh+mV
         sGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805689; x=1783410489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wN/H1G2k/2fwCg/1D3i4ik2O19md4fRGx2OQL5vrZCY=;
        b=qC7mmanPdPb54bJJz0hEuqaJlt0Pq8mGevoo5jMS/Rz3dq/3cKWrGb6iWMT+q7YWAU
         S+zeEPqeWsoh74kVCmZ376axQN1WtDwMgrRZ3QEriXtmZGsw8DuuE7c8xH1xBDnNlGel
         vRe+Xc/BlRdq3DHxJWfThlB75xRuqETVXt/9Zo4ffYDEX/vG76T7YAdK3wzsDq2s+t/n
         E7h1cxaFci5O1WwT/s2gf8Zx84BsO0WBmkOlJv2YP/liLOK6xiO1TNbKXeWD4e48MNqV
         X4/XA2bt65sZceNOBecrQFtiZiuNDMJdVNYtvlx3xkx3iBj1dbkPj444/WE5B7NXXGa6
         97Sw==
X-Forwarded-Encrypted: i=1; AHgh+RoMOMiKLHY+luWIGnLV32tMKYmmVS50C+DOFamC7i+nd2+WntQF/VKuCgKum0yc0LVEJt8hxg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxcn8O4BYDe6q6Fb4peBE2DB3OyW2V+azjAeQipy0Spi+VWlFBY
	bG4BgkzqDPKrochx6AOaFAo2liHx52bhyqAzap8JrYIqIEwxNfyud7RU
X-Gm-Gg: AfdE7clwJqoqXQJg+iIRQB5igOxNHCozTccdQY59LenbBF7BYokethmAr2BhLoEAr3z
	sHia/jP+V4YSPO8E19Igug3ewAs4q3auTjDNxNnQJtPJGWLieLh0a50DjQKLNw/vuappQZiWpL+
	yvsUyzHSNiC1iV4+caFtrwR5RZRRI6WMnvs0xZ4K5P9bz3JbGxebCdvCOLtT3S19WgPC2/0el2u
	YGj0d0zbgUJo0MaDXRU90V5LWbZI/mXln+ZLWHc3Hj/ucgOt0ksnnh6TNaLuWFiJanlOllUE5Po
	rRk6ouOikrZZANY5//2Ej3Q/P6BabnKSPdV/FG/mpcIuXzvJLRZgsm/P/rWVBDQ4X12pzazIpr2
	cvkfshfphBUcb84ockwB17BSuZ5AsfTP96gQF/z0YTKHHcgRWKlaMEK2iejzkxhaAh7q+zJ7so6
	x0jxSbQVtnwOliuvMIvXg92v7EJQ==
X-Received: by 2002:a17:902:ebc2:b0:2c9:cf41:adf9 with SMTP id d9443c01a7336-2ca2ec34870mr20905945ad.47.1782805689451;
        Tue, 30 Jun 2026 00:48:09 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:48:08 -0700 (PDT)
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
Subject: [PATCH v4 04/10] of: reserved_mem: split alloc_reserved_mem_array() from fdt_scan_reserved_mem_late()
Date: Tue, 30 Jun 2026 15:47:08 +0800
Message-ID: <20260630074715.4126796-5-chenwandun1@gmail.com>
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

Prepare for storing /memreserve/ entries in the reserved_mem array.
alloc_reserved_mem_array was skipped if the device tree lacks a
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
 drivers/of/fdt.c             |  7 +++++--
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 11 ++---------
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 26f66046cc32..b97775f6c9d4 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1282,8 +1282,11 @@ void __init unflatten_device_tree(void)
 {
 	void *fdt = initial_boot_params;
 
-	/* Save the statically-placed regions in the reserved_mem array */
-	fdt_scan_reserved_mem_late();
+	/* Attempt dynamic allocation of a new reserved_mem array */
+	if (!alloc_reserved_mem_array()) {
+		/* Save the statically-placed regions in the reserved_mem array */
+		fdt_scan_reserved_mem_late();
+	}
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 0ae16da066e2..81c8ec9378b9 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -187,6 +187,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
+int __init alloc_reserved_mem_array(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index e1bd35115cc1..f6c02b37deb7 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -69,13 +69,13 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
  * the initial static array is copied over to this new array and
  * the new array is used from this point on.
  */
-static int __init alloc_reserved_mem_array(void)
+int __init alloc_reserved_mem_array(void)
 {
 	struct reserved_mem *new_array;
 	size_t alloc_size, copy_size, memset_size;
 	int ret;
 
-	if (!total_reserved_mem_cnt)
+	if (!initial_boot_params || !total_reserved_mem_cnt)
 		return -ENODEV;
 
 	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
@@ -266,17 +266,10 @@ void __init fdt_scan_reserved_mem_late(void)
 	phys_addr_t base, size;
 	int node, child;
 
-	if (!fdt)
-		return;
-
 	node = fdt_path_offset(fdt, "/reserved-memory");
 	if (node < 0)
 		return;
 
-	/* Attempt dynamic allocation of a new reserved_mem array */
-	if (alloc_reserved_mem_array())
-		return;
-
 	if (__reserved_mem_check_root(node))
 		return;
 
-- 
2.43.0

