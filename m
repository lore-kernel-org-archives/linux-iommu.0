Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FA3EFD15
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145282; cv=fail; b=M72ZHM92kqudvhxg5QxQJYzHvYAwrfOLQZdt+zdDDGZNtSoE8fKV+E6o2YPPbPWswf03B4Q1ymluY9hYKooSASI12gEbX1V/UeO/Kf1S2RdAAcZWYNmT6a0lc2N3XbYdQoRXDwAw3dETD44KRKVexBi9Xw/6YK4pQghlict8/Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145282; c=relaxed/simple;
	bh=S45XgZ+rtGO33/XURUttTDxWefZHi6G2taAjoG6stJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShDHOMLqqqZmxukI8dJkKxrrvUfL1YeRvfxReERIcpJcBUMaWbYjd42d2vLJhf1lLY8a5y3OPLGHC6OVrTX+RNVUulCDITcQsnwwkwCDe6MdmGGMqFyIy4GxueBDwgN6pmP2aO/wRnsV+Q/5MXmuzM2L0/jdhbNn0l7iy+oM6go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGWsNucA; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGWsNucA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785145282; x=1816681282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S45XgZ+rtGO33/XURUttTDxWefZHi6G2taAjoG6stJU=;
  b=BGWsNucAYC4PGEbbJR+qCfVrUYXvzrjDEaYd+e2YWvEAF1lGgy1+9D+g
   YzIIk9i7BQdMOhcXrUkjy3ys3vlvbEF/YNIpov6CyUBQqkoRkBoVravU0
   FSbf9BFCxgQOuNbKoG94tzZrNtM3HFLjXAz1BAc8J561p5X/SvRBDqyHu
   pbWxrBfZudwqSlqr2r+ZU1PsjJrYYeAmRAY3LPVZdtRA5UWcDnHdZuL4E
   g2wPzBHU+OLmPyc6eDYuwb/OnHawiWljaiQibVm55D4j6DGnzKersl929
   wTKqieTOBfCv7aRTr2GBAliAXR3Ue7i4QLz6EXRb5hDlFQoj6TvCbukIy
   Q==;
X-CSE-ConnectionGUID: 7Ct1bsTxRIaVRy5NKKSw8A==
X-CSE-MsgGUID: T6bpchvfQJymB+r711otvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="97222002"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="97222002"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:41:22 -0700
X-CSE-ConnectionGUID: pJNUG019RZKVEIfBN4c+eQ==
X-CSE-MsgGUID: 4tAJtDJ5TXO7gEHxMFVPZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="258085671"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:41:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:41:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 02:41:20 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzDQK77703/D6ZCyNdf0SsXP/1B7Jdu1krPaszNQZB51986+YuXTPQ8vHqFmOY5ZkJUFPdCeOmQCYsmPQ0PZSujCBtWW9mq1in5IO5XcM+nO2HKLGg1Fdcnv5jAaJ4qwexR+ugqPBUKomS5fF6HqEPCT1j/zXYlMZ8YRcer3qfkkjeaDiKw0Zr+VqF76J9rpOmA02RnHQJBqtom7qEmVuNkYfI2aFHTw5PYRPFurXDmXr3texUcA59GMtHGr+EXZrZGQAV4yH04FFK9LWEDyn+cm31fIJ6gDAglM1GsCnGoUFo0wiiXnNsifxdnw1T5jGNyq/LB+7CHWbDr4xRgExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S45XgZ+rtGO33/XURUttTDxWefZHi6G2taAjoG6stJU=;
 b=E0ocs3AL3s9lKpIxta/9M6FOamzchqcyv6cIQGEig76iISND17qaBw9PWOqGgIvUfBE+FmCNQOF/myqCk2ggPKlWgCugBhWeTqVgNyBjjlbGVjirVmExCkqhdv0D/yRq84oQm9AQp/k62MUhtj93Rc2l6BHaahQjPvoNUyOtLjicTEB65kQL6GIGxM841hP5d1ywWK6Q7jwp2OcBeHaYp4hI/M3g3bBYnVz9mdPHH/bKANT1qv46knRowawkYMJ/Yn9ZBGJFH/GTT+HSKIJmKl+BxuaFr2+OYXtF113VhXlqEuGi4nLoIahN9Q++6svNF8q36QC2oscLgUnehySASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 09:41:18 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 09:41:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, Jason Gunthorpe <jgg@ziepe.ca>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "syzkaller@googlegroups.com"
	<syzkaller@googlegroups.com>
