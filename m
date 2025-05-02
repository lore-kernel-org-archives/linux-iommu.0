Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85424678B
	for <iommu@lists.linux.dev>; Fri,  2 May 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180075; cv=none; b=iWs1B19uC1zQuZJzVEfCfjZmEpD34RkY3XyJKlOfVkll1tTxzC7VBtfYUjQsxI5XAwYAkvoxRvePNEnKKtxObRqPmI2RLqr4Y4wRq/y1ABKqf/HLzIynpVuew3BpSG7AlhEYLMrvBxMY0T2U/QBTL9BzAVhkFv80/Eax4azlOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180075; c=relaxed/simple;
	bh=JBFJnBv1Vm67I2drd1XhP0qbGY0AFjAC5ZYn7HBNfWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMZq3h2oadXQcZ10KXrRum1lOQB/MqXdW2IlP0o9NYxAFZsDIXsPuRqeE3RQLF+vJyAhpqaq2hVQpXnZu1wpi+LhMHKyIyr0VmU2CynVie46fe48DFBGipameNTcMye+nZjQiz0X3hIU//EjS0flGDuo39BjyuK00o+UdB7f4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ElKzkIdD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ElKzkIdD"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2c663a3daso345706966b.2
        for <iommu@lists.linux.dev>; Fri, 02 May 2025 03:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746180072; x=1746784872; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K96TP7RufWR0A5oYw5jAf7HfaOkuZ/rMipxLAIxdi/A=;
        b=ElKzkIdD1G9ErfLMWozMghf6DVVX6aKeEOKZKKH13dv/3gtmWubCfG1z/ww9GJmLap
         76mDJTDYPQ6oh1XA83VxZ1kpwbKi15Z+aZdZdoM54zIzRZi/3SaddIHomSilGXghexDG
         D5pLwDwhJha+pEhUNv/Xvsw9byzo8n3q6s0GFU3xP2304xHI38NR4I57l/zfORJGv9XA
         duBvIJIGw/yGq6x1onhbdFv5C2/gJ6YmFYkDLuLFpESlXEbVzXAPA2pZ5Mgh9rrY7QV6
         KLByZsguFHt4EJrVOHlLhGueLK67vL56CBonLMVG8hYerf2QwfCwYnJL2pjpv2/F+jiF
         pZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746180072; x=1746784872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K96TP7RufWR0A5oYw5jAf7HfaOkuZ/rMipxLAIxdi/A=;
        b=TtYXmiiseW8k4fa2QYRKitKr3p3Juh6T4WGajzZirlO8trQtPc1wl/Ke7MORex7+La
         Hi9tDhUA5rgAINHOZELjX6N8yjrrrbRSd0LEqPYeaUL52WCOL7cueH5b9PJ5rGLiWQkh
         EMUGcT4Yp6NK9704+nXEDAKFj3s3s+mlozTc2EhmArqIdvFardqUwdgaSm9OXj8sBV++
         HRLREKHEU9ag3ea2OE8Hq80uc30+a16cD0wuXHrnEpBLT80MLpCiIgddWyQV9fKEztPv
         wxa+m7bPUjqRtKn0VK/ZsJoA7icePeye8MKGOOpIHz09eZYuC5U5X8lSRMbuWOAUOs5a
         AEww==
X-Forwarded-Encrypted: i=1; AJvYcCUDY37Vl0cezgMt9q41eEVFiSitdk9dnAY+7i6JRw6SUdxWzu9awNTGsIKFCYxMqtz5Pkvlrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgpBJt4Qi7W79TweqE20FedY+rUzbAkTGuxPHutkNxjQU7oOYF
	x3QedNMuyWKKS4fmQHsXInchl212A7pHT3qhx8c0IkWYUA50b6xCTV2OgG2i1HY=
X-Gm-Gg: ASbGncvdUJggKJxupAzj4QttzjiNFvFv8IBlYBInrErHP0SK/Aj/Top+0QkmO/yuZT0
	PfqtvPrR4nAIfFaZy6VewAMX/RX1wdSctsEoDuMB7xDvfgmO78aaQ04VnC0JCzRihUaGsd+5nVe
	hFSkSbPMiRCwPYFrcfw/iFtWxxT2nLa0dMj6FDfUp+xpUGroTospoC/lYTVAJ9sSkzr8QpZesG6
	HZeRGIeFAIlarT2AIjVpeSqyYpSZvfsDWAs36n5kTFTohBdjIDKyh9z+iXMoHImzzvj7yuWnZYg
	Hpc/6M+dFmBFKpSfsPpAovVrZg3GY1Uwf4uqaCuHmgwJF6N7mhcnG/U+pd7fd8TZvwOazxI+VNP
	e1vWHgmrI1eJq224rup12EOti9bJH
X-Google-Smtp-Source: AGHT+IEw/QFZ4Q15wjtCZMc2Ys2EDGftsTen4aFJcOHmrUkANvg/HjzdHRZE7b55C3GGic4/3YhYzw==
X-Received: by 2002:a17:907:74a:b0:acf:15d:2387 with SMTP id a640c23a62f3a-ad17ada7132mr232347066b.19.1746180071962;
        Fri, 02 May 2025 03:01:11 -0700 (PDT)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891473a1sm26030566b.4.2025.05.02.03.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 03:01:11 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Cc: Olivier Masse <olivier.masse@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	azarrabi@qti.qualcomm.com,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Daniel Stone <daniel@fooishbar.org>,
	Rouven Czerwinski <rouven.czerwinski@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: [PATCH v8 10/14] dma-contiguous: export dma_contiguous_default_area
Date: Fri,  2 May 2025 11:59:24 +0200
Message-ID: <20250502100049.1746335-11-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502100049.1746335-1-jens.wiklander@linaro.org>
References: <20250502100049.1746335-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export the global variable dma_contiguous_default_area so
dev_get_cma_area() can be called a module.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 kernel/dma/contiguous.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 8df0dfaaca18..eb361794a9c5 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -53,6 +53,7 @@
 #endif
 
 struct cma *dma_contiguous_default_area;
+EXPORT_SYMBOL(dma_contiguous_default_area);
 
 /*
  * Default global CMA area size can be defined in kernel's .config.
-- 
2.43.0

