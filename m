Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463B18E043
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126201; cv=none; b=G3EiIjCnebzR23FbejFBLf+a3+P6NcppXVkK9VQY7Aue5OrFo5ef2Bw3BO+uqniHWZI0GpW3P+lZzfKp5hM9m8AwhdU3qBJ82MdGO5N5r+TIExPxMAa9i7ZcrAUOa3fT9+FQ9yZJx2XNAk4KzmZI4NKQzD3H5c5SBC2/m3jtgbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126201; c=relaxed/simple;
	bh=EJTDZxvDTGO8aKCg3ypB07gV+yLhBoB+tl2vKjYOw4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWgMdRJARljcHl88cvn5hS8DU9YrCJcv6V4iJCriisbz2VL5MBEumjtyL21IvNhyfFmS4mmL8aX0AYAD4yH3vWhlo8qGIOJYOqWIJAGDpapCvnHo7iYtXhCbD+kQxxvj8D1YrLq48/0h8Zhec/McgTcNUuT9ZwLlEqu9G23Hg9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B94E227AAF; Thu, 12 Sep 2024 09:29:55 +0200 (CEST)
Date: Thu, 12 Sep 2024 09:29:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH] dma-mapping: reliably inform about DMA support for
 IOMMU
Message-ID: <20240912072954.GC7614@lst.de>
References: <7bbedc085ce87b121b9d0cb33eca8fba2fbdddbc.1726049194.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bbedc085ce87b121b9d0cb33eca8fba2fbdddbc.1726049194.git.leonro@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, I've applied this.  I do like the flow of dma_supported even
less with the duplicate condition now.  Can I get a quick review for
this incremental cleanup, please?

---
From d311bfe189d12a836b4add55fdb946f37f8697fa Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 12 Sep 2024 09:21:18 +0200
Subject: dma-mapping: reflow dma_supported

dma_supported has become too much spaghetti for my taste.  Reflow it to
remove the duplicate use_dma_iommu condition and make the main path more
obvious.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/mapping.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 022d670f8cad29..cd2a97d362cd24 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -841,20 +841,23 @@ static int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (WARN_ON(ops && use_dma_iommu(dev)))
-		return false;
-
-	if (use_dma_iommu(dev))
+	if (use_dma_iommu(dev)) {
+		if (WARN_ON(ops))
+			return false;
 		return true;
+	}
+
 	/*
-	 * ->dma_supported sets the bypass flag, so we must always call
-	 * into the method here unless the device is truly direct mapped.
+	 * ->dma_supported sets and clears the bypass flag, so ignore it here
+	 * and always call into the method if there is one.
 	 */
-	if (!ops)
-		return dma_direct_supported(dev, mask);
-	if (!ops->dma_supported)
-		return 1;
-	return ops->dma_supported(dev, mask);
+	if (ops) {
+		if (!ops->dma_supported)
+			return 1;
+		return ops->dma_supported(dev, mask);
+	}
+
+	return dma_direct_supported(dev, mask);
 }
 
 bool dma_pci_p2pdma_supported(struct device *dev)
-- 
2.45.2

