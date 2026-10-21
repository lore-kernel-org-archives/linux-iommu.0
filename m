Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571539;
	b=KCgfEzNNym2PcJlGslrSOctSTdv69r+RolufzhJ8yZ5JZzMT1CP+33pRRD/L89TUCRq+
	 EWR8LCxyCBbxeMaWJ2FKZqawr1wv/IU6nz0G7V5rk0SzklzTelqykzj+vXb39TIcDUO5a
	 cgxq28BuWCJcvCdzPwNjfu9ihWFCiyYQAONQcd56iEwkXtCw9BeZ8Z4OQiu+2tOKIObFp
	 /826asf9+t+JxUVDITNVDbN4UmnDtHCFYsSv81vqkg0X/vYRJsgcg+2YWctccRLqxpnlq
	 y3hEJ/o5KhfzzKG2ukdMbg2PTg2/8NfIY7Jg1gaAjq35EOwXocgd8vPJsptq0gsRhTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gUG85+B7KqrDZpPXGb0QyiCfKe+tueHmqLD38rgeJ0Q=;
	b=fD3yueVQKKqfb/dYbOz7/S6oDeLrgAEtxdZosynKGglgqd2MdVKaY+pl+MGoFbWecNhX
	 39CVHRM7JuPuBqiL89Wkv4lfcj0511IZryd9LlDg5we+NM9z21vZSR38/OkhPNp90trCa
	 Zz6wIXegeQ0ooEotW/aIGz7qsPch+aRZU1dhrl/WlMUcUboSYtA2MFVqBEZ9dRZ6PgiTi
	 Oll96Iwh1Npj+qYeReytan4GRedUlw9yuW8vNmbHvQfM881mf3NwNaAlt612hsLjbixYO
	 sfhq3rUk5IcCjSdoypPrx/kwzltXWWV3/N/iBgKkQM+nYRzBY4O9Cm5s58KiPf/i2yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="T47/BA6R";
	arc=none smtp.remote-ip=74.125.228.9
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A360A2607
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 08:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 852A360A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T47/BA6R
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cd65a511e43so163621a12.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571539; x=1793176339; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUG85+B7KqrDZpPXGb0QyiCfKe+tueHmqLD38rgeJ0Q=;
        b=T47/BA6RJTv6FAoYGWFHyD0w6lg8ssVuZ0N7eEGs7p3Fr1BrSGldoQer3A6noo33/F
         xc094IAp6N+IAzyIluabI6h1HCN2HqWwazmhHdltqq0ZhEM7fJLnw1uGq+OEcVcE7E4T
         ibYclpo2J9jY7F/WEs+QyGkhrfHqSvbeDH4BwSr66S486+16DgquZxdQgFL+XUpDMLAN
         PfF2qPpObMi2hBgaToG9ycqe5ZYedPzx7tLhpfmKw6XW+ENibJlh6P8LfMBCoe8G0nYq
         9MiG4GUPwD4rZyc0SK40wz5zH1P0AJuXiiwTnO64uioF/rHoMfQwMwV7afz9H0+R19vl
         zOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571539; x=1793176339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gUG85+B7KqrDZpPXGb0QyiCfKe+tueHmqLD38rgeJ0Q=;
        b=CKbH24g3RxD5/LWCIm9KewnB/SsxJzqfMSSt5zj/F1jNkLB2hCYiWgHltqoIxPfZep
         nSB/JC5m5pF3RI1S6U/AXQhp0KiMrW3wv6RkbB88TCXzOBWUt2d1UzsKz2X7wn3qtnyB
         /AghMvzI48zJpxDNGM627Mgogp4j9tWV9uNhRP+cBT2PEjYZzTUuM99bTqFSkoR3Iosi
         SzV3B2NZZ/4JxerhR+3nFHwlabqXVP12sO1VmwcOfle+vuO70PHTXCzpvBnJvfHP0zml
         NnlJOn8wgJ2pYOHaNAHOMlhtuU9ZA2JaGsexkS3HVFh1Yh9Tp/sOw0iY5rBrgRz4QZZW
         lvsw==
