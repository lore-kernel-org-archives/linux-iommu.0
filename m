Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54D2D7DE1;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830295; cv=none; b=W3RmJ0MdALSMQQAml37WDJRIzUXTE2aDiIUd0ybIkeK9RDpS5GucJZA5nHQqa1ckPI2Af+ZyB8sV++9MaZ8AQDfEBr1A7EisoF4oeXx16KtGZ/Wd3gJ2UTHsQgvm6CtO6RqJVh3ujVIwjhW+i5UKZWYO995rFocIDNKeH113hRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830295; c=relaxed/simple;
	bh=9ziipJ8QVhUYl7FNrii/r8Of1QWBSla3JzJXj5jEDSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9cENwavobUBYOAcHW4UsmvqZfTB4EahSQKTsAOtrZXbYnWi61E1V7FFvSZbH4gStfjTYQkA3L8a44s1jniKch/wZtpizADUXqLn0lQWvJkVycAYs8YbwH/jZ8HrCgvmIyBg2BEzknQwWqOuExMmo2JgcbmCWGLhD/MTqxdRjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Seh52KZa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Seh52KZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A15BC113D0;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830295;
	bh=9ziipJ8QVhUYl7FNrii/r8Of1QWBSla3JzJXj5jEDSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Seh52KZapGgBNv6ZL64OcFd52RIRCpmMwMMXK5xKW5E2BXJvTmqAPm3oOgO+62FuM
	 zMenW9mjUVCzNaMreSsf3ziEiihxrE3PGW24UzqdNQuFY8q4f8StFFll/UoqfGt3UR
	 Bcg5PapxghkaLj47JFwxkPItBrMvmD8DxJyGZkwetrBsCMNyTNNQmx59FJiykSuzFR
	 x9XzDw17QU3/vk9sU4Sf+w6ckhpY0+EJX+ZTkUC0TD71D9qk/4zSZ1Wdx2Ze8aJot3
	 hZyigUZTiQ7+ygIcZe7tU/zTLf9wUwnYIFB40i5TdPn9ZeqD4GlrEK/ygMl+v2rzAi
	 Nhn+fzizPzJNA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64FZ-00000000360-2r37;
	Tue, 07 Oct 2025 11:44:53 +0200
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
Subject: [PATCH v2 10/14] iommu/mediatek-v1: add missing larb count sanity check
Date: Tue,  7 Oct 2025 11:43:23 +0200
Message-ID: <20251007094327.11734-11-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251007094327.11734-1-johan@kernel.org>
References: <20251007094327.11734-1-johan@kernel.org>
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

