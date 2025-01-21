Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC01891AB
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443910; cv=fail; b=pKqk3OEddC5v2bt8IWYMLipD7FBe80wJjxh4/mUiejvEHcrMDbfOE5ywRxwacPsgfjYpiLDoiu0IPZP4XAcR36X/8wUAkm/AK7WL/Xtvw0l6srjeHPpBzZGV/UIyCMo/sw5LLgSUG90nZdkbQuq4EzRmA/FPthJnsyDaAl3UlHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443910; c=relaxed/simple;
	bh=Pcsxq/0cXWggsntlBSZQKHOOSd1HBI3OpnLkbafwc+o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmY4gv9VXLxRgK6cCdE4JsCyjAZkvbPAzN9tKg/yYyn5P5C/jZza3M8/OfCziW25gO5LsB6JL0/j9Shj4TvbMMfZxmKt6ZRTfZf+GOK/Ei6T2qmnREd4vY73uLlAhnD6+LJV9RNe1CTo1tRr4JPCspQOQb4YydTw1w7I2mU9EKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWa7Yh5k; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWa7Yh5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737443908; x=1768979908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pcsxq/0cXWggsntlBSZQKHOOSd1HBI3OpnLkbafwc+o=;
  b=dWa7Yh5k+LMsaFFzT11xerDwqVX0I6cOXsRv+gDdmP4ScCFah+DUFuGu
   yfkliU+RMClWEjF144fEcct74nnqTnvy0T7j1x2GSC6OFOWGqicgFPIuT
   FSO09/MLVUWj0X5Z2FbgxGXobBbAsJww+xPDTEpCFVH1zv8TrER/FQIOV
   ARbH8EL0nVNYzBXv3+mUN1OBZd+ZlUnbxurdMke8U36pAjHjCXUdUpKdT
   k9dExPREb/JdOCK49kRlKTKSeK2elppESMHRykqhf4xzpp/divgpjh9Bs
   r7G4JzXMkpJDci3tpDBTyeXGbz7JTh5uKoYT2riPXYmGSQTnf+UYlzmIY
   Q==;
X-CSE-ConnectionGUID: mOl5zxsNR9yOCipo3nssUw==
X-CSE-MsgGUID: dulBQJUSTaydG4yIVYOheA==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="41603210"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="41603210"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 23:18:26 -0800
X-CSE-ConnectionGUID: ejG40NIbRkmOBUsZv/7t0A==
X-CSE-MsgGUID: LLbjLhSfQ5WSH+OfvlFNKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="129981408"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jan 2025 23:18:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 23:18:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 23:18:25 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 23:18:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWe3GhM41NxsgWh3RGRmGfNO8RbN29WM6tlGgWdu78MQwISvT7+cTSxWYJXRMmseKRKXlMaJxSjAzIxSpqBaWyFTTZzULGU+Cql3SbCiFjaqyuWsMyh4gh6Q4P1nPKOhuXex3q6/SyRQhxLdjqIN5oes9g7kWn9jUvCtaLVhJUOooA8QZBlzt50Ry2NTdR8nBIzkuQzhgPjt8/SGwCNolvy3rQewPLByGAfsbRm/k5Mx+NvsCGdrKezrCa0e/s9+omPHyTdniOTd2MBp9qX2EQWQVf9yzQnFS8S+pCADOqGlVKufsMXY6HQQE9nxQgZBUttqSpwiwuyby6Ia+eI+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBaDE6Glmnr+ZVK58mUNLQ0J9HuCnAC8xM7u0OnexOU=;
 b=o47EM/gKwwfi/OSfNm5h7nRzDnQHMVs1hFjVJulGx19P43HMEhor7ceOHY0GEHV7ayh3BP8dt5EyW+mzYh/FLWxg5vdxtMnErcqJ9RlpN1eB+PR1dvgQleUAkbQOVbhRcR0Tpx5bXNSfsSTmbuPjXdDDZl66PsYWcOpuDp9brKcqMLii5sv+BPvlN+XHPX9wifniedIhA4dV/sM6F9439L7D1RmYqH//DTYhcfRvLQP+YDZMcyHBYhckDRdcf8TbMIE9Wqz6xo6klStWHcj7e/5PajmaaET7i5nEvh0H/IBUptKZexDvzT4IB598GrkTShm6/FQ7sLuRyR95akt6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 07:17:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 07:17:42 +0000
