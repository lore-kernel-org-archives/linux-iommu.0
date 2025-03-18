Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8101E871
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308541; cv=fail; b=QsMomq+SIE+42SY7I8HTMg13LOXM6GM1380u0jjfYOUwN9dB9CXSSRzAH1Jk48vCPhsmh/U84P0NCTTs7hfyK/WGNVWz7ILVJyCj+/SWeQqcypOrU8xLmwvulPO5djY1YKZaW55Dqz2PPcMx294PONo50R8tmCtqnUk6OP5pS8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308541; c=relaxed/simple;
	bh=5hWh1DYo8nU3Va+AOPyHImyVvRc+bfqUt4ulN01H7eA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KTHcEcM3g/231V5F0ezxCTFWWVj2UOLwb79qtM6tm+f/4lv+/Gr2fNTOhgeIaCvEkAqxlsqVz532yqxlyDz+Y4ssKwLlJMD6cp7uNwhBJcCQX9CNtBSwW/NVMUj64qt1LvU4tmbEsXNPUlBY/K3MadIqbSKE1TcHTrNXilO0E3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzMTgRsj; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzMTgRsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742308536; x=1773844536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5hWh1DYo8nU3Va+AOPyHImyVvRc+bfqUt4ulN01H7eA=;
  b=JzMTgRsjALNDgu2XQoljM1RM8UB+c3uFIddcm6WlOByX8Zlbaaz5eDPo
   vAB3F1Ko0wsTUE7zsS2X/0o25FvTR3mJ5zRe+2NGikFhnFi1kIN2OkZCr
   rspb0HNwdXW+HkItIpIcGlUqgWH37xGqjviSf2WPyptiW8O78e7xdjRz7
   S6XZAwePAeOlI4zqwnIOPKoO2M5xYDPQf0kxgWeqQQGAYS+wrtcq6prp+
   iCBvNyTK2Fj5ReUorIVj18RnelLqQkJyQGaK68KYYuJWrTiSOWtvxVUxL
   G4SrIzCcT6W+XuvplSMHl/NpPJY+NprMGGdybzGlwNMjQOYRiiRieXUFD
   A==;
