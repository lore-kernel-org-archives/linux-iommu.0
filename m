Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6CB1EEA31
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679950; cv=fail; b=NSILUwJpUuetuTWX1nm8gUWxClNkvMbVMtrIEcQznV2hNmD59QS2k0Xn3fWddZQFD/dKYuZOx1LW7iGxk3C8IPFOlOHbnmyE3FBb9kEfes7UNL0TRvRPJyxiGUFXb19ggsZ3QGVr1oBpWByIYe/raLrHdWMqdWWRaaLOe+Ln1NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679950; c=relaxed/simple;
	bh=z5YqCJkFK4uGxdjnUx4kHjpIAfUJO7wprYVlYxliBEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U9aDTDmUQDApu1D6DCgy3vax7FeAfhGNahiP6b1YdVMw65e8z4PcpEj/CgXxkdyZDFnAAa5nIdLulBY68fnUGy9/4m0zTkk3pRU0knqLgKc7gmIMqH08okDyo5cjS7KnBcTiuNiYIaYZTMOya+FSxa4Q2NCEcpCGmTOS8oEcPQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvZm1i0S; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvZm1i0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781679949; x=1813215949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z5YqCJkFK4uGxdjnUx4kHjpIAfUJO7wprYVlYxliBEY=;
  b=fvZm1i0SalR0RXUASl+WoO+Vbi3Uq45mkuEwxXwTik051SN6juTgsgAi
   x7SOKhjue4lZ9XnvXCNtFATDy+4M5Wa03oKwc6a6LZwUOROMrPUCqWIE1
   6dQp43uNwDpfL2WgTYcl94an/5mX3dlEfWzlZSHasvyOtRzbCb93t4nd+
   qUYPizMZA54+A8jOmhaq9j2Flb3oiMI5PWIJVCwPjdMNvEK0ceTcrDOqZ
   U+ZfheCmd82g0ZbbyyQPH+zrdNglweDkwVmT1emS46LPbaDwOT3uF1lBx
   TobF8nqvbuZ/v0vadQrmRYLcGkQPZS5Y0hKNTn3BB0dHnUyLFXDx/bjmL
   w==;
