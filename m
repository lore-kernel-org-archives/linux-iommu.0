Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840A2D7DDE;
	Thu,  4 Dec 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842618; cv=none; b=YObC2+78cX3SETQWqgvSKiJbW601hUXUFZmMtLllY3xRE+wJjRnBAhyrEs0LQxsMz4cks7ruuwHnq5cNXtQG7B88BmE/pWkep8ii8St2yPR3tyg2TXgQvVR/yjr0N7t09E1DnsKUKfX3AWg6FjiurlP9LnScPw7eM984hvz07bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842618; c=relaxed/simple;
	bh=mi0W+9RDcfdrjDnlqnYr3gQXgSUdxOfBqt+VqUehRis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=arpQuzR9rMoTx0iC0VpxVTp4+LYs9PGrZ/giYHUP/i6Rzzyw6D7Kd+KNETsFvLjPNq24M0/drJ/XW0G1tlHUiF+o8Of+HCbKGE6WduPqCyWqEZnLqQZBdA+lptSkvRkvPZx8wKrK4ST6E/RpVKFl7I3fWCcrPwugcIwCO2UPRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqODAnbs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqODAnbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D69AC4CEFB;
	Thu,  4 Dec 2025 10:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764842618;
	bh=mi0W+9RDcfdrjDnlqnYr3gQXgSUdxOfBqt+VqUehRis=;
	h=From:To:Cc:Subject:Date:From;
	b=AqODAnbsdF4m7Cr995qZeb6Wn93qTNc4nwUXPDaxBWiWswyiHJz8VvxMh80Wz6u3c
	 0GgcnTEd2OIq3/503a4maXowS3IMmCJLEdDW8OdfsT/NpcugZlKRDWABrw4C8uIIbg
	 kKurGc9psZPZpDYE+ELijHk0GIKyZZquVvhsV2oMDfIY439hWvHP86VuRtibu0HhC1
	 mHPRNSKUG9tR8Z05ZMR4D2yf3nGBguxrbZCRYPVWnmxZHJEgrV3kuJb2Uea0SHHOL/
	 ykVBgaswlKyybJ4B67okkp4gUL60Q6udqH/pa4rQmgeLxqG1/4C6W7j0BpELp7Ow8V
	 0+TOrQKgA6vHg==
From: Arnd Bergmann <arnd@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Alex Mastro <amastro@fb.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommufd: fix building without dmabuf
Date: Thu,  4 Dec 2025 11:03:29 +0100
Message-Id: <20251204100333.1034767-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When DMABUF is disabled, trying to use it causes a link failure:

x86_64-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_map_file_pages':
io_pagetable.c:(.text+0x1735): undefined reference to `dma_buf_get'
x86_64-linux-ld: io_pagetable.c:(.text+0x1775): undefined reference to `dma_buf_put'

Fixes: 44ebaa1744fd ("iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/iommufd/io_pagetable.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 54cf4d856179..d22e86de03e9 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -495,7 +495,11 @@ int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 		return -EOVERFLOW;
 
 	start_byte = start - ALIGN_DOWN(start, PAGE_SIZE);
-	dmabuf = dma_buf_get(fd);
+	if (IS_ENABLED(CONFIG_DMABUF_HEAPS))
+		dmabuf = dma_buf_get(fd);
+	else
+		dmabuf = ERR_PTR(-ENXIO);
+
 	if (!IS_ERR(dmabuf)) {
 		pages = iopt_alloc_dmabuf_pages(ictx, dmabuf, start_byte, start,
 						length,
-- 
2.39.5

