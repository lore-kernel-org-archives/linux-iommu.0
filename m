Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0DC28F933
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296016; cv=none; b=gSrJn0RQPIhwwTcN+DUtyMNoM73fvacAoRZnMWKDk0Qf8RODzlmePH/Lpo2GuntwlgGT4f+3L3tWJ5DMmzWRDbdNRRFG8QJj/ND126bqr+/XSc0xH28WjUBkYA8c5UuQWJdxzdUb3emksVlE2XJ9sWCyd8KS+95udCFBzWGulDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296016; c=relaxed/simple;
	bh=e/RiWFSF94CfhWL3q7b+4O5d2VF8knoYHBRsDZw8pvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqib/w/xki9J4iQ4ZXHaMEn8aQWO6pBH737yDe8vkAMIPrsH52H6L0NUHt3JDRxLHaxqTvdk0FpbvCzzoxw7hQwQKo63oXon8JUycnwI2AIgUysHQ3CswxWjuaUhKHdWZUk4gdB1RQTDlw0vekrh54+CcorN4NfLU5voOjclX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=njlhpmzN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="njlhpmzN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744296012;
	bh=e/RiWFSF94CfhWL3q7b+4O5d2VF8knoYHBRsDZw8pvI=;
	h=From:To:Cc:Subject:Date:From;
	b=njlhpmzNIw2EoQPOS8vpczUtQ4bdploAis8fS6uEURR0yCStRHkBBaS/3H14Ksm+C
	 d6KZW8JY4CoBI0lvXmHGhlG3XOEoEreY7fynavN9dASQlJHqDhth1GaDIVc35irO3b
	 ZDkGAaynOV/dvOh0/j29Q2Ku+1MDNzDlJOHuY4YNk2f4gJDp6WmGgj3zEveWQZJznv
	 KXqIQeH50tEk/ShTUH7t7oJ38KGocIA+GZVRzGxDr6KQAd3lmpjIK+mw+ZpzpXsa5k
	 Q+xFWisMtFw9ilu+IobQ28T3shh80krXnoid4X4sXWwcluGrmtT3jl1OKr1on2l9DT
	 euyEvEq6PrHaQ==
Received: from IcarusMOD.eternityproject.eu (fi-19-199-243.service.infuturo.it [151.19.199.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 47C2317E0CA7;
	Thu, 10 Apr 2025 16:40:11 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 0/2] MediaTek Dimensity 1200 - Add IOMMU support
Date: Thu, 10 Apr 2025 16:40:06 +0200
Message-ID: <20250410144008.475888-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding basic support for the OnePlus Nord 2 5G
DN2103 smartphone, this series adds support for the IOMMU found in
the MediaTek Dimensity 1200 (MT6893) SoC.

AngeloGioacchino Del Regno (2):
  dt-bindings: iommu: mediatek: Add binding for MT6893 MM IOMMU
  iommu/mediatek: Add support for Dimensity 1200 MT6893 MM IOMMU

 .../bindings/iommu/mediatek,iommu.yaml        |   4 +
 drivers/iommu/mtk_iommu.c                     |  37 ++-
 .../memory/mediatek,mt6893-memory-port.h      | 288 ++++++++++++++++++
 3 files changed, 318 insertions(+), 11 deletions(-)
 create mode 100644 include/dt-bindings/memory/mediatek,mt6893-memory-port.h

-- 
2.49.0

