Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E8BC433E0
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 19:23:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A1520760
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 19:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Av78oiyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A1520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3339F895E8;
	Wed,  1 Jul 2020 19:23:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HNSG7VTaLchG; Wed,  1 Jul 2020 19:22:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C707E8930D;
	Wed,  1 Jul 2020 19:22:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABE72C0890;
	Wed,  1 Jul 2020 19:22:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8882BC0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 733A98B119
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:22:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bJtojdir3WAa for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 19:22:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 040938B113
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:22:56 +0000 (UTC)
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efce28e0000>; Thu, 02 Jul 2020 03:22:54 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
 by hkpgpgate101.nvidia.com (PGP Universal service);
 Wed, 01 Jul 2020 12:22:54 -0700
X-PGP-Universal: processed;
 by hkpgpgate101.nvidia.com on Wed, 01 Jul 2020 12:22:54 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 19:22:50 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 1 Jul 2020 19:22:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FejRiXDR+KUKR45cUVNlCHjj/gnrF1TU+6Z3WbepCWM63HhBit65on+ECH91mzTIsSXHH83mpbRkAQcaVtI9o0ZnIb7gmsnGNSkP9CN/h2KUzOCtAvc8Jcff2lTEpW3rwINJlKxyjCgeP5y4fnGNIrzRup+I5/ZrLqsAAcZUyj5iLGSaWEcOFKHAIoJG5MgHBLvD+UOzXtxNIWcdcDm7hmimV9DF75UGhF3qWyMP2b7NNLBEbsmuYK4zvuzvmPKrdc/M3CvkOpoiBjmj5EA+bmw3MSWNn2z2Rf5olLYTGNEq/1IoaSjY3RgHnTVfrEZ63CP1wi6JY7IWJFJsYLz7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npiE+DZxGztABdxQds5tfE47KtXBU3Exj1JwJcB4ex0=;
 b=GVU4Q9mlzBx+nCuZ9nszEmQWSrr1axgDWCPPgAwLrafC46WCZDHlD2s4DCVmGmOIWJLXzIuNQVIDXM1aqF0eQ0d6FYrvipZQ9Vsbexk3lQUMD3NjC3F1hWFxJOKaoqteyxIXwuUiXo+/QbMmsLSA6W3EUXKKpQ0/IOwzb5J6kz/Y4IDTg6iTsgVC7Zk8/+9JNZeTAw6xC8EM+sCrvi8bBmajJqsIuICSZ2xUMVvEHaeJHWmVRZmrUHZljsXJUFYaZgsBu5uBdeeFoIN6U8+iTj23RiyrwC4u/BAGyKOdZT+cnO0X3pnnCeSPdR/bLNC3YCWzF1zR7ozlYHdOB0t//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB3064.namprd12.prod.outlook.com (2603:10b6:a03:da::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 1 Jul
 2020 19:22:47 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 19:22:47 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
Thread-Topic: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
Thread-Index: AQHWTnL3VCCI3Y3jhE+XVIWcwjPCvKjw1msAgAA8hACAAf2WwIAACi0AgAAAusA=
Date: Wed, 1 Jul 2020 19:22:46 +0000
Message-ID: <BYAPR12MB2822911461ABAAC205E76DE7B36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-4-vdumpa@nvidia.com>
 <4b4b20af-7baa-0987-e40d-af74235153f6@nvidia.com>
 <6c2ce909-c71b-351f-79f5-b1a4b4c0e4ac@arm.com>
 <BYAPR12MB282244D2B008E1C8CA57916BB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <446ffe79-3a44-5d41-459f-b698a1cc361b@arm.com>
