Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8831FB3
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478864; cv=fail; b=FfeX6o88MqWZSLlGcR1B6WCRqN1u5NJ/tQtfSBUOD3h45VvS//wtcd3CrMimY5lxjFj06CChtazsc42SwKsHMJfvdS2KvpfaqT0XLiPK3E/zHjuBTl7zPZcW6SUVEYUDU3e+M1Vs6PFO40AOt4SIYAX0CF0L7beISoDC03H+H2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478864; c=relaxed/simple;
	bh=OaJe9zV7mOpdNUXrzbZgBJuE39xg+9u0F/s3XCwFVRg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FXNVhf6sDsJ2AUM865WDn0O/3vKmhfbsXPnYXuXQsNmUVPjkN1WcRVNJUTc9+pWEeH7TSGzlrKg8tnkfwaUD8BXNLocNnNCsCx+7od2ZxEwTj7H9/dGJVAXCX549829HJAExBoRJCK2nJnvcHO7BPVWhIDyBFNMij/K9+b7BtXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8zNzocb; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8zNzocb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478862; x=1774014862;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OaJe9zV7mOpdNUXrzbZgBJuE39xg+9u0F/s3XCwFVRg=;
  b=W8zNzocbCQtmnWTuzneqvEX2/jcVSRlNwZowQa0sXqBz8aADm1uKYyoD
   X4Gk2maG6XeC7znisb3GIFl+QE5AwG9473EGr5VLmLg44lFPHYcWKMyIT
   mBWLLsLpkFFQmLimRRt8OMkPC4dqH2ZjDqEiSHK8SH4yTf+ULeZUp6kmf
   cXHFxdp2n81txUzilzZFHx6irFDXd45eNek6gqqRaUUT9gAgl18BYSmqw
   VbfEuBp3icOMBpSdA9sPjZnxiy18Tfgm2AHhJiUcNrR4kBxHjqg3G1mKQ
   ZfMvLJ1LskOGPK3M65FD9+toTnlgx2V03/zvMZKPDEHmU21TN8P5teufp
   g==;
X-CSE-ConnectionGUID: 3gqTIJIXRzui41lqdDJAyA==
X-CSE-MsgGUID: lKp5urPNQ6KEreJ/i0gSHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43441922"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="43441922"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:54:21 -0700
X-CSE-ConnectionGUID: l/Wmp8+GSqa5GlZEVZydWw==
X-CSE-MsgGUID: wOB7/MclT+KXfiZyVqJz5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="123858500"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:54:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 06:54:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 06:54:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 06:54:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrQw+r3ysgrx4GhPrL+2v9NxXDf4e5iNiQpdjadzhI00TEibaTmPNzTiw2F6AkfW7jtRdewji16KczW6JDWMgJma8fTvFU9DWTqHabsHz9NhNBVOJTPrTpmGj3wLnChRd1UjN4uMKwah4JWPrD4QIdrZ3TEHYAgmXvCajJxZMnEJ/p7MPNEAmnwmonF+pJw9JNzClPS+MJZFfd1iDnDXcJIsXql5BWqjtHn/ot0yLmPhlWy1EqOyvfGbijTz37Wu2kNEaNF2Gtw/brlypm+aqAUZH6BOWAmz9ML7OgySzr/kkA+8wvar2F1D3ME7feIg5qP1AiqvkmtMp8kkM8+lsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc42Mcj1BbwFPY+/HAJQkEuuUE87nup2g5IHCB330VI=;
 b=G+kmSlh4bGg87o43Q3VoxEDTC8tk1lSjBmo8MdB93UavJkmCq44D2N77539+TCGoQleBY111QIlsDzqaD2CwNTbbk0REEA/LrA1rRaZ4fST8XWfvCwxkTCqODk2T5vHXVZgNcP+XkVfQWbEOrry6a5B33/7hDFyUuHQyhPypj2UgoFeA/I1/P9HIvulHDGajhuEDl5n7t3fXlLoPb4U8w4ZP4qsLZv3VtbVyrwe8URhJsioCXrRHPNpMFounD8Uh1wzWmcOAR2ZKEUIT1NruPGYi8NxvDS8RqWueCCtASsU1iGyvYOuME7HqjDA2aCVKZnhDIUNkC0/oq4rNTUBVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 13:54:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 13:54:18 +0000
