Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793258327;
	b=p5+ybnOisddnw2Ijy8kIAKEBRKhng0+OdIRH00/T0JWdsUjpMPBbEZFrX0Djg3NiR/PS
	 joex9UBm02o0CyPgCEDzWUtdH+vn1XYDsqPv8XfaMhDZ12cOzeW+u1KiiGON/iImst1Qw
	 iWmDWjyRRrE3SSzL4XF09SAdzoJF054BCjPHm1QQbYEsi8cmzX+nDtuEjd1tgFNO1La8I
	 sA/UIEZx2hqoX9Od5egCtSNw3js8ITFZHw8g+nGCJhfGlXJjHWQqdaGL7wiZHttuROdZN
	 nHdxwIBHkHq0AbJv42zBagrJq1Iat084dN9Z1Fj9MfjBR4PkPni2TxrGGIzHQ5KtE4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258327;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=C34Kp2u5piqyuwxlMEDRHe9pHmEIIHjPT6KZj4nQdJA=;
	b=SQ9cCNgdbXMQtAyakeIkRlJ5gnFy/CyOmmISiNLMmoGpVPSrH7LnC+j+JBAxSM/y0Rw6
	 uZTwvENe9/pkEaYuhAUadhgT6an30W5GSeFVDjY8A5cK43mFHrpnmQV+dNhAxO5dhcccj
	 U4D503HNMlSX9PB/FTb86LEAmRzwZR0htngDwelRZrWxP5xEE2pBGoD7AdR7cgeDcGBGi
	 SWNRPRbUkMStPrKEK+5HNhbJj2FEDUhjwfQBd8aTPHDexxOTi7ceS2Nm1vMxyd+n8v7mH
	 Imek7loAX8L+6mCkjL6Lfrg01lYP0ZV9jz90wF/lOoNqVC+dpZKaTv2U++zoqnCYAIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qy6K+XCv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACC2606A31C
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 07:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AACC2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qy6K+XCv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793258325; x=1824794325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C34Kp2u5piqyuwxlMEDRHe9pHmEIIHjPT6KZj4nQdJA=;
  b=Qy6K+XCvgkc+pK321X1gWcXvgTwS7f/GRJhlaik1vRQ+6VUQj92TCgCq
   +O/xcpWba3M5KdqdXv3biHf9b1+mdqa/vnsnmct52emCblfyX7oDEmsGC
   9lMptBHVwFtwJDNO51JP9U67fuc+u+bquhDD3nUxyEK5fzsb1hOjxISGy
   qvYjsGXO2HHE4ORZi60EyFRqEEzlORGScEDDXwJUMonddI8039mHHdwqz
   X8VJMO1TYyTC+i8sY6YIGCxSUvq/X+9d8KsvOEVbNsZ29RvkXlWVonEHX
   OptWkap/XhWiGogTDvZnam0EZk1SWn0g0ub34bQe5bpQiyGl7HtiX5K5N
   w==;
X-CSE-ConnectionGUID: S7BftuuQTfSUHzAN1zKaWg==
X-CSE-MsgGUID: FxpnRRF0TSC7WMR5wlheMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2021218"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2021218"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 00:18:43 -0700
X-CSE-ConnectionGUID: 3mNQ2j/TQT+ZQj7nTI0/tg==
X-CSE-MsgGUID: 6knccoMrSveQfrqMw5CXNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5451962"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 00:18:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 00:18:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 00:18:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 00:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUvYoEL3HzjXA46A8PYKwJ44LK7/1gx4Y0v/oUm/JpbhhlYAwFkTXk2fUdCpTeZKy8XAL1lWrj46DIA7jp0GdVCyFaAl6uGpMjiJPJU7WBrutrpXDVzO206YI0VRO8bqP09WrXolLvLdFX8UrzlNDCH2gWinzaTA8cdbTVOPnPEjFJMwLVop9UbCjfT8OeW8D6n9LTZWPQ7yNyztJiARlozNLuPlmWNYgYV4O7Ar++/Iv8f10fXbOHIrNcEiRVJnxTAlqJJGlkZx2pLO0D7BSR96KEuUunIqKvFnrqlhCv0nulsCzBEpQ5zafUaUSf2nGu3evAO1+OBVXJZvIjxwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C34Kp2u5piqyuwxlMEDRHe9pHmEIIHjPT6KZj4nQdJA=;
 b=Vg5xfuofZL0TQcGBss3U0aN8zeOAQzz0eWT501tuR1RCT7jMqY9ATAInm3MHXXLI1KbVxkmjwDCjjZ7aXdXyYU6B7QSfL71NtolnhDwjZFF9sUBDgdpos8eEkwIN5IJ3Wp4mbGVZayEGkQEhePqY4jk7gVuLwJnTqw8WkRl484JhPYSHcyroBVTJ7mf8oENQ7KJMJXQ/DGwVo1EVEQJJBq+rNiL/eaGZbTzl1iDQUfrbPLqdZ9aXXV7TMuUyZwelVw5EkG8fYL0tVZm+60x2vNzEzoxrqn2g30PNK7hiiay4eWxPtpH80MWon52bjlIBXpkyFl7iuG8PHa0sFgayHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by CO1PR11MB5203.namprd11.prod.outlook.com (2603:10b6:303:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 07:18:34 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 07:18:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/4] iommu: Unpublish the attach handle before the
 group detach callback
