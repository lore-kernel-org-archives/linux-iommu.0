Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BAAC433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 09:44:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E012F64EEE
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 09:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E012F64EEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 797816F4E5;
	Wed,  3 Mar 2021 09:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O2m5bZnv1R8q; Wed,  3 Mar 2021 09:44:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55B7560606;
	Wed,  3 Mar 2021 09:44:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AFC1C000A;
	Wed,  3 Mar 2021 09:44:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30957C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 09:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F354E6063A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 09:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ggt4UGvKl3uQ for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:44:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C4AD60606
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 09:44:32 +0000 (UTC)
IronPort-SDR: xEl7Wer3ZUbLV8xvecWunf/3EwSuSVoavk5cDWqL60AbzZ8Nw2GLNuhNnFBF3gzoNJFPWuRLnR
 H/5T7BscDLKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174278024"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; d="scan'208";a="174278024"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 01:44:30 -0800
IronPort-SDR: TVR/6CoZTnAZFaRH0HKdWwhyJo4unAt6gEBp6mB9W2+Ca+V2rL+prNaux0JpREzRVo+ldHIUlF
 lfaZSrUDfayw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; d="scan'208";a="383922326"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga002.jf.intel.com with ESMTP; 03 Mar 2021 01:44:29 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Mar 2021 01:44:29 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Mar 2021 01:44:29 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 3 Mar 2021 01:44:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGOWENbhGPo69dYS3CXJURSssDDTGiQsBm1sa/mKhCn+bZ8AkBVr9zyNi92tWsS28Cj7bvW+XoqNwihGYB/QY32vJJ9CvmQXwrXIFNosg/DksQcmT0B91NO8NEGAEpHRLFeWag7sT2z4JOMqh8Na3BfLK1XlrqnIbrHheubDXjzsh0QKrEVlgIWZEhcDQ0IQpuLi829XtZC4l+9K75XlGfVohQ+8v+qQhW17ZNbFfNQyKK6ZhYVusgy0XvNUYVc9VFlaV3KI1CB6+vCbnuduPil/br+QrHKmDk2oxTLwk3taPXmVe9zmYf42nJZnuiJ09Z3oGcZkMg9lpR/NFHlTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cofRxY1jmb8P/c5R6NDv5EpiJ9UrxsTAxOSdrJiT6Q=;
 b=T5cpum9pKPk2oaz8D0QKhD3Ltn2kbmHkj6RrRYUXQKCAdqgKlHAtNCnK9/mBM/f7GFP6QPcbqXEn3SkcefHZLmPsp1OUzRr2nc5+bm15QtIfcp4xR8pi8R1ShcgevNZSCH9OJnjgtrWUhm07PXysDz5CE39mVS9sEJdcYwkkBeUrK5lKafvQ4+EJiEvq6OZV17ccsQMp19QMj3dOnxP/VcHnR8RXCpSXiwPk3Oj3/wEgdNhtwPLWjmRPeK2mn1cl8JEWSqPANk9FhMLRtH1NIRNZlsyjM2tamg0p1/XUsunauu0jQLP5f0MZjp1FjBqaDaI+5F4qhOCH6eJr9Q5GzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cofRxY1jmb8P/c5R6NDv5EpiJ9UrxsTAxOSdrJiT6Q=;
 b=jwt9zW6w8KYYxqfk9iRHcPZrT3/fsTXIZp1osC4XvKKLmHSpBXIX0HYEhF7Ve8K+FDryn6/DZo5vRjVwQkXPa6UZj51fcItSSWWqZvSMKnAO6gFXOHq53cuo1smLBEWlpBMJCLr1gTcu2x/smqfvA4dz30764X4cvSDwvMTD94E=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN6PR1101MB2338.namprd11.prod.outlook.com (2603:10b6:404:9c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 09:44:27 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 09:44:27 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, Vivek Gautam <vivek.gautam@arm.com>
Subject: RE: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
Thread-Topic: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
Thread-Index: AQHWh19ACfcP7ssg8UC1cgpZfCvfJKokT6+AgAAjF2CAACQ7gIABOtBwgAm0EICABjauYIAfUfuAgAAtvgCAGpg3MA==
Date: Wed, 3 Mar 2021 09:44:27 +0000
Message-ID: <BN6PR11MB4068809A4DE77636579BC81EC3989@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-3-git-send-email-yi.l.liu@intel.com>
 <CAFp+6iFob_fy1cTgcEv0FOXBo70AEf3Z1UvXgPep62XXnLG9Gw@mail.gmail.com>
 <DM5PR11MB14356D5688CA7DC346AA32DBC3AA0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <CAFp+6iEnh6Tce26F0RHYCrQfiHrkf-W3_tXpx+ysGiQz6AWpEw@mail.gmail.com>
 <DM5PR11MB1435D9ED79B2BE9C8F235428C3A90@DM5PR11MB1435.namprd11.prod.outlook.com>
 <6bcd5229-9cd3-a78c-ccb2-be92f2add373@redhat.com>
 <DM5PR11MB143531EA8BD997A18F0A7671C3BF9@DM5PR11MB1435.namprd11.prod.outlook.com>
 <CAFp+6iGZZ9fANN_0-NFb31kHfiytD5=vcsk1_Q8gp-_6L7xQVw@mail.gmail.com>
 <9b6d409b-266b-230a-800a-24b8e6b5cd09@redhat.com>
In-Reply-To: <9b6d409b-266b-230a-800a-24b8e6b5cd09@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13902a2b-06f9-4f70-dd00-08d8de28efe7
x-ms-traffictypediagnostic: BN6PR1101MB2338:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB233893964F99BEAE8ED54155C3989@BN6PR1101MB2338.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eoPe3sJSqgxb6nBq90l1xv+ISbdUbq8J7kvO03OTwF2XYsSk+jkq2jKBHYWVL8t+Ig3WegKSSWoDing9BgrnX185+HxXobvDI+QNtgWwMa4rZR4SVQGVdGFO75g57adFojvv24HFeRUgXK6i0e3viCOzgqnxEPtfCcFpkGeS7LKUWtuRoJaYjsK63I0M7ns2rVUDfI9MahQhPkZZgsNPJTP1CeptKVWhs6BKguX0zl6+1GCVZeNnyg/zLj7cfxFpsVhnZcy4Y7pMjZvuggn4jT4t/rm2hV1JVGqhKPoiVI+rbRsD9pJbn4WiGqLwX3CfLoIDCgKysynd8DdL1z+DexiD1OY1RVGduBU9dr2uabThaVDhqHQmvnCKGFLFf5HHHWbEmZqKi4fbmnU5t1sYvcXVV0vfnSWYezHlHXGrryAMe/p8NjdqQgDIa16ZtyVSbjOakHFAWbLvI2C2MijMr1kWf8rv46ayYqmaLET2lWrs7kO18ubJROLfp+ZNnk8iYuEayc8hiAkmWSpKjaMJJro0qTWrBLrgA2O/3c5iht6Wi57VFgQAnWIqQGmJ7nDtD9rj7GoJfKqUJOIp/KARi+x05Y9rrgVYX1yaZHrQPX8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR11MB4068.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(366004)(396003)(136003)(376002)(83380400001)(53546011)(4326008)(186003)(26005)(86362001)(8936002)(966005)(66446008)(52536014)(7416002)(107886003)(54906003)(110136005)(33656002)(76116006)(478600001)(64756008)(66476007)(7696005)(66946007)(8676002)(66556008)(9686003)(5660300002)(55016002)(316002)(6506007)(71200400001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UUxIRkIzTWFjYTZ1L0pKaXQ5cVJxUDkxZjllU3JQQ0pCWDBEWjVKOGIrK09F?=
 =?utf-8?B?ZUR1b0dxUk1GV1NBaWkxbjBUdlBIRmU1UDFIbmNLT3Y3MytleE1KNkNMaVRa?=
 =?utf-8?B?VWZyenFXcy9aQWsvamxNdG54c2hnb1hpdWd1Y1g4dEhORTdrMjhlOHFMRWl3?=
 =?utf-8?B?Ukk2dXNNRFNVRUxLN0luSEJseVZVMS85c3p1OXhlbHpYNEdjOEZYdyszTEhw?=
 =?utf-8?B?VTJHaXdGRHFjTXJZWWFVQWwySUtBQWgybGZ2MjVNR3RmSlFON2Q1eGZKbEZC?=
 =?utf-8?B?NEN3aEtlZFM5WG12bTY2b3Q4ZmY5MzQvQjlwVERaRGJQbUk4bldBbXNDaGxu?=
 =?utf-8?B?M0ZjN2YvRzNVZjFXL0h2ZGtFdGo1dVF6K1RFa1N4bTU1M2FKNEtSNVVRWm14?=
 =?utf-8?B?Mkpkamo4VWNDWWlZMmsxRW1OWGhYNGpIUlBOVXBTVlE3R2RsT3hRNnU2eGNs?=
 =?utf-8?B?OHZPTGduUjdpMGdRMWViLzJQWEFrZmpCb2tyRHdSRFM0RmFCaktoanliR283?=
 =?utf-8?B?OEVVbHRQOVZmTTMyemV1NmRVck1KdXFiYXF2ZUhNaGc0SFVOcy9GcmFNdkZK?=
 =?utf-8?B?TGdGb2dFNmozOGJNckhFMzBzNktOM1ZiY3BiRUNSSGdPc0N3OU5ONUd0Q1kr?=
 =?utf-8?B?Q3Bjay9ibXlNaHVjQTNWUEpyQUhpNVBZNlNyTGhCWmRPeHVIc1o2K2hwZzNM?=
 =?utf-8?B?aDBuNGhSSFZuRXRLMmY1cFVOak03bFVxbjZjcVBQS2F1bXNUNzdabGIrL2I3?=
 =?utf-8?B?SmNSRXRGNHNtY1h6bmRPbkc5NWJ1VEJpZXNpZCtObUlUOHdHaFAwOTNoWkdv?=
 =?utf-8?B?cy9VMVIyWjJOd0UrUTVVclFpRzdFSEJManpGYW1sSkQzektIRncxNkhnMFB5?=
 =?utf-8?B?YTZiajNyTzRnSUc3SG5jY2NvM1NFdElYNmQ2Z1JDV3FFUFByeVkwWDRUSnBs?=
 =?utf-8?B?T3NLOUNaQWFobWx6ZE1NSEFqeVlCTG5vWmw3WGxLZys2a0NFZ0dHQThNdEVp?=
 =?utf-8?B?TlBMQlh5cTJnMTloazBPUzBqSXgyTG90QjVKUHB4VDFvQ3plaVBja0pkbGZG?=
 =?utf-8?B?VjNJM3hsMHdhalB4TzNINTNhYjVkMFNGMWFBU0JiNkgrZlZsRkNjbTNkNFZN?=
 =?utf-8?B?ejhGV3p6dVZBV05scmtZaTg4UVpyaERVRFh0RlR2anZtaDBUVjhnSitFK25a?=
 =?utf-8?B?Q0JmVkdmK0hoa0dUK1NEVnFCZ2trNUpvamk1cGJwOVlzRmQ0SDFmdng4OVA3?=
 =?utf-8?B?RG1YYmxnM1pIM1NaMEwzRG9FOWFrd0VRaExtTkgwNHE1YnNEZWtYZXBaVk94?=
 =?utf-8?B?TlpjMCsyWWMydmFCeG01ZkIxQlJUZFZpTHZJR3FVaTQyM2dTS3YrZ09kSUZK?=
 =?utf-8?B?UUxKOGlnaWRSZk9lbk9FbXREdjBmOWxqNDV0NUNtVTdmdGhBQ3pLcG1CSUlL?=
 =?utf-8?B?RTh3NXBTWmcxaUJQTGo3cnljRDRwZHVRL2d6cjl4aXYwTXhDa1BmZDUvUWdx?=
 =?utf-8?B?T1Y5RExINUJDazFSdG05WFBYcVVYdnZtK2dxVWtVMUVPdlBhUEVrYXN6NFoy?=
 =?utf-8?B?VWY0S1lvUnNyNy9vZVBoK2VKUVoyWDFFdnl2em1YVVM4R0lyNERLOVFWRVRQ?=
 =?utf-8?B?cXVuSUdXaTRtY3h2d0E5RkpVbmVnYXR6eUlkZzZ5eDFEQ2d5cUhRNHlNUG1P?=
 =?utf-8?B?WkEvUFlDSHIveXpGSkt4Zk50V3Q1YVNFdWduaE1rUElsVlZiZTZUSTFxVEVx?=
 =?utf-8?Q?4v63jJ8c9EPq+Mny32BqjbVCCSSwDBmg2KQiyRO?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13902a2b-06f9-4f70-dd00-08d8de28efe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 09:44:27.5864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sG92J/7nulUkLGfYIsaC5aFDzPCM+cUnGlL8YuQ2jDpVIQ6CvrRThUv0pWcIloREoPkDX/zFCcOfayw9YcrfZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2338
X-OriginatorOrg: intel.com
Cc: "Sun, Yi Y" <yi.y.sun@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

SGkgRXJpYywNCg0KPiBGcm9tOiBBdWdlciBFcmljIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+
IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMTIsIDIwMjEgNTo1OCBQTQ0KPiANCj4gSGkgVml2ZWss
IFlpLA0KPiANCj4gT24gMi8xMi8yMSA4OjE0IEFNLCBWaXZlayBHYXV0YW0gd3JvdGU6DQo+ID4g
SGkgWWksDQo+ID4NCj4gPg0KPiA+IE9uIFNhdCwgSmFuIDIzLCAyMDIxIGF0IDI6MjkgUE0gTGl1
LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBIaSBFcmljLA0K
PiA+Pg0KPiA+Pj4gRnJvbTogQXVnZXIgRXJpYyA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiA+
Pj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAxOSwgMjAyMSA2OjAzIFBNDQo+ID4+Pg0KPiA+Pj4g
SGkgWWksIFZpdmVrLA0KPiA+Pj4NCj4gPj4gWy4uLl0NCj4gPj4+PiBJIHNlZS4gSSB0aGluayB0
aGVyZSBuZWVkcyBhIGNoYW5nZSBpbiB0aGUgY29kZSB0aGVyZS4gU2hvdWxkIGFsc28gZXhwZWN0
DQo+ID4+Pj4gYSBuZXN0aW5nX2luZm8gcmV0dXJuZWQgaW5zdGVhZCBvZiBhbiBpbnQgYW55bW9y
ZS4gQEVyaWMsIGhvdyBhYm91dCB5b3VyDQo+ID4+Pj4gb3Bpbmlvbj8NCj4gPj4+Pg0KPiA+Pj4+
ICAgICBkb21haW4gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYoJnZkZXYtPnBkZXYtPmRldik7
DQo+ID4+Pj4gICAgIHJldCA9IGlvbW11X2RvbWFpbl9nZXRfYXR0cihkb21haW4sIERPTUFJTl9B
VFRSX05FU1RJTkcsDQo+ID4+PiAmaW5mbyk7DQo+ID4+Pj4gICAgIGlmIChyZXQgfHwgIShpbmZv
LmZlYXR1cmVzICYgSU9NTVVfTkVTVElOR19GRUFUX1BBR0VfUkVTUCkpIHsNCj4gPj4+PiAgICAg
ICAgICAgICAvKg0KPiA+Pj4+ICAgICAgICAgICAgICAqIE5vIG5lZWQgZ28gZnV0aGVyIGFzIG5v
IHBhZ2UgcmVxdWVzdCBzZXJ2aWNlIHN1cHBvcnQuDQo+ID4+Pj4gICAgICAgICAgICAgICovDQo+
ID4+Pj4gICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4+Pj4gICAgIH0NCj4gPj4+IFN1cmUgSSB0
aGluayBpdCBpcyAianVzdCIgYSBtYXR0ZXIgb2Ygc3luY2hybyBiZXR3ZWVuIHRoZSAyIHNlcmll
cy4gWWksDQo+ID4+DQo+ID4+IGV4YWN0bHkuDQo+ID4+DQo+ID4+PiBkbyB5b3UgaGF2ZSBwbGFu
cyB0byByZXNwaW4gcGFydCBvZg0KPiA+Pj4gW1BBVENIIHY3IDAwLzE2XSB2ZmlvOiBleHBvc2Ug
dmlydHVhbCBTaGFyZWQgVmlydHVhbCBBZGRyZXNzaW5nIHRvIFZNcw0KPiA+Pj4gb3Igd291bGQg
eW91IGFsbG93IG1lIHRvIGVtYmVkIHRoaXMgcGF0Y2ggaW4gbXkgc2VyaWVzLg0KPiA+Pg0KPiA+
PiBNeSB2NyBoYXNu4oCZdCB0b3VjaCB0aGUgcHJxIGNoYW5nZSB5ZXQuIFNvIEkgdGhpbmsgaXQn
cyBiZXR0ZXIgZm9yIHlvdSB0bw0KPiA+PiBlbWJlZCBpdCB0byAgeW91ciBzZXJpZXMuIF5fXj4+
DQo+ID4NCj4gPiBDYW4geW91IHBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbiB1cGRh
dGVkIHNlcmllcyBvZiB0aGVzZQ0KPiA+IHBhdGNoZXM/IEl0IHdpbGwgaGVscCBtZSB0byB3b3Jr
IHdpdGggdmlydGlvLWlvbW11L2FybSBzaWRlIGNoYW5nZXMuDQo+IA0KPiBBcyBwZXIgdGhlIHBy
ZXZpb3VzIGRpc2N1c3Npb24sIEkgcGxhbiB0byB0YWtlIHRob3NlIDIgcGF0Y2hlcyBpbiBteQ0K
PiBTTU1VdjMgbmVzdGVkIHN0YWdlIHNlcmllczoNCj4gDQo+IFtQQVRDSCB2NyAwMS8xNl0gaW9t
bXU6IFJlcG9ydCBkb21haW4gbmVzdGluZyBpbmZvDQo+IFtQQVRDSCB2NyAwMi8xNl0gaW9tbXUv
c21tdTogUmVwb3J0IGVtcHR5IGRvbWFpbiBuZXN0aW5nIGluZm8NCj4gDQo+IHdlIG5lZWQgdG8g
dXBncmFkZSBib3RoIHNpbmNlIHdlIGRvIG5vdCB3YW50IHRvIHJlcG9ydCBhbiBlbXB0eSBuZXN0
aW5nDQo+IGluZm8gYW55bW9yZSwgZm9yIGFybS4NCg0Kc29ycnkgZm9yIHRoZSBsYXRlIHJlc3Bv
bnNlLiBJJ3ZlIHNlbnQgb3V0IHRoZSB1cGRhdGVkIHZlcnNpb24uIEFsc28sDQp5ZWFoLCBwbGVh
c2UgZmVlbCBmcmVlIHRvIHRha2UgdGhlIHBhdGNoIGluIHlvdXIgc2VyaWVzLg0KDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDIxMDMwMjIwMzU0NS40MzY2MjMtMi15aS5s
LmxpdUBpbnRlbC5jb20vDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg0KPiBUaGFua3MNCj4gDQo+IEVy
aWMNCj4gPg0KPiA+IFRoYW5rcyAmIHJlZ2FyZHMNCj4gPiBWaXZlaw0KPiA+DQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
