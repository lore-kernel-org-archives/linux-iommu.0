Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2000C47080
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 02:20:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8B4613BF
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 02:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8B4613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 394F06075A;
	Wed,  2 Jun 2021 02:20:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v3VcSDKq8xcX; Wed,  2 Jun 2021 02:20:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0862F605D6;
	Wed,  2 Jun 2021 02:20:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1502C000D;
	Wed,  2 Jun 2021 02:20:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29952C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 02:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0334F82AC8
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 02:20:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DejYDmCiB2Oc for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:20:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1764B827F3
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 02:20:23 +0000 (UTC)
IronPort-SDR: hA47VSI44/bc2HMGItub+eXjQLm4Nw5cp4I7VHMzB3K0S79ixMOwrz+rqRcfbKcXQgbjV9E7u5
 zopIAJw8EeJw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="203716925"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; d="scan'208";a="203716925"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 19:20:22 -0700
IronPort-SDR: QFxGMBdpdsVHhXxWJLaP3hnc/gh2ez3wgfrr9WhWpG5pT7SOdsGeESuAD01qsTPoHYaVVKCuIe
 l2vyQ9ob5ibg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; d="scan'208";a="635701392"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga005.fm.intel.com with ESMTP; 01 Jun 2021 19:20:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 19:20:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 1 Jun 2021 19:20:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 1 Jun 2021 19:20:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLm92Udy0Yuzsve/zq/HiRJ+66ABn9Ei2gjmH0s0p0SZ6GJWjm7MgGbOn4Kg5/TQQRSrZNOtxlOa829boHO4rkvHiMjMNt2p+qpAdp8hggwoKuMV9NZBXLUUKxOMZB1OCINZ43o5ZWtA3WsMzC7iBbe85swSnj/FcPMfi6nRwg6+Jh4rqQtmyG6abC6bmTTAU1Gl2u+cooHDXnlDAlsTr5k02VXi5JSWFCB8gUV+ty4zILpl3xDEVHmLi3OanoIC4I7e7tsS5DzkoG6FMs+wxppRhpn372xmkbQ710PMG7gsCIYkv4pEDUi01lJPQksJMlczQYzlFQN1p531LWPnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHz2rXXuBo5nuATjYwNDRFg+d+Uy7tRsBT1BWU9FNGY=;
 b=JDkLwYG9V+0pRny4E4ZYMF6vFXltB4VKq9Ehx6VrPIl5QICiuYrccQED6YwZBTP5nwZNXBKc5D7ccdvXaAIR3NXDTMDvM5jx+0Cd6+9bJcIep8+sgBkQT/IFfNA2bi5ldbRSWbapELPQniX9+nR4EtcL/g6D0oBY9nYeSq05xFpWcD9Znri9W3L00KI71hXX+Ws3F77oSnErrG5AOC4ASWC93QcV7Rn7Ml55ETJnp6wnqQLg7owdPxFSg8uLeUWciG7tIVGwSNMxMqfoFNRXL+c5G3bFYb6AbsHutihPT6XfQecXS76D2jkULhvQ3agkT6jip/NNv5XJ7Q9/aeTEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHz2rXXuBo5nuATjYwNDRFg+d+Uy7tRsBT1BWU9FNGY=;
 b=vJ422YpTn1uG8moVSgRoZObbHPomswelHiib+jtygjnfcz6cuAua4JZx6HDyuELHMMDaMj4NSmyfMiu8I04GQsAuCIeu3XgwBQd66U3Ir/0E5wwGMG7O7y48vyDWUxrZZIMiXlUn5Mgg+D5q6oJ2NIBFYXzBhdn6QLadz9W60sM=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB2061.namprd11.prod.outlook.com (2603:10b6:300:28::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Wed, 2 Jun
 2021 02:20:16 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 02:20:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBL2ymAAKTbxpAAKSt7gAAHpf9w
Date: Wed, 2 Jun 2021 02:20:15 +0000
Message-ID: <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601162225.259923bc.alex.williamson@redhat.com>
In-Reply-To: <20210601162225.259923bc.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.143.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22ef22f8-370d-42cb-82df-08d9256cf5ac
x-ms-traffictypediagnostic: MWHPR11MB2061:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB2061942772E873D7F271F0A78C3D9@MWHPR11MB2061.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5wFDploVEzgKAkF3MTLtYL2UlkLeS+uM0fPfpPsC9uyRMvpjnXftsN1V9zdB4LjXWNHcWkez4ky77VRKx2KDhpNox0tVG0yc0l1eNCiGdDQRv4iw8RHwrANHzu2S4dKcM6Xag3Drh3XW7NqNOJjTlhVsYO9qQ6lk4SfVg2pFcJwhfIrMQzIKCKlaAtNjF2F4b15yO8if24Uvu05u9YyjJG0FkAxHsqsFXF2r712hgIsIzwLstPYmmudB+eFaePhq8NGQUFi48/ZnfolRG4NBaofOoyWeqGSpWbrqCVV4f7i4eK8SpNwR7bQFmKR8Mbu/zmyOzk0egna3gB83srDei8qO8jKlFAo1/ChzfMlFIH+MXJDSNIiFS8SW814VDz4VNMTJtLj1EPRjwrB5+pa6IZK6yAKCS/rSwtcPRCisNZTmeNPt6yNz6m7TvXDzCyUszX/tAcZu8X94lf/Wiv0/O9rHgamZ8tIOFjdNvnf/Ao2IrGEVn4gteHpOSzxM5j6hBsuCfI8VExJKr4q+dCBMw1LqCwqwtz1A0Ishlyi0ypAjP64uWvqcA3JA19piSVKdaBtmDHNFPbiyJijQPHywBaoTHJ85i59pJ2IdiAJHY8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(346002)(366004)(396003)(39860400002)(5660300002)(186003)(55016002)(26005)(66946007)(6916009)(478600001)(8676002)(122000001)(54906003)(7416002)(7696005)(66446008)(64756008)(66556008)(66476007)(76116006)(38100700002)(4326008)(2906002)(71200400001)(86362001)(316002)(8936002)(9686003)(6506007)(52536014)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?eUYyM1hGQUdXeFJ3cE9JSjBLY1dZTU5WNm1uVys3emJ5OGloaGp0YUxVZEs5?=
 =?utf-8?B?Z1U4QU53cTdacTRBNWFqZmhZa2IySUtOOEdSeHdYSzNueFVzYUNBdm1zOG5C?=
 =?utf-8?B?SW1GTThMb0E2a1NQa0hVKzd0Rm0yZ1pDTjhla3JwQWRISE5aUlNhWXliTHZH?=
 =?utf-8?B?T0pQaE4wRjZycGlhSElENElOQXFPcDRhdUd1MDBBTzlpR203bUFieHR6WEJU?=
 =?utf-8?B?WCtaeUNUOEhVbEtJS1J2cEFaYk1mMkJFWmZGOW5qTnlRWXlZMm1wVWU4SURu?=
 =?utf-8?B?d2RpMnJmaXJzQWVpa1RVOHFQcUJwV0Q3a2oxTEpuM1RtUE5iV2NsQ2VDckJn?=
 =?utf-8?B?M3NNWnNObDZWcTd3TUk5S0hPRlJuZDVHaWJuQWMrd2w0QndDZGk2QjdQOHV0?=
 =?utf-8?B?dFZoUTZhbnNycTg1SVF3Tk1BaWRzWDNCT0ZLL0RlUklac2JWVXp3bWErd2ly?=
 =?utf-8?B?bnhLd0hQSG96OFhqRDJra3ZNS2lzTElIOS8yRU5NaWFJYStFM1JDQ3ovM0wy?=
 =?utf-8?B?YUNqam5aa3VHb093d2xZVTc0ZGw3OXZaTWZoQnc2U0dlaDExYVl6YURPa3k5?=
 =?utf-8?B?Y09abGhkcythaWkxOEtkNnAyRW5OS01wYkQrRDhpVnE3VVVEL0FrVUFSSWNl?=
 =?utf-8?B?bHNSbGNuNlZvZkoyeDBKMXhlZ1pLeisyeDRRSUxqWVhjV3pUV3pBNjRFR3F3?=
 =?utf-8?B?WVFraTJJV3dNSjZraGwvR2xSR1lXdTdLL1BOdjlzdUJhWjdLaFRkKytBUjgv?=
 =?utf-8?B?YlpQZWVzTEJPWTRGdG8wYWhFSExBZlh1VDYxK0o5QVJNUG9JWXQ3RmFhKzlI?=
 =?utf-8?B?QTRubjNlQU5yNWhRTXY3ZS9kSTkrUXlnL2pSNHd3bEd2c21MTVNMZWpVSnAv?=
 =?utf-8?B?S0o5aVYyWGs2eVNmeDlJc0Z2N05MUzdiTEs3aDZxdlh6YWVEd1RITHJsVk8y?=
 =?utf-8?B?SE5jbWtMVTZhd1FPaWJXQldxMWlQTzhBU3gwc3BEb0NnbHd1dTBpdis5NVZw?=
 =?utf-8?B?TlprOHh6T2xoWkdab2VYeE1sQzJqY0k4WjM0c24rTGRGRXBVVUZxTGU5clBy?=
 =?utf-8?B?RDBrZkVTWWFMdjFZbVcxR3ZBYzlDc0NaVE5jU1podk9Nc0RpWjhKcjd6Slpw?=
 =?utf-8?B?Si9FV29sMEVOR1V2bEd6WEtQT1J3dzNHWmY3U0RGTTNiZFpzUmM2VW5MUW5r?=
 =?utf-8?B?NHM2NmlkbHQzSVMzK0dNZ1R2QU9CUEdObXFGdTNweW5uajREVGdTd0hSNWJi?=
 =?utf-8?B?NWFDeG5lbno2UWJhNmpYWURiUVFJem1Uc2J6Nm8wM0Q0SzZhYkpGK1dsWllk?=
 =?utf-8?B?ckFzSjV1RnErdGhrcnVrRWp4VUlvc1FCdEpUYlFhY0JxNmVlSktpeG1FQ2cx?=
 =?utf-8?B?cnpXaklSR3V5REdIQ3dWM0VpVWZnMjlYV2llNFpFeXY2aG5LZGkwSjRtQldL?=
 =?utf-8?B?bHBFeS9wdTFuMFRsMFY5SUpxSGd4VCs1OEE3WnJ3Vmt3c2s5Y2pHQjdCYitV?=
 =?utf-8?B?SG5vV1lhR3doRGFYNWhoUjVsNUllVm1GdmFkZGtNb2o2MFMvVjFFSzlmTVFM?=
 =?utf-8?B?bzZNTWluV003Nmh6MWFUak9GeHFNRDVQZkxQcHlIbjNEOW55NmdmZUVidzdK?=
 =?utf-8?B?dkZRQjZoWmNkcGJkTFcxSGtRbHJtVGRpa3UzeExDVDZNMEFKQlFON25TTkE1?=
 =?utf-8?B?ZExUc1FzbnBibnFOUjBvUHhmY3FKOUlMU0MwdHNjUWk0cVF5SFBIY1JOd1hx?=
 =?utf-8?Q?1mXMwVmbxcI+rSvdsStiVf1UQhakA2Jjq7QjeT7?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ef22f8-370d-42cb-82df-08d9256cf5ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 02:20:15.7285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNeVBOA2JtGzj5Xbj4h8A7iVyETckB28efjbVESiCFujiZazngX1CpTCXw1Y/8YDcEe0XrGCzsMnr42AD7RQdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2061
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Gunthorpe <jgg@nvidia.com>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Wednesday, June 2, 2021 6:22 AM
> 
> On Tue, 1 Jun 2021 07:01:57 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >
> > I summarized five opens here, about:
> >
> > 1)  Finalizing the name to replace /dev/ioasid;
> > 2)  Whether one device is allowed to bind to multiple IOASID fd's;
> > 3)  Carry device information in invalidation/fault reporting uAPI;
> > 4)  What should/could be specified when allocating an IOASID;
> > 5)  The protocol between vfio group and kvm;
> >
> ...
> >
> > For 5), I'd expect Alex to chime in. Per my understanding looks the
> > original purpose of this protocol is not about I/O address space. It's
> > for KVM to know whether any device is assigned to this VM and then
> > do something special (e.g. posted interrupt, EPT cache attribute, etc.).
> 
> Right, the original use case was for KVM to determine whether it needs
> to emulate invlpg, so it needs to be aware when an assigned device is

