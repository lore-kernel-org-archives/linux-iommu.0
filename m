Return-Path: <SRS0=3mOG=IN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA71C433DB
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 18:04:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C898B64DF0
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 18:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C898B64DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2EC94308C;
	Mon, 15 Mar 2021 18:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OZbZ9k0_Ylt6; Mon, 15 Mar 2021 18:04:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F51342FC8;
	Mon, 15 Mar 2021 18:04:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7E1C000A;
	Mon, 15 Mar 2021 18:04:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9688BC0001
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 18:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83D4945AC9
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 18:04:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c7h9d5UF-a3m for <iommu@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 18:04:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::610])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E36244A33
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 18:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9EngVZHD/oWdq4n81uin0VHanVEvzHHp76+y8eBfAO8uvl25D4L1y8CTDvjpC6iFyVnEQtyFLaQqjqlLhqqM/BfTx951+MbsPsyDtO48EdcoG5PlaEz4/jwRoVbpfmTMX4Cb36kq0b8w5Aoo38qQ+LjGCWvascgebhAPOlgjHqP3kfkGqAa7QOjnOzwxKye8u6UIQhF21N93WgPWnXBR4VC+ySt239cVY61/n9eKEtQ7kvqd9xyjt8jN2f75e/2RR3bzkUNIazgbSPL1Z/RdYBO0gQEC+9I2rSoODwrrrxVakPA2cck8egcdauFKGUCc8+gbgdaBLjnKClDWKLEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk432e0eVrcTkcVmRB0A8zVDm9rkRFPxO+Ek9mGnBfI=;
 b=fcMaHBc0k6XOrdojIvU/rUN76t1ehuMfGRvOZZKSPdUaSv28d7YNdqjN1yEd+RngzveostApZ0s99719vsnUTlfSZZ5i7NL31XyFQdcrUihlrGeWSqn+z5vYqB2V6NrQOskoe00CMTS1k6WKUSILyBEPSMhnpxL3pULkgn3a27OtpwnZmvQgB0bhbE2DasyUBkAVMZ8b7DfDq2HPz/CkgnGAyhiRZDvvfksKr46nz3ROuo8atixYCSwqaaL+TUKC4WZWXxH8uUx57kIDBY6uJk23QJ2mnamACCpmBm34lggSmnzY5j6rfh/caTTPzTgHGcXcbWV7jz7dU1ZjkWrq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk432e0eVrcTkcVmRB0A8zVDm9rkRFPxO+Ek9mGnBfI=;
 b=gluEtLD1WiBA2Qh+1oRlzv/KO9IYjW8lH2aJsw081DsIOVDkALizD4BNQsDQCesJ4CN6LJyg67j/Yd7GmhK/6x6QQMNb26RnlTEAZE0txVtQoTlwKQmlLAvyWNuJmvWtM3bDEcLDUr0pAPEZAJ/Z1nUdZVVZg+4/YOU+8Y7SKTkKYFuVXxHT85HKYs9sfXAyYcYiVhefxs74/0gBv62QGIFTMazilP44Ovxk6tNOoiqmiYWQ4s931H2jMzY7WZ9zvBQVffsGsWKBWgXM1jToZTj62REqGULyuZDR6Q/fdzePcoREalIuh52ptKDx/jnPyvIEDj4CqPg38qXWJMWKVg==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 18:04:14 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 18:04:14 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "maz@kernel.org" <maz@kernel.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v11 00/13] SMMUv3 Nested Stage Setup (VFIO part)
