Return-Path: <SRS0=NY8N=G2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F16C433DB
	for <iommu@archiver.kernel.org>; Sat, 23 Jan 2021 08:59:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B56C20825
	for <iommu@archiver.kernel.org>; Sat, 23 Jan 2021 08:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B56C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1064787459;
	Sat, 23 Jan 2021 08:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4TESHwhLz359; Sat, 23 Jan 2021 08:59:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1C7B98744D;
	Sat, 23 Jan 2021 08:59:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E56AFC088B;
	Sat, 23 Jan 2021 08:59:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A59A6C013A
 for <iommu@lists.linux-foundation.org>; Sat, 23 Jan 2021 08:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 93182868D0
 for <iommu@lists.linux-foundation.org>; Sat, 23 Jan 2021 08:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DEUQYWtYIYH6 for <iommu@lists.linux-foundation.org>;
 Sat, 23 Jan 2021 08:59:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CEAC9868CE
 for <iommu@lists.linux-foundation.org>; Sat, 23 Jan 2021 08:59:28 +0000 (UTC)
IronPort-SDR: sqS4e8tTCz/cSsD9d7nzoBDauJ2yZUsiySfFwVrgUP+sla8YE2hTXmoNWUttxJiFP2H/QYNXT6
 2kWYjRxfKehg==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="179635414"
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; d="scan'208";a="179635414"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2021 00:59:28 -0800
IronPort-SDR: IKVjQ340c1kNy2iP4/h6yJtjsE/hs02FjNA9zwOh+UtVxTHnH3EMgEOwCMFzjYSgZ0B0mcyXPA
 Zl7Veeg3CQXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; d="scan'208";a="386208990"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga008.jf.intel.com with ESMTP; 23 Jan 2021 00:59:27 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 23 Jan 2021 00:59:24 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 23 Jan 2021 00:59:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 23 Jan 2021 00:59:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 23 Jan 2021 00:59:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhzMRpxBJr5OMjzkdXdtF4btc4bDp2DfBUiPpqOBzfmGi+a0HdAv9/Cxa37syqVXEqoIMNHvAH1hOCX7z781XtmENTU/fHcMlZ5jsztOOzUXQw4exMVetzvWOc5HSNC00DUbKnpIBAHdZJ7Hf13pyqAszRclqNZV32rymL/DWf6jHYUVBkoRfqsIdt7lrmP8l4ZI+j2SNlb/vPGfq7HW+xdYrs8+6ZcSngtiw1PWl4IQtW3X2E7OYnN5PgNpWQsrUEM52DK2EBSEYhAlNpOu65aSmpJqct2lsiAlYXrDDPvs5rxcR+kHxZJVNGmafx3FqTkf+4udhkyalCz3vnKpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azp6IqYlsJk74dmJy9/su6Sop0r3J/PumGk3Q+ab+vw=;
 b=mn+2h0yHhu1eSuEnpSX7KrIxe1itHtu+yKEg3qnFY0gJRk18nVP9qM3qYULoNgCXSbfBy1NL4xjU+edxllm2dlP0QVni1+r0lR8g9P5RJp5EH1OoWb28xhH7Vq2577N1U20A2XdX4rfX9x69JiExFePAKvEoFE51C6TRhUEt8fNY98BrUwAY9ib7xyi0axwk1i33w8LkVEhkt7Z4dTElfbhc8oj0ZozLgVuLbgOI59bH2f4HbFXTziDhZnDgLNLhU9QVcgMdpNGZ1yELk5cIztnP1H74+la/hiOXgg3flLygRpCwnt36pJ6h2UrVKjxh26j57v+mzse6/1/cEzpSJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azp6IqYlsJk74dmJy9/su6Sop0r3J/PumGk3Q+ab+vw=;
 b=U92/yzaLfrnmoLwX3SlY7iiF2NqsTkNLX+HA5REaBBRoNW5Vvm+jQuibc3JekuIqIEBH5ipGNf0qBVjzg9pazF17z6TD5L6lfzHF+y5Q4i8PTnGHEgFBv5LLiz8O15m/XEcR4Ludcl/xOaye4t+ByQBNFOcFWfqDdyM3pJG8dnI=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3146.namprd11.prod.outlook.com (2603:10b6:5:67::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.14; Sat, 23 Jan 2021 08:59:22 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93%3]) with mapi id 15.20.3784.015; Sat, 23 Jan 2021
 08:59:21 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, Vivek Gautam <vivek.gautam@arm.com>
