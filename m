Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780742;
	b=Bw5e0wcLp52Ci9CUZoJnDiETRFekoZoEYV2+FhH1u43xcukF70YK11U0sYzGuJeMvJCU
	 V7MGyT5eMyNZTnjuFJsw5X9cByL1uLZmuNJXRpY9sQGOjLOdnqft6/TWTnxux16Bf/CjB
	 f9DqZe0lWjFDRHpz3QsQ8UocflD/VOzJhD3TQv5AbMAMGX4EdTADj28pge4ZP3EG5qGID
	 p9DwaZHxYTtJW5nHkOW5S/s0jz8K9KjTKyCFEQ94vS1hGumtqbUfq8DXKV52A1AiIUlom
	 LTD3C2rV3a7PGusH6oGM6EQtFL1J60lrYOr8uvLK5xNowvx6U31ci+/iuEzaN2/DjMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780742;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=kU/vWsvzp/oeLbWN7RubnpobMMTsDvkHbxerPWgHnis=;
	b=g5vtevGC675PS2nuYdWgio7680/lzdLm7deNgncFMqZeh9h9gNn34K93faoLcPA80b+5
	 Jaw3rvl7rUbHu0cqWwDu1qCdnu6dGuXCoz7h06I8pQQpkpx7W6LMCmj8OOiPqdqSkilzu
	 hPkeN+8NcEV7/PIaxmeXq6t7Z580S+hffe6f0m5Ugy7wXIOypdqMgXUM+t5ibQDtl/0v/
	 d+dCyVsb3wb9wNGEuGYZn45MW2OjGmrmM+J9x2qjsTvfDGVRixZmvVAQXSsKpO1G6n0Fs
	 N3gy+KaH+AOFK3zDE2nNUi5fQOcVBsrMzBjUlZPGmI8io5u2Leo5hQbb8CcfIN9kV9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="g/ETUpOx";
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3030C606A32C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3030C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=g/ETUpOx
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261127115859euoutp01d8b158fb51b37a4f9a7083a2b09b2f0e~r5RF9kIlj2568325683euoutp01Y
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:58:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261127115859euoutp01d8b158fb51b37a4f9a7083a2b09b2f0e~r5RF9kIlj2568325683euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795780739;
	bh=kU/vWsvzp/oeLbWN7RubnpobMMTsDvkHbxerPWgHnis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/ETUpOxD/ZT0Oi4ngNjjkxmcCs2PjgFbZIjtugjnIvBV8v/PCWi5b70lRdHRBgEY
	 J8aArwdHqiPq2Or+U5kHx6JPJhjRYBgyDw0xogGec9Df4A/835VSe/KLxsZCUQG9nX
	 +p7D1rf4O8d4gCXWMoZUJMN75GEyngQrOh/tjRiU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9~r5RFsd37W0787907879eucas1p1w;
	Fri, 27 Nov 2026 11:58:59 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261127115858eusmtip1fe13b1aeb26ee1104c142b331f20a2bc~r5REtVNTR0670706707eusmtip1t;
	Fri, 27 Nov 2026 11:58:58 +0000 (GMT)
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
	Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] media: venus: use dma_iova_size() to check the reserved
 IOVA size
Date: Fri, 27 Nov 2026 12:58:45 +0100
Message-ID: <20261127115849.2780625-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127115849.2780625-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9
X-EPHeader: CA
X-CMS-RootMailID: 20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
	<CGME20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9@eucas1p1.samsung.com>

The IOVA reservation code compares dma_iova_state::__size directly with
the requested chunk size. __size is internal to the DMA IOVA API and may
carry flags in its upper bits, so use the dma_iova_size() accessor
instead.

Fixes: 953439251b59 ("media: venus: Fix iova allocation from restrict region")
Cc: stable@vger.kernel.org # v7.4+
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/media/platform/qcom/venus/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 7087af32060f..cec5db2bf755 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -408,7 +408,8 @@ static int venus_reserve_iova_region(struct device *dev, struct dma_iova_state *
 		if (!dma_iova_try_alloc(dev, &state[count], 0, chunk))
 			goto err_free_iova;
 
-		if (state[count].addr != end - chunk || state[count].__size != chunk)
+		if (state[count].addr != end - chunk ||
+		    dma_iova_size(&state[count]) != chunk)
 			goto err_free_iova;
 
 		rem -= chunk;
-- 
2.43.0

