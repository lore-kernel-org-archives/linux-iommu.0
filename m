Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887553CE484
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943415; cv=none; b=HCi/ncorK/NKRIyOGNbFphn1cWWeGGCGgC1AlZMCDOjilODN8BEwXqLK5sdL95DSRMuIUA7mQLuUDVDfxNkOCRzniJv/1+kz3adsqFGkRadPJqv2euhSLDnDFu9Ys8Fs9fcn0Aq5q89IG46tFljbWNw9eEMxy3Wj5L9DO18rJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943415; c=relaxed/simple;
	bh=pEAts6xefgNbpkfmypE/+GyTlphpHd+cArKTNcgfLoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gCCECd41x3fiLBD2eAcaZlZxTo6VjmXL87/Gk2A7Rw1FdhB4wxdKJWO+K9JZDg/yJd1wTbNrwLts5VM7qVR/VXhhxIgsfegLB5o+ciP4L7pO/yAuYhe+ovjIJbJm9ig9SbrJiZ1Iele2UNH+NY8MmCOvuFtozD3M3a4A1t6nqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/n1pA3a; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/n1pA3a"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so53931195e9.1
        for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774943413; x=1775548213; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ0FISfr5kyvOiMiGgtJkNjcn8iqulgi6+Bp+/x1xTo=;
        b=q/n1pA3ak7009aBrhHDV+WkBuRFvJAO40sQvUcXqA8iPPbZ/92bGCOguBKR7yeeGqk
         uSlWaDXJoMN/bOSx9ZsVEZNEkoAD4lnuBby5rSRa/Tp+kdPtLQUPNjfmnSWVjKKnS6UV
         ZhgSafO23N5KOBzgU+O/q1UiIC4D1Z3rO+8kJSLihADWYaoC0FzKfKcUg4603wIymmfM
         Tz0cnvK3/vsN4C+BACPrOYRgbPWLsu27vE0k08IiHQnM52m13dcPVOT8NBFOLshHNYNn
         Jlv9z1qf1XfzItVDRvOkh9foTdafslWIGt8ryaKKDRZUkafcnjxdqmIpo9ffLShMXdR0
         7wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774943413; x=1775548213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZ0FISfr5kyvOiMiGgtJkNjcn8iqulgi6+Bp+/x1xTo=;
        b=YbooADbQySFZYRMlcTpyiyVpTRCWJjTgIcQEXaA17u/1UAmU1FFf4lpcqEMhlJkd1Q
         8QEZ+bqtmTkW/ZNOtW2s+LeEKZgNtGMTnJJOsvndHjpHLUiOgyfR0wB0+tGQq7MBVgkC
         NRdt3IgBGw8jJFJYQyZ2nA0SD6NrDLuCYstbOWegoTPv/edYmgVKOKgPwKNWydP96HHH
         66mHTnm52E17jof8riqtpQ5YWsEQmJ3CSf1xOkejmZQcDnWIAQfKNf4R0HjzbndGL7pc
         aGB5N+IowD5KccOKYjFSvOlsjhOndf0iOrHeFJE6knS0quYjEeU2fBISdjG/j2N5VVkz
         O/6A==
X-Gm-Message-State: AOJu0YxGVG3KHnFNdubEsrKLqJEY7kXC5CMi+mlrHyMrpCxDF7WjlFRh
	AZsda2+/uCYKM7dwzTbuhoH2/ttiAVeBsXbuJ/Qhby7ZhbwYREFzZQFf4Bqixtj3wzY=
