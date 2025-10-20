Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F602BF3F4;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936197; cv=none; b=DbAAO7MRxMGxL4EbzF8Zuy6hEOk5JGAoIN97UhFLyqscrQFzA9iWObVRpuUUbhy6dWN3FNRU3dvNzhaKzNSXK/S4UkOpRYg+itv51GadoEYME3MGoc772CpAw9IjygCkqdHzh6lg/I+Y7CNYZHX8MRaEZI4N+RPuee7PklqPels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936197; c=relaxed/simple;
	bh=knUidLk/WfGmOIs1Y9PoZq64HcYmaba7BCKKYXsS7kA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtlOIhY2GXbXwyTUs7Wf02Q3fThskNX7SVN6WUX6P7TPzn241BKNxv55UiuEuSG8U0GQhLEKQI1aOLpm5gAAmxMs8HAFuO/5xkEl1pvo5hvFuaug3mdXapZww4dEMg4HkcLv5cTG9lMN2v7FskJeeeKikcgTw7StJB6NC240Swk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMwtCmvR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMwtCmvR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FC6C4CEF9;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936197;
	bh=knUidLk/WfGmOIs1Y9PoZq64HcYmaba7BCKKYXsS7kA=;
	h=From:To:Cc:Subject:Date:From;
	b=aMwtCmvR9qHD3LD18YwF4lEKiTMvYC4JmMT7IKS7REcHOzxAyRddwVWpaXZfDpkO9
	 s4+zTGq1F7oEbIfTYXZuGDjVvg1PuaG4XBD/X4YNG0Z8b9dr72N0VUuoRqIyfPfxya
	 dcbNEI09hYxGnv/bRsBagoXwFl6aQPzCaXMqbJgm8SxTAs8F6h7wXRajzdnNWoo5k1
	 Hmcal3rgaMdmmJ8JNXPFaAYH4lSzV7LRb1617oFgDk1eTfc7VBppG2bZU6ODOgB7Lq
	 ZzenNSKsJAHxs4IQpL8fmWE5S3RItR1kU6QYKDps7F0Y60J8Ey9+pfpbccYHQA6o1t
	 KK9rvTa3noxEg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwm-0000000082z-2h25;
	Mon, 20 Oct 2025 06:56:40 +0200
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
Subject: [PATCH v3 00/14] iommu: fix device leaks
Date: Mon, 20 Oct 2025 06:53:04 +0200
Message-ID: <20251020045318.30690-1-johan@kernel.org>
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


Changes in v3
 - fix mediatek use-after-free on probe deferral
 - add acks and reviewed-bys from Marek, Yong and Thierry

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
  iommu/mediatek: fix use-after-free on probe deferral
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
 drivers/iommu/mtk_iommu.c               | 34 +++++++++++++++++--------
 drivers/iommu/mtk_iommu_v1.c            | 28 ++++++++++++++++----
 drivers/iommu/omap-iommu.c              |  7 ++---
 drivers/iommu/omap-iommu.h              |  2 --
 drivers/iommu/sun50i-iommu.c            |  2 ++
 drivers/iommu/tegra-smmu.c              |  5 ++--
 10 files changed, 63 insertions(+), 38 deletions(-)

-- 
2.49.1

