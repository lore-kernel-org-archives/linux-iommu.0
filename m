Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47918C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 09:00:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2200604D7
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 09:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2200604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95EEC60777;
	Tue, 10 Aug 2021 09:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5RtlOkFttKrz; Tue, 10 Aug 2021 09:00:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 62B17605ED;
	Tue, 10 Aug 2021 09:00:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AB5DC0010;
	Tue, 10 Aug 2021 09:00:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FBE8C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D61B403F5
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:00:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0xGibr7jevav for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 09:00:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B7FD40359
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:00:51 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="195131141"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; d="scan'208";a="195131141"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2021 02:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; d="scan'208";a="674842384"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2021 02:00:49 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 02:00:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 02:00:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 10 Aug 2021 02:00:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 10 Aug 2021 02:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLD3Nqs55ThgpZbzdDWg9q3HCLl49dpk0TLEzigATczi2ZPc1jB8zFKuEnBsw/oUceq2R3sLfTLx+xmCbqz5WJjT+0yc1yFmPZq+C6oSAbXWLy+ViMpQOHGNaoqxE3EEIsdt4Vzrrb99VDB9nL+9mJt1huBeG0T1iikbvH3OcKwiy9uAfI7qbl5lSHTptbcpi1qD0VGOtfr0GYyg/8Thiw6G38ybZsiYIOwS5cVzfeOCVEUtUotUXf/K2A3BTDIQqBfdr8QDtj7qSJ/GZPwTc0LaXRsUmDJVmED92uj68tXawTaPzUqb5msNHdEZS9vUHL0qaEcjpVSiKFASGsUKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28QU3ywfJ6mY3KfB4laItfoLqhJNqq7GOeFa1Uxl4Nw=;
 b=bs+YevTRcQJsgMtY1/IUwp3WTnsaqYa0BMIfMBlBQgZrFySil9n5gBTMdmvEOs/eTSzMTtBWmsGtPWOXMe4qoxujxk2U7XpJiLXlrd2S/yQjid2wZXi43PfulPaW0psQV44bgHQq7qTNvIBqsqPYyAESmu2mG4qAcEak64x3ljNoPXHLEnmUsK7PU/DoQt1/QlOoGRRjLz5+7KBoNAMjsN3oRtFa7HIYERMR2vTT23DYsiXEEEalWp0rHfN86CFC4oxAkckvKYP4W/+dItHrZV2s7BuO1dpm1an/Ykp4Cbc7Sy/KqD6c410E/iehdUSvDDAGnnh5NnSM44Omt1HDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28QU3ywfJ6mY3KfB4laItfoLqhJNqq7GOeFa1Uxl4Nw=;
 b=PPLKD4CSZwsRgZA/2tWXp8FfozJ/xQZ0KRzRZxpvNCOSiSSwTw3LJSwLI94QFCeohogqV5GXpoVSLq9K0E2XkmRKSF0Q5yIjj31EIfsxBN0MYNrrM55+c4dIOffZ/eVNK1gmTAmHKFcUIjO/nXMCpMqAYiGwy2U90p/TR2toDq4=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN7PR11MB2753.namprd11.prod.outlook.com (2603:10b6:406:b0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 10 Aug
 2021 09:00:46 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::1508:e154:a267:2cce]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::1508:e154:a267:2cce%4]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 09:00:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "Alex Williamson (alex.williamson@redhat.com)"
 <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 "Jason Wang" <jasowang@redhat.com>, "parav@mellanox.com"
 <parav@mellanox.com>, "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Shenming Lu <lushenming@huawei.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: RE: [RFC v2] /dev/iommu uAPI proposal
Thread-Topic: [RFC v2] /dev/iommu uAPI proposal
Thread-Index: Add0lrMH87IsTsl5Rp6WN1oQU6kGMQUsvqiAAA+DMpABDABXAAACjD3g
Date: Tue, 10 Aug 2021 09:00:46 +0000
Message-ID: <BN9PR11MB5433FC19698D3A86B63850128CF79@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <b83a25de-7c32-42c4-d99d-f7242cc9e2da@redhat.com>
 <BN9PR11MB5433453DED3546F5011C3BDD8CF29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <cec41751-c300-40f2-a8d6-f4916fb4a34e@redhat.com>
