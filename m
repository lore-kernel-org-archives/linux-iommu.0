Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6167302162;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803350; cv=none; b=nuOofBei/ZWV5X89FgYabhYkt+G77Jd35gGhZVNF9SToYWgkGO7dee0EUeA4Q30saP0rYK0AlR6e9/ueFjFOylUW26ad+VL8wZSTIkMrvA9YZSEJvEa1MYl7GgcE03elY9FIiU6Ut3BUGwe0/eNcmjhFw9qY9V5kHH3Tti+ad1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803350; c=relaxed/simple;
	bh=XymwskrCAw2efl8WxuVXKz2ffBCqFEBrU6LBAlSXMPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VB87Vb6TqCBqHvKPduXHC2xuBIcAFCcLnNfYOO3H7UJGkNgcLr1bt3CigbHhu/h8i6EWbNndI++BMDwUpetmSmILNabLpKOij62zqw7+hwkr82nVTXdslQ+K0cgrJt2TV0QVgzaayMBLdwNNSrTS3ZR78HMEmO9ZAIWFLoOcSgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3M20M+S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3M20M+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EECC4CEF5;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803350;
	bh=XymwskrCAw2efl8WxuVXKz2ffBCqFEBrU6LBAlSXMPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3M20M+Sg306uH1VfP8CrxPwdi3ELcHXhyXB45JnBn3+NKQu8Z1ECitzHBNUL+tdE
	 4lakkpwMQ0/AHG6Cm0lahkfYjYKVMu6kacRSxCoFKFb0NyMS3W/i7abf2V+1tJX5HQ
	 ePz9MiPnc7KhUgIK3CRXbkBFN9qTR6KDBbMMFWhUL3U4kVWXbyBVJ5wlYRynZumc4Y
	 p6RQ9ylaMktPNfqGIi3y16g+J1l5lJUJeiMLpbN2v6Fc38YaAVmrCQlsn0aLYXCQT4
	 UwZssEgtrg1BaqRi1Sc4HGgRVeTY3pxWrqRB3Y/RnRtkgAx6gQUl5/xb0EBGvO53N+
	 JGwyadzjAFEFw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5r-000000002rx-10qX;
	Thu, 25 Sep 2025 14:29:03 +0200
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
Subject: [PATCH 12/14] iommu/omap: simplify probe_device() error handling
Date: Thu, 25 Sep 2025 14:27:54 +0200
Message-ID: <20250925122756.10910-13-johan@kernel.org>
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

Simplify the probe_device() error handling by dropping the iommu OF node
reference sooner.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/omap-iommu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 77023d49bd24..844def804777 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1668,23 +1668,20 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 		}
 
 		pdev = of_find_device_by_node(np);
+		of_node_put(np);
 		if (!pdev) {
-			of_node_put(np);
 			ret = -ENODEV;
 			goto err_put_iommus;
 		}
 
 		oiommu = platform_get_drvdata(pdev);
 		if (!oiommu) {
-			of_node_put(np);
 			ret = -EINVAL;
 			goto err_put_iommus;
 		}
 
 		tmp->iommu_dev = oiommu;
 		tmp->dev = &pdev->dev;
-
-		of_node_put(np);
 	}
 
 	dev_iommu_priv_set(dev, arch_data);
-- 
2.49.1

