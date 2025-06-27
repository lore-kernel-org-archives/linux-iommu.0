Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB82C1587
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019040; cv=none; b=eAE/gegwiCdgsTuEnTUfydwNfAAKp0zPZ6T0MSNWeZyQk3/npyRySU23gnWJjOWTe6ovAfh1xDmfDe9nWd5shk3GeoXe6OKz51IQoWT2RGmWdQgCUtE8ddHaNfcQf2f5AXshEHO86ukXV9qgcu80pGBcCSwEG+UDFcR6cUFqDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019040; c=relaxed/simple;
	bh=3+ynpMQcTjsyaLFunYDi9YC+WhFUge4SSY1Ra3bgnMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYsfg2+P25VcOwaR8u+jimtAgQFIPa1N6CnREHNAB5WwC+JXEh+NpRWnVWJhldyAt3+PqFyg1aN98A1tHQIyLcLxDcazLMFYhlW3fhg0C0gN3qWqHpjpSx5jDHOX7GZihCPITvWejdVCr7H6R9vstaLz7soQnoFpFX4Ahz5r20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CqqrNplG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CqqrNplG"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4eed70f24so299828f8f.0
        for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751019037; x=1751623837; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TquI4kf2LD9Vztrqxbozxq9qf65pOiNFo4XcEnHd+w=;
        b=CqqrNplG8S3Roc8yqJwIwIrbjbEkpBGMPNGE6v8AETcE7+cvNkS1BgL9zOwjW4Jo+u
         FNJE7Rpq3UHJIR6a89DL+jjApk/xKG/B+7/ysRNgEjxZj0QEiP5e83lqykrHYGXNHJZ4
         Wz9FEzAl7kkrAXeP4ckZnvP4Iy58r1Kg7OY6PmLckWScTQ9k+QCpbRBEFh6xApvoPxlG
         2lTyfUDTD1Nz336axGAOhikPFtKVUERa4rskxoCzzRy1FiLn8WuEnYuKNr2RZTbceNIA
         S+VAWhaKRA5ctEz7w/1C8xVutaaIW/HOvAB3q9oh7cYCO82U3ArujjG3HDOYC8Ttd/E3
         X/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019037; x=1751623837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TquI4kf2LD9Vztrqxbozxq9qf65pOiNFo4XcEnHd+w=;
        b=rKwKj6NVkm3psZkuiGWT1Qh7hF3sbFDoZtPjPpYBRu9SX7T2zZmaT1cSJC5rmG9cBm
         yxThEpZK+uUh+GnpS5tuDSnPHbXB0g2+//Kgx+imjF+Y3FkfeIiFM+4EX1PFlmEwm+yd
         tSNDnnC/gnmqyT2hfbeQ6NxK8pIWuX1NagxNndF0Z/X3LnC/tfAbv1Jq8vwms66dOplH
         SiQn1VU7Iyu8y8M3b1Vz7+HoguXjvOgRsdPz/2s7B7F4vtlp+t8DQ6fhXwm+iWg/A9KZ
         DkXjAeyrgwzldyQedoLLCI8/Yafw2Y7KdywnQkobo5r8SpSr3ZmXTdY89691p+hTjmzi
         WN6w==
X-Forwarded-Encrypted: i=1; AJvYcCWs8vI6zHoaBI6G6kd8nVc6jxXLwTcX0NJuKCOj+9WquF9C5qyyIPr0KvZG6nx8ckbIDRxJ6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZI2SDb/jbacNB9Zfx76M5Pa7AD46GeFXFhCaVqwJYEDLFT+Fj
	+19VVq49sDMX7tEDlygpwBRBjl4WKdxbAmi3baFU2jVBu4Uv9+odS7mNAXkmz4ROsrA=
X-Gm-Gg: ASbGncvkU9gYJRLzLu4mpyygv5VMnmWHxzQWNw2x8RnnoT9rA5mp2MbvaJi0xnuSIkZ
	JiTll3SbOwmPi/4jDg5ZsUGuJqdG4Szfc84ufvCm+x7Vm5m75DqRwN28kO9bvYxQBZnL2ytW8oE
	jfvcYoHAhqfm1MhAYPtJhxfIlHemGLo1BzaEo1UdNUixv7/vDxDE3zpTlsPh2JkKBbdxrLc/5ue
	NDwa3dav0OqHwl5YhKX4TK+cfKQyD1CV/olA8etsdb354xzauvR8jfSfsEVmkMRY1vV7Gn52tsM
	R3OcMHgdc57sn+sG8uVeO5zNZgR7EwSLVzmj4SQn18UWIC0ap2JrFwsgFFGJ8uAoX6IsZYLzWzK
	0Jg1iONISk9f0hqcsfch3Vht5yYJb7eRL5Bd8rwvT/WQBMc8w2Hh2KIgwNijCxMg=
