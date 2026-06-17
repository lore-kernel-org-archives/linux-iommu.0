Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F683ACF15
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681016; cv=fail; b=OPeUS/4Sg0CaxAY1bpXA5Qa9H9oO19DuD299ocwKDr9nU0HhVNrKgD0kNbKFT2QWpsp+IZ9T0Pq6NVzf294YaOXs6DSXtSvaVtA57YNTE7yFmS2466nJ0WUnKX2l5l/l5d+DQkHYbyM2FxR5iUOdeYS4e5MAXDhhc37rNwMANSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681016; c=relaxed/simple;
	bh=gceaGi1/jhdYb1vH5RVnk2lpvhjaJbbBeDg1VtshvL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T5uam4Awe+jG0uVviZX7dNZMMR/zCOucg5RSnBZIVMQRWAw6oUdxkOaAC0hLduU6ZzraWhd3TwnPJi7laMNZi26PbfFm/0jSkI8jZkd5UcMrQZWiCSp5V1X/kzWIRHRXLCtzFHysYRtbZrbBS9mloXMO34TDIWcuSSBTxHddGvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDAW5pm0; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDAW5pm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781681016; x=1813217016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gceaGi1/jhdYb1vH5RVnk2lpvhjaJbbBeDg1VtshvL0=;
  b=kDAW5pm0onlD+BPaY+n3g00V8WOgHX84DltKX32c0e8o2iA1E0sU7HD3
   7DO880PuzRf+r3wBKTOEAEcBt4N4XmA/mfmtInHe+eiVxx68MEYlTZWb/
   htHH0x9WOxYwrJLSrJiC/aybK7hvqfTN4vGIaVPg3hoPcDLBOBxtyiLc9
   3H8og7reg2kIAe7PkeYyZ6S9ot5S6FfNOZweVTMV3xdxh6OoyZ8/AZ9hD
   5YLwgFVVgipMr2iXyayM34OxqoHryGe7sg5GHQkqbTUWTSu/+dH5PrEY3
   b49wGjA1BzxK8Cpqi38wAN+5a788WPN+D2AdPjdYp6HwoM1VsaHh8Qs5D
   A==;
X-CSE-ConnectionGUID: e2Pu58+FTZqEtMBZL4GRgQ==
X-CSE-MsgGUID: 2Nckpa4jSIiEwCNjhzmjXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93581842"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93581842"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:23:35 -0700
X-CSE-ConnectionGUID: vb/Rtgw6TYWdyhHGYZqSfg==
X-CSE-MsgGUID: mLeoSUveTVC98+Xao9QZPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="271710593"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:23:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:23:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 00:23:34 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.64)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:23:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJx+3kuUnTKpsKXvGzTIg8cV2NNy81ShIw4ccOiZBkkvthwGK26llZ+EBc9DMgfvpaTFTtsUfp2Csydo3urAVEKhvxUuOfeaFfaO7YorLT4ej/V2ILV7ytlGR+IeBwQFuRiK6xa86o+fRzQ8Uiwt1p9KMNQnjNFsTx5L4vqPAXZr5xIG5X5hxdHwH7TmMIpwgJ7tPbN/BAe4A+R0Lu/3HiUa43QoOockrlRciHG0cbxwzim6TEcA0RHzF9BBsh69gZB2+nMCMAYe9xBjzYIcELvVORpp0jQAL+rYJyDTTyJEjkEWxxyKu3xtTsNyT/Y/MSeAGo5DN2hPonNXRgfPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gceaGi1/jhdYb1vH5RVnk2lpvhjaJbbBeDg1VtshvL0=;
 b=wLjO7pUHma+ZFCUKrmMYsyGHlziz6DgbyvDeymlIRc+XVdxsO5SmLzE5MTb2zej5s1buJLgcHLW7RRSxL9RP4sqs4WC6pJwQDNA+LeCR9O2loh2uv7vWBL7ygm8RQOrJy/ipJWsg/aVyms/QBoiXHZ8kwg0AZWgtvRGlUMxIrSZydNaFxmZmQxg9Lz6EpE5b86LUeCR40dhlwlX32WbNnYmzotvSYoMXR6qFX31CXTVtEbL6LKKmXtcnM3M6QJF+T4kNylBSUZTrcJgIoRea0Bi2ttx76DMd8B3kglCV5YRcAYQyv75jeRQ8yVUlpr6sjIWgp6g2I2NwTchwGVP0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 07:23:31 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:23:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Joerg Roedel <jroedel@suse.de>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, "Chris
 Wright" <chrisw@sous-sol.org>, Jesse Barnes <jbarnes@virtuousgeek.org>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 8/9] iommu/vt-d: Remove dmar_disabled
