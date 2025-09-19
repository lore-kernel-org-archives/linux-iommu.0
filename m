Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4E2E7162
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269911; cv=fail; b=XdR2w//myUyzm+HGRKmGcL/WkB0EKy8z8WKT+7SMuYlPrSoHuUSiCazGlKo3BjQc2urnu1O6iuzRgkXxrMZ++2sleOZnPagfcNkI6ommKM+3Rq4KBQa15kJflTydVqoZHE0kgvjKx7AchIGKlDyvC7tMVA0goZYoq2rB2/ya5gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269911; c=relaxed/simple;
	bh=mCVu4ecuIvB+gYt8xz3dj94PLRmu9U5kcVsSngTfrKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eOdjCXtijRYd4GN68bV8NGdlBUqAo/G1yjS3NgTA3+qMygQN2yRpMMsHBbfz0USZ9TDXhW8DJ4KRRx9bIGufNIw04ZfvFOm0mrHVj6ZwLvn4mE5Rkr2TJNRxsvZ3sBZDxHOT9rqF72ViiD2BUOOfp5VphR+g80nZjlMxXaHKX3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2ID6qQ2; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2ID6qQ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758269910; x=1789805910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mCVu4ecuIvB+gYt8xz3dj94PLRmu9U5kcVsSngTfrKs=;
  b=c2ID6qQ2KU6ABAQCRYHb1GPJjZrT4QBqfJfroNeDsySjA3JdlCsRxy/K
   KwK8iAhf3Fah2qi05nix1JWhOrFt0834hFRj23cBIHfog+wNYd4EL+qU3
   /zofTlc767YFdPLYVrNRquJuoQWtgBODfGTXQuz0Mroja3ixcn2PYBZAr
   mRnFG33hg08XqEPJZPNjSLOGRbC7BKUuR7y69V6JTx+3WAn5d5lPx5iNU
   D2PMHNlllEOvpoPFDAmkSVEa8qAnqo1zEEQwI2SmE8A+Yzdjn/GNknsY3
   9zAlyLVDfapf/NP6J1VQluPZXIOowIbk0U+aOKZ0AulG4ewhWrQhiPKLb
   w==;
