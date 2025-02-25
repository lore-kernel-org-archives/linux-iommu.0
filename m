Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144122673B6
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471484; cv=fail; b=Jc6Ma3kWwQ/AFbYCFndQ+qxkFn5oj19mjfneKVE1+a25lzy6/ePZIMVwz1/gwynJSUgwen2w60fVcOf6ovGY36yeIAneewfAkLn/KjHIWwUvwdg4uUtrRuJJPvdPjHl/wFEQgSGs4hySOnrSaclCRJI6nm3T0WCW3VN380p953Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471484; c=relaxed/simple;
	bh=4iHCQUBRyiu5DfFpqPot8VBiGZ7YYbKOexHG7WJMpTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VjdSdxaJgtoLN6AoXINq78y/jZWp8rx2qAVUSycE6atpbmLx9KmTxCfQq7/McMwaEmo2738KCopCvCmCp9vlVvQfEjOPxYRgUJgz2rAmSTxc6U6RS76+OfP7pyNdBL37EVzoVWZeY377FjmVAe/7w+Ro2Kz+xjcU6LmIdwC1xc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0rb1a+f; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0rb1a+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740471482; x=1772007482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4iHCQUBRyiu5DfFpqPot8VBiGZ7YYbKOexHG7WJMpTs=;
  b=c0rb1a+f1yRKX0lwP50rrP3j/AmtMA6cdpoCGNKhfvCjaIFoZcuf/JKP
   xxByOU+30Mq67kVZb8RRqdGywwHavCpk0mpl5kBFdEEKeYnbS94ZfQYwH
   HkQkhVa1qli2WPu3/Kw+U7Qln3CVq2hhrqLs1TuKctpgIZZjVha0iG712
   qsaTUTvf4dAxJgdREfqBRRXg/PzAO/DCmLsGpXXSty51JwoT3m7wZIiG6
   41rWJa1FLf8/VJUQ7Wy5hfg4ocjTWvLGzrHmrjcMrFv82AV+tmpcJ8ozc
   38TXdzbVgOPLiE+r3myEd2WoS7m1b0Q3Otw2VV9t8rcIhQZndEuxtYe5m
   A==;
X-CSE-ConnectionGUID: VtaGqcE9TGqxKUnsEUHf+A==
X-CSE-MsgGUID: Vw7TMC95QKCoUfQoFwD3dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41394230"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="41394230"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:17:57 -0800
X-CSE-ConnectionGUID: eCLpatbARAmn6u8tAmk4jw==
X-CSE-MsgGUID: 3icJEPNuRIyLUqS6/cXf9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="120941404"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 00:17:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 00:17:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 00:17:56 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 00:17:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoTVJV/MaJN+APDP2d4l5f5dOErZRORKTRtMFOPY6sryYR6KQiq4EbHxSivLnIBsed8+5Iy2djxc8efE9j+4JY9NuFnXH2vxxXS3RLC/TH5bOyOg9ItKIOWQlwgIvyU+MVWLPXFnXmEezPyklB/lWAYIiuuZKfu5z0o36cw6LyPx7dOTiO2WhljpkO+vM21dDBUErNae07RJG91kahlJrr14uHMkDPx9QsAN/Dz+7kqxrlovQC5/aJ+4aCntXDkZP/Jxi23HR46lEv4Uu42asyq3IXZsP1sJxNCgkiIUniU0n5KMzOz0pK/6NjaGmmBEBWlW42rKmJoDhB1QO83sEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iHCQUBRyiu5DfFpqPot8VBiGZ7YYbKOexHG7WJMpTs=;
 b=Nf3lGqABe10WC9iU7mXjXfjBFkXdftB4mKYAhbEfSnuohUecKX9ljMqg902Ryk9svEfE2CiWxuKUkapvOtKZCUr2JAp0BA768YvjCeJPUjjhqCmOhF7BoFQjJFcu6GZPN4WfNFmPk9ytrGmvtmAqse8rYO6z4zCjkfmFK5MjxOJsznseqauGn7N6siBFfNahdk6IcJrVX5157pEAo+DeOgwaNQJqrktMIzpNKBZkCiql0qiVjflGVKQNtbly7hbk8m9jPglH/x81sR8OQ/nZTBPN/9sJmX5Lsm19hA8spoa/D3zJLokXngLLJN+2TFinDasIwrB+wlIeN1aqpid8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 08:17:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 08:17:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2 10/12] uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Thread-Topic: [PATCH v2 10/12] uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Thread-Index: AQHbhntUjUrCABRfAUmOFdDsdaR50bNXrkbQ
