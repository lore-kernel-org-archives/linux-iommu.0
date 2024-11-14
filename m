Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D71AC882
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601153; cv=none; b=bBPkEIEBFuwMssmKQ3+KRBQ28BGjVdUyrYtcB6uGpmxjF0V/00q30huyX6YEaC3EkkAuYDSJN2RSx1i2LTPKE6eE80okBPAabph13c3kJVobDYIKpXUGKpiY2zrWnClz/1966dYNtckl7xuBVpuzfWIZv54RNFS9faJvPKJ2f6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601153; c=relaxed/simple;
	bh=ES0TvAxz9/x2ptiDnzIz0eP+Ou6/i+zYJHVn+dCYtjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOmOlweThrFJy6Tv+FcTlzpZ6b6Hpn5yHGtuWlTEgT46SKBYJaIVysVDWsAIUZ3j4wsx08gL4VJy/JjHoXLRCj5xbMthIWxdiAEWBEtygI36jI57OoR5lqv104hw+9Ue2k97IGm6hwitHxbT779RLjLWW8DJGeDbG938BWD0a3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iXUKlseL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iXUKlseL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4319399a411so7615035e9.2
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601150; x=1732205950; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmqNGe/T2iE9PlV9lB2/3K3MC1TQA7fI1NussKF1DE0=;
        b=iXUKlseLP1YdZo+lIIebuJooslmyWNrk05emlz13gdA8hGCbhQ6yl3pB1nmVzPT0ye
         4ml9ZjVjiIvtldZPXXZTWXM+8bR6KN/+EnNQw1YbC+KR5RwbFJj7NZC8I2cAMNGg91eI
         J+AsJ9vtpic+0MBzVIlujxHp/qpODnMyhTvvPFG6xVJcgHjuRXIMGd15EY8D4K+oPy9x
         iRfUd0XLf+rGSfIScLjBtHV7wgddw2VdGMMeTb/0e//JGAhfaDYE2NwdQf1LngbkhHQO
         ojVQBZ0YQwu9uFd8fU0c4QmmGRYP0To4bxY8Y5psIAxegP40inF2UPCujjDXGlgBSpu+
         rsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601150; x=1732205950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmqNGe/T2iE9PlV9lB2/3K3MC1TQA7fI1NussKF1DE0=;
        b=tpVVmkSa07TyVoIokoONIVrFTaz6/T364LOLRgFuYefWGcWumPrJjxV8am/oQdhtzj
         w0R5lo1bLymaN2Lj43wnQZdPu6QjVT2QWtvrJd4dmw6N2ZFjccRISxghTe3GwyCuViXi
         egHv+02Dh1ElzNys3POzY5c5sBkbwgOjyOgpsApxy59SOLAutwDyQjDwTVtl6CHYcvYL
         j+UPj+gWe6DH6mApyMVUGbskyTZDIyOWV2XsRCkct4yr2NU5ngGakjoJlNZauVfc1Fq1
         qkAQMRpN+5I2DHvKIzIIjjiKE51Zqy0aqZxG+VvloJlOGE0/ELxSnKpRqe4BNbDTvmgG
         RAIg==
X-Gm-Message-State: AOJu0YyrlU2hUXLcfU/HMf/x6dKyGn04lW5ZHAL8ZIVDdh9dylmFUYFp
	XbJmlgHLJSiE1a5lQu6+aSWaBI0Ts6fTCLLl+kz4h89MxAAS5X383GirdADeFIJMsM/DwGCky5B
	WQA0=
X-Google-Smtp-Source: AGHT+IGMbtDDWmvKWsj/Ybdc9TgUB55aFH3ajhr0ZnMlCbsRayCj2n5LaLaeoDlbaJzuEn6VOd9B/g==
X-Received: by 2002:a05:600c:8715:b0:431:93d8:e1a1 with SMTP id 5b1f17b1804b1-432b751bcc2mr209410385e9.27.1731601150428;
        Thu, 14 Nov 2024 08:19:10 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbe779sm1834550f8f.60.2024.11.14.08.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:19:09 -0800 (PST)
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
Subject: [RFC PATCH 14/15] vfio: enable IOMMU_TYPE1 for RISC-V
Date: Thu, 14 Nov 2024 17:18:59 +0100
Message-ID: <20241114161845.502027-31-ajones@ventanamicro.com>
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
2.47.0

