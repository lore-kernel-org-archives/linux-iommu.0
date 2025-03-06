Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3E19DF4D
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244698; cv=fail; b=CYmYwinXFFH42QRTr86j59xjfkK74GTI7ZUV+o+bEwn+Mz3N4nd2mxt2FB0B5qX/URPksZQEI5jY1h47w8bBfcbYDtC3nfenJn0pKzL5EMspVFxC5ucSOVYgAgFK36DUYco8kivXCdJ3VhR+u5j8iDmahmX8yPS0B0FLH/9MBhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244698; c=relaxed/simple;
	bh=vssigV86haZmyHCQyqBzHcEhXFIwqr56IHH0WI2360I=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zwl5KKCpVZr9lkA56FMt63yyDHqshJYv3/xp6nfgQw15TXkHa2cHKa7m4UThMGiqdngHHlnuYR4KCCLT7yfM9vzGoXt0eB8F4Ji6uHqzYaFNwZZ617MtOcD1ogACUyzCW5xG5+uEnL+ZUkdqUpeCpPIkdi8wCrBEdVNKc/Bm4G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSqXCRTI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSqXCRTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741244696; x=1772780696;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vssigV86haZmyHCQyqBzHcEhXFIwqr56IHH0WI2360I=;
  b=GSqXCRTI+jGLDA+3HUXkw7SaT8xMtqVrGirSeVEqdcgHKSMCkLRcyqll
   V8jIfZHaEBlYjQ3iBX6qAuN0/dTrSV4Ke6p6vYsYZo3E/XZzs9KA0BQz1
   jOYa1qjRO7TPRaVEqj9koKFFzg8x14DFtRS5p//qOaxlEovZSP3+ASaqG
   TeL1pq9dE7hJ/e1CZ5bxTbF82ml+y6Vo6F4ynjprC4yNjeMinUOplXoW0
   +w+1IxtP5KoIZw+l4BLUDks0CBtrwKThvkZ8qWbl7BDhDAF+2+jTK971/
   dC6If2nfXOG0m4i1Mh39ME0VwLrjh92T77/f11x5La7aaN9IZ3nGNUUef
   A==;
