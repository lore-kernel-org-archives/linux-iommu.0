Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780742;
	b=TcFVg5t6gA2mv6VxMzMKVCEogSAfZOGEcDzmhyuawrp1qOw9GYgq/3TLed2FDBUPcQ3g
	 M+LONH+dC3bQ9oFBRO6UZHGBrgnmF4pE77kVM7rEQLzxY5caISBd/yLvefrgGCI9qirWy
	 fAcM4AeaLTWCrl/EEIOzdYyr6tJ/7SFZNeUi+BCe5ryEXTo1hufnCtpq8vrDnVUg8yorv
	 cY3mPc0q7Ibl3q1Hdr+thnv8kdeLwKft28ruvXT3CzkAM2o3MMuO76XA9u3upwscOjvdC
	 NYzULgRl7OMY9PcuB9U9Dnz1v4HlGH1Fm3AOEgzEduqokoOW/xZFJPPUiUs3/BYp2OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780742;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=22tX+yU7I7HmNJKs5o0R5O/j6HPhCaItzCZ7BgwjO4k=;
	b=uKkddEsWoCRllD9hJMzuEWDXjY0y0ZbDGjospCKggxDT9Rj3vb1NrmdxT5elbaOwTiVE
	 KA8+fc/Qt4E5ZsqRBtWbANtzGhERvLRkASAYbIxSpJwttMLWSRa1IVJ6ULf10NHpjlf4d
	 wrCbLAhIxMGYfKCw9xHMw7qL51wNXjkVUnv+A5zmbVSjxeD5lcoLj/S12ZnQwM9o+0oLh
	 BblmtHN/51yNQ8a9snvYTVrBv5w7cpffmICp8OOXg1ZfxEMBxnoJqzgzkrVbLd81TlKkv
	 gP71dbY5wIHa0vD1cdZz53sll2WRtHr8ukD4hbhTDSdf1y2LBgv9JIzXynz4XlNEjBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=RonQfvQ6;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F8606A324
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B01F8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=RonQfvQ6
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261127115858euoutp02eaa0a255b29c89825738049075832d29~r5RE7Db2L1288312883euoutp02U
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:58:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261127115858euoutp02eaa0a255b29c89825738049075832d29~r5RE7Db2L1288312883euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795780738;
	bh=22tX+yU7I7HmNJKs5o0R5O/j6HPhCaItzCZ7BgwjO4k=;
	h=From:To:Cc:Subject:Date:References:From;
	b=RonQfvQ6uYtleM8SVajLLe9ZIC2xv34em9i2BT75/+6eiWQIqGrI0jY1rEvBxMoyi
	 jEAvBQ4Eqe7JrBaxVMgj8Bwmd7K9X09akl0DiPVrmnnJTAab/DdHuxJzhFAm2vVflN
	 BhDXuisaKeCn6+9ozn/tNvuYZVYxmvaaknUhaVgE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261127115858eucas1p1ac63e4ce0f221453e8666ab9723a2ae0~r5REn8Iid0792807928eucas1p1q;
	Fri, 27 Nov 2026 11:58:58 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261127115857eusmtip17e501e01b3810e026b6e3248567c99ee~r5RDrUILg0610906109eusmtip1o;
	Fri, 27 Nov 2026 11:58:57 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Honglei Huang
	<honghuan@amd.com>, prakash.gupta@oss.qualcomm.com, Alex Williamson
	<alex@shazbot.org>, Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar
	<abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho
	Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 0/4] iommu/dma: restore flush queue use in
 dma_iova_destroy()
Date: Fri, 27 Nov 2026 12:58:44 +0100
Message-ID: <20261127115849.2780625-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261127115858eucas1p1ac63e4ce0f221453e8666ab9723a2ae0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261127115858eucas1p1ac63e4ce0f221453e8666ab9723a2ae0
X-EPHeader: CA
X-CMS-RootMailID: 20261127115858eucas1p1ac63e4ce0f221453e8666ab9723a2ae0
References: <CGME20261127115858eucas1p1ac63e4ce0f221453e8666ab9723a2ae0@eucas1p1.samsung.com>

Hi,

Commit 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop
the free_iova helper") made dma_iova_destroy() always invalidate the
IOTLB synchronously and free the IOVA directly, bypassing the flush
queue on DMA-FQ domains. As Sibi reported [1], this makes iommu.strict=0
ineffective for NVMe I/O (blk_rq_dma_map()) and costs about 4x of
sequential throughput on SMMUv3 without RANGE_INV.

This series is an alternative to the revert proposed in [1]. Instead of
restoring the free_iova flag, dma_iova_try_alloc() decides once whether
the IOVA space is going to be released through the flush queue and
records that in a new DMA_IOVA_USE_FQ flag in dma_iova_state::__size,
next to DMA_IOVA_USE_SWIOTLB, so struct dma_iova_state does not grow.
dma_iova_destroy() then unmaps with a gather queued according to that
flag and retires it together with the IOVA free, exactly like
__iommu_dma_unmap(): either by iommu_iotlb_sync() or by handing the
IOVA (and any released page table pages) over to the flush queue. The
gather is never left dangling and the IOVA is never returned to the
allocator before a pending queued invalidation, as pointed out by Jason.
dma_iova_unlink() stays strict, as the unlinked range remains owned by
the caller and may be linked again right away. The whole reservation is
still freed, keeping the size fix of the original cleanup.

Storing a flag in the upper bits of __size requires that nobody reads
__size directly, so patches 1-2 convert the venus and iris IOVA
reservation code to dma_iova_size() and patch 3 adds a DMA_IOVA_FLAGS
mask used by dma_iova_size(), dma_iova_try_alloc() and the vfio-pci
dma-buf length check. Patch 4 is the actual fix.

The series has been developped with an aid of LLM, build tested on arm64
and x86_64. Sibi, it would be great if you could rerun your fio test on
top of it.

[1] https://lore.kernel.org/all/20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com/

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (4):
  media: venus: use dma_iova_size() to check the reserved IOVA size
  media: iris: use dma_iova_size() to check the reserved IOVA size
  dma-mapping: add DMA_IOVA_FLAGS mask for the dma_iova_state size flags
  iommu/dma: restore flush queue use in dma_iova_destroy()

 drivers/iommu/dma-iommu.c                     | 111 +++++++++++++-----
 drivers/media/platform/qcom/iris/iris_probe.c |   3 +-
 drivers/media/platform/qcom/venus/core.c      |   3 +-
 drivers/vfio/pci/vfio_pci_dmabuf.c            |   2 +-
 include/linux/dma-mapping.h                   |  14 ++-
 5 files changed, 98 insertions(+), 35 deletions(-)

-- 
2.43.0

