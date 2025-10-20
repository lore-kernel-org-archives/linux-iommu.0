Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D012C0298;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936197; cv=none; b=oDQkzrzssWQvlvL/LO0u/eKgcz3QXmLD1VxVxBBukIHoVepVqrvtmtPUq9tfv65TkpwBzFKG9e32gdamqpj8BHdmvrzqdyoAiQJlsFTjavloOsbv73Hl+iRuU9ZCehELfPdirlbAA2v4lOsni1+6sQu1XeyANh/DQcVnY7Wfcj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936197; c=relaxed/simple;
	bh=tHVRW+tk17pqNuK7fYLET2iKWngthkKfcRRhifSxTno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgkG79yYfq1bsM/DCbYLV4II1XObR6OnjsmfoLlhHHZu4+1vh9Po0WDWNq4lgtzrWpKzjWlLU1wUogYqeicRDP1snCquweWJmbLmoGzuT2w4M4GE6ZFW7dQUhSRiGVEbpR2fVp84cGY4LM4eVQebybCMPQ2GJts/IU9XPm6kONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXBdEOqu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXBdEOqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C284C2BC86;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936197;
	bh=tHVRW+tk17pqNuK7fYLET2iKWngthkKfcRRhifSxTno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXBdEOqu3tnm+H6MAvaIx5y1l0QxcloLJo4N3Rlhrmiskno3wm+L2UQIeMwA/yfp6
	 YxYjgZ16wIh2RYxjCzrcoERJPlhdaKcpsEsOE+Yo5lywqw9zVU3Sh9T3kSxFLn4SRr
	 5gnGdyaZmdMmpnL3LqJ5oYtm1SQC5pF3ZZINNU+6W8u6xZtviGg7x5jTMYEkroxATT
	 CLKBSuE9wvUQSdby/rgPZmGdSm3w1fSRDeqwjGhpXt4cIOPKXMem7AiA0pwKyNupry
	 6jf3uOqLwZflolsk4ZN+fxVpIhrlYX+kZWHqPKxgAq/ts3B26CDV176xLLT1dpqtpy
	 a6tz8k0zWksOw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwn-0000000083G-1hfX;
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
Subject: [PATCH v3 07/14] iommu/mediatek: simplify dt parsing error handling
Date: Mon, 20 Oct 2025 06:53:11 +0200
Message-ID: <20251020045318.30690-8-johan@kernel.org>
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
index 64ce041238fd..f21cd3766069 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1239,11 +1239,10 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
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