Message-ID: <e2bd148f-337b-4966-b0c0-a3b16f96ae52@intel.com>
Date: Thu, 20 Mar 2025 21:59:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/18] iommufd support pasid attach/replace
To: <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<nicolinc@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250320134744.5777-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW3PR11MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: d70829c6-139a-4fd9-b83c-08dd67b6b592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEVhTTJkQytpQnlBaDY2eVlUZ28yOGZMdnhISHlqNTA4dm4wZ3o0d3IrVzJW?=
 =?utf-8?B?UUN3SVpKNU9sS1hOcmNmR0JPSGc4OXVjMEc4ckd5aHN0bE1sVzh1M3FVNThx?=
 =?utf-8?B?WFZmcklqV3JKSVpQQnlnQU1nYVVTTGhFOXVoSXNTMmlzUHlFeFliTTluM0lP?=
 =?utf-8?B?eGR4bTVvcGNQLzVmNUp2Yk9CazVmTFNPRzdGZStzZ042Q3dOeUxxQXcvYmtz?=
 =?utf-8?B?VnJPRjdZc08yU0RhOFNpWmFLRERlM1JBWlVhT21SYjlwV2Q3ZCtXeS9teVNG?=
 =?utf-8?B?T3JGbFAxZ2VxeTVWOUFVOEdkcjRtaUVod3I5MitxTXhTbUlEYjJ2ejlIalgr?=
 =?utf-8?B?SjRTVFZqcVJCaThhUlY2S0EyWkpkalcwVmRlOWVCNS9uamZRZ016SUFnZmpS?=
 =?utf-8?B?a3ZHUFNvZUdpMEZoT2tROC9DUGhUaVhPWFVyNFRYZTN2ZmsrcEZlQXJZZXRS?=
 =?utf-8?B?R3FLVkErNzhuU3JTWlkrSmpLZVVYcWFzUTY1dmVlZno3a0dLenR3MkdBVGxH?=
 =?utf-8?B?VzdRNHpMQ1hJM0dpV3FERnVXR1NEd09sS1E0aFkwVm9QMG9nZmdCOFQ1WjhX?=
 =?utf-8?B?NlFsMjJselljV2QwZXNRSjM1NkxEeEhpQncwYnhpajNTQitUYm12RFAzRW4x?=
 =?utf-8?B?SVIwR1ZBT2lIcFJMRURTOG5XTXB1b2hZbFFuRThkM1cycUhIcEZScm4wQTNh?=
 =?utf-8?B?ZWZWN3N2eStWd3BEUGlLZTB3OStnZFA1dFBtS2FvcFNFU3ZrdVp2dFNVb0NY?=
 =?utf-8?B?SVFrcWNneFRSY2ZMLzVDaSszR2kyV1p0TVdON2VmNDBhaFYzbkZBM0dwRjA0?=
 =?utf-8?B?L2FOSXoxTWZTbU5adTFKZ0puRjJvQWhCNXJQUFpFSFIxdWxiWVBoY2QvSTFv?=
 =?utf-8?B?VGVVNWl0eDM0QXFBNFNBc3cyT2tBa3dyK1BxNjMzcDk0VjRmNkpnYk0rVmRh?=
 =?utf-8?B?Kzl5NGdGNEl4NkJDVXE2VVppU3pqZVNyL3VRVTZBblFmL3NLZlpYVk9vRWJ4?=
 =?utf-8?B?V3dqSThEVSt0THV5RHNaSGc1bExPUGt2Ymw4Tm9QOU5GSEhBZ3oyRlVCV0J5?=
 =?utf-8?B?KzBHMzg2S2plaEV5Q0FtdGx2TW40aHZrd1dxaTlqTEQwMVMwSjBZZDJ2Skc1?=
 =?utf-8?B?VlhkVGlBWWNjTTdHVHdhS3NEUlFwcXYvSFBERVN4MCtUNjhwbFdldEZWK2dF?=
 =?utf-8?B?TDRDZGVvcTByN1FIallSVDVSVy9FVEFGZExSV1VPMUpPU2dEc1lYdEhaWmdV?=
 =?utf-8?B?blF6a0NvSDJ4RkpmSTk2N2hlTjNEeHNyYUFkRFhOU2JuckRLRzE4d0xKQnBz?=
 =?utf-8?B?OXdrR3p5MzJZaU4yLzdWTHM4anZNd0cyV3ZueWc5ZUEwb2FaYSsweTI2VkpI?=
 =?utf-8?B?MkdSR1h1UDAzeCtxdXNvdm9YT2JvM2pTeG1mNGxyNS9RdVVYUnlDTm1jY3Vr?=
 =?utf-8?B?dmhFVmFnVXE2dmVDY3V4VDBrRllpMWk1UDhBcTN0NVZ0MktLaDZRUFVOQTBZ?=
 =?utf-8?B?bkVSUzZraFZLYVEzOW5QdC9lY1Z5Sjc2NXFNdXNHcDJZY1k4NWxXS1RjWVRF?=
 =?utf-8?B?dVpsSXlkbUd3K2hmUjF5dDRwTGcxVU1PcHFxR2owRkx1QnFBMFIxMTB2NWQ2?=
 =?utf-8?B?bC9Kb0tMYURwWUMrMWlxQ1RQK3VIRkdtdTFXL1RIR1dlR0luUHNjMHZsU1ZT?=
 =?utf-8?B?SW9KYlFwcm5YZ1VNQng2QzRwUkNIclVtMm1YNllHNzVSYmRSTy9LUGdDQzkw?=
 =?utf-8?B?L3d2ZWR3M09rWCtYTnJ6eFRvdFN4NUIxY0F2TmlqKzUwQm1nTnlHbUxoK3Uv?=
 =?utf-8?B?QTI4YjlwaFhVQUdYbWh3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWZtdWtoVnpEaVpTcjdPUDFwcXRJbE15RXY2RUhnOHRacU40a3BvNXlkWTFD?=
 =?utf-8?B?dXN4NU5TWTdsVlZabkFCRkIxcUwxZFlEM3lYeFBpR2tPeHBGaVVESG9iK1l6?=
 =?utf-8?B?WDhzWHZLTkdrWDRZWTJpQWpwUEUweWNVdFA0ak05ZitNSVJlb3V0N2ROL09a?=
 =?utf-8?B?bWhnY3F6cmN3Uy9zQkNoendqaVZ1cmdieElRS2JIckFxczhBWU5SSGhnWFhE?=
 =?utf-8?B?VlkvU2tTVTU2R0VYcHhVR0FOSmNIOXpRWG9UMG9xckUwQVBhK1hmclliWWZW?=
 =?utf-8?B?YXQxWDExZ0pFNU8ySHdZSEFBdmZXWDZCYUc4UVhFL2lLTTkvbUhvVm1nSXRV?=
 =?utf-8?B?TjVYazgwbXcvSjdnVWNDSXlrY3lnNUhpSHd4SzVLNjMvWGFkc2VOaXZoK0ox?=
 =?utf-8?B?SU1EaTliMW9LaUJIZDB5Q2c5NkFibkNvU0x1bU1TU0R4VEdVemlyWjVYeFpD?=
 =?utf-8?B?ZUlEL0creE9rSlllS2xoRGcxUHNrbW5SYzF5RE5LK1BMRjVPQzZYUEFnL2xI?=
 =?utf-8?B?Sjc2cWhlNFRQOEkxTFZ3bjhEanVQWlRZcGNaQWcybk9FeEhjaEFTLzJidEFJ?=
 =?utf-8?B?YVd4NkQvUFRpYU01WCtZWjRwN0Y5Qy91YkhUaHBoSDVieGdhSEVWdEdtSnhZ?=
 =?utf-8?B?bjJVWTk0NG1xWW9GUjVUMkxrK2NSMFIyTGNteEpJTjYyamNJWXcvSi9QaEc1?=
 =?utf-8?B?QzB5b3VQV29seG9URWVLeGtUTkNYVTFXYXZXZmRiV050dzJuMWRkRWxrTVpZ?=
 =?utf-8?B?Y0xudHU2Q0d4QitNRFJXdmtES3hWWE4zaWQya2JUYzEra1Vzd2JmZW1NUHdQ?=
 =?utf-8?B?d05PQnF4T2lhVlJ0NWY5dFgxTzdHSzIraE42cWJOMVZkL1FVU0pvakhHS3Ex?=
 =?utf-8?B?WkNxdk9LMUliN1BkeHY2V21ZU3hpNWtEQ0xPb3d5ZEtIMlJIelI5OTVmTHBu?=
 =?utf-8?B?d2pWTE9iNmhveVhSTUR4MDBWeUxHQ3JGaklqMi9LTGE4RGkvNU96SkdsNjZC?=
 =?utf-8?B?SlZCWDBzcHh5bW8zZ1RzbFlSd05oOEY3MTNMTlNUdXZnM1dlNEU4UnJHdGZY?=
 =?utf-8?B?QlA3d3VFRjAzb3FXdkorTUxaOFRRN0dlalMvK3FCUndtUDM2ZndvVlYxTDBS?=
 =?utf-8?B?UEYvd0M5RStJczZNaEt6YVhwcUZMUVkvTlg3T2liV3FNb1BzZ2kvajVVeWdi?=
 =?utf-8?B?dEFTb1QyRXN6OGRmbXA1VjBMdzdwQTRhVCs0N2Q5YTd3Zk9mdnBoRFVOY0tN?=
 =?utf-8?B?bGlSZi9PTEVDY0tua1VvRDhFZ29uUGo3L0xQZG1SOEEyZUFucEVRc2xXNWNt?=
 =?utf-8?B?VmdqTW9Vb1JGVTlycmdqQTBMd1FGOEJMVjdUelJ6cGpOOGg4OHViUVk2SEkw?=
 =?utf-8?B?dFFwbmtXdjNaMGp0RXlmS0Y1eXFMOFdObkRZdEJPY2VJVVpxS01GY1I3SjRj?=
 =?utf-8?B?VEVQaHZ5dmxySkh1VGUrcWgrRkpXSHBKWlNKN0srejVJaVMrMHdQYktVM0Rx?=
 =?utf-8?B?R0I1OFNvUXpyb1dHRC81U1M4UzlkcDJKR2RGZmFVNmdOWGRxbDhVcGQybVJI?=
 =?utf-8?B?SkRVMmNQdndnTEdHMVBRREhtM0dnVzBiRVlWTE1SUnBGS1hnc2JTQ3R0cnFZ?=
 =?utf-8?B?ejFGMGdpZjZSOXRGZkpwaGNSTndJUWp0VTRzZTRFdkRiR1ZaVE5GdXdLTWNo?=
 =?utf-8?B?RTJVZWNxbnA0S3Jad3hHekxtNHErejBacm1LL0k3R0MwWE9kNEU4anFGa3NU?=
 =?utf-8?B?dU85VmVtWGxmdy9wWDE0R0dBdFNjWGJaOUFSL0t1ZmI1VFVOYm1PMCtnU2VH?=
 =?utf-8?B?N1oyaVhPZWdJbVVra0VLT1JXY1ZYNzQyb0pEMlJWS2dEOExDZkYyQ0lKVlhD?=
 =?utf-8?B?blBXRVZPQmlTeFNCSkliVDlyMnVRZ3NJcjZPcHBaWGhqbkl1YXlLWTNFRjRX?=
 =?utf-8?B?bGJkMDN0KzhWeXJPYitvK0ZKVFE1VzlFWk0wWFB2aWExSVFlT1pSeHpOOGxK?=
 =?utf-8?B?b0JscnBsLzAxdVUvMFFtZGtGK0ptUUpHVUNVNzhRRG1vdjdnMERlK3o4UUJG?=
 =?utf-8?B?R3hqclJsc2dFUG1xWWlybTVMWmRxbGxaeTNEajBRNWViTnd0YmVJb21tb2JB?=
 =?utf-8?Q?a+R/prhFJuEEl/BiVz+URtwak?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d70829c6-139a-4fd9-b83c-08dd67b6b592
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 13:54:18.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cZwM9yfAw9uqs3phJD4n106EMHqO3uB4OV6KcXzvSRhCx2lek3yh1SQ8BdK8E3MFiGfFCIWjSW5PFaQ35RiMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-OriginatorOrg: intel.com

