Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD53C433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 07:38:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE435206CB
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 07:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE435206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BCD692076B;
	Tue, 30 Jun 2020 07:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fydcgJTLAyv0; Tue, 30 Jun 2020 07:38:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4192620115;
	Tue, 30 Jun 2020 07:38:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29C39C0865;
	Tue, 30 Jun 2020 07:38:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0171C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 07:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EBDEB87AD1
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 07:38:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5c5ddFeLasB0 for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 07:38:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 181C887AC5
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 07:38:36 +0000 (UTC)
IronPort-SDR: wSvdRYUapAftU8j5agy1ogx4Mkf0serng3WnSLd9J4I0/62aQRbMSK0MY3+vs0OLTnGoqXla2Y
 u5gGILGW12TA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="125802553"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="125802553"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 00:38:35 -0700
IronPort-SDR: 5Rzu2gh6P8gXyz5LRBr0iXOPG7YJJHK7jjxO44B5I8lrvuOGm6ESOwTF9wOo72MgNhMGd8l1AX
 iEjjH3hNJxNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="266410137"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.173.186])
 ([10.249.173.186])
 by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2020 00:38:28 -0700
Subject: Re: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external
 devices only
To: Rajat Jain <rajatja@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 Raj Ashok <ashok.raj@intel.com>, lalithambika.krishnakumar@intel.com,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Prashant Malani <pmalani@google.com>, Benson Leung <bleung@google.com>,
 Todd Broch <tbroch@google.com>, Alex Levin <levinale@google.com>,
 Mattias Nissler <mnissler@google.com>, Rajat Jain <rajatxjain@gmail.com>,
 Bernie Keany <bernie.keany@intel.com>, Aaron Durbin <adurbin@google.com>,
 Diego Rivas <diegorivas@google.com>, Duncan Laurie <dlaurie@google.com>,
 Furquan Shaikh <furquan@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Christian Kellner <christian@kellner.me>,
 Alex Williamson <alex.williamson@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, oohall@gmail.com,
 Saravana Kannan <saravanak@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-3-rajatja@google.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <606281b8-f71b-edb2-8e06-9f91a0cacf62@linux.intel.com>
Date: Tue, 30 Jun 2020 15:38:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630044943.3425049-3-rajatja@google.com>
Content-Language: en-US
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

On 2020/6/30 12:49, Rajat Jain wrote:
> The "ExternalFacing" devices (root ports) are still internal devices that
> sit on the internal system fabric and thus trusted. Currently they were
> being marked untrusted.
> 
> This patch uses the platform flag to identify the external facing devices
> and then use it to mark any downstream devices as "untrusted". The
> external-facing devices themselves are left as "trusted". This was
> discussed here: https://lkml.org/lkml/2020/6/10/1049
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

For changes in Intel VT-d driver,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> v2: cosmetic changes in commit log
> 
>   drivers/iommu/intel/iommu.c |  2 +-
>   drivers/pci/of.c            |  2 +-
>   drivers/pci/pci-acpi.c      | 13 +++++++------
>   drivers/pci/probe.c         |  2 +-
>   include/linux/pci.h         |  8 ++++++++
>   5 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d759e7234e982..1ccb224f82496 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4743,7 +4743,7 @@ static inline bool has_untrusted_dev(void)
>   	struct pci_dev *pdev = NULL;
>   
>   	for_each_pci_dev(pdev)
> -		if (pdev->untrusted)
> +		if (pdev->untrusted || pdev->external_facing)
>   			return true;
>   
>   	return false;
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 27839cd2459f6..22727fc9558df 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -42,7 +42,7 @@ void pci_set_bus_of_node(struct pci_bus *bus)
>   	} else {
>   		node = of_node_get(bus->self->dev.of_node);
>   		if (node && of_property_read_bool(node, "external-facing"))
> -			bus->self->untrusted = true;
> +			bus->self->external_facing = true;
>   	}
>   
>   	bus->dev.of_node = node;
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 7224b1e5f2a83..492c07805caf8 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1213,22 +1213,23 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>   	ACPI_FREE(obj);
>   }
>   
> -static void pci_acpi_set_untrusted(struct pci_dev *dev)
> +static void pci_acpi_set_external_facing(struct pci_dev *dev)
>   {
>   	u8 val;
>   
> -	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> +	    pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
>   		return;
>   	if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
>   		return;
>   
>   	/*
> -	 * These root ports expose PCIe (including DMA) outside of the
> -	 * system so make sure we treat them and everything behind as
> +	 * These root/down ports expose PCIe (including DMA) outside of the
> +	 * system so make sure we treat everything behind them as
>   	 * untrusted.
>   	 */
>   	if (val)
> -		dev->untrusted = 1;
> +		dev->external_facing = 1;
>   }
>   
>   static void pci_acpi_setup(struct device *dev)
> @@ -1240,7 +1241,7 @@ static void pci_acpi_setup(struct device *dev)
>   		return;
>   
>   	pci_acpi_optimize_delay(pci_dev, adev->handle);
> -	pci_acpi_set_untrusted(pci_dev);
> +	pci_acpi_set_external_facing(pci_dev);
>   	pci_acpi_add_edr_notifier(pci_dev);
>   
>   	pci_acpi_add_pm_notifier(adev, pci_dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6d87066a5ecc5..8c40c00413e74 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1552,7 +1552,7 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>   	 * untrusted as well.
>   	 */
>   	parent = pci_upstream_bridge(dev);
> -	if (parent && parent->untrusted)
> +	if (parent && (parent->untrusted || parent->external_facing))
>   		dev->untrusted = true;
>   }
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a26be5332bba6..fe1bc603fda40 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -432,6 +432,14 @@ struct pci_dev {
>   	 * mappings to make sure they cannot access arbitrary memory.
>   	 */
>   	unsigned int	untrusted:1;
> +	/*
> +	 * Devices are marked as external-facing using info from platform
> +	 * (ACPI / devicetree). An external-facing device is still an internal
> +	 * trusted device, but it faces external untrusted devices. Thus any
> +	 * devices enumerated downstream an external-facing device is marked
> +	 * as untrusted.
> +	 */
> +	unsigned int	external_facing:1;
>   	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
>   	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
>   	unsigned int	irq_managed:1;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
