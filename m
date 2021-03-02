Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02103C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 12:58:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA0464F5D
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 12:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA0464F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 010CC83F75;
	Tue,  2 Mar 2021 12:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MNrwdL81TxPq; Tue,  2 Mar 2021 12:58:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE0A983F71;
	Tue,  2 Mar 2021 12:58:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C9C0C000A;
	Tue,  2 Mar 2021 12:58:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68F5AC0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56DC943118
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KaV2FxVjzEi0 for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 12:58:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1153B430A5
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:58:10 +0000 (UTC)
IronPort-SDR: WxElojMh7HvauQtX2slpoVXIjxOjgDcEVn7GLVV0YNu7nj4ne07ONlepDl+kRVNjbDGtyiiMOk
 h3a0TtjZAEfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="250845613"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="250845613"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 04:58:10 -0800
IronPort-SDR: aOyLQOs8PqzZNmM4QLuBHkfOufrNwnFdmRSPX6RR02p2hQSmVAoRPQIzrUSO9H2zQLhL2Cv6Pt
 YPFarVhybB+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="406695825"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga008.jf.intel.com with ESMTP; 02 Mar 2021 04:58:09 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Mar 2021 04:58:09 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Mar 2021 04:58:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 2 Mar 2021 04:58:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 2 Mar 2021 04:58:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKyb94Y2vgU0vkTRYOp8H498fvRbMYvSEJ9WMOOAjCWRTAmm4jPSku2t8xzBQrWiVZ/8ey++88RlRLcznk3fAXJgiC9WJY1NALkJGqK7JRG5h7Ep03LqJ8f3AWbhqXGpsqiMCE72ncQIEcCnXCdrYpBtY6POkxGpuUTzRyj/rYbQaIMDowVPnhz4wuzVt8RKNsEmzypFFon/bhaIb5cCSWE+TIibahLbPolyrQw8KaeBXkpAsT0HNk3PM8/exI9WJFgg1Ych9shGQIpiCfWSEhW6fFhZORSFOTt4axjGqDgWI0kKIAZlve8jnRXSULkJuOddjeLrzSXQG1WefzT7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EABkFu3+j2V5WDiRXC0f/ppojwIHN02YS+GxyGKV6cA=;
 b=Ue4xGDbZbE5KIBsf+orOmBRwNAj8ewCxvl0ciJnyP60FPU4gAct9DcY4lcIXz63Ba633AaiTfuYODzSuzkifpGlhG5YlW3OvsqG5K9UHJIyYX+oLC27Kr0bSQus2ZHbkGP1N66bsWxHUth3TeNPon8vPHC28C/nH5L5HphVxJePkPfGSDiYRJzw+2rqzffIs3lSe6TM+yBsP7G929tWiyb7cxbt5PWsRYfvdEURUnuH/RqQZw9RXPjJRjR6DkEYUG1DjeohCeDWjV7KKQ9WkG+MpwI1jgpy6/H/SIOxHk6B/w67qt0PiibpdZWsPw+shOg5/7/2Ql9vKaVeTHOTfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EABkFu3+j2V5WDiRXC0f/ppojwIHN02YS+GxyGKV6cA=;
 b=g4PqHbpWP7IXc99b0R9W0Z1WhQHIi2+YAUkgcVUkGtCFzKClYU3fxEUCHYpSw24P1EGD338fqVmBQZW9gUpMoYZCPc+PwQ87ERBUUUsAy5dZjug0917o9Fi2xl/fpEL/OZ7Z72jLjTgDR2h1aQpoWuJdmfVKZdYnOnbTuwoJomQ=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN8PR11MB3601.namprd11.prod.outlook.com (2603:10b6:408:84::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 12:58:06 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3912.017; Tue, 2 Mar 2021
 12:58:05 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, Tejun Heo
 <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: RE: [PATCH V4 00/18] IOASID extensions for guest SVA
Thread-Topic: [PATCH V4 00/18] IOASID extensions for guest SVA
Thread-Index: AQHXDZuqHEV3IilLX0uOrgGtapPnEKpwq4EQ
Date: Tue, 2 Mar 2021 12:58:05 +0000
Message-ID: <BN6PR11MB406867D75E42A34F8C2555E5C3999@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d344a3b6-3f87-4487-a6c7-08d8dd7ad227
x-ms-traffictypediagnostic: BN8PR11MB3601:
x-ms-exchange-minimumurldomainage: github.com#4893
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB3601DF935CE15B8834C4F18FC3999@BN8PR11MB3601.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKdSGsMQKoz7MbihRXE5gg+aipHLNTDzzKMHZPf76v9YNGNxLai1s0ggxIQE2snCBNrXDor+G2+DNv0cnRcAo4TAnYAkxorYsDEmRbQubjUYDDVtinHfOQC9fBznPXf9wMFsTDTB1wvfTePMlJymJoVicZosf1nDJNtTP+PQLtBScbeevEeiBENmXEOo7wOYe3rZEEYbLIXPjFNSHIyd1QG3fP9pp+aE9KNnMMX2TRTr4BZhLum2M8oZZo7KmUgWZlvBPFsI/FfcZSmzICuUIN2bIZHDKTtXhFaT7n+qmI7OrtdHm8dVPw65eiTx4bxDSvPAMZuMuMD4yYOAr5k19LYNNu7MNKp8QBQ5l8LJ5PZ3+TcdfdnDi/6xuMTO+hNADY9Tx02UrkOWr4lrEyR0GdOePbgh+XerDb0nm84lbNh4D6DwwMxVHbTxPOFR3jQmUfImg35lLypN9MCDaNkKcsRzOiQtRCH4mZ+5imG5Z5PxH9nyp+0qeJQ+jQ1TlulMqgTNU21o6KEI6Bo4JkCV0PUvlIjXHlsr9C0vATbdi48KNKTW1CUmFGWqc6sPjjDvBphk6Tu8JqmHv9rbstebNwh8Y06ZF1BLT4WthgUh5xjKU7KtVGT7rYlLnhclF40j8JtxRZmGRdKKtV82RzDl+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR11MB4068.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(346002)(136003)(396003)(366004)(376002)(7696005)(83380400001)(921005)(8936002)(5660300002)(86362001)(66946007)(6506007)(66446008)(66476007)(66556008)(64756008)(52536014)(33656002)(966005)(110136005)(186003)(71200400001)(26005)(4326008)(316002)(478600001)(54906003)(2906002)(8676002)(76116006)(9686003)(55016002)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?YVMrWVAzd3ZpNC9QRGtQOXdSVHJKTmlHWHoxV25uZnB1aExrVFJmM0JEUm8r?=
 =?utf-8?B?ZDlUUmJ0dWM1QmVtVnJXSWR5SjJ4MlhIRDBZNkwyQVY3K1ZlbHhRazcxWEYr?=
 =?utf-8?B?TWR5UlBCcWthR1hUOStiKzNaL0tuSUV5THhIbTdDK3J1TkdvcEF1dTJmSXQ2?=
 =?utf-8?B?R2hPRHk1NUwySWZxMXY2WXVQbDhNQWpkWTYwQUE0YW4ycEVqd3VtTkZqSXhn?=
 =?utf-8?B?VXF4N1oyVnYzdkpWRVJkU2FZaVg3S1pKMUczRG9YVEwwd3BUaWp4THpJQldz?=
 =?utf-8?B?SzEwVU5VZlM3c3UrWUxJWkdsU0RvazdZNUh1a1hUdWJrWjMwbWQxTnp0eTZ2?=
 =?utf-8?B?NW03dDhSWlRYdFRxWmVOQTd1Z1F1ZU9ZVi93eGs3alpQYk1CWFkzRW4ySmtX?=
 =?utf-8?B?V0lDZHR6dk03elZpNVJSalZJOXhyS09KcXNNTm9hN3ZKcll0VTkwVjQ5VzA2?=
 =?utf-8?B?c1JKOHAwSS8yMU8rSVFVd1RMVXVRWDMzTVpSUHFUSEE3bTNYZHBtbWF5c0wr?=
 =?utf-8?B?OEdJZ0hjblJwMm5OWExuMFR3enR2YVg3WExMRGhWWjFSQzNyNjRpZHpxMXFF?=
 =?utf-8?B?by9UNUpyMnk1MEhqUDEzTGtPbTc0QXBXTVpYRzV2VDljamVFaDFLWUZmcExT?=
 =?utf-8?B?MWk5a21uZFVhUEs4WmI3V1hMUWNSK1l5R1ROQm1qbkdxZ1RmNktmQU1WYnJk?=
 =?utf-8?B?N2JTTTJlUDFPMUJsRmg5QVB4dHZLYXFJT2gxbVdIWm9EWGVHS2RBWExEZmRZ?=
 =?utf-8?B?YUc2WTZ4UWxzV1lDVEFBSTZMdFdWajZIODJSblZ0QWRrRFQwREd0ZnFFMmpv?=
 =?utf-8?B?WXpJcnA1cnptbWp2VjZkV2cwREJDSlZSNUg5ZkZ0NjdxZllvUTBoSlRNVWNU?=
 =?utf-8?B?OGpQdzhTUTVqWTh6VnlMMTVLNi8rTW0yY2lJSEVWenNQZjVhZTdXWWtySHEx?=
 =?utf-8?B?Zm13c1RMMGV5RktaUWV2OXpoVTZUeVI1SWlCUkpGNFFNaFNYYlZlc0l0a0Zx?=
 =?utf-8?B?ZUlmNndPN2w0ekxhR1crOUlQUU9uVUNwRkVJdFdGWW0rL1NqRUFlQXAzRG1W?=
 =?utf-8?B?aFY2b3FHb2NvTU02L0xmckF6djYxQzRaSnBwOHRielFuMTNyZHcvZzZuTXlm?=
 =?utf-8?B?Vm1tRFFVS2RhWEhKSGFyVVhJVXVoVWlmeTJ4ZVo1OTJqT3RoQjZ6NEVKcDF2?=
 =?utf-8?B?TEI1NDJid3lCT1g5OTBDd0hWTklvV1d2TWEvQXd4eUdvRlhoellPbVllU3NG?=
 =?utf-8?B?VUZHM0RVZnkxUExNZDJCZSs4TjZPREFWemFweG1CMzBHRGxKNW12Q0pVeGYv?=
 =?utf-8?B?RmZsdVBRK3lEd0g1SmcyZzJhYndsVVdTMlNWaDUyOXZId1JpZU4rQXlCdXhF?=
 =?utf-8?B?azRlU2h4ZVFBcVM3TFpYOEZmWEZqbmVRaFUzQ2JIeVg0cU95REpuUStGYks3?=
 =?utf-8?B?bDRJWmxHTURvVGRtQ1lXWUdoVGs1S2ZMcmNjN3hXaU11R2ErSGdsVkk2VTFq?=
 =?utf-8?B?TkV0aHJoSElkYUVhSVk4bkdIdG1ITzlSTm5UREhNQy9xbHdaOFQvWnc3RjVB?=
 =?utf-8?B?WXZGaU0wb3Q3OXhicTc1RHdkeFMrYjZVdHp1MzM4eHFpS3FLVDhLeFQ0enl6?=
 =?utf-8?B?bFEyYTVqK05CU0ozZjJ6bFV4SEJ0dEU5Uk92djVoejJJM3NLWm1xUDhNRnht?=
 =?utf-8?B?SU5BSUZXd3hFSW13RzJVY0xaSm1ObWFkdjBKaUw1SmQremxBanpLbXNDRmh1?=
 =?utf-8?Q?CABq0uhFpCGkjkWaVtWMqoEJnGpxglK5yUQ5LES?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d344a3b6-3f87-4487-a6c7-08d8dd7ad227
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 12:58:05.2618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adoWFvKmuOJj0RuJomUAedQTP61RJsqlS7KjFhGDv02gFYe255Wp4CSz6G9+lPvPagk47419M6HGfnIsRhzxEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3601
X-OriginatorOrg: intel.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Wu, Hao" <hao.wu@intel.com>
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Sunday, February 28, 2021 6:01 AM
>
> I/O Address Space ID (IOASID) core code was introduced in v5.5 as a generic
> kernel allocator service for both PCIe Process Address Space ID (PASID) and
> ARM SMMU's Substream ID. IOASIDs are used to associate DMA requests
> with
> virtual address spaces, including both host and guest.
> 
> In addition to providing basic ID allocation, ioasid_set was defined as a
> token that is shared by a group of IOASIDs. This set token can be used
> for permission checking, but lack some features to address the following
> needs by guest Shared Virtual Address (SVA).
> - Manage IOASIDs by group, group ownership, quota, etc.
> - State synchronization among IOASID users (e.g. IOMMU driver, KVM,
> device
> drivers)
> - Non-identity guest-host IOASID mapping
> - Lifecycle management
> 
> This patchset introduces the following extensions as solutions to the
> problems above.
> - Redefine and extend IOASID set such that IOASIDs can be managed by
> groups/pools.
> - Add notifications for IOASID state synchronization
> - Extend reference counting for life cycle alignment among multiple users
> - Support ioasid_set private IDs, which can be used as guest IOASIDs
> - Add a new cgroup controller for resource distribution
> 
> Please refer to Documentation/admin-guide/cgroup-v1/ioasids.rst and
> Documentation/driver-api/ioasid.rst in the enclosed patches for more
> details.
> 
> Based on discussions on LKML[1], a direction change was made in v4 such
> that
> the user interfaces for IOASID allocation are extracted from VFIO
> subsystem. The proposed IOASID subsystem now consists of three
> components:
> 1. IOASID core[01-14]: provides APIs for allocation, pool management,
>   notifications, and refcounting.
> 2. IOASID cgroup controller[RFC 15-17]: manage resource distribution[2].
> 3. IOASID user[RFC 18]:  provides user allocation interface via /dev/ioasid
> 
> This patchset only included VT-d driver as users of some of the new APIs.
> VFIO and KVM patches are coming up to fully utilize the APIs introduced
> here.
>
> [1] https://lore.kernel.org/linux-iommu/1599734733-6431-1-git-send-email-
> yi.l.liu@intel.com/
> [2] Note that ioasid quota management code can be removed once the
> IOASIDs
> cgroup is ratified.
> 
> You can find this series, VFIO, KVM, and IOASID user at:
> https://github.com/jacobpan/linux.git ioasid_v4
> (VFIO and KVM patches will be available at this branch when published.)

VFIO and QEMU series are listed below:

VFIO: https://lore.kernel.org/linux-iommu/20210302203545.436623-1-yi.l.liu@intel.com/
QEMU: https://lore.kernel.org/qemu-devel/20210302203827.437645-1-yi.l.liu@intel.com/T/#t

Regards,
Yi Liu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
