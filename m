Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B60140369
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719560620; cv=fail; b=hAdLxRhEGoU2jeg7DTGBa5I883JARZr4XxsZcQnJmXjhM/XvibGWvweTxVYFwu91dXEOBsLUSbDwcBcKybcpGxHYJOaKnegeFtZkIL7OfSwqP28pgz3WX+gp6NWsu23gHgVJhm89BASCn5c3R3p7fIaOPXR9V53dhNvSZrH1vSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719560620; c=relaxed/simple;
	bh=WXIT2HMnkoYJ+IC2cfUXxL8ZvEWu/eKhWP9RA7ER52o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oxq7j4XplZjQnPsQJc+8tAaIfCFJ/+Aa5Wldk3shJRdBELKAIFZ4JF4PqQUPXmvgBDdXhFOo7rRAaVWAnyZh0wKmB6EF7rxfJaJ+0CRiYtDx523A9Oh0xYjbfk6TTrGeZy7cT6lNxElhVgM2KBzCFGQotU346v/O0Aj63YUqdH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUSn2lCy; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUSn2lCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719560619; x=1751096619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WXIT2HMnkoYJ+IC2cfUXxL8ZvEWu/eKhWP9RA7ER52o=;
  b=KUSn2lCyypJP8y+S6ntEUt3phtb+sN3wKYZhfgnnGxZwSOokhgVqKDme
   5rAHFEd+neGZZ8Ktmz0xM+O+spycvs6exmWsXj2EskcilHf9wk5nUlz8b
   XgJFs03tK3Tqg4DCWsC9OTPh5ydnFXMCKW3DYYnFZJbMDSuaGabjDR0qy
   9G1b5+DNm6Ea3HXzWUeyUjgxFCAHOhyigFJ8gQ2OiHjzKKMzZTn/3H+0Q
   mn1nwTKAD7F203pRCpEARufxKUsHk3BDXZ6O9xt6Ny29gDGfUhw6MJN60
   KUoEHBDIFZpDkHCi7jZC/ocD6RB8YWZhHgJ2Bwle0PkMLxAjuW0tBCHak
   w==;
X-CSE-ConnectionGUID: ifO8XpbWSEO36qo/tULmEg==
X-CSE-MsgGUID: toQeVxXFQr+/oPD6l1SjYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16957913"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16957913"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 00:43:38 -0700
X-CSE-ConnectionGUID: HtBfSr+vSVaOOhdi23kzoQ==
X-CSE-MsgGUID: dV0hiCgCStyI8z6cNl5wiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44544787"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 00:43:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 00:43:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 00:43:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 00:43:37 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 00:43:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV/nIm0RElTy14VzWjgYqZy6GFtH0vxw1W7SOukdudd/8bGsXYh/Fc1uCpCW7OkTdV5Ac0Cf6DsW2/twohpXa+B79m72vfwyH+4ji65p++x8VZjz2cq/Df4qpmX1oJmf5OaSOLW+dOfBtidRabpeyFoBRVAlLnel2HPs1BVsezeTUxJe1V2SyjNjqgvCD1PNbiB0Jz9fWW2OWybfMrfFtK9iwb4uNTSkOkbdeHkTYvQfy1cnI7vMmbE+iqaY2EK2MfiF46Jcr7zLyb85AS5r12c3oKtdJUy5gfhsNyOvJAbc7KGBt6XWBxDCC5MFSEPuqziT3OSNFNwg38BEgaG/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXIT2HMnkoYJ+IC2cfUXxL8ZvEWu/eKhWP9RA7ER52o=;
 b=htblkegx+FVbOg1Dvq6emF5PssWsVASCn0RDqhzLh96MZyP5XMV/PYFGCIR/CQZUhdQpDQrXiB0Qy+4WBNbHfyrCat0jcSn8mZSVt0BeNsndNTS5/yRlR7trgURmrhdBCXaf6chIcqIFS/NMzS1sbSNsjmPjf76FkeXcB+Ro46op2is/IP4JcJNGe4GeQOCDEx/vnfMo1p8tR2GE9h2I5xO5+0GGSv+uX35fZLArLvSGt6MqKWE8Z2vkRsYE0jSDpYHgOToEJGlAx37qpKBjt8dgmC+TKwHH40u3NpLqkde9tAKarbsDP83gjjTAH5ToeC7tovk4SxphqwgcceTBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4609.namprd11.prod.outlook.com (2603:10b6:5:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 07:43:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 07:43:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] iommu/vt-d: Add helper to flush caches for context
 change