X-CSE-ConnectionGUID: 8wY4qLMpTZuig/oTjzYDOA==
X-CSE-MsgGUID: bWS/Bj79S2OAIaOxT5LPpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42127470"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42127470"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:04:56 -0800
X-CSE-ConnectionGUID: LvDkwuSLSGy6D/zbbg+ukA==
X-CSE-MsgGUID: c2tuWscpS0y8q8wgHQcvTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="123954337"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:04:56 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 23:04:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 23:04:55 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 23:04:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFDXZx/zGfY3qfmMeXaLtXMwIuuV3NF7VDEpbhaBq6LI4h2SWmgTtAZabJWu/AYdAwXZ3L7WybcLGysQ16wdankI1lo8o6R37Iq6amt845TIEG91DYbMTwfVbomx/bIziqP5qR+lvV1KU9I4PHbrBVWSK9iougGacp2rq0uQXKyb9rYXkQ2hUALxrtUtRV6xNXzOIITETnyn7LY2zwnbc6JXSbmK3py7OlTG9s0Vfemp/Zn9TVzSBSQvzCmOQAV6SlEbAE723Ou+wHZoEVsgdwZKomDSrG2qb9pcTEzjo7BkWa4CcznEEFjEUFM+Jh77XCcNyxBCFO5pK7yOnP8Gug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5Y/JwoS6ZLTju8ODMd7aGwhRX3EluR/Au6YrEJW1lQ=;
 b=LW3VT+TjL6Y73PZvypFxXIdG3hSqdfs6NPgEh/NGOiimjsuyktH6q5CWBD8KPX99ej5EO73tMet4i0/Da1wOwmYvfiDkIg1GDHub/rl/VJtAObHQD1E9Bo2ll8nc8AiA8Qm6cFVXsPBBXWzszbVjChYo1FGdL6bYAwN3KWGfOjLKg0eg3LwIurLhfVxXjodk7dTxkWOPWk4erzhjebkIH/Yq04uACGtaHHlRcws5kx9AAavRptY92eB1gDMO1G1rOGWSCMBFUNjGb56aJhQxqi4bfloSmf3U1tzopZh8OlWaKEh2+WSdYXUc5gRSxbPYV2aJ2rh2rqAjJ2kELEpxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7368.namprd11.prod.outlook.com (2603:10b6:208:420::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 07:04:08 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 07:04:08 +0000
Message-ID: <77fcb453-d88e-413e-8637-c61aa73be376@intel.com>
Date: Thu, 6 Mar 2025 15:09:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
From: Yi Liu <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250305130356.126424-1-yi.l.liu@intel.com>
 <20250305171838.GC133783@nvidia.com>
 <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d4da9e8a-e393-487d-ae4c-892fc139f2b3@intel.com>
Content-Language: en-US
In-Reply-To: <d4da9e8a-e393-487d-ae4c-892fc139f2b3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:820:f::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1c9671-49e9-4836-bd0a-08dd5c7d16fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3AvTkRBTVlYRE9QR2FRUGVDL2JXblI1QzZ6aFVmSlFIdDZkWCt5ZCt2V1V0?=
 =?utf-8?B?Um9IbVVtT2thSW0rNmwzdnQ4aEZiMnFXRFRWRHVxZlc3NVJiMXBVbEtRZS9M?=
 =?utf-8?B?eWFjU09HcjhVS2pRRG1LYUNOZEtBb1ExVlZReHdNcTF2SmliTWlGZkhpNUtz?=
 =?utf-8?B?VWNHR2UyaER6Wm5NSU9xSWFtbyswbFgzMlRpUTRNYVdWMENNNkI1blhwSmto?=
 =?utf-8?B?ZWRNSWZwWU53WkgvVW45aVJLOUlxbkpZRzJiNkNNKyt6RzQ4c3crRUpMUVZh?=
 =?utf-8?B?RUFVYmFKZG1CcisrU1cyR3BUcDR6T1dEbG1aeFBuYllGRXJSQkZUMmtSd0NH?=
 =?utf-8?B?Q2J5elBrV3VKUlJ5VUJZK1FHNnRhRFNJeFlMVzd0K1JrZEpNN2tiamJhaU1B?=
 =?utf-8?B?WU5Uc2hPREFNVW9jOHdjRFpxdTc0N1FleFpFL1lROVA1bXprS2V4Qkc4ZHlp?=
 =?utf-8?B?V2ZQYUdpRmV3VmFMNU5uTmlYRUExMGh3dWpsbkFTYTFPYjcydFBiV3hkcEdh?=
 =?utf-8?B?KzNyS1ZUcDNicitlS2N3WTRzcm9ZTXl1M1VQRVRuL1lUblFKUjdZaXhqL2JO?=
 =?utf-8?B?aXNyMUlEbExDYjNpWUJGYWo0QUNpeG1uSk1jTTFSR0YyeFZSYU1rNHNkYlcz?=
 =?utf-8?B?WlFtVDgvVWVaSFdmYmdEUFlyR0w3c1NRZk9nSm5ocVIySGdaSXRxTW9UOU9H?=
 =?utf-8?B?VFBwMWFCU25QS29xdm9kS3V3SW03N0ZFOXFvRzJNVEJ2bkVlWGpkOEc3NzlY?=
 =?utf-8?B?VHU2QTN3b2ZaRytxU0VUSUhXbFpieHNHMDhTWk9zNVo5TEVGL25GNkpwVFFv?=
 =?utf-8?B?VDZhc0FqUFMwVUM2NWlBc0xFZVhRQlRFZExCRWk0WGtvWSt3NGw3N3NLNHp5?=
 =?utf-8?B?Z2s2UFA3aFRKSDhLMHM0eTJHNjZCZU0vRUhTczZ5MTJrNkxGT2gvakt1MFRq?=
 =?utf-8?B?ek1tOEZRanNuUHMycnE2U2F0WmovWnBXOTh5aHRvTUFvczJOOGFVemZ4OHhN?=
 =?utf-8?B?UU94ZjBndzVaY3gza3l1UW4zYXlOa0w5TXlYdGVGVXpSMDg5Qm5tY0g2RmxF?=
 =?utf-8?B?YTEvMEEzRnNWOElTM25WbjBEL0FQaVg3RVA2eG9zSkNVaEYwUkxQamxMSllP?=
 =?utf-8?B?Y1dNRjlUempKOW1Oa3FMdjBpKzF6cDBuMTBjRGpmWXFNeE5YZnFkRVF1VGdq?=
 =?utf-8?B?Q1dEYWYrbi9IZC8rdG9Ibi9sQzRETUw5NzhFYlhtU3BCN1JzTks3SVFVOXRw?=
 =?utf-8?B?UFRjZ2piRnFzWUpUNVB5cTRYazFUUXFMc1pPdmg5MENWdnZFc1VFNE8zbXdM?=
 =?utf-8?B?dy9pcjVXWmQvMk9KeWhOL2U4ZWtjRXF0Mk11ZllHWUF2ZGNPN0NKcFlUZkNZ?=
 =?utf-8?B?VldSZVJkSGdYaGsxOXBFZy9oYTF2UHhHMytWa20zcWwxMVlBY3J4dC8xa00r?=
 =?utf-8?B?d05zZ0dpN0hKK2Vza3ZSS1NuRi9nVmk0WDEwTGxVc2hENXJzRW9pT1R3QlRQ?=
 =?utf-8?B?dlVxTWRuTXUrajQ0eEUvdmJSMldtam1IamFMRHNaYlZ6N0U2VVFOeHlyWkFj?=
 =?utf-8?B?ZTYwZWhPcGZrY0xLSTk4alVIT291LzNFWi9ORlNIbTgrTUtRcVhkTDdSTEVt?=
 =?utf-8?B?ZFJjRkdWWVdBdjhGV2VSREcyMEtpcEJhOEZ5VkIvWmdqRjdLcVBPbVB3UFhH?=
 =?utf-8?B?bkJ5THY4ekZzUWZqTHhqTkZmNHRHaUsweXdqdXNJaEFFVVF0QUdFYzlKVy80?=
 =?utf-8?B?dVpqeEFQK3dLNEZXNGtmdTBQdCtZcW9CZFlxZFNHRHY5TS9qV29OY1YrRFZM?=
 =?utf-8?B?MlVoT0JRQmJxclVlckxqZElZNlJGY1FoSkcvdkVzZjRsYXVMdDE4Z0xJZC82?=
 =?utf-8?Q?dLW2F5b1b4wYZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0Rsd1V0L1dyRW5IWk5sRXMzckszMXk2VGVDeXV0RlNzUkZsTHVpSkt6NE5s?=
 =?utf-8?B?YnFtaHpsajlGZmROa3VzZ3YvSHdjZFlqVzVSSVdGRU1ueS9jbmpBVHcxYWQv?=
 =?utf-8?B?WDM0RWdmQUt4MUpQcWU4NVN1YXdjMkQrc1VIMk91TTc0TXk3N3h4THVSTkdr?=
 =?utf-8?B?d1VQdnk3M0FVaGUrOFZsaGg1aU1iRHA5Mjg2VllxR2g2QzlDMEJJanR5Z2JB?=
 =?utf-8?B?UHJKRDB3MzRKR0tHRkxjVm5xZEJxTEo3bW8vTHlpVjM3VUUySFRxM1YwUmY3?=
 =?utf-8?B?L3d2TVUrWHpMeE9MT0FTcGVGY3plVG4yY281VWRqOExmMmRadHhYTnlQQjZh?=
 =?utf-8?B?ejJ4Sy9kK0NKbGxVZ25WVFhGQVZQRFFKT1pmSnVOMGZQaVJHNzg1OEpzSkt1?=
 =?utf-8?B?ZUNvNXR6YUNYM1Fid1RmU2xjZ1VSdlA1aUVvQlVZMFhsZ0FDb3lHVTFSL0Zp?=
 =?utf-8?B?Y1cxQm9yQXZwYmhvTFl4Qno3RXJXWXFsd0Z1VHdmR1hHenZ6N0tpZjBSSm1I?=
 =?utf-8?B?am1WYVFoYzlSS0ZtWTB3ZEdkWUpPRi95ZTZieUJ4MEF5YjFpbEtKdXJZOVNR?=
 =?utf-8?B?eit5MEFFc2Q4b0YwL09pZnRvekcyS1AyOS9GcnJTeFNwS2cvVWhxSm5xZ1R6?=
 =?utf-8?B?WlNlM2Z3ajhLMEVhNno3Z2lzZXVFejNnNVA3eHluNFk0L0twWFFQOVl4TkFa?=
 =?utf-8?B?Z0FjRXozenhKT3FjMVFkR0xyV3ZuYk4zQW9FNmJKL2N0WE5HSjdKdWNIaG80?=
 =?utf-8?B?N251R3AzQlRISDE2YnJUdEZMUys2eDNxVUx5bFNBakg1akN0bUV4c3gvcXJm?=
 =?utf-8?B?NWE1UVg4dFlqdmRqakRnUW0wVk9nYzlBWUd0OGk3UU1PVVdIclNvYlNuTjJy?=
 =?utf-8?B?MHNSQTNuQ0JJejV5b3hUc2dBV0FYTlgxOVd0SmhZRHBjT3hNeWdabFEvNjEv?=
 =?utf-8?B?Z21xcXVDYUpDM0o0T05jRnZaTFpSOXdRQ3dRdnpHcnFjSU4xVkhCSGJpMDZP?=
 =?utf-8?B?cU1MQXJyWFU0US94Ny9CN0tlTzNqN0R1dE5mK2hjN2NBZTFNU3cwbVhyK05F?=
 =?utf-8?B?ZTNZa0VhRitwRTdSVWU0N2Rha0ZvL2wxUHJiaHBBbWRtYUpLK213Wkw4WEw5?=
 =?utf-8?B?bWNJa3V5c1VEZVNoOURRREJRV2R1OGJoaXQ1OUdQSFRqbExYcGZRMDRPbXdW?=
 =?utf-8?B?U2h2L0xUR2FaenRvQVVway9ENFZTTWRKRHVBbkRPUm90WXhJZnV3VHhRR1ds?=
 =?utf-8?B?TE9sWjBsRkJpSFBHZnVnYTJwaWhjdWN1b0REd2x3eGJmMlJzVXpObXloeHY0?=
 =?utf-8?B?MDcrTzFCcEgyMXB5S0U4RVhUZng2QmtiVjJNN21GOHROTXZzeHpjZEVjbm1V?=
 =?utf-8?B?U0dNZFR4bkc2a0c0VHlOdkRBRE4yZ1lCTUxWMU92bWFmQUZnd2JtRGRLSjRI?=
 =?utf-8?B?OXplUkRsdWR2aDRrdE9XZGlndlM2K3Z1SG1RSUc3dTF6RVhnRm5mQitRcjFI?=
 =?utf-8?B?VURlUjFLaGlEYkdnajExVkw3SythS0VqdEFscDJxS2VZKzlyc3RRT3BoaUh4?=
 =?utf-8?B?OEI2MGFWNERXMEp3bGFoSTJXczhpY2QwbE1vM09Eblhaa2JiVDk3WE1zdy9z?=
 =?utf-8?B?VmlJMlphcDBkeFBYaXp5cnJqeml0Q1ZOOFE5UzlIcVFSaC9kbW5rcmdicWs1?=
 =?utf-8?B?VUp3ZUhOVCtUaXpTYUlBQkxrU3U5S08xU2dSa3BQdWl5SWdGVG54aGtLMWNK?=
 =?utf-8?B?VlowQWFKU0l1MzlqbmhXSENIR293dS9keGFUTVVwQWJPMmZIVk9HZUp2ZC8v?=
 =?utf-8?B?c29MWk0zTnpKT2E2Z0JuU1dTWEY5bHkrWUFkTVhwYkJPOVBSdUsrUFJLMmM4?=
 =?utf-8?B?NkN3TjhvTFE3L2hIUWpydFFEaG02Vi9KV3JsRlZPeXJrUTEyaFFwZE8zQ1ZO?=
 =?utf-8?B?TmxBQUhWdzBNRFJxU1JmbHlrcHBDa2FPaGoxRVhpQmQ1cGdYbHJZTlN2d3FK?=
 =?utf-8?B?SzdJb0w3bm13NUtmVEVtL2p5YkJ1bTZQVkt3YUZRb2Flc2pQeHlhREp4NGNH?=
 =?utf-8?B?b0VqZ3I1ZEg3YmVhcjNTcWhvVE5rUW9iNEtQOXQ2SjhrRmEzTFprYWhuREJX?=
 =?utf-8?Q?Z/8Utln/F5KsYsxiIRK7um0Ey?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1c9671-49e9-4836-bd0a-08dd5c7d16fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 07:04:08.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cux5zbOzLQ2apudZdj0lZZELHDratzvYD/ESv3WvrMwyyH9eTpIeF0B/BFAl3vsiJizGX2kdNLV9vR0msr5Edw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7368
X-OriginatorOrg: intel.com

On 2025/3/6 11:30, Yi Liu wrote:
> On 2025/3/6 11:10, Tian, Kevin wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: Thursday, March 6, 2025 1:19 AM
>>>
>>> On Wed, Mar 05, 2025 at 05:03:56AM -0800, Yi Liu wrote:
>>>> Hi Jason, Kevin, Baolu,
>>>>
>>>> This is more a query, the patch here does not really work as there
>>>> is locking issue. So I'd like to hear from you if any good idea.
>>>>
>>>> Detail as below:
>>>>
>>>> Existing code has a problem when the PRI happens on a device that has
>>>> alias. The PRI reporting path uses the idev stored in the handle. While
>>>> this idev is the first idev that attachs to the domain.  If the PRI
>>>> happens on devices other than the first attached device, then the idev
>>>> stored in handle does not match.
>>>
>>> Do you actually care about this? Can we say that devices that have
>>> aliases do not allow PRI?
> 
> It would be simpler if we can enforce it.

how about something like the below?

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index b4508423e13b..faefe06c212c 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -32,6 +32,8 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
  				 const struct bus_type *bus,
  				 struct notifier_block *nb);

