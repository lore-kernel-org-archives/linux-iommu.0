Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55716801
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736918260; cv=fail; b=vEWvphMJpjTral+QPq/8AsJJNzTeWdBEqanwxLesSFI32LbZ6MrzE0DZeJnJ0ygiZLmtV2fX/lyHq0Mb2uJsxWUU6nKlqQhdAYh94nsCJCOBuEuu5pIAO6oqkJpWQHqKh8XxRcNjgt89MHkc0+90eXLxNttb/3IeZz5KDvw+YjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736918260; c=relaxed/simple;
	bh=HHTrdcHTKl6reAv9p07xmJkPktzHDq4oRDhAEPHItl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KRbKNxZ3dSbo8IaMftEXHrrqyDemG33G7MH9a6D/p800U5gLd5ZGk8SY5GqB0ceVzAPqOBxrkSs4ZWil/41fWMOXBeK+y81A86/80iwcrCUGkZj+w7Q+MEDs9erx+U4lPlstFWxjFTqxMcoaMpiBwPbIHTTSpzEFgVVGCNTQof0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lzfm5gX1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lzfm5gX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736918258; x=1768454258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HHTrdcHTKl6reAv9p07xmJkPktzHDq4oRDhAEPHItl0=;
  b=Lzfm5gX1YBeHlDPqe2PGEaKZyFvcjNjEjLRVH62I98b7apnLvvRl0T/J
   I8FMWSPBDSVaLMSeQZdfU4g3zL48UiSKnvQ6+1S58X4K9pEG8+WzFGf7a
   aDlGLFsUr/GNUqj4CYMVXmhVH37JBtfvQzOys+HlM9ttE05uimTGh6TlT
   syKHdwHt7WU0QbQ07cNxCjn/Cq39LnVziLLvo/2wotz+g/2b7wtUtAUs2
   qSH4xiMSSahRsRiBg6IMQHM3poqHToQqM3hnrFbHF6YB6/YpYAS9wZIqQ
   FjQV8s5gifwsGtg05Kxm8r8haywIny06gOXWKzYMTe5OGecZN/twlgOaA
   g==;
