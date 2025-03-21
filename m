Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3A1DE88A
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521107; cv=fail; b=txSXOWO2aqYXeyqx87czmIilzPFfR86YOI35ViRVW/QdXtxok4aiObdWxyyZoZFNXoNHDLZdSnyD2tRTmZg2REmWsUHNNuAiyOie99aoxjOCifD8aZ/pIa6jtc4EavKfa+lq09bMUhIhMgT4fA774ppqwW7VpYx2QmpV1u4EB/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521107; c=relaxed/simple;
	bh=qKsxVIq+AcJcDGfVeOj6yDwLMi08VQ557elW+SZCD1k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bVPtGFJJHP80FAzT9fwdF+8dkUPWZvul2KlWkSVybv4CKrENvBdNwpt8+ZCcW0fKXw3W/1YkOEkwghODo2weJkgC+CCO7R9EC/T37leRMw8WwGe9Ykch9evukFxH2PbrtIva718dWg/D3Yn9LrzKRTAUEE9yn5ed9+VFYs2HH3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGCvwITm; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGCvwITm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742521105; x=1774057105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qKsxVIq+AcJcDGfVeOj6yDwLMi08VQ557elW+SZCD1k=;
  b=LGCvwITmLnRxk2nyKmh0EvduZBOsbs8RkjPVd5g7d0flV5P+s9rF21Vf
   KS58LE6lyH3h4l/ScNv7OeYFjcX01H92ivsc8vqxZYQv5yvoK0R/p7OcU
   6hZc8DvSI2m1uJg3kAD8kcH6jzVYi/Bp4alkG5QXfSec8eb49qGpmmaki
   SEYSVzS5FfqOBSSgsJzfPKsk0ql3KnBYo/aL7L91Lz5K2pf4r7w4oHXh0
   DdPtLKYWKzdg/6H0d0k1jQTwXh9cu7UdJ83yQtjvlgsZrztVELYCj6AXr
   OxoqdHITG/4fSJc1ePsaNq4DPNe7puJOBDp5r1IihO4KHqCLzsVStB02k
   w==;
