Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B097DA6D
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601131; cv=none; b=o9aBvs6SvSOeJHMzwG/BiYSCNGY7gBU/Ow9zMcukle2IekdvkAcBLBZ+f5m/8IqdQTZ3gaa6KMj1qMb/MzSO57UGUcVU/X1r09wm2sET+N1x3OXciCRBiUsPTY+Eq/AwkjlVMqWcsyjeKKwyR3+YJHauYh3EH6vcICB8Gwj51CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601131; c=relaxed/simple;
	bh=g+8C+bxaMal2sistKMy08AprWRr5v1lTzqnhoi4uxEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLmLlwgjvJZUrbL0sOhLgGylggVnnTCm4U1NNBMPEl6q7H6B6fSIkF2pH5ZjGcOvbirjUCz3xKrWALrT1kNU9hre20ntg4CZ85wRr1SG9mh+NmiEcwbLZ1jgtMfkJ6m8Bz20hITUqNQsC+yr0VtDHYHoknjCKRUUvsr1KO/sRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hjRMBxKA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hjRMBxKA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so7765355e9.1
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601128; x=1732205928; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3ezq2WAE13GAqwSlX07T0LyNCWtPpuH6EoHFe0wCHg=;
        b=hjRMBxKAYFZY6vC8I0v+QoVunIQW2hw9ia8LhEfDAcUkRWXtoS1LTc0yYwM6vw5NSy
         6ssbNCQ3B2CNHxCNYePUu1LqzaBuuY7OL9uuzbPAkIin83SchPoaLG6ncXERrn7frmtX
         fPckTbZSsALbzClu/22L7IIk/gyUhZiAW0Tc/ESLZl3Wq/fpP2abmd0W+8YZj7xGTTxO
         PJY82XzeHJbCGCbx8ZUbhnrh9m6Vl3iB+wzCaO9coSi0BL62iG+VHZztzbKoq+TEfteO
         S5EhjaVQpEMylG7MgX91OoxslpwGaQlOVNqa4dMeH5aI+b52OUIDWpxgIp5WPtnuLn57
         jhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601128; x=1732205928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3ezq2WAE13GAqwSlX07T0LyNCWtPpuH6EoHFe0wCHg=;
        b=B450TRU6EFYrjQymjx2Ke6dMOlHo53CIovN41DJtYRyv5SKnxDHmqmBLMJaXVb8EeU
         c/BYaoiTulWbExuz7FDUN/8qajZuR2qQBDtW6l/OMedDa438dP84J3XYMNj7BZPhM6+0
         81KD1+RQd1r36igwRxNtW6ZCavyJ0vOz+ZT/k3OqjnUT7xjvrUSd0ue1Cigzl432pa3B
         CX2ZMDEuzRed7x7hAussKH/rQEH4DNbpEUcDaVKoJNNVs5VgxZ6mAbMqEZrb65L5Wuo5
         O92fYcty0ChjXOQu7bQtJAx77la+k+Lb90n/RJcaVdc3mGOPIxqI5WgOCbHQ9GYKsCDT
         D2cQ==
X-Gm-Message-State: AOJu0YwPwADyzf6PFUDkBDU28ozM0I6ttMmeSw3HJslHwdHmv3s58rnc
	Oq+rzzXigzJYQMRoUc38kuNtvrRsEzJJjSgG0th5Lm0bmCX2IPCDu1e94BNSCc09k05UaUdUZiz
	Qrrs=
X-Google-Smtp-Source: AGHT+IGL/aKw/LZ1JTJ7uKMa5kImPbRP3wDn7MPyUSWssqMaT5McjPD8vLFqR2fLEptCKYdvhP3z0A==
X-Received: by 2002:a05:600c:1d1c:b0:426:6308:e2f0 with SMTP id 5b1f17b1804b1-432da7cbcefmr23145865e9.26.1731601128138;
        Thu, 14 Nov 2024 08:18:48 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2800absm28573255e9.25.2024.11.14.08.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:18:47 -0800 (PST)
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
Subject: [RFC PATCH 01/15] irqchip/riscv-imsic: Use hierarchy to reach irq_set_affinity
Date: Thu, 14 Nov 2024 17:18:46 +0100
Message-ID: <20241114161845.502027-18-ajones@ventanamicro.com>
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

In order to support IRQ domains which reside between the leaf domains
and IMSIC, put the IMSIC implementation of irq_set_affinity into its
chip.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index c708780e8760..5d7c30ad8855 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -96,9 +96,8 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 				  bool force)
 {
 	struct imsic_vector *old_vec, *new_vec;
-	struct irq_data *pd = d->parent_data;
 
-	old_vec = irq_data_get_irq_chip_data(pd);
+	old_vec = irq_data_get_irq_chip_data(d);
 	if (WARN_ON(!old_vec))
 		return -ENOENT;
 
@@ -116,13 +115,13 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 		return -ENOSPC;
 
 	/* Point device to the new vector */
-	imsic_msi_update_msg(d, new_vec);
+	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
 
 	/* Update irq descriptors with the new vector */
-	pd->chip_data = new_vec;
+	d->chip_data = new_vec;
 
-	/* Update effective affinity of parent irq data */
-	irq_data_update_effective_affinity(pd, cpumask_of(new_vec->cpu));
+	/* Update effective affinity */
+	irq_data_update_effective_affinity(d, cpumask_of(new_vec->cpu));
 
 	/* Move state of the old vector to the new vector */
 	imsic_vector_move(old_vec, new_vec);
@@ -135,6 +134,9 @@ static struct irq_chip imsic_irq_base_chip = {
 	.name			= "IMSIC",
 	.irq_mask		= imsic_irq_mask,
 	.irq_unmask		= imsic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= imsic_irq_set_affinity,
+#endif
 	.irq_retrigger		= imsic_irq_retrigger,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE |
@@ -245,7 +247,7 @@ static bool imsic_init_dev_msi_info(struct device *dev,
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
 #ifdef CONFIG_SMP
-		info->chip->irq_set_affinity = imsic_irq_set_affinity;
+		info->chip->irq_set_affinity = irq_chip_set_affinity_parent;
 #endif
 		break;
 	default:
-- 
2.47.0

