Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626CF39E162
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126238; cv=none; b=U8VMkmvPv70YO/mGVJgcBVHjbPEhp2djetARXt57QRzJQJK5JeeTMf39qIAfKIVK8xOv7k1VqAcRrlcgqKuL6J1bVaFy6GDN5FZ+hOJwdddODd0hMkk8wo+eHAOlacLBozi98FTHECPd8+fzvoN8lw2sVnxg7siG9DcyqVEh9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126238; c=relaxed/simple;
	bh=iQ49VPEpj9S3fP72Kb99rmnq+w1B6dB0pwrT60G2t/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLv+SE1mfke9GDvV/1qLZ8zflJ0KSM5qHtNrGKd2w/g2FnJAOAYsb1QrpTjdN77z68++EfdQJs7HgPM1WYIY8CDObZge8GfvWDGSvHGDlPxlDI3gisLF0asR7VYwEDMafL7KA2CAiMW9q5sPOG++f9WltllzeqDN4DjF/Z4Wdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=wxfEAF49; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="wxfEAF49"
Received: from 8bytes.org (p200300f6af1d96000d555eefe9f0908c.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:d55:5eef:e9f0:908c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 170B81C1133;
	Tue,  3 Feb 2026 14:43:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1770126235;
	bh=iQ49VPEpj9S3fP72Kb99rmnq+w1B6dB0pwrT60G2t/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wxfEAF49GAovhQQCEdEnGgBpF04v6EF/rTnUsjBEV2el99puTcE28alTOc0gKE4Nq
	 erPDgTKARJpxSofqzAywKJMWUuh2nESrkjbtr10DMRqcUowuim6wF8zjftbz4ktABt
	 FF1kvLbcnchBjJV+JDfKMkyN6E40w44TqFA6xYZSE+X1pW9/Ly52185jUKuGpydIcM
	 mInmLpMpVCqQ/NM6ItiCoGJmaFrLy4NXW9w4vdlKQmxzQ1BVEeEYTzyb2hwS2mYZ+I
	 DKu5+8afv5scBgqGJnV7muq7GkXR6mElmaoqFIbYS4xPHcd3qe1DIMS5+eQLo/uolb
	 xkGlMbx4JiBMw==
Date: Tue, 3 Feb 2026 14:43:53 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Magnus Kalland <magnus@dolphinics.com>
Cc: vasant.hegde@amd.com, suravee.suthikulpanit@amd.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Tore H . Larsen" <torel@simula.no>, "Lars B . Kristiansen" <larsk@dolphinics.com>, 
	Jonas Markussen <jonas@dolphinics.com>
Subject: Re: [PATCH v1] iommu/amd: IRT cache incoherency bug
Message-ID: <fwtqfdk3m7qrazj4bfutl4grac46agtxztc3p2lqnejt2wyexu@lztyomxrm3pk>
References: <20260203113209.56978-2-magnus@dolphinics.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203113209.56978-2-magnus@dolphinics.com>

On Tue, Feb 03, 2026 at 12:32:10PM +0100, Magnus Kalland wrote:
> DMA aliasing causes interrupt remapping table entries (IRTEs) to be shared
> between multiple device IDs. See commit 3c124435e8dd
> ("iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping") for more
> information on this. However, the AMD IOMMU driver currently invalidates
> IRTE cache entries on a per-device basis whenever an IRTE is updated, not
> for each alias.
> 
> This approach leaves stale IRTE cache entries when an IRTE is cached under
> one DMA alias but later updated and invalidated through a different alias.
> In such cases, the original device ID is never invalidated, since it is
> programmed via aliasing.
> 
> This incoherency bug has been observed when IRTEs are cached for one
> Non-Transparent Bridge (NTB) DMA alias, later updated via another.
> 
> Fix this by invalidating the interrupt remapping table cache for all DMA
> aliases when updating an IRTE.
> 
> Link to original thread: https://lore.kernel.org/linux-iommu/20251215114952.190550-2-magnus@dolphinics.com/T/#raf80785292deb22aafe6a817424051ea0d1d28f4
> 
> Resending for visibility.
> 
> Changes since original thread:
>  - Renamed struct pci_dev pointer parameter to unused
>  - Rebased on latest master
> 
> Cc: Tore H. Larsen <torel@simula.no>
> Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
> Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
> Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
> Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
> Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
> 
> ---
>  drivers/iommu/amd/iommu.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 7c12be1b247f..404afcaf4bc1 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3103,22 +3103,44 @@ const struct iommu_ops amd_iommu_ops = {
>  static struct irq_chip amd_ir_chip;
>  static DEFINE_SPINLOCK(iommu_table_lock);
>  
> +static int iommu_flush_dev_irt(struct pci_dev *unused, u16 devid, void *data)
> +{
> +	int ret;
> +	struct iommu_cmd cmd;
> +	struct amd_iommu *iommu = data;
> +
> +	build_inv_irt(&cmd, devid);
> +	ret = __iommu_queue_command_sync(iommu, &cmd, true);
> +	return ret;
> +}
> +
>  static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>  {
>  	int ret;
>  	u64 data;
> +	int domain = iommu->pci_seg->id;
> +	unsigned int bus = PCI_BUS_NUM(devid);
> +	unsigned int devfn = devid & 0xff;
>  	unsigned long flags;
>  	struct iommu_cmd cmd, cmd2;
> +	struct pci_dev *pdev = NULL;
>  
>  	if (iommu->irtcachedis_enabled)
>  		return;
>  
> -	build_inv_irt(&cmd, devid);
>  	data = atomic64_inc_return(&iommu->cmd_sem_val);
>  	build_completion_wait(&cmd2, iommu, data);
>  
> -	raw_spin_lock_irqsave(&iommu->lock, flags);
> -	ret = __iommu_queue_command_sync(iommu, &cmd, true);
> +	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
> +	if (pdev) {
> +		raw_spin_lock_irqsave(&iommu->lock, flags);

Move the lock above the if () ...

> +		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
> +	} else {
> +		build_inv_irt(&cmd, devid);
> +		raw_spin_lock_irqsave(&iommu->lock, flags);
> +		ret = __iommu_queue_command_sync(iommu, &cmd, true);

... and call iommu_flush_dev_irt(NULL, devid, iommu) here.

> +	}
> +
>  	if (ret)
>  		goto out;
>  	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
> @@ -3127,6 +3149,8 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>  	wait_on_sem(iommu, data);
>  out:
>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
> +	if (pdev)
> +		pci_dev_put(pdev);

This can also be moved to the respective if () branch above, no?

-Joerg
