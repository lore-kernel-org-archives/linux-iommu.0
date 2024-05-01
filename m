Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B90161939
	for <iommu@lists.linux.dev>; Wed,  1 May 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594412; cv=none; b=I5PMMvLOh1YZ2eDdw13I3zoufd2TGfmGVDtIL9+yMkpErgtRic3YPF5p0JiUpg0Vzcw2oltUbLCcgsFMTc7UCcgUpAMEjhVdtcqxFouFNHxGWznKaYG4clv8GgU8KxscZJo9SFH/WGM5gpkC0Kqjgu/hyg5lw8FVAnNhniifniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594412; c=relaxed/simple;
	bh=rkNzy9U73z8jvrL5sUQ+lp32dbo34t1vmGN/vpd0fWQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=INmG3lFvrGnEM0M1v1j/NWO4QXvqkamREgcCXINFSch3nt0qz1kraPYuizN2dgc7vfQ0uOGAtzYms3vgRP8lFt+MKQquLwDA1AtaLKydOzbi6+z6/HPbhtvBQdsE7GI8pOptflPmHgxdYrs2U0v+YDEaTT0YvtW5XvQ5CxyHGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H//P71TG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H//P71TG"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso12141052276.1
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714594409; x=1715199209; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pAz4UtE9TtuqKUTxLs4RS/mVM2NOpMppCAL8lNzqroU=;
        b=H//P71TGO6B6bLIDr4bLPfjuLWTlD4V3vSaySzB3z4ZJYZq3aU9NGGXsN/qd/wOG77
         oZsv5GyOtDHVKn/ak86iOVyVOb8P882YtYyBAGvIdEXf7WxPKZ+mLAsbMw73w0p6z/nF
         h+A9TwvT1VTavbZg+teZcN3O30RFgZtYibyF+bmtI5y7i1mvgr2S88RL5T/O1Strx3PA
         hHLwVzED0s/dqGW7FO1A3Jm1MfazfmSgaL0qL6iRIB/LY5aKr8lolrXDbml0s51z8VSh
         dM/OOy3sIy/vbIGUS2uY1/bMte3Xo/naCo1CFGAzKLfokXN1BM6yQhdsCNFkoMeeZ6Yk
         WJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594409; x=1715199209;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAz4UtE9TtuqKUTxLs4RS/mVM2NOpMppCAL8lNzqroU=;
        b=leugh2Cx0Zq6Oc1QKMPR8daRFv44ljNJNYpUTwjEi+aicAt4YtlXO/ppAx5CIPGl9f
         yd8UCh856VcCsnQp5aMiv63evmKE6b8oTo9yT1QmXl41Qw9VvAx0B1tvrBzQ/deFhdjv
         Grr2cywkBlMq6nER/Vuggg3oiU4UEI/iMc0zAj5VCn/QGYqG6RAMQoICSiSBzaFt0GeN
         5xpKTCCg/j+ppK+H0nq7dNrcF1gIm7pZsOSBXfaq0pszL9JJUlLrxg/wEXvixbeBxR8C
         I3amxjMuwNNadPlmjBuYovzt7mJ+pGhBkYxLioAtBxE6InuA15F/DuCmsC9NUtdEVR02
         Ayzg==
X-Forwarded-Encrypted: i=1; AJvYcCWU3oWr8I9BC8JmpMXBI+KwjzNby2p0afOJu8JYC20DAkuxm9RTWoXSExdYcYqhwwaJYMOd8jL976P51znKzziYWOdEykw=
X-Gm-Message-State: AOJu0YxBB83dUa39nO2uGoVv/azl+ngWLi1Fxrl7uGkmYhGgr/yVK8hc
	DdUNJjMW4xI4htQU01zZWLmd9DM0VcuUtP5LZTYXJFCIYPGyduaW6JBLz0og2cRooO0GR1mtxhU
	ybYpqUUSAAyygkg==
X-Google-Smtp-Source: AGHT+IHqI+ChrQt9eDkX7OntryvFzGWOZwa5AHoNSRjrZhppIPW4IvMdH+fS/OJP2+KxJpifU59LGhWMlLyMdo0=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a25:6809:0:b0:de5:5304:3206 with SMTP id
 d9-20020a256809000000b00de553043206mr381300ybc.11.1714594409532; Wed, 01 May
 2024 13:13:29 -0700 (PDT)
Date: Wed,  1 May 2024 20:13:18 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501201319.586289-1-tjmercier@google.com>
Subject: [PATCH] iommu/dma: Respect SWIOTLB force_bounce
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: isaacmanjarres@google.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

iommu_dma_map_page and iommu_dma_map_sg conditionally use SWIOTLB, but
checking if force_bounce is set for the device is not part of that
condition. Check if devices have requested to force SWIOTLB use as part
of deciding to take the existing SWIOTLB paths.

Fixes: 861370f49ce4 ("iommu/dma: force bouncing if the size is not cacheline-aligned")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/iommu/dma-iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e4cb26f6a943..755d66b49dff 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -606,7 +606,8 @@ static bool dev_use_swiotlb(struct device *dev, size_t size,
 {
 	return IS_ENABLED(CONFIG_SWIOTLB) &&
 		(dev_is_untrusted(dev) ||
-		 dma_kmalloc_needs_bounce(dev, size, dir));
+		 dma_kmalloc_needs_bounce(dev, size, dir) ||
+		 is_swiotlb_force_bounce(dev));
 }
 
 static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
@@ -632,7 +633,7 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 				return true;
 	}
 
-	return false;
+	return is_swiotlb_force_bounce(dev);
 }
 
 /**
-- 
2.45.0.rc0.197.gbae5840b3b-goog

