Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21A1C43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 05:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42A8F825CA;
	Tue, 14 Jun 2022 05:37:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pbF8j5xUSqyj; Tue, 14 Jun 2022 05:37:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C59C825B9;
	Tue, 14 Jun 2022 05:37:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC384C0032;
	Tue, 14 Jun 2022 05:37:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E27ABC002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 05:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC7284151A
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 05:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kTbSgCl9i3RB for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 05:37:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B717541519
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 05:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655185021; x=1686721021;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UQLTjMIZ/sXj3sPCr2bTxd0gG0Iun4+3IhwHosFViCk=;
 b=AFdjRdd8XzrnSS/8VsXzRqTVX8Fdw/Gc+pVg9Kl/u5tsXCt2jQYDRutn
 aFjIwFNw1zTqDAPpTgSVNoJDka26sKCp1ZY4lTe3Rq4NlYuWoGNmn5Xh8
 C0/WdGXr3eBrxVUx3wPf9ba8t0GIx0QjMTy1BhREtfOHckIUiUUQkSPUx
 K4AT5uu7mFVsOCrmeEZwlXVjfz84wYd/TdM8CSdiuGZAQjmyR1csDDg5I
 WT+27oZQiWafJZCBk0LKFA0REfDrJZwl++EIgF+OQeZixMKHuAdYxRycr
 7z26RcPICzbe3kVWAZOYRu1KIbPzgvmyJ6zbsDZdiRELz+hUjmo/L9AXQ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364846414"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="364846414"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 22:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="569756060"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga002.jf.intel.com with ESMTP; 13 Jun 2022 22:37:00 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 22:37:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 22:36:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 22:36:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOV6Mt5ZbT5g7GvbMd8JEDwII12vRGMdaK7Pr9p5bssXCX9UBOIUZTgNHC1dds6J7jb+D8QW+7Q9RsCt28uZeWZlJtldXN4/4tFoQZ3MRBKYl1nyTGgoAVP7Dv/2O+3yV+9aPMsbXBgDSgDah0v/pJAt8otPfoFYyxFDKegd4YbZCniLuxbeUekRflYWPy2ZrvlyOIi8tGQ3ddiryLo+S8C1tcvgm5KbdPxoU5KMfCte+YIZ5shrya0up31s08CqjVPcfaUFzMsmbDic8WU9gVx5LEyXpVJ/StNRLIvwvYPsYqolS4AdhZeoXHg3KcHFG5X5vV0PuzKEhPfjKI7PTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQLTjMIZ/sXj3sPCr2bTxd0gG0Iun4+3IhwHosFViCk=;
 b=B4FWMPDaLUAm8AoUC2dA0dRqwcJIlL+fszVD5CP8vAFew9BUi9UBBT7NeF5qkejzgFTR2MJtcrf09rKd79ntccSd84VYYLcD/7MCY88xSPIZm6LjWGs0tyg2sDYQ3/ICemXIJttPSDEF86+K5kqw/YTP0RIUXkfOQUf9ya3NPDosHB501yZraxCQnuFawumEOIv9+YIszCUmVTrJ+Jw1x7FdgU8oQf7piZ+DFHm76QmNO8XJbPB/XHbfBaF0v7U+L6JEoYekLGfFBy/E6/oz+UKLW5wB+1NOPyEriURw7aDBsUXssVPdt7vhrU5Usp+RRq7pAwoggQBKN5wCKz+rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4345.namprd11.prod.outlook.com (2603:10b6:5:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Tue, 14 Jun
 2022 05:36:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 05:36:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Thread-Topic: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Thread-Index: AQHYf6GWvMc4HxovbUuxK/w7aTPg8K1ORtLggAANygCAAAb88A==
Date: Tue, 14 Jun 2022 05:36:57 +0000
Message-ID: <BN9PR11MB5276DF2C87451A1164A995FB8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614034411.1634238-1-baolu.lu@linux.intel.com>
 <DM4PR11MB5278EBE8FA26185D91ACCD118CAA9@DM4PR11MB5278.namprd11.prod.outlook.com>
 <2d2a52db-70a8-788e-fedc-197789caa145@linux.intel.com>
In-Reply-To: <2d2a52db-70a8-788e-fedc-197789caa145@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94ce135c-9ce9-427f-ccb3-08da4dc7e581
x-ms-traffictypediagnostic: DM6PR11MB4345:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB4345D667F681DFEA1C6E7B198CAA9@DM6PR11MB4345.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QX8ulOFitVA98GqMfuPypcDG6WrpRXeg+9HdH0BTUaUq1Os4mrYEbImOo0hFGoBkA37A3S5I49YcyEemoyJIvQPEtY0Z/a/gkf8OSnHubviJZDPXj50ga/yOndcB+UBLtq/Fp2LaYZ2RJAH96fUIZfzU2s+9DOtoCoA2usLyW4p+oZT5Sibmd0+YTG+wuhqKtkW8xwFAH1I9lmW8PzQx9TGbUyyrXuPucNVp6AaABs2Fnx2fE6G1c368KhVMMya9PuSlKhfM9Emux4MfK+ccDyU4pkSY6+MgL/o9DxZx9ZJ4saEbX+StAK7vqsjMlbHpQ+4ZVmpY70VoX+jz6VzGZHiDphVnpH5yaQLF941CS7OlNQ75UY2qEs2saUI9GNNk3BQm69cPJntNi2uCxmA7NGRQBCvnObAdkJwSBnIXBPe/jWlwsyywC0GPqIbpjH5ZVwdeCjg9yrvbhUuLWTtKzzJCW7kI71a37lGRMJd6Dh9+Ce+0WS3GSWZRhcxBMyyFQHDQC8HFLWapNT1jxmWrI6O0OnSyOsQV4VlUJxrgCzCc9xWClq7dr6x/Mii/X/ZaQwxD9lIv3XX3k8dYjlXgSlbgz3rozJmm2OdPMJ+p6omk2lQ3rRQDAFs4875qbgo4A+Sa4LL5XNYiWWI3ByU7mPupLokIlGsPOzNqa34yRQ7Q6kYwTjnHGcsCbwyzEFT/MzDJU5qwrwVZlihApaCbeQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(38100700002)(86362001)(9686003)(26005)(8936002)(122000001)(508600001)(316002)(52536014)(2906002)(33656002)(55016003)(5660300002)(82960400001)(76116006)(38070700005)(186003)(66946007)(4326008)(64756008)(66476007)(8676002)(66446008)(66556008)(54906003)(110136005)(7696005)(53546011)(6506007)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2pBd3N3SlJRRzlhY0Y2Z2dRUk45b2dYQyt5NS80aGdZYkRVSWt0amlObHh0?=
 =?utf-8?B?a1JEeDB6WE5jU2t4TkQ3MDNvUHowM0dkSTFORWdJY0V2cjRNTWd0ZGlXYUxB?=
 =?utf-8?B?eHgzYk5ZMkQwc1VzTFIvTHNzaXlPbHV6NTNwUUgvMDU0QmhiU1pzaDAzTFZB?=
 =?utf-8?B?VUV2N0dCRUl3SmoxNUh6RzI4all0WnlPcUhUalRDMjU4aEtZbFVoTEtmY3Bm?=
 =?utf-8?B?UG1Dd3RpRGhhdmdEcXdtQm45eXlDT0JUUVN3ZnQrMXVqT2RVeU03cjBCeWNN?=
 =?utf-8?B?TTM4c1VjcGNBL0VXM01HR1ZLY28xeGxSSWdLM0lyTytWZlVTNWsvQWlsY0NQ?=
 =?utf-8?B?eHBPRjh1eVRhSkgvNUsxVzJzc1N5RGdhbzhWMG0vUVBESWRveG5VdXZMSHd1?=
 =?utf-8?B?MXdWK1FqbEZWREtZTHlVK0hNc0crZ2dCL3g5K0ZNTDdZQzNTay9Qc1dHMEZm?=
 =?utf-8?B?YzczdnQvNmN6NG9UMFFPK1NnU0tKWDdkcWo2TUlmVVBDYkVLRHFIOUhsUUlH?=
 =?utf-8?B?MXhiVk03VWV0Tk5SMXVWZWR2ZGN1RkVYRS9qTWJyQUE4LzMvRUVjSlEzQ0tv?=
 =?utf-8?B?VWdoQTBqZm1XRy9PcUVQZ0NoeDNNUkxYZVp3aG5zNTdxR3l1MEMyWDJzSXpO?=
 =?utf-8?B?Y2Q0SFZLRUU4YTNjS21oRExCY01GQSsra2hPNGF1cDRYWDFRSlNkOTdvQ1NJ?=
 =?utf-8?B?RUNMcHg1Y3ViNGJQRXNwK2xGUGRhVThJK0Qxbnp5d281WXdsUmtzaWNycXJD?=
 =?utf-8?B?ZGhFWm9CUjVpM3JlMDZiQmdxclp4K25vS1JJWWxzM1AvdFNDVkpxL1A2cUtT?=
 =?utf-8?B?anBjV080b1JxN1dtcjhuVzJwakd4ZmdoZGxHNkVOWG45K05CejFXdnYzUXJk?=
 =?utf-8?B?bG5uSDBaMHl1NkRnUkk3cVlMK0tGL2c1c2R4WVloMDdGSTcvUmJNRGQxbEV0?=
 =?utf-8?B?K2w5SUZ5TVRVY3RpbFRUbmZiV21JT1VzQzI3NWdKWU95emZlUHc3cTFEN3ND?=
 =?utf-8?B?ZEJuN0JkZ0R6NlZRMXBPeDhuRWh1Mk9NOGpod1dzY2dONDRJNHZDZ25XQmQ1?=
 =?utf-8?B?dEpQY2RKb1lUR2pIT3VtajNKa0R4a3NSK1hLZFJVZXYzVVd0YUpFNi9QaENN?=
 =?utf-8?B?UHozV1ZJL1I2T3JMK0FWcjBlRnhQU0ZLMkZlMkR1ZEgydXFvbHdOSzY4emcr?=
 =?utf-8?B?Z0JIUnkrRThYOXdPSkFCZVEyOTRmTlZCbGNHb3Nhd3NFTHRtYmVuUUw5QWNH?=
 =?utf-8?B?WDliTHZWQWM0UXVIK2wySU5oc2RjU0ZiL2tHYXdMZ29JRXF5U0VjME5MbEZF?=
 =?utf-8?B?dnhaV1Z6UnF1SFJkcXdaTFN4STlSUWtKNGtiWTJocWVCSEhSZDFJeXdiamt2?=
 =?utf-8?B?aEFzQXN4elBlSVVhVnFyNmo2dXAwY05HNFRxRDM3U280QzgwcmRjTGxnVDZl?=
 =?utf-8?B?OXB0UUdQKzNWVTJNZGFZNEZzall1RzI5ck5Gc1lJOEorVjZ0UGdHdTdIOXlL?=
 =?utf-8?B?bTQxSis5aHBSTldyZ0txMEc1WFRrVFpBVWdDV1o2Ryt5RjF4VHNma09ldGV5?=
 =?utf-8?B?U3lodGFrN01DaVdtWUhnTnZmTjRDR0dDRFJYTXdweWJway9ZbjhSa1ZWRlE4?=
 =?utf-8?B?Um00dDJCTnBQajVTb2U3QTJibjNGVy94NzFxOXBWUlNPclp3SkY4cE42Q1Fk?=
 =?utf-8?B?aDY1MFBPOGtWcUpCYWNzdldjbkVodDFsN00wbkZOU21NZEppWCtJODZEVkxz?=
 =?utf-8?B?L2lBQlpNV2FlNlFZV0tjdk5wbkdscEw0SDVkelJQb2pSV1FiSXdDc0lMREQ2?=
 =?utf-8?B?WUR6WGs0akJWKzdnc2RSNEI3UWhObGFXQk1vRWNLcHBJK3Z6Z0dTMS96bkFB?=
 =?utf-8?B?a0IxVjlWamcxRitYQTBmSXE3aEhMQXp1aGRoV05IdEpYVkxUTnlmQ3paTkYz?=
 =?utf-8?B?TVp2MVQrYmJsQ1htMUwwM2lvVC8xZW9LNm5JUjVaMGdXZWVCeGV4VDBOMU5w?=
 =?utf-8?B?VHQ5MFp1YTdXY0FSMXFLRjdqMFRMZVlCU2U0WFJraGVtcVpRQy9IN3hPb2M2?=
 =?utf-8?B?LzF1bmFNMzk2SUFhSkJZeC9neGNXVzhsa2tFaG94VDYwS1pjVHBoSTdWWWda?=
 =?utf-8?B?NjlGRjdHSDhqL0ZoYmpNcDFVbHFYMHJybXFyRHYzYjE4WHdJSGVCYXlKelhq?=
 =?utf-8?B?bmlKaFo4WWRsYWdHL3ZGTkY0d1hhTkZiQzNPdkNEbEIrVDZ5cFJjU0NzazhD?=
 =?utf-8?B?dmsyRlJqWWlzd2lOZjVOQ0xRYnJ1YjJOWlNGSjJubElIb1VERXlCWU83QkND?=
 =?utf-8?B?L1JSdVlOY3hBWmRYanFYajA5c2U0c3pvczVvUmpQREhNM1NmcDFvQT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ce135c-9ce9-427f-ccb3-08da4dc7e581
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 05:36:57.0353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEPL1hj6g8YAAw/dQp4a2UzEO91JH8UzrxupPD+i3yKV8IcfdvGY1pUeVVN5az4f15uRAA/wt45dAoJg735/1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4345
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

> From: Baolu Lu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 14, 2022 12:48 PM
> 
> On 2022/6/14 12:02, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Tuesday, June 14, 2022 11:44 AM
> >>
> >> This allows the upper layers to set a domain to a PASID of a device
> >> if the PASID feature is supported by the IOMMU hardware. The typical
> >> use cases are, for example, kernel DMA with PASID and hardware
> >> assisted mediated device drivers.
> >>
> >
> > why is it not part of the series for those use cases? There is no consumer
> > of added callbacks in this patch...
> 
> It could be. I just wanted to maintain the integrity of Intel IOMMU
> driver implementation.

but let's not add dead code. and this patch is actually a right step
simply from set_dev_pasid() p.o.v hence you should include in any
series which first tries to use that interface.

> 
> >
> >> +/* PCI domain-subdevice relationship */
> >> +struct subdev_domain_info {
> >> +	struct list_head link_domain;	/* link to domain siblings */
> >> +	struct device *dev;		/* physical device derived from */
> >> +	ioasid_t pasid;			/* PASID on physical device */
> >> +};
> >> +
> >
> > It's not subdev. Just dev+pasid in iommu's context.
> 
> How about struct device_pasid_info?
> 

this is better.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
