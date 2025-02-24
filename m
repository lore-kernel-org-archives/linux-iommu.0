Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F182A1CA
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740371624; cv=fail; b=HzgUTGZwmKuVDTK/EqKvob5kw/AjBeh8Izu+10LOebxR1ZlAFG79PN346Ke+td3nLWjTBsEW1jtcspUvEdGtCP4Irg+pqoLfdASJmxLR5rx+Mc/1Z7HIJ30fb7jV8kiI9+FYMyF2tDsEEkvMLxEE0DB5zqudJj5tJHIXuO5/QRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740371624; c=relaxed/simple;
	bh=N+mqJP2qBQbvC0r0/ibp9jjPJpsYoUIWfJc5A2g1xWE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CYT+7nEl1yo6SkLWGoYYgavQUACIiq1zhw6IW0cjY4jJVbn01TPbMYSRrbiYQxd7bBFyE13mPbLtG/tR5ajbAb/hdTLj2zfTRTXj//+MCnC2Y3JScWZWBXhV6z4wVtgG9D8hs8OFDxg+w83EuCXEt5RgotZRTxmb8Xvgl7++zBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqZxighg; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqZxighg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740371622; x=1771907622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N+mqJP2qBQbvC0r0/ibp9jjPJpsYoUIWfJc5A2g1xWE=;
  b=DqZxighgLjTcD7NZ/tSKKjRqi2RHwNVAlJLVLTKJYfAif+1vK+RJObjY
   RJN3YVQ1bnI+ToJdCph6irvXFej9qIPMjRHlNTJMaZ2cqdZvhEV5FYmGM
   8vIcYkr6lHZTwrLixuHU+VHQNY6rpFyRyd+He7+lX02NEVTzFR1qKjTA6
   qsWc6Mwma7M7PA4y2NnoQ1vnFd86CRezSZ1fnl3EZDHyAGElVtcBZwDMW
   Syc9KgGXwgWLklRw5HFbeHaHtR77yjCVP+TlH2JKrEBrPzGu7XxUuF+wB
   acDKJBoOy1+EWRP3k0+Uo51X0XJW6fiSWdDJ/8ahF8/oqRq7CL845KX3i
   w==;
