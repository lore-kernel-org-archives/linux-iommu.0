Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525551E9B0B
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 05:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744263003; cv=fail; b=l04D8UE5w6UbgbPwsvSy6oAD73YTepOMag0Y2w83+578imI8NrpaihgbTnvGCvyYE4+Si08KsEGCQ64gF5mb6AdwyDhWUowqMbd4lZwts/mGHT7lTBNRA9a9mltvGeWDYQHJ2e/Do2OrqM+dhHT4IsTs4h6jBicf1Npo0AM3LIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744263003; c=relaxed/simple;
	bh=3vm6RGuJsRjkD5SlSPl+Oc77V6o7Jk+W/MLksi0/XiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LNPcLeJjRdASB0DdJl90iMi+cuvva1Bj9XMFyVnV2nktyXY+spfHru7BxDa7FKWWggZs1ewLhbVQHfTVK5W3DCqyka8rlsZvyyky/vRXZN2JQrNUFkPXyLXg2uV2gzfBMyMes271GemkCuupmmse9WfUUYEW1986PmPQWZyZ+Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXWD5l4a; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXWD5l4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744263002; x=1775799002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3vm6RGuJsRjkD5SlSPl+Oc77V6o7Jk+W/MLksi0/XiM=;
  b=bXWD5l4aDU9GXIjON4R5M4Dysw97jM4cbFEVDf6ozF+b1gARYTPMJi3R
   HueHfA1yry2nXPMCNxvAsKsJujCJ7qs+bN+1B5rfxoMfDEab94wJgJb0a
   yzKzz5e7gOeA0SMH2a/giWpRYO/QANpnL+OhsCZG4bbzIyhtK9FgQVoHf
   wbit/86zHbnN3UlLc4zUN16YiF4W1ojNtfMibkyKsM8zKcZEyTZ20K6qD
   gqt5yu7yy3bwge6F0FTWuLWFwUKdQX1GjcbEXV7LbcocwwNAsXS4GCClr
   B4FPDnexi+KmXW10fFOsX3f7V3P/PwguPEgCIoZ2aHuBAYayw6K5jkTK0
   g==;
