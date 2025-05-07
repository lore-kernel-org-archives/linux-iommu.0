Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270C17E4
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634165; cv=none; b=b/S1OfXvr6j8lhRu3yGJ0gieQlycgM8xQdW1yEV8xnfTRx50rQiEV9kMfISIItzzdAmLt3kZMXvkepr48i3Qzx8fil28h/0FTCMJ/cj9/+9XAMXohoaqlnn4nxbuHzdAjlT2ktpu+0ZYE7PnEMk+AXGdKehKEY28s7Je8oGMrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634165; c=relaxed/simple;
	bh=suPZKkjGhRg9EAuSjppkmBzvFftFp11slWdLXQv1Hao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ju+cnQG08UCbFyAAjMK1uHQ2Qjw0u9dwAMJyuTTJIuMI3IgJiS/PpotdUQs2Xbf7tVMSUkFf1BgzNcr6Vd/Sv7bnbS3LDl9TQxKRxdsDC/6oSJeeOwDv9v/57NoFHEX9Px4PylJYLtAkmANCPdBscQHnSVnaU7oB20Wnnp2I9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BoKCKYCM; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BoKCKYCM"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250507160921euoutp0184da43719e5b2e0fd21ad74aed1577e1~9SoQa4UFB0089500895euoutp01C
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 16:09:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250507160921euoutp0184da43719e5b2e0fd21ad74aed1577e1~9SoQa4UFB0089500895euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746634161;
	bh=KPYpTlVpZwaG6GOkibqncFdwORzfVt/MImPhX3ya/XQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=BoKCKYCMynC47Di5LPknPPpomQBFDwq7Pb4RZrltPwv2EKudSWU0702DyhBBbbvVN
	 hE6krwlJmTiuplOKd5dKOBrRV0SAvxiQ2j3Gl1kqJd5amc6EdIOoHv0QVXsZfx7LhK
	 no7mqFtX0ZiSh1VlC86uKS72k16mAvBKZsrr3s6Q=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250507160921eucas1p1de6aa7aa265a65c6591bb4c3250e9dc4~9SoP5GAJB0253102531eucas1p1t;
	Wed,  7 May 2025 16:09:21 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250507160920eusmtip190ce670373e3f71f7f451105df96c3a7~9SoPIwfPf0592705927eusmtip1X;
	Wed,  7 May 2025 16:09:20 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa
	<tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey
	Senozhatsky <senozhatsky@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
	Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy
	<vivek.kasireddy@intel.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Gurchetan
	Singh <gurchetansingh@chromium.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 0/3] media: fix incorrect use of dma_sync_sg_*() calls
Date: Wed,  7 May 2025 18:09:10 +0200
Message-Id: <20250507160913.2084079-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250507160921eucas1p1de6aa7aa265a65c6591bb4c3250e9dc4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250507160921eucas1p1de6aa7aa265a65c6591bb4c3250e9dc4
X-EPHeader: CA
X-CMS-RootMailID: 20250507160921eucas1p1de6aa7aa265a65c6591bb4c3250e9dc4
References: <CGME20250507160921eucas1p1de6aa7aa265a65c6591bb4c3250e9dc4@eucas1p1.samsung.com>

Dear All,

This patchset fixes the incorrect use of dma_sync_sg_*() calls in
media and related drivers. They are replaced with much safer
dma_sync_sgtable_*() variants, which take care of passing the proper
number of elements for the sync operation.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Change log:
v3: added cc: stable to tags
v2: fixes typos and added cc: stable


Patch summary:

Marek Szyprowski (3):
  media: videobuf2: use sgtable-based scatterlist wrappers
  udmabuf: use sgtable-based scatterlist wrappers
  media: omap3isp: use sgtable-based scatterlist wrappers

 drivers/dma-buf/udmabuf.c                         | 5 ++---
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 4 ++--
 drivers/media/platform/ti/omap3isp/ispccdc.c      | 8 ++++----
 drivers/media/platform/ti/omap3isp/ispstat.c      | 6 ++----
 4 files changed, 10 insertions(+), 13 deletions(-)

-- 
2.34.1

