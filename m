Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512E0C433ED
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 06:40:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA6A23109
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 06:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA6A23109
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E2D9D87EB5;
	Mon, 24 Aug 2020 06:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5G3p-SckZnFB; Mon, 24 Aug 2020 06:21:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 58D3C87E78;
	Mon, 24 Aug 2020 06:21:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3821CC016F;
	Mon, 24 Aug 2020 06:21:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06F15C0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 06:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DAA6C2044F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 06:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id khvUk4-nb+sW for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 06:21:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 433C720018
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 06:21:09 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C1123AC3F;
 Mon, 24 Aug 2020 06:21:36 +0000 (UTC)
Subject: Re: [patch RFC 26/38] x86/xen: Wrap XEN MSI management into irqdomain
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20200821002424.119492231@linutronix.de>
 <20200821002947.868727656@linutronix.de>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8860c7bc-67ab-ce64-0340-1458d2483a39@suse.com>
Date: Mon, 24 Aug 2020 08:21:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821002947.868727656@linutronix.de>
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
> To allow utilizing the irq domain pointer in struct device it is necessary
> to make XEN/MSI irq domain compatible.
> 
> While the right solution would be to truly convert XEN to irq domains, this
> is an exercise which is not possible for mere mortals with limited XENology.
> 
> Provide a plain irqdomain wrapper around XEN. While this is blatant
> violation of the irqdomain design, it's the only solution for a XEN igorant
> person to make progress on the issue which triggered this change.
> 
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> Cc:linux-pci@vger.kernel.org
> Cc:xen-devel@lists.xenproject.org

Acked-by: Juergen Gross <jgross@suse.com>

Looking into https://www.kernel.org/doc/Documentation/IRQ-domain.txt (is
this still valid?) I believe Xen should be able to use the "No Map"
approach, as Xen only ever uses software IRQs (at least those are the
only ones visible to any driver). The (virtualized) hardware interrupts
are Xen events after all.

So maybe morphing Xen into supporting irqdomains in a sane way isn't
that complicated. Maybe I'm missing the main complexities, though.


Juergen

> ---
> Note: This is completely untested, but it compiles so it must be perfect.
> ---
>   arch/x86/pci/xen.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -406,6 +406,63 @@ static void xen_teardown_msi_irq(unsigne
>   	WARN_ON_ONCE(1);
>   }
>   
> +static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
> +				     struct device *dev,  int nvec)
> +{
> +	int type;
> +
> +	if (WARN_ON_ONCE(!dev_is_pci(dev)))
> +		return -EINVAL;
> +
> +	if (first_msi_entry(dev)->msi_attrib.is_msix)
> +		type = PCI_CAP_ID_MSIX;
> +	else
> +		type = PCI_CAP_ID_MSI;
> +
> +	return x86_msi.setup_msi_irqs(to_pci_dev(dev), nvec, type);
> +}
> +
> +static void xen_msi_domain_free_irqs(struct irq_domain *domain,
> +				     struct device *dev)
> +{
> +	if (WARN_ON_ONCE(!dev_is_pci(dev)))
> +		return;
> +
> +	x86_msi.teardown_msi_irqs(to_pci_dev(dev));
> +}
> +
> +static struct msi_domain_ops xen_pci_msi_domain_ops = {
> +	.domain_alloc_irqs	= xen_msi_domain_alloc_irqs,
> +	.domain_free_irqs	= xen_msi_domain_free_irqs,
> +};
> +
> +static struct msi_domain_info xen_pci_msi_domain_info = {
> +	.ops			= &xen_pci_msi_domain_ops,
> +};
> +
> +/*
> + * This irq domain is a blatant violation of the irq domain design, but
> + * distangling XEN into real irq domains is not a job for mere mortals with
> + * limited XENology. But it's the least dangerous way for a mere mortal to
> + * get rid of the arch_*_msi_irqs() hackery in order to store the irq
> + * domain pointer in struct device. This irq domain wrappery allows to do
> + * that without breaking XEN terminally.
> + */
> +static __init struct irq_domain *xen_create_pci_msi_domain(void)
> +{
> +	struct irq_domain *d = NULL;
> +	struct fwnode_handle *fn;
> +
> +	fn = irq_domain_alloc_named_fwnode("XEN-MSI");
> +	if (fn)
> +		d = msi_create_irq_domain(fn, &xen_pci_msi_domain_info, NULL);
> +
> +	/* FIXME: No idea how to survive if this fails */
> +	BUG_ON(!d);
> +
> +	return d;
> +}
> +
>   static __init void xen_setup_pci_msi(void)
>   {
>   	if (xen_initial_domain()) {
> @@ -426,6 +483,12 @@ static __init void xen_setup_pci_msi(voi
>   	}
>   
>   	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
> +
> +	/*
> +	 * Override the PCI/MSI irq domain init function. No point
> +	 * in allocating the native domain and never use it.
> +	 */
> +	x86_init.irqs.create_pci_msi_domain = xen_create_pci_msi_domain;
>   }
>   
>   #else /* CONFIG_PCI_MSI */
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
