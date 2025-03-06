Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73609195FEC
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 03:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741231510; cv=fail; b=LlUMdjRz2eJojWWcYFOcuPdnwY6OPGSZUdbJJG09+FWOxZgicoc+HFUnKKsGst9laXXmkN6sMr2rNJv+f/JqJuPKFC7xCulU6KUba27j2YDVisJnEdWS2ZEJANK1QZ/crSYzYZ5yizIEbbvxtlfgnM1jriYDHIlRHusd6Hi9lQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741231510; c=relaxed/simple;
	bh=KuorWql8jh8gLzMvEgC09uOMNfeKfHgqfFrCeAsE8Ck=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1lmhmzOs5Jz1RtDyLPMIlK3gmJF1WNeWA+UrhG1llTbleWb/EylcW9RNDCuFelpPUe0YMLwN8jjcJMS5i9npOA9OIxLkDeBZjxmJIIjy5fDJr79RYkSzD7yqT03zuIrUrrSuMPCesSp9t2XxINoJ2i7WYdqhGkhtjpw0a+bpjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OA5TjDXq; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OA5TjDXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741231508; x=1772767508;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KuorWql8jh8gLzMvEgC09uOMNfeKfHgqfFrCeAsE8Ck=;
  b=OA5TjDXqtllBmxmyvaE6alSxNmRYfc1+yW2Tow8vRmyNms/hOO49GLb6
   TjBUSXtDecD3BSEk59/CW/IZx3zqSRo3zfvOcyjCm+zvqhrsnutVjfdXd
   QRNo06r/8liLUOi/s680PzN70d8J/sUSiFeshjXV9G68eGwVmiduz7YZt
   rsHkcunGVgKBAoNoRUyvdHgA710e1hd1bIBaL4WvOzOHnPkBBgb86Lksc
   CNJZyt5dbI1yK3vIbWzGNU/9QpXT3PLDbniAanNnyAs3osj1hRVBTnsFD
   a70NqP3RZktVfDw8kktgqSxoler4FxV3aCFPE7U1J7XxqoYvXpBgowu//
   A==;
X-CSE-ConnectionGUID: ylsaNZtMRp6k5oqZyNPt5A==
X-CSE-MsgGUID: SmCIehtsT/29MzX5pNT/SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53625885"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="53625885"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 19:25:08 -0800
X-CSE-ConnectionGUID: 2IC0gq0TRqybf0eDnJB+Lw==
X-CSE-MsgGUID: +Hvi4fk6Qoqyn+h7f68rPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="118608578"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 19:25:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 19:25:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 19:25:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 19:25:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2dnEOih8k3unrY2laNJDnXfU3OcE6Q4BXaydtKAiJ8+uj25gAopW/PnWCmbkSNMOcNHAA3PlIlG6mY5fcvGhzPktHfUE9jahyfni2GeKrPmw2JC4rt+fTy3H9Mr0vMuElaTCEWKzfCkJwvC+KdveXuyhqj5fC+wv3wswfGPrnTzjTc7pcu+F+PD7vRTOSiksPUz47IvrJ6JEQr4jGm8C1CkyPBcX/jiqdKPo6B0RL1P60SF3/hTBxDsZT38mDNOeIzHTzDGMGV62LoNiJvOtYDzM51SLNAbHe8mGMR2FXjpM52pkIEqCmtweJPpKYv5sqLNXO+dFWeb9jMvoE9a8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUe/CfMRh2mVuRykpnX6r+7frQbIPk1JXKcsSi7BF+U=;
 b=K/pUQ+nw7wmTBytCqEjWOFvAJV6mOFaYfq/VcIecNGRo0JFg62Nc4JM1Uwe9OqSIvJKghhBrpp0R8607S2HV+QPvLfBICs9TwBYtifZ3nKjDBbr/keq/hbYkK5QG307RGMODuUzb/07j4PsJsCEDTNOj/e4kmzqr/MV/v2VGaTA8yj+vrxP3ENh+zejB77JkUhscW2cJnyDvhnjBG4dCiJcn1pIxqcoRJp9N3/uE1YWKFjOKoX/XH0tAo+12EFizbjOKngWkzsCJkJeOZUGJL1j0gSNorsIPvmDNlozCD88/KnWKgBx194Fmz7Nt4ZXfREgr5K2OViGbxU1KRhktfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 03:25:03 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 03:25:03 +0000