Thread-Topic: [PATCH v11 00/13] SMMUv3 Nested Stage Setup (VFIO part)
Thread-Index: AQHWvAfSVyYv+7sBoUuZEwC6Fk8r16qGEJYg
Date: Mon, 15 Mar 2021 18:04:14 +0000
Message-ID: <BY5PR12MB3764F977D65938544A1138BDB36C9@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20201116110030.32335-1-eric.auger@redhat.com>
In-Reply-To: <20201116110030.32335-1-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a94ea98b-8e9c-41be-0dc2-08d8e7dcbe54
x-ms-traffictypediagnostic: BY5PR12MB4180:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4180C6E641B9FF96A2ABEF19B36C9@BY5PR12MB4180.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MWMgRZX2COLBj1X39tBSMxyAGZgBVXArOxRD4W5J6H/sT7Gowk0/g3h3bi5wWTYwBF/NWGRo9AlSwybi8qrxzafsQwWTaLS1vVnqguzdmFBijkulR15xQBzVtfa/AaQQ6vPNpMw+ZT0XpI0XG7s63pldLiaFw7epEpK2mjZFY4ZFYr41ldONUoSYuQg1nI/F1myVzMN/DFJde1k23ceJbDqgd5jkKA0aAeMTlt1FpQXsH5JgPmO1FWNS8bAg2GaUnb58LAZZbSs6hMQeNg1tv6X4RStxJ2tljicRLSDtF6yR6rZjpCb/uycfB3aRh8TMd5zhcubFDoFbDC1wd20J8QpzPcFH5R5RLCeonT7jdQkh8Nwpou02RTJO1d1ePZhmDjS8jX1XeAPN+qmwIJSgqppByM1oYORl4HXm/0JxVtUEbxU7Ee0OwR6+wl5ZHtBfKoD4UTnz2ly5YgCHRlkgfpOU0zdgv+KvEBFj1Jiem7X2HtR+l6zmIomTsskwAFJBCCEfe3djKX/+9bYtUi4kBJV1kPH1y1wKFguXtv8iJxPQ8pFF6QJszyHyF7GnLIiRsmtP7tP/nFWGTpYiK4kJ9a3TAjoYdYLQBpmnu+NNCWk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(8676002)(66556008)(66946007)(54906003)(66476007)(66446008)(52536014)(107886003)(478600001)(64756008)(4326008)(110136005)(7696005)(5660300002)(71200400001)(921005)(7416002)(316002)(186003)(76116006)(26005)(2906002)(33656002)(9686003)(55016002)(8936002)(86362001)(6506007)(4744005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FuWHIHYTgHwGQvj+d5BBkR+mauuTyaeymqHfg2fToBGWIIlPgK/N8lP3VLYw?=
 =?us-ascii?Q?KlNXyPZ7NEV0tliuQvODMzt/H0UUWiIIOaLdaGaYEk7Lg4QsZtIZHLQjtAiy?=
 =?us-ascii?Q?8t8QOLy9lz/9hw48zfEgUbcpYfG+vwKVSSHnuKoq0/d3yrLkErTHR88do4Yd?=
 =?us-ascii?Q?PCFKBZ2BD+85P2h/RbSZU13mKet9TvEpQ5MFLAmtzzjqSo05gHB/w0DgF7CG?=
 =?us-ascii?Q?OhBuFOtnSMaDAhw0R1P3KZ3q0XNyWEQCR4gu/d4yUvBYN6KDVCMgUnjrCNgS?=
 =?us-ascii?Q?/k1LYoT168oWZzeyG2WudaLUS8+AR+84SPG/+dVyH6Wr0W9C/fRMiqtlNeL2?=
 =?us-ascii?Q?RCMKJFSeoVbL+1X+apkX+rWrEOPj/Bp+ZogRbqXUSGCZkAauW/I/w3mB4UJ6?=
 =?us-ascii?Q?Epd70V74h22uHuUzc/hO7RJ/66DuLKy8WWRkM376rbWCtZ4Weon4ecNbMMJP?=
 =?us-ascii?Q?dPdS5/n3qYW02jJ4cLe5L1R4suW3GKesuHoQMIsqTebuigYpamqxyKutEWFz?=
 =?us-ascii?Q?EneRYzvp9aOGL9m0z3O5Py8IpHuV0NsI0P9AgPK3e9mEn3QmBzm4p1xho35z?=
 =?us-ascii?Q?ArHLFbR1FkV9H3StJiLbbC/YcAatMP37CKf7FfKvGFTje/qae9M2zqtDE3fT?=
 =?us-ascii?Q?dp26JIfTzR+CdgNc5sh43OOvCgfpukmq39C2Vlp7l2RIwi8NwCZ2D9WWIcZN?=
 =?us-ascii?Q?Hn7NtUXbGEc2LHMMF79id/AK2DVyNZEfHMxsg+OEtPV9yHmbfZn0Js1Dd4oe?=
 =?us-ascii?Q?ANFuCmQbmEzzS+9E9SeJGaWnJe0TaCFS/2+QITpwFOTjNeEEAJh2EI/+pwU5?=
 =?us-ascii?Q?s7QUGkeyvLb47hYiJb+myTcM7FOW3uuNuBIBdep0qqMuSMSjmQzTJKPTgz+i?=
 =?us-ascii?Q?LQhcMGM+pu6021IqppSEnlC0xhZtRKs/bHSPZQ+gV8rm4fPqAXh+zhghZsao?=
 =?us-ascii?Q?Hms689D4VhvDaplsJcB/o0fpOhB/Pl/L8ddO+Z+bdRrpZ+A7l9aQoRQEIMQg?=
 =?us-ascii?Q?YUMdpKfui5DYD4X/fUMDxD6pAsAzAFA2o0VXSmdCA0SW+5FLWJD2G/xi9Wsp?=
 =?us-ascii?Q?XPOu0lq2x8pzmvWtorrYn8XGgtLJWSBLvEoijaI+6ZFZ/+mFcMuL0wvs8vFF?=
 =?us-ascii?Q?RZqc2yOXtblD0mQ39LXdjqM/LrDXMBopc8l9P4arcTu9Q8dDUogXRwbtz073?=
 =?us-ascii?Q?W8zTVVjbhe2vtDXbJKTRPg2okF+mGCjBcWwEUuMxkXUgifnqZMZI2kh5F4aH?=
 =?us-ascii?Q?iv6v6PoSfk+Mg2lAi9/qUlp6lQOQfK4xNQvX2uTOMWin+LrWiNVbk3wFaGjQ?=
 =?us-ascii?Q?j4AYkkt8d5RQP4Scx5gjLsWC?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94ea98b-8e9c-41be-0dc2-08d8e7dcbe54
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 18:04:14.4336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tgIfAW7hhMF0eZ60R+cpc/4sIBd1vFOEkq89jsskP1uXGJYtWelBO7PJDBYo0BjXUnUUo0sKFQUE/M3gbFDFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Bryan Huntsman <bhuntsman@nvidia.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 Sachin Nikam <Snikam@nvidia.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
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

Tested-by: Krishna Reddy <vdumpa@nvidia.com>

> 1) pass the guest stage 1 configuration
> 3) invalidate stage 1 related caches

Validated Nested SMMUv3 translations for NVMe PCIe device from Guest VM along with patch series "v13 SMMUv3 Nested Stage Setup (IOMMU part)" and QEMU patch series "vSMMUv3/pSMMUv3 2 stage VFIO integration" from v5.2.0-2stage-rfcv8. 
NVMe PCIe device is functional with 2-stage translations and no issues observed.

-KR

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
