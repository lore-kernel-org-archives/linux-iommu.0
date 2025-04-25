Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC1242D7E
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580608; cv=none; b=GyaA0mFf0lIAhl/8T79/JoGV6Aea0adERS/8D49wnETYTMqa+IZsmfSpHW8CIBYy+ueXAhfJSCtLqLh+bzT1gt6ngjQf4x8F5qJNEjTNu+Nzr2DdDy4gMJj6Ogm2fRMnCskHCqJZKN5XWoS8tpsswzeXnuIseXmwaeLeohxLUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580608; c=relaxed/simple;
	bh=t23Xl2aGJqI5dCFOLXadAg2Ch/8/EBXNLbMaJ8LntOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=dSmx7dbDmsdZWDshY3/qfq45IZNWDTp6PqQoa1F1PHjJZZjcc9+R26buLbE5mFzN4hDrwGFGDl0pOnHbuetdpfwl8V3lI7BUzk13gUqNSd5K67WRcMqrImMUxWbb/BV2BkpLMIkbecEVpQubcZSv0mjHCpbKGp85T77VXnhnL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DggQIO1D; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DggQIO1D"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250425112957euoutp02552e413cf01c33462aec12689a588064~5jE4k8Bj92987329873euoutp02P
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 11:29:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250425112957euoutp02552e413cf01c33462aec12689a588064~5jE4k8Bj92987329873euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745580597;
	bh=Zlx0XyWwMoPWWBL42Jl0fyK9NUIVNTNt8hE5fXcMSVA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=DggQIO1Dn3hqdBnUpk9T3ndOj6HfxgRuLYgJzeJ5XvFDzddAjdey3Zq+fb/6qiNkp
	 hc/n1AFV4enKhldXIwxW856J4Fczh5N/d/bxid4RhGyomtCEIXLgsJMZzf64yNwzmP
	 s83pyW5DsmIA5TOTlmVZwbGyzyfXSfpBbU18HOrw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250425112957eucas1p281bfd7cf959d48b35649ce4b9827798d~5jE4VDFiR2263022630eucas1p2N;
	Fri, 25 Apr 2025 11:29:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 06.26.00837.5327B086; Fri, 25
	Apr 2025 12:29:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250425112957eucas1p110e8b84689ce013eb26967a47681ee75~5jE4DxSlQ3274832748eucas1p1z;
	Fri, 25 Apr 2025 11:29:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250425112957eusmtrp1be696d5f4241fd870afbbb9ab46a2f1f~5jE4DWGcc1393913939eusmtrp1U;
	Fri, 25 Apr 2025 11:29:57 +0000 (GMT)
X-AuditID: cbfec7f2-32fff70000000345-6e-680b72355e8e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 03.D7.19654.5327B086; Fri, 25
	Apr 2025 12:29:57 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250425112956eusmtip2230eed71c84b4db44d3bc79fddcfc277~5jE3sVOkN1539315393eusmtip2_;
	Fri, 25 Apr 2025 11:29:56 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>
