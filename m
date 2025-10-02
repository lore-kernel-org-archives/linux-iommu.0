Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0750276
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421793; cv=none; b=Hqg8dbXQl+54JcZljQjEQlgsVY57R3DA7DMeMXTBWo/XQIbUSrHGNNb9mm5OjzzG6qxC7mdxsBXcel9ygmzj+A/C+ZlGrEaYX8uMa9pyOrmZ0U40l8POHo/bk+le1l0tFMZJQgaDtDYhtW1+TwXaJoXREEVqJFc1ApRJtNcq544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421793; c=relaxed/simple;
	bh=vOP57pLo9t+NIdpLJnSYQ9SV9U2TJKKVwuOHtKXSaAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2Vqt/cRCLz+jL3QOe5y6CG7BxhZ5f/fc0viRjlvUdzwS0XJUfKGPnl1fcx1TQoueY1yIXDN9fz9mhvIHOS1b0+OHhA8E8yPhyPH0/IMdjbg0z8WmuIC/pGSDZ+sOiLxFpCR0YJbqWYOdfRmQQOaO8kVoTCcekXqyMcaXXehUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=MKbYwjqS; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="MKbYwjqS"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4dfd1f48d4cso8319161cf.0
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1759421789; x=1760026589; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxritUvOZnvW7GTOw2Z5mKJYXhzRcHFVVfyj1Hwre+Q=;
        b=MKbYwjqSqiJUT4u0FiGyFCg34PFdrvPnqyqbgnlCTfYCAjD/p79GzuT9+k59SY+0bb
         3vXdW2wvDOoi0UWlN2SF4J8t+iNmoIwCs97M5HAfk2tCVEWxLZOvX+C3KsMtBnM/ZoIb
         qd0EEVFKUOXnkLCkhmfNY5mpFnRyFJ7OSYNHtF1W8MDjQ/8zicyFUfZAEP0c0618GgkJ
         rNwcVPOrmINNFhF8IWODcsibIOe6qVJTW6QvniwUg7iK/u9PQypDzWo7nWjkcDaqNz1D
         NN0jTPVeBMNoUoOSIp7lbZXaSqKGCjRWt3Q6wCfk1D1ny01A2JA65J3iR3lOZv2dk7h0
         AT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421789; x=1760026589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxritUvOZnvW7GTOw2Z5mKJYXhzRcHFVVfyj1Hwre+Q=;
        b=vAv6dkxmFkj0HRE4I9ssXuGArxEGk2ZhmXFp2qFlbGChLo1LnYKcSlYwypfnpNqBb/
         Ewt9JxXHFSLYUmAmaLRch7YyS/Y4O+zst4ZWsrwYEv1sUwrmQlcg5p63ct2vZD9pxL85
         oUhSLuHrcwWTbu70S3NPWMC++I+nIUI43HvlvL0coHbayv5zKWGGR+nY7xDzPfbG2C8Z
         agS6et/j7gfZi5fov56Yx80RlZJmjamexUWu4MqFVCgGMiO1L69IAz1eCSvyd7uzdIGC
         5hSDv+OEOd48mW2GzPM3o04QO9ZDYUaq5wMmVbF6Ny/tdn79ikUVbjdHz9LBNOjh29Qy
         rnHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpnkJMIYKqZE49cH/2gEY21yCUEfcWPlsXh9yVVB1zXDwwk5q3sVELr1N1bX3mCEcMI+0bNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEV9vNqNtNRzMy5ys6C9l7Z2OuT+WMdKoIOHLmJPd+5li1Ukiu
	jo+HTqBm5PZl4w7SLd8UnKy7+Wb8KnNtZ5HykIRIglrRuO26hxxdfsaDkLrumRnzryw=
X-Gm-Gg: ASbGncsdklKzU+QojIzkCppqpFnpmCtdMKrFCTftJRLi3P06n5oFcRyVEP18ovkYeW4
	q2Xr8getjVf3Jx7JEY17G1TJUJ+Ma6FRX+ZtnGLh6i05N9JozuziwlAvBTZM3H805nzi/VCgH4/
	Itf/Iq4johh9WaRCr7QwdMsRf1JzDwUdfez/wo4SV50/rGAC5beR3yVUx7gm4+IqKMVtujn5c8R
	2SgfOV72JOihOSa6jObSwWK80kevFxS2T8T0rjAR/IG3cyzgvk1yzWul7NrVsAWHFBQ9u+mkbbo
	eJXRxoxa0prf3NwE3OxWCdsf93eEAnaCNoZilXPj+2g4cqleGGU3Jsq/CohdbNA6gkc/DzMTWCv
	B8x6JZ9N6fLW+KxhclTbR4bvzB2+Qy+rhFMN4ec35SFnUQ+dls6bfAa9wuCiyrW1oO07r+a4xap
	VzJakoIjpAKa0ugNS1ubWtFejcYgagDJo=
X-Google-Smtp-Source: AGHT+IEVcrgDPTukLnX7GKNxMifNYwBRtwRpqPpzAI3H9EctG9klhVojcgO2GIKDXibk9hO5aPas7Q==
X-Received: by 2002:a05:622a:598b:b0:4d9:5ce:3746 with SMTP id d75a77b69052e-4e41de6f81cmr106450431cf.46.1759421788717;
        Thu, 02 Oct 2025 09:16:28 -0700 (PDT)
Received: from vineethrp-dev.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e56d9cd10csm14093781cf.42.2025.10.02.09.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 09:16:28 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	dmaluka@google.com,
	shraash@google.com,
	efremov@linux.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: set INTEL_IOMMU_FLOPPY_WA depend on BLK_DEV_FD
Date: Thu,  2 Oct 2025 12:16:23 -0400
Message-ID: <20251002161625.1155133-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

INTEL_IOMMU_FLOPPY_WA workaround was introduced to create direct mappings
for first 16MB for floppy devices as the floppy drivers were not using
dma apis. We need not do this direct map if floppy driver is not
enabled.

INTEL_IOMMU_FLOPPY_WA is generally not a good idea. Iommu will be
mapping pages in this address range while kernel would also be
allocating from this range(mostly on memory stress). A misbehaving
device using this domain will have access to the pages that the
kernel might be actively using. We noticed this while running a test
that was trying to figure out if any pages used by kernel is in iommu
page tables.

This patch reduces the scope of the above issue by disabling the
workaround when floppy driver is not enabled. But we would still need to
fix the floppy driver to use dma apis so that we need not do direct map
without reserving the pages. Or the other option is to reserve this
memory range in firmware so that kernel will not use the pages.

Fixes: d850c2ee5fe22 ("iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions")
Fixes: 49a0429e53f2 ("Intel IOMMU: Iommu floppy workaround")

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 drivers/iommu/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index f2f538c70650..17a91f881b2e 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -66,7 +66,7 @@ config INTEL_IOMMU_DEFAULT_ON
 
 config INTEL_IOMMU_FLOPPY_WA
 	def_bool y
-	depends on X86
+	depends on X86 && BLK_DEV_FD
 	help
 	  Floppy disk drivers are known to bypass DMA API calls
 	  thereby failing to work when IOMMU is enabled. This
-- 
2.51.0.618.g983fd99d29-goog

