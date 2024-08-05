Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A503FB3B
	for <iommu@lists.linux.dev>; Mon,  5 Aug 2024 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843650; cv=fail; b=X4x4ag6etmw0P8SD0WD5togGX27FVbzQK9tFXVrhKFimXtBXT5k4T665Xo03Qvg5LI8Ljp2RcQxD5wOXBnP69CYVUCP74J4JAz4JnMDEZglL078hrDyZR7YWwTk11yW29Wx+ABfNClDJHGCfQGP3Z4iT54n0DaJhuX2s+FF/4AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843650; c=relaxed/simple;
	bh=u9J8vEnZ3OcxSYyI5HScrpHorU+4VlpNFDd63rCuwns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AcIbVP79UCbk/1CludUqepNHtUpSJz1h0BUSOzEfm82TFPV/MZcIey68C5pweMVC6Mok487Hvme0XGrbXTiYHGLmTjONbuqPgm/wP0C+Ax9igmBbuzY17vyx40N4sii2IG9/j8HMKXeR57IccnTB0Dvl9ceFK74i/m386uLy75c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDgOLGBd; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDgOLGBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722843649; x=1754379649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u9J8vEnZ3OcxSYyI5HScrpHorU+4VlpNFDd63rCuwns=;
  b=PDgOLGBdF8caC81pbH5wfZohKPt3B91GuaOU6iPdD2XTmY2kIrdjwmdw
   LLzbGXq0rNoYORbW5wNMxIYdjYA+pkej6upzrnNxkwflfNmo0kiVvkHEB
   WbVZx6bxy1sKwKGVMRUA6yU4m3PwU0WUgE26yUV2fwQkGGT3wQ0OwzG+0
   dtQl9sdScPMwrsR0uNnVFw80/Z4vA1Oqmax/K4Lj53fRUaa5hMTSUNA8Q
   KNoNCECabzEjyqBRtPUVNHKaq+zEnnT/S0ewj6F2bPfuS/VGHaa82vdfp
   tly3stNIHASm8znGQc5qexzHWDjmxVTTgM5qBGkeyQtrJ51ZCIDcUPs91
   A==;
X-CSE-ConnectionGUID: FlP9HLtEREq2ysYiH7W0PQ==
X-CSE-MsgGUID: LFkKRoXiRASTMWvfT0G9bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20366723"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20366723"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 00:40:48 -0700
X-CSE-ConnectionGUID: Uz7pusOHQ+6aqmmrTUW98A==
X-CSE-MsgGUID: LklX/3k3QmGNex8wlQ7v3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="55952897"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 00:40:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 00:40:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 00:40:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 00:40:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObK5QT9jZWae9csDWsr7E0pDwOFDc27fOaTPUX0e7s8e3xlEtNxlm7w8mEXqUNRPHFiTMvQpd6Us9A3JLp8Ml5zSsFOctEPGojC1puKV6TB2B27Yw06Knn/1xMzfBxFrDFiuGhKPBitsjBKfo1WZZQmYcxMZ+3LQTBErL8Z6PHBrWgVme4XH6Q2QKyhQ+RMX1vvsf2iFXVisc31Vk1TFSIxSJMjNjjlu6UP2U1tEviA2Uj3xhNlnUwNkH+y9axhcGyXZcWvmrGGhKgdCNwCeWXVVDAdTk6CuPeX7terDVQeyLXWEfhjkv2dSr1RfkXTocTrNsIb3Tuw+Rt9Ex3uMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY5yM4d/a64cqlLtY1v0KtPwwTaO0AWT9HbSDzUhQKM=;
 b=OxM9HjcZgJ7FOt/NWio+ERMn3im1kgHR34I2K1tup7p4zSiEt1gCJqurZwQR3j914AVSOXJtPsaX+p43bAdPNJq+eCNybLji2UCnAf7wYk0XncOZk7vaTAmPGwI0MLUKM7bsPZAtGAdJ41Z/TXxWerzIX5PdjTeGqO02v/yrjUVdlWB9mJz4mBWyWc2j6DlkleCfUwfuCA67PV6sVCvZbz6dILgTF4RhKMyeQ3VqNVoQEriyFBIyrWwKReoyS3dcfVSIAmN2wLDInIAvAANt5c2SjLFf5Lhj5zpl1Ew5UHIwBflZiNspSKiMMthlsFoT+g9j8BJPmMFpKNqKu4j/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.26; Mon, 5 Aug 2024 07:40:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 07:40:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommufd/device: Enforce reserved IOVA also when attached
 to hwpt_nested
