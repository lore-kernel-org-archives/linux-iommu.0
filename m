Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0772DC433E3
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 20:24:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D223920767
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 20:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5SctpDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D223920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9519886B19;
	Tue, 25 Aug 2020 20:24:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Cv5CuEQz35d; Tue, 25 Aug 2020 20:24:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11345868CF;
	Tue, 25 Aug 2020 20:24:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3CDEC016F;
	Tue, 25 Aug 2020 20:24:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B16CC0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0FAAE204AF
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:24:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lyww-UG3Jusu for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 20:24:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id EB58320458
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:24:20 +0000 (UTC)
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 23A772074D;
 Tue, 25 Aug 2020 20:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598387060;
 bh=ySOkd6aDLwyhEWNu5XId2t2Myh+7GbuDeWGuL4FyNs4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=E5SctpDfmJVH3GOS41BdxD1KAKCCgLGp5cRY/d4s5Iaw4NV/9UXP/0IZXYISEg/D5
 7jTqAEVySonTUr8pSMzETXyOu0kEsTuPgpG2nWnP9vXaG+N4MEWZk+TCj7M2xX2ukA
 qdRiLK425Y+fBMqVUhac3FmUSyR6dzlO73HmofKg=
Date: Tue, 25 Aug 2020 15:24:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch RFC 34/38] x86/msi: Let pci_msi_prepare() handle non-PCI
 MSI
Message-ID: <20200825202419.GA1925250@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200821002948.664301259@linutronix.de>
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

On Fri, Aug 21, 2020 at 02:24:58AM +0200, Thomas Gleixner wrote:
> Rename it to x86_msi_prepare() and handle the allocation type setup
> depending on the device type.

I see what you're doing, but the subject reads a little strangely
("pci_msi_prepare() handling non-PCI" stuff) since it doesn't mention
the rename.  Maybe not practical or worthwhile to split into a rename
+ make generic, I dunno.

> Add a new arch_msi_prepare define which will be utilized by the upcoming
> device MSI support. Define it to NULL if not provided by an architecture in
> the generic MSI header.
> 
> One arch specific function for MSI support is truly enough.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-hyperv@vger.kernel.org
> ---
>  arch/x86/include/asm/msi.h          |    4 +++-
>  arch/x86/kernel/apic/msi.c          |   27 ++++++++++++++++++++-------
>  drivers/pci/controller/pci-hyperv.c |    2 +-
>  include/linux/msi.h                 |    4 ++++
>  4 files changed, 28 insertions(+), 9 deletions(-)
> 
> --- a/arch/x86/include/asm/msi.h
> +++ b/arch/x86/include/asm/msi.h
> @@ -6,7 +6,9 @@
>  
>  typedef struct irq_alloc_info msi_alloc_info_t;
>  
> -int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
> +int x86_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
>  		    msi_alloc_info_t *arg);
>  
> +#define arch_msi_prepare		x86_msi_prepare
> +
>  #endif /* _ASM_X86_MSI_H */
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -182,26 +182,39 @@ static struct irq_chip pci_msi_controlle
>  	.flags			= IRQCHIP_SKIP_SET_WAKE,
>  };
>  
> -int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
> -		    msi_alloc_info_t *arg)
> +static void pci_msi_prepare(struct device *dev, msi_alloc_info_t *arg)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct msi_desc *desc = first_pci_msi_entry(pdev);
> +	struct msi_desc *desc = first_msi_entry(dev);
>  
> -	init_irq_alloc_info(arg, NULL);
>  	if (desc->msi_attrib.is_msix) {
>  		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
>  	} else {
>  		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
>  		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
>  	}
> +}
> +
> +static void dev_msi_prepare(struct device *dev, msi_alloc_info_t *arg)
> +{
> +	arg->type = X86_IRQ_ALLOC_TYPE_DEV_MSI;
> +}
> +
> +int x86_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
> +		    msi_alloc_info_t *arg)
> +{
> +	init_irq_alloc_info(arg, NULL);
> +
> +	if (dev_is_pci(dev))
> +		pci_msi_prepare(dev, arg);
> +	else
> +		dev_msi_prepare(dev, arg);
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(pci_msi_prepare);
> +EXPORT_SYMBOL_GPL(x86_msi_prepare);
>  
>  static struct msi_domain_ops pci_msi_domain_ops = {
> -	.msi_prepare	= pci_msi_prepare,
> +	.msi_prepare	= x86_msi_prepare,
>  };
>  
>  static struct msi_domain_info pci_msi_domain_info = {
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1532,7 +1532,7 @@ static struct irq_chip hv_msi_irq_chip =
>  };
>  
>  static struct msi_domain_ops hv_msi_ops = {
> -	.msi_prepare	= pci_msi_prepare,
> +	.msi_prepare	= arch_msi_prepare,
>  	.msi_free	= hv_msi_free,
>  };
>  
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -430,4 +430,8 @@ static inline struct irq_domain *pci_msi
>  }
>  #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
>  
> +#ifndef arch_msi_prepare
> +# define arch_msi_prepare	NULL
> +#endif
> +
>  #endif /* LINUX_MSI_H */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