X-Google-Smtp-Source: AGHT+IErhL/Jp/Zzw50DopSUtmqu7kBNtcSnX1TVkRC2/Elb7ZST13WhfXT1w6C3WIxy5rXTNtnoKQ==
X-Received: by 2002:adf:b652:0:b0:3a3:6e85:a550 with SMTP id ffacd0b85a97d-3a8fe1dd5ecmr831103f8f.5.1751019036624;
        Fri, 27 Jun 2025 03:10:36 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e52a26sm2290796f8f.51.2025.06.27.03.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:10:36 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	Petr Tesarik <ptesarik@suse.com>,
	iommu@lists.linux.dev
Subject: [PATCH v2 7/8] docs: dma-api: update streaming DMA physical address constraints
Date: Fri, 27 Jun 2025 12:10:14 +0200
Message-ID: <20250627101015.1600042-8-ptesarik@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627101015.1600042-1-ptesarik@suse.com>
References: <20250627101015.1600042-1-ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an introductory paragraph to Part Id - Streaming DMA mappings and move
the explanation of address constraints there, because it applies to all map
functions.

Clarify that streaming DMA can be used with memory which does not meet the
addressing constraints of a device, but it may fail in that case.

Make a note about SWIOTLB and link to the detailed description of it.

Do not mention platform-dependent allocation flags. The note may mislead
device driver authors into thinking that they should poke into and try to
second-guess the DMA API implementation. They definitely shouldn't.

Remove the claim that platforms with an IOMMU may not require physically
contiguous buffers. The current implementation explicitly rejects vmalloc
addresses, regardless of IOMMU.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 Documentation/core-api/dma-api.rst | 36 +++++++++++++++++-------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 9fcdb160638e0..a075550ebbb54 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -184,6 +184,26 @@ segments, the function returns 0.
 Part Id - Streaming DMA mappings
 --------------------------------
 
+Streaming DMA allows to map an existing buffer for DMA transfers and then
+unmap it when finished.  Map functions are not guaranteed to succeed, so the
+return value must be checked.
+
+.. note::
+
+	In particular, mapping may fail for memory not addressable by the
+	device, e.g. if it is not within the DMA mask of the device and/or a
+	connecting bus bridge.  Streaming DMA functions try to overcome such
+	addressing constraints, either by using an IOMMU (a device which maps
+	I/O DMA addresses to physical memory addresses), or by copying the
+	data to/from a bounce buffer if the kernel is configured with a
+	:doc:`SWIOTLB <swiotlb>`.  However, these methods are not always
+	available, and even if they are, they may still fail for a number of
+	reasons.
+
+	In short, a device driver may need to be wary of where buffers are
+	located in physical memory, especially if the DMA mask is less than 32
+	bits.
+
 ::
 
 	dma_addr_t
@@ -204,27 +224,13 @@ DMA_BIDIRECTIONAL	direction isn't known
 
 .. note::
 
-	Not all memory regions in a machine can be mapped by this API.
-	Further, contiguous kernel virtual space may not be contiguous as
+	Contiguous kernel virtual space may not be contiguous as
 	physical memory.  Since this API does not provide any scatter/gather
 	capability, it will fail if the user tries to map a non-physically
 	contiguous piece of memory.  For this reason, memory to be mapped by
 	this API should be obtained from sources which guarantee it to be
 	physically contiguous (like kmalloc).
 
-	Further, the DMA address of the memory must be within the dma_mask of
-	the device.  To ensure that the memory allocated by kmalloc is within
-	the dma_mask, the driver may specify various platform-dependent flags
-	to restrict the DMA address range of the allocation (e.g., on x86,
-	GFP_DMA guarantees to be within the first 16MB of available DMA
-	addresses, as required by ISA devices).
-
-	Note also that the above constraints on physical contiguity and
-	dma_mask may not apply if the platform has an IOMMU (a device which
-	maps an I/O DMA address to a physical memory address).  However, to be
-	portable, device driver writers may *not* assume that such an IOMMU
-	exists.
-
 .. warning::
 
 	Memory coherency operates at a granularity called the cache
-- 
2.49.0

