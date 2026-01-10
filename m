Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AF327BF6C
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768040361; cv=none; b=dUspgpEqKo55R75gnhaJx6iJ01PC6RQwE7kBLHgR4uXRvKQMakEl5UL27auKqyOFL8j0AceQueGlHh3o0OmEyYf4B6U/sTL9Rmtqsqym6L1zKvwQ/O8CscOop93wZjglE3T6E51LIwy796AVPgonadKLTxXAU8+lGlJEwrMPvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768040361; c=relaxed/simple;
	bh=lLD3SWvwBv7Jdg9uDxfy6P+Y3wliJnPcNoKQh1G22MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDG8/+ajYtJWZ1ow8fvvZINeVIC3tryKnzFl0XshYq1vOjVxzXPSz2Z6d9OMVaVDfNU1uYXdGeez+CplFCiBbGr1Dfk5LTfhr23Vwqi7rSPJDkcnHiibFYqu9t0s70fVCR6EXi4QqVI7YtGfuWSxkXwlx+iLueZbqmxECj8w/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=xOCUuf06; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="xOCUuf06"
Received: from 8bytes.org (p200300f6af1d9600dfc71246d978d903.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:dfc7:1246:d978:d903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 281765EEB5;
	Sat, 10 Jan 2026 11:19:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768040358;
	bh=lLD3SWvwBv7Jdg9uDxfy6P+Y3wliJnPcNoKQh1G22MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xOCUuf06qH368MQdmJ0jsYu9HAALI04rhdNEHvclEuueq8T/4231W4mBE52f1fjue
	 VyOrIrUIMvo4Odf9wM2/sSEwyx7Gt6vdDJCR7SYkf/arVldLM+YPF5ZDvD+SOoJ0t0
	 nW5MIenPQfQ/iFcD49mhDtk9WfxzB91JUENHLTRZGUQWBarqYimZfQSaGUwBYyBZJh
	 FupzFkTS2iqRmC/1gFkPai36O9Q+sX+gupnybZnGIHEdNxEEaTDlaRWf/E+C84gh4U
	 6Yax4sX46/8y0fMtDZJbiX+irwD1awPPWdrMY6H/jBjWDi8q7l93qaX7s4D+hvEly8
	 XaZdeqlfV3nOQ==
Date: Sat, 10 Jan 2026 11:19:16 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Magnus Kalland <magnus@dolphinics.com>
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, will@kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Tore H . Larsen" <torel@simula.no>, "Lars B . Kristiansen" <larsk@dolphinics.com>, 
	Jonas Markussen <jonas@dolphinics.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [RFC PATCH v1] iommu/amd: Invalidate IRT cache for DMA aliases
Message-ID: <3eiwpcckfd4bhkxkxiz4iziry3v4xwx2sopndmbtynurs6rsek@cmmq4jjzlyhd>
References: <20251215114952.190550-2-magnus@dolphinics.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215114952.190550-2-magnus@dolphinics.com>

Needs review from Vasant and/or Suravee.

On Mon, Dec 15, 2025 at 12:49:53PM +0100, Magnus Kalland wrote:
> DMA aliasing can cause interrupt remapping table entries (IRTEs) to be shared
> between multiple device IDs. The AMD IOMMU currently invalidates IRTE cache
> entries on a per-device basis whenever an IRTE is updated.
> 
> This approach can leave stale IRTE cache entries when an IRTE is cached under
> one DMA alias but later updated and invalidated only through a different alias.
> In such cases, the original device ID is never explicitly invalidated, since it
> is programmed implicitly via aliasing.
> 
> This incoherency has been observed when IRTEs are cached for one Non-Transparent
> Bridge (NTB) DMA alias and later updated through another.
> 
> This RFC proposes invalidating the interrupt remapping table cache for all DMA
> aliases when updating an IRTE.
> 
> Cc: Tore H. Larsen <torel@simula.no>
> Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
> Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
> Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
> Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
> Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
> ---
>  drivers/iommu/amd/iommu.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 9f1d56a5e145..5ac19398024f 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -31,6 +31,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/percpu.h>
>  #include <linux/cc_platform.h>
> +#include <linux/iommu.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/io_apic.h>
>  #include <asm/apic.h>
> @@ -3095,22 +3096,44 @@ const struct iommu_ops amd_iommu_ops = {
>  static struct irq_chip amd_ir_chip;
>  static DEFINE_SPINLOCK(iommu_table_lock);
>  
> +static int iommu_flush_dev_irt(struct pci_dev *pdev, u16 devid, void *data)
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
> +		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
> +	} else {
> +		build_inv_irt(&cmd, devid);
> +		raw_spin_lock_irqsave(&iommu->lock, flags);
> +		ret = __iommu_queue_command_sync(iommu, &cmd, true);
> +	}
> +
>  	if (ret)
>  		goto out;
>  	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
> @@ -3119,6 +3142,8 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>  	wait_on_sem(iommu, data);
>  out:
>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
> +	if (pdev)
> +		pci_dev_put(pdev);
>  }
>  
>  static inline u8 iommu_get_int_tablen(struct iommu_dev_data *dev_data)
> -- 
> 2.43.0
> 
