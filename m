Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60E267B03
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483012; cv=fail; b=fENOieNZHRuy8DValX5KKa3xc3V5qYVXQSH9V0VmUmt+xcnxIXSNDfvuusUgWbLmS++o7L0N+EkiqHxtBlKw6wU4S0C0Z4ikypkGpBKDrCe0xs4oyplTTybWOeJ195uhld3JKCJbdaSBiGd64K5qkwDiVNi2l7a4A+xvcsDu2oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483012; c=relaxed/simple;
	bh=Xr4d4BT7DzkBlUlp4GDd21xO2S9bxiNhNupvNIPT3X4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ah4BWIINKlmkUoWGvYc7FQKZH40jp0Cb1FOv5DSofudeRZo/kBEuIBjgG5DoywgmyTGS4kiVCEmK9Zbgd3pUCBMemsxx9NNNTQTUn8e0L9eCNRv4uXBtGWFWktiC6zrgMIRFei1tq239zFAVbi1uJ3odGzX/ZUXfIqQa0tO+yvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6w1wGSE; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6w1wGSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740483011; x=1772019011;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xr4d4BT7DzkBlUlp4GDd21xO2S9bxiNhNupvNIPT3X4=;
  b=b6w1wGSEpkYCxhfYNGFTt4QQqyzThlNYlKJBFSW/cQHqXI1w9ajtFy0C
   GB/h+Ot++CjvT9lHATSXUswi13gSfQm3jG4xIhhusiHXlYuG5iCKAxinc
   BSZP/o1boG+O6v0kKLyhRJfDxfqpcy4iTtwouj43NZOvPDDzVwLZ+hab4
   brYSHAtb66uMxWHZpHvFFwX5dDE7XOm3bCuW5dENHM6umzf3fuoB7gOYt
   B7JhkrcK2erIyJgwyjsKwBGpyCRZ87H6HScFqL8EkXQKGztVPpKK/cGtE
   Pe7LAlw9jDvGj1csjQpZLLY1JmNAFSwy+IzKpgpSE9HBmNB+IFBNLpQWS
   Q==;
X-CSE-ConnectionGUID: HbRlXmnGRpuvMWk7K2aHKA==
X-CSE-MsgGUID: ysyNVcoVR7qJH1MKmuVV4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41198837"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41198837"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 03:30:09 -0800
X-CSE-ConnectionGUID: Ub9XUAqWRjyJPSMRJCs61w==
X-CSE-MsgGUID: CSxulkxdRje3ETUPARBdPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121615330"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 03:30:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 03:30:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 03:30:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 03:30:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGFKcb7RF/9BoMQKM+PZVVyhx/9nqatAhuEZ7TbICgeawim/bMdooUY/5lWf25dTx1omKzEhlsCPcoE+bcYduQyrsgWOGpMT40SRH2ToU/6zNzNs3uDvMhfZJWdeAhUPOZTCn6g6aO7o0cln38cO6DhHUDsM/AnSz/Mp/0rEHYXq3CGzQAXcQ/V2c0n1WmydBQq3KXVGtLnnokokvAWeQ/6AGbs/bXQPGUO4AZbJ3+fL7rd3NodNG/x1DP9SPJY1pyUOB2BPtLx+BvPLYnztRxD+bwWt/oyu8p5wGE0B6Z71F5jvf9yW4IGLokjA8MhG8rEFGi68HvwvBU8t2J2d5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4Yu2PLjtPh/UKdhTY69724h3pIRrC7Pz3xP34vOnQ4=;
 b=P5sMB5tjAnB6nNIPAYK7S8ukdruSlbMKTfm9Du+Zvswjb+XabTFE/5Bns0mIk5Q/z1Mm2ArL+rIFdPxdODEtyx/RqgaAL8hH+CUHfFMRJb5gMPASdod8zCRBBewiuCsyNGKZQLFhm/i6CXAkwpSdk3tNm45RAt5NDOagtqFbw90KG5L74oc+OR4WuzPVxEYxi7kVpYHSsdA5E8Qe8xhoWaslLPm0a5pMOAi3fH8CnYnGLdoTxEJa30H25okKvDknIYq4Vavq7y8Oq+xzV9M3sdRsBD8Ue6fjr+Zm9P7/E7k1H5q7slddfbgxBzHgao3WQfDTvgiGPrLo0oKoXY1ZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 11:29:54 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 11:29:54 +0000
