Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C573C433E5
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 03:23:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EC3205CB
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 03:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c9IDHD9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EC3205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CBC7E88C09;
	Thu, 16 Jul 2020 03:23:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U-b5ywnhI5vK; Thu, 16 Jul 2020 03:23:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DE44B88B61;
	Thu, 16 Jul 2020 03:23:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFE88C07FF;
	Thu, 16 Jul 2020 03:23:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F808C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 03:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 16F5388B61
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 03:23:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uLhT91MmSnTj for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 03:23:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10076.outbound.protection.outlook.com [40.107.1.76])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0B08988BAE
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 03:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtsxNrkevzEkg+zIP3Rg9sRY9BzfjsbHuop3wS0V3HLwsa1aOKCLye8gwsK28TqmqED7RJNOMeTh9nZ6v2Bri9F7YOnZ7gZJ6HLWMK2SFWIIZM6TxpWVVdgs9sW/r6ZEbeu2c5v1bqLNbqfTRIlESZrzeuvbO1VK72BJMYsDfAyK9mkCJC4HQ+p7noEG5x81Kl/Qs+opiciR8qR/1ufQJ0J5AdsBOrIl13bvlYvTOqUdXMQyctg213n49qxnGyeSYeJKl0zn7YmMr4sIzet0h0OHTJ8X8AmgrJwnoGNMsyX9iHBCYlqJDrZvx7uMYvsQKkjV/ZnxIwbXyE+sauHAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTvseORo/eoEqYavPhwNm+cmgsW5Bsl6Z97Ekk5E6w4=;
 b=Sibl0JGZDMBzR4D/F/kKibJ+DzjBjjjSuENfg4dz+z6iJ5VfmTf0nAYAXCjcRW6FR1Z9mK+6DPGYbSGLxVTYv4JVemDdodEALikBw4VDvPYKpBRFE1yhvOzOyFT+cz+jpVMSHpJSlo6zNsjeEpyVdEM2SUJdc/8567pNgtb2yb4iKXbh8p63VddeLxUxBOGEh153XGI5kjUIl6ZVD6IEA7Q9diYj4PHmFQsIIYtoWQBwvLfqUpi1SUeznkmg2lspJfc1CJE7RvzEn/H/aVxKgMGamv1BrD1s+umxG2xzqx9iZ/M0x7HxA8VuHYNZ57mIxA53+NZ5lMQH7jb9ji1nfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTvseORo/eoEqYavPhwNm+cmgsW5Bsl6Z97Ekk5E6w4=;
 b=c9IDHD9EhqmM98H4xGAr94UsOTWgTcVhu8eK2iQvqZawAyZefwZozhcHC6Qrz/IJuZhJXzjYnxD0FD43Cc7kyeAkuNH7SQBjNaMCWeFIHUM3qtpRDXYMfaIPsFQ6kOltD6hwuGeLwytc48/xPrNm5bYWvQTgduk7jEzZgl4w0O4=
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com (2603:10a6:10:13::25)
 by DBBPR04MB6060.eurprd04.prod.outlook.com (2603:10a6:10:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 03:23:45 +0000
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e]) by DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e%6]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 03:23:45 +0000
From: Makarand Pawagi <makarand.pawagi@nxp.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
Thread-Topic: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
Thread-Index: AQHWT8hvhkZ6PFIXKUip8fS0U4S+lKj/BKAAgAABSiCAAA4OgIAAA0vwgAAFwICAAAET0IAJYZgAgAEhl1A=
Date: Thu, 16 Jul 2020 03:23:45 +0000
Message-ID: <DB7PR04MB498603933E805C0E4053D4B7EB7F0@DB7PR04MB4986.eurprd04.prod.outlook.com>
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
 <20200715100636.GA31330@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200715100636.GA31330@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [223.230.100.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9278c75d-c6ab-45ae-2287-08d82937a5e4
x-ms-traffictypediagnostic: DBBPR04MB6060:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB606035D8E9067DD89C5E9EAAEB7F0@DBBPR04MB6060.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ErHnI3+SftFm/lMLeucydwsAUnluyVxwte9DCvZFCvo4gXRbV8Qrkp9MS45v+XY25gr1ddE2AF7CakZ+Zgv/117D+9v94jCrZTlLXyOm9QmReN3TINW3WYJRhMWtT2/N2vR/QThy0OC1bXkEZngzP4lUsf9juGxlKSwi4v5/eUXkc7cowwhtaoulPqW5cRAFh5hQtpSAPANtdz1QQDC/i9U7lxtazS4WeXOvn9D3M3q4vUYTt7xGben79lxY2jnaCnEZ1rHv4zyMedjF/mEj2egibjMqEeEcCGgl+FtgOIfrf1S0Brc9Ou1r759VJtfXFu+e7x601N5qpye/10CVLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4986.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(26005)(4326008)(66946007)(76116006)(316002)(86362001)(55016002)(6916009)(7696005)(71200400001)(2906002)(44832011)(186003)(6506007)(53546011)(83380400001)(7416002)(52536014)(33656002)(66476007)(8676002)(478600001)(9686003)(54906003)(66446008)(64756008)(8936002)(66556008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: I+7jV2pRmZuHFO+NY6bkgqGlb8vrgSdFlaRPFYGnQPyfON3Noi3nr84Ozho0p1vIUyfL1VYLlLPE4YT8y1Dahvszi3fPmqbe9H2B2UuLyJO1EDYa5g0h+6dNCOVqRICzwlR3ASS5nr0OAJdoH6c5HWNcPN/zhr1dFYljxKlTfaJu/G+sfX8tKvXhN+WTNvlnZEYo1pW3TLwkKvSL5hyEulScBoNdXNIEBCoFbs3wKkFpwXhIlEHeAHq8BxPtCRhJhJdjpfi5G5xCKNBzWsMXQAaizi33kjVyRCRMp8rerqpqB8Wj9Zqyrx/xZSeEtAybgyKI6tm14vRF3YUAzw6U34ZOwg44tCBFTy3hEQV2XkfGrl9JsVjXK4uk34icAcxogfxSrSNqJPdfYXFsepSn2FcYGOo9Sn2FKXJtKJduGVY/zofOG1S0zTKN3pOwjmKr+yifWEVM+I4ZsSo6wQI9Ij/Gk/IHro/olQWZOxha940Zy+SNzY/WrBuGLRJU6Z2T
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4986.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9278c75d-c6ab-45ae-2287-08d82937a5e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 03:23:45.4627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZZ2DXuhAel+rImsdm+sWvafweUGBXt+e9vbTsDNPilyX4xdEyhqMBuCyiR27FrW3QNiEo8LXqtzi9Wnspj7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6060
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
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Wednesday, July 15, 2020 3:37 PM
> To: Makarand Pawagi <makarand.pawagi@nxp.com>
> Cc: Diana Madalina Craciun (OSS) <diana.craciun@oss.nxp.com>; Laurentiu
> Tudor <laurentiu.tudor@nxp.com>; linux-arm-kernel@lists.infradead.org;
> iommu@lists.linux-foundation.org; linux-acpi@vger.kernel.org;
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org; Rob Herring
> <robh+dt@kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Joerg Roedel
> <joro@8bytes.org>; Hanjun Guo <guohanjun@huawei.com>; Bjorn Helgaas
> <bhelgaas@google.com>; Sudeep Holla <sudeep.holla@arm.com>; Robin
> Murphy <robin.murphy@arm.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Marc Zyngier
> <maz@kernel.org>
> Subject: Re: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
> 
> Caution: EXT Email
> 
> On Thu, Jul 09, 2020 at 10:52:52AM +0000, Makarand Pawagi wrote:
> 
> [...]
> 
> > > >>>> fsl_mc_bus_probe(struct platform_device *pdev)
> > > >>>>>>      struct fsl_mc_io *mc_io = NULL;
> > > >>>>>>      int container_id;
> > > >>>>>>      phys_addr_t mc_portal_phys_addr;
> > > >>>>>> -   u32 mc_portal_size;
> > > >>>>>> -   struct resource res;
> > > >>>>>> +   u32 mc_portal_size, mc_stream_id;
> > > >>>>>> +   struct resource *plat_res;
> > > >>>>>> +
> > > >>>>>> +   if (!iommu_present(&fsl_mc_bus_type))
> > > >>>>>> +           return -EPROBE_DEFER;
> > > >>>>>>
> > > >>>>>>      mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
> > > >>>>>>      if (!mc)
> > > >>>>>> @@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct
> > > >>>>>> platform_device *pdev)
> > > >>>>>>
> > > >>>>>>      platform_set_drvdata(pdev, mc);
> > > >>>>>>
> > > >>>>>> +   plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > >>>>>> +   mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev,
> plat_res);
> > > >>>>>> +   if (IS_ERR(mc->fsl_mc_regs))
> > > >>>>>> +           return PTR_ERR(mc->fsl_mc_regs);
> > > >>>>>> +
> > > >>>>>> +   if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
> > > >>>>>> +           mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
> > > >>>>>> +           /*
> > > >>>>>> +            * HW ORs the PL and BMT bit, places the result in bit 15 of
> > > >>>>>> +            * the StreamID and ORs in the ICID. Calculate it accordingly.
> > > >>>>>> +            */
> > > >>>>>> +           mc_stream_id = (mc_stream_id & 0xffff) |
> > > >>>>>> +                           ((mc_stream_id & (MC_FAPR_PL | MC_FAPR_BMT)) ?
> > > >>>>>> +                                   0x4000 : 0);
> > > >>>>>> +           error = acpi_dma_configure_id(&pdev->dev,
> > > DEV_DMA_COHERENT,
> > > >>>>>> +                                         &mc_stream_id);
> > > >>>>>> +           if (error)
> > > >>>>>> +                   dev_warn(&pdev->dev, "failed to configure dma: %d.\n",
> > > >>>>>> +                            error);
> > > >>>>>> +   }
> > > >>>>>> +
> > > >>>>>>      /*
> > > >>>>>>       * Get physical address of MC portal for the root DPRC:
> > > >>>>>>       */
> > > >>>>>> -   error = of_address_to_resource(pdev->dev.of_node, 0, &res);
> > > >>>>>> -   if (error < 0) {
> > > >>>>>> -           dev_err(&pdev->dev,
> > > >>>>>> -                   "of_address_to_resource() failed for %pOF\n",
> > > >>>>>> -                   pdev->dev.of_node);
> > > >>>>>> -           return error;
> > > >>>>>> -   }
> > > >>>>>> -
> > > >>>>>> -   mc_portal_phys_addr = res.start;
> > > >>>>>> -   mc_portal_size = resource_size(&res);
> > > >>>>>> +   plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >>>>>> +   mc_portal_phys_addr = plat_res->start;
> > > >>>>>> +   mc_portal_size = resource_size(plat_res);
> > > >>>>>>      error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
> > > >>>>>>                               mc_portal_size, NULL,
> > > >>>>>>
> > > >>>>>> FSL_MC_IO_ATOMIC_CONTEXT_PORTAL, &mc_io); @@ -903,11
> +930,13
> > > >>>>>> @@ static int fsl_mc_bus_probe(struct
> > > >>>> platform_device *pdev)
> > > >>>>>>      dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
> > > >>>>>>               mc_version.major, mc_version.minor,
> > > >>>>>> mc_version.revision);
> > > >>>>>>
> > > >>>>>> -   error = get_mc_addr_translation_ranges(&pdev->dev,
> > > >>>>>> -                                          &mc->translation_ranges,
> > > >>>>>> -                                          &mc->num_translation_ranges);
> > > >>>>>> -   if (error < 0)
> > > >>>>>> -           goto error_cleanup_mc_io;
> > > >>>>>> +   if (dev_of_node(&pdev->dev)) {
> > > >>>>>> +           error = get_mc_addr_translation_ranges(&pdev->dev,
> > > >>>>>> +                                           &mc->translation_ranges,
> > > >>>>>> +                                           &mc->num_translation_ranges);
> > > >>>>>> +           if (error < 0)
> > > >>>>>> +                   goto error_cleanup_mc_io;
> > > >>>>>> +   }
> > > >>>>>>
> > > >>>>>>      error = dprc_get_container_id(mc_io, 0, &container_id);
> > > >>>>>>      if (error < 0) {
> > > >>>>>> @@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct
> > > >>>>>> platform_device
> > > >>>> *pdev)
> > > >>>>>>              goto error_cleanup_mc_io;
> > > >>>>>>
> > > >>>>>>      mc->root_mc_bus_dev = mc_bus_dev;
> > > >>>>>> +   mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
> > > >>>>> Makarand, this looks a bit weird. Is there really a reason for it?
> > > >>>> Can you clarify please so that we can reach a conclusion on this matter ?
> > > >>>>
> > > >>> Laurentiu, can you clarify what exactly is the doubt here? Are
> > > >>> you asking about
> > > >> fwnode assignment from pdev to mc_bus_dev?
> > > >> Yes. I remember that a while ago I tested without this fwnode
> > > >> assignment and didn't encounter any issues. Maybe we can just drop it?
> > > > Did you tested with PHY changes? Because this is needed for MAC
> > > > driver,
> > > where it needs the mc bus node.
> > >
> > > Maybe it worth a comment or maybe have it in a different patch?
> > >
> > Since this change is needed for ACPI case and this is ACPI support
> > case, I feel we should have this change in this patch only instead of
> > separate patch.
> 
> Anyway - you need to seek feedback from Marc on whether patches
> 11 and 12 are OK from an irqchip perspective, it is possible we can take the rest
> of the series independently if everyone agrees but I don't necessarily see a
> reason for that.
> 
> Long story short: you need Marc's ACK on [11-12], it is your code.
> 
Hi Marc, can you please review/ack this patch?

> Thanks,
> Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