Thread-Topic: [PATCH v1 1/4] iommu: Unpublish the attach handle before the
 group detach callback
Thread-Index: AQHdUFzgAWlNmRkmSEyc0A/qizEGdLcUSn2w
Date: Thu, 29 Oct 2026 07:18:31 +0000
Message-ID: <CO1PR11MB483537421C45068D163811AD8C6E2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <03392b21011e9285b342488f0df233b92acc3405.1790718296.git.nicolinc@nvidia.com>
In-Reply-To: <03392b21011e9285b342488f0df233b92acc3405.1790718296.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|CO1PR11MB5203:EE_
x-ms-office365-filtering-correlation-id: fb8f426e-c5f9-441b-b977-08df358cd60f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|261028144727099003|56012099006|4143699003|11063799006|261022105027099003|261026121527099003|261021135927099003|261021123027099003|261026140227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: s4JEYvwlulNrtxq7uaKcJSb0R/rFqT5yB1v9tpF8fzwyvKk2N1npUCR250RKjePKAbgzIJSRHOXU64obr/cZ5W6WaNLQ3AZBZoSEV1CwVby65AHZVwI/aopOgYRXlfw7vf0zjDkG08TDeCcaXK1LzxpD2q5PFjFB4PO/B70errZGwLdaZkE0fOJDrWBoJFwQ1LZJxMqgQ2ZRTkert5E91fn+FdWtFlGb6AYp2Hq8NN29Ugdr+P2kr/kk9Q8Ygsd38p/smKYMfZomeduTpY/o3QxYX7HVhFwQuQW+zRP2QBDakIHdjjnnJvfdHXN/uZnsKh+0jA1f/FkOST5TwLG8hwYZepvNOf2LHTG5jzyIzzWCgVr3FK9RGEvKWZHMzpTtxpk9BSBm+4XX4c+1nX6pma9DfUhauM+V6Ys5XFS0AgFHPT/CCkxS+8CiJ22mo0WXTDQ5XEIAD37G1bVuOwAb9KufLNcV7KhLfMh/7kF/L+jzk6WtYDv413AX2LxMtd9dsE3yLW+ExNXC3/a7s8Vt8gK94F+dLpMPFYqzkKGPJWXjqTSejqA5JJiiukixzZIin3p8Uq1x84b2y8xh9up2w0ukFRR4kikD0CfxKdlIjDl0Rt6ZCfBH88sShYYsd4ERFoe008967vKj8rzYBBpjThJxb0H+L6WFms6h0VPAP6/vnqX85P5HGQ3RAsSiWZIr6jR/NyTVQFckrhiZAbbh8k+XKpJLhvhQPrHIdfZkkfI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(261028144727099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261026121527099003)(261021135927099003)(261021123027099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RhkVi0V31zquEOltYCx7BtPc5sXHuA9SSdKCHQ1q/Dbk1RqssmxtE8Xv7Kgj?=
 =?us-ascii?Q?J7Q3bECsJzPigmBSGTjQeb/4y5dj7prp/KizO0VeYCJNGWLTmhpwm71THzwd?=
 =?us-ascii?Q?uvyfy88GkpxR7260s2xxr+OeHWdSmgHOlkrazsGSg4jxL1JCKqfdxZbBEe5c?=
 =?us-ascii?Q?r5eTMZohnLRr0rtYPMylH/Fy/t6h5dBcelR7p+yiOyETnv99i7PEnxWdC77o?=
 =?us-ascii?Q?ghLp/lqcX0nLGfQsWSyffE7q+RYfXTx/21je02WGTzTepNbDVemtCWFRQIUA?=
 =?us-ascii?Q?s8Cpfa7Ozz5yMR1Ns9kKS7nXynN0nQesFj0qj0b+gdDDQas5EYFUOYhbVDJl?=
 =?us-ascii?Q?BMIzOEvlJKieHG1IJ7cgCbtyaB2ovUo5mwD7NJO3rz00ycWZS7P6yLpwPuGj?=
 =?us-ascii?Q?84kHuHdaQSnsfsAz8PHc6P2gKiG7PRqCFRW+d2YARts3/lDqvqyJpYmR25vX?=
 =?us-ascii?Q?vZCY+NszyJMZtP968tOGNd/16zAitNGEVGgNYM8xwyAwYz31Pa8HxzSln6su?=
 =?us-ascii?Q?hHtCv1xaFZf2wJ/2wB6sbKk5UUIqTr9098gI58gjnFCyY77sV5XGiGrfl+mM?=
 =?us-ascii?Q?dGZ/Ens6cmN73lKqitdGClV0OkNLXsUtxkN5p23/g/XDgZLxxvYKUL2WOOyZ?=
 =?us-ascii?Q?12sI3VdI7AIx8tcYv8h0MBACsJ4Hvx3KeqO4hgGH23y4hqCrw28soRRxTBc0?=
 =?us-ascii?Q?KoLmPbuIXqniZX8ta2kUKYfBzsrsLZTJzYeLMrmO9UwIvbbwLWeuSZs5CwEL?=
 =?us-ascii?Q?HYUNgJZMiJhZpHnmFMXD21gD00sbN3W7et34PL5WzlRTMg13fwHxFs0SBHKU?=
 =?us-ascii?Q?2OXPDX7LsCnEJEQoUbl3JOviT9LjmqDQ5Gi0zX7hnl9qGIg2e6h/xVjMftXg?=
 =?us-ascii?Q?UtLBeKaGw2M8yXVjG0sSfr1+4R+smpKwka6wWrKQplhA9hdOechtFgBwjBaS?=
 =?us-ascii?Q?3Q+bYhEOLqGg3fcI94ASYjNRX7AaLzfJGHsotjm0n2y1BitYpdVsD0DGUdrb?=
 =?us-ascii?Q?6RKXp+4kxdZZeol4Nm2KscROrBf+NxYVsDefHTAZCxcLOXLHCGX7mTiRpHES?=
 =?us-ascii?Q?TE0v6D5+3q33I+EaH6trhm2+njhG+6AH8Zn5FORLDpw+sN0cjYZBuCzuGB6o?=
 =?us-ascii?Q?1bJjpR/9miFq7KrHauAvybRiiFpoa8uakrSg1Zz0IGRyjmAQPixwFDr+nrbi?=
 =?us-ascii?Q?z52+WaEUG8hBnnwlA/EJh4Rlh6LlvAggFy7IGyVsiwTtaKO1pL+uRN3QlKm9?=
 =?us-ascii?Q?YMFsr/lGvtuOD7WwvsPOvLNbRL6oo/l483Mv65O5hgX837Uv26nBkHmrvLZf?=
 =?us-ascii?Q?u7oMGuj1NfIMgGiWp1r7723Ab4HPJV/Ijpeq7ERW03ZZK/yGmvF/B7TlHE+A?=
 =?us-ascii?Q?5QDBVrsdEkDN9Ux+P+sirqv6pBR/hZYmgiHdsUc5H71zkVNcecKp8fUa9F4G?=
 =?us-ascii?Q?G+2Uil5kNfx8elFiPIhjChaMxjZr7JHceOEd+5I++x86/+7KLuVujGIl51IN?=
 =?us-ascii?Q?3Bb+C+iHRZBeB55pgZ598J4T5zj45uwPAtebtT1le7EVU9eFMWvEjCXncUCR?=
 =?us-ascii?Q?Iya7TXQhAMGiMdfHsvYrk3/lzI9HRw1HRJCrgpSW18ZNupefWHebH/yJCzNd?=
 =?us-ascii?Q?0XysmwP1+HxQxJExKyF/FtqYWUqriKKfNlfZ9lYin2Bh1IDMKHEQv7QK093u?=
 =?us-ascii?Q?u189V3thY6ovKWS0YtxO2gIu0tuNhgQQzLPYdvrhYlwTPPTN6AjDmqWdnpU4?=
 =?us-ascii?Q?Y53ZhqNk8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gLU7NBTTJas23jb7d0ipaX2ZelYGFHMwywIQ/5Tpso4RpIKBk5lafnpMmmJAW7hYrPnvl2ZlhhYBCbPbtRae3S88zm6oJHiMmmKpz3nUJFlsK1AHGoJWRHj5eTosG+QEp4ajiDFNw2QqI/dKEpllvaF/eXwMRvY/HbnaXk4dIvWgxm9vlv20O6QPirV5pp56yqhAwcIeNZFsRSsoMBzuPRi8wh4/FpnMEzXEKV+z4txTbgxMFkpqMq5JDg1B0IuT3GY3O5oYNdjUL3o491L9B37SIQgs/SVaVhI9F1m1whSbrNLl1eE2aSN1UhGfIzPHDXxr+N0xGTxA6cABkVSZsw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8f426e-c5f9-441b-b977-08df358cd60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 07:18:31.2456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xsAATgQfcImcnNf8dqZ+XNCc66vxGEIxMChpn0r5XxakGujsuA9tAhYddxCRDbFIp734URtAb8umISe8Umzcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5203
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 30, 2026 5:52 AM
>=20
> The group->pasid_array entry is erased only after the detach callback has
> returned, so the outgoing attach handle stays published for the whole of
> that call. iommu_attach_handle_get() reads it under the xa_lock alone, no=
t
> under the group mutex, so a fault raised in the meantime still finds that
> handle and the domain being detached, both of which the caller frees the
> moment that detach returns.
>=20
> Commit 5e9f822c9c68 ("iommu: Swap the order of setting group->pasid_array
> and calling attach op of iommu drivers") has fixed the attach path, while
> the detach path never got the symmetric change.
>=20
> Erase the entry ahead of the callback instead. A missing entry reads back
> as NULL from xa_load(), so that iommu_attach_handle_get() returns -ENOENT
> and the fault gets rejected rather than delivered against a domain that i=
s
> on its way out.
>=20
> Fixes: 8519e689834a ("iommu: Extend domain attach group with handle
> support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
