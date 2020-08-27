Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000DDC433E1
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 08:17:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16BF22B49
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 08:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmsP/B8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16BF22B49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 94B9686D01;
	Thu, 27 Aug 2020 08:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j1Gi5ZAJxz9r; Thu, 27 Aug 2020 08:17:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11B2C86BED;
	Thu, 27 Aug 2020 08:17:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7CA5C07FF;
	Thu, 27 Aug 2020 08:17:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D54D6C0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 08:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BD95787866
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 08:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mijf6y38qYqb for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 08:17:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 29E068768B
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 08:17:16 +0000 (UTC)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 86A5D22CAF;
 Thu, 27 Aug 2020 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598516235;
 bh=f0/TTg7ydrldBCfzfcvkuWCMzTaAgtKPEMau/tanrpk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TmsP/B8ZI27FXcca++ez4/wY7bzEmEEis+Dyck/1ERZwMR0OuB91mKNhtYQsF0Xbx
 /e0s5LTBumjF95gOBL1dlpZN5H4zC/AJG1WooHCqj6zZkqNGswYFi4R4DmuLUe3yCV
 JdcXgX7JS8A29KaJ8sw9cYHnN3K3LQoA4KkOn7HI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kBD5t-0074EG-T5; Thu, 27 Aug 2020 09:17:14 +0100
MIME-Version: 1.0
Date: Thu, 27 Aug 2020 09:17:13 +0100
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 43/46] genirq/msi: Provide and use
 msi_domain_set_default_info_flags()
In-Reply-To: <20200826112334.889315931@linutronix.de>
References: <20200826111628.794979401@linutronix.de>
 <20200826112334.889315931@linutronix.de>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <b80607e87e43730133dd9f619c6464dc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
 x86@kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org,
 linux-hyperv@vger.kernel.org, haiyangz@microsoft.com,
 jonathan.derrick@intel.com, baolu.lu@linux.intel.com, wei.liu@kernel.org,
 kys@microsoft.com, sthemmin@microsoft.com, steve.wahl@hpe.com,
 sivanich@hpe.com, rja@hpe.com, linux-pci@vger.kernel.org, bhelgaas@google.com,
 lorenzo.pieralisi@arm.com, konrad.wilk@oracle.com,
 xen-devel@lists.xenproject.org, jgross@suse.com, boris.ostrovsky@oracle.com,
 sstabellini@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
 megha.dey@intel.com, jgg@mellanox.com, dave.jiang@intel.com,
 alex.williamson@redhat.com, jacob.jun.pan@intel.com, baolu.lu@intel.com,
 kevin.tian@intel.com, dan.j.williams@intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 x86@kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
 Megha Dey <megha.dey@intel.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-08-26 12:17, Thomas Gleixner wrote:
> MSI interrupts have some common flags which should be set not only for
> PCI/MSI interrupts.
> 
> Move the PCI/MSI flag setting into a common function so it can be 
> reused.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  drivers/pci/msi.c   |    7 +------
>  include/linux/msi.h |    1 +
>  kernel/irq/msi.c    |   24 ++++++++++++++++++++++++
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1469,12 +1469,7 @@ struct irq_domain *pci_msi_create_irq_do
>  	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>  		pci_msi_domain_update_chip_ops(info);
> 
> -	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
> -	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
> -		info->flags |= MSI_FLAG_MUST_REACTIVATE;
> -
> -	/* PCI-MSI is oneshot-safe */
> -	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> +	msi_domain_set_default_info_flags(info);
> 
>  	domain = msi_create_irq_domain(fwnode, info, parent);
>  	if (!domain)
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -410,6 +410,7 @@ int platform_msi_domain_alloc(struct irq
>  void platform_msi_domain_free(struct irq_domain *domain, unsigned int 
> virq,
>  			      unsigned int nvec);
>  void *platform_msi_get_host_data(struct irq_domain *domain);
> +void msi_domain_set_default_info_flags(struct msi_domain_info *info);
>  #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
> 
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -70,6 +70,30 @@ void get_cached_msi_msg(unsigned int irq
>  EXPORT_SYMBOL_GPL(get_cached_msi_msg);
> 
>  #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +void msi_domain_set_default_info_flags(struct msi_domain_info *info)
> +{
> +	/* Required so that a device latches a valid MSI message on startup 
> */
> +	info->flags |= MSI_FLAG_ACTIVATE_EARLY;

As far as I remember the story behind this flag (it's been a while),
it was working around a PCI-specific issue, hence being located in
the PCI code.

Now, the "program the MSI before enabling it" concept makes sense no 
matter
what bus this is on, and I wonder why we are even keeping this flag 
around.
Can't we just drop it together with the check in 
msi_domain_alloc_irqs()?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
