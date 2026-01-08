Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B6D328628
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855620; cv=fail; b=p/M6lFP+QTmzvVGNK07J3MwHdSg4FNjda+Q9PaRza6WC3ZgBRar+L70FCvQoGH+84uPGQLZx8AA8GwmBLAn++vSLPYCgUAyEJ/1wghsd82TzMLutOeznJfdAt2qIQsNgrGSoBaukkTd7sUsxC7qvWCaKyGD+jZLrL07fmXJvbS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855620; c=relaxed/simple;
	bh=YonqhYcL6nWL/Rr57zBR85ofAs/bKB345lYwB6m40Po=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZqLbntBqhtK5bmKRPc9ZeustUbDLdjVMY84bFFivcp8FKDaKlk+7yYht9AMljjDRvzgBIa/EATjFb/+I7tjS8qGMx0OspWiCTr2CFXnD0vBUrc0WK8/bmfvHyaGxcYEAYGpVCjVx/ncyqdmkzo01TFCzphEEyI1GqBMyZmAOdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXIBM+aC; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXIBM+aC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767855619; x=1799391619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YonqhYcL6nWL/Rr57zBR85ofAs/bKB345lYwB6m40Po=;
  b=BXIBM+aCdHHnt7v5mvUhuiTmsY40VhEZCnvAXZBKy6Sujsv02TPwc8XG
   DrF5zLtG4h8XnLx+njfsMw250fLYSFNaOb3qfIhrzx6RuD+800lzR09TE
   ERpC81om2apMEwwbpEMOZngRzjtF1J+1KLwi1d9orqECenBzsHbfAPSqb
   3UttRUAfwJf3tyOliqgkrvVF+AsSbPHbc1vvvjCMksZn/RXFOHyGqCzyh
   CG0ilZh8Pvg2bLqHT4b9bGCebYVgBYYtSvTAE8BxCTBBFo2oDgyHOOULg
   9ysrTILT/K8nDVEGP+t9IKOFeWpvXRYCfcAB7tiRqCye5quhlKAmkOEtT
   g==;
X-CSE-ConnectionGUID: dKTPHaJ0Tc2vzMtYjY7xZg==
X-CSE-MsgGUID: DzQF43feSjiS5tSNGJPGfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69303637"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="69303637"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:00:19 -0800
X-CSE-ConnectionGUID: CnwGvYJVQZ+C4Ovd8VxHJA==
X-CSE-MsgGUID: UZfYJYW9T+O7Q1BysjVGTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="202741960"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:00:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 23:00:17 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 23:00:17 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 23:00:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euaLkpe6ebJ8fGwmniBV7+3KL28vr9egq5dv2SJlehvjMWunxcM9EL2dKIE/dpJZp3jQZXzAPSWfgjG5WaP8GiR5U3InVJVzCKOmhnPW/35Ti7+sp8Yrb2gz6DQg4lahFd6wlmvwkxkkGkXHo440NSAZ3fDsT5cty8oonimnN99dt8LVsNxwDuQ/5eAIMkucIQhSnkMajQPqXUGInhvfsKMt8EX5+2YEKoWh9+tk9PBsGicJs6wa4PIiPhQBv3hbLW69E/vPsJa4Hwx4BuU4i0at/WXKb/4m1UEclNsEvyYABX1aS4ma2vnD74aJSqNfA4XIpO42jUc+gWDo1SV74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YonqhYcL6nWL/Rr57zBR85ofAs/bKB345lYwB6m40Po=;
 b=cst+AbxPLnyIDRSIgNqTgfPJid3LfG/wK/b7IbPeyp5M53lLH2J+IvXS494h4/ZPbbQ0c23UgR+2KxtjTkfMzaoLEXeI691m4MQW/giQs5US4zexyiW0SPcn62kPmDv2qlUkw/R3u3/68COlfK2NY5Wpi9C8DfzaOlWt7q6EGD/TeRNQ8jjoHoVtQaMmUPYjHFi7OQdaTXL5RvhkzRBY+ahqAMROHJ3zWy6aaVcNLr9IV6+gGEIaWHJPu5QAbWgSM0/Vsq6DxNEqJ3YrF/RLvIpZmokbMasTCyH6ba5hYQsqQOKFyXeE7ubtJ3+eXrjul+/hi/mLsz+GoLlU3eUvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:00:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 07:00:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Dmytro Maluka <dmaluka@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Vineeth Pillai (Google)"
	<vineeth@bitbyteword.org>, Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>, "Dong, Chuanxiao"
	<chuanxiao.dong@intel.com>
