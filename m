Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D7189902
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308338; cv=fail; b=S3nag/0UFXrNNrxrUTxALMDrRmeQLyKpeVqRdyVqDnbKnEPASHbWzyFUQowr0NkEvdBaAKkRFu0QVBX7yOb66U/NmYORPMnhOQa5GloUGia6Qzr8KZww1NAnugGVJHBgZHZMJldB/wlmxd9ZTaN9RbeTdUY1BKZkNu1CSNqrhfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308338; c=relaxed/simple;
	bh=NBYqdp/HiJNoAb2xNblmmnJm74N2H1wWzxpucHutgbk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B/jSrDWVzMBGYrjUFMg5NqlAlh61HxGXd25uh1bFoLb4bwAG529PlNHNQvjHZx6/4kwXM8JAxfr48DkPr5LVpWO78gpYHmaoyH+U0kMe6KTT/pNiG1/8JK+ZJcGgr2p+1S0TXabDOrZ0xaGPzgMsR+NvUE5ZvIxEM1VjAyaQozo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2XDW8xP; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2XDW8xP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742308333; x=1773844333;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NBYqdp/HiJNoAb2xNblmmnJm74N2H1wWzxpucHutgbk=;
  b=d2XDW8xPb3y0kOaE0qptanaqfsDA6E92oWnj4uar+MuCgo1CbQsW0v8t
   ThcU4SbYSG7A2l+F0AFkJtfO0LooUD+FSztOYQn9R3ntLrGDY89ManCAp
   kAeexSPbcxgZUNWBgQ/35i0bcLaV8Hd+UQ9DuHrYBolvNWZSEeIoVa/4d
   m9hGW9NDm2D2sFqt57aLOfHb+SFzBeFLDob13IXXQQ/+8luhJUA8hYQad
   kgYs1HVMDLZD8H2CQNUb0wiIpmEsDyB26S+dzlrXbfTLuT4HDmU1HlzLm
   WgWrD9J0NZhScg/z+kmeHK+LYUlla7ZsjENOep0oXo37njezBeizMpuz+
   A==;
