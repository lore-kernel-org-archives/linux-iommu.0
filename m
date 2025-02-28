Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3326E963
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751669; cv=fail; b=qIlH8FZF7r4JMesgXwJDpsfccQVI2tDRFSfbpiH51XmWjCcd17veKQ2KHqeayISmB92IxJtWRH4fdOpB8YBdjtfmhgyZqDNu4YxAaZ4N/XReM8rOAR/esQbmjz0nByAA4YAZ2ml+kBw8YVd7bJgf+CYW9e4iZJ5k48p1KDsPEaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751669; c=relaxed/simple;
	bh=3zbRWAf8APnPRIR4wVSqLZDMOd2XubAnGxxsLjht4zo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ki4br84kg3osE5yjyV9qj0HsvqrciY4WxNT//bxi4KVOLNxTEZi7OT7sXgajg9gpNrbK9bYhkHNWTHK4NaORgj2cOGS5gq8l2UAN2oQSYzCZB29MSLIcp0B3T8OWBL1a+tjxqjnEVl+u31Eo89Gm4/XM2ZySMbQWb2wbUfgtMDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIE2MWc9; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIE2MWc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740751667; x=1772287667;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3zbRWAf8APnPRIR4wVSqLZDMOd2XubAnGxxsLjht4zo=;
  b=BIE2MWc98hKxSIQ/Zvmgwk+fq0wSaReiuQAr/4zekKfYdUis+tTFXj2g
   LtZNOb1yr9S5fwCHGLX/K3KcfwUevzDT9lXZUHJnxKApNSBU3l5XssXVd
   YbEnM9WOquALabs+couQO3tDfJPczwMCN1Memf9ou8w5FSpWrgEDBkqTm
   tYEzj/JKSwG5SenIYNXNiWLwnxxjVOtsu2/vqClSCMbIxyOtpYX7aH5oU
   v0nG3xdDzLeGAjytmqOIibXhx2GwSqfMiWDDT74/oFAKZPRHvgbnnIYZF
   ZM/FRO4BGlhOm934SGxOCn42Xzl3xcpyjRD5EEBkqf3S7C9WOcst7iQis
   w==;
