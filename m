Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C422D7DC5;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830295; cv=none; b=CgtULWbEy0kNejyenkqH2E02EQ3R+mBuqdsMW3NBrZtr8eyLyJDOYkHXahTIcHt+50W+v17HxyCGEfflYlbs1jkLvnqXnGhHC4/o1WDVavai8u8FsCq8SWP2iH6eiJzU0H3AHYFrbzDFeI9W0JmhQ/teVKxh0lAyY9ZxhUbcIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830295; c=relaxed/simple;
	bh=3YsUGHE8p+SGmBLxNad+cDIngJ/4w2kWdXR7zcSNBhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLdJ438efBJzzseewKbwSZtqTpa7VZw9LfCRywlBd9VEAd2smCfksRvnDtV6wTV+9Uwlx7oIA2O4Pd5TdS4FHG7wKZvCAecLY2Hgm8o2tUUUb7srEw7RLC+ZD9WZeRSAU2fubLASjj6RT48vO/SkD3z72AFA7fUZ2+CGI8pVznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz4A46Ts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz4A46Ts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACC1C4AF0F;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830295;
	bh=3YsUGHE8p+SGmBLxNad+cDIngJ/4w2kWdXR7zcSNBhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lz4A46TspwgvM2rCHwq6tFgYs9Kq1WQFGtkhQIccVj1T+5xFX6bdYyvNboSJqbcZa
	 oPJVSKo8CpPlt8wMbluFLWh+QlxnIHtqedpiYDQ9YqAnjr8Vn1Cb196pi0e/Scv93n
	 okPytWwUkzlUNXd56vT1OS8K5uG2zLeVCh+cMEEl0e3FlXNWPt7oE1fcFnQTUVzGpH
	 91oYJbN4jR+KZG5Su2wLscKOEIAQOVz6H5qTrIuNNoe3iTDX7xnQXX81ypnvhZA8h3
	 X0wIQAGoeHlvzWnRMIiB75ZMbKyofcPEYwPz8DH7Wb4vXp3KOaJKCvL/zs7h35Agkx
	 8/5wnTtWQLPgw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64FZ-0000000035q-1aMt;
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
Subject: [PATCH v2 07/14] iommu/mediatek: simplify dt parsing error handling
Date: Tue,  7 Oct 2025 11:43:20 +0200
Message-ID: <20251007094327.11734-8-johan@kernel.org>
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

As previously documented by commit 26593928564c ("iommu/mediatek: Add
error path for loop of mm_dts_parse"), the id mapping may not be linear
so the whole larb array needs to be iterated on devicetree parsing
errors.

Simplify the loop by iterating from index zero while dropping the
redundant NULL check for consistency with later cleanups.

Also add back the comment which was removed by commit 462e768b55a2
("iommu/mediatek: Fix forever loop in error handling") to prevent anyone
from trying to optimise the loop by iterating backwards from 'i'.

Cc: Yong Wu <yong.wu@mediatek.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 20a5ba80f983..24bb8b646edc 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1240,11 +1240,10 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 	return 0;
 
 err_larbdev_put:
-	for (i = MTK_LARB_NR_MAX - 1; i >= 0; i--) {
-		if (!data->larb_imu[i].dev)
-			continue;
+	/* id mapping may not be linear, loop the whole array */
+	for (i = 0; i < MTK_LARB_NR_MAX; i++)
 		put_device(data->larb_imu[i].dev);
-	}
+
 	return ret;
 }
 
-- 
2.49.1

