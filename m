Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697932E0935;
	Tue, 16 Sep 2025 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007942; cv=none; b=JyuqdEh3QS+Pf8ySlOagQYBi0O7gPP94BPfQAQnrYyzqElsIVrXBpwO88qE2O+A9bT/b6yMTu+FeBIyYqlLfQElVBd5IiL/tR/iQlu7e9zfzztOxwh/lex1e0aWIYHeXr5s+6G8VGW+T9+Hx5n6n7P6TA7WWRekS3dsrMrWrVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007942; c=relaxed/simple;
	bh=o4HjOjUl8KogcGYW9HXIKKgJvXaiisXNIkdpv7PUUcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFXwAQ+JE4IN7xPMC5BBEpWeYFnxv2gvl/oG5k9r+tbnLhzUdXhiDvRA+aFkwPBJ847IEvtPZTeofzxQCyFD2KcsM0spTYolKDr+gkmUoIggjn0TAemVUgIEB7/aWyhWYMwClcCQ7NTidwWTANbx7ZD3zxwWsIUdfZ82nX9py4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwsRZjFE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwsRZjFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C72C4CEEB;
	Tue, 16 Sep 2025 07:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758007942;
	bh=o4HjOjUl8KogcGYW9HXIKKgJvXaiisXNIkdpv7PUUcc=;
	h=From:To:Cc:Subject:Date:From;
	b=qwsRZjFEL7oK2mF1/WX2+iqlGcMXKwfk1Rw+BD2fsqiw8WO42F6gGF/crufiipUim
	 4FZ6GYQZ28lU4DsQUOZFNbDQjPsLyhCC4nrJQdLYYSUdJil1ujEVKqw5taNIB9qUry
	 KsAghOIXP57dQoLUFHsHkP30rCrpaOzgVn/1Voe0GXSCtDx38WNLRxpWvAkyPfqfUj
	 2g/YWgrdlnsGTzjDaqYhK+a1NeMyRveZOJfEuvzBW6Bb80H6QEnnY9aPHhhZjchrEq
	 eECx2NJf4BpIM81CPsbEq7hVSSo3VqVxPGI+fXibPFpa2FrG0RdK9+jH1vNLsFgoI3
	 GIPGPw1uQ+dEg==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 0/4] Preparation to .map_page and .unmap_page removal
Date: Tue, 16 Sep 2025 10:32:03 +0300
Message-ID: <cover.1758006942.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v3:
 * Rewrote the series to allow combination of .map_resource and .map_page
   to one flow.
 * Added two new patches to convert and remove .map_resource.
v2: https://lore.kernel.org/all/cover.1752734252.git.leon@kernel.org/
 * Added default "else" section without map_phys and map_page
   callbacks (impossible).
v1: https://lore.kernel.org/all/cover.1753003879.git.leon@kernel.org
 * Changed "else if" instead of "if".
v0: https://lore.kernel.org/all/cover.1752734252.git.leon@kernel.org
---------------------------------------------------------------------

This is followup to "dma-mapping: migrate to physical address-based API"
series https://lore.kernel.org/all/cover.1757423202.git.leonro@nvidia.com

Thanks

Leon Romanovsky (4):
  dma-mapping: prepare dma_map_ops to conversion to physical address
  dma-mapping: convert dummy ops to physical address mapping
  ARM: dma-mapping: Switch to physical address mapping callbacks
  dma-mapping: remove unused mapping resource callbacks

 arch/arm/mm/dma-mapping.c   | 98 +++++++++----------------------------
 include/linux/dma-map-ops.h | 13 ++---
 kernel/dma/dummy.c          | 13 +++--
 kernel/dma/mapping.c        | 20 +++-----
 4 files changed, 43 insertions(+), 101 deletions(-)

-- 
2.51.0

