Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0714B97E
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441939; cv=fail; b=g2R1ojyp+tdVuyaCcIYZB1+QD/gVNFDIO0Q8u2VMIhHM5NcHi5vA44nO4EiIbR8VFJ7JKRnXi4VCgGpubs19mFnDOv3ZLibdYojDxa0Fkz3/r8RB0qHO6UrcbYCcdfYRc0v9Zp7HBgCZOGsx4DRvYULPKpDriDWQz5hLPLFTj9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441939; c=relaxed/simple;
	bh=UpZTQDPToPW+QLsyg+JxB7dUVfv4uQ946CE0mFaDPVI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UPpyoMP6KPR3+LoN0ZL7qH+1FDnTsNgDYhO+6FwhQXzWe3Xy1UPb6LIQfe9I5Iekvnu5blSZiwQzK82k4EP8Ju8USDrhK98s0dGwjam/FZP0BiDpgO96xb4CmMM2qExDz+pWvaMNjAKLpeGJ2XkQxn9GEgYX8Bu5/kFGnVa5mRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxK9xQdB; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxK9xQdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730441937; x=1761977937;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UpZTQDPToPW+QLsyg+JxB7dUVfv4uQ946CE0mFaDPVI=;
  b=JxK9xQdBi3Y9NjsSsBBe15FdkK64aDxvHB46cqpCrPwuAdNnLh72iIp0
   GHkV9CAvq88cPc6dugfRBKG5W5+WqO9bwsXfMmwIAJrL5ZsFxzUZqkNV4
   133bEiXNJUjvs6gmOUjU/Hlea/LQ8KZbXLxv6ZkTTlNRTK2UHcQtFPqgc
   yP7mh+DAUVJnkqUJXKVW20sjm68z7FK1xAgpS/By6oTb1JmxGOVU7ZSQJ
   ilLfh7biVv4+Ahdx87HCXDrGl/1LwrGkbsA6vJBhxjNTf2Y5VDCap68Q8
   LezNjf8wWKw9jh4dWywTxW2om4uIP+ZvQ8VhcWfD92v+l/nKGyeM5wr6U
   Q==;