Message-ID: <049af2c8-dc76-40c4-9e1c-3d4b9743607b@intel.com>
Date: Tue, 21 Jan 2025 15:22:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: Store either domain or handle in
 group->pasid_array
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <jacob.pan@linux.microsoft.com>,
	<robin.murphy@arm.com>, <nicolinc@nvidia.com>, <will@kernel.org>
References: <20250120030840.4171-1-yi.l.liu@intel.com>
 <20250120030840.4171-2-yi.l.liu@intel.com> <20250120155535.GK5556@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250120155535.GK5556@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c11d6a-b56c-4725-2c16-08dd39ebb1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkFVQSsvL0ZXLzdib3FnMXUweUtoakwxRlI1TEFRSC9aZlBoNFdzTlo1dG1K?=
 =?utf-8?B?Z0hnWHdhbmpmQVR3ZU84WGVaTG52WkRJRUxLa0lvS240S1BQK0lEaEdoQ0RQ?=
 =?utf-8?B?d3VDdUYwZEMwUzZzZjBGai94OUNmQXlvVysrWS9VNlZkRU52NVJ0ME9QSTJR?=
 =?utf-8?B?V2w4d0ZmWlVQckYydkdXQ0pRTlExZS9kWUt6ZU9rbzRyaGJyRFprSGlSOXY1?=
 =?utf-8?B?TTZpZnBuYXFVeXJJWU5abm1nZ1FCaUZza1JKQlRJcUhOVnlZMjNhekdFSFZ4?=
 =?utf-8?B?eUcxNnFqVnB1WnRtMzl1dE9Ba290b1NBZFJ6WTVWQWcrV1ZNdmNtcXYzMEVN?=
 =?utf-8?B?NGtWeFAvT0h6eFFIYk9PL2hZdFRjMnNoRzZIYnllWGw2ZFg0VFltb2VGWEtB?=
 =?utf-8?B?eFh3TmFiQmpYUGQrRmJhS3NoYWFCRWJBZ3k4aUdqaTBCak5qUEdhbFJrWE9R?=
 =?utf-8?B?QVY0S0dXL1gzdTJIOXNMalo1emc2OTV2aTlsQjJvNk5sZjZWeStvV2c1Y2dE?=
 =?utf-8?B?TnVQUkFNRnhMZEwxRmo0U1A5cDJQWGpiRmhmMHllakUzYkhDTWdPOTZMdHUz?=
 =?utf-8?B?MGdOL2tDZmVLZFhDTkxuaTNnK0twTlJUekJpWTZUWmMvdVVmS1puMnJSVUti?=
 =?utf-8?B?UTBpalJxRlpkKzcyWVRKNXFlVGpkSVdicjM3bGpSOE9JaEtDS0NuSG1OWEVG?=
 =?utf-8?B?SVJXRUlxbDJGUW9TeWNBSVY4ajJZZmVaRjFoTkp6U2ZMVEVsZHd3YkJiV3Bu?=
 =?utf-8?B?Z2EwZEFMaGRwWVVLMW9ocFh4MXdtdDBFYzVmbjNoQVE4bFE2eCtUMU5iZ2w2?=
 =?utf-8?B?TzdaeFhHMHRMYzgyTWY1MXBTelBYdUk5QzdKaDZTY0xNK01UUkViNVVUVEMy?=
 =?utf-8?B?Q2ZhSlRzL0VEdHVYaHRLRWNMbzI4SDFiSVI2czNMR1RBS0ZScFNGNHdQWTJE?=
 =?utf-8?B?bWV1UlM0WWpjaFlsSTNhQVBGTXo3Y1k3dW13YVNXWlBuV2V0OUJ2ZCtPeHh1?=
 =?utf-8?B?U3ZjNFZob1JDb1c0Y2o2WkpKS3UxZWdXNXRoaW4vSG1CL05tZjVjQWtydVNs?=
 =?utf-8?B?Mnd4M3NVYVJpeHZ6OGFhTWhSUG9teTlSdjJqZFJTRkxxWWp2TU5vanQxdEJB?=
 =?utf-8?B?R0tmeUtybmJaM1Vmc3JpY3lBc09NeDFOUGhzbVdzRlQ2dFdQZnJaaHdCTXNv?=
 =?utf-8?B?TjlrbklXMzAyb2tZN2Z2dzJVRHBiSFdJWmpGRlpwSzFwTnRNT3JtVkk4MS9j?=
 =?utf-8?B?c1Yza3Y2QWlmV3gvTUdPb1BPOENzVmp0ZXVFS24zUEZhMFpXN0p1bGNjV1RB?=
 =?utf-8?B?bEp6OUhTZHdyUmo1MUcxOGJTSzdqUGU0Y1BHc0NGb0xDWnR6N0RzYmNmcGV0?=
 =?utf-8?B?U0drMFdmK2M5MlRaNGgwSm5QbWI1dkdGM3VGV1JTcGdTZDBNTU9nNG55aVZ4?=
 =?utf-8?B?RVNOcjUxVmxpZmhWM0h1UkNZYTV4RG5kM0R6NGxtUDlSWGYzR0RxUGVOdHNZ?=
 =?utf-8?B?QmVLcFViMWpUcnFCakdTeGIwQlJjSFk4QURzTTZqVk5NNXZuejlmdDgwcHZL?=
 =?utf-8?B?T0xnMEdnUXV2OFk5eWtYSjFNbVgyY2laRXR0S1NST1BaL0RnQ0Eram9EUXJq?=
 =?utf-8?B?ZUtLdHdUb3V1S2tsOUtDbWtyRDE0RGdzdVRxR0tTL0paWjV2MFJGL3BDWGpC?=
 =?utf-8?B?Lzltc1kwOG1wdFFMWXFFb21sSFd4NCtYTDFPQTRIK0ZraFpjZnZQVmN3Nmxl?=
 =?utf-8?B?WlFMaDVDY0xseklncUsvajMvcEk5T1ZzRTE5ZVdZV3FtUWZVekp3azh3aEp4?=
 =?utf-8?B?TWdMUUhmYXYzYWF6Ym9IRElRTDJXL2F4U3lmUEhocUNEbkFIOHAxMWNZQjJu?=
 =?utf-8?Q?qPfxZHOf0HdBi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RytHbEtUNVZ3a0RxNjZONXlhQVJSV21tOTJHYlhoSy9CR01HS0RYWWZMQm5p?=
 =?utf-8?B?SWlVcTN3MDZkcTNnVVhnS2JOQURsM3BqUk5NQzU4K1lwdkpPanNqRDRuTHJ5?=
 =?utf-8?B?dkJSUnRRN1l0cDdkU2ZuaDVJM2F2cGxCL3RrUVJoV0FlK0s3MEd1U3lXeFcx?=
 =?utf-8?B?cWZkbUZIYm14OWgxT053ZjhTaERNTFl3UU80K2xMQXN6RW00a2NEaXpuZUpH?=
 =?utf-8?B?UGVIb1oxMVpHcjBuVXhnQTRVckVZbW52UmNHTGtkWDMwaUtHWnY1Q0RzSFo2?=
 =?utf-8?B?RUFZamhYSTJ3RGs0Vnd2eGFSa1dMZHVwazlkdFlLSmdqVEIrSXRXck1YY1VB?=
 =?utf-8?B?K2ttL254czBPN05vL3Y0a3RsQWJuVnoxWHlEWStOci9ONUIyWlJmYVJZNVRX?=
 =?utf-8?B?UFFDTTk2UUJKeG1EYXBBNCs3WkJMclJsUjlWcnVuM3NTNXEvbVNoL0ZmZzBR?=
 =?utf-8?B?SXN2aU9WS1ZCRnRRWWlQdzdlSEh0UnJTaDB6UVNEMjZDMENzMFBxaDBZTG1H?=
 =?utf-8?B?RzRqQktvVnllU241cVFScVA2bnlrN096NXIyUW1ZbktzeGpBeDRhZFhMZHZ1?=
 =?utf-8?B?NWNoQmhWVCtjRktJOFNCTVpCdXhoa1pUbW1xRVBYc1M0T3dmajVxVjY0S0JQ?=
 =?utf-8?B?T3oyNXk0VDhEUzE1cWozbzlqb2pxUTdtQ3JvOWhqdkRVeGxob3M1MklvdjM0?=
 =?utf-8?B?K09abWwxdEFLNkF2Nmg4TS9kNUdXUmt1NXBqTlYzTzhId0w1eUpUNTlkWm9G?=
 =?utf-8?B?ay8wTElvRHBjdERUbVhqS3pFUWd4MVo0WmJpcWtGTTJvNlFsYUJ0d094NWcy?=
 =?utf-8?B?VmJZU0g2S1JOYXBGbkFocTczcnRCRTZZK2RTRVkzSDBGbk0vWHdWeWdwT0Uw?=
 =?utf-8?B?OHNYdmxSYnpTc2VOaUVTM2c2K0xXNy9HVnMzb2xLenovL0FWYmozME55Z2lW?=
 =?utf-8?B?akNIeHI4RzdvNzZWM2kvRkc3OTNhVjVYT294L2VtYzEzWHE3bXkwMVFZYXRv?=
 =?utf-8?B?dnRRdjByQ1ZqRDYrQ0htY0JRMTVjR01kMlJpRWZFMzFHMHJNUzhvVHU1R0Zz?=
 =?utf-8?B?UmVaRHRQVXZMNlUydFVwR0JScWNDVWRla3RLalFVMGJkNXRrQk4xVzhYdUUx?=
 =?utf-8?B?UG0vZTZkSWFsMjFQU1U1TTUraVl5dTZ0RFRLcjhuWlphVTJCaGJkaUhRbDFF?=
 =?utf-8?B?Z1pNR1BaNUcxaXNwcVZtS0F5b21Obkh2NlhLUnFDRzA3bkw4YUVjcXVVZi9Y?=
 =?utf-8?B?NEhTNDZnY1RQWFYrVUE5VkxCeWFzL3VWeDlGZVZ1QjhWYXlXRGltK3QzOFdU?=
 =?utf-8?B?TWVKK0YxelJ2TStObDRtUHRtUXJJbUN5NjQyQmswVGlqV2VTYStTWHVYSXVR?=
 =?utf-8?B?a3htbGVybUc1c2U4YU9KYk4wVHB6YkFzUlI1RkVxakNzL3RSMTVGSnZVMCtD?=
 =?utf-8?B?L21XZ0RtUm9pc2R6RHBYckMvRmM4aXQrWmZCa1QvOUpqd3ZLSS9saU80Z0Rs?=
 =?utf-8?B?M2FscE5HMExMTEViVngyOWZlY1g4UkZHWm5VTEhSNysvTkhMTUFLbXJSeDBX?=
 =?utf-8?B?WXlYTTk5bWhaYUxqVkRXQkc4c1NjQXVndi9tN3IraktPQmNNM2VPNzhSOXdu?=
 =?utf-8?B?ajFDSFJmOTJMNGo1ekpWanNueERTMmFaY2hVeWJjeWlrOUZDRTlwUXBhS054?=
 =?utf-8?B?WUh5czFUdEs2aExzQ2tpQlRVKzc2Q3BOckovNDM1anhiNllqYlF5ZCsvOEVq?=
 =?utf-8?B?YmRjSzJTd3FXc2kvYVZhdjdMVXE1WjlKeTB0N2VMWXNjK242QlFiVFphNWM2?=
 =?utf-8?B?M0QwOE54WlZMeXo2MW9iaFQ5MUpnTnRCdXBIb0tJV2tCN2tKVVZuVytKK1RC?=
 =?utf-8?B?SUN2bTV0YlZVM3ViTGZsRW5lU0RJeVViOHNkU3UxNHQ3OFhwVHVEemJVTWtD?=
 =?utf-8?B?R0dMWHE5b1NscHZXZ3ZHU1hzbGxzOEN1UDZGMlQ3NXRPbUI5eGtJLzR0UlZH?=
 =?utf-8?B?dUo4UVlXdEY5VzdSVFBtOFh0d213bGJaeGNHS0lEYk1iZFlUZUpGT3dnMkN5?=
 =?utf-8?B?QzVpK21sS1JxQlBldm4yY2hsQVdua0U2S29nRlU5M1hPTmcwNXZFUDY0VzVU?=
 =?utf-8?Q?l3bQDZQMsT0DTlzo5AJT+xtHJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c11d6a-b56c-4725-2c16-08dd39ebb1a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 07:17:42.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3n4NxFDZLQ76/Zv6XXpsFKHwHU06NnyphY+kKHghz/CJDuRL/qJMTL3PMHrd7FQ0Yyd54IEGSDkPfvbTLT5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com