+bool iommu_group_is_singular(struct iommu_group *group);
+
  struct iommu_attach_handle *iommu_attach_handle_get(struct iommu_group 
*group,
  						    ioasid_t pasid,
  						    unsigned int type);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0ee17893810f..7b24b49110c6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1040,6 +1040,18 @@ void *iommu_group_get_iommudata(struct iommu_group 
*group)
  }
  EXPORT_SYMBOL_GPL(iommu_group_get_iommudata);

+bool iommu_group_is_singular(struct iommu_group *group)
+{
+	bool res;
+
+	mutex_lock(&group->mutex);
+	res = list_count_nodes(&group->devices) == 1;
+	mutex_unlock(&group->mutex);
+
+	return res;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_group_is_singular, "IOMMUFD_INTERNAL");
+
  /**
   * iommu_group_set_iommudata - set iommu_data for a group
   * @group: the group
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 92dc1ca010dc..6a1ca3874806 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -591,6 +591,9 @@ int iommufd_hw_pagetable_attach(struct 
iommufd_hw_pagetable *hwpt,
  	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
  	int rc;

+	if (hwpt->fault && !iommu_group_is_singular(idev->igroup->group))
+		return -EOPNOTSUPP;
+
  	mutex_lock(&idev->igroup->lock);

  	if (idev->igroup->hwpt != NULL && idev->igroup->hwpt != hwpt) {
@@ -720,6 +723,9 @@ iommufd_device_do_replace(struct iommufd_device *idev,
  	unsigned int num_devices;
  	int rc;

+	if (hwpt->fault && !iommu_group_is_singular(idev->igroup->group))
+		return -EOPNOTSUPP;
+
  	mutex_lock(&idev->igroup->lock);

  	if (igroup->hwpt == NULL) {
diff --git a/drivers/iommu/iommufd/hw_pagetable.c 
b/drivers/iommu/iommufd/hw_pagetable.c
index 268315b1d8bc..bd2bab5a3b86 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -405,6 +405,11 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
  	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
  		struct iommufd_fault *fault;

+		if (!iommu_group_is_singular(idev->igroup->group)) {
+			rc = -EOPNOTSUPP;
+			goto out_hwpt;
+		}
+
  		fault = iommufd_get_fault(ucmd, cmd->fault_id);
  		if (IS_ERR(fault)) {
  			rc = PTR_ERR(fault);

-- 
Regards,
Yi Liu
