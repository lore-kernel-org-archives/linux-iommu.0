Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE6DC433DF
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 20:07:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767DB20738
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 20:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4zLeGo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767DB20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 677A1882EC;
	Tue, 25 Aug 2020 20:07:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JijfwiLT94jp; Tue, 25 Aug 2020 20:07:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40CF9882B1;
	Tue, 25 Aug 2020 20:07:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33E11C07FF;
	Tue, 25 Aug 2020 20:07:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D547C0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:07:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6456286B1D
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:07:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eoiBrcjzsrFl for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 20:07:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3149C86B1C
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:07:44 +0000 (UTC)
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7C17D20738;
 Tue, 25 Aug 2020 20:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598386063;
 bh=YaQswRXI+GSH/he6lrf1zXvIORSUoUcZRaf2KaM0aQg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=j4zLeGo92A7idyLdF9wx1padjR1BkvijWirrN+DxgEJ80bcdC8FpwVMDmsikynYYX
 RflhFTwDDlLvi1z9ipQILUK45Xl/2KD6J8/5T+6i73r3Mswi/bzbfgcBEU8cEMdf1a
 EPw7h59JF5ItUvWJik/+iH27NdtyTyyC3QhM2pvw=
Date: Tue, 25 Aug 2020 15:07:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch RFC 30/38] PCI/MSI: Allow to disable arch fallbacks
Message-ID: <20200825200742.GA1924669@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200821002948.285988229@linutronix.de>
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

On Fri, Aug 21, 2020 at 02:24:54AM +0200, Thomas Gleixner wrote:
> If an architecture does not require the MSI setup/teardown fallback
> functions, then allow them to be replaced by stub functions which emit a
> warning.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Question/comment below.

> ---
>  drivers/pci/Kconfig |    3 +++
>  drivers/pci/msi.c   |    3 ++-
>  include/linux/msi.h |   31 ++++++++++++++++++++++++++-----
>  3 files changed, 31 insertions(+), 6 deletions(-)
> 
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -56,6 +56,9 @@ config PCI_MSI_IRQ_DOMAIN
>  	depends on PCI_MSI
>  	select GENERIC_MSI_IRQ_DOMAIN
>  
> +config PCI_MSI_DISABLE_ARCH_FALLBACKS
> +	bool
> +
>  config PCI_QUIRKS
>  	default y
>  	bool "Enable PCI quirk workarounds" if EXPERT
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -58,8 +58,8 @@ static void pci_msi_teardown_msi_irqs(st
>  #define pci_msi_teardown_msi_irqs	arch_teardown_msi_irqs
>  #endif
>  
> +#ifndef CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS
>  /* Arch hooks */
> -
>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  {
>  	struct msi_controller *chip = dev->bus->msi;
> @@ -132,6 +132,7 @@ void __weak arch_teardown_msi_irqs(struc
>  {
>  	return default_teardown_msi_irqs(dev);
>  }
> +#endif /* !CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS */
>  
>  static void default_restore_msi_irq(struct pci_dev *dev, int irq)
>  {
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -193,17 +193,38 @@ void pci_msi_mask_irq(struct irq_data *d
>  void pci_msi_unmask_irq(struct irq_data *data);
>  
>  /*
> - * The arch hooks to setup up msi irqs. Those functions are
> - * implemented as weak symbols so that they /can/ be overriden by
> - * architecture specific code if needed.
> + * The arch hooks to setup up msi irqs. Default functions are implemented
> + * as weak symbols so that they /can/ be overriden by architecture specific
> + * code if needed.
> + *
> + * They can be replaced by stubs with warnings via
> + * CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS when the architecture fully
> + * utilizes direct irqdomain based setup.

Do you expect *all* arches to eventually use direct irqdomain setup?
And in that case, to remove the config option?

If not, it seems like it'd be nicer to have the burden on the arches
that need/want to use arch-specific code instead of on the arches that
do things generically.

>   */
> +#ifndef CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS
>  int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
>  void arch_teardown_msi_irq(unsigned int irq);
>  int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
>  void arch_teardown_msi_irqs(struct pci_dev *dev);
> -void arch_restore_msi_irqs(struct pci_dev *dev);
> -
>  void default_teardown_msi_irqs(struct pci_dev *dev);
> +#else
> +static inline int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +{
> +	WARN_ON_ONCE(1);
> +	return -ENODEV;
> +}
> +
> +static inline void arch_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	WARN_ON_ONCE(1);
> +}
> +#endif
> +
> +/*
> + * The restore hooks are still available as they are useful even
> + * for fully irq domain based setups. Courtesy to XEN/X86.
> + */
> +void arch_restore_msi_irqs(struct pci_dev *dev);
>  void default_restore_msi_irqs(struct pci_dev *dev);
>  
>  struct msi_controller {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
