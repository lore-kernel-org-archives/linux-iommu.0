Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C348CC43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 01:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 413B760B60;
	Wed, 29 Jun 2022 01:54:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 413B760B60
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bBQbQBof
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 586E9oYn6THt; Wed, 29 Jun 2022 01:54:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0A919605B2;
	Wed, 29 Jun 2022 01:54:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A919605B2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFC25C0032;
	Wed, 29 Jun 2022 01:54:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2FA4C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 01:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8692F410AD
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 01:54:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8692F410AD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bBQbQBof
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OVyOp_fyc7oN for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 01:54:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAB68410A5
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAB68410A5
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 01:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656467649; x=1688003649;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5lYai6Wbbr6hhhvgEQ5LNjNBQg9a3RCdYGYVOBNU4SM=;
 b=bBQbQBofkZXiTf81zGKBmlNjmwR+KGjHkl6xqDCkUBCCIgXJ9AxehgLo
 aqV6QlTxfGnAE4QJ0XNUomqlpzyFq58527624pIn3aTK1UM6tlAPmpnK/
 Xxa5wvui1EVrFsQth5jKd5ClsdxLszMlUsTfD4w2WPzYQ+Q264F5AWP+x
 pRkG4DMJe7WjMySX2V4CkCQiou4ar7wAxFgyHmxBdmIUQbGLOMADMihws
 oju/rvpCeYQeqhQiXitW81DcdkenlYoKuz1cyFossp8L6deyUqJEBiSZN
 kNB5VwU6NkSIuLTMfNvW/iZd6Ch65BQEavowSn9XoVqnB1pcKvMbRMUpc Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="281929942"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="281929942"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 18:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="565265847"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga006.jf.intel.com with ESMTP; 28 Jun 2022 18:54:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 18:54:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 18:54:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 18:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fupSz9AuXg24IufJEd6NZx2ibaR1hiyAYbOhqQSyCNoGecogsjiRqi/IzxZbcNxfZ79Zg3qxH0kKwZ7+H7sZDfiuEzuacQcE57oexpoTfcwKUwEq6NAMJUc4B06RmmF0Xv5HZwFD+bfhWEVW6UjvYUZmPK8sdIj5xq0SFg7+E4tP7uJ3B76wcPI5d1UpX0x92X+QhtGFAgKIlW8d7eY2X0j8mdOges4GhW/XYybEAXtc9m+Jjo4ppf+twh67P5pmc8U/35sgxjzr4NWDrrt5bEwOMGjbtSyZc6Z2QtyQrYAIK8xrsWLLsARifrcVeDZiEyDRHyUojdwKgV4z6FjUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lYai6Wbbr6hhhvgEQ5LNjNBQg9a3RCdYGYVOBNU4SM=;
 b=LC9gPDdyV9G7kx4NV9dZ7qlcjdGKgrQEWlb9eh+L2ZNHKjXK6cA5f8AnvPFFMRVDkbX6Gm18GDc4f74bLW6O9/enycHdGrwnZxCmLL20bSqEB7ZTBFtg+GXGXtqy6Qplx8XADmdM25qy+qoC81WPXPmM63kN+r6VSDeI1DQk9GIYJq8YnagfSOwyl5PeuuiCJX1DydNMpiI0dk0x5mAwovVnvCzoncGcq8Zl4NfvRneRir96ygHBCp33XXSGcgrros3GUht3GtT6SGQ7xICjRCMzSxXRJ9KcDEPUE7RXETYRh7dqbRx+HtY4ehUgg4ud7QRWdiMkwkoM5cFdIRU72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 01:54:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 01:54:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, "Robin Murphy"
 <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: RE: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Thread-Topic: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Thread-Index: AQHYhX35xSpIBtEUJk2c4sDKhBGbeq1i8Q6wgAFnYgCAADJ2MIAAMAaAgADuHyA=
Date: Wed, 29 Jun 2022 01:54:00 +0000
Message-ID: <BN9PR11MB5276CE638C49B571612702BA8CBB9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
 <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
 <89130952-155c-38f0-3318-1c071562661f@linux.intel.com>
