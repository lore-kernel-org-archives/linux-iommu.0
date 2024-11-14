Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E71A76B5
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601150; cv=none; b=D+3fC8fwe7a0auRWqJmwu/515xv0NHBRxB/2XC+J6iaMhWy4Q42OsIU8cjIp6EX3JvXYFRM2sX8LKN25lYPsAzL6l+dFOm88hSnuYnPnCaNMtBWynuVxfYyFvXG9tcuo3gODuIj8fb6ag0w3sj1YwMVLmjfhEjGGcbyKoADYUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601150; c=relaxed/simple;
	bh=mWR/+tZ7zPAyQgPDW6T1+Yz2Dl/T8S6Wjb1XP+iFats=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdApNkU93h9ADokxOcvq/oRsHdH3bJg1NlaJzMClemQtqUS6HIuOzOjxaxZKjoecemodiDEqqCpCjUVNZWd4wZrCR7qCBipr8QuEeZ3oxdg/MKn+Tk/UdoIzT9qNMD5qa+Xzds3+nCgaPJqAZktJHoIYhXYyXzLyTkmEXFu2Nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=O8bnfbPQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="O8bnfbPQ"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53d8c08cfc4so685034e87.3
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601146; x=1732205946; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftdmF/h5yhFV9hvEqaih+NCLoaifWjggdlhRka1xblk=;
        b=O8bnfbPQdHHw1UQbdz3jPMYBNMAcl0VSHH+YtuHsM7ppG/gZbkBYfEestlW0qtR4ej
         K5eS0em5uU0ag8SvLAkiHpORyYDjufmTCEv8av8ww6syTK/bYHxVsFPEgIzhPcea++rb
         rW+Pp7LE+X7PzgDSoMbZDUwqp1GGaDqy1iD/tS4SWFLYVfbLA6kNl+ArnKHl3mNtJgbM
         RkGsoh9fWHaKXHw6Yc1Z+6sJGT7ASCBJS/+PjZgYAqeNDgWDc4Gl7mDxx3upAwhbVdOw
         EINoZD/SubYffib9oaeBIhZwT4z0HVvo/xF8gnI4W1sd6amy5ybv5LcGu5zQxIN5WA7B
         v74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601146; x=1732205946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftdmF/h5yhFV9hvEqaih+NCLoaifWjggdlhRka1xblk=;
        b=geYB/G70cUg/8h+lxuw7Yxgqcn95SqFLEjownGMvIMmG5J5+rfdwctnF7ZUvHaKwwp
         gaGxbMFL7KO7of3A9KRKA0bySaMG06eYmLJ09fkkW9q79lAw8oaZ40NiP6hm+YAf1o40
         Qy7As07JvbYzxSnesfPgCWNatG3WKJCBczLFNSGkMoKKmWce341Tb0ZsdkJqH7Ii6CGa
         KyfKK3u5O0fx2h4LEikt3ZoklMeFiz7VzWZODt2trI0ZJmGA/Ut1RbaO1VFXyQB8jzRy
         A4EBvm27R1x61yCklD3hBYP3YEl8xLjgO3hGpFaa93wzSUGjhCk74ASX9ePfnt1xflJ7
         qP6A==
X-Gm-Message-State: AOJu0Yw6INx6cW9+/k2uzfY0JpV2aNdj55i/LGA1/g9uyOvfDTjIRHsX
	R4l5TAVJBSb6XDM4ZuWPT6xRzfyJeWk2H7ofR9ENoR006e/42Hx/qnOBGWMQmWtbhYGos9Ss2EQ
	QeAM=
X-Google-Smtp-Source: AGHT+IEJJHbd90NQ7GNwzK7jz3We2gQcoeU/8zkdAd9xuaV8q/ybA/J9tvQBrrlFpg45NfoyESG9lg==
X-Received: by 2002:a05:6512:39c2:b0:53d:a99e:b768 with SMTP id 2adb3069b0e04-53da99ebce0mr590942e87.25.1731601146055;
        Thu, 14 Nov 2024 08:19:06 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab76dafsm25510275e9.10.2024.11.14.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:19:05 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 11/15] RISC-V: Define irqbypass vcpu_info
Date: Thu, 14 Nov 2024 17:18:56 +0100
Message-ID: <20241114161845.502027-28-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114161845.502027-17-ajones@ventanamicro.com>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
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
index 7b038f3b7cb0..8588667cbb5f 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -23,6 +23,15 @@ void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
 
 struct fwnode_handle *riscv_get_intc_hwnode(void);
 
+struct riscv_iommu_vcpu_info {
+	u64 msi_addr_pattern;
+	u64 msi_addr_mask;
+	u32 group_index_bits;
+	u32 group_index_shift;
+	u64 gpa;
+	u64 hpa;
+};
+
 #ifdef CONFIG_ACPI
 
 enum riscv_irqchip_type {
-- 
2.47.0

