Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96B6CCA480
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 13:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 418AB608F5;
	Fri, 24 Jun 2022 13:16:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 418AB608F5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t5vL10xR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q0ly-bvy5dEE; Fri, 24 Jun 2022 13:16:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 09B9260AFD;
	Fri, 24 Jun 2022 13:16:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 09B9260AFD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B469CC0032;
	Fri, 24 Jun 2022 13:16:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82C7CC002D;
 Fri, 24 Jun 2022 13:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43F5A4254F;
 Fri, 24 Jun 2022 13:16:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43F5A4254F
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=t5vL10xR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uXLXeiW5lbp7; Fri, 24 Jun 2022 13:16:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC9DE417D5
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC9DE417D5;
 Fri, 24 Jun 2022 13:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Afdwoy3Dv8z32Itpg67fkvsaiIqub3Ngmgy6Oq2/TIaBaUedqJmGYlWaqX4w9oBgLNhIT/dVz5OSGpKzLAzCRn3GrWn1SnQR7M41776fK6nPE+/2/qxVMD3+x0u//geYDkNhHdjEsZD31OdFBhqu8er10JvD8DwdGJXHFlu8E6oUIlWgBJsP3duljtaCkxgUfOmvni+SG1OtbDlRTXg02R3GNT6X6idx81oye5uVBYTbC48gvee/3xOe0uNpVMfZoJV9L+2syaLJ6stUBGnUQOLZuJvF7mocWBhn7ka5iGpk4k3CuscbBoN8V8OSeMhB4xqELYZd+/78beF8ArfqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c27UzObqDWTbSWIvOHWgj5Oj+0yv/K/TxsB332yb2Zs=;
 b=JPLF3kA4D6lK/n1O7d3ODBeSQmML+rjH1KPqt4S+4B8QCZCTzsIRZppZq0lyxXujikEUimzsHcLW7pfw78ZnkF6Qeyqo2DL3U1nVdFhvXWFD49DtJkXGIpDoitR51CCxHavLb72Dq0CCfBnA3NUHr7mEvIDRJuAEQsRLtkMLBIICF819V/tEE3z1Efzg/vWsuJ4WWR4V+5++LRv1Jdsetm87KkgcKCPrJmfsx7bBb38cPJtTopHbH3mAyt45ZESO8jloxrdqnOKwyWPDZFlXKT6x7qKslSUcSWWhsrYf+DRAV5/+qkss7voQ18UMFhsNgMtX17E+pyiROkM6sDeozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c27UzObqDWTbSWIvOHWgj5Oj+0yv/K/TxsB332yb2Zs=;
 b=t5vL10xRDTxbNLLFGOkPXFA5me9K5akVhl/b1tLO0re5We8Ek62nSErZFmEo2AaQ/Lvqlj4UnodQChpriBdMDd92sKFAL2qP+9kEt6V7S4XiXCmP3OXKq3OsZrKOr+Uky7Ure9kIOqHPpKaZSzxlLFP1/2shCGLIDcq3PNCFPr34fIUF/1pm3+ZPqsSJGZLR7PJFJBEU1PKRXa7CcneVx4Sj4P65oW8Xg4ApbUYLrCsdot3kHpBVQ5+qeJyHrK15g2PCmS5S82hX+aPP91KV6tnvlFpIqCrE1n/d8qeWNlIq2vfCgnRtoaWA/zDO92sFECmskTNePvLjSZA9M4eshQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 13:16:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 13:16:13 +0000
Date: Fri, 24 Jun 2022 10:16:11 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/5] vfio/iommu_type1: Remove the domain->ops comparison
Message-ID: <20220624131611.GM4147@nvidia.com>
References: <20220616000304.23890-1-nicolinc@nvidia.com>
 <20220616000304.23890-4-nicolinc@nvidia.com>
 <BL1PR11MB52717050DBDE29A81637BBFA8CAC9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YqutYjgtFOTXCF0+@Asurada-Nvidia>
 <6e1280c5-4b22-ebb3-3912-6c72bc169982@arm.com>
