Return-Path: <SRS0=3mOG=IN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D89CC433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 18:04:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D92664F10
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 18:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D92664F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68FF5605FA;
	Mon, 15 Mar 2021 18:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j4erHiDDJcfv; Mon, 15 Mar 2021 18:04:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 560DE605AA;
	Mon, 15 Mar 2021 18:04:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30967C000A;
	Mon, 15 Mar 2021 18:04:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D464C0001
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 18:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF3E6448AC
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 18:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0zzdZE1nRDKi for <iommu@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 18:04:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::619])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84F81446CF
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 18:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0jyWwJ8VgIwE7/SB2iW3QzRJ/o9YlB2pm4J18v+ikdORo3NiQeGNdxecWm57ixqnBlL63lc5Z9qS1tTUiv8Pol8Tz2VAzfWKKsWY8CmaMIuSaqf5QXL7InbnT+VrQEkTXd2zFPC0Hv+kvtvfkUVA1ZL6Qu3vRl8uW2E1axeOHmVZ2g/GzcEDfwGd7VZKkQ2y/QLgh6hYjiJk6HIlXEkRvoBDnp0gShjaNSjxE6H1gMVp/07tefpaipalamj7I+WW49y6XZDAKEI0CtgGU1JSCXqWfI1PzzyWAGj2437i32eRiGQe6M+tzexU8hy+PsmFTpDCF5kn600/c9uU1qdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVEElJG1J4r9cuz7+rcfvwejBkfvU/lOO7RpWSsj8Wk=;
 b=fOuzdUhWH6XWsqDL3YK3xj6qmg0DUE0xZz7PSMkHH0FBo77YHfr5p6aklziEpFoHf4bzLoXZoSzi/Ilq/bDJSxa98sUy7FjcDhMPzz/oe4w4MrZVJPpvvBhFMNZNHdP5kCT7xzVzL/D5hlD2pJyNaewhl/KZwC6tqxhwO3tJvListty3Vre5d+rjLx6jDyoIglm2W3q+jLBbN17aLD0XtybiS4FBwGovn+GsUhUoFveo95Uthlxk1VkaAaNuvudSBP3ec6iMgsSTB9/pao0sF9e1UC+v61Kre9zIadqbj1x8JJfUfrK1TGFanKbM5KeMryDGMwashRA1pDW8A8FWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVEElJG1J4r9cuz7+rcfvwejBkfvU/lOO7RpWSsj8Wk=;
 b=p+t7axkWVUbRE1aOzAHctWVZE/qB+1h/7OpylJoIW8cuOcLY5EgHXkTe0X36h+M4ry1Bn7dLlysmNtJBABFpj5Uztz8TDMw6vtq7N4OZ6W/t7w5cfztqQgpDYFsYY+60NKodZNOxn9ywZc5qb1Xq8Tx4c43PdN0s5h5kZhg/n8yPVoQH7yNHqt1mY5X8x5lGelNfnt6GXDf+VGos8Q4eHQqdJ7zLBId9FGsEfJPpRJ1mptOPu3Lf7+5OMSVlZ+Gg61bU9A9diWlM03zHn7k/69m6Gv7ENT+YdTsuQ5mFvGyldZnPBEXQnsjFfzFswKTHUQ1kngKE6vMFG6rNI9B2Bg==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 18:04:04 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 18:04:04 +0000
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
Subject: RE: [PATCH v13 00/15] SMMUv3 Nested Stage Setup (IOMMU part)
Thread-Topic: [PATCH v13 00/15] SMMUv3 Nested Stage Setup (IOMMU part)
Thread-Index: AQHWvZ0by+yuuitxUU+rB5qiY4c55qqGB4zA
Date: Mon, 15 Mar 2021 18:04:04 +0000
Message-ID: <BY5PR12MB3764285E7E8064B636132C65B36C9@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20201118112151.25412-1-eric.auger@redhat.com>
In-Reply-To: <20201118112151.25412-1-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f220884-90d2-439b-494b-08d8e7dcb857
x-ms-traffictypediagnostic: BY5PR12MB4180:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB418095EEF049C7EBACE7146DB36C9@BY5PR12MB4180.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8HXE5wNjvm+3k1GAheB/xiciEeJGK2ennoYFSRTdpIqCa2MV4PrWUcs1PM7j8nEldWCgaB3SWzM4OUznH8vQLWI/we38fhTfDomWZloEi9JCKkvGhQF6ft+n3r0MjEnGbUgMcSnZ/L4/D1mFy+UmyX13m2Ee+mIVlheRVY4Myc81metjP//ALqhfPkQ+QjnBSVnBy5APaW0wxWh7uVwiXkv7U5tHKYNMMtdowb5FEiMv+84obEwG9kS9uY21YaTUYiYtv62JvI4ZJiwMHsdJ5eJXwHl2uSghl7Coz+Tkj7H6T46wks22Oh2U8NqJaIqWIrLfyOYgHxDuUDbM2Phq+L51FrwIjsYVoGRgDgexijk9ttRQ2EId9Lp7cGPI5zt5h6c6M20n9U8PSfOeqOQzBSfp9CWrg0zCafmZzV8jxoXnYOSiOxakeGtEozKEbg2i7PGUkqxUzSecoVe9QtR0SJ1MtzA5T/+nKWuDrSqmm+N7S9N4XEjjWsYBTDlxb/k/fmxY+Lt2nVL7nyu/18t/xvf9XB4VKYXEy1iRFHYdhO3p+x7yCnRvFrB2G9njUGdonFUf7VssDt/zbecm3gtGeRHFnXyLGdPf/BB18hfVNOw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(8676002)(66556008)(66946007)(54906003)(66476007)(66446008)(52536014)(107886003)(478600001)(64756008)(4326008)(110136005)(7696005)(5660300002)(71200400001)(921005)(7416002)(316002)(186003)(76116006)(26005)(2906002)(33656002)(9686003)(55016002)(8936002)(86362001)(6506007)(4744005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PI98jIEfcW1vthrLywEF1Y20CtDExqGWfyK6L+XjgYJjCI3T3gUrb9ltAoWV?=
 =?us-ascii?Q?+56TQhmVlpIEI8K4OA++Xf83xa9NPGcgrDdKehLy54IbBHRIfcNt6nvxZRlp?=
 =?us-ascii?Q?cEsYPS0nzNdSRAGG+pW4wi/XMutw7L4jPYTr5YdPjB4AyoNrkjEMFu5b8Ffj?=
 =?us-ascii?Q?IWQTZWC3iHaxnqIYvIYeGQa/OTPp+Oc8aBb0Ay9oGTROi24DZKRqiqXJKM16?=
 =?us-ascii?Q?7znr1s1tunxhfs0CoFgb2x73O7KaVB6IDor4I/KV1WuU44Q0z9kQYWeQJDHi?=
 =?us-ascii?Q?mfehpbJPMkIZi0es57O3iBJOKf3l2f297gjI4l6bvfJkEmVkWYRvcU5oMHpq?=
 =?us-ascii?Q?I5XPzP46o52zKBVICNz1FpcaMuSWYn/joO3qiL3lVT+m4uL1Oc2/S9ex7/D+?=
 =?us-ascii?Q?QbkTL6Jga4Tp6imVm7nULqZBjvrxDhFWVteSdbQU2IVyhP/udIbou9XExIlX?=
 =?us-ascii?Q?cYunvT+A3Sw53GSLLpb7kNI5i4RSzbQBeqgI8rTrLPJ/L9iuxEyjD342pl/K?=
 =?us-ascii?Q?dIHigAuAAcKQDQT3gfrfp4bB3uhuXzyclw1ARkn39f4AMKFRSRA30XbPsS3H?=
 =?us-ascii?Q?WOuVwCJffIfGr/gWrOaWnjxSdPNO1p/m6ExIGl4GOCqjEkpQRrNXkJjU63IW?=
 =?us-ascii?Q?2RpCy+2Vls/m7w92FjFapwIe1eld3nV2604WgpZZUJIkuNE2s1GI0LHXVIOi?=
 =?us-ascii?Q?ZJHuind6OaJlctKCaozfC06TNSWH1X8ThRsAicouk3C5JafDg5mn9KqJIW4t?=
 =?us-ascii?Q?YFpVgTDHio9ZuYi0me1kge94SrEGxTxUSYobfrjGrE1HHO7VtN54AwoosGUQ?=
 =?us-ascii?Q?x3njjIlEP6lD6XnSMAZIqnfQtqNaO20jPXiHVJM5zJVlUKs020ArLTY1h0ER?=
 =?us-ascii?Q?CKsW02VGsDT84d6aZ2Faj6zRFYQ5QAa9LvQIOratqFzYWAxC3LTpg6hErtV4?=
 =?us-ascii?Q?CPOQoBAOVQfxCHQn4RlJnl1pb8M7NmP06e5kend6BWzuqGttznyOGayfwvSl?=
 =?us-ascii?Q?EYr0saIFfEn9kB0uYA6EVZMb1BAWzBCuhkhTqK4PmS/5CjwYAtRF8k+KKjZC?=
 =?us-ascii?Q?K4Eff+Qku42txFbrA7kiGqneGQdQ/5a+VDIYb0vwkfOMzwk4XJPNthTKNDMa?=
 =?us-ascii?Q?JjlWrOjRxoXSdIVXRzAY9bwKqR1LQhCazmBfg2Fs/HUQKJsEptR5ldWLh+di?=
 =?us-ascii?Q?q9TmzAqHEIolGB5llP8RhkzpvyqvthN8pKtaf2RKCTkaR1QE350Y1gtKOkuC?=
 =?us-ascii?Q?pGj5lkSnkrhXd02c0nlOixudBxMUkjVW31TipFpykbNHdRQi6Vg/nmHIpOOd?=
 =?us-ascii?Q?1AeTUjA1EPyN7NW1coFVEW91?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f220884-90d2-439b-494b-08d8e7dcb857
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 18:04:04.3994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uwA0oGaTaKy5R93JBlOcS5uosMten7U3jfMfX1b+a9nN4eltmjGOfL4d02AEPFVU8HGvLvZkt/JOriBnUhsqg==
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

Validated Nested SMMUv3 translations for NVMe PCIe device from Guest VM along with patch series "v11 SMMUv3 Nested Stage Setup (VFIO part)" and QEMU patch series "vSMMUv3/pSMMUv3 2 stage VFIO integration" from v5.2.0-2stage-rfcv8. 
NVMe PCIe device is functional with 2-stage translations and no issues observed.

-KR

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