Thread-Topic: [PATCH] iommufd/device: Enforce reserved IOVA also when attached
 to hwpt_nested
Thread-Index: AQHa5J3TlyHszQz2P0CCi2K4J6viy7IYRw6A
Date: Mon, 5 Aug 2024 07:40:45 +0000
Message-ID: <BN9PR11MB5276B6D6A75FFDF7DB14CAC18CBE2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240802053458.2754673-1-nicolinc@nvidia.com>
In-Reply-To: <20240802053458.2754673-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5966:EE_
x-ms-office365-filtering-correlation-id: d6b36251-45b7-41d1-8f39-08dcb521ea87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pejUlgewb1T3Q4ORYVckSLxSlcIRpKKJ3Lk6Ih7oolFH9UCFMBglZKZuakCe?=
 =?us-ascii?Q?RpN9eJfQJZ8wG6mshA/yKn0wjOoxd1D8JxkV4Yfej3X6o/aN6rhJMeqcHiTn?=
 =?us-ascii?Q?KEncpFq4HAruQv0n0xWJvcJ+n/cOmc9QsJEK8mj7usMgRDy3qsenvmzMImum?=
 =?us-ascii?Q?EU5m22IKEDlneux/w1CmXkuyiJa59QDV7at+g7LGBhYx0nojY/XzR3LwqPvm?=
 =?us-ascii?Q?sxTIQHySd4Qg+Q4kll51qbGrXXWNEKKYwCYAaR2yVe2z2qxgJjBTNS2zzXum?=
 =?us-ascii?Q?MVtobwO6gRFn3KBanI9MMn2Z3Ae2Zca/Z3/Yl/cwFKEsb+cTH4E/2e7laRXv?=
 =?us-ascii?Q?LV/gjTewsK9mpRSUduk2n5SlKRlrCSxhzV6AdNt1DWXinkYS5mUViYMLhZfX?=
 =?us-ascii?Q?u4OTefjyjDDt8HZxx/ys5RZR+UCD0K6/2+9W74PIowrt7AQzXhV3IkLGNkky?=
 =?us-ascii?Q?Vy+o25FMNTD4/wev/LrZODGT5/aMdJrA98d5MjPg24l6yk44ZOkLIeG4ONX9?=
 =?us-ascii?Q?pl2EHK99En96TheslAWqQAO8SSGzPL2tYJsWyP8JazQmuHe/5Pa40OzPweg2?=
 =?us-ascii?Q?z3JVsn1xa7Q1Wo6QDjVTCJOu5TriazyRY4Nwoy1106qFtFmG03nny2SHEZ0Y?=
 =?us-ascii?Q?flUztTSQJpnDWSHRVpBSEdvyO55gn5ggGTcZEJSZimJ4iLb5WL0Qon45aN3w?=
 =?us-ascii?Q?PWeVcaRmxlCyK/9v+VPzshMpR4ijfgyhWgw3zMdvbJettURA5ZOvZ6jASoak?=
 =?us-ascii?Q?C84VpuVgfB2nYnDCjLZPVWAae0SLfuw1DSnH+f+kUursWlFxrCtWDO3Ad8vo?=
 =?us-ascii?Q?lDCXw9PSWKVfzeOEIPQArJxIyMxhB6GK/mGOBmrpPdpFm1uffX1TsrZZYdxj?=
 =?us-ascii?Q?K4Jk3KZu/xxfpZRX0M8U8aaDGqltqabnBXZokl1KBNzjJL/r1s/gso6dOgFC?=
 =?us-ascii?Q?UK2irwrKIH7TS6z5qW68flVDDZkBQcp3nEsknEB2JqmTMqnBu8li6KX5o7NN?=
 =?us-ascii?Q?p+o058qA295sH1UytFfR7yfFgGd4HmLMvjBZAZAfDeWAsIastAFL16zDBIYF?=
 =?us-ascii?Q?kqzdDoCUsJoyieTwvkdoPe2+LylQa2pfx2fjafRaiNlRXHpjTO7FlKBJ6WQy?=
 =?us-ascii?Q?wyckSP5tVGB3qrGV9prs2mAojRD1BShuwCzoeaZJTyYEj+6/qnyZJ+HOWBrU?=
 =?us-ascii?Q?uHMsAkPUphjNbEEoabEbieuxcDaUy4Cs2G3+VtSU+VIaQ5mpazo36Z+RJCyz?=
 =?us-ascii?Q?qyvs2V11XVDsnENYTiiLMMqTqPCO4i6BPprbXYuTit7lKH0hJi46O18H8pHG?=
 =?us-ascii?Q?aNw6Axgi5tE1Pn8B4fxSn7DX+goDOULB075d3Qcb2kJO8aseEfRuloFDhRGs?=
 =?us-ascii?Q?rIlX/t11eOMIoRe+2CoOTbq3Jtp53ngsX3cPErG0y63yre5olg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?32kfO5l3476nItibNrJIR48VuHTKdI6gBwu8oiOcMq+LTCgM89KSjU3PS5J7?=
 =?us-ascii?Q?+LaSAzmNLLQ9k7jLFma9X7sXsnc8wZtJXlOyc1siTBpJSu7MqSNqRNmWBWaG?=
 =?us-ascii?Q?G94t53YehejU4i49IhYlWGa6e0uDSqXLMNW9JA2rXkdXDtZLFQ+Ebxyx5jjV?=
 =?us-ascii?Q?CTr4CmMqWwj7glwhSHH5c3yVN5oQDcbOmh/sA0X24IeqfUXAWffFSajU8JX3?=
 =?us-ascii?Q?jNHmXou0ys3enzIXd9xOjt4fypKsewVR33oEZYPrYXkMLr1N6vcJKAXQSF9j?=
 =?us-ascii?Q?Y5MehSY9XsRWW3L/0wEqmzri0CIJafMeiUiGun7+qYEasfWB7CSDTB4suyXi?=
 =?us-ascii?Q?eJ1FFpEgwcvZNgnH8SDSQX5k9BiLy1m/d88A8nfggS0aFZUXw+/lJHjof3//?=
 =?us-ascii?Q?ku67zWYTP3Mc49gvef3KCdcMOhI74xJftEo7jJqkLEP/xNqiKjqYeWQ2hjEc?=
 =?us-ascii?Q?AlDtyUQ8aTCnLLBY1wk6aqZdovUflr6YAbnuqzTXy8RAmWeZRs526/J5Fzsv?=
 =?us-ascii?Q?BC2dsLVyghu79L2PoZbaTW5KV76hr479WweOFZWrC7LyMhwA1ef+ReI0RvoX?=
 =?us-ascii?Q?NR0UmBB5UnkIcrvbPC509PWwX1WCDX6tMuax0fHN+5EE46I7z7r8CH/57rQP?=
 =?us-ascii?Q?sJJuERq6bSteC6i01EsuHxQhqzkbT0gnk6IrUYRAqw6RrsDFjQ7yFn7wSRBf?=
 =?us-ascii?Q?fQwu2dGaWEHFEsERAIbNhQcF8GBXIIyZm/1ZtuS7nDXXTdEvpX2hTOqBVk2S?=
 =?us-ascii?Q?W5+Al6ron4WOh3lcSiCfzL1PJlVkxPUA1V+d8oH2kTcupcJHXnvGHwQxNnyl?=
 =?us-ascii?Q?BwtYBLRzW65chGEWwMxFx25m7/L+lK6OtRkfqK13hydVunq6p9Qm3jW0g4oe?=
 =?us-ascii?Q?9JJK/Cf5xPvvlm8JL+XOGrn9nZqLJ408JXvkGV4cBDu3hz/DrDvplMPr29pt?=
 =?us-ascii?Q?kuN3u9qvG4foI9d+qr2XJBjrkJ0jkQNAVK0Gt73ygjkSmYDRb12qDP9X1sFP?=
 =?us-ascii?Q?yY8c5rUn/9MX+In+9lXRsOhQJwyVyHKhIv1SWKQbiXyODM0DaZv7qopDAKtU?=
 =?us-ascii?Q?Qmm2F/IvzCwU7fX5lp/lg4PGIe3G34lgPP1SvMOE+C6kFwTSRRq9NPjFxMTq?=
 =?us-ascii?Q?U7sljj0usmu1I86ucShjWUI7Kmf+DT7s7Mlc2qFwGda42O0t0xZvUDiauHYh?=
 =?us-ascii?Q?aerxUveA4+GRnD+Qu1zkyHu3U9LnoRgAYgdISUQxJIBelnf4kSwFJpHri5hK?=
 =?us-ascii?Q?abcHUTs69pk7yqy34DO0LCg/gvSlfFp4b5l43BG5qoXQpLTXgNG5ciYzeNZ5?=
 =?us-ascii?Q?eF/W3z0/PV4GdO1a+UTDswg6XX+RY+WPFuqxASAcXj7fi3AvR3+GlZ/RGnK/?=
 =?us-ascii?Q?zVfKuRUzL0/YL+HW2M77R5p4ky4qiU8YRzfW5SssVkSw1kIy337trLzr3tFf?=
 =?us-ascii?Q?ylzpBMOsH+dHnwBhBtKy5jTqpdIQy5PodZtF8g9hn3vcNDpYaeXY5dS9bl71?=
 =?us-ascii?Q?DMH1ljvGgZvkj7PbI32D/0Q0JdPUnFzCkvkzUhEZofUzk98IsfCzA7jIXOyF?=
 =?us-ascii?Q?e47co7hezAENaT6kIjMaAC0ecZ8emj4H22kIWoZE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b36251-45b7-41d1-8f39-08dcb521ea87
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 07:40:45.2768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymGlLIOUUgocujksfE72rB1HrhdFiy06EakIIPPy+tIWhXboBQiucHNioqMhj2LbBUBBkx194PCFvKZeVhDrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5966
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, August 2, 2024 1:35 PM
>=20
>  static int
> -iommufd_group_do_replace_paging(struct iommufd_group *igroup,
> -				struct iommufd_hwpt_paging *hwpt_paging)
> +iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
> +				       struct iommufd_hw_pagetable *hwpt)
>  {
> +	struct iommufd_hwpt_paging *hwpt_paging =3D
> to_hwpt_paging(hwpt);
>  	struct iommufd_hw_pagetable *old_hwpt =3D igroup->hwpt;
>  	struct iommufd_device *cur;
>  	int rc;
>=20
>  	lockdep_assert_held(&igroup->lock);
>=20
> -	if (!hwpt_is_paging(old_hwpt) ||
> -	    hwpt_paging->ioas !=3D to_hwpt_paging(old_hwpt)->ioas) {
> +	if (!hwpt_paging)
> +		return 0;
> +
> +	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {

hmm this change is broken. In this helper:

	if (!old_hwpt_paging || !new_hwpt_paging)
		return false;
	return old_hwpt_paging->ioas !=3D new_hwpt_paging->ioas;

Obviously the original code wants to enforce reserved regions if
new_hwpt is paging && old_hwpt is not paging, but this change
skips this scenario.

>=20
>  	rc =3D iommufd_hwpt_replace_device(idev, hwpt, old_hwpt);
>  	if (rc)
>  		goto err_unresv;
>=20
> -	if (hwpt_is_paging(old_hwpt) &&
> -	    (!hwpt_is_paging(hwpt) ||
> -	     to_hwpt_paging(hwpt)->ioas !=3D to_hwpt_paging(old_hwpt)->ioas))
> -		iommufd_group_remove_reserved_iova(igroup,
> -						   to_hwpt_paging(old_hwpt));
> +	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt))
> +		iommufd_group_remove_reserved_iova(igroup, old_hwpt);

this is also broken.

Probably it's clearer to continue open-coding those conditions in=20
iommufd_group_do_replace_reserved_iova() and=20
iommufd_group_remove_reserved_iova().