X-CSE-ConnectionGUID: /GTzCz+8RHW5p0KVJmyCaA==
X-CSE-MsgGUID: G4104OGHSB+K/aMeNtDl/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45658533"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45658533"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 22:29:59 -0700
X-CSE-ConnectionGUID: 6pqcXf4hSqawVioRUQOQYQ==
X-CSE-MsgGUID: k1hGfS6IQBaVs+lNPomWZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129736172"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 22:29:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 22:29:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 22:29:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 22:29:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3IrLaxlc9/rx0ocPZ+8dairtstr8ooDxtqNkLFe7uPdVZpaEuH/PiOqYUW5oYZj48MbPoJjK4zHBE/ww/9nafrQtLVCXKNexT+Lp/Yc6ZjcToRtlmanfShDbdEHOtezd3HyPKLKVZ5g28Q9JxJtIjC31YElN57oiJba6fvGcjr+qXJCvhVLvRiOo0dX2UxzBxRH7mt218w3B5nAEAGf741tKY2YSHoQRFu61XZgbmBV9T1tdGtBtMRg+AcPn7auUnC87cTCL/5ZxgLhtdU7/U96rP2BO97BO2tgtBSeLIm4vKt+sVG2I83nxo45t/mbhogo1TKOQ6jlDmHGPlvN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vm6RGuJsRjkD5SlSPl+Oc77V6o7Jk+W/MLksi0/XiM=;
 b=nOtkPNrkP5q8m0tJ/GKqA9LBeJGLlvnAreUuBHp6kzT/NRjjFyQueC7wrYMX9FU1P4FgD5+EdCPKz5Zox8f1uCK90i9teax7AvCAyw4Kx20AP6v18qnIl3C9s5+db78DGaB9CGe2XXMrF+QOgy/lh1txHfIKTsGieYwnn13WMhoYP3jpK6m+V8jDe0yM8M9cGfRe6nRKMocBnzP1AaunU/QswbopB8sOnicu+ChxOq3ne3FMIaCjRkZzLP3paPIhx7V2xBiX4s4VS0MyHnEpS7DNbvDol8PLoCOFFdtdKSYdC70RifAlYRtayg51Em2OEg9+t4SQ67quJqj01ffwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6350.namprd11.prod.outlook.com (2603:10b6:8:cd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Thu, 10 Apr 2025 05:29:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 05:29:51 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Fedor
 Pchelkin <pchelkin@ispras.ru>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Nicolin
 Chen" <nicolinc@nvidia.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH] iommu: fix crash in report_iommu_fault()
Thread-Topic: [PATCH] iommu: fix crash in report_iommu_fault()
Thread-Index: AQHbqM4GgAWYHJWWYkenlrWHmHQS0rOaS4UAgADodQCAASs4cA==
Date: Thu, 10 Apr 2025 05:29:51 +0000
Message-ID: <BN9PR11MB527618FFDCF2D7287C3ACA028CB72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250408213342.285955-1-pchelkin@ispras.ru>
 <20250408213828.GC1727154@ziepe.ca>
 <74c07104-d072-4d2f-9b79-d9a1c3f2bc54@arm.com>
In-Reply-To: <74c07104-d072-4d2f-9b79-d9a1c3f2bc54@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6350:EE_
x-ms-office365-filtering-correlation-id: 24782f09-08b4-49e2-6e2d-08dd77f0b798
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cm4vVUVCSEgrb25LL1RZaDhnZzhqdjhvU3Bnc0ZFT3V2YlowbktJNEY2N2d6?=
 =?utf-8?B?ZkM1YTJoaFhzdWdBVGlZejRwaFdodktXUjlPdTdoR2ppK29ObmFrTG9kQTdI?=
 =?utf-8?B?MFcvY2xLVWVOWGNqU3UyTTRuL3hyVEVJbzB5Q3lFM0Zzc0VaVDdVcFRRendq?=
 =?utf-8?B?OHlpVzJNOVZ2ZE5qNnAyY29FL0Z2MzdDZHZzbzVJelFzak82aDV1V1RiaXh4?=
 =?utf-8?B?RjliVmJ6Tnh1dDZMNE5oZlFuczFTekZPUWw5QVZSYWRJQnFlZ0pnS1gwMlBF?=
 =?utf-8?B?VmxJTkM0eGtIZUtZM3VLT0hCeUw0T09aT1lqdXlkKzk4SG9xZVRPdWo4RkRa?=
 =?utf-8?B?cEF5cThOelYvWnJyemp1WGN3ZDNXVGVFb3V4QXBWVHdXKzVaY0wwQjY0SUMy?=
 =?utf-8?B?SkM4VWgwdXZjRUpOeWVneGpIVGJKVnJlNXllT29mQkEzcnFNdHo1K2xjUzVX?=
 =?utf-8?B?ZGF6RVZKMWk0NzFkN3pKR2NjVzJxMExHblBCUGhvZ0V3NmxHZUwwTXpGMnBz?=
 =?utf-8?B?SHV3aVowWmozNnZrSUxwM1laUjROKzhSa0s5S3l1djBTdk5FOHNpVjUzTW50?=
 =?utf-8?B?K1V4QmRabEs3N1NydkZzbkJIQUVEUFlocGZaUG80eExMVVdFbFZPREJMcmt6?=
 =?utf-8?B?dC9GcitCWFg5SU1iR0hEYm5pMlVIQmNTSTBDcG1ESnZnK3cyR05uYUFxWkFi?=
 =?utf-8?B?aDZjY1RrNnNYeTNTeHZiTm52NkxXV050Z3pTRG83Y3NTc0RXSUNOZWUyaXdN?=
 =?utf-8?B?MHBOU0dtZjZtMkNJemxxMmtnL1RvTTg4NUtiVDNlTS9uaytKVFZSKzZpZFdC?=
 =?utf-8?B?MGRsTDBIL2FYZ3dtS2FTVEwrWjl1cm93YzgzMUkwRnFOTWZkNlNraUgyU1hQ?=
 =?utf-8?B?dEpBTjRTMllia3h0ZHFNcGlmM2RiOFdWWjk4KzBZYkhqb3RoU2FlSnVONVlr?=
 =?utf-8?B?WS9tbEJkb2JyUXkrMm5QT2ZONFRGUkZhWXlram13eC8wdGxtM2EyZXFtbjFD?=
 =?utf-8?B?aVpIRlc3blBiWUJ5VnA4U3F3SFpvK0NCQS9OMjZ3U2h3eHdrNDVzNi9Od0JU?=
 =?utf-8?B?UEFLU1BqUXJEenJPTWYrTnpWRUVUc3E2TDVMQTVTNnVsblhEaXI4V1l6NWxy?=
 =?utf-8?B?K3hsT3kzS0F1OE1yYlBHemlLYUNxajhlRUM1N3pRV0V6azRHKyt6STRpNUpy?=
 =?utf-8?B?VWYyMjVhQmlIS1hCdnBQNjYyZ1UyT216QWJ6K3dGNkNSZGJ2aXpWTDN3NFRz?=
 =?utf-8?B?amJlaU1BVDVZeFVNaFcyTVI4TjhOV1B3OHl1LzJxVGtqTzhDN3g1UE5QU002?=
 =?utf-8?B?UU51TSsrWUowUnpyL1pjOXhHS3h0SHFBZGdZa3ZXNTRGZW1DTWpOT2dnK0tQ?=
 =?utf-8?B?WXBQOHhBRXVxZzc0RUEwSjZwTE1neHZhOGlXU0JwUDlxMkpOZ01NSG5rKzlO?=
 =?utf-8?B?cDBsekF0cFlBY01jbzhQMUFQS0dqYXBYM1lGbTBtclUxbG0xM2JoZWl1OE52?=
 =?utf-8?B?Sy9SL1ZKUjhsWHRFYkEyc3MxUCtiOHBLSy85MVRoQXAxL1ZXckhKdWd1Z3BT?=
 =?utf-8?B?OFcrTkw4OHZSQUp3eVhQQVV2OHhYalRZNUtyOXgzRUltaXgwRjl6QWtmUUFp?=
 =?utf-8?B?S0p6aGhhMm8vY096SDdzTkFRc2tFUDRJRGQwRDYyQS9GT0RxcGcvQzdTcXBu?=
 =?utf-8?B?UnNPVnRUYU8zNDFuVFZQdVV3V0xxeVRhWFUzK0lSWjNKajJsaDd4ekFQRTlG?=
 =?utf-8?B?UnEwWGRvdDV0VUhUYkZRUHFqMTJBYXRBaVFUY0FBOUZjMVZwMjJKcSsxb25q?=
 =?utf-8?B?b1l0dVN3QzBZL3ozL1psUDIxMHhIdzRDWWdBRFpoVXVya3RtNVRhYVRObzRL?=
 =?utf-8?B?MG9GYUFmenpUZ0JuYm1DZlM2ZE9MaFZHa09zMVlDc2xpMThMVTVEM1lYb2dx?=
 =?utf-8?Q?0vvCu963r3+M3suEzcFkEIRk7N0yaB93?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enBJb0pMZklrVncyNnhZRTdFcFFaYlluREd3WEVPSEtxZjJoMWYwdHNlV202?=
 =?utf-8?B?ZFZzcXdGc05OaXdSWEtLL2JkZmhwak1JVlQ1MHVDLzVUUzk0R0FpSDk5c3lx?=
 =?utf-8?B?dWtHdnZzeXc2ZFc5cy8vU1praWV5ZHNMTTk3L1hhUHRoSG9qT2RjcUNvTTRL?=
 =?utf-8?B?NWltM0cydWg5Y0NOcEVxc0oyOVlwUVpFaU1pVU1KUVdWNVo0UGI0QzRsbFMw?=
 =?utf-8?B?Nkc0cGE0QWx5MnRPVzFDZlBKZk45SWpWaWVFNkM1dGR6OVFEZkJIL1E0UDJH?=
 =?utf-8?B?TkFXRXk4MllUSmZiUGtOTUVJREZ1d2txcFBMVU8wcmFlb1IzTHFLR280SEVs?=
 =?utf-8?B?b1ltRkU3dGFxMGlaRElobTFNdzVwOHg2MHZGUGs0SGZuQTR1eWRYS1VxbENz?=
 =?utf-8?B?b0FObitrSFV2WlJOTTlocFNRQ2REdXVOdWFEOXkwTUh3L1I1MklvcktsSTha?=
 =?utf-8?B?emZTNkYzWjNuRkYvS0dhNkRDL3FjRVlNOEFyUlc2WXZqWmMrK0k3Z21YcW9o?=
 =?utf-8?B?dlU0ZFpSVS83S3FtOVFrOUY3L3JLSXh1Y0R2ZFJoYkp3Nml3VWxOSlAza0lM?=
 =?utf-8?B?S1YyVEFZSW52eW9hNENEakZkZWxwc01XMkc0bzBZdGdMeWNEN3RnYlUzQXVO?=
 =?utf-8?B?NDBKb2pkTkRWQm5aN09HWld0T2dyQUozSUgyajdocE9NRm1mWjBid0d4ZkVH?=
 =?utf-8?B?MHpqVmZIN1VHR1hrUXJSMEFYWHcyOHQvbHZrRG5XOFdhbmlRNmxqOG1pUVZ5?=
 =?utf-8?B?RUNHdUtPamxvSmhLb09XOFpwV3AyYStnYk43Q0JUY3F4cFVEeDFhWm40UFRE?=
 =?utf-8?B?cmN1R0JGRUlIeWRIbzU1ejlLUXZZNXpoM3JyNS9jMFA3NndCSU1sdURjWHhN?=
 =?utf-8?B?RUxJYVhQVGk3VmoreGc0NGd2N2hkUjl2anlPaGVoZzlDbFJZVUdOSEJWeitJ?=
 =?utf-8?B?amJqZzczNTZUanlrbHl6b0ROemdXTTJBTzUxSmFUbHZBU3RiSzdjQTBtbGkr?=
 =?utf-8?B?ZndSSHVJRjZBM0w2aGpvaGJncWV1WE9JMmdZMXZDR1N3ejBORTloemsxdXEx?=
 =?utf-8?B?aGd5a0VNdWtUQWtjMm1YWWxPRmlYZE95dVZoc1FmT2tmd3VScnlSVVdxUTBL?=
 =?utf-8?B?V0tYMGhJTEt5d0FvUFQ5bHhITWxVZTI0UTBnTHJveHl4b3RMUmFZV1psNy9K?=
 =?utf-8?B?cUJtYWVHTUJ0dU45RmRDdVgva1p4K2lwY1hlWXNERU1VczNFR2F0VlFNUzVW?=
 =?utf-8?B?Z0RyaXp5Nks0UTRnNkx1TnlGd0VWZUg5V0pJVGZjUmdUUUxuZzdVRVlndjhJ?=
 =?utf-8?B?SlUvbVpNVXdjVGg5aFJDUDJwYisyMDFWVWdBT2h5bTJsZWJ0TzlKdWFuY20v?=
 =?utf-8?B?OXpjMlNUTTVFelZIbm5NcFlwYWQzTXVUMG85RVd2TmdaSTByWFl6WEFrZVdO?=
 =?utf-8?B?b3NjZndhSCt0aUNGeFFyTFBCLzl6aVVtNVFMRnJDQ05NWnVPODlTMzZmdFht?=
 =?utf-8?B?eVZ3TGtHWHFramswbTBSMTRHendxMHcyUHpDSWtaWUxwUjZ4QXdycTJ6VmQ0?=
 =?utf-8?B?UmZuTTl3THR5Q0t1bWJ5cnF1NVdJTm9hZEdjUWhHSFU3TEJ5VE9OSGo3YnhX?=
 =?utf-8?B?TU1pZ2oyc0JRclBJNHR3Ny91ekRodlpVa3YwSG8yR1Irb21pc2ZsMkxLMVYz?=
 =?utf-8?B?S1F3N2tPNVpoS0xQcmlEYTNZSlo1Wi9MVXhYN0YxNEc0bExlMUE0MkczV2Ix?=
 =?utf-8?B?dDN0aVVxUXRyQ0ZCaTRzbmZwNjVpeEw2QTQvWWJEdFBlL2FuRy96UURXanFJ?=
 =?utf-8?B?c2EzZ0R0Mmx2YnNSQ2N4V2puZlJqT3pvNWYwbkR2Uzh5K2VvbG9JakdFNlJR?=
 =?utf-8?B?V09nS2t3Z25pMlIvSU1lU0tHOGcwL2JpVXVaVUdKd2FhMTM5eFBrdUg3K3JT?=
 =?utf-8?B?SklDVzJobXJJTzRqbWpUU0NlNFBuWDhxK2dYc2lyZ2FLV21oNVVhNVBMOGRK?=
 =?utf-8?B?UEJCY2dlT0t1eTUvbmpOZVhLa2UxNXkwMWdJeSs0ckJYL3JTVXVnUk15TzlT?=
 =?utf-8?B?YmMwQXNNOEtqa3huaU1JNTkwcnR3S0dleWxMRzdLeDNEeWc0OUhqYitVMGox?=
 =?utf-8?Q?LaCFsgp/q3JVqvOA4Or5k6IN2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24782f09-08b4-49e2-6e2d-08dd77f0b798
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 05:29:51.2079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qm98BK0nPyERVh9d9KxGjxwc7U/eoHZhSkvyVZap9DntQL0kHL8VBe+7svyhMytKQiGb/hv7LAnDYLRFpdNUlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6350
X-OriginatorOrg: intel.com

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEFwcmlsIDksIDIwMjUgNzozMCBQTQ0KPiANCj4gT24gMjAyNS0wNC0wOCAxMDozOCBw
bSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+IE9uIFdlZCwgQXByIDA5LCAyMDI1IGF0IDEy
OjMzOjQxQU0gKzAzMDAsIEZlZG9yIFBjaGVsa2luIHdyb3RlOg0KPiA+PiBUaGUgZm9sbG93aW5n
IGNyYXNoIGlzIG9ic2VydmVkIHdoaWxlIGhhbmRsaW5nIGFuIElPTU1VIGZhdWx0IHdpdGggYQ0K
PiA+PiByZWNlbnQga2VybmVsOg0KPiA+Pg0KPiA+PiBrZXJuZWwgdHJpZWQgdG8gZXhlY3V0ZSBO
WC1wcm90ZWN0ZWQgcGFnZSAtIGV4cGxvaXQgYXR0ZW1wdD8gKHVpZDogMCkNCj4gPj4gQlVHOiB1
bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFkZHJlc3M6IGZmZmY4YzcwODI5OWY3MDAN
Cj4gPj4gUEdEIDE5ZWUwMTA2NyBQNEQgMTllZTAxMDY3IFBVRCAxMDFjMTAwNjMgUE1EIDgwMDAw
MDAxMDI4MDAxZTMNCj4gPj4gT29wczogT29wczogMDAxMSBbIzFdIFNNUCBOT1BUSQ0KPiA+PiBD
UFU6IDQgVUlEOiAwIFBJRDogMTM5IENvbW06IGlycS8yNS1BTUQtVmkgTm90IHRhaW50ZWQgNi4x
NS4wLXJjMSsgIzIwDQo+IFBSRUVNUFQobGF6eSkNCj4gPj4gSGFyZHdhcmUgbmFtZTogTEVOT1ZP
IDIxRDAvTE5WTkIxNjEyMTYsIEJJT1MgSjZDTjUwV1cNCj4gMDkvMjcvMjAyNA0KPiA+PiBSSVA6
IDAwMTA6MHhmZmZmOGM3MDgyOTlmNzAwDQo+ID4+IENhbGwgVHJhY2U6DQo+ID4+ICAgPFRBU0s+
DQo+ID4+ICAgPyByZXBvcnRfaW9tbXVfZmF1bHQrMHg3OC8weGQzDQo+ID4+ICAgPyBhbWRfaW9t
bXVfcmVwb3J0X3BhZ2VfZmF1bHQrMHg5MS8weDE1MA0KPiA+PiAgID8gYW1kX2lvbW11X2ludF90
aHJlYWQrMHg3Ny8weDE4MA0KPiA+PiAgID8gX19wZnhfaXJxX3RocmVhZF9mbisweDEwLzB4MTAN
Cj4gPj4gICA/IGlycV90aHJlYWRfZm4rMHgyMy8weDYwDQo+ID4+ICAgPyBpcnFfdGhyZWFkKzB4
ZjkvMHgxZTANCj4gPj4gICA/IF9fcGZ4X2lycV90aHJlYWRfZHRvcisweDEwLzB4MTANCj4gPj4g
ICA/IF9fcGZ4X2lycV90aHJlYWQrMHgxMC8weDEwDQo+ID4+ICAgPyBrdGhyZWFkKzB4ZmMvMHgy
NDANCj4gPj4gICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+ID4+ICAgPyByZXRfZnJvbV9m
b3JrKzB4MzQvMHg1MA0KPiA+PiAgID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4gPj4gICA/
IHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0KPiA+PiAgIDwvVEFTSz4NCj4gPj4NCj4gPj4g
cmVwb3J0X2lvbW11X2ZhdWx0KCkgY2hlY2tzIGZvciBhbiBpbnN0YWxsZWQgaGFuZGxlciBjb21w
YXJpbmcgdGhlDQo+ID4+IGNvcnJlc3BvbmRpbmcgZmllbGQgdG8gTlVMTC4gSXQgY2FuIChhbmQg
Y291bGQgYmVmb3JlKSBiZSBjYWxsZWQgZm9yIGENCj4gPj4gZG9tYWluIHdpdGggYSBkaWZmZXJl
bnQgY29va2llIHR5cGUgLSBJT01NVV9DT09LSUVfRE1BX0lPVkEsDQo+IHNwZWNpZmljYWxseS4N
Cj4gPj4gQ29va2llIGlzIHJlcHJlc2VudGVkIGFzIGEgdW5pb24gc28gd2UgbWF5IGVuZCB1cCB3
aXRoIGEgZ2FyYmFnZSB2YWx1ZQ0KPiA+PiB0cmVhdGVkIHRoZXJlIGlmIHRoaXMgaGFwcGVucyBm
b3IgYSBkb21haW4gd2l0aCBhbm90aGVyIGNvb2tpZSB0eXBlLg0KPiA+Pg0KPiA+PiBGb3JtZXJs
eSB0aGVyZSB3ZXJlIHR3byBleGNsdXNpdmUgY29va2llIHR5cGVzIGluIHRoZSB1bmlvbi4NCj4g
Pj4gSU9NTVVfRE9NQUlOX1NWQSBoYXMgYSBkZWRpY2F0ZWQgaW9tbXVfcmVwb3J0X2RldmljZV9m
YXVsdCgpLg0KPiA+Pg0KPiA+PiBDYWxsIHRoZSBmYXVsdCBoYW5kbGVyIG9ubHkgaWYgdGhlIHBh
c3NlZCBkb21haW4gaGFzIGEgcmVxdWlyZWQgY29va2llDQo+ID4+IHR5cGUuDQo+ID4+DQo+ID4+
IEZvdW5kIGJ5IExpbnV4IFZlcmlmaWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpLg0K
PiA+Pg0KPiA+PiBGaXhlczogNmFhNjNhNGVjOTQ3ICgiaW9tbXU6IFNvcnQgb3V0IGRvbWFpbiB1
c2VyIGRhdGEiKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBGZWRvciBQY2hlbGtpbiA8cGNoZWxraW5A
aXNwcmFzLnJ1Pg0KPiA+PiAtLS0NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBKYXNvbiBHdW50aG9y
cGUgPGpnZ0BudmlkaWEuY29tPg0KPiA+DQo+ID4gVGhpcyBzaG91bGQgZ28gdG8gcmMNCj4gPg0K
PiA+Pj4gaW9tbXUtZG1hIGl0c2VsZiBpc24ndCBldmVyIGdvaW5nIHRvIHVzZSBhIGZhdWx0DQo+
ID4+PiBoYW5kbGVyIGJlY2F1c2UgaXQgZXhwZWN0cyB0aGUgRE1BIEFQSSB0byBiZSB1c2VkIGNv
cnJlY3RseSBhbmQgdGh1cyBubw0KPiA+Pj4gZmF1bHRzIHRvIG9jY3VyLg0KPiA+Pg0KPiA+PiBN
eSBmaXJzdCB0aG91Z2h0IGFib3V0IHRoaXMgaXMgdGhhdCBpb21tdS1kbWEgaXMgbm90IGludGVy
ZXN0ZWQgaW4NCj4gPj4gaW5zdGFsbGluZyBhIGZhdWx0IGhhbmRsZXIgZXZlciwgb2theS4gQnV0
IHdoeSBkb2VzIGl0IHN1cHBvc2UgdGhhdCBubw0KPiA+PiBmYXVsdHMgd291bGQgb2NjdXI/IEl0
IGlzIGEgbWF0dGVyIG9mICJjaGFuY2UiLCBmaXJtd2FyZSBidWdzLCBhYm92ZXNhaWQNCj4gPj4g
RE1BIEFQSSBhYnVzaW5nLCBldGMuLi4gaXNuJ3QgaXQ/DQo+ID4NCj4gPiBZZXMsIGl0IHNob3Vs
ZCBub3QgaGFwcGVuLCB0aGlzIGRyaXZlciBpcyBjbGVhcmx5IGJ1Z2d5Lg0KPiANCj4gUmlnaHQs
IGl0J3Mgbm90IHRoYXQgd2UgYXNzdW1lIG5vIGZhdWx0cyBjYW4gb2NjdXIgYXQgYWxsLCBqdXN0
IHRoYXQgYW55DQo+IGZhdWx0cyBhcmUgKnVuZXhwZWN0ZWQqIHNpbmNlIHRoZXkgcmVwcmVzZW50
IHNvbWUgZGV2aWNlIG9yIGRyaXZlciBkb2luZw0KPiBzb21ldGhpbmcgd3JvbmcgaW4gYW55IG51
bWJlciBvZiB3YXlzLCB0aHVzIHRoZXJlIGlzIG5vdGhpbmcgYSBmYXVsdA0KPiBoYW5kbGVyIGNv
dWxkIHJlYXNvbmFibHkgZG8gZXhjZXB0IHByaW50ICJhIGZhdWx0IGhhcHBlbmVkISIsIHdoaWNo
DQo+IGV2ZXJ5IElPTU1VIGRyaXZlciBpcyBnb2luZyB0byBkbyBhbnl3YXksIHRoZXJlZm9yZSB0
aGVyZSBpcyBubyBuZWVkIHRvDQo+IHN1cHBvcnQgZmF1bHQgaGFuZGxlcnMgb24gRE1BIGRvbWFp
bnMuDQo+IA0KPiBCdXQgaW5kZWVkIGl0IGlzIG5vdyBlcnJvbmVvdXMgdG8gYmUgZGVyZWZlcmVu
Y2luZyBkb21haW4tPmhhbmRsZXINCj4gd2l0aG91dCBjaGVja2luZyB0aGF0IGl0IGlzIGluIGZh
Y3QgYSBoYW5kbGVyLCBzb3JyeSBJIG1pc3NlZCB0aGF0Lg0KPiANCg0KYnR3IGFuIGludGVyZXN0
aW5nIG9ic2VydmF0aW9uLiBUaGUgY29tbWVudCBvZiByZXBvcnRfaW9tbXVfZmF1bHQoKQ0Kc2F5
czoNCg0KICogVGhpcyBmdW5jdGlvbiBzaG91bGQgYmUgY2FsbGVkIGJ5IHRoZSBsb3ctbGV2ZWwg
SU9NTVUgaW1wbGVtZW50YXRpb25zDQogKiB3aGVuZXZlciBJT01NVSBmYXVsdHMgaGFwcGVuLCB0
byBhbGxvdyBoaWdoLWxldmVsIHVzZXJzLCB0aGF0IGFyZQ0KICogaW50ZXJlc3RlZCBpbiBzdWNo
IGV2ZW50cywgdG8ga25vdyBhYm91dCB0aGVtLg0KDQpJdCBzb3VuZHMgYSBnZW5lcmFsIHJlcXVp
cmVtZW50IHRvIGFsbCBJT01NVSBkcml2ZXJzLCBidXQgaW4gcmVhbGl0eQ0Kb25seSBhIHN1YnNl
dCBvZiBpb21tdSBkcml2ZXJzIGNhbGwgaXQgKGUuZy4gaW50ZWwvc21tdXYzIGRvbid0KS4gU28N
CnRoZXJlIHNlZW1zIHRvIGJlIGFuIGltcGxpY2l0IGFzc3VtcHRpb24gZnJvbSBkcml2ZXJzIG9u
IHdoZXRoZXINCnRoZSB1bmRlcmx5aW5nIElPTU1VIHByb3ZpZGVzIHN1Y2ggZmFjaWxpdHkuLi4N
Cg==