Thread-Topic: [PATCH v2 1/2] iommu/vt-d: Add helper to flush caches for
 context change
Thread-Index: AQHayDqJlrXCDNkGs0SyJ8Dba7G6AbHbGrdAgAAq7ICAAX/cAA==
Date: Fri, 28 Jun 2024 07:43:27 +0000
Message-ID: <BN9PR11MB52760D102BD4F0AD7C24BCD58CD02@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240627023121.50166-1-baolu.lu@linux.intel.com>
 <20240627023121.50166-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527642AD41669FCF390297378CD72@BN9PR11MB5276.namprd11.prod.outlook.com>
 <80d727b4-c1eb-49d1-9b4a-ab3f0a4b54e2@linux.intel.com>
In-Reply-To: <80d727b4-c1eb-49d1-9b4a-ab3f0a4b54e2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4609:EE_
x-ms-office365-filtering-correlation-id: b82598ae-9663-4b51-7e28-08dc9745ffa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UHE4QXhPRTFMWThLdVR2NWsyeGVRRWtydUpKZDE3ek9adUNvWDhjc0FZT3Y1?=
 =?utf-8?B?UFgwRXpoREE2SVp3QUNyTkN1a1Y1TTZ4U3NuQ3dXNHAxQlN5aGV6dUIvUkdw?=
 =?utf-8?B?bjlneGt6KzdjSFU5TElLUGRTQlRhYUpUTGp3T3VmSkpieUllSVUxYTZqS1k1?=
 =?utf-8?B?R05kQ0lpZVg3TytlSHdBVWpPMDdYVElzbldqQnhyL2N4QXJnVHgyM2ZzUmFS?=
 =?utf-8?B?eUwxMUdCQk0zLzgvQ3ZxbnZkMzlYOVdPUEpNSnBEbmprOW1iSlphVHA2NW9l?=
 =?utf-8?B?M213VWhaZGlaSkIwOG5YOFBYZVVuQkRJL2FyRnZWL2RhY21OL3pKYXZmTm9V?=
 =?utf-8?B?aFozdDdqbi90a21vdnlCUXZrM3pqWFRVSS9IaVhEUUVJTWpPa0hMVVF6RFZ2?=
 =?utf-8?B?bEZibXZFWjhyc0toUmZxanFCUkF2c2w4UjQ0SzZNZkhWZlNzOGZEcE5XQ0pW?=
 =?utf-8?B?Rk1uNUQxeFBoaFJnTjg4ZkVCUStXd2Znd1FPNmF0NFg5VzdJMnVKT0s0WnZJ?=
 =?utf-8?B?bVp0K21MbTdmZWtPQzdKaDVtQ1N5ZTM3MFI0UVl5L3RkcGVGRU1KQmwyUm00?=
 =?utf-8?B?UXV2ZE5KTE1lWGRLYmxMSFVQeUZQRHFpNDZnVDVZdlgybVRNWEN5WXZkdVoy?=
 =?utf-8?B?QklraEhvUitDMjZSOU9BRGtKTE9zRkpaTW9sL3NvOWtqQ2xJZGdQTmNRUnlR?=
 =?utf-8?B?S1hYdU42K05xVVN0aVE3RWwxSDVyRms0RXlObWhEUktrL0tQYW1LR2lDYWZ1?=
 =?utf-8?B?MldYRjdvVGF0VmViTWhWVENKbHdGdjZQdVRMdFZnZVMwdTNjTHBEcXlsa0cx?=
 =?utf-8?B?SUFBTDFjTEdSUU9GR2NFMUkzWDVmUURmREwwMUtVdUNiZmtTWjhZZ1NML2R3?=
 =?utf-8?B?Umt4ekZ4MjlRWC82V0hsRjJvK0dqZmw2RksvVDZxVTMzL2M4MER3NUd0NWtt?=
 =?utf-8?B?YXNqWXV0NDNtMkwvc3BaUjRXTldxSUs5VmF0a2twVit6aEJIOWlnRlhCcHZJ?=
 =?utf-8?B?bWxPZ2RWNDdSd2tMYzdsa3FDUTFRbDliTjM3VTRUNnA0V3FRMnA1WHBvZzVi?=
 =?utf-8?B?Rnk4c2hrRE83dGR6TWNibVVLemdvOXo5R3R1NnJmTEI1Ty8xUzFSUURwTU9a?=
 =?utf-8?B?aDBpRTlodlNKWFZjR2R0MFl0b0tmMWdxN0V0bTVVbHVpSzE5d1JQR0M4RkIz?=
 =?utf-8?B?Kyttb2dyVGlNZHF3aUl5SnFLeWN6OWVyNXFnbTZqZjRRcHVQcTlheGRvQzZQ?=
 =?utf-8?B?Q2NXaElHT1VBUUNoVzZlTkFDcnFoRys3b0RUelAyMHQ2bDZIUUFxVFM2dHd6?=
 =?utf-8?B?RHd5WWluU1VHdmZtUUFsWlkybVZVNEhLQUNOWGhWSXV0dmQwZWRYY2FNY2xl?=
 =?utf-8?B?K20vRmJsZ28xek9hRG8xUSsvYnJMSkJVR1lISnYvTGlSMTJ2MmY3V1JNRXd2?=
 =?utf-8?B?RzBxZTVaRTJRczc5bURHNU9JSVJIbkpTVlhwaUo2S0ZGZU1qQWgvb2tFak05?=
 =?utf-8?B?Zno2ZWVuekQ0bkdUUEdtRlFTb3BBVkV2aDRpVVlaektNejlWN2I3bkk5dDVi?=
 =?utf-8?B?VDFZMFFpZ2pPaGZCQ2RDbTY1QlBOb0YwT1dxQXNRKzRyb3Y3Snk2L201bVhn?=
 =?utf-8?B?a0M3bjFRRHhhWXQ4MkNjaWU5RGt3TE9LZWhYTXFRcjdlNlI3Vjl2cFpkRnF1?=
 =?utf-8?B?amtiY0NGQXJaYW1HQ0dRQUdmQlIyL3hKckkzZEpoa2F1MlRPcHNvTGhJbzFO?=
 =?utf-8?B?bzkzMzB6MTRJQm1JR3NqQWFYNklSRlFPZFBzQ20wYUgzcXBaK2NHR1owbXl1?=
 =?utf-8?B?YWJsSW9VZ2k0YlJyWlhYZ3M2R1FpVjNGcnlOQUdYMEZTeXIwU0I1ZEJOQnBi?=
 =?utf-8?B?TkpEOUtLZzliaFNqZ1luZ3J1WGVhSUxBOVlFNWlDYkU2V2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVU1aHY2NktOb0Y5bGlmUlZ5c3A0MC9ZZ1N0SDBPbUJualplcmVwWEU3U1lh?=
 =?utf-8?B?VWhSbmpyZkttOGdwSHhNYjBDRGxCQVdDZThyQkxvZEFCVmVyZFErSFZ6QllR?=
 =?utf-8?B?eGdrYnhGYjdWQXdsMkV1WFNraUhCQlhoeFE4dXFVYzVPcGlUeVBDRDg4TUdt?=
 =?utf-8?B?MkJGUHgrcUsvT1BxUzhGRE5nMDZmbUlNWi8vSU83Z0NEb21YMWhCQndxR1NV?=
 =?utf-8?B?d29OVFNEVXpaVElSbkVTVnE5NGIxMnZBZXdZWE1CSy9RdDJzZXhZTmdxdHZZ?=
 =?utf-8?B?Y29vWWE5RzZlSGNTSnJZOWppOWViM29Pa0s4eE5odytsUHJ1Q1pUWi9jYTlq?=
 =?utf-8?B?SG51eWVRcU1GVkpaSzc0Q056Y1FYYzl0N3pFU0w2dEZLcFc5SitRUUw2MFpj?=
 =?utf-8?B?M2hCdVlCdXg4STVEY2NaU2Q5ZnkvODBtSjd5eC9ObUlOK0RBNEVWZ0VlYmVy?=
 =?utf-8?B?QTVMM0dVMVBKRWJoMnJmUklEWHlHS0Nvbzh1U0tBakNKSUZla2FiSUIwMm1J?=
 =?utf-8?B?cEZwd3REWDJJOExUWTF3YUhZcUhGSGMySUFWTnZJUFowMFkvNkdqUlNtSGZv?=
 =?utf-8?B?TlIraEFta2lWS01IckZMc0xlR2xETnVpNEVoNkliNy9PdzlXRmhFSUprdE0v?=
 =?utf-8?B?dEN1Zkhkc0NrcGp2cGx5NDVpTjZjTUdaaG5zSksvR3lQNVVEUGlNNGlMS3Vx?=
 =?utf-8?B?MGhvVUEvR08xa1NOM0MvL25KMmh3dG80VDY5amg2YVIyODEwUmpFaDRBSGFL?=
 =?utf-8?B?YkFVVnVtT0pkQjlVL3VwVi81bTg0QVRPZXNEWXk5UVk3a1MwNTJhcmZCUGZ5?=
 =?utf-8?B?ZGkzSTlpNGdGVjA3OVV4SzZmaUVPSWtjZnlQcUVtRkNTM2w3bDJ3dzFtMkdn?=
 =?utf-8?B?d2hIdm5haCtxS0h1QzdNa0VKbDVwUkpqQ3VVZkpaOG43N2RPUXU1dE5pRURD?=
 =?utf-8?B?SzF3MHlia3k4MHkxNldmbDQ2M1pKdVkraVhQalpBN25uZ0I4UE5wc0NuR1Zm?=
 =?utf-8?B?YmpscTNmUGVhMG1lRXlMMDcyOGhFdjdlK3FtNFAyWnFPUmVIYWtWUVpjUVM1?=
 =?utf-8?B?UEpKdy9NcnIwOVFwQzBQYjEyZnVkRlFyaFRxU2tKQkVzQWgzT0xSbjdoZ2Mw?=
 =?utf-8?B?cVFHREpjdDlNVmtXTU8vWCtESnAwSEloUU14aXBtK0xqb3lOSUxZVTRqeG1Y?=
 =?utf-8?B?bmdsRVcyZnhQMlZLSk9hVWdSTWtGRWNSWnVjek1ubENUOGtPWWZXVmpJZEZv?=
 =?utf-8?B?ZnNXRmdlUmNWNjF0RjJaOUEwWDdaL2RuK2F3TndBQnJoSEpjMU5QaXkwSGRh?=
 =?utf-8?B?amw0WG9laHV0WDhuUUhlTHpvM09KTnROdVgxYVVHR0g4Y0hXdTNteFFjTHVG?=
 =?utf-8?B?TElUbDFkL2lPYkp5a2Rza2RZM1RFbWhLZGQxaStWUjRuZkUvajllZjd6UjBW?=
 =?utf-8?B?MWVycUZlOG5VWUxOVytrYUZ0TjdYYjBZK1hFbjJlMW5IdjQ0WnBlKzVqbmpj?=
 =?utf-8?B?QUZkVmxTVmdCajdPRWVLODFPUVRsQXFDa1pSTFpaSThGK1VRR0M0OTcrQnpv?=
 =?utf-8?B?SXZTbVlKSkFvampNcDNvOEwxWC8xVlNYQ2FtWWhNcWVmZnpubmF3TG5Tc1k1?=
 =?utf-8?B?Q24zdnQyOVJLdmlWazQxU0tFYWdBNHJBVlV1RVlNelZaMm9naSs2ZTFoR1E2?=
 =?utf-8?B?NDhuQU9VS1VBdUZ2bFN5SWowcXRQN3phczBOQmxzMjhFbndOalRXNW5UWFNx?=
 =?utf-8?B?N3pHb0dXQ3VMMzVHQi9WRC9wOCtKUEJsM1d6VDhZcS9BNG4zVERQemNNL1Vr?=
 =?utf-8?B?R1BJeUhsaVlQbG5SL0pQVXo4amVBdGJXa2N5SGd5Q1ZMS21SRXJialB2ckZI?=
 =?utf-8?B?Z0ZERFVOZnVBNVVDSTFScTBYTnNla2k5aDJTTHgyVGN0bUJtbHpKQTZ3M3Bw?=
 =?utf-8?B?Y1VRcDAwWVVsWW9ZekYwN291QklWaUh2NXllNmlKQlBTcXJKTkpBYnlPUDhV?=
 =?utf-8?B?c0JnYXFZQ0lQVjIxUy91QVpFWnVGM3VnelZURVBlV2tTZjJtdnBibDVtQjlM?=
 =?utf-8?B?Z2szZDMzaGtaelVLMWRKUStVRVVwWjBSOStYeFpCYUZacjAzQWxYbUMyek9Q?=
 =?utf-8?Q?/CdtaZ0XkcfpiDmXK5G0izukH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82598ae-9663-4b51-7e28-08dc9745ffa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 07:43:27.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwqXprYi3FIvz8+5YxgJe9mS182worx5OdBRfNVZx//OupstAuKHOx4HhyQrJv4AC5gWYxNIYg7EA9RaezXv5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4609
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVuZSAyNywgMjAyNCA0OjIyIFBNDQo+IA0KPiBPbiAyMDI0LzYvMjcgMTQ6MDgsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50
ZWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgSnVuZSAyNywgMjAyNCAxMDozMSBBTQ0KPiA+
Pg0KPiA+PiArICovDQo+ID4+ICt2b2lkIGludGVsX2NvbnRleHRfZmx1c2hfcHJlc2VudChzdHJ1
Y3QgZGV2aWNlX2RvbWFpbl9pbmZvICppbmZvLA0KPiA+PiArCQkJCSBzdHJ1Y3QgY29udGV4dF9l
bnRyeSAqY29udGV4dCwNCj4gPj4gKwkJCQkgYm9vbCBhZmZlY3RfZG9tYWlucykNCj4gPj4gK3sN
Cj4gPj4gKwlzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11ID0gaW5mby0+aW9tbXU7DQo+ID4+ICsJ
dTE2IGRpZCA9IGNvbnRleHRfZG9tYWluX2lkKGNvbnRleHQpOw0KPiA+PiArCXN0cnVjdCBwYXNp
ZF9lbnRyeSAqcHRlOw0KPiA+PiArCWludCBpOw0KPiA+PiArDQo+ID4+ICsJYXNzZXJ0X3NwaW5f
bG9ja2VkKCZpb21tdS0+bG9jayk7DQo+ID4+ICsNCj4gPj4gKwkvKg0KPiA+PiArCSAqIERldmlj
ZS1zZWxlY3RpdmUgY29udGV4dC1jYWNoZSBpbnZhbGlkYXRpb24uIFRoZSBEb21haW4tSUQgZmll
bGQNCj4gPj4gKwkgKiBvZiB0aGUgQ29udGV4dC1jYWNoZSBJbnZhbGlkYXRlIERlc2NyaXB0b3Ig
aXMgaWdub3JlZCBieSBoYXJkd2FyZQ0KPiA+PiArCSAqIHdoZW4gb3BlcmF0aW5nIGluIHNjYWxh
YmxlIG1vZGUuIFRoZXJlZm9yZSB0aGUgQGRpZCB2YWx1ZQ0KPiA+PiBkb2Vzbid0DQo+ID4+ICsJ
ICogbWF0dGVyIGluIHNjYWxhYmxlIG1vZGUuDQo+ID4+ICsJICovDQo+ID4+ICsJaW9tbXUtPmZs
dXNoLmZsdXNoX2NvbnRleHQoaW9tbXUsIGRpZCwgUENJX0RFVklEKGluZm8tPmJ1cywgaW5mby0N
Cj4gPj4+IGRldmZuKSwNCj4gPj4gKwkJCQkgICBETUFfQ0NNRF9NQVNLX05PQklULA0KPiA+PiBE
TUFfQ0NNRF9ERVZJQ0VfSU5WTCk7DQo+ID4+ICsNCj4gPj4gKwkvKg0KPiA+PiArCSAqIEZvciBs
ZWdhY3kgbW9kZToNCj4gPj4gKwkgKiAtIERvbWFpbi1zZWxlY3RpdmUgSU9UTEIgaW52YWxpZGF0
aW9uDQo+ID4+ICsJICogLSBHbG9iYWwgRGV2aWNlLVRMQiBpbnZhbGlkYXRpb24gdG8gYWxsIGFm
ZmVjdGVkIGZ1bmN0aW9ucw0KPiA+PiArCSAqLw0KPiA+PiArCWlmICghc21fc3VwcG9ydGVkKGlv
bW11KSkgew0KPiA+PiArCQlpb21tdS0+Zmx1c2guZmx1c2hfaW90bGIoaW9tbXUsIGRpZCwgMCwg
MCwNCj4gPj4gRE1BX1RMQl9EU0lfRkxVU0gpOw0KPiA+PiArCQlfX2NvbnRleHRfZmx1c2hfZGV2
X2lvdGxiKGluZm8pOw0KPiA+PiArDQo+ID4+ICsJCXJldHVybjsNCj4gPj4gKwl9DQo+ID4+ICsN
Cj4gPj4gKwkvKg0KPiA+PiArCSAqIEZvciBzY2FsYWJsZSBtb2RlOg0KPiA+PiArCSAqIC0gRG9t
YWluLXNlbGVjdGl2ZSBQQVNJRC1jYWNoZSBpbnZhbGlkYXRpb24gdG8gYWZmZWN0ZWQgZG9tYWlu
cw0KPiA+PiArCSAqIC0gRG9tYWluLXNlbGVjdGl2ZSBJT1RMQiBpbnZhbGlkYXRpb24gdG8gYWZm
ZWN0ZWQgZG9tYWlucw0KPiA+PiArCSAqIC0gR2xvYmFsIERldmljZS1UTEIgaW52YWxpZGF0aW9u
IHRvIGFmZmVjdGVkIGZ1bmN0aW9ucw0KPiA+PiArCSAqLw0KPiA+PiArCWlmIChhZmZlY3RfZG9t
YWlucykgew0KPiA+PiArCQlmb3IgKGkgPSAwOyBpIDwgaW5mby0+cGFzaWRfdGFibGUtPm1heF9w
YXNpZDsgaSsrKSB7DQo+ID4+ICsJCQlwdGUgPSBpbnRlbF9wYXNpZF9nZXRfZW50cnkoaW5mby0+
ZGV2LCBpKTsNCj4gPj4gKwkJCWlmICghcHRlIHx8ICFwYXNpZF9wdGVfaXNfcHJlc2VudChwdGUp
KQ0KPiA+PiArCQkJCWNvbnRpbnVlOw0KPiA+PiArDQo+ID4+ICsJCQlkaWQgPSBwYXNpZF9nZXRf
ZG9tYWluX2lkKHB0ZSk7DQo+ID4+ICsJCQlxaV9mbHVzaF9wYXNpZF9jYWNoZShpb21tdSwgZGlk
LA0KPiA+PiBRSV9QQ19BTExfUEFTSURTLCAwKTsNCj4gPj4gKwkJCWlvbW11LT5mbHVzaC5mbHVz
aF9pb3RsYihpb21tdSwgZGlkLCAwLCAwLA0KPiA+PiBETUFfVExCX0RTSV9GTFVTSCk7DQo+ID4+
ICsJCX0NCj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4gKwlfX2NvbnRleHRfZmx1c2hfZGV2X2lvdGxi
KGluZm8pOw0KPiA+PiArfQ0KPiA+PiAtLQ0KPiA+PiAyLjM0LjENCj4gPj4NCj4gPg0KPiA+IHRo
aXMgY2hhbmdlIG1vdmVzIHRoZSBlbnRpcmUgY2FjaGUgaW52YWxpZGF0aW9uIGZsb3cgaW5zaWRl
DQo+ID4gaW9tbXUtPmxvY2suIFRob3VnaCB0aGUgZGlyZWN0bHktYWZmZWN0ZWQgb3BlcmF0aW9u
cyBhcmUgbm90IGluDQo+ID4gY3JpdGljYWwgcGF0aCB0aGUgaW5kaXJlY3QgaW1wYWN0IGFwcGxp
ZXMgdG8gYWxsIG90aGVyIHBhdGhzIGFjcXVpcmluZw0KPiA+IGlvbW11LT5sb2NrIGdpdmVuIGl0
J2xsIGJlIGhlbGQgdW5uZWNlc3NhcmlseSBsb25nZXIgYWZ0ZXIgdGhpcw0KPiA+IGNoYW5nZS4N
Cj4gPg0KPiA+IElmIHRoZSBvbmx5IHJlcXVpcmVtZW50IG9mIGhvbGRpbmcgaW9tbXUtPmxvY2sg
aXMgdG8gd2FsayB0aGUgcGFzaWQNCj4gPiB0YWJsZSwgcHJvYmFibHkgd2UgY2FuIGNvbGxlY3Qg
YSBiaXRtYXAgb2YgRElEJ3MgaW4gdGhlIGxvY2tlZCB3YWxrDQo+ID4gYW5kIHRoZW4gaW52YWxp
ZGF0ZSBlYWNoIGluIGEgbG9vcCBvdXRzaWRlIG9mIGlvbW11LT5sb2NrLiBIZXJlDQo+ID4gd2Ug
b25seSBjYXJlIGFib3V0IERJRHMgYXNzb2NpYXRlZCB3aXRoIHRoZSBvbGQgY29udGV4dCBlbnRy
eSBhdA0KPiA+IHRoaXMgcG9pbnQuIE5ldyBwYXNpZCBhdHRhY2ggd2lsbCBoaXQgbmV3IGNvbnRl
eHQgZW50cnkuIENvbmN1cnJlbnQNCj4gPiBwYXNpZCBkZXRhY2ggdGhlbiBtYXkganVzdCBjb21l
IHdpdGggZHVwbGljYXRlZCBpbnZhbGlkYXRpb25zLg0KPiANCj4gVGhlIGlvbW11LT5sb2NrIGlz
IG5vdCBvbmx5IGZvciB0aGUgUEFTSUQgdGFibGUgd2Fsay4gVGhlIGJhc2ljDQo+IHNjaGVtYXRp
YyBoZXJlIGlzIHRoYXQgb25jZSBhIHByZXNlbnQgY29udGV4dCB0YWJsZSBlbnRyeSBpcyBiZWlu
Zw0KPiBjaGFuZ2VkLCBhbGwgUEFTSUQgZW50cmllcyBzaG91bGQgbm90IGJlIGFsdGVyZWQgdW50
aWwgYWxsIHRoZSByZWxhdGVkDQo+IGNhY2hlcyBoYXZlIGJlZW4gZmx1c2hlZC4gVGhpcyBpcyBi
ZWNhdXNlIHRoZSBjb25maWd1cmF0aW9uIG9mIHRoZQ0KPiBjb250ZXh0IGVudHJ5IG1pZ2h0IGFs
c28gaW1wYWN0IFBBU0lEIHRyYW5zbGF0aW9uLg0KDQpJcyBpdCB3aGF0IHRoZSBzcGVjIGV4cGxp
Y2l0bHkgcmVxdWlyZXM/IE15IGltcHJlc3Npb24gd2FzIHRoYXQgd2UNCm5lZWQgdG8gaW52YWxp
ZGF0ZSBhbnkgY2FjaGUgd2hpY2ggbWF5IGJlIGFzc29jaWF0ZWQgd2l0aCB0aGUgb2xkDQpjb250
ZXh0IGVudHJ5LCB3aGljaCBpcyBub3QgZXF1YWwgdG8gcHJvaGliaXRpbmcgUEFTSUQgZW50cmll
cyBmcm9tDQpiZWluZyBjaGFuZ2VkIGF0IHRoZSBzYW1lIHRpbWUgKGFzIGxvbmcgYXMgdGhvc2Ug
Y2hhbmdlcyB3b24ndCANCmNhdXNlIGEgc3RhbGUgY2FjaGUgZW50cnkgYmVpbmcgYWN0aXZlKS4N
Cg0KZS5nLiBsZXQncyBzYXkgdGhpcyBoZWxwZXIgY29sbGVjdHMgdmFsaWQgcGFzaWQgZW50cmll
cyAoMiwgMywgNCkgYW5kDQphc3NvY2lhdGVkIERJRHMgKHgsIHksIHopIGluIGEgbG9ja2VkIHdh
bGsgb2YgdGhlIHBhc2lkIHRhYmxlIGFuZA0KdGhlbiBmb2xsb3dzIHRoZSBzcGVjIHNlcXVlbmNl
IHRvIGludmFsaWRhdGUgdGhlIHBhc2lkIGNhY2hlDQpmb3IgKDIsIDMsIDQpIGFuZCB0aGUgaW90
bGIgZm9yICh4LCB5LCB6KSBvdXRzaWRlIG9mIHRoZSBsb2NrLg0KDQp0aGVyZSBjb3VsZCBiZSBz
ZXZlcmFsIGNvbmN1cnJlbnQgc2NlbmFyaW9zIGlmIGlvbW11LT5sb2NrIGlzDQpvbmx5IGd1YXJk
ZWQgb24gdGhlIHBhc2lkIHRhYmxlIHdhbGtpbmc6DQoNCjEpIHBhc2lkIGVudHJ5ICMxIGlzIHRv
cm4gZG93biBiZWZvcmUgdGhlIGxvY2tlZCB3YWxrLiBUaGUNCnRlYXJkb3duIHBhdGggd2lsbCBp
bnZhbGlkYXRlIGl0cyBwYXNpZCBjYWNoZSBhbmQgaW90bGIgcHJvcGVybHkuDQoyKSBwYXNpZCBl
bnRyeSAjNCBpcyB0b3JuIGRvd24gYWZ0ZXIgdGhlIGxvY2tlZCB3YWxrLiBUaGVuIHdlIG1heQ0K
c2VlIGR1cGxpY2F0ZWQgaW52YWxpZGF0aW9ucyBib3RoIGluIHRoaXMgaGVscGVyIGFuZCBpbiB0
aGUNCnRlYXJkb3duIHBhdGguDQozKSBuZXcgcGFzaWQgYXR0YWNoIGJlZm9yZSBsb2NrZWQgd2Fs
ayBtYXkgYmUgYXNzb2NpYXRlZCB3aXRoDQplaXRoZXIgb2xkIG9yIG5ldyBjb250ZXh0IGVudHJ5
LCBkZXBlbmRpbmcgb24gd2hldGhlciBpdCdzIHBhc3NlZA0KdGhlIGNvbnRleHQgY2FjaGUgaW52
YWxpZGF0aW9uLiBJbiBhbnkgY2FzZSBpdCB3aWxsIGJlIGNhcHR1cmVkIGJ5DQpsb2NrZWQgd2Fs
ayBhbmQgdGhlbiBoYXZlIHJlbGF0ZWQgY2FjaGUgaW52YWxpZGF0ZWQgaW4gdGhlIGhlbHBlci4N
CjQpIG5ldyBwYXNpZCBhdHRhY2ggYWZ0ZXIgbG9ja2VkIHdhbGsgaXMgYWx3YXlzIHNhZmUgYXMg
cmVsYXRlZA0KY2FjaGUgd2lsbCBvbmx5IGJlIGFzc29jaWF0ZWQgd2l0aCB0aGUgbmV3IGNvbnRl
eHQgZW50cnkuDQoNCj4gDQo+IFByZXZpb3VzbHksIHdlIGRpZCBub3QgYXBwbHkgdGhpcyBsb2Nr
IGJlY2F1c2UgYWxsIHRob3NlIGNhc2VzIGludm9sdmVkDQo+IGNoYW5naW5nIHRoZSBjb250ZXh0
IGVudHJ5IGZyb20gcHJlc2VudCB0byBub24tcHJlc2VudCwgYW5kIHdlIHdlcmUNCj4gY2VydGFp
biB0aGF0IGFsbCBQQVNJRCBlbnRyaWVzIHdlcmUgZW1wdHkuIE5vdywgYXMgd2UgYXJlIG1ha2lu
ZyBpdCBhDQo+IGdlbmVyaWMgaGVscGVyIHRoYXQgYWxzbyBzZXJ2ZXMgc2NlbmFyaW9zIHdoZXJl
IHRoZSBlbnRyeSByZW1haW5zDQo+IHByZXNlbnQgYWZ0ZXIgdGhlIGNoYW5nZSwgd2UgbmVlZCB0
aGlzIGxvY2sgdG8gZW5zdXJlIHRoYXQgbm8gUEFTSUQNCj4gZW50cnkgY2hhbmdlcyBvY2N1ciBh
dCB0aGUgc2FtZSB0aW1lLg0KPiANCg0KRXZlbiBpZiB3ZSB3YW50IHRvIGRvIGEgY29uc2VydmF0
aXZlIGxvY2tpbmcgSSBwcmVmZXIgdG8gbm90IGFwcGx5aW5nDQppdCB0byBleGlzdGluZyBwYXRo
cyB3aGljaCBjbGVhcmx5IGhhdmUgbm8gbmVlZCBmb3IgZXh0ZW5kZWQgbG9jay4NCg0KVGhlbiBw
cm9iYWJseSBtYWtpbmcgYSBzcGVjaWZpYyBoZWxwZXIgZm9yIHByaSBmbGlwIG1ha2VzIG1vcmUg
c2Vuc2UNCnRoYW4gZ2VuZXJhbGl6aW5nIGNvZGUgdG8gaW5jdXIgdW5uZWNlc3NhcnkgbG9jayBv
dmVyaGVhZCBvbiBleGlzdGluZw0KcGF0aHMuLi4NCg==
