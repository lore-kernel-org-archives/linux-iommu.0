Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728BDC433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 21:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25A864026E;
	Tue,  7 Dec 2021 21:04:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YlAVlZ-u12ln; Tue,  7 Dec 2021 21:04:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A8EB4024A;
	Tue,  7 Dec 2021 21:04:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06E04C0038;
	Tue,  7 Dec 2021 21:04:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D4F8C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3914A832EB
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:04:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FSSCz32HLUuc for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 21:04:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2990683168
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:04:49 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 0352CCE1E73;
 Tue,  7 Dec 2021 21:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C900EC341C1;
 Tue,  7 Dec 2021 21:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638911085;
 bh=4LqouiflKAdNmyzI14DusWvBDIHM7i2qiOmUjncfYKg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=RQOVer6mBex/l6+4wBSe2LYCuoLmvk9+eU9Tq2oxaGgZR9L9L74vmrqxzeosU0eE9
 ngdMyHKP5La85fcbVOhVbgSZHUQrTKSV1US2oehAiQe/6Ias9lqhsb5GEJLks5EeEy
 mo4f+CZ/w2OPEKkKFazbq8XQduz8HU/ObusTgF12SY3kxmUjd5Qdhy+3RSW/AryDfK
 X+IsdlZQ3kGBXRwHP3LNK6MMH25JOlNXi6N6rhNUEfsXPhpIWtoRZMCU0gdxCCHL/L
 nDT1H9tx0b73229NJhpwgnECznerrpC0B04ucF3JYsTi7juBMcjAU8xvXnRSBGgYgm
 WRp7vAKGZDoYw==
