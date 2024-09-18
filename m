Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86524428
	for <iommu@lists.linux.dev>; Wed, 18 Sep 2024 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647653; cv=fail; b=Ka/TPfipPiNAFAq9kOv4npo734+da6dOBdJE5dme7E35+MtU9DW3r/VCxpELCCmPoUIyuHrya8hOEsuFn7TrYiLOKtQdOwh9+/NIwWwgtHwpUcS/kcuG5sh/EtzHHtR9OvV9qY2kkvcTH9k/cAgfhgnGzHpL3WYJ2mvaj9jXKm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647653; c=relaxed/simple;
	bh=c7UCQ0d5cHagAyFcVmDw892C5kiVDwaje3qY521C0yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MzdoMs83x0oOUghhmScTHkV89ifyI8XA6ZbhZucGOYa/KdGg00ZhpwgTIJ2xo+tUgBYXu/14wIwGhGztbOYb1sGXiDjbQA6OmQSEHAODYBhBfxynr9z7TJ1V75dSB3meuEKQTtRUom8ycTxSbZfiNVvUEasKK+5jf3p2fJYUrSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyYAmWdk; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyYAmWdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726647652; x=1758183652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c7UCQ0d5cHagAyFcVmDw892C5kiVDwaje3qY521C0yo=;
  b=nyYAmWdkkYf1StBqOzkcTmF5o8DXZp9lQs2lkVtH4TwIc21GbEBNinMy
   T/Qf2G8CbYCieXMSJvArneX0y93UZi7WsU4BN8n1PZ/qlAvhpE/YyoVsp
   zDRSm/lrY9/Eoo8zWzu2rcIuVAfSu3rhkFliYYqbfu3BQXxX7MDycvL41
   1u9PmabQq/Mn0WVV8i8WMwlst1Jhz/rDga4M0IZLBm1uabKnjLoF3i90S
   B+//8vL0b4dKKDP8gVX/1CHxY/1BQUqm5fYe9N0e8N+nxpPn1O/nqV3HK
   ZYDffCD0DrRPrjugSxqyLHT01+m2qgQXHvjzAWoUcSMO2FizWlgjjg5XU
   g==;
X-CSE-ConnectionGUID: RLgct5Z5R0msYuKoRs/M8A==
X-CSE-MsgGUID: Yk18PaNdQF24BMEF5LxLgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="29289265"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="29289265"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 01:20:51 -0700
X-CSE-ConnectionGUID: tD/qHOsGRUqgUPPCduC2DA==
X-CSE-MsgGUID: PfiEr5grTM+R8gw5Hh2MvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="74302440"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2024 01:20:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 01:20:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 18 Sep 2024 01:20:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Sep 2024 01:20:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le2280850IsjlrP73T33qz6LIaasKQXDGZVR+2q+en4ct0VBMwI9/5Isrpg3yKrO0SaMk1iQXZyO4JiEmkO5/eL35gurlhJl1qlzVBx1WKTshIuatgUi3SO5SkHbnVtDMe5jSqlaF6y4Ii6BDiDHowf4KwhrSHLpv+wi4Br9dcaaF39z9vY0iu+0SqRBk6RqbaNY1XM+GXFGqCEN+B0kPZ89GV3rRVhO/WMdfeOgiMe6s1mj5+IK/jt0br1xqsoX6pMU1EfNzSLOv+Si9y9FaU1s7jnwlWXTFIPglwV2XpeMY5g08bSrXnhWaQwLVPNN5QplqdpHiFEFx2lp5nKOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7UCQ0d5cHagAyFcVmDw892C5kiVDwaje3qY521C0yo=;
 b=NiAICtNl1lM9uMEe1w6iVrHSUw4JN/20/ckpejAg9pXE4U39hax6Wi4mJLhtH29+t4/3wz0oencdJgn9e7oDh+VUMQhhA2PK2NjU/tmShj5nEi7eMociqd7hBbE5CZjjowyc8GljxCCymy82Yt7Zrft5qF1rHTnID1m5kz933h97K9vR3zG+Y1sj0Z7C5pIaKcNzObJ888fmB9fbR/lJtoc+tzqZujyhlR6KT8GfNFnrB8gJgMZhnhy1KgRrHUdzAJ/XBoBMQ15KXXzkhrwHt4D/gjra03PL1h9iqn+jO9wEb+T2ITcWWEJ+8FfgFnjhJnGU9u3ChO0ajKYbD/e6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 08:20:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.025; Wed, 18 Sep 2024
 08:20:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "j.granados@samsung.com"
	<j.granados@samsung.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen
	<its@irrelevant.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Thread-Topic: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Thread-Index: AQHbBdJ7/7CTtQp+20SlGBvfhvfxtbJWdAEQgAAIWoCAABlWQIAAMnYAgAZxEDA=