Subject: RE: [BUG] iommufd/selftest: KASAN slab-use-after-free in
 iommu_report_device_fault
Thread-Topic: [BUG] iommufd/selftest: KASAN slab-use-after-free in
 iommu_report_device_fault
Thread-Index: AQHdGb/x/hFgw3ttY0GKSPyUasVLvLaBJDIA
Date: Mon, 27 Jul 2026 09:41:18 +0000
Message-ID: <CO1PR11MB48353016C02FDA31BEEB274D8CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <D5E3AA41600B2056+f4e15662-bd2b-43ea-91cb-518de429e72c@smail.nju.edu.cn>
In-Reply-To: <D5E3AA41600B2056+f4e15662-bd2b-43ea-91cb-518de429e72c@smail.nju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DM4PR11MB7328:EE_
x-ms-office365-filtering-correlation-id: f4106343-f20d-4802-0745-08deebc33596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: P2B93HsP7LwU7EAwIaPZ+Z981v/IY8IcDp6zsLESWhdO+oknmNk/eIY33ai9cpict2m8zww8Jk1XXrbQAR2KJ9XUBviOBvdQkT2vZZ9sY6TQU82wh8ggskBMhZn0mUbR9+PWPAVXT2a6Tb8n29HyQCS/nq8fILTzhKt67n4tR6BVvbuUbLQq2+MbkdrVbOFwYWrKasoQ5MkcZYaarhr9VmAS8YDvOaOtxnR+AQiFS+e7Q3bZ7WU/kgCP4KNYHDvxXV4gW9BxDy+wG4+kMNRyT/KjjcagSLblKBrmOKFM2E4sHJFr/Hj8zOxCtsF0mDiNUQYvYNNOab08hOWUGkJlC8rLg5yIeuoPLnSA9P4wLhdk3eJg/zVrO7DldX8yuZZaU3/hg6OswDhz6NokHXLQpLwrd7dixJ4+Bx0PjZxDmfa8AKV4l+hK1mQ00qP9o6sG2QZ3pzd5VJ2QOxP7hr+mMZnLPvOPwJC+9r52Fa1PAgqI2aswIr4MT9uCB/0IKGPXjyr/PhL8rLs9Ny98Y6wzN8g54d9g5hHEawXdTyFY6N9zYugxyDsu2v/HmoFWSmLRYm18DVCfOzu+G/QkbYCOPKvEA8aIRTWllgOhmSMOMdB9QFkQax6CFzRM8XV7o8frnnZHTUfSSZMi8k5PEYbYoithI1Ta+ypJ7uDDgw+tEkBjIk3sdnIjHyKtF9AazCEW99i6q3UGGAe5vlAiTRMtyl5aKEIrCMc1vp4yuCgM6t0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUxiOUR5V0dzTldoOGNHZnpUc0tmOFRSZDVSNE9wL2ZVR2IyamNzM3NmMVVn?=
 =?utf-8?B?Sm0yMlI5Z3JxRjhsY25TMVQ4YXJmMlJ2cVg5alJFR2xvSSsraHB1cDNPSzNQ?=
 =?utf-8?B?QWFsb0Z1Y3NsdVB1Wk9vaWlDa1ovTnlTM0RMT2RMMjA4bWxEakJOY29YeVpr?=
 =?utf-8?B?YzVOVlNUSmMydE9RT0ZPcitpcjZ4VlF1KzhpQjhOT0NvUEo0cktPbi8yc2JM?=
 =?utf-8?B?dDRUSE1TK2xYVytReEtBUk0vUlhJdi85RXJkY2RaSndWWm05cmFnMGdoa1Zv?=
 =?utf-8?B?WXRHSmY1dTdUeVJRNjg5Ym4yOUZzWEJ2MkRRUk1KeXUzb3QzTkg1Uko3MFFI?=
 =?utf-8?B?dXVyOWlhZkw2eDlRNnltTEF4dFE2U3RCdCtIWGhsb2RNUCt3d2pjWnM3Vkt5?=
 =?utf-8?B?bzRNQm1mNXJ2K3hvUmtKRkFKUjJSbkVaZCtseHMyQ2J3eFRsV2JpUXdFMHVC?=
 =?utf-8?B?UlVXZFNsQlNJSzg3dzQxVXNTRDUzL2ppMG9QOEhGVmZHVGp1MUdLT1UyT2No?=
 =?utf-8?B?VkVnVUQ4VFlleDk3WVVGMGhrenpBTHk0OUxBS2tvZEtoMldwbGY0dzVRREc0?=
 =?utf-8?B?MXRhQ3NMZVF0Z0N6a0x3S2Y1UDFJMWF6WXhOellubUg5ZHhDV3ozTmtTK29C?=
 =?utf-8?B?aWJTWURiNm1QODFMallYd3FFR0tyZWlaSTNhdGJPcXg3UUUvbnVYeGZETXkr?=
 =?utf-8?B?dldVMTFWdEt6dHpCZWN1K1kzOG5RL2ZOK1dVZXhOY1FLR05vYWd5aFM0UWRw?=
 =?utf-8?B?MVI3TCs1WnF2TFhQQ29jUFMvaUxkMEtmU3BxbDJPUHVIeFp3aHRaMjVkM00x?=
 =?utf-8?B?bjdTNWE1VFhUeXhCQ0RzZ2RvSmhDYjN4SkRXbUpRbllWQVI3b1A2dTRiSDhq?=
 =?utf-8?B?c0JPMmpZbUpSM3BZTi84VFcvZDJnMzk1Q1pMU081R25CU2hES1pHNlczUVc3?=
 =?utf-8?B?Zlg1cEIxMEtTeVlvbmVNajBHZ0M5L3dCekZBNHR5b0o5QndGWDkzMTJRdlgy?=
 =?utf-8?B?Nnh2MmxXYUsyNCs4NkF2aU9xejU2U3o2SFBaS0dSSXZ6bUk1NXFHSHVEd0hp?=
 =?utf-8?B?eVBZVjF2VVBnbXVUYitmQ0trNnpya0xpYTJyNTJ5TjlNU2w3Mm9PRDRlSi9Y?=
 =?utf-8?B?cHFSN1pOWGJTT1l4dTZZaGQ0ZnBlVlRodE9pTXRjcCtJRzhnclFsNER1OS84?=
 =?utf-8?B?K20zem9wNkxhRm8ycWF4RkYwNUR6WXIvSjhCZElRSy9IZ3l2am9saHFnQnMv?=
 =?utf-8?B?TThJYlhKdnpsOW1Tb3lHMUJYV2RvUDVTQTBTdWxRbTEwbzRVSDByUXpEaWd1?=
 =?utf-8?B?QmdmL205NXNsOEZFZndLWEJEWkxtcW16dGQ1K1dyY3pBVGVtL1BBZDVXK2gx?=
 =?utf-8?B?b2RHcmQ1My9nTlBUcVRWN01tN2VRRUQwZnk5ZEF3R2wvZk44bnNXZmYycWFG?=
 =?utf-8?B?ckUxcmxmYjVsY2czYWVwQ1BuSDZDd3BFUnFEQWZJQm4waDJPYWpVd2MvWjZH?=
 =?utf-8?B?UEliY2kxVU1kWDFtK3VNcnEzNkZFZXNVSlROYW9KRng2RVJCY1JjZUV0cWl2?=
 =?utf-8?B?RTVBanlMOXB5QXpNVE1hM3lOMWJLaGs3SUxBN1ZCUEdRTTNrU0d6N2o2SVU0?=
 =?utf-8?B?dHFPRlFqS0FjemVEVWlJS2VmNWxzK0dxMCtRWStXTWxYWWlkRk9Rc0wyU3Ay?=
 =?utf-8?B?dnRMekRoYnVkTTBWTFNSSk9jMTR6QmtYbCtKWitOTWZndmhONGJnRCtPaWE3?=
 =?utf-8?B?WWt1bkVSWGxHWmZQOHlxNXpkWnBZUjFTelBMZGQxM0NmcVVhdHNrUDZUQkdx?=
 =?utf-8?B?WkRHT09FZTlxU0xodzFZN3Z1TVFhNmY4K1E1MDVlV1BIaVNOcFB0WmNqOXFF?=
 =?utf-8?B?dTlBUTltcmdXTTBwWDdDL2w2WVpvZkFlendxM09PalpwTVhVeUV5UFlTSGo0?=
 =?utf-8?B?VVEwMHFTeEVHTzVOMmRQajBRbDJlWTVDdEsvanV6Q0VoZC9FTEFWRG01TVVU?=
 =?utf-8?B?UHl4R2YvOTM1OGVuQ1VLclhBTVltbU9CLzhMNDVjRVlDbnhmYTFrZHQ3ZGU4?=
 =?utf-8?B?SWZzcERGeFhndldIclQ2SlZBbnB6OWZSYU94Nk45M3pwZk9KdXVzcnVqNWlw?=
 =?utf-8?B?MEM1MEtEaUlaQUlkQXE2U00rYUdaemxTK2YyYytTUFh5RjhHU25CWDltNlUw?=
 =?utf-8?B?aGM2Sko2eHZYZFZxWXI1S3l6c0dZUVh0WG83TmlyQ0FENksrV1BFTjNOclkw?=
 =?utf-8?B?Mm5wbWlqWFdscUxDSXViRXpKanhEd2lOdUYwN200dG43bGEweUp2M3lFaW53?=
 =?utf-8?B?V1E4MjRkbGZRRnVjUjVFbkt0S29TZkN5Mm8yRDl3YnZLMGFGNHdSQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y/otmT4l+6gAvfvFPrKQ/boCsRw6502M5WUO6weUaeWM6CtDtvz8O7XtboEwXT86hXBC79oS5d13wrhRgmbxkGTPg5aQoEGKRwL3yenOB8ANSewMS4PKVUnxhGsVkCu/P5yWKj713kjVTMHGz9gwqAzuN79z2GdeBgAYM1x/5w8/RIEJXO3waQp8C6WIBBvEu4Agjkw9KNuOlGi69NbryZjNbzs4vmLtXUg4XLFHAn0qAsd4RNLNT39hqUF7UD2nLpCZJbSHrq7/h4Du2eO95JpYFtoDzH+awC/L3NE69Jl9eYuRNLV0HxCjsshDXvf1eRqrnZzNZvt5yclPE1eXGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4106343-f20d-4802-0745-08deebc33596
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 09:41:18.2724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjTSxXmT5HuRrEFS9x6lYObKg2eqHXrfSUYHmoReyd1jUYh0yHThOJadsyxXFkX/rVwO0qcGPnBzgOO3djvcuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com