X-CSE-ConnectionGUID: 2c1a52TCTt2TAcMium7Xyw==
X-CSE-MsgGUID: N+95vi2ARFWgRuWnjiSSCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54413486"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54413486"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:38:24 -0700
X-CSE-ConnectionGUID: yQIj/u+FSpenuSuFPTEisg==
X-CSE-MsgGUID: l8+hiDfZTXylALS9Ki48UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="128486477"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:38:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 18:38:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 18:38:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 18:38:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsDHVBfk6AGnQpLAKfDqAhCfJk5pbKXlUgL18XkvBl3O34+apSusD7drI5IXbK08gG+M2rUrW1HEwMkTcf5bAobzqDepEz4dtXHrgGe/oOHqUapla/yV/MSFqhSUxuHejyymT+Q72p4hWJEaKa4lxcyMHo8yWnjJ0gIH/szlNWNTmJ131G9LMk97gNrf5YV27CWLMeQoFnC5eKZWNT7aBXs62qTxVflvIZvrWFyp18XkXVh3LTlu4t/mG129DsGTlhPtZbttEO1gA9WLCxmGkTPHnA0vnzXGFqe7HSnt43QERcZfhjJ24RWABmw3Q6dpcSy+CcBWfvK03hN6XUjdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjIvBThnhEuRl4yXl4XYdwrIGyoR9TLr8d7s8RaG18I=;
 b=hMHNhiF9ti3PB3SD+KcBbX3+GZRTCcefh8cFFxmp4KQzf7Cp5i2S1hVgKUWYSoEGzeeuhTBqWyoV7jzwMKFsEjjIaOCKD1k+hK495k02cxY0UeKt7Yf47rI7g390HMkaPhrNUXjMM1xPdB/Ct8i/lAUQ9lpIA37Q+S0WmipyqInqHCx7pXUTiKzmIJ0Eqii+mIDgCedxRhk1rCAxHu+9Rwqd8tggI+tzoR5OM2XCmLsFhhNXvWdKKdeV3UDPCJx6uQL4JwdOHq7l8dZ+3ZMOm+fLmcso9zIhNwr6mI5NE6HX0iAbA4H1siW/0j8IkPOk/FNrxVG+yAZJBSf/ALqMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6512.namprd11.prod.outlook.com (2603:10b6:930:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 01:38:20 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 01:38:20 +0000
Message-ID: <d9d9b35b-0c28-4562-88ba-dad9118fd3ea@intel.com>
Date: Fri, 21 Mar 2025 09:43:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 17/18] iommufd/selftest: Add test ops to test pasid
 attach/detach
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-18-yi.l.liu@intel.com> <Z9yiIEaWyMGyyc2A@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z9yiIEaWyMGyyc2A@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4b34eb-c5b3-45ab-79c3-08dd68190f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXlIL3RsVUJiQXdhUTdJMUtzZWNPbDZYU1RXOFZHdnpmQVVDbTRXakhqWThJ?=
 =?utf-8?B?clZCb0xGWWhPTzRZbGl4RS9sOUpWUnRUTVZmK2I2RGg0UUtEOXh4STZCcTBU?=
 =?utf-8?B?LzJneU1oeXVyZGIwNGpQQTJVNElOemVYRzhFUWdvR2V3cmhpaXVaeG84OG43?=
 =?utf-8?B?KzVoU1BROXlsT0lNWVFhcXF0N1M4RW5yMWR3MlRHL0UwOGxGbUlSQ0Mzam15?=
 =?utf-8?B?d284UGVSQ1VmalEzRkVTeUdnRk9UbFNOc2VkZ2MwUWF6Y1N5b1d6WG1NSWw0?=
 =?utf-8?B?OGkzQTMwS3ptSTlTTG5Jc3pBMU1XWVFYMjhIVjRvaG5POFdwSHBHcElabkFr?=
 =?utf-8?B?UC9hZUxsbGl2VlBaWjA1RDkwUytjbytQL2YzZ25mN1BVMWFRV2s0d3ZmYk5S?=
 =?utf-8?B?aWZ3N1lvbHdCSFo3YktydCtzS2pxVjhUYzhCQk1odzlhcDhBaVF4SGQyd0dC?=
 =?utf-8?B?ams1SU9KMVVJMHlteS9xZGZLdS9yR2t5Y1E0MmxmUkFDdC9Kd0dhaW9ncVAv?=
 =?utf-8?B?bnR5RWFTWjVSRTJvenpFRHlwQjZWejRvdUl1WjFsSDJhVjE0WmNmMm9EUkUv?=
 =?utf-8?B?emdSeGZPQnpGZ3AySG9wWSt5VzlUbHloSmlaSHc2VC8yajZDdzZDWWxkaVNO?=
 =?utf-8?B?eDFmKzJvak5WWUZ0WUFQcFltQTIrVkxpNjVMZFFFNlp5bDltZG52enZVcEVB?=
 =?utf-8?B?TUwzdi9BemJHWWVIMHI2SzZGZFZmb0UyTmVPS3dMZGszaFJySFhmNlpjRjZO?=
 =?utf-8?B?VmRTVUFZTlVmUWlsYzVBOVIyOFFvS0UzM09xTW90RjhkQ3ZJRWhwalkwZnk0?=
 =?utf-8?B?WGpPYXY2L3lBYUJMSEY5ZVJ1azhXd09ROURuOWdGTWl2c2YwK3cyajEvSkVx?=
 =?utf-8?B?elRKRndlMmV5MG93aFZpMGdJMkRGL2Q2aXpwUFVVaTFaQkZYZ0ZQcGhkOGFh?=
 =?utf-8?B?UEpraW1wMDIzcE9KQVNRUTg1c1RKeEQ5cVJNQ2J5ZTR0TmZjZ1ZQeWJBNnNZ?=
 =?utf-8?B?ZVB1YVFBZ0pRSjhQeTRXTUZibmVtVWFFd2toeVF6UmZTTWhwckNhQUgvNlI5?=
 =?utf-8?B?R1A1T2dqOXExUzhFMDdvMFZzMG9HNFFWYkszb3lWeHh5dkNnYyt6bVZiekpk?=
 =?utf-8?B?MVo4QU1PVVQrbGptcHcwa0hhU1VyU05UeGJFT2Jkd3ZiQXUwczRRQWxOZGND?=
 =?utf-8?B?djZVZmIyVGpkOUd3RkQyUGN6R1M0MlhVcnU0cG1FTzB5cnU3eWZCMFQ1Q01I?=
 =?utf-8?B?VUFHZGhkcEcxZmRvb2Q2NTV0NG9LM3JPMngxdzhTc1NZWCtoT2o5SmlqUEk3?=
 =?utf-8?B?VTZYc2ErZU8rUFVWTTNLeUVibUtkZEZHckhuemdVNWpUcDFTa2U1UmdkUk53?=
 =?utf-8?B?RjdzeDdSUXRpKzJVbWM4cmN5UE9CT3FEbkpRenpaY2dkZnNaWm1XSm9iWm1o?=
 =?utf-8?B?Nnp5YW1LZDJMdmRaeDMzL2w2SVl4MTI3Q1NhUm4rTmZkVVZBRUo1cXhwQmta?=
 =?utf-8?B?bFYwOXhSa0JHd1ZTWUt4K3l4QTlid1FDYy9COFQzSU9VR1NCU2xQa0UrL2Ri?=
 =?utf-8?B?TTlabnV4cFRTMzlxbitNamFYaEhtaEZaOTVHSGNjQkVZYytXdzVncGVSVGdh?=
 =?utf-8?B?SUZaTGJVRHlTS0NXVXVhNlo3NGRMZlhFN3ZDdkVIR1AweE5GTVYydElPUWM4?=
 =?utf-8?B?M3N1b2tBZnhVWStxZTlhQm1CQ2p0TlJwWVB4OWpoZWNjNjh3Uy9Eeks3eGcv?=
 =?utf-8?B?RVBIekFmc04rZEVTdi93Q1BKU25xQ1FSd1FCdUNDb2VRRG9wVUJRdTQ4VnFy?=
 =?utf-8?B?UExqVWFkQUFRNnRSM0dzZVp1TjQ1WDNGUXFrRy94bW1GeHp6MnlQUnYvODBI?=
 =?utf-8?Q?tYKgXM+U/9duT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHB6RTl1bGx2WWhkZERIVFBPRHgvZXVoeEVDbnhKZ09hcERHYVkwTFFxeUZF?=
 =?utf-8?B?VzR6RnlBOWVKakNWZ01FK1RPc1cveWZzSFZxYlhjUTVEUXB0SDhHWlFNV0tL?=
 =?utf-8?B?OVNSR04rR2hkZmE5SHdNTWxBM0h0emtXa1FMcGp1RVZyVTFFKytEQTRhb3hp?=
 =?utf-8?B?RzJmbmR4dVlvWnZWYlVSTndrYUx1SGVnSDZLcTVJUGt2b2VSVE12bFkxd1Rs?=
 =?utf-8?B?V2dxcGtlaWlWVG9SRG5RcXVUbEFPQmFSNjBYSHdWSXZvcTI0NDUwbDVrckdp?=
 =?utf-8?B?bmpmZ1FsVXVWQ1gxenFCaDdzelpSVExjRUNIaWpJWkZyYmd0bHRkanJnMmNL?=
 =?utf-8?B?RTBkV0s4dEJuYWgveno3OXVMeFVzSVU4cllFVjhESUFhdkxKVlRoWUtwaW9R?=
 =?utf-8?B?UUx4YldtdmFjZDdPY2NhREZ6UlUwemtMMVl0R3dhVjBWekNjZWh6MzN5cTZ4?=
 =?utf-8?B?SHlTbHBhRnl4UWIvWm9IZTFIV3pZZUtsSytVZ3VnTVo0NXhTZnBEb3ZkaVlR?=
 =?utf-8?B?L1hWaEZ3NGlPSjBjclY4d0dUZWVncjJEQkJnMGJOMVJQeXB1Qjg2UGxsTkV5?=
 =?utf-8?B?TWt6MFZhKzF1TXl6MVIzTEdocnhuTzVSSXQ2STh6Q0o3RWZ6Nm1QZ2owVDRa?=
 =?utf-8?B?Sk04Rmw2U1V1SjIwbUV6R0RqTktSK094RE5teTJacHk1VXMwUG1Gd3l5dG1i?=
 =?utf-8?B?MzRaVzRUUzZIdEw4bEVxNjcxdEI1N1MvRzRoQmpDVGt5eVE1TStMZHRlbFlH?=
 =?utf-8?B?NXVYVnhRTThTMXpraHFCUnJNbHJGeFo4T3YvTWxjZ1ZFNlczaGNOM3FwL3BD?=
 =?utf-8?B?N3hqTjA4VVRFOHZMM25TZVN6cmp2M2N6SVZ1RE4xVVNQVHkra3dyRDdMRk9m?=
 =?utf-8?B?TktwczMzMTNKYzFScXNodkg5THpuOEJLZ0t3dzdFTnFWR1RMOEc3WkVGUStt?=
 =?utf-8?B?YWNVNXpaU0k2NW4zR3dJT2lFdXlxckJua0FBL0RNcFFJVzVuREpRK2NPZU1C?=
 =?utf-8?B?STZpUnE3bk9FZ29NWUwzclc5VkhFTm1KdFd6WmltcjdxcndORVorSG03QVFj?=
 =?utf-8?B?SHl5OTEyNjRpRWFXdGhTWktuY2FqYnZHbnpiMldEWEFzQTNSU2FWTDI2WkRX?=
 =?utf-8?B?Nk91VU93VGt0ZHFRRE9XZUFyYjUrZDkrcTlrTVhjUWRlMHE0L3llbTZhTzhs?=
 =?utf-8?B?V09PUmZJN3pBWjZvWkw5ZHZBcmNRc3RxZHN0SDBleVhENm41bDFaK3BON0JS?=
 =?utf-8?B?d2ZLaVNxRkdhQVZON3g3Ni9sR2VJcmVxOWVaam1ORUxLMExTRmFtTWtQbXdz?=
 =?utf-8?B?RFJwYVBIOHBHUER1UzdyQWlTWVFidk1kVFlOd3NrOFV5UkhadGt3WlFSZFZu?=
 =?utf-8?B?Wnd0UU1HVlJMRUJLMFJYZUVOV3hiaEkzY1NrcEU2cTVyUWdqRHdrZ0pOUldl?=
 =?utf-8?B?MzVJdFlaejRiTXZ3M3lOVFpOTXFWVkJHbWlybzJ6a0k3UWZudHhQcFIxdzZF?=
 =?utf-8?B?NmdOZ1hPczFIVmdaeHp3cVZKMGFGMmVGY2pRODQxSERnYjl5YW1GVGpQZjVT?=
 =?utf-8?B?L1I1Q3VqT21QanBUV2QydE5aQllQOEx5TDg2UkV2ZVdhdTZQek14KzFJckd6?=
 =?utf-8?B?M3Z6bGQ4cWN5QmNhSEdjZk1FS3gzQk9IbHc2TkgxTkZkVkNNUU16NDl1OWVt?=
 =?utf-8?B?ZG1tYkkybUZqZnBXd1RnRThFeHVuQXBqZnl3emhtNU81ZklrTm9lZEJFd3lR?=
 =?utf-8?B?RWtObzZOUzlGSGR1T29uVVhhZ05pbngxaVlORnVVbFZVTFNmR0pFb05uanR1?=
 =?utf-8?B?SDBuU0trMHp0Mjc5UGwwZTQ5VXZKNHdjR1U4dFg4a3BFcmRzR0tEUFZxSVN6?=
 =?utf-8?B?MjJ2c1YySGM4WFh6UmFCcWN6dCtUaVJTQ2ZUdjlEVS9HNkw3VXBZYy9mQTdl?=
 =?utf-8?B?UXFhZGNmVXhlSDBWNVh0ejJ2OU1OT2FRRE5kY3dLRkxoSDNOcmNkWnFFclN0?=
 =?utf-8?B?MTkvUW5SdkE4TG1qVjgxNklQTUM2bkpCWm5UYTlibU1EWXJ3OHUwNjY3cnp6?=
 =?utf-8?B?dTkvZjFxSzBoam4vWEVLS3RBdnllTEFlTklTbVVyQTV2YWJFOE5tY2I0Q1RM?=
 =?utf-8?Q?e04O7NatNpdKefC/UJdROs45T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4b34eb-c5b3-45ab-79c3-08dd68190f5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 01:38:20.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnTUrPk7vyMf4BiJhmTw1J2fkaTaEcltv1ayBW3iIIKUtweepcQsV+PwcXM8/sKiZ1uTjHz76Cet7Vq46kO9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6512
