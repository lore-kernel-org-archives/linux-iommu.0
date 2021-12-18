Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A36C433F5
	for <iommu@archiver.kernel.org>; Sat, 18 Dec 2021 19:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B39341F7C;
	Sat, 18 Dec 2021 19:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjzG_e88mcT6; Sat, 18 Dec 2021 19:05:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2DDCC41F1D;
	Sat, 18 Dec 2021 19:05:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDA15C002F;
	Sat, 18 Dec 2021 19:05:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90EFDC0012
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 19:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F0FC400C5
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 19:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nfuukevuJMFk for <iommu@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 19:05:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D9FD4000B
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 19:05:13 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5D7DCB80781;
 Sat, 18 Dec 2021 19:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B24C36AE1;
 Sat, 18 Dec 2021 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639854309;
 bh=I6eVKACPJvnI+llvjluP6wdaS6TfkgpPNWmOCTJo2Tw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UMWo6BEBXL2vg9tHjb81KQokUbnD5ds+HV7ckML33awGfTpej3ik5Kh3h6cfpyyqb
 iFD4s+bZZ21aukh38a1Cdxv3Q680qbPDCrFRz4IUjxJcGtElf80NOxI08WBU35o5KO
 DNmZrv9Ka1wwC0RRN+bNzFNGCbR++Trade1JV0IXvYj4pEQ88pbWel1kl4y4dka9Vy
 v30sM76UJThM+xQ2PiEuVOz+Jtb0pMSsUUbW+ySVU2WJmK0RZD3dGbXyS/PYo1GOwF
 IJYYSA0Plrin3iwRee9bWx/w6bJtImnOGvLxXhdQqwr2xAa+xaDpfppDhnDsxbFplJ
 vGcX7+wVGtViQ==
Date: Sat, 18 Dec 2021 12:04:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
Message-ID: <Yb4w2wVvIwN7qaNy@archlinux-ax161>
References: <20211210221642.869015045@linutronix.de>
 <20211210221814.900929381@linutronix.de>
 <Yb0PaCyo/6z3XOlf@archlinux-ax161> <87v8zm9pmd.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87v8zm9pmd.ffs@tglx>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

On Sat, Dec 18, 2021 at 11:25:14AM +0100, Thomas Gleixner wrote:
> On Fri, Dec 17 2021 at 15:30, Nathan Chancellor wrote:
> > On Fri, Dec 10, 2021 at 11:19:26PM +0100, Thomas Gleixner wrote:
> > I just bisected a boot failure on my AMD test desktop to this patch as
> > commit f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()") in
> > -next. It looks like there is a problem with the NVMe drive after this
> > change according to the logs. Given that the hard drive is not getting
> > mounted for journald to write logs to, I am not really sure how to get
> > them from the machine so I have at least taken a picture of what I see
> > on my screen; open to ideas on that front!
> 
> Bah. Fix below.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> Thanks,
> 
>         tglx
> ---
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 71802410e2ab..9b4910befeda 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -1100,7 +1100,7 @@ EXPORT_SYMBOL(pci_irq_vector);
>   */
>  const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>  {
> -	int irq = pci_irq_vector(dev, nr);
> +	int idx, irq = pci_irq_vector(dev, nr);
>  	struct msi_desc *desc;
>  
>  	if (WARN_ON_ONCE(irq <= 0))
> @@ -1113,7 +1113,10 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>  
>  	if (WARN_ON_ONCE(!desc->affinity))
>  		return NULL;
> -	return &desc->affinity[nr].mask;
> +
> +	/* MSI has a mask array in the descriptor. */
> +	idx = dev->msi_enabled ? nr : 0;
> +	return &desc->affinity[idx].mask;
>  }
>  EXPORT_SYMBOL(pci_irq_get_affinity);
>  
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
