Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114311CA9
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740969850; cv=fail; b=UjFFcIgIUpp0rvGUaF58SfOdWXYkWO/TQ6fwqem2mPYd9wJ8vu36zUc7x5ZtXdw61mPWG3Xjg/0NpSY6AEfeRGxHpmAq4xWECnaVHEkqAYbBJMCDNihaVMj9YnPbujr8BwkUp5pZ7appWGh87vajXVqyScbb9XpsD2mHYFtIqC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740969850; c=relaxed/simple;
	bh=AorR5rfEnfRde13zPHrODjbp7rpwig7NP6Jq1tQ1+14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=drjPPoeuyzXudBx8Dp4gsR5hoavv+NK/jKXqDUgLScEOx/3YZ8DxpXouDkQusxZLWSVH2FYcXyng3pc/TCLV2hN1e3D+ajDkznz06JNDJ8Ap3ZQwWF+yFblWZmvd32zYskzisOePkpwaDZZHYoAxsxGJQi9755jBaL1vG+zcPjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxFurzdv; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxFurzdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740969848; x=1772505848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AorR5rfEnfRde13zPHrODjbp7rpwig7NP6Jq1tQ1+14=;
  b=hxFurzdvybEbAgCTCJ7swPZTWaitZxlKgaB/gF+u6H9P56SXnoQXRyTZ
   gpVGae4HVxsCUyaJCfJb/6k1c072uJHPw9YhQA98tUNsbivLbSwTfm4/N
   3/N5h6Fx4yYKVGb0T2xb6sy2KN4M+ISH6XVYKbeVY+KlXuIPLD4ZsERgD
   UxIKrfq9b773ugd2TLwIVDUbXykcqUtswaQ1qjbpl6ZJ0leqASDO8RvnQ
   oLb3XCy09VAGfg7NXSXnj3I1ZCKKbfHksYU2KWjrNmA4hjaYrkhAzlb3N
   4oTUOvKVzEfMhaFus4ZlrlU3ejqlC/TMhUe9TFmF2Q/CBsaWzJQCV6Ueh
   g==;
