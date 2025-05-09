Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22F2749EA
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781786; cv=fail; b=h4kfE+4NQLpqPFrhyi1fK6ksL8h/q/FPI+Ai9v45CvCqBzm51k4jvo5bDj4d3/mBqybNgXxIMUyyqLHyoIlK2Y77fK02L2h1GqfwyuAjDn1T2VQxbLtHSYvMy1XXCZRcX26rsBBMZ2GfVZyOEjLjblnkok8ry26TNC/dVnM1/qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781786; c=relaxed/simple;
	bh=0JjMVdUn3bjNk61CG8E1SWorvnoyOjUjzI56c9mNK/Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c7TWJj32w/CXvPpzF5PK9xIW0Myd4hFxO9VKBEfsKZQx4Tas/gqOlM0xjyrbxUamLXVr6KssRAQccN8jxizVlc9nCtT3ql8Cx7fPqWSCSe8seXMEJ6pwYiVDEFs67hutJ8foqDbiilMvvp/xeYdaxCxY6wE4YchFyWqRsuHM4W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTXyXFuD; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTXyXFuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746781784; x=1778317784;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=0JjMVdUn3bjNk61CG8E1SWorvnoyOjUjzI56c9mNK/Y=;
  b=dTXyXFuDTDwBcPtWQB4W5HcKYWMsqZnQx3/MjyGGypENW8VbPxo9oIxo
   1DGFXraQDgL/HgkRWWA8EnvE9PDr383sDWCpSgMGzXyXwOJ3yd9gHiuTd
   +5ucpveXC49JD+oWl54IvAb6b647auqfeo4/IECXoR/IAr6hmxnLwlOIL
   3L4DAoSEo0h+1M4Fnf/yO6a/tr0voIey79uv2z34GpklAVAUY+p8r2bSo
   6Y2uwsW83otYLLw/iQg1DhuatNx3Z7yKJAI3Q/gmVPAzoCRdVGR7nBrKY
   dp/MFfMLMAjz/RyD7h8RHr6U0+IPHI3EA/kai+ibwDcwEZpPLb8yTjLx4
   w==;
X-CSE-ConnectionGUID: gttenavVTJ6n7lJ8lr4MKg==
X-CSE-MsgGUID: dptHaqVMT9KwBzpN+lh41w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="66007573"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="66007573"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 02:09:43 -0700
X-CSE-ConnectionGUID: td2drzuZSsixTUpIBXLE/A==
X-CSE-MsgGUID: QBUai4OfQy24v+/XT1cgfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="159858504"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 02:09:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 02:09:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 02:09:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 02:09:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEwq+h/IO2C1OOJGkKt/Q0ZSLUMSbcylB+ROpZ4wwXHfA4qYFS88xhFwwMIZfTGx091vQ9bHIGhkkJd3lY8Nx654DOfksQi7XM0JADgAvt3SZGPDF9Koi4wE/qsQYSFVTbJWei8jfiGRVE6xLxkqn6WD4nAlx7e3KObJcjEe4EOh2+Q+7pyRJy3IVyGLWKQaAtftYqmqjUv670YTL2Yq5suGshNAsu0aCoc3zLsdRJpcQkQoN50JvYWqVPCdbmoe6kPPw9WDWs0hjEK1fYVdfqOVPx/LpBNCrx7McuG7x2KqwmloN9CIo/wN82FDlXtGmEVaiDCe1sjX6H+kODoNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m36QjFQIDSpbM8+OA4ymvAkFeuGHI58BqT0co9BWEeo=;
 b=jO9IAFOPMQKkxp1u80+FnsMRqxvFVxGU0UWPjUewikhY6TUbN1TpVpmDaDrShd0KsioNSuV9XtNKrer9nISW5l9rv7epOupdQCIRGHrOi3vft5JGM3nh+J7IXVTYnJBzAmcWiqgEOXKKPYt0a/SP+TIjtxFcgl1Bopzn8jwFlTgi1f+B4ax1qyOCEhlZB8qBySRi+YUr7MY6Bsab8BolS7fwPgcHmh/jdAo2/6Y9UeCKpaQJBY1t6rtA7cUpjTaaFXSxFjUohuOp/eQPm9mBmKvYzzAth1mGbG/veDvZjwlQN7DhL8YGOjetoCko48f1Mkk9fDilHT7dj0JWZTV+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW3PR11MB4601.namprd11.prod.outlook.com (2603:10b6:303:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 09:09:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 09:09:40 +0000
Message-ID: <19e39263-e408-4867-a080-d5f187095159@intel.com>
Date: Fri, 9 May 2025 17:15:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] iommu/vt-d: Eliminate pci_physfn() in
 dmar_find_matched_satc_unit()
