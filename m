Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEA115D1
	for <iommu@lists.linux.dev>; Mon, 21 Apr 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745224777; cv=none; b=tueEc42nNXBMBZnP/cr6cYbJLZ/FViiqxHsuG96rNvVoCbKdJrirKNY5nUBvOM5S4fc8S2TCDLTfcAMqb0RS1HGkagg6KTx6XzchXBa+i/aH9I+0PucLphQn1dWfAsQUp40nigUOoSqE7oW1Ko0VqHyfWmsQe3YDFe7jWPhdVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745224777; c=relaxed/simple;
	bh=ucJiMgexT4WXicbI52lS/Bb6ScZP0blnJkAdptLF+oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Po7oscQ4nVTdSA9etg6vRmo3BTtmEixif5RL8Ao9lEfXh4WAk6mu94+HV5+x7BFw99jXtoXDeyVDJuZjEuvypDVzLaYsayIbh9aRBtYXJS62sJy0e+HA03Kz+4sQ9LqpKN/hSm4fPnJ0aRX1Uygghu/81C6+YNc0MFOcYW80TK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oB7+BO1i; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oB7+BO1i"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736c1138ae5so3327080b3a.3
        for <iommu@lists.linux.dev>; Mon, 21 Apr 2025 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745224776; x=1745829576; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wR88YUOvRyxB0EwI3OjxUwHvwrBAXLgY8edQ+eCFxiI=;
        b=oB7+BO1iI3TOL4vwefo8Ev2BdTRBhnhePI69adirSoMkV+bnHOINhVoE2BDoVQFeh+
         5AKZcclp/fWtTePQa0Gyx0+e3zs1JHvB81mahWejGFmVlcshJl8m2BVLFMvLC6ZvAY5Y
         JOmmEBX+8g+Fay1HlTGyOyfNFpCk6GknOY82g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745224776; x=1745829576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wR88YUOvRyxB0EwI3OjxUwHvwrBAXLgY8edQ+eCFxiI=;
        b=nfUJGI+EYwbP3xbWN8RHqLoohJ5G/OkwDYMh9FXhIxNJ0d+15DxeVfrgI0G/KOPwim
         2tJd5cRQodJ2u3lOwweQZv1cVwqkHrgB/xQ6ZTg7itzwWL00P7ubYIPtnSyWFsEl0hxp
         bxg7q3SdJ3EkfIjwN0VNfkePOxO0nq8yHjtAxXTElT+Fsxu9e8DEcH82TTWgryGrmVRz
         jD0E0rqLLb33GMHVetMauJE75CELdCzTJ3fs3BOcwA0YQHFETm3izN9YFfeFyUgTR/ks
         GEiTugg1xyju85IyiEhV/IICcHq8mXD653ER7LOYymAzVfpB9N5iqDuHFmezUN7ODPnh
         23Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVH0/q020g0eVxihU23i4tEbxTF2fX/v8FBwVJjSY7np8S9F5oal0kLvAQLwr9k8+1SY2LqeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzICBEQqvBsPvWaOmk3ub+bdz5RAaEGX5NJlqPq8Gh4QWyR+1D3
	u1+LIkTWDJqKLGsxjd9dx5cd1qKx9kpKK/D7sAYof045T11RZLT5yxSJH/3f7g==
X-Gm-Gg: ASbGnctzB7GVdcr2L9utItn2VhhTo8XlFf62ady3wsYgAtt/hqc0XsnYSNHwuFgpeJi
	P9y0pR0ilvatjjQb+6xjmaT9T2bY1dLgGT9yQOwg1PIPJe0w3zcLFLWEc0HWYWSwUXHlf2JRX8P
	MkjmKlW7sk+L5X57jzu8AaLq5p+YEq/sC5GBb5AS6+X8Jj8V8aSPs1q1p2VNnTw5BDg1LIsKF0p
	QEUKgMYqaVecGvY4GW593YslbffsuAHf7vD8RBSaeOKcA/3LrHH0wbnOlPZuRbzgtspY31gt38v
	SR9pVaLfcFQ7c5zpzykAGgCwIk70d4UmIdSBEMj+CKK36gZGy7AQC2Y8aVM=
X-Google-Smtp-Source: AGHT+IGolMsV0u0T3aFzWf6YoYJGw1Ia9H/TFYa361qcURhToyHlLB4nnuCsVqXLrz2gtvhYkG1A1g==
X-Received: by 2002:a05:6a20:158c:b0:1f3:47d6:aa05 with SMTP id adf61e73a8af0-203cba7ccc3mr17256403637.0.1745224775723;
        Mon, 21 Apr 2025 01:39:35 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7633:f42a:d31d:3f9c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e42b5sm6277328b3a.57.2025.04.21.01.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 01:39:35 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma-coherent: Warn if OF reserved memory is beyond current coherent DMA mask
Date: Mon, 21 Apr 2025 16:39:29 +0800
Message-ID: <20250421083930.374173-1-wenst@chromium.org>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a reserved memory region described in the device tree is attached
to a device, it is expected that the device's limitations are correctly
included in that description.

However, if the device driver failed to implement DMA address masking
or addressing beyond the default 32 bits (on arm64), then bad things
could happen because the DMA address was truncated, such as playing
back audio with no actual audio coming out, or DMA overwriting random
blocks of kernel memory.

Check against the coherent DMA mask when the memory regions are attached
to the device. Give a warning when the memory region can not be covered
by the mask.

A warning instead of a hard error was chosen, because it is possible
that existing drivers could be working fine even if they forgot to
extend the coherent DMA mask.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
I talked about this on IRC on 2025-04-15 [1].

It seems that printing a warning was the most acceptable thing to do.

[1] https://libera.irclog.whitequark.org/armlinux/2025-04-15

 kernel/dma/coherent.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 3b2bdca9f1d4..77c8d9487a9a 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -336,16 +336,22 @@ static phys_addr_t dma_reserved_default_memory_size __initdata;
 
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
-	if (!rmem->priv) {
-		struct dma_coherent_mem *mem;
+	struct dma_coherent_mem *mem = rmem->priv;
 
+	if (!mem) {
 		mem = dma_init_coherent_memory(rmem->base, rmem->base,
 					       rmem->size, true);
 		if (IS_ERR(mem))
 			return PTR_ERR(mem);
 		rmem->priv = mem;
 	}
-	dma_assign_coherent_memory(dev, rmem->priv);
+
+	/* Warn if the device potentially can't use the reserved memory */
+	if (mem->device_base + rmem->size - 1 >
+	    min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit))
+		dev_warn(dev, "reserved memory is beyond device's set DMA address range\n");
+
+	dma_assign_coherent_memory(dev, mem);
 	return 0;
 }
 
-- 
2.49.0.805.g082f7c87e0-goog

