Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23D7280A57
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628966; cv=none; b=oJMavd6xw9910y9nT4rUATtJ//uy5aIGqkVgTB38c+Am8r3lOzykmbwYBHGZtJWYbQhMDsGLiN7kCC8u5lUpOaaz4SRx8n/iFADxe3GVkA2cnLTasOCNbvI63c7k6teOt6xkRYy/Fpys1tFm10jaXxmxX4g11h6m7R93BeUOZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628966; c=relaxed/simple;
	bh=nT+JxUktjgaWnv4oVQvfPAtxQF4vQLFdnZTODzxasIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=gGKmNW4MrJbpnmGWCYylT7RZThLlIw4z3R8dH0/jVTF06z+VJ1b9p1ULPyb5HdGv07ZYBD469UeR7M1xOQqmXy+HcTRWFWL6ADBwydQcsMPksjnKCE2It/AdfTydYd3jB+zPWoDHLF+UyaVnewH8yQvHoLLT1laC2dz3oy7TjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=guZjK6sM; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="guZjK6sM"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250507144242euoutp01afed47112f3933e8e4f15344de8bc838~9Rcl2OTIg0139001390euoutp01n
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 14:42:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250507144242euoutp01afed47112f3933e8e4f15344de8bc838~9Rcl2OTIg0139001390euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746628962;
	bh=DbGys0US7skwcuhdvdVwOVZSicDyfO1yb004QE26BKw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=guZjK6sMfp3Due0zdoki94a/Dg56CJlCqj03/DvPwtpLQo3/Xya1JZ1n/zmT5mEIS
	 7t4BjTrPEt1HLXZGXz6lFwhgJYwGIjXjQpkxuTcSlhABw38myQzDZFIyVLUQIwqQKo
	 jjbzMLV514rdjP4BgIf/ih2wEXpfN8Y81dPqf7yY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250507144241eucas1p14542a410069bfe5bc010996ee74b9695~9RcldqLTR0872208722eucas1p1q;
	Wed,  7 May 2025 14:42:41 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250507144240eusmtip204f7fa06fe1ac4f0301c67cd939a4fd8~9RcktY56O2360223602eusmtip2f;
	Wed,  7 May 2025 14:42:40 +0000 (GMT)
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
Subject: [PATCH v2 0/3] media: fix incorrect use of dma_sync_sg_*() calls
Date: Wed,  7 May 2025 16:42:00 +0200
Message-Id: <20250507144203.2081756-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250507144241eucas1p14542a410069bfe5bc010996ee74b9695
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250507144241eucas1p14542a410069bfe5bc010996ee74b9695
X-EPHeader: CA
X-CMS-RootMailID: 20250507144241eucas1p14542a410069bfe5bc010996ee74b9695
References: <CGME20250507144241eucas1p14542a410069bfe5bc010996ee74b9695@eucas1p1.samsung.com>

Dear All,

This patchset fixes the incorrect use of dma_sync_sg_*() calls in
media and related drivers. They are replaced with much safer
dma_sync_sgtable_*() variants, which take care of passing the proper
number of elements for the sync operation.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Change log:
-v2: fixes typos and added cc: stable


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

