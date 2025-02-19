Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9925A4D5
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 04:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739939059; cv=fail; b=NdmNoW2BlemSFIaRvYRWAFr1thhMyiYor+kpOdtU69zeMrAOahcW6uDX9Cq7fWwbrnSKGYiWM++HKWk0wSz3lonW7JCawYYeAouwVmuYzikPqIZdnCR9dNb7fm2B3oU9nGsDWHem391ubvnVDY/9IxmLJKNIDiwiMSvkYFfHpFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739939059; c=relaxed/simple;
	bh=9U2SuQrZDM/zIDDCEgVhkLFijKDeSAdk7oNVcpNofcc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FB0zFDhxH25gDSRIz428wAlEuhuF/nz4WaPMkkqq8aUBiGy25+teJuLcQ/ukZlAOyGtgz3B89QeQ8Pfu3rDFeconihqkkh6hNHsVPTETlUkIEZbL7MY7AAjhA/OyqU5OYSWKsjiV37dGJcLyT0gFC/X792I0EtIb92HL8C4fYxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKgnEdZo; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKgnEdZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739939058; x=1771475058;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9U2SuQrZDM/zIDDCEgVhkLFijKDeSAdk7oNVcpNofcc=;
  b=FKgnEdZoYUQFzCqjowkem93Dt3bsJYENy9cUscmOXminRcovsVewwW8r
   xomx6d5tKLednJGpLfjhc1bsHK4rfobLXtz9HLrH3B0fkdILnSi5gyWf2
   qlKnj6MRG0GYcqcV+U5vzK0AGMuWh+g9BLidqI/IC7wnETdGqoLfKV3Qb
   xsJohOKHOo7+q8/UbXmnHb0TKjlKBLaHv/qwT+04tDVcKPNUTllbWysc7
   CoyDmGc+Z922bYEYLEmAKtEmru/cDi00kKXybqOy4r5jbDE6bHrWJ/jZy
   e2U/QII/qZxKdmadBFLuLy+urfpeqyQLFPGRMVf7z6QCujSpHEkWn6wXe
   Q==;
