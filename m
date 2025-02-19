Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563451DFD9D
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969172; cv=fail; b=HwdkYn/+PcMnfZ+VXxDReTUw1bkufVrMI2brSCHlN5F0kM+Qxv6IQur6eLYbFfFoPbq1400YMS750FdIMJwlKqIbbo/P1jNGrSC7OhEwpiPrPaNQbtU85XU/NELLCdnmy+LMpeFQCL7XvFY55QcjU3Y8fL6ilc26loA/Pz/4b+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969172; c=relaxed/simple;
	bh=tkNZShfqBm+5VgmxPAdq6GH1DmQ7Jo17M2ZE6bIfej8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Szm7Nuko3uesp0FFwIg6h4xNur0vfTMhhdQM+5BeZVA88Cv8O9IUwkRJ44BAKUcyfvT8zhykyI+KRfE+i3DZsP0fjwtMEYCHRjrky3GOfAFRt1NibPfKUMnBd/616O59CnyaLByFQbSNeSJznfeXfil/MI1eLuIUbtSwhy7C+P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRCI83AD; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRCI83AD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739969170; x=1771505170;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tkNZShfqBm+5VgmxPAdq6GH1DmQ7Jo17M2ZE6bIfej8=;
  b=kRCI83ADJkpLFR81vXve7MeeDsDvlUKkkgxmD508xKBcLfXVVono0o7o
   hDbg3JWUpDzcziHuGSsooWL5v06B+TL8/mOAJ2SfOzSouBWtwMq0a+5xV
   qvkov7zQ+4GZofSCq3d7iMa8ExZMudd2xCoz5F3/WjxRfT+3RlmQEllXh
   x5EvYkYUR51BGI9jAFkSlZWtIcsiA6VBd4ymRxFKt1TkfZrWrxID0KXOF
   fH2LZoryggUYkfmblB1KMW8GF6uqtHdY6o6BT+i1BDyX8k3vpbpzWrrHK
   ChPmvhXqhFFIGFh6VkbCCgu9bG17UBnGT5gaMUrj99mYeY5pKcs8IrT03
   Q==;
X-CSE-ConnectionGUID: jsnOBsSzTYSPXduzYKtEXg==
X-CSE-MsgGUID: AYHNECqCR1CyIuWPmddIJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51321844"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="51321844"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 04:46:09 -0800
X-CSE-ConnectionGUID: Da5UU5EkSPWOBuhG0kBi/w==
X-CSE-MsgGUID: 7BohE8zOSZWgkbrX7t6plA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114684819"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 04:46:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 04:46:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 04:46:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 04:46:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUJQLV5fvlPIbsERK+Yiu+rWlusvmsasUy3DcbgNsbzG1iCIBEu4Bt/nkhfVMxlrXfTX+rooPy3ATp9iQ8l66NNnHY1NFetiWpdoGA32YNaokx3woBeTXZZlkKV74xUFFJ9fkfArby6mgYvwlI9i4Br+4T4osbvWVzN7Tl5fqV41S9fDWydRg37uZGAVanhE2bVzvb2oWjZECS9yLXymUsiHPv9SFrT5iCGs+fjlNBt2nNny6F6RL3OGBvCUnYbMVpGt3KgF+nuHT+SUZ1q1ixzP0adnDf1M9qPhx8bcAofxEpfDcxxBmoq+051YObj/oeSxesYdDFoVjX+zjpSNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW7/wRzI+F4pktb7HoBSL8VWJ6Rhh+Pac9onvroZK/s=;
 b=vYVnVZbKhXqiExKNx0NenCxOQ0zPYA7ei+AvWnlRGWOsOeB09/uXfMbX5GKIkaEkMMPQOncqTFzoHMOv69Rn3WnfujGd7uOuLzuN0ak/sGrM3AT1nVJVZDy5RdqwNKW3GmyxhFO++1q4rfbbNNe5y4ThB4iok+NwfXvQdfFBlzS3gn8b7UoBcwz1LdiRssflcy7IRqN+10MdIiWx6QNSmHSIMciMgI4cWMuFjyUroVTwltwzjCAMu9Px5Vn3K+IYv4QsuU1U/Sfl3D1qh2UjbJ4o/B+eDG7TN1CCD0s9hPos/jsjhu5AI/rfJkwGGl5qYSNVF8KIEnWgAVSW4Xf3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 19 Feb
 2025 12:45:24 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8445.013; Wed, 19 Feb 2025
 12:45:24 +0000
