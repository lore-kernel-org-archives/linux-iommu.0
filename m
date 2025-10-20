Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26322C21D5;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936198; cv=none; b=SRz6Ow02ppOyMsu/iYhR5UcRlR5ocN/qEK9VX2+Bv1FD1RbTZ71ERzPzIC0+vbREx7X5LVUm4/Drce95+I9cIzLLCpqQhUapQ8oJLCesZ8d0maJG8VM3CJ9tkGBvYhE7A4MMANp7XifElwn4zwfdUxae27uo3PkqvURSRTU0Kxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936198; c=relaxed/simple;
	bh=wDP21Y+s5kDNajy5hJ04hNgl2yzcFWdlbeRzYPBXo4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFdpNd1zt4ptui7drkFs7uE4H+C9QrTbJewkeyUVNlYj6/vLPhzHJkW7N0eG4HvWMNl2F+WqcDj+XwVwKG+fZBZrbFun4MjHrZjM6JzvZb882v+U1lgoSZ3voZqR8Zus5DXComE14u3cmIuK8sgOkyyk7p40VYdT8/vV8xurGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJHiHu0Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJHiHu0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55F4C4CEFE;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936197;
	bh=wDP21Y+s5kDNajy5hJ04hNgl2yzcFWdlbeRzYPBXo4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJHiHu0Y3vCKSkSUIXi3hTyUHQi8oaGwMOqMKxwrH26/cRPp9O+qGhJWAWjz07vNk
	 fJEmm0IjSsLJRO/ZECu7IMR5A50pGjUqDPN617qBT8OIwQ++BDaneQ4KCSXgI0+XMF
	 4+eF/TGfELVoHYQQu4XL2Swo0K1KgkEP2vgdyo08eyack13K3fkQ3pKMSYfvfAu1fO
	 D9BBAzi+l/J2ZVO+sNxyO7R8JfOw5L3RIILtLS8XfZftpYO/O5RcZkT9f0kPjJGfCx
	 8W+H0kb+I19fO3VvKbrvAGenpz+cviwLu/S1q9GSE8ut/TU4bBq3PUh21F0e5FG1Gu
	 ZoKwfujw67BtQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwn-0000000083P-2sUG;
	Mon, 20 Oct 2025 06:56:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 10/14] iommu/mediatek-v1: add missing larb count sanity check
Date: Mon, 20 Oct 2025 06:53:14 +0200
Message-ID: <20251020045318.30690-11-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251020045318.30690-1-johan@kernel.org>
References: <20251020045318.30690-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing larb count sanity check to avoid writing beyond a fixed
sized array in case of a malformed devicetree.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/mtk_iommu_v1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 44b965a2db92..55d6615a41a9 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -643,6 +643,9 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 	if (larb_nr < 0)
 		return larb_nr;
 
+	if (larb_nr > MTK_LARB_NR_MAX)
+		return -EINVAL;
+
 	for (i = 0; i < larb_nr; i++) {
 		struct device_node *larbnode;
 		struct platform_device *plarbdev;
-- 
2.49.1

