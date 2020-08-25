Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1A2C433DF
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 20:20:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53CF2075F
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 20:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeuOVm1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53CF2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8676E86B1A;
	Tue, 25 Aug 2020 20:20:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UFbscAEab7Xb; Tue, 25 Aug 2020 20:20:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EF65F868E5;
	Tue, 25 Aug 2020 20:20:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA64DC016F;
	Tue, 25 Aug 2020 20:20:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11C46C0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0943B882EC
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uNh9EoBnpNWG for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 20:20:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8AA52882EB
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:20:02 +0000 (UTC)
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 01E6D2074D;
 Tue, 25 Aug 2020 20:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598386802;
 bh=SS+t45IQlef2ZNO8GZOFRl2+c25Lro4JNuNwmNwc8zQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=UeuOVm1ZSIo+ErhE6OlxewMDFPnV4NsWvJxM77q2rQm3Y6ZJ+3mnLIcJH7jIXO4EC
 /XE+2wmGjyHazKgT/AJKml79ce5k1iC5Q8WKAKcLKlgCau+LQEJi/95s8aaS2ETMil
 Wsikip6rcjjaxBoIOlqOC42TYjOKJ7dhkIDcMCCw=
Date: Tue, 25 Aug 2020 15:20:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch RFC 17/38] x86/pci: Reducde #ifdeffery in PCI init code
Message-ID: <20200825202000.GA1925088@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200821002946.982695529@linutronix.de>
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

s/Reducde/Reduce/ (in subject)

On Fri, Aug 21, 2020 at 02:24:41AM +0200, Thomas Gleixner wrote:
> Adding a function call before the first #ifdef in arch_pci_init() triggers
> a 'mixed declarations and code' warning if PCI_DIRECT is enabled.
> 
> Use stub functions and move the #ifdeffery to the header file where it is
> not in the way.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-pci@vger.kernel.org

Nice cleanup, thanks.  Glad to get rid of the useless initializer,
too.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  arch/x86/include/asm/pci_x86.h |   11 +++++++++++
>  arch/x86/pci/init.c            |   10 +++-------
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -114,9 +114,20 @@ extern const struct pci_raw_ops pci_dire
>  extern bool port_cf9_safe;
>  
>  /* arch_initcall level */
> +#ifdef CONFIG_PCI_DIRECT
>  extern int pci_direct_probe(void);
>  extern void pci_direct_init(int type);
> +#else
> +static inline int pci_direct_probe(void) { return -1; }
> +static inline  void pci_direct_init(int type) { }
> +#endif
> +
> +#ifdef CONFIG_PCI_BIOS
>  extern void pci_pcbios_init(void);
> +#else
> +static inline void pci_pcbios_init(void) { }
> +#endif
> +
>  extern void __init dmi_check_pciprobe(void);
>  extern void __init dmi_check_skip_isa_align(void);
>  
> --- a/arch/x86/pci/init.c
> +++ b/arch/x86/pci/init.c
> @@ -8,11 +8,9 @@
>     in the right sequence from here. */
>  static __init int pci_arch_init(void)
>  {
> -#ifdef CONFIG_PCI_DIRECT
> -	int type = 0;
> +	int type;
>  
>  	type = pci_direct_probe();
> -#endif
>  
>  	if (!(pci_probe & PCI_PROBE_NOEARLY))
>  		pci_mmcfg_early_init();
> @@ -20,18 +18,16 @@ static __init int pci_arch_init(void)
>  	if (x86_init.pci.arch_init && !x86_init.pci.arch_init())
>  		return 0;
>  
> -#ifdef CONFIG_PCI_BIOS
>  	pci_pcbios_init();
> -#endif
> +
>  	/*
>  	 * don't check for raw_pci_ops here because we want pcbios as last
>  	 * fallback, yet it's needed to run first to set pcibios_last_bus
>  	 * in case legacy PCI probing is used. otherwise detecting peer busses
>  	 * fails.
>  	 */
> -#ifdef CONFIG_PCI_DIRECT
>  	pci_direct_init(type);
> -#endif
> +
>  	if (!raw_pci_ops && !raw_pci_ext_ops)
>  		printk(KERN_ERR
>  		"PCI: Fatal: No config space access function found\n");
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
