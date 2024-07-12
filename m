Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749FC8F70
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720751970; cv=fail; b=fZ66/BqLFjhvYAg6kI2LKanEBO1faxfCLuky6ztTzJjYcsFab3pGG1b+pBHUgKjXr+a1ZqgqEAlj1ubxzFeH/DEBv6wypqLM2sxuspqIRXR9DvNkluevGraUoiFHP8UTrYBnwQTcg1FpB0WPQSfBw02WhRWfjFCQ9vaHoaFmNnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720751970; c=relaxed/simple;
	bh=6/pe64q3lihmNIs9ScZlzmKXNWsNWrmnilevMhA+rV0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dNJP/dMgpxlOF2sy6N8X9Bm7KL8bZ5r8WdtMA2bz3JiztxltTXPo2b3nB5r15bLGtNwWXQROF9Graz+U1tqXGHZ6fDYbK9Ak7E9tkIxbRhRZXXNeBT9BmOMk8Ma8NulA0+ICP/zQNQSKOrWj14bZO7Ys/MNOyhDczloU+zDnxyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZY3tbnPg; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZY3tbnPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720751968; x=1752287968;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6/pe64q3lihmNIs9ScZlzmKXNWsNWrmnilevMhA+rV0=;
  b=ZY3tbnPg0MNIyg53RGsr1gAImp3SVs5qrgbP5aGy4A1cry1hephdybvI
   93VJ0ap1Z9YNlLFrVIfJYzFrLcRt1WurQCYvaJ+i0vqTXlixr4KrdRKOn
   8NZkrbXI0SwsuHKVJrzsfkw6T3rPI6le3IUD1lPHqS7Re/KjNI1cVoOF8
   0eKwdaRelDb1Bq7JNDYWl87lh8dM95Q2+PoFSK9eCrISsIFbuEEzPM2Wk
   A0Q5G0VzG99v9dYNLTewrAWZoW3bwDJREocBgLh1KH7RpFd5mS1jC9IZo
   e0t/he5fF7Zwl5IoHooUs2Kuik3u05C9JWQ4SKRswuMwtaZudTqtkeiwR
   A==;
X-CSE-ConnectionGUID: DxmiclI8QMWJAKQ8r7J5eA==
X-CSE-MsgGUID: kNgSwphTR86qcVN1R1FtjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17796937"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="17796937"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 19:39:28 -0700
X-CSE-ConnectionGUID: A9K8GPQ6RWaIpbQcgHp2IQ==
X-CSE-MsgGUID: fIYmaF0eTqGJ2IsqscdZAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53699169"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 19:39:28 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 19:39:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 19:39:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 19:39:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xe6w04A9fshHpti6gdojnGC6fAgZJ+brUh2D8/rCrx5gzzAtH2TqEnxL/d4pAh8KETajHL4dEHSWsnQj53qD7KGSK6rhWrrL0uhmgGmswA9CRqbXdpHFKKKuBzqtMBzvm4PLw12L+mSjaHKYg1BPrTeduYggoapWU3V+ZcsrC5Ya1/Mu569X9qRBkatBfdaEe78S5zxLFU/ix1ABPFbUSQ3C1JOWblZhHFRbKA1HbwQ2+qdFquPddf6QG7TLtRnsyRhVLseOFrF1bJTA0bwlOpGc4gChhabgq+MzmBMPL/JE42POh85KBGG9+Aw1jB4tGvpy8zk4ZQw2oJN6we+XXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYo1T8Vn6JPm6e0E+opgJEjz+z1D4y7d4GotKQJqtbQ=;
 b=RFUkRVJrLCyOyKdVCvvKKAX5midUb17jas+sq4PjuiFxJelCHIzqvv4XspXSu8rBNPCxuS8vk0gEQreMcCohKbX2VD4lYSvlYYdj79aD0Z9gKkYrXLLygZ0+FalaCwhFwTMkJKxvM4+BGt2pmAs7JmgiyarvO0k7G+y0UNiAnNPnpJAgYMWPWyNEgC4SszzqOYgjrzixoSbJdvtWT99ij5wG9vB596fJbgO7cykjU37hiZ3cJ3aN9LZn+Ed+I4vjE9WA7O1PXwo9rVs8Est7eG+4vFVI2hOx++3ppFpnZgxB8x0aSjrhvQLxT9lgfNCWD6acpVN969KnW1QdVkzjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 02:39:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 02:39:17 +0000
