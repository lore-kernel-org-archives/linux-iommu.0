Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5A1AC43E
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601155; cv=none; b=KDdhLuvLWXlJQL5FOoRMFIPRLzFI04YrgghaEzlXHL9IF2RqrFJbOCSffr/10SKufNh67/mFHCbTujexVjlNJjNRtG13vX1KQDkMxKGXRpPkK8taXzeBkT5lOd5rAcXqbeR6RpNv+k6wemI2eEdxWDH8d0GT8//YZ1VYz04c3Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601155; c=relaxed/simple;
	bh=nPnauxX7TiBvZUSelznoj4ZrHIzLIbMVHtA1EyH4RVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJm/ImB1izp2K2Bc5qBZVWAfB/pnBkNwYSG82aDSZUV81v1FBBFOQOTP6dHIs2nBTMXcAsfa46PVZVDIRrIQ4B0Dfz8+AnhsHsEY3eu1jhRwJslXlfXuSPKUTFVNg1AqFd1lOaV6tIk4QlAKlP8lsVUDFYqUxZzlQ8EtxoTD9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=K6fXpGAY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K6fXpGAY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314b316495so7194865e9.2
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601152; x=1732205952; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLyjPEUjYy3GGHllbim/73zpVvmemz3R8H3vfZF+LqU=;
        b=K6fXpGAY49fbgoHRnZFvp82bVfQkycMO/c0iG3IZxvvcB+ed00sTPqj8NBbuvKqgJj
         20vHQ0CMpw+o3foiDkm3zTyCcmgrj7dJIWfb4DQZbuIOrwKzbLopWyVUw/vl2/RfuuO5
         UEKreBg2BlBoWKx0GDEwfxGffms+nFEQH7JETSdn1k7FHAqrs/tGsQc10bgdQaK3wrpp
         srBi+f7jFD1ZqsJF8NeSyMQVzLADr0Ejwmm3OmcnStvpu92jgaO9YYUnTjckVdGREmHI
         Y2bqJPNBx/2v4btrMlbF1v68tXA5rQF6iUNpbXPqoXFsP3o+95vTYlNnbDN8ff940LLH
         ZYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601152; x=1732205952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLyjPEUjYy3GGHllbim/73zpVvmemz3R8H3vfZF+LqU=;
        b=s+BvM+q10a+y1nxuiBxjtS3Tj+YUjn6X9J3x2Kb6O0n5dZYc8ZYKgIZVn0oWee0hFA
         +EzQrqTX10qYXdKXNhO5Ofkqoo+Jr2c0bPvPt2fHO/gnFT+QERLpkbhizoGzIpKqEriz
         e39+O+OGdZSZHtPwKmA0Oi8CAac9c46DHYfefkRoeiEWVuTdXDgpac3cg1mTwG4t/Xcn
         uduvA5P50FF/2Azn0uqRcNi0ML7iAd7su4Zgb5wUnkzcLn7iSVMB6RD1aY4gxvCA8hNg
         PjtQLVCpSYCYJdhg91EMak+r33/Pa9oC5nhh0yY4TdTMfqkzWI/4juc8HHyg+PZo1oY9
         0wFg==
X-Gm-Message-State: AOJu0Yx/i6ScMZkzM8c0ouUqLI18pXh2WAo+RbjS+F4xeqcTrAGLt5Ht
	+p2pyi855/9N9IS4EcjgMqs3QH0j8N0OEi2U/ibqOodkuAdAhdGq6vgygXnd6+t9TrqOt4GgXeL
	AuDI=
X-Google-Smtp-Source: AGHT+IHKQidNVhwcm1UkvoSFM0iFKvguMA4Koj+yRoQBZD+zU91sO767fbB1E85gsh6vbgzv0SLQ3g==
X-Received: by 2002:a05:600c:c08:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-432d4aae6b7mr76573235e9.10.1731601152220;
        Thu, 14 Nov 2024 08:19:12 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298a41sm29066525e9.38.2024.11.14.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:19:11 -0800 (PST)
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
Subject: [RFC PATCH 15/15] RISC-V: defconfig: Add VFIO modules
Date: Thu, 14 Nov 2024 17:19:00 +0100
Message-ID: <20241114161845.502027-32-ajones@ventanamicro.com>
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

Add the VFIO modules to the defconfig to complement KVM now
that there is IOMMU support.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index b4a37345703e..10fc9d84a28c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -242,6 +242,8 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
+CONFIG_VFIO=m
+CONFIG_VFIO_PCI=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
-- 
2.47.0

