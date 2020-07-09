Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36944C433DF
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 10:53:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB2C2076A
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 10:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a7JhwbHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB2C2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CEFB187EC8;
	Thu,  9 Jul 2020 10:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vFDYcFFy1BbZ; Thu,  9 Jul 2020 10:53:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A4AAF87EB1;
	Thu,  9 Jul 2020 10:53:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8ABB0C0865;
	Thu,  9 Jul 2020 10:53:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59D59C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 10:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C5A4685C62
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 10:52:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vwwr1nHfZI68 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 10:52:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0853085BFB
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 10:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkUhX5L3L2d4P0zQsceRXKPeQP+PGaPXAlvEx0faze4HpqgUrO1exSAzQyEawdh7HthJg/lClIsMMczPgsfRY0fieqCut6gqAc8OV2u553qg8pRLg2ZOm2ccMdquNmuVtvjiO36Bp2KfHJIHhN/olD67wIL55Hk68VRahJyxegZI7EDw+sGW0iTk4PcA56zbeHCFrxUCCymmTlUYZvdijSBV7+ABEGANzRhsdTjccjAsI/NIyFGaF1VVIaiVfbEPBiDWg8grvRF5uXIuNaA60mVGyL58wuoMWAykUz7yPpnCe5FnJVd/JKJM2KBrP9diCekD6oWnaRMgvSiiZesvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GQktOFMK5HsfyDYcUSSxhnfrnu5nXAKFUwSrpFp+0s=;
 b=Y8e1V8Vo0TKPNhfQYAtk+qVwndgBE+n3zA0TURWIBfZq67JIcvF/FFKGQUGVyWrWpo1Zvbf68CvLPbEuwdkHdaZy9c6ocivD1ACuwu0+7V2QYBrYvmWadTXU0arhRfB/hQMBFbzrfo7KgKCg5MUZVk/LtjjOLbELORlYyEBr9IFubRjMPwZIwwamz5dJngVcThLampwMfi4SX3W9AwYy9HkFVYMXci0orEFukjGSSBwowfjFXDMaVWilig2bspS7T+odfiDtPq1JKZb4quQU8n2WNc19jAQSOUU/cmNorSZWbFOW/xWRSukyEPiKDlHRGHLNvuSjt/jc46dbcZBmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GQktOFMK5HsfyDYcUSSxhnfrnu5nXAKFUwSrpFp+0s=;
 b=a7JhwbHY5WFO7DvrtKutc19C7TwqEljJGN45xysuWOWxhA6Lu1l2uVHWIj3f6ec1qOfzybHl1pg5+EkReaDSHSWu1oLaOeKkDuZnR3V8TZOWbg8zQ2tP/j0cuCmmt1p0btMNRk1x35/yOT5aWxtHweasVgu4yM9uGE+6RS9Xw10=
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com (2603:10a6:10:13::25)
 by DB8PR04MB6747.eurprd04.prod.outlook.com (2603:10a6:10:10b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 9 Jul
 2020 10:37:48 +0000
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e]) by DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e%6]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 10:37:47 +0000
From: Makarand Pawagi <makarand.pawagi@nxp.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: RE: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
Thread-Topic: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
Thread-Index: AQHWT8hvhkZ6PFIXKUip8fS0U4S+lKj/BKAAgAABSiCAAA4OgIAAA0vw
Date: Thu, 9 Jul 2020 10:37:47 +0000
Message-ID: <DB7PR04MB4986C63772CB47A2A827D028EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-13-lorenzo.pieralisi@arm.com>
 <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
 <20200709091950.GA18149@e121166-lin.cambridge.arm.com>
 <DB7PR04MB4986D1A0BB7B685911DF4831EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <203372be-144c-54ba-d011-30d0746dd615@nxp.com>
