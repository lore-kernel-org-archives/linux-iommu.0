Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96BF3019AC;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803350; cv=none; b=PpzWs6Ofc76GYpB0m37Ny8N+fDH0pbOh0ImCJmDdQznpULMk7ynOMQXkai6gx13RMbhd+F9YiTUqd7kN3/SjYV2hVbnGqzwyQjSeSzWmH7MAJKq1vjV1Rs2s8wpNy32Jijy1WzU1v4BEGK+XD/DOgdv3VPM/bjPxodzxxd/Kypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803350; c=relaxed/simple;
	bh=pauPkgHyC5sOmXEJMX4kk9zHj/nOugY/JrqP/IyD4H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pl7KG5jThICYqSkN9E/GLN2XIuFIjgn7YXWdAFwrpVDJsI58HX43AJ0vlhtRTP1QhUN+3ELYlcDpPhS3tNvRuj/4k7Ks6VSl8+Z0wFn3r9HjzsNwQCvvGI+6NbNDzcPo+oNDMshyFD7DqtdE8LJA0pjp7jZlnNcWGOKFWkD5Rdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI1echjO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI1echjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E49C2BC87;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803350;
	bh=pauPkgHyC5sOmXEJMX4kk9zHj/nOugY/JrqP/IyD4H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LI1echjO6hgNUDeUgFpHMCBc0z0G4ivKhf0HDMXdbC4P3tzVdrwMYaGp3CQpLEXYR
	 yZ2kxeQzBzRj4RVr2OGIRg2Ibl8JLM9fpNFHCBlY6UBiSEYboAZpncQkfovy4RWFiy
	 i3vDGOxR0VlpV/V8q9yxC2cmsx+zrsUnUbbm4+ktYXCUnQtLH0W2ctklVSwMET9M/l
	 DBB89FTAhIilxaEILFHDewXnLGLdyQhlqepqRn73672vUMRqMBEH3tW2Efi69el2LB
	 Hu4RGPg6qJYeIf9tUPN9fsl2E+c7Hc+kWhvxASn5qkEqcv2FXkbVPi36+vnWOWZ14T
	 5MjkXF8czRGbg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5r-000000002rr-0D7f;
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
Subject: [PATCH 10/14] iommu/mediatek-v1: add missing larb count sanity check
Date: Thu, 25 Sep 2025 14:27:52 +0200
Message-ID: <20250925122756.10910-11-johan@kernel.org>
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

Add the missing larb count sanity check to avoid writing beyond a fixed
sized array in case of a malformed devicetree.

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

