Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D401261364
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477361; cv=fail; b=lx+yHGeJ8//HBAoAGXi63S539CgStXtzDZne/TM+4SI8ih2QqkmUdWBdsWCyMV8irebB7/jl5in9A9CvqJlo4YFqNheCCSy87c4RT4gCHu5ymMT6CjElmg6Vd4Xox6xX3SHwaBPIfbXqadCkHIUHQ5mPCrwiq48Ldxs78/0PFYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477361; c=relaxed/simple;
	bh=2/fr4SEHnx5MRJRfzdQt2hRpBHSgm51/0J04J05pfOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=onXY7JUNw2PUvG/eYR4EdZ1t81y6rPkhlc5GoeI4jH8FIiW7nOowgFlyRqzj960sYqAYOwFEB2AnPAk3hpegkrq2qVIZUTc+B8MywbbeeAg+V2DjbEgyoxOJ7Lcg6YYMj07G/QporLbFr5yEsaEK9iALDfSO7MPUWwWGugqWkU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZAlogO6; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZAlogO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740477360; x=1772013360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2/fr4SEHnx5MRJRfzdQt2hRpBHSgm51/0J04J05pfOw=;
  b=NZAlogO6SRNr1+O4dhZLr6WHi6DvAOnqLjh5sn6O+inZ+ALA/MMCNfEf
   b4J9qeYByvbI9nOdL2H4k3ZHXgWg2T4j061+vS81MyGz6QPKJ1NRt0B4p
   cj6DjZm1xmjl917XIh39qJcKwSMDDaNJalAWEukvxTZSQa5ZTuuv5tZud
   /YZuxISDq57pTrRKiWHDP1SSP8k6PQal0+vRwJ4IJNygVCcZ3KjWayC9f
   WlpfE9OYfVc0gxEC5iZeLjC8WiZnNbNj4Nhx5FtpMLrdYqOCIehGCsEMT
   Yh/dJdDGdfT7F4/1z3MNJFBhHbQOXLWNCBmaCebZicg9E5bJ1XSOXEh6q
   A==;
X-CSE-ConnectionGUID: lXsqIpK1QJiO1WP00O0cCQ==
X-CSE-MsgGUID: UW8/3ZacRDufG0H+L3XdLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45184132"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="45184132"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:55:59 -0800
X-CSE-ConnectionGUID: LshiS1m+Td+XYMXdRUPH0A==
X-CSE-MsgGUID: pFip4k7kQ+6tNHTnYCPgRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121588226"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 01:55:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 01:55:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 01:55:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 01:55:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LH9Zxux61jLGZb9uY98mo9yCmCbNThh5F2C2R1SMeDGPRk8tdRBuv1syMwKfQvEDxTeIU73kqP8fposCe/gIRFNiDyu1NBjK4WuyaiyRn68x37/qrUSLy9gJKsxAwHyktr38uMad8Qy7zJAbvkg41bmiEPlJobjsuYX7fVWrllzM7HFM9qfGYiZRhiT8Qa8OWa6PzS0J7SA6j3RP5FH1NoLB5iaPAqGjEPunNJ1YOlvXzwjQPPmkM8E6IgD649f4A/7G4Uw1iAR0NqbRo3Jwh1GuPl4V14Qng+0fn7ycaGRRGQl4aLgEURWnWI8OUITjBgUZBV0N7gf4jLxkwtmunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3xq4zNu25w8nMiXBEW6uR+6ZV712DmMjOfxr7I9xWs=;
 b=pZXrenTbzNzQNgt2RcwWQvZbFZgMZbI4zSSiskVRGrXSTiw+3aX5oAZpFmQ4DCT4dq/xJuz7x0joIGDbFv4YMMOh1PzB25NcjRfIM59U/Y1XFAb/yoLqgK72pj0jmAOSCx5oVibnYE/xce7V130kf8FyGc9VxSLb6s+QtlAg/eZjcu/QM+0PVpgXnhQF51YLNJe/mmm2syB04i5c/Q230Y0HyM92DtxFjlE1gOC+ujOtcHMP+eaLUT2UhRhu5aYJU/XZm91Hdgcwmxe65SqOwlS1XvECtwvUS9xrb2gEvJwAiUmz5rWXyqzhJQY7m3Zoyehn76hd2kgpi3itbQtkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7723.namprd11.prod.outlook.com (2603:10b6:610:127::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 09:55:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 09:55:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v7 02/13] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH v7 02/13] iommu: Introduce a replace API for device pasid