invlpg -> wbinvd :)

> present and be able to test if DMA for that device is cache coherent.
> The user, QEMU, creates a KVM "pseudo" device representing the vfio
> group, providing the file descriptor of that group to show ownership.
> The ugly symbol_get code is to avoid hard module dependencies, ie. the
> kvm module should not pull in or require the vfio module, but vfio will
> be present if attempting to register this device.

so the symbol_get thing is not about the protocol itself. Whatever protocol
is defined, as long as kvm needs to call vfio or ioasid helper function, we 
need define a proper way to do it. Jason, what's your opinion of alternative 
option since you dislike symbol_get?

> 
> With kvmgt, the interface also became a way to register the kvm pointer
> with vfio for the translation mentioned elsewhere in this thread.
> 
> The PPC/SPAPR support allows KVM to associate a vfio group to an IOMMU
> page table so that it can handle iotlb programming from pre-registered
> memory without trapping out to userspace.
> 
> > Because KVM deduces some policy based on the fact of assigned device,
> > it needs to hold a reference to related vfio group. this part is irrelevant
> > to this RFC.
> 
> All of these use cases are related to the IOMMU, whether DMA is
> coherent, translating device IOVA to GPA, and an acceleration path to
> emulate IOMMU programming in kernel... they seem pretty relevant.

One open is whether kvm should hold a device reference or IOASID
reference. For DMA coherence, it only matters whether assigned 
devices are coherent or not (not for a specific address space). For kvmgt, 
it is for recoding kvm pointer in mdev driver to do write protection. For 
ppc, it does relate to a specific I/O page table.

Then I feel only a part of the protocol will be moved to /dev/ioasid and
something will still remain between kvm and vfio?

> 
> > But ARM's VMID usage is related to I/O address space thus needs some
> > consideration. Another strange thing is about PPC. Looks it also leverages
> > this protocol to do iommu group attach: kvm_spapr_tce_attach_iommu_
> > group. I don't know why it's done through KVM instead of VFIO uAPI in
> > the first place.
> 
> AIUI, IOMMU programming on PPC is done through hypercalls, so KVM
> needs
> to know how to handle those for in-kernel acceleration.  Thanks,
> 

ok.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
