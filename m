Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51431F4284
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071174; cv=fail; b=ArX5dBSd/nJ9Z0sPQbb4Q5U0iLENlK0DKdMt+b/PSR0j7j8dSZL3Qhb37Ck3FNGfM4BPoyPVWD1DSUjUYdiKAVQAbYBdJR3ISKZTesmPx4wNJb25dmTp6KfIOjyfsYvF5t4IqAp2fj36UdEXJcxJKOkOeT88VMxzZGF+HS1XJcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071174; c=relaxed/simple;
	bh=jKMpr2tVeb1S28c8sfbaOIAsNfXJ2kmZ5s/a7l02wh8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=clv9NHWE8ADW8xup1B6F2BqdATQLLQTIDD1youWlOwqZjh8IYI7i81Ybfn3v6e4D4xk+vEYUQFH9Ufiqu83v/M6X8uq0htRCztq/pUgPuUES89MvWCl/5I2FjXh8ZTeXH+BkyxDucOoEEraTku+lAghmcCR4MTu2VrZhEduFRKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TC1B5WKP; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TC1B5WKP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741071173; x=1772607173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jKMpr2tVeb1S28c8sfbaOIAsNfXJ2kmZ5s/a7l02wh8=;
  b=TC1B5WKPGxUFBgnXr9N9O3A/Z5WsDTacBWmrSPeb5E2mD9CuuPNruJTm
   yWJhPz1cm+iO6+NMZX5q5FcoPh5JpEwFoE2JI8zNSI5rUEh3xchtGli/u
   o8m+Nf/TQWL+a7ars+oAQeLFBVr/Cw7rp69qZHSWAqQYsqG7Jva7nsC6+
   veSSOmxZmOtTtsaqgiQ7jBdPYJcxu1mSBx7FQcCMG4jNa2KUB7r+dEt9J
   ShDuSIOTgcQ2uQEMI/CiiUJFDC0SDTZI3wMX0y6h0jEJLIJuPbPJlJw4S
   ZKs0+HcGeK69l3LM+V3KQYB3P3Hwqs1b3wqsJJkEEfywcG6oxotctrNDg
   g==;
X-CSE-ConnectionGUID: iOM+dlICTqi3TaTtvD3N8A==
X-CSE-MsgGUID: BXQ5HcKeQ8yza0xWbK1SYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45900617"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="45900617"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 22:52:52 -0800
X-CSE-ConnectionGUID: VIIWkSGTR2qbFMwT+fMHwg==
X-CSE-MsgGUID: mxFRJBGQT8WYeA2YvV35nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123226378"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 22:52:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 22:52:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 22:52:51 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 22:52:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZUPBcOUeMtI8eVo4xGAuQxCteAPzh8M0noYdhCekys6b/JyleBkIG7hIQ/FEEjIdg1r714NVXm3CxjW3kG1gHhv9uwLkQopSKZNo1+MgP9C0h5yAJETr/oolOcdoIeSQkKIxtunCEUzdM7pWw04cGKeqmvFKqK4bfaXBoF3ejUs06Tx3/2HY00oYME2tzcFKGugD+O42QrHT2TrxVut15UDIXBPtFa0O2nSiEItn4jXB/d0dUSncuRTFVmG6rj3qT1oneiUq8nM3mTJVG2yHqPkOfHZab61FqRDkug/0vswI5H9/FLzM1CtkJQcHGTQNaxu6D1fN7DEFrGONKzM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHrl+S7tKMc5yLVls7O2/rvwPEfew0za9Co1eh8XeLg=;
 b=nMwBmUccOHcU5bPAtv8+yhHav53BG0FhYPlyBUOUNMgXuoZz+WqlIEiZyeAt4vTzdsN+XfCQJpQhPTmjmo7opZrGm26gDZaAhKxn+YUqVooc1viTmUuYb+9AIUpnsCiFWGEtvmC+v2IbtSrWD3k5ZLiL5OlCf196kwon3ZVKPzConm7YbcYaLiRj2v1yK9hThUlfu68ru1qP5O8wcwTvm4lvQA8b9kTLmVstC5rKrLDcsyR6L93f0RpZ+fIxJhZg5J66OJ1SLwPplQmdAXhdmg3pQmEpxUJq/JtbQxtT/gzIwDsoftBn7NINCiApyQbFmiBQ1QIaW85UU7qqepZYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 06:52:48 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.028; Tue, 4 Mar 2025
 06:52:48 +0000