Thread-Index: AQHbgCY6Rs8F6tfSk0Kv6LEcNhG+3bNX1HhQ
Date: Tue, 25 Feb 2025 09:55:40 +0000
Message-ID: <BN9PR11MB527698FB8038D4A41A4191E88CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250216035228.23831-1-yi.l.liu@intel.com>
 <20250216035228.23831-3-yi.l.liu@intel.com>
In-Reply-To: <20250216035228.23831-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7723:EE_
x-ms-office365-filtering-correlation-id: ca19a81d-3dfa-4827-032f-08dd55828ff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PBx1PjYBsyrJRjxuvo2OK9meluwguyVXIIPfwB6hyGfwqr/h43wGyRMrpSku?=
 =?us-ascii?Q?gpaY58/filoFcC6iiiKjWmRp4bmY99uv9ABDqeecmu7oeCBNj1Ia5ZZiaX5q?=
 =?us-ascii?Q?UQFHZxYO60i6Xavne3ZhObP6S2zjsA8GWXYUkJdtvrDoXxS07EKdjELxkIxP?=
 =?us-ascii?Q?SZu9wDhjdzNV2bQpYBvB7Me1JqYggwM7hQwfIKuHMIKmLmOg0tSQM4kQ1WUy?=
 =?us-ascii?Q?qOGAANcYAexvgkraTKNCYSkwzhpLRYjosM9NfMp8sAe05Q+YKkOcohAsX4Fg?=
 =?us-ascii?Q?T/JxRa2k6vvFCNmyC6QFcre+1ztNXK/6Jj/W0pt/6mHQp3bn4a74kHlFbw0E?=
 =?us-ascii?Q?5bZGBlaZYCa70Jo3QXVme/p+5g6bqKe0hI/e1EVdp0zDh5LVL7RDvgupwe1Z?=
 =?us-ascii?Q?uQ119Yo1jCNzivOj/7QBVHWX3AN0R5GIQIB7fwchfli31z/cwGR6szqfGA/l?=
 =?us-ascii?Q?09Da/3YIpqTTChTbpnkqmbsAhW1yeNkRvYrcD2ao7uTNDWuS9C1o6GZaIyNO?=
 =?us-ascii?Q?jdWFwFUcloEdKUetRqrJ88taaGKBF3Cc11qj3xJs5Pbfzo5TntjZl6wfmSGY?=
 =?us-ascii?Q?/91PhO0Sb7mxGrPJ5r8nUwdi/9P2rQjY65WlFsrgNRKiMHyDDOhiZd/esfXW?=
 =?us-ascii?Q?5xH0zU9wlKMgfkxBkVdSuoyO3fpD3HBKGuUT7efP3+L9wnmniGXu0Hbn1dJy?=
 =?us-ascii?Q?85Y7oMloBeyzEe80okzmiK0sX/raV+BD4x5W8lOIvQimpbcz/9IncK7hEtYw?=
 =?us-ascii?Q?yEpfBzlEGikWnyznapaJS5X2z+fuJGBgOYQHtzTkcUQfXmpl1CHqhz6BBf9m?=
 =?us-ascii?Q?uQKQmxm/aZ//BytkhJ56GbbQi2ltPxKTnArDktlkLrqx0jkAlodpW1eqbUC7?=
 =?us-ascii?Q?nSyCmd8U6y9YLI+v48bfuij0v/t10eXbxAGZ/Nt+EPW9uZjxO+VhUVcBdo5O?=
 =?us-ascii?Q?rUdbAlq0z/42nn/pjHRxb6U4IKBSUgD6aQzMG62iq+K3rVafHrPMM5tep5YK?=
 =?us-ascii?Q?ix5H2FKRfidnZIaRBhqbaRaVPxIOYcMw+zLpWMY8cQXnrUx/kgj2Db/AY7H7?=
 =?us-ascii?Q?N64X/hlMwhNr+a7CpKREDg5sxngG7l92KDcIbufD/9S0yFcaSo9+CR2i+894?=
 =?us-ascii?Q?G6Fnc8Ebo4qrGWl/cam7PfRw9Zs0cU1bi7gzvn3dmYIQciiE1Zawziztd3O4?=
 =?us-ascii?Q?Mze+m7pKyGNoCukWvPHAhXJ7ukRxJNjmRzCaNU5PAmAKFLAMFs6/6y8BIvaI?=
 =?us-ascii?Q?MviiX9Qq0NE83zKYWw4SW8kFonV0C2twt2am6rMpPTlwHv29TMeVkQ5fPDZo?=
 =?us-ascii?Q?EbGZPGQru6U6bKLT6xxA75tE5ctNm8tM8M/TNDd6Gc38nyA0U7yqNOyWkoJM?=
 =?us-ascii?Q?GpyHaSQMrJywoYGyN1XzyAHHJPriSpX3EVK7AFJoKjqsnMrfH0iqWgltlyBE?=
 =?us-ascii?Q?miLuWzd7l+B3R2wV72E8HY8UFOd4K4MR?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U+y9SnxTLaokzHOJqyxk15Q+d8pMP+Ysp/VY0hoKAuyMEPy8S7Y5fyyHax2n?=
 =?us-ascii?Q?loqsZqCQIJWW/bM0R3Au68n3GkBoQoeles99BUu0DEOW/yF1J7MAvWw4r2z8?=
 =?us-ascii?Q?cfIrbvCfDtQSbFNYkl07xyUUjffRHzRkjU1MpRcCqhIZieO8YOiD3xTEkyKW?=
 =?us-ascii?Q?1UgmE3YS3gFB64FKGVWKTwKs8z6Xao+7Olc2Cu7tuKSKLph56ZLnhfSbJc2T?=
 =?us-ascii?Q?fNqeh/zVqd7RkzQkGZtXe91EsyvAuDnaAbXBmQp9oiwxQL9K7LFSAW5nx5Nk?=
 =?us-ascii?Q?4aiLIdAZWXeQ5AyR6rU2Cs35DitMbA0P9m6Q4wpDP8ctV3jyB2wJ8GA3K1aj?=
 =?us-ascii?Q?5VSpP/PluQawgxN17QGS/3W5mpdQeGbB1jaEJss2gZLcx3Mra1aWSgK96l27?=
 =?us-ascii?Q?z4VoQv50q5VW5YZNjUWIih/I2+8t6BJkOY3L1bqPRxaagZ2TluZP30YZzvNH?=
 =?us-ascii?Q?hCxJi2+uaLk8TdW3tEXhI6pn8YWTJ9yWwguGmrbHD3+VVjdym/nzOBRDI1Ob?=
 =?us-ascii?Q?XMiIHqmUEeD/nIHeVs39KU8GMS032hr7cFPU5GSpzrZhVEL+KWdODmotkiTA?=
 =?us-ascii?Q?tkbbC225qz9Q+/f0PEyB5qSEizUSzu5jteBBpVJ51LevzCOSohQtUgY5BCPC?=
 =?us-ascii?Q?V+/giNN1fyNg5y5yZXHd85L8nYpeJAQnj0xtQiJp016P3FIOdMpZIvm7LAzP?=
 =?us-ascii?Q?Ap1y1C8STAt0w+2wxg4sRCzDdJU3xicnEUZ2c1vCFbyW5XxXUNUTUjvSJkWQ?=
 =?us-ascii?Q?b4INHSVb38/tGkBRSttJN2O3KnYGgrGd5GEwfEvMjBdlXpbBlQsXUkdXip6j?=
 =?us-ascii?Q?a8o5QAKTIXSEzrTCwQ0CrbmLGt7dtluv6MMm5ydDIKM7DIX2ZdOIdsoPluSq?=
 =?us-ascii?Q?wWUdVCYG0iw9s4mzUB9N1fF+ANNnqOuM68922cUowF+vLG817sTl6IPDbbnU?=
 =?us-ascii?Q?ZmNqd0nBhIp5IJO4JXa2pWXhexuflKyvSoWj6ni2OXHeZvfMf8GPd7INsCQw?=
 =?us-ascii?Q?ZhqTXBvkTFMtuaAlUGewM1luDP2AipbW3atzULGuDbB39AAHry6hUv/ILqmW?=
 =?us-ascii?Q?x7ta/JyPvAMrgG234G/l87tyoT9TH/3/+8bijZ6Z2jFuv9CKuIEF2c/AV833?=
 =?us-ascii?Q?/YB8l0o9Z6AzkgjI3WpS6/NhJ8x/jlivqpOpE1DvkfsQySc4tYKfL6bgPzE6?=
 =?us-ascii?Q?BEj1dzDze8J8Jl5CQr6mYqjhbRl+06NWpwItwCu/eEYCdpA8ECJeNWT4baSf?=
 =?us-ascii?Q?zfcd0YTdC95fWaECYVL6fX+RaTlwxmv3f+wjShy1ETh63hi5htfL9w6Bd6CZ?=
 =?us-ascii?Q?Q65duxk7t9L6bnmDa+MuzbJWf0MSTSmbL5VeZzoXvK2QHOSFXA7Rxqg8a8an?=
 =?us-ascii?Q?Eop1apraF4wazxuNBLwPjySWe7DkzAJI5txNQMFHytR2R0awZzK+1vHg8p7D?=
 =?us-ascii?Q?n5xjBBxhXyFYYfcWU7X01G1pF/I7fUztwNU6ApIXJnNPax7Fj54PW1celcia?=
 =?us-ascii?Q?Bd856Rygkg3Ql++Kcr23FCdEyQVjoV8vy0CHs2Bg+ql6csBUyLim68LLpy0J?=
 =?us-ascii?Q?u5LGag561BqKMdYgtmJxzv1mxjUXTY1TLq66Fegn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca19a81d-3dfa-4827-032f-08dd55828ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 09:55:40.5770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cuDf38YJKLwTZvhcMTuYt/qGefb6xwAVsxoYzZqf7OL171yYz23KrIEQO6q4LL0A9H6G7OYR9eZdxhcjQr8oxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7723
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Sunday, February 16, 2025 11:52 AM
>=20
> -struct iommu_domain *iommu_group_domain(struct iommu_group *group)
> +static struct iommu_domain *pasid_entry_to_domain(void *pasid_entry)
>  {
>  	struct iommu_domain *domain;
> -	void *pasid_entry;
> -
> -	lockdep_assert_held(&group->mutex);
>=20
> -	pasid_entry =3D xa_load(&group->pasid_array, IOMMU_NO_PASID);
>  	if (xa_pointer_tag(pasid_entry) =3D=3D IOMMU_PASID_ARRAY_HANDLE) {
>  		struct iommu_attach_handle *handle;
>=20

What about calling it iommu_group_pasid_domain(group, pasid)
which accepts a pasid as parameter so the caller doesn't need to
do its own xa_load?

> @@ -3388,7 +3392,20 @@ static int __iommu_set_group_pasid(struct
> iommu_domain *domain,
>  	for_each_group_device(group, device) {
>  		if (device =3D=3D last_gdev)
>  			break;
> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
> +		/* If no old domain, undo the succeeded devices/pasid */
> +		if (!old) {
> +			iommu_remove_dev_pasid(device->dev, pasid,
> domain);
> +			continue;
> +		}
> +
> +		/*
> +		 * Rollback the succeeded devices/pasid to the old domain.
> +		 * And it is a driver bug to fail attaching with a previously
> +		 * good domain.
> +		 */
> +		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
> +						    pasid, domain)))
> +			iommu_remove_dev_pasid(device->dev, pasid,
> domain);

Above can be simplified as:

	if (!old || WARN_ON(old...))
		iommu_remove_dev_pasid();

> +/**
> + * iommu_replace_device_pasid_handle - Replace the domain that a pasid
> + *                                     is attached to
> + * @domain: the new iommu domain
> + * @dev: the attached device.
> + * @pasid: the pasid of the device.
> + * @handle: the attach handle.
> + *
> + * This API allows the pasid to switch domains. The @pasid should have
> been
> + * attached via iommu_replace_device_pasid_handle(), otherwise, this

why do we care how the pasid has been attached? and in reality people
does attach, replace, replace, etc, i.e. you cannot expect the 1st operatio=
n
as a replace.