Content-Disposition: inline
In-Reply-To: <6e1280c5-4b22-ebb3-3912-6c72bc169982@arm.com>
X-ClientProxiedBy: BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ad22d0a-4b79-42e7-8304-08da55e3b5f8
X-MS-TrafficTypeDiagnostic: BN9PR12MB5367:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/1dZFsXJxd4Cp18TvkRctN3C4qD05Liz20MTClISjopZ7IILLZHHNr5CgWAo/005tbLjLyPWVnBTKi2kscERoNRE7OQwaofVKkuTeoDcpsS9b/iVwqF/iFJqhehWnRvCUvJF2cvx+ipr6RXLcfaLZzgqnUNqOWyLlvmjpDQ54NoNDjPQMPKGysDzrZETMF8uhL6yKg26DioGpuifLN0UnUW8+zKG/XtAM2NL1Dag/mlNvXd4FIJqvg20i3hbVTmkEwgLzS6ck/9M7e16DGxpypoZyf/G59HXu/aH8rKvmZ9huJ77f+UShANia1yLpT2EAHtAiFaTpvJan72YaNJ1WCSQ4GqXuvvdXColIRz++++lun/IbQtJrcakSW5UWvemUtTs8wXu+bbK6xCANVOU2IAmZkYo1hyWg6Bel9qYhJ+NnDN3auWlt0Xo7ZavpyUm3o8oFp/9r+w45XaYuwy8rXZqMNLNf69BWoaivcqaxn9Idsrh/l7j7ZT6L2V15o2vyf3/HJF88B2KELxFrsP6+nwIBrjrH2pOrhZDS3nKrv4tX6i31M4AyDO7cPSNmAkWGWdkP6uVt2IsO0l7h0Wivh0s2nMDfJfKmJ5XBmp3HQwS70I49nGiX0Yl+a3UOVH0HPU2e2a4XdW69kVyrRfpgZx62ni+1tovQ1tBLDbvt0O3QLNzaY6jD8ltj/r9lERtrY3p1qYg/UaQbd9s92LjJ4DztGuNtS1tsp4Dsb9LEk9IBVqF3ga7wCCpM3R4p5w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(186003)(478600001)(6916009)(2616005)(54906003)(7406005)(5660300002)(36756003)(41300700001)(6486002)(8936002)(1076003)(316002)(2906002)(38100700002)(7416002)(6506007)(66556008)(33656002)(86362001)(66946007)(53546011)(4326008)(66476007)(26005)(8676002)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZRc3ZIUi93Vi9wZFZibUEwWHdQUHVuWUlZMlJXVzFUQkFVNENGSzJkN1J5?=
 =?utf-8?B?YjNycksrQk9hdVJFUkNGK3lLa205S3ZCSDg3THpWcXFlYlFRTnp5bGlWd2Uy?=
 =?utf-8?B?bkNkK3F3cUNqczFTTmJjSHAwSmlmZ2UxRnovSGFUZkVmVmEzazhXbGRHQ1pS?=
 =?utf-8?B?ZDM1aFlrbTJ0TFJZSmJXcll6dGljYmlSc29jbVdNdUpkSFhMd09rZGpnVkEw?=
 =?utf-8?B?bTI5MG8vQ0taclM1K2JsSlJDMzdnQzI4TVdVNTNSaXlhVW1IVVJOUXVlMXpV?=
 =?utf-8?B?cDVyempaYjhxMGR3WjFwTTlJMzhNc05GQUlRdTh5NU5CQlhUczlvNHNHazBj?=
 =?utf-8?B?V3krdy84T1NWWjFTZFMzRVo3MmtiN1YySWR5U1poVTN4d0VyUW5ZdXhhNFV0?=
 =?utf-8?B?T0Y1cWxUK0ZhdkFsS0VZcFFYaEJpMUFhc0Q0amRrRkdLTk5qdGxSRFZaM1Qx?=
 =?utf-8?B?VThTRVBmTGg2OVpVb2VFZmF5cWZSaDF6SmhMbThTOEc4N0hralBHZUhJR2pn?=
 =?utf-8?B?a3FJd1lEaHQ4YUpQRnExWnZQaUx4eGNoZXFjbWNZMEFxUWR0bnE2amdOTkRw?=
 =?utf-8?B?ZFFxWDFkak5rMGJUSzlLQ2NCSmJtQnhyOEIxWDVaQW1LU0cvYXVmUi9hb1l0?=
 =?utf-8?B?My9mQ20zTkJYWHhXMm1ZcUdHZmU0RFQ5cnVQNDhxNHlVT3V1WEp0UjREcFFG?=
 =?utf-8?B?REpFcHk2emtrNlczVWVuN3dxbEFsNU5heGVsd2wvTXg3ZHdPcGNiL1ZkdW9D?=
 =?utf-8?B?dVpYUFh5YlVsSTVzK2tZS3ZOa21rRWxnd3F2YlhJbVVmdzc4aWZWWXpGWHBD?=
 =?utf-8?B?VVRnMVFqLzJibUNEU3h0SjNleVUvUFFCbDZqVE83MDNYaWJ2U00xbytDd1Rq?=
 =?utf-8?B?TlFPeGhqTWdoR00rQXh2UTMyeTJrRlhTRmJ3SnRhVUhSR05POGQ3bUFXcW5l?=
 =?utf-8?B?VXJ2a2N2enBrK3ViQjhkbDBnRURXZ0pPQSs1a3A1MThUb2czOEM2VlNwdnBL?=
 =?utf-8?B?ODEzdGZkS3ZYTGFhVVhpSFM2d3p6Q1kyajdOTjM1ZlRydjNHUnpPaFBwQ2V6?=
 =?utf-8?B?ak5PZERuWjdlT0tNN0hVc2RQWUFFZVhTam5RV2lnN0JEd3hWWVU0aENKT3Qr?=
 =?utf-8?B?S0N3OEFUbzRHYWFiaFFjcDVuRlVGMy8xWityWGJ3Z09ZcHRaRnMveEFyRlJs?=
 =?utf-8?B?ZjRoZ29SUlFrL0V6YnRhc2Rxd0twSFMxZiszOEk3MkZjMjgvNUROdVFNZlhs?=
 =?utf-8?B?NDZmUmg5SE5CTTc4eFJQNXQxTDBPRVE0akZIZXRZQ25rNTRkK29adWxDSHl5?=
 =?utf-8?B?U1llTVJNeVFTdFZvVFZaV3JBejA5REdHenUzZVdBT0ZyeTJ1QkJuYXIxanA5?=
 =?utf-8?B?TUtqeC9RSzBNNjVNa0FVUWhnOGQ4MTl4THUyR2ZvRnAwRks2TDN0bDJISmpy?=
 =?utf-8?B?eFkyK0pwMXprKzhhVFBqMkVLZjBDcEhrenh6Y3dRR3hTaWUxRHNzaXRNZXpB?=
 =?utf-8?B?c0lnTWtMODY2cjBNSW1aeGJEWC9jeCtIUjgxOTdabXA5UEZ3U0VrMEpmMUty?=
 =?utf-8?B?S0hWMmNadi90ZzJPMlFGeEZ0QmxJclFwMmI2ZDUrTUE2Vk85aSt2TmE0cWQz?=
 =?utf-8?B?YzNnREc4T3pBNGJ6U0YyNklXM0Z2dC8wa2RwbjFaUTdPcTJNN1VxODkxZkNC?=
 =?utf-8?B?Tmp1MVl6Y2gxaEhTUnBEOTNQU2U4NHMzUTB5MFNWTWU3alZiUzl3OVFObXhv?=
 =?utf-8?B?aTBCQTJkL2Y0WXVOVmpJTzNmQWNMTnpXSW9TY1pHZktUbXE4WG1Eek9YWENU?=
 =?utf-8?B?NGplYTdwdlNZMUdPQjF5alVjVU5iMXVtcDVuNlFlQ1JVUC8zemlQdXU0NHdS?=
 =?utf-8?B?RlVQMHFyWkUwSWNSeCtIYm4xcWNUbTJoRWEwZXdDV1MreWR2QXRreXA3OXlR?=
 =?utf-8?B?eGtSZnVZczVCRmNpV0k3UXphS2luc1pDazJkbFdJQWtBOGo2aFFXLy9lWFYx?=
 =?utf-8?B?aDN1bjF3Z2F1blBadmQ5ZW9VdlF0Y2lreEJBYmVFZWY3N0JSOEhTaXY2MFZ4?=
 =?utf-8?B?SUpsU0JTRFNycHNlN0cybFliWDBPK25kQmNSODh5TTJWUncxbUNGMDlkd0Rw?=
 =?utf-8?Q?gYKiWo+10HdHN3SXMIqFWzl/S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad22d0a-4b79-42e7-8304-08da55e3b5f8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 13:16:12.8996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnHhdaxNeLFI6IWXnhQLhzikTp+6GnxdJLINL7Mm2a8zeBvwXcMZ+vLxZQn7iKFu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
