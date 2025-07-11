Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EFC19D07A
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217287; cv=none; b=FjbSD9g7RQ32Nx1+abHud8q/sHmoT5Jup7aCXwMzzotPJEvEhFbiu65xpzA5ebstZ1MCK8rlSqJb9x/ZMeSKayh0+RVyfX/Cn2+++uPpiExc/g47VR8hSqA6SlbGcNIqKlRqL0CvU+AXG3L+0PnZrMtFckpo2QyHE0vAH7+nOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217287; c=relaxed/simple;
	bh=JIOnGgolu/COLOQppNdzEF05M+7NretGhi5gKwNtgYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=W6BVZT1zK1OPqYaAtJsUok2R8carXjfZty4Q+UcROec6oQMCy5es3DD3lnOq+ejDVCFRd2e8WbroE1hU8qdSupdxy2dt4et6KKq/r5FVYETMtKWCWBIt0mk4l7mNl1Ym+XUwOgRiOlpd2kLj2FAVWERBHWjhYD4lYD2MIgkpNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X3KmgkOg; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X3KmgkOg"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250711070117euoutp0288a9615b70973bd8631992668a3bba3b~RIFSh84pp1393713937euoutp024
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 07:01:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250711070117euoutp0288a9615b70973bd8631992668a3bba3b~RIFSh84pp1393713937euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752217277;
	bh=79bKppBldYti/ypqiN2CkZAAnEEIsuoO0YIZOoHX1RE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=X3KmgkOgWtbVi694Oysshe0SNSyaRlttMC/eff2ZRCQ7Rfcj5KMV5i4Q1vTP89iXw
	 MThWwJ3AHdK7e//Y9bdVpaXPQgsBrIZp2ogQ6RJ6X2/czLAOcn3NvjEH+1zA8/bIph
	 mil2KXEWEbffBSQgIs/ff+c0t/DWNxN+2pLaZQGY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250711070117eucas1p2788fee3599caf71ac5f0a5f811f6c6bb~RIFSTaXKZ1251012510eucas1p2o;
	Fri, 11 Jul 2025 07:01:17 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250711070117eusmtip2a4f965f590b2644d81d83724ea0b249d~RIFR9Ewm80454804548eusmtip2H;
	Fri, 11 Jul 2025 07:01:17 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Feng Tang <feng.tang@linux.alibaba.com>
Subject: [GIT PULL] dma-mapping fix for Linux 6.16
Date: Fri, 11 Jul 2025 09:01:02 +0200
Message-Id: <20250711070102.4071882-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250711070117eucas1p2788fee3599caf71ac5f0a5f811f6c6bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250711070117eucas1p2788fee3599caf71ac5f0a5f811f6c6bb
X-EPHeader: CA
X-CMS-RootMailID: 20250711070117eucas1p2788fee3599caf71ac5f0a5f811f6c6bb
References: <CGME20250711070117eucas1p2788fee3599caf71ac5f0a5f811f6c6bb@eucas1p2.samsung.com>

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.16-2025-07-11

for you to fetch changes up to aa807b9f22df2eee28593cbbabba0f93f4aa26c1:

  dma-contiguous: hornor the cma address limit setup by user (2025-06-12 08:38:40 +0200)

----------------------------------------------------------------
dma-mapping fix for Linux 6.16

- small fix relevant to arm64 server and custom CMA configuration
  (Feng Tang)

----------------------------------------------------------------
Feng Tang (1):
      dma-contiguous: hornor the cma address limit setup by user

 kernel/dma/contiguous.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
