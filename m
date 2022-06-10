Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BED4C43334
	for <iommu@archiver.kernel.org>; Fri, 10 Jun 2022 09:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC38341163;
	Fri, 10 Jun 2022 09:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MOACfG0MsbEY; Fri, 10 Jun 2022 09:01:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D02EC400A4;
	Fri, 10 Jun 2022 09:01:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A601DC0032;
	Fri, 10 Jun 2022 09:01:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06E18C002D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 09:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4142842BF
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 09:01:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jxZjB93Ggwu4 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 09:01:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EACC88429C
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 09:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654851709; x=1686387709;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=++MHfGeKtiOTf8SP6YyDfmR09y6LW9GTnJ7TuWSHr7o=;
 b=bi43Rb/QiCHsyUAu/6d/MgCe8iS5Y8v37Q3QrLHb/IWhKJeM49rnYMFG
 hCw5rbZvtoxR9BCEbARi7Ub40W/uJGd5FAe3xtLTrHR2s1njOWDHzWozH
 7SXgtYX4f5ReLv/UAgqwNtNu2W5dXtX/c5ybtW2fK7MY1ukIxE6Ec4i62
 4DEzPj5fu8uoB+BVjYLD+d6OuockF7peNXa+Oxdbp9sRGbXcRAPNU4Z/O
 5PAASeS+Tm0CrwwB6c7H4aVgPs/N7YXnBv2nLxfsIn5idXqYK6B8dv52z
 qj0499VUgRX1i1garuCKbQmdrHVOVNbAc/d4fMFCtXe73CirP8A5DUs77 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341630929"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="341630929"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2022 02:01:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="580984948"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga007.jf.intel.com with ESMTP; 10 Jun 2022 02:01:41 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 02:01:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 02:01:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 02:01:40 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 02:01:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xkg5FfeyDlGon+EdCgqsE9IbxIjF05Oet4iDvyl/ImUKYYDs8HDNZe3J7DGzv5P19Q666FAKbpGmH30ew+9mE2pbDVF02QcOEKTCEN08UQ36TLsxC2XGTvcdxOVOaT2nwAZbBaQtWgqbrq2K+UrmJZylYcP1x2CVS2jJehCEgPiU/gqBjHr7f14NIZHrUZl5a57YnlmpUx62W8bnn+5tUleJahyBSkMuyD8dvhbgBRUOp/1YyQSklgTbbT6OhtL7/9Igg830IHTpMxiB1++cPbsdrdSBRtsSItEeZD0t3sFoudJ+dp6ACdkDMbzNAN+xmlvpuxly/6iXoRgut5vLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++MHfGeKtiOTf8SP6YyDfmR09y6LW9GTnJ7TuWSHr7o=;
 b=PiefdxeTbRVsMsYvO5a7EcjlBKNbLGTiZW48hDQKsKuH31T+OhBrY7tLwWCHr5ioIfHQQ5UTvZagRWn7uI2bqzaBGXFs55tf+CXhXIBuae3JmrX3ZfHYnyrrr20zFpqqDqowPj2oWu/w3TPzyEkkIr3FJs/K4Wu1QyK7DaDt7HVLNVXRMFLK67Gd8nmSEUAJ9Jkee84zMeancYKXQ2U/lK/ikOivQaY6BeR4nI2GmbxtBwtXf7aNmRmbE9ThJ0L1Wx5uaFCCnPH370dw+wJSo50kk7GLPK8C5h1o0U3cwWXng3dAa28N+fZtvHh5ddNYJnPvSIbF0SXMtn4gp8Gtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5877.namprd11.prod.outlook.com (2603:10b6:510:141::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Fri, 10 Jun
 2022 09:01:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 09:01:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH v8 02/11] iommu: Add max_pasids field in struct dev_iommu
Thread-Topic: [PATCH v8 02/11] iommu: Add max_pasids field in struct dev_iommu
Thread-Index: AQHYehFqfLSA0C1VVkGHz+EI1qcA6a1HcmMAgADFNQCAACEyAA==
Date: Fri, 10 Jun 2022 09:01:38 +0000
Message-ID: <BN9PR11MB5276C7B4FAC55C58A5466EFC8CA69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-3-baolu.lu@linux.intel.com>
 <20220609190102.GC33363@araj-dh-work>
 <f92629ef-8c9a-b89a-ef0b-32e71617bd51@linux.intel.com>
