Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074D185B78
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601135; cv=none; b=bn+4zOEfAJIXKeD2h/3SHDUH0TtTiXuGZjqtoKOMRoUIwp+EuvBUNz2waxsmTn+F6WrIw9MSl5n+HwC9owaLloHRlBA11TZA5/pD9fzgtIxNrm5KZygZbKJTUUzGGGxtl7kthr5zoZbmNo1iLCduJ+T2uiFHKXHIkMViMm4sL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601135; c=relaxed/simple;
	bh=NzQJBoC/AMGjdcz5fUxYJHaJ2T5WgutxrlJ2H2gtLTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2pdPjMBD/uAOiaN47XOwXNYsjfknx6k2+JtNglCU910d691w94sSHNxqpMJWvu7mUBXqLxTDDFXhrULBSUoDlufvcR5Enw9PKeQ0qcB2yb2txikUUyZf+pbiNVQj0jiDEWm+VFrsUn442H0XIq+OXWGDaojkU6SAHRzfI87xr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dJZdCAqc; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dJZdCAqc"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53b34ed38easo822048e87.0
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601131; x=1732205931; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgkdpOYsLIOn0iKAKl5fgt6eXL8Mzl+XIucJ8fWc9TA=;
        b=dJZdCAqc+tvx2QzB/UVM9qRvBCX7tw7M7beGKu541Wssb3b9abbXq6MSXRV5IKfu1j
         0OQRwmilvv8TleExjAScKhA1Q6/55aKRWCwkA7LrL48pwFAVmAGk42CfhGb6t6bi8Pu8
         1NWTnAMATNIN3dd7eWiLCQyn+TEWhVBuAwuhMaVf4XDE2kPRZ4wQ6/zpYfxZOeHjjjgh
         bsiiudQFiXK0fJFFJRRbQN5VceO/o9hh/BZAQVSRzOON3VhaQZcSKgr9wYqb9Y4Slsrz
         KRi5OA7ol9GTTHFJAbyZG5ybMOHv5WylAo2l6uhl3BNJOB4Bdsc3s8wkgqXidjNEAYGA
         ytVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601131; x=1732205931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgkdpOYsLIOn0iKAKl5fgt6eXL8Mzl+XIucJ8fWc9TA=;
        b=Al/dTwCRRRlNedd9Ruy4n3NBrppaqyHPU74QYl5PTWrEf1zb0HuiMxbLv12rZXr+us
         PXDGfoSthPIlyf3WFJpc7Y3tTxE2kS2/2pdD2j6ttg/L1MXkV+eqLhf6aDl6roYT7yiR
         sayortCkTD5ozKaRmH16WbPsgxuUGOwzP2e/5/yLLoHr2n7/WSDk8xADSd6I6IfZBeI0
         SWkxQxbU7vtBc1D1yyN9+NCZjx2/bamI0xz+9ITENQYyzgiov2tNPk3VJ+R8nPSZ04ow
         7UJv06FIkyJvn/+ON0HSdXEVwSmZJyqMFsfpqHYwzvkWORzCZfauzIIAxqPGdrOcaxOG
         gGdQ==
X-Gm-Message-State: AOJu0Yze5BP0jR5+lBoBFcpVKjV0vwpuEh20bXAXHcoJ8ZsMkif2aCWp
	W6O8lN9SH/ZaVPEoihw6dje6H7L19QVOJ2ba0NB9RVxEbown//8/R/LlczyKlH1dD30/k8eHvrO
	ry0s=
X-Google-Smtp-Source: AGHT+IFd0CnkIMN5l0Pz4D+G0QBgRZi3KYTDXcb5xA9gQJqvW8wTertCqu9+xj4IWnW1G55hIkNGVw==
X-Received: by 2002:a05:6512:3ca5:b0:539:f607:1d2b with SMTP id 2adb3069b0e04-53d862b45e5mr14144215e87.7.1731601131046;
        Thu, 14 Nov 2024 08:18:51 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1f409sm24906005e9.37.2024.11.14.08.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:18:50 -0800 (PST)
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
Subject: [RFC PATCH 03/15] irqchip/riscv-imsic: Add support for DOMAIN_BUS_MSI_REMAP
Date: Thu, 14 Nov 2024 17:18:48 +0100
Message-ID: <20241114161845.502027-20-ajones@ventanamicro.com>
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

Unlike a child of an MSI NEXUS domain, a child of an MSI_REMAP domain
will not invoke init_dev_msi_info() with 'domain' equal to
'msi_parent_domain'. This is because the MSI_REMAP domain implements
init_dev_msi_info() with msi_parent_init_dev_msi_info(), which makes
'domain' point to the NEXUS (IMSIC) domain, while keeping
'msi_parent_domain' pointing to itself. The rest of the IMSIC
init_dev_msi_info() implementation works for MSI_REMAP domains,
though, so there's nothing to do to add support except accept the
token.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 5d7c30ad8855..6a7d7fefda6a 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -246,6 +246,8 @@ static bool imsic_init_dev_msi_info(struct device *dev,
 	case DOMAIN_BUS_NEXUS:
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
+		fallthrough;
+	case DOMAIN_BUS_MSI_REMAP:
 #ifdef CONFIG_SMP
 		info->chip->irq_set_affinity = irq_chip_set_affinity_parent;
 #endif
-- 
2.47.0