In-Reply-To: <446ffe79-3a44-5d41-459f-b698a1cc361b@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-01T19:22:39.5041949Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=9b388edc-4a0f-4f83-aa33-c45582982b13;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4b421c2-523e-4f49-3fbc-08d81df42328
x-ms-traffictypediagnostic: BYAPR12MB3064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3064668DA837A27C6B138834B36C0@BYAPR12MB3064.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNmG4wMUiZiqhDMzoE9vz/D04d7tvmvCMqmWCTiaJcMMrIN3LltNIB4l4nWbx1QSzdSbGmaZA8yJkDDLaTMGXF/HJuMKsUnyveGKVKXz+loqyzI5q8tqxUTj2a2TQQiazgVo1BVOsSxw+wY42Ni3uKjQ5VMVh49J44bEYRsWOZsl2tpcjCxoW8+5ArPLBuxCvkzaab9mN+axLq0C89EzTEJD1G4etlGDdSPNlFkMK5u9SFZj6J+t8hn51OS0MNgeXSbo8NH0CZvJeAzmnol5qIOnEqtZRdB6gqCM0mw8OuXvEAJSjQF5qc9K8asoWzFheVpzyNXIgVhOnoUrj9mroQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2822.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(5660300002)(7696005)(6636002)(4326008)(8936002)(55016002)(316002)(76116006)(54906003)(107886003)(33656002)(478600001)(8676002)(83380400001)(66476007)(64756008)(2906002)(66556008)(66446008)(26005)(71200400001)(186003)(9686003)(66946007)(6506007)(4744005)(86362001)(52536014)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: MhcqX2A2fruUQ3cbHffHzQSrzmTc6mDVICp5qm6qYf/WPcSLq/7oR5ZMGch57X+Ij+4vdlO9O792GmHevtaMLFZnUeqGXGkCMgyJ5bPdTCl+W8+t4prxBDHrPXuBL45OhNPP7CJTYhJOG0M2uB7Gk1gnlHYMENvY44PcN3F3RBOAc5AZjwIBHWJDdjQi+acVhUV9TcdfADg1xQdmKR8VtBy5+GrcJvx39XEFi9GAdLVwjaKgQJ2yPxRnQNvs8+Y0tBN2lKROgtBxwVvuB42Xh0RsNT7vqOYKCmkoItrtqs2lWZ3eX+Wngj42mzX89uBGKD/2nYewrSiRzOwC5XsWlFjOPBQnmeiQgu1FbDILbN9OrDcTLpwNsG/BcOgdUapm95dGN6fU81eXgt/zsn9KTyPsbTFLQfF0YAz+15EQtLpfts7SEnXTBtcDSa0Xl7octdIUbhhtyhzGJ9V9TCjuGYGA2tVjj6NU2OebzsVaiTWtFh11XAPbb17U0tLY4k5+
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b421c2-523e-4f49-3fbc-08d81df42328
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 19:22:46.9752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2INbIGyKny2bPhIWseKU9U0oBKPy60xQa1wHQWKdnMHh0r7uFavmYu09UJvLK8J2bWJCu7WSSTodDZndv2JCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3064
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593631374; bh=npiE+DZxGztABdxQds5tfE47KtXBU3Exj1JwJcB4ex0=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
 authentication-results:x-originating-ip:x-ms-publictraffictype:
 x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
 x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
 x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
 Content-Language:Content-Type:Content-Transfer-Encoding;
 b=Av78oiyw2h0d8Ftv6lnaG5kXX873St/dW2C03y0UrzPZYr5WH+H0znCbwJBkOxvnm
 t4NCJiRQiBSWmSVwYbLoXogVDtcqHO1Kxlv2in22EgIqIjeIUA16c8kJDko0mOUX6o
 C3z9T+MiCrB6Et4AYd5tez6qRZOptqEFj7vipY4EXn6gR+J8//hkvYwGjvBXh7zMcC
 N6KxBAGeHdQ/hCXdMMm++BqnwaycFoFQ0uKO2HcJww49TOGRkN2Va9HtKGQJFSoRfm
 x4UIaNtpo2ROfcL6rgUvwBVsGTqFCNGXrMVDK5sdc6ey8b+SfSWF+aRzQnYBBbTezG
 NR1aHPuxmESRA==
Cc: Timo Alho <talho@nvidia.com>, Thierry Reding <treding@nvidia.com>, Bryan
 Huntsman <bhuntsman@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 Sachin Nikam <Snikam@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Yu-Huan Hsu <YHsu@nvidia.com>, Pritesh
 Raithatha <praithatha@nvidia.com>, "will@kernel.org" <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Bitan Biswas <bbiswas@nvidia.com>
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

>> With shared irq line, the context fault identification is not optimal already.  Reading all the context banks all the time can be additional mmio read overhead. But, it may not hurt the real use cases as these happen only when there are bugs.

>Right, I did ponder the idea of a whole programmatic "request_context_irq" hook that would allow registering the handler for both interrupts with the appropriate context bank and instance data, but since all interrupts are currently unexpected it seems somewhat hard to justify the extra complexity. Obviously we can revisit this in future if you want to start actually doing something with faults like the qcom GPU folks do.

Thanks, I would just avoid making changes to interrupt handlers till it is really necessary in future. The current code would just be simple and functional with more interrupts when there are multiple faults.

-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
