Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D932389E1F
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260552; cv=none; b=nuov8D6mRz4Cj6/ZdoeeQUDE9Ykhblo5fwQ+7tOcuA+K0uslQcjHStVE7GpMq2BrsvCNxB22GWUq9+GG0mEJ3KzYiKMyBu/aGi8VXDIR8ZxXVYBszNjGF9q2K88dldJaOxKkEVW08zCDj499g4PVAxnuEpaqyeEDgoVZyZPE1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260552; c=relaxed/simple;
	bh=fEiRyeZVJwhFtFqbI0vn6o6cF7AHvm0gYrPdLwNAYQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=H4m0PK5py9Ob8cBTMqmg6pRgVzCQHUEJdeQMTV9KPAfwraMvKUskAdF0R2eRMLbF0zx93/o2OzkcxoE+mM3RxLuI8eoVwzEgFO3SO3GBSDYIm3Jjr24OlFGTQR45kwqP3AXDz4QhAeJhp2BTPqPVArXfuMX78x1QXndEW27/BuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qPpo4h2L; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qPpo4h2L"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260323100908euoutp02a681219d630b99cea254dc6423edc78d~fcJGAsfUR2466124661euoutp028
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260323100908euoutp02a681219d630b99cea254dc6423edc78d~fcJGAsfUR2466124661euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774260548;
	bh=6U023ro9kxomqVcVF/r7g//Mb/LGZ46g5cga3RP+O7c=;
	h=From:To:Cc:Subject:Date:References:From;
	b=qPpo4h2LLV/dgQcUT1G0Ov9ns2N60pTIab7FagGkM7KCU/Y3efhUHvyLoZpJU/m5t
	 wxBXlIN0YeUxt7UtpeqGaUZmzMtDQfbu+CQD7xje0cxP5NBE62W/UJ6du5XZG2ZDQT
	 LV0r+Lj87J8hkA71T2MMeIRmKFCjAkF3vJoUcs4c=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260323100908eucas1p2f471760fe1b26181c9b0cb90dd0739a6~fcJFtZAtx3016530165eucas1p2O;
	Mon, 23 Mar 2026 10:09:08 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260323100907eusmtip2658502ec69d59c68a76f64db0b353a36~fcJFHlhjF0976309763eusmtip2h;
	Mon, 23 Mar 2026 10:09:07 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Saravana Kannan
	<saravanak@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Robin
	Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 0/7] Refactor reserved memory regions handling code
Date: Mon, 23 Mar 2026 11:08:54 +0100
Message-Id: <20260323100901.4079171-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260323100908eucas1p2f471760fe1b26181c9b0cb90dd0739a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260323100908eucas1p2f471760fe1b26181c9b0cb90dd0739a6
X-EPHeader: CA
X-CMS-RootMailID: 20260323100908eucas1p2f471760fe1b26181c9b0cb90dd0739a6
References: <CGME20260323100908eucas1p2f471760fe1b26181c9b0cb90dd0739a6@eucas1p2.samsung.com>

Hello,

The reserved memory regions handling code was reworked to handle
unlimited so called "static" memory nodes in commit 00c9a452a235 ("of:
reserved_mem: Add code to dynamically allocate reserved_mem array").

The side effect of this rework was a set of bugs fixed later by commits
0fd17e598333 ("of: reserved_mem: Allow reserved_mem framework detect
"cma=" kernel param") and 2c223f7239f3 ("of: reserved_mem: Restructure
call site for dma_contiguous_early_fixup()"). As a result, the code in
drivers/of/of_reserved_mem.c became a mix of generic code and CMA
specific fixups.

In this patchset I try to untangle this spaghetti and perform some code
cleanup. I hope nothing breaks this time.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Changelog:

v2:
- added missing ops assignment removal in tegra210-emc-table and swiotlb
  drivers
- fixed issues pointed by kernel test robot and Sashiko: removed typos,
  improved comments
- fixed incorrect node passed to fdt_validate_reserved_mem_node() in
  fdt_scan_reserved_mem_reg_nodes()

v1: https://lore.kernel.org/all/20260313150802.1121442-1-m.szyprowski@samsung.com/
- initial version


Patch summary:

Marek Szyprowski (7):
  of: reserved_mem: remove fdt node from the structure
  of: reserved_mem: use -ENODEV instead of -ENOENT
  of: reserved_mem: switch to ops based OF_DECLARE()
  of: reserved_mem: replace CMA quirks by generic methods
  of: reserved_mem: rearrange code a bit
  of: reserved_mem: clarify fdt_scan_reserved_mem*() functions
  of: reserved_mem: rework fdt_init_reserved_mem_node()

 drivers/memory/tegra/tegra210-emc-table.c |  19 +-
 drivers/of/fdt.c                          |   2 +-
 drivers/of/of_private.h                   |   2 +-
 drivers/of/of_reserved_mem.c              | 318 +++++++++++++---------
 include/linux/cma.h                       |  10 -
 include/linux/dma-map-ops.h               |   3 -
 include/linux/of_reserved_mem.h           |  18 +-
 kernel/dma/coherent.c                     |  19 +-
 kernel/dma/contiguous.c                   |  86 ++++--
 kernel/dma/swiotlb.c                      |  19 +-
 10 files changed, 285 insertions(+), 211 deletions(-)

-- 
2.34.1

