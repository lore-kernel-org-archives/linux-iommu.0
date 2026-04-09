Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317843BE17A
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752039; cv=none; b=Q+tr5pfLLNidum2N4Szu553CuTcQ4juZC3eF4tkxPzkqno3Pr4SN0iRJGn4jQiJD0Q37JYmW0lXV7yITXILiVFwXhrPrvLTxPXH0RbuS0QQ/m8ZGx5Ai7ZRQUj3E0WXB7yDcib0bsVQOEvbBLqECL0rnhJZ3o+V2UXuW4/+y150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752039; c=relaxed/simple;
	bh=dQh+ICDxgU3jEBt/9EkeIXTgeKPJg/we3iq0UjMAvNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=EOOTRZ4tUnBha+uHPPOxQ0zYVCYHLZbBGq0FB2p+UiT3l05+QfbwM851HgkLV5nfKhd1/aQAs/ghGhlC1iF4oV2AM8TyTmtirccS84bYX4qd2QNVqLDcoLzomZCpB+Kuti8Dil80z2urcF+4qbuTm0/ayUBpER/PTlWajOuhRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kXM78Yp2; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kXM78Yp2"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260409162707euoutp01e1eaafe77e170e851cb62042c29efe16~kvQ91000a2868228682euoutp01h
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 16:27:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260409162707euoutp01e1eaafe77e170e851cb62042c29efe16~kvQ91000a2868228682euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1775752027;
	bh=6J1qyqLUBDHDg/Ha6SGgGKDIFjScNUYlnRBxiyazWDg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=kXM78Yp2O/K8hcQxGsNBfJkhXY/7ojip0nlu8kMT4E8xLqYKcnnoJ3zb265Ns2SnX
	 gSzXnovFwRfwFgANmwjn3Ublnps20CQuLCpZyzcqF54AuvqsbTYhts7/uetpBHlRMk
	 OInJAlNLMckEpKmdRi0VYcuM2OsnfyU7THrNrHgk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260409162706eucas1p1823b4c676d51c8c9875fbba53e3a4db5~kvQ9gEDPt2918129181eucas1p13;
	Thu,  9 Apr 2026 16:27:06 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260409162706eusmtip2b5bbc441a7f3ce9769f9d40526f07aa0~kvQ9LhZrZ2199021990eusmtip2B;
	Thu,  9 Apr 2026 16:27:06 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Mikhail
	Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [GIT PULL] last dma-mapping fix for Linux 7.0
Date: Thu,  9 Apr 2026 18:27:01 +0200
Message-Id: <20260409162701.3657907-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260409162706eucas1p1823b4c676d51c8c9875fbba53e3a4db5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260409162706eucas1p1823b4c676d51c8c9875fbba53e3a4db5
X-EPHeader: CA
X-CMS-RootMailID: 20260409162706eucas1p1823b4c676d51c8c9875fbba53e3a4db5
References: <CGME20260409162706eucas1p1823b4c676d51c8c9875fbba53e3a4db5@eucas1p1.samsung.com>

The following changes since commit 2cdaff22ed26f1e619aa2b43f27bb84f2c6ef8f8:

  dma-mapping: add missing `inline` for `dma_free_attrs` (2026-03-25 08:01:21 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-04-09

for you to fetch changes up to 3d48c9fd78dd0b1809669ec49c4d0997b8127512:

  dma-debug: suppress cacheline overlap warning when arch has no DMA alignment requirement (2026-03-30 09:41:18 +0200)

----------------------------------------------------------------
last dma-mapping fix for Linux 7.0

A fix for DMA-mapping subsystem, which hides annoying, false-positive
warnings from DMA-API debug on coherent platforms like x86_64 (Mikhail
Gavrilov).

----------------------------------------------------------------
Mikhail Gavrilov (1):
      dma-debug: suppress cacheline overlap warning when arch has no DMA alignment requirement

 kernel/dma/debug.c | 1 +
 1 file changed, 1 insertion(+)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
