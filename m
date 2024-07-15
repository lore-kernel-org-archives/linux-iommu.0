Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3B2572;
	Mon, 15 Jul 2024 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043857; cv=none; b=m1gc9uWkgi1h4uo7k2q0edgTFuQPBnn3bhY01wX9qjbKdpEgnTqy8ZbUHBDmOwqiolZMvStlUTJyhlBOwSIFYYnVcwm4xz4C0y1vnTl36W6cjqZnTs45atkoPqxaXVgIBxRMYtwBMY/GhSGWTsFt/Q/lYivxJ2Rk7EI73wQ5/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043857; c=relaxed/simple;
	bh=rkcjPN2IC9uGeSh3wi5QJubFjAvwqQr3HfLBYlq3/r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uqsl3Tl3j30YnxZ2VnMUmiV/gYD0GcEHoaDXQVlSrfewV6pht1EFn5wT9qdAYxHO+7MGRZ/v67+NxgllSrPwmWYN0Ps2CTy5DMu6MLzVVBkJqzHri51a1+TWutcuUBUgcYlA5tVo4Wnt8/NVteVghCbfBqUA0IHp7AwMIz3B/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ntqiu1Gl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ntqiu1Gl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE43C32782;
	Mon, 15 Jul 2024 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721043857;
	bh=rkcjPN2IC9uGeSh3wi5QJubFjAvwqQr3HfLBYlq3/r4=;
	h=From:To:Cc:Subject:Date:From;
	b=Ntqiu1Gl8p43tSq/WbDdf6xqczW1nPbYmzEHcFBLgU0LrWL8buPrsJ0H4jotjGUOY
	 21zbPrFdQ0s6mbhIwiUzTPFlrJ9UXcK3E08lBM7Mvw2Ps2h8/yU2/MOGZcW57vRDiN
	 QMwNVqoNmAPnWFPUlN4CpsJULRP6rfy8kn4PggywUkWJ+DAVMGVoWUMDeaFWSdQWKS
	 HoanM+918lp3wqjpN1v9UNXSbPBa5ROkYG5S0Ug1CDgPFL10Zsbd+7poziO+cecQj/
	 /D6JKlzIi1H76bxCn1XWltNJ4nb7z3l3cPAgu/bZ5jrldcbInFJRKm9Da8i513n+H1
	 4AQQxaKEzrQ8Q==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v1 0/2] DMA IOMMU static calls
Date: Mon, 15 Jul 2024 14:44:01 +0300
Message-ID: <cover.1721041611.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1:
 * Dropped extra layer and called directly to iommu_dma_* functions
 * Added unmap_page and unmap_sg to dummy ops
 * Converted all dma-mapping calls to use iommu directly
 * Updated commit messages
v0: https://lore.kernel.org/all/98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org/

Leon Romanovsky (2):
  dma: call unconditionally to unmap_page and unmap_sg callbacks
  dma: Add IOMMU static calls with clear default ops

 MAINTAINERS                 |   1 +
 drivers/iommu/dma-iommu.c   | 108 ++++++++++-------------
 include/linux/dma-map-ops.h |   3 +
 include/linux/iommu-dma.h   | 169 ++++++++++++++++++++++++++++++++++++
 kernel/dma/dummy.c          |  21 +++++
 kernel/dma/mapping.c        |  73 ++++++++++++++--
 6 files changed, 305 insertions(+), 70 deletions(-)
 create mode 100644 include/linux/iommu-dma.h

-- 
2.45.2

