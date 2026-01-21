Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9040757A
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768976696; cv=fail; b=jaoTf/R0wUBhWqP4pg6/xk1iWEBM5KYfAmB3bmoNtxuiJIx6u6l3bltmK9lGOrCF4wlz/aqljzwkb/Ma/0y35y7/QYUCwm9F4tBVxgLbFc0hn2s78aGhUH9rvj06ncT5D4lM/v13JoPhUZ4WhCRz6TwF+wfYtrXM0U5QjftYZrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768976696; c=relaxed/simple;
	bh=NZqqGInGH5FUbqxOmyUgjgWkdzDg5Oqt4tZ0rILSKw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=srDAZmIaH6YkAt6U0q1BN2TiMtR4HKWm6gfM15hjTVvsn223pvJNQnuyLPOkPnJ/kUnIPO0gGzND6GupHoJgQSly4lWLL1jMkV56lnyTi66Ez7lcPxL5WbZTkgNNN5Cg0l9kRQ3XYD1ctn10nrdIp1n7Nhoc93UY1UKmjzAQd5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSL90BmN; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSL90BmN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768976694; x=1800512694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NZqqGInGH5FUbqxOmyUgjgWkdzDg5Oqt4tZ0rILSKw0=;
  b=kSL90BmNIgv/KCbgmXzU6ZnHGPX/p/0rE1XF/qJp22hDo5+GfAd4yrS7
   TvIfGTuNFVA2bKGgLXHYtuUn5kpIOj3cW9gsn1n1y0PiirVri6Gyp92dw
   lVLHrIHBiLsR4X2TeAIKTNx37J2EQRZs+glGn1osmzeFjyuihjlQinl2f
   h28tEyagZ6w2FEsjwyDU1jXJAyHDmW5sHJvLR+zxXMpgmsGb+EWcvMPfB
   k1RDl0kQi5MvesdoimUddRCJGU9qcRsxUInhk2/fJow6KmNSg5fHZGSS6
   /9CIttKsfxjTBF6RzrhhrUSXmx65IsknQ+xL42DK04uleiPUQ64gZwa3+
   Q==;
X-CSE-ConnectionGUID: l6o7nwW2QU+5Lblm5E+/MA==
X-CSE-MsgGUID: A56rbr3SSZmIahoaOy8qnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57760426"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="57760426"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:23:24 -0800
X-CSE-ConnectionGUID: bKvL2f8+S/SXf70+6tr1Qw==
X-CSE-MsgGUID: D+CdQ4SjTxmxafn1sf21qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="229330168"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:23:23 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 22:23:22 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 22:23:22 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 22:23:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwbtsRAzfLKWTUjdV2l/pCRZ9Hvkg0rNsUzWcAnQq9LY+QE5zSrfE3l4MCDN3V39bbmT4dE+iLkjXzuZNaCo68rXP3CqG2D9VJlXQwxYfWc6D7VHcUsIDl8fBySgcb2xwkdqgp0g7ta7eGPzsrQA9F9rggkHgKFs2GeRFTcxf5VbxlmFxYA+Tr0HncEM4Za4f1oOUdW4+CjIXea4o0BGWy7jmIuCHAMmA2/yUPwmcJlvyWNr/zLu4Dp2+UB4B0FPMrghPjaqiODIrKF7vYp6tJkmCl7xoK3cXhh7ynYEqvlAtG90JzUtPHbEw9qwmTMOA+yfPfVqLQqG5KYWNIZ8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZqqGInGH5FUbqxOmyUgjgWkdzDg5Oqt4tZ0rILSKw0=;
 b=AMrrhTnhFLwPRSUQ/E1pcEhVKWb+werJ+H3dkYE5STLNWJsIEKUrde+5JbJWbBvLZMuL1Oct1vKGFLCotWpsGIFhDvZGCuboidZQBG267DQq/BlCIIGgY9BnGPx+Z3XsjJ5yGS4YxQgzEh9sh2dr/punRnu6ti7S4HcgYFQxt5n3hpvOCkb+Ci9tdHu23FeoMb2zQNWy7rkFz/8jbXjr1gRrrJk+8aMnC/o7uQtUEaFZNbdha86KOueT+PMWDKCuZt7qbmRzKNdS70xwVUdQqIdT27pNhhruSrohgcaYIaRs0llIytdjeenCwSUYM3vSD1ElfWRkOzARe/iEOGFgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 06:23:19 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 06:23:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
	<skhawaja@google.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] iommu/vt-d: Clear Present bit before tearing down
 context entry
