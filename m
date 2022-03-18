Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652AFC433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 05:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D524C8436B;
	Fri, 18 Mar 2022 05:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mIRl66mqTMCE; Fri, 18 Mar 2022 05:13:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA95B84356;
	Fri, 18 Mar 2022 05:13:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B9E8C0033;
	Fri, 18 Mar 2022 05:13:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33308C0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 05:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 270DA40101
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 05:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yzdJLMrae_MY for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 05:13:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70F37401D2
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 05:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIaWOUMalxIXWGdcUT+wyVvGJnO4eET3UGFZTmkeoLqtpMQbjkPmD4ga6l/pgbFTKKeEbAudyjUo3FAb1KIkMz7/RC9NPQQDFlq5CNn22zvfJUD2rSmBPCFIJu5EP4XS9PvvdGie7zilAXBgQOpvcI/ehG6TnX6WZSXgoKsyHv0d+RVtelj8q9/tXH70R0qDBaMBkW12AhDMQ8go9eQAnHvOUUgEHIEnYdfLzRU8II5PuUFUvTkm/PeHVdCxdRTnoYYQbGoDrwVqBJFjv2MmG+LMsKeMwtlaF0MnxntQZXg5LfQ7+P7IEKWZ1APbDiH6QiIQ64VoJbs7byIv6EhPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drdLC9M+ZAveSPuI87rpXPqL6vFqltjDVfNTnL7M5FI=;
 b=MycaaLhwCQ6Wks7BVTqHOKrx8rMfBl40INizDPAEKEJB8rqlfok8P2qrFyp50mKhgxNKW3j677M801kIh1BV2KEKMcVUX3mmF2bqa/06Z4BrKFV5sfB2hWRmqFfzwt/J2M6MHnZWOibR5a6TlYmNqk31w9+O27lA2W4OLmgg0iGuv7e0cgF/sI8pejDBaZT3q1VTGp9S+hBkb6WQcbcCi7UgePsNpY8i4b9sgRoO/qM54DUlmqsq8ccu6x5Tk/9HGj7XBNjDG74uokLzFH++GrFm2HDtiR77J2lrvOp0b3daTaumNiSLHwX1MqO4xuojxZNPb4cfZ3Y6jhYqUUb4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drdLC9M+ZAveSPuI87rpXPqL6vFqltjDVfNTnL7M5FI=;
 b=E1156XXa0ANgz3lvJ5hVJPm9duH663GNmcFyiTUkCVyvL8K7tAFmO8yo8UScxnhU7HtvajERPbGpKqfJNhnzm9qZCqyrpDfH/STq+jzJchhE/oHGhjr3gy9hM7yIbgRF/JIQu38NImpZ/RTW3PxIlgdi3lokCl0lwfnlOvJAVkU=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM6PR21MB1466.namprd21.prod.outlook.com (2603:10b6:5:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8; Fri, 18 Mar
 2022 05:13:03 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b%5]) with mapi id 15.20.5081.013; Fri, 18 Mar 2022
 05:12:57 +0000
To: Robin Murphy <robin.murphy@arm.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "robh@kernel.org" <robh@kernel.org>,
 "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 4/4 RESEND] PCI: hv: Propagate coherence from VMbus device
 to PCI device
Thread-Topic: [PATCH 4/4 RESEND] PCI: hv: Propagate coherence from VMbus
 device to PCI device
Thread-Index: AQHYOhuoZPOAPXCXP0q01eTUICYXTKzD0PMAgADGUgA=
Date: Fri, 18 Mar 2022 05:12:56 +0000
Message-ID: <PH0PR21MB302533BCD6707DAACC13E64DD7139@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-5-git-send-email-mikelley@microsoft.com>
 <9c52c5a0-163d-e2dd-d95b-9f382e665215@arm.com>
