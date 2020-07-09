Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F38C433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 10:53:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35F32074B
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 10:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oGwvAIX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35F32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 67D3D86CC1;
	Thu,  9 Jul 2020 10:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PycQHEmNeVvX; Thu,  9 Jul 2020 10:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A9C786B81;
	Thu,  9 Jul 2020 10:53:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50051C0865;
	Thu,  9 Jul 2020 10:53:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68773C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 10:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E029426B67
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 10:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 52x1GesF2Ehk for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 10:52:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
 by silver.osuosl.org (Postfix) with ESMTPS id 82E2E24C8F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 10:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdWMXcLNLJkIzfw7jnQyCQ353vVIhPMYnZKW60x7Y6Lt4nWTAT2pyJpcjhJ6FgCkI/DTQKnEdtrPHgQyZTSGE+jh6f/Opli2XjQQHPOTgnanC/FjqIiX3T4Vrgqio0TcPnkspDCkWBuYRlZXYo9aW3Ag/DSoXqHrRplTeDuit2/3Uh+ip6ydTunmpmZPPHoF5daNx11n36V7gw8pfexu8FBaXMYSm14cshF6IpgSmBJg6y6mv9s8lzDBcRJPSokvQ0n1D9niPrFXV/Mf9xMGm43LB+bF0A8Wy/eTlxNP1cvXH91WFNXSNw7b2HElcPBCvIpLGRl4EqNtjyuMbZGmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIgy7086ox+6s26JWyNE+f2XnVwYty1frlH/0fXM6TE=;
 b=mQb7q5VRwpEkGv9aBI4zuPzRHMqmNOk9+Ti/6HP+d+vvd6Ux3n7XgKQURvGvP3rp/b6vdX8QgCifz+mIIIZdDGJ1upbOTHWRQaLuc8q3O6kmhaIA3WRgMQGio0nV6Qf7cpfHjq+VfDQjK4f3iRKheHvRDF/lFZK6vz9dI0xcxZDPcjO1wXWEMebqeSJZ9aN7UwTpgXq81XIFFZNcxsv65L4K8TUun7zSwt/Jz1HweOHAxpxhQWVcplyVpmNUEmMrEMe5tmW94bRi2J5J0nne4IigIBLanZuxK108E3pGJ05fRfw208sux0GqKzHbvutQclgw17INZLePTFFVeliq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIgy7086ox+6s26JWyNE+f2XnVwYty1frlH/0fXM6TE=;
 b=oGwvAIX9D1SUVsY0mZ6cE/0MDqFOuPi/A8xo/GPA6TU5v+Jgh2it6+MVD9S1Dx01ftSvI7rdHlb4QCtoZn6Azc9Gatp3V3Pyz6at288Dydd7fbMpXI0N3as2YbXPLlGkmmx5kRkrYDWs6qNLQTXJOao2JkRN1XsJlaCL6Fdm8p4=
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com (2603:10a6:10:13::25)
 by DB6PR0402MB2790.eurprd04.prod.outlook.com (2603:10a6:4:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Thu, 9 Jul
 2020 10:52:52 +0000
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e]) by DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e%6]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 10:52:52 +0000
From: Makarand Pawagi <makarand.pawagi@nxp.com>
To: "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>, Laurentiu
 Tudor <laurentiu.tudor@nxp.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: RE: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
Thread-Topic: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
Thread-Index: AQHWT8hvhkZ6PFIXKUip8fS0U4S+lKj/BKAAgAABSiCAAA4OgIAAA0vwgAAFwICAAAET0A==
Date: Thu, 9 Jul 2020 10:52:52 +0000
Message-ID: <DB7PR04MB4986A56021750A3D104CA244EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-13-lorenzo.pieralisi@arm.com>
 <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
 <20200709091950.GA18149@e121166-lin.cambridge.arm.com>
 <DB7PR04MB4986D1A0BB7B685911DF4831EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <203372be-144c-54ba-d011-30d0746dd615@nxp.com>
 <DB7PR04MB4986C63772CB47A2A827D028EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <d41589da-c2f9-a750-f57a-25dccf51e69f@oss.nxp.com>
