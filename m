Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219F78F24
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739416271; cv=fail; b=lumYjRoTGEa8BZgrASiKxbM+PWgvPT9mzzwkp1zCw+wRcsHbzfaH2TMAX0325fR4Qtl0YfjYxvf4PEXMnz9EToWa+C66k+0pWFWzsjBLdExkoquwVeHeOOd9M/XSEs4N+EKuShahkYLL3+fY2T0xC2Bg+Io9ec32IhLBNoe1NYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739416271; c=relaxed/simple;
	bh=Rr6aArAil6vrHlW9eQX3j/nPSWeFIBJF2qbaaqhnS9Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oUgkEU5i4shkRC87aWoguU+/8rqVmPOmjMsYiUBem29aZecbGTwH67MoTYxOnMkhpbxkoGkL0TlZLsXusU7uLr8PuVHsn7sRNm8COs+s9DpPUoPNzjwiRUyj+imA3hPmAM76orhKYdFT48MNezZXuHnGyXjTb+nPnwgYJ20THJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHRogTCC; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHRogTCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739416270; x=1770952270;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rr6aArAil6vrHlW9eQX3j/nPSWeFIBJF2qbaaqhnS9Y=;
  b=IHRogTCC+7u3j/an7ttvJvR0dzyzNwC92nmHVcb7ba2v/+Kt3Dvf6qGi
   C+B8/GB+8ktqwd8lTA85FbM53gwlJIRqgLGfgwpZ20VemYOo3E2a+LiMl
   pY9bGIEUSKvM+R6vEYuu5GMuPA7CDdXsuxJyfdDT/wdmwvJNqVoctyw3P
   0LEGuR6I6FZ3E6F1gniwkEbtiRsLfDw3cDVI3m/NodwShkb97oSWG2v62
   FxTDJB3boezyk0si96VhQjaaAcy6Daom9RFYzkqZ2UZDklaOGSf1/13MY
   dxr2s0U2uKExeRNcRm9VUb/Jta+9CWO7K54olPRy3vRpMYIqC6rFo0Mq4
   g==;
