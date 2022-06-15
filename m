Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F7FC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 06:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73B6340337;
	Wed, 15 Jun 2022 06:13:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hKLZNVjYrQMU; Wed, 15 Jun 2022 06:13:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 668E84032D;
	Wed, 15 Jun 2022 06:13:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44B24C0039;
	Wed, 15 Jun 2022 06:13:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 606A9C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 06:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 480A940396
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 06:13:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sY4L_ELFA_ho for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 06:13:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5689740253
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 06:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655273604; x=1686809604;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MAw12frkse7EwAUGL+2vb4G2f+xyyHDhaQpAoBmT4+E=;
 b=m/ANMbqHGFlJVH5gIlJCInChDvf2UIoeGxVj0ejuv283kPTXoUzPPT/L
 2dingeGnCCXKJIqqrNGP11oj/gjZtGuI3qL1Fieo31BZ2uWxNP3j1+HuB
 6awnS0EGYN8gqpQ7a/GB/lTkdpYqThiUwSaDziLXQYPTT6xefmi25qy/Q
 aJaBU1GPbJuhCXcR/z6+XqSoBcz1H78i+jIywVTqzkMazAmXMWkkhuPWQ
 XDqWXrfxeFOwtSzesE7woLN6/kH4BrGPPbB7n7h7hA5jhK51auI+GT66/
 8/kBqTX4ZgRxYw7a+icZmo780t6yofX60GNGXR4sJoVzZcPt1Z4WSWYeu Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="365199343"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; d="scan'208";a="365199343"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 23:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; d="scan'208";a="640811711"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2022 23:13:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 23:13:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 23:13:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 23:13:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+1NrELQNDFi2KNq8Xb1Dp09Qu4GrTQ4579LKU32lHfScHSYT+8DQJ19X5OZnfTK2we67/fvi1W3xanPgKbYTN0QycpBgVA4yox38SkVuUnc3kDNRZ71xzY8livJwbV/4jJCYfjqpuBnsTZwjLoqH2Gn1ZQMdyMsfxN9AvR+1KCQKTSfrUp1gZ4l5xAZmXMkLk83qztj8ApUykKIQTXi3GHTOTq/QY/EzG84s3+GEithV/3eC1b7Pr73TTArKOk8LL2WYEJoXnwi2ECVP6Il3HFM8KvQeIlD1rxwoNucE/vbPW7h1cC4skQBI9861WwJ4S49nsXCFxE7/V9G7vC4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAw12frkse7EwAUGL+2vb4G2f+xyyHDhaQpAoBmT4+E=;
 b=f8nhhbhSa8VHcMiVzpNEvKmwzoAPQ3ycaaLzf5myF0QKiPKGLRRjrjJK0Knsu2awsSqvuFr8pTqy3EMTsTH9Aw3NcyE4CyXCgYS+b0be4itQ//frB/GtH8TQqt0QsKAxLPrqMmogHWp/ZyLBF+zWCy2ZuXGD9m4XgfZ6AQGGKgyh9zyhrwpV+87VAwnW2BLSjUfoTe7m3frEw4oS0/NDcHeelhRzNNt1G+b1exaUrGbEXHYy8TE9QW/DL224TkuGNpJIs0aEkB+1tstmDIFUvyYWftl9gHHl1x2X0qkpXb2/Ul6Ji6dICrcJdWjpy4fqxZqK9VhoUTmT1TF8jiv1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY4PR11MB1590.namprd11.prod.outlook.com (2603:10b6:910:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 06:13:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 06:13:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v2 01/12] iommu/vt-d: debugfs: Remove device_domain_lock
 usage
Thread-Topic: [PATCH v2 01/12] iommu/vt-d: debugfs: Remove device_domain_lock
 usage
