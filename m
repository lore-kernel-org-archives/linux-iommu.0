Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F22D73A7
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400758; cv=none; b=Ih2Fq0WlmXTySJXY22L6T4l3rkmCj+zuqq3VpFs6ikD8ZPEz6HRngmSJMjF2raYY2g+rUnoF+lrvW01PhmDljixjhNK898pYpOzoUo1Zokli9xselvhD9kCw3a5tEjEGbsC9bByHdekhWp6FpehvIfgLnf427sN+pKuSSGvHRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400758; c=relaxed/simple;
	bh=KZiCU1nVn9reB0m8aW3lnYMrYjnZ2w93aVpVoIvDif0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1p08QJAWFAQtjlOIhJ0kQ3RbEXBLN8hRMCmRP2pgD5sJuZA5guZF5gNq8ykfhQOx4gR9iazx6P9o12+2zU0oQQB/qRvpNcnTWhp9JEsGpggeRuNemzi2vHI1IZxfKn1X4NknIGuDI9+ZRSRps1PxhXhhGroPjtp0l4J2HByMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RI3iZuKW; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RI3iZuKW"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-42403719c73so34188225ab.0
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400756; x=1759005556; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDiaVjHF4kERpiNA+aqN0eX91N+wRKnw/AH6MzFfvy4=;
        b=RI3iZuKWSruSDHH4da5t24Os1n6i5uzu+h1r0TubRyGj5WAMk3JGq7ZewRpO43buFB
         rk1bIXW1eWz4ElvctBiV2D4p3EdFebcEXNYaOTbdvX9iPnxsVeUTOcRFDRdl/aKd7566
         EHJLdnxMTFfbt1fHoYnN7Rpuc92Rn0znjffAwYghJ8iyT0bb69nndAeRR3bpsjlQkxy6
         zSMaNTMPt6klcyV4RAKyxhr0TufG3swl7ukQMhORt1hgRawf11cMzQLvl+suShOiy2Rg
         fWlYJyGyE7Wkw+zslDUTMwSeU9475azrpK8jmmRRgqiitzn+oW1LCSIlXTRhSNfZoT4O
         I6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400756; x=1759005556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDiaVjHF4kERpiNA+aqN0eX91N+wRKnw/AH6MzFfvy4=;
        b=uuYtWMA2PjUT9hjgipj0dM+PjmcIF5BUqallTpkrsYQX+MN6rAzGUWCDlKS+KT+PYg
         OMEugrwRDoz1WvpbqVlMERQWKyQ+iGWqCYe3d2aWmahfJhVk1WuVULnhlelgITPtSJ9O
         rUt1AlJ8hT5krtRmc9NAWCgoIFPmfFzbcSIJqZma49t64S00PT1XK6Uqj/QkFfGacWEB
         aR3VrVhJwWKBdmulR78GE5kreZSS2a7DlL/Ak2NSiK8LbcD79lsq6ep2mCWO66Gn9vM/
         eRmtsvcM3MjInLDNLB/UcxUzDZgwXOAzynkbDT1yX5GMA0j4oMK+gvgBRIpRCQCVtwgJ
         B3lw==
X-Gm-Message-State: AOJu0Yz4zI1GYP/ucEnhRod0fww1i+WrinjuIfwuEUobSETDMMrPivei
	mlyo/seucV0ROqZd+EoVO5fwKiTE2YGwhzvPh+BHrUHMbtltSWq28WNabxe+hq1dc/9rnZ/BZw/
	iPMV1+QA=
X-Gm-Gg: ASbGncvbrZ86Tt8hglU1TAJdLP2cWNhJ12xeVZ8Nz3kFS6JSC5kACpjfU2ZuSOJgbcJ
	O5HN0Fd3sthRRL/E6M5hCpnfk8YSRiX0BDzeqKKRxHpi+5LUB8pWXxJFA6vC2onV39qepSByNgi
	nDEFiwBOibLt45u4L2/O/HjDGaAUMrwqmQvXjkZ0fYxrZxzu0ARmi4+pZeKJ61lDMhiclypYVVY
	+JNb4ahl2knTJaRo8iP0lG0dFKU/34YwuIeMxlWV+ZLpqydShDNBu1MHnvRaaHZu5EQPUDOl+ba
	Q+sjSBqvJty6udO9A7ddWbkOR9s4YB9EKN1AWeKmUsDIjqsBtpfRrvL/n5S1KGmEvuZVxdRRv0A
	KAjUHiwej5x0NzDuT6ahYFvcr
X-Google-Smtp-Source: AGHT+IG8Raz8xeq0QgKszu3pyBicegyYf16hU26G0T5WrFouzicPpKiOvFexp2tE8Gc55HnrfGmbkg==
X-Received: by 2002:a05:6e02:1947:b0:424:80f2:299 with SMTP id e9e14a558f8ab-424819955bbmr133419975ab.27.1758400756210;
        Sat, 20 Sep 2025 13:39:16 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-424804ec921sm30642665ab.43.2025.09.20.13.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:15 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 18/18] DO NOT UPSTREAM: RISC-V: KVM: Workaround kvm_riscv_gstage_ioremap() bug
Date: Sat, 20 Sep 2025 15:39:08 -0500
Message-ID: <20250920203851.2205115-38-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Workaround a bug that breaks guest booting with device assignment that
was introduced with commit 9bca8be646e0 ("RISC-V: KVM: Fix pte settings
within kvm_riscv_gstage_ioremap()")
---
 arch/riscv/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 525fb5a330c0..994f18b92143 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -56,7 +56,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 
 	end = (gpa + size + PAGE_SIZE - 1) & PAGE_MASK;
 	pfn = __phys_to_pfn(hpa);
-	prot = pgprot_noncached(PAGE_WRITE);
+	prot = pgprot_noncached(__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_READ | _PAGE_WRITE));
 
 	for (addr = gpa; addr < end; addr += PAGE_SIZE) {
 		map.addr = addr;
-- 
2.49.0

