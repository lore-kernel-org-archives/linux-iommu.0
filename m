Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DA2773C
	for <iommu@lists.linux.dev>; Tue, 16 Jul 2024 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115586; cv=fail; b=NZcgMM5gsDmPYIz3GbPtiEaVqSgPkyGxoRrf2mD58EZyzLrvb8SCI8iXZ5tPRr6zbVhvCNYEU/B3VtE9+ueoTH5Yd69yhebZJ+a00jsqAzdkZiMqjJ05BHsAlvdEWyKUAP2ixwETgH+5hdQGeEbSDu+HUG9Spe38kXTdy9cScxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115586; c=relaxed/simple;
	bh=ypTWRRRtQ4XvIMgGq6QlxqUVXjw2NpMRBfUZMC28CLI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I4oWil5Gii49ta6DFOBbiAj3Hi90+FqVAX1vZCPERXS0PgkRycekcqF4gZN8CQwcXvSw60KBvWwT5FITUbzMQlGspz9PRiSZVuuOj2o/6miFVFiuvMWa3Z2NurQ/K7Zs6VDEw1fwHPDRHcdcoRn4dKIxGmJ3QdtPlFKEf2hneHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SV36QmGS; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SV36QmGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721115584; x=1752651584;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ypTWRRRtQ4XvIMgGq6QlxqUVXjw2NpMRBfUZMC28CLI=;
  b=SV36QmGSJ7XtyfWD294cV4h8JsuM/OSvtXoM2d0PKM4rwDDx9+iRRyb2
   UQ2L1z12ggz+KJKJvpyJhY7EpJidvfBnU9BBvRRRIaxvFojJdwDamgRmp
   ewiw/YlHzOwvU16t4lriGZbpe2H5WLBgFeEHrrFnaSyeNrZfxH9NsI+NX
   E70KWUNVjk00AaQ/cTbRG5g7CUwZvouXxIMwFWRTdkIpbyS31dKXBr0a8
   O4B1VBXrEMmqfCSgjI71JEANzN9Ef0Dm98rVdBMeaAC+kdcTxnZVXNc+0
   TYsTHcOhhsUEkRepvLDZRkXUaQZbNMqSeIFwPptqC0hitStSvsSMcP29E
   g==;