To: Wei Wang <wei.w.wang@intel.com>, <dwmw2@infradead.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, <jroedel@suse.de>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
References: <20250509140021.4029303-1-wei.w.wang@intel.com>
 <20250509140021.4029303-2-wei.w.wang@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250509140021.4029303-2-wei.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW3PR11MB4601:EE_
X-MS-Office365-Filtering-Correlation-Id: 713ffa6b-0410-48a6-5884-08dd8ed93a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWdUNllVaDJEYjE1NDF2NnNJNHRWMHdzYlRjaVRmVzdFd2tNamtnc1QySHh5?=
 =?utf-8?B?RlZqbzFVbTVJcVkvdktFaGIxRVU3dFNMQWNpMjlCU0tsUEVGNHNUN3F0bnZP?=
 =?utf-8?B?cU04TzRnOWgvanE2cWtzMGk4aW5IakMvNHFxWGlheFJwVTBLZ05IaDZQYWQw?=
 =?utf-8?B?L05rcjhDL1BDWWFpYVl5cm5kdmI1d1lmSGkyVTI0RVA1STdzdmduc1RTVVV0?=
 =?utf-8?B?aFQ5RjlBTXUxTDNpNVZqRkJUUndIVnB5N2Q3amdRbWdMTkd0STJJelhFU3pO?=
 =?utf-8?B?YnFlVnN4OWxxbU5JWm5KcWFjcmZWRkxKR1MwOEVkcTgzRXNhRS8rbExaSnJK?=
 =?utf-8?B?Ri9uWm9xb0UxRVk2djNGQVhlNVJtL3gzZlIxZzdZT2g0NXF5K2hrV2p5SHpH?=
 =?utf-8?B?dDQ0SVBMMlNoVldtNmF6eE1mc0NHV2x6M2l2T2lqdGZQNjRURlRBSlliQkc0?=
 =?utf-8?B?UDhacFRSSUFETXJjYmczdEI0Q0Z2M2xxYUdTNkRYWnpNNS9MZVRUZ3VsUUpN?=
 =?utf-8?B?WU1ucDFtUzgrdTB1MWxWMmkzRkxkN29oTWFVVjA1b0FRcUF0ZVlNYTRSZ1VK?=
 =?utf-8?B?YXNCcWN2ZG1MbGJpaDNLdytrbW4rYStkcEhENjBEVmY3TCtLakM5NUhMZVZS?=
 =?utf-8?B?UWdLV3p2bm41TmZvN29JeXNOZmJPcStjcVJLZGNiWTdZKzRGem9WUGZyM0RS?=
 =?utf-8?B?WDV6M3FQK0dQTVB1WG5hRVJwQXR3WnZvSnJxaTg3NkpSQTNmSk1uYW51VW9E?=
 =?utf-8?B?TG1PZU9keEJxaWl6OUQ3SDZWRi9YK0VvZy9YTFFEMW45TzEwZG50Uk1YM1Ny?=
 =?utf-8?B?YWl0VjM0SGt6V0FYZitTWkhCNVI3QzZuQXZsd0dGR1I0anJjT0hJMHNmYzV6?=
 =?utf-8?B?bVJ2UC9FSWZsaUplQTJMRS9xNUk1dE90SXVEcjArODZ2Sllab2U3d3VJWFls?=
 =?utf-8?B?aGt4UWNNdEtPSFN3RllZWWZ6S0lNSDdNTlFZSnRxOEJyMmR5dWdMVlBwT2hx?=
 =?utf-8?B?OFZZQWY4b1paTXFDM2VjMitiR3FSRC9JNGQzS2lkV3lYTzQ1SnhnbHYzSVFG?=
 =?utf-8?B?Wi9MMmd6cnNKQnlLaTk5UHFneG9TdnNOeW1KQXR3amdFRi9Ib1MzYUwwcEQ1?=
 =?utf-8?B?YmdxSGdiZnVzYk5ncHJjblRMWmtsVG9LSEg3c1JxYTlnbC9VQmNacnVjcU1a?=
 =?utf-8?B?eTMzY1lUTTBPbURBSkhoNHJ2MkxsWlNiQnp0OGlYU1plSFdqY2ptcjlaMTZZ?=
 =?utf-8?B?SE5sUUJYQ0laY3BxM21CTytLL043RFBqZzlBNUhlc2FiREtKT3lETmhSbVBz?=
 =?utf-8?B?ZjdrSWVBckhHZWttRFI5OGc1aFkrMW14UmIxZ1pSUlJ4NWNQMWNRY0IxR0h6?=
 =?utf-8?B?Y2pkNk9lSTNvMmdoSFNIaVNZVnJ3cUpQcHppVCttdnRjTXFZZWhpZEIwejBk?=
 =?utf-8?B?cnJMdWtCVnMyemJsdUtFS3RwMjNrbXcwVSszb2JkaDBJWjdTZWhka1p2c2JE?=
 =?utf-8?B?UHdxL2lkT2lFR0lxZmhXOWV6dUFOQ1dBQTNvLzBPWXhLLzNaRVNkeno5akcw?=
 =?utf-8?B?MjVtSnBweEpvSDNaL0VZbHlha3pCbDArVE5JaEdaZG9xZnRBdWR6b3JRQVp4?=
 =?utf-8?B?R3R6dXdmOGRiQVVwRnhBY29OaWlDSWwwSkRZVUZUaFo1N3d1NEc2WVRvMjBt?=
 =?utf-8?B?dUwrQWlaTTNMTXh0QkhwMng4dzg2OGVTamgxRUU3bHB2cEZWVHFBTVl2bnBq?=
 =?utf-8?B?ZXovOVpWQThlNFFacmRLR25vN0NzWStqM3VIVGxKaVh4NTRSeW1pTm43V3Zi?=
 =?utf-8?B?Vld1YnJ0dEc3a0ErS2VndWY2MWNvWGQ2dW9tMVN0bTV2bTRWTjQxdzZkUlpi?=
 =?utf-8?B?MytzdFl5MVV4YTJZbmIwTWkreVFUNDB2M1hsTFE1WjZRSW8xRE5vV1kwUEJ0?=
 =?utf-8?Q?LYU7ZWrwHLc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJBWEJjOVFnT2FUTFJtTkdDRTViemlRN1N3Q21NK0J2aTdNQ0hPMGdPeWZV?=
 =?utf-8?B?aGRvRVhpbWIralVFNEpFNTMwNFN3cEhFMWsvM1B6cE91anh6N2pGVjRWVkNy?=
 =?utf-8?B?MWlma1d2aUFLbGV1SGhtd3IwYllpWGRkeHQyK3pjdHkvemVGSlR5N2h0QzNK?=
 =?utf-8?B?aVB3OUNNN3BQUEMwSWxpaUdvWVRNMVo1cy9KcWMydjNqVDBzcVhQbmVXZ0tG?=
 =?utf-8?B?czRwY0tFRndDamNaZkp2ZGlJSWd6TFFUeC9EbmozMFpYdWE2UlFIZWhITTlI?=
 =?utf-8?B?UWxLOU5CcC9ETURhUjVkeUFDQ3V3ZEx5M0VETWlxVjU5d1pmSm5Nc0VkSW1l?=
 =?utf-8?B?a3RwWUoyUlBBeHJqbUJ3ZkRUaFBDUjhpczJDakk3bkNQejRpNUxiSWJtM1BS?=
 =?utf-8?B?L3RReFlZSGx4c1JiTEFEQmE5a3Nzd1RzZll1Qlc0c3MvS2tPZ1dwRGttVVBC?=
 =?utf-8?B?VHVqS295allGcTl6TzdhdW81eTN2Z2RWRlQ5ZjVRYkI1QjNVZzR5Z0tQM0Zo?=
 =?utf-8?B?QjIzeTNWY3pWWEZ6T3pnZUovM0g4WnlVeWFWWjJ5SitnUTZsbnRJaERQdWtZ?=
 =?utf-8?B?VXBadzJhSUFLOXh6S0NnR1BsVTdQNW9FdTAvNzZvU1BaNXdCN2pOOFdnMGNB?=
 =?utf-8?B?QURaL1Z1MGJqSk5Ma2hhV1Q2MnBxTk11MjFyNUxSM0VzSUNoT3ZqVHprYzAy?=
 =?utf-8?B?aGUrcmFWdHhPZXhjWDBmQTFQazEvMVdSTGtDa1l3SU4wU2k2eDB5SjZpVWRz?=
 =?utf-8?B?VU9qL0xVS0QrcnVRV2Vsc3ZSN1lFZTRSOFdtb0ZCT1VWRVhGYW9IN1h4KzdD?=
 =?utf-8?B?WThhR0lYemI4YXIyMnJ5ZlNZMFNWdHFYQTFIb2ZIUTdLU1MyZmVaaFNrR05x?=
 =?utf-8?B?V3BTbW44Q2lNb0I1KzhNN0l5MXF3SzVjNkhVMWh1eDhTQ015NXFmeEVJdjNh?=
 =?utf-8?B?V2cwUXd5VjNVN0t6QXBaRlg2K2o4R3RFdUt5MDdCNWdyWkNtQklKaHN1Znh0?=
 =?utf-8?B?QlpQZTZrVFkwTFNQc0VSVGNVUy9yTFJ0SjNaRnZUa3hRaEF0cXEyNGRYQ1Vs?=
 =?utf-8?B?djBvbERVaUY0MmJ6cnpKTytsZUJTQXZ5cFd3V2dCQVNESWI0WVhNR1gzVXNv?=
 =?utf-8?B?aFpDQm04RkZlWFZ6R2l5SzB1QTJ5UmZZbndZMXpwZi91ZUNoUjFEb3lCZDdL?=
 =?utf-8?B?UGIxQkRKRklkeG55MmVEcjFoME1TeTFuclNtWUN3MUVKSEZnanJvOXpyOUF2?=
 =?utf-8?B?a2hDZjNCbjJPTUNDa3ZDQ0s0bkVuQmdkeFNpckpXaE9MZEYzOTBpOXo5SkZM?=
 =?utf-8?B?bXpxeG4zamNzd2pNdlU5S2J0eEJOZmJCVkprZkpDMjhKeDNQZUcxcFdWVVp2?=
 =?utf-8?B?WC8xbkJJZ2hmNVMvRjhkUjdIajRZS3k1K01VK1VkTkZFUGt1R2xTQ0NLdHVs?=
 =?utf-8?B?VDhOUXRPRFVDZWh3N3FSb3FickhGVHJsaU95b3hVT1NESnQxRkVlTWlOUlZP?=
 =?utf-8?B?bUJTdFJhbmVLanZkaDFUN3pnWjBneEcvZEFGWGFsM3pKNVJRNzJObnB5azJS?=
 =?utf-8?B?UzViTU1KbjF6MTN5Z1NWQkZhZStLTlVKMkxpSUZYZ1lSK2dGZHFzcUdNS0JW?=
 =?utf-8?B?d0VTUENrUytSTWZBSUE5NWFhRms2MjBXbTZld3JuaXV6RldYbGpsMXVGNzlV?=
 =?utf-8?B?bnVYSE11QXU3dGx1Z3FvZTg1OEM0RS9kZzBMNzR2dUllYW44YjhGbTNLSEZT?=
 =?utf-8?B?TnBiRFpUbWhrTTVQVmwwL0dOM2gxNUszMms3bWFlZFZBSmNDMG9xTzJ5UWlX?=
 =?utf-8?B?a05mbmxwM05HWTdITTdiMzRHbnhIT2Y3K2RnYS8xc0J5NThaeFF4dFJjMS84?=
 =?utf-8?B?RWVOVVZZeU1PempTajNudU1oLzNpcGRySWcyUk8zZUorTERhaWhzV0FHVGgx?=
 =?utf-8?B?T2hBV2NZZ0JrUnU5WnVQeEd1eTZTVGdTU3FLSmlmM0U5ZjF5b2IzTUxoOU1n?=
 =?utf-8?B?N1JTS2g1R1grbUkxTlNGalBiZFdFMVovOGpQVE4yNVNDc2xYNHFCRStZSE5M?=
 =?utf-8?B?WHpRaXhiSnV5eExlTVRTQ25keUU2blBCellIUFdHMXlLdHhUMHFYSnhLTDN0?=
 =?utf-8?Q?XOVKY8e0S6ssn2RwN1hPpYrZR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 713ffa6b-0410-48a6-5884-08dd8ed93a55
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 09:09:40.0589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+K5dVzRyY5NKv2QKA+840Lo6iqxuejymPZetwDovl4d/f6J0VdG9VIgGqLEawAxtnU6kcQksiFq5egpMey3Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4601
X-OriginatorOrg: intel.com

On 2025/5/9 22:00, Wei Wang wrote:
> The function dmar_find_matched_satc_unit() contains a duplicate call to
> pci_physfn(). This call is unnecessary as pci_physfn() has already been
> invoked by the caller. Removing the redundant call simplifies the code
> and improves efficiency a bit.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cb0b993bebb4..d8aa71305509 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2744,7 +2744,6 @@ static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
>   	struct device *tmp;
>   	int i;
>   
> -	dev = pci_physfn(dev);

better have a comment to highlight the input dev should be PF. also, can
add a WARN_ON(dev->is_virtfn);

>   	rcu_read_lock();
>   
>   	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {

-- 
Regards,
Yi Liu