X-CSE-ConnectionGUID: lvdUCV2eRvWpLzTX8fy2LQ==
X-CSE-MsgGUID: ai1PrIsbQCahDw8Yl4evXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43371166"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43371166"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 07:32:13 -0700
X-CSE-ConnectionGUID: 7QMCHBLUSBScSpyzaL/HIw==
X-CSE-MsgGUID: mGaBf6VUSvSS6XOuick9Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="127325775"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 07:32:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 07:32:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 07:32:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 07:32:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoidT+JtbkjJOGtn3QT+F4spRbdgrKnhRq8lopWiJl0irbVOpXc8Tc+8GmaEvNJF3qEmUQO/mWWocLUJxyZSxKM5C1Te18HUjo2lUvYIXDN/ksx1RqXIR6HaMeoF3Q6wNbhIBp/52BR19BJRohTQIK32vk7roYCts5e8RqfnKeiucuG2XHE/L/M0Enq42QoDFcZ51QChwedoLCeLYhk971Fk3EixTak97Y8Zvcbi0N1iH11L9U1qj6ZC4k1iYB9Cw0TKdKgd6DFelLPHcf19nEGWQ2TFpCp6WWWLpxyBPlac/hti+Lw3a7r8BKzz2EWDla57HHLtcL4X7Cd+y4MCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAqLorbcFyPqwYy7NoEsibwavGD0v1Ll7KcEqq9FCe8=;
 b=RTaIcIJhyMnl+EPgRc8o1oIVtp2f2WvVa5smzlt+5EDmWx31LfZUijrgDugDGm0bLA33I2mdPsEf1f0NVXuUHu4t6qFr4cwsshjF4BHumDUJ4wJ3s1BSINqNCjSUS8nxc9Vr5g5D5ees/KRpywFmoXad1Cu/NuDoeeZiDipNfpMZ9tRlPzu5uPHdhUCt7KM/TaiLx9AV0zcjLrbR29yIXMIGpUnNGq4nDejLI8TsoOvuK9092ZrPfvL6Zsu1V6YbFJdFqcG8aWrWIjgVDvf9WZUzwcg8ZGyRojfycvYKGLVd+z2/fZ0faYPoH/BmuGFZc9Bfbh8jZASCkKwShXg9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB8702.namprd11.prod.outlook.com (2603:10b6:610:1cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:31:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:31:55 +0000
Message-ID: <a446b705-b81e-4203-ba9a-2c72e52f5643@intel.com>
Date: Tue, 18 Mar 2025 22:37:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/21] iommufd support pasid attach/replace
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250318124141.GN9311@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250318124141.GN9311@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c94c70-080e-4351-429f-08dd6629a1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTI3MVR2Z1BMbmNyUDM5WWgwR3I1MEtZTlhNSlZidnJZaHhMM2tva0QwdDlR?=
 =?utf-8?B?Z1pJV1EvYjQybXNTbGRoVGdRZmRicnJSNjEyT3hJaSttQ216cFYxRW02dnMz?=
 =?utf-8?B?cTh5OW4xZGZ0RWJ4UWlFRTJhVENjeTllVmhRRlNSL3pOTGNLZ1kwVmE2NzZy?=
 =?utf-8?B?dTNldTcyZ0FoQjRIZCthdWZLbldnR3hxbExHdjJPSytDSkIvMkEvNUhjWks4?=
 =?utf-8?B?RVd0aW11bldtaDg0YktwR0psVGRTYlROa1BDNzcyVWFCbkM1YzllenFDKzF2?=
 =?utf-8?B?QnpIZTNkODFqOE01MUdkMWFsTmZzNlpRcGhYVklVbXhKSzlPKzJiL0R6VndV?=
 =?utf-8?B?cHdXdEtKZmtxd2EzSHc5enkvQjNhNWRBdEV3RjhWaVlwVUdsTEJ1YUd4Ky9l?=
 =?utf-8?B?LzlFdHdyVlhkUXNoTFRiOCsxWFJEajBydEJTSU9FRzBhSnBLRmFycHlZT0Zu?=
 =?utf-8?B?eHVTVzJ4NTZxSkp0Tm1qM0paUTFCb0krb3dHTmhjdi9hNVF0VUZQbHUzeHdK?=
 =?utf-8?B?aFRyRE5Oc3k5VkgyRmQ2MHVjYy9vWWxLaVcwT2RlQ25lYTJZaWd6TUhjUlJL?=
 =?utf-8?B?NGpRaThDdExzN0NkRmFEMlB1ZHl2RzNWMHBCSzFhU2lxWHQ5c0NYTVZuLzhM?=
 =?utf-8?B?TlBIOUNQREU4QTZWVWhxRFJjYkFFNWJBU3I1OER0d2JmZTMzWDVtc1A0TG5G?=
 =?utf-8?B?UEwyQ3dIRjNZYWVBdVNrd0VSeXg2alM2NnFUZXc0TU1pWlpkb1h5WDMxSlpN?=
 =?utf-8?B?eUxlb3lRbDZFWlJwQnU3T2hQdUM2SzZYdXkyWjJZWGtHNjRQN2JhY1V0Skhr?=
 =?utf-8?B?RkU0M2NNMGRkeXlIV1ZXYk9GSndDUHk4RXpFVmxDRXVHcm8yYzkvbEx6cTlC?=
 =?utf-8?B?aTRncHdLNU1Eam52cEpNV3ZSaTVYQ3YydXBRTEdqaG5xZXFUSlRLZ1VyeFhD?=
 =?utf-8?B?WFZ0cFRzNTJMVWR4dFllbzRNYjVoWUczcnFrL2dpdTBGQVpINkpiajdTUFYy?=
 =?utf-8?B?dW1rSDVpTmlldFNJa1VEd1RiSHZOVWtTWjlKUktiWU9EeVl4YkNzb2RPSjhW?=
 =?utf-8?B?OFJVc3lhK01rWWwycjJZdGIvelpYK3BKRHQ5VUd2Um8wWXBFRTRGNWhxN3Fr?=
 =?utf-8?B?NndpdHFncE1qVmgxZkJvY1dLNjhOMUlGUUd0KzFiZ3k0WmFQTmFlUkQrdkxj?=
 =?utf-8?B?ejhTU0luV1N1d1A3ZWJaQjYvQWx5aXl6dzhXenViK1BhTHhyRG1BYWJvWXdx?=
 =?utf-8?B?QVVqZ3ZEaDBqWTduQjhwaXBwMks2MXhaeWdGRmYxU3BQZVFlWjVMUi9SU0ZR?=
 =?utf-8?B?SFQ5VUVocCsrdnNtYUJNbzZQMmZuVTdOVHlWSi8ySlZmMGFST1RwaFNsTEd4?=
 =?utf-8?B?NG1CbUZpMWFHRmEzMEZNU3pSdDZybmdmTnpKODlFRHptd1dQTzBnd3ZTTUw1?=
 =?utf-8?B?aXZMNnFtV0FLdVNncjE4NmRlOUl2anBtb2RzdzBDTUNrOHR1c3JxanBxbDV5?=
 =?utf-8?B?UjlPZ0tPbnRDNzlEc3k0Mm9EeUU3SExGSG5aZ2lwN1JDQ1lFQmZFdVRxUVlK?=
 =?utf-8?B?alk4UnljZFNTWi8vMHBsazBQSXUxMS9PQ1hjSU5wL3k5TnY1clE2YXdXTzd6?=
 =?utf-8?B?VUFVVVR4QlRBSitFYXowb09uVmpzS3ZETE85ZWx3LzQvdUM2UFRXb3hDSmxG?=
 =?utf-8?B?NXR4VUVOMmNxcmNEUTBzSmU0eFZQSFZKSVhEa3picUtKSllMMzF3MnhGdEdr?=
 =?utf-8?B?dnkwQjQzYlU2UjZVQmtzenpqMmE2YTRqdEthTU5LOGI3N1FFdVNkeEY2d05w?=
 =?utf-8?B?b2dEMmtlSWpETzNGcE5uNTJVbSt5aDF3SnUvOTBXZW1ZbmdMK3VKR2k1Yjl6?=
 =?utf-8?Q?Tzw0v//qwuaK5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3FmRlBXck04T0hLczFOUkZpb2R0RGY2M0tvU3g4RnlaTU5USW41MHlrR1V5?=
 =?utf-8?B?UnA3R2l2R1R0Skg0bUZzczlqUkp5SjJqWjhqemNzRFIwSEhtdlhnZVRRV0dQ?=
 =?utf-8?B?ZzNyb2lHTVoxNzZtcSsxdUJ5ZEVPcmM3dkhxVG9hYU9ZWm0yWFRvNTc3Z3Ux?=
 =?utf-8?B?ZituWnlJQ2l0TXFoZkpMbERXQ20yeTJKN05uaGJQc2QvMEJWRXpTTUNNQUJK?=
 =?utf-8?B?ZC9PSTNUd0ZmZjFwb05JbVM4UDBNMUwvcUdqTTVXQUx6c0REUHBNMW5zUVVZ?=
 =?utf-8?B?OGlxcmU4SkhpcUJNME1JWXVxVEhNMkZSdnV2ZGRQNjVPOCt5WkFvYks5Q1Ay?=
 =?utf-8?B?RkZjUG9FYTVuMm1IZVZSVCtleDlhK3NIY2orV1ZpeWlzSGZPTm1FMEhYQzFY?=
 =?utf-8?B?RkY4bnF4MW9IbGNmUTgyV0tkOVdpa0oxMGJPUTc1N09jeHZSUTRIVUJXZU1r?=
 =?utf-8?B?Yk42TGU4RkNKeHZPSEdQTEtqUnpWeUExNFZnYVlWYVVlL3poaEF0eGVDOW9W?=
 =?utf-8?B?SDB1cG5DenBiKzdoQ01ZaUZWOGM2elp3WHl6dzZvUzZQTGdIaXY3WERLYjJB?=
 =?utf-8?B?aTBGMVJ4dSs2TkhmZE9kZUNvcmhFTmZLZWx0TEJ2SnJIRXVDNWczWDdTWG9y?=
 =?utf-8?B?czZsanJnWmtrVS8xR05zS2F3UzRGajFLUmFGMUR2RzZYeXNqMmVZWm5EQkJQ?=
 =?utf-8?B?T3F6ZjhnRUVIa2tYbm5MWDJXQVgzQldOamQyNUZ5VW4wYWRoMFpTN0NNSnRM?=
 =?utf-8?B?VHR2RHBKMDZvYzJWOExDaWNTMkVra1ZyeC94YnR2VS9DM21scjRaQ1hkTTU4?=
 =?utf-8?B?N3RuclJzMWV4bWtjNERoL1RNdnNOb0hvZUFiMUkyRDd1ZEcxVGcycmJrN0NQ?=
 =?utf-8?B?RkJNUVM0TVQ0RGNxN3daSGszODgzUTU2N2J6aVB3K0s0RnpCVkkvT3ZreTlY?=
 =?utf-8?B?YlYva1gzbGYxN2FzYjViQlc3SlBoam0wRitmQ2RMOTU3bkxTWDBqc29iTmhZ?=
 =?utf-8?B?WVB1SDZTdC9wQkRudjRySnZva1ptNDVtcGVWcjIwTDE5dFkxRUx1RTF0aFZz?=
 =?utf-8?B?bGx6c3ZvUFI1cUhmQ1NPTkpucFdZSzYrVk1DWVhVeHUwYlZyVjNNSVJCckI5?=
 =?utf-8?B?MndHYTdqVDB5M2kvL0ZsUUFKYU0xZGFJVEd5a2tqTUpXeG1scFdkVlRuNDky?=
 =?utf-8?B?dy9NRno0RXFVektJbyt3dXg2OVByb3BOa3hVMTJDWWlmZFR6NnNzU3BVSmdB?=
 =?utf-8?B?NGkxdWVlUzhianh1Z0RQY3UxTVQvek1zU2gwV1ZoMGw3ay9JWGRtdkthQXZy?=
 =?utf-8?B?VWRBT1NoUW9zVnU2UUhCa045eS9YQmJVN0hab3BWVGtXaXJYRHFibkFMM2hF?=
 =?utf-8?B?clZ3MFpyRHEwOG9laUpNU2tqcjRzVlVIMDZtRmlFOE8zdkt5RmRZWWNmQXUw?=
 =?utf-8?B?elp4NEgyVGtiMTg3WUJTcGlTRHdJY0VXQnliRWxwbzdUN3dpNTYxNmI5WE9B?=
 =?utf-8?B?amFZeXFqdDJOdEU4OEVtWUM3RC9wV1VmN0ZoaW0yZ3NyQkIxellhVE9IRTI2?=
 =?utf-8?B?R21TZHBmSFhuSUdxak1RR2gvMGJ4WGlySjJMeUU1NDdzOHNWUm9xTnoxUzJ6?=
 =?utf-8?B?VWRIY1RpNmdad2pyL3VWYmRuRXBmZjFIMmdrWWhoUm9ZdGdhbUw1QnpiSlgy?=
 =?utf-8?B?OWppb0Z3dXRuSzE3Q1didHRuMC9xbXFndTBPQloxM3RVeEZ2YTczMXNRK1ZU?=
 =?utf-8?B?VkNoQjRtd3pBLzlIR0dDS0hRWVdvRHZzSEFaTW42eVBMM0tVVERTLzRkTjhN?=
 =?utf-8?B?VC9EeGRMTGJFdzRrdWMzZVZCMGMwaTE5dlRCeWFTSmhmK28wZnJNMmlpd3hX?=
 =?utf-8?B?NVJzajY0SWMrMW1sZFNKYldRMzRDR2dwSHpLV2diOXp6K1FQOFFteXRjN0pV?=
 =?utf-8?B?M0tKb2hSNDY2WVRmMXk3VXJhOUZkQndLblhHcUJtZ1ExNC9nQmE1d2ZleTQ3?=
 =?utf-8?B?b083RmIwVmVoYmVSNUZWQUxvQlpXa0czK1ptdnZRUnp1VnZQcll4ZVJMVHVt?=
 =?utf-8?B?VFovMTZJUG5BTGZiTHJjWkZKbTN0SGc5UHNjU0pSTnNsUW5TRkFwUXFvSElV?=
 =?utf-8?Q?H4pIIPoBNgRjb/9sNbgV/cdyD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c94c70-080e-4351-429f-08dd6629a1c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:31:55.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hY1V5eZw0jC34JcQzkt+xkf/rtUmDDoqS9sXS4vxP4N7z56kb8zZT+25QMx0CWO8bhS14X5v8dxsQu8GpKBzqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8702
X-OriginatorOrg: intel.com

On 2025/3/18 20:41, Jason Gunthorpe wrote:
> On Thu, Mar 13, 2025 at 05:35:11AM -0700, Yi Liu wrote:
>> PASID (Process Address Space ID) is a PCIe extension that tags the DMA
>> transactions from a physical device. Most modern IOMMU hardware supports
>> PASID-granular address translation. This allows a PASID-capable device
>> to be attached to multiple hardware page tables (hwpts, also known as
>> domains), with each attachment tagged by a PASID.
> 
> I'm tempted punt the error case handling for PRI flushing to another
> series as fixing it properly looks a bit big.. Maybe just code this
> series to assume PASID attach success for now?
> 
> The attach handle locking thing needs fixing, I hope you can just
> allocate new attach handles and not change that design, drop the first
> two patches.

yes. I think the PRI path also needs to consider the multi-device groups
support or detection and the DMA alias stuffs.

-- 
Regards,
Yi Liu