Thread-Index: AQHYf5o9PBZqbtPZ60ix6nIaRhUsd61OcNnAgAFFbQCAAEgwYA==
Date: Wed, 15 Jun 2022 06:13:17 +0000
Message-ID: <BN9PR11MB52769385E96377F5FD8CE2928CAD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527680C1957C0E29E8AE85168CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4f6f7bb9-5ea4-b466-7a59-62ebd5bc2cf7@linux.intel.com>
In-Reply-To: <4f6f7bb9-5ea4-b466-7a59-62ebd5bc2cf7@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad13b66c-f13a-4d82-c0ca-08da4e96237f
x-ms-traffictypediagnostic: CY4PR11MB1590:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB159005E2DFE85B2A6097202F8CAD9@CY4PR11MB1590.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6T7bM/KUR+WTaa9KdIQ+8kqf9vGTjBb27qE5t+Y4H5nd/KGt6SHih3p7eRxvr6jayp+hu4ga26VEmCbRX4JYg50aVI8MfKCaQUVUXOShPLTkG7W2YJcg3rYqhUTv+T6p5oz1lIOzYX3Bh7MFXjhI6RH2WzWi3ovV4fkm/hVd9EoVBH8om6n+deBq1udkXHbkuUZ9U7HLusq/Rk54tTdb1piFEbn9IQ6akUFVVPdLLQDw+079fOTZchCe2E13j4QuGXHT4N0QIc4amOMh5WZ3c/5JihqDWA0x6rGpcpbyQ7rpBldbkE8y8TC42nff+gH7f4T28rcA1qP+ugHJznmzlL2gPqMlMc/+JRl+/RQs5U4w/bkFUhWozoAU1r/h+7ukPosG2bpw3S0rsuXkVXe1h/NXBbY0aTk301SiP96cVKJqTtFLPvSb+rVF7CMBJhiMhhZ2SZ17wMvChXW5uuhqWiR0ZyoCr4OM1Rd7B+KmfyZcDCL0CTI3aF48bQ2kmhP+MFqf6LquKEyOJwdJn5fPHEneeKGXTIJ4HyMRy7cvVqh98QHRFcQ5CFtp6zIiDyawaK26fkv2GjUEastKIncKnxlpxdyAHMJ8dqfdaEz2l8TL5qmrGZBRpTSgrBCkhKK/xFCTq/Mv/t1xAOQigVOqgsv4/tbbiX/RpybVP75SHWoZHtv0Yjl76j8P6cZydiQbgVwGHhFoawwLpGyCDk8oug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(83380400001)(55016003)(2906002)(8676002)(316002)(7696005)(33656002)(6506007)(71200400001)(86362001)(9686003)(110136005)(53546011)(508600001)(4326008)(54906003)(26005)(82960400001)(122000001)(186003)(66556008)(66446008)(52536014)(66476007)(8936002)(66946007)(5660300002)(64756008)(38100700002)(38070700005)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVpqaXQ3ck41RTBBaS9zNHRieXRGV0tvdndsZ0ZoenJYdjZBbkNFSFZMaGhy?=
 =?utf-8?B?YzlkbmQ0bjRxckVva1Fia3J3OHQ3c3l1RTJDdk9pVjI1Y2plRVp2NlQ4bktD?=
 =?utf-8?B?KzFDMmlpeHBhTVBYWTEvWTVPVGdUM2htU1ZvTGJQTEd5dkVxU0ZOYUE4R2Vv?=
 =?utf-8?B?c2FtL2NtZCtnWmxERUJubzErN053UmJOd04yc0RiWStDRFJnMmpXeDRWRlNQ?=
 =?utf-8?B?dnJkZHBaS0xRRlA4RXhnZ2Q2UlhKOENpaU45Q3BYOENBMngzOC8xeS9uOGIv?=
 =?utf-8?B?dzlsTkhwRUVQSXBtM1lIQTZRSG8ybHR1L09nd1JKRUdSVGd6UzhWQ0pQMnph?=
 =?utf-8?B?Y2dRMVJ6YkU0akVBTGNMSGg0VWs4RzdaVlFPZ1pHNWNpOVZDSjhBMzQwNmRM?=
 =?utf-8?B?dTVVbld3NTB6a3NPdy9BWFE0V3hXc3A4Tkd1QW1EbzNyaUk4SVVkcDU0b1Ev?=
 =?utf-8?B?Y2VyVFNqcGpjZEVmMXRLUmhJU2ZIellYWnJlSzl0Y2VBMWxjcWVJOGt1dTNC?=
 =?utf-8?B?U0dWRS9kNGtQTVdyOWVXVGIyd3dCUDJlSlM4Z1I3eldkUTZQYlJuTjNBVmlS?=
 =?utf-8?B?QjVqaExrd2JTS0d6NEVOVE91T1hMVXkrcDBjamxlZGQ2MGpwaUVyejhZYWNX?=
 =?utf-8?B?bjg2N2ozWGhtWlAzREorbzF4aWF0cHdQUmdEUjBHanRXemdXVnFMb09zOTRM?=
 =?utf-8?B?QjZHdHY5cVlBSlc5NE8wZWhCOGdiWG9BNEhiNGdQaGFzMFIvUzM1K09YeU1F?=
 =?utf-8?B?UG5GTDdxMVp2RndHTDlpSTJXQTUwRXk2VXpCcmU3TnFjM0o3N2E4YnAwU3RE?=
 =?utf-8?B?cUgrRkpNeTJDeEtsWE53b1FJeUt5Rjl6amxEMFh4SThHSmRiZm5ZVTN5Z3dO?=
 =?utf-8?B?TTJYMllvWUYwaitkZStESDkvQ28xRXZjT0w2ZmxVaGN3Rnc1RWtSd3dmcHBv?=
 =?utf-8?B?MXQwYXN5d1J3VDRIUlpsWDc5d3pWR1Z1dFRlTmIycElnalJTQko5cktoRjBV?=
 =?utf-8?B?UnZMbEhWcXBydnIySCtYdWRJTS96YmxCdlNCQ0ZSR0NMNTRpVFJzUmZvUHpl?=
 =?utf-8?B?UW5mdGVLWWJLOTBmWHlaQThOeXU0WVgxdGRUakRaRms5K1M3WkpucjdtUnR2?=
 =?utf-8?B?eHJxWkcyTFZUSHgrR1ZXbFZaTEE1NWg0SUJmUzhLK0Jqa3lKVEpCdHEybnpY?=
 =?utf-8?B?OWFIMTArRE0vVGxJNW9abHRFcGROb2U1aGNndkJjMXhOSmRVTk9pOGY0ZmNW?=
 =?utf-8?B?bjROUzJ4OVJMa3p5bk5LTWo5YU9SS1FsMlVYVE9yc1FadkRiUExJNzFzTnlM?=
 =?utf-8?B?c1dLMzRVS3ZncmRnMzQ0L1l2SUlvUUhVelJBamFDQUozYllmNlZCYXh3MFJ4?=
 =?utf-8?B?UFR6RUhKKzIyWlU3dWJBNFJ3MGRkL1R6UHp4OEQzMXpTTzU0NVZqK0w3aXRY?=
 =?utf-8?B?VWpqd0ROcWxCaWpnaytlMm9ZdTRrY0JHc1FrbDB1SzZrR0w2VFFWVDAwVWFn?=
 =?utf-8?B?V2lkeDdwd0tWQzVkczJUZkNmc1NQVUxyeGZ5QU5JRkQzTXpPVUdWQnVFcVZX?=
 =?utf-8?B?dGhYWExzYmVGUVkzbWRnejFhQlRjbitYUkc3VUwxWldTK0I3K3NJR1cwSEI1?=
 =?utf-8?B?bmZWcm8xR0owQ0c1Zm9KV0g2T0JpWDVhNnNGOVV1cHBIenJwcW5sY0ZiMXdX?=
 =?utf-8?B?YmNhOFRxdkJoemR0NXNueE9HTDNyd2ZjN3R1cWZxQzNkYkd4RDVobEc5djMx?=
 =?utf-8?B?blZVa0kwQ2ZKS3pJMFROc3JEZXd5cVhBQXkxWGplWE1NWHZvckNLM0I3MDFP?=
 =?utf-8?B?MllHR05QempmS2xEMGdMYXZ3ZzFEZXNQZUNuUjB0clh4RTFkbGZzeVVEYjNI?=
 =?utf-8?B?bkJjaUZjekdjbUpnZUpHdHIvQkFXRlcvblE2SU1ySTlyM2Zpd1kzdFJyMzNk?=
 =?utf-8?B?dTd6bEZ0M2dnUlBkTWY2SUdscWRGTW1FekM3Z2hSYWlodjdodmNzTG1MSUNj?=
 =?utf-8?B?VWdacHdtVzJzSHZtUFJnSmtUL0RNZ0N3Zi9YK0xOeER5OGs0RksxbEozeDN0?=
 =?utf-8?B?Tk5pdkl0UDlNZWcyQjVRdWxZVHQ0bzhKRENUNmludy9ZclVSVDYzd0UwWGw1?=
 =?utf-8?B?b2JXTmxNZTNDSDN2akxKSlo1N1JwOFdEeGt5ajNvblkxQldxamxHVlptN3dp?=
 =?utf-8?B?cG8xQzk4ai8zM1NZSUtLNlZ2a3J6c2dNa3c1a3VhcVJFWUM4K1VFV1g1eXgw?=
 =?utf-8?B?Nm8zVVVPQlh6TU5MeElLY002b2tEYVBZVm1OUFFaOHNVck5FaDhmQW12YWhU?=
 =?utf-8?B?Z1hmdVFWdTM2QW9uUGR0SGZOaDdNNkxmamV2VGFuMklnSHlyR1Bhdz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad13b66c-f13a-4d82-c0ca-08da4e96237f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 06:13:17.3826 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: no8q8Na7ziaL0nF2B8CpCgcrS4ImqkjcdfaU7Fvv0Sb9yMu1Qin6xEcAmmds7lFQVGnQedcKZuCMAr2Z0XqsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1590
