Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A861121CA16
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782761; cv=fail; b=Q6lfWm1nHscAOj0J8Ax0oYVe7CZjBuo7hXFlpYLuWsCGOIr1/paE9CgPhgWIlH7wU6eI150m7+9NMjpULjHdI/+m5nz1CRZSJdF600Fu2362SivkAN8WHxXCTMDk5Phgfe31zDoFcRuakCTkIUM7po4WPJqW2aMvMXHvB6pbMpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782761; c=relaxed/simple;
	bh=U5EKKZTRiZZBUwN5oNzA5KHSFMAODEH0uJHji9WULJM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X9+FGFGR6/DupU5U3f7UNiH30VOiIxSnctJBgwaotlsX3lKqNhx3ySqgfdHDKAEs366AQ3oSjvfmi9kOk6ij4egYbGrC/HacGVypURcBwUmMKwZ9NF8tQC3FYgL4HjUcP2qDlVCQ1/hpfd9TED8rOJqhztfQbl98aeodVuPXPTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjUgvvTc; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjUgvvTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746782760; x=1778318760;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=U5EKKZTRiZZBUwN5oNzA5KHSFMAODEH0uJHji9WULJM=;
  b=VjUgvvTc94cGP1XOMI4iVXqTic9kEYbpaqHVMwOsqARKre282v/+BZ49
   jm8u00xTz69WBQL60AGFdKpcSsSGmIGCiWmSUR9rYEdfdkuhdZPM6/Mq1
   VL71gxYJRmDZ44UXI43OVteNKTd78oTJshanxOwfhOh5gPXZ2uHGzU2TC
   KI93eHLM+otf3f4UW8rSeG5dx70170lnxJvlKEubpYJoDKGeNSs6+6YFW
   ruzPIoBM1XqOXgju0Nh+ZigXo8WvX2x0XizsNTGtj5dQvUrOKBju/h7wC
   nu+UVYVVbeuacuY7eplGFk1jAl78khGUh39JcluJJ/QVGp4QtZ+JHqtfG
   Q==;
X-CSE-ConnectionGUID: +kOrScirRwCmQHccrV1RkQ==
X-CSE-MsgGUID: 67u2dw3JQ3SaPdoF+NR27w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48609663"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="48609663"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 02:25:59 -0700
X-CSE-ConnectionGUID: gnKojSNkTxaA6BKbqBLvUw==
X-CSE-MsgGUID: 4/en1nThTjuFocVaFjtxpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136499236"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 02:25:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 02:25:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 02:25:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 02:25:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7FCVXgeU7a/ddwTCqtlUmh1DQNMU6bJzmA8VLSK1P/AfNsINIowAG8k1EHFZ56WShqkz5sdR64MFsWpZjbrAyeaOcAN//K97HDdrab42cvle88RgS6gZw7hx9dq4YUiiI/pcDQmG8I7H3StXnsBAocbFfbBih9+zyJUFRt3Lda0ITuiMh8u4VDCTk38b+uWU8iyzqb2qG2SDQSoVRm+9Ixh6omWtBnaASvILf9l23egyYt/zH/omO/qdQTbXcbPHQ7vXxRctXs08a9O8N7ydJ2/RtB3NSP/XSZiqfWCKP3IKkZtWEUx4E/00jZ/wEI1eVfQTSAwUkRTk2MT+N90jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MAH65Ezj7xBUe/6gK2m8vh4ocO7Xim62j6krPsuzSU=;
 b=ISVseYErsziiFKZnNCm2hY3edK9l6xngpBY3AG+63ZCiBlzQ3xkPOywBnQEGMT+IO46hAHwjgzfYJrys9AD/0wWjeUgBAZXLXBFnB5f0shtmPUKblwKgBoCZH7jj7EK7n4BPwCjdbJAzQY2II6L+pqRl/ZPiSQl+4LB/3kIKfQ3CmM6zCcWqgnYAGlLZTHk5ptJkUMPt4NztJ141YcgLuZ4AiR/sdAKNGULhMII4QXunh/Kq/WE8l5oA7T3/rwCKv1gUFKSJH+CUQpecf7IzRwpjocQEbgK+AAx1cKw6hO2l4Robl8dQBzZsSoB5bMm2Jn2czVgkNpQFy9OZbhfZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN0PR11MB6033.namprd11.prod.outlook.com (2603:10b6:208:374::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 09:25:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 09:25:55 +0000
Message-ID: <802eacfa-b29d-4589-bad8-a9665909cb1b@intel.com>
Date: Fri, 9 May 2025 17:32:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] iommu/vt-d: Fix ATS support check for integrated
 endpoints