X-CSE-ConnectionGUID: BuKsv7A8QE+FY+Djqt6m3A==
X-CSE-MsgGUID: N+89kRrjR2qt+EA13Ez+0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="47685825"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="47685825"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 23:18:54 -0700
X-CSE-ConnectionGUID: 2eqVRcDlQkSswq3Mc1vuaQ==
X-CSE-MsgGUID: Glc2wPvHTlOFjf5pguh2Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="87999983"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 23:18:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 23:18:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 23:18:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 23:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2hpZFvew+7YowDQvx5LeX8MUCnc/OexJCN45KqGVGIxAtNGJwCJ1NjBp8L80pEXkF0a+8esBJxLh8ReG+lgWhHZsp9jaaJwS/el1KQHCrpgfatA5a6xuNoty8GAvntAJD7A785OP0veqQwHYzLeojtVEJ6QwYNRL0ZDw+05712D3Kv7T9Y9pZvw60wx/mncFZMD5LMPdYo6HL0+OalAZ72rlLkI39ia/Dg7CZMGM3w9RBpV8+zkMfYqszWgpu2U9YpjEUt3ZrIySsGEQUm30ry22kyGNyvm20XJDIHGFBIKrq09zycwepJj8xKbMVQfJ10GVQI4MpDVBgDkvedIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le6bmI3BkLOHk4EwMz3AmTncO13qEEUhoDn76XgxTEA=;
 b=tDdDejJnx4yYFaITGNBJ+iz/mDUMTMVnxW/Ajd+8SOGlepxcNTbAsGoX+cDNQdA8v14uiOZyijlHTsQiQKMdLmwZjFXqIRzRLRz8dfiabkd6L0tlMLEwtbhXGIvF8NAPcbx/VVC/ZUrin3oeVqEcw1uyQzxr4SMSo73A3ddE8HAinEVQ1U/Pnf/ZxMXE5RWuODxtgAzn2HshW3WGMAvRPdBs1ywhdt9QPWNtLZvZw0AZ62fBa9nvoDeqE6yfkWQx7iJfbKvEjcwzQ1LkxDj8W7fkT4HNlyTzuyOFsLK+zlsJ387raDJkxxBqFsgBxnmKr3Th/cSq0Rp7JOW1PDc9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW6PR11MB8365.namprd11.prod.outlook.com (2603:10b6:303:240::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 06:18:51 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 06:18:51 +0000
Message-ID: <7e562d1b-9b90-464d-a43b-ee7d13d39824@intel.com>
Date: Fri, 1 Nov 2024 14:23:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Drain PRQs when domain removed from
 RID
To: Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20241101045543.70086-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241101045543.70086-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW6PR11MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5ee998-bce5-4080-fe22-08dcfa3d0d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmRqK3B6VGQ4NWk4b2srUlZYb2YvcmMyKzZvVlkwNWxQQUZlM1FSUTVFQktQ?=
 =?utf-8?B?Q1RrblIrbVpyUG9jaHRIOW9ldno2MkFnMG9vSytsYmlZZElad3FCR0NqUzBS?=
 =?utf-8?B?VUNoVFRvd284Qm15WTlTLzVqd2lZNnk0LzlBTm5hV2RZU0J4QVhrYStSUUR3?=
 =?utf-8?B?bjUrenZEaXpuNjRadXMvbCt5K05sN2NaRnZhbXVmWWpJUnRxN0Q4eDB4a3FM?=
 =?utf-8?B?SzBWb1R2SW5IK0RuRS9jT3g4TThVT3RaRnRPd0d4UEpaNHlvck95R2NTclNO?=
 =?utf-8?B?VWVFUkx5TXBoT295bk0yL2F0L3oza21YcVdTeHB4TU9pRFJKR1pRZ1UrZHVv?=
 =?utf-8?B?YjVYTUNIZGkwVUlMN1ltOUlGYmlnNjZKVHF4RlBNeGJlT1pQQk1VTVgrZWVU?=
 =?utf-8?B?NW5OU0hmUWI1cUhXTGVlV05WcFZha000ZVdZTzN2bE1TTllFenN5ZEEwVDZ3?=
 =?utf-8?B?ZEduUHcyZWYyM2tlNnpxdTJyaDUyVzJPQ3hGbkQzM3E0UVM5T0RTaFBYMUsr?=
 =?utf-8?B?emp2S2d3VmZINks2NDhoME5KMzFvcFhickROUjdaOTZWWnhaVTJOV3gxV0FG?=
 =?utf-8?B?cmRGRlk0MTQycXlGZ3JUemhLN3ZKUWpBNGdDRk80UWZwbHZTY3FGODU3VVc1?=
 =?utf-8?B?eWpWVVVUdjNtbGpMQll6WEN2RDU4RDBVdXh5bEpkdDJMV1lrU3VqNm9RTVYw?=
 =?utf-8?B?ZGhDMEJOcGlYYldFd3I5clRHU2x1aDZKYlU2YkZmK3p2SlBrZlpMcDRVRFVq?=
 =?utf-8?B?TTRRSVMrakdOMlZDaDNhM2p2dHdVM3V0L1VUK0lLcVZtVkRDeTJCLytHd3Z4?=
 =?utf-8?B?YlVuQ1locmpuSGhNaVJpM1NzazlDWi9CNnZVSTl1YjBoSktpcXpJQjZTQXFZ?=
 =?utf-8?B?UW9SUDdhUlZFTFpTZkIxaEVUMUJta3BUblB2b1A0eFA2b0FxUVVaNm5yN0FP?=
 =?utf-8?B?SkZ2SUcyM0VKRnQybGY1MVkxQmVXdFVsRkhpVTRZNnFnbWd4NVVSVmdhbGJj?=
 =?utf-8?B?YlIwOTFTZlZRRVNQZVFsN0t6T2FlckpUbFVqTTI3Q2V0UkE2RXo4SFMzTHZv?=
 =?utf-8?B?ek5WSk9yY1BnMTdQTkZ1Vm9aTFN4VzBoYi9MUkZzMjFyN3EzUGhwRlFqb1pm?=
 =?utf-8?B?YzluNzNLSVJ3U3pYckNZdnVuakZobEVTZUdMUmh6aTRETXRKbXE2b0JSeC9n?=
 =?utf-8?B?U3hXMW9qb2pOcGpDTk1keEIwSFYwSlA1c2VLWFVlNytFeFUzR2JwYXJ3Z0Nx?=
 =?utf-8?B?bXRrZmE3QjJEMHZkbTI2bHJaK1EyL0d3a2lPSmljOFJIeVF5UUpONncxbDE4?=
 =?utf-8?B?aW5sbnhsaC81d2VvWUU5cVRWNlFOc2F5Q0VuSG9sWHUvbkhUY2dvd3V2eWJh?=
 =?utf-8?B?RWtRbVdxTGhyRVNxQlY5YjZyb2E0WEdiKzlMRTBKL1FUaEJtYkQ2UUlWOXpq?=
 =?utf-8?B?ZGVjNVZmMGdRRUN6V09vQlZHVjd6UHRNMTJobUsrUUdhS3hwTkhqRE1xWUxD?=
 =?utf-8?B?d1NoTmJKWTAzbzRCN21CMWNHNHhRc1o2eGU3Ny9YbnpGNzQ0d1dUcmFMUXEv?=
 =?utf-8?B?bjdxUUxBblhRbGlxL2VESzJHS2Q2S0xKZjV0R2xYM29ibkNhNWM1Z05yMWxS?=
 =?utf-8?B?ZlkrLzZLTHVIVjVpbG50R0lzL1dzZ09Ed0JLVXRyMmJLbjVJTjVzV3J0YW5U?=
 =?utf-8?B?UVJVZ2djblhVZ0RrbTY5R09FeVVNSWtzNndyYlVYbmVEeU1TYkpQTXdKYTR3?=
 =?utf-8?Q?lj2O8yRh6+Otzz7YA17i+zYpJkr6vcvno2D1E3P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXlWM2NDcVd2UGVkVnNXbUh3NjFnUG5iODNRYlZHdVJLNDhEYi9pS21IVTdl?=
 =?utf-8?B?eDg5ajl1cnlTRkUyQ3pNeExsSXdFdVE0c1RHNHFuVlJ6NW1xMmdoM1ZWemhQ?=
 =?utf-8?B?cDhOYVh0R0pZd2xVejVpdDhKRVArUGpNbkpsQnNycjZEbTdRNHRoNyttMzcz?=
 =?utf-8?B?SURzMk85OXlEVGRVS0JlR3dtd0ZuVS9YVFpzZGN4eWpZbVcrQnh1dUhNVElJ?=
 =?utf-8?B?NzdKQWJFTVZuV3VsdUYzUE9NcUN0VkUzMEtBSWpGTCtJWm1PNENFQkJQRUoz?=
 =?utf-8?B?aEg5ejJjRWtrOFd4R1NPc05iMTF3bjNqc2c4REpZV0NxdkFUNkM1TnZTci9Y?=
 =?utf-8?B?S1cxbEppRnlhN2dLaHJla3BnL3J2eDc0d2dlZGdNd2ZOa25UM3NyV1BMdzIr?=
 =?utf-8?B?N0tsMmxPdGhtOFpWYlNROHpKN3JZZS9CbWdCeFlKQWdTS3A4SStkdXEwc2kz?=
 =?utf-8?B?NFJEcUJ4a1dkNmUwd2pyMEdtbkU2aHU3cG95ZFNEM2c4OStLUmlDdTh2MWda?=
 =?utf-8?B?TTFpWGp5RnZCK3JjTUtBZjFYcksrZ1dZUmdRQzBhWjJCM05FbXZQMGNZSUNC?=
 =?utf-8?B?UnAxRC8vTm9vTlhlNGIvZkpGK09aT2F6cjFxcFBuenhCOHFjUjRKWUlvamxn?=
 =?utf-8?B?emhOdEkzdXZ6OEROVnRyUGo0L0FRek5hTFZmNGJJV2gxWEp3cSszNys3eFpy?=
 =?utf-8?B?YVRlLzg0SHRydnVYVGVrKy8vdW4ybTl3WjlsUW5LSzNnNW45ZUFjWUJYbThQ?=
 =?utf-8?B?T01pSERnS0E1Q0w3eWp5SGFod2FNZE5vb2xvNDdiZmpJRldPZmd5bGJZOWw3?=
 =?utf-8?B?WStqVWlRTzJMeTlWenJILzlWWHRvVVVGOXRldlBnRjFjbVFRQVlQZ3VKWisw?=
 =?utf-8?B?TUZHek1nR1J4YzlpVi82R29UdlA0YzRIbU5NclJYR1YvVVJWblpaTXM3SlQ0?=
 =?utf-8?B?OFpmSHlSbWVpeUw2dW8vcmU4a2JzUTJCQ3VvZmNuUXM4Y3NSMnJ0aWsvZkMy?=
 =?utf-8?B?WnN3cVJtTS92VHB6OHN0cG5OSEJRWnhOaWpwenBmRWtjeWZobjBhbFZPYmls?=
 =?utf-8?B?ZmxLcFRmM0NTUDFsazhOTndQcmZQK0Q1bHNTMkpUeDE1S2pYM3dWZFRTMVM4?=
 =?utf-8?B?bDZmd1h5eVVQcFZuUjBQcEZPQkVhc2QwRkUzS01USEtXOWE3RjM4NU9RYmZQ?=
 =?utf-8?B?RHg1QTMxR1Nvc3J1ZjdYNkxPU2ppVkhJNjdoY0pVRVorcXl0alBaZWw3VDlL?=
 =?utf-8?B?djR4Q0Y2cU01RFRTVENqOVpZOTZEaTRZdlJHQTBOdlNyekg2bU5mcU1YVHRj?=
 =?utf-8?B?b3lhVjFQbG1xZGJnTUYyY0UyTGhuQlNVOU4zVzJvUGZTaWNYdjdxN1ZBZjFL?=
 =?utf-8?B?RTNTNnpaeDZqalI2S3BnK0hROHBtQUxRUzdnMmR0NVQ3ZHdGMk10RGFaTnFi?=
 =?utf-8?B?R2N6Vy8zdEw2Wk1jUFNaV0ZCSlZHbkVhL2N0bmtTMzhVeFFXQXc0eEFQQ3lX?=
 =?utf-8?B?Rlp6bzVvM3dUYVJ0ejJvZnl4MXl4UDRuODZEcmFvNWE0a0hmRWlRcHRHam1o?=
 =?utf-8?B?b25aT1FjWFhKSkZBZmh4eklQb25mc1EvaHNuZnhialF1blBZMW1HdzFtUXF1?=
 =?utf-8?B?MTdQZXdreFIyZE8wVjN6SGxiTEhOby9kWEFtZHBVWlZZb08wUU9QSWtsR211?=
 =?utf-8?B?dmR5RFFqWW52RzdyaysyUk9YbUJHa1lyVDg0QjVrU0ZJb3JETmNxd0wxd0xi?=
 =?utf-8?B?V1pHN2hpYkQrQjQ2RkNtR2dFcitMSHlXMW05Vkc1aUxnTHQ5Sm1YQ1lHczc2?=
 =?utf-8?B?Wk1NQTYzUUVqUGMwSjhmMUZyblgvTEt3WGttTUZkaGp1UHJWTE81azBoanUx?=
 =?utf-8?B?OEVJRW9qM0xSZ2RjZE5DejFEL0VyVERSTm9CSU1HblArSFRkMWlYTGRuNG5N?=
 =?utf-8?B?VUQya3hCTkZUaVlGMXppaWlYWjg0eWIvQysrU05CTHlvY3lOVlJPR1p1WWtZ?=
 =?utf-8?B?ZFhIYjh0clhCN1lCQmdpdzdSSjczK1NFNHgvYVR6eUhJY0dFL2R6ejZWMVdX?=
 =?utf-8?B?SHIrREN4MHJnMU40N2gvdzdvNStZUnhnQVRsKzhpVXU1b3IvNTlwei9WWGQr?=
 =?utf-8?Q?FqDGGoeVz1rO7qzAuM+3kKJvj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5ee998-bce5-4080-fe22-08dcfa3d0d95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:18:51.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLuZMcOqAJawnygZOyJyXfzc3H3KXBKGp0uIO5fbBp/u+lx2WJFpx5gjgfqknXks/HeobJVzfrkXzPhPMtonsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8365
X-OriginatorOrg: intel.com

On 2024/11/1 12:55, Lu Baolu wrote:
> As this iommu driver now supports page faults for requests without
> PASID, page requests should be drained when a domain is removed from
> the RID2PASID entry.
> 
> This results in the intel_iommu_drain_pasid_prq() call being moved to
> intel_pasid_tear_down_entry(). This indicates that when a translation
> is removed from any PASID entry and the PRI has been enabled on the
> device, page requests are drained in the domain detachment path.
> 
> The intel_iommu_drain_pasid_prq() helper has been modified to support
> sending device TLB invalidation requests for both PASID and non-PASID
> cases.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c |  1 -
>   drivers/iommu/intel/pasid.c |  1 +
>   drivers/iommu/intel/prq.c   | 26 +++++++++-----------------
>   3 files changed, 10 insertions(+), 18 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

-- 
Regards,
Yi Liu
