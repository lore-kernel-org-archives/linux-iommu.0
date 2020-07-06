Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C95C433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 16:38:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F830206DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 16:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJeMrlVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F830206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2BFD088B61;
	Mon,  6 Jul 2020 16:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B1tzkmzexrbo; Mon,  6 Jul 2020 16:38:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5E19888B49;
	Mon,  6 Jul 2020 16:38:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43B74C0891;
	Mon,  6 Jul 2020 16:38:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE80BC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 16:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BA0FA89407
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 16:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KwfP-Mp4RnY8 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 16:38:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E35A389403
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 16:38:06 +0000 (UTC)
Received: from localhost (mobile-166-175-191-139.mycingular.net
 [166.175.191.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4DFCA206CD;
 Mon,  6 Jul 2020 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594053486;
 bh=h5Wfn3HjIiXXhkf+M34R0UCWrLS9Ym2zaBVYF7o20HY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=gJeMrlVKeXf1hw7Srvob2oOpPzBsNGaCeiFEJ+LQzaVKhYbrlKPmFkGdYmrfMFUwc
 Ld3mkXuOJa9U4mWbnSYaf+Vq4Q5MicOSEBp9KH8DY8/98sorKBQfQISXTBGxc+khFT
 8Q+9AXK2ocdqROk8v2rot2AEd87cQF7DZzpa8u0k=
Date: Mon, 6 Jul 2020 11:38:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external
 devices only
Message-ID: <20200706163805.GA120024@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630044943.3425049-3-rajatja@google.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci@vger.kernel.org,
 lalithambika.krishnakumar@intel.com,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 oohall@gmail.com, Benson Leung <bleung@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Alex Levin <levinale@google.com>
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

On Mon, Jun 29, 2020 at 09:49:38PM -0700, Rajat Jain wrote:
> The "ExternalFacing" devices (root ports) are still internal devices that
> sit on the internal system fabric and thus trusted. Currently they were
> being marked untrusted.
> 
> This patch uses the platform flag to identify the external facing devices
> and then use it to mark any downstream devices as "untrusted". The
> external-facing devices themselves are left as "trusted". This was
> discussed here: https://lkml.org/lkml/2020/6/10/1049

Use the imperative mood in the commit log, as you did for 1/7.  E.g.,
instead of "This patch uses ...", say "Use the platform flag ...".
That helps all the commit logs read nicely together.

I think this patch makes two changes that should be separated:

  - Treat "external-facing" devices as internal.

  - Look for the "external-facing" or "ExternalFacing" property on
    Switch Downstream Ports as well as Root Ports.

> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: cosmetic changes in commit log
> 
>  drivers/iommu/intel/iommu.c |  2 +-
>  drivers/pci/of.c            |  2 +-
>  drivers/pci/pci-acpi.c      | 13 +++++++------
>  drivers/pci/probe.c         |  2 +-
>  include/linux/pci.h         |  8 ++++++++
>  5 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d759e7234e982..1ccb224f82496 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4743,7 +4743,7 @@ static inline bool has_untrusted_dev(void)
>  	struct pci_dev *pdev = NULL;
>  
>  	for_each_pci_dev(pdev)
> -		if (pdev->untrusted)
> +		if (pdev->untrusted || pdev->external_facing)

I think checking pdev->external_facing is enough for this case,
because it's impossible to have pdev->untrusted unless a parent has
pdev->external_facing.

IIUC, this usage is asking "might we ever have an external device?"
as opposed to the "pdev->untrusted" uses, which are asking "is *this*
device an external device?"

>  			return true;
>  
>  	return false;
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 27839cd2459f6..22727fc9558df 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -42,7 +42,7 @@ void pci_set_bus_of_node(struct pci_bus *bus)
>  	} else {
>  		node = of_node_get(bus->self->dev.of_node);
>  		if (node && of_property_read_bool(node, "external-facing"))
> -			bus->self->untrusted = true;
> +			bus->self->external_facing = true;
>  	}
>  
>  	bus->dev.of_node = node;
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 7224b1e5f2a83..492c07805caf8 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1213,22 +1213,23 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  	ACPI_FREE(obj);
>  }
>  
> -static void pci_acpi_set_untrusted(struct pci_dev *dev)
> +static void pci_acpi_set_external_facing(struct pci_dev *dev)
>  {
>  	u8 val;
>  
> -	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> +	    pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)

This looks like a change worthy of its own patch.  We used to look for
"ExternalFacingPort" only on Root Ports; now we'll also do it for
Switch Downstream Ports.

Can you include DT and ACPI spec references if they exist?  I found
this mention:
https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
which actually says it should only be implemented for Root Ports.

It also mentions a "DmaProperty" that looks related.  Maybe Linux
should also pay attention to this?

If we do change this, should we use pcie_downstream_port(), which
includes PCI-to-PCIe bridges as well?

>  		return;
>  	if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
>  		return;
>  
>  	/*
> -	 * These root ports expose PCIe (including DMA) outside of the
> -	 * system so make sure we treat them and everything behind as
> +	 * These root/down ports expose PCIe (including DMA) outside of the
> +	 * system so make sure we treat everything behind them as
>  	 * untrusted.
>  	 */
>  	if (val)
> -		dev->untrusted = 1;
> +		dev->external_facing = 1;
>  }
>  
>  static void pci_acpi_setup(struct device *dev)
> @@ -1240,7 +1241,7 @@ static void pci_acpi_setup(struct device *dev)
>  		return;
>  
>  	pci_acpi_optimize_delay(pci_dev, adev->handle);
> -	pci_acpi_set_untrusted(pci_dev);
> +	pci_acpi_set_external_facing(pci_dev);
>  	pci_acpi_add_edr_notifier(pci_dev);
>  
>  	pci_acpi_add_pm_notifier(adev, pci_dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6d87066a5ecc5..8c40c00413e74 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1552,7 +1552,7 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>  	 * untrusted as well.
>  	 */
>  	parent = pci_upstream_bridge(dev);
> -	if (parent && parent->untrusted)
> +	if (parent && (parent->untrusted || parent->external_facing))
>  		dev->untrusted = true;
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a26be5332bba6..fe1bc603fda40 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -432,6 +432,14 @@ struct pci_dev {
>  	 * mappings to make sure they cannot access arbitrary memory.
>  	 */
>  	unsigned int	untrusted:1;
> +	/*
> +	 * Devices are marked as external-facing using info from platform
> +	 * (ACPI / devicetree). An external-facing device is still an internal
> +	 * trusted device, but it faces external untrusted devices. Thus any
> +	 * devices enumerated downstream an external-facing device is marked
> +	 * as untrusted.

This comment has a subject/verb agreement problem.

> +	 */
> +	unsigned int	external_facing:1;
>  	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
>  	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
>  	unsigned int	irq_managed:1;
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
