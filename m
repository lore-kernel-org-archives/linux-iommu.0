Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E03C433E6
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 15:47:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2452075B
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 15:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yPaiAu56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2452075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 69BCC88263;
	Fri, 28 Aug 2020 15:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9dIFhQP7EOsI; Fri, 28 Aug 2020 15:47:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A904E88188;
	Fri, 28 Aug 2020 15:47:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92E19C016F;
	Fri, 28 Aug 2020 15:47:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15874C0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 15:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F220922920
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 15:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GmzDDF4NaTe9 for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 15:47:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by silver.osuosl.org (Postfix) with ESMTPS id B2E7C231B1
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 15:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFebrR5FKOwk5OiYpI1tLTYv36+QAMwQup/K/7MhjWvELX1CxgLYreMPdCiIbuhh4j4VGgeMIU0rZittK2Px2bL6aXQsS8qpWnFqCFKbqy72Np5Y3GWEHsiNxYOmygsHdkBirc3qEEsn1CvW1o2sGq+W9OR2Z6xDIX10yYS5IGUO8G2ZyZlHcZKoomgaQfjVXkZsIENva1/S2Cexo/XYOf4oyA4uP6E7b2uoCkKO25OehlXrm6UZ44msWepWw25Q4ScOLSxaxV3XXu3C0QR8+H6CySid3MmFbAJDDQj0JDb8PFOocyR7rdRnUjl8l1nQ9caF8USH3dRwgRZ8iulPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aVGx0xpBRnpGOWDES5IhWBRTJSbNCf6aMxzCC66KcQ=;
 b=CjR5voXtR6EZ4kZ0Ap+vesR7pcG0uqkQ3Mo8NuhKKi/KZWPs4WjLjqRFHtohUboXjvdexlp0/PmllypZtK9pqG5xeQ6omRHYG0L0ujN+/8xYOqNHVTLr8zuBs+JPjmhHowRm6t/6wX11Uka78t5kCOUi07iY9GoYSV3exvO5w5nZFIutodq6tRr83Ed91ixU/VTlioODVluR+00rHRkn48Q2dZDTLFdOuHq0eiY38CRw/Er2PcwZhAIQAzohOvEURlxAH/MFToZGalR7deOMqrTZN5Afg0Wmuti0KZQAbTSElAeOfNsQe0yNvmZijNZ4/46xt+M14IF075ZjLkLtPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aVGx0xpBRnpGOWDES5IhWBRTJSbNCf6aMxzCC66KcQ=;
 b=yPaiAu56UnW3TC2SogivEVD3uYjUnt50xyEWDs9bwKxxbeLEr3g2U6ueZA8HO8HIG9c3ovmK5kS+yCotgEKWuwR9GcnTtQCqiwWQZ+i2U4GFNI6TctKxuen7iK365h9RXCeZF1kQWY+HEAlYjjscE66+SRihm5oeDqj3JIpJpD0=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2338.namprd12.prod.outlook.com (2603:10b6:207:4c::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 15:47:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 15:47:08 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Thread-Topic: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Thread-Index: AQHWegTrKFaLvteaIU+zNTDEWFvNM6lKcXK8gAATzoCAAABa0IADCauAgAACVICAABPWsIAABqKAgAAEcBA=
Date: Fri, 28 Aug 2020 15:47:07 +0000
Message-ID: <MN2PR12MB4488BE2F12F85BDBC91E2C0CF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200824105415.21000-1-joro@8bytes.org>
 <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
 <MN2PR12MB4488BF7DDE700378F7B2776CF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828134639.GW3354@suse.de>
 <60067932-dbf4-d67b-cf11-4dd2b016ed63@amd.com>
 <MN2PR12MB448849D3AD019749DB64A146F7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828152943.GY3354@suse.de>
In-Reply-To: <20200828152943.GY3354@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-28T15:46:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=93931deb-4146-404b-be3d-00001bfd64fe;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-28T15:47:05Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 54f88b37-52b4-4ad5-a611-00005bdf3d41
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6761090-790c-489d-5c6f-08d84b699ef0
x-ms-traffictypediagnostic: BL0PR12MB2338:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2338F306CC587472725C0888F7520@BL0PR12MB2338.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tf82lA3pLKv+SqdKElncocGHI9t91n11pNkld+pMg2zZH06rdw6EFP8EcaISmGg92Pg2SAZVuuiwvlZauzesE5Y9gS2KFC61C4/+1c+akVqPf7YT2HjRJgvBfX6ItdkuYJy2suKqqOebBq8O3Hew4ziejyCXxJjlxQcViUz2HaBx4RDCHEer2mqJs6TEj7D0aN064Ey9zIvmky6jSkBoqqCbsb0juyA0RT5YoLOFIQ3ALk0xz2U2T1zuZFxOC0tJrOiNuOFNmnCPVlnGMH+mwEwt9yMPtPTccIRROEt1XteBWjj9nKgclbzE4KlC/iEgRp6ndi6QnyALmMOtE1ZEmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(66446008)(66476007)(66556008)(9686003)(64756008)(76116006)(7696005)(52536014)(2906002)(5660300002)(55016002)(66946007)(86362001)(53546011)(6506007)(33656002)(8936002)(71200400001)(316002)(54906003)(83380400001)(4326008)(6916009)(8676002)(26005)(186003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yCmiobe9fI5znms2J5Qt/zwpkgNxorCrxUiiMPtA83u4/snSUINaf/tyecbeTKcjb3IpiKHTaVttJREtlCI4jFsnKlPD6p3MNgersuJ4Q/DSGF1SnvB4WvWm0L5YHA9NMtd3gguXU5FrzwClQjYmvWQB+AwnJmhIOTa1mlRHvFq09kQC9EsxEBWQiXOWPlt9ENET4U0bTMDhTGRo3uRM0YVhJFDOw1pv116XAUUmB8syocHGgkl6LtIdoDx1sjyHwUalzgvEXGwlqpmqE2uaJ6S0XcUP41q53U411nT+13Z3JYx5vhA9rOVWrAmSKhGn52zQzDhI9sVpzUDcUKBcpbWXUYEG1INs1kmyg+07Jwv583jh2XGQ5RB9LviVV8YSErTrWw/1CsrbBefTM3XaRnIADqfhpxTmrG9HBQRRADWjU0mehw0ysbyPkuDntSQZCLQ7Y9hhrCm3elYhod56guWQUQQVlPDE2es1at2FVLRaD8zn6Mz0sEcrrIIHgYlvy+pbCkR4KG/LuwulzfpEl0st1+UOI/xElygHHI8+nkOOCR75cQgCowQi/5XwAo3J55jkHst9pIIInRpucvEg16R1YGMLSGhtPuDjlKnZYjO9hAyMJFzszvJi/+xKm0UgZZQNF/TUkqGTJkuge64bdA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6761090-790c-489d-5c6f-08d84b699ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 15:47:08.0229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+PXSDamOLfGhqGMJ7q1FWenaI6PKNNzjx9uMQCBZI7levUCFK44MrhKGZmaZFS8xia8lVvK8JEK/YGAoYYEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2338
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Huang,
 Ray" <Ray.Huang@amd.com>
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

[AMD Public Use]

> -----Original Message-----
> From: jroedel@suse.de <jroedel@suse.de>
> Sent: Friday, August 28, 2020 11:30 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Joerg Roedel
> <joro@8bytes.org>; iommu@lists.linux-foundation.org; Huang, Ray
> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
> Lendacky, Thomas <Thomas.Lendacky@amd.com>; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is
> active
> 
> On Fri, Aug 28, 2020 at 03:11:32PM +0000, Deucher, Alexander wrote:
> > There are hw bugs on Raven and probably Carrizo/Stoney where they need
> > 1:1 mapping to avoid bugs in some corner cases with the displays.
> > Other GPUs should be fine.  The VIDs is 0x1002 and the DIDs are 0x15dd
> > and 0x15d8 for raven variants and 0x9870, 0x9874, 0x9875, 0x9876,
> > 0x9877 and 0x98e4 for carrizo and stoney.  As long as we preserve the
> > 1:1 mapping for those asics, we should be fine.
> 
> Okay, Stoney at least has no Zen-based CPU, so no support for memory
> encryption anyway. How about Raven, is it paired with a Zen CPU?

Ah, right,  So CZ and ST are not an issue.  Raven is paired with Zen based CPUs.

Thanks,

Alex
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
