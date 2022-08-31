Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108A373
	for <iommu@lists.linux.dev>; Wed, 31 Aug 2022 06:38:22 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id j11-20020a05690212cb00b006454988d225so1520475ybu.10
        for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 23:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=It3y/STunI05Ydz1QHfujdG313dUyBru08R+qGI7HoM=;
        b=bA2Qx/GQl3M3N9A8PUFo9hekqjnouCvqIFiijACBUirMx/DolZPyJR/G96OVlAoZkj
         taUpfJ8birvC5nERsAybS7mclQxIjcWwrUWZOj+hJyyCZ6fGo8Yo43RCreFN7/wWBxIM
         kOUrZJLrLLNG27GYus10Nrns978dPi93yD801SyYNRSqnoamewGNGufUej0g/mqncUrR
         PkcAAmyK9RUfYVjqPOFankeGldXgjIbxLQpFy9Fk8BRAHLZeDVbG+oUnOX1Za0yM2elK
         XoeNhV6Ui6e1NIg1hvb/WA7uTXfxmfZnl2z7uyKEi+AItM2ctv5piL6UBvhcbQNfaj6A
         43kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=It3y/STunI05Ydz1QHfujdG313dUyBru08R+qGI7HoM=;
        b=v1h1TPoA5uZlSsWqAh0XbiB7l3pSGz5mJP5KM5jYMT0lYYfVOXAxF36gw3X4ESkx15
         uIAWUQo2Okmxbopq9GxMq2xEinRuJ+Q28RhYCWKw6lSZ3exN2sVr5oW8Mp2cn5UzhiQO
         R3x9fiLPhrS3quzIDWfqYuTcu1/rbPn+6opafTYRphjO+YP7cg609/oAZO408fJ6TRrx
         +o7FDSrBwdFJfzsVhNzXk57tW8M+VWbteexw6YygX5lhqdvq6flCYXFCSEYqf5GI4BEr
         diEDl6w/Ae+w/ujVBIqUxk7Wqljov8wUxZocutVdyNOkq/cAER/cEE92V5GZ/yCC8lxi
         YZJA==
X-Gm-Message-State: ACgBeo3Vy+CG4ciK2VOucvt9Ztohc6Nm3DGzfKeVe/0/pTDXeHgwQOUM
	kCTwsIBZqqUV+UpWYOUu2+6t93UmfEY=
X-Google-Smtp-Source: AA6agR4BQf9ZFM65KZ1OjONT0vPQ2tZZiq9X3I+KHd0i3Y++KKDlpOhXPDjfwUav9YJIu2iR/eJPWprCakw=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:103:daa9:a72c:751a])
 (user=yuzhao job=sendgmr) by 2002:a5b:3ce:0:b0:66f:4692:27a2 with SMTP id
 t14-20020a5b03ce000000b0066f469227a2mr14479161ybp.167.1661927901645; Tue, 30
 Aug 2022 23:38:21 -0700 (PDT)
Date: Wed, 31 Aug 2022 00:38:18 -0600
In-Reply-To: <20220829232934.3277747-1-yuzhao@google.com>
Message-Id: <20220831063818.3902572-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20220829232934.3277747-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v2] Revert "swiotlb: panic if nslabs is too small"
From: Yu Zhao <yuzhao@google.com>
To: Christoph Hellwig <hch@infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Dongli Zhang <dongli.zhang@oracle.com>
Cc: iommu@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>, 
	kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit 0bf28fc40d89b1a3e00d1b79473bad4e9ca20ad1.

Reasons:
  1. new panic()s shouldn't be added [1].
  2. It does no "cleanup" but breaks MIPS [2].

v2: properly solved the conflict [3] with
commit 20347fca71a38 ("swiotlb: split up the global swiotlb lock")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

[1] https://lore.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com/
[2] https://lore.kernel.org/r/20220820012031.1285979-1-yuzhao@google.com/
[3] https://lore.kernel.org/r/202208310701.LKr1WDCh-lkp@intel.com/

Fixes: 0bf28fc40d89b ("swiotlb: panic if nslabs is too small")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 kernel/dma/swiotlb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190b218f..dd8863987e0c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -326,9 +326,6 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		swiotlb_adjust_nareas(num_possible_cpus());
 
 	nslabs = default_nslabs;
-	if (nslabs < IO_TLB_MIN_SLABS)
-		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
-
 	/*
 	 * By default allocate the bounce buffer memory from low memory, but
 	 * allow to pick a location everywhere for hypervisors with guest
@@ -341,8 +338,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	else
 		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb) {
-		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
-			__func__, bytes);
+		pr_warn("%s: failed to allocate tlb structure\n", __func__);
 		return;
 	}
 

base-commit: dcf8e5633e2e69ad60b730ab5905608b756a032f
-- 
2.37.2.672.g94769d06f0-goog

