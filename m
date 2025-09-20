Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8F2E2296
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400756; cv=none; b=Nhb6Z3k9DFB3rcIwaCGjkfqgzfZrVrVz6nrvec0DX00ZrpPokbtCgu7+c3YlMG40171DgdU9k4dypgO7A8VdFe0XEujLbG/GgPtmpknGEQ+iUVKJyKJyRdjE5QXFbtPzztYILUlhCnhlOHm5+3l4P7geAa5GvZkQwpxJk0O2WGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400756; c=relaxed/simple;
	bh=eR9yldP5I+tQHxNItj/BneVd8jk+wwPiVMth3Yu7eiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jxouvcnwc6aylL6QUiwAxtFMLPFTGMJoaShdm4w2K7sjvR6dz7+VMOUgOQ4SL9cOHKb8gzIUsFQxgbNbiGTEbx33yQH42O7FtZzIlZ/tPZK+5KzW7I70X+ncAFHO4A1WNygD5y05vLB37Xt39BA4c5g+ZQiRjaIrR0pjgVe3Ofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QjB+ZCsU; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QjB+ZCsU"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4248b079780so5227695ab.3
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400753; x=1759005553; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lp5QAIgY+FjKQKHqRdWuauO9I56sIIxDetTr/Rl2SyY=;
        b=QjB+ZCsU4vOErQpEWltpClETrZBrFpK1Rrnt+eezQwN0tGCnXH+/CfWg64+eWwDBQF
         wZLIcpQgLsrcFNdvTYKVRz/cKVgdBRTHA99hlvOTn/z/2lrKhFMrssQRmpWjT3HrgE58
         esVg/cWT2mqNbeWL7IieEje1SSnv7/Xzux7HCr5fd2I87mSoY2UYahRSkUbys5KBkGmH
         98BX5l9MmEDRFM/uVlR8fVhss6FAsNHdM79YpV/9c4yDCVAHhQHnuFCM1gV5ulsEiAze
         mOwkRkj5tDfYZpsMBJQfCtl5kIonMXkjR7T6vOB07lmirc0hbJIl6RXTz52MD0vgBJSZ
         KiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400753; x=1759005553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lp5QAIgY+FjKQKHqRdWuauO9I56sIIxDetTr/Rl2SyY=;
        b=LLbSDXvxkYSX+2afv0BdswovzITYgZSc0Wam3fdgJF1t/YJzDAtLFe9GIaxRjDitrF
         bcVmhEMCtSHAxwCL4HgiUZzNk/zZLPyGgGjzetAIhUikNIivYeTsN/7xBs7D3uY8hEHa
         y09VakZ/QsuW8Ki/G9+y+O5qhgiaSW4w/eLjl2HDaMUNejdKobrakot+ZpKpJbciUGRJ
         iXub2v2gdR6ui/sdY7kJ+NpgCQtmDNNB2J0ogGujPDUFXxb8+V/J7lIroDLyZoHn4JMr
         +NaQzhMKx+Ycr9lQ84nMHGdhKBDaG0KJtFT7aW86eQNpwT8rpD0sHDjuqZs2LjSKrPsZ
         8gsQ==
X-Gm-Message-State: AOJu0Yzokx8v+Ua3JEOJTEB5PjkmpyoAyEqqcd8ynATshF3W083d9T2w
	/RTaFuxpBklji00cM4EdB+hvg7oh2RD+aF0pbIA20wF/2B2BDqpnUdmj67XwA1VwFPA23loA30X
	r3AkyuSc=
X-Gm-Gg: ASbGncuvS1FHmPRqKrl1I9UvGkt6oYvRQyVMrfowf81PdgN9fAU0Zjk48SlWcIlFnAs
	EJ1ok3YwNkjj1CZdL0bxQAuQFA/iXGffsa/mFrXW2aRv8KLx5xxJBhUDMwT1Rta8rI6Ja/q3rFy
	8SgwYNay8zBXUdHUUROyI6JB0OviBlKjKDn3qMGR2fxhNsuXuOD3tANBBEwPE45Px76Vpla7YtW
	vCffAUaaFQ8vHQ+UU6Z90+AB7iNYClNHLowhKmSA3aXcta5LXXI1n2oYu9sbSiFA2XypmszlH1Q
	mRE+jiVATlUon7leRPy08449+NuKQMHqyMOzyeEoyPLH5ysv6PgA7SFKwaf6GL6W3TWjK3SK1gt
	osHnIO5j3OvAUz+dC5OBJn5G8ckoAc2mPglk=
X-Google-Smtp-Source: AGHT+IEGRyXKIZhBuusMIimPhPuaP1RErmgLHhjZOiDaZM931WOu2VdkPLc6h5n6dwDp6Uc98U+7Ow==
X-Received: by 2002:a05:6e02:188d:b0:423:f924:c885 with SMTP id e9e14a558f8ab-42481938b95mr127031045ab.13.1758400753481;
        Sat, 20 Sep 2025 13:39:13 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-555a288f097sm699084173.44.2025.09.20.13.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:13 -0700 (PDT)
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
Subject: [RFC PATCH v2 16/18] vfio: enable IOMMU_TYPE1 for RISC-V
Date: Sat, 20 Sep 2025 15:39:06 -0500
Message-ID: <20250920203851.2205115-36-ajones@ventanamicro.com>
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

Enable VFIO support on RISC-V architecture.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/vfio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index ceae52fd7586..ad62205b4e45 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -39,7 +39,7 @@ config VFIO_GROUP
 
 config VFIO_CONTAINER
 	bool "Support for the VFIO container /dev/vfio/vfio"
-	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64)
+	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64 || RISCV)
 	depends on VFIO_GROUP
 	default y
 	help
-- 
2.49.0