On 2025/3/20 21:47, Yi Liu wrote:
> PASID (Process Address Space ID) is a PCIe extension that tags the DMA
> transactions from a physical device. Most modern IOMMU hardware supports
> PASID-granular address translation. This allows a PASID-capable device
> to be attached to multiple hardware page tables (hwpts, also known as
> domains), with each attachment tagged by a PASID.
> 
> This series builds on previous series [1]. It begins by adding a missing
> IOMMU API to replace the domain for a PASID. Utilizing the IOMMU PASID
> attach/replace/detach APIs, this series introduces iommufd APIs for device
> drivers to attach, replace, or detach PASIDs to/from hwpts at the request
> of userspace. It also enforces PASID compatibility with domain requirements,
> allocates PASID-compatible hwpts in iommufd, and includes self-tests to
> validate the iommufd APIs.
> 
> The complete code is available at the following link [2]. Please note that
> the existing iommufd self-test was broken, and a temporary fix patch is at
> the top of the branch [2]. If you wish to run the iommufd self-test, please
> apply that fix. We apologize for any inconvenience.
> 
> The series is based on Jason's for-next branch plus one more patch [3].
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?h=for-next&id=a05df03a88bc1088be8e9d958f208d6484691e43

correct the base of this series. It is based on the latest commit of
Jason's for-next branch.

https://web.git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?h=for-next&id=da0c56520e880441d0503d0cf0d6853dcfb5f1a4

-- 
Regards,
Yi Liu