In-Reply-To: <cec41751-c300-40f2-a8d6-f4916fb4a34e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b98c53e-1673-4ab6-18d0-08d95bdd579a
x-ms-traffictypediagnostic: BN7PR11MB2753:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB275324BD1004817920433A818CF79@BN7PR11MB2753.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3b3RaL+evn1DLzmBogSn1l/+ClUVShF9no3E6c/svWa6GtfRFN0tTTMJWNFJnJBbepS5QBvvRPynGtRjQOyZvbufI0j4/+OCCL9KyxRV0Xf4UnaASFqp6Wlzl4GfGrYsjCWUmddt+zZBbG9hI8PTunWbK8/cSdMMHryHEEqYI89esXH6rUdiKYTLvmNzCLu5n3CmMPOT3GSy9P7w+NXzS1HhDdU8BSurmgy4btToWF7DYKyI+iNgM+2EpwlncazV2DLqncV32I5zK8PKiWfHEqgZgW/7EtwipjxiyOYi+x0IwB4tkTzj/ya9u+B4OLoHqwplpphnypkea32JJsKMqlJxQWvEefiG4UiL5rN5N/mToCaSFLkcjGOKO+OZrSQ/SONJCyzSNnAujf6X+BloSLR8HEJ4vJfTrGaisAd7jtn+Uuqfoc7r4MEVDBmT9zM4f+LqQFFQlBWE4s3c5P7ofhNFjirjH1EUnBT+9vXDsMxyQ1XEkUfeNwdwKVympEfkLSbgq0V3Rifguc9wFGGcsWDg18sO3dNvk30M1xvpDv+9LLWWqPIWnEjdvVeMaAeZ1amEs7GcqPIokV29KZJV7FP3BMKBVlRmJ+exzmm1Za8JjSkCzPfFtDhAT468G1+1pFEHDCf4AATlEPPNtexkzJkmqNxpkZR+Oz7bk8uFP89V61UNGzk3GElXJlKnylCkuDEvB9exOIoW5nWkjaRYTClX/nlKK9v18wuF2fxAlkjIbg9wiSsRZlX0lglcTB9xhFXi3O9uyhJUXU5OvNp8eomZ6a6hOuBw+zYEik0MeVssXwdKj4gTviQfHVeRE2kL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(110136005)(9686003)(55016002)(38100700002)(83380400001)(76116006)(52536014)(8676002)(54906003)(316002)(122000001)(2906002)(38070700005)(33656002)(26005)(966005)(4326008)(8936002)(64756008)(478600001)(186003)(7696005)(71200400001)(5660300002)(66946007)(921005)(86362001)(66476007)(53546011)(6506007)(7416002)(66556008)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnZES1lkUERpZ3NNdmlDclUvdU1nWFpCWS96MVdCcEhmRE9QSG1iblNTbVZL?=
 =?utf-8?B?WGg4Y1VhK29MeFg0RlFUNzhtMTBQT0hTZkJJR0E5R2YwZ2Vyc09HbWtFRGg2?=
 =?utf-8?B?Y2hBcW5qRVc5VW1oeFBSeWc3ci9CYlVwM09nMmJyRzdQSStaS0w3MFM3QnRN?=
 =?utf-8?B?UGtzRFR6L0xyMGw2R09UMkZJUUt4MGRkNVE4ZWlDNUlnWUZrTWZRbmlaaks4?=
 =?utf-8?B?SnBJbi93Z0JNYmVLVGI3Uk0ySmo0cTA5OTJtcmVENVJaUEZmN245V3RhVDJy?=
 =?utf-8?B?MEl1OThGTWFFQUdnTUFqbjZoUjNOSy9UQnZwWjlETW9BYzYwaVdjM0dJQkRJ?=
 =?utf-8?B?QTVLNlFkSFhSYlFRVWp4UWEwSnNBNllzTlJXVFlSRTJCMlhveTNNMS9WbmJt?=
 =?utf-8?B?ZWFaWVZDcWVCRzNLVmRsZzNtRDAvQW5XdkhyUjVZRUx6UTlia01vRjE1dUk5?=
 =?utf-8?B?QkNHVzdMZGVBQlh1cFRML3pTdysxbjJyMkpES3RyejMrb2Q3b3N5WkV0R0o5?=
 =?utf-8?B?SWJFck9DM3Q0Y3Nka21ZRkN4Y2IvWDBoMi9UT1d3ZUJyanZkY1JJUWlnVnYz?=
 =?utf-8?B?QURIQ2JqZW5sakJYQU1OYnoxM2MyOFZySHdnMUtHRy9ZaU5QcXM4clJqTmtL?=
 =?utf-8?B?THAxK2xYZ3Q4eXFqOUQwbkM4K3VhMkdZQ3ErbG0wNy9neDJPVnVybHZVcGMw?=
 =?utf-8?B?aUYyd0JWcTdGTU5ZVjBXczZlZHh5LzlOZWFwRUYvZXJJMDM4bkRHNXFnTTdt?=
 =?utf-8?B?K1oxR01QOVBJbVY3ZmJldVU0YWpLbjZkS0JzNFQ4N1NYZHNESmlFSmJESzBp?=
 =?utf-8?B?VE5ETU9YSlhrZldJOFJIT2JoS29NQlFIOW1VVVJQTGwxM2F2RUdXZ2tTRHRs?=
 =?utf-8?B?cFVaM0xVSjZ5K25UZWVhaXl6dUc3TTcwWkVFcGNLUTZ2a0pIcjh2eTZZcy9I?=
 =?utf-8?B?QXN0cjZPK0VuM1lnQ2Jwd3I3SkZLbVhDTE1kM1ZMZ1UwUldFWnJLZ1NNZzhM?=
 =?utf-8?B?ZGMyR2d1blQzZE9FaU12M3kwcFVEL3VLYmp2a3lTQWMxc2ZhQklMd21oNmp3?=
 =?utf-8?B?M1g0NnlQVStacjc2dUxOWEo5MlNOb0tIbGsyQ3g4eFRZUXFIQnJrNUxjOXhJ?=
 =?utf-8?B?RUxNZHN3YTV4dnZ5NVVwMERHUlk3WGVRajdBcDd3MUZjL0xWWDdLeDNRdHZp?=
 =?utf-8?B?Y0NoRlc0VFdrdUxSbWNyVzFhS1BQMXVGaGlLOElBUXg5QUZVcHR5U2dLckFV?=
 =?utf-8?B?T1g4cGRyeDFmb2lENFhxSWw4S3N4YTZScUpVR2hYLzdvSFVEU0JEdXB0WlJV?=
 =?utf-8?B?alIyMWdWakJ3M3QrZDE3VkRJdDUxK1NUaDkweThJNmEyQkZvL3dQY2lpeHNa?=
 =?utf-8?B?eDhuV1hPMWxIV05Ha3ZDZE5XZkZBR2NJSzEvRVhGdGRvUnhPVTVwYlV6b0dG?=
 =?utf-8?B?WVNtSzRMYmtjUkJEd1VyTFFHWGZyUTh4YUJPMGF1VUZ6NjZnWnZ1eG11eE5p?=
 =?utf-8?B?a29aOHVKNGFkUmhwYTRaTlVQZzVJS3RORUJOTzZuYnNESjFsYlc1WHBCZkpp?=
 =?utf-8?B?NlI2dGRzdVQybndvamtFNndyNk5NWlZkVEhpM0FROFpMRkpYbitLMlMyczZG?=
 =?utf-8?B?c1EyTEY3TDZmblZROHJVNzJRakxjWVg2TnhLNTRYamhsRzVHK3J5MGlWRzJP?=
 =?utf-8?B?Z3lheWVPMnZLcWlvM2lLeHNjY1JLNzY0Nkhvc2hZQW9ibUFQblU0K3IrOHJW?=
 =?utf-8?Q?Gczp54wH0B9CaJyjzDoHtDrnlB44YhU9WK7E8VR?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b98c53e-1673-4ab6-18d0-08d95bdd579a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 09:00:46.3918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8i+Fk8BrcMg9mEQkN+EUP5vuDwz/OWahSihQ9vzdA3yHuffuC6usEMqv+k7/ulUeoXiEUUORzxkXoHjBPEjiHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2753