Message-ID: <6061f40e-6027-492d-87ee-8dc47c2efcc4@intel.com>
Date: Fri, 12 Jul 2024 10:43:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Baolu Lu <baolu.lu@linux.intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com> <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <4ffc953f-4968-46c7-b6a0-b7b2fc454564@amd.com>
 <71880aa8-adb9-4f3f-ba9a-7862e8d30b46@intel.com>
 <f75d4ce8-d4e2-414b-b3c4-76abef779eb4@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <f75d4ce8-d4e2-414b-b3c4-76abef779eb4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e05e86f-11c1-493f-632b-08dca21bd355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzVKaWpZT1dLT1BjWDNkRk9ZOTk2VVhSRTdIR2g1d21GYnVKQm13RGs4N2FJ?=
 =?utf-8?B?RHlWeTdRMktSSFZoYnJNbWlJRGxTWnVYUUJTVUFmT2kyMnovT2hPZk82UjZo?=
 =?utf-8?B?QUxFN1lxQmZqNnoyM0VybEZpMkg0K2YwcWlCdVNXL2FYazd5WSs2Qkh1Y0Uv?=
 =?utf-8?B?N210dTFhVHRxTXZqV1ZDZjY2NEVDVW1RYklaR0dBbjB0K3pHdjFHWlpWN0hw?=
 =?utf-8?B?b3VzRTk5MXFkamxweTBta1hOVlp3ZGVwWDFPQ1VvcXVtSVdtRklPUEdBMVpH?=
 =?utf-8?B?c2laY2h2RGY4SG12T0NpNVlHT0JmQXRFclhadm1DTGxLZ2toSFlnQ3pkazU5?=
 =?utf-8?B?bzhMNDJsTkxJNnoxV1VPeWVhYVVkNGhZRXFKMWxiS0tncDJEZE9LeUhqMUZt?=
 =?utf-8?B?RnpiUXlKVy9veGNUZWpWMVJ6dmtJMW9LK3pWd0RJSkxpam54RGVCNUUycm41?=
 =?utf-8?B?OWNBTE9sTGI5QXBwUnpZQjl5bmYrREhkczNtdmUxdzBMc2w0ZnZXQ1N2MVp3?=
 =?utf-8?B?NnhKZ1Y3YXJZRE1MRTlOUThrWUZxbEJUbER0TWJvS1dNSWVyeUg5WDFEVWhS?=
 =?utf-8?B?RzlaTlFtdVYvdFQydDB3VnpqZDFRcXA2eUMzbTEyK1B1T0VUR1NxcFU5emhw?=
 =?utf-8?B?RjA3VzBHdEpLKzJqY3VDemYxbnJKYmZVTFpqRURsdUtSaDdnSHVnTTlxcUR3?=
 =?utf-8?B?dWlpRTkrd3IvQUFuVVVDSmYwZUdRditoSCtXUjhHeUxlRCtVSUFXaWlOdnB2?=
 =?utf-8?B?OTg0Q1o1cnRxeXc3RHVHVTVMNjlRWllpTWZwOXc5SUpiMnYwUG9wOTBVbTdT?=
 =?utf-8?B?NVlScTk1WlZ4c1ljd0h0OFBJUDM3WlUvb3c1MEh6ejAxR0hBbzFTc3JSaUFU?=
 =?utf-8?B?bmlWUjFpVzZaTDFqcDFMamg1ejkzMExKRDhmb2lnK09xbXNqUVl4OWhxUjNp?=
 =?utf-8?B?cEhZSmdvV3kzNDRHcGtzWEJMS3dLU1VPVnZnZ3cyZEdqNW9BQnRuOE53QUJY?=
 =?utf-8?B?amhjd2EyYUhtZU56d0gwNGcwY3pFeFQ4NHFGWE1jSVpUc2t2bGVXdG5xYUc0?=
 =?utf-8?B?dUltYkJVYmpUanlCbXo3NG9VQnkwaFdmcVhlblFmVlJXTFJTemI4ZUhJL2Jh?=
 =?utf-8?B?MmtVNzNHejNWSThOVjZDTnl3VFhNUUJzNHhhMFZXaEFFS0xRNTdNSWFiUDEx?=
 =?utf-8?B?UW1NSEFNUGJ3R3Q0amtOY09Ec01ncGhraXNKTHNEK0dUNU56L1BxZFpqQUJl?=
 =?utf-8?B?MkcxVFRhRmRoUnBkWklkRkVycGthL2FmKzErbjc4S0s3YXRzeDFhS25Ua1Ra?=
 =?utf-8?B?V095V1A1UHIwQlRkKzRxYjMrRE1IdXdFVTBqZmtIUGhiRUFSTm5td2g3c0xH?=
 =?utf-8?B?TE96RkZsOXdEVE13VmJnYUg0aTlrRndXeFVGL3cySTYvSDZGeWJhclZHcS9r?=
 =?utf-8?B?RFJGZUVzay9UWVF5UjhUampXbDRwN0ZCK2hYOVl4aS9XZnZhdjlON0tEdXRN?=
 =?utf-8?B?N05ONzV6WEkzc0xPZlhWMGRiOVdnL29jWXlwQWZHQVYwWG9ObkhXRUJGWUdL?=
 =?utf-8?B?ak51L1dSRmhiOU13S0N1TDVsV3VlUnNEL0I5K0ZYRWpJOVU0V2NGTGh2WktG?=
 =?utf-8?B?bTFmRGY0cUdENHhqRWhLT3RVTmhQTDhCQjF3dDhNSWhtZVRBaVBacGJQMGRJ?=
 =?utf-8?B?VE1WZzErekUrWURYTUd1b0k4RmZxZkt4SkdGL0NhVTRHRnVpck03QVJvUmt5?=
 =?utf-8?Q?F1DqiXO50thwcThL1g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnpod05LWTdhOFVZMGZXMExWRmsxQlhQZS9XV3hsRnQzWXo3eEhvMHR2cEo1?=
 =?utf-8?B?NFRyd09pVUNDd3RHY1ZyUTRDSS9sRkptSllzQ05JOVY3bDhKWG5Vcm1FenBI?=
 =?utf-8?B?VzUrWWw5Q2xDdUd6amY4Mm1NeUdIK1hXTUIyejkweTFNK0xSY0p4RW0wdEd2?=
 =?utf-8?B?b2p5Z2xQK0RhdVhMODRQQWptSkNsWmhQeFQ3Mk56VFhSYkJtUlJIZERXNTZP?=
 =?utf-8?B?eG9tVmNzR0pycTVaRTJNOGRRa09sOEx0Y2xXdEN5QjhNbldSLzM5Zks3UjJR?=
 =?utf-8?B?NE55WW0wVEpKRndvcWI4aVMyczYwU01aTGFLR2RkcWMzSXVMUnhTT0UwLzht?=
 =?utf-8?B?anRBb0JhU2NaVGk3cTZ4WG53NFNVdmduU24ycU4zbkdkVXFITHdPVis0cEFi?=
 =?utf-8?B?MnI3UWQ2R2N1T1BzK09PeUt5Ym1zYU9xYml5Q25sY0hodGdzbG9mUFpxRCtK?=
 =?utf-8?B?am1HWmllQzArNlBkMDEyOE1ranFTN0tmcEpVY3VCVE82ZWdSSERWR1I0M0ha?=
 =?utf-8?B?ZURUNWhGaVVhTzNyZzFFcHI3TXliT1RhS2pMQzZTUmU0L1RMWUJndGs5bmEv?=
 =?utf-8?B?TXFSOGhOMXZuUkxERXdWRG50SGdOa0lwUTlwU29STFA5TGxyRXMvNzdSVE1B?=
 =?utf-8?B?eHpnRzRFUFlGYzljZUxaRjJtRGZESGJwSnkxR1E5cmJzMUltaXlJZWN5aEpk?=
 =?utf-8?B?NXU5bFVkRWdSWkl0L2VITDcxNlFDY2ZKSXRrRm4zU3Zvb3p0c00vcXcvRTFW?=
 =?utf-8?B?Rm1KeGdnNHpXdUw3cWM2eHl2ejIyMlZFVFo4dEVQUTl2Skh4bS9aQ1J4azRX?=
 =?utf-8?B?dnUvWHg2aVlDbmtneHNpaEtrYWJUSkVVQ0MxSUxLWFhZVmVTY1FqS04wMjli?=
 =?utf-8?B?bmhvK1F5MXhGTDVzVUswMFo4dCtPZlN5ZW1ZOGVKbzR2eXJXdkZQdHBaUCtL?=
 =?utf-8?B?SmY5OHVKVlMwdW02VmlOQ0NkUkV4L3J0Sk55U0t0TVZ1VDlZM090d0JXUUVS?=
 =?utf-8?B?citVbGpRVWgrajNRaEE3NHNzeWtBSXhwa0dRV0FKR2ViRFVsekRkQldCYUNT?=
 =?utf-8?B?VFcydVM1TzVBMmVVQUpoZTRXcG94d3dhSjEyV1prNlJvdXRmZW9UMlgreEZ2?=
 =?utf-8?B?U3BOUEVBNEpCZkVidEVXYkxHOHZnN1VqcmFodXE0Zm41djc3WUVmWkMwb1NM?=
 =?utf-8?B?Q25EVXoycWZYaGJDSjFhaWpmMTZqRzZKdTMxaUd4eFFCTUt3aHZ2a3RmQ0Rz?=
 =?utf-8?B?K0h4cks3MW5ZL0xRazNzbG0xb2lJQU9DUEJDU2NQY3E5Q0l2VkNsUDN0R2J5?=
 =?utf-8?B?dUExN0haMDBaY05yVDNLOTN0enY1RTIxVy9VMmVOVS9jTEdrTzNVSXpqOVlO?=
 =?utf-8?B?WHZnTGhHNjJDK3JZYzZhTnhINk5kbmJqSTVTRzhxVVRTL1FCMWJUMm84QWlj?=
 =?utf-8?B?WTM1MXRVeUN1OGVZZW96b0h0dk9KYXBGVDlNYzEreVJyZXpBNXJkRkhVdnhI?=
 =?utf-8?B?dFM3akFBZGhmbkFvL0RnYmhRR2E5U1N0OXZ6QkdQN3FUR1cxc0xKek1aNHow?=
 =?utf-8?B?ZHdESnJCNytJSURRdVdObTlFYlZwTUJBeSsvd2huSTNUdEkzUHkrS2VxL2xH?=
 =?utf-8?B?NzZvTWUxTjdyNmpBcVNhdWIzK0J5dEZtZHVHN2ZCaWw1SXBROHNleXBubGFU?=
 =?utf-8?B?ZE1yRnAycHJNV1IzalU3TGN1WENsR2N6RXNZNzc3Zk15VWd2MzlLengwd3Vp?=
 =?utf-8?B?SnB6MVdrSktjVVlSV3h1K0x0UUl4ZHA4QXVBb3VLL3o2L0lOQmNEdSs5OHRh?=
 =?utf-8?B?RWlwN3NLUmR5NExpMERkQkZaTU52VU1WSUdTLzRHc1FLUlRhMEFTdCtlWDFX?=
 =?utf-8?B?dnBqTTZKenVZT1lUTjVDNmVQeXZBN2kyZCtqdjZkSWxUUWtYL3BCY056Tm83?=
 =?utf-8?B?eXVQSE9jMkpOMFJPQ0xhZExRTkhFVnlpaWFFNUM0aU9rc1hNNXhONGYxY0lJ?=
 =?utf-8?B?QzlnZDZiU1FtbkxhZktMQzN6NGNkaWpQWExBNE9qa2NmdFQ0dmxuckFZa1JE?=
 =?utf-8?B?NVZnL2ttRVk2b1h0MHBrT01IVjA4SnlBbnE5SjdPQXd6TXp4NWVRV0hnZE5I?=
 =?utf-8?Q?6LxAVygJ6KngGv+v/3QYB+ged?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e05e86f-11c1-493f-632b-08dca21bd355
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 02:39:17.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CkbfuQcsr1DsUyK/OPv4X0iVOKjUJcaimcsawxKD0/jhJL8MZVq9KOXmidIPOhBvwvRhTdrz+M9uUwzndbenw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
X-OriginatorOrg: intel.com

