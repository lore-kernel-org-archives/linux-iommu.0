Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0B2DF13F
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400748; cv=none; b=StSp6HB7tvP7+l4mjnI6j0Kof6KcuRRT16SpuZhdGjso2BquVMpp66uIbBOWuyQmgcVptRKCBWA/UmEEOACov6NHFpBZNHq/aDsgMrzwyeGTiHpL86f5+G5nDPm/PYWulcBU5Uk38u3rFC7SNG+sEIMBaSTHNuoqJCMEUb2f/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400748; c=relaxed/simple;
	bh=tTMgpRJRAH5vDgnhSX3ZRgd44nfq1rpFBPS4f/QxglI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYfXcFQ1hkGveW5ziFC2KDocpbC0coZnc+XQfJGhiXCktAuYMdtThIMishcHKdISRAk3ozoU8q8f0dSokoP6CrWrZ5v7ZPzOpDjneXfxLp2TKAZlQQmZk08FwMh9/YbZ03WyPX6TuCTjS++6NBR37WlnT0VAWEJhn4G8ANDOg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=j9wO5LRi; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="j9wO5LRi"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4248b3204d4so5002915ab.3
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400745; x=1759005545; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfEiik7U1UfCLLRy1SfBX6A4ZldZkp0tuNOLkoczFfo=;
        b=j9wO5LRikc4P4CLPyc5VsvJaZfFM1BOqUVw8CLcklHEwX9uPi5vcO5fgARhR5p8Sdw
         AFqIH76784Byo0636jUA1P3q1cS2N3RJ3BMYpNTOFcwym54GJCWNH8bYgKAS0xDsp3v+
         6bfKjQ6ayFFKF4vRFDIKBnKJmz2UBoudunM39GaOtAmNEMQGynXua8wX6PZ4hd4tHe8R
         pbRn798TLVAbSD7/Lk5S7yJtbDKmmMDvuSO5PNd2aF2m8GmA0VFL+yn9Mo+gIAF0H6Bk
         Lg/MexOW1wAWjOcp4Sntrl5H0kPiYvWtmFl7TDADOYXIVa3rSY76CjUWXbBmQm1vqVmd
         Z1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400745; x=1759005545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfEiik7U1UfCLLRy1SfBX6A4ZldZkp0tuNOLkoczFfo=;
        b=dCttEkbalDLSfr90Gl8OMdyLsUgALPoiMc4VTpJsKFYYm7xwsSlxFcO8i4iQ3k5JGi
         eV+PIwGorz/yZ8g7rh6wF79ckxyc0MB/C3BA8lU89F3yB5sW5fdzXae135RHH3wF6m+T
         9wt2/x4Loz3MGvKI/ewFpIaSx8HNs6SpM8PSYSbCupaY2KT7M1b1Nkry4KnhlsKqFi5I
         uLNRZ8/V4YiofWAE30w6JsZ/xonvWn+m+Odmi735ouBtaXmIxMKkX6GWPUh/NFhOttVL
         LQ6fM2MqFfQwWMYrSz9l8ywQCZNaOETtnHF/5g5AL62E9TCBJaojHtZtTjU6pkyyOTkP
         sJGA==
X-Gm-Message-State: AOJu0YxU6I+BOy+paE0NbvO8/5y5monI96hjMYri3emDvXHzavL3NnVs
	q8B4zT4j1OVdTPz/i9iL3et/2ZZLsh1F+RqNpWR5O1H4N4cmhezmJCBXn6bD4G4DxdQ7k2F+N0g
	r0TFDKoE=
X-Gm-Gg: ASbGncs+iWsXE8r7OGoF+CnkQE3w78l0UeLrZQQW/7yzS1RMTVxAZYWi0jL8l+U9gIf
	VygTIucnCaLvVjkaaVxTEAKXi8J7G9HTtnH23N05vuXoyGlYGMVpkmjaC1jjGuBczxlmks73DVs
	pepxW3c0UhX3molJM3MnjvFJCitUuH+Y/SNCYwQah4LeRsX6aFNsjh1fb3kNiyURzmbH+bHsekn
	zzbIInE+r3A4E4FH9yoCFLJaER2WCj7y5/TahN0TmsR1HeO+1nPayOtLqLVTK6OeSzkKz+tHAw6
	AInZjwlTFBsylF/hksm/fSvPYEOvjNfp36DA+zVVDtX1xs0sFXuvURBzVDEwkIZ/c48E9Nj3Zlz
	iSYeyAycSUS+zuHUjjTBsh1CM
X-Google-Smtp-Source: AGHT+IE581P0AkyphXbszugWZqZNJhwWmOr5TRI9ATozw6M+qkg0V/7BRnonU41e1GD3hHsR2JSR+w==
X-Received: by 2002:a05:6e02:1b09:b0:424:69b:e8bb with SMTP id e9e14a558f8ab-42481936b23mr116504325ab.9.1758400745560;
        Sat, 20 Sep 2025 13:39:05 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3a590fcfsm3682210173.11.2025.09.20.13.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:05 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/18] RISC-V: Define irqbypass vcpu_info
Date: Sat, 20 Sep 2025 15:39:00 -0500
Message-ID: <20250920203851.2205115-30-ajones@ventanamicro.com>
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

The vcpu_info parameter to irq_set_vcpu_affinity() effectively
defines an arch specific IOMMU <=> hypervisor protocol. Provide
a definition for the RISCV IOMMU.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 59c975f750c9..27ff169d1b77 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -25,6 +25,15 @@ struct fwnode_handle *riscv_get_intc_hwnode(void);
 int riscv_get_hart_index(struct fwnode_handle *fwnode, u32 logical_index,
 			 u32 *hart_index);
 
+struct riscv_iommu_ir_vcpu_info {
+	u64 gpa;
+	u64 hpa;
+	u64 msi_addr_mask;
+	u64 msi_addr_pattern;
+	u32 group_index_bits;
+	u32 group_index_shift;
+};
+
 #ifdef CONFIG_ACPI
 
 enum riscv_irqchip_type {
-- 
2.49.0