X-CSE-ConnectionGUID: co8+ZCppTxmRiB5/UFgEUA==
X-CSE-MsgGUID: q+VLpigERf+fzGdJD1vhVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40251053"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="40251053"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 19:11:10 -0800
X-CSE-ConnectionGUID: HrMxasKNTtK6ZUaAo0shbA==
X-CSE-MsgGUID: kShoICDRQwKmcuz9GUaRwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="118018924"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 19:11:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 19:11:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 19:11:08 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 19:11:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDmqSSF3zU0JbvHAZPQwybO0TVEtCMu5vJLG9qbxkH8K/wlz4dXt7vDFgycLtpm99ksM1BKsJbYgZRn/Hv3w8GYhTRe3Y7Rk9fkKGS/I2Rh4dU5G3gVM0T/WSDpt7eLN2o+ddspqXI1UfNoao6/I2bgh+yFFzrkydaiXTmSPgQ72/tWi7Cssd/mrN78envHWf2YlaEAKnfY8Vcxe0/Xa9N4G69xdouHNVKxwlPfPxK239DtTfjClmjexVHYQ39nBG/X9v54Qu2Slm/r69rHRga6sc3oEVcvIVR4NzCJoa2BeupruvfRL4aNqGFm94knlBuEOmwFmS3ERkigM56+tnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLgBAsU9k4rsVzEm8H5Bzf6VMDxAwfn7tXKqWxhJcNg=;
 b=SqGRlxQjG4f+OaH/ufqo96FmeBDCICaSamNoRiRRz62vhV5nLNQTVeWiQdpuUiiEGeziXvRSIeQRN5CUFBxozuH0A6uU6/hLsIU2swUcdVZEYqSf5ZWr67Av1/ic8LFRGhE1DyW1J/yFpZU7UMIVj9RwYygmDxF/VWx6mGKn/Tkjh1W4rMjl3Wr9CxS9wpACeXxyfJOwS3bIO04IXefkSF6mlEf/FPrqAWvk4vRiHEimhnD9lp0J6CsXkJ8pT+4z+QRr6Y6UItjewAqW6pR2sDRwXaz91As4Wc2K0T4kpth0O8hno0ae48h2JQZJI+5RUENYoRSY+vwlds0cnPJEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ2PR11MB8323.namprd11.prod.outlook.com (2603:10b6:a03:53f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 03:11:04 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 03:11:04 +0000
Message-ID: <bc4368b8-1d15-4605-82c0-a4db108fb8ca@intel.com>
Date: Thu, 13 Feb 2025 11:16:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Misc iommu_attach_handle enhancements in iommu core
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <robin.murphy@arm.com>, <nicolinc@nvidia.com>,
	<will@kernel.org>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212152531.GA3849539@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250212152531.GA3849539@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ2PR11MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 730f74cb-2f05-4385-4c15-08dd4bdc0d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTNBL1RZZFRsYW52V3I3a3lVSGVVc2oyNUlKVDZrUllKZkdqaGpaQVlWN3NG?=
 =?utf-8?B?VmhMNjBzK3c2OHdZQmxNbnZHR0RhZ1pwSzhhMVBIUy81Z1ZBNDVzQ21LSHRY?=
 =?utf-8?B?SmxFMEJZd0dZNjVyb2VoYkdzUklKVEdpM21tWmwrQ1pIa0dTMzNudXlIbnNK?=
 =?utf-8?B?YUxNbU1BZE9wWjVwcUZqaWNQaW00Z2YvejdCUytYaWJ2a3lqNCtnTCt2SDhi?=
 =?utf-8?B?WGdrcndxeDA1V3NXamZUUjdlNHdPUWpma0lXTFYrZFdzdnltd2hUelg4Zkk0?=
 =?utf-8?B?bjA3RmJNUURZMEx0VGRwVUk0OWRkV3hvbHNlR0NQendyY0JIblY5d1ZVdVFp?=
 =?utf-8?B?elluR3FDUk5JcnVXc3FjckthcjJZRW1qMk52NlhkeW5YdXp5VDJWNHBERCtz?=
 =?utf-8?B?ZnBtSHpUNmJKdEUrYTlEZFFIcW1QQTlCUWFWNjdBK0draGdVODNQMktaS2ZY?=
 =?utf-8?B?cXhSckhOanl5TUhMMHBJZVlyZURrSEFQd0ZXSHVONG93M3VmZnJ0czkzTXFs?=
 =?utf-8?B?d1NVVHA2M2g5bWlGdHhaQkZjak0zcUk4OGsxSW45N01vU2FNQkhTVTZFMTBF?=
 =?utf-8?B?d0J3Y0ttTHowa0JNUlFrVWkvN0UzOFJnbXJiL2x4YUpqajgzUnF0Zm5IT2dh?=
 =?utf-8?B?OFFUMm40Nlo3U1JwQ2RMcFFIancwT2JxZnJOOTVQQmJIR2VkVjgwckw5K1pu?=
 =?utf-8?B?cGl6S1dJTzBqNlhobjRIQXErNXQzeE1KSXhOWTRRSldWUmhacDloNWFkb1E4?=
 =?utf-8?B?cVRzdGR3SldNcFFLaDBtbTBhMkhmalBlN29zMDhhaW1zaW4yU3g3a3kyNU45?=
 =?utf-8?B?SVhjNFZOSHV0YXlNMW5LK3dLYUE4ZGFaVVZCMXNOczY4dXhhREtzNXRCd3dY?=
 =?utf-8?B?c1RabHErWXZqNGoveUhUSDZucHlUUmx3dlg3NVlkNHdJWTk3ZjVUN245Mng4?=
 =?utf-8?B?RkNXY25lM3ZZcitzQlZ4dzd4ZEdYbGVqalVuTnpSWGZzTU53RE1iMVJpb0Zm?=
 =?utf-8?B?aHNCTmxzMThjZnVEVmVabVhQTFd6bUZwd05XT29uWElKVVk3bUVqOVArL3ZK?=
 =?utf-8?B?ZVAvV2pYYk8zTm1TTnBXN2o1NnJqWk5TS3E1ZlI0M1gxL2haRkVYYWhzT0JX?=
 =?utf-8?B?WUo4ZVcvd3dYZXVQa0tObTdud3c5UnlBSGtGRG5mWTlacGtJcFcvc2wwTmpP?=
 =?utf-8?B?MVhidWtjbENrTUQzWEJERExkQWoxd3hPMGUzY1JzOW9yNFZYWEQvUS8vVXZR?=
 =?utf-8?B?OFkvS1NVbEpHRURDMzlRK2FzZFNkUkFzTFZnYWxBYmVlbnE2VExheUJNQTRL?=
 =?utf-8?B?M2V2M2hQbG0zcm5pa3FrNjdXSzhZSlp5Lyt1eDNYUThPaW43OGh0ZGg2bmdB?=
 =?utf-8?B?L2YzQVR1RGRXVnpGV3Z0bVFlZm9RY0p0NHdxNTZueGtlMXJ5THVWZlh5OGRF?=
 =?utf-8?B?Ti9KdENzVEZOZURhYlVSRGpwZ1dhV3RnQk40VnpHcXAxQkQyM2lvSGtPay9j?=
 =?utf-8?B?ajQxMTVJeWJhZjg5T0pnTGRteHF3SThwOEFpTlVIak1mWThkZU1td2EzR3p5?=
 =?utf-8?B?N0xYVkpld2pMZ2w2dzZ6c2l3a1M1SzljRmI2S0tkbjFEdzYzRFJDckVYbnVQ?=
 =?utf-8?B?QmV6MkovTnltaXRpQk1UQzdQYmRLMWNWNEhTU1pleU91Z1gwVi9vcS9hZHpB?=
 =?utf-8?B?TGpneTUvZXAyMXl0U2llbFg2M1dDY0FmVi9jU2xmVTVYME45L3AyaEJMT1dZ?=
 =?utf-8?B?eFVoamtjMlNXN2ErVldRNTdtdzJHSkFEQTBKR3hReXA3dzNaU3NDVy9jbmVu?=
 =?utf-8?B?cnA5QkhYRWo2dnRIcE1uRFQybU5XL3NKZVRMeXFiZnNYVjBnNThUeEdleVBa?=
 =?utf-8?Q?cJoDroLjtzqER?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JWK1ZabEp3TTNkZzN4Y01iRks4U0ZwSWpORUgvVE9VcHN0NmZ5bDR5cE5Z?=
 =?utf-8?B?MFd1Ym5jVDFsZlNnTXNweGpSbTduYXFZM1dnL2FzVEVSU1NkYjFWRG5PRzBn?=
 =?utf-8?B?cWkyN2JHQytHRTV2MWxYRGwzelhFQi9DdTFaY2J4dnQxaC90eDArcFdWU09p?=
 =?utf-8?B?b0hWd3N5eVJTcG5na0JERHRLcVFiU1pDTlk1R2FpbWFMNmVxRGpXVHBqZmZl?=
 =?utf-8?B?Y0JmandHbll2UDFNZFlXSUR2cExRRjVrdTgvODBIUGRTQmllaEZQQXMvVkdu?=
 =?utf-8?B?YjYvbHhJQVphUjR4Z3Q5My9LanEzTzVSRlNYcWI4NXBXdWdKUnU0SjJjM0No?=
 =?utf-8?B?MXJuN3dDVUNRTjVaRTUrRkR1V3dvR25lNEdWWWpYNUVDdnRQQXVwaDZmTSt4?=
 =?utf-8?B?d240UEZSTXBnZktpQVBFTnEvYWUyam1sSHlLTUQ0dVZNSVF5OFZ6S1NtMlVY?=
 =?utf-8?B?RCtQcjljaXBRdGlPclB6eVJ4dFVCOHRsK3NHSnMyZi9RK0diYVJHRmlwdHRM?=
 =?utf-8?B?cU1vSWlFWkIzWWVTL2IraXRFeWl2bnJUNDE4S1lFeSsrY2E2QXYxNCtjNE45?=
 =?utf-8?B?ak5IaFNhQ2xiNTJHQmJ6WlRYaWxwbDJ4SzhDM014MjBhSk8rWGU4dEF5UWxj?=
 =?utf-8?B?eXJwVGVZU3BUc1kzYVZoK0FGU3VXS1FRRGt4M3lRcW9iOER0VXhUek5yWlRC?=
 =?utf-8?B?eERHVDNzVUIxYWh2M3Q3amhXTndGZ1o4R24wMGlCa1pZeU1aL1p6R0JMZVRW?=
 =?utf-8?B?TGVWSW0yOHdwS2JEUWJJR0xHY25RQjh3ZkZEbDJpWkVrbjNSazU5VkI4ZXF3?=
 =?utf-8?B?bTE3TmFOK1hKT2pTTzFXSW9oNUZqdmtNZlRzTEdCQ1ZmNU5QZ0pyZU1VaU4w?=
 =?utf-8?B?R1Q1T1lJMjBUSTBzanNrSFVpZ3FXU3hteEdqMHNhTGZkZWRHN1FvMmcwOSsx?=
 =?utf-8?B?L1pMZmZtVldzdmhDRmFIYldEemVnckFSYTM4cTJkMGtyRTlWQm5oeDcrdzZ6?=
 =?utf-8?B?Z1lqZ1VPTGFDZ3U0dzIxcENPVEZRRCtjTktNeHByNko5dzkvRC9vWFdLdU9a?=
 =?utf-8?B?WnFpRTBtcGx0UE55bmRqbERQbWNXZDdFWXJ6eDA0OUd0VTBVYzdhNkU5bkFB?=
 =?utf-8?B?VkF3aXlySXRsVXdlaUlmUWJGYkw2bm9jUVFrK3NXSHVKU1hLOFl2ay9RZVNm?=
 =?utf-8?B?bEczMWZzVjdUUGxPVHdjZ3oraG9HbVJ5R0xkYnBhWkt5dXlCaktOQUIvZ3BE?=
 =?utf-8?B?RXdya0JWdVRUUmtESFd0Rzd1QkNUbWRyazQ2eGRUN2ZSOTVVL0dzQVk2VVh1?=
 =?utf-8?B?bmY2bmxhUnlYY1pwUVBLME01bjZhNFB6YWZwM0NwbWE0ZTZWN2dpZUM1MlRT?=
 =?utf-8?B?Z2RiZndUUHBPMU1MenY2Z0NURDdTYWwxd1lWSXdQSnV3N1NNeWFUWU91dU9C?=
 =?utf-8?B?RitaYmVEcytmTkRpNUlHMTN1TU5GdndNQ25pQllWSWpzZmxJaHhiWDZ6VTNw?=
 =?utf-8?B?REtNbVVMUkNRL1NlUjg2Q2VielNWNnZ0T1JldkVuRS9rN3dwSGtqcXN5MTEv?=
 =?utf-8?B?NGR1ZWJTYTJjemR2UFlzSm9UZXE5VEtWK3ZaWDVGenRZL1FicmNOQk5kc1ZC?=
 =?utf-8?B?Mzc3ZmUvQ2xFZTNUVjNPU2NOTHZBTlNzWVJ2aVdHVmVOekJ2VFJLbWplVFRo?=
 =?utf-8?B?a0xySDJwc243K0tTMmVIR2xzS3VrV3pMR29zV3huQWhDTUtROHFiUUh1VTBD?=
 =?utf-8?B?OUZNanZkRk9ySEpqOXRKWURqeHBvZGU1bVRSVnJlbERRMWZVTjVJcjNuUXQ2?=
 =?utf-8?B?RU40dlZlRkZVeitlWUF0U1M1UTRXb0w2cmM1L2g1cXJKczNTbzdCWG16c3VD?=
 =?utf-8?B?WTdJWkNpWTF2aFJ4UW1BR3VqdVNJZzJ1YXUyT2ZZamxtRndWSlBRNWlMN0NU?=
 =?utf-8?B?NUozWERCSVM3MTBEaDlEckNHaGFTMUdGcytLVlhDMzk2QVJINUs4cjRLZ1d3?=
 =?utf-8?B?Yk9qeDZMZ2s1T2pqTFRSR3FzSlRjVW1qakpTQWRlc1c2N3BOcDEzd2ZzR2Vv?=
 =?utf-8?B?bm5VRTRBZFdGUTFzV2t0MFVQT3NSU2xMQld3TTZqRG1RZFM5RWJRblVzRlQ2?=
 =?utf-8?Q?h2F9WG1HvjtKzsyyXiQnIxNIA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 730f74cb-2f05-4385-4c15-08dd4bdc0d00
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:11:04.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 683dUjvFanDk2KMAWYutRraky4lCf4kZPAVRofaF1wMFSQjy8OVUs8+nMd8EALcFFqd+thDRcem4eUNNU8FuRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8323
X-OriginatorOrg: intel.com

On 2025/2/12 23:25, Jason Gunthorpe wrote:
> On Tue, Feb 11, 2025 at 10:05:35PM -0800, Yi Liu wrote:
>> This patch series aims to enhance the iommu_attach_handle-related APIs
>> in the IOMMU core. The changes build upon Nic's previous series[1],
> 
> So it needs some branching help to go into Joerg's tree ?

yes since all the changes are in the core. Current series is based on your
for-next.

https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/?h=for-next 
   dc10ba25d43f433ad5d9e8e6be4f4d2bb3cd9ddb

> 
>> This series also covers the prior series[2] which only takes care of the
>> iommu_attach_device_pasid().
> 
> Is this a pre-condition for your iommufd PASID series?

yes. The last patch is nice to have. I included it as it is just one minor
step.

-- 
Regards,
Yi Liu