Message-ID: <e99759fd-ffcd-41c7-b960-8c4a2858ed46@intel.com>
Date: Wed, 19 Feb 2025 20:50:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: "Tian, Kevin" <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
 <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
 <95ab1ac7-f0a8-4b9d-b88e-72ce0d72ca98@arm.com>
 <deb77d13-5722-49fe-a5a7-8ba6bc370763@intel.com>
 <145b2f93-58b3-4484-b6b5-9216d4d21e1d@arm.com>
 <BN9PR11MB5276770D48B7B4C21A2BCB448CC52@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276770D48B7B4C21A2BCB448CC52@BN9PR11MB5276.namprd11.prod.outlook.com>
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: e16534b6-e337-4274-91b1-08dd50e34788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUsrYVdZaFJRTENpYjF4Qnc4YU1GNWhIYW9GTFd1ODdGYjFuODEyTDVOYmxS?=
 =?utf-8?B?ZzArY3FYeHp3YkxqOEFtLy8vK2dlL3Z4V2RpZUFQSkdDRFBXVnFKcWY3cVNr?=
 =?utf-8?B?SHdhNm01ZDJFeUE3N00xWTBqNW5xQkNZNUpZRWNEcm1MckVTbzRlS284OGVy?=
 =?utf-8?B?OW91N3p0M2JhZlJDS1FKdUxrK3BCQVFlK0tTM1NQTm5BYnFJeW12N2w0MlB5?=
 =?utf-8?B?NEkwOXR3azZYVGlTdyt3WGFmMGo2YlBuYmJwazZIdFA4NUN4YSt1YlRlaFNP?=
 =?utf-8?B?ZVhSdkpEeDBsUEVOWlNOYjFmelhkMXZiTXZabWZMZ3pHVG94RHluT3FsRmxs?=
 =?utf-8?B?L1BsTzVXNi8xbDRtZkRwR29aUnNaNnAxaXhvQ3JFZGtTQzYvaXlxdmNvQ3c3?=
 =?utf-8?B?QWFSMHNYUjJscENqRGVkSzlTUysySzl0YWpzZEhFQld6U0xRYi9rNEdoMzZr?=
 =?utf-8?B?VE5TSXRGMXcwaHZnM1o5eWR4YTJHMG8wSHhJVGlKTmttSWZmakVOYnYvUXZu?=
 =?utf-8?B?d1BzWDJ1YmtlRUVMWG5HR0U5REVmNmFyKytLbmVVMEpKOTJKelUrMGlLU3BY?=
 =?utf-8?B?UUdKZVJMOVNmRGFUWXc4OWJGRnhuRHkzeHlVbzFVWGJnWVpzWHBuZFRVRXZZ?=
 =?utf-8?B?b3A4NHRjZWVZMHhKT2VkWVNmaFpPM29PV0Jpb3VlNVZwZTMycFVEMTJLdzRm?=
 =?utf-8?B?TlI4QTdsQTVsVHVSYXk2RGxUR1dzV2JldkZTcVYrc0lOUzB4K2hxdDVlL2hq?=
 =?utf-8?B?VnlSYVJBSk9nN2lCOHViK2dWUXBuMWtibVh0S0pLTVAvRmFDSnhnNjNtYkVK?=
 =?utf-8?B?dVdTUkttUFFCNHNFWHBPazQreEduNHptZjU4cmFmRUZzbGFsazNTeWdOSklw?=
 =?utf-8?B?M09lblhkdWZQb2Z1YmUvRFR4azh3RnhMVFFRS2J1YlgxMTBlSzVLRXo2VTNr?=
 =?utf-8?B?STg5M1luaVFFK29LUWE1ak5DRFp6d3R6U000V3hUdTZTNk0yMUdCa3hHVHRk?=
 =?utf-8?B?Z1hEVFpPTyt4ZUVmejVQcmdVaCs5R2U1aDFIMTFvRmovSUgwbSs4a2N0N294?=
 =?utf-8?B?eUhqZUVDdHE2VitxNnZ6bU1oVkFEQ01yenZvOWFxcytUWHdqeTlmK0NoR0lT?=
 =?utf-8?B?d2FxN3ZtcTliUGNKa3ZKckx6ZDZJK0NHTVJHWmcxK29ObVErdldGbkF6STgr?=
 =?utf-8?B?a1VDYjVhNnZQOXRQM3pOUVlHb0FVTU1manFUbU14dnNCZjRyNnFodXVwdnRM?=
 =?utf-8?B?b0JLT3RFYTZBQjIrNzdsWXM3eVloTGxVeHB2V0d1eGQwZ090UlEyTWlCRmNE?=
 =?utf-8?B?OWtLQ29YeDZ4THJSV3pzeUh1WEVVWDljN2hyZzF2bG1YSkpnQmIxMGxVNlFC?=
 =?utf-8?B?N29ORWdEektUVjNoWHJrSFEzZTFuenVhbnNBWEFKTEdxblBJdXRUZGo3dGpl?=
 =?utf-8?B?b1EyZmtSNTdPbnFEcUpOQVhkd2NnQmtLZlFDWXFDc2x1dHJBS0tNUDBPV0RT?=
 =?utf-8?B?bUxVNzhaRUJrOFg5ZWVnTmRaa2oyb3dtRGRJdzY3ejBxMkJxUDZITVhjSGkz?=
 =?utf-8?B?V0k4dEhhVE1yOGNSMmpuWmViYmZrM2F2TjIvYjRBNm5EQjlkU1BQMC91dVJP?=
 =?utf-8?B?Mm84d2xyc05LUnJENmRUdXpxZ2pCYndxeTJlWmV6aGFYK1A2MDRCZXBRa3ZT?=
 =?utf-8?B?MmdPR055YWNsdEs1VGtyS1hIR3ZXME1Wd0NKTXJxbEF1bXAzRkFqcEJQZUw2?=
 =?utf-8?B?ams0VjRhSkl3TGtYM2YvY01SNmVHaDlzWFFvcDlrcTd1MGMwUFVsaFNMUzV6?=
 =?utf-8?B?ajJBVHkwSC8rKzZ2OForZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1d1R3ZpQXZkWTZSbCtvRG4waEhCRmFkUTl1Vk1aYmZHZXhtMHdnS08rZjNv?=
 =?utf-8?B?MWtGY20zRUtGaDE4VW10M0MxSVJJTk5PVUh4SXVyd01COGdMMHJJT2czLzJU?=
 =?utf-8?B?Ri9HaEJPWVBvUVRseEtwTStweTdaTlZsbU5pN0hEN0pZNGtCZDRQdEdmS1N3?=
 =?utf-8?B?Z0IwTC92QzdoU0VCWFFDdC9XUXc3Vjcvd2lrdjhjNGNVcDQyNWxQUzMxaStF?=
 =?utf-8?B?aHpFWEpJU1V6QnI2NWpSSVZWTjZMRmhDelNwZlJZMFhDeEhUOUYyQkkyNWxS?=
 =?utf-8?B?c0thRHE1bHBoL2ZpalFnRzdNRnozK01PV2pOeUN2NTFEQ1lFN1pLZm94a0Nq?=
 =?utf-8?B?Rm5DOFFubG5hRkI1Uk14aWx6VndyajQ4SUhWcHZXTHBndWhLMTZpOU16ZzBi?=
 =?utf-8?B?TDBFNmkrNUNQenpEcnF3YXZIanp5Y2R2SXZTdm5GbVJxdW5FSEwrUml0M1dl?=
 =?utf-8?B?MzZFcG5vT3RhaU5JRWRUcTgrbzVsVzBYUW1oU1VwL3M1ZWRXa05KeHhKdzNM?=
 =?utf-8?B?dkxqcUlrd2Y2STM0NTJuRGtYc0g2VlNEVjZWZ0t4UHdMdmFNVitlUHNyUGpk?=
 =?utf-8?B?Tm5EOXQ5dHFzNktzV25HZnFwV3pMNVlVb2JlcDdJeUJFNmFpWXJSMXVXN3JS?=
 =?utf-8?B?NExyUlFIdnMzbExVWkNvNk1UU0xEbjdQUXRKdmtHc3A5b2x6bEdqaSsvWkhp?=
 =?utf-8?B?elV5cis5YlVkaXVHY3Q2Z0Uyc0hkN0xaUWhiS2J2bmZObWI1bTNmWS95cmZB?=
 =?utf-8?B?TnJRWWR6VmpSVnZrODFJUjRPOS9raFRZSHkvRFF2cjJFdFVzdGlVZENmUWdG?=
 =?utf-8?B?RWl2d1NPOG1UdDNIYnNCNXRYN2dUUGc5OHhKOTdJT2NSdC9oTzJDQytsckVB?=
 =?utf-8?B?Vk1rVm5jSWN4YXA5SmI3R2h4bkZaUVVnM0dsSDZiaEZ2YW8wdXcwQjJQSFNt?=
 =?utf-8?B?QjQwamNlOFpTWFhrcUpZWUszYStUbkE1UzVOQ2J0cm14bENTeHo0SEdOU0R4?=
 =?utf-8?B?Zm15UGEyeXd0Wm9IV0EwTkRENElIdnkzZ2ZQWGZaWHUrTFNvVDRsbjRYNnBv?=
 =?utf-8?B?cTRCUGVob01wL3NaR1BQVExCQjAvZm9UOGRoNjUvQWhnRG96aVJiYmcvaXZp?=
 =?utf-8?B?UWpGY1JBbjdwRG03eTljTmNXTTQwQVlsS2NSbUUvMkVMQU9PcGhCTDlXS3dz?=
 =?utf-8?B?ajJ3Qzl6SExiVllaa0x6L2J2Mjg5d3JxQVFET2dkd0Y3SmpZWjZJdHlLTFJO?=
 =?utf-8?B?WVR4V3V6dThuSHpwZjJ3VllRY1N0T2ZFQW93SlBkcXBXSjh2c0N2L25tc2JF?=
 =?utf-8?B?cVk3SURLMXMzd25vanIyWDB2WW1kUFB6a1lVSnFPSk8xK3FwdGlEeUJqbHpK?=
 =?utf-8?B?NEJCTlJDZW9zV3JONExHZGQ4eTRSMENxNHpHKy84cHREVFdzWHVDaW8wM3dz?=
 =?utf-8?B?VUJKUUpJOGdPb3lGbmFKRVplL05IbjB4OWQrWnF2T1lQQ2RlZDhTeEw4cGZu?=
 =?utf-8?B?S1Z3TUpMRUlmbXpVcGFYREpKZ0NMRFVoZkl1Mk1RNmVFY1RJODlYZFlManpP?=
 =?utf-8?B?K1IzVEVCNTMzYlVTV0Iwa1hPQTlRZGhNamFaK3FmT2l4c3VTeHBRRzlYTXpL?=
 =?utf-8?B?ZXhYMy92Vml6UVpoeXBtdjdhZTZPT0pRNGxidWZqa3ZaTnVBKzJ1dzUxS3FL?=
 =?utf-8?B?d3hHeEtEZENvazAxSVV4bDVOUnpMaGlDQW5LZkY1NjV2Q1FybW1CYnE0RGp4?=
 =?utf-8?B?alNBcDRUMDNOQ3lFa2k4aWMzNk83L3lRaDJXcXNlZTFDT1lVRzViQkFsRUVi?=
 =?utf-8?B?TzYrQlJLaVc4T0g4MjM4VmRPNmxlcC8vU0VRUzMxTlVmdmhmRzQwbjQ3VDlr?=
 =?utf-8?B?U0JWMkFVWXdwaWF5dC8rdWtsTHNRVjBjRENlemZZbGRhRThDZ25nTXROWkgy?=
 =?utf-8?B?UFBiMzZJMExoN05YVmlScDdoWTFXcjdnTFF1b0p4elpWUUtxWEVBRlR0VXpL?=
 =?utf-8?B?TE9QODVKcnVmMVVvU0ppZnNDVld0ZU9jUXltamlqazFIbW1xR0FUZzJWTnZ1?=
 =?utf-8?B?b1FtN2lUemJnaitrSEdhemVBcVVPdTZYLzVGeUdYdkFlbzcyMlk3K29JekZa?=
 =?utf-8?Q?gsZU4s+WxIqxDYhnhIDoZ9MHz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e16534b6-e337-4274-91b1-08dd50e34788
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 12:45:24.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7bCA5EMXyLYkEFijQOFehJXqp/ewSLbzz730RNrLPVDr9onEJaTltYRdVyzC797+9klN9MN4fc/WwMcdWH0Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com

