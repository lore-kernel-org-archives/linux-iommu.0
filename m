Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8030EF6F
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768540803; cv=fail; b=X3blNaa1Baa7eSYgRlTU1b+NllwWta7luSQa6T2W/Gg+hGhZd2cKMfz/4V4UejvpVOUo+7M6cPMwAwNHpHXD6X/Lt/+0vEs6uBSvfcliTM47hYnDkdZ+o/tinlU1ir98ZS9dexgKfabpTKh9nrH6m8HGDJRGrubFZ8iX+gDiDNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768540803; c=relaxed/simple;
	bh=cvfuyj5vtm69FS3qp34S50CDl09AHW88a0oB3qGJWK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tTsXXvQYZpFEBOPBT7lPVW2Pk4k0s5KP4hBJbc+W3ZHEXJ5xdxe7LI8EeEbe3ndHLdYh+6LG6JBKoSm5bfyyp/dToE2ybVZsCKbFNtAeQmw911KCw3YwJw+qpBmiNcYjE3Aqo1whGMLE1kuNqxiHX2mpAzdgQLgvq2CFKfaHGKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lltsuS9K; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lltsuS9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768540802; x=1800076802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cvfuyj5vtm69FS3qp34S50CDl09AHW88a0oB3qGJWK0=;
  b=lltsuS9KYAFp8RThn1h50feLJ2606VR4rNqpIPT+I6Tk53YZrSk+yO8n
   +BHTqdoQOlvCo9ZIqE9vCiBOtZNiI87Djc//d9j7C0ovAdvglVS6njBqY
   CC8f0DUBkW8q4OPuA7CeYzE0Gr30tk3jvEnZPW8bfl5WG9OJiWzI9PfrX
   B45lshvr54C7tPpwB4sa/72riOFeiwLmDI5DGz26d7q9xY7uxWFayCN2/
   UjTbuliQ9P0hhBKAMXq7jOJKym0l4BXdwgs1JPwVlTq79yY8CcUYk0AGZ
   BaSM7pm0C9Ro5swax7PmIEqCYnv2BzwiGCibs7teql+C2zXnY67FLtwT8
   w==;