In-Reply-To: <203372be-144c-54ba-d011-30d0746dd615@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [122.169.149.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca73e0b6-540b-4bbb-16d9-08d823f41f64
x-ms-traffictypediagnostic: DB8PR04MB6747:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB674775C2981C7CF062F5FA83EB640@DB8PR04MB6747.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04599F3534
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cbjIKh+M0aQcgCQruH10XNLsMKRtT8zWccA53Cbs5mvJcBxVdjgmbFiqqpPaM/XwQKg+IPZ0d4+JlJHK6EFZrysaQR9uD3sg5/q5+izKeE7ZgcgRnKQKHIvvktQdJaZ7sbXkpM8SV3pTPR+iVP62CDLGCS4+XzxboBzVg3ROD0IkKEFUyLaPnnIyXO+4DUmpd9rluBOK3xeCVoF/LKVOIEV33LGjj9CwkTU82C9WgOVwL2BtmusyUC28zq/dJP+ZG5+6eHg+Lwr+XInObd1+434zZ3Sl1kF4I4HYkmPDvMd9ASSrfdV1a4SOzFn3ox0x28qccjd157c2wofxC/h+bA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4986.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(54906003)(8676002)(7696005)(33656002)(7416002)(71200400001)(5660300002)(52536014)(2906002)(8936002)(4326008)(186003)(66446008)(110136005)(86362001)(66556008)(26005)(76116006)(64756008)(55016002)(66476007)(66946007)(83380400001)(44832011)(53546011)(316002)(9686003)(478600001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: GmgvNeTRwJ/B2pjp7YcfyZrsBgXSx6rnfdSaydslQDz0acWBFzI7PCgFLgWjEQH5MVT0WjayJjTNg2PEFrmPaxirgk+18zozjGzO06aAWkWn3AyqKEx1BWK5XZ64FxUq4LtYH9jaAhCSoKHLyt1sR7p/za9vWO1NC06znHKeWoWI6MbsIPWI8MGahRnswnt/Ux4/r6VhJMJRPqYsxKKLzrRC1rbq3pbXCqZuXQZB4iRdfUYtxSx81kjpM83FNzO5OHzaX6IxRIFCpGFEfgaZRdLJn942eMT3tJld/e44g1Tumg3rK4hF0lOP2I9mi3rU7opqCTZk+me9f0sNqDPbTnLn66qgSROOxQNb4Ye8HKZA4wDPzWWVLgBnL4phRynE4pCH7c1rDR3QizIM1So90Qf652T4UXP7AYWcZ4dbyQo0xydO0ADQwen7oj2JWKj+u9aXiL5pNXZAx7XJL6XyK7ezfenMcI4Yatle/tyLgAFy7PPFwnqss9B5Xm1iXmAt
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4986.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca73e0b6-540b-4bbb-16d9-08d823f41f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 10:37:47.7231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZaMT8mkKJg+0uGap3HCcISiKWVzTPiH1KTVeqcbzFJN2PMJctyp5dYPN/dVd6/ahvSpvlo6bDFpObZCHZOZXDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6747
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



> -----Original Message-----
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Sent: Thursday, July 9, 2020 3:45 PM
> To: Makarand Pawagi <makarand.pawagi@nxp.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org; Diana Madalina Craciun (OSS)
> <diana.craciun@oss.nxp.com>; iommu@lists.linux-foundation.org; linux-
> acpi@vger.kernel.org; devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> Rob Herring <robh+dt@kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> Joerg Roedel <joro@8bytes.org>; Hanjun Guo <guohanjun@huawei.com>; Bjorn
> Helgaas <bhelgaas@google.com>; Sudeep Holla <sudeep.holla@arm.com>;
> Robin Murphy <robin.murphy@arm.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Marc Zyngier
> <maz@kernel.org>
> Subject: Re: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
> 
> 
> 
> On 7/9/2020 12:26 PM, Makarand Pawagi wrote:
> >
> >
> >> -----Original Message-----
> >> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> Sent: Thursday, July 9, 2020 2:50 PM
> >> To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >> Cc: linux-arm-kernel@lists.infradead.org; Makarand Pawagi
> >> <makarand.pawagi@nxp.com>; Diana Madalina Craciun (OSS)
> >> <diana.craciun@oss.nxp.com>; iommu@lists.linux-foundation.org; linux-
> >> acpi@vger.kernel.org; devicetree@vger.kernel.org;
> >> linux-pci@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; Rafael
> >> J. Wysocki <rjw@rjwysocki.net>; Joerg Roedel <joro@8bytes.org>;
> >> Hanjun Guo <guohanjun@huawei.com>; Bjorn Helgaas
> >> <bhelgaas@google.com>; Sudeep Holla <sudeep.holla@arm.com>; Robin
> >> Murphy <robin.murphy@arm.com>; Catalin Marinas
> >> <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Marc
> >> Zyngier <maz@kernel.org>
> >> Subject: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
> >> fsl-mc
> >>
> >> Caution: EXT Email
> >>
> >> On Wed, Jul 01, 2020 at 07:55:28PM +0300, Laurentiu Tudor wrote:
> >>>
> >>>
> >>> On 6/19/2020 11:20 AM, Lorenzo Pieralisi wrote:
> >>>> From: Makarand Pawagi <makarand.pawagi@nxp.com>
> >>>>
> >>>> Add ACPI support in the fsl-mc driver. Driver parses MC DSDT table
> >>>> to extract memory and other resources.
> >>>>
> >>>> Interrupt (GIC ITS) information is extracted from the MADT table by
> >>>> drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.
> >>>>
> >>>> IORT table is parsed to configure DMA.
> >>>>
> >>>> Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
> >>>> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> >>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>> ---
> >>>>  drivers/bus/fsl-mc/fsl-mc-bus.c             | 73 ++++++++++++----
> >>>>  drivers/bus/fsl-mc/fsl-mc-msi.c             | 37 +++++----
> >>>>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 92
> >>>> ++++++++++++++++-----
> >>>>  3 files changed, 150 insertions(+), 52 deletions(-)
> >>>>
> >>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>> b/drivers/bus/fsl-mc/fsl-mc-bus.c index 824ff77bbe86..324d49d6df89
> >>>> 100644
> >>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>> @@ -18,6 +18,8 @@
> >>>>  #include <linux/bitops.h>
> >>>>  #include <linux/msi.h>
> >>>>  #include <linux/dma-mapping.h>
> >>>> +#include <linux/acpi.h>
> >>>> +#include <linux/iommu.h>
> >>>>
> >>>>  #include "fsl-mc-private.h"
> >>>>
> >>>> @@ -38,6 +40,7 @@ struct fsl_mc {
> >>>>     struct fsl_mc_device *root_mc_bus_dev;
> >>>>     u8 num_translation_ranges;
> >>>>     struct fsl_mc_addr_translation_range *translation_ranges;
> >>>> +   void *fsl_mc_regs;
> >>>>  };
> >>>>
> >>>>  /**
> >>>> @@ -56,6 +59,10 @@ struct fsl_mc_addr_translation_range {
> >>>>     phys_addr_t start_phys_addr;
> >>>>  };
> >>>>
> >>>> +#define FSL_MC_FAPR        0x28
> >>>> +#define MC_FAPR_PL BIT(18)
> >>>> +#define MC_FAPR_BMT        BIT(17)
> >>>> +
> >>>>  /**
> >>>>   * fsl_mc_bus_match - device to driver matching callback
> >>>>   * @dev: the fsl-mc device to match against @@ -124,7 +131,10 @@
> >>>> static int fsl_mc_dma_configure(struct device *dev)
> >>>>     while (dev_is_fsl_mc(dma_dev))
> >>>>             dma_dev = dma_dev->parent;
> >>>>
> >>>> -   return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
> >>>> +   if (dev_of_node(dma_dev))
> >>>> +           return of_dma_configure_id(dev, dma_dev->of_node, 0,
> >>>> + &input_id);
> >>>> +
> >>>> +   return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
> >>>>  }
> >>>>
> >>>>  static ssize_t modalias_show(struct device *dev, struct
> >>>> device_attribute *attr, @@ -865,8 +875,11 @@ static int
> >> fsl_mc_bus_probe(struct platform_device *pdev)
> >>>>     struct fsl_mc_io *mc_io = NULL;
> >>>>     int container_id;
> >>>>     phys_addr_t mc_portal_phys_addr;
> >>>> -   u32 mc_portal_size;
> >>>> -   struct resource res;
> >>>> +   u32 mc_portal_size, mc_stream_id;
> >>>> +   struct resource *plat_res;
> >>>> +
> >>>> +   if (!iommu_present(&fsl_mc_bus_type))
> >>>> +           return -EPROBE_DEFER;
> >>>>
> >>>>     mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
> >>>>     if (!mc)
> >>>> @@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct
> >>>> platform_device *pdev)
> >>>>
> >>>>     platform_set_drvdata(pdev, mc);
> >>>>
> >>>> +   plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >>>> +   mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
> >>>> +   if (IS_ERR(mc->fsl_mc_regs))
> >>>> +           return PTR_ERR(mc->fsl_mc_regs);
> >>>> +
> >>>> +   if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
> >>>> +           mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
> >>>> +           /*
> >>>> +            * HW ORs the PL and BMT bit, places the result in bit 15 of
> >>>> +            * the StreamID and ORs in the ICID. Calculate it accordingly.
> >>>> +            */
> >>>> +           mc_stream_id = (mc_stream_id & 0xffff) |
> >>>> +                           ((mc_stream_id & (MC_FAPR_PL | MC_FAPR_BMT)) ?
> >>>> +                                   0x4000 : 0);
> >>>> +           error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
> >>>> +                                         &mc_stream_id);
> >>>> +           if (error)
> >>>> +                   dev_warn(&pdev->dev, "failed to configure dma: %d.\n",
> >>>> +                            error);
> >>>> +   }
> >>>> +
> >>>>     /*
> >>>>      * Get physical address of MC portal for the root DPRC:
> >>>>      */
> >>>> -   error = of_address_to_resource(pdev->dev.of_node, 0, &res);
> >>>> -   if (error < 0) {
> >>>> -           dev_err(&pdev->dev,
> >>>> -                   "of_address_to_resource() failed for %pOF\n",
> >>>> -                   pdev->dev.of_node);
> >>>> -           return error;
> >>>> -   }
> >>>> -
> >>>> -   mc_portal_phys_addr = res.start;
> >>>> -   mc_portal_size = resource_size(&res);
> >>>> +   plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>>> +   mc_portal_phys_addr = plat_res->start;
> >>>> +   mc_portal_size = resource_size(plat_res);
> >>>>     error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
> >>>>                              mc_portal_size, NULL,
> >>>>                              FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
> >>>> &mc_io); @@ -903,11 +930,13 @@ static int fsl_mc_bus_probe(struct
> >> platform_device *pdev)
> >>>>     dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
> >>>>              mc_version.major, mc_version.minor,
> >>>> mc_version.revision);
> >>>>
> >>>> -   error = get_mc_addr_translation_ranges(&pdev->dev,
> >>>> -                                          &mc->translation_ranges,
> >>>> -                                          &mc->num_translation_ranges);
> >>>> -   if (error < 0)
> >>>> -           goto error_cleanup_mc_io;
> >>>> +   if (dev_of_node(&pdev->dev)) {
> >>>> +           error = get_mc_addr_translation_ranges(&pdev->dev,
> >>>> +                                           &mc->translation_ranges,
> >>>> +                                           &mc->num_translation_ranges);
> >>>> +           if (error < 0)
> >>>> +                   goto error_cleanup_mc_io;
> >>>> +   }
> >>>>
> >>>>     error = dprc_get_container_id(mc_io, 0, &container_id);
> >>>>     if (error < 0) {
> >>>> @@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct
> >>>> platform_device
> >> *pdev)
> >>>>             goto error_cleanup_mc_io;
> >>>>
> >>>>     mc->root_mc_bus_dev = mc_bus_dev;
> >>>> +   mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
> >>>
> >>> Makarand, this looks a bit weird. Is there really a reason for it?
> >>
> >> Can you clarify please so that we can reach a conclusion on this matter ?
> >>
> > Laurentiu, can you clarify what exactly is the doubt here? Are you asking about
> fwnode assignment from pdev to mc_bus_dev?
> >
> 
> Yes. I remember that a while ago I tested without this fwnode assignment and
> didn't encounter any issues. Maybe we can just drop it?

Did you tested with PHY changes? Because this is needed for MAC driver, where it needs the mc bus node.

> 
> ---
> Best Regards, Laurentiu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