X-CSE-ConnectionGUID: osrGFYlXScyVanHz2YmMLA==
X-CSE-MsgGUID: yJL3YzplQ86/f9UkgGQ2FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="59653716"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="59653716"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:18:30 -0700
X-CSE-ConnectionGUID: kLMB2qi+SuiN9dGGvkHlGw==
X-CSE-MsgGUID: drQ9SxX1QHqfjVgr32YSYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="180194667"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:18:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:18:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 01:18:29 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:18:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOHPWv3i8+eNmY86VStzlvp23E2wHhh+yKssVvZsrHQ6SqIgq4vwAwC7HBxEFbuXJzWOIZ6w+MwoSHTQIAesEka8iq+IUH5ZMj5PZRfrzKwvNj6BDb2+DUcwdp4DE6YhnxqrJS8I720o2odLiP0BkQSeSbCWRaJq+Ickv3NtMGlLuvFoqRnTj9SqcyHyLdjzxpLG/guMP8eJ0xKq6ozoipU6AeE7roFTCbGgeCJSUP9OW7JXOVD9rOSZQ6Ct3QsRr4CsW65ZguW+tcqEFvx0N7o6FRLieXHpZlQOyLHPrsCohmcF5+iIMdZuU6oLHpceBnCjgRhZ+zEa9vkkRFL9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6zoTf0y6THZkOLCzqzq7YB6MCIsLWwf+qIuFtuKTdk=;
 b=DJAvIBm5nuoeKnc/dX96uTQZznIK4WRbXg7N7PqbgtLwe/gf6PgK0sqM5LNzd6PYf9vLB/UcSs+N5h9mntjlwNBNX25/81jjD+jLJHe4LR7PLDDTmfyZPJ+axOy8vTddwq3/GJw5evjKLrUZnol8gGCasXoQl/DmR1hJuz4WiYtc9YJxdn/9F0dFhpcb27YkogBm5zlfbBwBMvFZr6F7zz9vfts4/ZYsbpmngX7yv85YW3U39RAKiY6EympYi8dwE/JdXxKuZ28OpAIDYoktUFEv2Km6NNW2TkQBPWs3yyZs7SEPanzqzyNJk030DoTfOrqTR9QnbAyted+FjirWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5796.namprd11.prod.outlook.com (2603:10b6:510:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:18:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:18:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jann Horn
	<jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>, Peter Zijlstra
	<peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, "Lai,
 Yi1" <yi1.lai@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"security@kernel.org" <security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v4 6/8] mm: Introduce deferred freeing for kernel page
 tables
Thread-Topic: [PATCH v4 6/8] mm: Introduce deferred freeing for kernel page
 tables
Thread-Index: AQHcHil0+WjIl5Nj6UekRoJQglk8lrSE7b2AgApQXWCABO8ngIAGEiYQ
Date: Fri, 19 Sep 2025 08:18:21 +0000
Message-ID: <BN9PR11MB52763344AF43582DB97EF45B8C11A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-7-baolu.lu@linux.intel.com>
 <20250905184355.GR616306@nvidia.com>
 <BL1PR11MB5271A6FA21418DD8486089AB8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20250915113509.GA1024672@nvidia.com>
In-Reply-To: <20250915113509.GA1024672@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5796:EE_
x-ms-office365-filtering-correlation-id: 9d11c89b-1bd3-4313-b910-08ddf75518b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?eF0nujtMJkANEkKi0OzjD+7t7cL0w6FSvOJjjfqWcllF6hnZIEbzSVQmcPaH?=
 =?us-ascii?Q?1KLaysOi1LYDX3Ug7H+VGgif7eMAMv27et5T8/sIVz95PDoVbDqKVv/H36JT?=
 =?us-ascii?Q?/8EILdWFC9S/r8KreXDQwDl7cRvOv8bSa9CFrWYKa0VXC6cHK1LNtSEA+nwq?=
 =?us-ascii?Q?tl2tWdqYuv7ZVr8YsT9hvQLfCF1EBybAuYCm/Ee/NTDLpK1lIYDeyZrCHQZo?=
 =?us-ascii?Q?asShHUmG8ZnV8Wjt4jmm5rEivD6oCQ0VA9psro9ym02e5Y+Jw1o1+RSbHYLk?=
 =?us-ascii?Q?AdcC76C2XicZsJ44gYEy5CR4axP7Grp8hNm08ySc+36hLFaHFD3jQTmGMCkg?=
 =?us-ascii?Q?uCmAtm074IQg/6zWoJZyANOg0Cgorhe+cD4h+gjNZrRbth1qWPhz3EHivALD?=
 =?us-ascii?Q?7xdqgfo5MdqW+iJKK/rjcbPknHFGTEOSIGxNj15mrAZEMRMkEIf/yQFFLszn?=
 =?us-ascii?Q?UOb1/XLz2ZNXrnjGNafNSc70Hgm2qzOFHFS0v0iukm3/5Cet2M96xUVfBXpK?=
 =?us-ascii?Q?Kj8Xr7o2KEcdbMWrewMdu7xsRDP6Sndi930jG8rpQB8Tb/tirQ0UvqPEkWrv?=
 =?us-ascii?Q?/yoeLUrFl1xBXHjlIqBM2OX/Gt13W7HH2/Sz63x/OnocX08xJ9pmgft9eMHq?=
 =?us-ascii?Q?WWqYs6YHVa6ypmxf2uOdOCorLI892N0QTHIDpqrm0XNDL//MWsB8y5j6lUMd?=
 =?us-ascii?Q?Y/TW8fBB3d9poYti/kd3QF41qIj80RsgdWka/nxRz4QK3Rc1f6Y6bXZFYDip?=
 =?us-ascii?Q?70HEVaNf99lCTfwlHF+DVyRRK0JLFg4k2/akfveM99V7tgyCMflCMCSBC9+y?=
 =?us-ascii?Q?GMB7psG+Rt7OPOjXAv1oY8yDCdgN5c9kPxxi0zlnJDpGrDDekVnWJxd/HDK+?=
 =?us-ascii?Q?WIszQPh24uzFfOLRfzE5hgF6OYeXb9TjiQpfFyJNxIId1ygo7GQ7WgX442OJ?=
 =?us-ascii?Q?wWqKQDH7gHBMeHik1qdPdl72R7a2Hd8V3vMF3mR/B1qafLRYVKkXvAOZ7HNs?=
 =?us-ascii?Q?F6+jCUYfc4vs37wwVMqFmxQkCbmjB5ZtGEjte/ElRNQT4nm+3D3/DPVbyb80?=
 =?us-ascii?Q?Pdo9s5nhXU5nmD8ZavT4VV9ECSV4mHwOfyHlJ8emRKN/xvnRpMwA3HSDmezJ?=
 =?us-ascii?Q?k1GgJ8fobgmnnRSFsk9MAMW3LxUXjA2g9/Y+hagtxvovL5xTwp/y439OMYUm?=
 =?us-ascii?Q?U1rM6O798FF39cbRzEvnZwI5UzzYbLstPHJxE6TVtkCJaYYZDXi76qVhIdru?=
 =?us-ascii?Q?6RLDaiLz/Y7KIfyl+p6dZGvOt0Wn85z43cnISBHS0KfdR9Uy0RAZvdnebQbs?=
 =?us-ascii?Q?u6C0+jKdrRFfE2f/MNiDpIEVBgDOGfauuKMrOy2rDG4Xbv3R0oLUEII5JKmQ?=
 =?us-ascii?Q?VS3hBdt2ceUH8bsIri50DCwIw5cOHR19cDAieElxCLgMcKq6hTClgNuyZsFx?=
 =?us-ascii?Q?Je6nSxsnaEt5k5QbwlR7ElX6RcrHRWvAbgGkmed1VmuaLz2ss272PA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VF51rgnrrdx4YBk/upC0HBss0sLRy9FyxzLNYJoZ1/mgZE4veEiJGg2NK97Q?=
 =?us-ascii?Q?i7bIP+TT3rDVsXZL0nP+N7CaYz/536NYvjdKhUQIs7fqiPLK4gHjPsGHjYBh?=
 =?us-ascii?Q?yeZavjWJQ/LIGNIRoS+V0z/yKV4CWEHT+YIhSUm3IubMbiZFR1wpLzWymF8l?=
 =?us-ascii?Q?52TFhnQg9LITnIrjsGsnl1hLA7Sm+yJnVF81TjD6HNRB+it1BVeVh25nW3Ms?=
 =?us-ascii?Q?dCiVYXNasmgTBBpJCxsiLDgsBW2vyrk7ZQQDv98EQ7z2EBHWC6vJnM5Z3D9Q?=
 =?us-ascii?Q?ohaMjOAXaxgxd6JNFCSP47S3Y/zPwjWwKzd6CYLfCJhE+ebVRZUJYN1c6rPI?=
 =?us-ascii?Q?Xp/GOinzVfrkR2cfqW8jTFEdxydLcxisMUa9K8wDjHxPtKrcZXUga+JxtBhL?=
 =?us-ascii?Q?/h4QvIIwiPKVrTn1szhM/aUXp0USRC3eY7KvTLAVgHTCxSmWmzNEyiwFoUby?=
 =?us-ascii?Q?boaKf75tjMhs606PPt8fpJSzVM5APU+QsB14qGf//KccoL9vPWSyr3i2TTJg?=
 =?us-ascii?Q?dYcUoUz6hj7WC5aPO/rCnAXB2axrSEtgYHoyNFKr37zHtYS8+3ZbT7WwMG2y?=
 =?us-ascii?Q?kTFqoIswaOaN7dcb0uoZYFkgOeSuTiSYm4byC4g1qktqOLh5LM1bnwUSbCbm?=
 =?us-ascii?Q?8hVYEJSnoEDcegdp9xbjMEUOoU4b4As9c9DQJDIXm4HM+tlKoEWrgtnZdNpG?=
 =?us-ascii?Q?rhXYgCMLihlbtFVD7MyIynDWzARdZeO4g4vb0Erl11qcanDLIeuLfmA/pFuh?=
 =?us-ascii?Q?igyv15HlvCmmlLiuc0PjNevuAcWXjoMbLxgLHepIem0sVvARhRNI29Pn/d1T?=
 =?us-ascii?Q?LZBL8rbi98L/WwIDLpmolMrUzHTRarG2yP8J+AKRsWvD4pR3Ducpoz1GxT2z?=
 =?us-ascii?Q?I63d13NPdkjScePQuzQGTJuSPZKpXHEhYtPrh/p8EraR/5WuSe0lbQtmeqgE?=
 =?us-ascii?Q?1dzePcPlyxO+AjvwipcMWXazu3yvp9njzmVAiSPaLcLlSldpklhgPftmNJnZ?=
 =?us-ascii?Q?ya7WuRFXCkzFqZ6Pmvu/NYB+yPhMtaC+KCH2axqA/NT7hfxzf6Xo/DaDKcDU?=
 =?us-ascii?Q?GN0QGtHgfyK/q3dBVCUr/mP68j+/FlqGetY254FhcCQMDrynTAdo8yKr7acr?=
 =?us-ascii?Q?VzH0+eTjjt2i3QN/vD0dQeopsVXn02NQoJeBZM4yHNfU5wJ2qmq4nMjepWrS?=
 =?us-ascii?Q?Yo0G4OOvJcgRRU8mzhqKMLKQp7H86jn+O68cI9XwF2+jhyWGc08GI1IC6m6J?=
 =?us-ascii?Q?eMDPJ8tdph3AXOcbtbGY8KLJEbAzFl3J73+4rjjLfc/MgY+/anSCzJWAjShS?=
 =?us-ascii?Q?bg0hRLNMkIzBiIsSJJYUokvHH2DmG6xOIOCceShF+t91Sv1UTBFM0UrxUGii?=
 =?us-ascii?Q?7gmVoYkwkqTelpCJpUe3coERwCuMzRNKzMoty6vd8ri/XzTD1561qEu2zj5P?=
 =?us-ascii?Q?wH1Fz5wpFRvC0vaGqE0TO9ba/jN10xD4vuQBqTHOCRgfmj7rpWQVn9twMDOF?=
 =?us-ascii?Q?9+Dg/FpZMPVrm6E9VwRbw+Clxn5l1DUTDX9w18WkesuWJjkP9d07yPkvjzlR?=
 =?us-ascii?Q?b9BwxeIF8yivgIYaEo4lXUHUw13AeU6nFmwym3Nu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d11c89b-1bd3-4313-b910-08ddf75518b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 08:18:21.5241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ljZLysqSmTMyMROIMPGVlqkAarWPJFGeYKhkqILV7U7duaKfOnXDIndkqWfiWMEYcHhnn1IrZVv1Xi49MTTWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5796
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, September 15, 2025 7:35 PM
>=20
> On Fri, Sep 12, 2025 at 08:17:23AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Saturday, September 6, 2025 2:44 AM
> > >
> > > On Fri, Sep 05, 2025 at 01:51:01PM +0800, Lu Baolu wrote:
> > >
> > > > +	list_for_each_entry_safe(pt, next, &page_list, pt_list) {
> > > > +		list_del(&pt->pt_list);
> > >
> > > The list_del isn't necessary, it doesn't zero the list, just _safe
> > > iteration is fine.
> > >
> >
> > if no list_del why need to keep the _safe iteration?
>=20
> __pagetable_free() can change the memory holding pt->pt-list, it is
> like kfree. So _safe is needed to allow that.
>=20
> _safe is not just about deletion, anything that could change the list
> element must use a safe iteration.
>=20

yeah, my oversight.
