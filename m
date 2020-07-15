Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0829C433E6
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 10:06:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4D9206D5
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 10:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4D9206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5B42C226C2;
	Wed, 15 Jul 2020 10:06:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BnMKLFaFmISi; Wed, 15 Jul 2020 10:06:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6AE3C2036C;
	Wed, 15 Jul 2020 10:06:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F4DEC07FF;
	Wed, 15 Jul 2020 10:06:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE520C0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9BEAD8AF63
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:06:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mHp4oejcAvtJ for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 10:06:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8F9578AE08
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:06:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB79730E;
 Wed, 15 Jul 2020 03:06:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA0563F718;
 Wed, 15 Jul 2020 03:06:41 -0700 (PDT)
Date: Wed, 15 Jul 2020 11:06:36 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Makarand Pawagi <makarand.pawagi@nxp.com>
Subject: Re: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
Message-ID: <20200715100636.GA31330@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-13-lorenzo.pieralisi@arm.com>
 <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
 <20200709091950.GA18149@e121166-lin.cambridge.arm.com>
 <DB7PR04MB4986D1A0BB7B685911DF4831EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <203372be-144c-54ba-d011-30d0746dd615@nxp.com>
 <DB7PR04MB4986C63772CB47A2A827D028EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <d41589da-c2f9-a750-f57a-25dccf51e69f@oss.nxp.com>
 <DB7PR04MB4986A56021750A3D104CA244EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DB7PR04MB4986A56021750A3D104CA244EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 "Diana Madalina Craciun \(OSS\)" <diana.craciun@oss.nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Thu, Jul 09, 2020 at 10:52:52AM +0000, Makarand Pawagi wrote:

[...]

> > >>>> fsl_mc_bus_probe(struct platform_device *pdev)
> > >>>>>>      struct fsl_mc_io *mc_io = NULL;
> > >>>>>>      int container_id;
> > >>>>>>      phys_addr_t mc_portal_phys_addr;
> > >>>>>> -   u32 mc_portal_size;
> > >>>>>> -   struct resource res;
> > >>>>>> +   u32 mc_portal_size, mc_stream_id;
> > >>>>>> +   struct resource *plat_res;
> > >>>>>> +
> > >>>>>> +   if (!iommu_present(&fsl_mc_bus_type))
> > >>>>>> +           return -EPROBE_DEFER;
> > >>>>>>
> > >>>>>>      mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
> > >>>>>>      if (!mc)
> > >>>>>> @@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct
> > >>>>>> platform_device *pdev)
> > >>>>>>
> > >>>>>>      platform_set_drvdata(pdev, mc);
> > >>>>>>
> > >>>>>> +   plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > >>>>>> +   mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
> > >>>>>> +   if (IS_ERR(mc->fsl_mc_regs))
> > >>>>>> +           return PTR_ERR(mc->fsl_mc_regs);
> > >>>>>> +
> > >>>>>> +   if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
> > >>>>>> +           mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
> > >>>>>> +           /*
> > >>>>>> +            * HW ORs the PL and BMT bit, places the result in bit 15 of
> > >>>>>> +            * the StreamID and ORs in the ICID. Calculate it accordingly.
> > >>>>>> +            */
> > >>>>>> +           mc_stream_id = (mc_stream_id & 0xffff) |
> > >>>>>> +                           ((mc_stream_id & (MC_FAPR_PL | MC_FAPR_BMT)) ?
> > >>>>>> +                                   0x4000 : 0);
> > >>>>>> +           error = acpi_dma_configure_id(&pdev->dev,
> > DEV_DMA_COHERENT,
> > >>>>>> +                                         &mc_stream_id);
> > >>>>>> +           if (error)
> > >>>>>> +                   dev_warn(&pdev->dev, "failed to configure dma: %d.\n",
> > >>>>>> +                            error);
> > >>>>>> +   }
> > >>>>>> +
> > >>>>>>      /*
> > >>>>>>       * Get physical address of MC portal for the root DPRC:
> > >>>>>>       */
> > >>>>>> -   error = of_address_to_resource(pdev->dev.of_node, 0, &res);
> > >>>>>> -   if (error < 0) {
> > >>>>>> -           dev_err(&pdev->dev,
> > >>>>>> -                   "of_address_to_resource() failed for %pOF\n",
> > >>>>>> -                   pdev->dev.of_node);
> > >>>>>> -           return error;
> > >>>>>> -   }
> > >>>>>> -
> > >>>>>> -   mc_portal_phys_addr = res.start;
> > >>>>>> -   mc_portal_size = resource_size(&res);
> > >>>>>> +   plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >>>>>> +   mc_portal_phys_addr = plat_res->start;
> > >>>>>> +   mc_portal_size = resource_size(plat_res);
> > >>>>>>      error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
> > >>>>>>                               mc_portal_size, NULL,
> > >>>>>>                               FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
> > >>>>>> &mc_io); @@ -903,11 +930,13 @@ static int fsl_mc_bus_probe(struct
> > >>>> platform_device *pdev)
> > >>>>>>      dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
> > >>>>>>               mc_version.major, mc_version.minor,
> > >>>>>> mc_version.revision);
> > >>>>>>
> > >>>>>> -   error = get_mc_addr_translation_ranges(&pdev->dev,
> > >>>>>> -                                          &mc->translation_ranges,
> > >>>>>> -                                          &mc->num_translation_ranges);
> > >>>>>> -   if (error < 0)
> > >>>>>> -           goto error_cleanup_mc_io;
> > >>>>>> +   if (dev_of_node(&pdev->dev)) {
> > >>>>>> +           error = get_mc_addr_translation_ranges(&pdev->dev,
> > >>>>>> +                                           &mc->translation_ranges,
> > >>>>>> +                                           &mc->num_translation_ranges);
> > >>>>>> +           if (error < 0)
> > >>>>>> +                   goto error_cleanup_mc_io;
> > >>>>>> +   }
> > >>>>>>
> > >>>>>>      error = dprc_get_container_id(mc_io, 0, &container_id);
> > >>>>>>      if (error < 0) {
> > >>>>>> @@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct
> > >>>>>> platform_device
> > >>>> *pdev)
> > >>>>>>              goto error_cleanup_mc_io;
> > >>>>>>
> > >>>>>>      mc->root_mc_bus_dev = mc_bus_dev;
> > >>>>>> +   mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
> > >>>>> Makarand, this looks a bit weird. Is there really a reason for it?
> > >>>> Can you clarify please so that we can reach a conclusion on this matter ?
> > >>>>
> > >>> Laurentiu, can you clarify what exactly is the doubt here? Are you
> > >>> asking about
> > >> fwnode assignment from pdev to mc_bus_dev?
> > >> Yes. I remember that a while ago I tested without this fwnode
> > >> assignment and didn't encounter any issues. Maybe we can just drop it?
> > > Did you tested with PHY changes? Because this is needed for MAC driver,
> > where it needs the mc bus node.
> > 
> > Maybe it worth a comment or maybe have it in a different patch?
> > 
> Since this change is needed for ACPI case and this is ACPI support
> case, I feel we should have this change in this patch only instead of
> separate patch. 

Anyway - you need to seek feedback from Marc on whether patches
11 and 12 are OK from an irqchip perspective, it is possible we
can take the rest of the series independently if everyone agrees
but I don't necessarily see a reason for that.

Long story short: you need Marc's ACK on [11-12], it is your code.

Thanks,
Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