X-CSE-ConnectionGUID: l77jpPPJQXSSBUfRlsEMFA==
X-CSE-MsgGUID: oMlRolVhT22gKvS2/AHrXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29140087"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29140087"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 00:39:43 -0700
X-CSE-ConnectionGUID: hovq8nRHSMWVsl5tNCibJw==
X-CSE-MsgGUID: /5ICkktbQN2T/8lDjeLwjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49850351"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 00:39:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 00:39:42 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 00:39:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 00:39:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 00:39:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNZ3j9BviwLPlHU2owDlZv+kfXnzx0oINxVf+znN+gx59H8vD5rkreBnTtDvKthJBTzNgKRTE0ba8ocvDvznjKdoUrqv4UDRMf6Ftv2G6uAiK07ni3ACD961kudTSekuv4Rh4Gl9bo/rlwD5PGxnafhBX9wP6QC6wagLAlx8xwLKjhxBqZM6k/aOhgfTuFs8HsvNvMqEHrEbYb11lTV077MiRrd0qW+OzhwLxdVzsRUVqXd31r59bYYvpKISWeA2ZWhA8EOYrGAIInX+2N9LYGbPFZiFsu1kQho5muPpGWDap/J7ICVcHQK6PPo8PoouX0UnftVKaZeWVrKN5plZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19mFHiRiBk6FBX0wfdTzn7jfQLntRDYzqzSk4MQlF5o=;
 b=tzkOPNJEoJ09qZziGOTCWV1R6jQUfA7oZW93FmBsOTpmrmuerYgtB5JMrZW4mavGr9YUKSuMlVQ2AEZFMoCa+sCqvWcbIrw38JUgo0qY2b6BLTmUjDiRhQ4kaJ+j1dCZqcbfVog6F5QO1ggn8JeLZJ5ts+t78nOGBSwxGVqyLs8s/tT9gzB77q3WzfNd+objKNQ7Y/55EEzFEEojdx3Rc68Fqb3/SkE3vlYqDsMxfMBv6d3GnUYetNe3eB5YO0Gh2bPOAvTK/Iefw+AOCqPzHu4jdnLZrbrPtHXNbsHQz1ibVSeMBxjo4UX1+D3TutCKvoYwLUvmLz5q59dXzS+1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB8090.namprd11.prod.outlook.com (2603:10b6:8:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 07:39:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 07:39:40 +0000
Message-ID: <85821ad4-5fe8-44d7-ae8b-4bf13e960c81@intel.com>
Date: Tue, 16 Jul 2024 15:43:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com> <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <4ffc953f-4968-46c7-b6a0-b7b2fc454564@amd.com>
 <71880aa8-adb9-4f3f-ba9a-7862e8d30b46@intel.com>
 <97538ddf-57e4-481c-9429-ab5a4b88710d@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <97538ddf-57e4-481c-9429-ab5a4b88710d@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1afadd-29fe-4630-1797-08dca56a7319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDlZOGoyNEduWFdrWVdJaHFPOEYyWDlZcFArWFJ4eS9iUThPamlaVGVwUFVu?=
 =?utf-8?B?VXJSQjBpREhsc05nS3ZQcU95bFQ1azN0TTgyMkRXalR5akEvd21xOGZZajdC?=
 =?utf-8?B?YWZ6OXYzUmVFSHNKNUxCY1pRNHFnNGY4eDAzSHhCMldtTDZ0MlhHTXRvMElO?=
 =?utf-8?B?VVU5SHptWklweW5BN1FwQlphL1ppMW9pK1JKWDZ4SUgyTEJyQUs0VmJkUlF3?=
 =?utf-8?B?dmpZZzRQVzNmaThMZnBDOUtybGtIcUYyV25tamxPQWtSdGxNaVpHWElZVE4w?=
 =?utf-8?B?emFXRXNRRW8xZ1Q4bkJUWjU4UVF2Yk9SQ2dBMG9qR3NBSmRnSnpHUm9VR3p3?=
 =?utf-8?B?N2FCMUFGN2QvcVZzSVBJTSt3Tng3TjdFaUtvMmUvWlRHVUdOSEVNZ21KNGlN?=
 =?utf-8?B?cTFEVGFEcEhHZC9nbElpdEdhWkFleEZzZXZsclBqbWRFTFBSNmdRQlUwK081?=
 =?utf-8?B?ZlBjNmoxenljZGVRNlBwWk51L05zaDNTTlk3UTRDOHlJbk5KcDN0dXlQeDJw?=
 =?utf-8?B?b3NSMVRzOHFBUUsxdWlYSTVJc05KeWNFcWRnSmQyaHFJQXlIcG5SU2VJRW5R?=
 =?utf-8?B?c3ZrRGkvLzJaaWZjdm16V1hvYlQwTFl4SU5GZmxwTEx6Q1liVnRVeWR0dWhh?=
 =?utf-8?B?ZTRGM1EvT1BGVGZsSEZJcUVpT2pMeE9iamFxSXhnN2FuWjdMWk9LL1pPR1h6?=
 =?utf-8?B?anhqTng3WjYrellqQjJ1RUlrSlZDU25Cb3k1K214MDl5OGxNcndjN1pVKy83?=
 =?utf-8?B?RS9NUVNRSGZuSXVEVTNKcGJrS1FDSjJrdjNEWXRJVEx4emRrUGZxa0JEVVdu?=
 =?utf-8?B?YnFOTzZ0dG42VVB3bTBpVVlMT0ptdVhmUTJEbW5tNlZrQjhOTVlLK1hlOHly?=
 =?utf-8?B?MFc2ckV0elpURTI1d1BZWVFnZCt4ak9RT1Y5NjA4dm9LM1MvNy9QN0UzbTU0?=
 =?utf-8?B?bklydjdDaE9LdUh2UExkNFpWZzN5cjVkNC9GZ25tQWVJbzFYOUV3MUhXb2hZ?=
 =?utf-8?B?MDJBZXZwSFpxeXV3TytuYWF6a3ZidGZLdU1IVHRCb3k4QWRKNmFyRjVNVlJI?=
 =?utf-8?B?SVpqR09vcWY2T1Y4bW1kTGFoWExRVysrUGJEbk5HaklzejAzMXFlZVVuR2dl?=
 =?utf-8?B?SXBXRnJXZFBnbGpLRXhSa20zQ2hUK1pUNk9LejMvNEJYc1Rvc1N0djFpTjVP?=
 =?utf-8?B?MlIxSHNhVUdHeEx0NUpjamVQQkJvN2taSVlNYitpbjdZNkduS0xWd0F1c20z?=
 =?utf-8?B?TWl5eUUzU3l3RnJGM0ZyTGJ2YmwrT1hiaW0wdDRpQjF1TitFQVpsam1pU2w4?=
 =?utf-8?B?UE9wMno4MjljcWcxb3FNQVFsb0RqU3hPbWUxd0tabnMveG1XclUwV3c1eDZI?=
 =?utf-8?B?d2FtRFpLSSt0WGx4OGdTU3grUjNyNG1nUk9kRnhSTDlVZUxWWWJFMkg2Yzlr?=
 =?utf-8?B?bTVNazJZcUd4bG1HSVNpR2ZWQ3hhUE5tUDdaUGwyVEFiMVpha3ZRa0Rscy9a?=
 =?utf-8?B?d2xlbVF4SWRrMzRuekFwUEZrMXduSUtoKzBmaUh1aWo2MTZieVJ4N24vYnAx?=
 =?utf-8?B?ZnBGY0pUYS9RS0RDSlQ3anpPa2V2N2lMRE1XTHQwajBGcGNiOE15cEVsd2Vw?=
 =?utf-8?B?bHJqQVoyTFNmSzZGaHFPK3hUeGZYazhQaVg1TFJOZm5wYnVWNHAwMkQ0N0Ft?=
 =?utf-8?B?NGs2R0dRc3hKdk5zbnNXamVPS28xZG1BMlQ4OGVHOEcxQ0pmV1pwVE1PMlor?=
 =?utf-8?Q?19HTPx+ZrYYWUNK8d8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2JoZ01Wdm02YUJBOEhuYlJFT250ek1PMGpzeTdKaFE4M2Rjc1BRcTZYMzBp?=
 =?utf-8?B?TFd6TmN3OXhpT1BRRm4vc3p1aHByOFJjKzd3NEF6K3o2YzJQM2sycVljWXZG?=
 =?utf-8?B?UGV1VlZTUjZRZVRSNVF2TnNCa1BvbURmSTkwU2k1elE3Mzd0Y09DaDFLTzFh?=
 =?utf-8?B?cGw2WEZxd2ZxRUcvSUQ4VFh4b0ZrNUQwWEVKL3VzNmFUc0ZBN0UwN0FDdkI1?=
 =?utf-8?B?VysyQXNtZkl5dzhFU3ZGOVRkQ1dGd0dtSVVFQ2VZRGNNNXRrWE5zdkVIVlhs?=
 =?utf-8?B?cTN0NVF2TDBXWFZrV0lYNkt2elc5N2JHNXVneDQ1ZlFoeHNkWUd6b0JETEl4?=
 =?utf-8?B?VzNuRktXYmpVYmtmRDA0VVhJWjRkS0s3QmY1NmNOYlFHUmEvazZNK3RDODBw?=
 =?utf-8?B?end6bUk1V1NLL2tKTndCbk9QZGV6M3QyaXY2YUJxNEJ6OUVBNFJVUGhjcmxE?=
 =?utf-8?B?d2NkdWdhck5VVTZDYStUcTNFTjRrR2l4WmZ6dGFKLzE0cDU4NkZaZFczK1Bu?=
 =?utf-8?B?ejU2RHpsUWtna2lieVdmWmRScDZBVkYvRGRzWWZQMit5UFJPV2YwSWNXZlk0?=
 =?utf-8?B?NS9HM2JoR1ZZVEtKTndTamxJbjduUkgzZmo1NlVaVTVzc3NuRUsrNUsxVDJi?=
 =?utf-8?B?bWFUWWhkN1pQNTBGdlUwVjI0N0Z2S1lML09URlVmRytjaU5WZzQ5ckxlY0RF?=
 =?utf-8?B?eUt0c1lLbEhaTXlZRjQ0VTEwSWFoZDdKNko2bWZORFgrQU1QSHVoY0dqVkFa?=
 =?utf-8?B?NFVYdXc0dnB6d2I2ZG1TdFl2czM3SEhPWWwzSG1ZNE9iaE84Smp2Q2twTXJB?=
 =?utf-8?B?a1dWZm00cm0xNjl5bU9CeVhJUklMV1NGV212eWhoZlhuSWlya0YyYktKL0JH?=
 =?utf-8?B?Snp3RmlXa0N1a0NraXgxSDQ0UW90YVN4RHFPelZXNUNzN2ZSeGxkVTZYR2Jw?=
 =?utf-8?B?aFJHeXBlZCtwdGZIUUVnVFRQMWhzUDZsWVZiRE1EcmhvT3F6TUEyZ0VBelJV?=
 =?utf-8?B?TTNWc0w1OFFUMnQyQXY0Y3BNVFI3V3YzcXRjRHF0MWEwTDNyMEZuU1N3Z0JT?=
 =?utf-8?B?dU52aVJDSjdFajdhckdQUUpxZ0ljRnRIM2VOT3Z1dUpIZWFCdFBsbE96eHVK?=
 =?utf-8?B?WG9PYVd0bzFoRklkY0NRNFR6Si9ZNklCUFgxRTZvOXhwbHVwMyt0aE1lSHk2?=
 =?utf-8?B?Sm9IcXRIcU04QXlVN3hZai9jWFBJcEtCNHJ2cjF6OEtTRnRqM0p2OGlmcERE?=
 =?utf-8?B?ejN3aEJxU0tzbVlCWDNOT1dzNXlLMkJ3NUFZMmtYQ2lwbHJSNk13bE0ySnBw?=
 =?utf-8?B?VHNXTU9VL1UzZTBWOGZBOCt3L1J6b21SY0VoeFhxWTVyWWUzQzIzb00vbzBM?=
 =?utf-8?B?dVVpRFAvdHQyOTBDV3hTdkR3SzlTWm5nREdqbDM0eWEvZ0E3UWw3SDNGZVJ4?=
 =?utf-8?B?UWJFVmVoa2ZBeEN5RjN5c3NtQk9pSFRJb0xZeWgzdEo0YmwzYkc5M0FPbk1T?=
 =?utf-8?B?aHpVWVpEV3dZSlREaEVhcno0RTg5NG5KQTBhaUlPN1ZnNlNTTTU1blUxNjZh?=
 =?utf-8?B?eE4xREYyNHZBTnBvdFFvRzFOUVVGNlowNGFUOElud3puYXEzMUFEVkFvK1Vo?=
 =?utf-8?B?YkVXb1ZWVmVoRGVzWXdvN0pNSU5kenZlQkltZENVRzVsWmVWRGg1aUJ6YWZJ?=
 =?utf-8?B?ekRPQmQzZXlVbkh4aEU5NjhsZ2tFWXZVTGNkVDBoQUN1NThRUUZiSE9LSWtv?=
 =?utf-8?B?YkV3YzFENnZaOEd2d1FNbFNUVStwTU9CK1FOSzVseGhUMngwc28vVW5NbzV6?=
 =?utf-8?B?ZGtFOW4zNVk4UkFiRThIWUowWmxLaGFLY1h0YitxdG1QNVUreDFLcm9FRnlL?=
 =?utf-8?B?SytnSE41SFdsT1N0Z2JJczY4NkR4dVAxeEhOMzBmVDdIMGZsOTRiUWdEaVJq?=
 =?utf-8?B?TGhnRnRPcjFNYmdGejkya1BESjVGb1NrT3VpQ1Q0aFRBZEw2TUhhTFk2YW9G?=
 =?utf-8?B?Tk9CRktSSWpFeG5INmJhQXJrc3B3R0pCZFg3eHFUYVBSdS9uQ2s2TG5ESnd6?=
 =?utf-8?B?WFdWYnhQZ0RYcldpY2d6N05OS0pEVU5oNjNUd2FQakdPbGZNWnpVVWRRMHRM?=
 =?utf-8?Q?EBIoojHcAM0X7PWHYb9ILXMIy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1afadd-29fe-4630-1797-08dca56a7319
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:39:40.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZOHDKnv9ed7Gr4G08HRPSCT8CNULzXIagj3WVLh2e81gdUSEFEFKOUiDHyUeqDVDxH6ef5njF5bGl4W1fDUDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8090
X-OriginatorOrg: intel.com

On 2024/7/15 18:39, Vasant Hegde wrote:
> Hi,
> 
> 
> On 7/11/2024 7:26 PM, Yi Liu wrote:
>> On 2024/7/11 18:15, Vasant Hegde wrote:
>>> Hi Yi,
>>>
>>>
>>> On 7/3/2024 12:27 PM, Yi Liu wrote:
>>>> On 2024/7/3 13:42, Vasant Hegde wrote:
>>>>> Jason,
>>>>>
>>>>>
>>>>> On 7/1/2024 10:56 PM, Jason Gunthorpe wrote:
>>>>>> On Mon, Jul 01, 2024 at 04:18:01PM +0530, Vasant Hegde wrote:
> 
> 
> .../...
> 
>>>>
>>>> https://lore.kernel.org/kvm/20240412082121.33382-1-yi.l.liu@intel.com/
>>>>
>>>> BTW. For AMD, can a single device be attached to multiple V1 page table?
>>>> IIRC. looks like AMD has only one V1 page table pointer per BDF. But there
>>>> is a PASID table which has multiple cr3 page table pointers.
>>>
>>> Jason covered this part in his response. Basically AMD has two page table :
>>>     V1 which doesn't support PASID.
>>>     V2 which support PASID
>>>
>>> By default when host is booted it will be in V1 page table. What we are planning
>>> is we will implement domain_alloc_paging() interface in AMD driver. As part of
>>> that:
>>>     - PASID capable device will be placed in V2 page table, rest will be in V1
>>> page table
>>
>> looks like the format of V1 and V2 page tables are different. Can the V2
>> page table be attached to a device (RID) and used to do address translation
>> for the DMAs w/o PASID? I have an impression that a RID can only use V1
>> page table. I may be wrong here. :)
> 
> We can attach V2 page table to a device. DMAs without PASID will use GCR3[0]
> (PASID zero).

got it. :)

> V1 is AMD IOMMU specific, V2 is compatible with CPU page table hence it can
> support PASID.
> 

yeah, this suits my understanding.

> 
>>
>>> For UNMANAGED domain (like vfio-pci), we would need a indication from core layer
>>> saying whether we want to allocate PASID capable domain or not. So that
>>> internally we can allocate appropriate page table type.
>>>
>>> That means from VFIO layer we need to pass this detail to IOMMU layer.
>>> For this part, I will start watching your patch. May be we can start discussion
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
> Right. My understanding is with vfio IOMMU we will not support PASID. SO it
> should be fine.

then you only need to take good care of the iommufd hwpt allocation uapi,
and the domain_alloc_user() callback to achieve your goal of this thread.
Anyhow, I'll still loop you in my pasid series in case anything missed
here. :)

-- 
Regards,
Yi Liu