To: Wei Wang <wei.w.wang@intel.com>, <dwmw2@infradead.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, <jroedel@suse.de>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
References: <20250509140021.4029303-1-wei.w.wang@intel.com>
 <20250509140021.4029303-4-wei.w.wang@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250509140021.4029303-4-wei.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0039.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN0PR11MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 048f54eb-820e-46c5-321d-08dd8edb8029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUJ4dk1xb01nTmx6V0F0clY2RjMxZGJRVHQyN29Wb1hDVGNDWGppck85TzNj?=
 =?utf-8?B?VmFDUFFEMjdXVlFPMjZhOEc0WWJCY0xQcDJmSVdVVjlGd0E0SGg2WnVIc0Zv?=
 =?utf-8?B?VFBNWkNjMzJhaTdBWlNUMkZMN001bTdDK3p6MERoNndJd2QvWEQ2TERESHg1?=
 =?utf-8?B?OGxqOExPNmFSNnpXem91UDg0cHlvNTlzR2dqbHdOMTEwbDVYVERtNFoycmI2?=
 =?utf-8?B?TmVlb0d4YWpNT3RVR3F6eTlZMmdiSEdlaDNDU2hwTWNUT08xOEdOYU1pdWp2?=
 =?utf-8?B?bGpmODNpYWNlMWpkSjJUTzJBOC8wYVZQdUo3MTBQUlh0UDZnSVIrczVZUFg5?=
 =?utf-8?B?TGtvSGFXcHN1a2VRY1g4MjV1TGRNNC9BcXVFNkpocnhsMFdPakRaakdlbzNH?=
 =?utf-8?B?b204b3hEZEx6bU11N0l6d2JvUnZURU9na0pzN09JVlh6cWdzZGg0cXJwTTZs?=
 =?utf-8?B?UUMyQnBsU0lTTHgrQTdVWjNBdmw0OXQwaWl2YXJnTnU4QTh4ak05YkVWNWpH?=
 =?utf-8?B?YVowMCs1cHYrMWtGZC9yOE9XUTVST0ZWRTJQUFBxRXNJTjd2U0x6bFYvUC9h?=
 =?utf-8?B?NU5EenJrcTYrNU05UCtsRitxd05FeDFoa3dJbEp5TlB2cTVRc0VORFhySzFC?=
 =?utf-8?B?ZGZrZlp4UXpDWHhHb2tSWVVNQlVST2t1UEJOaU1BdTlmTzFBc1c3MS9WajF2?=
 =?utf-8?B?N3JGVUZXUzhGaVhFRW90R01YUTQwNG5uV25Odm9LWElPLzJIRU5SZUI2UGYx?=
 =?utf-8?B?a2Vxd3VCMTRCYVJ6eFo2YlgzNnFseWltU1dHZW51U0hGbm8zdVdXUHZZM0Jk?=
 =?utf-8?B?ZHpDd2RRTGJVb1pFNThGQUs1ekU1QkJVTnp2U2dyN0lPWnFxS0ZRZEpFSjBF?=
 =?utf-8?B?MGdvclBTLzBNNm1xdU4vMTZBbWFtV3BDRzg5RnhUdDEyL0lrQVBxUUF3c0tv?=
 =?utf-8?B?Z1E5dmgyWG5ISkUyK2R6KzZ0R3o4TmUzRm1NbFcxdnFINGNIenE2QWJFdWRa?=
 =?utf-8?B?ekdvRjdwZTVwUlFZdEhPTEpHY2JJM3ZnU2VESTNjMHVGSDF5b3FaSVZuMlYr?=
 =?utf-8?B?cEk3eHFlNERtN1lobVFjTTQzTnlLZzAyTklRbGxDazJDRFYxNlk0eTN1MkxP?=
 =?utf-8?B?Z1lPRkR2U1lMWGlWOWtXbFFHcTdIcjB5b3dBQXhoeVlZSzVENVlPaGE2Uks0?=
 =?utf-8?B?Y3N2TEloWmxuaGZaTzc0K0ZkVStKVitsbUEzWnVDZ0ZoN2M0Wk9UQU8zUDFp?=
 =?utf-8?B?YzBaa01wcDlvaFJhQVBTa1lkV1VDMFFvUkk0WUE1dUxYdGxDQWlEbldZVXhI?=
 =?utf-8?B?MU5OalF0Z0c2Y3VlTXRqNVFHU2xsNjZlUVVYS3FxdUJjcEpXNWIyT2ZoUy93?=
 =?utf-8?B?NHJBQlZtNzl3dEJtbE95Z0V6bkNJc0tLc3RLVUJZdld3VHhZbUlCeEtmcHhr?=
 =?utf-8?B?TVUrTE13d3JlMmJ4ejZmZ2pxMi9JZnc3enhIZjFQNmhtYWxVSDFWWStnNStG?=
 =?utf-8?B?Mmh3WkpLSTBlWE1JenpaVXJhbEhLaFlGaTE0bjBCMzRoNXAxZ2x6OFBsMzJa?=
 =?utf-8?B?OTRrcmE5OHBzUExhRDE0czdDSHFWdG1EK2FFV3hoTTZON1Uzb1JsSFhTZlRK?=
 =?utf-8?B?c1p0WUNUZHhmbDVSMGxTUWFGeFRIK0pCNW4rYXlwdE9GRFlsTUNzMEgzNGhO?=
 =?utf-8?B?bnRDd1dRbDBpK1pnV3RXZTVQVStVNzJTMFcrVVJBZ0JoWHdWZGdTdStDYlpN?=
 =?utf-8?B?N0d5cC9rTkdzRHJzRldHbk9KOFk5UjYwbGZtRlplWVAwV2RmSzVVdTdtK3hm?=
 =?utf-8?B?UUtYejA2SVlvOXhhb1dLMDQwYUVDbHAwYmtEMys0bGdFNkFtcGwvNmhwc1JW?=
 =?utf-8?B?QTZJQ3pKbjFrVVBCT1BlakdDRklWNE5OZ0ZnR3RSVW5qYzFZTys3bEROelVz?=
 =?utf-8?Q?ZCGa+R8fwT8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJHV1FWUWdwQ0lrVWZWQzg2dGsveW0rYk9NTGNtMkF3QVI4V1hXb0kydEQ0?=
 =?utf-8?B?MUFFYWpEN1Jud291dEtLS3lBaW1qNDZNSkhCU3A3elVDL2xGcTBmaUxOYita?=
 =?utf-8?B?Y2JsSzB1ZGRNb2VRQXM1TEt1Y2ZiSTZDQmZ4L3k1MzhMWVlYWFhnVU5mV1NU?=
 =?utf-8?B?Q3g0djM0N1h6U0lOT3hBdnJJWlg0WTBpaXh0c1F0WEh6UE9wTXg4OXp0MkZm?=
 =?utf-8?B?UmVzMXUwbDFnUnVSazZtbzVTYVNYOTl2SWtYM2hLOUdoN0F3TEl6blpvWWdl?=
 =?utf-8?B?WXNQU3MzYXI3WVFIM2t4NjQ0cE9uSFEySXR1a0RDd3UrcGtFUGQ1SE5XUmo5?=
 =?utf-8?B?TVhmaUU2azl2cGt5Z3pZYkVXL0lzeis2a3dRdWQ5RzZkS0RPaDBYRFdTU2NY?=
 =?utf-8?B?cWZpdlV0SFM1eXFmTkxjc2E4YUROSk42Ky9uS2xUZ3BJNWJQeWJEL2xsTW5S?=
 =?utf-8?B?T1BTT1BrYm8zZkp1UVFVTlFmSkJyWmpMN2FmOU9TWlVOazhBZHBtU2NpN2tT?=
 =?utf-8?B?UlFlQm85aDFmaVRBYkFGNTFqRnNJcUZyKzhJb1hBbktibHh6RlVkNXhuS1R6?=
 =?utf-8?B?eGV2YWJpUDRITy9nMWZDdlVCVTdPNjQxWjVZTldEZzB1b0dLTkJ2eDFQbVdl?=
 =?utf-8?B?MXcvbDV5Nmp4LzF1aUhQVnZqeHJYM3VQenBZVGgwY01EWjgwK0IyOGlMLzVN?=
 =?utf-8?B?TnBhZFRtQ3QzMVM5dzg2aGZrYnVzOGNoZGRCWlV2dVZXdGY0dStMNEVkL2Z2?=
 =?utf-8?B?N0ZnY1doYlVHQTM1R0FCbVY1dk5CT0xpOTkzQTJobjRhK3FhWDRzNjY2cTZJ?=
 =?utf-8?B?YlBMNmNFMHMvYnhaNXdBRjFNeVhmVWhMRFRNZHYrRlNrV3lrb0JMV2xBa2NT?=
 =?utf-8?B?SjI1dVJaSkZ3Z0p5NHNpVzU0UWRTR2IzbTd3WndUWmpuckZka29kWUx1cFBt?=
 =?utf-8?B?NmMwdGJ2TVk2cTBEVGhNMTJEalp1T0tvb1lTam9vV29nSTlUZjZhRDFaR2wy?=
 =?utf-8?B?dmpGSHZuSk5kRWxqV3FESE1HeXhTK3VMclQrVnVKeG1TRmcxc05wNGZwMzZ1?=
 =?utf-8?B?Z281S3FqZWZoQUtvb0FyaDdJRC9EQkExTjFKVG5NRHBWYTd0SWpnSktnNzZw?=
 =?utf-8?B?cTZBLzhnZzB5TTZQbk5Rd2oyM1J1bVBYc2tXVmZxV1hwSUw0dWVCMHZ4U3JF?=
 =?utf-8?B?MW8rZ2JQc2FOc1ZKTEJHRHIrdWRkZlQrZzZWNHA0T3YrNlVqTzhyS0w1VXZv?=
 =?utf-8?B?eTRMNWpISVZaL2p2Nk9wdG45TUdNVnJKUW8zSGVIS3NtRFRGTmxQb1QzazRL?=
 =?utf-8?B?UFBRdDFKV3dkY1RiSktHWG51WEtocGlTN2h2aHFkOVNYdlZ6UEhxcVIrU3Yx?=
 =?utf-8?B?a3pLQU9PTlpEck1OT2hGWlMxdjQwaW15YkFRMlF0VmZRb3JnVWdQc3RNUEtr?=
 =?utf-8?B?M1R6Y3N3QkY5WUpaUGVCZjJGa3RWL2wwN3d1b2FUOG5nQ2NFWnBrSTV6aTJu?=
 =?utf-8?B?VUNSTVlSUHM4clZ3TFFNU1VqcGEvWFhScmtqMHg5Mm9veHd2cmtKSWdBQW1q?=
 =?utf-8?B?cEZPODY1anBheklBc0dZeHhZOVVtQU5GODQ3ZEwxMTFnMTIrTVlvWkhxQnAv?=
 =?utf-8?B?OTM3VHdJdERkNXZEVnMzWXMwcVRSMlp0SlFuOU1LVHp4bjJlUDMrQlVoN3dD?=
 =?utf-8?B?WGV4SUx0QnM0SzI5eFU0S3p2YnZ6NXRjUHczT0ROMURweGxGS2ZCZlJCRGxY?=
 =?utf-8?B?MnNIQXdjbGlGZUNEQnhJSUd2RXdmWUJiWVRja3VBOFhyWlRCSTJQTHV3Zlpx?=
 =?utf-8?B?OFRGQW03WXhENGdkQUtiQkVMK0xoandvMitib0Z2c1U1ZFlSNW1BZU1HbTYy?=
 =?utf-8?B?YjBIOGtoa2hxdnBxanpidk9wbXhtWFZNWDI3SnE3NHRtTUo1bEdrSVplejNQ?=
 =?utf-8?B?UUw2L1YwMC9tTTNrako4eGJnK0IzQnF1UlhQQXZVVVAyOXpEbzdmK0NtSVB5?=
 =?utf-8?B?MlFWUjJSM25YWWxHKzRCSHdMakdaNEljaWF4MVpzajBzMnl6MmdWVVRnQ3lS?=
 =?utf-8?B?REg5anUwWmRvS21yZy9EcGt1K21RbGdCc3ZPbnJvZURjUUlaWkczei9tbnJQ?=
 =?utf-8?Q?5eg6zkKWNfwbJJCSGjzMSUTVL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 048f54eb-820e-46c5-321d-08dd8edb8029
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 09:25:55.6947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ph+hl3jwjbTgTzyNvGpQAutmj5xcjOWuAtaDsGuVNRcg5dMDLzeWyTtvpdoimokRiyB+zi+QUnvUGonGYyAEcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6033
X-OriginatorOrg: intel.com