X-CSE-ConnectionGUID: oeMy7xcdTfeeOrMnBcZuWg==
X-CSE-MsgGUID: aisY5eePT9ySO72cCUvbgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80968358"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="80968358"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 21:20:01 -0800
X-CSE-ConnectionGUID: qcIGctXfQSO5cU5xTq8uFw==
X-CSE-MsgGUID: Nv8TtzfuQEyNb9A4xqpdGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="209633158"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 21:20:00 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 21:19:59 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 21:19:59 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 21:19:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhiivG53Dd0dwGbQDqWQtlHc47c/BA52NR9JrSBnHHP3wsmjoG7ZkbKB8oRYYF8GgnQ8blBTUsZQmru+yV86F2iKNWzj23fl19Uxg3Fvv7MtfU0c1NlyRoJJK+VsytnFRukXqV3snA5MZmBWImLkI11qq1KaDQdZgxIofRiCsyPC4CCVlwm9nPNgvf6tGl+D1/oO+LL0CqDQ5nTAdbw9SyAEzxIYUl4MUxQConV7lpjYG0b2/UZctouzsmnMAumxrClUj0sZJZo8KOaqsV8YdjLkehc83Aw3BU/worye0xPIvjBG7IYDC6vUZ5cBVAfMV/FhQ2Kb3iDuxsukQ3J6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmVra+UzO85fXtdLPGos1ajNT3VJoIE6rtpRwVCJ9R0=;
 b=UM6YXJxNXgWeSRpp+mCsjUplEs0Ni9wtRCo1XC6dXYNLZJ82NjH1ddYg4O9u+17i2EIeXO29MslRuXqjcLm2RZKhfyzESmaO4eDNqvo73ThTzBhtn+Nk5jjwdJd5TFzsk9PBti4ZTeET8mJBQKUN+iBfku/0c2cmwXxH196VqmLQf3Ky9uep0j2h5fur05Dhzp2HQ623a1iXLaxDO1HSfo1P+DW/xmusTG5EnTIEip9vmFcY7htdQRutA1L+HDAsB89x5Ma36rT7s6OMM3t7jr0IjDnSLzYyngQjZRFw4iPihWcUIjnKZJ2YpSiusQ+SOrdzmirU+yrPNL662ZlKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB9477.namprd11.prod.outlook.com (2603:10b6:8:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 16 Jan
 2026 05:19:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 05:19:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Dmytro Maluka
	<dmaluka@chromium.org>, Samiullah Khawaja <skhawaja@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
Thread-Topic: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
Thread-Index: AQHchDk4W/6+cv58J0mVdTDrdjg0/7VRR2wwgAFNtACAACpDYIAAfGgAgAEJXlA=
Date: Fri, 16 Jan 2026 05:19:52 +0000
Message-ID: <BN9PR11MB527605C53AD9E8C6C6DCB2498C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276EFACF8AA21215568550F8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <db26b1e3-bd7a-44ee-b458-6cb0fedf6662@linux.intel.com>
 <BN9PR11MB52768CB67C102CFCF562E8248C8CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260115132322.GE961588@nvidia.com>
In-Reply-To: <20260115132322.GE961588@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB9477:EE_
x-ms-office365-filtering-correlation-id: 661567ca-5c50-451e-1e0a-08de54bee0cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?gLsb/615mYXvlGwe9qbQRy76PXwviw9E9TkdYztmq+UXfk18XmxrXUJneHYx?=
 =?us-ascii?Q?pbCT/nm8e1AvfFGzlWVGDrnk6szp9tYNbNMO6W2F1fdD/J1dEDsIZPfu0GPc?=
 =?us-ascii?Q?bj7W1af89dEf4xmegyfn+Dn7/7hJOufL2yrR4kDOWu+cvoxOobeNE46GQx3T?=
 =?us-ascii?Q?PmJ0TjVUbC52ZRya2LOhA/iWX7WJUpMX1PZIgcbppp7h2QXzmufNEyVIFp4+?=
 =?us-ascii?Q?Yuwf7xPGs3T4fIHgtXKyX0Zh6JmSdBNXp/IOY/S46hwDcp7ac/InUAEtIXqV?=
 =?us-ascii?Q?so+J9GtAYr22rXaZHzTIXtxT8sV3Gyx/0yUTOythdmV4W0sQqmnDCwpt+dzp?=
 =?us-ascii?Q?Tf0HbElR3RdGZQjDJ9mWK9xtEOr0NZnWTEI76s+6n4PGU6IdF/jErthz0Pd4?=
 =?us-ascii?Q?9bH571+3g6Tt0jKEJ8KstUyuVEa8FYImduZo95QdYfDmd80KeSTFE2puS/Mi?=
 =?us-ascii?Q?5mtEcMxV6nzu9wc+NMyVX4sqg05bJRdmBN5qhNrQpmxo0iSaGWstyXGPv4P0?=
 =?us-ascii?Q?hSFQO9P5Z1TTp5IotQtnGR6u87pjZXrV8NbhEJDV57Z2VXXsf6vz9S41Uw6Z?=
 =?us-ascii?Q?SW3c8tSEF0ZtZr2pn9vykfr45SV6YZLzWO1P9uod8/DlgAj3JMSwtuBRA1XQ?=
 =?us-ascii?Q?xVh7SBYqXF/ZxhAmd9T9vvx8j0HXeCDWWQg5aqklTVq9PjmA3EANToAF95gD?=
 =?us-ascii?Q?uTBu/GIaz0LZVSoSWIlOAwbz1YzBJew2VI3e5gQTGbMCaQPH7xswWLkaHolt?=
 =?us-ascii?Q?qTmhE+o6eHddAVaR76kWApmdM9TFyPThpLb7JIIIkNnUqpw9ARBcu2pw3iwn?=
 =?us-ascii?Q?eF1cDiP0iuJ8vlACEFnWOLhf14ldV1BQ5Mh757d0dJHWYefQMB49OhZ/pIIc?=
 =?us-ascii?Q?AMtEgCOljbGr1YOQulVx50ENBRANQvpCMznl9/3+yV79bf71Q/innAvZaCYg?=
 =?us-ascii?Q?I/Pz7hrV76YEViq+HO6KEARPGtC6UMYC/gSsPRejVr+pFTtcRNyxyiPP+1El?=
 =?us-ascii?Q?WAfm6+0qxWbgj/ndAlGRq+isXk+mW24lsr9eERdUA3lA/HLB3FIRym0SBEjv?=
 =?us-ascii?Q?RGm2UlgCGGWjRmIn7gqhzITr47ANlcHl7YLXTo8AQlw5BbGcmgipq9rxo0ee?=
 =?us-ascii?Q?SgkjPVGVdN0VbfaMFnZb9d+ahYIw7syPQ95xHaU+FgYiHIz7UuX40qhcObEZ?=
 =?us-ascii?Q?+Nm8IrVB3X3XSBQzpsdxyayDWe2LnscYFjS6gcyAo/WtFiJDaKgYJFXuO7sh?=
 =?us-ascii?Q?hHzaMPA+KR2UNrZT0HI+pO+YsfpY+OsE2sr72tMB0rPRVG9f9YoQzGIfSAzO?=
 =?us-ascii?Q?LZnf/FoIxCRW1RLzx1tvJDNaCwoHblWvGZKarwo7UwoQB4bn53YImJY0gMCe?=
 =?us-ascii?Q?p663rzirwa4tNGdlWWO/ftrpuI3aOcghe8Wn79HsV7kYBeCnUOmRvlWW1mGb?=
 =?us-ascii?Q?B4bzWY77QbSsRtYt65YAOfdPGu7LaLxMW8oR3Fxg9KylQu9wu1z+GsMae9Vm?=
 =?us-ascii?Q?h/cljyIrnlmOLt8taffqvQtRvHKFONHncw9rAki0VCA8u89PMKtylqIm4zGd?=
 =?us-ascii?Q?GkisVtcrXq+/4dhJvar8mJ0aLoZzE4DwzR0+KIw56X1Uu4oLVrt7b8kvd7ga?=
 =?us-ascii?Q?3aYAvHio0DEoiPakwijm5g0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?evyWUEmeGuCet2EZ32ZsQGqu6A7QMwka/mLQ0vxKyK6D8iM3ECg7RVJzj9eg?=
 =?us-ascii?Q?mme7XgM/zPg0SME/S4GGpWX1bSm8252hH0YsN8EqcCjBi+MhUyCUjheM7Jtm?=
 =?us-ascii?Q?qspnzW0lr5BDOw1JgIJ1pSHa6eE/a0GhRfhM2LSfM8OqDPqoVqPn/1sh74BI?=
 =?us-ascii?Q?3/gmT54QVLY49NAJvaKx/OakgDGltd5KP85617jl4eeJxgBDisJPblskx9Bl?=
 =?us-ascii?Q?n4taF1dQmukMl6x4EJ3aB3a/i8lMJjep8utubBOpGXHQ5Vpa7hjMGELlyiTy?=
 =?us-ascii?Q?HCfEN0erpFTSH30yH9X09fl7H4OcWEUp6TSpuDoU02LeI3oshug74kWip4LH?=
 =?us-ascii?Q?QAJ/6t718+uqkRiLkaCD9eqORuo2wrtJ09Mw4EUBjRXDJuEmSKsPMtDb00JU?=
 =?us-ascii?Q?ZM0zs5zKWBQZPYPxkTX14vDvZ4qv7CuRl/CEuGeJWDY8NdDbgEJ/s7Jib8jh?=
 =?us-ascii?Q?PGzjrQ4gFIaAqE6PauvxwWFnIBnnRwhb8Rnw8kdptNp1pKFmZvz/BEm6sRW2?=
 =?us-ascii?Q?2XTF415CF6Bbt9qdxuUpTlIh3hxZUwhJt60Bs6WXVyv1R7s1iXnBkyRLF+L3?=
 =?us-ascii?Q?CAeooInsHwe++TAfP/G+3oyQOUSVdKjoA5K6B0RqX4Hx2nQfJrzI67S2vy5a?=
 =?us-ascii?Q?q6aOLBOGHxZL+qEe3HIdqkH5Ft/z+4Pu85SlJmERMv7fD3VIxkNzJhDNjU23?=
 =?us-ascii?Q?xArvcFUNaqkCT8cqmkWlnaxqVITVz3kMGYlspJ6JzRx5Hjs+OyNuh7LzJ02V?=
 =?us-ascii?Q?rWbKf2dn9cWpnUXcmYyRPNlhoXw1BhtlySN4uuNShkUhb0sYTtG1BV+CLqB0?=
 =?us-ascii?Q?/wUu8A3YR3Zh9OCVCHW1oo44cc8Fd3W7AIfi4PvBKsJWaZfy+IzG4rDDqPoc?=
 =?us-ascii?Q?gPl+VkODvdLOo1L3kf8N0XPabpAzMmQlxrMsRM2QVJ0uSHCSa8FXGk5odbcQ?=
 =?us-ascii?Q?e6GFcIs8Rm9/zAnEn8x3cpzahbcfqgKERE1578iZL0ocMRqH2TOGHSEXZTLs?=
 =?us-ascii?Q?eNsGei4cy+2D54BOHWPUFULlvBOrPX4c+YNSuUFjbxbMYp1NGnsC5WDeOtF1?=
 =?us-ascii?Q?Z8GSiPPpptGlFWn9Cz6gAN6TiYToV9CqSetJwA/0zG3CouEakMLklPuxmPc/?=
 =?us-ascii?Q?OYhO22T9W/70i+vl8/e6eAr/VZncnW4GmkdBKOLs3JWmbdRoPrHBqfK40+eT?=
 =?us-ascii?Q?/isOPFE9DcEbWd0o2+eSyjH4S+F2l4GiJOZSMuP9c7lY2UJMMFsdYYIx9fu5?=
 =?us-ascii?Q?1W36y1mqUz5/bMu3Xdx35979suieon33yedERQZ2x9ZZiA4DkOYUDGA9Fs7+?=
 =?us-ascii?Q?xXxPRiywl6aAn8fWZ5fUNHJcltNYyDHz2GhLTMWIu1TWE/Mqll+HXQa4uKvm?=
 =?us-ascii?Q?LbjxSDejwHtYuV3L97LVWKlyoM8tW+RXCQJVLJKKCPOO5hne6CFEgXXr10TO?=
 =?us-ascii?Q?Am9kwufTTMexGJ48NB9n7TQ0alz6PLLfRYJEKZ2agaaATG7hM6HgrblA7NOa?=
 =?us-ascii?Q?MsJA+gZYUHz5YiZra0/uVvmKnHdmca60rdbMGHoaaQdPO7pCbFf+dbXbNs5J?=
 =?us-ascii?Q?OTePTgBGWdz+BU+HXNdwk295G0Vuc+m7ci+Lmp4zmNkSvcd8S+BRGv9lbz0J?=
 =?us-ascii?Q?cGe6H0AgFVSI+7E3vIrJHpJ30hTUPRgceqsINzaF8NDN66yAThsKUtdKpx4H?=
 =?us-ascii?Q?GzQf7S+tmR4EOuTai77GGIqKvecufOM7L8q/xjQwRu8GIloFrgQNzHu1ZSKK?=
 =?us-ascii?Q?5j2Fsd4Mww=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 661567ca-5c50-451e-1e0a-08de54bee0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 05:19:52.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/9qvP4zc35ju09oCCb195ZF5zF0mW3Y29bkZwSPBxRnWM/yo+DclsxGSWCIamfS5cUAX31Cvnfz9DSaqIqcWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9477
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, January 15, 2026 9:23 PM
>=20
> On Thu, Jan 15, 2026 at 05:59:56AM +0000, Tian, Kevin wrote:
> > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > Sent: Thursday, January 15, 2026 11:27 AM
> > >
> > > On 1/14/26 15:54, Tian, Kevin wrote:
> > > >
> > > > Then this may be split into three patches:
> > > >
> > > > - change context_clear_entry() to be atomic, to fix the teardown pa=
th
> > > > - add present bit check in other functions in this patch, to scruti=
nize the
> > > >    attach path
> > > > - change those functions to be atomic, as a clean up
> > >
> > > Perhaps this also paves the way for enabling hitless replace in the
> > > attach_dev path?
> > >
> >
> > I didn't get it. attach/replace are different paths and iommu core will
> > reject an attach request for a device which is already attached...
>=20
> From a driver perspective there should be no such thing as
> repalce. vt-d has gone wrong by having special replace flows inside
> itself.
>=20
> Drivers do attach and should try to make it hitless, that's it.

Agree

>=20
> Meaning drivers do the whole attach sequence in a robust way:
>  - Manage invalidation lists so that old/new domains continue to
>    generate invalidations while transitioning
>  - Updating HW data structures without making them non-present
>  - Managing ATS enable/disable in the right order
>=20
> It is alot to think about, but if you follow the ARM sequence it is
> all written out there..
>=20
> So this series should be about the 2nd one, making HW updates go from
> something on the stack to something in the HW, and if Balou is going
> to use entry_set then use entry_set for *everything* and it will deal
> with things like using the 128 bit store or making things non-present
> temporarily. Even if the thing has only 128 bits used you may as well
> stick with it.
>=20
> Remember also that the 128 bit store is a CPU optional feature. AMD
> investigated and found all their CPUs with IOMMUs have the store
> feature so they could use it unconditionally (IIRC they check at
> driver probe and fail probe without 128 bit store). VTD needs to do
> the same thing, and if 128 bit store is actually sometimes not
> available it needs to fall back to the 64 bit entry set, for
> eveything.
>=20

We are checking that...=20

btw the way that VT-d spec describes it as "software MUST use
128bit..." highly suggest that it's either as AMD or with exception
only on very early generations. Another exception is VM which
may have hardware supporting 128bit but vcpu model doesn't,
but I doubt it's a meaningful configuration nowadays...