Subject: RE: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Thread-Topic: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Thread-Index: AQHcd1pONBzWAyEdQUC7AlJ00GGhhbVD7t0AgAAL+4CAAAVkAIAADl4AgABFfQCAAORcAIAACMWAgAAYWoCAAjOC8IAAWEKw
Date: Thu, 8 Jan 2026 07:00:09 +0000
Message-ID: <BN9PR11MB527611217341AC8462220F6B8C85A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca> <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca> <aVwZkFQ-iQ7OHMi2@google.com>
 <20260106001418.GK125261@ziepe.ca> <aV0TalseaDGW-1Jp@mitya-t14-2025>
 <20260106142301.GS125261@ziepe.ca> <aV0vM9ad-4QhCNaA@mitya-t14-2025>
 <BN9PR11MB5276FB0F465DBFB4EE4D742B8C85A@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276FB0F465DBFB4EE4D742B8C85A@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CYYPR11MB8388:EE_
x-ms-office365-filtering-correlation-id: 43353095-fd6b-4fc2-538c-08de4e839002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RzlSR2taT3lWT2o4Q2V5QzFvdmZYcUxxenFDT1dxUnZ6LzB6V1NGM3VIUXJv?=
 =?utf-8?B?TXc2UkZZV0U5QmFwMExYMjkwZ2wvckNFbVBQeGQxNzBsOWs4cWIrKzNVb05Z?=
 =?utf-8?B?RnlaYTYzeXFiTEVhVFBjWXdJRVA0NWExZ29qMHVCNGplbFVBRFVHaUdlRlFM?=
 =?utf-8?B?WEpoQy9WWEdObUJsOEwzOElpSWwrdWVrcXNHdm5reFplQkx3VktEMXBiSzIy?=
 =?utf-8?B?aFEyQ1dMYmQ0SjY0dDVQWVhqenRsQ0YxUGFubE5aaVRZZTN4QkI1bE1VSnpZ?=
 =?utf-8?B?TWxkcno4SlNQMEtkSDNGcFlSQ2VrQVdiZHlnYyt3SlV6YndPTGxKSWVRM21R?=
 =?utf-8?B?NzFZNDBRNzVPUTJjcEtQUWZkWHBuc2laK3dYWHVqdG8zSEhHZ2pXQW8rR200?=
 =?utf-8?B?NTUvWGlkQ1grK0ZWejlRdEp2d20wRVplZDlUTUlpOUUyNHVqM2wxcjJsUXNh?=
 =?utf-8?B?b05MbWlicU9TVjQ1R2ZHN0RSMHdKWDkrYVpnZlZhemF5NTI3RGovU0NpdEk2?=
 =?utf-8?B?NkQrOWdqUlkxdTQvekN0KzRkVWhodG9Kb1JqNWNjcElsRHZqeHpkMVFKc2Nt?=
 =?utf-8?B?TDI4T0M5N2hablZQUUNCMFhOWk91dUFVY3M2eXRuKzl6bUJoUEpFdHZ4dmM2?=
 =?utf-8?B?ZjhNTllPN1NveTNSZExIUy9lRGFqUU9KSGxTanF3R2F3QkhTbFRQTEc5Zi9C?=
 =?utf-8?B?cGxGQVBEUGJIZUV3NXU3S21CczE3empicElRZHJ6MXlnMWFjNmNDMkc2eHo0?=
 =?utf-8?B?ZWRXamNrVTFLekw5SGw3dFFYeVgrVTlhdi9xaVFwRVFFTWRiNkt6L3JsNkJW?=
 =?utf-8?B?ZE8rcXpsV2kvYy92Z1pqcDZpTnBJZkk2Z3NMWnRnTU91Nnp4cDhCK21sYmZX?=
 =?utf-8?B?YU5ac1Q2aWxLQ29CWlA4Wk13cXJkbHJsUHpuU211SHpqekNTcXhMb2dyb1B3?=
 =?utf-8?B?ckJjUi9NVk95Wm52dXI2NENwTUwwODVLYldwelJIRTBLcWtIY1B0T0NvTWdu?=
 =?utf-8?B?UWttK0JzOHNlaWNGRzdlcHBwUkY3V0dhWEhoTlQvL0REV2JpNkYzSk5QdjI1?=
 =?utf-8?B?bEFUVmJUenQxMU43RkJIL1RKR1pjKzQvdFdZOXhRZDZPcXByUjNaTXpOMk90?=
 =?utf-8?B?RG8ySEF2MzFmWnpySjRJMW1YMytDdzNBbGZoc3NQQWhxMlMvelFDNXlkQVN3?=
 =?utf-8?B?WlNPL2dGTGsyU0IraCtZTVB2em16blM4eTJMdjQ1ZjcvMCtReGRGMTZXbVRD?=
 =?utf-8?B?cW93aEtxOXlTZDV4Q3g0MGIrS011d2J6NmtFWG93c1ROL1dsemhTNjdqTWx1?=
 =?utf-8?B?R08zQmNwendha1hQaDU5WWlPUTFCb3pNZGNWaXRZUjRoak9XcWQ2VGlsd2l3?=
 =?utf-8?B?cnRxYStlMlJvQkJWTlNDN2pYSGF6a1BURmw5dkhYT0xDNjJPNEtlY3Vrd3JM?=
 =?utf-8?B?THlWVkJiSkVhb05wajhkZnVaREU0OERLSFMrWkEvWFBGc2ovNitneWlFSUU2?=
 =?utf-8?B?bDBJVWhTOVp5WHVNK0dOZUNvOVkrR3hpdkFOR2FTckJDdEpTd1NMVmlYUU04?=
 =?utf-8?B?R29VQmhGN0gvVjZWdCtKNDBScXV2UmdsbGM1QkxvSVRPaUN1dXUwT09kRU5i?=
 =?utf-8?B?UCtsRlJpYndEOVQ5cWFyNnlKTUFZbit0VXoyaGZubCtFaENsTk9kMVl4d0lN?=
 =?utf-8?B?RlNrem9UWlg1VithRnlDTDd4L0tJYjBXRmM3OFdhc2F6RnN5OE43cGVFQi9I?=
 =?utf-8?B?VG9hYmxyUy9qVGpCUDZDVXY5dWt2MDlZL0Y0T05KNWhaTEVmdGd6ODZmbFJ5?=
 =?utf-8?B?Q1d4L29paWZ3ZXlzTVVJaG14OGdiLzh0WDFXbVgxTS9FK2NpU0tvckFEY0JE?=
 =?utf-8?B?ZVNqZGdSNnhnT2ZtM0djMmNRKzlLM2NVUk0vUHZtS3MwdGpqc3pYc3Yzc2Nm?=
 =?utf-8?B?dmhtMnd0Qmx1M09MSnJmYk5reU0yWEVxNjlLUld0TFZITHlyOThZR0hialBx?=
 =?utf-8?B?SWRXZCt2VlpkTDZFY3hkTCtWQmMrOFV3cXI2WGVJTW9ab2cyNW43MjRGQ0lI?=
 =?utf-8?Q?mxx9tn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXIwUk1yay9tZ3VqWFNXZmJ6YlNueW5JQ0x3bE9wMy9sUDJPSVRiQkJmV2hU?=
 =?utf-8?B?YlZMQ1BnVk0rQ3ZJZk12QVlEOUVGSGVaaTNaWDlNNVZPd2FvS2s2RXpValFk?=
 =?utf-8?B?TDQrTTVqc1U1K2pKWlBMTVdaVUsrTmNWWTFtalFwSXovc0FIc0pmUVhwOUxq?=
 =?utf-8?B?bnlPZ0NSa1B1Zm5UVEFMSmsyU1podVBmOERwWUhPcnYxSFk5VkxHZytJc2FU?=
 =?utf-8?B?czh5RTg1Rkk1MEU0WWxQQ0RkZWJtdXRkRThxOEZlSWtDelNMbmxEU0pGSHl1?=
 =?utf-8?B?NmFHZ2JLUGNYMjZoaUwyM04zZjZmT1RVUmZaSURmTE80VnZ4akNrMGlxVFMz?=
 =?utf-8?B?bXdNM21vZjg2NHV3d2ptRzNabG5pM3ArM3g5K0FFZnpVcVFOdW9ydUtaU3Vo?=
 =?utf-8?B?eUprR0c5aStUVVVwczdCa2JlOWlhR1QxMk5CTnI3cjZTUENKMUlZY3A4VTBS?=
 =?utf-8?B?c2NSOE5nOE1NNjhVbjgwVGgzZXNBYjFCaFJmSVhvMFNOckxJbGJuY1NhS0Fl?=
 =?utf-8?B?UWNQN1FMcEVudmVzR3Y3WXROS0ZIUllCR2FzMXArSy9saDhCTlF3NjNBSFcx?=
 =?utf-8?B?anUxdG9CTTNVYkl6R3VRZlYzOHJ4TzhZaUl0YmpZUHNHc0hxOXlvYTQrZ1hZ?=
 =?utf-8?B?cWtqZWI0NUNyZHVjUitjR2pTWUFINUJEQ3JxUEJvalRxNVlsZllYVU5RN3Za?=
 =?utf-8?B?UXpXNkZaMGxXQy90M05POERCbTBtR1Rkekg5OE1rdjROazlteE1IWnFacmJz?=
 =?utf-8?B?RlJjeFBkaStiR1pNUTY5MlpMQUE3cEJWUzFHcHQ5ejRPK3JSWncwSjVwY2Rs?=
 =?utf-8?B?dGlxK2VlWlJpU295YTEwTmFVNmFrZXliMnhUbklSd1J3cm81T3EwQ0UvTDJq?=
 =?utf-8?B?Zm56dlBUOU1qV1hzL1hYZERaclpWcmdqb2FLMkVMZ0R2RXIzOURKYStVQUl2?=
 =?utf-8?B?VkNLS1ZSVklBTStQSWVFUGxsQjBSbGd5djhwb0dneFZoektCMWxib2dmSWlU?=
 =?utf-8?B?TnJQemV0SDhicDkxWUUyTmRWa0xxaWZaYVQvelp0MytJN2dzVUd1MWJDSUpy?=
 =?utf-8?B?Z0haN0kyL2J2dTU5WTZQd044czNWWVpkK1ZoSmgwT3U2WUcvRDUyY0pJUEYy?=
 =?utf-8?B?enVwT1BzRTZudFVLRlF2YjZVbTZnMWF4N3U0OEZWbzR4SmJaeWp1elFPQ3d2?=
 =?utf-8?B?UHI4Q09HWEN5bDJ3QmZlZFZ4MHJzTTA5UVRQdytWTjNyTkc1TUNYZFkyWHg1?=
 =?utf-8?B?YWh3dDZXcGFaL2lVUlV0YzA0N1MzSU81MDBpOWtNZ25TWE5CU2VaL1p5aVpX?=
 =?utf-8?B?N1JRbThoR3ZERVJsZ3l6Rmgxb2lZOGY1T215RGtkaXV6ZEdCcGJyaVFoQ08r?=
 =?utf-8?B?OVhIa000eFVrUUNMMXdIUkZEYStIdkF1WHZmK1JwaGZtSHBDYnVuby9YWWNC?=
 =?utf-8?B?S1JqUmc3RXZFWnQxbUk1K0dkK254OVh3RUNTbzAwRllvWkczM1lyS09tNWJU?=
 =?utf-8?B?dVd5QURtU3h0ZHhFaTZiWDNOWm9zNGlQK1p4Y201QmRwSkxoUStMZk9tVDhK?=
 =?utf-8?B?SlFMMy9aTzZMR05qNjJWVFAvMS9iS0k0STZ3TGcvbyt4Q2FMajZ5Z0Z1MWtn?=
 =?utf-8?B?VDVLbHFKSk5WZ3ZNMzJJbmJSNW8ra2FzSEZOaXdLb0VZSjFxREFXOTFrQTZ1?=
 =?utf-8?B?a1pIRnlpNGlhZmovNDJ1MWc3dStlUnJWQ1FiTjIwVzlZZlBxUzh5aWE3Sm5M?=
 =?utf-8?B?SmJzRkZsRnFiYWp6M2lnMHVaclZCb2t5WDVtTlV5eFc1ME5YL3ByZk5xYVlu?=
 =?utf-8?B?VjJMdlRCTmF4Y09VZmkxTjdQTXpRSkFhY08zUnREODUrQ2JzQlhGVGlYVmpH?=
 =?utf-8?B?N3NKd05TZlZTdGhaK1FHUm9jUWIxZGtGejJLOG11NnljanRnOHZMMDdnSWZX?=
 =?utf-8?B?ZTdRdGVyQ2NHdUlGTTBYTTZQSWNTTGM0WTJEQWNIL21yVnZha1g4KzhnNFI0?=
 =?utf-8?B?SG9ydzVsWGNaTzhDV1RLOFVOcmoyQ1k4SEN2ZnJXaUFocXdjWkU5eDJTOGZH?=
 =?utf-8?B?Zkp3UzRzMjBqMzlObDdXUEE5T1l3dENNUDMvMGx4U0IrSDVXS1R6WnE5VlBu?=
 =?utf-8?B?MkZjcS9DaEJoKzFyNGp6QzdpbVh2bEluQjVIMFVSUDE4NjFnYXRvVzgzNWRa?=
 =?utf-8?B?RWVMMHBDMHB2OVJKS3d2RXJERDJxZ2thVEZ3dXlZa2xIZVBOWG5DWVpCdTNW?=
 =?utf-8?B?K2JsMEYyWi8yRE5WNktSaDNINXBxMStwbEdESDRPWmtMZ09UekY5ZUFLclRn?=
 =?utf-8?B?NDlERkN3YlF0dUR4TzdKejVGUEpWRmdHcms0T3dXSERMaXFtcko1QT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43353095-fd6b-4fc2-538c-08de4e839002
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 07:00:09.6593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHW/s/wL4X+tm0NMUIvvceZBaSxiaS5o7pxSmKMN5I0h4pefsmtYtR/04G6qDxishcklTekWG0iDxDetyT7pXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
X-OriginatorOrg: intel.com