Message-ID: <d4da9e8a-e393-487d-ae4c-892fc139f2b3@intel.com>
Date: Thu, 6 Mar 2025 11:30:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250305130356.126424-1-yi.l.liu@intel.com>
 <20250305171838.GC133783@nvidia.com>
 <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2b58a3-993c-4021-275d-08dd5c5e7b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTFxaHVvVGFrSzFuQS8yaUVSUDBjTGZ1MFBFczVhNTlyVHNXRUVhQVAySlk3?=
 =?utf-8?B?ZWdjVG11VFRmOGQ1cXF5ZmRRZ0I1dlhFSEZBT0U2aThLQXNPNTNQeXF3OFJK?=
 =?utf-8?B?TmVPVldRRVRCb25RamgvZXBjczc5cnNIdy9ZWjdzdnowYmtRbHBxdnRPaGlu?=
 =?utf-8?B?cEZod3N1QzRBU0dUTkE3ZU44MStUWnREdVp5dUtrZk9ZQ3g3WGt3L1FKcmhK?=
 =?utf-8?B?cjVFZjRZMit1ZFhUSCtWTnhEaDU1bk9NblBIcTBIU3BiQ3Nsak53cmhUand3?=
 =?utf-8?B?QnpDTnU1Y2pUczhEY0tVd0ZrcWFmbDZwMlMvVFpnZkJtWU9yNVZJdnRINEZR?=
 =?utf-8?B?MVdHZmJqejBVdkpJR2dISGh5OHlpUVl4UmhsaUVZQlJWUTlIMzd2N0NiOWJo?=
 =?utf-8?B?MmRENVo3L3FocEk1MlgwWXd6bnc5MkFRVHlPWjZ6L0QvN0xxKzN6b3NXQkg1?=
 =?utf-8?B?emI3VWFCV281Nm9yN3lIcFNLN3pwd0crSklHOHVpcmV3R2ZaVGlVZGRYVHNH?=
 =?utf-8?B?S1dyWmZPMTNOWUZ0ZHErS1pjdHViYmFIYmZrckJHWmZDNWJyWldUczd3QlU3?=
 =?utf-8?B?NkIveTBnK0VzcStxdDFvQ3lBQUdGTFMrTVFwaVZadENmZVJ3b2ttT2kraGpT?=
 =?utf-8?B?SlNZbGwvK2Fldm9SUytXeTQ0T0hpM2lmVnFxSHdRRnl2bDdTWWowUC9ob1FQ?=
 =?utf-8?B?RVE4UHAvR2ZYR0Zsdm1Gc3BrMXFDM0ROS0Z5dDNVMkZQYWd6V3ZZNkhOWkNU?=
 =?utf-8?B?T1ZNVzhNa0ZXdURCdEgzSWQxYXI4N1pqNEwrK0kwNGtjZnNPSzZhbWtXRGNV?=
 =?utf-8?B?S3pGMEFKSS9vYi9OZDFqbjNKQldrUkxsRjhVYytXWEJ2cHpvZDFMM3ZuUWJ0?=
 =?utf-8?B?Y0hwZGRZc3g2dWoyM0hoVVJCcTA3Y0c2OXNINzhZV01EQVd2aWlFb3lLeUtL?=
 =?utf-8?B?UE9zT0Zyek9aZm55dTFMU0E5RnN6ajJKSlRYWlVxd09TamorOVptRURyaVN5?=
 =?utf-8?B?NmdIT1BncGZ0VEllMWNYVlhBbWp4WEZKTmNuMzZyNkJPenk4Z29iem5mR3Vx?=
 =?utf-8?B?VTF3QTRaOHNtdThtTEdTVXJnMTF0a1hlZUlkb0dKVXh1cXU2eXZ5b0s2Wk96?=
 =?utf-8?B?T21yUkJYUXBpZ0FYU2s1MGhERlNXL0gyNW9iVzVuOG4rbUFDUmFuYUNXKytn?=
 =?utf-8?B?VFJHdXhlQXpmMmlaOVdOdnZIK285ZWtNZG55by9DUmFOdnBhYWxEQytHZk9w?=
 =?utf-8?B?MUY2ZTJuc0E0VXFlb284Z20vUVl0cDU1TGRRbmV5OHhKVTRlRW8yVmk2dXp4?=
 =?utf-8?B?Q1RBdFJ6Z3dTU2gwV1FuaTVJaHdEOUFSa1VPVytPZUl4ZnplSHFDWDMyT3BP?=
 =?utf-8?B?VjVEMWNHWkZMZFFFOCsrS1Y2bWFPNFN3MFlsb3NQNWJzMkszSWdBci9SUHFn?=
 =?utf-8?B?aGVISGNhMk1haW1JaHFhbWI3NzBsRjFYZmE5eHdsTTZKeCtwaW55eXR5N2tt?=
 =?utf-8?B?Z0o2OWpWTVNxTUlqSjY3KzFLeG9rZi9IWHBmUE9UUVZzWVZiSk53L2JIMWNm?=
 =?utf-8?B?aWg1a1hMQmVvWkpoSzBCVDk3SUtIcGRDOUNuTHhhalBxQUlUb3BGQnBZK29K?=
 =?utf-8?B?eUdEN0dhYzh3bzBTV3laOVVxcTZtLytxSXo4d3Bvd2JJb0hNZ293R0NhNm9q?=
 =?utf-8?B?a2ZGcUYzTHQvQ0tEaEtvN2VMZU95S2pIa0JsQVp0Q050T0JRYWhFY2FoRnpG?=
 =?utf-8?B?bXd0U1lWMFlRN3ZJQ2g1RUpaUE9lUmh2azBweEw5Tm11TjB6VXVxc3hPNVVx?=
 =?utf-8?B?YlZyR3pnYk9YZnVvNGY2V29FQXl2M29oT1B6SzRKV0Z4aFJjdUtxWUsxeEdq?=
 =?utf-8?Q?xkCzN0kUgOmFd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MSs4WElhQnFvR0ZzYUJ5VU1sOFc2SXI5TGtGVWFvY0NNdzNpVjdYV3RPVTk2?=
 =?utf-8?B?WjFiSE5BOVVlRVdtU284MnJleFJKOUVKY0gva0ZCMU5OR0NmYUdqTTh1ZXpj?=
 =?utf-8?B?d29NOXhJQWVOaTFiNDRYS2c3ZWN6SG52QkViY0djY1hoY0hNbDBVVmw4WDFG?=
 =?utf-8?B?SUhNblRHVUpNUmg4Z3R2cmxRaURDSVZ1MWtoZlVhV2h0VFEyaW5xdW1TbXV2?=
 =?utf-8?B?QktaZ0YzUGFRd3R1c3BwaFpuRTk1bkxKTVROK0wrZE04TVZvZTNsVFF2b2Jv?=
 =?utf-8?B?My9PaHRER3VaM0M0Zyt0cC9QdWRjczNzVDYyajdVTWgwRHRISytrVENYam9G?=
 =?utf-8?B?ajd6cjBpUUNUUHZMTVJEZ01oL1BSczhITXRMSHROWktudUFJR3pvaUVNSDBZ?=
 =?utf-8?B?VENNRWJyVnpJdG1ObENWcVNUalp0dm5aVmMyUjI1UUNHRmZOc3hZTkJ3dkFt?=
 =?utf-8?B?Ump6ODd1M1RTcTQwd1NEQ3BkRmlZNHdlSlBtTFJmeWtudWhyTFA1N3VzVmFK?=
 =?utf-8?B?UFFkRVJTWFJUc3VuejFhSHBydWZwMDJhUDVYZElEdDcvZEpqZFBYK1ZlN1Nx?=
 =?utf-8?B?NEZuNlpyck1ROWx5NUljVWVMNTIrSk4yZVhJTVRBWFVHN3QzNU9aSVJHTk56?=
 =?utf-8?B?UXZ4cEU0V0J2REVlKzJ0bGowVHZmU216dllrcG9Mc3YxL21YSFdUbUF5TFIv?=
 =?utf-8?B?TEw5K0NkaE12am5yWnNOUzlUYnp3aHFYWGFtS2w3LzdRNTNLUFBTeTNnTitJ?=
 =?utf-8?B?NlhPVC9uVGdXcDN2Wk5iNEk3eWtBeVBJNldyaWpSUjFVWHQ1eU5sZzFlaGhi?=
 =?utf-8?B?aFh6a2QyajdqYklqallFenltRURjd3VlNUdQcDlGekhGVThwWUVyZmdqcHY2?=
 =?utf-8?B?dkdRZDMzTFRFMlZJQ0I5VjJNeTFGVWVxYm9KVHgxMmFoRlNhdUlXQjRLK29x?=
 =?utf-8?B?M2VFS1Z4TDI4OG1ibjYvUHZDZDJOT002SUJTUllGSDBLbFcwb1NveVdJSUdX?=
 =?utf-8?B?a1NESGFtZ3BObE4wbktTc1hKdThndkRiSTJQR0pVcVhmbjR6bWVkb2JYbEVh?=
 =?utf-8?B?WDF1SEhsbWxWVHNsQWxKY1E0V09hc1FYVG5BSmVzTUxwYUEvM01zK3Rxd0lm?=
 =?utf-8?B?UmgvRDFLaHkzZG0yTG4xeGRJWlE2Ukx3b0VqcFpHR1B0L0xpVHQycllrNEht?=
 =?utf-8?B?dTVOT0lwTUU4U0RKT2h1cmNDTGVEdW0reHJFY0d6bEIxd1ZXT2ZqL25JLzY3?=
 =?utf-8?B?RXdsOUR1ZVdXRnY1eks4ZytDMHp1Z3MvNytUQnJ5aElCWWx0RkFjdHZzVmxK?=
 =?utf-8?B?cERYVUhZWnd2SWtYd1VuQTdaWnRSMVBNUVJsOG1CM0UxN3kxUWI3dUxxalA5?=
 =?utf-8?B?amNVTGc0S2RKeUw5eXprWGJBbEFXb25aVEZmOVVpMkFiZDlhN3FCd1VTTFpr?=
 =?utf-8?B?eFdXRDc0Y3hHTkZIaytabUQwMTEzUE5iN21RZCtnRGtIN2czTkdSb3BaRklU?=
 =?utf-8?B?MGI5cHA3ZDc5Sktpa09la3RHRG9rTzQxU0dyYzdlamlSaWVyLzU5VkZoSWpQ?=
 =?utf-8?B?aGRIT3d4YksyRjBUYzJoY2hxUXBFdStjSnVBaGVybUcxUmR5cGJTTkRHNy95?=
 =?utf-8?B?UDBGUXN6QStJZDVnVlkzdExIdmFveW5TaVJRUnQvd3VDUkNVcjlqNjhySVFD?=
 =?utf-8?B?dXc4SFZ0dmNaOG96OWtxcjRRZXZQM3E4WDBGNUI0SERIMGZBNnNQeHA1SFBq?=
 =?utf-8?B?RXF4bklreWs2NDdHMFZtOG5SNjExdjY2alZOdU1DVE1YK2tZcVBzc3Zibkdl?=
 =?utf-8?B?WTM0Y0RHcG5IaUhzdkRtcmdnSHdweWVCL1lYNzNhdHh6WDFDMGY3NnBXR1pr?=
 =?utf-8?B?T2Z4WEdLL2tHcVFCWUpnR2I0ajNCcGZ6RjBKaEhoeTVtZTI5Zjkrb0JSUk9m?=
 =?utf-8?B?eWFCSlBaMjdDN0hZTDVIUzk1TzBmbXlFZmlnZUlVUUppNExjN3ZkczNNQkJZ?=
 =?utf-8?B?TjhDOUh6UU1NMUwzdHpEQ09kb0xJTXVGMXZFb0NpQlRwd3kyQW9wSXhRZGRG?=
 =?utf-8?B?cmxrRS9Vb3NmUnJNbklDTnpTVWZ4bUdYRzRyVGVWdlFPTEltTkNTd0JVVUxp?=
 =?utf-8?Q?kwRAxyo3ixOoW/akFO7QHa5tr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2b58a3-993c-4021-275d-08dd5c5e7b91
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 03:25:02.9340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IT33FxTBz5rTchI4x3EJJQU0kEChbNl4nWnbbLpSLjcHJg+rcHWo1LIKQvTcNietgJeLJW5sxwdkvMwJUAl5UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073
X-OriginatorOrg: intel.com

