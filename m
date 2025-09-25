Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769E3002B5;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803350; cv=none; b=XZHDZTxnoXKfsyOmmYRhUDuFNf+73RBbfnWBKNj6tf6fnRklMuMl0eibQSScqk+9NcpmHfSFXJA+t1+JCrH5F5wnehE7YMq/UhAGG/Hheoa9So16ZpU4QSbdCye8IOTSZcc3QlzK/vPmByGPs7QKwkuozRME/hj34cTILcJgVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803350; c=relaxed/simple;
	bh=TOL9f9t7TrdwbKha9pz6SX1lSEEfhPXvp//CHh8g1jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSjcVYw7Tg8NEyZJuNWl89EBEyoSNHkGiOZo+GR2c07FHqUhZZe+wOh9c8G05vgW9BnK5F9QJiE4ZQ0cvrUiJkvH+E4FqL9Fmpr69m6S5JkamKduI62kcOqDyNZrnGNOM5Z5iR9r5bwiFFlFcfRtCx+oPdu0mY8e+CSB8qlfpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZZtIUhL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZZtIUhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2939AC113D0;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803350;
	bh=TOL9f9t7TrdwbKha9pz6SX1lSEEfhPXvp//CHh8g1jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZZtIUhLnYspE/6f154Up/BtAVP3b3RMx4ASntjG6zgEMhE68ehUnWswpUxi6GLYx
	 CcEggvKKkHt/iBSOjt+kE6nCCgPyV49PBDhrEBeg5ums5xPUGjmVgGi2rNYoyRccE5
	 9uNoOHSBw/thYT5+pQKqiVUj3Isg4clrMqJCcS/f9REaNIb87m8RF10V/hQgK1aymN
	 fuwD2Ttp2+xGtbpK/t4mgo+fUKEP806tz0llsK+/DcxQPtRsHICNSj/2vMGlC+R5Xa
	 Lu/7MgKWokLob8e/W8v6JA+l8m9kRmEUdkZ1mus/m9/on4AUbxdmEYP/gkvk9RftRs
	 TpPbU7CTVoPbQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5q-000000002rh-3KSM;
	Thu, 25 Sep 2025 14:29:02 +0200
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
Subject: [PATCH 07/14] iommu/mediatek: simplify dt parsing error handling
Date: Thu, 25 Sep 2025 14:27:49 +0200
Message-ID: <20250925122756.10910-8-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250925122756.10910-1-johan@kernel.org>
References: <20250925122756.10910-1-johan@kernel.org>
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

