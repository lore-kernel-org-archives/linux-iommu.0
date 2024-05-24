Received: from mail-wr1-f97.google.com (mail-wr1-f97.google.com [209.85.221.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54973C6AC
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575282; cv=none; b=Lva9Jc3ArbvNZYExrhbWKez/FfwGaTUSOiJimwJ4wERlDC2cANQg9SG5oONtPbUO2+IEEs+AtKHTjlj+ThNw8WA7IHkYnXiaLlhx7GMYbrWsPlAxnzvCXyVOT05UfPy6xUV6fL/wQ4U9UIJlrr6iqpQ0ycRjZiD5eKtteYnESeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575282; c=relaxed/simple;
	bh=q/vPvexOj8BorMyOQXoWhY2JPB5kWHRHIatWLRoYFL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUPSkjV2/eWpXWIuA5GhuWUx7jIuKRqvIXU+36UdXtXOiaDp/YJmwzv747HQPd2vb/rM3FXaslI+uaXqDwdXLDNKa370OPt4HZRrE6PAR1JRM32iuJxTEdeLsARgpce+ZYOiMaua3Dn8ZN0M0XM8rg5KQY/ymf2Y0KmHbdUhXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=qqmhu/gC; arc=none smtp.client-ip=209.85.221.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="qqmhu/gC"
Received: by mail-wr1-f97.google.com with SMTP id ffacd0b85a97d-351b683f2d8so2894844f8f.3
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575275; x=1717180075; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94Kgj4XNRFYduQRTRfIrQIcXqS9keoQhSCwvILhnmSs=;
        b=qqmhu/gCZn8Pt9oVNz8Q8cDxPZOU4He+YNS47IpOrBMajDSAUZfo2VocGNNEmeveGu
         NToLf3fhATIg6GVeLoJhGt0be0EIAI64vbS6N04pdUnLPspdhXOK52REzVZ5HA2Myz3H
         7cbReDQwBnBaFe5IG7Cnj5lqCT9TU+bS7TsBWaOjr5Njg7OHdnlYpk5SuKKD9EAuv22p
         rVFhFSkGVRq4XewmR67F7MuU7SIpQQ2c2c21jEvFgUh/0frUl2i+KM60E7WOhIqLmjUs
         ApO7j+Nd74ziB8ngReKBg9zd3+arw4T9kGh3ptupFCFRIOFamSpo5KkKzyLEkaBqu2RF
         RYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575275; x=1717180075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94Kgj4XNRFYduQRTRfIrQIcXqS9keoQhSCwvILhnmSs=;
        b=jk9C2HEAHjrd75Kd/bte+MW5whHDQY6saBdSo7kiQ2USi6bJJ4xtrutTao4ztkCE7+
         L/GcRa5N7xJ1/FKLqw0RDJi5CkODn2sKYmK7LIGS3/zQNfRDtuLCcYBH3EG1QT3fOLuc
         FVdnpU5CrASby/lONG5JwhiytMLJDq7yHup+u96LIGSsZO2fl+kak2HsUCSF/rHbgfoF
         DLKeZlxc9thPha3D6g1r3OkLlqNZzhs7ZUMUbtasrDwqR1l2zpQWXFgl8lnX9GdIjJoz
         pyxvgIJxYcVH542h9H65r6dJRMx+EAIOEMszXrs2Nmyo8TE/2jZUwhDrE3I5voSSErMq
         J7OA==
X-Forwarded-Encrypted: i=1; AJvYcCXJci5bzIPDdYVqKPSzKscY+8rrxx7kjlanIsTeFTFJk5THb7Zsdox6NOO+ZowpacLuBaaZwStC1uXwtS2ngiqxeK5e0Io=
X-Gm-Message-State: AOJu0YwX53BSPhpQrZfp/hv7XpC0G571x/OF3V/em/cmuzd5TsFabj3+
	LHS/BmAV3Vb05FFT8lpZCJxJ/iw0C97LJ8uF9EifV299dpEISFs6FH+uzmeQUDAMFXNE6PyyqtE
	9KP5xmyV0M8qjHnnBApXyGyB9NH75XKDY
X-Google-Smtp-Source: AGHT+IGesJtEvV+unRtxxlqVpvfAyXBqt4L3VhNP7OXMl0+5bcpxZXNW6Yligrt0JA2P+vgera6GBoU5TmNu
X-Received: by 2002:a05:6000:248:b0:34d:b605:ec68 with SMTP id ffacd0b85a97d-35526c37d2emr2209418f8f.17.1716575275087;
        Fri, 24 May 2024 11:27:55 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-35579d7beacsm64758f8f.21.2024.05.24.11.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:55 -0700 (PDT)
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
Subject: [PATCH 07/18] dmaengine: bcm2385: drop info parameters
Date: Fri, 24 May 2024 19:26:51 +0100
Message-Id: <20240524182702.1317935-8-dave.stevenson@raspberrypi.com>
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

The parameters info and finalextrainfo are platform specific. So drop
them by generating them within bcm2835_dma_create_cb_chain().

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 83 +++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index d6c5a2762a46..e2f9c8692e6b 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -287,13 +287,11 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
 		container_of(vd, struct bcm2835_desc, vd));
 }
 