X-OriginatorOrg: intel.com
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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
> Sent: Wednesday, June 15, 2022 9:54 AM
> 
> On 2022/6/14 14:43, Tian, Kevin wrote:
> >> From: Lu Baolu<baolu.lu@linux.intel.com>
> >> Sent: Tuesday, June 14, 2022 10:51 AM
> >>
> >> The domain_translation_struct debugfs node is used to dump the DMAR
> >> page
> >> tables for the PCI devices. It potentially races with setting domains to
> >> devices. The existing code uses a global spinlock device_domain_lock to
> >> avoid the races, but this is problematical as this lock is only used to
> >> protect the device tracking lists of each domain.
> > is it really problematic at this point? Before following patches are applied
> > using device_domain_lock should have similar effect as holding the group
> > lock.
> >
> > Here it might make more sense to just focus on removing the use of
> > device_domain_lock outside of iommu.c. Just that using group lock is
> > cleaner and more compatible to following cleanups.
> >
> > and it's worth mentioning that racing with page table updates is out
> > of the scope of this series. Probably also add a comment in the code
> > to clarify this point.
> >
> 
> Hi Kevin,
> 
> How do you like below updated patch?

Yes, this is better.

> 
>  From cecc9a0623780a11c4ea4d0a15aa6187f01541c4 Mon Sep 17 00:00:00
> 2001
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Date: Sun, 29 May 2022 10:18:56 +0800
> Subject: [PATCH 1/1] iommu/vt-d: debugfs: Remove device_domain_lock
> usage
> 
> The domain_translation_struct debugfs node is used to dump the DMAR
> page
> tables for the PCI devices. It potentially races with setting domains to
> devices. The existing code uses the global spinlock device_domain_lock to
> avoid the races.
> 
> This removes the use of device_domain_lock outside of iommu.c by replacing
> it with the group mutex lock. Using the group mutex lock is cleaner and
> more compatible to following cleanups.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/debugfs.c | 42 +++++++++++++++++++++++++----------
>   drivers/iommu/intel/iommu.c   |  2 +-
>   drivers/iommu/intel/iommu.h   |  1 -
>   3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> index d927ef10641b..f4acd8993f60 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -342,13 +342,13 @@ static void pgtable_walk_level(struct seq_file *m,
> struct dma_pte *pde,
>   	}
>   }
> 
> -static int show_device_domain_translation(struct device *dev, void *data)
> +static int __show_device_domain_translation(struct device *dev, void *data)
>   {
> -	struct device_domain_info *info = dev_iommu_priv_get(dev);
> -	struct dmar_domain *domain = info->domain;
> +	struct dmar_domain *domain;
>   	struct seq_file *m = data;
>   	u64 path[6] = { 0 };
> 
> +	domain = to_dmar_domain(iommu_get_domain_for_dev(dev));
>   	if (!domain)
>   		return 0;
> 
> @@ -359,20 +359,38 @@ static int show_device_domain_translation(struct
> device *dev, void *data)
>   	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
>   	seq_putc(m, '\n');
> 
> -	return 0;
> +	return 1;
>   }
> 
> -static int domain_translation_struct_show(struct seq_file *m, void *unused)
> +static int show_device_domain_translation(struct device *dev, void *data)
>   {
> -	unsigned long flags;
> -	int ret;
> +	struct iommu_group *group;
> 
> -	spin_lock_irqsave(&device_domain_lock, flags);
> -	ret = bus_for_each_dev(&pci_bus_type, NULL, m,
> -			       show_device_domain_translation);
> -	spin_unlock_irqrestore(&device_domain_lock, flags);
> +	group = iommu_group_get(dev);
> +	if (group) {
> +		/*
> +		 * The group->mutex is held across the callback, which will
> +		 * block calls to iommu_attach/detach_group/device. Hence,
> +		 * the domain of the device will not change during traversal.
> +		 *
> +		 * All devices in an iommu group share a single domain,
> hence
> +		 * we only dump the domain of the first device. Even though,

bus_for_each_dev() will still lead to duplicated dump in the same group
but probably we can leave with it for a debug interface.

> +		 * this code still possibly races with the iommu_unmap()
> +		 * interface. This could be solved by RCU-freeing the page
> +		 * table pages in the iommu_unmap() path.
> +		 */
> +		iommu_group_for_each_dev(group, data,
> +					 __show_device_domain_translation);
> +		iommu_group_put(group);
> +	}
> 
> -	return ret;
> +	return 0;
> +}
> +
> +static int domain_translation_struct_show(struct seq_file *m, void *unused)
> +{
> +	return bus_for_each_dev(&pci_bus_type, NULL, m,
> +				show_device_domain_translation);
>   }
>   DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 19024dc52735..a39d72a9d1cf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -314,7 +314,7 @@ static int iommu_skip_te_disable;
>   #define IDENTMAP_GFX		2
>   #define IDENTMAP_AZALIA		4
> 
> -DEFINE_SPINLOCK(device_domain_lock);
> +static DEFINE_SPINLOCK(device_domain_lock);
>   static LIST_HEAD(device_domain_list);
> 
>   /*
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index a22adfbdf870..8a6d64d726c0 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -480,7 +480,6 @@ enum {
>   #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
> 
>   extern int intel_iommu_sm;
> -extern spinlock_t device_domain_lock;
> 
>   #define sm_supported(iommu)	(intel_iommu_sm &&
> ecap_smts((iommu)->ecap))
>   #define pasid_supported(iommu)	(sm_supported(iommu) &&
> 		\
> --
> 2.25.1
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