Message-ID: <5f4bb0b8-0fb2-4db2-a81e-8b093377abd4@intel.com>
Date: Tue, 25 Feb 2025 19:35:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/13] iommu: Introduce a replace API for device pasid
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
References: <20250216035228.23831-1-yi.l.liu@intel.com>
 <20250216035228.23831-3-yi.l.liu@intel.com>
 <BN9PR11MB527698FB8038D4A41A4191E88CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527698FB8038D4A41A4191E88CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 75af850b-82c9-412b-75b2-08dd558fb996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHpvZWlDK1hBMElsbXBTQjdXVm9oU01qKzJpSzRSQWdRelhscDQzMFlzYTc5?=
 =?utf-8?B?Y3FNNmI3TC9KTTBjUlh1VzZpV2ZneEd5Vk1YUlJ3T1M1Um9zbzNwY3lscytp?=
 =?utf-8?B?MTRWVUwwQVNYaXJaMkwzSFVqZHRRVU1EeXY0ZVYzYjY5TW1yc1luTXE5bHA4?=
 =?utf-8?B?ZkdQWmpBMC9aZ3o5YnE2YkRiMHFaR29Dd3dLZjFSR1FOYjdWRzlsOGg5OEFV?=
 =?utf-8?B?WlQ0TXdMQUVaN2pRU0lYKzh0Z1E2dFFSbEd1dE11YU1NSjZxejFXcVhMMC81?=
 =?utf-8?B?ZzNXeUZwd01OV3l6K2s4OWkzWlVENXBNNmp3L2VtaTg0UFFaWkU4SEhTcXhu?=
 =?utf-8?B?WTAwQ0NEUEVITlI2YlJ1a1V2UTdsSkNBb01TZ0lLdU44SmtyZUZMWEtIVXNB?=
 =?utf-8?B?UHdMb09Ycm1TOFRzekxoWGhBaDBVM09HLzlxRGRMSmszYjk2ek5mcU5QOVdw?=
 =?utf-8?B?YzhUUDBkbFRxdVN3L21uWTduVWh0VWhyMWZpUTkrVndraDFJc3RXaVBsMlRC?=
 =?utf-8?B?SmhseDNCQTUwbVZLWVVVVU5JQlBHbE12S3RhTWxHdUNIT1pUQVFrUnBQWjVM?=
 =?utf-8?B?N0xtOWF0bEhRSEpRdlRpbUR1WUppYlhER29KMjdXZlYwMFo2WHJ1czNaWUJk?=
 =?utf-8?B?bE9jcHlaWmY3ckNwOTBhREhOVlF2dElUUWwvemUxa3A4dlJUK0kzRjlLV20y?=
 =?utf-8?B?c1ZtK1d0Y1BkQXVZaVBKMGttalA5ejJXTjA1Z2w4Z0twTERtcHVtUHFKN1U2?=
 =?utf-8?B?UGM3eWFlVyszTExwbnpScjRBSnZGY01tWVdxMVhXTHN1TnRsdDFybVZlajBr?=
 =?utf-8?B?OSt3aDhmZ25iZjJncUVkd1o3LzFibjl3WlloQnkrWWpJbzUxQmlzMkVlK1Fp?=
 =?utf-8?B?SFFOZjBOV1lVRFFlZ2ZveTFzd0xzTGFoa0FWTTZ4RDhxb2xzc1JVVlJkSys1?=
 =?utf-8?B?MWVLT1hnWkJoT1c5S0dvbDlTMkxkTDRhRkw5NUlFWTZqZ3ZGK2V0bi82NTZ4?=
 =?utf-8?B?THNUbFBidTdhYUZpZ3VTZXZkWkNLbGJIalE3bE50NmRhNG1oUlZRQmR0SHk0?=
 =?utf-8?B?Q2xhbFBVUjl5b1VQWWZHNGh5VnRMMzBScmlNUHAyTEdWRGF4b21mSXExOTRa?=
 =?utf-8?B?U05MbnpsYkhDVTE0b3lObDVGSUIwWmM2REoyRUpCWjJVUFlzOWFLKzZ4clFj?=
 =?utf-8?B?WjRSUG9QLzlKdGFVaGdySjRGNXhXWWp3T3laalJkcjVlempOZjZ6TEJLTkNI?=
 =?utf-8?B?MlFCQ08zaUZ3M1NYTC9TK1hpKzdlSUp3dGQyT0NDTWgvSkxCcVFoY0trYld3?=
 =?utf-8?B?QkF1UldiMTR2dGF1eS9ZbE9QbllJR1VVd21PVTNDZXJ0d29DNm03aEpRSE1m?=
 =?utf-8?B?Y2tvMFJ4YU1tVG5ET1RRQzNxZk1Vak1LRjVraVpsQlBydFpUcHprRkpmMk1k?=
 =?utf-8?B?UUlFbFpRZGhoRWRHbkZxVXBvMXdUWFdJdkR4S00vK1BrMXlqdFY3aCtDRXph?=
 =?utf-8?B?eUx3YTJIVDg4eFA4cVpVR05VYTRsK1l6V0VHRFByemY3RzdKck5YSkV2a29r?=
 =?utf-8?B?RWdUWDF1SE1jR1BHbHhDQ2hXRnE0NnVPejVPOGxTV0haUVNQVkVlcDkxYzRS?=
 =?utf-8?B?QXo3cUJRejY3a0lvTDgxc1REcTFrWUtVNTgzY2lCbzFVWnp6UjNPTERTajdO?=
 =?utf-8?B?YklpM0k0WHVJSjQvV0pjclRJaW5vWVYzQ24yOGlVS3EwbFpmNEVIdHROTmNq?=
 =?utf-8?B?L1dwRDVVTGRlalMvTXVMTGh3R2VJV1R2NDVhbjhHUHcyY1ZCUldaZ28xSXVr?=
 =?utf-8?B?bS9kRG9sbDVVMTkzd3dibEtkVEJUWjJPOWo0VTVNQ1FuU3FkRGRvSGgybVND?=
 =?utf-8?Q?8LlwxfFzuhj+R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KytxNS90TDV0dmk2WFhRNXVaK1lLcXU5eUhPbkl5bDZtTjRFaGVKb0dkT05K?=
 =?utf-8?B?anZtQ3BYd3Q1NzlDdkErZGwzeTQwSmo5QTNPRmNpanNLT09SWlVOUGNaekU2?=
 =?utf-8?B?OW13bHRXM2R2bEw3dXdvaG9LZTZxOG1VbVVoRFVtbmtWeFg5QXhsc084Tll5?=
 =?utf-8?B?a1ZybGZkaVkzRmJnamY1K1d1bHhlTjgxVUt1cG5qMEpFNkd0MHYwQnllRUdR?=
 =?utf-8?B?RlJ4TjgxcTRRcTNza25aNllWYyt3ZDNnSldlYjQ0YjZtQ1pYL0tHdk1OOTR2?=
 =?utf-8?B?MkRDc3ZEMXhnWW1jSUpTczgxK3NLc3BNRHJ6SGtPSU5EMnhqVEhKcGswOCsr?=
 =?utf-8?B?d1lUdnQyMUx6MmVIWFJzTDFhckdFWlNseFMrb3FzY1pYcEV0ZldsM2dkRGVF?=
 =?utf-8?B?RnYzRVNERjk5WEhHUWloSUN2Y2Vic09aZnoxU09wVTZkNjMvNklsMXBEV3U3?=
 =?utf-8?B?ZVBLK1JuVHhPeHMvVmJvOFY4Y2VLMVR2b2xxZ2tzSUtSTmhaTFhrWktDbHZu?=
 =?utf-8?B?NWlyZFNncHlMeU90aDJ1cDNTcmY0cERJS1dMcGNxa3dzNTQzaG5KNm5DeElQ?=
 =?utf-8?B?M1RzV0tFUWhPbW9JZThQWTd2OWhnM1hMQURaQ0JrYXpHVk80eFREUUJ0QlhC?=
 =?utf-8?B?S25Sd1l3M3FuVUU0dlkrWUJSd1dkZUlhMU5nWjhFUXJlV0FaQ2Z4NVMrNzlk?=
 =?utf-8?B?NFBXTnkyRzRDbHQzcUZlazZKczNuc2t4ZzljSXJtMGdwYmJEQlBCaGVkdVN0?=
 =?utf-8?B?SWZjc3lHdER6bW1XaGlIUDBUaEt1c1Z5dFhrYXNqajlaM0ZaSXZFbXlQM1dv?=
 =?utf-8?B?MmE1Y0pFNi9ZUlcyYjV2Q3QxdVlWM2lDTERtTGptQmxObkRiT2ZsNlZGQytY?=
 =?utf-8?B?Q1pUbmlrdFVQcGVhMk55Q1NuR1pOcmpFS2UrNURuYTl2cU1MaWQvaDI2Wkpw?=
 =?utf-8?B?blZvZ2x4cFJGRjZPdHZhelByOWVFUXBmVTFxclA5cDRxVlVGYjh4dGpsZld3?=
 =?utf-8?B?Z05VcVRmeDkwTFhwUHREcTV6UXhFUDlwYmVXSlJuM3g2OWhTNGpvakx6RUNu?=
 =?utf-8?B?QXRpT3NkMEN0VW81Unk0T1J5VFU5UllScisxZWd1Uk40eWNCUWF5czRlVm1Y?=
 =?utf-8?B?bEgzdUxPUlJYcWdsSktvNVRMQUdtREpucE4zbUVYeGVubXhWRU4zQng3aHJq?=
 =?utf-8?B?NTVKVWMyd09raFFxakNhSVY4M2Z2WTd2bWcxMlZ3dFZIQmtBZmlhMys5SzBQ?=
 =?utf-8?B?cEUrL2xtS04rbVFNMWcvVlBuRWtTdENUWGFtalpjUWJIWXh3QjdycDZwclJk?=
 =?utf-8?B?U0tJaGs0R0pwUkhXNHZxM1ZHK05KNmFJRHZSd3dLUkZSSGxHUlgxM0EzT3JV?=
 =?utf-8?B?RUdjNHF2cVl1bmgxeDFOSXdFckdidjhWdHk2aEZWUDRGSTRTRVQ1Mm9ZWE83?=
 =?utf-8?B?amk1YjRqd29HNlZMend4ZDl2bXhlT3V4N01PRVJMVFNlQkcyNjNRdktZeUFl?=
 =?utf-8?B?WXErazlFYkRKMjhKeVNUK0JhRkxxM1dBYldUVHNnYTV3eDBrU2tROXR6UFJF?=
 =?utf-8?B?S3lWZ2xadWdtQStHSUlFMVBOK3VSRXdxYmlLZXZpaW1mblVudmV4d2JmSkdt?=
 =?utf-8?B?T2xvZXp0ZlV5cVR6TVpGWFNtaG04YXpYVmRxelhlUVQzSHBmNTE5N2JkRHlW?=
 =?utf-8?B?ZHhyNUVUUUtCa05pTWR2WWFPRjJvdW5QMEltQ016YW1SWE52dGVZK0VFTm5G?=
 =?utf-8?B?TEJFc3VIWjJWb2RobFV4SmwwSFFQOStzS012azAvTXJCYmprcTd6djl2VllK?=
 =?utf-8?B?aktEdHdyYy85Y3JTYWdpbHc3Zzl4TFJnSzdObnI2UXM1dEpCcDI5V3NpYWY3?=
 =?utf-8?B?ZGhTeTZsSHQ2VDVMWnZSNDFsV1ZwOXRpa2lFM0VRWGVzVWtQeGVjUFg1a09r?=
 =?utf-8?B?N2N1YWxYcUdpMzdkdTZYelNHSFJ0dWFxSVJHZDNlVCtMZ3R6TzRPSU4zQXdY?=
 =?utf-8?B?NnBuSm4yVmsya3FYMktLKzg0NFp3VWJ4cDJBQjN2bUR0OWh5OXpReFd1Vito?=
 =?utf-8?B?NmlDa3JlRDV0Uk5zNTMwTUZyOXhoaTZkd2lJWWg0L1A2blFYQ0JueU8zM2Rz?=
 =?utf-8?Q?498U0CN0X3yGYp3RU8kU0uWtF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75af850b-82c9-412b-75b2-08dd558fb996
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 11:29:54.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BKwJANbIqkbdLn9i1Xt1a6GrU5y2V2Ycg40crTk2egiQX9/HcGFbXQ/hGaxNTUdJMaqlwFFfQrOY0S2hurm5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7187
X-OriginatorOrg: intel.com

