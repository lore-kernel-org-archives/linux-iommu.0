Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424052DE707
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400747; cv=none; b=u8EIkesj1f3lgqx/gox2RIgrrd2anjRFlPvwVDJr6DespYZ2lgObCQhbUaqoFm/oMlprXm7ws36LfIuIjKL6pwzJgNglFHXAZFzVqsydEMuI/HnuJrfw5at2HUX0urmZLboSdmTWgZBmS6M+k8oDclNNV48Ytqd3GXAdlxDvk2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400747; c=relaxed/simple;
	bh=FfOMQJOET+fXIoGZ1uM25aIVQjCYOD9kzF8+9pRr/5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUHCGT6//UFTufApLsNOkQ/YI+83/nGLOL85lBpW5IXihjubm3iNoc82sje2WlYVYiEll+mIlF1I+d0CH+hV61UhGAImU9SM4DqeYdsCnC+PhrFEHeXea2fY+m74/xOP+c9J2jURg82tL7UK5FMbkV5YSLbaC55ZPhsjmyP6m1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=F/maYpCn; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="F/maYpCn"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-887745ee814so105352839f.3
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400744; x=1759005544; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyclL1XhlEcYsrqgE10jIhLpC+mtwJUT0A78Decqu/E=;
        b=F/maYpCnv+sF4EbdyRRguxlE5T1BWyi5tQOHNkAIfid8hJSfXr3MbsCCRgqnaSTorH
         6B1yEAa5wF1kGKYB4a7Y5DZiDtmv7TwowM2yd6OSn7l3tQs2e26LBsQxO9nKFEku3IHh
         XKfSzLZsAOzttWSSSZHh5LxONGHi1iZCEYXLSuuQ9k4j+s/gt1FulYx+f+vkqo80gFur
         DqmWDHgdlC3j/TjMQPC2+gE5VI6YRRY5Bit+kFQgZ4UxyApUOkZ+9+a3MKBD86f6ua8h
         YbCmVTbY9Rhz8yg+4QMqDUOZQ9NhT9g1vN5GjFFvXmuHm300D4e+iZBwwRVNnj+JGh3E
         v4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400744; x=1759005544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyclL1XhlEcYsrqgE10jIhLpC+mtwJUT0A78Decqu/E=;
        b=Ui+p+u+/e9DL+zmhoCLq0Ec7G1OfP0WmbdT40WbBzOSkw4QxSoEqNH3C3UqnZwTPX4
         E9znbczLIqIVvagY1ZfHkeML3GC848b2lkyeQFkmNRqeoyFzW0K3stZe/CHBCnLI3bU7
         yC4+ZMF7rwxb+r14hhjVDvrhPjQ8moEbzvyN46dC+sb4yqWPAV9p7n5dlC3Gt4GgQPxn
         ha0OlXwUNATFIVixG6zzsyfv4W0RXmh2YK/jomyqrCnOYZ9TN7UGZshN6idOAr3NCyn6
         kyx/69nw9NRIfit3KET1ZGfglGzYO1TSU+8GsZLbsTpymxtpxe2uh9JzoIYVgxc3woNk
         mLlA==
X-Gm-Message-State: AOJu0YwATmz4D1XrYO4DQXRyUzqEr5LH5jO54MG/fidGmKtTAEaTYMWF
	LbBC7Ej2krbSRqPKz/JWj8VNNSbQNbNcaLGmVA4lb1Id6SFmoNR8PnhoU1Or5RpociaJiT/oozx
	5YSiJGHI=
X-Gm-Gg: ASbGncsctH0eeZ0SyzIKT8aIW9AuFjN2BfWPg39ZemnizkpPaSKUuqbQDYN4ja2R/go
	9w5Ep88VTVLMz9pj2rkRdOm3YZHeOinWRMq9m4cpAud6wH0yD0W03HzbfkcP7uTz/NkV2HuYeqv
	q9FAkINZ7GYNkuZS1DjV2U+LGOAh6X7bTeA2Ad4LPZ5wFLs5ZyNjDq44UrrtZviZXkwiLVvqo99
	tD7BeNmsReoPkwzOxPuUk5ZCNOY8bkcH6p0+NbpOCzVfBjDx1EyCecR85lysvXRSrB7mkwO/u6W
	QqgGpTeuofgWsUuY1mrUodoNCenOVvQ05JNNj4gb7S3EhMfA9PoXhmncaW6K9C5pOvf47eilLQx
	49svp+ImQez6yFAnoLGBPE5e7
X-Google-Smtp-Source: AGHT+IG40gGHsXsi5eSQylQi3Zsm0ULLvlAN1CN/2lldqNCL8Ji0Ye7gijLwVVX5LjTNRaDqmRWawQ==
X-Received: by 2002:a05:6602:6d04:b0:887:788c:d345 with SMTP id ca18e2360f4ac-8addc8a1170mr1309874539f.12.1758400744491;
        Sat, 20 Sep 2025 13:39:04 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46b2f3405sm304724039f.1.2025.09.20.13.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:04 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/18] iommu/dma: enable IOMMU_DMA for RISC-V
Date: Sat, 20 Sep 2025 15:38:59 -0500
Message-ID: <20250920203851.2205115-29-ajones@ventanamicro.com>
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

With iommu/riscv driver available we can enable IOMMU_DMA support
for RISC-V architecture.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..9d8c90690275 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -150,7 +150,7 @@ config OF_IOMMU
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
-	def_bool ARM64 || X86 || S390
+	def_bool ARM64 || X86 || S390 || RISCV
 	select DMA_OPS_HELPERS
 	select IOMMU_API
 	select IOMMU_IOVA
-- 
2.49.0

