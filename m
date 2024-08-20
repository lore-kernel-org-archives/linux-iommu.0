Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2418E35C
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143900; cv=fail; b=NKNvo7YBLu4EOpb5BaWfc4Anld4GmWZs4Fs7/W/Fe2zp2kh0pqUjrSRURtbufGfXMW3z5El2PUxTxuTjcSvFwJZVNPgdro8W7z+ivlPxxQSPE3IxqWr47T9ArUxuJgZTLOu9aOB/4imSOaJMvfuQLeh/jjsMOR6Y0MVDx1IaVa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143900; c=relaxed/simple;
	bh=TdNao4qQuwBVb9k6jd7xmkIkw8NPafqnJDTn/G8/kGA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k6X7DV6/XGJ/fQfbYKprS/GtTdbcLZwvwi2SR3LojY5AFo+BS+GesWO84YZsi+kM+SQPmrtQixympMMhfKEvYsvpWty68y8zQNHhiDq7eZ5apWu50LbZhz7dMl4MziSnI1T3IFR4Bs+EH1oxYw4sjyz1oEY065kefYeK9/8Q07I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKqCZKa3; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKqCZKa3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724143898; x=1755679898;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TdNao4qQuwBVb9k6jd7xmkIkw8NPafqnJDTn/G8/kGA=;
  b=NKqCZKa3SQS4ytEkpHZwACxoSnT37AfuRPmll/2zvsDk6CcZgm6Zi2J2
   /PGyx8+YA0ruTygcGpdiTA/W1PEU9W17kaUFx5X4AIBVmV+kuKc0QpPh6
   F5tABo6O6GQwQ+RD84vhCXSsljqtYFIvDhohNaygro7qPLtTBAMPOlE6i
   72nUDzohMf37zKqfQJomt8Rb+AKJmONXItDeAqWQcYicYfbjweazXQJF0
   U4jEwzd8YNIVNBI8u1Urp84cGl7nEM3gC5WtTq/pA4fHhReVd1H+jbQPZ
   UJiFLpCJnKhkHVOxZ6eE9O61q7Vjy4LFfPydbeTv7SLGx2S7KaLRMafrq
   g==;
