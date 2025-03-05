Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996211EB3E
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741144029; cv=fail; b=lCXkfXVcUYLIOMavtJJyFEOiaTtqiqOhm0p1tVPpDM4vGNjxPn1pZeGKHWZ/s4py79iziddlvICfGO200FNNOBiD0W/T+EYPkVhbwE02UYq0rk/nsEDtQsX+j4m5XMYbbA4kek+S5J5eIp2iDAQ1ER92KHoBun14NVskoIZHMQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741144029; c=relaxed/simple;
	bh=rvxpFLMSpx2GTQq0BEAXXrsaQBMKECwBusECC35aKYI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gcx9OTnA+XXblsfxPLRUG1FQDCH/EfR3VZczXp1HLrSuPiQR+H9Hd2I8Po8ggyp7z6pPxeOsMRz1kwMTCQ1d1gQExeeTrxOSK8FBU/iqzD3n06Q+yl20ikYvlxkASuDpcpOXp3/uyrHCJJx64uWlzn16FwROv7Oja8SXpaWTkVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2XhPP6A; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2XhPP6A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741144027; x=1772680027;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rvxpFLMSpx2GTQq0BEAXXrsaQBMKECwBusECC35aKYI=;
  b=Y2XhPP6AVmP3QvwpHHECVh8jPYNKK28XObRmw89qDEwzVc2H5VhYOCBc
   jwEtbTF3iaEprx7C2VhDiEXE6FNTGkZ2y49ztyxPuZEX5wjRgniNaIFrm
   UlYToG0oYy2FUXVfdf0iNqFGgAEHa9kprWeRhDD6lEX9bv9RXhfl/z9l6
   ExXgXMO0b/8za0rRZTlHpuliUf6ovB/uDXSs5oXDgavaaxC69oq2ZThTD
   gqHWQlRXjVdxAXLAH4hm/0oRMGGcsx2Rrxw9uNR8q1wB+SkOOJrQ2Ha08
   Zh4ANxHYurznDV2FflQRqMwZYc5PjyOSLlL+0yvo4/GRFRyi1ilPBWhq0
   Q==;
