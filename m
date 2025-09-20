Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5B2E0B5C
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400757; cv=none; b=GYSV+2tt0EwKzTZdXBws1cJMc6qGx001o3GVbsqTmJo8eYp0B18dvojHqHA5oBiq9U8pgCk6gXnVQMoZuNDZdYvw9M/x4xN3t0uZvQ1870Ic51fEZQNqiF+Gzm9bhYDgpq94d2KowTD8JVZRE3jCydj9Fuz8DxUTcrXYwVAnbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400757; c=relaxed/simple;
	bh=E+sSPT+kUSejcvl41Q1TeDzQ8VYDhNgMKLADnh8bTf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ai+0G2i+aiNQRK0oLe8ovZt883eFa9dTfYMpD4SvqS1lbevxAFcd8qe1BVwjLRZIK6dGDVE1JSj7gHuKW6cWsobk4ixAyJgFB9ZbLjw3Rx9VZ0mZtz9usNDBmtQfsUYapFUw56dTUdynySnxjWaGWR0Jan81s27yifciFiPvJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=M9mGhMC9; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="M9mGhMC9"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-887745ee814so105355339f.3
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400755; x=1759005555; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhgo805sVSiR0SJlmhLHBR/NhPzSwBuZgQ2sQCeXYLE=;
        b=M9mGhMC9hbnMuEMZnVsWGoNiXRoCUySDZZE1xhaB+0VMURrNu1e+etdQnb3eclDRoc
         K6xxGRarZUbPCbdVb0/Bnry0f6WTGUm5ggPDkt9RLUIc+cy9Wvn+AoK2Pi8XRvSWNDDU
         neykysob94MC3tXXvab17JPAWfiMawgFYqUElP46efyNt3u//57WniATqe08SO/KotBE
         unvJmqWnt8BC0XYcmOy9/ygae9GwdV7mKZrX5SmzJ1wuL/c7GwZTopWwDwmhrcI7ZG0X
         SRuGuDC84Pdmmt2uc6veKzpyafNtgeh8+hjxT1pjaxw8/Pc9HhBrr5MZOpkRGOE+7Q0O
         82Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400755; x=1759005555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhgo805sVSiR0SJlmhLHBR/NhPzSwBuZgQ2sQCeXYLE=;
        b=A9vwP1WOwX/Tj7xqCivGAHjg64IFmCq+xCnOK83F+zWgaXdLoTm9uYSTKjVzR/GOmY
         AC4UPhlYJbuSJIpDVqMiU/T84qTKweE+O/MP9hyniU5EpboXwngaeUspJHctsP6ROjBA
         1DesH3vgRoyDuakSnKMC39PbPVdoe2jqZDMk9NwThasrsRZDuljrtNs+f86O/Mrc2/2C
         nYVeXS+aGhl9TbAndYo0S62zY1E085BGuGCeANvUqDvo50Dud6E2yxu8aYO8ovXqc8DX
         Iud/qKkCA+L/QB8/vVGQpaaPDhWCDgY8PbNAVXqTCci7nWhtevtZlfW56coz3p3gSDlo
         HyTA==
X-Gm-Message-State: AOJu0Yw6fFL2AA8JyjFnwzcXyuv4ngKOX7HlV05167gKPygsojH+7TD/
	MfNr+00WVf+4F67Y1BCwWpHNqJTaZVOKyQQ7iL3+vxF8Hkfw0p5Fl81GLjETlai1mhqlDj1asPf
	yxBzr3YI=
X-Gm-Gg: ASbGncuHeDJbUR4CNVSg3HKBRefIKigiEUksM16L4tPvQpbqv1KQl0nVaWUSdgdr0Mq
	v7p81oHLW/ykwgx82ZCuyDbm5VGj5ZnosdI005DJV13y+O7czLC/9ACTcqM23O+uMuHERfoxA9P
	6Dp90R5SeWyZs3UFu7lRyuTtdeC4REZT379Wi+yIWvop3pprgYbmXMFCKFpddSLIEdd8OiivkaH
	BKJ9UVIFu5b+7NQh5LwzIdvqUcYdK2rZX1uklcvdEwzsGr8shnRRtOAc73ZI9Lijd8LMEQBflLf
	iqGw2+o0b3GwndFxTqYuw1Pziw30rK19IX4ws/j/jZNaO8h7hrHFyI8/R09zrzTSQ8r2eU8L4bd
	850QiO0hCYUBTuKQ5EAXsYdx0/VFvIeKPGgo=
X-Google-Smtp-Source: AGHT+IFpmX9UAkdlqyKeAFy3AzOo21LtEJum96Rzv+8iJlkbfeuTwtEuWDKpDYd555ixOqfVlv44jw==
X-Received: by 2002:a5d:8791:0:b0:886:c53c:9175 with SMTP id ca18e2360f4ac-8ade08247f9mr1118249839f.16.1758400754919;
        Sat, 20 Sep 2025 13:39:14 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-54cfd9b688esm2100997173.84.2025.09.20.13.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:14 -0700 (PDT)
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
Subject: [RFC PATCH v2 17/18] RISC-V: defconfig: Add VFIO modules
Date: Sat, 20 Sep 2025 15:39:07 -0500
Message-ID: <20250920203851.2205115-37-ajones@ventanamicro.com>
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

Add the VFIO modules to the defconfig to complement KVM now
that there is IOMMU support.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 7b5eed17611a..633aed46064f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -242,6 +242,8 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
 CONFIG_DWMAC_THEAD=m
+CONFIG_VFIO=m
+CONFIG_VFIO_PCI=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
-- 
2.49.0