On 2025/2/25 17:55, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Sunday, February 16, 2025 11:52 AM
>>
>> -struct iommu_domain *iommu_group_domain(struct iommu_group *group)
>> +static struct iommu_domain *pasid_entry_to_domain(void *pasid_entry)
>>   {
>>   	struct iommu_domain *domain;
>> -	void *pasid_entry;
>> -
>> -	lockdep_assert_held(&group->mutex);
>>
>> -	pasid_entry = xa_load(&group->pasid_array, IOMMU_NO_PASID);
>>   	if (xa_pointer_tag(pasid_entry) == IOMMU_PASID_ARRAY_HANDLE) {
>>   		struct iommu_attach_handle *handle;
>>
> 
> What about calling it iommu_group_pasid_domain(group, pasid)
> which accepts a pasid as parameter so the caller doesn't need to
> do its own xa_load?

I would consider it in the new version. However, if the caller still
has the entry, I may still need this helper to avoid duplicated
xa_load().

>> @@ -3388,7 +3392,20 @@ static int __iommu_set_group_pasid(struct
>> iommu_domain *domain,
>>   	for_each_group_device(group, device) {
>>   		if (device == last_gdev)
>>   			break;
>> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
>> +		/* If no old domain, undo the succeeded devices/pasid */
>> +		if (!old) {
>> +			iommu_remove_dev_pasid(device->dev, pasid,
>> domain);
>> +			continue;
>> +		}
>> +
>> +		/*
>> +		 * Rollback the succeeded devices/pasid to the old domain.
>> +		 * And it is a driver bug to fail attaching with a previously
>> +		 * good domain.
>> +		 */
>> +		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
>> +						    pasid, domain)))
>> +			iommu_remove_dev_pasid(device->dev, pasid,
>> domain);
> 
> Above can be simplified as:
> 
> 	if (!old || WARN_ON(old...))
> 		iommu_remove_dev_pasid();

yes.

> 
>> +/**
>> + * iommu_replace_device_pasid_handle - Replace the domain that a pasid
>> + *                                     is attached to
>> + * @domain: the new iommu domain
>> + * @dev: the attached device.
>> + * @pasid: the pasid of the device.
>> + * @handle: the attach handle.
>> + *
>> + * This API allows the pasid to switch domains. The @pasid should have
>> been
>> + * attached via iommu_replace_device_pasid_handle(), otherwise, this
> 
> why do we care how the pasid has been attached? and in reality people
> does attach, replace, replace, etc, i.e. you cannot expect the 1st operation
> as a replace.

it's a typo. :) It should have been iommu_attach_device_pasid_handle().
However, this comment should be dropped anyhow since we are going to
support replacing domain with handle per the handle series. I'll have
it in a refreshed version of this series.

The replace path is going to have something like the below. If both domain
and handle is the same, it shall return directly.

	pasid_entry = iommu_make_pasid_entry(new_domain, handle);
	curr = xa_cmpxchg(&group->pasid_array, IOMMU_NO_PASID, NULL,
			  XA_ZERO_ENTRY, GFP_KERNEL);
	if (xa_is_err(curr))
		return xa_err(curr);
	if (curr == pasid_entry &&
	    new_domain == pasid_entry_to_domain(curr))
		return 0;


[1] https://lore.kernel.org/linux-iommu/20250218195756.GG4183890@nvidia.com/

-- 
Regards,
Yi Liu