X-CSE-ConnectionGUID: 9AYttXzMSbqrFpuG7+FcMQ==
X-CSE-MsgGUID: f9aM7pVVRkaMZf2gmv7SuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46015088"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="46015088"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 19:07:05 -0800
X-CSE-ConnectionGUID: QjBwlX2RRXOTtoXUNo7H4A==
X-CSE-MsgGUID: n5bvDM2TQs2wNzmm2ySZ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119065351"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 19:07:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 19:07:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 19:07:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 19:07:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQHzulWJJme7lXXJanuZmsqhVMbCpKi5SsKpehFFgjP0ryeyh9tWe1DGIGQfdTB0jtNpFsa+hjARNwaoWBYpQojQwQQbDAvGewuI3+ljCj2TwsCJ6AbwDLu3yaRo/KCrT1RQe+R9BL3CemSEeYKU3KiCBmmYzSbCjX5/rkgbPLzzdUYPdY/2eVPxG7KYW2rcLJ/iWdYxTFfQXUXP2AmJVEIRs+6wGuMBvhIiycK7sB0WjkwI5fNM6kSId2f4PB0Lc6aRC68GGyajt0rzVf70hsdR0eMeQ2Zve0EqKmh4vhQpO2FCjCq8YLO9tsgmAGkSLDWuFNXBuVpSNtLWvXr5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHGML7/PxQZ8xdp49vMxoI4/D3Px4Z0CcmF0cacckBY=;
 b=oBjEV96eyqIYnRG0Tyace8iEnZdSHinlJ6i7mV3bXg+wS6+8tcKE9nXiFhAZHjbbDsFSdyqdiyrq6pEk/Er+bhdjkS8ZbXEfCAzfkxQ6LK4KgH6Kq9zmMD5Mt+2A0EdDTeIH3znDkkLoGxhG2wBXWiMESkdc0/vxE6x6M6BesUC+A7b583UMBpDjl2End0bkYwWr7ZHdCtxW84clAkFeGyJ0mIqAJYdtfbEu5h1h061rQV/wA+aGJN/MCiE/As0AVlo2nyhRJgojrDsFRbAHyxAOmpTB7lvbL/IoPrIAw1sV89Cp9yEhAR0G6Ad2Y8WILU5jMBzqAA6tt/XLyT9c7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV3PR11MB8741.namprd11.prod.outlook.com (2603:10b6:408:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 03:06:56 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 03:06:56 +0000
Message-ID: <c173e856-ba54-4467-9d8f-8f8732cbdf81@intel.com>
Date: Wed, 5 Mar 2025 11:12:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Fail replace if device has not been attached
To: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
References: <20250304120754.12450-1-yi.l.liu@intel.com>
 <BN9PR11MB5276D60701D818C2F902E07A8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276D60701D818C2F902E07A8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:4:90::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV3PR11MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a728cf7-73be-468f-e25d-08dd5b92c987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1UrTVFkNnZERFE2Z0gvbDNHN2RiL21yZk42d2JVK2dYUmdneHo3M1d4Qkg2?=
 =?utf-8?B?OHhBRWo2Rnc5S0FZQXFLaVJtMjY3S1JyNEhGSWVWRW02ZmpTWndFVktQcWFs?=
 =?utf-8?B?NWZReURiZG5heTJldlhIYkh3NlBydmZXTS9FZVZNeFBRL2VxdkNyZTYyNzZI?=
 =?utf-8?B?YXorZXpoN0tEUlFkNEQ5K3FaYUR2ajMvWmpNRHNoZFJDVm5RTmNScnZtSm5w?=
 =?utf-8?B?cUQxK2ZOVk91UGhxdGJVT1ZMRVR3cDhJb0kyb01TT1AwdDZTOThnWmpsYmhW?=
 =?utf-8?B?QTgwQzNWM2ZWTjZWengrc21ha1BNU0g4Slg5NmhZak04SlhiYUhURm10eVdz?=
 =?utf-8?B?Lzl6WHlQcmk5YnAyOTY0aENzU0J3YjFGSWx0aWlLNDRqZ2lEUlFDNERoaXMw?=
 =?utf-8?B?dEZUR2sxdzhaWENQbjA4bGhFOFZXMUJESCtQU2E4azY1ZzZ0S1VSMUpNY2FU?=
 =?utf-8?B?dlJ4cUI0Qjlaa2lGWEUraC8vVEt0dGpLWmxSQ3RnQnYxaGVNZHBvSlNXbUtQ?=
 =?utf-8?B?UVoxemQ2dzBTb21GcUQ5dWNxL1JZM0hiVzlVc2gwOE80NXhTMGFKblErZW1C?=
 =?utf-8?B?N3dPdUpkMS9wV1BLOVVKT28zUGxKRGwwZTd3Njk4UGdzSUQxTFpvZlB6RjQ0?=
 =?utf-8?B?Y01RcklGWlZkK0VyNVpUTW14UHRQbTdBdTVzMWdDeGVicmlGYXYzUGdmSGdw?=
 =?utf-8?B?MXJNL2RSS1pyU3ZtQXVhNyswNWZnYitBQWt3Q3FZSFBzRzRCbFhGTXFNUitk?=
 =?utf-8?B?OXljL3FEbDQ2YmEzeFpVdVhJMndybDRBMVowTjZkZTY3WHFXVkhBb0o0Yyt3?=
 =?utf-8?B?c3pOVm1NSWNaeU1KSXVkc0QyVDBoMkJsYktZYmM4YVEwUHVndEZvUkxlbFQ4?=
 =?utf-8?B?dXordm4xL2pmNkR2ZHBFM25Bc0xNcFQ1MVNTcWNBelc1bFl3Q05FdWFLaTBs?=
 =?utf-8?B?QSs5RWpObnBXdVhmRGlEcjdaU3pSWWRJcnErbkNXMTFQa1JxRXRZcUxMQU9j?=
 =?utf-8?B?UEgzMitJZVU1TnMxT0k5Y3RkT3dxL0VIYm5UZkNQc1R0MVpPSm9naEVsWS9o?=
 =?utf-8?B?RzI3WWxPeWtUOTVXSktWNGRvY29XMm9HOGp2QTRjQko4WDc0azVJaVNxNWJK?=
 =?utf-8?B?bk4zSlhHVmdpK2JNMmYzQ2U4U2J2b20xckkvNTFCQjVRKy9uVGg3V0dacmx6?=
 =?utf-8?B?aVBrMFVzM0tFUmR3SWNNaC9aUkRSckVaSmVOVkIvVUZEZ0dwMUdkWGFPTW9V?=
 =?utf-8?B?Q09lWEV0NTdHdDBRMWVlWkh0bzE4eURVRStXV0dOYTdhVDE0SFg0VmZLejBo?=
 =?utf-8?B?R3NYLy8zTU9hZGw0bkJlbG56dmZEaEhmSjBqS2tDR0g0YzVUSnRONk04eld0?=
 =?utf-8?B?SVRONTlnTGZvRTNIR2dTUmsxajVEdkxBQmM4dVZmdWp6MEZwOWZFcjNYKzZR?=
 =?utf-8?B?U0dkakdEcEJ5OGR3dnhRRWtSUzdFNG1jd3k2cDFMSi9NdVJRbm5xUUtvcnZ0?=
 =?utf-8?B?NXJDL05yZ3piMVJ0aW1YTHYyZVYyWGxhZnZvbm5ZQXVzRjlQcmhKSStsN3pR?=
 =?utf-8?B?dVNJZDZEdCt4bWJVY0lveTd3YnJJbXZiekV6ZTU4LzU3aFp6RkxBYVBIWVp5?=
 =?utf-8?B?d2pJd1pKQWlrQzdKSkVId1ptUFdmRmpTbkU4YjJzVGZMUCtTeUlmTGQvOGxi?=
 =?utf-8?B?aGovMnVacGRzVCtsNFlYZ0RGaVQ2VzRBaVJEVG50ZHVZdWVYeG5nVzdmUHln?=
 =?utf-8?B?S2F1THRMcjhoMEpOc1VZc05ZcXlDdmc0UlBsc08vcFN1WXo2S3V6MjNmb3dG?=
 =?utf-8?B?cmNUNDk4VG9IWmwrcUhkL3BQb0NaME5sMDFXdVJkaVdycU9jZnE3eDkweEZo?=
 =?utf-8?Q?iN+iT4ks1RTtt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjBVV3J2NGt0MmthU1VESk5nWnNmRm1WT1FSTFdVdXcrL1ZPVWRCUkg4MGha?=
 =?utf-8?B?Z2UzOXVoTTBCMTMyM0ErUHVrUm9VUE83NUxkM1UxYVpZZmdJZTBJdXpsY2pn?=
 =?utf-8?B?V0tDM0R4SGNyQVQyVk4vTEJrVWNRSXhtU2QreVpCWlJ2TXROOXpMeWhQeTJx?=
 =?utf-8?B?ck9HOE8wNDFqU2VBYVEvbUZJaTBnRXhRRWhlZmNWL2YydlRTNWRiNllmbGRj?=
 =?utf-8?B?R0NZdTF3dEMraUp3V0Z6TE95WDB3NmRobng3MW9ZMWN0allCTkYybTlmcWRS?=
 =?utf-8?B?bWdzS1QzR1BlZklWNFV1eTdxdG5mOXk1N0RwWmw0QXJ0d1BOYWpjaURwZGVM?=
 =?utf-8?B?RnAvelMrdWxIYndha01mVHdUZkxGbWpYS2JrRWdlNWZud1VwWXE4MFVaMnZy?=
 =?utf-8?B?eThOTnM5bDJMNEw5Wm9uQ1FOdEk0VjVGRlRFM0FIaFUzUFlvM2I0VEovTU9B?=
 =?utf-8?B?OXhseWRjem5oSE9CUXF3UVFVeTVhb3pKY2tvbll2Q0hJbHl1cDdLejdRYTZI?=
 =?utf-8?B?azlvUVBLU0dyU3VUaWVMWnl6T3pMMWRPSm1ITU05MnlXYWpvQ3NtWnQ5S2xV?=
 =?utf-8?B?ZXFnMXN6T3ZUZWhtaVdrRU5FeHlZdktJbHcycFdSdHRVK2NOVHh5cVczVDdm?=
 =?utf-8?B?MzhYUzFDU1RDdzh5WWpNczRqeEllSEcxeEhFY040MW5oaENFeCtzSjJYYWJ1?=
 =?utf-8?B?dEZlTm40MTNaRVVxZ2ZkcUV2d1JndVJ4dlFELzE1ZEsybDc4MUpDY2Z3L3Y3?=
 =?utf-8?B?c3pUeXJ2cUZBV3p4Yngxb1RWN2FpTS8zYzRERExDOUIxZXZyQk45L1lsbkti?=
 =?utf-8?B?cS81VHlSc2Rab0xpUGJpS25SRmt6WkJPUEU5NDY3R1A1aEJQU1dUVndiRUQv?=
 =?utf-8?B?N08wL3hidUxub3BJL0RseFlMR1dIU2hOdmpDcStWaFVucFJBZmxoY0t6Uk1W?=
 =?utf-8?B?ZEs0ZHVGVklOUWZBNTRCajZMRlhPRjg4VDJaOXk5c3VNYjhOeDEvRnYvWSs0?=
 =?utf-8?B?V3Nhb1ZsQ3NWczVTRCtMdFN0WUorcEd5ZVpEdWx4M0NDQzlZR2ZkQ0xpa3RD?=
 =?utf-8?B?elp2SGlJTmR2Mk5CdlF3STRiNStFZGRsOWNnd2F1ZkdCQU1rcFkzUkRHSzBP?=
 =?utf-8?B?VXl6TWhKdWZxdFJvQWtBbnI4eThzdlcwNCswM2tOWmUrU0NVcHkzMjJXWExB?=
 =?utf-8?B?WWNGWlFZWHAwL0tFTTJQbUVtRmFibDlXL3BLOUdvRmYzeURuNE1DYTVUYWtK?=
 =?utf-8?B?dUh0RHJQRFBPRmY3SjFTcjFSMjFrcmw0aFBhdmY2WHZPYjJLRENSaXp6eDU5?=
 =?utf-8?B?TGtuVWl2S0JLK3ZCYnRqZWU2Slk5eDVXRGR6Q3hseGdRU2ZibFN4b3lYWnBt?=
 =?utf-8?B?aWhxZU1mQi96bUQ2U2FnTlBNUVFxakhLSHpyNVRCdEJtNzNrVkhKcUp4MGl5?=
 =?utf-8?B?eFNQMkpGdW94ZC9ZelRmNWplaGZFYzAycnBweGNwMFQ1VlhoSS85WVF2Z3pL?=
 =?utf-8?B?QWhRbXhFbGd2VUZUT1Q0RjZDSWhqQUFwVmxSTUF1SFVlaHlKeTUxVWJZV1lm?=
 =?utf-8?B?N2VTUkxjOXlJbjhRdDZqWWhZaFJOaVJTRG51eFgyaTZUeGl5eU5IQXhjN1kw?=
 =?utf-8?B?NTcreElGTDF2MUg0L2NQeVpaZ2JRbzlUUW5DVVBKUGJ3UVFBZnZoSmJ1cnhP?=
 =?utf-8?B?NHRpNnRSNzB3S1VZVk5pKzBZaXd6RkNiTHUxQUswNnVJaVFNNlRRMFFFd0Uw?=
 =?utf-8?B?WGtEbXIvbE9JcVlna20xMmFSR1dEQ3QwTnJoRWhYaDJJdnE4ZWJhRnNIU0ph?=
 =?utf-8?B?YjBFbmgzS0pEZllQc2ZnZGNQaE1LaDJ3WGprZFJzZUt0bTM5eVB0SmozM3Bt?=
 =?utf-8?B?UTBLTGNLY3lEOVFDc2ZPWUcyT0ZiYklHL25CQlZUQnBhNG5teTJIVzZDMWZy?=
 =?utf-8?B?OUNBaWtXdnhpeXVRZ1FJMDZkNEVLNG1yR2lkTG1ZRkViS3ljV2RqZjhFaTdW?=
 =?utf-8?B?NDZnT1JpWVVwWSsxU1lUQURrSFNxZmNEK0RDa09kMkkyQWtHRHJ3NU5FOTd6?=
 =?utf-8?B?MCtqMmZjOURzajBlZDI4d2F5bXk5MXd0QnR1RnFTMUYzSG9FZHlOeHlqZXhm?=
 =?utf-8?Q?i3kyv8kSripWLpxTZYo2j005R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a728cf7-73be-468f-e25d-08dd5b92c987
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:06:56.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Px82xNMyAxQ4dqtgdcG3I2/dV280h9QLa+W6tyNuFa6g8swMz4BNgfjqilXIGSUw2z53ZEWEKj3q8hCoJBmn/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8741
X-OriginatorOrg: intel.com

On 2025/3/5 10:32, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, March 4, 2025 8:08 PM
>>
>> The current implementation of iommufd_device_do_replace() implicitly
>> assumes that the input device has already been attached. However, there
>> is no explicit check to verify this assumption. If another device within
>> the same group has been attached, the replace operation might succeed,
>> but the input device itself may not have been attached yet.
>>
>> As a result, the input device might not be tracked in the
>> igroup->device_list, and its reserved IOVA might not be added. Despite
>> this, the caller might incorrectly assume that the device has been
>> successfully replaced, which could lead to unexpected behavior or errors.
>>
>> To address this issue, add a check to ensure that the input device has
>> been attached before proceeding with the replace operation. This check
>> will help maintain the integrity of the device tracking system and prevent
>> potential issues arising from incorrect assumptions about the device's
>> attachment status.
>>
>> Fixes: e88d4ec154a8 ("iommufd: Add iommufd_device_replace()")
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> cc stable kernel

sure.

>> ---
>> Hi All,
>>
>> Alternative may be just allow caller to replace device even if only its
>> alias has been attached. This can be done by a few line of codes. But it
>> seems more reasonable to fail it. So I chose to detect and fail it. However,
>> let me know if you have different thought.
> 
> doing so breaks the definition of replace.
> 
>>
>> Regards,
>> 	Yi Liu
>> ---
>>   drivers/iommu/iommufd/device.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/iommu/iommufd/device.c
>> b/drivers/iommu/iommufd/device.c
>> index 4e107f69f951..c66bb9ef5465 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
>> @@ -471,6 +471,17 @@ iommufd_device_attach_reserved_iova(struct
>> iommufd_device *idev,
>>
>>   /* The device attach/detach/replace helpers for attach_handle */
>>
>> +/* Check if idev is attached to igroup->hwpt */
>> +static bool iommufd_device_attached(struct iommufd_device *idev)
> 
> iommufd_device_is_attached()

got it.

>> +{
>> +	struct iommufd_device *cur;
>> +
>> +	list_for_each_entry(cur, &idev->igroup->device_list, group_item)
>> +		if (cur == idev)
>> +			return true;
>> +	return false;
>> +}
>> +
>>   static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable
>> *hwpt,
>>   				      struct iommufd_device *idev)
>>   {
>> @@ -705,6 +716,15 @@ iommufd_device_do_replace(struct
>> iommufd_device *idev,
>>
>>   	mutex_lock(&idev->igroup->lock);
>>
>> +	/*
>> +	 * Device has not been attached yet, replace such a device is not
>> +	 * supported. Fail it to prompt caller to use the correct API.
>> +	 */
> 
> Just remove it. It's same meaning as what the code tells

sure.

>> +	if (!iommufd_device_attached(idev)) {
>> +		rc = -EINVAL;
>> +		goto err_unlock;
>> +	}
>> +
>>   	if (igroup->hwpt == NULL) {
>>   		rc = -EINVAL;
>>   		goto err_unlock;
> 
> then this check should be a WARN_ON().

you are right. let me add it.

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

-- 
Regards,
Yi Liu