X-CSE-ConnectionGUID: KMhrhVwUTVmkWq4+5TC0yw==
X-CSE-MsgGUID: GkteOFHISrKy2kopGvLATA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41597589"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="41597589"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 06:07:47 -0800
X-CSE-ConnectionGUID: OEdHJ/WTRnuxzB/75t3nIw==
X-CSE-MsgGUID: As18S1gVTV+jC02Zp9ORLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118261361"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 06:07:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 06:07:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 06:07:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 06:07:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7YWEWHm9PUMcF9aUiF5qbyaHUMf9DbUrrqEb8QDw95/kyUPoflxddddVqSPuXkK4vsF8uxEzuyPuZT54xLkBcUdAyvj3FNCDWAHAJrCs3LFdfh9gtCJzMs0WBADTGC01C9W6jkezSnm9YB6DvU2b/5pSk3Ho75bxyl1vsueBxR139SUz7JSlN+nXWDN8k2n0rFrR9g0BrBjASxFFtYjycWHpnl1w+kvyyN2fizlv0mlNIkQPyTY8nUXQy0xnjWfSsITR6pW8oxbuQfaDFMbXTmO41LB1b2F+ClEQoQjCelaBYJk4iJDy3pNlzAmZ4nMpz+LKUkHWS4Jx0FL4KMKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkjsQAb1oDCmJZxpcjbgFzZ6Up5WW01bthRUHjxT6lU=;
 b=wyS8ycU7spMyEjv0qydIkgq9MqfjlzNlSc52jEShY6u6iXYmkLNdbY4pK7JBSv308V4O8T1OuMJqEUUWjcirPYYH3VpMsJOwlu8PmcviWe8p5IA9S0M5ClXWaq6WFFovqL0nEClftmnnxM5zB21UbYLSo8YsBtCBtYPdXjkE8yLWbOKln19ZwqPqkcZ1/Pu5aIY9pbGtVifFMb7eyo4+kioE4C5jKPB4p+KwZ40ognCOuxXq570RtvBX7Wt3a0rDPIe508U34/fN7K4V+rJY6OiAfoFb1te7SyrVRB6VAllrumn7DTBWfC0MoRRgs6Q+JmFX7eEWWjtWFsQljarhFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5894.namprd11.prod.outlook.com (2603:10b6:a03:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 14:07:39 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 14:07:39 +0000
Message-ID: <b4ae36b3-a15d-4bac-ab7b-60c0edeaa9b0@intel.com>
Date: Fri, 28 Feb 2025 22:13:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] iommufd: Support pasid attach/replace
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<joro@8bytes.org>, <iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-7-yi.l.liu@intel.com>
 <8839ae2b-014d-40bd-93ee-89a5791f95ce@linux.intel.com>
 <124caf04-629c-4b5c-847f-1e965ea5721a@intel.com>
 <20250227201551.GM39591@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250227201551.GM39591@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c39527b-4a24-4018-3db3-08dd580142bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlpSMThpM0V6TGpDS3lFVlVKc1F2RkhlOWVjNzRLWTdENkpoN3ZQVTYreW1S?=
 =?utf-8?B?clN1ZjBtWXU0aEgwTE1BMEtsdC9DMnY0M0tQck5xakZjOFg1SGljTmdtSHJF?=
 =?utf-8?B?cWZzcWkvM2Q5dDVSLzNTQXpSUm9ZM1gweDdWdUt2UzJmOWV3bnhicUs5ZjRR?=
 =?utf-8?B?UlBxWWx1WHJhM1RkcmpqZjdSTFVmaForOS8rN1VjVFJLbmttblJ4K0JhNmhm?=
 =?utf-8?B?TnV1RlA0Mm1qWVRGRUZQYzJXN1NaeFp5M1ljSjY5YlppQ1pULzZqcE5FVnJk?=
 =?utf-8?B?ZUZCUzY4KzF5UENza3F1UGlZTUc5L0dEOFZ4ZHROZmVsa2FYMXRXbUp3NXVN?=
 =?utf-8?B?WmZSWTdEQTZDa1RhUm1qaURoc0tNcFFLMmMzQ1RkTWVOUTc2bExMRm1Uc0Rq?=
 =?utf-8?B?YjhzbUxUS3lYaGxSRVM0dUpnek04bGxXZHlVVDBjdm9XQUhtTGdZd21FLzFw?=
 =?utf-8?B?R0xDL0s5NmxOd2xKQWFmdGN0dkVKSEN4ZzdRMzY0Vy9ObEExK056ZjJLVGRl?=
 =?utf-8?B?ekVVLzlxd3BBZ09nWTZxa3VnNWliSTRSSUlVMWlsczBBaUEyYzk4emVDSFFI?=
 =?utf-8?B?UURSUGtLbmpCN0JISi8yM3BYWklFMHllcU05OFhuTFRhdDRzR1A3VWNScCtu?=
 =?utf-8?B?V2ZFMXk5anJqYlZmK2pGajU0MUN6ZHpTL203VjFCR1p5V3FtejBsU3pyQi9k?=
 =?utf-8?B?eklCWGlOK1NLZFEwWDNtTXRJTkJSSFpjUk9xS2ZnR2x5T0U3Wk1PQkdjNFpN?=
 =?utf-8?B?M1hwU3NWa2l1b3BGdEVZTHVKd0VSeDZjdG5QbU1BM2ZuWU5oc3ZIK0dRUzBx?=
 =?utf-8?B?YURvdjhzTkk4RjdobVgycHo1KzdXNHhqUU9HeVRNS0VvM2ZMWTU3c1V1ZVhX?=
 =?utf-8?B?MkNtYTY3TmhDMFFwK0t4ZjVRcVAvRWtCRDdlVzlIRlVoNnYxdGlNcFJzQTM5?=
 =?utf-8?B?S1pxRmZGSUZCSzMxeDlMQVhnQzNCRlFPYkFCbGFVMFhhbExUY2hqbkFZeThq?=
 =?utf-8?B?QkpCMEF2VW5qYmxkL3phNlZFVGVaVzdZSDVVM2E3bzBzdnNTRUFYeEdDL0xJ?=
 =?utf-8?B?RFNQdndjWDhnU3NKWEkyK0VBaHFDd0tFT0FDeFBUcjdkc3R2ZDczc0REV3py?=
 =?utf-8?B?Yko0N3RXUW4zNVBPWFpLcGxzOXZQeVJBYVhIczZlSU01TTZTRU1pY2ppWFdz?=
 =?utf-8?B?TnY1aUNDVHhZSGdxWEpIK0wrRTNWVVlIaDFFdGdXSkFHU3hrRmpKSExXVjEz?=
 =?utf-8?B?azArWXp4RWVWYWRsMERGekVZTFZrOWp4MzNFQkZjUDgrc1lKcGlaTG9rSjhh?=
 =?utf-8?B?TnVsQlRyVFI1d1QxK1drcWVRVXEwVytMM2VSMWZHTHRUUGptSzZ4YXJFZjQr?=
 =?utf-8?B?TGJxS0JWOVVVNnZpbCt5Tk5jMzRxMi83cERtWU9EWU96VDdqV1kzbE4rWHlj?=
 =?utf-8?B?UU0yNEpEeEtaWGltRHRTZDVPaUh0SGQ1cWl3QU11b0QyaVB5L0RLOWN3bGZU?=
 =?utf-8?B?U1gvRWY1TU8zMmJRdWEzemFQK013dGlTRnU4S3Q5UHROVERDRHMrbVJjSVJ3?=
 =?utf-8?B?SG9XVHYwYlJtWEU4b2JyL0R0RzNGOHExSEY0eTlvVVZYSjZKMjEzZVRiTzhZ?=
 =?utf-8?B?VGhhNFVWcWdFYWhNZU1qRkREQnlBc3RtSzZVMWV6b3g5bVNtTGhNZGlhc0V3?=
 =?utf-8?B?Ny9iNnRjRGdKYVh0T1hwUHdpVmdIRUtXK2tSVnZWUHoxaWhIWjNJZFB4c3Nw?=
 =?utf-8?B?UGY5ODBEOWZYL3NUcmdiNWQ4bEpSRW1sYzBlMWczc1U0ZXdqRDcwNFZCMndy?=
 =?utf-8?B?N1VJckZtMEpHTjUvcmMzSSthVTJqeGdBMmx5alBjZCtMYjFpNE84Q3ZqT3Zx?=
 =?utf-8?Q?cFnLpJBPPL9RD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW9DcTdNcHJ4MVpHUmFlTEhucGNmOXZ5THVvcFdRQ2FNMUZsMmZhUExudlBC?=
 =?utf-8?B?VUNQZC9uMWMxR3k4dStRZWZSMmFqZnNneS8vbGFBOEVVMk1Ia29yT1Vlei9T?=
 =?utf-8?B?SWpzTm02ZGlCTTFWYXZRMkkvSmNzZW8zK3VlOUJ4Sk9NSk9uQitGOHVmVVlH?=
 =?utf-8?B?NWJBS1JQZkFKczVPamxSUmVxUDFGZ0NURHpkU1Nrd2FrT05VWFh6ZGZhWG1N?=
 =?utf-8?B?c2FXS0ZGZzhuZTd4Zkx2ekwzMWlUVjV6bVBybk1oMUZuSlhDcnRqbjk2cDVQ?=
 =?utf-8?B?Z1VzZ0c2UUpXSFA1TldoTjV1ZEtab1BpWlIyYXZjRVM1U0NKOFphSnBNNm02?=
 =?utf-8?B?Vm94SXNyYTVOWHhRS1U2NGRxSjZLS3FXSWlIU004QWtSeXRGS2FZVkUxcldP?=
 =?utf-8?B?ZG5DY1BiSy80QnpxMnY4S0FVaENpRU1RMnpLOU5aeXVkbVRhVnpEc05FYVhr?=
 =?utf-8?B?QVlGUDRrNS9SL3VMOHUwL1VEN3I0S3JmL3N3dEVyald4MnFCcE42UVVZSmF2?=
 =?utf-8?B?Y2x6NmJSYWtNZnZIUVB5eGN6dDd5OWJ5dTJMUTU2VHY3QUNTWEE2bGp4Wlg1?=
 =?utf-8?B?dWlZYXcyRGdvUHpmYkI5SDJMczY1YmIzbStyL3hkMmwvM09IU0UxN29pT0dv?=
 =?utf-8?B?eGpSUTRhSC8yNHdTMVpxMmFSMHQxeDhFTndBRnR5emxRS1Vrd2J2QTd4VERT?=
 =?utf-8?B?aElqQVFmT0pIdWJqMmgxSG1ySlZOUUZYV3kwNnJtRDA1Yzg2NDNJcXoxckl6?=
 =?utf-8?B?NFc4RXIrVWZqbjgraUxSYlJIYjVoa3hvYU1KVnh4YXRTQVdCR1UxWENYaEJQ?=
 =?utf-8?B?UGI0WDR6czB1cU5LTStaN3MyeFJBNEhHNDVKY2E5cTJrUUkrSVNST2pTNjNI?=
 =?utf-8?B?VS9zQUJYTFhRV2h4WnV4bllSb1FXS0RPaVlXOVBpcVYwMUREa2lXaGtPK0lu?=
 =?utf-8?B?dnRNck1HemdCRVFWSHhBVE0xSFZOZlFleHJteEF2YUVzWlBoYVBOdWNFRFg0?=
 =?utf-8?B?YTkza3Y3UEtBenJTWlduQ0MzVk1GTmhuVTk1c043VW5aNWVZNlRnZEQyazEx?=
 =?utf-8?B?alFTR1NsWW5RdHgyTEFFZWhwazVpdWlsMWdNL2tMWW1ROSttSGgzZng0VWh5?=
 =?utf-8?B?U2ptZktVNGNQOFM2U3VPa3c5c0trSng5RklyWUZYZ2FpYkMzclZkS2JlKzZo?=
 =?utf-8?B?ODJOaVJsa1pSK0pJRVFLTzVWNHg2Umh0eXFFdlVLR1ZuaFFJZDNEUTNLdStH?=
 =?utf-8?B?V0k5MWNMdGZML0pIZUpXQ0oyRlpZRWxKSnN2QkVIY2J2WHpDMlRKeVhtNXhw?=
 =?utf-8?B?aVpRNEk3azhNek9uRHlXT0UyNnAxOWpSVkVFNmJUVkkwU09YN1Y0VlBYSXkw?=
 =?utf-8?B?aDFVWHhQNmIvNG54RUJPTEJKV3pCQ3g1UVRLeUdFN1dJd2VBK2p1d01YSDNs?=
 =?utf-8?B?WDNFNWJId2xKSkt3ZVVhWGl3eVRaOHpjLzk2dGNta0Z1ZFpod3pTU0ZZNjQ3?=
 =?utf-8?B?QVk0UWdVYmNhTmFja2ZuVzZaeGdFTVpXZU1XUTJId2I3bndpUmFQOS9uM2dh?=
 =?utf-8?B?QjZvQjhQemtLejJvMFNPMkNDeDNHR1owR1ZwR3VrTXl1Mkl2ZHV1TUFyL09W?=
 =?utf-8?B?RlRqcVRDZStaQUdqdXUwejkyNEJSRVhMWmRzQklSR2hURnkzK09OeWxDNFMz?=
 =?utf-8?B?U04zLzFCZ3QvYmVUZjF3SEEzRjZSQlNQdEh6L2FwY0t5VUdaK0RTN3Q4dlNP?=
 =?utf-8?B?a0ZmaWVRNWZBTFUweGlLa2NnT2x1bkV2THEvZ0ZMeEc3Q0JwazRLd3FPOWV6?=
 =?utf-8?B?QXdNZWIyRm5uSlUwUlRIdkpyUEdVTXBzWjV0blh0M3MycXFxSlAyQXdZKzkw?=
 =?utf-8?B?Zk1kd1dQVkxxRGVUbktNY0RiSlEvdjNmNGdDcWtxRU42YWhsL0NJaVQ1TXl2?=
 =?utf-8?B?YTM1WjJZN0tHUkRWaXZJTFlFMW5oLzlOR2djNHRKZ0l3WlZpUSt1M0h3MmRm?=
 =?utf-8?B?VEVrQnlQT2JIOUZjMnRQZi95ajU2VnV4MG9JVnlrNklFZERYMUpwTWx5THpF?=
 =?utf-8?B?c1IvN3plRHFYVmxDdURKWlR0MEFWYWxLd2hSVmM5QmtKckE5MWN4dVBzWDFr?=
 =?utf-8?Q?cN0AwjTPEJrEYZ02OYRPmZy3F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c39527b-4a24-4018-3db3-08dd580142bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:07:39.7750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5REJcHXbl7PEBAxOgaCm6A34HXtZbX2izLCTT7T8p+G2w9odVVmDzpJz5UbQ47O9mKq/dtw7SwA4H2oOVOazg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5894
X-OriginatorOrg: intel.com

On 2025/2/28 04:15, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 12:19:24PM +0800, Yi Liu wrote:
>> However, the second one seems not trivial. iommu core stores domain/handle,
>> while the iommufd needs hwpt to check if curr_hwpt is the same with new
>> hwpt and the detach path needs hwpt as well.
> 
> Nicolin's series stores the hwpt in the domain:
> 
> struct iommu_domain {
>          union { /* Pointer usable by owner of the domain */
>                  struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
>          };
> 
> So it is possible
> 
> However, you should also to check that iommufd is the domain owner
> which we don't have a thing for yet.
> 
> Maybe leave it like this for now and we can revisit the xarray when
> more parts are done?

sure.

-- 
Regards,
Yi Liu
