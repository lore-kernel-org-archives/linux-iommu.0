Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C543746C
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008965; cv=none; b=opKvmsAyRKDhcQWzkFHHptlmVGBonkrTSpwZjkyb0Kbu7g3Y3zqpZ8/7vqJI2CJ0BoKZFM77zVyl4klSKIbAbICBcgejarp2GNtgiKSyjvNz4BKgiyTusin0C4V8o7kEDu3DMe77hBJCBrcg0MI9a0dbpa0jSCk2jsk2BKweNyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008965; c=relaxed/simple;
	bh=lZf+l4j/Q4ThP9Eu+M5Jyz5exYGOi//i+2xKo39QXs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmRlQP+7MUNDaGnYrmfLH2eim6nUf84UBCP3IQtlkoDuqgtyvQ5b8yK/r5ANmJny9XhfoHERDGpDLAK+CGZFnU0STEt7HTILW2ZIcIKpwP7syFJobupMvTFS2ri77coPrFN+oPqic27CRXjlDhs5iuDWe6Tm15TPnOmExVWIwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTB2Rgw9; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTB2Rgw9"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca034c989e2so1034759a12.0
        for <iommu@lists.linux.dev>; Thu, 06 Aug 2026 02:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786008960; x=1786613760; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knTPycIW4JC9RtVxI7lTQdVb1SJbys3U0akygREf/j8=;
        b=fTB2Rgw92zwKcM6WsYXUCcWbbatzYatis7uWYnzwhgHxpnFQ6nMVKOTpsWxVJxtKtH
         npi8C6PrE8N2K/HrhQQppkErHzSHZpa3rklv373xslSzixrugxn0kWz0nR9xXLvk3Den
         +RbTPyDHa5S6nDc2aZeCUD3YacIk8ZxEiLyArDQvfdBsJthd65xq+JHkxjIZLiBdyZhY
         MVesaK0lHfIGg/CwgAjerjMkxBj8S51VvbSEr8Wcrj/gwkUfg9GDjeNSH0SqxuQSDV1J
         Wd+Pbxi+rMAVyY9YENKh6n/PkOaXz0jFXThCRvmdZ9MmdeDbE+EGy1Kaan+0GWs65bx2
         5dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008960; x=1786613760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=knTPycIW4JC9RtVxI7lTQdVb1SJbys3U0akygREf/j8=;
        b=oP018KCmE7yEr2fJNV/BlKBW5HXxW0f8aBfZsDjU6kuro8a7owSx3VrHg0vHOki0c/
         mLRfS3zGwuUpqLVp6SPGUwnpxaQizxTmkYxZXUGOwFTwSEFrpzcHptfjSvkkV4ilfGZU
         rA8px4E4+ChoZDnaG3DMMCP2P5NUKYO9svPpOotkDVJYxBDz7c0/L6QyHDiWEbwFPoHt
         C4qQx25S9tLpeJ+7rM39UYFXHz6Y27KYjsaj5qmR5bd51n0AnPfqQW57/AswNz6s6m3o
         sw+jhJw0PGkibc5KKyZ7XVRqJ9xJj6LDFHAqCIIQM+BBezXk69UDQkTTi/a6TE58PDZd
         MbLQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBQuL/RCXBlxIhSRWbqSLh+ya5ZoEGOnpMldpSgwRcRKQrUdCDQbweuVFbxLwxPaPkK6/rQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTiC9lDt6W7Qp3dAikwfiS3hYn7jMrioyHix8xx9JEDD3FUlFV
	NkiJOvx+3Iutu7tUUMJ25htwafDFrasczz1kw2Q4WeZKoJpKtO1b5cUw
X-Gm-Gg: AR+sD12lt/BjUi1g9RMwzlgPJ/XLsMCkl5bamrPPXzObBakWM6HS5xb3gDnZ+d49Rrr
	F8IWtPB0HtRbFho8F0bV36HIDrLyDYanxd6R2cxiUEuyZTw5JENPBrpZVBEa0xni2Ws4vnfQb+n
	qvDXqeYPXswxw5UF75zKk7m03oHb/PEqZbi4zNgUpNJGK7Y8N3zK9dLd3ZHAX3A5efSxHyDVGtP
	KZzbrwZQljO9ATKt36ahnpIgWQnwwxaUxGDH/oLpI6QLNgChyV3ixHk1u9dhy7244uZwdrpHmf1
	dE5ZfJxI6Vg37N+OBpUIsok6rz7FCAPDDuLIaw/YW1VEYmajtimCQf0iCFGFAHtmwcq0Ngbf8FX
	gACjWaL1zFJZXxUbZOpcb3cMJK/3/N0/keI4EB+ZtArURxMlAEQ5G3CszQ493KkdSbAyvIJcZJf
	r3zXdbyN1h6invKCEI5hVPH+AO6GTT02Bp4AC3uKwVauyTssgokpeFj5WEFf/pkCbeyj/jArcll
	PM=
X-Received: by 2002:a05:6a00:2d8f:b0:848:7552:3d86 with SMTP id d2e1a72fcca58-84f2e009be7mr14478703b3a.23.1786008959699;
        Thu, 06 Aug 2026 02:35:59 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:35:59 -0700 (PDT)
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
Subject: [PATCH v5 2/8] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Thu,  6 Aug 2026 17:35:13 +0800
Message-ID: <20260806093519.2907771-3-chenwandun1@gmail.com>
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
index e8b20b29fa68..55a67cee41ea 100644
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
index f754079a287d..63ff134dadd4 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -565,6 +565,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0