PiBGcm9tOiBQZWl5YW5nIEhlIDxwZWl5YW5nX2hlQHNtYWlsLm5qdS5lZHUuY24+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgSnVseSAyMiwgMjAyNiA1OjUyIFBNDQo+DQpbLi4uXQ0KID4gU2luY2UgaW9t
bXVfYXR0YWNoX2hhbmRsZV9nZXQoKSBleHBsaWNpdGx5IHNheXMgdGhhdCB0aGUgY2FsbGVyIHNo
b3VsZCBiZQ0KPiByZXNwb25zaWJsZSBmb3IgInN5bmNocm9uaXplIHRoZSBjYWxsIG9mIGlvbW11
X2F0dGFjaF9oYW5kbGVfZ2V0KCkNCj4gd2l0aCBkb21haW4gYXR0YWNobWVudCBhbmQgZGV0YWNo
bWVudCIsIG1heWJlIHdlIHNob3VsZG4ndCBhZGQgZXh0cmENCj4gbGlmZXRpbWUNCj4gbWFuYWdl
bWVudCBtZWNoYW5pc20gYXJvdW5kIGlvbW11X2F0dGFjaF9oYW5kbGUsIGluc3RlYWQgd2Ugc2hv
dWxkDQo+IGZpeCB0aGlzIGF0IHRoZSBjYWxsZXIgc2lkZS4NCj4gDQo+IEZhdWx0IHJlcG9ydCBj
YW4gcnVuIGNvbmN1cnJlbnRseSB3aXRoIFBBU0lEIGRldGFjaCBhbmQgcmVwbGFjZW1lbnQsIGJ1
dA0KPiBiZWZvcmUgdGhlIG9sZCBhdHRhY2ggaGFuZGxlIGlzIHJlbW92ZWQgYW5kIGZyZWVkLCBt
b2NrZGV2IG11c3QgYmxvY2sgbmV3DQo+IHJlcG9ydHMNCj4gZm9yIHRoYXQgUEFTSUQgYW5kIHdh
aXQgZm9yIGluLWZsaWdodCBpb21tdV9yZXBvcnRfZGV2aWNlX2ZhdWx0KCkgY2FsbHMgdG8NCj4g
ZmluaXNoLg0KPiANCg0KeWVzIHRoZSBtb2NrIGRyaXZlciBzaG91bGQgZHJhaW4gaW4tZmxpZ2h0
IGZhdWx0IHJlcXVlc3RzIGJlZm9yZSB0aGUNCmFjdHVhbCBkZXRhY2htZW50LCBqdXN0IGxpa2Ug
b3RoZXIgaW9tbXUgZHJpdmVycyBkby4NCg==