On 2025/5/9 22:00, Wei Wang wrote:
> The VT-d spec states that "SATC reporting structure identifies devices
> that have address translation cache and that is validated per requirements
> described in the 'Device TLB in System-on-Chip (SoC) Integrated Devices'
> section. It is recommended that system software enable ATC for this
> device". It is possible for an integrated device to have PCI ATC
> capability implemented but not validated per the requirements, and thus
> not appear in the SATC structure as recommended for ATS enablement.
> 
> The current implementation checks ATS support for integrated endpoints in
> two places. First, it verifies if the integrated endpoint device is listed
> in SATC. If not, it proceeds to the second check that always returns true
> for integrated devices. This could result in endpoint devices not
> recommended in SATC presenting "supported = true" to the caller.
> 
> Add integrated_device_ats_supported() for the integrated device ATS check
> in a single location, which improves readability. The above issue is
> also fixed in the function via returning false in that case.

if it is a fix. A Fixes tag is needed.

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 42 +++++++++++++++++++++++++------------
>   1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2778bfe14f36..39abcf4e0f8f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2760,6 +2760,34 @@ static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
>   	return satcu;
>   }
>   
> +static bool integrated_device_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
> +{
> +	struct dmar_satc_unit *satcu = dmar_find_matched_satc_unit(dev);
> +
> +	/*
> +	 * This device supports ATS as it is in SATC table. When IOMMU is in
> +	 * legacy mode, enabling ATS is done automatically by HW for the device
> +	 * that requires ATS, hence OS should not enable this device ATS to
> +	 * avoid duplicated TLB invalidation.
> +	 */
> +	if (satcu)
> +		return !(satcu->atc_required && !sm_supported(iommu));
> +
> +	/*
> +	 * The integrated device isn't enumerated in the SATC structure. For
> +	 * example, it has ATS PCI capability implemented but not validated per
> +	 * the requirements described in the VT-d specification, specifically
> +	 * in the "Device TLB in System-on-Chip (SoC) Integrated Devices"
> +	 * section. Therefore, it does not appear in the SATC structure. Return
> +	 * false in this case.
> +	 *
> +	 * On older machines that do not support SATC (i.e., no SATC structure
> +	 * present), ATS is considered to be "always" supported for integrated
> +	 * endpoints.
> +	 */
> +	return !list_empty(&dmar_satc_units);

shouldn't it be "return list_empty(&dmar_satc_units);"?

> +}
> +
>   static bool dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>   {
>   	int i;
> @@ -2769,25 +2797,13 @@ static bool dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>   	struct device *tmp;
>   	struct acpi_dmar_atsr *atsr;
>   	struct dmar_atsr_unit *atsru;
> -	struct dmar_satc_unit *satcu;
>   
>   	dev = pci_physfn(dev);
> -	satcu = dmar_find_matched_satc_unit(dev);
> -	if (satcu)
> -		/*
> -		 * This device supports ATS as it is in SATC table.
> -		 * When IOMMU is in legacy mode, enabling ATS is done
> -		 * automatically by HW for the device that requires
> -		 * ATS, hence OS should not enable this device ATS
> -		 * to avoid duplicated TLB invalidation.
> -		 */
> -		return !(satcu->atc_required && !sm_supported(iommu));
>   
>   	for (bus = dev->bus; bus; bus = bus->parent) {
>   		bridge = bus->self;
> -		/* If it's an integrated device, allow ATS */
>   		if (!bridge)
> -			return true;
> +			return integrated_device_ats_supported(dev, iommu);
>   		/* Connected via non-PCIe: no ATS */
>   		if (!pci_is_pcie(bridge) ||
>   		    pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE)

-- 
Regards,
Yi Liu
