Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D51DEFE4
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742515068; cv=fail; b=jE0Dm1dr9/8l1mi5eX+RWyIIryvv1tG6oNEiLxWNkpR56QMy3j0Xi0cWPlERLT5hJuiKrjR0QyxW7YsFrF9ZYWmjULBscUOd7vLHDE4TnL6mYDk/kPEc/+O72BWUfy2Oagx3emH+pKA+WbhTcmfKTqfYGUJtaxYk+Kgy07rRtEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742515068; c=relaxed/simple;
	bh=U/mp8QieniIm1AffW3gSv4XY3D+/5m4yeKBUcsKJjjI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U8GFdhndZdcwLx1PKQ9gNfvOjUlRhTgHaIcK7xHg9d6d50L/n7jI2rxcLKAez7ztx4FR6IGdIqEBpG5JBBTHwUHChcDe/QUvxPjrUu6/5QxnspsELZCYNBP4YKcJajEzERCeOI+CQOiq78pqDh5d2t/YzIvgFXHLHmbJvyQiACA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIQUea9K; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIQUea9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742515065; x=1774051065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U/mp8QieniIm1AffW3gSv4XY3D+/5m4yeKBUcsKJjjI=;
  b=IIQUea9KNAq8UngqQWKW36fztiXTnYjZChSVoo22S8l5YBQBNsukcNXf
   n2L14NbR1Qj3BgAkFXX+6OV4AJ/mwJ0LDaYcSqFh5TrLiK/RwHfcrLn+W
   mcAYIQVMWwuLNmoDw/pZNTPo1gtkkxI8a8zxC4xtKoxmYs1SKfsHGwn6d
   ou2y374eKaF+86rTNDjyoIo4O4upz8X6URb0Pyzrl8/+S+HQ/lX1PUBIE
   Q1ngxpYoNnDyxNaJzAgQk4OJHypGlkB+uxuLMGbUv8e2Qu3X88FobCRSP
   carjHekx+b7f5DaWVohC2XPqkHUZCviDBybk+J9LHKu7BshnbQ/mi41RI
   A==;
X-CSE-ConnectionGUID: JI0vm+EsS92jr8nFyVxVbA==
X-CSE-MsgGUID: dVxiyJTQTqevQ/n+z/6+QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="61297725"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="61297725"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:57:45 -0700
X-CSE-ConnectionGUID: rZ29cLstQWeBVLNMDhuvfQ==
X-CSE-MsgGUID: 0B/H/Qn4Qw2vcdzMOz74Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123697142"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:57:44 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 20 Mar 2025 16:57:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 20 Mar 2025 16:57:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 16:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcK0n97hS+jrcbZb+Q0jJvd3EVYKVkW1DDXSY/aI6X2Pwh/O0HVk+jGHy5dZpw14MLksqF7ebDz5ZPn89f9PSETviBm7PMCVSbs+/OG8vMjiwxMLv9ar9FRm26seAlaOlMXz32M7aMlbLw/djlwkvU0P6BmN3HpIQlcu7Y7APIOpPJGc1MshN7X9yxwRw/d3DcSQEmVXLUC7tIjxBy7z8p2nqNw136F0ry+gAxV5CdsfLPlVbvr03JvYni6yJbtyao2IKRsFG+Ol4rGFyRjBLqdOugXxqps+SROwldlxsErO65RqfmhtJwW7QbugkQhqBk9y044kSZFZRw7ul8aTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LklxuvMThNHZsyyKV1EgqI8RHDkVmx0uSLGFyCh98xE=;
 b=mgAfTpKCMHA1YYLPOeT4008K28ns0zHaJVSBmvmQY2fjY+zgaCh26Ieuf+/TH1CBnJiVJkdsnzBrp1Xnt86KOQW51Hd1gajgIZqORWZLNPMVtICy9bpktPupZ16pnoWxncvBh40yqW+vop/mXp738Q6Fz3mx+mAHFpYoKHeTQpXKmjO4HUcS+ZpVzCwq+rdZuZvBt82lzV31V2iS9xkJLFnZqDyam2lNtFe84tvfmyCpJmrnfc4TDREhfXIvEy+GMdX65YMV+gNEPBnz6yuT96NPtUWPjDtWiDwE1TYmXG6fI1Y/WiBOY5JP8uM9D1bqWV98/0Kg3adAu/hAGpoUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:57:06 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 23:57:06 +0000
