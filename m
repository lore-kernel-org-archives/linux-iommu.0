Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277302D46B1
	for <iommu@lists.linux.dev>; Fri, 12 Sep 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664849; cv=fail; b=jMm+oHml7Gl8W1ZbReRukqYJtbFiJ1BY1aIUCJth/Zb1YZ4kZ7z7esYV/As1jq3arHLcpqWmHwMrXgSXNa0fPOJl/P9pqd+iG35pqqNcwQXdjUXNP4yUZR5iE9Wge2BS+yNMzt8AthokGCa4+cjvrq+nZviufHGARkO+DGpuJ64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664849; c=relaxed/simple;
	bh=dJQIAC2g/l0wjDgLlnnYfcnFgdv0mJsusvVM2fKpwbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DXBrOA4gJxkWzRgkH0o6hs+dQOvNdBQXsQ3ICQdfepGCXFKMO+Yye9cZKCbaZvFgD2jRlNBpbQsaVwJ33CJcWsrB1TqzIXEO0W0XSr7dCfYJYB1Jz7P62ijyTzh2i/yrIbLOcwtQTkLRsjihc2O1wXzt/8hB9itcRA/ehnRhsW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QExhu0PH; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QExhu0PH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757664848; x=1789200848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dJQIAC2g/l0wjDgLlnnYfcnFgdv0mJsusvVM2fKpwbE=;
  b=QExhu0PHzO0ZSOjvoIOTMuYIs+vVcv3Ycp9v+5HVWo1uesHyLbnUifVj
   uglx3RMDeZ2auDTTqxpB5mNl25gf4dn1B7N3Ra5N5r7zb2D6DFOF8tSNb
   f81rv1P8WiT1huYEJqmcMxQ/KIFV2bu/bSMGLOqiU61xTXpt3uTbAXymQ
   qqngzI37ph1I1nEBb5NNCtuxAnQp7FFpMA08AwuUD7PM1NFBGC/eQ1+Hc
   9BawaBm79ELhmHEtzxL4+SWHehevVT8ibaiYvHy8hMAJ96RdkLI7iUpZC
   v7DIiBRgat024Hz98tpa7/7UVUZiv6CNllECT2qttuhZaLu+CXyNEll65
   A==;