Subject: [GIT PULL] dma-mapping fixes for Linux 6.15
Date: Fri, 25 Apr 2025 13:29:39 +0200
Message-Id: <20250425112939.501985-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djPc7qmRdwZBhMPK1j8+mJhcXnXHDaL
	tUfusls86nvL7sDicWLGbxaPF5tnMnr0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxtS7k1gL
	3vBUtN5by9rAeJWri5GTQ0LAROL6l81MXYxcHEICKxgl3q66AuV8YZT4/+4dK4TzmVFiz7HF
	zF2MHGAt+3cqQcSXM0q0rNnDCtex+dMzZpC5bAKGEl1vu9hAbBEBI4nPL66wgjQzC6RJrLyr
	DxIWBppz5fk/dpAwi4CqxIf5eSBhXgE7iUv/H7NCXCcvsf/gWWaIuKDEyZlPWEBsZqB489bZ
	zCBrJQT+skvsuz4XqsFF4vi8y+wQtrDEq+NboGwZidOTe1ggGtoZJRb8vs8E4UxglGh4fosR
	ospa4s65X2wQh2pKrN+lDxF2lJhwdjkrxPN8EjfeCkIcwScxadt0aJjwSnS0CUFUq0nMOr4O
	bu3BC5eYIWwPibc//4KdKSQQK9H24jnrBEaFWUhem4XktVkINyxgZF7FKJ5aWpybnlpsmJda
	rlecmFtcmpeul5yfu4kRmD5O/zv+aQfj3Fcf9Q4xMnEwHmKU4GBWEuFdas2dIcSbklhZlVqU
	H19UmpNafIhRmoNFSZx30f7WdCGB9MSS1OzU1ILUIpgsEwenVAOT0tub4tI7fhq+rn8iPTc7
	dILoSqd0H9PTHW4+z891PDQQZnF5wzVZQc9gp+Cn/2wxJ5LmudXanlzu4Ji41MQx/pmm4Jf2
	BwofT9/gyJWZs7CPI+mp/A11SeYtN/UUV7K5+t9YtrTi2TPXllKW3sTWYz8Lv0jdnaz7oOu4
	wKeXT3y6uD/EqP6z3m1alfdFruvRjaXPH/xOkyoscHQ6f+jjAv5ri9mt1SeG6Uo5K33kZCs/
	4Ne+/dSrhWf4Tt6cMuf///Wm1gU+PfMebKxkzMgpvfR/T7zmfZWjHgbB60tEp3RHNej+SjOr
	uCNcuWRLu2ReKl+I6anZ6gG3pFoMf3lofNzlf1hGzLt1+qYTte+UWIozEg21mIuKEwHksUPI
	jgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsVy+t/xe7qmRdwZBnv+cVr8+mJhcXnXHDaL
	tUfusls86nvL7sDicWLGbxaPF5tnMnr0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGe
	oaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJextS7k1gL3vBUtN5by9rAeJWri5GDQ0LA
	RGL/TqUuRi4OIYGljBLtJ46ydjFyAsVlJE5Oa4CyhSX+XOtiA7GFBD4xSkxe6QBiswkYSnS9
	hYiLCBhJfH5xhRVkJrNAhsSeSbIgYWGg8Vee/2MHCbMIqEp8mJ8HEuYVsJO49P8x1HR5if0H
	zzJDxAUlTs58wgJiMwPFm7fOZp7AyDcLSWoWktQCRqZVjCKppcW56bnFRnrFibnFpXnpesn5
	uZsYgSG77djPLTsYV776qHeIkYmD8RCjBAezkgjvUmvuDCHelMTKqtSi/Pii0pzU4kOMpkDn
	TWSWEk3OB0ZNXkm8oZmBqaGJmaWBqaWZsZI4L9uV82lCAumJJanZqakFqUUwfUwcnFINTFXK
	qxhuv9t+XHLbpHhj1TvRqyYZv/qhPCdWwqXyhs4Z9/T4r538m5jlnv38cFGq7ZiWhLqHrbHs
	uluPivc9M1vdkDt7NcvVbaKRHe7eEzd6XF05c+qnszZrC5VaDrJ/N8jzk93ud+dduHiOtVKB
	xIS+Z23rvSU/cX4Q1tzZFqHqMs/i2Kc+s/rMLb6RR2+zSB0K1XSe8Mw4WVj/+3I71W5RXePU
	7dacrnflJtqlr/M4d9zE4K4HZ+Fix2lPs6yadIReK3Fdbt75d29ZiWjK7vAzCXPvKS0S7dVJ
	Wnaw2Ci6QPNNa8YhZ1eeN/51dn6W542lvjbfk6z5vO3K5F3mldt4YxZu6Qy+d/W+dfYTJZbi
	jERDLeai4kQAaJWmbOICAAA=
X-CMS-MailID: 20250425112957eucas1p110e8b84689ce013eb26967a47681ee75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250425112957eucas1p110e8b84689ce013eb26967a47681ee75
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250425112957eucas1p110e8b84689ce013eb26967a47681ee75
References: <CGME20250425112957eucas1p110e8b84689ce013eb26967a47681ee75@eucas1p1.samsung.com>

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.15-2025-04-25

for you to fetch changes up to 89461db349cc00816c01d55507d511466b3b7151:

  dma-coherent: Warn if OF reserved memory is beyond current coherent DMA mask (2025-04-22 17:44:09 +0200)

----------------------------------------------------------------
dma-maping fixes for Linux 6.15

- avoid unused variable warnings (Arnd Bergmann, Marek Szyprowski)
- add runtume warnings and debug messages for devices with limited DMA
  capabilities (Balbir Singh, Chen-Yu Tsai)

----------------------------------------------------------------
Arnd Bergmann (1):
      dma/contiguous: avoid warning about unused size_bytes

Balbir Singh (2):
      dma/mapping.c: dev_dbg support for dma_addressing_limited
      dma-mapping: Fix warning reported for missing prototype

Chen-Yu Tsai (1):
      dma-coherent: Warn if OF reserved memory is beyond current coherent DMA mask

Marek Szyprowski (1):
      dma-mapping: avoid potential unused data compilation warning

 include/linux/dma-mapping.h | 12 ++++++++----
 kernel/dma/coherent.c       | 12 +++++++++---
 kernel/dma/contiguous.c     |  3 +--
 kernel/dma/mapping.c        | 25 +++++++++++++++++--------
 4 files changed, 35 insertions(+), 17 deletions(-)
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
