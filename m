Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5E2D592F;
	Tue,  7 Oct 2025 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830295; cv=none; b=BdgoXxWnU9GFr+0C3ABgOriI9hPdUOhV0TYuZgB9YNwh/by+7HLwNKi1LB2vW8f5JUpwSLex75bL3gMB+TTHGZrQrKl4ToiY5mo7K+UpERil9iJnjIfjyFz8FktWpmeLAYX2PZySOkjA5FGdfZ/TyQpuCooMDJ4z+tV55ofQVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830295; c=relaxed/simple;
	bh=K4wtzOitYKwJm7rZCA/75OduLrT7uK+gCj11IIm8B0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWm+DFKup/0GPbefA/W3oJ6opFtDf59AEXsqs88ixDFStaCiu72TGfPGnpfNDq/l3Le/yDMea4fJhxem9L1l5NADdkii3GcBlLNOaJaWqu9PyVVU5ejd3vIifjgJhgcMFPWZd4NNbislTxgC4AvRUfpKdTYxmtCbygtYQefTX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQFcOLmJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQFcOLmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C84C4CEF1;
	Tue,  7 Oct 2025 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830294;
	bh=K4wtzOitYKwJm7rZCA/75OduLrT7uK+gCj11IIm8B0s=;
	h=From:To:Cc:Subject:Date:From;
	b=YQFcOLmJiAHaRmiUYYxJPyiSXRTXWiliQuKDqH5Ki7JSsSEw6EutmWheETYQgJJX3
	 KbSqj9w4v9vDCh/MESFc1Yyt/m+mnOgNxe6K/YD60wNsuCkFBuqS7mabsONAagc0QI
	 EeiFx1X//PXZZCCbtH/x3SVEcOoUKS3V5XkVJwvFSp0K03AJOVIX1OAR0iM73V1O+o
	 YP43hy6/o+1d8xkmOfYcv4M+KlgboH0lb9o4Un+XEuYNQwWKBHRNiSFi0KllZh8URB
	 s9r5ZrPwVkJeQYhhymjZZhZrf3hsx0z+b0VWquWaomO3w6xycQJ9Z04On8+bJfnVFO
	 cjFXd3spLwxcw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64FY-0000000035X-2vyK;
	Tue, 07 Oct 2025 11:44:52 +0200
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
Subject: [PATCH v2 00/14] iommu: fix device leaks
Date: Tue,  7 Oct 2025 11:43:13 +0200
Message-ID: <20251007094327.11734-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes device leaks in the iommu drivers, which pretty
consistently failed to drop the reference taken by
of_find_device_by_node() when looking up iommu platform devices.

Included are also a couple of related cleanups.

Johan


Changes in v2
 - drop omap reference sooner; remove unused pointer
 - amend exynos commit message with reference to partial fix
 - amend tegra commit message with reference to partial fix
 - add Robin's ack


Johan Hovold (14):
  iommu/apple-dart: fix device leak on of_xlate()
  iommu/qcom: fix device leak on of_xlate()
  iommu/exynos: fix device leak on of_xlate()
  iommu/ipmmu-vmsa: fix device leak on of_xlate()
  iommu/mediatek: fix device leak on of_xlate()
  iommu/mediatek: fix device leaks on probe()
  iommu/mediatek: simplify dt parsing error handling
  iommu/mediatek-v1: fix device leak on probe_device()
  iommu/mediatek-v1: fix device leaks on probe()
  iommu/mediatek-v1: add missing larb count sanity check
  iommu/omap: fix device leaks on probe_device()
  iommu/omap: simplify probe_device() error handling
  iommu/sun50i: fix device leak on of_xlate()
  iommu/tegra: fix device leak on probe_device()

 drivers/iommu/apple-dart.c              |  2 ++
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 +++-----
 drivers/iommu/exynos-iommu.c            |  9 +++----
 drivers/iommu/ipmmu-vmsa.c              |  2 ++
 drivers/iommu/mtk_iommu.c               | 33 +++++++++++++++++--------
 drivers/iommu/mtk_iommu_v1.c            | 28 +++++++++++++++++----
 drivers/iommu/omap-iommu.c              |  7 ++----
 drivers/iommu/omap-iommu.h              |  2 --
 drivers/iommu/sun50i-iommu.c            |  2 ++
 drivers/iommu/tegra-smmu.c              |  5 ++--
 10 files changed, 63 insertions(+), 37 deletions(-)

-- 
2.49.1