X-CSE-ConnectionGUID: VB2fzYeARaCdPxY/rAhp0g==
X-CSE-MsgGUID: INLgp9KxQs2qo8XuxPa3Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42626991"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="42626991"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 07:35:35 -0700
X-CSE-ConnectionGUID: H6C7y7d0Sh2wVjEvPCkTeQ==
X-CSE-MsgGUID: 2rNtMAnfTKyDJe4td2DrJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122305142"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 07:35:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 07:35:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 07:35:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 07:35:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlgnmPaukLnrtUYJ5LBhmC+/zlxkMLtLgaz7ScdrGRkdWm5O0q8+SPT5nVqSnBIBcBHwO3S6UczjNWyw8kdtbBcVbVweVuztk73Ex+swOnqOZeHDTQIS0C+rLNC0QUAiafdrpzKx7wEnBEAPTOIioTQdo7oZqiomBcqNITr/GXo50eluMDEx5qcP18nuiwQmVm0ISphQOWYor00dPSVY+YZ9/zuvZ8Pn6TQ6DzULJTUhAtaKgRb/3/WKYpcWoj6kM0DrbiLt1gtiKaabMRXkDuHivj9TCjV21SP0z8A5fu5OBMYC63aKa1bWSc/gLg+Owfk3J9ykEM9VdXzlLrtCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idYPRWXAeCeZNPHLVKcQOH1dD+Ghh4vfskpUpTd2yzs=;
 b=JC8D4yanA0eae0kV9VpjDT8Oos4rGE5zni4dzsEkUK0AQ5ckHdn7tuBXA3JWzPl+UUwEMTWX+kw9PsIIQ3SUqbo07ZJ15PJqTuzCyKfMwwImAJC5xVlq5DX5S9ZxgWpWpwf2T8890Q+mHBJ8lMgwMde4Ai0eoBq8G4UaFBxMv3IdoM8cb8CCmr3mXtjChneOfxjc3BifzIFAjZbNgc9zCSriC/0SXLtmTF+6lRUIhEte0xBOm/jJjUeqowQSOZ3MOih3I+/giSs5T9NN54XT+briRyQnr8TknJrNZFekD74NswIA/ESyWIHLDjU97TNS7qQwvJ1o4ieZpEW+wf9Jhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7122.namprd11.prod.outlook.com (2603:10b6:510:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:35:00 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:34:59 +0000
Message-ID: <6cd47624-2384-4b79-b728-9be104692521@intel.com>
Date: Tue, 18 Mar 2025 22:40:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/21] iommu: Wrap pasid_array entry creation and
 setting
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-3-yi.l.liu@intel.com>
 <20250318120447.GE9311@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250318120447.GE9311@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f991447-f304-4c99-b212-08dd662a0fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WU1Pbk9Kb3N5cC96VTVRb0ZYRExjbDFlYlluYUplb2JPNGkzdHpsMndpTXRH?=
 =?utf-8?B?blk1eUkwa0h2Y2J0SnlvWmdpeWd5b0dLdXRsRE51OEJ4UkNvTjBxUUpyU0JC?=
 =?utf-8?B?b3crQURIRjJrSDh5VVJ5UG1vUnNPWlNyQUpWSm5mWTJ5L1JpRGRIeTV1RUpC?=
 =?utf-8?B?d1hzRWxCOVlpWkU4NHM1TGYxQTF4QnRSaEVuYnhkd2k0cndZSmErb2ZRQ3NL?=
 =?utf-8?B?bWEzUHBoTTJ5Mk9nNlNNRXpEbDk3anN3OWdoWHZKd0pzcjJBOEI5VG93dUNR?=
 =?utf-8?B?b3RIY1NCMVBQYWJnemJBM3RNTUNYWG9nc1VEc0ZaRStCMk1GbWl4bVE2MmJz?=
 =?utf-8?B?dlQvVTJWVHcraDJqSmprR0Eyc2swbU44ODdrWG5WbE9zVVFTajlQVEtpN1VR?=
 =?utf-8?B?bnV1QytONUowdjhkSjBUS1dONElNSGpBMzZyWnE5eS9XTm9acjB3OTdiellG?=
 =?utf-8?B?ZHl0cXhScng1NjNEMDZuaWlXYjZWdU82SC9waWM0aTlqMVlFUTRSdEVnbmVH?=
 =?utf-8?B?V3pFS1Z1akhyNVByQkwxTCtpc1IrY0VNYlVCYUMxbUtUYld6WkNVSXlFSHRs?=
 =?utf-8?B?RUZvbDhyMUZ3cFJaUzNaYlNabnpoTE1iY2kwL1lVbXNLS3ZZd0h2eGFhdG43?=
 =?utf-8?B?d0ZWaklKUEcySGlWVWFVb2tldlBsa2x2eEEzNmZpaUlaU1JFZ1VBT2FuNHpr?=
 =?utf-8?B?R0lSc0JiY2laa1FIUzFXT3I2eTVlME1OWk5PcUY1dG1ZQk8vWlB6MG05UVlV?=
 =?utf-8?B?cmw2SmxpQm81TVZzcGZ4N3BPWEs3Ti8vL2t0aEZhVisxMStudUtZT3BZNG51?=
 =?utf-8?B?cEpZRmVCS21jakJFbjkxWDF1VlppelhHaE1uTGE5MnRXK1pLQlRPRS9ucW9k?=
 =?utf-8?B?RW9wd0JqcVUycmNzSW9tK3JxVHh3d1haNlJnYjdBaUZ0OWNZc0tvL1orQ1V3?=
 =?utf-8?B?TmxhcjJMQm9HTndYeG1FVktZaEcwL0xDcWtFdjhIMGZkcjhiL3hPMTcyeU51?=
 =?utf-8?B?MGtlTDVieFJJNjg2bXV3Ly82c05jaFo2Sy8zbnh6UG9mWW9uTURvN1RJT3pz?=
 =?utf-8?B?UXd2bXhSSEJOcktrUmJVZ0VvWkdyNGdzZDA1ZWFPbnBRVzZqUEduMTdXY3l5?=
 =?utf-8?B?QUlDZFJ4Q1Z6WlFxRERManZFTFp0eXFMWjFiN2N4SVA2UXNRZ1o0MXREdTF4?=
 =?utf-8?B?MHE1b0pCaUVsakhrVWk3VVo2cTdMZjJlKzZWYXpSdytvbm5wTVk3aXFWRGZR?=
 =?utf-8?B?M282UTNsYXYyUjFnQUdOWW9EY3pMSmh1dytvRTZOYWt6SnpXZW42RTZRaFlo?=
 =?utf-8?B?K3ROMDczRXFiWGxIRVBWT2JKRkl5NWU1Z0N1MVdiTVdOT2lIQk1GZmVzb2Jj?=
 =?utf-8?B?a1YzRTZiMXNzeGdIdkFGVHJ4MjRMVHJSU29uZjl5YmkzZ0FUOHVUaUVLbFhm?=
 =?utf-8?B?UGM5TU0xS1hPVWFFcUxIN1lXWFBkc3VxbzVHVTNlcVN4d1B4Rzc0MTM0NVl2?=
 =?utf-8?B?Zm91TFBFZWFNRVVnMUNPd3Q4b09jMmIvZW1UNnV1TmpGSkEvQk1ZVnBRbGY3?=
 =?utf-8?B?RGxraWk5QXZyclVjYUFxUWpzd3U4ZWpnNHppWWxpRHhwV21nbCtqS0MxajdY?=
 =?utf-8?B?cksxY21oVmMrd3psQ2VCSVZYRjhTUVJiOUlaTzl0aGlrS1ZXZlZCaHFyT2Zl?=
 =?utf-8?B?YWtXNWl3czFZRHJSc1o5dTU2Z0NnSzUrSnpxUDBUTHJnZ0dOQU1ONVRUM2hI?=
 =?utf-8?B?M0s3K0JUVlRkY0JaVWZLNW51ZGJPdm4wdVFFRjI3eWF6clkyNmJEclM2TE40?=
 =?utf-8?B?UlNuSnhDc2xlTVREWEQvbGFYYUZZQjJMODU2bm9sWWhVRTIxaDNwTVpaTm96?=
 =?utf-8?Q?Y+2FENI8J+7ls?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWRra0h0OFAwYlhBWVF1YmN4SXl2RWh0dW93SkpjWW1GVnVDS09PeUpVOHQ3?=
 =?utf-8?B?OU9nN1pOY1NmU3g3Sk1pQnVJN3NjUm50WVNJL21ZcWJPdFNRTDJEMFRSVjRk?=
 =?utf-8?B?MGUwemkzOTdJdkFCSXpEaVg3dmdOK2VmWDZGbjQrditXeDd4bEtFYlpIVnJM?=
 =?utf-8?B?MTRRWGNjY3poc3dpQ1UybUt4c1BEaTZ3ZnFZS0NGRWlud3JLRjc5NFBVTmtJ?=
 =?utf-8?B?amY2OVdxYjRmTk9TaVIyTU1XdmZoQ215NHN6YUZJOC9WQVdRSGFBWS9IT3Nh?=
 =?utf-8?B?TXpXK2NPa2xmc0pwZ0t1Rkc5dEpTYzRJWGQweEZLUHJ4MzVyRXJCaTlQc2R3?=
 =?utf-8?B?aGN6UG5BNFdTOFZ5K21nekNIN25NQ0FPMW00ZGxtUWhtd0pvYWk5NmhQbXdz?=
 =?utf-8?B?LzNoTGxJSGpRLzlzdnJmcGxhSTRGd3R5UnpvV3JZQTZHdmY2QUptdkErejc3?=
 =?utf-8?B?L2haOC8ycGhiRE1SUENTNVZSYVBsaDBrMDJtQWlZMU5mOTR3YTNuMVFSekxp?=
 =?utf-8?B?elhmb1JGL2JpS2dkUXNNZE9qRWErM2pWMVBlREFLNUxXVDRQT0VQOG52bDhx?=
 =?utf-8?B?VldzRi9KcmdNd1FVZnhIVUhVZHhMRHZweEkvUTVOcUEzbHRKdFhBSFpHa2FO?=
 =?utf-8?B?VHE2TDAzZUdIUjRzMFowRUhaUWRjT3Jjb3pVbmJ4dDlLR1IzYkdELzBhVE9Q?=
 =?utf-8?B?TTZiZXkvZERkaVhyUjk0RzZzcTdEaUR3ODJHRk00VHhPdmlXcEswUkIzSTc5?=
 =?utf-8?B?RnNxMWRkODYxNEkvNWYrN20wb0hyZG50OGhSQy9NcW9mYm1DZFVleGV5U3JG?=
 =?utf-8?B?SjZTNXJtbkdKd2pYMUJ1U3V1ZFVIWFVKMzNjWGFWa3ltL2VxNUtHdUNhYzdE?=
 =?utf-8?B?WE9Sak9yNWJxK3BMcTFNZmNYVzgzcnBBVTlUOVREVmRDRHRFaWNjVmc2N3ZO?=
 =?utf-8?B?eG52a0FaWlE5SnlQWTlvcEZ3cGkwdFBtb254dEFDeFIvMW0wZWR6YktzYkZm?=
 =?utf-8?B?OXkyeURlMlpaQnlXY0MvQktqRUR1SmwrSjBkMHhZOXhrZXloNEhmMDh3b1Bk?=
 =?utf-8?B?NjhvRGxScDV4b2h1QnEwMVVSSlNWejgzbUpGNFdCd3A0WTlsTGgxRjJPMHNm?=
 =?utf-8?B?UXVkWjBsYXduUUpoTXpRa0k0aDdaUmRaOUZwT1lmQzFveWhENnFBQ0pqVjVG?=
 =?utf-8?B?eDltWG55eTBKaituQStIbzRLYWNLVDVhRXk1SXdzOVN6bm16VGZ5RU12cjBC?=
 =?utf-8?B?eHVxcExaT3k0NmZ5NU5SQlBDdE5RWnQyZzg4YkdndUxvVzBzamFsMXNBZFFn?=
 =?utf-8?B?SmFuY3NwU0dHSnVuMWNlS3dscnVpNjJnV3BNY2YyRXhlVGpZUHBYM0hEdlpZ?=
 =?utf-8?B?LzJzL3hOajZLc1QyUHVXTzR0UzhUc1V3UnkyN0ZqWEh1WVlYTTdMYzhma2Rm?=
 =?utf-8?B?bkM1RzNuY0FuaUV0bVQxYklPLzVRRS9BUnBETWFPcWVOZFM2eW9UWC93VWxP?=
 =?utf-8?B?bGJjREhjd0FpbE53RXNBTkIvUisrUGd5ZXQ4dENOaEFjQnZOQzc5OWxUTHhN?=
 =?utf-8?B?OW14QnBhbkFTbE5VOTZSU1c5RHRoQTYxamVlNjRSS3lEUW1pRWFwZG0wVFpr?=
 =?utf-8?B?dFRMTmp3UUptQUNJcW54bWkxNDFLcTBRUjFoZm9xOUIwSi9RS0lNSndwbW1m?=
 =?utf-8?B?Ym1NNWloQjNieXNLbnFtaXc5QjYxNzZERlRiUitYQnU4R1JKWUhUK082Z1Vn?=
 =?utf-8?B?N2hkL216aWo1Qkcwd2tqaGlTeTUyMGROZTJhb0JLaHlEdGU3Z2h3ZEpWMnhD?=
 =?utf-8?B?R1Fablc1QmhzamkxOGVwdVUya0VCQ0Y4b1hPWWhLTVViSmMvRUhxVDJjN0FK?=
 =?utf-8?B?VTZEaWQzWVJjdEh1YVBVdUd4a3h0cHBabDFpaUFXSjVKM2FvbTQ2QUFTZ3Zr?=
 =?utf-8?B?U3M4d2dzYjVGZU02cUhpcGsvTm5xemZxU1cvNGc1UTR2SE9IZmoxUmpQdkIx?=
 =?utf-8?B?Q2x1WXZlNHlRZDYrUzM2MExhU0ZyVEs5Q09xdVNSQTlDSE9lejRCVEFQRDA1?=
 =?utf-8?B?N3RTSzJsZTNwWVl4QlFrZHp6Z0FqQUpJQ1J3Q2wvUXhtWW56VlhRblNYTi96?=
 =?utf-8?Q?OVBqbE3KeKk9VQS+m1S9/hHNF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f991447-f304-4c99-b212-08dd662a0fb7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:34:59.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaNNzvlPIoEGK6F1WQ+vLNn2NlaEne8ihh0IsHaq2q9bHuCezybfjJ6++e/la/OPIKs6NXDv0vnVzH7j/9d1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7122
