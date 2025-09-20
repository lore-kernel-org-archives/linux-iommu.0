Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69002E2F1A
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400753; cv=none; b=PyWglaDNo66GNDOCeknrudP+Kz0K6uqry390Hf1H4B1W4JaMXGyk78Mov8oqnzz6kg7BbOj2dAsZCdUZjImXVGideuMfd6C6FbGlWBeA/mr6M86xA4NZAowGhW05ThPXwJFEaUrNWTdd9I2v+Y3AXm/Uve8czZYUV31DDUU6UPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400753; c=relaxed/simple;
	bh=4BFlmqPFmB0y8a2YMn/MaIcIOGsPHlt2XA/KAa8fqQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V76zu1Zp0d0RSUE7QwjOpCrcEUQO8X7Id9XoQtBIa2RmfXl5k9c7olHWb01mTBEwkmeA0dyGV1n/s/qxLMOkSUI+My8hTtLve48S3JPe9A7hcNSn9S/+tK13kkwbHDYe4oEzz/biE3Ui13fH558VKc1qGAuCajVpptHujI+rDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FNssa3bQ; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FNssa3bQ"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4256ef4eeebso3934435ab.2
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400751; x=1759005551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxscO8SXNrjDBekFMJlTFlhXiLgQFfajmO2RZqDfrAU=;
        b=FNssa3bQGsFXpt/qfSdnFqV3cOGtL+aLhO8FzGCqgktrK+QzsqX2Xccf9ITRWM98bH
         0XRaFUrnn1b/N/X5gmWruxkAZYGvEWP6/niSidtPFG/KezHlox3jbeP3mkNrriLQkw0B
         bQnRmnavuTaLkhIJ/CHj7f7jeTiZQQ5B5gykcT2VxCJPMlQSs4/4GLFC3zKqpsm6Ts3n
         8QV8O+HQMSHXLryN5AhtvRccLhamFNN3vpk4CTL/rtCwhVQL8v3n481OawS3NNVsKC+i
         ltCTk5cdazMPEBZUHQBuE+uVhubKJ1Jv558fiSfxafNdrTQsupslwzRP9bGxq4TCOJRm
         IS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400751; x=1759005551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxscO8SXNrjDBekFMJlTFlhXiLgQFfajmO2RZqDfrAU=;
        b=eJ4vWHPryN7XUi13rznW0i130M+tEWie0KbyzutGqthRk4HepQDwxu9KTS7j+YEUG8
         mYXZ9oRjNqvNxz3/oyU57f7Gs8Iv7vUcDF+OswbStUuT407G/GCiru4F8h0Xr7+6ZfIa
         qvturGsJsCQGdHr4DgGkergzYF520OtrqtzFawX1C0w64q4ptPX0lHqylQQy2/q2syz7
         qyxEKEGU3+2MZQh11q5HIrnITtjOg1nCNkzzLvhBdlpiw+5ISXnPjJTSqu6sMrMBJAcA
         QnyRRcGJ4k/i5S1RSqBv6tHRGmMf0S0k1JG5usxow3q6pW6zlN50c7XslC0WvbGIKqAo
         rCVw==
X-Gm-Message-State: AOJu0Yxfcih0T7pVmg8cZWLJjiXOk/IVb41alaLdzDefrYtDe6eOQAr+
	EdeCVMkDTWCywKMJUnIHYPyApkIrzhXMteXimjdbKtegRLifhp0UaHNexVJ0vlxdwEzP8nsP4PG
	EcHFa4J8=
X-Gm-Gg: ASbGncuauCWM+fYnNDWbsBalOiBSICPx6EzqRA1vw8QTKPnEMHzU8GMaQzAy6YH7bMf
	r+GpSr57H43KHwIH6Qtu6J9mPAYX3KFcM1uEgEgBz7JrNLDM73Nj9xahJkjUgvzRecPzaMVNSXE
	stDSOpFzEJD81ZvQeh4vY8tqnMOfh6dbf/fT36V/8M24uL/xDKr0o3xPn6KMKe6UPPhA0nJpe3K
	q6r7Nt9FQntLi89OZAz+SGPnwKVABYB+LGu1Auys7m3f2Xvo8lw9UBVwFYxAaWkOlU3TnaWZ9jW
	+d0t5kEvYjQtzTo7JDEZT3zgnZEUXH5n1p8tNt2QabC5Sz1CLLFPyPhs5ID09Ro6soEiEYK8zbw
	UBXMjWMP0nB6TjD5a4FBLzmTO
X-Google-Smtp-Source: AGHT+IERpRPEc12mV955tvnuQoeNvkZUC+MN7EtTp3JKXd3eHnM2oBc0U3F0kWPqnL99WZIdHZ+AuQ==
X-Received: by 2002:a05:6e02:1d9d:b0:410:cae9:a089 with SMTP id e9e14a558f8ab-42481922e1cmr116891435ab.2.1758400751055;
        Sat, 20 Sep 2025 13:39:11 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d56e429f3sm3768486173.74.2025.09.20.13.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:10 -0700 (PDT)
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
Subject: [RFC PATCH v2 14/18] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Sat, 20 Sep 2025 15:39:04 -0500
Message-ID: <20250920203851.2205115-34-ajones@ventanamicro.com>
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

Enable KVM/VFIO support on RISC-V architecture.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index 5a62091b0809..968a33ab23b8 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -30,10 +30,12 @@ config KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
+	select KVM_VFIO
 	select KVM_XFER_TO_GUEST_WORK
 	select KVM_GENERIC_MMU_NOTIFIER
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
+	select SRCU
 	help
 	  Support hosting virtualized guest machines.
 
-- 
2.49.0