X-CSE-ConnectionGUID: 7u+ldMRFQtWrZ6OJp4AQug==
X-CSE-MsgGUID: W+LZsl5UToK1gdlQkXRzoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40962254"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40962254"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 20:33:42 -0800
X-CSE-ConnectionGUID: hyi5obvAQeO6MM2PtoY4Ww==
X-CSE-MsgGUID: KdVDdL+NR3e+xN1cdXAI4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120862885"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2025 20:33:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 23 Feb 2025 20:33:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 23 Feb 2025 20:33:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 23 Feb 2025 20:33:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEhjyYpQ4BDkIHM1rHQ5rmBm1LeDNmM3d3MlYE4/bAnqgBGkOqInm2byg2cbfVuTwecwFrxmHX/F007XOSMEgm+4GChVCNq53d6KC8l37FtXTNHBlcXgpLyWWdSiViELTbEGROa1JUD8GjLMTi+HNgadQfAMeOm937A/jgJvtMoeTVclp4k+2tjAuGNVYnAtKV+dh2lqVR/XTP8PymLudFgNXrcFHwwZJ0+qsWzzmpTwk+Jfmp4C5IYaoaVcmg2eIWTaPl9fnxBb9w9QEGRwsTi9CbeA8rSyyBFaXINBw9iOVNEmDfY8Ve/tdzW45hJ2EqjLh7BT498Ft5fqbD8FzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26qhgnXFwnmlSI0bzBP+BxqhMLIeWik0ZNZvynJ0HF0=;
 b=Ezlp/AwMNs9bX3KfNzQT5kTuf/TqunBLBleD8/y950RcpWGiJcgSd6XE8C+y1F8BD7710FchcqfFmKcKzZ9p8ALaOcgECEEUl5tjgXbCFgNsz8NPoWoVJYLgrIyGwlzaGQ9aGnSUW9sj1fceWrf+zxK+z4I2v0z4kwYxcuXPRxptHYe58++kb5ANB5GLs8WupCM3WHFaj8ENxohgplvcqYwMGgslZIkxAAmT2bZqUtvPRLm2tL73K2gNpZqSfm2Cg7uonImPmjZpNwIK4Nhyfx+UIKKi6JnOLwMlh2NwqBuDSfTvqvOk6pByrB0G4tOXybY+yP82QzO1tSS7dNy1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ1PR11MB6178.namprd11.prod.outlook.com (2603:10b6:a03:45b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 04:33:28 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 04:33:28 +0000
Message-ID: <c71cb2bc-e1f0-4d42-a695-026a996e8f6e@intel.com>
Date: Mon, 24 Feb 2025 12:38:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Swap the order of setting
 group->pasid_array and calling attach op of iommu drivers
To: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<iommu@lists.linux.dev>, <robin.murphy@arm.com>, <will@kernel.org>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-5-yi.l.liu@intel.com> <Z7i3dvyA/opurciP@Asurada-Nvidia>
 <ceb475fa-dfdf-4bcb-a4ba-8128ba86a39a@intel.com>
 <9ad4766e-e37b-4310-acec-dc8eb91dde64@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <9ad4766e-e37b-4310-acec-dc8eb91dde64@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ1PR11MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 77276830-53ff-4058-213f-08dd548c6236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0VHandzUG92eFAwK1RBYVFYZGFLeTdCTFJYMzhkTzZvWVJ1UHhydEdHUlhG?=
 =?utf-8?B?elpsaEJnaHdNN3QxOXZDM2FNWVNwdmV0ZVBOc0ZHZUdDYW9ibDRHUkNUTDkv?=
 =?utf-8?B?WE5CWm11VnYwZmY5VlJpd3pBS2ZVd0tiSWNvSDJHanlXYWdoNGJySDBMU21Z?=
 =?utf-8?B?ZWpncElpY25OYkR0d0M0RXEwb1dJZWtzVlVqNTFUc3BMRU4ySVAyaDQzZ1c3?=
 =?utf-8?B?TlJVL09qSVM1TysrN2FUb3NldjJvTm5aTWtpazdQS1VrcFR1dW0rbHJqVWd1?=
 =?utf-8?B?clRFN0p5U1RhVlVYL0hxdEx2WUNiVVcrK0tuMERyVkpQNXFFREZsVGZoeDls?=
 =?utf-8?B?RFdhSElSeUVaaWc4VnBxd25tVHVKTmJIYVpwMS83cUJtS0lWMFZNMjV5T1pC?=
 =?utf-8?B?bGppTFNST0RiWDZscEZkNitzaGliTzREZjQvVXUzRTVoWFI3T0hEcUdBejBQ?=
 =?utf-8?B?QzFyK3hwUGVUREY4bFRlaDdqdHV4M3NHL01kZUo1U2xDdXVQQS9Ta0VCcytH?=
 =?utf-8?B?a3QzT1pyR3M2Y2ZzR1Zic215QTFackZ6WUU2TjhRREw4dzVkdG5DWXJGRHIz?=
 =?utf-8?B?NXhYdDVKQjVqWFNibFpadHE5ZzVocTIrUy82aC9UMTkyRURwU1J0dE9CTGFX?=
 =?utf-8?B?ZjBpZC9hN1l1ZXFBdUQyRnlHTnM4S3YvZHpML1Y3eG10SEpCSFdaaGluRUNO?=
 =?utf-8?B?RzdyZ3dKZUJVOXI3SzNXbEtraHp3NFlzQWlSejZ1c0tiekczb05kbnhpTTBE?=
 =?utf-8?B?eG1YRFNHYXQxNmVHNm1Oek11TU1FamVBb3A2ZFozUWRJS3JyaUtYR09lSXBl?=
 =?utf-8?B?ODRFUE8ra1dhT3ljY0RhUjJmQUd3c3k0YjIwMDcwWGxJVmMzY3pNb3hpZk1s?=
 =?utf-8?B?RkkveTlOU0Fyb3hxSFUzVE5WdENaN2pmWWJWcTd4WkNEUi9zZ2N0UFlnaXNy?=
 =?utf-8?B?aU5uY0ZCNHNzUGc2Tnp5ZmtGaExCWGdvWEFTMmxueHdjb20yZ0o0NGE5ZnpT?=
 =?utf-8?B?dXlyYjdpSmNyZitIOUNzTjJ2bVRuaVZjZGpkNUQzOTBxSzAyOXFtakU3OEhh?=
 =?utf-8?B?Ky9ZeFd1UWFJbGxGOC80WnVGWFN4b1ZXbGVuTEt3YUFUT09ETjhSTFZkTkRa?=
 =?utf-8?B?L3Q5b2tVUUlEU2Nha1NUVTNaYkg2VERkLzRxS1dsUnphUExhSjBGOGNrUEhG?=
 =?utf-8?B?QmpGT1RqV3B5NlhIaElVUW5wTUhrVTF4cXhrdkdNWmU1TTF0QUN1cVFFT2Nt?=
 =?utf-8?B?UzlDTDJhK2JMNVROTnhFRC9Mb3M0TVNob1IreUR5cUVla2t3RCtxenEvVFcy?=
 =?utf-8?B?SkZFUEsrWThvOE1sT2dPVWhXdW5KNFRzNm9wWmhURTlVeC8yYjA4MHZudXZH?=
 =?utf-8?B?ckFLRDdmVldGaVFxNm4vYzFscVB4S1lBOExVWEFKVCsvWWt4NGRCTFRsZzFX?=
 =?utf-8?B?dXlpamh2b3BuRldVSVB6QUlybUtZUHlYZmZRRytvNTBqam53b1FMV09ucmd0?=
 =?utf-8?B?emJBcUJjNEhMMk1OdGZveStMc2k2eitlTTc5YjhuZTlIMklTM0ZrREpqV1RN?=
 =?utf-8?B?UFl0aGVhK0xJWTRlb3NLdW1vODRUdktTRWxlUVZYd0ltRlVLWldCVEI2V1BU?=
 =?utf-8?B?VCtqL1hqbzN2TXNpbVR6blVuYTNqaUV0ZXRER2loaDJGdWgzNWRWMkxZYWVZ?=
 =?utf-8?B?KzNvWnZpalkrSUk4R0p5czlEU3Ywa0svMGM4bE0yN0todXdMZW9mWERrTndq?=
 =?utf-8?B?OVlwZ1hnbGZlZW1nWXRlRDFwOE90cEhSczBXZWhESnhmRG9ST3pJdDkwcGI4?=
 =?utf-8?B?eXpvSjAxa1VSZStZL0VYWEdkV1U4cEQ1dDUrU0JOWlU5VmJPNm55RlNhY3hn?=
 =?utf-8?Q?N48Uvwgjyrxyr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUlNaXFINU9EcXFHaGxCRW1vRmZZbmJPdTV6SWZCM2tqczUxNW9ZRDVRcUNP?=
 =?utf-8?B?WEc3SER6OUZMeG8vY3VZbWxLdVl3UkZFcW0xZzlzcjVxazIvazJ6NDRhRnZn?=
 =?utf-8?B?T0RBUWd5VVhJajBySzVIYklubTdBWFdzcG5zU296UUdCYllnM1Q5V2pTU21G?=
 =?utf-8?B?L0dzTTdXdmlFYndwd2NPSXZyb053UFNuR3g3cHAvZTdBQVpXblppcGwyaTN1?=
 =?utf-8?B?a3RhelIxSVh4ZlNrVGV1YUhsVGhmLzYrVUFGdnZtNU96VzVpRmZFbHZTOGlM?=
 =?utf-8?B?cDdBZjRBVGJzYWluMUJPVUtwalUwZE1FRnlWaVBGeE56T2ZwMDB3MERDeklo?=
 =?utf-8?B?NDBseXVrSjIrZTRJTndRV1FYOGVSaVdYK3I3YWJ4YTg5enBodlJ6L2FTdWQr?=
 =?utf-8?B?U0h4TUdtNkFub08wckFLZ3Mzbk53Zm5mclhBU3NzSFFIdFZCK3dpU0NtY1ps?=
 =?utf-8?B?RXBKTWZLQm93UDlSTHFEMXFVc0NTZy9la3VkWDVGK1NOR2ZVNUVtQjZkRnZL?=
 =?utf-8?B?ZExtS0Y4OXh3NWd1eDZuM3lWaGV0aUVXRW0xZ1g5ajh4a1JGTFVZTlJIbUQ0?=
 =?utf-8?B?T3RIRVhuWmhkRzMyUHBvZHpGUnhNNElzcFFadnpTNzUzM1AvdzdCb3IwUWRW?=
 =?utf-8?B?M1NBL0k0ZlhONm92c21INmpNeUZJamRJSDI1dE1vLzBUQmlINXR5dDVyanNx?=
 =?utf-8?B?VTg4M2lkYzJKWERpTXBlYlVoOXMrckZ3RVJET1FlSXAyNjRURWxmNi83Wkc1?=
 =?utf-8?B?L0tGS3hWUmdkcnEwbHNPTm9sbXBpazlnREpFRDhacDBWOG9xODBKektoRDVw?=
 =?utf-8?B?OEZicWJ5eGc5VjBCQ0VTWlJVRnZya0NhVUlSejZlYm9VZjRDYS9QRGxiQ0xp?=
 =?utf-8?B?VjhHRHIyME1VbXZFQ1ZXQVo3ZFFYS1lmeUxqWHJZY3BOWG5sbFdqVGorTlJQ?=
 =?utf-8?B?Ty9oUytCZEdvYUNjYXlNWlhDUlZFeE1FRTNyYm5JWTNTUUZUTldERFFSMXZh?=
 =?utf-8?B?RDFIUkQwTFJ1cXhadWw4WUY4Z2hZbHZydDhIUFNVM3VKcndMTm03VjdxYW5R?=
 =?utf-8?B?OGhFNWpmZTg1Q3dSd2Z3L0s2eGFzWTM1ZUc1QytncjRUa0w3bzRGR0xIQnJY?=
 =?utf-8?B?V1BobFZRNWM2amFjRUhQZjBvL1hmZnBGWDhHRy9vc1dDMVJaVGJTNkhLN2Ix?=
 =?utf-8?B?SkRFYksyWVRRUFJXS3hqUGx5YXZ6aHdTYUR3VnNTQ2IrYkRjUGJaNGt2bFpS?=
 =?utf-8?B?OUQxSVQ0YmhMVUpuVnNmUG01ajZrVEJPOFQzc01NY0QrRDlYdUxpZTNwMnVW?=
 =?utf-8?B?d3Y0VHA2UWtkNGNTMmthLzBvS1R1RVBaMVdiVTV1Q1I4SDRnUlg4ZEx3cUgw?=
 =?utf-8?B?YUw5ZUQzNXdySzEvUmJDZTFwL2dELzZLODVERUYwTjRxRUYreFdmZjFSdGxi?=
 =?utf-8?B?Y0g2VUNZSHdiTkVxZHA5anJsV1BUZHVRMjJGSTU0YjJlcEt5aytWaE5nZ0lk?=
 =?utf-8?B?UXNYekhnNWdTazRLczVxdVE0WnpaR1JleXI1TXN1aHphS21MMk43VHo5WGZR?=
 =?utf-8?B?a1RIbHZzVi9lMThYelIwN1E5bDBzZWE4K01HR2w5U1dpSldKRHJyYWpjNnQy?=
 =?utf-8?B?ZkdwQlpvRkhzQWNRcE43T1E1bnN5VjlhR3RUcnBtRytLY2RIUXZ6MjhHRGVI?=
 =?utf-8?B?WkFFaXFyNVdnTC9BcHR2aGZteVczakdpQzRrVmF1bHp6UTZ5U0ZZVVVWdHMw?=
 =?utf-8?B?WVdBbkg0TTMzMXN5Wml6UHliSC9sQjR0MHRwckNaSHJZY1pmcmtqa0l4SURq?=
 =?utf-8?B?akZGbnZBTUVoZTN6T2UraUpKMHlia2Mxb3ozdCtRc09WMytUa2ZoT0ZFWmhG?=
 =?utf-8?B?Zk40ZFZqQ1hQeUpyY25WMjhVblhqMDNzWVB5bkdUcUhOcVJLcFYyRW15UGFx?=
 =?utf-8?B?a3JJQm8vNFZtNHdWN0hKTk9Wa0JreGp2a2NPUGl2c2trYWZYT1UzZkhaeXdI?=
 =?utf-8?B?NTNPTlh3T0xQVm5kVjdCcGlCNFI3S3JUdHVGdmNjRjc4SG1VdjA4bE5CcStR?=
 =?utf-8?B?cHo0T0Y4cGZnQVMvWjUzYW1HNGdOZVkvREJpVm1vZkVPMXovbE5nR3ZCckps?=
 =?utf-8?Q?n9n0zfZpTZOHl1FyNEQZLJqPc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77276830-53ff-4058-213f-08dd548c6236
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 04:33:27.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fzynwnwH3fYfvaWOmXZDw+1sLghtKXO0EGFRqCIRLa3X5haqa884osrmNc0/uw/yAsL4VAqkU72VeiRtoOBag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6178
X-OriginatorOrg: intel.com

On 2025/2/23 21:32, Baolu Lu wrote:
> On 2025/2/22 9:59, Yi Liu wrote:
>> On 2025/2/22 01:27, Nicolin Chen wrote:
>>> On Fri, Feb 21, 2025 at 06:33:35AM -0800, Yi Liu wrote:
>>>> The current implementation stores entry to the group->pasid_array before
>>>> the underlying iommu driver has successfully set the new domain. This can
>>>> lead to issues where PRIs are received on the new domain before the attach
>>>> operation is completed.
>>>>
>>>> This patch swaps the order of operations to ensure that the domain is set
>>>> in the underlying iommu driver before updating the group->pasid_array.
>>>>
>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>
>>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> A nit:
>>>
>>>> ---
>>>>   drivers/iommu/iommu.c | 44 +++++++++++++++++++++++++++++++------------
>>>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index eff5f678883b..73555e1cf016 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -3388,13 +3388,25 @@ int iommu_attach_device_pasid(struct 
>>>> iommu_domain *domain,
>>>>       entry = iommu_make_pasid_array_entry(domain, handle);
>>>> -    ret = xa_insert(&group->pasid_array, pasid, entry, GFP_KERNEL);
>>>> +    ret = xa_insert(&group->pasid_array, pasid, XA_ZERO_ENTRY, 
>>>> GFP_KERNEL);
>>>
>>> Maybe xa_reserve() pairing xa_release()? Same thing though..
>>
>> there is slight difference. xa_reserve() will return 0 if there is already
>> a valid entry. xa_insert() shall fail with EBUSY. We want to catch such
>> failures here. You may notice that the replace function uses xa_reserve()
>> as it intend to replace existing entry.
> 
> Do you mind adding some comments around the code explaining why
> xa_insert() is used instead of xa_reserve() here? This will make the
> code easier to understand without needing to refer to this discussion.

hmmm. do you think it is enough when referring to the kdoc of xa_insert()?
It notes it acts just like xa_reserve() when no stored or reserved entry.
It fails if there is another present entry, and this suits the need here
since it does not intend to replace existing entry.


   * Inserting a NULL entry will store a reserved entry (like xa_reserve())
   * if no entry is present.  Inserting will fail if a reserved entry is
   * present, even though loading from this index will return NULL.

   * Return: 0 if the store succeeded.  -EBUSY if another entry was present.
   * -ENOMEM if memory could not be allocated.

-- 
Regards,
Yi Liu
