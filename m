Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786AEC433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 11:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 272EB40BFC;
	Thu,  5 May 2022 11:03:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ywUpfxBcznu3; Thu,  5 May 2022 11:03:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CDB0B4014A;
	Thu,  5 May 2022 11:03:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8716C0039;
	Thu,  5 May 2022 11:03:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 141D6C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 11:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E83B883FC2
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 11:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 90lsykbdzm46 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 11:03:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A99DE83FA4
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 11:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651748605; x=1683284605;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=imZP5E107Sb2qfiHkkU7dGC7YDCBJBD7OmK+mbOipXI=;
 b=J2GWSkRQToCK3gCquaEDy/qC6gID66F83pJYKtkviqTv5nyMFVUPGuSe
 vfuJ0S/TY+SKJCPGlHJvSKsQ1TGIOXwS0uZ6fjcQrMUpTlEdxqgIqvRM6
 mDetkxux92/TTWrwdu+Gh+OcnSnd0sfyVlhuTT5YPUodVzYArFp+GPwNx
 wxNiDCN2IjWHYllt31bDqsJ6d2iHewt1GkkuSR+J0S4cJzR8z2CxQyQt8
 Yi1uQaenb9ju0vAlb+U/8JdTjeyRpWc93rdTpdSpz4Il22TB/GeY5EilI
 uF0v4P7+NFMrCmB3j1L17Gn0/CPmcYLDB7v98giN+zSIF+9YHR0t+4Anj w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="354509138"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; d="scan'208";a="354509138"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 04:03:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; d="scan'208";a="734848552"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP; 05 May 2022 04:03:22 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 04:03:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 04:03:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 04:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0brs1E9MKCH369BSDi/LospYimfS6RfgYPq5DHe8muLBR0i4EMr4Qm67QPyJAN4kZJ0jPrcG1cl6HlAjEyuC1Bmux8PwoWFsM+hFSB+6203cry13OheIeyDO6vpghGBE/VaC/mocYz3eUAelbAt54f+hROYRAfUnGwY7U3k8e82+4iuWZ1C33jGXpjHLZf6vrLn2lCPEDZUO+Pr2M6V8MrirEp4DRYWfkaTCuQafFc6EAsY35YevzVkTAQ38yL9IdskcEHG9q4wHNOI8ggrmkkS8zt7LFwITOMIOWbvxmyBeFT/2/x0+NY1uZvggNIuu9cuvm/kzEUcaGIOIFoJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imZP5E107Sb2qfiHkkU7dGC7YDCBJBD7OmK+mbOipXI=;
 b=CyJdkvy9XNETa8GJEmZ0OArwFtHc2t0HW4oVN00D7ALZ371F5nQW5MTUMMrl3qGXaLklcAKyRuhKDK+7oQQCbgWkLIwTEmbn7T3sdUX/Emt9mPZhy3z8dJnZRhzXToXf2UeAoLJEO2/NrzLPPhdHZPSQVNM/NbeB/Gd/h2UEXDWtbeaROyfCLvpMIiIvI4DKP9U7npqyNJYHphn27SIpL9aqYD7ydVH9f3PlgYSlCcgYIz6a9VQ9y96Yq3cxEXj+IET3Q8BhGVDSCTgFNWzXbuRWI68zMsSDs3tSqPumJztGSfS8eo7R0gEceIfvNRC3qdETZRttUR6PFBH9GEo7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB3933.namprd11.prod.outlook.com (2603:10b6:208:13d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 11:03:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 11:03:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Thread-Topic: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Thread-Index: AQHYW0R/S6mfDid5yEe6M+QKFrUDn60GOWsggAWwCICAAAubgIAD+0BQgAAo1oCAAA4PYA==
Date: Thu, 5 May 2022 11:03:18 +0000
Message-ID: <BN9PR11MB527662B72E8BD1EDE204C5538CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <BN9PR11MB5276F104A27ACD5F20BABC7F8CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220502121107.653ac0c5.alex.williamson@redhat.com>
 <20220502185239.GR8364@nvidia.com>
 <BN9PR11MB527609043E7323A032F024AC8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7b480b96-780b-92f3-1c8c-f2a7e6c6dc53@oracle.com>
In-Reply-To: <7b480b96-780b-92f3-1c8c-f2a7e6c6dc53@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27193284-7123-4db4-96d7-08da2e86dc99
x-ms-traffictypediagnostic: MN2PR11MB3933:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB393323ACA1E5769DF7FD4EF28CC29@MN2PR11MB3933.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x6kxOK1TtgRrOBuVZkXs5L7sNLh5kiqn2Hu+ldfZfaly3wdqRbRXbFlsedWpA3+IG+jT2BVjlPyImhEJR0Hcpf3VpOtz2rqLGHtF6QQGJdNaThGon7Hq+jnlHtc+7AfzBB/xMr+/3TmnPVFzeWpn4HrFDLTMw3ht5C3zV67ZrGB7k482Aqfot34ot5bH1NTTCJ0gqsaFD1fHPFLKptyhQq3ER/o1q0S7tlcQhTh+1TAcd144fIzFrg4LLCfPtq8xljc8Io8f7wNhhBhgg8VDtStNWyFGeLigoAd7irjacnNb7h74y/koPjhZmxtgQzQRkGyUGNYc6MGa706I5ihe6E+7gN/AW4swDkJzZMqtSveWLl+JQuVY+uh+BAof9fosZJZT+05BRS2fhQuN+tweWMxCOs5QqiAWwqwSznb5ZZc9i/Cwz0gf/IO4QbS+CrXUo82juB+RFR/Y1q6Zgl8lKZbNT1sMoNGint2YjJBtc2GMQFwmY+pKUaw0lsG4SSE60UtI78VWXmK7oXGCaDi1EaWgn6FNX514OApKz8DYzB0wsaRrLhykpgQmhXz3g1M8rdJvRSIDtjPxg2GzpiSgbG2ZsxcrCtHPy5PM3fz2Ht/AcFg32+gsT1SJOcZvAOHeIOQ4yiznkksbY+NWMUf9ZYi7exSmcPpFX7t8JvkzWAF5t3P/jdzhX3XK+7hNzIdREOVVLWObWWmpizcDYUh76WcATyQaYhun56onloW6oO8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(76116006)(83380400001)(66556008)(66476007)(66446008)(64756008)(66946007)(33656002)(4326008)(8676002)(7416002)(110136005)(186003)(316002)(54906003)(2906002)(86362001)(26005)(9686003)(55016003)(53546011)(6506007)(71200400001)(5660300002)(82960400001)(7696005)(8936002)(122000001)(508600001)(38100700002)(38070700005)(52536014)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTVFUG45YWY0aTdzME55dzFqWEZQOXV6Kzl6bWMwK1NIUmxlaU41bldhL3NO?=
 =?utf-8?B?S0hUUWJ0OGtsN2kyNXdNQXVqZ1FIZU0rTXlqWWRtQ2xia0hNcm8xYm9ycXVV?=
 =?utf-8?B?NDl4ZVFIaXdMRGJMM2pvdm9oTENCMm5leEh1ZXp0UHd4TEIzbVkzWnUrK2d4?=
 =?utf-8?B?dHI1S2FTVVpKN012bmZFcWoreGk0b3VQR3pOcTVuRmlxS2NBVXJibW5xZTVm?=
 =?utf-8?B?ZDh0b2FqQU4vT3lFcjFoY25kd05uNVI0ZU1RWDRFcU5qc2hYN2d0UzZOTUhL?=
 =?utf-8?B?NmpTRlk5MGgyZVBmRXhJSS8vR3paQVZKMWJ2QlQ5SzBSN0pCZnRvaHY1TExw?=
 =?utf-8?B?OEFzN2RaSEIzVkR3cTF6ZXVNQllnRWJJZG9IclpqUjY4OWZwMm5oc0RrK2o2?=
 =?utf-8?B?d2ZNZVJ4cFlvSWZlWUZvRzVwWE80Syt4NzhrV0pZM1FDSllYdi9LajJlS2NX?=
 =?utf-8?B?MkxCUVF1bGVlZG5GVElxbmtZNXNBbVg4QWQxMTlTTk5GUWZwdWVXdHFwSTJ2?=
 =?utf-8?B?Z0ZnQXBGMDlYekVhSi9mUDd0bldtSVpPRzJCYmVnRzMzTExiSU5SYUFJNVNK?=
 =?utf-8?B?b1JhaVFNR0dJSFNKbFJVeW9aMXlBeENHTnh6UTNkUjNzQ0MxM2hqYnBCNDVM?=
 =?utf-8?B?NG1IaFJuMFdFNThLT1VTUVR2Y1pweTFCYmtNSjhMK1BLd0s1QjFRandtdkE4?=
 =?utf-8?B?dGZtT3hveGJRNVZQYmVZNmFzOHRlVlJLN2ZPb1pQRGtSTHpiMXlRNmFZS3hG?=
 =?utf-8?B?Q2IyN0R0RlBzQzUrZm5lTnB3VVdoUVMwdUZkek1tKzUyU2lUcVVqckFOSHE3?=
 =?utf-8?B?SnVHdCtxc0pGOGl0NnFLK0RHeDhOOWhvOXVMTktEQlc4MW5nL0M5S0VwMXRW?=
 =?utf-8?B?dExxS2hXWDJqVmxqdk5LbzQ2NWU3cG1vR3c4ZkJTeVN3K05pd1B5NWdzWEhm?=
 =?utf-8?B?d29DQ0E2ZUVxcWt4Rk55cGZYWjVZTVczUGlIMExqSWxEUkw1eFczWVRCTGpM?=
 =?utf-8?B?SUhDMS9ZcHRPK1Awd2g1MUJIb2tOWDF0djVsaEpuWEFXOHkrWFVkUHVta0dW?=
 =?utf-8?B?R3RNUnVNNXNHMVRRUGU1cStRWXNQQlZ4aVJkLzVZeTU0WmJTcGlIR29tSUhl?=
 =?utf-8?B?b0NZUjNnbHNIbU9SeFoxeHlyTHNhNHE3QzQyQzJKTHpoWklsZVowYWc4UndF?=
 =?utf-8?B?MC92cHpjeTAwd0hjbThXdkpDVFBYbkk0Q1dTNDAwWVBmdWxRTytRVmtJM2Q0?=
 =?utf-8?B?Q1VBc2NHVzY5UXdBMTlGWk9MaENJRXYyWE5zVWxuNVdxczVNeCtxZkUyM1Q5?=
 =?utf-8?B?UVpJOXhVYko4amlsZk1US0J6RW5ZblRWTUo4cVVXbVRUSUZQdXNDM2RUWEZ2?=
 =?utf-8?B?RDljQWx6WWF1dDRpQlVJS3puZ3k2SXl4aTNueDNBcEVhNUw2V284dDlzSFVG?=
 =?utf-8?B?Qi9Gd3BXcnArbTZoVGhBT2dzcEltcGFiZzVBNUFTMFA0U2xiN0VxcjZBTGlz?=
 =?utf-8?B?V3g5N2RMWGhYdis4U3J1RDNnWXpOQ3l1WFI0aEJxcW9DbEd1bGt0dHpWbXVt?=
 =?utf-8?B?endFOTgyRFJKcEQxWXM0ZTZmUGJyV1h0Q3Q5Y3RQVU1JMzNMN0RIeFhQQmo4?=
 =?utf-8?B?N05xN1dDbHZHTlZXS3RVMW12QVpBSGlCa2N2aGUwMHlFS21zUUpiMHgxYW9K?=
 =?utf-8?B?QzMwcDhFakVJVzVYeXVNdXo0a1NmcmZSZG1ITzA0VHhRYjBGRXZvck5PUnJy?=
 =?utf-8?B?WGZFaHczdnBNWDZpZUIxNTNYWXJ6RnhJM0JnUWV0bXJHOWdzaGQrWXMwYzEw?=
 =?utf-8?B?M1NlRk9QdVFyZmRySWM0QUJDREtKY1F4Wnh0WlkvT1ZydzNPLzZXVEM4RjBh?=
 =?utf-8?B?OEE1SlBYNDdTc01EeUFrbTlKUUJXejAxdDkzQ0VMY0o1bW1XMXdoUHZ6KzNZ?=
 =?utf-8?B?UThkSUphSlhsNUpGbEFNWVRTZ2hFWWdraEkxaU1FZXpHZ2FMNlhVdHVTNGpP?=
 =?utf-8?B?N1RmUnlHNHJvR1dzbDVjR01RL1k5MlE0TExJSWZUdTBrSEgxNGw0T0JiUnp4?=
 =?utf-8?B?cmF0SllVTUJxWUhmc0dibGlteEI2YUE5OWVMYnNPZllzN0J6K1FXS0hWK1RB?=
 =?utf-8?B?ZjNqRmF0TG5ndE9EOEMrd21MUnpnSlJ5YVN0Vnh6SnZKM1VyWXQvWFVEOWpx?=
 =?utf-8?B?N29IK2psR1hNNmpnWWUzRkpuY3dpUkVzZzBiUDZHQmt6WDZUYUJSREVIdUhT?=
 =?utf-8?B?eGtqL0JNQWN6NzcvdDFXcytKRk02TjlrRE5CR0g3UTlqeTFKeFRWVFk4RUpy?=
 =?utf-8?B?WStFSkRsaVphQUNJWThhcUZIeEdJR3NWT1o5N0U3WUN5V0tMank2dz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27193284-7123-4db4-96d7-08da2e86dc99
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 11:03:18.7426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWzbiicw9nQ5VbOCG/lND6IXLO1AE3LHLavg5rglogqJnqJAJuoDOoSuxInv1cDOqxFQ8DU3SG7wGl2C3XY8OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3933
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yishai Hadas <yishaih@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

> From: Joao Martins <joao.m.martins@oracle.com>
> Sent: Thursday, May 5, 2022 6:07 PM
> 
> On 5/5/22 08:42, Tian, Kevin wrote:
> >> From: Jason Gunthorpe <jgg@nvidia.com>
> >> Sent: Tuesday, May 3, 2022 2:53 AM
> >>
> >> On Mon, May 02, 2022 at 12:11:07PM -0600, Alex Williamson wrote:
> >>> On Fri, 29 Apr 2022 05:45:20 +0000
> >>> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >>>>> From: Joao Martins <joao.m.martins@oracle.com>
> >>>>>  3) Unmapping an IOVA range while returning its dirty bit prior to
> >>>>> unmap. This case is specific for non-nested vIOMMU case where an
> >>>>> erronous guest (or device) DMAing to an address being unmapped at
> >> the
> >>>>> same time.
> >>>>
> >>>> an erroneous attempt like above cannot anticipate which DMAs can
> >>>> succeed in that window thus the end behavior is undefined. For an
> >>>> undefined behavior nothing will be broken by losing some bits dirtied
> >>>> in the window between reading back dirty bits of the range and
> >>>> actually calling unmap. From guest p.o.v. all those are black-box
> >>>> hardware logic to serve a virtual iotlb invalidation request which just
> >>>> cannot be completed in one cycle.
> >>>>
> >>>> Hence in reality probably this is not required except to meet vfio
> >>>> compat requirement. Just in concept returning dirty bits at unmap
> >>>> is more accurate.
> >>>>
> >>>> I'm slightly inclined to abandon it in iommufd uAPI.
> >>>
> >>> Sorry, I'm not following why an unmap with returned dirty bitmap
> >>> operation is specific to a vIOMMU case, or in fact indicative of some
> >>> sort of erroneous, racy behavior of guest or device.
> >>
> >> It is being compared against the alternative which is to explicitly
> >> query dirty then do a normal unmap as two system calls and permit a
> >> race.
> >>
> >> The only case with any difference is if the guest is racing DMA with
> >> the unmap - in which case it is already indeterminate for the guest if
> >> the DMA will be completed or not.
> >>
> >> eg on the vIOMMU case if the guest races DMA with unmap then we are
> >> already fine with throwing away that DMA because that is how the race
> >> resolves during non-migration situations, so resovling it as throwing
> >> away the DMA during migration is OK too.
> >>
> >>> We need the flexibility to support memory hot-unplug operations
> >>> during migration,
> >>
> >> I would have thought that hotplug during migration would simply
> >> discard all the data - how does it use the dirty bitmap?
> >>
> >>> This was implemented as a single operation specifically to avoid
> >>> races where ongoing access may be available after retrieving a
> >>> snapshot of the bitmap.  Thanks,
> >>
> >> The issue is the cost.
> >>
> >> On a real iommu elminating the race is expensive as we have to write
> >> protect the pages before query dirty, which seems to be an extra IOTLB
> >> flush.
> >>
> >> It is not clear if paying this cost to become atomic is actually
> >> something any use case needs.
> >>
> >> So, I suggest we think about a 3rd op 'write protect and clear
> >> dirties' that will be followed by a normal unmap - the extra op will
> >> have the extra oveheard and userspace can decide if it wants to pay or
> >> not vs the non-atomic read dirties operation. And lets have a use case
> >> where this must be atomic before we implement it..
> >
> > and write-protection also relies on the support of I/O page fault...
> >
> /I think/ all IOMMUs in this series already support permission/unrecoverable
> I/O page faults for a long time IIUC.
> 
> The earlier suggestion was just to discard the I/O page fault after
> write-protection happens. fwiw, some IOMMUs also support suppressing
> the event notification (like AMD).

iiuc the purpose of 'write-protection' here is to capture in-fly dirty pages
in the said race window until unmap and iotlb is invalidated is completed.

*unrecoverable* faults are not expected to be used in a feature path
as occurrence of such faults may lead to severe reaction in iommu
drivers e.g. completely block DMA from the device causing such faults.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
