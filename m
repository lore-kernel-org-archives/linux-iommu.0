Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C002D876A;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830295; cv=none; b=QDL04w5FBjfR72XojIbzjsoVWTtY2F8wEVA13cIoKV8hC1IE6T89Y5VOiqAUvYQDkHDTLbHWgwz9sF/aZVuRZ7eQ6EgABb0gXoAET2HTmnWNY531k6jJ7cEPSgnHweleG8AYU+3ujAf0/hdWjj6ptrujqi/orzJzGxQn3o0q4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830295; c=relaxed/simple;
	bh=8MwwusWhD3Nfmd2dXw3awuzZtltqINN/xlTNNCP9H5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enshbNKObTS8vCeWp8UEcVdd86eHp4faWr7yS96aqZqIoa7J0QKs1bIS2xZaOdUSQmd3pyNxQJe5NPBRiJ+A+4svndW3JA3TUa3bRe+YhMm6naPVRXVq24VyeZ9XvnVxiieOwchYlD9Za4HenBD9oaah170VdzQRXnXOwKn3JAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY21KRx5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY21KRx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863F9C16AAE;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830295;
	bh=8MwwusWhD3Nfmd2dXw3awuzZtltqINN/xlTNNCP9H5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aY21KRx58O5U13wwmk6sv9UeD9mKwuu3XBQorhZYo0IZC4Piedvkau94ZpgNos7fy
	 FPfwDptQS+RJ3jfvclgEOA+vjKiNgxjbfsmVrWeg8w+vgDz2SVdFEXjSkVGrKBTrYr
	 nHLA/V/+i4LGdRwW2zjlNl+wK66vqQWsfnkzjh2jzdbqmx1+CCwzVamzbTpjIlYgUs
	 hShbmerU9ONo47h5ZkLnt1gvr0GgCI8Qd4DF7TCXqOVOUC+J5aK+3hk6gszpr6VDS+
	 dQfy4yUCAsdx0Ncooeo4o8e2met6p3g3RfznvC2R7DZeQLQnfNaHloraXOybI9ZvrR
	 U4164Qp/sIkmg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64FZ-00000000365-3VfD;
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
Subject: [PATCH v2 12/14] iommu/omap: simplify probe_device() error handling
Date: Tue,  7 Oct 2025 11:43:25 +0200
Message-ID: <20251007094327.11734-13-johan@kernel.org>
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

Simplify the probe_device() error handling by dropping the iommu OF node
reference sooner.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/omap-iommu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index b87ce129fb1f..2e161d174b5a 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1668,8 +1668,8 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 		}
 
 		pdev = of_find_device_by_node(np);
+		of_node_put(np);
 		if (!pdev) {
-			of_node_put(np);
 			kfree(arch_data);
 			return ERR_PTR(-ENODEV);
 		}
@@ -1677,14 +1677,11 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 		oiommu = platform_get_drvdata(pdev);
 		put_device(&pdev->dev);
 		if (!oiommu) {
-			of_node_put(np);
 			kfree(arch_data);
 			return ERR_PTR(-EINVAL);
 		}
 
 		tmp->iommu_dev = oiommu;
-
-		of_node_put(np);
 	}
 
 	dev_iommu_priv_set(dev, arch_data);
-- 
2.49.1