On 2025/1/20 23:55, Jason Gunthorpe wrote:
> On Sun, Jan 19, 2025 at 07:08:39PM -0800, Yi Liu wrote:
>> iommu_attach_device_pasid() only stores handle to group->pasid_array
>> when there is a valid handle input. However, it makes the
>> iommu_attach_device_pasid() unable to detect if the pasid has been
>> attached or not. To be complete, let the iommu_attach_device_pasid()
>> store the domain to group->pasid_array if no valid handle.
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommu.c | 23 +++++++++++++++++------
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 28ffd836592b..278c4eb8f225 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -45,6 +45,8 @@ static unsigned int iommu_def_domain_type __read_mostly;
>>   static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
>>   static u32 iommu_cmd_line __read_mostly;
>>   
>> +enum { IOMMU_PASID_ARRAY_DOMAIN, IOMMU_PASID_ARRAY_HANDLE };
> 
> Since xarray says:
> 
>   * @tag: Tag value (0, 1 or 3).
> 
> I would initialize those enums and add a small comment

yes.

> /* tags used with xa_tag_pointer() */
> enum { IOMMU_PASID_ARRAY_DOMAIN = 0, IOMMU_PASID_ARRAY_HANDLE = 1 };
> 
>> @@ -3397,10 +3400,14 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>   		}
>>   	}
>>   
>> -	if (handle)
>> +	if (handle) {
>>   		handle->domain = domain;
>> +		xa_entry = xa_tag_pointer(handle, IOMMU_PASID_ARRAY_HANDLE);
>> +	} else {
>> +		xa_entry = xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
>> +	}
> 
> What about iommu_attach_group_handle() ?
> 
> 	mutex_lock(&group->mutex);
> 	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> 	if (ret)
> 
> And iommu_replace_group_handle() ?
> 
> 	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> 
> I think it should be consistent and it should call xa_tag_poiner() too
> (even though it implicitly always is since the domain is stored in the
> group)??

yes, it needs to be fixed as well. I asked a help from Baolu in prior
email, but I can enlarge this series to cover both RID and PASID path. :)

-- 
Regards,
Yi Liu