Message-ID: <f4291e82-aa27-4baf-a950-c432f7a9a002@intel.com>
Date: Tue, 4 Mar 2025 14:58:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: "Tian, Kevin" <kevin.tian@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <BN9PR11MB5276BC7C4FD335EC5447BCA08CC92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276BC7C4FD335EC5447BCA08CC92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: aed8d321-ab84-415a-c113-08dd5ae92cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmhoZjB2MUorR0lRaW94aGlUekdIWHdNL2Zoa1ZBOHN4NzZlQXQySlVDQnJv?=
 =?utf-8?B?cDk5TCs2d1RMUXhOZlNBMGduTHgzMFBLOVZ1bzJUYzMvQkZFK3cydXZKK09V?=
 =?utf-8?B?eGt1Zjhza0pVWWJoK2dNSnNIb1ZBakhXcXhMZXVORjgvVnI0Qy9zOWtESXNQ?=
 =?utf-8?B?TGZmNUlJM1c5Z1ZDNFI4UmhKdDMvTDFGdG40UVltWExHQmRkSEk4UWRQUHEz?=
 =?utf-8?B?SVJaKzR0Nmw2MjJjSVYvWmpwd3dWMENQUWZUNmR5UTlhdGhQRDBjeDdWaUVy?=
 =?utf-8?B?UEYxYkxOUWZTWm9NYXhGbTJSMU5aMDBPb2lSTExiM3pGWFlBT0l0LzNCRHpq?=
 =?utf-8?B?UG9xNU9NRzJRQldxMGhLYmswZWtNRGxTUlh3aWhma1FJTTRCd25sNlF3QWh3?=
 =?utf-8?B?eEd4cnVTT0FwdUJrbEYwYkxvUlllZzBQNnVzRU5pcEtacDJrWGpSKzV2aExv?=
 =?utf-8?B?Uklka1poeW01MVBBWEpER2N3SGRPYWlxT2lKK1Q1VE82NDFzM283NHJ6WHJ6?=
 =?utf-8?B?TU9Ba0U5M2dXYUV3RlBPL0ExWmpzZlZTOE1heWRJSHFBS0NzTTNJNlNUQ2Rr?=
 =?utf-8?B?a0hRT1lZMGdoUWdGbk5BNHpMS051RHprNWxuOUUzaTd0UW9iNjRWM2hZV2Ri?=
 =?utf-8?B?SGxkbFp5Qi9YeVhaM2Nub1VFakpUR0ZWYm1idTN2M0czaHFCQ0pqQk9VVzlT?=
 =?utf-8?B?Q1pYRklvbjRnRE5maDBUSzdLWnNmY24wTHlmVkU4Y2JOM0grbGpWQmJNSlNp?=
 =?utf-8?B?cjJhTDlVaFBDRFFhS3VJaFZKWGJTQ0JzT3dYQ3Irbng3bEVJRDBPUU84SnlT?=
 =?utf-8?B?N2tKT0NzNTJUR2ZzU3ppYU5qdFVJby9Tc2ZGblN3eTJKVkdaVVBUZ0ZhY1J4?=
 =?utf-8?B?MHpiREhkQjRjbWwxbENFQUt1T2p2NHRwclRITFJrMWZCZ3RBRTE5eFc1QlhT?=
 =?utf-8?B?UG90ZXVmT2tLUkZBQ1pJb2xsNFE2L3crWGhoakJUYnpqVGFFd0p0RUFnWU9F?=
 =?utf-8?B?OTY3ZHFONExZMWh5SlIzYWxVeVE1NWI4YUhtMVhxR2s4a1BXSXZYSTVRVi9x?=
 =?utf-8?B?bzJvVkliSGNKR1N4QWhuZXppa0RJOXBxbVBkdW5XU05MaUlybGNkV0V6VFBW?=
 =?utf-8?B?azU1RUM1WmF4K2UrOXdjY3N1bEZDMXhkR2FMamk5bktWRlZXYW9PU0xnTW9z?=
 =?utf-8?B?Q21YQVhEakxyclcyMVk3aUN2NUdpaGNRV2I1Z21OU3NPeWwvZ2lSSjBHQWhi?=
 =?utf-8?B?VVZpS3dMMkwwRmcyZnRURWR3YnhyWGlkRU8rekN1RTJpaURxWUF5aFdyVTl1?=
 =?utf-8?B?S0tMeDl2RHdzREltYmltcFNoSGtVQmJLZTJab25LWFIxbmZkc2ZwSjg4SXFP?=
 =?utf-8?B?Yk9raEFvdzlNSm82R3l0MWd3Mk1tcVR4V3hCR3NnZU1YbkozblM3WWZWVnpZ?=
 =?utf-8?B?eU5PZG1mNGVMQ1o0YzkrR0xRS3NEWTdUZUhMb2VVVlovcnFXMmszdFBpZW9y?=
 =?utf-8?B?MlY4d1o4ZStxaEd1eTZoUG0ydlZqRFNkYWczSFQ1M09qZTJoK0lRMUhQRDdO?=
 =?utf-8?B?RVJJd1BFekt2VGhJLzNNQXZoZ0hZRVpVWXYzU2VudnVUc1JHcnhnSk5kSjdl?=
 =?utf-8?B?Zm9HOWdZeTNxWm4yb1FRd1dVWElYZ1VxdGc4Z0VLRjloL29jaE9xSWcwblV3?=
 =?utf-8?B?bk9ubmdVMFpTSi95SngzeWN6WXVKZ3U3S2ZMVzJIUEhCYnlxUU9Tc0xBVUg2?=
 =?utf-8?B?Sm9rRnJqRG1LS0J4V0xlVVFOVUZKK1gwN2JiOWcwNmhUbHJ5Y2tZd1I2ckJ4?=
 =?utf-8?B?Q1BIS1dCWUdWT2F4NDNrWmYyZXFZUkhKcFBlVzJJSXlyb1ZTZE02UjFPVEJM?=
 =?utf-8?Q?19McmbqqfmnXf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE1UdHFRWjNOTERNVGVHMy9xbUoxRFV2VDBsamZ2WjBrV1p2dUR4azd3MFVM?=
 =?utf-8?B?dndtZ2JqSnBBcFpoaHZxL1kraXZwYy83Q1E5SGRXSldDT1RiRGxIS2JUQzhN?=
 =?utf-8?B?a0Qvd3JQdythaWM3TlYyd2hDZGdSSEtoVkxuNkhDVllQTk13VzhSelFFMUp4?=
 =?utf-8?B?TENVbVlJZVNCYmtIQjZjUllzSDNaS0JNdkNIYnErNzZiUHNEamsrcmkvNWpV?=
 =?utf-8?B?S0hVM0piQTRHUGtsQ05UK3VQQUZCWXRkc0RwaCtYNysrdktlNmtYd2hmT002?=
 =?utf-8?B?K2VQMHppTDZJRzZ5bGpueDhMUW5aUXBTcXZDVXlXcDdHMitTYlFSK0dmVDBs?=
 =?utf-8?B?RTNIcytUYjA5emhyK2JwZ1VtR29HZ202YlJZcnJTNS81T2UwNTZLdCs0TlJQ?=
 =?utf-8?B?OFVZaCtBNjR1S3FWaVI2MkpDWVlkMUZiTmxaL1N6cmZST1ZQT3pTMGZzdDNy?=
 =?utf-8?B?K3NGU3Z4ZDlTZE1ab1VRdGVZZWQ1OFBxUnUyci9XN1FuQm9lL28xNWM4Wmhs?=
 =?utf-8?B?eWExWXZ4RWc5L3IyM0xkZ013NVpPc01wWVQ1OHZzSUNnUENMNmE4a3lVejho?=
 =?utf-8?B?Nm5xZXdLUlAvQWd4RFRZdnhzREdpYmx2cVVXUStMeXdESW1MYkhuVzdSakdU?=
 =?utf-8?B?b3lqbmpER05kWGZQc3Rld3c3eUttOHpWSWlLbmVQSXY3eGQzREVHL3VXMVNp?=
 =?utf-8?B?UzB2Vkh6cWJBR0ttaVpaTkUwM0lZTloyb25sb1Npd3FMNGJKZXg5KzlkMkhy?=
 =?utf-8?B?VkxsdHo4Y2pmMnp1bXRXcHo1aGF1VXBQZHJacUNHaDdZbisrZGc1bEo1R2cy?=
 =?utf-8?B?ZEswa2RtQWNiWS80MHVyMU10OGlLNERCU1ZlekdoOGwyQTkxTEw0N3BIampz?=
 =?utf-8?B?R0xoUm1OWW8wS1dYYUZoR0NUN1FrRVdvenN2TG56SXRESjFaemtxaFpXR3B5?=
 =?utf-8?B?ditOT0ZITERpQWdtb1lEaXcxK0hjUkIyblhFSkFURlVmWDJ2bmZsVDFTMVFq?=
 =?utf-8?B?WE1ZME42Y3Z2NkpJUG1kb0p2OWtoUWpYdjZaL0h0NXZ2TCt2WkdnOHUvQUEv?=
 =?utf-8?B?MW1uMkJ5NTNyT0cvVmFScHFwV2pwZ1pHMTZxU2hEYmdNQnVTZ3pxYmhycVN2?=
 =?utf-8?B?eXNENm1vRU5mV21rOUJvNlZPZTh4eTk4TTFBZXRpRGxhVmF1aHE2TXQ5SnZ1?=
 =?utf-8?B?OVVFcnNvUkt5TEJJbmk5cC9FWVEyaFhiSGFlZUFseGhUcXl0Sk9YMk9aRyto?=
 =?utf-8?B?OXNTWWJkejJKYnJ6RXkyMEFGbkE2T3VTeEFQaWtQWVdKK21qNGg2STNXaUhY?=
 =?utf-8?B?c21qZGE1WkJKTnhvMFZySURwS3JKKzhqbmE4Yy9KdUYwZXk4QVpZYkI4WkJD?=
 =?utf-8?B?aHJvZ0VjTDkyWit4bGpVYzZyT1hLYzExMitHU3dEZmZjREJZbml3NnRrc2dD?=
 =?utf-8?B?VjNabk80cnJuRVJtVnl4Sm1pSDhCb1Qxd3pHZEpSTDBSRVlUUEJlTmNCb2Vx?=
 =?utf-8?B?ZU92Z2lYSFdKTjBHRko0NytjNXlkM1Q4cHZ3V3VlTVVYWjh6SFJQVDhoVE1s?=
 =?utf-8?B?QjZIZUl6MG5nQXA4dWNoZVVtYkdLV3JJY0lNS0pqelpjdERHaE1UU0RXWkdw?=
 =?utf-8?B?c1NTOE83enVVRTdMSVBLUDB5clorUWNhSlVzTnhiWDQxdVlJQ01nMCswQmlF?=
 =?utf-8?B?Q2srbXJLOFpHWTBjKzRJcXAybE5BazhvcGk2MW10dGFBVVlVVS9kOCtvMTVl?=
 =?utf-8?B?TWZOUWZZOGRlc2haK3oxbUpuT25nOUtPcm0yR0JnTDltc0psQzQraXhKd3hR?=
 =?utf-8?B?RnVDalJCckhpVTNXWHBEakU4YUJQdzAxemNXZkJlMStsMElZZXgrRlhVejhY?=
 =?utf-8?B?dVR6VE5STTMrSkZudnJrWWtoTXZHWXVacDlScDlETVV1bnJpTnRrL0JVVlFu?=
 =?utf-8?B?UTRnNFBUMFkybWljaitGOEtQODd5b3M2blhjU2lROXpZTFFhY00xeTYxa2o2?=
 =?utf-8?B?V1BWYnZNRDlNWjZVaXB1dnRDOHVyalR0dlhwVmplOUQwSWcwQXlRajU0T296?=
 =?utf-8?B?Sk1DeDBoUVo2M29QSVdleGI4amx2S0wzYW9Da3VEbXZSQUtrQkt2czdkUHFr?=
 =?utf-8?Q?Ytex53mJZCyQoSvIEk6MRBitq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aed8d321-ab84-415a-c113-08dd5ae92cd9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 06:52:48.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJbmWxVkWE6PW0UyCp3Lp+4Vp4IuBOi4oxmtFJ9Z1o+KDNAZEt8n+s+RxtYqBCACOBtM55yrCTV5KmLRbzTuqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8132
X-OriginatorOrg: intel.com

On 2025/3/3 11:00, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Sunday, March 2, 2025 4:11 PM
>>
>> I'm also thinking about the impact of such a knob. How should we define
>> this knob. Should we allow it to disable/enable ATS? Especially in runtime.
>> e.g. if the device is identified to be ATS untrusted by the admin, while
>> the hw does not support SATS, it seems reasonable to disable ATS for
>> such device. This might change the driver behavior on ATS enabling. Intel
>> iommu driver enables ATS as long as it's available in the probe_device()
>> op. What about AMD and ARM?
> 
> I was envisioning it as a policy knob, which can be updated only when
> the device is not attached to any domain.

If the device is probed, there seems always a domain attached for probed
device. e.g. default_domain. Only when bound to some drivers like vfio,
there is a blocked_domain attached.

> There is a default value per
> device, based on hw capability and platform enforcement like SNP.

or maybe topology as well. if a device is plugged in a slot, it might
be considered as not trusted.

> Then when attaching the device to a new domain, turn on ats/sats
> according to the policy.

-- 
Regards,
Yi Liu
