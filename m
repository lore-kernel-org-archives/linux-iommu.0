Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D082D94;
	Thu, 11 Jul 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694343; cv=none; b=feYm3QcAxHbTvxKK68oJA7wl/YsUmsQdDIz0t9ZA6EYSpPYItlBzdJvmeU2IwVPJOiYOWQ4L3UjwEZru1fbthcmSuHYI7CnYih8iEHSG1srD1BFApq/Fp/xuYIZjUMmZHT+1oEBSlX3/o92TegbuCYWYeSbjb4dzeBsmUwEtEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694343; c=relaxed/simple;
	bh=wX7XKlsj2cSApKllUPYiWI25YXU972l/vtIJA/ARJlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qB36lA+93uirjqdH25fYAzJ/wJoOC/BxebnHPL4a+9m7gzWSZ1YadQKpfBZgDiGA8nPMjYThF0ThkIMVQk9uJavLtVXY2kTBt4/Nqwk+uY8UE98p99voo1lXxlESWIWYVJHzdPmfPfFCGOsEsRz6BgJUK7BkNiNHrstGW8Mxq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLGa3CUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLGa3CUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8AAC116B1;
	Thu, 11 Jul 2024 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720694342;
	bh=wX7XKlsj2cSApKllUPYiWI25YXU972l/vtIJA/ARJlE=;
	h=From:To:Cc:Subject:Date:From;
	b=bLGa3CUne0HSpwFa6QVKhiGVMIqlQVBd2IEZHNhzm+KxaWtC4TBsl7uQa5EjyOT7I
	 lbF6OYNkY513o0RchffcbbNGpjplhujpoFbQ7P0zanzUeF3BHa+XMXLjXD6HAHqtKl
	 4BOsycPah9ZC/ElC8a9VF8QjuXyVlOE2jRqezedetS10RvEKtqcKbRoCyYAKa/4vh5
	 SY7LztD46IjO/bCWFHLiH/7tVM3AYpBZkNhrqbVb9dxAkV64stT6Tl6v//9nHs1Ill
	 YeDNZDr/JxwkPFs+7/iTxaTksfsWzO0cTr93I4NmQ7ZR26H9wXgDHwtp6x0ltL7xR6
	 /nCfKUVKZI/UQ==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 1/2] dma: call unconditionally to unmap_page and unmap_sg callbacks
Date: Thu, 11 Jul 2024 13:38:54 +0300
Message-ID: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Almost all users of ->map_page()/map_sg() callbacks implement
->unmap_page()/unmap_sg() callbacks too. One user which doesn't do it,
is dummy DMA ops interface, and the use of this interface is to fail
the operation and in such case, there won't be any call to
->unmap_page()/unmap_sg().

This patch removes the existence checks of ->unmap_page()/unmap_sg()
and calls to it directly to create symmetrical interface to
->map_page()/map_sg().

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/mapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 81de84318ccc..6832fd6f0796 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -177,7 +177,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 	if (dma_map_direct(dev, ops) ||
 	    arch_dma_unmap_page_direct(dev, addr + size))
 		dma_direct_unmap_page(dev, addr, size, dir, attrs);
-	else if (ops->unmap_page)
+	else
 		ops->unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir);
 }
@@ -291,7 +291,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 	if (dma_map_direct(dev, ops) ||
 	    arch_dma_unmap_sg_direct(dev, sg, nents))
 		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
-	else if (ops->unmap_sg)
+	else
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 EXPORT_SYMBOL(dma_unmap_sg_attrs);
-- 
2.45.2

