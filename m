Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90D2EA75F;
	Mon, 30 Jun 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315126; cv=none; b=aOr84tksVXPWfIKtw56YV6oCQrclqpHCFxXiCWczrORdtAx+vgOc7B8oMdYBfZsUM3OM2eGOdgYSL4PPvhvp0NTg89b1umTfSCEu7Sx6Afn7Fti5JUiV4/Yt+Q7t+eMjQOxGuWV4DPssZZXiFI+ZeDOOWO+jEjzELtF3DJkB5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315126; c=relaxed/simple;
	bh=ui5hCeBwRvRdhzOlPRFBifufw7HRiacGECkcNfw+A/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLdpgqGOKQsstRq0GB0c+HmlBe+dCVfrkESptdtc/7FxWu8q4qY2/PVT3Horp23g/NfvrbseI67/TiI7o2M09jdS7jsy4ZIpp+m+07bYSjKI5CpymPl10xz081hIC7oxEh0WS/7k9XB7EoMiTkQwljQOq08M4bDi+qPh+DciCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGR4UWsW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGR4UWsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43772C4CEEB;
	Mon, 30 Jun 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751315125;
	bh=ui5hCeBwRvRdhzOlPRFBifufw7HRiacGECkcNfw+A/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGR4UWsWzR7g4+LhGxEPHvJBF2Y6j8XhE2knGrHs4Af42IDEzIZZWZmFsT4uolG2o
	 Nk8aQwIbKcT8dtvkpRMM8TlDlCfuvFTdd92yrgeq8cAE1k2SEJcbCImLiyi7giYxFw
	 9F41lpiCKhvWbnTJem8i5UbsQkX8THJSwANmP6s/nDR6PS9Cj2hmJVbqAh7/OvSk9v
	 +g7WOcnsfsfggE+l5+suj77KKoG3Mg2QMX4U2dFDrplrwm1M245oQrrdL36fluZYkt
	 WyB2mFBaIJv14r64KhB/Vj+FudX5cfmH76NatWknmo/jMOABwdUlUpgQ24r6d/YJ8O
	 u5jxY04iWUYDw==
Date: Mon, 30 Jun 2025 14:25:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ben Copeland <ben.copeland@linaro.org>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <aGLyswGYD6Zai_sI@kbusch-mbp>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630133343.GA26040@lst.de>

On Mon, Jun 30, 2025 at 03:33:43PM +0200, Christoph Hellwig wrote:
> Hi Ben,
> 
> > [   32.857521] iommu_dma_unmap_page+0xc4/0xe8 (P)
> 
> Can you resolve this to a source location for me. i.e.
> 
> gdb vmlinux
> 
> l *(iommu_dma_unmap_page+0xc4)
> 
> Also what IOMMU driver is this device using?  It looks like it
> might not support a 4k IOMMU page size.

I think the PRP handling is broken. At the very least, handling the last
element is wrong if it appears at the end of the list, so I think we
need something like this:

---
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -701,7 +701,7 @@ static void nvme_free_prps(struct request *req)
        prp_list = iod->descriptors[desc];
        do {
                dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-               if (i == NVME_CTRL_PAGE_SIZE >> 3) {
+               if (i == NVME_CTRL_PAGE_SIZE >> 3 && length > NVME_CTRL_PAGE_SIZE) {
                        prp_list = iod->descriptors[++desc];
                        i = 0;
                }
--

But even that, the PRP setup doesn't match the teardown. We're calling
dma_map_page() on each PRP even if consecutive PRP's came from the same
dma mapping segment. So even if it had been coalesced, but if the device
doesn't support SGLs, then it would use the prp unmap path.

Ben, can you check if your device supports sgl?

  # nvme id-ctrl /dev/nvme0 | grep sgl