In-Reply-To: <89130952-155c-38f0-3318-1c071562661f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97a69769-b549-4c67-b4fa-08da59723c7a
x-ms-traffictypediagnostic: SN6PR11MB2575:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kboznsDIzh5EtyWrZ1uCfFqNjs5LpUsN/vjhYLW8NAOXRAUX/DoB2Tm5pB7tBfNE7R09vz8Z42IqK4xU629K4xRmP4x5qtfV01Hw3813BDXgvolTROCfhCzucTYpohmYPJ/VTMRB3TfO8+LSc20Nic+gcdF4aNiSUShy8dCbJR4oOuuq7sRi5Lm3rsGZ+NdQiXB2XE97lFB+pJH8BHZVcEbFVxcc3L01WRTZnkwJutEQccSsz7RMQYC7R2Bti6p+q/QTpmm2LsBszUbwaJD4g+5zQgbwq0QSnN9McmA3bHJuLl8AtYvFqPWEnlZWKd8y2kCjefguaBYrhTOvCVcRObydmgqi324S4VVvp/YLbs83F8hpL7Ip6IsshpNbAEWhYw0H/umirD+MAw1FOxILRLY8Nw8wroJjiU5mx1H1Igf07eXZwKInrIgrvv+FkrjyG6rOlKDn7zyio/IpgLn3L0GWZhWvcTr7EES7Ew0L+AVH7csStqZJud/tjzHDMRVhG6GwQQ+Y/MhmaoJrFtZwL2kwKjJSILQ6p09XdFjzQui+A2meZrdCXJ62aKol57RgjWdasHT1+08AxeW3n/CccGV4XcXa9gKIPUfk39+/WD3fiVk9hYt+MOZLbIDutxad9y7KEqsDpBpVEtB/C8sIAcXtpwTUEkfbYRZGXi74wwnw3sKkV04dnIG+egVPdh9S5eFhYOMiz2TpdZ/l9ta+Q0VdntJ/8h+pt6HxO7BfZ7T4dtWh2yC0rPafg/4VvydC0zYg03w1tCfC33nXDOyeMJ9aMJFWNEN3cD+vM5o6BA1aRmnzJKVYQkf7IULtp5X5kaEtDy75Mmde4SNO2WNiA9YR7445JUpo56YI/hCY0vlhXSIwWmuGNw/nO7mHRXEIxGI4UqKKyqg0Fzuzrg0TYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(136003)(39860400002)(396003)(346002)(376002)(82960400001)(8936002)(921005)(52536014)(122000001)(966005)(7416002)(478600001)(38100700002)(5660300002)(38070700005)(26005)(66556008)(66946007)(76116006)(316002)(4326008)(66476007)(55016003)(66446008)(8676002)(64756008)(71200400001)(9686003)(86362001)(110136005)(53546011)(54906003)(7696005)(33656002)(186003)(41300700001)(6506007)(2906002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWhNQXBLRVR1TDhCd2V2ZTdPOE9OMHB5Y1BXZC9DM3RveGMyY3JlYUpLK2t4?=
 =?utf-8?B?T2tyQXpBMUdPWmRERS9mWHVzTUgxOWRkWHMzcmJuTnBMY0w0NWhTMzRqcVB4?=
 =?utf-8?B?b2FNdlgzbTBhNjRvM25WQVBKM1AwYVo2c21lNW40ODRzS0JteFNVdjhMNmxm?=
 =?utf-8?B?b2h4bWNvdHBHVldFWFNxdFpXdEhpd2hTY00xeTA4U05NMzZlNVhoRE12ZUxw?=
 =?utf-8?B?ZlNDb1JEVURwUWFwb0d2dlY4VWFadktCcmR2c255S09yMjdNZDJ3OXlMVUt0?=
 =?utf-8?B?U1h0YTBsVmlhUnRGajhDOUZEZm5sckQrNnQwTjVtN3lpVUp1UkJzancxT3g3?=
 =?utf-8?B?WWR6R01nTy8yNDYyNjc0RGJqV3krR2M3UFVOdFE2QmZZRGRYdnBJL21uUGN4?=
 =?utf-8?B?b2MzZkxPWEx2OVFTYU5aLzgwcjd2a2ZpUHdNTEI0L1Q5OGZ5aFQ0eE0vVzVr?=
 =?utf-8?B?MVVLL3I0ZzQ0MWNFQjFBWGNCdEVOaXI4RjF4ODBjbmJZZ25KWERsNU9tU3ZQ?=
 =?utf-8?B?UEdJL2QzUTBJdUpjbml4dElGSVFKTzhlV2xrdzFQYnZpZUt6aFNTM1lpM1VN?=
 =?utf-8?B?ZnBJdTdEZnF4NWtDa2h4c0l5VFRUYTVjcnFNQUFSZG9MSUVQaGo2MHVpUzdz?=
 =?utf-8?B?UGZMQ0kzWjVnMFJqY090dzFMeENwa2tZN08wQTFEUnhodmc0Ry9EOHB3UGJ5?=
 =?utf-8?B?SmMzMlNhZkRyMHl1UXJnTldUSUdTQXdzZmh5dURXZkczZ28rcWhvUWdiSnh2?=
 =?utf-8?B?WFVyRmdSa1pORlJHMlpTM0h3V2hxQSs0d08ySzBvVHVqdDFtMHhYTktlZnJH?=
 =?utf-8?B?RHZoVnpYWkw3QkxQbXhPcnhnSHFndmQ5c0xoZ05OV1J6bXBvMDEwMTdDeVNo?=
 =?utf-8?B?RWh5c244VjVnZW5icXI0Skc0UG9MbVh6QktBTlE2aStJN00rUlpjMUpvREpX?=
 =?utf-8?B?aGQxOWpFbkJodWg1MDJsS3R3cU9nZ2FiM0h3VEpQeU1PbTNkN0c5Z3JGT0R5?=
 =?utf-8?B?d2srNVgwWE9rakV2dHZ6L3orQWRmOWowbHc2YXBZc2ZianFGY2JGNi85emM1?=
 =?utf-8?B?S2orYWNyWFB0czM3OVBub0RDaUE1emtJWW1QVmpMdmpzVUc5c0svbjllMWkx?=
 =?utf-8?B?NnBOaERsK29mU3k4Q0FOREtUbWJJYzl6UGxqeGVhR3MwVVBoNzNmbTRSNFFB?=
 =?utf-8?B?RzF0cjFwOVBuSXoyTExFL3A3YnArOTErajBtanZsTG5MSWc0RWZBZnc1dTl1?=
 =?utf-8?B?L0RtQzV1akVRZ0hLQ29iYll5Z0dCc0NkK05GRmlSRlN3dU43OUwrandhb1dM?=
 =?utf-8?B?MTRKcmd6eGYyRDA3Rkg2V0VnVG1YUENJZGJzWi9CNm5HYkZrUTZ1d1lIdVll?=
 =?utf-8?B?T1NtcWJiaC91UHk3NFhsUDQ3L1JjZFhRaFQvdkZCOG9XWVZUS1BzdmlGNFhu?=
 =?utf-8?B?SVZVd1E4R0I0VllTUDUweSt2YzJSUFdHWGZRYTh1MjRmS0NiZ2h1OHcrRW5p?=
 =?utf-8?B?cXhweEh3UjYxVWJ2NTFnaXAzQlFoV2NoUFFGemQrQjNRbmwzazArRDYya3RD?=
 =?utf-8?B?T2hpSTFzWmZqb0kzMVpsVHNNeXVOaXhqd054V3B5end5Zkg1TVBSQ0hpNWY5?=
 =?utf-8?B?ejNuWlBmMzVubnZIYXluZ00rNlY2SlhpRy9VaUpVbVF0SmFBMVJhcmxvVHpm?=
 =?utf-8?B?eXE4VXBVN3UrbzV2OGdJcnE4M0syV2dON01PeXU0T3ZXRTF0R0hKQjczbmFG?=
 =?utf-8?B?ZW5OTWxrREFYUjUxbWsvbFBjQXVpcmZyY1hZTUhHTnRFaFE3dmxTZ3ZDdFVu?=
 =?utf-8?B?ZkwxcFdsTGpBUW9uaHVhZ1Bua2VIbVdFWi80L0VyUEJ2YzVLNlREc1Z6WmNx?=
 =?utf-8?B?aisxTzBvVGN4cWF5NlcxWXBITzhoZElzZmFCdi8wa2xOdzU5bEp0cGcvalZr?=
 =?utf-8?B?ZGhEYml3UnFyS2g2R3VNZmZ4bWc1MVE4bVc0UnRKbGtVdDNaVEhhcEo2cDdN?=
 =?utf-8?B?V2lwdklPVXdrZmZ6UmZCVXFTendLLzBUMzQ4QkFJV2k0T0gycDFXU3dKb1Fn?=
 =?utf-8?B?R0ZnL0pBSVk4OVNkMWJNVTZEeWR0ZWFxN0t0YjZXalM0MUVKUlVKcEppVDNv?=
 =?utf-8?Q?GgPdw/yBM+Up76ecXZ3pnj5Re?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a69769-b549-4c67-b4fa-08da59723c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 01:54:00.1539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qFPhgywc0Kr2gxDI3TLBNSLa/0FLz6rdLHYuQoAU2CHwRoMf/75tGBB89LRdTj0QT+/7rFNOrrcNgyFQZprOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2575
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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
> Sent: Tuesday, June 28, 2022 7:34 PM
> 
> On 2022/6/28 16:50, Tian, Kevin wrote:
> >> From: Baolu Lu<baolu.lu@linux.intel.com>
> >> Sent: Tuesday, June 28, 2022 1:41 PM
> >>>>    struct iommu_domain {
> >>>>    	unsigned type;
> >>>>    	const struct iommu_domain_ops *ops;
> >>>>    	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
> >>>> -	iommu_fault_handler_t handler;
> >>>> -	void *handler_token;
> >>>>    	struct iommu_domain_geometry geometry;
> >>>>    	struct iommu_dma_cookie *iova_cookie;
> >>>> +	union {
> >>>> +		struct {	/* IOMMU_DOMAIN_DMA */
> >>>> +			iommu_fault_handler_t handler;
> >>>> +			void *handler_token;
> >>>> +		};
> >>> why is it DMA domain specific? What about unmanaged
> >>> domain? Unrecoverable fault can happen on any type
> >>> including SVA. Hence I think above should be domain type
> >>> agnostic.
> >> The report_iommu_fault() should be replaced by the new
> >> iommu_report_device_fault(). Jean has already started this work.
> >>
> >> https://lore.kernel.org/linux-iommu/Yo4Nw9QyllT1RZbd@myrica/
> >>
> >> Currently this is only for DMA domains, hence Robin suggested to make it
> >> exclude with the SVA domain things.
> >>
> >> https://lore.kernel.org/linux-iommu/f3170016-4d7f-e78e-db48-
> >> 68305f683349@arm.com/
> > Then it's worthy a comment that those two fields are for
> > some legacy fault reporting stuff and DMA type only.
> 
> The iommu_fault and SVA fields are exclusive. The former is used for
> unrecoverable DMA remapping faults, while the latter is only interested
> in the recoverable page faults.
> 
> I will update the commit message with above explanation. Does this work
> for you?
> 

Not exactly. Your earlier explanation is about old vs. new API thus
leaving the existing fault handler with current only user is fine.

but this is not related to unrecoverable vs. recoverable. As I said
unrecoverable could happen on all domain types. Tying it to
DMA-only doesn't make sense and I think in the end the new
iommu_report_device_fault() will need support both. Is it not the
case?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
