Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761BCC433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 09:20:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421EB206A1
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 09:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421EB206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EC3BE20352;
	Thu,  9 Jul 2020 09:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNWlMflBFwBT; Thu,  9 Jul 2020 09:20:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BC56520437;
	Thu,  9 Jul 2020 09:20:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8753CC077B;
	Thu,  9 Jul 2020 09:20:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCA56C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 09:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B01018854A
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 09:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PUFHNOQoOiDN for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 09:20:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9310388528
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 09:20:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1BBB31B;
 Thu,  9 Jul 2020 02:20:00 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BAB33F887;
 Thu,  9 Jul 2020 02:19:58 -0700 (PDT)
Date: Thu, 9 Jul 2020 10:19:50 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
Message-ID: <20200709091950.GA18149@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-13-lorenzo.pieralisi@arm.com>
 <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, iommu@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, Makarand Pawagi <makarand.pawagi@nxp.com>,
 Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
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

On Wed, Jul 01, 2020 at 07:55:28PM +0300, Laurentiu Tudor wrote:
> 
> 
> On 6/19/2020 11:20 AM, Lorenzo Pieralisi wrote:
> > From: Makarand Pawagi <makarand.pawagi@nxp.com>
> > 
> > Add ACPI support in the fsl-mc driver. Driver parses MC DSDT table to
> > extract memory and other resources.
> > 
> > Interrupt (GIC ITS) information is extracted from the MADT table
> > by drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.
> > 
> > IORT table is parsed to configure DMA.
> > 
> > Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
> > Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > ---
> >  drivers/bus/fsl-mc/fsl-mc-bus.c             | 73 ++++++++++++----
> >  drivers/bus/fsl-mc/fsl-mc-msi.c             | 37 +++++----
> >  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 92 ++++++++++++++++-----
> >  3 files changed, 150 insertions(+), 52 deletions(-)
> > 
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > index 824ff77bbe86..324d49d6df89 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > @@ -18,6 +18,8 @@
> >  #include <linux/bitops.h>
> >  #include <linux/msi.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/acpi.h>
> > +#include <linux/iommu.h>
> >  
> >  #include "fsl-mc-private.h"
> >  
> > @@ -38,6 +40,7 @@ struct fsl_mc {
> >  	struct fsl_mc_device *root_mc_bus_dev;
> >  	u8 num_translation_ranges;
> >  	struct fsl_mc_addr_translation_range *translation_ranges;
> > +	void *fsl_mc_regs;
> >  };
> >  
> >  /**
> > @@ -56,6 +59,10 @@ struct fsl_mc_addr_translation_range {
> >  	phys_addr_t start_phys_addr;
> >  };
> >  
> > +#define FSL_MC_FAPR	0x28
> > +#define MC_FAPR_PL	BIT(18)
> > +#define MC_FAPR_BMT	BIT(17)
> > +
> >  /**
> >   * fsl_mc_bus_match - device to driver matching callback
> >   * @dev: the fsl-mc device to match against
> > @@ -124,7 +131,10 @@ static int fsl_mc_dma_configure(struct device *dev)
> >  	while (dev_is_fsl_mc(dma_dev))
> >  		dma_dev = dma_dev->parent;
> >  
> > -	return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
> > +	if (dev_of_node(dma_dev))
> > +		return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
> > +
> > +	return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
> >  }
> >  
> >  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> > @@ -865,8 +875,11 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
> >  	struct fsl_mc_io *mc_io = NULL;
> >  	int container_id;
> >  	phys_addr_t mc_portal_phys_addr;
> > -	u32 mc_portal_size;
> > -	struct resource res;
> > +	u32 mc_portal_size, mc_stream_id;
> > +	struct resource *plat_res;
> > +
> > +	if (!iommu_present(&fsl_mc_bus_type))
> > +		return -EPROBE_DEFER;
> >  
> >  	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
> >  	if (!mc)
> > @@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, mc);
> >  
> > +	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +	mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
> > +	if (IS_ERR(mc->fsl_mc_regs))
> > +		return PTR_ERR(mc->fsl_mc_regs);
> > +
> > +	if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
> > +		mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
> > +		/*
> > +		 * HW ORs the PL and BMT bit, places the result in bit 15 of
> > +		 * the StreamID and ORs in the ICID. Calculate it accordingly.
> > +		 */
> > +		mc_stream_id = (mc_stream_id & 0xffff) |
> > +				((mc_stream_id & (MC_FAPR_PL | MC_FAPR_BMT)) ?
> > +					0x4000 : 0);
> > +		error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
> > +					      &mc_stream_id);
> > +		if (error)
> > +			dev_warn(&pdev->dev, "failed to configure dma: %d.\n",
> > +				 error);
> > +	}
> > +
> >  	/*
> >  	 * Get physical address of MC portal for the root DPRC:
> >  	 */
> > -	error = of_address_to_resource(pdev->dev.of_node, 0, &res);
> > -	if (error < 0) {
> > -		dev_err(&pdev->dev,
> > -			"of_address_to_resource() failed for %pOF\n",
> > -			pdev->dev.of_node);
> > -		return error;
> > -	}
> > -
> > -	mc_portal_phys_addr = res.start;
> > -	mc_portal_size = resource_size(&res);
> > +	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	mc_portal_phys_addr = plat_res->start;
> > +	mc_portal_size = resource_size(plat_res);
> >  	error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
> >  				 mc_portal_size, NULL,
> >  				 FSL_MC_IO_ATOMIC_CONTEXT_PORTAL, &mc_io);
> > @@ -903,11 +930,13 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
> >  	dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
> >  		 mc_version.major, mc_version.minor, mc_version.revision);
> >  
> > -	error = get_mc_addr_translation_ranges(&pdev->dev,
> > -					       &mc->translation_ranges,
> > -					       &mc->num_translation_ranges);
> > -	if (error < 0)
> > -		goto error_cleanup_mc_io;
> > +	if (dev_of_node(&pdev->dev)) {
> > +		error = get_mc_addr_translation_ranges(&pdev->dev,
> > +						&mc->translation_ranges,
> > +						&mc->num_translation_ranges);
> > +		if (error < 0)
> > +			goto error_cleanup_mc_io;
> > +	}
> >  
> >  	error = dprc_get_container_id(mc_io, 0, &container_id);
> >  	if (error < 0) {
> > @@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
> >  		goto error_cleanup_mc_io;
> >  
> >  	mc->root_mc_bus_dev = mc_bus_dev;
> > +	mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
> 
> Makarand, this looks a bit weird. Is there really a reason for it?

Can you clarify please so that we can reach a conclusion on this matter ?

Thanks,
Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
