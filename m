Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924019CC0A
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601146; cv=none; b=DzenOYMc5CgkEThxs/pZcw4LVbsgSwR52bB5geWoaOqt4Xi4jLj/PbNHr101ASDT2ucbfyCqheyzqB6fBtq727eQCPCzUzt+H+D9PyJlwtJz2eJnKnkHFSR6HKwRTzk55k+HdgyefMaDXT0DGzHyu9kmEAxS7DQ5rp98ok6uunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601146; c=relaxed/simple;
	bh=zG8rAEuB5eoKnSaZdksATDcRCj9Xf9/S0fQz+A0rat0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+cSpy/24AqbeR6r33o/qNi/N8wgQ7oyM8DoQ+cmpIU3Buw6mvN3pTGhGHk/fLjsFD3zdTX7vNxSAb3yENJcvZNxvakd30dyCSlOjTsYMP/Mw7R1K/2Phh/lffkJgybI4KP2L7yvq0e6R1JojaHIFIRhi6EmbvwDjYPEWgTePGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pobrmIxo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pobrmIxo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so7299985e9.0
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601143; x=1732205943; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ylj9cSUnN7lZBYMxGOa796BuugfVNbbIfct9OAjDsOY=;
        b=pobrmIxohG91twGG9aDtUH13Ps0B0sH8ouUPQ9IaoIdEkDW0LBIMiElOYEAg65F1EK
         MnHzKw1L73Aec6JpugILnH5oOtgdjeLwRCEnpfNcYwr9fVP+JWh26E+9yClQJIV77Jpf
         D449yx6NEuMJXlo6xMHXpdTB079KhtsJdC3pnuuWyoSXVAhLjv8Z4TwXEPDX1nLzo8tJ
         P/75kXvFO4HCZEmocLfFDwfEK5ewZzU3q9s1QOCGSqz2msbB0wOFUrG4ZSxKrmAhEX0f
         rX88dDS60/rHdz65w7YpBnqdrhPvEv9yoxa2ePLlmxD9Cmb25iCIPr2gx2QKAzYHXIPV
         mobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601143; x=1732205943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ylj9cSUnN7lZBYMxGOa796BuugfVNbbIfct9OAjDsOY=;
        b=IQ9TqGnBHcC5cZz3R3VWDzyATutZWrFQtbl1QYPWTcYzJ/D56rw/lYnxHy+vdNyri5
         JewVFV/udINr2ovRZo2+p71U+8YAn7w8JDBVaGRx9kOxzIZkEqo2eZ0M2dSrFPcoqbna
         S8JY4A5V6NWtpYChYbSGaJHa3+8oHNgxjaT14xHTZ+brGAk+c/Joz5IVsOG79FuYE41g
         VzI8ucLgOv+Zn8bgINUAkjqTa2UFEJso9F6YR2JF0P5W/+Cit0dNGxn1FTFGUOuBWW44
         LW20ffdlKGAXK/joQxgahU0lJQi1CwrVTFxtu1fPnFwenFajxbkSXUJ4GO0R0RpKl7lg
         UBFw==
X-Gm-Message-State: AOJu0Yy7JmG/6701TBZV/dGZRGudpvdZaTEdv+GYT3d7eNek2gtJf7YP
	t26w99qLM/Ctfg4HKsYqTfKU5O6nVllG8jOFeiN6kvjg4jcCC9N3fvjfB7jQSSNgfIQ8tEA9AeQ
	aRYs=
X-Google-Smtp-Source: AGHT+IGWufmtM+epbPX600D1VFEI9w8hjUWbvA+ZtsTOBkgX8kbCaXoJN+2t/PgDnUc4rlU+m8h9BA==
X-Received: by 2002:a05:600c:3114:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-432d4aae479mr69854575e9.8.1731601143362;
        Thu, 14 Nov 2024 08:19:03 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265ca8sm28719625e9.14.2024.11.14.08.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:19:02 -0800 (PST)
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
Subject: [RFC PATCH 09/15] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Thu, 14 Nov 2024 17:18:54 +0100
Message-ID: <20241114161845.502027-26-ajones@ventanamicro.com>
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable KVM/VFIO support on RISC-V architecture.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index 0c3cbb0915ff..333d95da8ebe 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -29,10 +29,12 @@ config KVM
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
2.47.0