Message-ID: <26331dec-fffe-48e2-9586-d7fd41bb3132@intel.com>
Date: Fri, 21 Mar 2025 08:02:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/18] iommufd/device: Add helper to detect the first
 attach of a group
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-7-yi.l.liu@intel.com> <Z9xSO6pIPZZLP4lf@Asurada-Nvidia>
 <Z9xVkwu62tXeLSsJ@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z9xVkwu62tXeLSsJ@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: d458a77f-75e1-4d85-e273-08dd680aeae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFplTlBrMmRXNE1jbmdBZk9QUUozMzlBYlZqdUppemo2bVI5ZG5UbnUzVGt6?=
 =?utf-8?B?UUFsZTVkb1NjQ3JJS0RIWVBxRG9PZ3c4S2pXbEVGNXpTd3ppVWFtZVBNTXo0?=
 =?utf-8?B?MGhPUG5GK3k1bEowWmdQNEJqaWN3YUJkaktIRnNpTzNnKzRiRGVOaXpZSGVt?=
 =?utf-8?B?OHJIeTFSMTg2bEFBY25Za1ZwRERoMmpzQ25TOG5hQzJtTDdmdXpUd0tVNEwv?=
 =?utf-8?B?VUZSZ09UbUMvMUNQMFMzUy92QnN3ZUI5ZmN4WThSRzhMTzZOd0p3Q2hQNWlI?=
 =?utf-8?B?QWJkdi9taDV0Rm9LTUpCaTFOazFNdkIwdWJEVFVXeENxY0FpYU5RL0UwM0l2?=
 =?utf-8?B?QW4zMGhLUnAzUDZEc1ljaWcrTExET3NORm8zeFZiQ21EYmZHWTlxZ0NyRmhj?=
 =?utf-8?B?VVIxQi9pUzlxSDNHU3FleWJFRSs1d3NFTE45Q0ljNk9HRUlMUGpMK2s4STlX?=
 =?utf-8?B?S3dDZVo0R3hnbm1rNWxzbUhvZWExM0NIWTg5aDdhV0hKd2xpbHA5UzF4TXJE?=
 =?utf-8?B?NjYzcE9Gb3RoMkptNFVhQUJwSkRzZi94Q0o1S1NwUDlKTFlRMlF0cTVTWG9U?=
 =?utf-8?B?a3ZkR3NGQ1prQVlGRHlrWDRUZk9SSUJXSTk3TG96WU4rOGdvbVdSSnNFNjVm?=
 =?utf-8?B?VXdMcS9tMkdoTEZ1anoxY2J6bjRJZW9tOGhOVld6RHhocmZ4dGdiM2t1M3Ux?=
 =?utf-8?B?MVpudDR4MzdCUlJhbXJGakthSzRaS2kwdzlGOFNtUGVUaWNlTis0RTQyTDRt?=
 =?utf-8?B?Nm02Sms0Y29CM05Vc3htcExPbHp3WGNpSXJJVnZzVDB2TVIyaXQ2cWNEQWRK?=
 =?utf-8?B?NnVRa1h2a2tYUlU3MU5FKzRkdHNFcTBDaWhYUmNRQm9PUkRONWRYc0ZGZFpP?=
 =?utf-8?B?M0lyNy91dFdLWEc1U0NickZ0YjZ1WEhmZk1TNGwyM2VJQXRDR0d2NWpnRFhn?=
 =?utf-8?B?Wno5elJaNUtIR1hzMHl5UkpsbGl3bWVxbmlmeFk1cEI4bmhPR0R1Z2w1VzNB?=
 =?utf-8?B?Y0p6elVEbjdiYTZhVFFkeWgzSVg2Q3IraUYydUdOcTJPWHp4MXdYUk9aUFF2?=
 =?utf-8?B?K1hmb0xyTkE2TDRhelQ4aUx2NU1aVldDUDJFdS9FY29FU1dqVDJQZXpEa2l2?=
 =?utf-8?B?NWpFU2p2eVlxQ05keTVjSVcwT0tmRzdBdUo0VDIyMmp3cmIvcm44WVRZMkk0?=
 =?utf-8?B?cVlob2NxNllqVHZvMUVEdFNKMWV3WHVKYmhrbE82RTlkZ2RTdzdqdjNwUjhj?=
 =?utf-8?B?WHJ2dkVRell0Vm9xRXJNMVhGeVk3MEN1V3JYc29lVUh2RmQ3SDRqNkIrVFIv?=
 =?utf-8?B?d3hrd1dRTTlTQ0lQV3RtWWNJaVEyZkFWbFk5dWZXNUNpamNNRDFzY09LS3hC?=
 =?utf-8?B?V1hIYm9yVUtSZUM1UjloZWlXSVVOYzlWd2ZBOExqSkZmR1Bobmd0Y1h3THAw?=
 =?utf-8?B?SXo0Um1ERXczYUdBRWpwWWFSd1dKM1J5VWVjaXZ3SzJza1FwR21RdStsN0w0?=
 =?utf-8?B?UEFFL0pYMmZKSVBwejV2KzlCekc2T0dtNWNQaVVrejZVK29Gd0l0MGFMY1RG?=
 =?utf-8?B?S1FHS0lUSldlRWY0VnVuSVlpbVBwSXRwU0RKbTVaS2lGMXJwMEJiNk90MWg2?=
 =?utf-8?B?NDY4eUZMblNGOE1hSG1oSWJHelZpUy9NcmxDTExJYWx2Q05rNVYyT043cHdY?=
 =?utf-8?B?RTF5VTlkdVVnVCs3YS9DVWZ2cHpZbEFmYVMvUURLWlovYkoxVXVCK0Rrd0Jm?=
 =?utf-8?B?WTVveDdnQXM3NWdwYWQ1Tk52SzJLUXpleHBiWFJXRW5SNHVGeWxsbmNocmZm?=
 =?utf-8?B?RmpvZWwzOUJ3ZTBVcGN3MVhLczFhNWFWMUlhRFBXVlZ3cnp2R0hzQWJxNUk5?=
 =?utf-8?Q?8Y516K2qyPl09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2VTTy9vVmNpRWJiL2k1RVBjYjlrL2FZY3p6L1VJMncxRGJlWEpQUW9mUzh3?=
 =?utf-8?B?S3NLRHVaVHg0V0lnd29TMGFiM0EvWm9oQ2V1d1cwalhPUGFQbklQTFdYWHU1?=
 =?utf-8?B?MlJrZ1FETStoK0xmK1ZCUmJOLzBRZzlqa1M4NjNPUnJHQVo2MEhnQ1J6Tkpk?=
 =?utf-8?B?dzNLbmFVaUhsUHFsUXUyTW9GSW1mZjZnZzgzVWZPRE1CbTBYYmRvWFkra3Az?=
 =?utf-8?B?ME9BUWI5MTQrTzA5YzdEb2cvMXQvNnA2TGR3aVIxb0RUc1FReWl1cU1Ld01H?=
 =?utf-8?B?Y2J1OHN5N0ZyR2xvRExEWC92NjYrK21wMFZXTHNwVXpRUDRqMWtvT1lUNU5y?=
 =?utf-8?B?QzFhNFdVejBVRmcxNVN2SkhMWlNUZk03TmdmU0Roc3k4ak9kZFRBK2k5SGFD?=
 =?utf-8?B?azA1U3hTN0d2N25vTnM2Zi9oKzhXdVRESHBVODV4NFU5c3NqYUs1dzF0akgv?=
 =?utf-8?B?SXFSeUdMNTZzVldYV3ZvZHJJTzVHMHdGbk14UmtHMkl3Y1BZNERLY3JteU5p?=
 =?utf-8?B?bVJhRFg5ZkNrWmVOVlh1RmczbElISVMxVktrbTFNNS9JbTg5K0JVaHAwa0sw?=
 =?utf-8?B?Q2FUQ2UyaFY5cVlrcXZPeTB0QWZZN05VNklkR1VtV21WZGtCWFBKdDBUR29h?=
 =?utf-8?B?U3ZpSERJeUZGdFNYMDVVS09XV21iamZTYVNFSFlGdUJLbmhTT1BCODNjMlBC?=
 =?utf-8?B?TERydzMrN3BXTGRhclNLV1NYQ244ckxsVHI4eWNrb3J5UUhXUmhPVWh3ZklC?=
 =?utf-8?B?ekRFendjUGxhSzNESkNiZEEvSWIrT204NWVmSVZzTlRZMTRXVURnMWxENGQx?=
 =?utf-8?B?NDdLTGJrM2EvWGFQa0d2d2tlVmcvN1BFcW95MnVPZWZkZUVpeDdLcWF2ckdk?=
 =?utf-8?B?VnZ0UVljU0krRHQxUlc1S0U0Y3NodnUrbGlMWXBmRyt2TGVhdmIwOC9WbGpm?=
 =?utf-8?B?MGhyUnJWb2V1eGhMc0x1c0lDbzdGWjlvdFNrblJLVFd5KzNxSmE1a2xHSmNQ?=
 =?utf-8?B?VUFtdkVsM3JMM01DWmYveWxSd1dtbXR4NGZXNVY2UHJQT04ycDhkN3owUVNx?=
 =?utf-8?B?b2gwbjU2ZytyZTVmR0F0VmdwVVV4bzNRTFdZemxSLzBKVHFZNFJmQ3lEdU4w?=
 =?utf-8?B?dHFSOGNKZUhGNFZNSGdxZVA4TS9jOVVRWjB2ZVQyL2RNTERTTkRhMGoxTUY1?=
 =?utf-8?B?dm1HUU5GSnQ4eTJQS3YzcGFhQUhTcC96cStkaS8yRkZuUnF5bVZzZ2RJNHpq?=
 =?utf-8?B?eDUweUdzTk5RcHFoNFRZV1E5V2tIaWFXYjhlekw1VGYwWWpIbENxOVJaK3Ju?=
 =?utf-8?B?bEZJUjlOeG5qbm5aKy95SVBEUmZSQjJnd01PTjlTNkxVcFVjckpqdlJUVzE1?=
 =?utf-8?B?UmZoTDMzS2hLaTJrem1qdzBIaUJCaVp6SEhYYUxHbVAzQXZ4VlhiS0VZaitP?=
 =?utf-8?B?Y0N6ajAzOEMrYnhBZWkzKzZBVnUxYld2TjB3S1lCWGRwSSt3N21JSnhpdFZ5?=
 =?utf-8?B?Sm5yeSs2RUFpL0FySU5SZ2RCTEthQmNqQk9hMERVSEhmb2pkUjFPTTErd3J0?=
 =?utf-8?B?azVObjYyTDUreEhnWGpTaHJHWlRaZWZLM1RXWVl1Z3lxaS9GNzFPVTl2R2dx?=
 =?utf-8?B?cXc4TVdUTGNqWEwrbEUyQ0tuWXoxeDhNRGdRdUlzeUhvN0tNVDBhUm9VRE10?=
 =?utf-8?B?Q3NYbTlhclhEaStzYUNjbk5GRS9MRVBKWmZFQnhJVkJOQjN1ZUwxMUx1V3A0?=
 =?utf-8?B?aFJRaTJCV2dZYTI2ZDQzZ2hGNUF5bFF3MlprMlZSdXdVT0pCRjd5eUhkMmZy?=
 =?utf-8?B?VFF6QkJGVUJxVlBFUnl2TktHSTdYWjZWYkJOOVlEK3dUZzFlOGU0WUhrZkFy?=
 =?utf-8?B?OHRwV3FzQkhQaDY1TzJPQTIzUFFsVjNoTFRGSjdvY1N4aUJEaHhTbjFxNktH?=
 =?utf-8?B?eHpRYU52TFdqcllkZTYySGtKbEhzVWE1UEhxUEhsNWVtRlh4ZjNCRUhIZkMv?=
 =?utf-8?B?bnk2NGtPaFJ2Y3N6Vng1RHBwL2I4UkZtZTNUZVFBYjRBazR0NVB5bG05d2RS?=
 =?utf-8?B?a1ZiKzlTSUZ6bHUwNnovN3loaFRpRmk4dW8wSmFKR1EvSUVKSDV3WHU3YnVJ?=
 =?utf-8?Q?kOkfafNhDrvDmoG8ekhF/TQi+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d458a77f-75e1-4d85-e273-08dd680aeae4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:57:05.9361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wE1J5lM8Waq6dQdTkPp9/M/8aGpEBDQirQvXv+hfwh6D/aD5zffOEtcE0gmSFLPcg5gb/yIqk9fzL5WZx983tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667