Cc: "cohuck@redhat.com" <cohuck@redhat.com>,
 "jordan@cosmicpenguin.net" <jordan@cosmicpenguin.net>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "will@kernel.org" <will@kernel.org>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "saiprakash.ranjan@codeaurora.org" <saiprakash.ranjan@codeaurora.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "marcan@marcan.st" <marcan@marcan.st>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gV2VkLCBKdW4gMjIsIDIwMjIgYXQgMDg6NTQ6NDVBTSArMDEwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgo+IE9uIDIwMjItMDYtMTYgMjM6MjMsIE5pY29saW4gQ2hlbiB3cm90ZToKPiA+IE9uIFRo
dSwgSnVuIDE2LCAyMDIyIGF0IDA2OjQwOjE0QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOgo+
ID4gCj4gPiA+ID4gVGhlIGRvbWFpbi0+b3BzIHZhbGlkYXRpb24gd2FzIGFkZGVkLCBhcyBhIHBy
ZWNhdXRpb24sIGZvciBtaXhlZC1kcml2ZXIKPiA+ID4gPiBzeXN0ZW1zLiBIb3dldmVyLCBhdCB0
aGlzIG1vbWVudCBvbmx5IG9uZSBpb21tdSBkcml2ZXIgaXMgcG9zc2libGUuIFNvCj4gPiA+ID4g
cmVtb3ZlIGl0Lgo+ID4gPiAKPiA+ID4gSXQncyB0cnVlIG9uIGEgcGh5c2ljYWwgcGxhdGZvcm0u
IEJ1dCBJJ20gbm90IHN1cmUgd2hldGhlciBhIHZpcnR1YWwgcGxhdGZvcm0KPiA+ID4gaXMgYWxs
b3dlZCB0byBpbmNsdWRlIG11bHRpcGxlIGUuZy4gb25lIHZpcnRpby1pb21tdSBhbG9uZ3NpZGUg
YSB2aXJ0dWFsIFZULWQKPiA+ID4gb3IgYSB2aXJ0dWFsIHNtbXUuIEl0IG1pZ2h0IGJlIGNsZWFy
ZXIgdG8gY2xhaW0gdGhhdCAoYXMgUm9iaW4gcG9pbnRlZCBvdXQpCj4gPiA+IHRoZXJlIGlzIHBs
ZW50eSBtb3JlIHNpZ25pZmljYW50IHByb2JsZW1zIHRoYW4gdGhpcyB0byBzb2x2ZSBpbnN0ZWFk
IG9mIHNpbXBseQo+ID4gPiBzYXlpbmcgdGhhdCBvbmx5IG9uZSBpb21tdSBkcml2ZXIgaXMgcG9z
c2libGUgaWYgd2UgZG9uJ3QgaGF2ZSBleHBsaWNpdCBjb2RlCj4gPiA+IHRvIHJlamVjdCBzdWNo
IGNvbmZpZ3VyYXRpb24uIPCfmIoKPiA+IAo+ID4gV2lsbCBlZGl0IHRoaXMgcGFydC4gVGhhbmtz
IQo+IAo+IE9oLCBwaHlzaWNhbCBwbGF0Zm9ybXMgd2l0aCBtaXhlZCBJT01NVXMgZGVmaW5pdGVs
eSBleGlzdCBhbHJlYWR5LiBUaGUgbWFpbgo+IHBvaW50IGlzIHRoYXQgd2hpbGUgYnVzX3NldF9p
b21tdSBzdGlsbCBleGlzdHMsIHRoZSBjb3JlIGNvZGUgZWZmZWN0aXZlbHkKPiAqZG9lcyogcHJl
dmVudCBtdWx0aXBsZSBkcml2ZXJzIGZyb20gcmVnaXN0ZXJpbmcgLSBldmVuIGluIGVtdWxhdGVk
IGNhc2VzCj4gbGlrZSB0aGUgZXhhbXBsZSBhYm92ZSwgdmlydGlvLWlvbW11IGFuZCBWVC1kIHdv
dWxkIGJvdGggdHJ5IHRvCj4gYnVzX3NldF9pb21tdSgmcGNpX2J1c190eXBlKSwgYW5kIG9uZSBv
ZiB0aGVtIHdpbGwgbG9zZS4gVGhlIGFzcGVjdCB3aGljaAo+IG1pZ2h0IHdhcnJhbnQgY2xhcmlm
aWNhdGlvbiBpcyB0aGF0IHRoZXJlJ3Mgbm8gY29tYmluYXRpb24gb2Ygc3VwcG9ydGVkCj4gZHJp
dmVycyB3aGljaCBjbGFpbSBub24tb3ZlcmxhcHBpbmcgYnVzZXMgKmFuZCogY291bGQgYXBwZWFy
IGluIHRoZSBzYW1lCj4gc3lzdGVtIC0gZXZlbiBpZiB5b3UgdHJpZWQgdG8gY29udHJpdmUgc29t
ZXRoaW5nIGJ5IGVtdWxhdGluZywgc2F5LCBWVC1kCj4gKFBDSSkgYWxvbmdzaWRlIHJvY2tjaGlw
LWlvbW11IChwbGF0Zm9ybSksIHlvdSBjb3VsZCBzdGlsbCBvbmx5IGRlc2NyaWJlIG9uZQo+IG9y
IHRoZSBvdGhlciBkdWUgdG8gQUNQSSB2cy4gRGV2aWNldHJlZS4KClJpZ2h0LCBhbmQgdGhhdCBp
cyBzdGlsbCBzb21ldGhpbmcgd2UgbmVlZCB0byBwcm90ZWN0IGFnYWluc3Qgd2l0aAp0aGlzIG9w
cyBjaGVjay4gVkZJTyBpcyBub3QgY2hlY2tpbmcgdGhhdCB0aGUgYnVzJ3MgYXJlIHRoZSBzYW1l
CmJlZm9yZSBhdHRlbXB0aW5nIHRvIHJlLXVzZSBhIGRvbWFpbi4KClNvIGl0IGlzIGFjdHVhbGx5
IGZ1bmN0aW9uYWwgYW5kIGRvZXMgcHJvdGVjdCBhZ2FpbnN0IHN5c3RlbXMgd2l0aAptdWx0aXBs
ZSBpb21tdSBkcml2ZXJzIG9uIGRpZmZlcmVudCBidXNzZXMuCgpKYXNvbgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