On 2025/2/19 16:02, Tian, Kevin wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>> Sent: Thursday, February 13, 2025 6:25 PM
>>
>> On 2025-02-13 10:10 am, Yi Liu wrote:
>>> On 2025/2/12 21:00, Robin Murphy wrote:
>>>>
>>>> Yup, SMMUv3 is more or less in the same boat - we *could* reasonably
>>>> manage unpinned S2 for non-PCI devices using the stall model where the
>>>> F_TRANSLATION or F_PERMISSION event tells us all we need, but for ATS
>>>> it's the same thing where by the time the fault has taken a round-trip
>>>> through an ATS response and a PRI request, we've lost the details of
>>>> exactly how it faulted (or if the PRI request was sent eagerly without
>>>> a prior translation request, then we simply have no idea at all). Thus
>>>> the prospective mechanism would be to inject a virtual PRI, wait until
>>>> we see the guest issue a matching CMD_PRI_RESP, then sniff the IPA/GPA
>>>> for the given input address out of the guest pagetables to see if
>>>> there's anything to do at S2 as well/instead. Yuck.
>>>
>>> Thanks for the response, Robin. It seems we're in the same situation. :(
>>> Out of curiosity, will the vPRI response provide the IPA/GPA to the
>>> hypervisor? If not, the hypervisor will need to derive it from the GVA on
>>> its own, possibly requiring software to traverse the guest page table.
>>
>> No, the PRI response command only contains a Page Request Group Index,
>> so the hypervisor would then have to look up all the outstanding
>> requests with that index to retrieve their input addresses and then
>> translate them. The SMMU architecture does technically accommodate a
>> hardware-assisted translation feature (ATOS), but it's optional and
>> rarely implemented - certainly Arm's implementations don't - so in
>> reality that is indeed a going to mean software walks as well.
>>
> 
> In cases where software walks are inevitable, it's probably more
> efficient to do the walk early to figure out whether it's S1 or S2
> fault (then only forward s1 fault to guest), than always injecting
> a virtual PRI to guest and then figuring out whether s2 should be
> fixed too after receiving vPRI response.
> 
> Software walks are costly. Prefer to not supporting S2 faulting in
> nested configuration until there is proper support from hw to
> report the level (even a simple hw-conducted walking is more
> efficient than doing it in sw).

The AMD IOMMU specification includes a bit to indicate whether the PRI is 
S2 or S1. However, the AMD IOMMU driver treats GN==0 as an invalid PRI.
Given the fact, looks like we don't have S2 PRI support in Linux so far.

Spec (Revision 3.09):
Table 74: PAGE_SERVICE_REQUEST PPR Log Buffer Entry Fields

GN: Guest/nested. 1=Address[63:12] is a GVA and PASID is valid. 
0=Address[63:12] is a
GPA and PASID should be ignored by software.

Code:
static bool ppr_is_valid(struct amd_iommu *iommu, u64 *raw)
{
	struct device *dev = iommu->iommu.dev;
	u16 devid = PPR_DEVID(raw[0]);

	if (!(PPR_FLAGS(raw[0]) & PPR_FLAG_GN)) {
		dev_dbg(dev, "PPR logged [Request ignored due to GN=0 
(device=%04x:%02x:%02x.%x "
			"pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
			PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
		return false;
	}

https://github.com/torvalds/linux/blob/master/drivers/iommu/amd/ppr.c#L86

-- 
Regards,
Yi Liu