X-CSE-ConnectionGUID: oMqbDf5FQGKYnf3GtiMybw==
X-CSE-MsgGUID: liG11gTDTHGxSQR1Mej8Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="62637828"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="62637828"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:14:07 -0700
X-CSE-ConnectionGUID: owjNK39tQFOFHTU81dB3cw==
X-CSE-MsgGUID: 9qiHKHRSSOGh+3TJkB8KCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="204906980"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:14:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 01:14:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 01:14:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 01:14:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgMuEW5eceq6ohrXiIr0J9GEH5QLGlJjoc9IuVisR/wTN9Xg48+A6izkx5czJPvX+iExbq3E+4kT1phq03dOX3uuI9p4g7cJmwDGBI75vl5jSHtH7AOCvvds2JKoe8hQ7T0rMemqRIWdyZ6/urtRLm1ihIBUXFsOM9hsAUjDq1YTtZtJh9IN5uu06XAyycCp3dTB+vqK7X1la9HZwtyrczNa/5WAOGaoU6Zh8q5SghbSjXPDSnUA/0udH/ugzbQXbnZeHigSC19ns2Gmpynktw1kW8FWZsG7UPYKZFy+0Izu49Alx77bkHb7ziZbXO5B/j/ei5ts22h5qFksGV4r0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJQIAC2g/l0wjDgLlnnYfcnFgdv0mJsusvVM2fKpwbE=;
 b=Fv844O1jYk4VmDwIMVUdCrmrK7aY0s1/T2BCwf9aF/xJIotpI8BKgCzkgB7Lu4yUqdgvYejLzRp4rormN85wAqT/TywoHscH22t6vfa7FC5fDbwQauOdCflG/VaK2VW+CRwLQ4IvtqqofJbBbHqzbfo94Bj2Lrz9NhZwuwJqZGKoss9fmAbWPJPMixISM8Szj3xISlRMGs3cAwm3TMH/nJc63s2aa4eKlc7drQDA/sHDRw02CzUYR1F9O1pJgEnntQzxn/3aejhAVuwWUaAKHoT0ffZzdlBXBBx1kSyVFda2VtEDfvauD9iV5Gc4tICR4ZRZ+QqrMRSucJegWcpVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DS0PR11MB9503.namprd11.prod.outlook.com (2603:10b6:8:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 08:14:04 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 08:14:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jann Horn <jannh@google.com>, Vasant Hegde
	<vasant.hegde@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Alistair
 Popple" <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v4 6/8] mm: Introduce deferred freeing for kernel page
 tables
Thread-Topic: [PATCH v4 6/8] mm: Introduce deferred freeing for kernel page
 tables
Thread-Index: AQHcHil0+WjIl5Nj6UekRoJQglk8lrSPPRpA
Date: Fri, 12 Sep 2025 08:14:04 +0000
Message-ID: <BL1PR11MB52719E654E5AE227FE29B75F8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-7-baolu.lu@linux.intel.com>
In-Reply-To: <20250905055103.3821518-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DS0PR11MB9503:EE_
x-ms-office365-filtering-correlation-id: 7dd3b96a-e30d-488b-5daa-08ddf1d45697
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?BzsunJQh2PK2faDJIIvjp+oOWRhztcv6HT3EOPh5gM6msB66eo23wbx0EUeg?=
 =?us-ascii?Q?FB1hZ4Ni3hehdAfFzwhBNlw5zx8bTs50mTZFmlT2Ixo2198xFdaAzhd4n48R?=
 =?us-ascii?Q?EiiEE527kKonfipNtW/Zg9PYXrD5pPbXeCj8r+JMB5Y045XrU5PXX1KPV3t7?=
 =?us-ascii?Q?hqQUQRYpQVkWHDYFQhYkL1wFqyZaZ6VNy64dIBT/oHmnlXI3RVI4M8t57JtG?=
 =?us-ascii?Q?bhfAX0g2J0f9RDAbWLL5dGepnwR13TVuqls3EG4YvFidPG46X0zC8TINwxes?=
 =?us-ascii?Q?Nww7BTJKkIbD3G3gkIjeooGExdRMyx6jBHBDpcznPOGD6/hjC616lT369XRi?=
 =?us-ascii?Q?4x8CiclfTX95CdqpYwkWn5FiQWKIcZ2iwG4JEpu6befrWmiWHpLbD7uZuz7i?=
 =?us-ascii?Q?gLTnKNibHcPsvSLij6ERYCITk6IMstc9L6WAthc0J8jXR+iXGSauL8pz5O/u?=
 =?us-ascii?Q?sU3qlaWWp/AiJcsrpu/hBZjTruA0EzcwN2E6yC6TdbIk06WN8wUDDxiUB0Pk?=
 =?us-ascii?Q?P05eO1+cYle0vOkxDWs0K88S4OsOZsey7BDuvLzaIG1335FlXiTvwb1qHALF?=
 =?us-ascii?Q?g7yD9dGruAAmvp9VpnrPgLghOPlI3d+LPR1bsPgtFH6ZPrdbi95y/cYzTalv?=
 =?us-ascii?Q?6JS6IB/wWuOg+8METByPIxT3gjlKqAxXNTX4LwH5VRduF2yz8ZvTO1YcfWff?=
 =?us-ascii?Q?JAnYQjzwO4jERAiRyweCVU8wPZtsAkgqlc2Je5Avlo7lW8XXpb5KSzb+jTup?=
 =?us-ascii?Q?MnZqGxCwxvCwNopj3bIuJHuvCbqdn99w+JaiBEPoxiZRsvUAYnCYHC8pcvdT?=
 =?us-ascii?Q?7euPoryErF7DhQMNSpGZnp+Zpszu5b3l/o7j8TSHOoY88tgZjIJ5Rq9om3sb?=
 =?us-ascii?Q?0COlIJI5Mp28531ClZG7ig2xez6LqCKGju8QQelQsg5SNTaZ2p/0ttD2ZyqP?=
 =?us-ascii?Q?flczyOaP4sdOenSqLRZPqN2K3HFMKnVjUc/yErmNeA8tRXJE4bYy1dqDAmQB?=
 =?us-ascii?Q?NElMc5YW5/Q7DHqkGsjFlNX484FgRk5Y2TsEvQZYE5bYbIaN2DfrkA7m82Cw?=
 =?us-ascii?Q?Bgoi/ZqiGcGVT7eNX0YIo+ll5tHx8jEe/Rpuda+d5nElUz+evSR/9knLI+yg?=
 =?us-ascii?Q?E/r6GbDUflpNlTZ6LtCFdp8lQm2kfCcc0bgceBFHqhUAjnQTvwfPtVDbOHgf?=
 =?us-ascii?Q?oMoM+FbUzmVDHWbeWaRTgiVGYIKzQq84c5yywHQl6LWHRf/B7q4X2bAqn901?=
 =?us-ascii?Q?qqGR6gTt7AQmvI6KDao9eIG33O2nP+jWaSQy42IHtsWhB6MWjHnBRHPlwI/e?=
 =?us-ascii?Q?2+00+BiZI8xQXnXTgv7VIyxpHCgHD/JfDBc8GgOG8XE/ZLZ/EfWA0DrbwewE?=
 =?us-ascii?Q?1ZoQa7udQmaIwNczgBCyw8veAKSIyp8WOelvqzPJ2FGRi8qAlFcrTb3QjusA?=
 =?us-ascii?Q?VTRmtvHmeGpfRdInIeg9BAFbMkpuA9VBCH8oVyXxiZlEV6vACAk2OlmZOIC0?=
 =?us-ascii?Q?BsrAU2pH3scaRdc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0LlZ+22BqBhyl3ir3leLL3oA4xXqZLr5J6MzB2sWfvMXcfaY2+mdZSReAfoo?=
 =?us-ascii?Q?t11/77gcX/izm2EprrfmYkoATU8yU7Ho+shU8PTtFboSqmklM9NMs+SItFlL?=
 =?us-ascii?Q?AxkKamIyt/sZUPI5597b5U2ctmKRx0e3TMGb7h30G73XA6IRVks+V+iQe92e?=
 =?us-ascii?Q?I+k1SjnjvCzz2nsnNQNxkWuoCgfzbdZOri0aFXPXkgVO8gvfNSJdCfs88iV6?=
 =?us-ascii?Q?viJfGX7NBiIbJzyd9PUeV4z69BhSVoEvjgeP3ZOXzH0H86v1HTYp9Wka5GAZ?=
 =?us-ascii?Q?17VBlcwlTqzLB+RvqwkPe6sWqeYAeibQYejLduNMBJJmhhUVHF/kwGccRpnc?=
 =?us-ascii?Q?Nxbw1uUUv0hxIMb8NDjoNtyJ2T5WMOA0Ih2VL+cM6HoYIxWrcq2QAcruTtzt?=
 =?us-ascii?Q?3CF4mWhwUv6+1GfFSrhxKvsCIUx6WAq3hi1k9urz39g26ht3m1eFXpskBfk7?=
 =?us-ascii?Q?ONA1Ru24aCC81idOac19S8UkLXcdc6sRG2ypBWBZ2AqonWHd758hiz7CEdJX?=
 =?us-ascii?Q?0F0hMrEprISW86jqFbKbe6Ic0IynhKvkZ3gqKrK03LaY3EbgI4tVjEwpfsWp?=
 =?us-ascii?Q?0QAVMJYFAwtZiEsjq7aMEN1jrNQZlqunArwxs+i92rfEABRPdOlULPpo3Zg2?=
 =?us-ascii?Q?oI7s1NEYzcqP4c5KnKfWvrHGI5GHd3RE68FSBp8PDNvFCFzBSBKiDZxbWbYv?=
 =?us-ascii?Q?r880yn7BCF1fBr2AI89NjSXQAShpLexOxWzpQWvoCncRFnR1EX3nXOUsooic?=
 =?us-ascii?Q?JLxg/HjAaU+RQoNhNg6uY1jJ/TiEzCfdPfUg0zTTeeGnF9pknrAhgY0HYoHf?=
 =?us-ascii?Q?FCA289TRK5I+k5u8lRnVTZNvx46n0S7KavNno6KBHQoajyjrJvphdtDQtMhf?=
 =?us-ascii?Q?8bkD5wwH3+aF2QhcsKFCeg12rlPhQGGtnOGyCPvC0XQg9c/96N6/I9+ycOwy?=
 =?us-ascii?Q?dkThJUC2oOtyDx63OjeIGV8DXavuMzMwnT37fCmhdedsL6WXUpyTsCE0E7li?=
 =?us-ascii?Q?houP4HVSOpVsqg0RbqsF1AkPzQJKsQZmvBnQvFASupN8G2cq2qjqZ+Y4lbLk?=
 =?us-ascii?Q?3zh6Q6Po7h5nZXTbF2wX6jtYTB1+9Byh5/hQZbrh5zPpwqKw3CmQXKLN5NGW?=
 =?us-ascii?Q?PI4F2VZU02eI3kSNcmdSY5iqHh2YcSISdyP58isfHHv+5461J5t1naC0dghG?=
 =?us-ascii?Q?oPmnm5iC4nr8Ow9Ye0PBxBCa63cpymDoGlH/o9roih4tFgHyI873NaStJOi8?=
 =?us-ascii?Q?NNCXxLagp+Jrq6BWJCPyVrBJUWEk50yxzIXO6aQTws/Gv4eER+5QFVplXp+p?=
 =?us-ascii?Q?00Xz9L2vL/WH3kORG6xnXppEJcxRnOJ8rl5KfT4grCKYesrAjxiOXU4ttrrY?=
 =?us-ascii?Q?H4T4s7Oa9JnR/nVgR8abNd/4OEjGTmaQ7FzFUHLE9J2Sc8jULwfBjT8l4J6H?=
 =?us-ascii?Q?JJ1TmD+JtIj76eocAJfrBf7CYugl0zrcOC31C1WFhfnBrkbC5k62kIRLKDlF?=
 =?us-ascii?Q?/GSEIe5MmsZEeKTTCe0tUapHnutSp1HkDFf/5nqUyKIOtmAqdIwF2saUt7zz?=
 =?us-ascii?Q?hAXhOJJ2hZDMgrgumqustPosgZ2i3KhrBkB2CPIO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd3b96a-e30d-488b-5daa-08ddf1d45697
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 08:14:04.3992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KkorWwJ8O3ivKtEdmm297eAxUG0KoBTSPvhcDznnx1pCtFXh/awrm5vHfEl64Uucox0eAOTMnpawE0TUnQvBsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9503
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, September 5, 2025 1:51 PM
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> On x86 and other architectures that map the kernel's virtual address spac=
e
> into the upper portion of every process's page table, the IOMMU's paging
> structure caches can become stale when the CPU page table is shared with
> IOMMU in the Shared Virtual Address (SVA) context. This occurs when a pag=
e
> used for the kernel's page tables is freed and reused without the IOMMU
> being notified.
>=20
> While the IOMMU driver is notified of changes to user virtual address
> mappings, there is no similar notification mechanism for kernel page
> table changes. This can lead to data corruption or system instability
> when Shared Virtual Address (SVA) is enabled, as the IOMMU's internal
> caches may retain stale entries for kernel virtual addresses.

above could be saved to the last patch.

>=20
> This introduces a conditional asynchronous mechanism, enabled by
> CONFIG_ASYNC_PGTABLE_FREE. When enabled, this mechanism defers the
> freeing
> of pages that are used as page tables for kernel address mappings. These
> pages are now queued to a work struct instead of being freed immediately.
>=20
> This deferred freeing provides a safe context for a future patch to add
> an IOMMU-specific callback, which might be expensive on large-scale
> systems. This ensures the necessary IOMMU cache invalidation is performed
> before the page is finally returned to the page allocator outside of any
> critical, non-sleepable path.
>=20
> In the current kernel, some page table pages are allocated with an
> associated struct ptdesc, while others are not. Those without a ptdesc ar=
e
> freed using free_pages() and its variants, which bypasses the destructor
> that pagetable_dtor_free() would run. While the long-term plan is to
> convert all page table pages to use struct ptdesc, this uses a temporary
> flag within ptdesc to indicate whether a page needs a destructor,
> considering that this aims to fix a potential security issue in IOMMU SVA=
.
> The flag and its associated logic can be removed once the conversion is
> complete.

stale comment?

>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