X-CSE-ConnectionGUID: CdsjLb1NR+WzFarvqG7DIw==
X-CSE-MsgGUID: 0VPggM7EQKWCrvhB26fzig==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="86120067"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="86120067"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:05:49 -0700
X-CSE-ConnectionGUID: SAAKlFNmTXuA0dhgO17eow==
X-CSE-MsgGUID: eeXnJR2zQtKaCuQxoiQ0/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="248050590"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:05:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:05:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 00:05:47 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:05:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nC6pmdsLgbI+9PP04+VjzdmrhkhtqIT0DDf+PFgL+gxTkxVNx6NxifuKy5KXFPh/j24sDwJKLwz7/Q2oZ8hNFh83HaXA65jYDrms1YgGZ1szAeYlFuwA9RMPmt4y9krYQXmF73F/GWaYJd9wMKBul7W3g9WcRYOKLM7m0E+aFIYrQm29GGz8WZDfz46bxfZSM8FNL6gbBPy9aV3ZCGWmTVt9RhPTTELeB/AS68piFeQepGS48yf0TD//7U20PjDzRDzK8y6HGb68Fy+cUputlNoJospY2JkC2kQie6Lf3/h+ixLXhZrp69nmvOJFMS1WdGUJgMPnSZZQ65q3cPYJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5YqCJkFK4uGxdjnUx4kHjpIAfUJO7wprYVlYxliBEY=;
 b=PYxkONu7xeonQ7flpkyaZ9YdbA6f3oAYgiVJHat2m8C+VsfKhyjHRsM0xhoCwF0TTUC1cy7ch+qEU6teDHBv9dgwPBc2UwcN0sSoTkDhz21SM+BRzhkQWKAIN8vmetC+YBVvipn7lAskIw6pE40FOamb6Fipc55nuOelMHPU43wvqBa/FYTWvr3Dq7m829LMP/f955cjC142LS4Ry0jANcLpaiv2QO1whSXCBVdtWo3nUogClNq3gFbR8V7vPHYdHB2TJ7dH97ivBAYUUiK4LDtToPBjSu/Gm9VkK+3C2G/6d0fmMqMBu/atMcyOoWFi+KcwAhi1n3PNFwd0hYkzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3687.namprd11.prod.outlook.com (2603:10b6:a03:ff::26)
 by SA1PR11MB8256.namprd11.prod.outlook.com (2603:10b6:806:253::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 07:05:45 +0000
Received: from BYAPR11MB3687.namprd11.prod.outlook.com
 ([fe80::14b0:6b4c:1431:d2ee]) by BYAPR11MB3687.namprd11.prod.outlook.com
 ([fe80::14b0:6b4c:1431:d2ee%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 07:05:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Joerg Roedel <jroedel@suse.de>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, "Chris
 Wright" <chrisw@sous-sol.org>, Jesse Barnes <jbarnes@virtuousgeek.org>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/9] iommu/vt-d: Consolidate dmar state management and
 force_on logic
Thread-Topic: [PATCH 4/9] iommu/vt-d: Consolidate dmar state management and
 force_on logic
Thread-Index: AQHc89/rGIuyxu1Md0mi0qVQ4r0sVbY6z8eAgAeXNOA=
Date: Wed, 17 Jun 2026 07:05:44 +0000
Message-ID: <BYAPR11MB368726F5C852BC8968E1743D8CE42@BYAPR11MB3687.namprd11.prod.outlook.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-5-kevin.tian@intel.com>
 <fe8d86ec-539c-4fb3-bf8b-48150e92eecf@linux.intel.com>
In-Reply-To: <fe8d86ec-539c-4fb3-bf8b-48150e92eecf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3687:EE_|SA1PR11MB8256:EE_
x-ms-office365-filtering-correlation-id: f6146a87-e036-49c2-eeb4-08decc3ed9af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007|6133799003|38070700021;
x-microsoft-antispam-message-info: oinDFixZ6xSscskxK18/ZIYmryTmgPtGLYvNhswQype2yx3AmPfl0QxAMHs0IRlgLAfokm/Z2QDYa4gft1TvkE2obQ6+s//vnieeYsY5bwVY1OOzPYTJVQciJa5zkRaLdgBbDSXbY4xJSkoIdA0d0/PR26bAAcs1BArmQgPGr2hpJ34LP/VgzBge93+hep35Ql19G1eejqZWdLK7eq8cIn75cb919ZU5jVFq5mXqRIjGSbYbXaxMRTxuhIu7sbu8NwwC6zG4jT2YbCAGzUYc2y3dPXCIVey1yy+DDjgCtfXCOVabE4lXHz6AoQAYjprZLUjfhMU+/eUcV9DnZ5Sp1/M/6s7xUYN3EcFeDrx1dzxj9hO9j9pRRGWXITWKfhtlh0UoDVCIK/KIj9pi1oRyqbmcaSZ76QrLqFDuwFILahpZznqeu/8ZmosnVhJ8I6XibCpKx4THOopRW3odOzxilf4OluJUwp5zghPivyXMRoi42Chiur/yFG7pGP46WPl7dx4GA46p5HXDnSsEqztwsyDk8QqtK2EsFrdiIWo4+ryEV9xCI5iyVBwXCPiyjnWij40N1ymy2a8UvAiM4xLJsy8LCvdJzTghsZSlmRkSY4JD+70btdt/MNIflQXK/a/AOhwUZjO8Ne/9XhI8q+l/5ikaSNaPu05h7tKi3KeSe1DAqvyXvXuY7VerkzMSCV7ADBegdb5FFXaP2jA1naTPqIbBLekem7rMzep64ZHLQ081+l6XnllUuPTGDWxhueS1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0FFakcrS2xJbEhpUStKaUZCTVdjdHBwcGxJdUYvdy80NEE4bFlVQ0pLVWkw?=
 =?utf-8?B?UW1ER3VCQTZXN2l6WFRMQjdTeW5zOWRUQXJGdDFqWUJPd2RmNTZ0M3lYNzRo?=
 =?utf-8?B?SnRPRW92Y3RYUStHUEYxY0JXaHZBUVVtQ3R3aDgyZ1liWW5UUUZBZ3JBZmFp?=
 =?utf-8?B?YXRrVHNqdkVsUWZ3UGJMWC9zRHpaN2dYa1oyVVI3bGZvdlFhVkFoL3lJZ1h3?=
 =?utf-8?B?WGdCTWx0amgxT3ozeFlsYm02SlV4RmpUdWs4aHpnRUZMV0pWS3ZnbG5nNXZT?=
 =?utf-8?B?TDVsckE1SzVSWFp6aHFJWjF3ZE10UnozUE8wTjUyV3JRaDFKdXVTVTQxaHJC?=
 =?utf-8?B?UzcvMjRUMmRQVC9FKzZ6Um82MW1ySjBsTkNHc0pkZmcxMXpQZC9sRUs2Q3NC?=
 =?utf-8?B?eDc4VGVPd2hnUVR1L29KOTdkV1laYURLeFNLd2VPVDhDTmN4SDUzWFBvL2FI?=
 =?utf-8?B?VkUra1dqelBTT1MvVkIrT3JDaGpobHVvWWpCVHJCUHp1RE45MGpDa1o5eER3?=
 =?utf-8?B?aENCVEN3L2pVa2UvejVzWndhMDZmWUFqSHpYanNVWGlrOFl5cUI4NytTWEN2?=
 =?utf-8?B?Sy9LNUJnR01JWG9UT1J6Vit0MWtkWDVrOHozbjNiY1FVU2RaRGlMTkFMM1lK?=
 =?utf-8?B?aE55SzRwS084NittbFFjMHhaZ2Fubk9kcmVpL2xvd2prOUdDcW5DdGRGL05E?=
 =?utf-8?B?YlBWbWRQQnYzeDZnOHJCOGZDL2hsWnpIbU1aMkoybGtHUkhSYk5BanI2Ylpo?=
 =?utf-8?B?elJSTm1QdEJkNWpUVWZZY1VrdnExamRVVTFaMXAxVEtxcTNmaEtSNmNHUStu?=
 =?utf-8?B?YnZ4OWpSM3pOUnFqY3lWSFRHVC85ay9MYjBvQ0R0cjlna1JSY290R0IwWi9C?=
 =?utf-8?B?VVFEVENVcDhCRHRtWURTNWRYNG9yRUU5a0t0b0NCbVJ6VUhkbXVVWHh2MExm?=
 =?utf-8?B?SDRTS2VpWGVoN3daWTFuMGpKSW51YlY3VkxpZHpIeGZWU1o0d3BkZ0pIV1VK?=
 =?utf-8?B?OEV0K25ZeTB3SkkwVjZrVHYrUXRGY1RYQkc3WGpBaHJiVTFmNTBoMnd2cTBO?=
 =?utf-8?B?Y2tkZkhNS0FmU2RKL3ZlQmNlNzAvNUJDQTJzVUo5a1RrTUhwbmROc1lDTThU?=
 =?utf-8?B?dCtqQ3ZjbFZMOWszOXdtMFhBRUc2WnZkQkxvdFhwcEo3UEhSYThOMmRIY0gz?=
 =?utf-8?B?WWF1Q1VER2VSZGJWVXlOemFuWXRZUFJNVGpJRmNtT1Z1NkdCL1FLay9ZL2M0?=
 =?utf-8?B?TEpXVjBxajVZNFVvSDdjWXg5UnhaeGYybDR4UFJWaHdDN0xmRGF4U1RqWmhN?=
 =?utf-8?B?SmkxdEZHWElJd3E2dVdDOXljZlllRWhGWUwyR1BEN3QxVkgzOTJ6NzRramVy?=
 =?utf-8?B?UmFYU2Z3TnVTZFdPTWlNVkZkdngvbCtHbklERTNCVGZmWUV4RGxQL3ZPbEJr?=
 =?utf-8?B?V1pDT2QwVGpObEc1QWFkVUw2bUU4TWUvZTZEejVuNTh3dDVPQkdvZTlOMlBU?=
 =?utf-8?B?bUFhLy9Eb3hkZzgrZi85c2J4bERxU2VPdTlDcW1oK0tWYjRBdWY0R0ZoWjg1?=
 =?utf-8?B?MGdadWJEK1pTQ1pKT3lDYTVxTUlqelp4TU9XSVRVdWp0U0wxbEFQNCtwbXhn?=
 =?utf-8?B?bTRTUVJZVmN3RUR4eW5qcXdQNEJsSVlUVnp1RWVGZWFRZm9pZTE0Mm1tMW83?=
 =?utf-8?B?cEVQSkxCQTdYekhXYmJGK2lhZUVnUEtuenRkUFFONG15cWpYbkRNR2dTcVlC?=
 =?utf-8?B?K1NEaHkyRGs5SUJWQTVJOUdGQ2VPWEFFQ2xMekVCb1E2NkhzaURDcFBrS0wz?=
 =?utf-8?B?TnNaUGlrU0lXQzNab0pqSnRyZ0plS3dJcExPV09uNmtnbkhmeGRnM29nNFdR?=
 =?utf-8?B?cUN1Q0poSGFsd2dXZUJ1Nk43aXlsQy9DSElRK3MvcVhmNzk3enVWNFBGRVVK?=
 =?utf-8?B?bTNBRWpLeDNQUGl2ekJyQ3Qrc3RDODBVemJ2Z0JUOFFVdDdOVm0vN1p5MVBn?=
 =?utf-8?B?SkpPRGs0ZXVmejN6Nm82Sjd2bGdsbWpmWk5ieDk3VTRDMmZKdWtCRWpMNVYr?=
 =?utf-8?B?dHJnWStGUXNIaDYzNzdMaFkxMTRCU2d2dHR4WFhvQTZlK1FjQmJQamUrZkh0?=
 =?utf-8?B?OElVTkZDckpwb2dCWVhodnlYRVlkZ0IrTGFReTZsMXU5dWJXeXdMeUo3eE5h?=
 =?utf-8?B?aUpMK2ZMMUNFZUxDQzJtdDlJOC9yUnZZcHFXbmFKZnU4Qzl4ekdxRm11Y0cr?=
 =?utf-8?B?VFhtaEc3dmlDdjlzSU5jeENLR1JYR1FqL2dkaHdhRWJOTEt4Slp4Sk1CQlpZ?=
 =?utf-8?B?dUppYzdyaU10SkdvNDMyTUVEQXpUK014aEFPTjk2WUhqZXRRd0QrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E+e7ig5MCjBbPnXuf1xanO1W8s76leMWkLXuvWE3TRojOswmbFqiUPT6KaHy3tpdA0UaFFUxH2TY8mQ/ENSkqOLtnsLn0JpAcFXjM7kMCn2P0LbG76YBN+nVb5hdOJAzMb0J09IsJ+zre5Wwa+M4tDMecbR6RRgbNpyvGx741hR7y5PvD267puaBE60+kvuhqd9DugyZ7I8LXOUqPqA4LX+MsrRvLOu22XdXVaOZncAjjrQYvwNTH+Z9N8s7AjZW2j3y4uDVjz7ROi7+rX/D0BfnlPudpNUvHky9t3Qn7l239Cc8h33KG29qcVzmmZJprPjWmLWK+3T3akQAzVQJ1w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6146a87-e036-49c2-eeb4-08decc3ed9af
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 07:05:44.5175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HN1oIai8dYXx70IGdeRPqBwEnxMwz94hcBs0p2WLnrS0Y98NKLWPFv3+vqXawb+P4rsm7ExrxBmGmtnahIwMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8256
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bmUgMTIsIDIwMjYgNzowOCBQTQ0KPiANCj4gT24gNi80LzIwMjYgMToxNSBQTSwgS2V2
aW4gVGlhbiB3cm90ZToNCj4gPiArLyoNCj4gPiArICogQ2VudHJhbGl6ZWQgaGVscGVyIGZvciBk
ZWNpZGluZyB0aGUgZm9yY2Vfb24gcG9saWN5DQo+ID4gKyAqDQo+ID4gKyAqIGRtYXIgZGlzYWJs
ZWQgc3RhdGVzIChmb3IgRE1BIFJlbWFwcGluZykgYXJlIGRlZmluZWQgZnJvbSBzdHJvbmdlcg0K
PiA+ICsgKiBkaXNhYmxlcyAobW9yZSBuZWdhdGl2ZSB2YWx1ZXMpIHRvIHdlYWtlciBkaXNhYmxl
cyAobGVzcyBuZWdhdGl2ZQ0KPiA+ICsgKiB2YWx1ZXMpLg0KPiA+ICsgKg0KPiA+ICsgKiBXaGVu
IGEgZm9yY2Vfb24gdHlwZSBpcyBwYXNzZWQgaW4sIGl0IGlzIGFzc29jaWF0ZWQgdG8gYSByZWZl
cmVuY2UNCj4gPiArICogbGV2ZWwgZm9yIGNvbXBhcmlzb24uIGZvcmNlX29uIGlzIHBlcm1pdHRl
ZCB3aGVuIGRtYXIgaXMgaW4gYQ0KPiA+ICsgKiBkaXNhYmxlZCBzdGF0ZSBsZXNzIG5lZ2F0aXZl
IHRoYW4gdGhlIHJlZmVyZW5jZSBsZXZlbCAoaWYgZG1hciBpcw0KPiA+ICsgKiBlbmFibGVkIHRo
ZW4gdGhlIGNoZWNrIGlzIGFsd2F5cyB0cnVlKS4NCj4gPiArICoNCj4gPiArICogRm9yIHN1cHBv
cnRlZCBmb3JjZV9vbiB0eXBlczoNCj4gPiArICoNCj4gPiArICogLSBETUFSX0ZPUkNFT05fVEJP
T1Q6IHRib290IHN0cmljdGx5IHJlcXVpcmVzIERNQSByZW1hcHBpbmcgZm9yDQo+IHNlY3VyZQ0K
PiA+ICsgKiAgIGJvb3QgaGVuY2Ugc3VwZXJzZWRlcyBhbnkgdXNlciBvcHRzICgiaW9tbXU9b2Zm
IiBvcg0KPiAiaW50ZWxfaW9tbXU9b2ZmIikNCj4gPiArICogICBhbmQgd2Vha2VyIGRpc2FibGVz
Lg0KPiA+ICsgKg0KPiA+ICsgKiAtIERNQVJfRk9SQ0VPTl9QTEFURk9STTogZXh0ZXJuYWwtZmFj
aW5nIGRldmljZXMgcmVxdWlyZXMgRE1BDQo+ID4gKyAqICAgcmVtYXBwaW5nIHRvIHByZXZlbnQg
bWFsaWNpb3VzIGRvd25zdHJlYW0gZXh0ZXJuYWwgZGV2aWNlcyBmcm9tDQo+ID4gKyAqICAgY29t
cG9zaW5nIERNQSBhdHRhY2tzLiBmb3JjZV9vbiBpcyBwZXJtaXR0ZWQgb25seSBpZiBkbWFyIGlz
IGRpc2FibGVkDQo+ID4gKyAqICAgYnkgYnVpbGQgY29uZmlndXJhdGlvbnMgKENPTkZJR19JTlRF
TF9JT01NVV9ERUZBVUxUX09OPW9mZikuDQo+ID4gKyAqLw0KPiANCj4gSXQgcmVhZHMgbGlrZSB0
Ym9vdCBzdWNjZXNzZnVsbHkgb3ZlcnJpZGVzIHRoZSB1c2VyJ3MgY2hvaWNlcywgd2hlcmVhcw0K
PiB0aGUgcGxhdGZvcm0gb3B0LWluIGNhbm5vdC4gQ291bGQgeW91IHNoZWQgbW9yZSBsaWdodCBv
biB0aGlzPyBNeQ0KPiB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgInRydXN0ZWQgYm9vdCBlbnZpcm9u
bWVudCIgaXMgY29uc2lkZXJlZCBzdHJvbmdlcg0KPiB0aGFuICJ1c2VyIGNob2ljZXMiLCB3aGlj
aCBpbiB0dXJuIGlzIHN0cm9uZ2VyIHRoYW4gYSAicGxhdGZvcm0gb3B0LWluDQo+IGhpbnQiLg0K
DQp5ZXMsIGFuZCB0aGlzIGlzIHRoZSBleGlzdGluZyBwb2xpY3kuDQoNCj4gDQo+IElmIHRoaXMg
aXMgaW5kZWVkIHRoZSBjb3JlIGRlc2lnbiBwaGlsb3NvcGh5LCB3b3VsZCB5b3UgbWluZCBzcGVs
bGluZyBpdA0KPiBvdXQgZXhwbGljaXRseSBpbiB0aGlzIGNvbW1lbnQ/IE1ha2luZyB0aGUgZXhh
Y3QgcHJlY2VkZW5jZSBjbGVhcg0KPiB3aWxsIGhlbHAgZnV0dXJlIGRldmVsb3BtZW50IGZvbGxv
dyB0aGUgc2FtZSBwaGlsb3NvcGh5Lg0KDQpPa2F5LCB3aWxsIGFkZC4NCg0KPiANCj4gPiArYm9v
bCBkbWFyX2Nhbl9mb3JjZV9vbihlbnVtIGRtYXJfZm9yY2Vfb24gZm9yY2Vfb24pDQo+ID4gK3sN
Cj4gPiArCWludCBsZXZlbDsNCj4gPiArDQo+ID4gKwlzd2l0Y2ggKGZvcmNlX29uKSB7DQo+ID4g
KwljYXNlIERNQVJfRk9SQ0VPTl9UQk9PVDoNCj4gPiArCQlsZXZlbCA9IERNQVJfRElTQUJMRURf
VVNFUjsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgRE1BUl9GT1JDRU9OX1BMQVRGT1JNOg0K
PiA+ICsJCWxldmVsID0gRE1BUl9ESVNBQkxFRF9BVVRPOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJ
ZGVmYXVsdDoNCj4gPiArCQlwcl93YXJuKCJVbnN1cHBvcnRlZCBmb3JjZV9vbiB0eXBlICglZClc
biIsIGZvcmNlX29uKTsNCj4gPiArCQkvKiAnMCcgbWVhbnMgcmV0dXJuaW5nIHRydWUgb25seSB3
aGVuIGRtYXIgaXMgZW5hYmxlZCAqLw0KPiA+ICsJCWxldmVsID0gMDsNCj4gPiArCQlicmVhazsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gZG1hcl9zdGF0ZSA+PSBsZXZlbDsNCj4gPiAr
fQ0KPiANCj4gSWYgdGhpcyBoZWxwZXIgcmV0dXJucyBmYWxzZSAobWVhbmluZyBhIHJlcXVlc3Rl
ZCBmb3JjZV9vbiB0eXBlIGNhbm5vdA0KPiBiZSBlbmZvcmNlZCksIHdvdWxkIGl0IGJlIGJldHRl
ciB0byBub3RpZnkgdGhlIHVzZXIgdmlhIGEgY2xlYXIgcHJfaW5mby8NCj4gcHJfd2FybiBpbiB0
aGUga2VybmVsIGxvZz8NCj4gDQo+IE5vcm1hbGx5LCBhIGZhaWx1cmUgdG8gZW5mb3JjZSBhIHJl
cXVlc3RlZCAiZm9yY2Vfb24iIGNvbmRpdGlvbiBtaWdodA0KPiBtZWFuIHNlY3VyaXR5IG9yIHRy
dXN0IGltcGxpY2F0aW9ucyB0aGF0IHRoZSBhZG1pbmlzdHJhdG9yIHNob3VsZCBiZQ0KPiBhd2Fy
ZSBvZi4NCj4gDQoNCnRib290X2ZvcmNlX2lvbW11KCkgYWxyZWFkeSB0aHJvd3Mgb3V0IGEgd2Fy
bmluZzoNCg0KICAiIHRib290OiBGYWlsZWQgdG8gZm9yY2UgSU9NTVUgb24iDQoNCkknbGwgYWRk
IG9uZSBmb3IgcGxhdGZvcm1fb3B0aW5fZm9yY2VfaW9tbXUoKSB0b28uDQo=
