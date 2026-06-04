Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB32253A1;
	Thu,  4 Jun 2026 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557543; cv=none; b=kVB+jlgiuwOIWYqKp/uk/tac+VUSu0Rcz5LepUXDiryaxrJ3toEF57OtE8r3GY3SXlIlGX/X7RCvX9lEJJUKnJzDiwxpD3L/hVgyqfyHN3oFQz1kEFuai372D/Nv/AcJHIDvjQlyNmofJMMfKUW0ClZDU1rXrGzVruacLtRbFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557543; c=relaxed/simple;
	bh=LP1/YIzcbR077A3aKsblO/uR+qsoaGJKDIDhT+GxaUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oweOHSi4rcfuQXRxRPMzZq0+A8Jzo5qMKg7QRc9kLe3JXUf1AwhvchD/NkqMch4d/uNzCNHDz5hB8U2+DT3vNpafaWNTxv4L2s2ElcMw2v5muO+5tiSHqnFmwDrkfaDp8cY5dmNntx2OT6nBICKpB6dNR9GdUaQNJJo0VcKkh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvQrGVVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvQrGVVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1111F00893;
	Thu,  4 Jun 2026 07:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780557542;
	bh=D5+7waXUsBW4HaUTVWCmtPi1HCMwoy6+60neSZFO++A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BvQrGVVitnrAGsuvMWBmrLdzHwPUAPPdYze1Sg+PvLNp976xdqdggumulXo2KOeUm
	 e0yWqAKMa6vtvqcEEOE57IBYh4HSK8gxmwi84XIHlW0V9Q62lY1TbjDa2YGSnjTpXY
	 6zG+wYOQ05H/p4har1o8pDuPCpHozcYmRxqtCqnotwSDZR6h+/Z1uxWjva35lyQ+/H
	 5F0uDn5Pq4MxYSvXllUbT/2A7m/JDhkvc2dV8PFPJSLELrQoZ3agLhS8wFhpLm7wSM
	 8k+P6z0DD4fT8kf4OXBXy8dj64Lf3k9C3twuaxllwAno/z0Vrqz9Z6VrCTfx/tRWbQ
	 e6uQ/nU4v5Itg==
Date: Thu, 4 Jun 2026 10:18:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: lirongqing <lirongqing@baidu.com>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] dma-mapping: direct: fix missing mapping for
 THRU_HOST_BRIDGE segments
Message-ID: <20260604071856.GA245424@unreal>
References: <CGME20260603013739eucas1p2acd3cd59c1083639deb58723d57558af@eucas1p2.samsung.com>
 <20260603013723.2439-1-lirongqing@baidu.com>
 <d5b8f939-02d5-4016-9ccb-dd0be0714abb@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b8f939-02d5-4016-9ccb-dd0be0714abb@samsung.com>

On Wed, Jun 03, 2026 at 06:25:22PM +0200, Marek Szyprowski wrote:
> On 03.06.2026 03:37, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> >
> > In dma_direct_map_sg(), the case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
> > incorrectly used 'break' instead of falling through to MAP_NONE.
> > As a result, segments traversing the host bridge skipped the required
> > dma_direct_map_phys() call entirely, leaving sg->dma_address
> > uninitialized and leading to DMA failures. Fix this by using
> > 'fallthrough;'.
> >
> > Fixes: a25e7962db0d79 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> 
> Applied to dma-mapping-fixes, thanks!

The change looks correct, but it will be better if this change will
improve d0d08f4bd7f6 ("dma-direct: Fix missing sg_dma_len assignment in
P2PDMA bus mappings") too.

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index ec887f443741..e98b6547c950 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -489,9 +489,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
                case PCI_P2PDMA_MAP_BUS_ADDR:
                        sg->dma_address = pci_p2pdma_bus_addr_map(
                                p2pdma_state.mem, sg_phys(sg));
-                       sg_dma_len(sg) = sg->length;
                        sg_dma_mark_bus_address(sg);
-                       continue;
+                       break;
                default:
                        ret = -EREMOTEIO;
                        goto out_unmap;

Thanks

> 
> 
> > ---
> >  kernel/dma/direct.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 583c592..4391b79 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -476,7 +476,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
> >  			 * must be mapped with CPU physical address and not PCI
> >  			 * bus addresses.
> >  			 */
> > -			break;
> > +			fallthrough;
> >  		case PCI_P2PDMA_MAP_NONE:
> >  			need_sync = true;
> >  			sg->dma_address = dma_direct_map_phys(dev, sg_phys(sg),
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
