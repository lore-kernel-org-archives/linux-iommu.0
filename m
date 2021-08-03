Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B35C4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 05:51:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8193F60C41
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 05:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8193F60C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DD26606F1;
	Tue,  3 Aug 2021 05:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e-DwBjIIOc79; Tue,  3 Aug 2021 05:50:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 80F3560613;
	Tue,  3 Aug 2021 05:50:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 422C3C0010;
	Tue,  3 Aug 2021 05:50:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B155FC000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 05:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 999BC82813
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 05:50:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K7G13cNqD8_v for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 05:50:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E916827FB
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 05:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxfeDLBsGGUuJnp6NSLt98rUmGxU7YQMiKaIvWrC45NtWppVhewqD2dmKsTTPgq8kzGe1tmvNSj039p7AzxG4Xx32zwNcjxroPD6clKHXmAqSUgBJw/JF2ZNupFRTx0Dm3Olnw599IL2dwqNPFU1Ow3LCwHYal03kZKGfo9/2Zc5IO5fujnxyx2mU7CuK7+31Tr3reEGkXbLUNshjtsGOqVEe2pNTuK7rzDuifVcKeajZgq0OlCy+3lYTHw1IEf+LPK7wVtcCWbX53ia9bvYqR9yX1GWNDEta/POn4cSze8IQweA5R6BfsgVLwf4Sbr1Edu3QiSmm6nAQ4PTTfLylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0rm4hu4MqitA6ZXtg33Hbv+HIacmjfwpw58sYMRfe4=;
 b=MoDw16jtgnCZ9BsZWzUR1m7bFBZaQmtsump0mrtM/bOq6RdOgsG+2ll+nHgHXKnI+LOc6YzmAmD2+e4RAT923K360cas2qIMNxSrm491kcZsjZm7kgSiH6rl6v0//gcG06pEUivS808pFqhAQ1AQLTyT4OsSHHVi1Bw//maA2iVS+pMIZG2S2mHX5LmyyeIDYWctYNSloXTcyrxp5eupI4B3gnQTxTiNtPZDAvs9yJA8IcGQdpCV10jPyqLICDf3zAx1Tc+P1aG28y7WUGH821z6fvlvflnnFWQlRSTxTUQagJR1nC+Waj3RnMAg3nHBjAlkwlz1F7XMPDnXa780MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0rm4hu4MqitA6ZXtg33Hbv+HIacmjfwpw58sYMRfe4=;
 b=EZGp9Cut4WALZAbR4K40+jmh/W5ackpMzPuG1L5NdUeu9kE/cmxrOP6aR8Pux4f/lWqp/+Q9kpeRg/S40LG4x5McoBWxNtRa3H8xd/dmk2HLTEVwR7PEtkQ9ddwnYGFWX86W30Ign6XncP6ka4gsREwEaNYjU3w4B1aG+SaXElQ=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15; Tue, 3 Aug 2021 05:50:47 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72%9]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 05:50:47 +0000
To: Chris Wilson <chris@chris-wilson.co.uk>, Robin Murphy
 <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH] iommu/iova: kmemleak when disable SRIOV.
Thread-Topic: [PATCH] iommu/iova: kmemleak when disable SRIOV.
Thread-Index: AQHXftHncp563ylbik+a4AZQduZFMKtPFoAAgAcppICAAEt+gIAAVxPQgAAFi4CACmK5oA==
Date: Tue, 3 Aug 2021 05:50:47 +0000
Message-ID: <DM8PR12MB54785D5E3F31EA4E887B02C3F8F09@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210722081629.7863-1-PengJu.Zhou@amd.com>
 <4b59b7ee-5258-a2ca-531c-b1b5d9c064e7@arm.com>
 <DM8PR12MB5478D90255FF1379E44AC51AF8E99@DM8PR12MB5478.namprd12.prod.outlook.com>
 <c86a8861-64b5-92dc-b664-b31402f23db3@arm.com>
 <DM8PR12MB5478DD7F296EB264848680EEF8E99@DM8PR12MB5478.namprd12.prod.outlook.com>
 <e6675688-c5a7-448f-84f4-bba0217d99a6@arm.com>
