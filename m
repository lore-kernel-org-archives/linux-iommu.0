Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAB8C07E96
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 06:50:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761FD6117A
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 06:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761FD6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 489AB60BBA;
	Thu, 15 Jul 2021 06:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1rjNKu71V1i1; Thu, 15 Jul 2021 06:50:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D2E960BA8;
	Thu, 15 Jul 2021 06:50:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 022C2C001A;
	Thu, 15 Jul 2021 06:50:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 576B7C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 06:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CC97405F9
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 06:50:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3B-sSmHIfwlJ for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 06:50:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9FAA40524
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 06:50:00 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="210527751"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; d="scan'208";a="210527751"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2021 23:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; d="scan'208";a="488868715"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2021 23:49:58 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 14 Jul 2021 23:49:57 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 14 Jul 2021 23:49:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 14 Jul 2021 23:49:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 14 Jul 2021 23:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dulbMMLqUMyjIkmkBL/xiO8E/GaC49EYI7WYBIU/b+/v0nR77KNGOoH9DfGocMIPJ9GtOEZ8yx51u96hX26EBruSZKaG6Tg/cXVCQnMMlmSlPol6F5vLdb272vCIMzNnkGiDlSkZCEUJ/XmSufgG9PBMdyYiFMAouzzGW+ubWSf8ubuZSOcQgXl4JzYSOUkpDSspW+3KNZf5q/oz70hl5MF03Y+MZyYcs7w0YfgdVL3aW19n+mv/oNlAIua7dc6guzjSd9mv9quM3rtXFUiSpg+U3wkUrpnOWUYdbPBwx4tbHtKc5wm4gOHBJyqrDRYWOXx7rHW3AUrtteIXZR8BMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtgNNxfC1W89h1hOaFLx7qXFy475UiqgWde5wnXD6us=;
 b=UfZT4kFrO4ZZRI0cUCNh2zWuhvKrlQsSKP9cwsOvWVBTvqSk9GRS/Krr5xLjtP/Ty19O45dW0M8P5w2qwT8t2YGlzbMx8IINtB9wqdwV5RePiR1z/T3oVOGJlFZgNdUG2KxUUhtEB+tTnRSFoCS2q9KE/nj6YxhxVn025uvZZyfksGmT5NlcDqaA8iZ9ICqw8UTPL1f6N8X9jD7BjT+xBjT4UQnvCN0Dfu2mej5KiEqhsSedSWT9xWZ49Deks7Jo8bEnmbNQZmtJEENRwYH/+w2WubjneCcr2ko/KdbmtMF+O+erOrcDj3ZB4/JvCvbT7dpub3dzReE4yVa5kLIwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtgNNxfC1W89h1hOaFLx7qXFy475UiqgWde5wnXD6us=;
 b=QheITeZOJvLWXXS6rMLkjSYTiUgTKx72PTmQ6i1QSV9fBAwfseeypDhyQD/WdkbnCYzW4b8A20yMD7GlwWbKJB8/1ZTqBwYteisbpgWDGnYr2s2vbcsjbGTmPVW5wf4ZrFiBwkTW8hK57Ev0JZqfuekzsgc6i9r/ALtlp81bbng=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB3892.namprd11.prod.outlook.com (2603:10b6:405:80::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 06:49:55 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134%9]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 06:49:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shenming Lu <lushenming@huawei.com>
Subject: RE: [RFC v2] /dev/iommu uAPI proposal
Thread-Topic: [RFC v2] /dev/iommu uAPI proposal
Thread-Index: Add0lrMH87IsTsl5Rp6WN1oQU6kGMQEkayMAAADgu8AABbP/AAAAaVlQ
Date: Thu, 15 Jul 2021 06:49:54 +0000
Message-ID: <BN9PR11MB54336D6A8CAE31F951770A428C129@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <7ea349f8-8c53-e240-fe80-382954ba7f28@huawei.com>
 <BN9PR11MB5433A9B792441CAF21A183A38C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <a8edb2c1-9c9c-6204-072c-4f1604b7dace@huawei.com>