X-OriginatorOrg: intel.com

On 2025/3/21 07:17, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 06:47:43AM -0700, Yi Liu wrote:
>> @@ -150,6 +155,32 @@ struct iommu_test_cmd {
>>   		struct {
>>   			__u32 dev_id;
>>   		} trigger_vevent;
>> +		struct {
>> +			__u32 pasid;
>> +			__u32 pt_id;
>> +			/* @id is stdev_id
>> +			 * pasid#1024 is for special test, do not use it
>> +			 * in normal case.
>> +			 */
> 
> How about add on top of these structs:
> #define IOMMU_TEST_PASID_RESERVED 1024

yep

> Also, the coding style of the multi-line comments is a bit odd.

yeah, but it cannot be finished in one line. And I think it is necessary
to add it to note how userspace should set the id field and pasid field.

>> +		} pasid_attach;
>> +		struct {
>> +			__u32 pasid;
>> +			__u32 pt_id;
>> +			/* @id is stdev_id
>> +			 * pasid#1024 is for special test, do not use it
>> +			 * in normal case.
>> +			 */
> 
> Ditto
> 
>> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
>> index 691e7a23f300..37c9cd285541 100644
>> --- a/drivers/iommu/iommufd/selftest.c
>> +++ b/drivers/iommu/iommufd/selftest.c
>> @@ -223,10 +223,29 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
>>   	return 0;
>>   }
>>   
>> +static bool pasid_1024_attached;
> 
> I recall syzkaller would do multi-threading... We might need a
> global mutex or something atomic_t?

maybe move it to mdev as Jason suggested in another email.

>>   static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
>>   					 struct device *dev, ioasid_t pasid,
>>   					 struct iommu_domain *old)
>>   {
>> +	/*
>> +	 * First attach with pasid 1024 succ, second attach would fail.
> 
> succeeds?

yep

> 
>> +	 * This is helpful to test the case in which the iommu core needs
>> +	 * to rollback to old domain due to driver failure.
>> +	 */
>> +	if (pasid == 1024) {
>> +		if (domain->type == IOMMU_DOMAIN_BLOCKED) {
>> +			pasid_1024_attached = false;
>> +		} else if (pasid_1024_attached) {
>> +			pasid_1024_attached = false;
>> +			// Fake an error to fail the replacement
>> +			return -ENOMEM;
> 
> /* Fake an error to fail the replacement */
> 
> While failing this, why does it detach pasid-1024? Maybe some extra
> comments for what's doing?

do you mean when does it detach?

>> +static int iommufd_test_pasid_check_domain(struct iommufd_ucmd *ucmd,
>> +					   struct iommu_test_cmd *cmd)
>> +{
>> +	struct iommu_domain *attached_domain, *expect_domain = NULL;
>> +	struct iommufd_hw_pagetable *hwpt = NULL;
>> +	struct iommu_attach_handle *handle;
>> +	struct selftest_obj *sobj;
>> +	struct mock_dev *mdev;
>> +	bool result;
>> +	int rc = 0;
>> +
>> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
>> +	if (IS_ERR(sobj))
>> +		return PTR_ERR(sobj);
>> +
>> +	mdev = sobj->idev.mock_dev;
>> +
>> +	handle = iommu_attach_handle_get(mdev->dev.iommu_group,
>> +					 cmd->pasid_check.pasid, 0);
>> +	if (IS_ERR(handle))
>> +		attached_domain = NULL;
>> +	else
>> +		attached_domain = handle->domain;
>> +
>> +	if (cmd->pasid_check.hwpt_id) {
>> +		hwpt = iommufd_get_hwpt(ucmd, cmd->pasid_check.hwpt_id);
>> +		if (IS_ERR(hwpt)) {
> 
> Do we need cmd->pasid_check.hwpt_id to be optional?

not intend to make it optional. just wants to use 0 as a special
value hence no need to retrieve hwpt. Hence be able to check if this
pasid is attached or not.

> 
>> +			rc = PTR_ERR(hwpt);
>> +			goto out_put_dev;
>> +		}
>> +		expect_domain = hwpt->domain;
>> +	}
>> +
>> +	result = (attached_domain == expect_domain) ? 1 : 0;
>> +	if (copy_to_user(u64_to_user_ptr(cmd->pasid_check.out_result_ptr),
>> +			 &result, sizeof(result)))
>> +		rc = -EFAULT;
> 
> If we do want it to be optional, we can't unconditionally check the
> result then?
> 
>> +static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
>> +				     struct iommu_test_cmd *cmd)
>> +{
>> +	struct selftest_obj *sobj;
>> +	int rc;
>> +
>> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
>> +	if (IS_ERR(sobj))
>> +		return PTR_ERR(sobj);
>> +
>> +	rc = iommufd_device_attach(sobj->idev.idev, cmd->pasid_attach.pasid,
>> +				   &cmd->pasid_attach.pt_id);
>> +	if (rc)
>> +		goto out_sobj;
>> +
>> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>> +	if (rc)
>> +		iommufd_device_detach(sobj->idev.idev,
>> +				      cmd->pasid_attach.pasid);
>> +
>> +out_sobj:
>> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
>> +	return rc;
>> +}
>> +
>> +static int iommufd_test_pasid_replace(struct iommufd_ucmd *ucmd,
>> +				      struct iommu_test_cmd *cmd)
>> +{
>> +	struct selftest_obj *sobj;
>> +	int rc;
>> +
>> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
>> +	if (IS_ERR(sobj))
>> +		return PTR_ERR(sobj);
>> +
>> +	rc = iommufd_device_replace(sobj->idev.idev, cmd->pasid_attach.pasid,
>> +				    &cmd->pasid_attach.pt_id);
>> +	if (rc)
>> +		goto out_sobj;
>> +
>> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>> +
>> +out_sobj:
>> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
>> +	return rc;
> 
> If iommufd_ucmd_respond fails, do we need to revert like we do in
> iommufd_test_pasid_attach()?

It should be reverting to the old hwpt. It lacks of a helper to get the old
hwpt so far. I can add one since we have pasid_attach array now. But it
ends up with helpers used only by selftest which is not so positive. Also,
it requires a mock_dev->lock to sync the attach/replace/detach. Then I
found iommufd_test_mock_domain_replace() just returns without revert. So
I chose the simpler way.

-- 
Regards,
Yi Liu