In-Reply-To: <d41589da-c2f9-a750-f57a-25dccf51e69f@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [122.169.149.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5039c4d7-5ecf-427e-9083-08d823f63a83
x-ms-traffictypediagnostic: DB6PR0402MB2790:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2790B33AFCCE64178020958CEB640@DB6PR0402MB2790.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04599F3534
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IyHXArdvrR1GsXoc4MIub3olZwof6NvQdxmHhYpwhWg/EDmEr4FU4P1AehOX4oknn2CXPczR4FxiAT+nxzXcvozQ/Of5b6sNuKOSSQXhXik4y5OHHy1zllaNcvZUw8UkJe9XBm6vcGS1Or7xnv520E8wNR1eb2Smp5fTtEJr53aHUQkCSqa4NK34tt5uKAUpgsMVt71RC6W/XyEsOIw0MurvlBxgecuD7aGoEbHsrWaWRZinqKhnkwVDA87kuU9lAQ+YVx/PB9D3+v1/MiY8o2tQz6Inis/OaB/NA6UIzMXrHib3NhTKxkjiWnSX/8AWSzo7+CJtOe7BrKyl07uSvQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4986.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(8936002)(66476007)(66446008)(64756008)(316002)(110136005)(55016002)(71200400001)(9686003)(54906003)(76116006)(4326008)(5660300002)(8676002)(66556008)(66946007)(52536014)(44832011)(478600001)(83380400001)(7416002)(33656002)(26005)(86362001)(2906002)(186003)(53546011)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 17ZOLKepBkcKckfSfVdP3HuVHovHR4uGcX2oBxrvXl214W7jUgNYTCbj3Y7hzTnC3Of3IQ1v09q6MUPG44eMZWfD5+p6EkSwV4u5MKckKYkKo+3ABbzUpYiNfuFPsa5uvwPPoBHfe7cCLvVclhXOwQVvPyzQ1lBiptah6wd9HO0l9IHeSMA7IzUvR2R3zHtMZ+vmwdq6FPLeRfTA6i6ViF+kMhNQhWrV10f+/4UpPP0OzwkPTkpvXFunLZALpXQhZDq7cNJh4H7cpQAqAwyD40M/X0GBvlHeaWKzoI6ic9zGYpuzdFNuab3hAjDAJ9HtYIz20q5O148FdXMeQ9Og9ktPFt6MrJVXjB+BYoa2+bmA0ok4enr20r+2dgdUnUfr0pK2tpiDoWscbYuktE9s6bgNjJFvv2O85ez2K7yT1fuQaHFYUkA3oX2dn0eVRojiS2fj+W07zcINuTLi6Ri97ZJAl6o2rLD2FhJszp6fU81ur7+alE4Dx/70a58M3bWb
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4986.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5039c4d7-5ecf-427e-9083-08d823f63a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 10:52:52.2903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yx1ksOYHMY5QnM7m+RhrYKrJ/jmkhFu+l2owNyteth0I7vSbosGPBs1GMLZe+BBD+X+UVX3JvCIgCqvBpviYPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2790
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>,
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
> From: Diana Madalina Craciun (OSS) <diana.craciun@oss.nxp.com>
> Sent: Thursday, July 9, 2020 4:17 PM
> To: Makarand Pawagi <makarand.pawagi@nxp.com>; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org;
> linux-acpi@vger.kernel.org; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; Joerg Roedel <joro@8bytes.org>; Hanjun Guo
> <guohanjun@huawei.com>; Bjorn Helgaas <bhelgaas@google.com>; Sudeep
> Holla <sudeep.holla@arm.com>; Robin Murphy <robin.murphy@arm.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>;
> Marc Zyngier <maz@kernel.org>
> Subject: Re: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
> 
> On 7/9/2020 1:37 PM, Makarand Pawagi wrote:
> >
> >> -----Original Message-----
> >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >> Sent: Thursday, July 9, 2020 3:45 PM
> >> To: Makarand Pawagi <makarand.pawagi@nxp.com>; Lorenzo Pieralisi
> >> <lorenzo.pieralisi@arm.com>
> >> Cc: linux-arm-kernel@lists.infradead.org; Diana Madalina Craciun
> >> (OSS) <diana.craciun@oss.nxp.com>; iommu@lists.linux-foundation.org;
> >> linux- acpi@vger.kernel.org; devicetree@vger.kernel.org;
> >> linux-pci@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; Rafael
> >> J. Wysocki <rjw@rjwysocki.net>; Joerg Roedel <joro@8bytes.org>;
> >> Hanjun Guo <guohanjun@huawei.com>; Bjorn Helgaas
> >> <bhelgaas@google.com>; Sudeep Holla <sudeep.holla@arm.com>; Robin
> >> Murphy <robin.murphy@arm.com>; Catalin Marinas
> >> <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Marc
> >> Zyngier <maz@kernel.org>
> >> Subject: Re: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support
> >> for fsl-mc
> >>
> >>
> >>
> >> On 7/9/2020 12:26 PM, Makarand Pawagi wrote:
> >>>
> >>>> -----Original Message-----
> >>>> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>>> Sent: Thursday, July 9, 2020 2:50 PM
> >>>> To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>> Cc: linux-arm-kernel@lists.infradead.org; Makarand Pawagi
> >>>> <makarand.pawagi@nxp.com>; Diana Madalina Craciun (OSS)
> >>>> <diana.craciun@oss.nxp.com>; iommu@lists.linux-foundation.org;
> >>>> linux- acpi@vger.kernel.org; devicetree@vger.kernel.org;
> >>>> linux-pci@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; Rafael
> >>>> J. Wysocki <rjw@rjwysocki.net>; Joerg Roedel <joro@8bytes.org>;
> >>>> Hanjun Guo <guohanjun@huawei.com>; Bjorn Helgaas
> >>>> <bhelgaas@google.com>; Sudeep Holla <sudeep.holla@arm.com>; Robin
> >>>> Murphy <robin.murphy@arm.com>; Catalin Marinas
> >>>> <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Marc
> >>>> Zyngier <maz@kernel.org>
> >>>> Subject: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support
> >>>> for fsl-mc
> >>>>
> >>>> Caution: EXT Email
> >>>>
> >>>> On Wed, Jul 01, 2020 at 07:55:28PM +0300, Laurentiu Tudor wrote:
> >>>>>
> >>>>> On 6/19/2020 11:20 AM, Lorenzo Pieralisi wrote:
> >>>>>> From: Makarand Pawagi <makarand.pawagi@nxp.com>
> >>>>>>
> >>>>>> Add ACPI support in the fsl-mc driver. Driver parses MC DSDT
> >>>>>> table to extract memory and other resources.
> >>>>>>
> >>>>>> Interrupt (GIC ITS) information is extracted from the MADT table
> >>>>>> by drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.
> >>>>>>
> >>>>>> IORT table is parsed to configure DMA.
> >>>>>>
> >>>>>> Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
> >>>>>> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> >>>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>>>> ---
> >>>>>>   drivers/bus/fsl-mc/fsl-mc-bus.c             | 73 ++++++++++++----
> >>>>>>   drivers/bus/fsl-mc/fsl-mc-msi.c             | 37 +++++----
> >>>>>>   drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 92
> >>>>>> ++++++++++++++++-----
> >>>>>>   3 files changed, 150 insertions(+), 52 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>>>> b/drivers/bus/fsl-mc/fsl-mc-bus.c index
> >>>>>> 824ff77bbe86..324d49d6df89
> >>>>>> 100644
> >>>>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>>>> @@ -18,6 +18,8 @@
> >>>>>>   #include <linux/bitops.h>
> >>>>>>   #include <linux/msi.h>
> >>>>>>   #include <linux/dma-mapping.h>
> >>>>>> +#include <linux/acpi.h>
> >>>>>> +#include <linux/iommu.h>
> >>>>>>
> >>>>>>   #include "fsl-mc-private.h"
> >>>>>>
> >>>>>> @@ -38,6 +40,7 @@ struct fsl_mc {
> >>>>>>      struct fsl_mc_device *root_mc_bus_dev;
> >>>>>>      u8 num_translation_ranges;
> >>>>>>      struct fsl_mc_addr_translation_range *translation_ranges;
> >>>>>> +   void *fsl_mc_regs;
> >>>>>>   };
> >>>>>>
> >>>>>>   /**
> >>>>>> @@ -56,6 +59,10 @@ struct fsl_mc_addr_translation_range {
> >>>>>>      phys_addr_t start_phys_addr;
> >>>>>>   };
> >>>>>>
> >>>>>> +#define FSL_MC_FAPR        0x28
> >>>>>> +#define MC_FAPR_PL BIT(18)
> >>>>>> +#define MC_FAPR_BMT        BIT(17)
> >>>>>> +
> >>>>>>   /**
> >>>>>>    * fsl_mc_bus_match - device to driver matching callback
> >>>>>>    * @dev: the fsl-mc device to match against @@ -124,7 +131,10
> >>>>>> @@ static int fsl_mc_dma_configure(struct device *dev)
> >>>>>>      while (dev_is_fsl_mc(dma_dev))
> >>>>>>              dma_dev = dma_dev->parent;
> >>>>>>
> >>>>>> -   return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
> >>>>>> +   if (dev_of_node(dma_dev))
> >>>>>> +           return of_dma_configure_id(dev, dma_dev->of_node, 0,
> >>>>>> + &input_id);
> >>>>>> +
> >>>>>> +   return acpi_dma_configure_id(dev, DEV_DMA_COHERENT,
> >>>>>> + &input_id);
> >>>>>>   }
> >>>>>>
> >>>>>>   static ssize_t modalias_show(struct device *dev, struct
> >>>>>> device_attribute *attr, @@ -865,8 +875,11 @@ static int
> >>>> fsl_mc_bus_probe(struct platform_device *pdev)
> >>>>>>      struct fsl_mc_io *mc_io = NULL;
> >>>>>>      int container_id;
> >>>>>>      phys_addr_t mc_portal_phys_addr;
> >>>>>> -   u32 mc_portal_size;
> >>>>>> -   struct resource res;
> >>>>>> +   u32 mc_portal_size, mc_stream_id;
> >>>>>> +   struct resource *plat_res;
> >>>>>> +
> >>>>>> +   if (!iommu_present(&fsl_mc_bus_type))
> >>>>>> +           return -EPROBE_DEFER;
> >>>>>>
> >>>>>>      mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
> >>>>>>      if (!mc)
> >>>>>> @@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct
> >>>>>> platform_device *pdev)
> >>>>>>
> >>>>>>      platform_set_drvdata(pdev, mc);
> >>>>>>
> >>>>>> +   plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >>>>>> +   mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
> >>>>>> +   if (IS_ERR(mc->fsl_mc_regs))
> >>>>>> +           return PTR_ERR(mc->fsl_mc_regs);
> >>>>>> +
> >>>>>> +   if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
> >>>>>> +           mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
> >>>>>> +           /*
> >>>>>> +            * HW ORs the PL and BMT bit, places the result in bit 15 of
> >>>>>> +            * the StreamID and ORs in the ICID. Calculate it accordingly.
> >>>>>> +            */
> >>>>>> +           mc_stream_id = (mc_stream_id & 0xffff) |
> >>>>>> +                           ((mc_stream_id & (MC_FAPR_PL | MC_FAPR_BMT)) ?
> >>>>>> +                                   0x4000 : 0);
> >>>>>> +           error = acpi_dma_configure_id(&pdev->dev,
> DEV_DMA_COHERENT,
> >>>>>> +                                         &mc_stream_id);
> >>>>>> +           if (error)
> >>>>>> +                   dev_warn(&pdev->dev, "failed to configure dma: %d.\n",
> >>>>>> +                            error);
> >>>>>> +   }
> >>>>>> +
> >>>>>>      /*
> >>>>>>       * Get physical address of MC portal for the root DPRC:
> >>>>>>       */
> >>>>>> -   error = of_address_to_resource(pdev->dev.of_node, 0, &res);
> >>>>>> -   if (error < 0) {
> >>>>>> -           dev_err(&pdev->dev,
> >>>>>> -                   "of_address_to_resource() failed for %pOF\n",
> >>>>>> -                   pdev->dev.of_node);
> >>>>>> -           return error;
> >>>>>> -   }
> >>>>>> -
> >>>>>> -   mc_portal_phys_addr = res.start;
> >>>>>> -   mc_portal_size = resource_size(&res);
> >>>>>> +   plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>>>>> +   mc_portal_phys_addr = plat_res->start;
> >>>>>> +   mc_portal_size = resource_size(plat_res);
> >>>>>>      error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
> >>>>>>                               mc_portal_size, NULL,
> >>>>>>                               FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
> >>>>>> &mc_io); @@ -903,11 +930,13 @@ static int fsl_mc_bus_probe(struct
> >>>> platform_device *pdev)
> >>>>>>      dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
> >>>>>>               mc_version.major, mc_version.minor,
> >>>>>> mc_version.revision);
> >>>>>>
> >>>>>> -   error = get_mc_addr_translation_ranges(&pdev->dev,
> >>>>>> -                                          &mc->translation_ranges,
> >>>>>> -                                          &mc->num_translation_ranges);
> >>>>>> -   if (error < 0)
> >>>>>> -           goto error_cleanup_mc_io;
> >>>>>> +   if (dev_of_node(&pdev->dev)) {
> >>>>>> +           error = get_mc_addr_translation_ranges(&pdev->dev,
> >>>>>> +                                           &mc->translation_ranges,
> >>>>>> +                                           &mc->num_translation_ranges);
> >>>>>> +           if (error < 0)
> >>>>>> +                   goto error_cleanup_mc_io;
> >>>>>> +   }
> >>>>>>
> >>>>>>      error = dprc_get_container_id(mc_io, 0, &container_id);
> >>>>>>      if (error < 0) {
> >>>>>> @@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct
> >>>>>> platform_device
> >>>> *pdev)
> >>>>>>              goto error_cleanup_mc_io;
> >>>>>>
> >>>>>>      mc->root_mc_bus_dev = mc_bus_dev;
> >>>>>> +   mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
> >>>>> Makarand, this looks a bit weird. Is there really a reason for it?
> >>>> Can you clarify please so that we can reach a conclusion on this matter ?
> >>>>
> >>> Laurentiu, can you clarify what exactly is the doubt here? Are you
> >>> asking about
> >> fwnode assignment from pdev to mc_bus_dev?
> >> Yes. I remember that a while ago I tested without this fwnode
> >> assignment and didn't encounter any issues. Maybe we can just drop it?
> > Did you tested with PHY changes? Because this is needed for MAC driver,
> where it needs the mc bus node.
> 
> Maybe it worth a comment or maybe have it in a different patch?
> 
Since this change is needed for ACPI case and this is ACPI support case,
I feel we should have this change in this patch only instead of separate patch. 

> Thanks,
> Diana
> 
> >
> >> ---
> >> Best Regards, Laurentiu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
