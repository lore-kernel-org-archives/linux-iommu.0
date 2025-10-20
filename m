Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57D2C2345;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936198; cv=none; b=jYNeVL+aq0pOjhvHrJSVB7LvWp6JSKZlFA5n4gbA0eqwCnKOOdLkHOw9eF8WcuJD7yXhiSRnwYiDv+10V2qtWERCeBAl8/OWTMDE41SD1BgqoAyirfBFIzDGMXeNTbB6TwV5v2Chp9XnwpjZcDxsyin/U7YIQGOFAm2gPb+nG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936198; c=relaxed/simple;
	bh=czt+mLY75+c/6bsLisPC4wh/lUvSc1D12TbPg946eV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIig6b6lIJ3A2IfhUp5GJalwl6z0lpQp7DUj202LSZQaxk1nAliprlkuwDes64lwqc7Ea7J5exMsk2M3A4n51+dGWbA0kRI8g+Xso3IOtM0f8TiQewKMhtMpDhD4fjds1wExwUTMlps0ydiw0xuyD3FA01b5kEqCeOqWXGi5feE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdFaARmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdFaARmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1684C4AF14;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936197;
	bh=czt+mLY75+c/6bsLisPC4wh/lUvSc1D12TbPg946eV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdFaARmk3vMAKMbcoZ2VIOKstcro1rl5TkL9Lc9L3Exn+5nClyEyQ/tEP7njLZMbk
	 gtdJHSkM7+T9s2IN0PzDPzhCIfYacnQZNhcGBSeu7VQ5AvTc7FE0Q43s3+KgdoLma6
	 ePD+gGs1qofP3qlFpfPZmITFhK1wC+1lwqiHnu+rpVZ03NJbTSez7gqUyQg+bpqkcM
	 jTYtzhEivllffstAMXAkVuhyu5BAGFhBNICTZ5Oqb9HWBSNe2aEhfh9R1sfJr71GzK
	 ChqoBL80XvfY6nrbYsMOsr4o5Ggm0/Oer6Rz5/K46+BT8zK+CGcXSmAGZGkZBuQXlz
	 aRBmbGyF6uabw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwn-0000000083V-3iVU;
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
Subject: [PATCH v3 12/14] iommu/omap: simplify probe_device() error handling
Date: Mon, 20 Oct 2025 06:53:16 +0200
Message-ID: <20251020045318.30690-13-johan@kernel.org>
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

Simplify the probe_device() error handling by dropping the iommu OF node
reference sooner.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/omap-iommu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index c0315c86cd18..7bbc6928c8d0 100644
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