In-Reply-To: <f92629ef-8c9a-b89a-ef0b-32e71617bd51@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7690696e-2f82-4373-527d-08da4abfd41e
x-ms-traffictypediagnostic: PH0PR11MB5877:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB587796169E374B05EDC5D4B98CA69@PH0PR11MB5877.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V93xCQUMmLlPBCkICOpF1uHclpbVj5xJScHF5pnIA5pvj4JN2+GH6gtbIpbU22ZCs+ZTXJ7w4DAE79IuWraY82El2ZWiuQzGfxTQz0N5hpZYJEjiIXnC7mKuC/f2VMysc3Uf8QFsQQNFbL4+CabkktQ0Lj1dqi0ZBMOhe34+eFrq6dEsdeBwJn+cCLWDB12bBpVxP9rm+ljIw6IgrV4O9z4CjMYUinHizlGu1zhrFTgBwBd5TeSGAYHmLatWtYErW3oAEmTU6QjepcRJ21sLic/YyCHyhW1lfnGpUPajodf8cahnxZmzfp99E5/XgJMsWKLULDaXjRGL6h9lG8hbrdR2gHr+3adM88tESe+WONPWOIAd31AtSzh1FlyoyKQG0w5J2VxQReeGO9AvpjP12KLwQKUhaUU/+oa9yxgruMffMLPW0BqPj7FIWDSe0g7/QVw/T5n5KLHNAUeUEOa+2SiFYX9jNuHoIMi//5XE/M8aK79kgu6DNRFB8Z2ovC+AQ3G1OfuJVtk9V5I+K4ywMgJGIOA2pKRxOWhaJ0wkbyxORGTBijCMWrOLuLXyqVa9vjOHkbgAT5y+1Wm1cX8ZU514dXaSGfLcLUGGGAJCSb3sq2gec3P8lqK+dBpCZaaETyB/b4t4EciQw3h6dhCJMB9EqH26nb2SGf/8DWmge3t5l4xqhw8Gm2bJ2b934MGyJv6WxVk0Dw41TJlPVFrp8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(54906003)(316002)(6636002)(86362001)(186003)(53546011)(6506007)(26005)(9686003)(71200400001)(110136005)(33656002)(82960400001)(508600001)(2906002)(4326008)(38100700002)(7696005)(7416002)(66446008)(122000001)(38070700005)(55016003)(66946007)(66476007)(8676002)(66556008)(64756008)(8936002)(76116006)(52536014)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wkd4MUs1NjdSMS94MW5PQ2R2MHBRdFpLNmR4OVlsUmI1WWxFUVpNZmtaWDdV?=
 =?utf-8?B?QVJTZmExemJadVQ5NTM5SW9oL2dsT21Xa1dlN1Z3L1NPTVRPY3N6bHJtL3JZ?=
 =?utf-8?B?OHBGaUZSY0ZZVk43MitxZjJiK2owNzhxeVVhQ2RQZTV1WXdSa0MvTlowQVlp?=
 =?utf-8?B?YVpidG44M0Y3aEJtUGRLd0hXa3Q5WVJsV1laYlVIS2dhVm5xK2NONE55cjlW?=
 =?utf-8?B?dVh0U1FGQnBlZjBNRFJDNWxPOTQyOEdiQWNVTEN2KzE5SGRuZGNlOG9JZ0VT?=
 =?utf-8?B?dzJ6L1kvdjI0dkhpS0FvdW4rTFNpMFB1MzFxQkpBS0l2VllhZHlWQkM0Zm94?=
 =?utf-8?B?a1MxRkZ0M2lqZ2V5Ulg3cWJsNVhRNklpQ05vNWYzVnB2dXVaUmhsWDRzMmZR?=
 =?utf-8?B?SXV2VXk1TmpTcWtXN1BDQ2xDQVlHQkZsVGh5NUZoWS9LeUJENFFTeXlzWFdr?=
 =?utf-8?B?T1RoamJqN0x1c2t1N1ZwRzZ3VFE1ODY5elkzRmtRT3FRaEVtcld4UG9FVWJO?=
 =?utf-8?B?UWh2UVAyQU5JbUxwcDM4cmYvTHhVV1ZDaGtQeUF2VTlZM1p5dFJ3ZFRvRzZU?=
 =?utf-8?B?OUpZclByWXJVWTRId0ZVT09Dek5ra2g2NDk0UlhvWUcwSEg5YmEvV2s5Z2dE?=
 =?utf-8?B?VnZ1djBiU1lyNTM0QWRWckZVUDNFa1pEVTZZY0ZaS0EwaVkxbXNRQ2VDYm9G?=
 =?utf-8?B?cC84L01nTDlQb1Nic2t1Z1pRUlJIc3FmektsNWVqMTN4Z1JEWTVGYjc1YnBn?=
 =?utf-8?B?TjJLZTA2V3laK0VKb01haHBRS3JKYU5zTTh0UUY4UXVUZWV6RytGazNXRmpJ?=
 =?utf-8?B?M25xTkQwdVVIeGFtVWdMalV6WkpiS3JXVVcrZlc1TTk4N1k0bmdYTHRRaHRl?=
 =?utf-8?B?UDRGNHBQVUdVcnFkcnNUY0RObWlnSWk2WktTMTc4U1Axc3l2TWVRdndJL0VN?=
 =?utf-8?B?UVRVWlRZVWVCZUV2ZGNuWG1HWVZwRWlhVVBXOFJoekphNVRWaDZ1bUJ4dlVV?=
 =?utf-8?B?UEVYKzRzNzFUaG55Yi92NXZRUXV2Mk9mTE00MVpYU1FmSVNadEJZaU5QejV4?=
 =?utf-8?B?d05mZG5MRjN5eFNBNlNlSGxFNUQ5VUdoTjZIQzlZcVFacmYyUDdqYjgyTEpQ?=
 =?utf-8?B?TzRDVEl0M0krTkY0bXQ4QUg0VStkUkhPcVRNTkpQZXJpS2dkSVdBUXhLam0v?=
 =?utf-8?B?TDFDOGFLQWhGVm9BZHZVbERZQUZHWVlRL1MwWXFETU5qQ0s2alUvNnBFclVU?=
 =?utf-8?B?OU1tYmZVcGw0MlZodGtlMFp4a3JEdmdpVXhLRHR3NjR3TjFNamw4TEJEL09N?=
 =?utf-8?B?UGhQNENtN0pXMGt0MUlDaElTU21rd2VMcFhZUG11L3I3d3orKzdPQzVLOWNx?=
 =?utf-8?B?dFcyY0pGMDZJaDVmQ1JKTnF3NnhYM0wrRlhuRWZhTUdmbkRtc2YxV2xHREE0?=
 =?utf-8?B?Mkt0b3U1bEQ4N2pSamNIRzlDUnRMUDNReU1mejdsU0h2K09tc3lJb2JTNkI2?=
 =?utf-8?B?WmhUVTYyL1JzdkNQLzdDbVZNVXpvaFIvVG1DaGlPbjdBUDBNbE1PUmZtUi9s?=
 =?utf-8?B?d2FIdXJiSXcyV09JbXhLbGhDNzdJWlFpMEIwVmducFlqVldiL09LVS85UmZT?=
 =?utf-8?B?dmtPdE1xemRKVWVGSW03U2EvWWtUSnNWNEJnRlR5QU1aT0lwKzgrM3FlUFpS?=
 =?utf-8?B?VjQ5bTRwUHVSTUJneVlDMDBDTTJNMHpvUVNWOTNLTnBVTmlLbGRDTVdwS09N?=
 =?utf-8?B?MGNWRzNLOFE3akYxL2lHcEt0bFYxR1ZBUkdxSkNvOGZLZGlzNlVTUlZLZjNy?=
 =?utf-8?B?aFBZVzFhSjVuUWlFbG1nYmduQXp3VWEveFdqNW1FWHlKQTdMcERCVnRRNmhL?=
 =?utf-8?B?OHhFdldOTWFPRzYzWG5Canp4ckRKM3RublFmM3hKRE8xMFVnWHEzQWU5Y2tv?=
 =?utf-8?B?MVNSSkY2dmM3MUUxaUlUeUcxR3N2cFVaVG9udUVaVmpPR3UzU1d2SVRScEZX?=
 =?utf-8?B?aUFnTTVEd3JLOXZTcTFiZUxOckJWWVYvaHpkOTlLSGpWRXhLczM0cU8xb1B1?=
 =?utf-8?B?OFlmK0xxdnA2VnRuRlR6V0Vzak5MNTZsdjZ2dWE4WVVXZlFOUjdGREhXT3ZY?=
 =?utf-8?B?WDZ1Qm1EYnVtc015QVVQcE5hdE9JSW5UdldwbTlwdFplSng3b2R1TE02eG5J?=
 =?utf-8?B?anZQYU9aMVBzZ3RZbldkQlNWK0dnRk9vRnBIY0o1ZFQ0WTFRSXJ1dkt4eUlW?=
 =?utf-8?B?bmZaTzg5WldYRGRjaXV0WXBxS1VpSTJDYXVYZGxRWWtXOW15MFlNMjZMd2xn?=
 =?utf-8?B?VmZkbGVhZEFKd3EzWWtraStEdEEvRW4vL01CaERmRGd0NE5JVFpsZz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7690696e-2f82-4373-527d-08da4abfd41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 09:01:38.3843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kfSofj2OHfpe8MQSUNvDHiUOqRfUudeV9dKlKc2IQ4FKY6r+zZEpvwifrO0yLDBVxsSGmkM0YasLFwChA1RxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5877
