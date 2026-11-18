Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010482;
	b=LSc9USGIN9m1meFT8dezlPuOU4ss9zcBY7MGJihEbHrNZcP6kw8xdkxvvm+W2L3aBnw3
	 PbAbkIgkrdAWjVM06jvT3L2r2+78HJSExsy7u3RLsUpbxRj5gUUKW2nxOtfN6INy6HKI9
	 G1Gxoqjlf26uZYK8NEC2jDdwUsn9ZlWSZM83/afvh/6kAsH+qdCA786ISvi3n8/gIdkNc
	 oI3q+owu33zV3p/LNBE6vFSf7CWFEsilznCr1MYZW4G4NaYGpD9NULfA0yexLNkdkTbkT
	 j+KX5dj7+3YxuwVc1V0Zg5DcRoMJQQqYfyK7qv1q5UKThzyzNxTFDn6jancuziol/3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010482;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=wQ/2jUYFKVawqfmCq9N92iagih9sJQ5jouErSdo6RaA=;
	b=H10xkC/8dfqQMy+f/I0rZ13l3qLgXx8EcB9Axqh+3IuaMnqhAVxNNg44moPECpz8Pmwm
	 IfAtW52AM5rU0H1OG5bcpilTaf3XUJQgAGWsjp46IC09vlmwa+6CBcb1y5K16W8fg022e
	 zCQXKR3j37t60xAbvKcmBBOrTPIEuCoG/Y3eyqnJiTeP5afMJV28/WLBqlXu/SGuWwFFF
	 MgLAqp4Q/uMxOZdt7TwsEBmG5HQY2C1vlXwo/79NIFWTVC4mvMMf5KtsDM/DX1PhkTFAG
	 tEHxVIrLvsBAH0X6HTHKp0w8fbqqegD5NGm9bhVHKVTcwzG7LgSEn8a8Gm1mCxXdg9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=j6sfakvh;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B7606A33D
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 14:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF7B7606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=j6sfakvh
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261118140113euoutp0268c9d84719128f826cd94471d7202824~pKIPZXDzN3075830758euoutp02_
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 14:01:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261118140113euoutp0268c9d84719128f826cd94471d7202824~pKIPZXDzN3075830758euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795010473;
	bh=wQ/2jUYFKVawqfmCq9N92iagih9sJQ5jouErSdo6RaA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=j6sfakvhYQqBwc62F20ON+yLmmkU969m7faGY2WExdknOVv4t6zj9QBspjbyFl7Cr
	 Y28Z+BAuPzwQduhMAf+aHbIROagi0aOgBBEVPXq9xW8GOi9cNKI9kEglEQ452gbjUT
	 v8WRHzwv+SI2SoGcCtf+sZN/Jv8DP0PiOgkJfqPw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261118140112eucas1p1f60a3d28537856e94a285334dc1e2f58~pKIPGQhrl2369423694eucas1p1A;
	Wed, 18 Nov 2026 14:01:12 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261118140112eusmtip29a314bd4e0df4a5648b5dcf218673c23~pKIO1YYEK1853118531eusmtip2X;
	Wed, 18 Nov 2026 14:01:12 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Subject: [GIT PULL] dma-mapping fixes for Linux 7.4
Date: Wed, 18 Nov 2026 15:00:59 +0100
Message-ID: <20261118140101.249506-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261118140112eucas1p1f60a3d28537856e94a285334dc1e2f58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261118140112eucas1p1f60a3d28537856e94a285334dc1e2f58
X-EPHeader: CA
X-CMS-RootMailID: 20261118140112eucas1p1f60a3d28537856e94a285334dc1e2f58
References: <CGME20261118140112eucas1p1f60a3d28537856e94a285334dc1e2f58@eucas1p1.samsung.com>

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.4-2026-11-18

for you to fetch changes up to 14866e632fa48a0b4c385ab0121526575eb8f88c:

  dma-pool: decrypt pages before creating the shared remap (2026-11-16 11:29:54 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 7.4

Various fixes for the issues identified by sashiko.dev review
system in the dma-mapping helpers (Marek Szyprowski):
- added serialization to reserved memory region initialization
- fixed initialization of the shared memory for confidential
  computing memory pools
- fixed error and exit code paths

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

----------------------------------------------------------------
Marek Szyprowski (6):
      dma-coherent: serialize reserved memory pool initialization
      dma: swiotlb: Serialize restricted DMA pool initialization
      dma-pool: release CMA pages on atomic_pool_expand() error path
      dma: swiotlb: Round restricted DMA pool size down to IO_TLB_SEGSIZE
      dma: swiotlb: Properly tear down the default pool on exit
      dma-pool: decrypt pages before creating the shared remap

 kernel/dma/coherent.c | 11 ++++++++++-
 kernel/dma/pool.c     | 51 ++++++++++++++++++++++++++++-----------------------
 kernel/dma/swiotlb.c  | 35 ++++++++++++++++++++++++++++++++---
 3 files changed, 70 insertions(+), 27 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