X-CSE-ConnectionGUID: 47WG8ZeERsacd9OmhZ5Xgg==
X-CSE-MsgGUID: XwOLOeH8QFKxnj+C8pwweQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22051628"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22051628"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 01:51:15 -0700
X-CSE-ConnectionGUID: gSPZewdNTDOMemZpbuuW3w==
X-CSE-MsgGUID: RGGGeHG/QF+4+d6oQoUqTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="83865332"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 01:51:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 01:51:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 01:51:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 01:51:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 01:51:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0OrIRSb+v9x49uvRwyJx5r5+e1saK4ocKE2ilVhBQidBBAxiGc7fc8MOPxiTPGCB6qlUgHryV/2Z+vzlHvBlCg0B3S9SPqsett2C4Tp21U5XsqysEnrZhTyKSnNTtEGGptCeZ3L1IcX7NjPOQ6/mlQzsg+onQbEp1a8rxF3jEitQAl8EJr1zzgFuvFy+faKp+0ekP7K3w/9s4DcfXBeLrgHBKRkPovXpyDccIZE4/8+sOMBYTrf5Id34NBTgS3rIm6pQG3z1kul3/ZteZr73lnsr6hxPQJt8zBtum+qWDtwKJS6Pk7Fc7WOQfR6uQnmSuxOMeLhcNmgWNmF78XP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pA8JS9uz/qofOOlKcrd/HU5HNskA8YnE+lUtRzjSs0=;
 b=CQ/TyUs7zLbuLkggkNZj9kszTKlmU0Jp0n3hWFwamdYBxk6lQ+HAv5fRVNLePVfNWlK6yiFZlUsJYvFD2mTpGLo8VXl1oLOY/3BJcXwBboNZVoasBrsJWd1HMMEOAUDYO9/OjD2sqft1GFl6GCRDsSuxA7ERhN1oTLwk7sxnjGk+mH6q0ZZp3iM7/spvrXLGlj/Twfu0AsiO/1QfbCnrp86qkMFUMSuUkqMymycVh+sLLL0oVby/o85KV/Mo/1rzs5AJdGRTpYDEoO7o3CgVYdpR/+E09DMKXqI2vGYEKdJH0OpRmbB3o44gQOuyytMVPtjv0BjmwbPDWJAXJ96ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB7555.namprd11.prod.outlook.com (2603:10b6:806:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Tue, 20 Aug
 2024 08:51:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 08:51:11 +0000
Message-ID: <95473081-db0b-4802-b875-24605ab2ef37@intel.com>
Date: Tue, 20 Aug 2024 16:55:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Vasant Hegde <vasant.hegde@amd.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
 <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
 <20240819123400.GU3468552@ziepe.ca>
 <4d9c1513-8062-4594-a06a-c9f179abdaab@linux.intel.com>
 <72e59734-431e-4eb4-b27c-44eefab3dcb0@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <72e59734-431e-4eb4-b27c-44eefab3dcb0@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 2083698c-10dc-4e33-3bc4-08dcc0f53d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWlFeFUwM0RWR3VFQ0pCVmpwUXYwaWNTZzJDbjlRZndxSlo5REtJaTRUb3Nh?=
 =?utf-8?B?WDdZcGxxMlpoZ2M1NWJNMVpCUlBVRTZRL2pnUnJhUjZvM2gzV2l0SWxtWmZJ?=
 =?utf-8?B?UVJUem1aa2t6UVo2L1RubXNvalpDcFF3U3lYblVVOXRFVW9oZExrTk1ERGRJ?=
 =?utf-8?B?SHhaVlVVblBWemNxcU5tR0NhVUJad3dEV1JsVk9HRXVlRGFLTFpETE15ZWM1?=
 =?utf-8?B?TWpUa1lxeHlrMm1kRjFQUlJDL2UrS3ltSjg0SEFicG40blpsWjJkY09lOUVh?=
 =?utf-8?B?eTdIMGRDNXNSSkRoelhwL2s3YWg4dzNDSHp0WVkzRk9qRUtSellyTjZ4WU52?=
 =?utf-8?B?cFJWOE1Ic3hVM29tV0RpR0w4U3dhRWNRQnJTeHVFQTM3Z096QmdsVTVzdGQz?=
 =?utf-8?B?RzFSRjc2UityVHh6ZmYycTRpNitHUmFuSXNHYWRmcnhieDd4dVZSRTAwZUo3?=
 =?utf-8?B?V3VQNHM2L2ZNbkk0NzQrYTFETXlBV1VVQVZYcjQxNnlZL2xIcVdpM2VsZ2s1?=
 =?utf-8?B?SE40bzBUR0tjamxKa0w4OG5GeDczWEFJU1VUN2Q1TXlobEtZKzJZWVpEYjMr?=
 =?utf-8?B?SjRLbHJVNm9rc0twV2ZZbkM2Q0kvR0l2RUNmaUM3aE9sUytrMUthSSsrVmpR?=
 =?utf-8?B?SzBWS1hYZEEyYlZPOXdsdy9iajlEQ0tTUTkvM3QrN2EycG5ENlQwNWF0NzBR?=
 =?utf-8?B?NWlrZUdCdy9zYndmWnBRRGpmOU5uQzU2OHMvY1dVK0VUK3FjaDZkLzV0QWtl?=
 =?utf-8?B?dHZBdEY0ZllXb1VYckVtRXlQZjFxNlBpTm9NaDBxYlRzQ05KTzE1NUV4MWZB?=
 =?utf-8?B?WVpiVmx6NDFTOXVEcEdxaWVjOUVubUlQaVYveWp5NTFnUmZRbXpJYmdVUlYw?=
 =?utf-8?B?d2ZUTjl1SWpiUWVNbE43NVhVK1hMSnhuSEYzc3YwNzA2ZU05elRlenprbHRs?=
 =?utf-8?B?VWkxekJrTTJySGN2b0tUSkczOEk5Mzh1V3ljN1B2MHF6TFhMVVUxL09WT1BD?=
 =?utf-8?B?NmpMVXU1Zm5HR2pOd05ubEVyZlQwUmxKeElvd0lXL0lOTHJDSERpS2VLTVN6?=
 =?utf-8?B?T2dwS3lmWDFpakIwb3Z3cExwRzFBMzRzVEdudHFYaDVtM21aL1RPWW9aTW5n?=
 =?utf-8?B?dC85ZW9LeFpWOHRoZTlmODFyMFc4Ry9kSk9BT1QrTjYyOUFSOW1DSEFuRkJZ?=
 =?utf-8?B?OGg1WENsSWpENW5jOVpueUs2MnFIVDcrNEJPVFRFSExSdEVwb3pVSmxZdEJX?=
 =?utf-8?B?UktEZXpGWHYyNDR2VDhyZ01PdVhDVHdIamJjcnBKWitRQ1FLVGZwblZvZGFV?=
 =?utf-8?B?cFVuNmZoOVhOY1MvUkN5MW05RnUycDdiaGE0T1MxM1pFajQvRXhyOHpoMFhi?=
 =?utf-8?B?L2ZNcmFFeGM0QWNHcjV6K3hSTjZtZmQ2NnhOSkZRVXVGR1N5UnVEVmVUTHZW?=
 =?utf-8?B?NVdGNVdMYXJPL2FoSHpCNTN1aVZSWGlGWTZTUWNXYzlsQll1djVIOXZJUTNv?=
 =?utf-8?B?M28xL1RSRkRaQUNEdm1OVXZHaGF3NkhCUWlrd1JDeWZDS2NzUjFxTmVLWFRZ?=
 =?utf-8?B?djRmRFl0MHpISEtiSjRWS2JLaFZXMkdPa0xqaWw0OWdBVHZQVVBSNVhPYmt6?=
 =?utf-8?B?d3RSaHAxMFk3V2JHYjF5UTJXZWErWGFFcC9SNXl5cTBvYTUxKzNnajNobUVk?=
 =?utf-8?B?TjZzTVZHMkZRL01KUVRNbm15WnJ2czBHTklOUjFMaGVKWGpUdDFzMk1NeVlN?=
 =?utf-8?B?S1hUeGxYQlhlSFZhaUV0S0QvWXNnWW53RUtkdFhzTVU4eWY0SVFBeHI3dDVk?=
 =?utf-8?B?SDJ0NWV0ZTcvUHZ0Vlozdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azduOEdTLzhqN1YvRCswWVpwS1pWWk5TQlBRWEVMMEMyVEJJdDAvbDlKVUk2?=
 =?utf-8?B?bXN3RFZZY3NYSHNyVGlhZXBlRnhoejJYNXd4V2hQQVM2a1ZhT3BUQklpTkZJ?=
 =?utf-8?B?akRIVWUvOFBiSDVxU01Wam9CRGdDWWJOSWhzRy9ZYnBpSGp5WDBhTU9VNnJz?=
 =?utf-8?B?eGhKaXpKVmZsSURFbkZnMVJoTmhtWndyZkhmdWpjbDhoUVZaMFhhM1A4cWVL?=
 =?utf-8?B?TEE2OCtvbU1oOGk1RXdjN0pPREM3V090MUM1OTJ3dXlJdkVJc05Xam1kSjJo?=
 =?utf-8?B?cjV4ME1CK0dzc0JnY3R6enBwS2NQSlAyODVwTmdrcGN4ZWl1V0VnSXdoaFFG?=
 =?utf-8?B?UUJGUnFNL3RXSFJibXY4cWljRWFGWUo0K3lyVGF6U2JteG5MbHZsYmVXQ0dY?=
 =?utf-8?B?UWtEUlgzdS90WUd6OGJob3BFSmJBTk4xQWNGOUVrVHlaSVV1R0tvb28vVVVq?=
 =?utf-8?B?U3J2c2lqOXdSbndIR2pBUFlMbGVJNUM3U1RRcDFOUStXZWkwMm85VjdCN016?=
 =?utf-8?B?L2IwcU5rK1E3aVhEZ295blVJdFJMeFZkS3hLWHlTeTkyTlN6QUJkR1pMMkRC?=
 =?utf-8?B?bVhsbDBTYzR0MlVpaU9TR21KWWExRFBFdG83cUJ3R3pNWnJ5Rm9Xa3k1UDJW?=
 =?utf-8?B?WnZaM21YRHVHS1k4WGprYUlRY2ltZjNuVWFGMmN5anpodFBHZzRQOXIyNGVH?=
 =?utf-8?B?dHVpVUdJMytkd3hnbmoya2hFQmpCbzdRNy9lS2pNYjUrZUVoR1V3WXlBU2o5?=
 =?utf-8?B?UkhUU2JCY2xPNWlHYjg2QXZNNWpzaVBUM0EvTlVCTzhRVUZFcGY0OHJhQk9G?=
 =?utf-8?B?MkJRdlNWWGxROTBYbkxtUU5RZmRWWVpIem5zWGFISFl6eG9wSFVMQzlnbjE1?=
 =?utf-8?B?SysxVVZQeGQxVGxPa3J6U2NPdWxpcmdnand5dFVkR0lwY3VnWjNPbXVCWlNH?=
 =?utf-8?B?eFczT0ZacUlXUDd5cnowd0VKWjhFbXNTcG9lWDdpdksrVFdFS1ZpZ1MvMlJH?=
 =?utf-8?B?S0lBWk9xdnQwT2pYSnJHdDNFUUk2dmZEUTM4Syt1Z3pkK0t1NzBmYzg2MXpK?=
 =?utf-8?B?S2tIc3pncUVUMEtqanpYalJiN0Y2RzlGT2k5c2hFZ0FWdmJSUnY3Q3ZmazN1?=
 =?utf-8?B?ZjJSNy8vUXBnaHF0Mlpxd0U3M0lmRUdZaXBXYUxPeTlNbU1oUmgvYUlCL1pu?=
 =?utf-8?B?MEJYMUdtdUJ3OHJHeWJNRGs3MlZCMmo0TDZteER2ZWRER3FWOTBhU09BS1NJ?=
 =?utf-8?B?b09COGxQRzFUTGlQVXJJeUhzamhndTJvWE9VS3dBMm55aHRJNGhhdzdoZlRq?=
 =?utf-8?B?TjNlc1hHeVFKcjVGYUpBYVVzclF4STQ1ek9NaExVc3NxU0p6Y09PWjU2NjVp?=
 =?utf-8?B?UWsrb0h3eHBsWmt4c2p3ZWJiNzErUzRBaHNwYnJGV2pBZ3pKODYwaFIzQWVj?=
 =?utf-8?B?OE1hdEwzalVRZTROditRUzE3SUN0eVBZTEJmMm81RkJPWm9zV0RhZ0ZCeDRQ?=
 =?utf-8?B?cEFvbDZxa3VUM29LNlpTNDlHMDB2bm9rUHg2VGhSZ1J2eUNwbEhzK2xRRzQy?=
 =?utf-8?B?Nnl5Wlpxa1MwSmxnTElLSDVNL1dIWm5mVUVOV3VsK01teCtDZGlGMkdSaUJO?=
 =?utf-8?B?NnpWNHJ0RkJYY0pWYk5YOWFqMzZvNGhLKzRFT3d4WEFNNHJNTG5Qa3dnd0xq?=
 =?utf-8?B?R1ZiWWRLSzkzRWpjWnhvcEZYLzJWMkxlYW1URHE1UkZJZXFtYWpKcjdhSnEy?=
 =?utf-8?B?SEtqNGNwTmMrMnFZQ1pacmF6aWZaRDZZSzdnUVBDVzRxLzBURW4wTjliS3BY?=
 =?utf-8?B?Q0Jvcmp1YWlBTmEwT0lBeHBxUEpzT1hGT0ZhR0laY2twRGpHaDVaTzNjSDJQ?=
 =?utf-8?B?K2ppS0hjVjBPckU5R3JobmRSMWYrbVVmazM4dHBTejF6U2R0S0FrQTRIdVNx?=
 =?utf-8?B?bXpKRjZpeEZVT3dPOVUrZnQzWEhGcExWeWhmaGxxSkZsYmUxc3duYy8zUHI1?=
 =?utf-8?B?NDdMdlFMVEZtMjRtSHM0RGlvRU9XRDhEbkxZa0lGWGxiNmx5RWJrVC9JT1N1?=
 =?utf-8?B?VXZ3N3VJRlJxQ2RXb2t2M0NMUG4rNnJtRk5XMG05K0UzNHdRQzhrSzFlZldw?=
 =?utf-8?Q?+rjWbzEm9xE/4kPRzUyZnSO/E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2083698c-10dc-4e33-3bc4-08dcc0f53d3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 08:51:11.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZgwzqgqUluEfTAJJo7kgAJirvmx1n6AYZDkfknXmgvqIIZjcpWCTR2gqg/AhCp4tfpiTHPy7XvKrTDQQLTFMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7555
X-OriginatorOrg: intel.com

On 2024/8/20 16:30, Vasant Hegde wrote:
> Hi All,
> 
> 
> 
> On 8/20/2024 9:40 AM, Baolu Lu wrote:
>> On 2024/8/19 20:34, Jason Gunthorpe wrote:
>>> On Mon, Aug 19, 2024 at 03:09:00PM +0800, Baolu Lu wrote:
>>>> On 2024/8/19 14:34, Vasant Hegde wrote:
>>>>> On 8/16/2024 6:39 PM, Baolu Lu wrote:
>>>>>> On 2024/8/16 20:16, Vasant Hegde wrote:
>>>>>>> On 8/16/2024 4:19 PM, Lu Baolu wrote:
>>>>>>>> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
>>>>>>>> attached to the device and disabled when the device transitions to block
>>>>>>>> translation mode. This approach is inappropriate as PCI PASID is a device
>>>>>>>> feature independent of the type of the attached domain.
>>>>>>> Reading through other thread, I thought we want to enable both PASID and
>>>>>>> PRI in
>>>>>>> device probe path. Did I miss something?
>>>>>> PRI is different. PRI should be enabled when the first iopf-capable
>>>>>> domain is attached to device or its PASID, and disabled when the last
>>>>>> such domain is detached.
>>>>> Right. That's what AMD driver also does (We enable it when we attach IOPF
>>>>> capable domain). But looking into pci_enable_pri() :
>>>>>
>>>>>
>>>>> 202         /*
>>>>> 203          * VFs must not implement the PRI Capability.  If their PF
>>>>> 204          * implements PRI, it is shared by the VFs, so if the PF PRI is
>>>>> 205          * enabled, it is also enabled for the VF.
>>>>> 206          */
>>>>> 207         if (pdev->is_virtfn) {
>>>>> 208                 if (pci_physfn(pdev)->pri_enabled)
>>>>> 209                         return 0;
>>>>> 210                 return -EINVAL;
>>>>> 211         }
>>>>> 212
>>>>>
>>>>>
>>>>> If we try to enable PRI for VF without first enabling it in PF it will fail
>>>>> right?
>>>>>
>>>>> Now if PF is attached to non-IOPF capable domain (like in AMD case attaching to
>>>>> domain with V1 page table) and we try to attach VF to IOPF capable domain  (say
>>>>> AMD v2 page table -OR- nested domain) it will fail right?
>>>> Yeah! So, the iommu driver should basically control the PRI switch on
>>>> the PF whenever someone wants to use it on a VF.
>>> PRI enable sounds like PASID enable to me.
>>>
>>> The ATS control is per VF/PF, and PRI does nothing unless ATS returns
>>> a non-present indication.
>>>
>>> Like PASID, it seems the purpose of PRI caps is to negotiate if the
>>> CPU can process PRI TLPs globally.
>>>
>>> So, I'd guess that just like PASID we should turn it on at PF probe
>>> time if the IOMMU can globall handle PRI.
>>>
>>> Enabling ATS will cause PRI TLPs to be sent.
>>>
>>> Probably more of this code should be lifted out of the iommu drivers..
>>
>> Some architectures, including VT-d non-scalable mode, doesn't support
>> ATS translation and translated requests when it is working in the
>> IDENTITY domain mode. In that case, probably PCI ATS still need to be
>> disabled when such domain is attached and re-enabled when the domain is
>> detached.
> 
> Does it make sense to move both PASID/PRI enablement to probe() path? something
> like below :
> 
> [I am assuming ops->dev_enable_feat() interface is going away]
> 
>    - Enable device side PASID/PRI during ops->probe_device()
>    - In device attach path (ops->attach_dev()), depending on IOMMU, device and
> domain capability configure the features like PASID, IOPF and ATS. That means
> ATS enablement is still done at attach device path.

Are we sure that it is ok to enable PRI before enabling ATS?

-- 
Regards,
Yi Liu
