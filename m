Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AF53803C2
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775678126; cv=none; b=X7dm/1ULFcNMzffedPur1biH+Z+8fELYMtf3gyObHuPK+vH1kPSJ78TuL0jL0JPr3lAWBYwha0HKfaqbTqhMquLhBAYKsx8SSifJYjl2VaqVHz1j2FfBxmQEKF1+WcLaOVgI3XPctFoilIngjA3iiovmZlz2iWtmPj4RCkJV8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775678126; c=relaxed/simple;
	bh=hP0DBz2MnfHgUl3vIzfFDjwQPis63gKAesI6MjWY1NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD8CNDPOcR+nwAViYrXfeUqWhs6LSmlhteP2Gi9HRC9z4HfF9tbu15p3x8ID9IX9zdXopnJfds5+nVn19SwevGyyydgS2akLVlBJ+bn3Bi5loGFaERN4KcNusRorbstkLN9ULosFychqN+/3C2zSDvjYLDjUSJPXXVLCspO8eME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qFu40S34; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qFu40S34"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kDGfj+dIHPPPtxem43wBR54tdlI5WONO4yOnjDFCHo8=; b=qFu40S34x3LPTlvHlJxgPpP1VE
	5lcrapFLgKvUE5BdnKOsWZgZqznw3hd7hv/+YTmZLtc7DK0lveb5mHqcKDjVlYJSu7/D8mi2ul7E+
	Lts+VGGD58x68+/ZE/xIWfP+d/MA16VoVwOvK8V/yrGjzdqVJOcO97zbX1rWd/NvHYZjKqfc0CkmY
	M8GrxwLH4sLTBU1TG0kfa37TDUJQxDPwGAy/gIWFAAY3Jj2oTtV4fXrcmJB3mzLXLlj0QWHRH8nfG
	Qj+cI5ctSa0AxCeMYOR7WyYSJS8eN+JDqUPhYrL/oSRnRreXppPbmQ0iRDehJwNeh4i6tn41QZG8P
	S7PklMcg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34022)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wAYzg-000000002kI-0bnN;
	Wed, 08 Apr 2026 20:55:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wAYze-000000003cL-2mUf;
	Wed, 08 Apr 2026 20:55:18 +0100
Date: Wed, 8 Apr 2026 20:55:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	jgg@nvidia.com, iommu@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] iommu: Ensure .iotlb_sync is called correctly
Message-ID: <adayppUjhjNZNSeY@shell.armlinux.org.uk>
References: <8982e3412563cf91e106d59228dfb6115024c75e.1775659257.git.robin.murphy@arm.com>
 <bdad8adc-5c20-4fb5-90b0-b7ca4199a7a8@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdad8adc-5c20-4fb5-90b0-b7ca4199a7a8@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 08, 2026 at 06:28:55PM +0100, Jon Hunter wrote:
> 
> On 08/04/2026 15:40, Robin Murphy wrote:
> > Many drivers have no reason to use the iotlb_gather mechanism, but do
> > still depend on .iotlb_sync being called to properly complete an unmap.
> > Since the core code is now relying on the gather to detect when there
> > is legitimately something to sync, it should also take care of encoding
> > a successful unmap when the driver does not touch the gather itself.
> > 
> > Fixes: 90c5def10bea ("iommu: Do not call drivers for empty gathers")
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Closes: https://lore.kernel.org/r/8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia.com
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >   drivers/iommu/iommu.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 50718ab810a4..ee83850c7060 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2717,6 +2717,12 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
> >   		pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
> >   			 iova, unmapped_page);
> > +		/*
> > +		 * If the driver itself isn't using the gather, make sure
> > +		 * it looks non-empty so iotlb_sync will still be called.
> > +		 */
> > +		if (iotlb_gather->start >= iotlb_gather->end)
> > +			iommu_iotlb_gather_add_range(iotlb_gather, iova, size);
> >   		iova += unmapped_page;
> >   		unmapped += unmapped_page;
> 
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I think the commit message needs to spell out that the blamed commit
causes random memory corruption which leads to data corruption and
kernel oopses.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
