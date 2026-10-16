Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805AC3932DB
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131454; cv=none; b=WO9uVTwwemrL92s+7YnjA7l/0GuzewXbVwTYvweB0OFPGpSYYv6sYX2UafQ5Mt1Hxl8SrQdunfrBoermUWScffs5G7YQh2WL8uVUcNtoHsxNBIyrYNQdY//jmCTLFR2Ra4/My5zsVbKLrluF//aF7SXb+l8rCXmzzf8/RDHWOGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131454; c=relaxed/simple;
	bh=FYy5PHSg/oCo4Er7s9x4p7nGdzrZ9/PNiuFGdN0WpnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJbQSkY39wJtPhWdRxbSnZDTyFkQHu7dT7zsOfCvUZkdoTq7EX/FRhKUeGCf+7/DOF/Isvnl0TVBnvdklWGTQ88GxZLUYzR0jEjcdgAlNDZ3dywHJDXuQVKWYe3aJgLHUu0nbzDUFNEfXrBMtfhYKgbYPaP5PaW4F0yZyXPxewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tF4xmV5m; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tF4xmV5m"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cd65a511e43so73723a12.1
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 23:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131453; x=1792736253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ICQyIKowVj3RyrjMn4gMzYuhROzG3qohL1WARXEfQY=;
        b=tF4xmV5mNQj1ZfOAB1OV/7/sVsWuzhZft7O4t4pvtPNQzDQrJfpCXlheYTYb3392m3
         OB/Olcdi6z1891Q/5HuyWXLix1QGd5K/vcQaosSOcX0ImoYp+st9E/sy1sU6Qs8FDU5c
         fXPDcS182kkRFtrAkwQzhW3jCJ5u9ZaW9KLzwmRzs8QJ1MaSMeYMNVOnSf8d/5pUkvpN
         f15VBAR7HS5hkU8XKYxEtAGvQlucCLqeP8yMheE4l4b8V4moZ7BrVzzdueM1cek/q/1+
         kQyAV/j+yS5QaI1UUGlZFmdBS0X0lg3xA4BKxkzRyK++jQO7YvO0cnmOEfiVu4BtVnDp
         lNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131453; x=1792736253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ICQyIKowVj3RyrjMn4gMzYuhROzG3qohL1WARXEfQY=;
        b=SMkQxIEoI2z/HR2epFKbF8GFhIKeQ1hkiAzctHKXmSpMzDCLoHSF67Rm4HICaaCiiT
         gZSaaPnvyaG7+cXRUqYRNSmyLbspdp2ZakxXSk2T64zenCCeQFjMZzZFufYLg5Rw8JcO
         lrIHcj75cLO+Vs+UUaRWQzZEbRCHm69LLNqyOi8NGtSwVVoaQxjQnq7NFKAUuDiadGMS
         YtP9rCvbUTSpGccLwpCJMTJJ0YXDd3c06gsrYkDKRAO+wdbMEXLDPA6Cug/qBxAom7Pz
         4cdkVwMNIblcZ0pkvPYaFTowWcoj9QsB94P/hYkJVJvfmY1OXosLAljZzYBhkWQetYYX
         Jzdg==
X-Forwarded-Encrypted: i=1; AKwUvBzIssTTBqV15FHm5TYCzyIy90H128xpRVVoFAYsHCmiooFn8Ifg1fe43Jh5f/82haj2SExBcQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLtObSAdo8O2ZU/cLljCqrUu6JMVHfXfTjYANNTAnWehO9jN2gj
	ZyHXcNFGgPoCqevMUdKO2I0vkt5IFFUypA7v436N2IcOx+t/oa6kFueo
X-Gm-Gg: AYBFou1n9CnqPipqJ0mIPKyiWjplJWYcmWQU+fyihrdlRGiICjEP0ZCbgZEoain7TDw
	S4c1uht4x4TW7FQu+k1cwo7Js1S3grPejoi4slpaLlXlrk+kL5zsQ4vdffjAxWYKbw7FBdDcQYk
	0oRcGiiy9iURUdPIzyuLaZmxmUg92c00OWzaY40vsX2tZA6piCp7iAsMODrkVZknKzt90ndHOlH
	X1Z25VXBnknP3ee8GDxUlqM2/y6gT7qbjN1iK4c57KduMIYd0NBSKNr+DVGXUDE8x3PJfwCD6Lv
	O43ZT8O2b01xRFjPLdh0Yyveie4MFNcS3gEsyzJF/7u/OwokqGjAK6Ecc8+IVcvwTM9U/+4ypVn
	EJmxT6hlnjTavIqcFGKo9+Tb13XAA/C1z+2lsEX/9id9pGsL+g8LzIVfhVxjqxIj9Li7GI0bnYL
	Bz2KSnDla8zkSOpXSKH+TItJp+eTHiy7upIV2yzx2lw4O/1YrVAkJgOKXz5WXDOn6gAf+1pBUsR
	Fc15ITUYjo=
X-Received: by 2002:a05:6a00:1941:b0:89d:7f51:6492 with SMTP id d2e1a72fcca58-89d7f51698fmr8778955b3a.32.1792131453020;
        Thu, 15 Oct 2026 23:17:33 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm586375b3a.42.2026.10.15.23.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:17:32 -0700 (PDT)
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
Subject: [RESEND PATCH v8 7/8] of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
Date: Fri, 16 Oct 2026 14:15:48 +0800
Message-ID: <20261016061549.4181390-8-chenwandun1@gmail.com>
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

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

The marking is guarded by CONFIG_CRASH_DUMP so non-kdump kernels do not
pay the cost of splitting memblock.memory entries at NODUMP boundaries.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/fdt.c             |  1 +
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

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
index 8c9d6395d6a3..f29a07e8fb23 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -677,6 +677,21 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
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

