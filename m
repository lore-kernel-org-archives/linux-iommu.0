Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA36C433E3
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 19:57:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B1620823
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 19:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLbu0zhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B1620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 089F28757A;
	Thu, 21 May 2020 19:57:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BeMn5j7VrZsu; Thu, 21 May 2020 19:57:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ED0FE8755A;
	Thu, 21 May 2020 19:57:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9206C088A;
	Thu, 21 May 2020 19:57:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30C7AC0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 19:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1E6E088522
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 19:57:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qwtwsnW34iJN for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 19:57:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7C8C287F52
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 19:57:17 +0000 (UTC)
Received: from localhost (mobile-166-175-190-200.mycingular.net
 [166.175.190.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E75DF20738;
 Thu, 21 May 2020 19:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590091037;
 bh=3GAvSfAMUddifLPCHvTDvFY432iF5D80Ue+hjq5ma/k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=gLbu0zhdPVgG7Aa7IJPzjZ012leZ59yB44+hm4Djnqe8e9igB7XrDDOqwRrCvIVps
 VGzPP6kAzLHPckkBWX0D0Xq9iZwTRZN5nDCIv9E4wOlxFcjK/Q0L66P9VnXc+BbvIF
 b1FuHaozN67QS9jwH61wycwEOTtGQA/LP4ZnnrZo=
Date: Thu, 21 May 2020 14:57:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 08/12] of/irq: make of_msi_map_get_device_domain() bus
 agnostic
Message-ID: <20200521195715.GA1171267@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200521130008.8266-9-lorenzo.pieralisi@arm.com>
Cc: devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <maz@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, linux-pci@vger.kernel.org,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, May 21, 2020 at 02:00:04PM +0100, Lorenzo Pieralisi wrote:
> From: Diana Craciun <diana.craciun@oss.nxp.com>
> 
> of_msi_map_get_device_domain() is PCI specific but it need not be and
> can be easily changed to be bus agnostic in order to be used by other
> busses by adding an IRQ domain bus token as an input parameter.
> 
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci/msi.c

> ---
>  drivers/of/irq.c       | 8 +++++---
>  drivers/pci/msi.c      | 2 +-
>  include/linux/of_irq.h | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index a296eaf52a5b..48a40326984f 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -613,18 +613,20 @@ u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
>   * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
>   * @dev: device for which the mapping is to be done.
>   * @rid: Requester ID for the device.
> + * @bus_token: Bus token
>   *
>   * Walk up the device hierarchy looking for devices with a "msi-map"
>   * property.
>   *
>   * Returns: the MSI domain for this device (or NULL on failure)
>   */
> -struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 rid)
> +struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
> +						u32 bus_token)
>  {
>  	struct device_node *np = NULL;
>  
> -	__of_msi_map_rid(dev, &np, rid);
> -	return irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
> +	__of_msi_map_rid(dev, &np, id);
> +	return irq_find_matching_host(np, bus_token);
>  }
>  
>  /**
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 74a91f52ecc0..9532e1d12d3f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1556,7 +1556,7 @@ struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
>  	u32 rid = pci_dev_id(pdev);
>  
>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
> -	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
> +	dom = of_msi_map_get_device_domain(&pdev->dev, rid, DOMAIN_BUS_PCI_MSI);
>  	if (!dom)
>  		dom = iort_get_device_domain(&pdev->dev, rid,
>  					     DOMAIN_BUS_PCI_MSI);
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index 1214cabb2247..7142a3722758 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -52,7 +52,8 @@ extern struct irq_domain *of_msi_get_domain(struct device *dev,
>  					    struct device_node *np,
>  					    enum irq_domain_bus_token token);
>  extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
> -						       u32 rid);
> +							u32 id,
> +							u32 bus_token);
>  extern void of_msi_configure(struct device *dev, struct device_node *np);
>  u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
>  #else
> @@ -85,7 +86,7 @@ static inline struct irq_domain *of_msi_get_domain(struct device *dev,
>  	return NULL;
>  }
>  static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
> -							      u32 rid)
> +						u32 id, u32 bus_token)
>  {
>  	return NULL;
>  }
> -- 
> 2.26.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
