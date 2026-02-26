Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6A3A0E8C
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145938; cv=none; b=XFzbiiTpKAmbIo+lswNhpOS46wKInxfJICmQWxZckyJm0afKGupEYE6BDkecF3eYs/wpElUrI1Ys/lWsvWedSamfq+rL60d2X7ffibpAIFES+tLAVCtQbJQ3mhCDjljHcsMRtqUrgzuQhmg+WQB8uJPGedKjwqqxUKm4/b1pVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145938; c=relaxed/simple;
	bh=WwX1gvvJGt0VahDNgFoIkfqyoAP48uKGgLQ7HW1SEfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=eooe0IyyaosWGRUQotuiNzefXMNoMiC3Fk0kk0uIlUbBOEub05w7yQ4HPqtzuYJs0av9nOCtFUhOgP6sf+asYyuwruZxTxNGPzj03dZ7Hua4cZUD3tREuuhGGRzxm0Pu4icMgwzuABwxQ2nloE6mCN38JNgZ3hazunNXLun78Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hBIkp5Pu; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hBIkp5Pu"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260226223635euoutp02c26a7f62fd23be378a366f1e38e1a015~X7NkhrLz11714217142euoutp02j
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 22:36:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260226223635euoutp02c26a7f62fd23be378a366f1e38e1a015~X7NkhrLz11714217142euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772145395;
	bh=xn/RSYl5kynI3db3PQly25wMU7g2D1TVBjqvWQPgtos=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hBIkp5PuJyETy+yPydiiuSc9SAmP/0Ks9jGEXubyRw1QvEJgzW3wreJVYVwvE3Ql/
	 Qh2TpXo5Tc+vqkJcwenyJihD0aBC/2SVVvquZnXYTCdF94PlXRZjvBt/L12zJuKKbf
	 FCXWr2x/lwB57RB+iqlA1SRDW689Lzi4/S7/oGkU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260226223635eucas1p25ed99f07826bffde88f607c822ef350a~X7NkHop-_0456404564eucas1p2k;
	Thu, 26 Feb 2026 22:36:35 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260226223634eusmtip1d2979af906e303175b86f16191977c53~X7NjvFc1f0173601736eusmtip1B;
	Thu, 26 Feb 2026 22:36:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Stian
	Halseth <stian@itx.no>, Jiri Pirko <jiri@resnulli.us>
Subject: [GIT PULL] dma-mapping fixes for Linux 7.0
Date: Thu, 26 Feb 2026 23:36:20 +0100
Message-Id: <20260226223620.873540-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260226223635eucas1p25ed99f07826bffde88f607c822ef350a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260226223635eucas1p25ed99f07826bffde88f607c822ef350a
X-EPHeader: CA
X-CMS-RootMailID: 20260226223635eucas1p25ed99f07826bffde88f607c822ef350a
References: <CGME20260226223635eucas1p25ed99f07826bffde88f607c822ef350a@eucas1p2.samsung.com>

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-02-26

for you to fetch changes up to d5b5e8149af0f5efed58653cbebf1cb3258ce49a:

  sparc: Fix page alignment in dma mapping (2026-02-23 08:33:51 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 7.0

A set of two fixes for DMA-mapping subsystem for the recently merged API
rework (Jiri Pirko and Stian Halseth).

----------------------------------------------------------------
Jiri Pirko (1):
      dma-mapping: avoid random addr value print out on error path

Stian Halseth (1):
      sparc: Fix page alignment in dma mapping

 arch/sparc/kernel/iommu.c     | 2 ++
 arch/sparc/kernel/pci_sun4v.c | 2 ++
 kernel/dma/direct.h           | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