X-CSE-ConnectionGUID: gSROYNLhQWCXAvi9cfkhFA==
X-CSE-MsgGUID: Ex1ts/g0S4qBq7yrKgW9pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="67204280"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="67204280"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 18:44:07 -0800
X-CSE-ConnectionGUID: PorcsmwAR1uDfp4tjOSSqw==
X-CSE-MsgGUID: K3Qm/pHRRFOyQ7t1XomNgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117730303"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 18:44:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 2 Mar 2025 18:44:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 2 Mar 2025 18:44:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 2 Mar 2025 18:44:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUylNLfZPNdSz6aK55BuDV+JlKLoe71OF58TKWfw7+73XVmcIgOZ1O9AfepVpEBXd+WlkFy1YwPY4NRm+fgjXan4otv9YzA73CdW6TktzA/0bBH8dlHj7qNfQOeUJHWoK8p4AyT/GA9TQJf0iDFcrGt6ZOQVLIDcsbMggiT5kiXsov/oq6XINhejoQtcDjo0rtShZKUbUkZcmByEIxMjhEXHqLHbLdFnwooYgGn5eWqqUt9Zl2xcz4Cv4FFNEz+dI4ff/f2b+xw1jMSqsG4whIIdqtq1UXhlpWd3Wocjqg1FxuYn3d2sAe7+Lwozer/DMrtixC1PlweBbXDO+DOIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AorR5rfEnfRde13zPHrODjbp7rpwig7NP6Jq1tQ1+14=;
 b=rzqSiDCOocEg3hBxYzvw7lsY8/Hn04cHLy9QNJ+O60Sg/x1kavxu0v+raRLk1Ve5JonIltSgWI3QP/0OhSzQbC9cEDgIvL1Z2XYwXDTYlBwHseW/+3xQNEqRUi1z/nWzfIqRd4FNiwCZrY4zCZ/ki0qvcSVXZYF2IOFiJorqQZ2Pv9bGXZz5b7kZGl+eOH6/tqigZ4nJmY4JlkmwBiQaEm8W1vo35pBPBC9yf96AAtQWNpvNWf12VyxDfKm+X1mIxCWBK0xDe6UhPg8GNhSTKrdfjMdUNk+W61XE5X19csUYf6r0pbQKGC/Mq83zHsA2MckYZWCgHAA4GDV77tSqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6539.namprd11.prod.outlook.com (2603:10b6:208:3a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 02:43:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:43:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAA6H6AgAAmfHCAAijjgIAAoxWAgABE8HCAAJaWgIAD6K+w
Date: Mon, 3 Mar 2025 02:43:58 +0000
Message-ID: <BN9PR11MB5276406FED1E5028D9E84D128CC92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
 <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cc4cf4ae-2d29-4747-b655-df841661b82a@amd.com>
 <26fa08c1-4a3c-44a6-aba6-a35a0f308bc8@linux.intel.com>
 <BN9PR11MB5276D09A00E44AE7D220D7C18CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250228145325.GK5011@ziepe.ca>
In-Reply-To: <20250228145325.GK5011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6539:EE_
x-ms-office365-filtering-correlation-id: 9b18dd19-c68d-4392-dc3a-08dd59fd3fbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?28iJe8pAuSTBs2vWwJQlbBamNvaIvTj2tq73Mqvdyb5gfmItsnccOznurg7r?=
 =?us-ascii?Q?v1o+uJDzpKWAxbajQD9oV1uL4/iyxELNJkiAFQsXzdr+3gJ0IGObdJi6LEap?=
 =?us-ascii?Q?U3QB0d2ccWjonnHf5yBWaU4mGvVJp3ovk+bgIt/75Ar24DHSCRAIFt5l+iGL?=
 =?us-ascii?Q?TSzSQSP4A4kJa4N9YSmJYPjZurhYUzRVbZNOmFOqdPd2Ev2kOxeAfJx7D+uG?=
 =?us-ascii?Q?HGSwEvwXBCf3q5NoygSUJEz7U/9fZQtsnSIJP5H5Ll5jMOl/CJCplYB3YdQi?=
 =?us-ascii?Q?kni9288S458066qjOxW20FdNYzOCUqyP91F55rYJNKUG5VZR4XnZd0kdhTec?=
 =?us-ascii?Q?lCdVbgXtYvR+qbHtvXhU+ccaU2zac9JNZqzRU+NAWh364EtJ/p6VHfhNQYqm?=
 =?us-ascii?Q?ziPK8hYDzZEhiKyihOEhc6tlHVIPvpVB2RaPT8sqUrTyNlbmxOCW7+x0NBu2?=
 =?us-ascii?Q?N+Imloko5X0UznJFCPEr/cSjlqBgCBqcmSC2VDwXx56XxQRcg4Xjrqi6Kbwg?=
 =?us-ascii?Q?pdKNUKkT+cwI9pNKTaHhghsxRPo9EUNbPNUqlWiTqRoOTf7bYZAa0FoaSZlC?=
 =?us-ascii?Q?QsuvUlG+7DWUiyeOZ/UNth8i5LdNsiaKJFmxxGIoghaYFtyAv2U2XE7YnFnq?=
 =?us-ascii?Q?XlqEbILWkSe/SZdWTXjDieqvL1IUZzuGkipKYzqieUfu9hY845ai67GwDum/?=
 =?us-ascii?Q?1tmEdejYhGTWPkbeH7sBUH3KDFAPcL7kch0uwTUPVtD5TVqXC7/cRz+phCvO?=
 =?us-ascii?Q?L47SDo5TfveLw9MucGbK+v/4eRtQZTnHLjTdyFHOYSy3uu4kvpCLNVqk4EuN?=
 =?us-ascii?Q?gyCtp0jo1h/eJSadEGxVDlrA5GcKrLU6QEap8IYkmtQVdCEI617Yb/bvTvnF?=
 =?us-ascii?Q?5y6vuQOE7W1lj43HM6m2KX0ySSgeOZ7VjtW7l6kurYSL2YnnM1bRqW2JTa9c?=
 =?us-ascii?Q?hWh+8ehl08L7Iz4ykStmgYN1uT/I3ztcylr6gwJvLCuKN14dCDxX8c2Ap1Xy?=
 =?us-ascii?Q?+qH6GT9mxyyA8ifM2czQ4l57IHxIHDsBOOq8E/s9GICxIUh6e8V1P5+Ra1Td?=
 =?us-ascii?Q?7GIsdXUwywv5K91/1CkFITduyYKZ0BQ79QnX9kNtmhOgIddIKi88u+YmKrM8?=
 =?us-ascii?Q?CafRWy+6GsFwcAUBdd/ntAtruTv1Y8nq9x5NrEzSrehv8S8siaDxteoGtEYG?=
 =?us-ascii?Q?aC2GfqwsmUaklsomY5hKui3maDSsJWCpZpioYNXp8bDmenhujjiEZ71gSF5d?=
 =?us-ascii?Q?xnzIn8gP+ZkJb/A3aybB2wm/dFSMuwC0CM9uPhfETSFKvVlvB54WQpdKEFfB?=
 =?us-ascii?Q?qBCRqTGwaE8Mh8FE9ZC/c2sa7XnaXRs/wP1Bq1u5GPGTArYLrM16L1fcARbD?=
 =?us-ascii?Q?QS5MNesX2DBzuSII+n/oPDt53gmqAtzoGDsoGTCU/29GCno7/QuoP8f5Tc0G?=
 =?us-ascii?Q?cFrt0eH6wbZqGT7qzY4NsMyr/2K+tZ5P?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VwgfxshkUkM0IC396oLvw+uNjgcYwPwHr7bh3i3gcHVkt5Tfrqi20IzVcPxr?=
 =?us-ascii?Q?5zywMoCqzmzebzksFS+zUGSmw4MR/ymYgAoOjhleUtgH0C3cql4SfpFO30zx?=
 =?us-ascii?Q?BWyxwBl4DDicOYw2aqlvxLxIHu7t4xB5bRcmJwaP26w8fiesZY8ebXplKPL9?=
 =?us-ascii?Q?w9ZHP6rz7g5yPGs86GJakouCfzSdwo0dWy4VtazqKlWBZ84hBhdvi8Ub0JSS?=
 =?us-ascii?Q?UaUG2mIxsCHY93bYzjICATv963HGx70yM+x3IoxhMGK52aANExBtv8D0SamN?=
 =?us-ascii?Q?80Jw30cRZ5j6ctKNyM8EWNuh5581MdQdwTKE8SVHK2n0PFSqBbpWs9K6D0yf?=
 =?us-ascii?Q?Q7D9F8UEHLCMxJndPmo+GcAAEB4ZZ9qD+BRVBHChygSrTy8Z99kHmtTs5OOo?=
 =?us-ascii?Q?zUBGW8FCXEyz3CUbwL7MJpmEuUuJm8w8M5C2xWLNE6NvOCoa1ZJoYbI6RsxO?=
 =?us-ascii?Q?DA2Iy1gibZlwrZ+0FFxtwo3XNTTtlWWM7NJKDa1/s/26aNyE7OPADvSeO8WJ?=
 =?us-ascii?Q?lf2TYTj9mDGmrVLJ+tv5t4bgobqSgOKuBR8/oyzy5W+n5sBaZIKobM94ZM9C?=
 =?us-ascii?Q?oX84QKdvnsexcZwqTnP9unUVAPjnwNZ4n8BLdn8AL0nLpaAHGXnW5d6xjhG9?=
 =?us-ascii?Q?ZI1zQwc7d7O9sVLWvv3s9gzTsxOlFDDfJMx9HcmKSfwlYYZBIgTOJfDEqs/f?=
 =?us-ascii?Q?1g0g5r/7yUhNZwWMjKl2GWNII7XiZiv57F4OMrlnFh9ChKy48jyKGl5pZ2ip?=
 =?us-ascii?Q?Aj+VFAJICMViWSRh5NYeKZOukPQVkhQZxyc+TqMKNrLuCMZLK5xhZ/EzggEm?=
 =?us-ascii?Q?ElxAxDVb6roUyThTA95Yw2/C3IrQmPK/UcL/XME5Vmf4H5lrAr8RleQzKeYm?=
 =?us-ascii?Q?E9x44gWpv6JzsgeUyXKhj+3U96u8OoXIJdyJwZIDj1BLbdVkDU2DlMmnPV5q?=
 =?us-ascii?Q?feBrfOKWJnHjcWCUp4ZyUC9NcrpQF79Ju0CGlSMCseOnLFerX5azf71e0qb9?=
 =?us-ascii?Q?zPlUY8THt/2ArxGm++CFBnA4K5pBPs4ZXxdeZ9DSiEM3FKwX4pHRwK/wnOoh?=
 =?us-ascii?Q?5xuYWGYNorL3iXgm1XYqE/YB0IF0cUXD9D1cEPRfXDvalfaLG8XXt7B6KAkj?=
 =?us-ascii?Q?2rq9ZSlSnfsgKti+afzYX3VENBW3l8Rl93BcQxxl5P5Lhee/Vvket5QmNafv?=
 =?us-ascii?Q?diGsiEovfCrkGZu+7x7qOU1tV1k9z4rMR7NS+CMGKfjLLR3iKn5N799eodqh?=
 =?us-ascii?Q?AZMm+2kjUTKLTHvA3adC3nybFSEX0t2evLRY0JWONYWVW++A9MGscvE5xitb?=
 =?us-ascii?Q?pf+MR0vBSF+qyYXk56MZbTRwAAnZIa0kuxBp/S84BMNc5w62+aAhc9M9mpm7?=
 =?us-ascii?Q?xACtUqEaabTSpQNOHcbXbeBYnU8bADPtWdOSV+jmQAzymcRd5uE3Hyj04blv?=
 =?us-ascii?Q?SDRAgrlUUuQ5XlC6u5e1lPuMk4wZpT8L5sqMWQXmoX0FApuccsFcer+0KHqt?=
 =?us-ascii?Q?3pGBf9co8ZBOWk8yKgeLJjbg/QCd4lIFEpKC0T474vV82WyUN6BF8c7sYcJ0?=
 =?us-ascii?Q?3u/4PbpFd+JKv6vVJgrTWNwFlJ5FoD93W0Tnnikl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b18dd19-c68d-4392-dc3a-08dd59fd3fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 02:43:58.6957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omp/IZamIptnKzRftBxdxJdDyY4t5wj7T43eI4Rl9wh8thgsIB4wN/VehweGbrlrOxASvxt29I60FfntofSSMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6539
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, February 28, 2025 10:53 PM
>=20
> On Fri, Feb 28, 2025 at 06:15:32AM +0000, Tian, Kevin wrote:
>=20
> > scenarios. Probably good for prototype development but no
> > real value given it loses all perf benefit from ATS or even worse
> > perf compared to no ats due to double walking.
>=20
> ARM's docs noted they expect about the same IO performance between #3
> and #4 methods. Both are walking tables to validate the TA. The main
> value of ATS here is not for performance but it supports a non-present
> result.

Both are walking tables but the costs are not exactly same.

In concept #4 allows a more efficient table format to achieve a good
tradeoff between performance and security - perf lower than unsecure
ATS but higher than #3, with security enforced.

e.g. for VT-d the permission structure is a compacted format with
each 64 bit PTE covering 16 pages, i.e. only 4 perm bits per page.
So it's far less walks compared to walking a full nested I/O page
tables, plus a dedicated cache.