X-Forwarded-Encrypted: i=1; AKwUvBwNC9Gy0HaoksjdskG3W4+6r7yJqHBnXhTCeY3XM64W2pU1HumNzRbb97IJTW6oEO7jddmpvg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKoSIMgMPMCDavhhyecmV84yy+0bS9j7x9ZD3Vjg28sQ0oO65Kf
	vEHVmF4UNQpIVQGd0sgNGgxKTNotln1Jr2F9eUd6IFDl6L+pawzL1woa
X-Gm-Gg: AYBFou3OFkggsnwP5IaxomKYZlbYximigmVQ1XvIJnaTOGKLfxmdIAODIEsrTqZHy+O
	sN51CmGP4sZPQRiT5xt5t2zyRY3MTezR+O3aweTAuGbAn4YKsr7MkjYJNWRnoZqEUzCHiQDl/2O
	BWzsV8zwVPRelVySXgf8nvzh656R9jefkbh1oqNOHVeOrIy/OPs1zVuwmp0Z9FAdnBbD7r8Vo2w
	lUTR5lRkXGClPvBoEzSTVmcJwQewErql32Hq+O3d7sDOFR16GVtEv5DmCqXv6EnTgtEqdkRDREC
	xTquKFTQa0z3lC90LfayqRw3Bot3QGd3G+p4eMdlGEid632P0HFoTSR+c+9OHaOUw8C4lYwkoof
	FPXqG2hljCIl3gyqUF5GXI29XdGK1IiF23Chyidc7FvHu65f6eTiduMBvAID1MOk1Nn5/LPsV9p
	/gdNxo4MZiCZS0+Bmh3MVUar1iCue6RinABmq50uyz++fAjEtfgH0MZxCMSW5L1KhBP8lRFIbTc
	lazPXUwFVgsWfiAj66ChGrhzzyow5wYCrtwDB87+bCD3k+eedx+cUBBEc9L1KtXhBC/
X-Received: by 2002:a05:6a00:a0e:b0:8a0:1435:fda0 with SMTP id d2e1a72fcca58-8a089d4702cmr1201474b3a.51.1792571538862;
        Wed, 21 Oct 2026 01:32:18 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm600653b3a.41.2026.10.21.01.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:32:09 -0700 (PDT)
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
Subject: [PATCH v9 7/8] of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
Date: Wed, 21 Oct 2026 16:30:10 +0800
Message-ID: <20261021083011.2170525-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

The marking is guarded by CONFIG_CRASH_DUMP and either CONFIG_KEXEC_FILE
or CONFIG_CRASH_HOTPLUG, so kernels that do not build or update crash
ELF headers do not pay the cost of splitting memblock.memory entries
at NODUMP boundaries.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/fdt.c             |  1 +
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ecc923102622..a5f223a74b7e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1285,6 +1285,7 @@ void __init unflatten_device_tree(void)
 
 	/* Save the statically-placed regions in the reserved_mem array */
 	fdt_scan_reserved_mem_late();
+	fdt_mark_reserve_mem_nodump();
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 0ae16da066e2..505735732c13 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -187,6 +187,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
+void __init fdt_mark_reserve_mem_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8c9d6395d6a3..db2bf76000d2 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -677,6 +677,24 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 	reserved_mem_count++;
 }
 
+void __init fdt_mark_reserve_mem_nodump(void)
+{
+	struct reserved_mem *rmem;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_FILE) && !IS_ENABLED(CONFIG_CRASH_HOTPLUG))
+		return;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		rmem = &reserved_mem[i];
+		if (rmem->size && !rmem->dumpable)
+			memblock_mark_nodump(rmem->base, rmem->size);
+	}
+}
+
 struct rmem_assigned_device {
 	struct device *dev;
 	struct reserved_mem *rmem;
-- 
2.43.0

