Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451052FE587;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803350; cv=none; b=VTcH4bUvkoWwu6IdiJYInWnz07bEwxc5N1qEueEY5iFMkjU6ej8jpqWE6diGDQTpsxWnkTn0mLcEIfMO6ap1doN/3BtbkbJVq+cXu6qnFvg4c6wbQ4tnvwaEb+S/aUXPJOg5BCjdBiF9Z6s/yzBNazZhJ1NuansFk0F1Z10J+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803350; c=relaxed/simple;
	bh=+qVIO7AwdM51KcSgUJ5C+8PxZLq5jlAFoQ6FLS+O9nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2tIzMfS5pwNn4NSD5WSTOk4gZ094dBfKIfXff5VZQTr5UuawdiHb81jSkuewjvXx+/0yP+hMgX0aTHk2KBQ4lpUFyrf0N9Ur65tMvngwFeYInMt1iyT9IWiSIyuVEppdXyvgQKdY8DWk3a7nz0hmS969ffG0nVMupd+GCneJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riASQpJG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riASQpJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE3AC4CEF0;
	Thu, 25 Sep 2025 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803349;
	bh=+qVIO7AwdM51KcSgUJ5C+8PxZLq5jlAFoQ6FLS+O9nI=;
	h=From:To:Cc:Subject:Date:From;
	b=riASQpJGiXd0jaMLViE6ocM+hNS5tTizapR7rCdZAF487Chz/Lo/5h1sPsfylcDr9
	 bNA4wZ2MIPhcghREQeyC2XUlDxmN0d0ve7PxAtqbjW1IIrafUX3l+uNjGyUSGwaXed
	 UdmnHV3jGxkc5VnSOfUZwB96WobRE6fGbeJoQCuJ4/WcXj5hLUkyKu/odr33UXiPQt
	 h62gymMGvHcejQ9kJEYN2IaiKfu2CP29B0o3DZWZHN8IvBVvSTd5dxY/6sGhT2KdCd
	 EfMHEPboNV4d6wBX+zr1StkGAcXVQ6dl37NnmYqLGn3LefLacMVznurQ+6rZLxgTAT
	 bi+N4Ck4wBNTA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5p-000000002rQ-21jE;
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
Subject: [PATCH 00/14] iommu: fix device leaks
Date: Thu, 25 Sep 2025 14:27:42 +0200
Message-ID: <20250925122756.10910-1-johan@kernel.org>
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
 drivers/iommu/omap-iommu.c              | 32 +++++++++++++++---------
 drivers/iommu/sun50i-iommu.c            |  2 ++
 drivers/iommu/tegra-smmu.c              |  5 ++--
 9 files changed, 81 insertions(+), 42 deletions(-)

-- 
2.49.1