Date: Tue, 25 Feb 2025 08:17:12 +0000
Message-ID: <BN9PR11MB5276D4184B1ABC3260FE79B68CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-11-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-11-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4620:EE_
x-ms-office365-filtering-correlation-id: 768d15f3-9a41-4a36-29b1-08dd5574ce56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4t+dcCNgSI+8YITVTFDV79jmLiJqmvNNyV6emY4sTYRTzzaghET0Wen9v0Lq?=
 =?us-ascii?Q?Q1tPrv/4n4i2bNUH/0KXXYhSTfvqE0dwvq2Hgk4SCzH8bFxTf5Ze1mXnKg2m?=
 =?us-ascii?Q?cJkhDTJ7J+vhYFOdIsE+WN5OklDObNrmhFeuY1j4cdX5T9UTmCTm+a5Op0N3?=
 =?us-ascii?Q?h2VQNQ1HZXQjV9qcsgH8y6G5h9hUgVxmJUKHVw0dz2Y4YfPXNODQkBKbkePG?=
 =?us-ascii?Q?ukNNCjqe8MNycTFcEh8jHq4pSHBKF9K5kum7fVwUeC/LyQ7qBNA5k63VUnQV?=
 =?us-ascii?Q?wz+ka9w2kCF4j5WuwOcd5Q9ciE5dYchIKkp5z5p6Zbf0d7NV5myPClTUP7oe?=
 =?us-ascii?Q?ql/OGE1XXPlDtUSdtQe6IQ4k/B3nwaeHXEjZt8JMhJ3R9tdmr/aKEq+9CHsd?=
 =?us-ascii?Q?4HGJKRU/kH+5V95bNFBMLbWYESA4jX1NE8azTo2G5gGurOwFCu+hEQ8dbWsC?=
 =?us-ascii?Q?DL7/C42U9XyYWOUovcWb5XpWpz13UBehjLs06s8ui9Vg5KX6pdLX/FxdoInL?=
 =?us-ascii?Q?f1ndfaZNnGcf7NsPHzriEBHjCI2hnx6kAZjYYU61vhXTzaYpNjubqeYZ/hAt?=
 =?us-ascii?Q?O98b08CpqNVReFJYZQaVdvUB6YMNJyOwHpegC533qOWdOHEW/RrPDvlnUy/T?=
 =?us-ascii?Q?U23cmKE2jdRPJZRESH26xtqEHmQUyAS2cm0neo24Iki5jsZxn4qZs+/LFRyV?=
 =?us-ascii?Q?aScwOZcy/cnvV+YguAY9z011fbq9IvEh00obV4TKw8Uon51vWIBu+EIscwaa?=
 =?us-ascii?Q?oWSMVlCeTC/VUvB8/P6S8vUmRmDNxvY5LWMUQhLmrCMhQsNiE3qWqrA1ZE5P?=
 =?us-ascii?Q?atYhh8Di9HXTQ+vIGtHZswAOp0/fyUyAhfjA/IoWBG9AYN/knyLBEDMbmRb6?=
 =?us-ascii?Q?exS8Jo6yhcmMEkkb7MMc7J1FCKAUCmU74tYykts0oS6pIn0SGBWvP7xDv053?=
 =?us-ascii?Q?fo73W0/DWuqLWu24QIwuK1JvbGfcEbTjClhBDU1nZrGQQ3d4o8yytsIA18bO?=
 =?us-ascii?Q?o0rbRg3Q/2Jd83Mb+/E8DQyeR4w9AtVfuLIQb6lp6aHeIiX3vObTAnpKfk99?=
 =?us-ascii?Q?kV7LMIW/KCW8DGgNXFT3iJYkOcAubgfscuZ60DTVCYQB6apGvWRj/70E2uWE?=
 =?us-ascii?Q?3wU1wKz2T/JjJhgBd2rZnvQrd02888gsPTaGiodlMiQUVScPMi+cgk/Mnp+P?=
 =?us-ascii?Q?SSNwMaeY1utoaxixWN8x+XBHAEhRfrHuXuIvRVBElyzgBDANTP04sjlJegl7?=
 =?us-ascii?Q?x3PRChAPKqlX5Y6Nb/MT6XgI9OKHpTH2sE8owTmxxb4LH4ji5LwU9WJ20nmr?=
 =?us-ascii?Q?VXWigJb4CQ53X2kx1CW0/gCfzQFmzkZZG6gOsIT9t3atteT55muITd8Xgt6r?=
 =?us-ascii?Q?Lj4+e/hYJAwlHCow8pgm/utEUguu43arM+OzjwuqRmZ+irG8KOE8aV8JbNcZ?=
 =?us-ascii?Q?EeXy3h2XgyIBezOOf6Hx5LxdwD8/XJke?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ahiRHuOxwnyTeZQGuo0vpMONdjL6M+dCqpKWiYtGwsGxiKtHNnDDMz8b1EJ8?=
 =?us-ascii?Q?TIxzyfEhBF7F5VStbJz4dY1fmCyQVdGWe6STkeQT+rhnNTGnwwKChBGmgx5L?=
 =?us-ascii?Q?aLkh9f1niXjgpAb3j5VsKpE5o0n+JNXnMvHIU0h6XbLUv0YxzwnUbYI1IEo2?=
 =?us-ascii?Q?893LXe73mWEg9SlTBo4n41Beo/VzejzvQazPBjsw4Q9pOAeOSUu8Gtdy1KlI?=
 =?us-ascii?Q?0+laGOWMrViCns70ldhjyCpcmtkX9cj5FHXUQqPCgOI8GCnb7V93RZVipzId?=
 =?us-ascii?Q?spgAmkfoWeTV2ng9wiAXd8cdjdchGT6Nu2sKwz0YUyZa4OnqIBn8NN4melTz?=
 =?us-ascii?Q?A3lXqk+BF1jJSPHq3IGAXD7CwhTA9Qrej/dnaYLycB/Jeic4eNy5ly/4m2Ip?=
 =?us-ascii?Q?ClbAdHj3v3rUkG8fAV/FEwYSGuuRqSifqfpYqzKU7DdGyGaTkdj/NbVVoH7/?=
 =?us-ascii?Q?v3qgnHcz+WfDDiJW5HjTAXa9KJZkUzZatEiZ6j4szVqK6Ql/TWnu/wKhQ2zQ?=
 =?us-ascii?Q?HPNd6WtH10pAvq2B6ss6bK3JE2IZ6SNbqVGL4J1wRosINFT/IH97Za4Vc40I?=
 =?us-ascii?Q?htximBOJv7L4kJQ3POpm/TvObkNrD4NE1AVFrUzQnfNOMgdRa9ABLv8diS3Y?=
 =?us-ascii?Q?0LOaS6BvstjrZWR8jgmvgiKlCQIm6m//x1h45+EAFO+cJu+B70bfklQRHwGr?=
 =?us-ascii?Q?z/CdHeNNryzBt9ModDnuGUwoFlJ4pHUDbiFiiOIeVVBcvfCVYPkc5u9k6AyE?=
 =?us-ascii?Q?lkZCS5ShfFTrGqn1TKzfX5I+rC6aZ9xWAgediThYyHa3IW0/DKGi57kikDUC?=
 =?us-ascii?Q?yazzCZugEkqVJnVsngWpQ+qkumeEBxPGT+8jpopn8HLNttXzWLBnOwcdrSPB?=
 =?us-ascii?Q?dOQVVXzKpJ3dWGJFHvMAT0sh+r4KvOSR0MFeVkSpleAuoyc34oujw33AMj+f?=
 =?us-ascii?Q?O4UqfniFTE6TbrzkFALASpB2UXpEYY81Ps6X4/0abr4MSSGTQq32GqsIWiJ4?=
 =?us-ascii?Q?G7pru00d6hIPGIMlkTLwNJvCeObhMZ+1mqxcnhtRuhydT6EeVOKcdb8hZyoN?=
 =?us-ascii?Q?nhzDLq4f/7yWs8SxJ5TP0v3YDOtDIaSdNfk4UTk6qKpNcAd5MhAv/IBddhB0?=
 =?us-ascii?Q?fEFzEJCqAnsDv+6SHH+8CiCzNJQh6NLhE61pNO7VGESJuCaWBEuuU7dCrybA?=
 =?us-ascii?Q?PX4C3FnZ+cfAYF5TVvoRqyqPCN9jvWfeB8Lj1TM0HzaWnzDNK+5jPKdhVKkM?=
 =?us-ascii?Q?AZpaCQ+aEfEZGPgUrAae0uxYl/0MWutF0viz4aCN1y5uwgs8DF/ugo28I18o?=
 =?us-ascii?Q?ePNO8PNffZxhCUIFPIHPRjD/F5mfzW0pqPUVvdw90SR0Y7V+QyoL89OQtD6u?=
 =?us-ascii?Q?MaLVOn80maPoTPG0N93qb0WwApC08Ej2ndd2rdthB/OVJwbjWkc7HC+PjJ+6?=
 =?us-ascii?Q?V5aF22tSYEjG1K0Y+OW3Jov/ZaNxgrHhC5X01OeqvBZSOQ2d+IFEmJmSbhxy?=
 =?us-ascii?Q?+uJaBp1tKDcXM50UT02yzIt0W1Cr6x5N4as3ql5D0AS6R4TP4BZEBd4bDnrq?=
 =?us-ascii?Q?sXg61nHilFqbAph+znVpqUkTkJaumolgzDqX8z/v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768d15f3-9a41-4a36-29b1-08dd5574ce56
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 08:17:12.2496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jltSIJSEkjVo1PMy0FUhfM1sVNj6m0nJgZ9tIgUuwln8S2NUgBppiMONGrus0KuC4Gi7mc7euTMWVwwYHfuqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, February 24, 2025 1:16 PM
>=20
> None of the drivers implement anything for IOMMU_DEV_FEAT_IOPF
> anymore,
> remove it to avoid dead code.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