X-OriginatorOrg: intel.com

On 2025/3/21 01:51, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 10:37:01AM -0700, Nicolin Chen wrote:
>> On Thu, Mar 20, 2025 at 06:47:32AM -0700, Yi Liu wrote:
>>> The existing code detects the first attach by checking the
>>> igroup->device_list. However, the igroup->hwpt can also be used to detect
>>> the first attach. In future modifications, it is better to check the
>>> igroup->hwpt instead of the device_list. To improve readbility and also
>>> prepare for further modifications on this part, this adds a helper for it.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> ---
>>> v9 -> v10: It is patch 07 of v9, it's reworked hence renamed as well.
>>> ---
>>>   drivers/iommu/iommufd/device.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>>> index ac54d734b819..9db36346328f 100644
>>> --- a/drivers/iommu/iommufd/device.c
>>> +++ b/drivers/iommu/iommufd/device.c
>>> @@ -444,6 +444,13 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
>>>   	return 0;
>>>   }
>>>   
>>> +static inline bool
>>> +igroup_first_attach(struct iommufd_group *igroup, ioasid_t pasid)
>>> +{
>>> +	lockdep_assert_held(&igroup->lock);
>>> +	return !igroup->hwpt;
>>> +}
>>> +
>>>   static int
>>>   iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>>>   				    struct iommufd_hwpt_paging *hwpt_paging)
>>> @@ -459,7 +466,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>>>   	if (rc)
>>>   		return rc;
>>>   
>>> -	if (list_empty(&igroup->device_list)) {
>>> +	if (igroup_first_attach(igroup, IOMMU_NO_PASID)) {
>>>   		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
>>>   		if (rc) {
>>>   			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
>>> @@ -623,7 +630,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>>>   	 * reserved regions are only updated during individual device
>>>   	 * attachment.
>>>   	 */
>>> -	if (list_empty(&igroup->device_list)) {
>>> +	if (igroup_first_attach(igroup, pasid)) {
>>>   		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
>>>   		if (rc)
>>>   			goto err_unresv;
>>
>> We have the same list_empty in the iommufd_hw_pagetable_detach()
>> and iommufd_group_release() too?
>>
>> And I feel "igroup_is_not_attached" could be clearer, as it fits
>> the detach/release context too.
> 
> Oh, I just found that the following patch changes those paths.
> 
> Yet, at the end of the series this igroup_first_attach() is quite
> similar to iommufd_device_is_attached(). So, maybe we could align
> with that the naming here: iommufd_group_is_attached?

maybe just iommufd_group_first_attach(), I would expect using it in
the attach path so far. I can add a kdoc for this.

> With that,
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

-- 
Regards,
Yi Liu