X-CSE-ConnectionGUID: iJeHUSVsSlCioFlhWga6XA==
X-CSE-MsgGUID: u3fZIrwhS+WC/h6B1qzKtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="66018010"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="66018010"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 20:24:17 -0800
X-CSE-ConnectionGUID: sVFdN0EaTiCe7IU0ACYtNA==
X-CSE-MsgGUID: Th9WdVRxTJiZfASe8m/BIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="119709773"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2025 20:24:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 20:24:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 20:24:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 20:24:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXSwT2Qa+rWBqZZXgBA7o38AISMGEbQqtPnHVM0ol1PPEJ7ZDoTTux5qwjVUukNybAHNBXoDXJ8xXLQoZvkA8DPnUMCagwIlwvowRkZAUKiqBvPxuTIg37AIMhgGK3g15GLoMF5cQOjHEv5GUQaADgcac4K8+Z1VXdJ22cPmjUPjOjxaTMtNbF0cK8Y/OJczFcFwBwenyGbfUdEz3JUgIZc98RTq1kgWJU+rCiWEfr/bZ5uKrqlYTMuSrEZsxFotwKOyBzy/OxGCuLw12AIKTJ99uCWIZsmnTUgaveZ8Ld+rv21+sdZgDLs+ZxTMQJS4g0wh0ZSME35nkfgUE8xbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN3tefgmg0ed7ft7IlMa7jQG1kZ2+IT2QUwx60fPTFs=;
 b=OqQkR3NN4dE8LfMSFcn3mlKjk+nE0pbe0MHmbpbZeId6QTgJaNnIIoAPbseOrlmIpQ6XywLWAnom5ljMBnyD+958MNqPjQZZ0pOW2UBFN5k+FrmzNoiT3HgvdKcJi2pp2/aZlkzJj6aiki+5XcPvmdRABkN8PusJ24pVXuVDQbnI2JI5LKwDKeay1RFEXK1V7RbSIu9URvgEcAuVz7HYrEEKvmo4K9WzbfYJalO4UwQhE3yv9Mi0+O/m+G0kjZzpsRb1mw8lH9AxVZsBYubLXUliTrEM+dZn2Bj2feux/pfXEkfR1kB3S5tEaLKF+N94wcneMLUmHZMYkRRkUvN3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB8263.namprd11.prod.outlook.com (2603:10b6:806:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 19 Feb
 2025 04:24:13 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8445.013; Wed, 19 Feb 2025
 04:24:13 +0000
Message-ID: <975f9f29-bf06-48d2-96bf-49a68ae1cd49@intel.com>
Date: Wed, 19 Feb 2025 12:29:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] iommu: Swap the order of setting group->pasid_array
 and calling attach op of iommu drivers
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <robin.murphy@arm.com>, <nicolinc@nvidia.com>,
	<will@kernel.org>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-5-yi.l.liu@intel.com>
 <20250218192718.GE4183890@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250218192718.GE4183890@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 39315f6c-a51f-4da4-7f0e-08dd509d43c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3RBc2tFTkZSanJKNUVuVFhLT0d6WmN0NUp2U3lGV1NOWTdiU2h5bllISDIr?=
 =?utf-8?B?MjI4SXNnMjRVc3lNQ1JBVTZLRXBVcU5wS0QxMzhEbmpDWjBSSE4zT1NUbWJs?=
 =?utf-8?B?QlJnenFGSFl5OVpSamsxcmNIUWQyTWtkMlBQcmlFM0RRRUdISHZiRmd4Nlow?=
 =?utf-8?B?VERBQ1hxajdlaTFNMkdlKzBpcnNENjZRNEtIckt1SW9sclUwTjlhOC8vQlZv?=
 =?utf-8?B?aUFmbkoxczREMEI2dGJiWWVrdTdIQVJMWXU0YmtoTVpNVFVIQ1ZZMUR1Rzcw?=
 =?utf-8?B?YVpScTMrOXA4NldtR2x6Y29HN1p4dUFiVWtoQlV2dnpaanJUZHlNdFE1VE1G?=
 =?utf-8?B?MHN6d0FnempWenIwTDZWWnpjWVhJSjQ5Ykh5dE9JR2xvZDRIYnB3L2IrYzJj?=
 =?utf-8?B?YzV0dkltQjE5VTE2N0JaeUY4aGZ2SVNFT0JtQ2tWL2tNVjdzUlJsYllVdHpx?=
 =?utf-8?B?elViWXpGMnpNZlEweUk1emVMUGdnbXFtT0VwalpIZERYZVpoRWduTFRuVGVy?=
 =?utf-8?B?RTJFK25jaWJybTV2NmN6SFJzVG5nWmtBT2VWNm5HN21GMXhZbk1reUtyaklW?=
 =?utf-8?B?UEo2bEFKTStLNDlNZ2xMbTFnRkMxa2M2ZUFYU3hjR3BjS2Zkb3lGSmxIVWxu?=
 =?utf-8?B?TCtsVDhFY1RjcDVnTUVOMDk1QTVldWcrVmhIMitScXYzeFRmVXlhSk1mMVcy?=
 =?utf-8?B?UlJkNEh2QU1UUW1tQXJDZ2hTOFA4MnBzc3E0aTFjUyt0RmhLMHgxc29Scm53?=
 =?utf-8?B?RExMMnp4MmNEZm01c2pHTE1KYUxqQzF2dlpBSUtjMkJnVjc4NWlNNjFoSmUr?=
 =?utf-8?B?VXFoOTZkSnAxek81RUxjOFlLUi9EYTRIcEdmdEIrMWgvT0dQaU9qZEtWYUlS?=
 =?utf-8?B?cnVzcUhaM0UvK1ZwTHAweXZUVzJ5bDdBTHU2YUdub1ZqQjNQOVI0dDIwY2x1?=
 =?utf-8?B?T29lSXd2SWV0dStCSHFrUFJ5RDZQMXV6SEZWUjRHbWlNU0JSdy9OaVZZSnVa?=
 =?utf-8?B?YzRCUDRoa1l5a3RCM2FTUU5XQ3I2VytURnBDd2d0eEhiOFRocWtuS1lnYkx6?=
 =?utf-8?B?cmxDbUg5MmNVWG56ZGdlZ2xKbEhscXBMN0tiVkErbW5EUlhzaDFybmh4b2M2?=
 =?utf-8?B?V1gySjVDeUU5NHFHQ093MndWUUNTQkJiRXF1R3gwVVUvaVRoTHZKRENUQlYv?=
 =?utf-8?B?b0hITU16emRsVmtmSU9vUW51bVFJYWtjaWE3aXQwMHpLT3lFTGFoNjBZMzVX?=
 =?utf-8?B?UE5sbnhlVlFscEM5b3JvbFJuVnRmNEVNZUxkYW53S0c2dzBiU21CMi8yendN?=
 =?utf-8?B?NWNYdnNZbUNKclpnNDRYaDAwaHNYWjZiUEE5NHhOWnFFTWsxbHQ5R0FJOHd6?=
 =?utf-8?B?ZmFZaXdqa0FNWlpEd1dETTdtVFNIWTUxU0wxQk1iMEpiaTJlRE1JRURkNzhn?=
 =?utf-8?B?YTJVbWwzRjJJa0RLRndIQ2pWVU5nNXRPS1lCSzBRRkx0dndETWphdkhtdkdH?=
 =?utf-8?B?c2VZUmUvSTJnUCtYcGNuZjJ1Mk5QK09nRzhCR2pKenFkUlB5QUNxaXNnVFpm?=
 =?utf-8?B?SjNzMHhJODJkdi9sVGg5MmhINzdTai9mVnAxcVpuRlFrV0VVVXVHSFAyWHRT?=
 =?utf-8?B?N2JpMXppMnV5bGtPMTFySktoRnJGNTgyRkMzM1JBV3N1Y25KdGlMbEkxYkdQ?=
 =?utf-8?B?TGp6Ym50ZENpZnlpTFZNZHdod2tTQVdlandmVE4xU000NTZUbzd5MWx5N0RC?=
 =?utf-8?B?cVYxS2djL3BpUkcyR2xzYTlPQWtreE83RWZjWTY2OWlXUDBOYnZqdWRkVWRk?=
 =?utf-8?B?ZUVHYk11bkZndUpLelFuc2NqUit5K1JsR1FrYm5Nb1lLOW9KUndtZGF6cW91?=
 =?utf-8?Q?+aID9yJY0bGk6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZsdzZ1MThIVy9GbVFndmU2YTdVVTlQdStNelVRaS9Oc3R5WFBKTEh6VWts?=
 =?utf-8?B?V0gvalgzajVKRk9qbU1xZGE4TzhXVTYzSmtGaE9IUFlqYXB2VE5GWER2blNP?=
 =?utf-8?B?bnRvSlhZbHhDTy84SGFrdE5WR3ZXNjZxb0RSQzNVZTR1RForU01uMHhmUTYy?=
 =?utf-8?B?WGdBck9lZ1lNTzRyaWFCN29FUmpabS9EQjdWS3ovME5pZ2pMZzlxMUxxaldL?=
 =?utf-8?B?OCtwT2FOQnF0WDBTWDFRczNna2FKM3VRY1VydCt0V3JxdEZCWWlIUDhETlhN?=
 =?utf-8?B?cWtrL0lUVG02K05uL0xLM3l1L1ppbmRhczRhcjRqR2ZRc0IzYk9rVU1zK25r?=
 =?utf-8?B?TEU3citPOEpYbW01eWM1K0JKT2ZtK2l5ZkxRd0U1MlhyeU5kOHU4RVpGSWtE?=
 =?utf-8?B?YkxmeDVrVG9wWGZRRWcwWmwrc1JCN0VoWlI1WW50dUtKSjV4aDZGM1ZhbC83?=
 =?utf-8?B?bHVlaEV6bndtbHpPdkI2NmRQVlZWRktYVVR0Rlo2alBwbDJTeXdGT29jREl4?=
 =?utf-8?B?SW10NFQ1aVJPQjlFWUV3NjdpcFB0NkZ4MTJ1RktLbVl6RXczMmhZVG5WODZR?=
 =?utf-8?B?UEJZWCt4NTluUHZ6MXJWbGg4S0dXOW9SanpuaVlrTFFsTXMrT000MW41Vmx1?=
 =?utf-8?B?dmU4a0FtME8vcEgxejBvbnVaVERERmJ3bkgyVlY3YVJnU1lyU3I2SldZZVlY?=
 =?utf-8?B?MUlLSDZLWjRPaUM2MUxSMWx2bVM4U0JDbTYreHlWTm5iK1V2RmlPeUV6ZS9v?=
 =?utf-8?B?djk3S2lUZnVVVm40U0VkdWdNZE01UCtzSEUrbGJHTm53M2xqbGRobG1WeU4x?=
 =?utf-8?B?eVJQcC9tVElMUms5WDhZQXNKck9VQ0YwcTkrcVdzMlNOd0tKYUl6eEV1d2dU?=
 =?utf-8?B?aHdwOTRyaU1hR0luSGQ0SUNKdlRMdWxIT0JidE1Qa0w3RHRwR3dITUlqVEQ3?=
 =?utf-8?B?bW5TY3M3R1Q3T0tHdXg4N1ZveVdWMnMxd0J5UnhzRzZqaHkrcUFwZ0hWb3lZ?=
 =?utf-8?B?cjVnS0lMTGhPek85K2NqeTFRODBST2NZcmRpR3I4cFo3VEI4MFRFWDlwb1A1?=
 =?utf-8?B?VzJON0hTMzdNRjdVTVNnYnRYSEJzT0pZZ2VMUmNZcEtXSk0xenNrclA5Tksr?=
 =?utf-8?B?aWRFZFkwWXA0d3htK3RkMThXK2xiM0JnRjlXRzhCSERsZm1MYmhnQWpBeGtZ?=
 =?utf-8?B?YUZPeDUxTG1UV1AwVHBjRjJXYmprNVlpaDhxR0tqREJwNi9pQWc1OVJjUkdq?=
 =?utf-8?B?VEZJSjNMYVZta3pnQjR0eFNMZ0ZNNDdGL3RCSTdLbVdwVG5GUkdrdVZnQmlK?=
 =?utf-8?B?VlN2cVVaU1QxdUNWNktCSWowbXAya0w1QTNyaGpSRExtT0dVdkI5VkZwVGJz?=
 =?utf-8?B?U2hna0Y4L3ZXNzBHVmVUSkovYmI2bXhja0dCVEV0dnF3VjBvRlJUUWt1VjVP?=
 =?utf-8?B?bkI0T1dVQ01FWm1yRXBmelRpRlNwQmp3ZnpjSTNXNTdFWmVXQTB2ZmpqK0ZJ?=
 =?utf-8?B?cE1PaHRSbzdoY2dxSzdnMWJ2SnUwSVZ3dnJ6dk9vQno0RzZxR2NuNWExWng2?=
 =?utf-8?B?L3VkMlU4d3o1djNwWk9hd2MrRDZKQzBDd2VYdFUyOWllNmN3MU1zZzRnRTh2?=
 =?utf-8?B?dGtwRnpwNnpISmVjT2lIS3Z3YU14SUlWL2lxS0dDSnMyd2hMV0ZjUXJTRzJW?=
 =?utf-8?B?TTdoZGJpZTd3RGNCbWg2ME5OQ2RqRnVMb01NUUVTT3Z4U1JZR1diblJIY1p4?=
 =?utf-8?B?QUFFSjYrNDVVSmRRa3NncGJ2OVFmbmp3RDJrb3lnQXpuUGpaVkU0ZmMxSHBR?=
 =?utf-8?B?bDNzamM1VWFpOTVzaXVHQVk5Q0cvQiswZnlvMFZ0SVBZSVhJbjZ2S2Vkb0hm?=
 =?utf-8?B?bW5KMHlpWnBIcndPdlRBWkdieW1XVGN1eVB1TWJsc1Y3bHZDam5WVDlYbVpk?=
 =?utf-8?B?UVBnS1c4bFVHRWFUWG1TVmZpcEJJZnBrWEhOY3I5SURQZDN2dFEzMllhTmI0?=
 =?utf-8?B?a2xGaVJJdU9kY1pZS1p3SjI1NzNCYTgxeHp1TVdOL2Fab0dxQ1lLeUlkSmRO?=
 =?utf-8?B?ZGEyU3p1M3R6N21uQ0VHOVpjTHdqNXNoZVFaRGhsME95Rkg4VmRGSXZNR0cv?=
 =?utf-8?Q?izL7esCCMfAKW/0/eTnmtE+xz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39315f6c-a51f-4da4-7f0e-08dd509d43c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 04:24:13.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMdZmgNKJr2qCmW9hIdnM0NFBwe7o7brhMHfkKpMjHVbvREeUYX/H+3RQctmGq0u8aRcbL2aZepCvkwaIrWTVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8263