Thread-Topic: [PATCH v2 2/3] iommu/vt-d: Clear Present bit before tearing down
 context entry
Thread-Index: AQHcidTzCfYiZ0yzRkeXiAiaNaQQUrVcJ3HQ
Date: Wed, 21 Jan 2026 06:23:19 +0000
Message-ID: <BL1PR11MB5271F1F4DF8B6D4052D626088C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
 <20260120061816.2132558-3-baolu.lu@linux.intel.com>
In-Reply-To: <20260120061816.2132558-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|LV8PR11MB8486:EE_
x-ms-office365-filtering-correlation-id: 90f9b13c-6078-493b-af49-08de58b59212
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UVpuWDlQYWdGN0pzMlRoQjBxa3ZEUDJpcnhNb0xBR3pQV2hoUFk4WXlRT3NI?=
 =?utf-8?B?cm5YOUc0T1dPTEI5aXFzMlJaQldHbGROdzErQ1Y0Ti9KQytINUU4YUhqZkFX?=
 =?utf-8?B?ZW5iVitLbVJDai9MMFVTUDBXU2pUd3pIMytDQS9VVDI4M3VzSjdaaHpHc1l4?=
 =?utf-8?B?ejFVc2xQN3F0eGZUTmxxdmExMDU3MTBMSkN3ak8rMHNlZExuREN6WkpoYTQ4?=
 =?utf-8?B?d3AyKy8vTnhHeXZ2UjFmTEtPTk0yRTJlZnNxUnNUbEVCaVJ6RytqSnNOb2Fj?=
 =?utf-8?B?Q3F4R2V5T05wREdJQ2Z3U05BV1l4ZnlRVG9VR2pNdnp5Tm1yZEtBSTNoa2p5?=
 =?utf-8?B?aU44Q2FYclZNLzZ6dktqelhrNzFZQ1lXZjAyN0V3c1gvM1VmNDZTRUFlOHlY?=
 =?utf-8?B?VDhLUG5NOE0wK3d1UWxGOTJkdXR6MVc1UHppRWpjZDhMc1ZkQm1oN0ZwcFN0?=
 =?utf-8?B?TlN1aFRTdS9vYWpqUHBxQjErR29yZURqVHVvUmtYWmQyajZlQzV5NE41aU9E?=
 =?utf-8?B?SVhDelBEOFQvc20wdDlrd013d3ZNbmNsN3kvQzhQZGZLZ3FUakZOZGFIUWtV?=
 =?utf-8?B?cDdYVXFYb1hEOGNXaWZGdWhDS00yL3NsQkM3dG9aLzZaWERXV1F2NERBNDN1?=
 =?utf-8?B?eG4ycnJnODdxUUxmakROTmhjZmhJbTYrTzNrZm5qRTd1TTNZMkJOMWZjNFhw?=
 =?utf-8?B?bU9wOGUvaC9SU3U4RWdrWVJrRlJ3WmlwZk4wYjdtMHI2YVpZZ2dZbFZaMW9S?=
 =?utf-8?B?Q2xmRFRDbFNGTzVnK0hCN0lFSmdqaXZBTGgrM2N5WGtXYWNlOFBBcVI3bWR3?=
 =?utf-8?B?QnpWbm5uMzBnQlUyYnFUcVpYS1kxNi8xamU5ZkxVbDRONjd6NHMzc09yaVpj?=
 =?utf-8?B?UjNPV3FDVjRCNFVGU2cwMzg0MzhMRGNFZk5NaG01RDE5ZCtsN0t6eXZKY05j?=
 =?utf-8?B?OEdCMTE5amxESzM4Nm1SM3FMZk1mazF5cy84WUo5Q3FGQzZ2eVhTaElQbFJ4?=
 =?utf-8?B?ZGN6Y08yWk52cUQ1b1BPa2x5L2psZllDdUN2aHdvYnJMb2QwYURUc01HZGtx?=
 =?utf-8?B?STJCVk1mWXY5TXBRMTE0TVBOd1lGUnZOeTFkV0M2elcxQ25EUVE2NDlsUzZy?=
 =?utf-8?B?ZlNuN0E2NnEyMTlNd202Q1VXVnJWUi9MTTQ4UlE1SkJjaVFMcDk5dElCb2wz?=
 =?utf-8?B?bGxmbS90eEpYaWQ5MGhHcUlpSndZbm85ai9xYW03bWk0QW45U1pMSHFtek1X?=
 =?utf-8?B?OXp1UzF1dzU5TzN5a3ZGSCt0WnNBTTZjYVZkeVdSUFRiZnpiSnBOOTVPS2Zj?=
 =?utf-8?B?RDVlMVRYSWlXUHNOK2NTNEdlSGNFOXZJZG9xMVRrWEJoVjRvdUNDSEkxM05w?=
 =?utf-8?B?ZUl1SmZtVmRJNjFhUHpPT3FMWmFCQ0JpOUtXVWp6QTRvOEp2WXJyTUZDbTlE?=
 =?utf-8?B?OW9ERDBHTU9vMU5tMkt0RW9KTnM2QU5UVndyUHZPZERPVUJ0RXlyUnBuTEdF?=
 =?utf-8?B?SUtIS2ZnT05YbXVyaDhXWkN5RHZyK1NJbjhXZC8xRVJWQlBXalh5YUF2ZjBE?=
 =?utf-8?B?VVhkNHAvRng5a1hVYi81QlJJclZhRGY1MFJsSEkydFRCT0l3Y3EveVBkYlhF?=
 =?utf-8?B?QWlQQk1KRkV6aEJ3ZDh4dmZNQ0x6UG5XVjFGdWtSeThEaVAwZWpPb2YvdXFj?=
 =?utf-8?B?LzBOQW9DQkZ4UGo4MWpvQkVJWTllQjdwdzdveDg2Q0tMMk1xaE1XZkJZenlS?=
 =?utf-8?B?SFB2bjRINE90NlFRYkE5TFp2dTZlandZWXF2eTc1NXR6bG0vVklpcnlHemNa?=
 =?utf-8?B?WC9kRytWZ2FoWG1JOFBUT0t6SWlxcFFXQjZJMmgyS3pvN1Rpd3RGRmZtTGlH?=
 =?utf-8?B?TjhMRTJVTEo2cjBJT0RnTnUzUGhQM2MyMVUzb002clVmQS9VVzhMSDY0WEIy?=
 =?utf-8?B?RDUxSDk1KzBCN1JxcDNpUldFSHlWSlZ3blZzN1VveGFRZS9HRXczc2xMR0dH?=
 =?utf-8?B?TGdpWXgzRUJDSTRTZlp2WEN0VjJMbjNXSTJrZXVCNE9KZ3BKMytZTnhVemVE?=
 =?utf-8?B?bnJrVzIxN0hjS1NRckptV1hNdHliUkNrS0dLWEZseWVGeU9JUy9lUUZFN2ty?=
 =?utf-8?B?R2NJUmJTMndHUG41UXFISU1nV1crMXJvUkFyblpXN1F6eW9CbklEM2tvdEQr?=
 =?utf-8?Q?01b0bhDa97xpFGJcstBwCes=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0lvRkxWWnJzWnJtY0swdjBSeGIvS1BPTGV6a3dDenFJcVVOU0dGNWdJS3J6?=
 =?utf-8?B?OUk0TytWMVNGQ1RpR3lnRG4zMU51QW5MVS91UEtXWHFONWlZSjVDS0VrR3RY?=
 =?utf-8?B?ems5QWYwZDVTTEw3bUNhSEk4SlJxTGgzc29UbmlPQVFPTWpSZ2RDam0rSXg1?=
 =?utf-8?B?REpyV25FWkJzc0xwMGU1RDNJZHMrdWpGUHhadmFJZTFQUURvZ0NNWmFmaFZ6?=
 =?utf-8?B?RG9hSEM3akhUL2xOd3lBSjI3Uzc3TXBzQ1dpa3BwVlFvbmk4MUN0VzJhNkFK?=
 =?utf-8?B?THF5TG54RHZNckV0U0tVN0h6Qm5BZ1VrcE1xSHV4WmVJaG5TdnFrZ2NmYW45?=
 =?utf-8?B?TXMzYlBSWG56aDlsblRNQ085ZVRNYWxBaE4zdkdTaFdRR2R2SjM2bFNQN0Yv?=
 =?utf-8?B?Q2FmdkVjVDB3ODBleE9vNVhUUkhSMTR0UHVjTlRZTm4rSGU4dDRsTmphRjk4?=
 =?utf-8?B?RjdVMTVZWklSaDVTeGUrVEMxSjUrUWVnODI4TTZGNUFlVjNsR0phUHJLcWt2?=
 =?utf-8?B?OHAySUlyM2hLeUUyeTFkVzA5cW5DTmd6MGtzczJwWGZjZGtJRXcxd3Q5TnUz?=
 =?utf-8?B?UkdKcWpsaFpqcE5CR0N2aTVzeHEyREp3RDBnYmRTN0E0VlN4TXJMMHl4WTE0?=
 =?utf-8?B?dW5weWVzNzNVYzNuTWpEbTJMRjIxeURFZTRLZ0gvemhIQmlwcG9WcnhRdGVE?=
 =?utf-8?B?UGYyK2w4ZTNjdlZmMERDVjJJZk1ESWx2dVJqbktMQ1lWSHVwaG1tc2hQdlBj?=
 =?utf-8?B?YUJYYnZkeWRPQ3NQUEJuaHlmUWNlbXdtbGdpNmhyVTJZeHFxS1hPSzhzaDkz?=
 =?utf-8?B?OWMwNHV1RnZsQ0tXa2ZBMDFlQjFRMVNtbzRuM2hVZ0hlUFRWZGZqL0FnTFA1?=
 =?utf-8?B?R3F4Qi8yZXBBUksrS3UyV1R2c1RScmVIUitLWkh2R3hJNTRsK1VrMmdNUkNn?=
 =?utf-8?B?RWxpMCt2dldNU3o4NERLRVJLRVFoSm1GcVRpeFVwcDJYckdOSWVoK1NiR211?=
 =?utf-8?B?a2MrMXgyM0VEZENIZGRVSFJCanJreS8xNmYyRWVEcEd3RTF6eTY2WEY5ck55?=
 =?utf-8?B?SGdBZERjOXdHUDVMT045YUd4T3BIcnNCWTYvSHl1RWdXaEk3ZW1TME1rRGp3?=
 =?utf-8?B?SU1wVmQwZXduMHVhYlgxd2ZVUkRBbFJLeVpHVGpJeWxtbk1JbEJEamlFNklU?=
 =?utf-8?B?QVB4K1BBMGFRZVlGeFVzVm5rUXQ3MUFqRUFoSEMvZFNzVmo5QXB0NmZVMmdK?=
 =?utf-8?B?TkEwdGIvUXJidjRsUStIYzhyM1ExYVdLK283Z0t5czFkZmtqK1RFWDlsSE1p?=
 =?utf-8?B?M21rRVdOYnBFR0NWZktnS3hXWDR4QWRWdlBVZENUZEZNaVNlOUhhbHpWZ1hv?=
 =?utf-8?B?ZHJTcVhRUXM1Y3FiYkxaNFNYSEFEamdZY3lMdnFBd0x5SGtzUUtiREc1RGFV?=
 =?utf-8?B?YXpSMjVKdTI0RkdQK2Fpb1BuSGVaM0kxWGsxb3E1c1dRbTAwd1c4OU0vZysx?=
 =?utf-8?B?dmZHVjlQSmpmSWthcUE5TkZSSy9YNEJsaDBHLyt0M0RTdlFaS3ZOMlI1djJu?=
 =?utf-8?B?cTh2TEVDbFc2UEhXOE5Qbk5HaXdSTWlOa0tMN1cwN2VFQjd6d3l4dnRPR0R0?=
 =?utf-8?B?OUYzMWhIT3k4dDFrajZFUVduRngwU0svaElFQ084R2h2SUhRVjJOUUV1TC9L?=
 =?utf-8?B?dlAxc3lESWNxL2NKV1EzMm93ak5LemhtODVmb1F3cEdOU0M1SkoyUVRCN3pS?=
 =?utf-8?B?V1duU1BxUm1GUHNhSDdXa1Myd3MvSVd4OWJCZ2l1VGtkQWZuMkt3TkRPSGMr?=
 =?utf-8?B?d1pta0k2N1JuWHltVWhPNUYxeTJrV2tjVzRHMHg0RTF0dWc1bWl1aGUyR1Zh?=
 =?utf-8?B?Uy9GWExTaDFPQWhKRWw2dmx6U2R1bkZjU3ZXK203RGl6d1J6d2Y1NzhMNzJD?=
 =?utf-8?B?REV2YVdtT091NFFRaW9zTm9rdmlqSkhxSXlVS3doTy84a3NmS1h4dVM3SzVr?=
 =?utf-8?B?M1lmK2ZqYXBPZkVIMU81bDlzTE5FaS9CUTlNYkREbWpLYnZqaDd5aE5ma0FB?=
 =?utf-8?B?SlJQc21IZ0dCdTJHUVc2K2I2M2k5UjRSSGtrMUVUaDJSbDRDMk0wN0QvaGNM?=
 =?utf-8?B?OXgwSjROY0dmdk4rdkdyelRtR2hOdTkwVjV4dVJJd1VNbVNjNVVsV1Q4NENF?=
 =?utf-8?B?U1JpWHlDcWpiUHQ1ejJROHd3dkE5VWNXWU5QZGcrejYxTkZzbnZDR0ljeVVF?=
 =?utf-8?B?Vis5TUFmVy9Gc1RhSUp1dUh1Tk1CazdFWnZ6K2RxUktQSnlNd3Y3Q2hQMTJG?=
 =?utf-8?B?dldiZHJzUkVLWVNrdk5TMzF0YVRmaFJ1aHluQlRZMjVBaFBUS2hsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f9b13c-6078-493b-af49-08de58b59212
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 06:23:19.6137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQJclow8mohgxyh8548oYan7s6CoD+pICaFK5V+8oLL9pZnXC+d/AIJcY9l3VTO6zOLwHKBZih1v0jvJXzBYLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
X-OriginatorOrg: intel.com

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKYW51YXJ5IDIwLCAyMDI2IDI6MTggUE0NCj4gDQo+IFdoZW4gdGVhcmluZyBkb3duIGEg
Y29udGV4dCBlbnRyeSwgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gemVyb3MgdGhlDQo+IGVu
dGlyZSAxMjgtYml0IGVudHJ5IHVzaW5nIG11bHRpcGxlIDY0LWJpdCB3cml0ZXMuIFRoaXMgY3Jl
YXRlcyBhIHdpbmRvdw0KPiB3aGVyZSB0aGUgaGFyZHdhcmUgY2FuIGZldGNoIGEgInRvcm4iIGVu
dHJ5IOKAlCB3aGVyZSBzb21lIGZpZWxkcyBhcmUNCj4gYWxyZWFkeSB6ZXJvZWQgd2hpbGUgdGhl
ICdQcmVzZW50JyBiaXQgaXMgc3RpbGwgc2V0IOKAlCBsZWFkaW5nIHRvDQo+IHVucHJlZGljdGFi
bGUgYmVoYXZpb3Igb3Igc3B1cmlvdXMgZmF1bHRzLg0KPiANCj4gV2hpbGUgeDg2IHByb3ZpZGVz
IHN0cm9uZyB3cml0ZSBvcmRlcmluZywgdGhlIGNvbXBpbGVyIG1heSByZW9yZGVyIHdyaXRlcw0K
PiB0byB0aGUgdHdvIDY0LWJpdCBoYWx2ZXMgb2YgdGhlIGNvbnRleHQgZW50cnkuIEV2ZW4gd2l0
aG91dCBjb21waWxlcg0KPiByZW9yZGVyaW5nLCB0aGUgaGFyZHdhcmUgZmV0Y2ggaXMgbm90IGd1
YXJhbnRlZWQgdG8gYmUgYXRvbWljIHdpdGgNCj4gcmVzcGVjdCB0byBtdWx0aXBsZSBDUFUgd3Jp
dGVzLg0KPiANCj4gQWxpZ24gd2l0aCB0aGUgIkd1aWRhbmNlIHRvIFNvZnR3YXJlIGZvciBJbnZh
bGlkYXRpb25zIiBpbiB0aGUgVlQtZCBzcGVjDQo+IChTZWN0aW9uIDYuNS4zLjMpIGJ5IGltcGxl
bWVudGluZyB0aGUgcmVjb21tZW5kZWQgb3duZXJzaGlwIGhhbmRzaGFrZToNCj4gDQo+IDEuIENs
ZWFyIG9ubHkgdGhlICdQcmVzZW50JyAoUCkgYml0IG9mIHRoZSBjb250ZXh0IGVudHJ5IGZpcnN0
IHRvDQo+ICAgIHNpZ25hbCB0aGUgdHJhbnNpdGlvbiBvZiBvd25lcnNoaXAgZnJvbSBoYXJkd2Fy
ZSB0byBzb2Z0d2FyZS4NCj4gMi4gVXNlIGRtYV93bWIoKSB0byBlbnN1cmUgdGhlIGNsZWFyZWQg
Yml0IGlzIHZpc2libGUgdG8gdGhlIElPTU1VLg0KPiAzLiBQZXJmb3JtIHRoZSByZXF1aXJlZCBj
YWNoZSBhbmQgY29udGV4dC1jYWNoZSBpbnZhbGlkYXRpb24gdG8gZW5zdXJlDQo+ICAgIGhhcmR3
YXJlIG5vIGxvbmdlciBoYXMgY2FjaGVkIHJlZmVyZW5jZXMgdG8gdGhlIGVudHJ5Lg0KPiA0LiBG
dWxseSB6ZXJvIG91dCB0aGUgZW50cnkgb25seSBhZnRlciB0aGUgaW52YWxpZGF0aW9uIGlzIGNv
bXBsZXRlLg0KPiANCj4gQWxzbywgYWRkIGEgZG1hX3dtYigpIHRvIGNvbnRleHRfc2V0X3ByZXNl
bnQoKSB0byBlbnN1cmUgdGhlIGVudHJ5DQo+IGlzIGZ1bGx5IGluaXRpYWxpemVkIGJlZm9yZSB0
aGUgJ1ByZXNlbnQnIGJpdCBiZWNvbWVzIHZpc2libGUuDQo+IA0KPiBGaXhlczogYmEzOTU5Mjc2
NGVkMiAoIkludGVsIElPTU1VOiBJbnRlbCBJT01NVSBkcml2ZXIiKQ0KPiBSZXBvcnRlZC1ieTog
RG15dHJvIE1hbHVrYSA8ZG1hbHVrYUBjaHJvbWl1bS5vcmc+DQo+IENsb3NlczogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsL2FURzdnYzdJNXdFeGFpM1NAZ29vZ2xlLmNvbS8NCj4gU2lnbmVk
LW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0KDQpidHcgdGhlcmUgaXMgYSBj
b250ZXh0X2NsZWFyX2VudHJ5KCkgZm9yIGNvcGllZCBjb250ZXh0IGVudHJ5IGluDQpkZXZpY2Vf
cGFzaWRfdGFibGVfc2V0dXAoKSwgYnV0IHRoaXMgcGF0Y2ggZG9lc24ndCB0b3VjaCB0aGF0DQpw
YXRoLiBJdCBzZWVtcyB0byBhc3N1bWUgdGhhdCBubyBpbi1mbGlnaHQgRE1BIHdpbGwgZXhpc3Qg
YXQgdGhhdA0KcG9pbnQ6DQoNCiAgICAgICAgaWYgKGNvbnRleHRfY29waWVkKGlvbW11LCBidXMs
IGRldmZuKSkgew0KICAgICAgICAgICAgICAgIGNvbnRleHRfY2xlYXJfZW50cnkoY29udGV4dCk7
DQogICAgICAgICAgICAgICAgLi4uDQogICAgICAgICAgICAgICAgLyoNCiAgICAgICAgICAgICAg
ICAgKiBBdCB0aGlzIHBvaW50LCB0aGUgZGV2aWNlIGlzIHN1cHBvc2VkIHRvIGZpbmlzaCByZXNl
dCBhdA0KICAgICAgICAgICAgICAgICAqIGl0cyBkcml2ZXIgcHJvYmUgc3RhZ2UsIHNvIG5vIGlu
LWZsaWdodCBETUEgd2lsbCBleGlzdCwNCiAgICAgICAgICAgICAgICAgKiBhbmQgd2UgZG9uJ3Qg
bmVlZCB0byB3b3JyeSBhbnltb3JlIGhlcmVhZnRlci4NCiAgICAgICAgICAgICAgICAgKi8NCiAg
ICAgICAgICAgICAgICBjbGVhcl9jb250ZXh0X2NvcGllZChpb21tdSwgYnVzLCBkZXZmbik7DQoN
CklzIHRoYXQgZ3VhcmFudGVlZCBieSBhbGwgZGV2aWNlcz8gZnJvbSBrZHVtcCBmZWF0dXJlIHAu
by52LiBpZg0KdGhhdCBhc3N1bXB0aW9uIGlzIGJyb2tlbiBpdCBqdXN0IG1lYW5zIHBvdGVudGlh
bCBETUEgZXJyb3JzDQppbiB0aGlzIHRyYW5zaXRpb24gd2luZG93LiBCdXQgcmVnYXJkaW5nIHRv
IHRoZSBpc3N1ZSB3aGljaCB0aGlzDQpwYXRjaCB0cmllcyB0byBmaXgsIGluLWZseSBETUFzIG1h
eSBsZWFkIHRvIHVuZGVzaXJlZCBiZWhhdmlvcnMNCmluY2x1ZGluZyBtZW1vcnkgY29ycnVwdGlv
biBldGMuDQoNClNvLCBzaG91bGQgaXQgYmUgZml4ZWQgdG9vPw0K