In-Reply-To: <9c52c5a0-163d-e2dd-d95b-9f382e665215@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bc4ff47c-b5d9-4f99-8999-baf3e627d00a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-18T05:05:11Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6b5710b-d766-4eb2-8eb2-08da089df6d7
x-ms-traffictypediagnostic: DM6PR21MB1466:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB146695175A86A4F8E7AB9745D7139@DM6PR21MB1466.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cr3hxrN8cjQZrLERscsG1/FFzhBAEcjp9e4dd/D8rxopMhNuYC+gOgKaS9INF6rmN7EgqMlA4VGR3nZCtbWF983xGAqJ2ZDcecUcXB8yvfNtz1xfy0O6H2slVtyrtLoJQy8WgUheEHn8Rd/dfbYKL1lEbyeH/kCtmkz/+z40JDjC4WgUjT3bylrf4j3PQbkwcZPBokFahD7sygeCwNBDf9zQ7UW9dDSgOmkQD//kIhpNPQi8Qv+aSzSCkLO0kBIGjVnyI/Zg1vtcD7s30SAu4rs7hl4sQGKxZ2w0CpvpAGIzkmsf6jyPEn+m3bnjsFQnxsun8pB+V/FnqSQxg/imxr5Rsb3Y0GpcQ2DsIZ5rjeol000JtJZRq01YWjdmDYVX6rP/kL9jRDifscHwjz4spzw97e60yOhlK1/UrlY68dvOjlqxJ5A+jKPmaPfaM5Y8ApPS3FFwObGnqpyGDD2UUjZrBJ0ha5bVmmuihMZEEpLss+sm5p3cLqeYTX1gljzrqa0fgoIKir4ROEKt3qWp+ZeBlus4AqJb1B//glmyr2e7hKHNvMs1KoYu5/CuAeyHWBr9IqaQP/D3vVSozZGDUkSF7vGNFhGFlG3S7Z2hQ9d6dn2T5dzngvT3yOe7NI118W/kVPfBhpZPhQBpsS5E4ruJ0zEwOiT87OWawMdb1eEEKWuzKmo/2LVvYuk6TigodsMzNxNlVaY+LIKby5ZP2WaPNlIrOPBXkMx7I5/LX2XCrMQTCfXpRRuJi5LRKcNsne3iOsjje2diTENabCH1cQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR21MB3025.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(6506007)(508600001)(82960400001)(10290500003)(110136005)(8990500004)(82950400001)(53546011)(55016003)(921005)(7416002)(8676002)(66476007)(66946007)(71200400001)(316002)(86362001)(5660300002)(66556008)(64756008)(66446008)(76116006)(52536014)(38070700005)(186003)(26005)(122000001)(9686003)(33656002)(7696005)(83380400001)(8936002)(38100700002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjNBbWdpSUxXK1R4U3dKcndwU1l4NmZsZGpNdG5NUFhxcUVsZjJ2cHp5TW5G?=
 =?utf-8?B?R2VNemhKbU9TdHUzWndxZVZCcFd0SXloekJvNnNMQ0lFdzMwYTlSWldPdXJF?=
 =?utf-8?B?cDJ0eGxZTHAvSUhrR0crMzdCVkdZMm1uT0N3eFhzY0wraUdBeFpIb0xLV1Jy?=
 =?utf-8?B?RysyWWo5U2k4bWwzaG9CN09XTDBuSUJhcERJMmFneGNmT2kyRS9tWGsrUlQv?=
 =?utf-8?B?Ykh1Y0JJZE5LOUZEWkFmMzVyaEtOMnRzRGF6cEx3ZElSVjk3K2hZRmo5WjZY?=
 =?utf-8?B?c3dNcmplOGRrazcxZEtKcmlEbGU0d0lSUkFQMC9WVGJObU9GR1FyTVk1bFl3?=
 =?utf-8?B?c1dpN1N0U1o0UU05dFRDaXB5UEdtUUw1YVZQR1RQZUdrU09TMjR5UWNlQ2FJ?=
 =?utf-8?B?djNPWUNiNGZYeVRKejZlZVFGL0VFaDU2UDNidzhmaUtxTnpDWDlWRzZzdUxH?=
 =?utf-8?B?dmhZNzVxMjRGRTVycllxNGFYRkJVbld5bGlxSlJNT2wrSFF5UzZXci8ybitB?=
 =?utf-8?B?bFpyczhGMzEzNmdHMDA4ckl6M1NXSGJJQWZmaXYra3ZwUzJKcHpvNld6UHBt?=
 =?utf-8?B?NGIvdGFycVpBd2dGdWFHeVZjeFRFdGhWQnJBckh0TjJnaURDamFMZXI4VVdj?=
 =?utf-8?B?OWRyTnJOOXRwOC9aSk12ODFZczI3dDJjMEI5eGdoVktnS1ZIamxmM1JnRGJq?=
 =?utf-8?B?Rnl5eU13SlMwRjJyVTYzb1hUcG93Q1JMRi9weFM0ODJxQk5PV1FpcUF6YVRD?=
 =?utf-8?B?eGkvMlNKc0FlQ2VIKzF2ZFQ1RmhRL3JoZG9SelJROVIzb1diOHo0K2djaFFm?=
 =?utf-8?B?cEsxVVFKWEFaeC85aUt5eTJDWXBxQ1VSbFJYOXYweTc3N2RwY25LS1lSWFpX?=
 =?utf-8?B?ZFpGeEVZcDEvKzYrYlhmV2ZHRzhGRGRXM2lQY1hYMXpkTmhhKzNSZmdTN1Ux?=
 =?utf-8?B?ZGFRZGM2SWZzdThHeS9rMDVQNTJydXBuT3ZoSllDRXM0ZnVLMkFDSXk0dFBE?=
 =?utf-8?B?U0J1REJibHIwUlFCSk44VWhPMEpSdkxVbFJsVkFEcmhSZDRXOFFpUE9YOFhG?=
 =?utf-8?B?MDRmb2R1ZFgwdE1ONTM2SldLbFc1YmVKRVYxTkx1Vk9FWlNObHlvbGFqRU9Y?=
 =?utf-8?B?YTQwUkRKRSsra2tUNzBGN3hYMEo3ZnBJZHdhOFB1SHU2MmxNWllmU2s3Vkcv?=
 =?utf-8?B?d0ZSWjBVT3QxS2lYNThLdVd0d0YzZTlsZGRabXlRMU5TeVQxcnlVMHIxV3lm?=
 =?utf-8?B?Uy9DcTh3QjR2Mk9XcEpYaDlZQVpVekwzM0Z3NGF6VC8wZ1V4a2hQbTZ1dmpL?=
 =?utf-8?B?OFpsT21vd2tQUmRYd2JGMy9uQXZLSWNyMEQxa2M1QUZ5b0Jxa2RtbTNscUZX?=
 =?utf-8?B?RTZ6N2w3dDN6ZlQvaXRnalNCMG9nWFVkUDVKVDFIMmh0cklVd2pNRUoxdVZ2?=
 =?utf-8?B?cUgycEVRdWhhenV5aTZHbW5oT01vblRldXZhTUJXYkxvN2hKMWpCTmtaMTZm?=
 =?utf-8?B?NlpEaDVBRk1wWldIZUhPaFRnTmJRTEc3L0RON3ZCTFlqUGk1SjY0dWI1Skg3?=
 =?utf-8?B?aEJlU0R0dTdOZFZxRG9pUlVUSVVpa0lLSE5aLzFFS2tlZ1ZrZGdSVUtYNG1t?=
 =?utf-8?B?SjJtMlZDZHd1K0NSV1dMK0liaXVTYUFKbDNzQ09SakRmaElCQno5emxTRXNz?=
 =?utf-8?B?TmRDK3dCeTB1NVJTMVdDRW9BaVBUUERkb3o2dnplS0dCVzVFNU5VRGdQdnlI?=
 =?utf-8?B?Q0dpaGUxcFByOVFlZGZQd003QWJWckIydTZJbWVrQ1pGV1JnVEU4NWQxNE1U?=
 =?utf-8?B?VFpuakd5cmczU3BPWndHVmVrWGNOWmZ0TUJ1UHhvZHhTMWczSFI1OWFNTFpM?=
 =?utf-8?B?d3NKeHIrSFV1TDFJT3F1TngxOEgxY0xOdG9OYVVRalpHRUdzTldrZlFROTBh?=
 =?utf-8?B?eGN6L3pyMkFrM3ZMcXY3WlU2d1Q1U2xSQTN0eFRCU2x2dlNjNGtKSVllN0dM?=
 =?utf-8?B?cXd3UzJNcGJnPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b5710b-d766-4eb2-8eb2-08da089df6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 05:12:56.7755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9lwAvjQmsDwiwCgo1Z7qpQfsnrXly65Q4HIEmcfUgYGYD9IBJXbM3DqRXey4IGqZmlhxzrzacSaYB64t9rxdWsm3zXRPHZDKWY4vux6NO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1466
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
From: "Michael Kelley \(LINUX\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Robin Murphy <robin.murphy@arm.com> Sent: Thursday, March 17, 2022 10:15 AM
> 
> On 2022-03-17 16:25, Michael Kelley via iommu wrote:
> > PCI pass-thru devices in a Hyper-V VM are represented as a VMBus
> > device and as a PCI device.  The coherence of the VMbus device is
> > set based on the VMbus node in ACPI, but the PCI device has no
> > ACPI node and defaults to not hardware coherent.  This results
> > in extra software coherence management overhead on ARM64 when
> > devices are hardware coherent.
> >
> > Fix this by propagating the coherence of the VMbus device to the
> > PCI device.  There's no effect on x86/x64 where devices are
> > always hardware coherent.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >   drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++----
> >   1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index ae0bc2f..14276f5 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -49,6 +49,7 @@
> >   #include <linux/refcount.h>
> >   #include <linux/irqdomain.h>
> >   #include <linux/acpi.h>
> > +#include <linux/dma-map-ops.h>
> >   #include <asm/mshyperv.h>
> >
> >   /*
> > @@ -2142,9 +2143,9 @@ static void hv_pci_remove_slots(struct hv_pcibus_device
> *hbus)
> >   }
> >
> >   /*
> > - * Set NUMA node for the devices on the bus
> > + * Set NUMA node and DMA coherence for the devices on the bus
> >    */
> > -static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
> > +static void hv_pci_assign_properties(struct hv_pcibus_device *hbus)
> >   {
> >   	struct pci_dev *dev;
> >   	struct pci_bus *bus = hbus->bridge->bus;
> > @@ -2167,6 +2168,14 @@ static void hv_pci_assign_numa_node(struct
> hv_pcibus_device *hbus)
> >   				     numa_map_to_online_node(
> >   					     hv_dev->desc.virtual_numa_node));
> >
> > +		/*
> > +		 * On ARM64, propagate the DMA coherence from the VMbus device
> > +		 * to the corresponding PCI device. On x86/x64, these calls
> > +		 * have no effect because DMA is always hardware coherent.
> > +		 */
> > +		dev_set_dma_coherent(&dev->dev,
> > +			dev_is_dma_coherent(&hbus->hdev->device));
> 
> Eww... if you really have to do this, I'd prefer to see a proper
> hv_dma_configure() helper implemented and wired up to
> pci_dma_configure(). Although since it's a generic property I guess at
> worst pci_dma_configure could perhaps propagate coherency from the host
> bridge to its children by itself in the absence of any other firmware
> info. And it's built-in so could use arch_setup_dma_ops() like everyone
> else.
> 

I'm not seeing an existing mechanism to provide a "helper" or override
of pci_dma_configure().   Could you elaborate?  Or is this something
that needs to be created?

Michael

> Robin.
> 
> > +
> >   		put_pcichild(hv_dev);
> >   	}
> >   }
> > @@ -2191,7 +2200,7 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device
> *hbus)
> >   		return error;
> >
> >   	pci_lock_rescan_remove();
> > -	hv_pci_assign_numa_node(hbus);
> > +	hv_pci_assign_properties(hbus);
> >   	pci_bus_assign_resources(bridge->bus);
> >   	hv_pci_assign_slots(hbus);
> >   	pci_bus_add_devices(bridge->bus);
> > @@ -2458,7 +2467,7 @@ static void pci_devices_present_work(struct work_struct
> *work)
> >   		 */
> >   		pci_lock_rescan_remove();
> >   		pci_scan_child_bus(hbus->bridge->bus);
> > -		hv_pci_assign_numa_node(hbus);
> > +		hv_pci_assign_properties(hbus);
> >   		hv_pci_assign_slots(hbus);
> >   		pci_unlock_rescan_remove();
> >   		break;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