Thread-Topic: [PATCH 8/9] iommu/vt-d: Remove dmar_disabled
Thread-Index: AQHc89/x3BTpsvtW1kS8TQVSXNxglbY7BxeAgAdlWnA=
Date: Wed, 17 Jun 2026 07:23:31 +0000
Message-ID: <DM6PR11MB3690CCD68389CAE3BBCEE3598CE42@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-9-kevin.tian@intel.com>
 <c9c6b903-f62b-448c-82e0-c8b40d13df0a@linux.intel.com>
In-Reply-To: <c9c6b903-f62b-448c-82e0-c8b40d13df0a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|IA3PR11MB8987:EE_
x-ms-office365-filtering-correlation-id: de21306e-d4a9-4751-ce97-08decc4155cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|56012099006|6133799003|11063799006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: rn9ky+6Le+VP9aw5+DjfgyJ9D4oLIjQnrShbduWpg1VpKTm7xcRQdg8oUNOP4aS9WOZxPe/zGlUOFVWLPIpWprRcULaUurbOt+sELPHS5n99YvVVimloMX47XmV0AEx3HPTNiGwLhY8AvXzAKrjifxdhNHVP7jxJ6R11Q00J2xLauxat8EDLdu0UNU/dowLxsJFzX+Ssa9CyzsDKyrH/tmvPQwHN+1Yu17r9cmC21l7HImTSVMZ7Fcamz4t56OQVNrGB894vSuXYw9JjCrAjaQBslD1Spy/GgqR0K//Mm8Oxht50eZqUdPwGn8i0L+SGkyj3Wtb1uE7g8e9P8+ou73AzckC9lvUTpo9XwrolMsVM4PrPeFiW/Ayi3NyOahWF9IUu+Qy9q/cqXjD4f9BGzd82ZlTQcMIf2CW1dL/UHN7ULSdgewpiBc29IScPHAUxBifPLkVQW4BzDZ5Kqwz4t2XokJH2Xqkk2X1w10QTEwkBT2WRuf2UlxnDxzod8h6clPqD5CpuJyFGwlkd3vIiTKwxrHOSPmgW3ii9VqYSV2aGeqh4VKaPu0D+gU12WfzduJM0TUwmUeq7HVYBwoLqQ9JJOEp1NZuXDWk0SLEOjtxNNggTIrF0AiTLspv5POnFX66HGKc2EDoOgQlN8Dra+mS8CDUiru0Bvx5jWRCTqH7DB0aYI3jVbk0ttIDFiNPIF1UUyi7mPKsvqCf576qiG8r74jApskPPzL/9X2jbcdgClMqYTZO/ro23Z4gmu1NP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(56012099006)(6133799003)(11063799006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXhpbk1oWDR0VWdVSGdZMnFZOVgvZDZaaEF1KytPMmpITDFKTDFHcjJ5UnpE?=
 =?utf-8?B?ODVJWVprT1Y3aDZOSVp3VG0zVy9kVHlTUVZ2MlBqb0ZZYkFnMXE4aENTa2Jl?=
 =?utf-8?B?bXpyUWR3VTR4dWlVQ3d0Z1lBUlE5M0Jtb0VNMFlpWXI1TGp5SFNTK2pkVmZU?=
 =?utf-8?B?NmVMeXExMFBOdEs3c1hNTlpMdE5Md21yNXErTWtacVRsTmU3UDdGVlRKaDBS?=
 =?utf-8?B?L3VzdFdHSjNiMDhSaUJWUkkrd2tQN0ZqSWk5WWdxS3JoL09jRGw2YitWYWtw?=
 =?utf-8?B?ejhkdEVzKzBNVzFrZmZFVWVaaEdwZ2lXSEZuLzU1Q2F2YkRPYWhtUlQyN2ll?=
 =?utf-8?B?UmJXajdDcVJQZEYzWmNDaHNCRDExZmlVMlEzVUVrZTVWM2N2UnJ3Qk1Td1g1?=
 =?utf-8?B?SDRqRk1GajlKQ0l3aCswdFVGOUR5QUNqak5wOHJKa054SHF0dDZyQUxKOW82?=
 =?utf-8?B?dXh4R2w0dzlPNnBNajZQNGRvYnJuNDFpMld4ZU1uL1lvaHVSOHVBTGR2NDJY?=
 =?utf-8?B?VVN4T0p0MVY0SUd6TnQxS2xFVDBiVk1uUy9zdkFZSUlVWXhVRzNDKzdXTVFM?=
 =?utf-8?B?c3pvZkJ5TXZORXhlOW9BQ3IyVkZ2STBJTXg5NU1JL2IzN1RueFhpcU0vQ2N0?=
 =?utf-8?B?R1IwSlhrdkZQSHk4VU1uUVVpT1pjaHpnem9ULzRDTkVRcG5PdFNKUnJSTUFL?=
 =?utf-8?B?ZUF3S0tkajU2V3BnR2hIYmZwY0dPSjhjdGt4LzVaTjZ6ZHpPSW5MSTYvdEda?=
 =?utf-8?B?VG5KNWtQTG1ZUWY3ZmNQbzlYYkxzWmIyQlhmMnRkdTB4QktCNWd6VG5CdSs3?=
 =?utf-8?B?VCswSzF4bThZYUE0TERTbnRVTVVrS2t1QjZZUDJNVHhxNXdKWjdOQW1ReVpy?=
 =?utf-8?B?Q09FS0REOEJQVHh6UUc3aS9YRXpsazh4RStNUzcrbjlxSUZHeE9OdlBZZUNV?=
 =?utf-8?B?U2V6YnovWXlJZmtGY3g2cjJnQ2pMYXlJYlpHWXI4c2V6RFBYckQvam1rTmgy?=
 =?utf-8?B?Zm84bTE1cGRuM1ZNMWRGTUkwSmJ2VnhDVkkxdnNmNlJpKzJ5MEZwMkozOHFj?=
 =?utf-8?B?MjJiRzlPaFlELzR2bFpOS3htdGNZZFRVVFkrM05PYU1Fa1JFd3BYK2Q1NEQx?=
 =?utf-8?B?Z2NNMXJqZ05HVGU1bkQrYjJlYThLWGxTMWlWd3JRQUtNWDRPU0g4T1JGSmtZ?=
 =?utf-8?B?dkJyUHNrQnJQbzVnSDN2M0pzdXRLZEU5N002Y1RYNlRjRHJGaUZOVXh0NE1X?=
 =?utf-8?B?US9TbHVHYm5IVkRhK1ZKaUtUSEN4MDZmYnd6VGdsVURwWFFRZi9kUm5JaEt4?=
 =?utf-8?B?anR2aWhMdHkrc0l6Y1dsMFdvL3JkOFhYVnlEU0FHTWhSU1duUXNxVDM2M0Zk?=
 =?utf-8?B?Qmk4SisrQXd3ODE5c0dBdUh4cVpFSEFUdktFclVuSTJHd0lTVXl1VFZBNDQy?=
 =?utf-8?B?R3V2VHJHTzVmRldnVWxneUxUT3d4a1pWSW81WnFtTzhady8vWlhJbjFHTkU1?=
 =?utf-8?B?cE53Skx0TlBWUmhaSnFtc3dnY3N6ZDk5L1dISm90ZENhMVprTnBHdmFuVmdJ?=
 =?utf-8?B?SjRESXl2eWE3WGpxYUZYWXE5d3JqYzBrcnJXb0tMOGwvYTFDTjM1Tzkwenl4?=
 =?utf-8?B?UlR3QmIwck41R0Ntb21aSWZCWnFpYU9xQVJWTnJtSkJqa1U2Mk0xWDQzVWdv?=
 =?utf-8?B?c09nVjhDZ3NjeWh0TVYwZTlpRTd2T0ZnR2xCcG92OFJqenJTdk5KR2QwZWFG?=
 =?utf-8?B?bGgzRnExZ2RnU3ducVZ4elpoSHNJRDl4SDhCY3o1T2dOUHNDV1ZwRWhrUEd0?=
 =?utf-8?B?aTNVcndHeDluOXJ0SVNnWkQ2SFQzNTc5cVNCOVBIcThVYWZaK0ozZHJLdkNF?=
 =?utf-8?B?SE8zSVVaUG4yWTJqdkpnUmZERVdoZ1dMVmhLeDVsd1M0c1F5SkFucUhGelF5?=
 =?utf-8?B?TVF2VGFVRDFCZXZ1TEtzWHN6amp2czdVV1JicCtOd1RFTFROTFV2SVJBYlpr?=
 =?utf-8?B?c2wvU29Gak5CMkttdkd6bHJnU2tKN1YrRG5jaWRPa3J5aUhOZDVpTStTelhn?=
 =?utf-8?B?V1BaZk9uNTRaRTdITDN6eGZrUE0vT1UyR3V0ajlveTNsek0zRDcyVGFSODJh?=
 =?utf-8?B?TGl2NnJ5ZDd4TXVrTDhwTTF0eFgxcnM3eEhjRGMwbWF3QkdNY1BzSHcwSzNY?=
 =?utf-8?B?aHQ5Qy9rOXVaRlFhTWVaczBMemJrcXcyVjR6QjAwK1lSbHFpWVJ6bXFFL0dT?=
 =?utf-8?B?STdXeldWMlRqYktueHRSU1hEOXlIQ0k4Rk54dDgzYjdkRWYrZm9rNll2czda?=
 =?utf-8?B?dFllNkRqSEJ4S005ZHJuMVhFMUkrVHMyWjU1Z2JXRGhjQU8zUXBlZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qmc0J3nDeyzG7zqzKcIKgtZmNSIMadyphU5EqK7MaS9ctcogh3niZaXcqvZOyPam9HFsYfM2XPuBLdxiNNQ31SuAsnEtRypIwGfjKojM8C09GYYSLT9UWxDQNznjpgxRsg/sd6JDH4egjPvwkxaP88w6EXHxq3BqO0PKownxVUSFenUyl0rdd2jxvciZ5kQmTcO456muQRaPp+nwlPEgpWtdXj47yQg2DP29YRC+W4nRHEnTznuG0n7mAYGlyDFajAWZUydrCSgKTIxxG7PdtM5VmUsua+1yOyTG3CisQGCHjARQsBh6Hv6OlVyDOTCXt+i26EoA1v72AEx+vL+4Ag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de21306e-d4a9-4751-ce97-08decc4155cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 07:23:31.7423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCQRQtyYOTwzqeoWKhu9/iBK6IRRRBVJhlWQvXevetYsIUD+++NKa2qeQjlO91DaiRlZ5lxCQ8Mem+SA5PTeyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8987
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bmUgMTIsIDIwMjYgMTA6MjYgUE0NCj4gDQo+IE9uIDYvNC8yMDI2IDE6MTUgUE0sIEtl
dmluIFRpYW4gd3JvdGU6DQo+ID4gSXQncyByZXBsYWNlZCBieSBkbWFyX2lzX2Rpc2FibGVkKCkg
bm93LCBjb3ZlcmluZyBib3RoICJpb21tdT1vZmYiDQo+ID4gYW5kICJpbnRlbF9pb21tdT1vZmYi
LiBBbHNvIHJlbW92ZSB1bm5lY2Vzc2FyeSBjaGVja3Mgb24gbm9faW9tbXUsDQo+ID4gbGVhdmlu
ZyBvbmx5IG9uZSBleGNlcHRpb24gaW4gaW50ZWxfaW9tbXVfaW5pdCgpIHdoaWNoIHNraXBzIGRl
YnVnZnMNCj4gPiBpbml0IGZvciAiaW9tbXU9b2ZmIiBidXQgbm90ICJpbnRlbF9pb21tdT1vZmYi
LiBLZWVwIGl0IHRvIGF2b2lkDQo+ID4gc3VycHJpc2UgZm9yIG5vdy4NCj4gDQo+IEFzIG1lbnRp
b25lZCBpbiB0aGUgcHJldmlvdXMgcGF0Y2gsIGRtYXJfaXNfZGlzYWJsZWQoKSBvbmx5IGJlY29t
ZXMNCj4gbWVhbmluZ2Z1bCBmb3Igd2lkZXIgdXNhZ2UgYWZ0ZXIgdGhlIGZvcmNlX29uIGxvZ2lj
IGhhcyBiZWVuIGV4ZWN1dGVkLA0KPiByaWdodD8gV291bGQgaXQgYmUgYmV0dGVyIHRvIGFkZCBh
IGNoZWNrIHRvIG1ha2UgaXQgc2FmZT8NCj4gDQoNCmFzIHJlcGxpZWQgZWFybGllciBJIHRoaW5r
IHRoaXMgcGFydCBpcyBvYnZpb3VzLiB3cm9uZyByZWZlcmVuY2UgdG8gaXQgYmVmb3JlDQpmb3Jj
ZV9vbiBpcyBjb21wbGV0ZWQgY2FuIGJlIGVhc2lseSBjYXVnaHQuDQo=
