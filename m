Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6C3D971
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575276; cv=none; b=CvPdB0cjAWxis7CSRyNAmoaet/BTsDO1XZ875RNw+ErrdJv5nybbFODAs8EFHIhAX4LdvpVYS41zrLAKalVKvZUkcR5Es25rlNNBNHCfxmR1CJ2YjPVGZNn1oefSsIRR2PRyxMAOjXgr5nOz7q0AVXjgysEjyh6/NkcGWmKHs68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575276; c=relaxed/simple;
	bh=guK+qXaJ8AZoVR69jRMhph9+Ra3UDqbRnwvqmJc9gsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9R931d8jnLee6X95YaWq2mE96q0nQdIR1EPNIVtIzCO4L6E6Q1kN4wSFszB/wMdnN3l3OIpNa5TsH47XfRsF2qtApsvRDiv4aL5NFOx/WxIjqJCbckMftfq3nlRkk2i9iiX3TUjheFbCVajzTE23H1a8C7yAZ/4NZLG3LQhDsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=n64tpdX2; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="n64tpdX2"
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-42102c51524so12460045e9.1
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575272; x=1717180072; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSFDj4ol3AWAL0GeTo1h24EE4RwMrFwKLsNkcBtWgJ8=;
        b=n64tpdX2LddRbqVRSfomOJiu2jW67YqWugtOy+wenDyywWrBVorbYHQj5ZH+aJzl9L
         rt9y3PQw/6JOswcMPG96AjyQMfCF6El+RbTtPHJq4FZN5qcRHj8GTHnyyLL31BJfL0iD
         h419bM9MStgwqcaS4rkw/ejgcVJLcgot73bGMwoK0PAxFpjdjb33SS5KpSZwrMn0ZpQF
         YRWSGq0Xa79+F8rWNahBfNxCUqMbw6N5OPxCZqQNj+Odo/hfbE9+0/jYiTm5AMHc51xz
         HFtLXZ3FCo3WuTrTGc9KbagiXhyXMKh9kIM8bPzJ/wHn/FCIT0PHgtOTSBm0qmwROYP1
         hyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575272; x=1717180072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSFDj4ol3AWAL0GeTo1h24EE4RwMrFwKLsNkcBtWgJ8=;
        b=RDvHmchIU6zK8d39IZ7yKL2+NeSeUuJE6aX8yh9t34jjnji0Pl71Uqnk7zWqnctm45
         irVt5929O7Z9oE9t8iMgFvztwq1BwFU3b5ofFd58SCXYAYsptg2s9zE/z+0otG+oQYn/
         pDkfV2dC40YDhmkuYS+2KmUPRovCUFK3XZYwrSBuXdetcFrkmLzp3tO2mwSupeBd9MZl
         DSIpclrvRNUhNKAnpQwewFoSn2HJNyG1ZExKdvuH+Vgb2Y47BmVj1FhviQbWxc+pe3Ko
         FzeyATCLMmK42vwU5JsWlPlBD+8PITDFTMMg1wnZPreQgwW8okTwgH28NnAeSVvrMh9v
         FUxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMyReDCuZUtgp0Mi4o/Bxh4t3nnU+kxx/NjYvhnNi2/9Q5DF9t6SZ9P6e85eSUbgBLXo8CaKB8XTt3RUwnRK5bVCYkZ2Y=
X-Gm-Message-State: AOJu0YwPxJwHLqUAYViKh8RdJW+pEYfXQq3PjdFPjcVGFBMn9SFgkcjZ
	Kj/8MnWiWHaLJkrwyNa7W9l6oDtdX40Wg4ZxX4MfmkfJel3uTRPWLUKgFHYQmkhUpEjTvSWhBYk
	GgN8KYwaMkGVJqSGg9JzKt6BZ+yne1+zq
X-Google-Smtp-Source: AGHT+IGoEzQFTvVJkKaznbn3tsRrsBHXrR2xRBfQSwJwq8OyKLj9sbB3e3hIegjaXdW0XFK+xVpzR1K4PrIS
X-Received: by 2002:a05:600c:4695:b0:41a:4623:7ee9 with SMTP id 5b1f17b1804b1-421015b3ccemr57035725e9.10.1716575271904;
        Fri, 24 May 2024 11:27:51 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4210890571asm1226495e9.7.2024.05.24.11.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:51 -0700 (PDT)
X-Relaying-Domain: raspberrypi.com
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 01/18] dma-direct: take dma-ranges/offsets into account in resource mapping
Date: Fri, 24 May 2024 19:26:45 +0100
Message-Id: <20240524182702.1317935-2-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

A basic device-specific linear memory mapping was introduced back in
commit ("dma: Take into account dma_pfn_offset") as a single-valued offset
preserved in the device.dma_pfn_offset field, which was initialized for
instance by means of the "dma-ranges" DT property. Afterwards the
functionality was extended to support more than one device-specific region
defined in the device.dma_range_map list of maps. But all of these
improvements concerned a single pointer, page or sg DMA-mapping methods,
while the system resource mapping function turned to miss the
corresponding modification. Thus the dma_direct_map_resource() method now
just casts the CPU physical address to the device DMA address with no
dma-ranges-based mapping taking into account, which is obviously wrong.
Let's fix it by using the phys_to_dma_direct() method to get the
device-specific bus address from the passed memory resource for the case
of the directly mapped DMA.

Fixes: 25f1e1887088 ("dma: Take into account dma_pfn_offset")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4d543b1e9d57..916a16959575 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -509,7 +509,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t dma_addr = paddr;
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, paddr);
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
 		dev_err_once(dev,
-- 
2.34.1