Date: Tue, 7 Dec 2021 15:04:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 17/36] PCI/MSI: Use msi_desc::msi_index
Message-ID: <20211207210443.GA77781@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206210438.580265315@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Megha Dey <megha.dey@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Juergen Gross <jgross@suse.com>, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Dec 06, 2021 at 11:39:23PM +0100, Thomas Gleixner wrote:
> The usage of msi_desc::pci::entry_nr is confusing at best. It's the index
> into the MSI[X] descriptor table.
> 
> Use msi_desc::msi_index which is shared between all MSI incarnations
> instead of having a PCI specific storage for no value.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  arch/powerpc/platforms/pseries/msi.c |    4 ++--
>  arch/x86/pci/xen.c                   |    2 +-
>  drivers/pci/msi/irqdomain.c          |    2 +-
>  drivers/pci/msi/msi.c                |   20 ++++++++------------
>  drivers/pci/xen-pcifront.c           |    2 +-
>  include/linux/msi.h                  |    2 --
>  6 files changed, 13 insertions(+), 19 deletions(-)
> 
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -332,7 +332,7 @@ static int check_msix_entries(struct pci
>  
>  	expected = 0;
>  	for_each_pci_msi_entry(entry, pdev) {
> -		if (entry->pci.msi_attrib.entry_nr != expected) {
> +		if (entry->msi_index != expected) {
>  			pr_debug("rtas_msi: bad MSI-X entries.\n");
>  			return -EINVAL;
>  		}
> @@ -580,7 +580,7 @@ static int pseries_irq_domain_alloc(stru
>  	int hwirq;
>  	int i, ret;
>  
> -	hwirq = rtas_query_irq_number(pci_get_pdn(pdev), desc->pci.msi_attrib.entry_nr);
> +	hwirq = rtas_query_irq_number(pci_get_pdn(pdev), desc->msi_index);
>  	if (hwirq < 0) {
>  		dev_err(&pdev->dev, "Failed to query HW IRQ: %d\n", hwirq);
>  		return hwirq;
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -306,7 +306,7 @@ static int xen_initdom_setup_msi_irqs(st
>  				return -EINVAL;
>  
>  			map_irq.table_base = pci_resource_start(dev, bir);
> -			map_irq.entry_nr = msidesc->pci.msi_attrib.entry_nr;
> +			map_irq.entry_nr = msidesc->msi_index;
>  		}
>  
>  		ret = -EINVAL;
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -57,7 +57,7 @@ static irq_hw_number_t pci_msi_domain_ca
>  {
>  	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
>  
> -	return (irq_hw_number_t)desc->pci.msi_attrib.entry_nr |
> +	return (irq_hw_number_t)desc->msi_index |
>  		pci_dev_id(dev) << 11 |
>  		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
>  }
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -44,7 +44,7 @@ static inline void pci_msi_unmask(struct
>  
>  static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
>  {
> -	return desc->pci.mask_base + desc->pci.msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
> +	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
>  }
>  
>  /*
> @@ -356,13 +356,10 @@ msi_setup_entry(struct pci_dev *dev, int
>  	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
>  		control |= PCI_MSI_FLAGS_MASKBIT;
>  
> -	entry->pci.msi_attrib.is_msix	= 0;
> -	entry->pci.msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
> -	entry->pci.msi_attrib.is_virtual    = 0;
> -	entry->pci.msi_attrib.entry_nr	= 0;
> +	entry->pci.msi_attrib.is_64	= !!(control & PCI_MSI_FLAGS_64BIT);
>  	entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
>  					  !!(control & PCI_MSI_FLAGS_MASKBIT);
> -	entry->pci.msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
> +	entry->pci.msi_attrib.default_irq = dev->irq;
>  	entry->pci.msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
>  	entry->pci.msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
>  
> @@ -496,12 +493,11 @@ static int msix_setup_entries(struct pci
>  		entry->pci.msi_attrib.is_64	= 1;
>  
>  		if (entries)
> -			entry->pci.msi_attrib.entry_nr = entries[i].entry;
> +			entry->msi_index = entries[i].entry;
>  		else
> -			entry->pci.msi_attrib.entry_nr = i;
> +			entry->msi_index = i;
>  
> -		entry->pci.msi_attrib.is_virtual =
> -			entry->pci.msi_attrib.entry_nr >= vec_count;
> +		entry->pci.msi_attrib.is_virtual = entry->msi_index >= vec_count;
>  
>  		entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
>  						  !entry->pci.msi_attrib.is_virtual;
> @@ -1034,7 +1030,7 @@ int pci_irq_vector(struct pci_dev *dev,
>  		struct msi_desc *entry;
>  
>  		for_each_pci_msi_entry(entry, dev) {
> -			if (entry->pci.msi_attrib.entry_nr == nr)
> +			if (entry->msi_index == nr)
>  				return entry->irq;
>  		}
>  		WARN_ON_ONCE(1);
> @@ -1073,7 +1069,7 @@ const struct cpumask *pci_irq_get_affini
>  		struct msi_desc *entry;
>  
>  		for_each_pci_msi_entry(entry, dev) {
> -			if (entry->pci.msi_attrib.entry_nr == nr)
> +			if (entry->msi_index == nr)
>  				return &entry->affinity->mask;
>  		}
>  		WARN_ON_ONCE(1);
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -263,7 +263,7 @@ static int pci_frontend_enable_msix(stru
>  
>  	i = 0;
>  	for_each_pci_msi_entry(entry, dev) {
> -		op.msix_entries[i].entry = entry->pci.msi_attrib.entry_nr;
> +		op.msix_entries[i].entry = entry->msi_index;
>  		/* Vector is useless at this point. */
>  		op.msix_entries[i].vector = -1;
>  		i++;
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -80,7 +80,6 @@ typedef void (*irq_write_msi_msg_t)(stru
>   * @multi_cap:	[PCI MSI/X] log2 num of messages supported
>   * @can_mask:	[PCI MSI/X] Masking supported?
>   * @is_64:	[PCI MSI/X] Address size: 0=32bit 1=64bit
> - * @entry_nr:	[PCI MSI/X] Entry which is described by this descriptor
>   * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
>   * @mask_pos:	[PCI MSI]   Mask register position
>   * @mask_base:	[PCI MSI-X] Mask register base address
> @@ -97,7 +96,6 @@ struct pci_msi_desc {
>  		u8	can_mask	: 1;
>  		u8	is_64		: 1;
>  		u8	is_virtual	: 1;
> -		u16	entry_nr;
>  		unsigned default_irq;
>  	} msi_attrib;
>  	union {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