-static void bcm2835_dma_create_cb_set_length(
-	struct bcm2835_chan *chan,
-	struct bcm2835_dma_cb *control_block,
-	size_t len,
-	size_t period_len,
-	size_t *total_len,
-	u32 finalextrainfo)
+static bool
+bcm2835_dma_create_cb_set_length(struct bcm2835_chan *chan,
+				 struct bcm2835_dma_cb *control_block,
+				 size_t len, size_t period_len,
+				 size_t *total_len)
 {
 	size_t max_len = bcm2835_dma_max_frame_length(chan);
 
@@ -302,7 +300,7 @@ static void bcm2835_dma_create_cb_set_length(
 
 	/* finished if we have no period_length */
 	if (!period_len)
-		return;
+		return false;
 
 	/*
 	 * period_len means: that we need to generate
@@ -316,7 +314,7 @@ static void bcm2835_dma_create_cb_set_length(
 	if (*total_len + control_block->length < period_len) {
 		/* update number of bytes in this period so far */
 		*total_len += control_block->length;
-		return;
+		return false;
 	}
 
 	/* calculate the length that remains to reach period_length */
@@ -325,8 +323,7 @@ static void bcm2835_dma_create_cb_set_length(
 	/* reset total_length for next period */
 	*total_len = 0;
 
-	/* add extrainfo bits in info */
-	control_block->info |= finalextrainfo;
+	return true;
 }
 
 static inline size_t bcm2835_dma_count_frames_for_sg(
@@ -352,7 +349,6 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
  * @chan:           the @dma_chan for which we run this
  * @direction:      the direction in which we transfer
  * @cyclic:         it is a cyclic transfer
- * @info:           the default info bits to apply per controlblock
  * @frames:         number of controlblocks to allocate
  * @src:            the src address to assign
  * @dst:            the dst address to assign
@@ -360,22 +356,24 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
  * @period_len:     the period length when to apply @finalextrainfo
  *                  in addition to the last transfer
  *                  this will also break some control-blocks early
- * @finalextrainfo: additional bits in last controlblock
- *                  (or when period_len is reached in case of cyclic)
  * @gfp:            the GFP flag to use for allocation
+ * @flags
  */
 static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	struct dma_chan *chan, enum dma_transfer_direction direction,
-	bool cyclic, u32 info, u32 finalextrainfo, size_t frames,
-	dma_addr_t src, dma_addr_t dst, size_t buf_len,
-	size_t period_len, gfp_t gfp)
+	bool cyclic, size_t frames, dma_addr_t src, dma_addr_t dst,
+	size_t buf_len,	size_t period_len, gfp_t gfp, unsigned long flags)
 {
+	struct bcm2835_dmadev *od = to_bcm2835_dma_dev(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	size_t len = buf_len, total_len;
 	size_t frame;
 	struct bcm2835_desc *d;
 	struct bcm2835_cb_entry *cb_entry;
 	struct bcm2835_dma_cb *control_block;
+	u32 extrainfo = bcm2835_dma_prepare_cb_extra(c, direction, cyclic,
+						     false, flags);
+	bool zero_page = false;
 
 	if (!frames)
 		return NULL;
@@ -389,6 +387,14 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	d->dir = direction;
 	d->cyclic = cyclic;
 
+	switch (direction) {
+	case DMA_MEM_TO_MEM:
+	case DMA_DEV_TO_MEM:
+		break;
+	default:
+		zero_page = src == od->zero_page;
+	}
+
 	/*
 	 * Iterate over all frames, create a control block
 	 * for each frame and link them together.
@@ -402,7 +408,8 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 
 		/* fill in the control block */
 		control_block = cb_entry->cb;
-		control_block->info = info;
+		control_block->info = bcm2835_dma_prepare_cb_info(c, direction,
+								  zero_page);
 		control_block->src = src;
 		control_block->dst = dst;
 		control_block->stride = 0;
@@ -410,10 +417,12 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 		/* set up length in control_block if requested */
 		if (buf_len) {
 			/* calculate length honoring period_length */
-			bcm2835_dma_create_cb_set_length(
-				c, control_block,
-				len, period_len, &total_len,
-				cyclic ? finalextrainfo : 0);
+			if (bcm2835_dma_create_cb_set_length(c, control_block,
+							     len, period_len,
+							     &total_len)) {
+				/* add extrainfo bits in info */
+				control_block->info |= extrainfo;
+			}
 
 			/* calculate new remaining length */
 			len -= control_block->length;
@@ -434,7 +443,9 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	}
 
 	/* the last frame requires extra flags */
-	d->cb_list[d->frames - 1].cb->info |= finalextrainfo;
+	extrainfo = bcm2835_dma_prepare_cb_extra(c, direction, cyclic, true,
+						 flags);
+	d->cb_list[d->frames - 1].cb->info |= extrainfo;
 
 	/* detect a size missmatch */
 	if (buf_len && (d->size != buf_len))
@@ -682,9 +693,6 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 {
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
-	u32 info = bcm2835_dma_prepare_cb_info(c, DMA_MEM_TO_MEM, false);
-	u32 extra = bcm2835_dma_prepare_cb_extra(c, DMA_MEM_TO_MEM, false,
-						 true, 0);
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -696,9 +704,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 	frames = bcm2835_dma_frames_for_length(len, max_len);
 
 	/* allocate the CB chain - this also fills in the pointers */
-	d = bcm2835_dma_create_cb_chain(chan, DMA_MEM_TO_MEM, false,
-					info, extra, frames,
-					src, dst, len, 0, GFP_KERNEL);
+	d = bcm2835_dma_create_cb_chain(chan, DMA_MEM_TO_MEM, false, frames,
+					src, dst, len, 0, GFP_KERNEL, 0);
 	if (!d)
 		return NULL;
 
@@ -714,8 +721,6 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src = 0, dst = 0;
-	u32 info = bcm2835_dma_prepare_cb_info(c, direction, false);
-	u32 extra = bcm2835_dma_prepare_cb_extra(c, direction, false, true, 0);
 	size_t frames;
 
 	if (!is_slave_direction(direction)) {
@@ -738,10 +743,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	frames = bcm2835_dma_count_frames_for_sg(c, sgl, sg_len);
 
 	/* allocate the CB chain */
-	d = bcm2835_dma_create_cb_chain(chan, direction, false,
-					info, extra,
-					frames, src, dst, 0, 0,
-					GFP_NOWAIT);
+	d = bcm2835_dma_create_cb_chain(chan, direction, false, frames, src,
+					dst, 0, 0, GFP_NOWAIT, 0);
 	if (!d)
 		return NULL;
 
@@ -757,13 +760,9 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	size_t period_len, enum dma_transfer_direction direction,
 	unsigned long flags)
 {
-	struct bcm2835_dmadev *od = to_bcm2835_dma_dev(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src, dst;
-	u32 info = bcm2835_dma_prepare_cb_info(c, direction,
-					       buf_addr == od->zero_page);
-	u32 extra = bcm2835_dma_prepare_cb_extra(c, direction, true, true, 0);
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -814,10 +813,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	 * note that we need to use GFP_NOWAIT, as the ALSA i2s dmaengine
 	 * implementation calls prep_dma_cyclic with interrupts disabled.
 	 */
-	d = bcm2835_dma_create_cb_chain(chan, direction, true,
-					info, extra,
-					frames, src, dst, buf_len,
-					period_len, GFP_NOWAIT);
+	d = bcm2835_dma_create_cb_chain(chan, direction, true, frames, src, dst,
+					buf_len, period_len, GFP_NOWAIT, flags);
 	if (!d)
 		return NULL;
 
-- 
2.34.1

