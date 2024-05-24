Received: from mail-wr1-f97.google.com (mail-wr1-f97.google.com [209.85.221.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54743D3BF
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575282; cv=none; b=Olr7Aji8vuf60CRKzKqA5R1ZZavM6rnSGUjahzhkphGA76dz0/R/lXZgkhYejxATV/nOS9+HcPvMHwa+9FeU/pAaZeoFyTCnbBNsZPE0yS3aXq9BDv/Od7UwnF4kFIpkb+st0BDXVsirWF+hiP8AqWyi6PJs/AbntmSb1gHN4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575282; c=relaxed/simple;
	bh=nfU4i7o8p143//pVAQIuLJreZUHivVRGYWOYdCfqYIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZWSW2vFTCKtpZc7v//TmBK6BJHkmhfaLLyy8fDAQY3wT88FE7HYG9Hxa2nfn1lDZ+R3Ndg1YmvNNgXmq+yawe0+sz23MWOJdaz3Cy+etXPchwgdNH3/i20LYn8lhwXtf8oItFuByj+GyoJnXs4wKBqrGEMRanp7i6Zlc3AWUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ckATiP1S; arc=none smtp.client-ip=209.85.221.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ckATiP1S"
Received: by mail-wr1-f97.google.com with SMTP id ffacd0b85a97d-351d309bbcfso2341197f8f.3
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575274; x=1717180074; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dAf5h5XwHiWp+dmoS6JsUC+O9MVsTne143uCle/zUc=;
        b=ckATiP1SGLZyiouxNgKqR7ZWbyyYl20hU35aXiNM7thYYjyjr4x62wTfH122zsvL/2
         sjBJIm0lWrmWJe57MM/UMlK3+iB2+mDT1aQLAuGQzVUk7L+DyrXvNqVr6cbhckxPIguu
         OppLIuAfAbu67SKFb4932ieZilCoAB7IdmhHmGzgfmU8Lj9peL6qt3ypue21Dy7Hqxh9
         mMbhlpMI9EMoIz7edFQ3Ssx+74Syd/Lc7KaYzjNiYYt37VUt+80EAWjdKEA/2jhaZNJZ
         C3xtvquZvigNZsViMxQMbbAgBfoqDcZ9qvRYpjBv4Ykkww8ebaed2rPz3emtUwA52wcx
         C1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575274; x=1717180074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dAf5h5XwHiWp+dmoS6JsUC+O9MVsTne143uCle/zUc=;
        b=wtWGkR+hiDkWfBGvqlOwp/K/LTofF51yE6QoOlVbxZxQbvhwI3zzA7RmVpRdVbbkJ0
         dTOq86JSymmj2hX1GKzLgNQe+1ihy9a8cPFno/KxR3fAiCt5aPK3u8J+bKgVoOrcoqne
         XdhVDkSi47KikpLZBA52vvJ9XGprypX7FFfr2ibophQ7Dk095sXvIX2WCH94pl0ANgkB
         8sCm4F8cezKIZjy8NkMbZPFcgstPyHgonTJKowcx8MKXqHhw0+wgVjFpqPqNpyrQE0Gi
         R4Yc/lekmj0Asn31CQznmml+gf3mAl8J/rcU9x0Vi2MvwKfGNd4USc3/R4bVc4VkiYSQ
         ItCw==
X-Forwarded-Encrypted: i=1; AJvYcCVd6gYBsgIoc3mBTeCsL1ALdRRR/MGTwjl56Qk4tLsqys4vT8VBpyWo0mo/s0b+VSvjHTjTphz6MH4EtCvTqnjlqpTOIE8=
X-Gm-Message-State: AOJu0Yyu+2oO4ZnQ4HtNIJFEe/or18yM1zTeMlDhL7wCHXlioxC61K10
	WMEDRBsXphyWZ8bbZa5fuHsuUiyIU71YBC35IUP/gH/izoPinyLhNGO8vJ80FpnNk0a/if6xCIG
	AF11sO+GW4kv6Xlf4lZAYlmC2aJUiywR8
X-Google-Smtp-Source: AGHT+IG7AwSKXGWwm3Jk0PS/jS/c6HEpbiqG3nmvQrlTW240Q10yveOxPP4at4VICqmuogqReFECxtmY3Gqc
X-Received: by 2002:adf:f746:0:b0:34d:bab1:26eb with SMTP id ffacd0b85a97d-3552fe17476mr2052052f8f.68.1716575274538;
        Fri, 24 May 2024 11:27:54 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-35579d7c6bfsm65665f8f.22.2024.05.24.11.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:54 -0700 (PDT)
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
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 06/18] dmaengine: bcm2835: make address increment platform independent
Date: Fri, 24 May 2024 19:26:50 +0100
Message-Id: <20240524182702.1317935-7-dave.stevenson@raspberrypi.com>
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

From: Stefan Wahren <stefan.wahren@i2se.com>

Actually the criteria to increment source & destination address doesn't
based on platform specific bits. It's just the DMA transfer direction which
is translated into the info bits. So introduce two new helper functions
and get the rid of these platform specifics.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index ef452ebb3c15..d6c5a2762a46 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -252,6 +252,24 @@ static u32 bcm2835_dma_prepare_cb_extra(struct bcm2835_chan *c,
 	return result;
 }
 
+static inline bool need_src_incr(enum dma_transfer_direction direction)
+{
+	return direction != DMA_DEV_TO_MEM;
+}
+
+static inline bool need_dst_incr(enum dma_transfer_direction direction)
+{
+	switch (direction) {
+	case DMA_MEM_TO_MEM:
+	case DMA_DEV_TO_MEM:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
 {
 	size_t i;
@@ -336,10 +354,8 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
  * @cyclic:         it is a cyclic transfer
  * @info:           the default info bits to apply per controlblock
  * @frames:         number of controlblocks to allocate
- * @src:            the src address to assign (if the S_INC bit is set
- *                  in @info, then it gets incremented)
- * @dst:            the dst address to assign (if the D_INC bit is set
- *                  in @info, then it gets incremented)
+ * @src:            the src address to assign
+ * @dst:            the dst address to assign
  * @buf_len:        the full buffer length (may also be 0)
  * @period_len:     the period length when to apply @finalextrainfo
  *                  in addition to the last transfer
@@ -408,9 +424,9 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 			d->cb_list[frame - 1].cb->next = cb_entry->paddr;
 
 		/* update src and dst and length */
-		if (src && (info & BCM2835_DMA_S_INC))
+		if (src && need_src_incr(direction))
 			src += control_block->length;
-		if (dst && (info & BCM2835_DMA_D_INC))
+		if (dst && need_dst_incr(direction))
 			dst += control_block->length;
 
 		/* Length of total transfer */
-- 
2.34.1