PiBGcm9tOiBUaWFuLCBLZXZpbg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA4LCAyMDI2IDEw
OjEwIEFNDQo+IA0KPiA+IEZyb206IERteXRybyBNYWx1a2EgPGRtYWx1a2FAY2hyb21pdW0ub3Jn
Pg0KPiA+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgNiwgMjAyNiAxMTo1MCBQTQ0KPiA+DQo+ID4g
T24gVHVlLCBKYW4gMDYsIDIwMjYgYXQgMTA6MjM6MDFBTSAtMDQwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOg0KPiA+ID4gT24gVHVlLCBKYW4gMDYsIDIwMjYgYXQgMDI6NTE6MzhQTSArMDEwMCwg
RG15dHJvIE1hbHVrYSB3cm90ZToNCj4gPiA+ID4gUmVnYXJkaW5nIGZsdXNoaW5nIGNhY2hlcyBy
aWdodCBhZnRlciB0aGF0IC0gd2hhdCBmb3I/IChCVFcgdGhlIEludGVsDQo+ID4gPiA+IGRyaXZl
ciBkb2Vzbid0IGRvIHRoYXQgZWl0aGVyLikgSWYgd2UgZG9uJ3QgZG8gdGhhdCBhbmQgYXMgYSBy
ZXN1bHQgdGhlDQo+ID4gPiA+IEhXIGlzIHVzaW5nIGFuIG9sZCBlbnRyeSBjYWNoZWQgYmVmb3Jl
IHdlIGNsZWFyZWQgdGhlIHByZXNlbnQgYml0LCBpdA0KPiA+ID4gPiBpcyBub3QgYWZmZWN0ZWQg
Ynkgb3VyIGxhdGVyIG1vZGlmaWNhdGlvbnMgYW55d2F5Lg0KPiA+ID4NCj4gPiA+IFlvdSBkb24n
dCBrbm93IHdoYXQgc3RhdGUgdGhlIEhXIGZldGNoZXIgaXMgaW4uIFRoaXMga2luZCBvZiByYWNl
IGlzDQo+IHBvc3NpYmxlOg0KPiA+ID4NCj4gPiA+ICAgICAgQ1BVICAgICAgICAgICAgICAgICBG
RVRDSEVSDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZWFkIHByZXNlbnQgPSAxDQo+
ID4gPiAgICAgcHJlc2VudCA9IDANCj4gPiA+ICAgICBtYW5nbGUgcXdvcmQgMQ0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgcmVhZCBxd29yZCAxDQo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICA8IGZhaWwgLSBIVyBzZWVzIGEgY29ycnVwdGVkIGVudHJ5ID4NCj4gPiA+DQo+ID4g
PiBUaGUgZmx1c2ggaXMgbm90IGp1c3QgYSBmbHVzaCBidXQgYSBiYXJyaWVyIHRvIHN5bmNocm9u
aXplIHdpdGggdGhlIEhXDQo+ID4gPiB0aGF0IGl0IGlzIGRvbmUgYWxsIGZldGNoZXMgdGhhdCBt
YXkgaGF2ZSBiZWVuIGRlcGVuZGVudCBvbiBzZWVpbmcNCj4gPiA+IHByZXNlbnQgPSAxLg0KPiA+
ID4NCj4gPiA+IFNvIG1pc3NpbmcgYSBmbHVzaCBhZnRlciBjbGVhcmluZyBwcmVzZW50IGlzIHBv
c3NpYmx5IGEgYnVnIHRvZGF5IC0gSQ0KPiA+ID4gZG9uJ3QgcmVtZW1iZXIgd2hhdCBndWFyZW50
ZWVkIHRoZSBhdG9taWMgc2l6ZSBpcyBmb3IgSW50ZWwgSU9NTVUNCj4gPiA+IHRob3VnaCwgaWYg
dGhlIGF0b21pYyBzaXplIGlzIHRoZSB3aG9sZSBlbnRyeSBpdCBpcyBPSyBzaW5jZSB0aGVyZSBp
cw0KPiA+ID4gb25seSBvbmUgZmV0Y2hlciByZWFkLiBUaG91Z2ggQU1EIGlzIDEyOCBiaXRzIGFu
ZCBBUk0gaXMgNjQgYml0cy4NCj4gPg0KPiA+IEluZGVlZCwgbWF5IGJlIGEgYnVnLi4uIEluIHRo
ZSBWVC1kIHNwZWMgSSBkb24ndCBpbW1lZGlhdGVseSBzZWUgYQ0KPiA+IGd1YXJhbnRlZSB0aGF0
IGNvbnRleHQgYW5kIFBBU0lEIGVudHJpZXMgYXJlIGZldGNoZWQgYXRvbWljYWxseS4gKEFuZA0K
PiA+IGZvciBQQVNJRCBlbnRyaWVzLCB3aGljaCBhcmUgNTEyIGJpdHMsIHRoYXQgc2VlbXMgcGFy
dGljdWxhcmx5DQo+ID4gdW5saWtlbHkuKQ0KPiA+DQo+IA0KPiA1MTJiaXRzIGF0b21pY2l0eSBp
cyBwb3NzaWJsZSwgYnV0IG5vdCBvbiB0aGUgUEFTSUQgZW50cnkuDQo+IA0KPiBWVC1kIHNwZWMs
IGhlYWQgb2Ygc2VjdGlvbiA5IChUcmFuc2xhdGlvbiBTdHJ1Y3R1cmUgRm9ybWF0cyk6DQo+IA0K
PiAiDQo+IFRoaXMgY2hhcHRlciBkZXNjcmliZXMgdGhlIG1lbW9yeS1yZXNpZGVudCBzdHJ1Y3R1
cmVzIGZvciBETUEgYW5kDQo+IGludGVycnVwdCByZW1hcHBpbmcuIEhhcmR3YXJlIG11c3QgYWNj
ZXNzIHN0cnVjdHVyZSBlbnRyaWVzIHRoYXQNCj4gYXJlIDY0LWJpdCBvciAxMjgtYml0IGF0b21p
Y2FsbHkuIEhhcmR3YXJlIG11c3QgdXBkYXRlIGEgNTEyLWJpdA0KPiBQb3N0ZWQgSW50ZXJydXB0
IERlc2NyaXB0b3IgKHNlZSBTZWN0aW9uIDkuMTEgZm9yIGRldGFpbHMpIGF0b21pY2FsbHkuDQo+
IE90aGVyIHRoYW4gdGhlIFBvc3RlZCBJbnRlcnJ1cHQgRGVzY3JpcHRvciAoUElEKSwgaGFyZHdh
cmUgaXMgYWxsb3dlZA0KPiB0byBicmVhayBhY2Nlc3MgdG8gbGFyZ2VyIHRoYW4gMTI4LWJpdCBl
bnRyaWVzIGludG8gbXVsdGlwbGUgYWxpZ25lZA0KPiAxMjgtYml0IGFjY2Vzc2VzLg0KPiAiDQo+
IA0KPiByb290IGVudHJ5LCBzY2FsYWJsZSByb290IGVudHJ5LCBjb250ZXh0IGVudHJ5IGFuZCBJ
UlRFIGFyZSAxMjhiaXRzDQo+IHNvIHRoZXkgYXJlIE9LLg0KPiANCj4gc2NhbGFibGUgY29udGV4
dCBlbnRyeSBhcmUgMjU2Yml0cyBidXQgb25seSB0aGUgbG93ZXIgMTI4Yml0cyBhcmUNCj4gZGVm
aW5lZCBzbyBpdCdzIE9LIGZvciBub3cuDQo+IA0KPiBzY2FsYWJsZSBQQVNJRCBkaXJlY3Rvcnkg
ZW50cnkgaXMgNjRiaXRzLiBvay4NCj4gDQo+IHBvc3RlZCBpbnRlcnJ1cHQgZGVzY3JpcHRvciBp
cyA1MTJiaXRzIHdpdGggYXRvbWljaXR5IGd1YXJhbnRlZWQuDQo+IA0KPiBidXQgd2UgZG8gaGF2
ZSBwcm9ibGVtIG9uIHNjYWxhYmxlIHBhc2lkIGVudHJ5IHdoaWNoIGlzIDUxMmJpdHMuDQo+ICAg
LSBiaXRzIGJleW9uZCAxOTEgYXJlIGZvciBmdXR1cmUgaGFyZHdhcmUsIG5vdCBhIHByb2JsZW0g
bm93DQo+ICAgLSBiaXRzIDEyOC0xOTEgYXJlIGZvciAxc3Qtc3RhZ2UNCj4gICAtIGJpdHMgMC0x
MjcgbWFuYWdlcyBzdGFnZSBzZWxlY3Rpb24sIDJuZC1zdGFnZSwgYW5kIHNvbWUgMXN0LXN0YWdl
DQo+IA0KPiBzbyBpbiB0aGVvcnkgMXN0LXN0YWdlIGFuZCBuZXN0aW5nIGFyZSBhZmZlY3RlZCBi
eSB0aGlzIGJ1Zy4NCj4gDQo+IEluIHJlYWxpdHk6DQo+ICAgLSBpb21tdSBkcml2ZXIgc2hvdWxk
bid0IHJlY2VpdmUgYW4gYXR0YWNoIHJlcXVlc3Qgb24gYW4gaW4tdXNlIHBhc2lkDQo+ICAgICBl
bnRyeSwgc28gdGhlIGNhY2hlIHNob3VsZCByZW1haW4gY2xlYXJlZCAoZWl0aGVyIGF0IGluaXRp
YWwgc3RhdGUgb3INCj4gICAgIGZsdXNoZWQgYnkgcHJldmlvdXMgdGVhcmRvd24pIHRoZW4gaHcg
d29uJ3QgdXNlIGEgcGFydGlhbCAxc3Qtc3RhZ2UNCj4gICAgIGNvbmZpZyBhZnRlciBzZWVpbmcg
dGhlIGVudHJ5IGFzIG5vbi1wcmVzZW50Lg0KPiANCj4gICAtIHJlcGxhY2UgaXMgYWxyZWFkeSBi
cm9rZW4sIGFzIHRoZSBlbnRyeSBzaG91bGQgbm90IGJlIGNsZWFyZWQgaW4gdGhlDQo+ICAgICAx
c3QgcGxhY2UgdGhlbiB0aGlzIGJ1ZyB3aWxsIGJlIGZpeGVkIHdoZW4gcmVwbGFjZSBpcyByZXdv
cmtlZC4NCj4gDQo+IElmIG5vIG92ZXJzaWdodCAoQmFvbHU/KSwgcHJvYmFibHkgd2UgZG9uJ3Qg
bmVlZCB0byBmaXggaXQgc3RyaWN0bHkgZm9sbG93aW5nDQo+IEphc29uJ3MgcHNldWRvIGxvZ2lj
IGF0IHRoaXMgcG9pbnQuIEluc3RlYWQsIGp1c3QgcmVuYW1lIHBhc2lkX2NsZWFyX2VudHJ5KCkN
Cj4gdG8gcGFzaWRfY2xlYXJfZW50cnlfbm9fZmx1c2goKSBmb3Igbm93ICh3aXRoIHNvbWUgY29t
bWVudCB0byBjbGFyaWZ5DQo+IHRoZSBleHBlY3RhdGlvbiksIGFuZCByZXdvcmsgdGhlIHJlcGxh
Y2UgcGF0aCBpbiBwYXJhbGxlbC4NCj4gDQoNCmFoIHdlIGRvIGhhdmUgYSBwcm9ibGVtIHdpdGgg
dGVhcmRvd24gdGhvdWdoOg0KDQogICAgIENQVSAgICAgICAgICAgICAgICAgRkVUQ0hFUg0KICAg
ICAgICAgICAgICAgICAgICAgICAgcmVhZCAxc3QgMTI4Yml0IChwcmVzZW50ID0gMSwgdXNlIDFz
dC1zdGFnZSkNCiAgICBjbGVhciAxc3QgdTY0IChwcmVzZW50ID0gMCkNCiAgICBjbGVhciAybmQg
dTY0DQogICAgY2xlYXIgM3JkIHU2NCAoRlNQVFBUUj0wKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgcmVhZCAybmQgMTI4Yml0ICh1c2UgYWRkcjAgYXMgRlNQVFBUUikNCiAgICAgICAgICAgICAg
ICAgICAgICAgIDwgcmFuZG9tIG1lbW9yeSBjb3JydXB0aW9uID4NCiAgICBjbGVhciByZW1haW5p
bmcgdTY0J3MNCiAgICBmbHVzaCBjYWNoZQ0KDQpleGFjdGx5IGFzIEphc29uJ3MgZXhhbXBsZSBz
aG93cy4gOi8NCg==
