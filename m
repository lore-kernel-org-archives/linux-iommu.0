Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078519922
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 17:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DCAC433D2;
	Thu,  8 Jun 2023 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686244773;
	bh=6ad4Ze1/w0HwSx4VHiAz44pNtRELAkpuEtOfWAJU1Eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YdfcfRKqLJ40FuDdoTSVmRM59ViFQ9d62OUiQnwXIXPAteXBAEXPSS1RwfI34G5Q/
	 IXT7FFgFG83agNDw1g2EZmqgIuAXoBm5Y2tnLegxMyp4PhZsYj+N4eHL+kq8pr2CC7
	 crFZoqJyfoVY6ZKzBAsac8uLYJvnSMaaXYhuGhUkZlno6X9sN4zviMFHrKEFNm8cW7
	 xzvDsHK2w/T1vIdlTZfAjlvk6uxU9Cs6UOjLU+j7K4/jtix0t5hdaNiGHVC4oEwhRq
	 pMYw3WUhTeuRw1Cwha0qtfFWslBtasx/UMavhic7exuLXedpc+q6J+WE7wAz1k6i+c
	 9jhxtxE3aMKSA==
Date: Thu, 8 Jun 2023 12:19:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	hch@infradead.org, stable@vger.kernel.org,
	Jason Adriaanse <jason_a69@yahoo.co.uk>
Subject: Re: [PATCH RESEND] PCI: Add function 1 DMA alias quirk for Marvell
 88SE9235
Message-ID: <20230608171932.GA1206912@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731507e05d70239aec96fcbfab6e65d8ce00edd2.1686157165.git.robin.murphy@arm.com>

On Wed, Jun 07, 2023 at 06:18:47PM +0100, Robin Murphy wrote:
> Marvell's own product brief implies the 92xx series are a closely
> related family, and sure enough it turns out that 9235 seems to need the
> same quirk as the other three, although possibly only when certain ports
> are used.
> 
> CC: stable@vger.kernel.org
> Reported-by: Jason Adriaanse <jason_a69@yahoo.co.uk>
> Link: https://lore.kernel.org/linux-iommu/2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk/
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied with Christoph's reviewed-by to pci/virtualization for v6.5,
thanks!

> ---
> 
> Note that the actual regression which started the thread is a different
> matter, wherein a particular combination of parameters which used to put
> intel-iommu into passthrough mode now enables full translation instead.
> 
> Take #2, hopefully not royally screwing up my email alises this time.
> Sorry about that...
> 
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f4e2a88729fd..3186f2c84eab 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4174,6 +4174,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
>  			 quirk_dma_func1_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
> +			 quirk_dma_func1_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
>  			 quirk_dma_func1_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