On 2024/7/12 09:39, Baolu Lu wrote:
> On 7/11/24 9:56 PM, Yi Liu wrote:
>>
>>> For UNMANAGED domain (like vfio-pci), we would need a indication from 
>>> core layer
>>> saying whether we want to allocate PASID capable domain or not. So that
>>> internally we can allocate appropriate page table type.
>>>
>>> That means from VFIO layer we need to pass this detail to IOMMU layer.
>>> For this part, I will start watching your patch. May be we can start 
>>> discussion
>>> in that thread itself.
>>>
>>
>> yeah. Looks like you need to pass a hint to iommu driver for domain
>> allocation. For the usage vfio+iommufd, it is fine as the domain_alloc_user
>> accepts a flag. For legacy vfio (using vfio iommu type1) usage, it's a bit
>> tough as the domain allocation is within kernel, userspace does not have
>> any input on it so far. And vfio type1 does not expose the domain concept
>> to userspace, it only exposes container which is kind of an address space
>> object. This means no good way for userspace to control the domain
>> allocation.
>>
>> If it's only a matter when PASID is enabled, perhaps we can skip vfio iommu
>> type1 as it is not supposed to support PASID.
> 
> As we have already agreed that new features should go through IOMMUFD
> and vfio/type1 is only kept for legacy compatible purpose, I don't think
> we need to carry any PASID bits in the vifo path. Did I miss anything?

yes, we do. I have below kdoc for it in my pasid series [1]. Let's wait for
Vasant's confirmation if it's only a matter of pasid. It's not quite clear
to me based on my limited AMD iommu knowledge yet. :)

+ * Associate a pasid (of a cdev device) with an address space within the
+ * bound iommufd. Undo by VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT or device fd
+ * close. This is only allowed on cdev fds.

[1] https://lore.kernel.org/kvm/20240412082121.33382-4-yi.l.liu@intel.com/

-- 
Regards,
Yi Liu
