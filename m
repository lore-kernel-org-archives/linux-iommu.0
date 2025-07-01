Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88483277035;
	Tue,  1 Jul 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376590; cv=none; b=bfRkkrbw+Px5hK4uznDsIS0QqhyLXEoIxh5Sm58hvCnfhP2afSbGPE8Yy9EEdkUJrJfbmdelSsFrn+aO5u9nLFg5PB8I2/9hiFJOrMHYogVw6VzRUu072cIIHjuDAaRbk9HE7aYZ641qooRFIo4LQ2xv88b84S8sm2/7c+UIFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376590; c=relaxed/simple;
	bh=MsxpFyRX5iJsXaaBdaf4j4mcSgicPs1L159BjM4u9T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJGSrp57htI5796do6GlN5QZAIj5IuQf7Hm7mdfAlrGyTfUIWX4iUtrgDiQ80DP0cGHXZ56khX3NSrEZojeM0aFycMgoTAH4w4f6+jP7O68iEI23ebafOblHDV5WcHys2SzClgas4PnpVWnVAdD4mdODDZ5R0LbO49QN41omEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17A3B68AA6; Tue,  1 Jul 2025 15:29:37 +0200 (CEST)
Date: Tue, 1 Jul 2025 15:29:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ben Copeland <ben.copeland@linaro.org>,
	linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <20250701132936.GA18807@lst.de>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com> <20250630133343.GA26040@lst.de> <aGLyswGYD6Zai_sI@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLyswGYD6Zai_sI@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 30, 2025 at 02:25:23PM -0600, Keith Busch wrote:
> I think the PRP handling is broken. At the very least, handling the last
> element is wrong if it appears at the end of the list, so I think we
> need something like this:

Yeah.

> But even that, the PRP setup doesn't match the teardown. We're calling
> dma_map_page() on each PRP even if consecutive PRP's came from the same
> dma mapping segment. So even if it had been coalesced, but if the device
> doesn't support SGLs, then it would use the prp unmap path.

Yes, that's broken, and I remember fixing it before.  A little digging
shows that my fixes disappeared between the oct 30 version of Leon's
dma-split branch and the latest one somewhere.  Below is what should
restore it, but at least when forcing my Intel IOMMU down this path it
still has issues with VPTEs already set.  So maybe Bob should not try
it quite yet.  I'll try to get to it, but my availability today and
tomorrow is a bit limited.


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 38be1505dbd9..02bb5cf5db1a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -678,40 +678,55 @@ static void nvme_free_prps(struct request *req)
 	enum dma_data_direction dir = rq_dma_dir(req);
 	int length = iod->total_len;
 	dma_addr_t dma_addr;
-	int i, desc;
+	int prp_len, i, desc;
 	__le64 *prp_list;
+	dma_addr_t dma_start;
 	u32 dma_len;
 
 	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
-	dma_len = min_t(u32, length,
-		NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
-	length -= dma_len;
+	prp_len = NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1));
+	prp_len = min(length, prp_len);
+	length -= prp_len;
 	if (!length) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
+		dma_unmap_page(dma_dev, dma_addr, prp_len, dir);
 		return;
 	}
 
+	dma_start = dma_addr;
+	dma_len = prp_len;
+	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
+
 	if (length <= NVME_CTRL_PAGE_SIZE) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
-		dma_unmap_page(dma_dev, dma_addr, length, dir);
-		return;
+		if (dma_addr != dma_start + dma_len) {
+			dma_unmap_page(dma_dev, dma_start, dma_len, dir);
+			dma_start = dma_addr;
+			dma_len = 0;
+		}
+		dma_len += length;
+		goto done;
 	}
 
 	i = 0;
 	desc = 0;
 	prp_list = iod->descriptors[desc];
 	do {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
 		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
 			prp_list = iod->descriptors[++desc];
 			i = 0;
 		}
 
 		dma_addr = le64_to_cpu(prp_list[i++]);
-		dma_len = min(length, NVME_CTRL_PAGE_SIZE);
-		length -= dma_len;
+		if (dma_addr != dma_start + dma_len) {
+			dma_unmap_page(dma_dev, dma_start, dma_len, dir);
+			dma_start = dma_addr;
+			dma_len = 0;
+		}
+		prp_len = min(length, NVME_CTRL_PAGE_SIZE);
+		dma_len += prp_len;
+		length -= prp_len;
 	} while (length);
+done:
+	dma_unmap_page(dma_dev, dma_start, dma_len, dir);
 }
 
 static void nvme_free_sgls(struct request *req)
