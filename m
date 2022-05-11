Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF885C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 01:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AF8460AE2;
	Wed, 11 May 2022 01:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3J4lnkmNPv2; Wed, 11 May 2022 01:17:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6A43760A88;
	Wed, 11 May 2022 01:17:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EBC3C0039;
	Wed, 11 May 2022 01:17:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50E33C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 01:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3050D401E5
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 01:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YyeIDcqmAWTK for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 01:17:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7B74401C3
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 01:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652231829; x=1683767829;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/mYCx8UTEbxs35Z+Pv8f61s8YMOcZLYMmzzoYip4sMQ=;
 b=m5/4pcg1oS9NZgpXQtFcScTSt18jcmLlqHC39gnP+RC6vfTqKHkpu9Wd
 nUt4qcsw+JYAYqGnSsQ8KHPg8n9ltPR6W/c+raDYoJKUAUQAUdUiq7DIJ
 lMWXGzUwumBVwHDCSWRcgKUQMxykNPujMSTCaT3LmPmhGLl3e3GgYCL8v
 jKJOwBfzamgxb5etMEUAZilHahZD0wWG6x8ZPgCKzmvaH8vRzo+aFengX
 nrBSgR3SlgeCol3u7lCgaV0MBDO6q8UzsZ2y0Gtr1/TZlLwt5WIrTLMQh
 sXKDQ1FOkOb3hKwyV14Z8R2C4PRag+8ZgV5aFXnWwHlJEUTj5ccfau6I5 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249446987"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="249446987"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 18:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="571858269"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga007.fm.intel.com with ESMTP; 10 May 2022 18:17:07 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 18:17:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 10 May 2022 18:17:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 10 May 2022 18:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asovo7UsxJJDjKImPvG+gtPtw5AwxLm4JqVnvH8jZGdVclFJljjERFGtxknq3gQa1y8lsF8xZDLV+REpEL6EcDhgSoZ9UcXQwvVgQGryV3SPwc7aBLDZk77FzX9RYriO3ZabavpezCUPiADsM+yUeht5Qf+vFaJPGz5Q6J5AkJ2ULdhOGXhsJtBeblOwRi7Zw3SjFbVM7RvkwbGnZo7MCDzTYBMwrPgDDq6v2GXzmgZkv6wMWayYNFGm6ozT0DQJm7bewmPvei9PopRrnFIW3vB+RxK3ak24W0Ar8vFyEUMWIShS522/9nYN43PjLFDprWQWl3Ewv7mxxA7iFGI2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mYCx8UTEbxs35Z+Pv8f61s8YMOcZLYMmzzoYip4sMQ=;
 b=QsgfTabmdQi6T5Ai4cH4GLJfdPRfV6OzNtj7kTMw66cuImrzoDCggQBY46SD18opQUrBTwyKy6D63HLnE66Gu2/cAocl2T/tJa6vNaUCpu1Hs7fzSsAhYNMey+WcvjyhK3pdTxkhME91Ygh1nUlAC6w6y7IvxpJ9qdqc1+8Ovv8uMiEN55IW9gs6apfJO5gafI3MV/BCH85yfWX9dnRhKxoKRU/KHYBMWFqNZDkrkjIjYQsv1Jq8aBogDILUz21cDqb9dYtJQERqN0Cdy2fUHAXyir55WMvc1LY8t6oNPaU29GyB9wWJpP/xL+mOqkVDAAkndvobg9q2KJ+pHHY+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB4261.namprd11.prod.outlook.com (2603:10b6:610:39::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 01:17:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 01:17:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: RE: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Thread-Topic: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Thread-Index: AQHYW0R/S6mfDid5yEe6M+QKFrUDn60GOWsggAB3owCAACSFgIAI+m3AgACMaACAANzWEIAAjfgAgAWZrqCAALDgAIAA34Jg
Date: Wed, 11 May 2022 01:17:04 +0000
Message-ID: <BN9PR11MB52769A810D0C684F8F9FA52D8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <BN9PR11MB5276F104A27ACD5F20BABC7F8CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f5d1a20c-df6e-36b9-c336-dc0d06af67f3@oracle.com>
 <20220429123841.GV8364@nvidia.com>
 <BN9PR11MB5276DFBF612789265199200C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505140736.GQ49344@nvidia.com>
 <BN9PR11MB5276EACB65E108ECD4E206A38CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220506114608.GZ49344@nvidia.com>
 <BN9PR11MB5276AE3C44453F889B100D448CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c08528c7-a20a-0c38-0e7f-f51b8fade84f@oracle.com>
In-Reply-To: <c08528c7-a20a-0c38-0e7f-f51b8fade84f@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e99d87c-e5aa-4d4f-a635-08da32ebf57d
x-ms-traffictypediagnostic: CH2PR11MB4261:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB4261596C2955FA8EA8FECEB38CC89@CH2PR11MB4261.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a8IE+ZRZaoOR0hzgkf/ZHQkj/tfaqYiPnyo6dlOZ44uH7UdUEwZjMMzfPP2bEwsC7sSC+YZ3oFXyuVYtmCRLaNJgkcD6OOEof7a3ZmM0QB9YaAlkpWlFV5Jl6cPHXJfJf9pHG6AZaNRBaAl1QB48Ut6SEDYJzIWVEN6WzqRTdtaElLaWMlN4WolSNP3f657StQg09lCJksbtaPtR1OtcDFZQTA8EuJxRLVmTaahsQEXVy7rQjiJ2M4ZZkVKbeE0v5+rQTrRkI3P+QDCVBHWn8xiR159YwiQXmCg7zv6dpYVWG30atDFBuN/3fq0Y4JQKheVyx9ZoZM8auh0yELAuMzxRiwLJiPG225MqDueqKp+tvFzkhYpqxLY5xHOZ9LzAydrVDygxbfQq6EfsKkAY40+RDIhR2Tpg0wfdaca3vDpJwnjo5UsRkXXsKa79aPjUTIJSpobB7L2mVPQ3+vw4bain0pQ209Fs2Hl2PmrXVhTiZ4z0XunT19kpHqP3u0f5zJFWSYzv01sv9y+RrybT1fLXT27sJi0NctoUc2csc/bCjHjAxoBCASpezg6VFebQghKYQdQMaEx3P3kGbXZ9+uBLwtzjFPpO+aLxjwg2swaFFs2swps8KIqpwpsRInGVVZTtqWV0Gau9bZZd5j18Wtib8DgSwIiYVCskvq/P7g11SAcEY52Bye4fiEYCaV6lDX0jpBw2BoYvQdBWsxsAknhymIWTuptRaWkGXMb2UKw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(7696005)(38100700002)(86362001)(53546011)(71200400001)(38070700005)(6506007)(508600001)(83380400001)(8936002)(82960400001)(122000001)(26005)(186003)(9686003)(55016003)(33656002)(5660300002)(52536014)(7416002)(54906003)(110136005)(2906002)(316002)(8676002)(76116006)(66476007)(66556008)(66946007)(64756008)(66446008)(4326008)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VktSWXh3SHdrYnMrb1JXeUIrV3RkK2EveGxaa21lMUlNRC91cnNVMUo1N1I3?=
 =?utf-8?B?QVRVNkN2Tk5DS1JWSXEzRHk0MU5ZbDhuK2kyRTR0dDN6R3NUcjROdk9Ea2I0?=
 =?utf-8?B?K2d3clhlc3AvY2hXQTFKSks1RmFtTStpMjFYeExuV1E4cXVPelFsMFF6TXox?=
 =?utf-8?B?RjBwbDBzK1dwbWtGODVKdEZYQVhBTUVEdmlKQlJLTEEwYmIyQ3h5dGJjUHMy?=
 =?utf-8?B?NW1lNXpiRG9PeVk3UDZaaXdvNEszMHprRzE3RnVQS3ppQlNKR0pJM0ZTOTNx?=
 =?utf-8?B?VytrclYzRFhsMlBubUJiYVdqallFemRzajRYcjhKejY1U2RIYWIrSW9mODgr?=
 =?utf-8?B?cU9yVVIxdlo2OW9tRThTSGhYb3VWRU1XdEhUZmlXSHVPcmtrU0V3eGovbFEz?=
 =?utf-8?B?RHcrQ21reWlKcS81alNSVmNOM096YmxUQzkxSzcrYlVGNkFja2l3aXJ4YzhP?=
 =?utf-8?B?OG5iWWNVdFoyeTlSTUpyVVNiVC9OUXBaQ2U1NkdCYjV2eDM1RXJjTWRyTUly?=
 =?utf-8?B?QmVxd3V1LzFtdm9vMTdMbUlNbERTRDZmbUhuK0lxeGUzc3dmQTN5Smh1UEJI?=
 =?utf-8?B?bENmeTRkQkJYTEdURzIyQXl6aWk2eXRGb1UrUHN2bGJNeFh3RWdnSTRaM3lv?=
 =?utf-8?B?TXB3WTY4Z1hKbTRLWGtpSERzbWloaHp1Zm9DTkI3cVI1UzQ1WklhRlhSL3dJ?=
 =?utf-8?B?SWF4ZnBLNUdJOVMxNUJ2aGhJK3NUL1d6L21WUk5hR3J0OGM3RXBRY2xFZG1Z?=
 =?utf-8?B?bUtKSURXUjUzdVJzK01XUDBVdEYzU3lEL1Qxa1dxWjMrZjYyV0UySFh0Sk9n?=
 =?utf-8?B?UGNwVTdZc29rSU5mYlFhd29QYWxKS1lDVkVqNFh0RDBiSTROTzBnbHIrNGhy?=
 =?utf-8?B?MVlXR0NKek1XdTRpVDFvdDd3THliUnl6YzZvZ01YM0tjNUQ3K1QxWWNqSGp5?=
 =?utf-8?B?MG1wSTVoOGhEb3h6aUZIb2YwV2Frc2hwZTFVNUNmeHd6TVNvKzN4VWlXeHVQ?=
 =?utf-8?B?KzBLZ3BHMHptMG8xZk83UVdNNUhXdUdYUVBvRjhPNm5wb21XcnFjMzJ4NGp2?=
 =?utf-8?B?bFFtS1ZPVDR3YW9QTVQ3b3NUb0RQN0NrcVozWEVFQ242OFFjYnhlZEZrNnV6?=
 =?utf-8?B?RjNMaFBZQnZjUlZhdkxWNWE0RlI3aTIxY2pMQ2RBSDZkYndQbjRsVTBtM1Bx?=
 =?utf-8?B?cE9qRkNTTGFSQW8wY1N6cEFjcHZqU3BLU1FCZWc1TUFqUFN0QktnWjdmVmZx?=
 =?utf-8?B?T0c2Y3VTM2U1K3dFaFBFQjlLZnBOTjdXRkVYNTR3MXEvenZSQlYrWkQvYmo4?=
 =?utf-8?B?Nno1aFh0RXNxdGs2YUw0RlJ4UHZSWjJRZmltUjdCVGxzWXM5UnhTRG9hYk5H?=
 =?utf-8?B?WWRydzhiYldHK3QzZGJMdTY4Uk9sM2hsLytDZ1JhUXB6Z0tnR09XeERNdTBh?=
 =?utf-8?B?RW9pMlBGSTNEYlVBWTRXQTM3U3NkVmg3ZG5WNC9ySjhiay8raVNPT3g5Qm1z?=
 =?utf-8?B?dTdNSXcwS29Lc3h4TEhHWTJZaVpiWVdOMTVuOU94MTdjeGFXblRpekREY3d1?=
 =?utf-8?B?RlRuRVlCdDIzc2Jib3QvNkZWSVdZV2FrQy8zQm91OTU2MHdLZ1N5OUJHV0pV?=
 =?utf-8?B?VWptVVdOa3FmRTFNR3l6aC9QSk5PMnh4ck5VRWxNRmwxcm56ZkpsdkN3cVdu?=
 =?utf-8?B?ZXR5NHdDV0pkWXF6MkdFYjlUYzFLZnZaeE1TT1htTVJ5N2Q4SDNES0t5bGRL?=
 =?utf-8?B?S2Z0YUpZb2hvZGtmR2YvSkdZc01PSTlTWGE1Sm8vM3liTFloQ1pSQmNKc0NR?=
 =?utf-8?B?emVKSjFmWHRiZVhTVG96bGdkazFmUXZkMmw5cGJCUGVHUGZYUEdONnJoR0gx?=
 =?utf-8?B?MU45T3ByZDdNeEVrL1NzWDRIU0pWbEhHY2RqeFFSMUR2YU00QTVIUkRLczdS?=
 =?utf-8?B?TEJCV205Y0lsWGlCUjN4NWJrVVluUEcvMi9EMkEwWVBKVjN6SGZnWG8yZDVN?=
 =?utf-8?B?U3F6c1I2TmYzVEIyNXozWU84UlpRbm9EQmtHZUM1ci8vSzY4YldLMGhhMWI5?=
 =?utf-8?B?TkdHYTJqZ0puRjFpVHZCZlAxTkIyZk9WQk5Lc1RhdHhVdmRHN2lvOExNTzJz?=
 =?utf-8?B?VTB6NndxblFCNG9VZmpzV092VGExd3cxdXdtclRFL2Z4TG5jMHZTVEpMaW1r?=
 =?utf-8?B?OG9XWmZBSzYva2ZrMDgraWRvSjZrWlVsRjJ2cmdjWkROZ3RzTng2Y1FlOVVl?=
 =?utf-8?B?Vlp6ZzBEcm82dnFHWmFZZHRxTyt4WHFaTkduSkpLaWtqTTd0Y1RXL0ttR1Bi?=
 =?utf-8?B?TkJUa3lFQTArRzN2Q3V5dmRSdXRRYTc4Y2hsOWVvNmVWLzJlYXJiZz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e99d87c-e5aa-4d4f-a635-08da32ebf57d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 01:17:04.3077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkSZ8lx5sCO7zwWFyNR7T21QhRrLmO/zPrIuW/eWCLKkljSSdiKctLbxx4qHQi/DMnfjc/ZP1HgkCAhDKoUCrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4261
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yishai Hadas <yishaih@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
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
> Sent: Tuesday, May 10, 2022 7:51 PM
> 
> On 5/10/22 02:38, Tian, Kevin wrote:
> >> From: Jason Gunthorpe <jgg@nvidia.com>
> >> Sent: Friday, May 6, 2022 7:46 PM
> >>
> >> On Fri, May 06, 2022 at 03:51:40AM +0000, Tian, Kevin wrote:
> >>>> From: Jason Gunthorpe <jgg@nvidia.com>
> >>>> Sent: Thursday, May 5, 2022 10:08 PM
> >>>>
> >>>> On Thu, May 05, 2022 at 07:40:37AM +0000, Tian, Kevin wrote:
> >>>>
> >>>>> In concept this is an iommu property instead of a domain property.
> >>>>
> >>>> Not really, domains shouldn't be changing behaviors once they are
> >>>> created. If a domain supports dirty tracking and I attach a new device
> >>>> then it still must support dirty tracking.
> >>>
> >>> That sort of suggests that userspace should specify whether a domain
> >>> supports dirty tracking when it's created. But how does userspace
> >>> know that it should create the domain in this way in the first place?
> >>> live migration is triggered on demand and it may not happen in the
> >>> lifetime of a VM.
> >>
> >> The best you could do is to look at the devices being plugged in at VM
> >> startup, and if they all support live migration then request dirty
> >> tracking, otherwise don't.
> >
> > Yes, this is how a device capability can help.
> >
> >>
> >> However, tt costs nothing to have dirty tracking as long as all iommus
> >> support it in the system - which seems to be the normal case today.
> >>
> >> We should just always turn it on at this point.
> >
> > Then still need a way to report " all iommus support it in the system"
> > to userspace since many old systems don't support it at all. If we all
> > agree that a device capability flag would be helpful on this front (like
> > you also said below), probably can start building the initial skeleton
> > with that in mind?
> >
> 
> This would capture device-specific and maybe iommu-instance features, but
> there's some tiny bit odd semantic here. There's nothing that
> depends on the device to support any of this, but rather the IOMMU instance
> that sits
> below the device which is independent of device-own capabilities e.g. PRI on
> the other
> hand would be a perfect fit for a device capability (?), but dirty tracking
> conveying over a device capability would be a convenience rather than an
> exact
> hw representation.

it is sort of getting certain iommu capability for a given device, as how
the iommu kAPI is moving toward.

> 
> Thinking out loud if we are going as a device/iommu capability [to see if this
> matches
> what people have or not in mind]: we would add dirty-tracking feature bit via
> the existent
> kAPI for iommu device features (e.g. IOMMU_DEV_FEAT_AD) and on
> iommufd we would maybe add
> an IOMMUFD_CMD_DEV_GET_IOMMU_FEATURES ioctl which would have an
> u64 dev_id as input (from
> the returned vfio-pci BIND_IOMMUFD @out_dev_id) and u64 features as an
> output bitmap of
> synthetic feature bits, having IOMMUFD_FEATURE_AD the only one we query
> (and
> IOMMUFD_FEATURE_{SVA,IOPF} as potentially future candidates). Qemu
> would then at start of
> day would check if /all devices/ support it and it would then still do the blind
> set
> tracking, but bail out preemptively if any of device-iommu don't support
> dirty-tracking. I
> don't think we have any case today for having to deal with different IOMMU
> instances that
> have different features.

This heterogeneity already exists today. On Intel platform not all IOMMUs
support force snooping. I believe ARM has similar situation which is why
Robin is refactoring bus-oriented iommu_capable() etc. to device-oriented.

I'm not aware of such heterogeneity particularly for dirty tracking today. But
who knows it won't happen in the future? I just feel that aligning iommufd
uAPI to iommu kAPI for capability reporting might be more future proof here.

> 
> Either that or as discussed in the beginning perhaps add an iommufd (or
> iommufd hwpt one)
> ioctl  call (e.g.IOMMUFD_CMD_CAP) via a input value (e.g. subop
> IOMMU_FEATURES) which
> would gives us a structure of things (e.g. for the IOMMU_FEATURES subop
> the common
> featureset bitmap in all iommu instances). This would give the 'all iommus
> support it in
> the system'. Albeit the device one might have more concrete longevity if
> there's further
> plans aside from dirty tracking.
> 
> >>
> >>> and if the user always creates domain to allow dirty tracking by default,
> >>> how does it know a failed attach is due to missing dirty tracking support
> >>> by the IOMMU and then creates another domain which disables dirty
> >>> tracking and retry-attach again?
> >>
> >> The automatic logic is complicated for sure, if you had a device flag
> >> it would have to figure it out that way
> >>
> >
> > Yes. That is the model in my mind.
> >
> > Thanks
> > Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
