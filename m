Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948EEC7
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761440; cv=none; b=ZJ1uo5R5q0dFt3WNkUkjFCvNLpk4aK8m77Kw4BxYwEAybDxJ0nTBZrkJ+zkMWqQeeJO5XzOYUNrfdo3fsD9e1phE3JlPmm+dlkERqHWXDZjt9yggoT07F3n1qdqL/WfPBF+sGdhi3lSSu0USvja5HAUED15cchgWTIv6hVthmjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761440; c=relaxed/simple;
	bh=wm5pk9S0/JQcuHXC+N1ugdSHVS+48gum9vVTthDqGHE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LK1VT+l+8207ubSAB4nckqcONg8EYBdED6GGv8wKi8QSFbcaxJImZPHpGfv6556oGKCxLfkREDdwi2w1lpBqgCKX099DxwaO3FeAKHck9lnrJ9+9grU9ICTAkz6ftGW3Yk4k00iBoC7q6vNvcL2vdWhro9M+FFcqDE4N6i/pTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c2gI7bRv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2gI7bRv"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de60cd96bf3so11390276.0
        for <iommu@lists.linux.dev>; Fri, 03 May 2024 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714761438; x=1715366238; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dnbX50dR3baSwjlitnZlT2KQP1Bjq1hEVDevUqr+0/8=;
        b=c2gI7bRvfAajH8UgSe37OhZIifvnCknCPw9oVgdxDZmpVAndM9jaeY2AoyD5T+nLnh
         uG6F4ESnu13GLx6Vl5LkTd1nflzRhmOIQdkGwo4H6/hgVeSKtAakxTmPCXfstvTRhIOY
         anXxKevEitgAHQoUtmp0gZFvJ47XV4r7AnE8I8llYd5FaJecEEvf9/KcFbslUNfm1YQo
         YCC4LA+lr6YOABXZQaAk/sSG+opprt6wtNhef6EO8b/aFechjSIZ/9xcAd/Ozre8pq2y
         lodivsd8Ky/QgDyrRjo1nhv+d8gnBjyo/lC0a3Lvf3UiOGowgF8Y3s9+0964Ho1X3X1x
         VznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761438; x=1715366238;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnbX50dR3baSwjlitnZlT2KQP1Bjq1hEVDevUqr+0/8=;
        b=m7LmkuMZKrrmSJlEwQUhO0HY+WUA7FDyBWBd3kuXraSGWA6cjcgS2a6gtofVTtbdeB
         KWbT7Whsd7Y24O2b5vAJHHY9QkpRQalKDZfKtUE0DdtwfdTFg0qMW8D4Mc3xF6Rs4+VA
         5DH/TGPq8gWProq3NNLkz4QrqPBUHcx79x1yFldhQGYKUvxHcwxS8/OTYzHnEun3DFnq
         w+E6a6aQkdZoZUhwuwoW/LOn71w5jDXlrNE5jp4WkIZR4qTsWqtmDr//o+llEaWoob2p
         RAP/Xz7BOKMeGSp7cn6kTNMZPSnkg3KIBnPXO7pwiguLawQ850k0srNAk89E9bxjhF4u
         bI2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkMuzyOeb8DtCZqZ9OQQWLFjENPkAFwpWjrkT9VtG/02arPIZ4OGgYOaQljotrLtVxk1fgR9g2fm2pNFMXl23dZgmPMoA=
X-Gm-Message-State: AOJu0YyTsL9cIyZhmCTuGXsyEw/Spfi14ZZcLvR7mpAtJmxr0KYYEaU2
	XEUtVqvid2Ngr/krWzKZLIfc6StvHvrsNpDV5CD6Kq9zHsb9TZLWmv4pMEPy7RXP6XDKLUhMZqR
	NK/4nN7bG7jmxpw==
X-Google-Smtp-Source: AGHT+IEGJ2S4zgk0AufQ45l1QpKrNKuLv5DVdMLyALhLjEW3+o5Sl1DK7KUfHw9Mvzh7OZLZuz0tF0RKftLW7XU=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:6902:102a:b0:dd9:2782:d1c6 with SMTP
 id x10-20020a056902102a00b00dd92782d1c6mr1222431ybt.1.1714761438256; Fri, 03
 May 2024 11:37:18 -0700 (PDT)
Date: Fri,  3 May 2024 18:37:12 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503183713.1557480-1-tjmercier@google.com>
Subject: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: isaacmanjarres@google.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As of commit 861370f49ce4 ("iommu/dma: force bouncing if the size is
not cacheline-aligned") sg_dma_mark_swiotlb is called when
dma_map_sgtable takes the IOMMU path and uses SWIOTLB for some portion
of a scatterlist. It is never set for the direct path, so drivers
cannot always rely on sg_dma_is_swiotlb to return correctly after
calling dma_map_sgtable. Fix this by calling sg_dma_mark_swiotlb in the
direct path like it is in the IOMMU path.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/dma/direct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4d543b1e9d57..52f0dcb25ca2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -12,7 +12,7 @@
 #include <linux/pfn.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
-#include <linux/slab.h>
+#include <linux/swiotlb.h>
 #include "direct.h"
 
 /*
@@ -497,6 +497,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 			goto out_unmap;
 		}
 		sg_dma_len(sg) = sg->length;
+		if (is_swiotlb_buffer(dev, dma_to_phys(dev, sg->dma_address)))
+			sg_dma_mark_swiotlb(sg);
 	}
 
 	return nents;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