X-CSE-ConnectionGUID: dDuCbED+RZG2D+nDhjpKBg==
X-CSE-MsgGUID: 1KMfDM8gQxSK+THbAJphMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36517487"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="36517487"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 21:17:38 -0800
X-CSE-ConnectionGUID: iYZWmtGzS5iL2BFiXxvhDA==
X-CSE-MsgGUID: p0IHU0CASRGZJwdR6a7f/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109084646"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 21:17:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 21:17:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 21:17:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 21:17:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aismAjrArcGBtVIdE8eTPqh0p2U/GmKT5LWZYSyFE47qaR14+uJ0x7J0CEbqi8qUoTfz4oyz5qk1EZ6uQ24+PLLotVRLKcYDnjXGKsJb/ELvqV41+rdm07qGCTTHJnuGgzj690uygqwbbaqY2o/aRV228hVEHzL5nCmC+Ccva4cxNm0D6Ox6uIwlvm0tJpEzjVSYeb1raR1U8/uxBeZn8FtKBx9oZ224ByNAkPBql7BajGe7cMFV9fCV2FJSD/KrucKmiVKllg4AxR3P0iCmGZQn3II7acZZfRvEfDyELFzNK7w5fiBn/6xtjhALR4VvRWru8qaQ1XazQOt6v2kNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHTrdcHTKl6reAv9p07xmJkPktzHDq4oRDhAEPHItl0=;
 b=dKQJAbABooa5eeXC6kdvF3q3jQMV5Ju0IwBW2jVp1NmIh7hKo+DG7ai9sRm4RHcJ6N3KDxc1OvpdfZlud7Dm0BRE/QXdGiYZywBjopYr2++W2hxMZhsOtrggN94nyPhrD69GglRc/tWpBZZ6Y8QDiB72mwZiMD+MkPfESCqRlu2jQAOApPcx9Sf+gt/bvcvc/eSRvHNTTWhXoZ+g37wXJAN/tjpVBdpfPTX1EyYhhMzg36K2ecclufC+WAPXSOi4AjJ3YlYyxI63gbs4v6bzarNtGL91oZgXd/cfQ72d8dxhD1RuM6ykl/vhRMXadVxJKmCNX8vA/MJGVIxCShpU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8372.namprd11.prod.outlook.com (2603:10b6:a03:539::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 05:17:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 05:17:30 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: [PATCH rc 1/2] iommufd/fault: Destroy response and mutex in
 iommufd_fault_destroy()
Thread-Topic: [PATCH rc 1/2] iommufd/fault: Destroy response and mutex in
 iommufd_fault_destroy()
Thread-Index: AQHbZtwmK07Bph2oGEiN8YvlkvuBKrMXS7lA
Date: Wed, 15 Jan 2025 05:17:30 +0000
Message-ID: <BN9PR11MB527678EBB1405D5BBDFFE1A68C192@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1736894696.git.nicolinc@nvidia.com>
 <5e78ecaa3f731c782785de7b1aa5cc535f3cb0a1.1736894696.git.nicolinc@nvidia.com>
In-Reply-To: <5e78ecaa3f731c782785de7b1aa5cc535f3cb0a1.1736894696.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8372:EE_
x-ms-office365-filtering-correlation-id: 5ccc0cb3-c817-4b38-c78c-08dd3523e8b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gtgJ53rjK1blTGSD1U0AAEDAVaXdE/h70Ydd8qlXkvf0WmPa/O4YPohlZ81e?=
 =?us-ascii?Q?FofCPw+p8ne2fQMnIX1UeaL/NIcmms6srumN3bN4vd/vwnb9tvbRKR+wBUQo?=
 =?us-ascii?Q?xbANZyiKBHJ/2utYok73afd1zELAvINjifQPBqoVGapcgsom3VcqvBncqw5C?=
 =?us-ascii?Q?Maz7qgj8bfLhIQAQ9rYlDX35OrJN9glqbKKuWiXj3k97sdbAxUKNwY/btwll?=
 =?us-ascii?Q?Kxtx70IP28a8a2YFl7jOxyJ6Rs/dTBMM90V3RMgGt4hGjLFnpQkyCrDwwlU2?=
 =?us-ascii?Q?4w7VyQhcPYtgVqVW/OdkmEQDmFuZOfxRxVvl8HppIPXj7kjtS4yDajqW3MsA?=
 =?us-ascii?Q?nBgUU1XIp6M7QSSXTsjZ5ZHrdiVy32qJV6ABI+O5ONCIvYO8OIJug3yctpte?=
 =?us-ascii?Q?OB9Vud4piof7tOjSZBrPhvtQOWqvftjyuX6+RDOh+j+hK+V2E/W5CX858968?=
 =?us-ascii?Q?Vjwn6jj1z/AuH6/rqSILmR5t9Tem1GwqWVVCffTfws+qX8xz1aJk4ukvfH7/?=
 =?us-ascii?Q?FYp438FM4F05R4YoyRbNNrKvHkWGBYr6AKdk5IWEdR8faf3g5BpqA6VIFibz?=
 =?us-ascii?Q?d1Nj2e0Vpylw7VVGUx6A2f53KwXN3RHIuUYTSb32rLXRqrZ8ZQzs9jaJgjFe?=
 =?us-ascii?Q?485f3nho3xREC0nYuXdOp/vZPL5VWNSlhjsxXp3l7SWiKU7AhBvYrTPjbrbk?=
 =?us-ascii?Q?06kWZCEaNKp6Ul5u++UEtZZhc+xF5Zi8AxUumIJ8KUo4yMhlSUyqZgfsBvGg?=
 =?us-ascii?Q?pSzLW2LKdmPDytZjmAQdzD0zSYyVVpAFxVVokxqTF+8llOnevg/9TPCVmb81?=
 =?us-ascii?Q?5TKQK43m/IygnsrWh6MMrIZImdT0qVapEoe2gM4vG3brf2t9DM7I9BqA32oe?=
 =?us-ascii?Q?5J3SuQfsW650GyKKCH1MbxGYWJamDl+Z6CzGeKfviULbsbkna+brR+sxVRHv?=
 =?us-ascii?Q?98Xc0rFOKX0TItH2dk/rEL+BnGGE+t+Nf3QF1krUhmpytTNgmSuttMFGnbRJ?=
 =?us-ascii?Q?K5wk+oPhn4ugmJcMOJw7CQxvNsYVcMjD4ZpANnU+3AGTxeR/g72jcyQLjm3i?=
 =?us-ascii?Q?QcVJxSguImyFNxhqcoR1W6OOrhF6hGrpzQ5HYfnUooBXma2ZU5fMrg3AhBd7?=
 =?us-ascii?Q?S8C6jI6TX1v3/EWFBtIL3sQ1pRp+fymmUDZ9HHGlgw4aSeCYl5ntqTEyGG8B?=
 =?us-ascii?Q?5mmzrL3fdz6UR/1i8MHFDykURfioJ4bMDflQLEHmHEXywbguib/n5AT0Vdos?=
 =?us-ascii?Q?medeMYQG00ZD+OJuY/vq/AeytNy9gxR2EMpVCTqT4TNdba8zzLtEjC7qDF6z?=
 =?us-ascii?Q?p/FxIBmZ5IqByvHbYSOPOqK5enUn7JbIkjs/4GLcMsKxEfoHoDtxaEtjOYHq?=
 =?us-ascii?Q?/3cStSeiLIZnyxvZHiaGIMpocJH+S8mJiMpI+N6nMFlUDLnO4SHrqi7AMwxr?=
 =?us-ascii?Q?9gTwsEGbQYNQCxyvAryHzLMbHx08cvY3?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EfLGTK95AvKQAuaj9+8OERIoOOvxvGKwZ3WJRPMhpLBDbcL1VjbaAzhp5X4s?=
 =?us-ascii?Q?xkLsDWsfAEU2fJObpXh4MhqsnM7ipnVnKc2MInGBeE40sNG5Q4L2bvynxrX4?=
 =?us-ascii?Q?zQ/twHV9aVZv1zmSjZvwgSvV6wInldlnTI18bNzPXcmsGGEGMqSMFiHKMn93?=
 =?us-ascii?Q?JPRWLhW2KFhRocZoQwgtaKRbDL0/DPyGzrwRMoIJY43Xh8uYLJZTMH2DUCrj?=
 =?us-ascii?Q?KkRZIIXnBqOspOnrrdwd9KHka3jYJVzDEfQAgrgghauX/0vviaS5xuQqKHEs?=
 =?us-ascii?Q?5Jyc0W4fYRtrf37+oln99eTXreQgteRzIYd2vBABtgxlWdjqr/mCC7dYJ3Dd?=
 =?us-ascii?Q?EUyiWwMVYq2ZfJ/UdPlvR0fbhKHlKsvsszlUrGe2pdHlKVvAGKulrQ5nn2iE?=
 =?us-ascii?Q?2QBqgcjzmpiJ/xuMN3zzjiA/A8FMjQ42FTBXLhmhnpsaEEFswouAIqVm8SMT?=
 =?us-ascii?Q?0cxiJIp8YZgKws5DNQMIV8nbzAob3k6IBwrRZ2bACB1hDb6Ef1LuluuTOtJZ?=
 =?us-ascii?Q?NyyGRQYH1+0zBuDlM65BaLihNvhglYxeor059E3p/cmvpjfdMotvgvcK07gH?=
 =?us-ascii?Q?LQq3MJ+1V+6gqc7Ux2iF14fb0W24RVcKVOAZyCcOARYM7NLroTBTE+9OCDJO?=
 =?us-ascii?Q?Dysynxxs8q9ouZ7Y+Ru1bAuXoV++RbHcpAC+sNkeEvjjpRMgA9zjdywYFAr6?=
 =?us-ascii?Q?+Se8D7LRrYxZW44V2xZyEG2j/Qi8qBOwkyhwsKWY+7DMKqGP4OPu2afqerJF?=
 =?us-ascii?Q?V7XIxb4y/19p26QFyMMQUwchJpAD6cpB3bo4FvdwLrzWv+nAE8fSK+q8bjcH?=
 =?us-ascii?Q?dakrE+CBGxbRvNjzkW8K1cBV864oBUsOX7VsN7mexoYyw0Y7gGEurFPg1en/?=
 =?us-ascii?Q?rovu/q+YivfpgA7kAj3nj5BaaXhfRDnQ+FUToY0JV7vHWX93REYP7pQstH8L?=
 =?us-ascii?Q?w00l+dus3ZLN6jtxVMpZXI0f0eEk5Sa8yTXAk0QCcNehWrNX1Hb8cE+/025t?=
 =?us-ascii?Q?xvPJu/rsuczBahSu8B/QnptPuSf6qOXM+PjWd4CsppLDZXTucUabe/0kMnG2?=
 =?us-ascii?Q?QB5ejfGXcOk4y/K6QzElxrrok3jVedR1YQVfYDDc2Tkc6VDE7Fgjb6T1zMU1?=
 =?us-ascii?Q?SrdzETsY+OvksWsE/Xn3eWFG1Gp2K2p9zM692eWdMN7OY3ggsKBCqEKBcm6j?=
 =?us-ascii?Q?1Y4O4w7XEZ4edhBcSolj9arA5IV7HKSB7rn5VBZF8Dafxfs7sKohnI0VLZiy?=
 =?us-ascii?Q?lVGuheRSh+B5hoYRDnCM7XjJ42NJUl5SiBYZhwN102WmQ/DEtGxAX/YZEesX?=
 =?us-ascii?Q?0AozETvMx7L0Nr2CgjjvBdTzSFM9JCQm4HztW2ibPi+sjqwaaIVJKg9fKO5l?=
 =?us-ascii?Q?6rhm2M1PWcUh+viVJQPyV41UMbLyfRvnHIAJD4BY5cNaR7VNigQmykw8ZI/h?=
 =?us-ascii?Q?nKYfCyCDrNPQEYXWWufHF+MvoK9ZHHWD6hdaN2TWVYTvMdeZfKonGitYXMv3?=
 =?us-ascii?Q?g58TlWuiIS9WgxseZWgHV9DjpBXjdx0yTrQ3i2emOSBO/QQbTJXdTPlD7420?=
 =?us-ascii?Q?9S5eTJeoRdJkKwvcx7smL8gHyMYiIz/CTpDoJEkz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccc0cb3-c817-4b38-c78c-08dd3523e8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 05:17:30.0406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKlFyAK20dmACrmOGqxPK932yvNDNxS1nS+liBKOrC2yGeXg+yKElCxNfASs+zVbPrMT4X0VnBo8yWfxPROghA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8372
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, January 15, 2025 7:29 AM
>=20
> Both were missing in the initial patch.
>=20
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