Subject: RE: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
Thread-Topic: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
Thread-Index: AQHWh19ACfcP7ssg8UC1cgpZfCvfJKokT6+AgAAjF2CAACQ7gIABOtBwgAm0EICABjauYA==
Date: Sat, 23 Jan 2021 08:59:21 +0000
Message-ID: <DM5PR11MB143531EA8BD997A18F0A7671C3BF9@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-3-git-send-email-yi.l.liu@intel.com>
 <CAFp+6iFob_fy1cTgcEv0FOXBo70AEf3Z1UvXgPep62XXnLG9Gw@mail.gmail.com>
 <DM5PR11MB14356D5688CA7DC346AA32DBC3AA0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <CAFp+6iEnh6Tce26F0RHYCrQfiHrkf-W3_tXpx+ysGiQz6AWpEw@mail.gmail.com>
 <DM5PR11MB1435D9ED79B2BE9C8F235428C3A90@DM5PR11MB1435.namprd11.prod.outlook.com>
 <6bcd5229-9cd3-a78c-ccb2-be92f2add373@redhat.com>
In-Reply-To: <6bcd5229-9cd3-a78c-ccb2-be92f2add373@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd83a3ab-e251-49a3-5db5-08d8bf7d2cf1
x-ms-traffictypediagnostic: DM6PR11MB3146:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB314643BB53F5E0544E505048C3BF0@DM6PR11MB3146.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8GvGTfsc61RwnvTnQIdxmyRHllmuqe20r71EEbOYdRfPPkNexk5Ne8gvQ9CguucOhPjm/Z9k9E3SUFSngm3X9acWyYnZMOYdv6gJ4vGCwWI2jNRGtGFpLDXuUnW8kdCmqg1Dage4A+kimw8531LgOlZYnOoPKN/bbQr3+BxKRI93pdCIm4Zfpbwvs54grwgmmMOwBuLwPvnQ4cNKdEcDTQLttMdmXkHNKSumTMbgLWu0iEcklPXPgcxUbEuYAtHWJxwMUQKpL07TmthIbbM31XZWVudlxEA+SlBPtG9MGzo+iIK/+/oGzM+tK9Kkjq+TqMwhcRevfAkfesKCYhTFykTu7ChfMSnqh6EUozuSOk1gtkZAQ6C0oACosCltjgoTgS5Vi6EQyJWv5Eu2KJQJ/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(86362001)(83380400001)(26005)(7696005)(55016002)(5660300002)(186003)(107886003)(54906003)(6506007)(7416002)(9686003)(33656002)(66556008)(8676002)(316002)(4326008)(66476007)(52536014)(4744005)(76116006)(64756008)(66446008)(66946007)(2906002)(478600001)(8936002)(110136005)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?QUlCUERmZE5LMG9xMHc4WU40MFo4ci9xekVCcWZTNmxTeU5nQ1lPTHVxK3hM?=
 =?utf-8?B?TEhIRURPRlVTRTFEMWJRNXQzVUZEWFl0NlloTU9FVTVhaUZrUVFHcGJRMEZ6?=
 =?utf-8?B?dnFGWEUzY3dyV3NoU28yU05GdkRzaERSSlFzV3VVSWdPTThDVDZWZXd2WG8y?=
 =?utf-8?B?emZzVWFKU1NSTEdGZEVpc28zeG5UUUw2dDE5SGNTaGhXTXpSUU4xL0xCNGI1?=
 =?utf-8?B?dHdpaTQ5bDdqOWVFSEdxL3pXOFZnQzZxVGd2STFpQWhCZkM1UW1zK21qZkMr?=
 =?utf-8?B?ZSt6TUxUQm5sWFFocFVQV1h5TkFFem1oKzJLNGszSzZxa1BSVWdQZjh1OEdo?=
 =?utf-8?B?ZEk4eUZwM25ZWk5sQjN6U3dGQjVZclEyQXBBNFV4ZlRNUEVsbUVIcjl6YnFL?=
 =?utf-8?B?Q3VMUSt6M2dJL1hhZlZLVXlLaXRPbElmWUFCTE1wMWU4VG00K1dSeUlqYytm?=
 =?utf-8?B?YmE2SEtQcU5JSnpNVm02eHVUTUQ3V2VOYlNOcEhTNzk2L0hHRi9udkRCTUgr?=
 =?utf-8?B?ZFRaNjFVZkhKUGZRUFhpZFNXZk9GVkl5Wk53M2NzVm1QOVFjRWFGUlcvTUJj?=
 =?utf-8?B?S01SZ2tqbVFoK1ZjTkEra1BMMmwwWUVoSGZ0aWRJaWpGUXpTVHB0WGNld1RC?=
 =?utf-8?B?NkFweUc0c0lHRC9vamFQSnJkbzdkMlFnRlZuTlNHR2pNR2RDUkhoVDNXbERq?=
 =?utf-8?B?NDUwM1ZEWVFsMEE1bFBTMkJNLzZzTnp4WkFuOHRLRU5ONTFkYVA3QXExcE1F?=
 =?utf-8?B?YUNJY09HZ2xEVFhYTDd1NXZMUklKUGFuQklmc3dyTTV5SzhtamE1UTBqWm13?=
 =?utf-8?B?V0tENW1PWU1PVDg0Y3VOZ1Zya3oveXlBMCtNMUlRaEJrQU96K0lpa0ZVTUVX?=
 =?utf-8?B?cWdJTkVuRUpJTTRlQlAvVDR0Z2ZPR3hZRGZPbTFseVJmd1ZqL1F5VWN4V2J6?=
 =?utf-8?B?N3VuejY1V3pmVjMwRDE4YzdyRWhpKysvUlEzY2MzOUtRbm1PSUVRMUdidUxD?=
 =?utf-8?B?NHFOUTRiN2tvWVFpTm42R05LOWxtU2Y2aHdaTXI1KzNJSktqYnV0ZVR2K2VL?=
 =?utf-8?B?VVcxcEdtZE4vcXJ2a3Y2REJQVHRmWEJZR0lYSDdMK1lSMUVMQnZPZ1MwTXJN?=
 =?utf-8?B?WC9XYWZGYU9mZjBRNmpjQ3JnbnVobStDaEgvNERBRG9RdHAyMjdTb0ZyTWF5?=
 =?utf-8?B?TGFkbkJ2M2crUERBQUR0d1ZjOXFhWmUrenNtR3BVTTNzc3JSN0dkRnVtMnI3?=
 =?utf-8?B?QzRLZ3lCanU0N0xpelU3MjJTQmRUZ3pOMnpqN0lRbmVlN1F0aGxEQ0lZMWFm?=
 =?utf-8?B?K0NVVysxOFdpaG1wUHdwV1N4U1lQTUp2c2xyNmxoRXpEeitpSlFncjJJOHR1?=
 =?utf-8?B?b01xdHViQTRFMVFpRXpJYzJvbWxyQUFHcW0wb0RwcmJ2bEdzTmxKdE1sQXRw?=
 =?utf-8?Q?wobqzhma?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd83a3ab-e251-49a3-5db5-08d8bf7d2cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2021 08:59:21.7438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pL+drByBVAL8E3J+2ZwKpZErWKikRBVY8Tv07mJC+7mBME6R2E7L5OP94tlQuc+u9PI7Hifuld3rhMfFH9SZAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3146
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>
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
IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTksIDIwMjEgNjowMyBQTQ0KPiANCj4gSGkgWWksIFZp
dmVrLA0KPiANClsuLi5dDQo+ID4gSSBzZWUuIEkgdGhpbmsgdGhlcmUgbmVlZHMgYSBjaGFuZ2Ug
aW4gdGhlIGNvZGUgdGhlcmUuIFNob3VsZCBhbHNvIGV4cGVjdA0KPiA+IGEgbmVzdGluZ19pbmZv
IHJldHVybmVkIGluc3RlYWQgb2YgYW4gaW50IGFueW1vcmUuIEBFcmljLCBob3cgYWJvdXQgeW91
cg0KPiA+IG9waW5pb24/DQo+ID4NCj4gPiAJZG9tYWluID0gaW9tbXVfZ2V0X2RvbWFpbl9mb3Jf
ZGV2KCZ2ZGV2LT5wZGV2LT5kZXYpOw0KPiA+IAlyZXQgPSBpb21tdV9kb21haW5fZ2V0X2F0dHIo
ZG9tYWluLCBET01BSU5fQVRUUl9ORVNUSU5HLA0KPiAmaW5mbyk7DQo+ID4gCWlmIChyZXQgfHwg
IShpbmZvLmZlYXR1cmVzICYgSU9NTVVfTkVTVElOR19GRUFUX1BBR0VfUkVTUCkpIHsNCj4gPiAJ
CS8qDQo+ID4gCQkgKiBObyBuZWVkIGdvIGZ1dGhlciBhcyBubyBwYWdlIHJlcXVlc3Qgc2Vydmlj
ZSBzdXBwb3J0Lg0KPiA+IAkJICovDQo+ID4gCQlyZXR1cm4gMDsNCj4gPiAJfQ0KPiBTdXJlIEkg
dGhpbmsgaXQgaXMgImp1c3QiIGEgbWF0dGVyIG9mIHN5bmNocm8gYmV0d2VlbiB0aGUgMiBzZXJp
ZXMuIFlpLA0KDQpleGFjdGx5Lg0KDQo+IGRvIHlvdSBoYXZlIHBsYW5zIHRvIHJlc3BpbiBwYXJ0
IG9mDQo+IFtQQVRDSCB2NyAwMC8xNl0gdmZpbzogZXhwb3NlIHZpcnR1YWwgU2hhcmVkIFZpcnR1
YWwgQWRkcmVzc2luZyB0byBWTXMNCj4gb3Igd291bGQgeW91IGFsbG93IG1lIHRvIGVtYmVkIHRo
aXMgcGF0Y2ggaW4gbXkgc2VyaWVzLg0KDQpNeSB2NyBoYXNu4oCZdCB0b3VjaCB0aGUgcHJxIGNo
YW5nZSB5ZXQuIFNvIEkgdGhpbmsgaXQncyBiZXR0ZXIgZm9yIHlvdSB0bw0KZW1iZWQgaXQgdG8g
IHlvdXIgc2VyaWVzLiBeX14NCg0KUmVnYXJkcywNCllpIExpdQ0KDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
