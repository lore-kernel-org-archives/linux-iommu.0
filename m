Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241E3C2BB1D
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 20:59:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA74206B7
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 20:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoAaCQPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA74206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C4E7585116;
	Thu, 12 Mar 2020 20:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ee2DNe8AbDAU; Thu, 12 Mar 2020 20:59:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C4595850EA;
	Thu, 12 Mar 2020 20:59:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD071C089F;
	Thu, 12 Mar 2020 20:59:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F058DC0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 20:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DEC068758D
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 20:59:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I2jxUnl-099Q for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 20:59:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5CF378701C
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 20:59:00 +0000 (UTC)
Received: from localhost (mobile-166-175-186-165.mycingular.net
 [166.175.186.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CA66B206B7;
 Thu, 12 Mar 2020 20:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584046740;
 bh=sZrxWzYm4Q2gQ/nKayUGqNHfr3nP8m8qZiAHKqaks08=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=YoAaCQPJTwGmp7XWP86L78EAbP87WHaly0Mp6Ed8cwzHqWkTNzAekl0Vckbc5pcmt
 sHCTW0fPtyDVPWOuPF8zuumu2s9LhFTzzRroslWpC97D1efkVIlDqL6XyysJdOWTM/
 cfylvimv3zTN/vGEqEvIIqwZ9L3tXOyXL77JU+ks=
Date: Thu, 12 Mar 2020 15:58:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 04/11] ACPI/IORT: Check ATS capability in root complex
 node
Message-ID: <20200312205858.GA178807@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311124506.208376-5-jean-philippe@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: mark.rutland@arm.com, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 liviu.dudau@arm.com, guohanjun@huawei.com, frowand.list@gmail.com,
 corbet@lwn.net, will@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 amurray@thegoodpenguin.co.uk
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

On Wed, Mar 11, 2020 at 01:44:59PM +0100, Jean-Philippe Brucker wrote:
> When initializing a PCI root bridge, copy its "ATS supported" attribute
> into the root bridge.
> 
> Acked-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/acpi/arm64/iort.c | 27 +++++++++++++++++++++++++++
>  drivers/acpi/pci_root.c   |  3 +++
>  include/linux/acpi_iort.h |  8 ++++++++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ed3d2d1a7ae9..d99d7f5b51e1 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1633,6 +1633,33 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  		}
>  	}
>  }
> +
> +static acpi_status iort_match_host_bridge_callback(struct acpi_iort_node *node,
> +						   void *context)
> +{
> +	struct acpi_iort_root_complex *pci_rc;
> +	struct pci_host_bridge *host_bridge = context;
> +
> +	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
> +
> +	return pci_domain_nr(host_bridge->bus) == pci_rc->pci_segment_number ?
> +		AE_OK : AE_NOT_FOUND;
> +}
> +
> +void iort_pci_host_bridge_setup(struct pci_host_bridge *host_bridge)
> +{
> +	struct acpi_iort_node *node;
> +	struct acpi_iort_root_complex *pci_rc;
> +
> +	node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> +			      iort_match_host_bridge_callback, host_bridge);
> +	if (!node)
> +		return;
> +
> +	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
> +	host_bridge->ats_supported = !!(pci_rc->ats_attribute &
> +					ACPI_IORT_ATS_SUPPORTED);
> +}
>  #else
>  static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
>  #endif
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d1e666ef3fcc..eb2fb8f17c0b 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -6,6 +6,7 @@
>   *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
>   */
>  
> +#include <linux/acpi_iort.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -917,6 +918,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
>  		host_bridge->native_ltr = 0;
>  
> +	iort_pci_host_bridge_setup(host_bridge);

Similar comment as on the OF side.

You mentioned at [1] that "it's important that we only enable ATS if
the host bridge supports it".  That should be captured in a commit log
and comment somewhere here.

That suggests to me that we should not set

  bridge->ats_supported = 1;

by default in pci_init_host_bridge(), but rather leave it zero as it
is by default, and then do things like:

  if (iort_pci_host_bridge_ats_supported(bridge))
    bridge->ats_supported = 1;

  if (of_pci_host_bridge_ats_supported(bridge))
    bridge->ats_supported = 1;

I don't know what you do about IVRS and DMAR, which don't appear in
this series except in the comment.

[1] https://lore.kernel.org/r/20200213165049.508908-1-jean-philippe@linaro.org

>  	/*
>  	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
>  	 * exists and returns 0, we must preserve any PCI resource
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 8e7e2ec37f1b..7b06871cc3aa 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -10,6 +10,7 @@
>  #include <linux/acpi.h>
>  #include <linux/fwnode.h>
>  #include <linux/irqdomain.h>
> +#include <linux/pci.h>
>  
>  #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
>  #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
> @@ -55,4 +56,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  { return 0; }
>  #endif
>  
> +#if defined(CONFIG_ACPI_IORT) && defined(CONFIG_PCI)
> +void iort_pci_host_bridge_setup(struct pci_host_bridge *host_bridge);
> +#else
> +static inline
> +void iort_pci_host_bridge_setup(struct pci_host_bridge *host_bridge) { }
> +#endif
> +
>  #endif /* __ACPI_IORT_H__ */
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