Date: Wed, 18 Sep 2024 08:20:48 +0000
Message-ID: <BN9PR11MB52769D1D1FEA9BAF0E6D19718C622@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
 <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
 <BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>
In-Reply-To: <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB5976:EE_
x-ms-office365-filtering-correlation-id: 17c16d55-58d2-455a-d8e3-08dcd7baccfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RUJBbkoyVVVudzNJOWpoeklrcnc3NHRlL2RRcm5EUU5Td2pESG5tcHROUWd6?=
 =?utf-8?B?ZE1laVU3UUV3SFYxMkNFTlJKV0RpZFlJWWthNkk4MlQ1ZTQ5UHcvQm4vZnNI?=
 =?utf-8?B?enBjYTZ2OG9OaE45VlFST2lvQ0tTMkc3cVhrQ3hQZTVMVGc2Q0huZFBpV0sy?=
 =?utf-8?B?NDVrTEtqYXNGd1BnMEUvNGloSFc0VGlIWHE0YmdPcktoSGM4ZXdldzV2ODdv?=
 =?utf-8?B?Kzg2eXRkRlFjaUlSa0VwYkU1eG5yTFZEM05FS05CbWY1dzIxRkxjTVBVNGQ5?=
 =?utf-8?B?aEJ2WUdXMTJkb2gzRnBLNVdZZ1VKNHYzRDFCTWxBYWFiazl5NXE5bTBacTFV?=
 =?utf-8?B?S0NpbDc3QUF3alkxSEFzYXg5TmRsalVFQVBnb2FoNkp4S1V3ajlVZC9USTBz?=
 =?utf-8?B?ak41dVhTUHM2V0VkYk0yTGV4bkJJVGZOZWVVaVl6eW8weTFZUjdSVDhDR2RB?=
 =?utf-8?B?QXVEZk9kYW8rWjduUGhsL3hGMm16R052TGRpWUwrczdMaUIzdkJwd2p6am4v?=
 =?utf-8?B?Z3pPcTMxcTdDN0lBL0ZkdWo4ZzFzZzZpZDFBdTZSM3NyNGM3NmVQTlJJVExZ?=
 =?utf-8?B?MU5VMEk3ejJjTmRwMDA3T1gyeTFyQ2tSdHpJMmFhM2I3cE44am4vOUxnUVNM?=
 =?utf-8?B?MGhOVXdJeVVOWW9YbnlKcUlFY3ZYOHpuUU9PMjZORkM5cDIxM28zV3BIZ2w5?=
 =?utf-8?B?UWdPTFJwYnVvdkpGbDdFYWtDVzZHV0RhOVNwUzJYNko4UEFjdmV4aDFScU43?=
 =?utf-8?B?NEFSRld1RWRibVgrdjBraEIwMk9XQmwxemcyNDlkcXR6bDRNSi95SG5hYk9S?=
 =?utf-8?B?Zno2dXJ3TzZpVDcwUE40QnNsZ1c0enNFSHRIRDUzMGNLOUtKS1NqWUUrcU9F?=
 =?utf-8?B?cTJadkw5QU5wcEZCSy9ESWVkZzIxRkpIWXBnbjRpQlkxQXhNUW9abkw2bm1V?=
 =?utf-8?B?RkdIUWcrS0FQMSsvTXI5N0diMGRpNDNmTi92d3U4bEFyWi9jcW44cGFWNm0r?=
 =?utf-8?B?U2gwbUJzcFdVdmluVktGd3dCNitza3ZPbFNsSXdPR1hSY3RTdGZmYmlGK3NI?=
 =?utf-8?B?WEZqajIxbGNGeUNxeXdqb0F6Ly8wcTQ5Snp0SndzTWtvUEFQUW5kN1o5VGU4?=
 =?utf-8?B?VVdvZzRDblNxaTN4dk8zc3oyTHFVdmtWajdXbCtrSVpvWWdYMHYyNXFXSUlU?=
 =?utf-8?B?ZkkwVkNuSng1eW1aY0hyb1Y2MU9yNU9WTVBtRjZYc1oxMDRScG1XQ1c2R2RZ?=
 =?utf-8?B?SHF3WE1SUVZEWTJxN1BZZGNCVXhYalowTCs4Zm5KNVZMVWpxR1hSNjc4WGcz?=
 =?utf-8?B?Z2ZmVkpFQkYraGMzZXZVYk9xV1pCOWZPcWc2ejFnZHAwT2JPNXBvZUZvQXlm?=
 =?utf-8?B?Slp2VEZHTE42UUx4OGFCcXBIQzJxekV3dEZGRlpDTjRTZ2JGRW9OSUkwY1FN?=
 =?utf-8?B?YTlDSnA0dlkxWVprNjI1R21KZ1NESGM4L0FaNWNQc3pBQk55WEJUaVpFTGFn?=
 =?utf-8?B?czU4UXl4MWsxYnZ1NkhtdnRlT2Frb2pqNFhtQytzaEN6VjdjNlJCUG9nR2Yy?=
 =?utf-8?B?NnBUSG16bGhUUXJrZnl2aTgzOUdTTnI2Ukx0MERsWVQvQUtnYjE5SExRYytu?=
 =?utf-8?B?OFg3R29pakljVm5WcFQ4bXl3U2xxOTNYbDIrMXNSK05jd1daeS84WndMbzVx?=
 =?utf-8?B?Z1Uzc1dQd1UzNFVGRW5vTXRtRmdlRWQ0NHpRRHNvaEtnR0NueVBUbGI1NmEx?=
 =?utf-8?B?OGd6SHJRbUlDMlpmRjFJZVNHRFNTdXhsMXFLOHNLUEtkRmVQMEpyd1pMdnk3?=
 =?utf-8?B?SEtsYVBqNUllMTB0UDlrSUpGWjU3c0dBcG9oQ2lTT2dhRldHVjNWdG9nTzho?=
 =?utf-8?B?cVMwSEowQUU4UGhxenpXdmU0dDRQcjhQTU15WUlMNmJLTGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGx5R2tKejN0TDFnc1lsRGR4MmJ1bXVCckl0TmZrQXdyNExnV0Fvcy9MQTF4?=
 =?utf-8?B?bWI0aXg1RmJvbFRqWGFzZy8yOXMyTzJlNTZJTGJldkZlS3gvbUdHZGZFNUxp?=
 =?utf-8?B?bUFoS3d5UXBSRG5CN29KTHlOR1RPV2o3dU94LzJIQ2FBVmxZZzhhM0laRUVs?=
 =?utf-8?B?TFdKbWR0SGR2OEgyUWJ0VnVEOW5lRHdDRzAxaE5vVm45dXdjTTQ2SzNQMmhK?=
 =?utf-8?B?RXFHdjNSNStHSm9IMmY1QUs4eTB0ZWRSblBzUHNSeko0VnJKWExtK1dxRXRp?=
 =?utf-8?B?RHQyRU5vQjk2aTFsTWljK2ZOZ0VwVFFWRTRneDBpaFhXM3p5THZOT2t0Qjlp?=
 =?utf-8?B?YUEwb0FPNHdKYVBHYXl0Z2dhOVVQMkE3S0M2QVNpbVRhMlJvU0RVYUpORkdQ?=
 =?utf-8?B?UG1vNXNJZlMrUEtDVDBvaG5GSVFkbkcxZFFFY2VGSndtTE8vdzdjOXFZVUhr?=
 =?utf-8?B?OGF2S1JlOUNPWlE2YWhsc2tqMXY2QnZId1RteTdMLzU2WmpQYm56WldYMURT?=
 =?utf-8?B?OEhFL2YxdjRyS0RyRHU1RUIzYjBEMVcyZ2xzYzVxV3g3RHdsTHNnam0rVCtD?=
 =?utf-8?B?cndEM25jQ25DL0JuSnYycCtEMTludm15d25ZS0FBMWNyNFpqVTMvQW1pNkdX?=
 =?utf-8?B?N1JOdjdBUk1qRVRTMG5aazh6K0ZnUndQSkFZdGdIMHhvckE2YS92bFhmWTNo?=
 =?utf-8?B?WXppWnRLYzd3WW1KUjhVWjgyaHVBOXFRY21CT0taaHFjZXM5bkJCNjhxMVBk?=
 =?utf-8?B?SzI4T0NuaTE1WXRub255b0o2TndOaTFjUm9XSEJNMSsyZHdrWkJvY3o5L3Iy?=
 =?utf-8?B?cXVxNTROczZWT0t6cEIrUks4QkRMcGxXSzhzMXIrZDNHR2Y1TTNlSFdDcVYy?=
 =?utf-8?B?U1NZNmROYnB1em9YcjlzV0tXcEJRaGU1TG13OVlVeWpQUVhzNGF6ODM1SzJT?=
 =?utf-8?B?Y3BaV1dQN1dGQ25PbXdVQUpOd1ZZREI2TlJMclIyNVptOGthNkkvK3E1TFdN?=
 =?utf-8?B?ZDJ6REFxZjFQV1dzUWJ6WHA2KzFNUTlZTkV4Z2VqZ2MyQ25CelNEYU5uRkc0?=
 =?utf-8?B?UmpsNGNFaEFHeVF0azNYK2QwRkdkd1BQRGdLYUFzSkJZeTN3QkNTQjRWa25n?=
 =?utf-8?B?SFdVMCtrUkJzWTNMWjdxQzJQTEY3UjkrdmN2Nm03cENZR2FaNnFTMElmRzhL?=
 =?utf-8?B?V29DcFdoNnUvcnBkR1RqSFdVV01lSmxuUkRRMVNIYTUya1RyQS9sODNaQ3Fq?=
 =?utf-8?B?YjVWcHMwZEdNYkw5NG11Z0FYS3hrVGpKUHFrU0VoRFVscFo0RDZZUnhsdHZp?=
 =?utf-8?B?WmtZTTkvQVNqLzRYTDgvUWFEbnRkdEo4b3BjV3FXSkJVOFc0cFNHdmRaNlZj?=
 =?utf-8?B?cjEzMzFlcXZEZGtSeHJCVnNZVlo4dzNqSURWV1NCL3R0TGc2aXlpN3dFWThT?=
 =?utf-8?B?dUM2T3hFeHhtVlYxdWE3Q1k3clZWenVGYWdPSml2ZGg0WDVia1Q2a0FWd1Uw?=
 =?utf-8?B?YUV3KzJDREppSlNHOWNUNUFqUVpWL1RpRGk5ZmJ4MTRJOGFkeW15cVFOK0t1?=
 =?utf-8?B?anFqK2FWSG1PR2tUVXI0OU40a1dsemd5VXkzM0JySHZ1ZUkwRzdnbnpjazIw?=
 =?utf-8?B?aS9LNlFJcFQ4L2JsOWZxR0NRZHd5elpBMzAxUklzNTgzYjVxMFhBb01OajZG?=
 =?utf-8?B?MUFDRW8yWTlsYVdnNmh5VjFra0xkcVNSNjhYMUNZTFNjYm9paVlzNnBGY1Nj?=
 =?utf-8?B?RGhkNFJJNldjUGtOaDByUWlGeHpTOUhhcEVyMUxFZ3FwY0o1azcxOCtYazJ3?=
 =?utf-8?B?eld2VXBUak43OFU1Sm5iUmpmTmI0Q0wrSjVLQkxQZUVwdEdlM0pqUXE5REJt?=
 =?utf-8?B?d1BrMDRKZ29NUjNHQ3FiSW9tU2lUMlFoVkNzb01Ya1lEUEJsNUpHRVNDcS83?=
 =?utf-8?B?aTV4KzE3cjJqQTdmNlJtcVpIdzJ3YXpkRENpL1JJOS9DUVo5NzVmVStHdjJG?=
 =?utf-8?B?VVExS2ErR0ZGVHFzN09RWGVGYWQwa0VkQ0Z2RS9kQ3Z2RTFiMFpoY2Rqd05B?=
 =?utf-8?B?TFkwZHN5STBjUit2ajdBdHVxN1ljWnoxSDZZOVBsbnhKbWhmT1NCRU9XOXh6?=
 =?utf-8?Q?EJYQXP0EB4UiJZLRkzoIF073R?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c16d55-58d2-455a-d8e3-08dcd7baccfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 08:20:48.2511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypf7IDpQ3MHcCq2rKk2xxvlt30Pg0X18wPFvxcUSWo9pcPSPv4coeqmLTUo2zUMgXoMrJRHsUR9FfYM7sWTcQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgU2VwdGVtYmVyIDE0LCAyMDI0IDE6NTAgUE0NCj4gDQo+IE9uIDIwMjQvOS8xNCAxMDo1
MywgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEJhb2x1IEx1PGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4NCj4gPj4gU2VudDogU2F0dXJkYXksIFNlcHRlbWJlciAxNCwgMjAyNCA5OjE4
IEFNDQo+ID4+DQo+ID4+IE9uIDkvMTQvMjQgODo1MiBBTSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+
ID4+Pj4gRnJvbTogSm9lbCBHcmFuYWRvcyB2aWEgQjQgUmVsYXkNCj4gPj4+PiA8ZGV2bnVsbCtq
LmdyYW5hZG9zLnNhbXN1bmcuY29tQGtlcm5lbC5vcmc+DQo+ID4+Pj4NCj4gPj4+PiBGcm9tOiBK
b2VsIEdyYW5hZG9zPGouZ3JhbmFkb3NAc2Ftc3VuZy5jb20+DQo+ID4+Pj4NCj4gPj4+PiBJTyBw
YWdlIGZhdWx0cyBhcmUgbm8gbG9uZ2VyIGRlcGVuZGVudCBvbg0KPiBDT05GSUdfSU5URUxfSU9N
TVVfU1ZNLg0KPiA+Pj4+IE1vdmUNCj4gPj4+PiBhbGwgUGFnZSBSZXF1ZXN0IFF1ZXVlIChQUlEp
IGZ1bmN0aW9ucyB0aGF0IGhhbmRsZSBwcnEgZXZlbnRzIHRvIGENCj4gbmV3DQo+ID4+Pj4gZmls
ZSBpbiBkcml2ZXJzL2lvbW11L2ludGVsL3BycS5jLiBUaGUgcGFnZV9yZXFfZGVzIHN0cnVjdCBp
cyBub3cNCj4gPj4+PiBkZWNsYXJlZCBpbiBkcml2ZXJzL2lvbW11L2ludGVsL3BycS5jLg0KPiA+
Pj4+DQo+ID4+Pj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzIGFyZSBpbnRlbmRlZC4gVGhpcyBpcyBh
IHByZXBhcmF0aW9uIHBhdGNoIHRvDQo+ID4+Pj4gZW5hYmxlIHRoZSB1c2Ugb2YgSU8gcGFnZSBm
YXVsdHMgb3V0c2lkZSB0aGUgU1ZNL1BBU0lEIHVzZSBjYXNlcy4NCj4gPj4+IERvIHdlIHdhbnQg
dG8gZ3VhcmQgaXQgdW5kZXIgYSBuZXcgY29uZmlnIG9wdGlvbiBlLmcuDQo+ID4+PiBDT05GSUdf
SU5URUxfSU9NTVVfSU9QRj8gaXQncyB1bm5lY2Vzc2FyeSB0byBhbGxvY2F0ZSByZXNvdXJjZXMN
Cj4gPj4+IGZvciB0aGUgbWFqb3JpdHkgdXNhZ2VzIHdoaWNoIGRvbid0IHJlcXVpcmUgSU9QRi4N
Cj4gPj4+DQo+ID4+PiBCYW9sdT8NCj4gPj4gVGhlIE9TIGJ1aWxkZXIgZG9lc24ndCBrbm93IGlm
IExpbnV4IHdpbGwgcnVuIG9uIGEgcGxhdGZvcm0gd2l0aCBQUkktDQo+ID4+IGNhcGFibGUgZGV2
aWNlcy4gVGhleSdsbCBwcm9iYWJseSBhbHdheXMgZW5hYmxlIHRoaXMgb3B0aW9uIGlmIHdlDQo+
ID4+IHByb3ZpZGUgaXQuDQo+ID4gaG1tIHRoZW4gd2h5IGRvIHdlIG5lZWQgYSBTVk0gb3B0aW9u
PyBJbiByZWFsaXR5IEkgaGF2ZW4ndCBzZWVuDQo+ID4gYSBwbGF0Zm9ybSB3aGljaCBzdXBwb3J0
cyBJT1BGIGJ1dCBubyBwYXNpZC9TVk0uIHNvIHRoZSByZWFzb24NCj4gPiBmb3Igd2hldGhlciB0
byBoYXZlIGFuIG9wdGlvbiBzaG91bGQgYmUgc2FtZSBiZXR3ZWVuIElPUEYvU1ZNLg0KPiA+DQo+
ID4gSU1ITyB0aGUgcG9pbnQgb2Ygb3B0aW9ucyBpcyB0byBhbGxvdyByZWR1Y2luZyBmb290cHJp
bnQgb2YgdGhlIGtlcm5lbA0KPiA+IGltYWdlIGFuZCBtYW55IG9wdGlvbnMgYXJlIHByb2JhYmx5
IGFsd2F5cyBlbmFibGVkIGluIGRpc3RyaWJ1dGlvbnMuLi4NCj4gDQo+IFRvIGJlIGhvbmVzdCwg
SSB3b3VsZCBob3BlIHRvIHJlbW92ZSB0aGUgU1ZNIG9wdGlvbiBzb21lIGRheS4gSXQncw0KPiBu
b3RoaW5nIHNwZWNpYWwgZXhjZXB0IGxpc3RlbmluZyB0byBhbiBleHRlcm5hbCBub3RpZmljYXRp
b24gYW5kDQo+IHN5bmNocm9uaXplIHRoZSBjYWNoZXMgd2hlbiB0aGUgcGFnZSB0YWJsZSBpcyB1
cGRhdGVkLiANCg0KbW9yZSB0aGFuIHRoYXQuLi4gZm9yIGVhY2ggSU9NTVUgdGhlIGN1cnJlbnQg
Y29kZSBhbGxvY2F0ZXMgMTYgcGFnZXMNCmFuZCAxIGh3aXJxLiBUaG9zZSBhcmUgdW5uZWNlc3Nh
cnkgYnVyZGVucyBpbiBtYWpvcml0eSBkZXBsb3ltZW50cw0Kd2hpY2ggZG9uJ3Qgc3VwcG9ydC9y
ZXF1aXJlIEkvTyBwYWdlIGZhdWx0cy4NCg0KPiBJdCdzIGNvbW1vbiB0bw0KPiBhbGwgY2FzZXMg
d2hlcmUgYSBwYWdlIHRhYmxlIGlzIHNoYXJlZCBiZXR3ZWVuIHRoZSBJT01NVSBhbmQgYW5vdGhl
cg0KPiBjb21wb25lbnQuDQoNCmJ1dCAiYWxsIGNhc2VzIiB3aXRoIHNoYXJlZCBwYWdlIHRhYmxl
IGlzIGFjdHVhbGx5IGEgc21hbGwgZ3JvdXAgbm93Lg0KDQo+IA0KPiBBcyBmb3IgQ09ORklHX0lO
VEVMX0lPTU1VX0lPUEYsIG15IHN1Z2dlc3Rpb24gaXMgdGhhdCB3ZSBkb24ndCBuZWVkIHRvDQo+
IGFkZCBhbnkgdW5uZWNlc3Nhcnkgb3B0aW9ucyB1bmxlc3Mgd2Ugc2VlIGEgcmVhbCBuZWVkLg0K
PiANCg0Kc28gSSB3YXMgdGhpbmtpbmcgdGhlIG9wcG9zaXRlLCBpLmUuIGtlZXBpbmcgdGhlIG9w
dGlvbiB1bnRpbCBkb2luZyBzbw0KYmVjb21lcyBhIHJlYWwgYnVyZGVuLvCfmIoNCg==