On 2025/3/6 11:10, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Thursday, March 6, 2025 1:19 AM
>>
>> On Wed, Mar 05, 2025 at 05:03:56AM -0800, Yi Liu wrote:
>>> Hi Jason, Kevin, Baolu,
>>>
>>> This is more a query, the patch here does not really work as there
>>> is locking issue. So I'd like to hear from you if any good idea.
>>>
>>> Detail as below:
>>>
>>> Existing code has a problem when the PRI happens on a device that has
>>> alias. The PRI reporting path uses the idev stored in the handle. While
>>> this idev is the first idev that attachs to the domain.  If the PRI
>>> happens on devices other than the first attached device, then the idev
>>> stored in handle does not match.
>>
>> Do you actually care about this? Can we say that devices that have
>> aliases do not allow PRI?

It would be simpler if we can enforce it.

>> I'm confused about how that can even work if the RID is erased in the
>> fabric, how do we deliver the PRI response to the correct entity?
>>

If the RID is detached, kernel should response any pending PRIs. If user
sends a response, it won't suit any pending PRI then dropped.

> 
> Another tricky thing is when some devices in the group support PRI
> but others don't...
> 
> I'm inclined to agree that it's simpler to disable PRI on non-singleton
> group, than trying to fix and eanble it.

yes. This also tricky.

-- 
Regards,
Yi Liu