X-Gm-Gg: ATEYQzyR9sddHwD6w+jCFI6pbJKUdfORnunkiUkMlSskTNzEUYx2gV6o85bbs+RByjl
	wyuVMrO2FGhE4SeKjWs8EgPG5RDyi2BlyyKkoZpwr4m3z656gcTUPNIZ7VQPQnJk7WoDSOFxV6K
	z1EIn8si729myh3HABzXZTN1/BP9Rp8j6fZqFS9Zv7hG81/rc9EBtDhJkoih/87R8NOhbzKgd2r
	aQoTCWFvX0flEZf+LKy3Aw7dcKoXTqwTyG/GAjoogB+TZWbqPnzPPQ7tKNbjsEHR+bGM4jL2/8V
	Ay3v6a0+Hc+OHjBcGeLPqLG71VtO+wueNvW9zzbsTjwdf3vgPRr1KM07zMxpqx4OcUFNZmXxBgE
	UUvcTC5WulLa3+bdGHuNUNRoHSGsea+mebwbrmjHiHK+/ZNt9zR70v9szCN/W7Xn/4laRnWirVl
	1ttvaXuf9k1Kdf07rr1kgkZLI6KAJnx2xqymDjRBo=
X-Received: by 2002:a05:600c:8907:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4887818678emr31449875e9.1.1774943412488;
        Tue, 31 Mar 2026 00:50:12 -0700 (PDT)
Received: from rock-3b.tailb81abf.ts.net ([213.152.28.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c91f0casm9873015e9.35.2026.03.31.00.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:50:11 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: iommu@lists.linux.dev
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	heiko@sntech.de,
	jonas@kwiboo.se,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Midgy BALON <midgy971@gmail.com>
Subject: [PATCH] iommu/rockchip: fix page table allocation flags for v2 IOMMU
Date: Tue, 31 Mar 2026 09:50:10 +0200
Message-Id: <20260331075010.1463-1-midgy971@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 2a7e6400f72b ("iommu: rockchip: Allocate tables from all
available memory for IOMMU v2") removed GFP_DMA32 from
iommu_data_ops_v2, reasoning that RK356x and RK3588 IOMMU v2 hardware
supports up to 40-bit physical addresses for page tables.  However, the
RK3568 IOMMU page-table walker uses a 32-bit AXI bus: it cannot access
physical addresses above 4 GB regardless of the address encoding range.

On boards with more than 4 GB of RAM (e.g. 8 GB LPDDR4X), removing
GFP_DMA32 causes two distinct failure modes:

1. Direct allocation above 4 GB: iommu_alloc_pages_sz() may return
   memory above 0x100000000.  The hardware page-table walker issues a
   bus error trying to dereference those addresses, causing an IOMMU
   fault on the first DMA transaction.

2. SWIOTLB bounce-buffer poisoning: without GFP_DMA32, page tables land
   above the SWIOTLB window.  dma_map_single() with DMA_BIT_MASK(32)
   then bounces them into a buffer below 4 GB.  rk_dte_get_page_table()
   returns phys_to_virt() of the bounce buffer address; PTEs are written
   there; the next dma_sync_single_for_device(DMA_TO_DEVICE) copies the
   original (zero) data back over the bounce buffer, silently erasing the
   freshly written PTEs.  The IOMMU faults because every PTE reads as zero.

Restore GFP_DMA32 (and DMA_BIT_MASK(32)) for iommu_data_ops_v2, which
currently only serves "rockchip,rk3568-iommu" in mainline.

Tested on Radxa ROCK 3B (RK3568, 8 GB LPDDR4X):
  - MobileNetV1 via RKNN: 5.8 ms/inference (IOMMU mode)
  - YOLOv5s 640x640 via RKNN: ~57 ms/inference (IOMMU mode)
  - No IOMMU faults, correct inference results

Fixes: 2a7e6400f72b ("iommu: rockchip: Allocate tables from all available memory for IOMMU v2")
Cc: stable@vger.kernel.org
Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/iommu/rockchip-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 85f3667e797..8b45db29471 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1358,8 +1358,8 @@ static struct rk_iommu_ops iommu_data_ops_v2 = {
 	.pt_address = &rk_dte_pt_address_v2,
 	.mk_dtentries = &rk_mk_dte_v2,
 	.mk_ptentries = &rk_mk_pte_v2,
-	.dma_bit_mask = DMA_BIT_MASK(40),
-	.gfp_flags = 0,
+	.dma_bit_mask = DMA_BIT_MASK(32),
+	.gfp_flags = GFP_DMA32,
 };
 
 static const struct of_device_id rk_iommu_dt_ids[] = {
-- 
2.30.2

