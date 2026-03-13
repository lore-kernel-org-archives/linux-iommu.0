Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DEE397E90
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414495; cv=none; b=P56tl/m6zJIjipydD9HjGtmPVU2vTDxg9PbrfmT/MG+U4Ta8/ww/06zgA/zgwA+iAQFAzze6zPx5FFp32Z5z3PdDmRl+rxucITHKt8gaKI4IBRQ6KR2a7NSrsg2gJCe9d0vHkK7MFJgKuWUh2pAI60OdrBvwMqTXIFXCNgkgudE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414495; c=relaxed/simple;
	bh=ST+7NIYtJCOYQkvOnHtK+3x4EgE/BOwVjC/OYpZE3ng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=V+J9/6XaPHhxo33T55v6zQgfm7D8CiL661ahz7WLqb9QNrjlCxLa7Fw51tfLY0r864zfPYfjaTjFdMOYA6cw+OaZLCDcfSwnpLeGeRFM5SN9VTBy2fEgUilOWajmf9M5EggFTF1AHCrH4IRrDwfPo26inoq+Sazu1Aqk+SXBVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kSqUTRdF; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kSqUTRdF"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260313150810euoutp01889703a9cde539926996df2c063b7bcd~cbxU44tLI2418424184euoutp01D
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260313150810euoutp01889703a9cde539926996df2c063b7bcd~cbxU44tLI2418424184euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773414490;
	bh=ieZsFx6ApTvtzCX6XrisGuhU15p9rYRXxzDN/ZilEbc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=kSqUTRdFlhls6LGeB/gW1ePORD385noPahaD89ukVIdsLtkfmMLxMi1hRSBM4a4+s
	 fLmeERysE9XYIVodCKyzifD1u2T5SvBRSOzM43fsVtseGFxrnWB07C+7kojwAFbKOt
	 /zBYM+9w+x09ZcKH02ijpFMVQTAyrDmU+2PMlACI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260313150809eucas1p169ab0904a217a04e0601e2ef01854c73~cbxUNE6ka1866218662eucas1p1i;
	Fri, 13 Mar 2026 15:08:09 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260313150808eusmtip1d9210d2958f7bd448b7051b9db3217fc~cbxTpGxpl0299002990eusmtip1w;
	Fri, 13 Mar 2026 15:08:08 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 0/7] Refactor reserved memory regions handling code
Date: Fri, 13 Mar 2026 16:07:55 +0100
Message-Id: <20260313150802.1121442-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260313150809eucas1p169ab0904a217a04e0601e2ef01854c73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260313150809eucas1p169ab0904a217a04e0601e2ef01854c73
X-EPHeader: CA
X-CMS-RootMailID: 20260313150809eucas1p169ab0904a217a04e0601e2ef01854c73
References: <CGME20260313150809eucas1p169ab0904a217a04e0601e2ef01854c73@eucas1p1.samsung.com>

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

Patch summary:

Marek Szyprowski (7):
  of: reserved_mem: remove fdt node from the structure
  of: reserved_mem: use -ENODEV instead of -ENOENT
  of: reserved_mem: switch to ops based OF_DECLARE()
  of: reserved_mem: replace CMA quirks by generic methods
  of: reserved_mem: rearrange code a bit
  of: reserved_mem: clarify fdt_scan_reserved_mem*() functions
  of: reserved_mem: rework fdt_init_reserved_mem_node()

 drivers/memory/tegra/tegra210-emc-table.c |  17 +-
 drivers/of/fdt.c                          |   2 +-
 drivers/of/of_private.h                   |   2 +-
 drivers/of/of_reserved_mem.c              | 289 ++++++++++++----------
 include/linux/cma.h                       |  10 -
 include/linux/dma-map-ops.h               |   3 -
 include/linux/of_reserved_mem.h           |  18 +-
 kernel/dma/coherent.c                     |  19 +-
 kernel/dma/contiguous.c                   |  86 +++++--
 kernel/dma/swiotlb.c                      |  18 +-
 10 files changed, 256 insertions(+), 208 deletions(-)

-- 
2.34.1

