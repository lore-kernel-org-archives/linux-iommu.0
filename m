Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110622A1CB
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512908; cv=none; b=u9Wg1rDWqNx5L4ByyWQB2LHnJm/nHbp36ynF8tCwkfsLjRJalYJRcU79zOpnJitTBQcHPk9pIxRdjpsD0Gv6TvEDU6kKQYZ6p4ZoClsrdH5u/Ctf3xbogSt61K2VMmg+g+PDDJJaDngU0ep2DVPiR/pzISa+6pQjbqGtozzSEc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512908; c=relaxed/simple;
	bh=AHDmzyijp9ZELgL1o7g85JgdlQHpfVV++jmUNt0pl44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=TezmgMyn3DnaXfffJvNbE6UH6hdts5Oi+zBYM1LI9nJ+wsQ1FEBihlADHAOO+1QmykEwfxCZdF4UKodW7YCpmh9LPvxOyZygPaMF4xIIY6d62GS04lpRbOjSPaY1SQ+PkVe1ewz55FiRxAf2ZZo+LJRvrR9tsoaXlXVxzZFEHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L0QfNVNw; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L0QfNVNw"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250320232138euoutp02baed38a7181a8f774fcc76de70cdcfc3~upj_ni4RN3150231502euoutp022
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:21:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250320232138euoutp02baed38a7181a8f774fcc76de70cdcfc3~upj_ni4RN3150231502euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742512898;
	bh=Jgh7/aGnQ8G2WHCuJK0N49oWUWg1YldfBxA4ZHdy2LI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=L0QfNVNwRPosJe8SgrBHCSjPuXflg9A3P5y4iNVLOpb7D2MrhDIQUcTRfDEjal+Xj
	 3jSY+etlkAjMWl8crKFwHwc9AJ3BzejewH7l+l58hNQ1VHcNkwtj9hZFOAeW+p9wNV
	 wfRCVunWjlsKcoCyxfNP0xbwHQPasHv7QPNib0Jo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250320232137eucas1p289da6fe11c17ac87a8faa6ab647746dc~upj_b7M5z2395123951eucas1p2N;
	Thu, 20 Mar 2025 23:21:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id FE.8A.20409.103ACD76; Thu, 20
	Mar 2025 23:21:37 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250320232137eucas1p2f877454de65336d638b200d920ccf2f3~upj9wupIO2394423944eucas1p2L;
	Thu, 20 Mar 2025 23:21:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250320232137eusmtrp2b4030c2d062c85cec93d261b45a0e0f1~upj9wRTqg0223902239eusmtrp2X;
	Thu, 20 Mar 2025 23:21:37 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-63-67dca3018d2a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 53.68.19920.103ACD76; Thu, 20
	Mar 2025 23:21:37 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250320232136eusmtip2d3eb93a765e337482f1f6bb1c6cf220f~upj9cXt820599605996eusmtip2c;
	Thu, 20 Mar 2025 23:21:36 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fix for Linux 6.14