X-OriginatorOrg: intel.com

On 2025/2/19 03:27, Jason Gunthorpe wrote:
> On Tue, Feb 11, 2025 at 10:05:39PM -0800, Yi Liu wrote:
>> The current implementation stores group->pasid_array before the underlying
>> iommu driver has successfully set the new domain. This can lead to issues
>> where PRIs are received on the new domain before the attach operation is
>> completed. This patch swaps the order of operations to ensure that the
>> domain is set in the iommu driver before updating group->pasid_array.
> 
> I think I would drop this note in a comment since it is subtle and
> important..
> 
>> -	ret = xa_insert(&group->pasid_array, pasid, pasid_entry, GFP_KERNEL);
>> -	if (ret)
>> +	if (xa_load(&group->pasid_array, pasid)) {
>> +		ret = -EBUSY;
>>   		goto out_unlock;
>> +	}
> 
> Let's write it like this:
> 
> 	ret = xa_insert(&group->pasid_array, pasid, XA_ZERO_ENTRY, GFP_KERNEL);
> 	if (ret)
> 		goto out_unlock;
> 
> 	ret = __iommu_set_group_pasid(domain, group, pasid);
> 	if (ret) {
> 		xa_release(&group->pasid_array, pasid);
> 		goto out_unlock;
> 	}
> 
> 	/*
> 	 * The xa_insert() above reserved the memory, and the group->mutex is
> 	 * held, this cannot fail. The new domain cannot be visible until the
> 	 * operation succeeds as we cannot tolerate PRIs becoming concurrently
> 	 * queued and then failing attach.
> 	 */
> 	ret = xa_err(
> 		xa_store(&group->pasid_array, pasid, pasid_entry, GFP_KERNEL));
> 	WARN_ON(ret);
> 	ret = 0;

perhaps we can save the above line by WARN_ON(xa_is_err(xa_store())); :)

> 
>> @@ -3510,19 +3518,26 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
>>   	pasid_entry = iommu_make_pasid_entry(domain, handle);
>>   
>>   	mutex_lock(&group->mutex);
>> -	ret = xa_insert(&group->pasid_array,
>> -			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
>> -	if (ret)
>> +	if (xa_load(&group->pasid_array, IOMMU_NO_PASID)) {
>> +		ret = -EBUSY;
>>   		goto err_unlock;
>> +	}
> 
> Same here

yes.

-- 
Regards,
Yi Liu