In-Reply-To: <e6675688-c5a7-448f-84f4-bba0217d99a6@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-03T05:50:43Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3394b804-1095-4d0d-9bb6-8cfc96c565ac;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: chris-wilson.co.uk; dkim=none (message not signed)
 header.d=none; chris-wilson.co.uk; dmarc=none action=none header.from=amd.com; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd160307-8ddf-4959-c1da-08d95642a472
x-ms-traffictypediagnostic: DM8PR12MB5447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB54477B045F706FB1AFB9FB7DF8F09@DM8PR12MB5447.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2H0lnvEq99/YqiNuY7jNTyBWNYpZkIPnwFj00P8FHBcLV5xxdXXCz5eMDapPs44JD8BKv54qF9UeeMn9tztKBFY+4uDOtku8FKWU12ZQWSLCXEd3phEgC5+tkGZJ2b8+MECzUX81f9mRvKOx7N6+HPGTNeS94/LtQhfsEVdFOr1xV8qpT7vjbQzRAAd3wh4VHTlW91Rnrj6n+j3mwGMf44cTdPQ+RSPt6taIkb2S4nUOZHrl9X07Ot/2PPtL5hvq7EK47Onj5QfBcnQ3P67lvXuAD22sqiVRLXR9jfyiFiI6Vz6Rx74YwnJt6Ust0q9FXTsCgWjcOEidba47Slp9WJevyd450cuh9yUX3KwINKlmbTuI24DFuwLdkYvCuj8hch/NpbXjhix0qePLKRsjjJJjra8uaB3zI/Bm9nQsJJjVR4TiaVihMmsRCeoOOUmlRPraqWHFeQGWrEJPvil1jLNcBk/7bnmtKMJjuoOMAF0R5yzuFkxftKyaF8fbqX1HQte8/J5Vaw02TPs2u0egYsMplpNDKdYJhujzs01EmbgwDhN10Vf4cG6pICoUQZ8yyEOoEkVcXwa7FvETNJ1cgunlGYtXSq3CMuZbOw3+CCNBdpeqkU1XU6zBwBeT2VbZHUPMEu2n9kqbKm3W+qiUtgSOQeAf/Evd0uk2qwu6sn4kJ+yEcgEoHyGysyDlhNAkOI+3SWI1mR+VZHdqY/L9syuSfPwyyRy9DobFzggMs02kCa8HY56zzyO6oeJPzxKbBY81mJEvXuUQz6veDtMxFqAKucTYTcYtE14gg/xOwmY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(84040400004)(30864003)(2906002)(316002)(38070700005)(122000001)(38100700002)(66476007)(66556008)(64756008)(66446008)(7696005)(66946007)(76116006)(26005)(53546011)(6506007)(186003)(8936002)(66574015)(86362001)(8676002)(71200400001)(4326008)(52536014)(110136005)(5660300002)(54906003)(9686003)(45080400002)(478600001)(55016002)(83380400001)(966005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WohvdJPfb8zbMyWF+B6gcGayr4sAOIzYC0Cst1VC85yOVklKvcHSxMcHY2tu?=
 =?us-ascii?Q?w/P8uWTXVPFwn1DvKA81oOM0WzV3YNhVzRCmsT+eX4mwGQCb8mMoxCsj4pdT?=
 =?us-ascii?Q?zESJYOTk0dndK402U3xTq17EIjuQe2FNxCEI5PItySbUf/NQ4yzn4mopsEzF?=
 =?us-ascii?Q?H+1h99NtcHvigX0SucLEzCdDpyWoEJWJD3yLXOyUxFH7vwNdCjlpbYdV6iJm?=
 =?us-ascii?Q?ui9H0uCLj5nubEORa7Nrf7JnAYTr3GxhmGQeg8SfllOkaKxwmNHaNX0vYsJu?=
 =?us-ascii?Q?rlR3vrl2ihMHytX9HhCRaCcOe3n1Az3WDVtqJ6G42g7K9pernb+CEOHq6FWW?=
 =?us-ascii?Q?CUCzy1p4YV3kKvM+27/P95AGq8GX4vz0IArskftHMslC11i4EvTm7rvJV8Uj?=
 =?us-ascii?Q?3revV+kPWxSf422i/gszvWxL9LXKXvpTjXdbcUnjnNaS2prkFZoMhTyNefeP?=
 =?us-ascii?Q?iW2kAjpUoXI8YR1aPVuNs5OwpIlQpNLBqIQVX9tN6R2zhJRm3LZLYJAgKuU9?=
 =?us-ascii?Q?m1rvnRYBdGJUhZ8vDKH9lGS2qZqh9MA18lfc+e1pVFhe7hPFhtBs3fRO2/F4?=
 =?us-ascii?Q?/+Ha5Id0hhwaqcUzR6LhSwDxox+xqr3JS8pvqHCKC8EsEAAkKfj6Rxo8D/q4?=
 =?us-ascii?Q?MoEr207ZHoTh3eZicPSSH14r018kanReaL8BRJcWybrNMOLY1Snq7gycz2Fc?=
 =?us-ascii?Q?E9tVv/qEZsTtg2bWmkn/KOUx9F7qCy4oOgiOolMCF90o0SVhJrXjCmnQ/KMN?=
 =?us-ascii?Q?s4sXdo92wkQjH4NWeViljB2sdYtHMtnGS70WWLzcP/iS3QvqSks9M3PweKFQ?=
 =?us-ascii?Q?w9d5erKcVWH5IbqUgM88wnmU5qiZqxzCu3GAc7a1gl9pIMMMfdT7Lbyg1/nV?=
 =?us-ascii?Q?G4rJt5vkUQyvab4F9/wwzKVIaVqfLkq4p5diEa8UDJpMcd2tMlhvyEgxcQY0?=
 =?us-ascii?Q?CZTJoyEd4iUkPzx6zNy3qeQcvdgCSsk8fgOUELGlRLZsD95ZgINyWM9nU6w0?=
 =?us-ascii?Q?LwQDFWajiBAUnxW7eG+it6IG/pPgpzVDZbadENLahvVaBp9l6irMvuGIfXey?=
 =?us-ascii?Q?sFlfCSf5kiSVzsSDqRXoMqdzxtPrUiUAumktnt+DUYqnCQKIXjgrW+yOq8CT?=
 =?us-ascii?Q?1c7StXRLhAXyYQ4iP+/2N2seIXrI5LEoZLglj9pNjtHMPMdI3S3x1GH1WJFW?=
 =?us-ascii?Q?5D6Xe9CPVIqCrchfDWdhUd7AZkn5HGpbsAyzemtNT395LwjwsE6tFQKAiQhk?=
 =?us-ascii?Q?2Lea1W9ah1x4ZwzrcokiO8UbXX55Qf2c+4bs5/n/9n3Ks+waNXeOmzqQ1mx5?=
 =?us-ascii?Q?2qU4IEMxmqLqKrJHuLQDqqBV?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd160307-8ddf-4959-c1da-08d95642a472
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 05:50:47.5205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqrvIYma/o6kT8U+VJbomphU2MqzyMTDn5xb5F3hgQaBtPIAqyr1ThD0mBSbjptdsoEncTr6dVA68tQXbBddEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5447
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yin" <Yin.Wang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "will@kernel.org" <will@kernel.org>, "Chang, HaiJun" <HaiJun.Chang@amd.com>
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
From: "Zhou, Peng Ju via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

[AMD Official Use Only]

Hi Chris
I hit kmemleak with your following patch, Can you help to fix it?

According to the info in this thread, it seems the patch doesn't merge into iommu mainline branch, but I can get your patch from my kernel: 5.11.0

 
commit 48a64dd561a53fb809e3f2210faf5dd442cfc56d
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Sat Jan 16 11:10:35 2021 +0000

    iommu/iova: Use bottom-up allocation for DMA32

    Since DMA32 allocations are currently allocated top-down from the 4G
    boundary, this causes fragmentation and reduces the maximise allocation
    size. On some systems, the dma address space may be extremely
    constrained by PCIe windows, requiring a stronger anti-fragmentation
    strategy.

    Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/2929
    Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>


---------------------------------------------------------------------- 
BW
Pengju Zhou





> -----Original Message-----
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Tuesday, July 27, 2021 10:23 PM
> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; iommu@lists.linux-
> foundation.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yin
> <Yin.Wang@amd.com>; will@kernel.org
> Subject: Re: [PATCH] iommu/iova: kmemleak when disable SRIOV.
> 
> On 2021-07-27 15:05, Zhou, Peng Ju wrote:
> > [AMD Official Use Only]
> >
> > Hi Robin
> > The patch which add "head" :
> >
> > commit 48a64dd561a53fb809e3f2210faf5dd442cfc56d
> > Author: Chris Wilson <chris@chris-wilson.co.uk>
> > Date:   Sat Jan 16 11:10:35 2021 +0000
> >
> >      iommu/iova: Use bottom-up allocation for DMA32
> >
> >      Since DMA32 allocations are currently allocated top-down from the 4G
> >      boundary, this causes fragmentation and reduces the maximise allocation
> >      size. On some systems, the dma address space may be extremely
> >      constrained by PCIe windows, requiring a stronger anti-fragmentation
> >      strategy.
> >
> >      Closes:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.f
> reedesktop.org%2Fdrm%2Fintel%2F-
> %2Fissues%2F2929&amp;data=04%7C01%7CPengJu.Zhou%40amd.com%7C47f
> c4308f6044a379ed908d9510a19b1%7C3dd8961fe4884e608e11a82d994e183d
> %7C0%7C0%7C637629927137121754%7CUnknown%7CTWFpbGZsb3d8eyJWIjo
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000
> &amp;sdata=iO5%2FKSW8KV1UZtwGU3oiZpYqiR4eBNcSpF3%2Ft6uSDpY%3D&
> amp;reserved=0
> >      Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> 
> ...which is not in mainline. I've never even seen it posted for review.
> In fact two search engines can't seem to find any trace of that SHA or patch
> subject on the internet at all.
> 
> By all means tell Chris that his patch, wherever you got it from, is broken, but
> once again there's nothing the upstream maintainers/reviewers can do about
> code which isn't upstream.
> 
> Thanks,
> Robin.
> 
> > ----------------------------------------------------------------------
> > BW
> > Pengju Zhou
> >
> >
> >
> >> -----Original Message-----
> >> From: Robin Murphy <robin.murphy@arm.com>
> >> Sent: Tuesday, July 27, 2021 4:52 PM
> >> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; iommu@lists.linux-
> >> foundation.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yin
> >> <Yin.Wang@amd.com>; will@kernel.org
> >> Subject: Re: [PATCH] iommu/iova: kmemleak when disable SRIOV.
> >>
> >> On 2021-07-27 05:46, Zhou, Peng Ju wrote:
> >>> [AMD Official Use Only]
> >>>
> >>> Hi Robin
> >>> 1. it is not a good manner to free a statically allocated object(in
> >>> this case, it
> >> is iovad->head) dynamically even though the free only occurred when
> >> shut down the OS in most cases.
> >>> 2. the kmemleak occurred when disable SRIOV(remove a PCIE device), I
> >>> post the log in the following, in the log, the line:" kmemleak:
> >>> Found object by alias at 0xffff9221ae647050" means the OS frees a
> >>> not existing object(iovad->head) which added to RB_TREE in the
> >>> function init_iova_domain
> >>
> >> Sure, it was apparent enough what the bug was; my point is that the
> >> bug does not exist in mainline. This is the current mainline
> >> definition of struct
> >> iova_domain:
> >>
> >>
> >> /* holds all the iova translations for a domain */ struct iova_domain {
> >> 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree
> >> */
> >> 	struct rb_root	rbroot;		/* iova domain rbtree root */
> >> 	struct rb_node	*cached_node;	/* Save last alloced node */
> >> 	struct rb_node	*cached32_node; /* Save last 32-bit alloced node */
> >> 	unsigned long	granule;	/* pfn granularity for this domain */
> >> 	unsigned long	start_pfn;	/* Lower limit for this domain */
> >> 	unsigned long	dma_32bit_pfn;
> >> 	unsigned long	max32_alloc_size; /* Size of last failed allocation */
> >> 	struct iova_fq __percpu *fq;	/* Flush Queue */
> >>
> >> 	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes
> >> that
> >> 						   have been started */
> >>
> >> 	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes
> >> that
> >> 						   have been finished */
> >>
> >> 	struct iova	anchor;		/* rbtree lookup anchor */
> >> 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/*
> >> IOVA range caches */
> >>
> >> 	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
> >> 					   TLBs */
> >>
> >> 	iova_entry_dtor entry_dtor;	/* IOMMU driver specific destructor
> >> for
> >> 					   iova entry */
> >>
> >> 	struct timer_list fq_timer;		/* Timer to regularily empty
> >> the
> >> 						   flush-queues */
> >> 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
> >> 						   when not */
> >> 	struct hlist_node	cpuhp_dead;
> >> };
> >>
> >>
> >> Please point to where "head" exists either way ;)
> >>
> >> The mainline code already has a special case to avoid trying to free
> >> the statically-allocated "anchor" node. Whoever modified your kernel
> >> has apparently failed to preserve the equivalent behaviour.
> >>
> >> Robin.
> >>
> >>> The patch I sent out may don't meet IOMMU requirement because I have
> >> no knowledge of the background of IOMMU, but this patch can fix this
> >> kmemleak.
> >>>
> >>> The kmemleak log on my server:
> >>> 316613 Jul 19 02:14:20 z-u18 kernel: [  108.967526] pci 0000:83:02.0:
> >>> Removing from iommu group 108
> >>> 316614 Jul 19 02:14:20 z-u18 kernel: [  108.969032] kmemleak: Found
> >> object by alias at 0xffff9221ae647050
> >>> 316615 Jul 19 02:14:20 z-u18 kernel: [  108.969037] CPU: 30 PID:
> >>> 2768
> >> Comm: modprobe Tainted: G           OE     5.11.0 #       12
> >>> 316616 Jul 19 02:14:20 z-u18 kernel: [  108.969042] Hardware name:
> >> Supermicro ...
> >>> 316617 Jul 19 02:14:20 z-u18 kernel: [  108.969045] Call Trace:
> >>> 316618 Jul 19 02:14:20 z-u18 kernel: [  108.969049]
> >>> dump_stack+0x6d/0x88
> >>> 316619 Jul 19 02:14:20 z-u18 kernel: [  108.969061]
> >>> lookup_object+0x5f/0x70
> >>> 316620 Jul 19 02:14:20 z-u18 kernel: [  108.969070]
> >>> find_and_remove_object+0x29/0x80
> >>> 316621 Jul 19 02:14:20 z-u18 kernel: [  108.969077]
> >>> delete_object_full+0xc/0x20
> >>> 316622 Jul 19 02:14:20 z-u18 kernel: [  108.969083]
> >>> kmem_cache_free+0x22b/0x410
> >>> 316623 Jul 19 02:14:20 z-u18 kernel: [  108.969097]
> >>> free_iova_mem+0x22/0x60
> >>> 316624 Jul 19 02:14:20 z-u18 kernel: [  108.969103]
> >>> put_iova_domain+0x1b5/0x1e0
> >>> 316625 Jul 19 02:14:20 z-u18 kernel: [  108.969108]
> >>> iommu_put_dma_cookie+0x44/0xc0
> >>> 316626 Jul 19 02:14:20 z-u18 kernel: [  108.969118]
> >>> domain_exit+0xba/0xc0
> >>> 316627 Jul 19 02:14:20 z-u18 kernel: [  108.969123]
> >>> iommu_group_release+0x51/0x90
> >>> 316628 Jul 19 02:14:20 z-u18 kernel: [  108.969129]
> >>> kobject_put+0xa7/0x210
> >>> 316629 Jul 19 02:14:20 z-u18 kernel: [  108.969140]
> >>> iommu_release_device+0x41/0x80
> >>> 316630 Jul 19 02:14:20 z-u18 kernel: [  108.969147]
> >>> iommu_bus_notifier+0xa0/0xc0
> >>> 316631 Jul 19 02:14:20 z-u18 kernel: [  108.969153]
> >>> blocking_notifier_call_chain+0x63/0x90
> >>> 316632 Jul 19 02:14:20 z-u18 kernel: [  108.969162]
> >>> device_del+0x29c/0x3f0
> >>> 316633 Jul 19 02:14:20 z-u18 kernel: [  108.969167]
> >>> pci_remove_bus_device+0x77/0x100
> >>> 316634 Jul 19 02:14:20 z-u18 kernel: [  108.969178]
> >>> pci_iov_remove_virtfn+0xbc/0x110
> >>> 316635 Jul 19 02:14:20 z-u18 kernel: [  108.969187]
> >>> sriov_disable+0x2f/0xe0 ......
> >>> 316651 Jul 19 02:14:20 z-u18 kernel: [  108.969629] RIP:
> >> 0033:0x7f6d8ec45047
> >>> 316652 Jul 19 02:14:20 z-u18 kernel: [  108.969634] Code: 73 01 c3
> >>> 48 8b
> >> 0d 41 8e 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66        2e 0f 1f 84 00 00 00 00
> >> 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d
> >> 11 8e 2c 00 f       7 d8 64 89 01 48
> >>> 316653 Jul 19 02:14:20 z-u18 kernel: [  108.969638] RSP:
> >> 002b:00007ffc18dafc48 EFLAGS: 00000206 ORIG_RAX: 00000000000000b
> >> 0
> >>> 316654 Jul 19 02:14:20 z-u18 kernel: [  108.969645] RAX:
> >>> ffffffffffffffda RBX: 000055817f00adc0 RCX: 00007f6d8ec45047
> >>> 316655 Jul 19 02:14:20 z-u18 kernel: [  108.969648] RDX:
> >>> 0000000000000000 RSI: 0000000000000800 RDI: 000055817f00ae28
> >>> 316656 Jul 19 02:14:20 z-u18 kernel: [  108.969651] RBP:
> >>> 000055817f00adc0 R08: 00007ffc18daebf1 R09: 0000000000000000
> >>> 316657 Jul 19 02:14:20 z-u18 kernel: [  108.969654] R10:
> >>> 00007f6d8ecc1c40 R11: 0000000000000206 R12: 000055817f00ae28
> >>> 316658 Jul 19 02:14:20 z-u18 kernel: [  108.969656] R13:
> >>> 0000000000000001 R14: 000055817f00ae28 R15: 00007ffc18db1030
> >>> 316659 Jul 19 02:14:20 z-u18 kernel: [  108.969661] kmemleak: Object
> >> 0xffff9221ae647000 (size 2048):
> >>> 316660 Jul 19 02:14:20 z-u18 kernel: [  108.969665] kmemleak:   comm
> >> "gpu_init_thread", pid 2687, jiffies 4294911321
> >>> 316661 Jul 19 02:14:20 z-u18 kernel: [  108.969669] kmemleak:
> >> min_count = 1
> >>> 316662 Jul 19 02:14:20 z-u18 kernel: [  108.969671] kmemleak:   count = 0
> >>> 316663 Jul 19 02:14:20 z-u18 kernel: [  108.969672] kmemleak:   flags =
> >> 0x1
> >>> 316664 Jul 19 02:14:20 z-u18 kernel: [  108.969674] kmemleak:   checksum
> >> = 0
> >>> 316665 Jul 19 02:14:20 z-u18 kernel: [  108.969675] kmemleak:   backtrace:
> >>> 316666 Jul 19 02:14:20 z-u18 kernel: [  108.969677]
> >> cookie_alloc+0x1f/0x60
> >>> 316667 Jul 19 02:14:20 z-u18 kernel: [  108.969682]
> >> iommu_get_dma_cookie+0x17/0x30
> >>> 316668 Jul 19 02:14:20 z-u18 kernel: [  108.969685]
> >> intel_iommu_domain_alloc+0xa7/0xe0
> >>> 316669 Jul 19 02:14:20 z-u18 kernel: [  108.969689]
> >> iommu_group_alloc_default_domain+0x4c/0x160
> >>> 316670 Jul 19 02:14:20 z-u18 kernel: [  108.969695]
> >> iommu_probe_device+0xff/0x130
> >>> 316671 Jul 19 02:14:20 z-u18 kernel: [  108.969702]
> >> iommu_bus_notifier+0x7c/0xc0
> >>> 316672 Jul 19 02:14:20 z-u18 kernel: [  108.969708]
> >> blocking_notifier_call_chain+0x63/0x90
> >>> 316673 Jul 19 02:14:20 z-u18 kernel: [  108.969713]
> >> device_add+0x3f9/0x860
> >>> 316674 Jul 19 02:14:20 z-u18 kernel: [  108.969717]
> >> pci_device_add+0x2c3/0x6a0
> >>> 316675 Jul 19 02:14:20 z-u18 kernel: [  108.969723]
> >> pci_iov_add_virtfn+0x1b1/0x300
> >>> 316676 Jul 19 02:14:20 z-u18 kernel: [  108.969729]
> >> sriov_enable+0x254/0x410
> >>>
> >>>
> >>> --------------------------------------------------------------------
> >>> --
> >>> BW
> >>> Pengju Zhou
> >>>
> >>>
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Robin Murphy <robin.murphy@arm.com>
> >>>> Sent: Thursday, July 22, 2021 10:59 PM
> >>>> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; iommu@lists.linux-
> >>>> foundation.org
> >>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yin
> >>>> <Yin.Wang@amd.com>; will@kernel.org
> >>>> Subject: Re: [PATCH] iommu/iova: kmemleak when disable SRIOV.
> >>>>
> >>>> On 2021-07-22 09:16, Peng Ju Zhou via iommu wrote:
> >>>>> the object iova->head allocated statically when enable SRIOV but
> >>>>> freed dynamically when disable SRIOV which causing kmemleak.
> >>>>> changing the allocation from statically to dynamically.
> >>>>
> >>>> Thanks for the glimpse into the kind of weird and wonderful things
> >>>> people are doing to the IOVA allocator out-of-tree (the "holes"
> >>>> list sounds like an idea I also thought about a long time ago), but
> >>>> judging by the context this patch is clearly of no use to mainline
> >>>> ;)
> >>>>
> >>>> Robin.
> >>>>
> >>>>> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> >>>>> ---
> >>>>>     drivers/iommu/iova.c | 15 ++++++++-------
> >>>>>     include/linux/iova.h |  4 ++--
> >>>>>     2 files changed, 10 insertions(+), 9 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c index
> >>>>> 2371524796d3..505881d8d97f 100644
> >>>>> --- a/drivers/iommu/iova.c
> >>>>> +++ b/drivers/iommu/iova.c
> >>>>> @@ -26,6 +26,8 @@ static void free_iova_rcaches(struct iova_domain
> >>>> *iovad);
> >>>>>     static void fq_destroy_all_entries(struct iova_domain *iovad);
> >>>>>     static void fq_flush_timeout(struct timer_list *t);
> >>>>>     static void free_global_cached_iovas(struct iova_domain
> >>>>> *iovad);
> >>>>> +static inline struct iova *alloc_and_init_iova(unsigned long pfn_lo,
> >>>>> +					       unsigned long pfn_hi);
> >>>>>
> >>>>>     void
> >>>>>     init_iova_domain(struct iova_domain *iovad, unsigned long
> >>>>> granule, @@ -47,17 +49,16 @@ init_iova_domain(struct iova_domain
> >>>>> *iovad, unsigned long granule,
> >>>>>
> >>>>>     	INIT_LIST_HEAD(&iovad->holes);
> >>>>>
> >>>>> -	iovad->head.pfn_lo = 0;
> >>>>> -	iovad->head.pfn_hi = start_pfn;
> >>>>> -	rb_link_node(&iovad->head.node, NULL, &iovad->rbroot.rb_node);
> >>>>> -	rb_insert_color(&iovad->head.node, &iovad->rbroot);
> >>>>> -	list_add(&iovad->head.hole, &iovad->holes);
> >>>>> +	iovad->head = alloc_and_init_iova(0, start_pfn);
> >>>>> +	rb_link_node(&iovad->head->node, NULL, &iovad->rbroot.rb_node);
> >>>>> +	rb_insert_color(&iovad->head->node, &iovad->rbroot);
> >>>>> +	list_add(&iovad->head->hole, &iovad->holes);
> >>>>>
> >>>>>     	iovad->tail.pfn_lo = IOVA_ANCHOR;
> >>>>>     	iovad->tail.pfn_hi = IOVA_ANCHOR;
> >>>>>     	rb_link_node(&iovad->tail.node,
> >>>>> -		     &iovad->head.node,
> >>>>> -		     &iovad->head.node.rb_right);
> >>>>> +		     &iovad->head->node,
> >>>>> +		     &iovad->head->node.rb_right);
> >>>>>     	rb_insert_color(&iovad->tail.node, &iovad->rbroot);
> >>>>>
> >>>>>     	init_iova_rcaches(iovad);
> >>>>> diff --git a/include/linux/iova.h b/include/linux/iova.h index
> >>>>> 076eb6cfc613..553905ef41fe 100644
> >>>>> --- a/include/linux/iova.h
> >>>>> +++ b/include/linux/iova.h
> >>>>> @@ -81,7 +81,7 @@ struct iova_domain {
> >>>>>     						   have been finished
> */
> >>>>>
> >>>>>     	struct list_head holes;
> >>>>> -	struct iova	head, tail;		/* rbtree lookup anchors */
> >>>>> +	struct iova	*head, tail;		/* rbtree lookup anchors */
> >>>>>     	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];
> 	/*
> >>>> IOVA range caches */
> >>>>>
> >>>>>     	iova_flush_cb	flush_cb;	/* Call-Back function to flush
> IOMMU
> >>>>> @@ -252,7 +252,7 @@ static inline void
> >>>>> free_cpu_cached_iovas(unsigned int cpu,
> >>>>>
> >>>>>     static inline unsigned long iovad_start_pfn(struct iova_domain *iovad)
> >>>>>     {
> >>>>> -	return iovad->head.pfn_hi;
> >>>>> +	return iovad->head->pfn_hi;
> >>>>>     }
> >>>>>
> >>>>>     #endif
> >>>>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