X-OriginatorOrg: intel.com
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Vinod Koul <vkoul@kernel.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Robin
 Murphy <robin.murphy@arm.com>
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
> Sent: Friday, June 10, 2022 2:47 PM
> 
> On 2022/6/10 03:01, Raj, Ashok wrote:
> > On Tue, Jun 07, 2022 at 09:49:33AM +0800, Lu Baolu wrote:
> >> @@ -218,6 +219,30 @@ static void dev_iommu_free(struct device *dev)
> >>   	kfree(param);
> >>   }
> >>
> >> +static u32 dev_iommu_get_max_pasids(struct device *dev)
> >> +{
> >> +	u32 max_pasids = dev->iommu->iommu_dev->max_pasids;
> >> +	u32 num_bits;
> >> +	int ret;
> >> +
> >> +	if (!max_pasids)
> >> +		return 0;
> >> +
> >> +	if (dev_is_pci(dev)) {
> >> +		ret = pci_max_pasids(to_pci_dev(dev));
> >> +		if (ret < 0)
> >> +			return 0;
> >> +
> >> +		return min_t(u32, max_pasids, ret);
> >
> > Ah.. that answers my other question to consider device pasid-max. I guess
> > if we need any enforcement of restricting devices that aren't supporting
> > the full PASID, that will be done by some higher layer?
> 
> The mm->pasid style of SVA is explicitly enabled through
> iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA). The IOMMU driver
> specific
> restriction might be put there?
> 
> >
> > too many returns in this function, maybe setup all returns to the end of
> > the function might be elegant?
> 
> I didn't find cleanup room after a quick scan of the code. But sure, let
> me go through code again offline.
>

If we do care:

+static u32 dev_iommu_get_max_pasids(struct device *dev)
+{
+	u32 max_pasids = 0, 
+	u32 num_bits = 0;
+	int ret;
+
+	if (dev_is_pci(dev)) {
+		ret = pci_max_pasids(to_pci_dev(dev));
+		if (ret > 0)
+			max_pasids = ret;
+	} else {
+		ret = device_property_read_u32(dev, "pasid-num-bits", &num_bits);
+		if (!ret)
+			max_pasids = 1UL << num_bits;
+	}
+
+	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
+}

 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
