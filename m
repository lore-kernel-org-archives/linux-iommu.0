Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDA25F983;
	Mon, 24 Mar 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836069; cv=none; b=bUHdIj1MF2MqMpiT4/I9aQZqjtZYPRsGgNwyh/OonZd4qfARjstvyocOFcyWJBckrz9LQCYSU+MNIA3zM27lzNwn2ka5eTk6qR1muUOHEahmklyMrNw3r49DX46eGaDQw2kqFnMRRY/AC4ZivVtqtF27oxRQy6J79TD2boq5cdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836069; c=relaxed/simple;
	bh=rAZ9Xlu5H7xabS4rjtmInIH/wJ/ynY3lA+N50DJ9br0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Se+3eQXhocO68FuVC9X9lRNSim5pOzHbwaTuSs+aXysb2lhAwcGmtrc+LK/j/FIhTOy7BqxEhxa245vqkF8Gcngrggw5VixFsuHAmMzUEXrKQX+TURlnbh/juEoZHyxDFdCc4qYb8r5di6W8E3vJB+22jypjQCtubLDwrqABUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX6HFzDG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX6HFzDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97C9C4CEDD;
	Mon, 24 Mar 2025 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742836068;
	bh=rAZ9Xlu5H7xabS4rjtmInIH/wJ/ynY3lA+N50DJ9br0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rX6HFzDGfD4mymFF0xVp70VJUFpCm72oXCkofwJFHEaI4eBCBaeScDURfTK30h0bY
	 RF/Poib1ZDQMyCxc7O23M86yd4uTcWOPQgqQCnib5uCyPrezqx/nFEOLNfYk+bIRPw
	 h5ETSgYUDozQI1q6zEPUsQz6SahDVus9gpj5CFbBawuYAqY15ZMEi7sYt5NEZ0QYeD
	 5wZ52X/hcJu4KrBNTbc4xdYxM3s1AOsCyA8H+pu2v45yX+FQz2l/Q6n5xYISbg3O3P
	 f82sMWyTAxyC0EslM31ZX5m36b4RgcLLIThji5rigAu6Ff/T6QXnOw+5mygMJsTplX
	 e6P9vHiRKZ2Ew==
Date: Mon, 24 Mar 2025 10:07:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com,
	robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Message-ID: <20250324170743.GA1339275@ax162>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
 <20250324162558.GA198799@ax162>
 <Z+GK98/VSvYl518j@nvidia.com>
 <Z+GOkl21ZLtE3B/e@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+GOkl21ZLtE3B/e@nvidia.com>

On Mon, Mar 24, 2025 at 09:55:46AM -0700, Nicolin Chen wrote:
> On Mon, Mar 24, 2025 at 01:40:23PM -0300, Jason Gunthorpe wrote:
> > On Mon, Mar 24, 2025 at 09:25:58AM -0700, Nathan Chancellor wrote:
> > 
> > > I bisected a loss of networking on one of my machines to this change as
> > > commit e009e088d88e ("iommu: Drop sw_msi from iommu_domain") in -next.
> > 
> > Okay wow, I will drop this series from the tree if I don't see a
> > resolution in a few days. We can try again next cycle, thank you for
> > testing and bisect!
> > 
> > > At this change, I see:
> > > 
> > >   [  +0.000000] Linux version 6.14.0-rc2-00033-ge009e088d88e (nathan@ax162) (aarch64-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT_DYNAMIC Mon Mar 24 08:57:49 MST 2025
> > >   ...
> > >   [  +0.002355] fsl_mc_bus NXP0008:00: Adding to iommu group 0
> > >   [  +0.000533] fsl_mc_bus NXP0008:00: MC firmware version: 10.28.1
> > >   [  +0.002565] fsl_mc_dprc dprc.1: DMA mask not set
> > >   [  +0.019255] fsl_mc_dprc dprc.1: Adding to iommu group 1
> > >   [  +0.046820] fsl_mc_dprc dprc.1: Failed to allocate IRQs
> > 
> > I guess it is tripping up going through iommu_dma_prepare_msi()
> > somehow?
> > 
> > Maybe fsl bus is special and doesn't manage to set
> > IOMMU_COOKIE_DMA_IOVA for some reason?
> > 
> > I wonder if this is not right:
> > 
> > +               default:
> > +                       ret = -EOPNOTSUPP;
> > +                       break;
> > 
> > And it should be just break instead (return 0) which is what was
> > happening before?
> 
> Yea, I found the diff here too.
> 
> Nathan, would you please give it a try by removing this
> 	ret = -EOPNOTSUPP;
> ?

Can confirm, I tested the following diff and it resolved my issue. If it
goes as a standalone patch:

Tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the quick triage!

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0f4cc15ded1c..2b81166350ae 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3661,7 +3661,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 			ret = iommufd_sw_msi(group->domain, desc, msi_addr);
 			break;
 		default:
-			ret = -EOPNOTSUPP;
 			break;
 		}
 	}
