Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F4209F41
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987666; cv=none; b=TU1x132z9cGYcujwoHVBPSZCGXNciL/WwR+/guDKu7p7YDLaYPCynLZWQf2KdImM3snS5X9S+mTAUha1Inilqr8VYBqaThmwQiZ+X8+as3mlzbK7AQ97Ja0ITrT2DmtWrNZjyGfu9PgF6ya6jvNu4Aaw9y+xq+caLTShNKd7AiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987666; c=relaxed/simple;
	bh=hl0b4LicWQS3tXqT83aGHU3v7Vt+LOCxtkD/uO/X+uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqW8qNxTCOFB0HnH0j2rIYzLMR+nYmQ+K5RdjTKC+fBz56EcU2RjuuUWTpPeIGPCSI0sv/iZHc+fXZL8sEwm7iVKeYIW52dEHmvOY4jwtt1xPk/8OEJY/9hm6S+3ZKe5dWrxdKgCpN9WZDyA3p6VjLcmEvuPaB2+r/mYT4jrbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F177068D07; Thu, 12 Dec 2024 08:14:18 +0100 (CET)
Date: Thu, 12 Dec 2024 08:14:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: missing clear bdr in check_ram_in_range_map()?
Message-ID: <20241212071418.GA6638@lst.de>
References: <64931fac-085b-4ff3-9314-84bac2fa9bdb@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64931fac-085b-4ff3-9314-84bac2fa9bdb@quicinc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 09, 2024 at 06:50:06PM +0800, Baochen Qiang wrote:
> Hi,
> 
> while checking check_ram_in_range_map() I am confused by the condition set/check on bdr.
> If I am reading the code correctly, if bdr is set once, it would never get cleared, hence
> that function will always returns 0.
> 
> should we clear bdr before each new iteration?

I think so.  Even better refactor the code so that the non-NULL bdr
doesn't leak out:

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5b4e6d3bf7bc..181e244f410a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -584,6 +584,22 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	return mask >= phys_to_dma_unencrypted(dev, min_mask);
 }
 
+static const struct bus_dma_region *dma_find_range(struct device *dev,
+		unsigned long start_pfn)
+{
+	const struct bus_dma_region *m;
+
+	for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
+		unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
+
+		if (start_pfn >= cpu_start_pfn &&
+		    start_pfn - cpu_start_pfn < PFN_DOWN(m->size))
+			return m;
+	}
+
+	return NULL;
+}
+
 /*
  * To check whether all ram resource ranges are covered by dma range map
  * Returns 0 when further check is needed
@@ -593,23 +609,14 @@ static int check_ram_in_range_map(unsigned long start_pfn,
 				  unsigned long nr_pages, void *data)
 {
 	unsigned long end_pfn = start_pfn + nr_pages;
-	const struct bus_dma_region *bdr = NULL;
-	const struct bus_dma_region *m;
 	struct device *dev = data;
 
 	while (start_pfn < end_pfn) {
-		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
-			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
+		const struct bus_dma_region *bdr;
 
-			if (start_pfn >= cpu_start_pfn &&
-			    start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {
-				bdr = m;
-				break;
-			}
-		}
+		bdr = dma_find_range(dev, start_pfn);
 		if (!bdr)
 			return 1;
-
 		start_pfn = PFN_DOWN(bdr->cpu_start) + PFN_DOWN(bdr->size);
 	}
 
