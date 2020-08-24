Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF30C433E1
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 05:09:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14B920706
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 05:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14B920706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 67EB52011A;
	Mon, 24 Aug 2020 05:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2bJpjH59NrYn; Mon, 24 Aug 2020 05:09:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 25D5A2045C;
	Mon, 24 Aug 2020 05:09:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F4154C07FF;
	Mon, 24 Aug 2020 05:09:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A77E2C0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 05:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8F02985A96
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 05:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fPHeR3Ulkd22 for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 05:09:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6B0B785A92
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 05:09:38 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 36A65AD71;
 Mon, 24 Aug 2020 05:10:06 +0000 (UTC)
Subject: Re: [patch RFC 23/38] x86/xen: Rework MSI teardown
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20200821002424.119492231@linutronix.de>
 <20200821002947.575838946@linutronix.de>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <c81c2536-2258-19b0-4d77-0de1d2fa88db@suse.com>
Date: Mon, 24 Aug 2020 07:09:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821002947.575838946@linutronix.de>
Content-Language: en-US
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
 Jon Derrick <jonathan.derrick@intel.com>, Russ Anderson <rja@hpe.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 21.08.20 02:24, Thomas Gleixner wrote:
> X86 cannot store the irq domain pointer in struct device without breaking
> XEN because the irq domain pointer takes precedence over arch_*_msi_irqs()
> fallbacks.
> 
> XENs MSI teardown relies on default_teardown_msi_irqs() which invokes
> arch_teardown_msi_irq(). default_teardown_msi_irqs() is a trivial iterator
> over the msi entries associated to a device.
> 
> Implement this loop in xen_teardown_msi_irqs() to prepare for removal of
> the fallbacks for X86.
> 
> This is a preparatory step to wrap XEN MSI alloc/free into a irq domain
> which in turn allows to store the irq domain pointer in struct device and
> to use the irq domain functions directly.
> 
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> ---
>   arch/x86/pci/xen.c |   23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -376,20 +376,31 @@ static void xen_initdom_restore_msi_irqs
>   static void xen_teardown_msi_irqs(struct pci_dev *dev)
>   {
>   	struct msi_desc *msidesc;
> +	int i;
> +
> +	for_each_pci_msi_entry(msidesc, dev) {
> +		if (msidesc->irq) {
> +			for (i = 0; i < msidesc->nvec_used; i++)
> +				xen_destroy_irq(msidesc->irq + i);
> +		}
> +	}
> +}
> +
> +static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	struct msi_desc *msidesc = first_pci_msi_entry(dev);
>   
> -	msidesc = first_pci_msi_entry(dev);
>   	if (msidesc->msi_attrib.is_msix)
>   		xen_pci_frontend_disable_msix(dev);
>   	else
>   		xen_pci_frontend_disable_msi(dev);
>   
> -	/* Free the IRQ's and the msidesc using the generic code. */
> -	default_teardown_msi_irqs(dev);
> +	xen_teardown_msi_irqs(dev);
>   }
>   
>   static void xen_teardown_msi_irq(unsigned int irq)
>   {
> -	xen_destroy_irq(irq);
> +	WARN_ON_ONCE(1);
>   }
>   
>   #endif
> @@ -412,7 +423,7 @@ int __init pci_xen_init(void)
>   #ifdef CONFIG_PCI_MSI
>   	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
>   	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
> -	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
> +	x86_msi.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
>   	pci_msi_ignore_mask = 1;
>   #endif
>   	return 0;
> @@ -436,6 +447,7 @@ static void __init xen_hvm_msi_init(void
>   	}
>   
>   	x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
> +	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
>   	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
>   }
>   #endif
> @@ -472,6 +484,7 @@ int __init pci_xen_initial_domain(void)
>   #ifdef CONFIG_PCI_MSI
>   	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
>   	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
> +	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;

This should be xen_pv_teardown_msi_irqs, as pci_xen_initial_domain() is
called only for the pv initial domain case today.

>   	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
>   	pci_msi_ignore_mask = 1;
>   #endif
> 


Juergen
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