Date: Fri, 21 Mar 2025 00:21:15 +0100
Message-Id: <20250320232115.3940-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djPc7qMi++kGyz/Y2zx64uFxeVdc9gs
	HvW9ZXdg9jgx4zeLx4vNMxk9Pm+SC2CO4rJJSc3JLEst0rdL4MpoWHqHsaCXo2LF/z72Bsa/
	bF2MnBwSAiYS19ZcY+li5OIQEljBKNH6dT4jSEJI4AujxJwbIRCJz4wSN+dvYoTp+PGzkQ0i
	sZxR4smlG+wQDlDHhbaVLCBVbAKGEl1vu8B2iAgYSXx+cYUVxGYWMJf48nMeO4gtDBTf+uUt
	WA2LgKrEvJNLwTbwCthI3Dm8nhlim7zE/oNnmSHighInZz5hgZgjL9G8dTYzyGIJgbfsEv0z
	24AWcAA5LhKn9ldD9ApLvDq+hR3ClpH4v3M+E0R9O6PEgt/3oZwJjBINz29B/WYtcefcLzaQ
	QcwCmhLrd+lDhB0lXl/sZISYzydx460gxA18EpO2TWeGCPNKdLQJQVSrScw6vg5u7cELl6BK
	PCSu7SiDBG6sxKbr75gmMCrMQvLYLCSPzUI4YQEj8ypG8dTS4tz01GKjvNRyveLE3OLSvHS9
	5PzcTYzAVHH63/EvOxiXv/qod4iRiYPxEKMEB7OSCK9Ix+10Id6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4ryL9remCwmkJ5akZqemFqQWwWSZODilGpgy3UR8Iz7Nib/7O0J145Wvl5abcennGJ6e
	OXd38eFjex9X5Eus+3j47pZ/PFKfO3YJf5ycuURI5vLvjTpxRhx3zyyztMtXWR2flcvspMal
	bvNbaqHY0kKXaws/b1krwPf0kXFZo+VVb/PXYfm2RsY3vz0KV1yr9Pv/uhV7HS80nzs/y1r+
	3IWrer+q/Wa/kgiY6H1ugjPX6psX/oo/PybgKLlJKOPRJtuIN8ueJddtqpNwWaxW/snI/HOx
	p9Cs6XV3jTRkdbMcD7U/DyuK/172+13dbsbO+AieC6E2p14EiZbfjnvvc8+w/GDS/5p5+g97
	i/Szd629PmWtgMty18tpqYfdnRK/rsvKa/jDdM5JiaU4I9FQi7moOBEAH7AGIIQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t/xe7qMi++kGyw4wmHx64uFxeVdc9gs
	HvW9ZXdg9jgx4zeLx4vNMxk9Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
	j7UyMlXSt7NJSc3JLEst0rdL0MtoWHqHsaCXo2LF/z72Bsa/bF2MnBwSAiYSP342AtlcHEIC
	Sxkllu+bwwiRkJE4Oa2BFcIWlvhzrQuq6BOjxIojM8CK2AQMJbredoFNEhEwkvj84gpYA7OA
	pcTX63OZQWxhoPjWL2/BalgEVCXmnVwK1ssrYCNx5/B6ZogF8hL7D55lhogLSpyc+YQFYo68
	RPPW2cwTGPlmIUnNQpJawMi0ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBMtx37uXkH47xX
	H/UOMTJxMB5ilOBgVhLhFem4nS7Em5JYWZValB9fVJqTWnyI0RTovonMUqLJ+cBIySuJNzQz
	MDU0MbM0MLU0M1YS53W7fD5NSCA9sSQ1OzW1ILUIpo+Jg1OqgWnqIgWJyfUtyttC5x/b0BQ1
	z3fj43jfTbtWB+R/Ozb9WtVXg8KMnpOdhq9PhXc9E53T8lltc8qXnoJmH6GN9aquHsZZaYe0
	HIyT/zGua11uHnoqOpSN8dmeFZadHsI251RljFlvXXg30Wbj2T+7JzxXbXXlCrhz9qnKUktb
	qfC1VbdSlmoKRF+W4jFV3cjTeHOF7eQPaRLbJ967xzStbM57zw375MvbjczM4128q9pvlauH
	rErYX7fwYIzFXPUZL79eYWPfKrL9/Yc/G/RXr+MNPx5V9H1j+SZ3vavF/zim7Db1WmgXvS3b
	utBnjnWvv9yMcp1fmz4ws97rFcv3tp9nYP79uUTakm8FnK/rZiuxFGckGmoxFxUnAgDeE3UR
	3AIAAA==
X-CMS-MailID: 20250320232137eucas1p2f877454de65336d638b200d920ccf2f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250320232137eucas1p2f877454de65336d638b200d920ccf2f3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250320232137eucas1p2f877454de65336d638b200d920ccf2f3
References: <CGME20250320232137eucas1p2f877454de65336d638b200d920ccf2f3@eucas1p2.samsung.com>

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.14-2025-03-21

for you to fetch changes up to 8324993f60305e50f27b98358b01b9837e10d159:

  dma-mapping: fix missing clear bdr in check_ram_in_range_map() (2025-03-12 13:41:44 +0100)

----------------------------------------------------------------
dma-mapping fix for Linux 6.14

- fix missing clear bdr in check_ram_in_range_map()
  (Baochen Qiang)

----------------------------------------------------------------
Baochen Qiang (1):
      dma-mapping: fix missing clear bdr in check_ram_in_range_map()

 kernel/dma/direct.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