X-OriginatorOrg: intel.com

On 2025/3/18 20:04, Jason Gunthorpe wrote:
> On Thu, Mar 13, 2025 at 05:35:13AM -0700, Yi Liu wrote:
>> The IOMMU core does not mandate that callers must always provide a new
>> handle, allowing for the possibility of handle reuse. In the replace
>> path, the existing handle can be reused. To facilitate this, the core
>> must ensure that the pasid_array entry is made or updated under xa_lock
>> to prevent race conditions with callers of
>> iommu_attach_handle_get().
> 
> I don't think that helps, the access to handle->domain is done unlocked:
> 
> static struct iommu_attach_handle *find_fault_handler(struct device *dev,
> 						     struct iopf_fault *evt)
> {
> [..]
> 	if (!attach_handle->domain->iopf_handler)
> 		return NULL;
> 
> And so on. So even with this locking change the domain value is unstable.
> 
> The driver still has to fence the iopf queue to flush out the domain
> references during replace.
> 
> We decided the instability of fault delivery during replace is fine,
> as it is logically OK for either domain to receive the fault.
> 
> What is problematic here is the repeated references to handle->domain
> in the fault path without locking during handle reuse. It should be
> using READ_ONCE(attach_handle->domain) and it should happen only once.
> 
>> Additionally, this operation should be performed only after the underlying
>> IOMMU driver has successfully set the domain. This precaution is necessary
>> to prevent forwarding PRIs to the new domain before it is fully prepared.
> 
> This can't work, we need to change the xarray, then have the driver
> do the fencing to flush out the old xarray value from the fault path.
> 
> Otherwise the old handle and domain is still floating out there after
> replace/attach returns which will UAF the domain pointer.

yeah, let's go forward with the agreement in patch 11 of this series.

-- 
Regards,
Yi Liu
