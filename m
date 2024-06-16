Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DBA71742;
	Sun, 16 Jun 2024 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718577761; cv=none; b=kOdrkFmAFEHnesCymNAs5+jTWcNvfLaHzrDl29D6pM6HkXNLdQoGnTwL4GXP9DbAj0mAU3uQnHJUDb+xH8Ms9kyCZsCEuPrcQSj9JKA589RTvWL3mEjTJPtknDbbRTvBH8/7XnjRRvNeoROd1WsiQHgx9dqbop9X64vTmJU5j4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718577761; c=relaxed/simple;
	bh=h9laPsEmx4V+TqAvg0VzvF7xi5h9to2X4e1wiIcUvpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aAt+T0l8xuzdpNmphB3on0MklXZORjC5o0ceJ8q+qyMd+EcSyTLTGyBG4FZlTT7FE7mE/xA0l+1DgaixxwBfci4mPgjKPYjbbnW4AqkXYw5sUkQ7sYzWrPKAmDcU+FJcQ0NdgUV/h1G5HTaAoRd6TQjksYdYkRej+lkTnzWuegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E4241516;
	Sun, 16 Jun 2024 15:43:04 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4536D3F73B;
	Sun, 16 Jun 2024 15:42:37 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/5] iommu: sun50i: Add H616 compatible string
Date: Sun, 16 Jun 2024 23:40:55 +0100
Message-Id: <20240616224056.29159-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240616224056.29159-1-andre.przywara@arm.com>
References: <20240616224056.29159-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU IP in the Allwinner H616 SoC is *almost* compatible to the H6,
but uses a different reset value for the bypass register, and adds some
more registers.

While a driver *can* be written to support both variants (which we in
fact do), the hardware itself is not fully compatible, so we require a
separate compatible string.

Add the new compatible string to the list, but without changing the
behaviour, since the driver already supports both variants.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/iommu/sun50i-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 20a07f829085d..8d8f11854676c 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -1067,6 +1067,7 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 
 static const struct of_device_id sun50i_iommu_dt[] = {
 	{ .compatible = "allwinner,sun50i-h6-iommu", },
+	{ .compatible = "allwinner,sun50i-h616-iommu", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun50i_iommu_dt);
-- 
2.39.4

