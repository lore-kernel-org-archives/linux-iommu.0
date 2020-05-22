Return-Path: <SRS0=4l6Q=7E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC61C433E1
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 05:32:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D282073B
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 05:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxvTXm0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D282073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 25521203E8;
	Fri, 22 May 2020 05:32:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Dt6ScNu2v6f; Fri, 22 May 2020 05:32:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1300D203D0;
	Fri, 22 May 2020 05:32:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D59E7C088B;
	Fri, 22 May 2020 05:32:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75083C0176
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 05:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5A4AD88793
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 05:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eKgEZ7n6nVKU for <iommu@lists.linux-foundation.org>;
 Fri, 22 May 2020 05:32:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10074.outbound.protection.outlook.com [40.107.1.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8EDE988558
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 05:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvbeqknbPDlDDp5VfxM1IIHND1Hlk6i2W0Ag5BZ+VSy2QZiMM6PDR2cBNDjUmyvTYOFyjdMZCvMK2v/rjmDJs3E4MZxk/AgnhuxFBj5rS1g981LXe91i1jv4+sF7jTcSl4u6Kv82uEqKcA9NbT1+VigY06Q40ISt+2BoLAqOEX+tYbHnTRtiVVooksJ60vfi2oSjFbbtKGpm6/65GMxCM0qDX/So19B8k3x7A63t2VINnnZnFqkYgdwFmIf+o/kgyrUzMa4pVfdX2AOHxhQcTNOleXJ9Pq4dOaSQ/SjuEfBYH8B+oU0SDyzc3XnfHiVw2QRTF+wJgyDY5sORB6yTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR4f1IB/r+vImNDvxHdENzeDfXiXxzGuWKEyQt40AGg=;
 b=YV9mSDkzhlKZzJg0qzaKk1mYL+wd/DHZoKrPaPYS8psQ63Y4eVr4cKVUu45nxVcr7N4am8JXtQrpIzQJkH0PerG5o18+m07zX9CSaNS0mUPJWrqRzNdM2TT8DKWOKCsU8H04elamLlILVjpeUA9G4jJmV2m/mUZ5FPMQkWg99cbdAfcvXfRndCHws0ZfOpZ6c4L9r/+QexciD7znmM43EP9lOLLWfW2ENd5LD+IuUGMo6ZaMrPbr2+m/Xl1Z5c1apo8h8bhayeIIi9bmUEcxrbvEF8iLEvb1iSJAT85MGid42mRY1soeNCKdZ2IIBiiLN7/EEw1d0YXtBm6gQ4T2Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR4f1IB/r+vImNDvxHdENzeDfXiXxzGuWKEyQt40AGg=;
 b=kxvTXm0T8qxMHVxUbkSoPBdME5KY/Rqmk6ensgDgIIAgGlycaqPG7F2rI+xldG8+I3EjzAg6ERCitrF+pRnkW4MpLwZryPRAspqumv69T6a3eswOChzs3gxeTATeGi+H/jD5PvAaP/31DLcT3n5Wgo/8HzR5MsFAGSMx7WsXUV4=
Received: from AM6PR04MB4984.eurprd04.prod.outlook.com (2603:10a6:20b:7::23)
 by AM6PR04MB4550.eurprd04.prod.outlook.com (2603:10a6:20b:17::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 05:32:02 +0000
Received: from AM6PR04MB4984.eurprd04.prod.outlook.com
 ([fe80::5167:8ffa:569e:fa57]) by AM6PR04MB4984.eurprd04.prod.outlook.com
 ([fe80::5167:8ffa:569e:fa57%4]) with mapi id 15.20.3021.024; Fri, 22 May 2020
 05:32:02 +0000
From: Makarand Pawagi <makarand.pawagi@nxp.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
Thread-Topic: [PATCH 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
Thread-Index: AQHWL4EA+tWCI6MmokOtaoHDA2UgG6izlSoA
Date: Fri, 22 May 2020 05:32:02 +0000
Message-ID: <AM6PR04MB49847931D51AD92057043D92EBB40@AM6PR04MB4984.eurprd04.prod.outlook.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-13-lorenzo.pieralisi@arm.com>
 <3045acd5-0bcf-40c1-e65f-0b740200b2e0@nxp.com>
In-Reply-To: <3045acd5-0bcf-40c1-e65f-0b740200b2e0@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [117.98.155.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87e9bf14-772d-4c6f-f75b-08d7fe1174cd
x-ms-traffictypediagnostic: AM6PR04MB4550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4550DE4D9940E8B098F6F4B8EBB40@AM6PR04MB4550.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:232;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3Ena4z7HkAbJv6kiwiLfFFO3w6lCXB3N9xPEGc3wxLs27f2xIe6YC4nXoNFIWxMZLgItpnSfnR4qVnYTjc5vv2pdbmBmuuBlSnPMwdcWKu/D42NVSBqwgcbx62yWw2qJG+9uxq5AiGlFONJNx5ZFVE8kTh4QMkL5Laz21+93HrmEmJZvMfr0Y4orRyzmseyHw8SQfaaNW+bgQbQoU9rIZByEsukqqHZcP296i2L4gXxxeoreZpsVEUAgwW08tb2yU13MGymBYMhS5kJEvY9MGZLiLz/zuK3sgA3Hj9A0/xTpnkASV49BsPCXNZIGLCLzQTv4Hr1gACxTfPwb4UvyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB4984.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(186003)(26005)(53546011)(7696005)(316002)(4326008)(8676002)(8936002)(478600001)(33656002)(9686003)(110136005)(55016002)(86362001)(54906003)(5660300002)(71200400001)(66946007)(7416002)(44832011)(6506007)(66556008)(2906002)(64756008)(30864003)(76116006)(66446008)(66476007)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vvbljHZumA7yjXZKrXxWFnll/qBE2tXt7iYzeKkOmrpdVCDeAJYHHF0ts8Da3WZpGMCQKgs5ttOCfaZpXn4GMdU74WwNmr05thDyUCEjWGJJQQcF1M6slzyyKDY9JCfC6wtvg5CWi1cdyC9wnpK7XXeoVVEhME5SQLTSykFaZPq/xKcWhLAAHqTxWVYJkLHO/xF7hpwFtHUDn21EiHTZJ148kshnNxzyA/V3BUTphHyYO/V3kYsoiCB2te0nFvjZbJENVa7ZvjYKsgHwOo/e7Sew480pfuJ+5rAG+oE6lOw1u8doRo+/6CBLRYQRj8FYVpni2fF6U5ejyfLiJ5Pig2pFCQPesnlkQnFBafYBQhDBg8IKaFgkefcm5do85P5MOeF2WbQRZ46kzEB/yQoGx16rXaEIbXDpF4nvbCA3eDkTqtl4rluuW+7RXy+mjZv9uQ1jb9ObiNqxNY55YoaxeXp7+HDEGD7+cjlJZBsL+lw=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e9bf14-772d-4c6f-f75b-08d7fe1174cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 05:32:02.2579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QkkfRMSCi+clMnaPgtsg8cf0vpgF02P+zgW9zNvh0giSmLXovQ4ELmP8UFT9Ssp44K7kELWCKrXKSqC+OYxgxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4550
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 "Diana Madalina Craciun \(OSS\)" <diana.craciun@oss.nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
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

Hi Lorenzo,

> -----Original Message-----
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Sent: Thursday, May 21, 2020 8:33 PM
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; linux-arm-
> kernel@lists.infradead.org
> Cc: Diana Madalina Craciun (OSS) <diana.craciun@oss.nxp.com>; Makarand
> Pawagi <makarand.pawagi@nxp.com>; iommu@lists.linux-foundation.org;
> linux-acpi@vger.kernel.org; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; Joerg Roedel <joro@8bytes.org>; Hanjun Guo
> <guohanjun@huawei.com>; Bjorn Helgaas <bhelgaas@google.com>; Sudeep
> Holla <sudeep.holla@arm.com>; Robin Murphy <robin.murphy@arm.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>;
> Marc Zyngier <maz@kernel.org>
> Subject: Re: [PATCH 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
> 
> Hi Lorenzo,
> 
> On 5/21/2020 4:00 PM, Lorenzo Pieralisi wrote:
> > From: Diana Craciun <diana.craciun@oss.nxp.com>
> >
> > Add ACPI support in the fsl-mc driver. Driver parses MC DSDT table to
> > extract memory and other resources.
> >
> > Interrupt (GIC ITS) information is extracted from the MADT table by
> > drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.
> >
> > IORT table is parsed to configure DMA.
> >
> > Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
> > Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > ---
> 
> The author of this patch should be Makarand. I think I accidentaly broke it when
> we exchanged the patches. Very sorry about it.
> 
 
Will you be able to correct this or should I post another patch?

> ---
> Best Regards, Laurentiu
> 
> 
> >  drivers/bus/fsl-mc/fsl-mc-bus.c             | 73 +++++++++++++++-----
> >  drivers/bus/fsl-mc/fsl-mc-msi.c             | 37 +++++-----
> >  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 75
> > ++++++++++++++++++++-
> >  3 files changed, 150 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > b/drivers/bus/fsl-mc/fsl-mc-bus.c index 824ff77bbe86..324d49d6df89
> > 100644
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
> >   * @dev: the fsl-mc device to match against @@ -124,7 +131,10 @@
> > static int fsl_mc_dma_configure(struct device *dev)
> >  	while (dev_is_fsl_mc(dma_dev))
> >  		dma_dev = dma_dev->parent;
> >
> > -	return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
> > +	if (dev_of_node(dma_dev))
> > +		return of_dma_configure_id(dev, dma_dev->of_node, 0,
> &input_id);
> > +
> > +	return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
> >  }
> >
> >  static ssize_t modalias_show(struct device *dev, struct
> > device_attribute *attr, @@ -865,8 +875,11 @@ static int
> fsl_mc_bus_probe(struct platform_device *pdev)
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
> > @@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct
> > platform_device *pdev)
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
> > +				((mc_stream_id & (MC_FAPR_PL |
> MC_FAPR_BMT)) ?
> > +					0x4000 : 0);
> > +		error = acpi_dma_configure_id(&pdev->dev,
> DEV_DMA_COHERENT,
> > +					      &mc_stream_id);
> > +		if (error)
> > +			dev_warn(&pdev->dev, "failed to configure
> dma: %d.\n",
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
> >  				 FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
> &mc_io); @@ -903,11 +930,13 @@
> > static int fsl_mc_bus_probe(struct platform_device *pdev)
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
> > +						&mc-
> >num_translation_ranges);
> > +		if (error < 0)
> > +			goto error_cleanup_mc_io;
> > +	}
> >
> >  	error = dprc_get_container_id(mc_io, 0, &container_id);
> >  	if (error < 0) {
> > @@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct platform_device
> *pdev)
> >  		goto error_cleanup_mc_io;
> >
> >  	mc->root_mc_bus_dev = mc_bus_dev;
> > +	mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
> >  	return 0;
> >
> >  error_cleanup_mc_io:
> > @@ -967,11 +997,18 @@ static const struct of_device_id
> > fsl_mc_bus_match_table[] = {
> >
> >  MODULE_DEVICE_TABLE(of, fsl_mc_bus_match_table);
> >
> > +static const struct acpi_device_id fsl_mc_bus_acpi_match_table[] = {
> > +	{"NXP0008", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, fsl_mc_bus_acpi_match_table);
> > +
> >  static struct platform_driver fsl_mc_bus_driver = {
> >  	.driver = {
> >  		   .name = "fsl_mc_bus",
> >  		   .pm = NULL,
> >  		   .of_match_table = fsl_mc_bus_match_table,
> > +		   .acpi_match_table = fsl_mc_bus_acpi_match_table,
> >  		   },
> >  	.probe = fsl_mc_bus_probe,
> >  	.remove = fsl_mc_bus_remove,
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c
> > b/drivers/bus/fsl-mc/fsl-mc-msi.c index e7bbff445a83..8edadf05cbb7
> > 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-msi.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/msi.h>
> > +#include <linux/acpi_iort.h>
> >
> >  #include "fsl-mc-private.h"
> >
> > @@ -179,25 +180,31 @@ struct irq_domain
> > *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
> >
> >  struct irq_domain *fsl_mc_find_msi_domain(struct device *dev)  {
> > -	struct irq_domain *msi_domain = NULL;
> > +	struct device *root_dprc_dev;
> > +	struct device *bus_dev;
> > +	struct irq_domain *msi_domain;
> >  	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> >
> > -	msi_domain = of_msi_map_get_device_domain(dev, mc_dev->icid,
> > +	fsl_mc_get_root_dprc(dev, &root_dprc_dev);
> > +	bus_dev = root_dprc_dev->parent;
> > +
> > +	if (bus_dev->of_node) {
> > +		msi_domain = of_msi_map_get_device_domain(dev,
> > +						  mc_dev->icid,
> >  						  DOMAIN_BUS_FSL_MC_MSI);
> >
> > -	/*
> > -	 * if the msi-map property is missing assume that all the
> > -	 * child containers inherit the domain from the parent
> > -	 */
> > -	if (!msi_domain) {
> > -		struct device *root_dprc_dev;
> > -		struct device *bus_dev;
> > -
> > -		fsl_mc_get_root_dprc(dev, &root_dprc_dev);
> > -		bus_dev = root_dprc_dev->parent;
> > -		msi_domain = of_msi_get_domain(bus_dev,
> > -					       bus_dev->of_node,
> > -					       DOMAIN_BUS_FSL_MC_MSI);
> > +		/*
> > +		 * if the msi-map property is missing assume that all the
> > +		 * child containers inherit the domain from the parent
> > +		 */
> > +		if (!msi_domain)
> > +
> > +			msi_domain = of_msi_get_domain(bus_dev,
> > +						bus_dev->of_node,
> > +						DOMAIN_BUS_FSL_MC_MSI);
> > +	} else {
> > +		msi_domain = iort_get_device_domain(dev, mc_dev->icid,
> > +
> DOMAIN_BUS_FSL_MC_MSI);
> >  	}
> >
> >  	return msi_domain;
> > diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
> > b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
> > index a5c8d577e424..b8b948fb6b2d 100644
> > --- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
> > +++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
> > @@ -7,6 +7,8 @@
> >   *
> >   */
> >
> > +#include <linux/acpi.h>
> > +#include <linux/acpi_iort.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_address.h>
> >  #include <linux/irq.h>
> > @@ -30,7 +32,8 @@ static u32 fsl_mc_msi_domain_get_msi_id(struct
> irq_domain *domain,
> >  	u32 out_id;
> >
> >  	of_node = irq_domain_get_of_node(domain);
> > -	out_id = of_msi_map_id(&mc_dev->dev, of_node, mc_dev->icid);
> > +	out_id = of_node ? of_msi_map_id(&mc_dev->dev, of_node, mc_dev-
> >icid) :
> > +			iort_msi_map_id(&mc_dev->dev, mc_dev->icid);
> >
> >  	return out_id;
> >  }
> > @@ -79,7 +82,67 @@ static const struct of_device_id its_device_id[] = {
> >  	{},
> >  };
> >
> > -static int __init its_fsl_mc_msi_init(void)
> > +static int __init its_fsl_mc_msi_init_one(struct fwnode_handle *handle,
> > +					  const char *name)
> > +{
> > +	struct irq_domain *parent;
> > +	struct irq_domain *mc_msi_domain;
> > +
> > +	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
> > +	if (!parent || !msi_get_domain_info(parent)) {
> > +		pr_err("%s: Unable to locate ITS domain\n", name);
> > +		return -ENXIO;
> > +	}
> > +
> > +	mc_msi_domain = fsl_mc_msi_create_irq_domain(handle,
> > +						&its_fsl_mc_msi_domain_info,
> > +						parent);
> > +	if (!mc_msi_domain)
> > +		pr_err("ACPIF: unable to create fsl-mc domain\n");
> > +
> > +	pr_info("fsl-mc MSI: domain created\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init
> > +its_fsl_mc_msi_parse_madt(union acpi_subtable_headers *header,
> > +			  const unsigned long end)
> > +{
> > +	struct acpi_madt_generic_translator *its_entry;
> > +	struct fwnode_handle *dom_handle;
> > +	const char *node_name;
> > +	int err = -ENXIO;
> > +
> > +	its_entry = (struct acpi_madt_generic_translator *)header;
> > +	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
> > +			      (long)its_entry->base_address);
> > +
> > +	dom_handle = iort_find_domain_token(its_entry->translation_id);
> > +	if (!dom_handle) {
> > +		pr_err("%s: Unable to locate ITS domain handle\n",
> node_name);
> > +		goto out;
> > +	}
> > +
> > +	err = its_fsl_mc_msi_init_one(dom_handle, node_name);
> > +	if (!err)
> > +		pr_info("fsl-mc MSI: %s domain created\n", node_name);
> > +
> > +out:
> > +	kfree(node_name);
> > +	return err;
> > +}
> > +
> > +
> > +static int __init its_fsl_mc_acpi_msi_init(void) {
> > +	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
> > +			      its_fsl_mc_msi_parse_madt, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init its_fsl_mc_of_msi_init(void)
> >  {
> >  	struct device_node *np;
> >  	struct irq_domain *parent;
> > @@ -113,4 +176,12 @@ static int __init its_fsl_mc_msi_init(void)
> >  	return 0;
> >  }
> >
> > +static int __init its_fsl_mc_msi_init(void) {
> > +	its_fsl_mc_of_msi_init();
> > +	its_fsl_mc_acpi_msi_init();
> > +
> > +	return 0;
> > +}
> > +
> >  early_initcall(its_fsl_mc_msi_init);
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