X-OriginatorOrg: intel.com
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Kirti
 Wankhede <kwankhede@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
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

> From: Eric Auger <eric.auger@redhat.com>
> Sent: Tuesday, August 10, 2021 3:17 PM
> 
> Hi Kevin,
> 
> On 8/5/21 2:36 AM, Tian, Kevin wrote:
> >> From: Eric Auger <eric.auger@redhat.com>
> >> Sent: Wednesday, August 4, 2021 11:59 PM
> >>
> > [...]
> >>> 1.2. Attach Device to I/O address space
> >>> +++++++++++++++++++++++++++++++++++++++
> >>>
> >>> Device attach/bind is initiated through passthrough framework uAPI.
> >>>
> >>> Device attaching is allowed only after a device is successfully bound to
> >>> the IOMMU fd. User should provide a device cookie when binding the
> >>> device through VFIO uAPI. This cookie is used when the user queries
> >>> device capability/format, issues per-device iotlb invalidation and
> >>> receives per-device I/O page fault data via IOMMU fd.
> >>>
> >>> Successful binding puts the device into a security context which isolates
> >>> its DMA from the rest system. VFIO should not allow user to access the
> >> s/from the rest system/from the rest of the system
> >>> device before binding is completed. Similarly, VFIO should prevent the
> >>> user from unbinding the device before user access is withdrawn.
> >> With Intel scalable IOV, I understand you could assign an RID/PASID to
> >> one VM and another one to another VM (which is not the case for ARM).
> Is
> >> it a targetted use case?How would it be handled? Is it related to the
> >> sub-groups evoked hereafter?
> > Not related to sub-group. Each mdev is bound to the IOMMU fd
> respectively
> > with the defPASID which represents the mdev.
> But how does it work in term of security. The device (RID) is bound to
> an IOMMU fd. But then each SID/PASID may be working for a different VM.
> How do you detect this is safe as each SID can work safely for a
> different VM versus the ARM case where it is not possible.

PASID is managed by the parent driver, which knows which PASID to be 
used given a mdev when later attaching it to an IOASID. 

> 
> 1.3 says
> "
> 
> 1)  A successful binding call for the first device in the group creates
>     the security context for the entire group, by:
> "
> What does it mean for above scalable IOV use case?
> 

This is a good question (as Alex raised) which needs more explanation 
in next version:

https://lore.kernel.org/linux-iommu/20210712124150.2bf421d1.alex.williamson@redhat.com/

In general we need provide different helpers for binding pdev/mdev/
sw mdev. 1.3 in v2 describes the behavior for pdev via iommu_register_
device(). for mdev a new helper (e.g. iommu_register_device_pasid()) 
is required and then the IOMMU-API will also provide a pasid variation 
for creating security context per pasid. sw mdev will also have its binding 
helper to indicate no routing info required in ioasid attaching.

Thanks
Kevin 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