In-Reply-To: <a8edb2c1-9c9c-6204-072c-4f1604b7dace@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4908f388-1980-44c0-52fc-08d9475cc115
x-ms-traffictypediagnostic: BN6PR11MB3892:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB3892167D681B6582F7CCD76F8C129@BN6PR11MB3892.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLqvC5JU1OZdk79i7TfWjtFEmyCuQo/7t9J87zyaU/OrMy/BFIs+JH15tL+ZrdsJ9/3YxGC0GTkNZQtFfBjvN3rmQ70BV6IdFhR5rGfDW1oyK6U0OSxhWAMWiQKZMO1SZGv6z4g17t05g6zaTfyG6XYty4QC3eiO00cetDfHub7fIt/iKA3NbY89xaGH7jvva1zq1/feZqBzRJBXJAkkUTpSmdv7kAPCh8aHOLG4hgRknXsP20POe85DKd0WOhYg9FD2XHvDc/dMG29q9F8N0iFkor6E7E9HSyMmT+97bGCUUuQJKuSXPMRslYB40i9k3enl/IL54kjex0Ye+z++Pd1orAoQAOzQOvlVo3IHB1KCRCKa79XxqW1Xir3ENI2ndnrSz1wyLhpABIW1D2gurpTspVsOZsltTfKV/XwE5KKsTN0PTNuSGGwnCy0rjBaJ907XKgyKT9r613i6xYIeX8L758lBmhgy6Q/ebwUyaXVDUefjP8JwcgIOVb8+bjqBDpjWjyk+7OrS50SwW0Wm4JDMrWVpP4XVpdiTmr4NvaGxMqyAkPQBRTzYUsL+eZhs4WBHMdy3g2LfFY+aQiKtqXUuHzU9dMh13DI7T4mjYFTe0O42t4qN8Ct4E3K+TAttGAE12RRttTDE77qQ+kzxey6QB5imoaLPTsn517OO/cBavlagCbO+Fy26No+SQ6QYXKSfmN+LIdDdOyFIa7cC5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(33656002)(478600001)(4326008)(86362001)(26005)(53546011)(186003)(6506007)(7696005)(8676002)(8936002)(316002)(54906003)(66476007)(76116006)(55016002)(66946007)(66556008)(71200400001)(64756008)(66446008)(7416002)(2906002)(5660300002)(9686003)(6916009)(52536014)(38100700002)(122000001)(38070700004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTNlbUxMUnRIVzVPNlRiSU1aNW8wb3ExSW5BUU1oaXlramZrOGhtdlg3dVFK?=
 =?utf-8?B?K09HaFhSOGs3NkVUcFAyWHBKM0dmNjlVbVJ3T2xlMEJTTmN2QU84NnJYWWs2?=
 =?utf-8?B?VFNOMmtnWDhoWFJFTW1UaTBtSzltZmpZZDEweEJzMnhwZURjVnVQWHRFcVVH?=
 =?utf-8?B?WWRKWEFQZHc4ZU5sSUFoMExHOVRVbTZZQWt0WmNvRUNUTjJsTnh6OTh1RFJ4?=
 =?utf-8?B?OStiOGxrVEVnNzBmcUEzREcxalRiR0NwQVp5WnpBc1lPaWI5a3BmSDVOMWsr?=
 =?utf-8?B?MTI5N253MVBjcktwOWc3ZmpMWXFhSkFOcjBydlJSRjEwWklGY2lSWVBpUnkr?=
 =?utf-8?B?MXpSZG5VY3E2TGhBeXVYYitIU2VHTmtldVlwTHNzc1d2Q0FWSVJkUURmZy9t?=
 =?utf-8?B?Ny9CY1JTcXFkaEZ4bjQrbStQb05VSWFmd0x4bFZ3OUp6Z3BIY0NSVWM3eHJP?=
 =?utf-8?B?TE1rTTlKV2xPQXdaeUlReXYzQkFsRXZ3dXYvZlFwWFo1bk15R1RYWnl0ZmJ4?=
 =?utf-8?B?dkNRNGtnRlZ3c3dKWHVLOVFNNW4ycFVRNkZ1TmVnZkpZb1FYK3NlTWlZaWJq?=
 =?utf-8?B?Q00vN241RDVneEVZeXZCVWhXZFp5aDYyNE5ZbGZzdGdvMmc4Y1B2VTFZSVRm?=
 =?utf-8?B?aThVWWwxdnJoN29QTFFVUG14Vyt2WmJWUVh5cWpiSjlWRXpHWXJyVzB3UVdN?=
 =?utf-8?B?QkpYMXVvQ0JDWjZMcmJ2d25yRlUyTm01Z1VOY2lUNmRicUVoNlViN3dQemFJ?=
 =?utf-8?B?M1VGUEg3UWZlMldObW5Sakh0aDlPRXE4TmR3SXh2VUVvZHpubjR2blVHdTJn?=
 =?utf-8?B?ZDN0QStpNDdHRDhVeWlJY3lzTG9jeS9COHVIakpaT3RNRGpUNkE5aXRKNHJx?=
 =?utf-8?B?NCs5cTJqKzRzSkI0RnpqcTd0RGNpeklkdzJHanh1NDFmbXJPUXZucEo0NWNT?=
 =?utf-8?B?bTBGT2x4cllYcCtmNTlPbVlCK3drTEdNSVhYQkhKay9xVm14eG52T2ZRaHE2?=
 =?utf-8?B?bUczeWtrZE5TNldaU215UFMrVVJpMS9CS282WVVaNktEa25LNnJwODM1YmJo?=
 =?utf-8?B?UDNDT3NubDRTa2ZzcktRNVVUWG4rOExpUVo1Zm9KK3U3QmxrYmxRejRza1hM?=
 =?utf-8?B?eTRINDJUZVF2Mk9JUjBUWEU4VUZ3MWZBcWNrbnNTdVNkYXRrY0o3VXg2QnJX?=
 =?utf-8?B?bmdVQTB4eWx1RkNTZXh1d0MydnUzU1BSRmZBYkhjYS80UUgwTHlEcWRXdXlL?=
 =?utf-8?B?dzlBWVFFVEJuZDhmRzBGRUVrb0VDQlZQUnc2V0NNM3Z4cG5ROWR2S3owcUR6?=
 =?utf-8?B?aHozY3RMWTJ3YVlHMHQzR2huUGVEWlcza3pKb3dhYkErQm5aM1gzR0dqcGU4?=
 =?utf-8?B?L3p3Z1k1MmYxTDNBVkVFM1hxSzlKYzhlazhua0tXYXZJYzJpQTN1MEQrYU0x?=
 =?utf-8?B?N3JobzRMelZxZnE1Um92NCtRK0JkTHFsRUcvNEY2dTA3OUY0T2ZibHhnVjVy?=
 =?utf-8?B?aUNjbzV0eDRZRjV0VEJqVUE1SWRLdCt4bE14bWJZTURzZDVWdzQ5Ri9KWlZN?=
 =?utf-8?B?dXpiTXdXSXhmTzRlbkhBckM0YWNwV1BWNHNtaWZtb2tzZWd1M1JKMm4rc1NQ?=
 =?utf-8?B?eWRQN3J4VzZQMXRTTTdFOE5sRThwTWFTMDdjM0hBYzM3cS9JN3BrbjNWbjRa?=
 =?utf-8?B?WHhYSnVEMEtwMXo1V1VIYjBaVU5hMG52TnVBOVdBWEttb3duYlV1cGozU3Vs?=
 =?utf-8?Q?NAocopsRbujIxMB2vwiVwRv8waHEkq0Yme2snsE?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4908f388-1980-44c0-52fc-08d9475cc115
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 06:49:54.9289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DksW4TPR0tx6KdJuwg/+YF5iIzx1WCNNq5qZ1klTaRIx+215xH4QQwEyiq9kCqdIxkKhuKvHlUq9Vs7u1viF8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3892
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PiBGcm9tOiBTaGVubWluZyBMdSA8bHVzaGVubWluZ0BodWF3ZWkuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVseSAxNSwgMjAyMSAyOjI5IFBNDQo+IA0KPiBPbiAyMDIxLzcvMTUgMTE6NTUsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBTaGVubWluZyBMdSA8bHVzaGVubWluZ0BodWF3
ZWkuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgSnVseSAxNSwgMjAyMSAxMToyMSBBTQ0KPiA+
Pg0KPiA+PiBPbiAyMDIxLzcvOSAxNTo0OCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+PiA0LjYu
IEkvTyBwYWdlIGZhdWx0DQo+ID4+PiArKysrKysrKysrKysrKysrKysrDQo+ID4+Pg0KPiA+Pj4g
dUFQSSBpcyBUQkQuIEhlcmUgaXMganVzdCBhYm91dCB0aGUgaGlnaC1sZXZlbCBmbG93IGZyb20g
aG9zdCBJT01NVQ0KPiBkcml2ZXINCj4gPj4+IHRvIGd1ZXN0IElPTU1VIGRyaXZlciBhbmQgYmFj
a3dhcmRzLiBUaGlzIGZsb3cgYXNzdW1lcyB0aGF0IEkvTyBwYWdlDQo+ID4+IGZhdWx0cw0KPiA+
Pj4gYXJlIHJlcG9ydGVkIHZpYSBJT01NVSBpbnRlcnJ1cHRzLiBTb21lIGRldmljZXMgcmVwb3J0
IGZhdWx0cyB2aWENCj4gZGV2aWNlDQo+ID4+PiBzcGVjaWZpYyB3YXkgaW5zdGVhZCBvZiBnb2lu
ZyB0aHJvdWdoIHRoZSBJT01NVS4gVGhhdCB1c2FnZSBpcyBub3QNCj4gPj4gY292ZXJlZA0KPiA+
Pj4gaGVyZToNCj4gPj4+DQo+ID4+PiAtICAgSG9zdCBJT01NVSBkcml2ZXIgcmVjZWl2ZXMgYSBJ
L08gcGFnZSBmYXVsdCB3aXRoIHJhdyBmYXVsdF9kYXRhIHtyaWQsDQo+ID4+PiAgICAgcGFzaWQs
IGFkZHJ9Ow0KPiA+Pj4NCj4gPj4+IC0gICBIb3N0IElPTU1VIGRyaXZlciBpZGVudGlmaWVzIHRo
ZSBmYXVsdGluZyBJL08gcGFnZSB0YWJsZSBhY2NvcmRpbmcgdG8NCj4gPj4+ICAgICB7cmlkLCBw
YXNpZH0gYW5kIGNhbGxzIHRoZSBjb3JyZXNwb25kaW5nIGZhdWx0IGhhbmRsZXIgd2l0aCBhbiBv
cGFxdWUNCj4gPj4+ICAgICBvYmplY3QgKHJlZ2lzdGVyZWQgYnkgdGhlIGhhbmRsZXIpIGFuZCBy
YXcgZmF1bHRfZGF0YSAocmlkLCBwYXNpZCwgYWRkcik7DQo+ID4+Pg0KPiA+Pj4gLSAgIElPQVNJ
RCBmYXVsdCBoYW5kbGVyIGlkZW50aWZpZXMgdGhlIGNvcnJlc3BvbmRpbmcgaW9hc2lkIGFuZCBk
ZXZpY2UNCj4gPj4+ICAgICBjb29raWUgYWNjb3JkaW5nIHRvIHRoZSBvcGFxdWUgb2JqZWN0LCBn
ZW5lcmF0ZXMgYW4gdXNlciBmYXVsdF9kYXRhDQo+ID4+PiAgICAgKGlvYXNpZCwgY29va2llLCBh
ZGRyKSBpbiB0aGUgZmF1bHQgcmVnaW9uLCBhbmQgdHJpZ2dlcnMgZXZlbnRmZCB0bw0KPiA+Pj4g
ICAgIHVzZXJzcGFjZTsNCj4gPj4+DQo+ID4+DQo+ID4+IEhpLCBJIGhhdmUgc29tZSBkb3VidHMg
aGVyZToNCj4gPj4NCj4gPj4gRm9yIG1kZXYsIGl0IHNlZW1zIHRoYXQgdGhlIHJpZCBpbiB0aGUg
cmF3IGZhdWx0X2RhdGEgaXMgdGhlIHBhcmVudCBkZXZpY2UncywNCj4gPj4gdGhlbiBpbiB0aGUg
dlNWQSBzY2VuYXJpbywgaG93IGNhbiB3ZSBnZXQgdG8ga25vdyB0aGUgbWRldihjb29raWUpIGZy
b20NCj4gPj4gdGhlDQo+ID4+IHJpZCBhbmQgcGFzaWQ/DQo+ID4+DQo+ID4+IEFuZCBmcm9tIHRo
aXMgcG9pbnQgb2Ygdmlld++8jHdvdWxkIGl0IGJlIGJldHRlciB0byByZWdpc3RlciB0aGUgbWRl
dg0KPiA+PiAoaW9tbXVfcmVnaXN0ZXJfZGV2aWNlKCkpIHdpdGggdGhlIHBhcmVudCBkZXZpY2Ug
aW5mbz8NCj4gPj4NCj4gPg0KPiA+IFRoaXMgaXMgd2hhdCBpcyBwcm9wb3NlZCBpbiB0aGlzIFJG
Qy4gQSBzdWNjZXNzZnVsIGJpbmRpbmcgZ2VuZXJhdGVzIGEgbmV3DQo+ID4gaW9tbXVfZGV2IG9i
amVjdCBmb3IgZWFjaCB2ZmlvIGRldmljZS4gRm9yIG1kZXYgdGhpcyBvYmplY3QgaW5jbHVkZXMN
Cj4gPiBpdHMgcGFyZW50IGRldmljZSwgdGhlIGRlZlBBU0lEIG1hcmtpbmcgdGhpcyBtZGV2LCBh
bmQgdGhlIGNvb2tpZQ0KPiA+IHJlcHJlc2VudGluZyBpdCBpbiB1c2Vyc3BhY2UuIExhdGVyIGl0
IGlzIGlvbW11X2RldiBiZWluZyByZWNvcmRlZCBpbg0KPiA+IHRoZSBhdHRhY2hpbmdfZGF0YSB3
aGVuIHRoZSBtZGV2IGlzIGF0dGFjaGVkIHRvIGFuIElPQVNJRDoNCj4gPg0KPiA+IAlzdHJ1Y3Qg
aW9tbXVfYXR0YWNoX2RhdGEgKl9faW9tbXVfZGV2aWNlX2F0dGFjaCgNCj4gPiAJCXN0cnVjdCBp
b21tdV9kZXYgKmRldiwgdTMyIGlvYXNpZCwgdTMyIHBhc2lkLCBpbnQgZmxhZ3MpOw0KPiA+DQo+
ID4gVGhlbiB3aGVuIGEgZmF1bHQgaXMgcmVwb3J0ZWQsIHRoZSBmYXVsdCBoYW5kbGVyIGp1c3Qg
bmVlZHMgdG8gZmlndXJlIG91dA0KPiA+IGlvbW11X2RldiBhY2NvcmRpbmcgdG8ge3JpZCwgcGFz
aWR9IGluIHRoZSByYXcgZmF1bHQgZGF0YS4NCj4gPg0KPiANCj4gWWVhaCwgd2UgaGF2ZSB0aGUg
ZGVmUEFTSUQgdGhhdCBtYXJrcyB0aGUgbWRldiBhbmQgcmVmZXJzIHRvIHRoZSBkZWZhdWx0DQo+
IEkvTyBhZGRyZXNzIHNwYWNlLCBidXQgaG93IGFib3V0IHRoZSBub24tZGVmYXVsdCBJL08gYWRk
cmVzcyBzcGFjZXM/DQo+IElzIHRoZXJlIGEgY2FzZSB0aGF0IHR3byBkaWZmZXJlbnQgbWRldnMg
KG9uIHRoZSBzYW1lIHBhcmVudCBkZXZpY2UpDQo+IGFyZSB1c2VkIGJ5IHRoZSBzYW1lIHByb2Nl
c3MgaW4gdGhlIGd1ZXN0LCB0aHVzIGhhdmUgYSBzYW1lIHBhc2lkIHJvdXRlDQo+IGluIHRoZSBw
aHlzaWNhbCBJT01NVT8gSXQgc2VlbXMgdGhhdCB3ZSBjYW4ndCBmaWd1cmUgb3V0IHRoZSBtZGV2
IGZyb20NCj4gdGhlIHJpZCBhbmQgcGFzaWQgaW4gdGhpcyBjYXNlLi4uDQo+IA0KPiBEaWQgSSBt
aXN1bmRlcnN0YW5kIHNvbWV0aGluZz8uLi4gOi0pDQo+IA0KDQpOby4gWW91IGFyZSByaWdodCBv
biB0aGlzIGNhc2UuIEkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYSB3YXkgdG8gDQpkaWZmZXJlbnRp
YXRlIG9uZSBtZGV2IGZyb20gdGhlIG90aGVyIGlmIHRoZXkgY29tZSBmcm9tIHRoZQ0Kc2FtZSBw
YXJlbnQgYW5kIGF0dGFjaGVkIGJ5IHRoZSBzYW1lIGd1ZXN0IHByb2Nlc3MuIEluIHRoaXMNCmNh
c2UgdGhlIGZhdWx0IGNvdWxkIGJlIHJlcG9ydGVkIG9uIGVpdGhlciBtZGV2IChlLmcuIHRoZSBm
aXJzdA0KbWF0Y2hpbmcgb25lKSB0byBnZXQgaXQgZml4ZWQgaW4gdGhlIGd1ZXN0Lg0KDQpUaGFu
a3MNCktldmluDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
