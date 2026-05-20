Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487E33603E0
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261129; cv=fail; b=tPEaTacN91rBf3HHD2FL7sRuJpRcIt9o/xrcoyiMc+f4WF1OKCI7M7DOWPZ3fWLTD6L8w8WdhdZTe4P4P2cSxzuRG+cwIpJjLfs6QvE0Jk9uTN2TM1yHLs6uJKyqJR0QxePe69DBlqINjB4mtr+z/9MOnBX8Fya7mkePdqAJ1vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261129; c=relaxed/simple;
	bh=yoXw7o7Bk+7uUGc88lvzOfIep9IdOGjorA1vfwu+Tek=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hzbBu/pBQLecNatQiyO4HkQYk90CqWzjhYa6ja4/NaWFUryKkrZn6cOJKq1MyamNjAWu5ra2ib3agP4ypm8QHTKMtvRbZokbid5A8VaQsbuJ+0dG0d5p8hsOf4Y507EKwYORYQlXpOEdNnVw3AWsFWyJee9hQlurptpjOmiXh2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWfqGzlI; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWfqGzlI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779261128; x=1810797128;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yoXw7o7Bk+7uUGc88lvzOfIep9IdOGjorA1vfwu+Tek=;
  b=LWfqGzlI2Xq9NJJ3QU8LvPqrpNSchJybxdoVP+xfbNshJMC3ZYCpSa8C
   WnOV3siqb6U1uxgv86AOAG91kNq1KWltvZV19Lw6RT9Uk2FuVjciuKxUg
   pgXWFx2nIxXYY4ItwCw55lWFb9/ImDYJHJAzQpMRLovwnD+aF6nkN3MgA
   Hyc6K4T0GGs76p0kuzO/mVCaAtnU/mBhXpMj6bRlX8wCg3xT4EoDppOYi
   6ePNaVzzGf1eA87yhaHXvkPfVUNf9VpqZZwF/6wxB3t7SPVf7Fl6mFEUN
   iNS54MWb0v96fG5PEWy52hte+SIL65eBKy8r5fnRAdQb0hbYk3Q6kEve7
   w==;
X-CSE-ConnectionGUID: 4RLTTZEmQBmlFmr82KINWw==
X-CSE-MsgGUID: hWd4h+yFTjyFud9v1frOIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83768820"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83768820"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:12:07 -0700
X-CSE-ConnectionGUID: 63iwDUWzSFenEij5b90QPQ==
X-CSE-MsgGUID: 7ibuZAN4R6ez/yLRd1VVCw==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:12:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:12:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 00:12:07 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:12:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhRaB+NR7MwA9HuQduYwBPShvyfz5nGSxG8zn4SvOwHzP0HUE9CVFOvwRU8lK9dZskultRvw/XPFs2zBePk41/Oajyn0fJx4kV7E9rRUmqsVvgQBhGBs0CrwPbx2KBumwsipAliFCI2U9STVu+t2WfU9/zDIME12k5hTqg801kfaYIrd8qLI6tLrqppT4nipBnW1NSlJM6AqBB2lBIdeAM36OCu/WSCR/uxIZ7iWfabTg6tMD6ASAPfu6dfaHXr8rZ1PQ35AtFdk7m84Ph1lwTTLmjj/Q2ZoNouVVLPIT6sm2uyibGAOjMe2KkCF4E2qP5S0LE5uYToBRQRcoZjZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZSt6ybtR/IotT5B2TgwgiCp1pL0Z9GxdJMf1EstDlY=;
 b=NkKBKKjrCF/0p4qCWlACb6JNvBkPqNN49ShcfOJoXIgw/nNvc1i2vJflZVjEnh4aPunrrz6DcuF0o4CpwrWuwnrFFI5FPfiVYrfxcu72UI9yKvsD+JDnxsSOT7XldvCAZ10nR2huJutRyqi4T9K0MXZKPbr1iFvdxjQCCM8QkfL67LiqWjRC9ThkOVrNkmsHwF3c+n2QTS6876K30dMLBb2UpTXGoDhwmgtVigNVRKW0U1tB9SANqmasM0gV8kIdUEiEimEZyrxBna9GZLRLTWjNdWVrMl/qeRnPKxPq9zKjt6xYnyKL4/6GC3Wy4I48lrr7F7LGIewTJANDeGr/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.14; Wed, 20 May
 2026 07:11:59 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 07:11:59 +0000
Message-ID: <b9e3a3ef-086c-4284-94ce-8e7fafc22d85@intel.com>
Date: Wed, 20 May 2026 15:20:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] iommufd: Allow binding to a noiommu device
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-5-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260511184116.3687392-5-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ2PR11MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: f694ff75-7433-46ff-26cb-08deb63f1537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|42112799006|366016|376014|7416014|3023799007|921020|22082099003|11063799006|18002099003|56012099003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: dsiJ0vxMgS4/hsG/w2xk/DjxPfokfaAoTNLpoY26fWhzYM8u8kepRBpjShmj+DCGM+kvcbQ8FgXYu9OSvMW3Ai0IX3mgTm2PrjEFILgkq028Ovxo5kI7J6MXne0RJ+Irniv9NHqc2Xxo3myNtDdST3dMkhlkTPymqFDBv/eAG2kYj8V6p72zBG+nLKouw1RyR6jV6AFsDnZgLHvndFncG5DdKmyzDM9XefjIAK7tc0NEbSpJH/u/Bvw2LHVrv57MABuh67hMtiHfKM9Opp+IHQMSQecpRsQ2YjLvogZTnju7bkmO8tRl8NWspDNVQcR9yUT5+9ol3RKCcr7+Z4zkANJxkE6zHh5IrXJ78RkCSdVyRaDt4HtCYgPU2jcSkrasDcpzXflKIVcq8BRVkfPUg8FQ19fmdZYnzATmG+s/YVsU13KJx8DF6Cp2GqcBY3LriV+YlUflF8ADtKsIU/WyZB5iRY/JOJct9EQH1k57zZoCNT4p66ug1t3Cp2sV25CWjXq3YG3XXvnw4eWoOD/x/ISJhIKPmTo953qiwrTo3e3aZ9EaAmH4Bw5dwMr8oKkwp0MKoK5WcqTOSSiGlGUkr0fSVOJ+NZyfyDdVyVgxhcDDO/0W39LOGf+uWSE9TvyVrBfzJQk7YRKZ+Qpfa2iAlXUTe0h+2dVVd/FrLaxDAZCl6KQAm5ON86d0oZG3whqdChwmc94leqFTvvQ2/7c4We9QAeFIpzFvj7tEx4o6aEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(7416014)(3023799007)(921020)(22082099003)(11063799006)(18002099003)(56012099003)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0QzRTk1U3pHaE84NDlaUzZqU2RGWEV0SUhGRzFvT0xvRzhFUlJCWm1IWjFw?=
 =?utf-8?B?YXlMY0FCREZ6V21sVmNlMzZmMUgzcnJWTlF1RzY4VDNuUEFyclRJOE5pWkRy?=
 =?utf-8?B?Q1k0WFh5eWVDUU51amRRS1FwSTA4N2FYaVJRcUp4bC8rVEh6Q3MwMjh3RjYw?=
 =?utf-8?B?VTVnMk9WSWQwbXAyTjRQU3dCVVNXY2ZULzhUUS9TYTd0cElDYWlyNG1hNy9n?=
 =?utf-8?B?dlkrcG9IQzAzbGNuTFJaWXBxUHNIdWMvVHg1TFFJVVk5a0ZYSFRzZVpTbUox?=
 =?utf-8?B?Si9ZdzUvcHFLY2JUUHN0TnVMbVBEWU9nZXd1bzRXY2lIYUpPT05LTlBob1RX?=
 =?utf-8?B?S2J1OXNLc1VodFNVellab3VRd1o2WHgvZFlMT2l1aGh6VFNWUXE1ZGh2TVJy?=
 =?utf-8?B?bytUTzlRZmQwYzljQkdwMWJIYjlxN3FoSG5WR1lKbU1WUUo0M1FicmhFMHcy?=
 =?utf-8?B?dzl2ckVzTHVJSGxlQ0FWb1E2OHAyZG4vNFl4NlN0UWlSbENBYnpCbHNWWGE1?=
 =?utf-8?B?aGM2M1dodVN2QWdKZnRabWdwdlp2V0cwVUZEVERZK01obTV0WmxIa0txNFNC?=
 =?utf-8?B?TDNvekRieEhjblJtNnFJR3hlQTZOU3V6TUdvMTJxNmFnQi8zR21ZRXQ3NlVt?=
 =?utf-8?B?Mk9SVCtQelRiUktRekkwZkwwTFdtNlk4MXI1ZDY1Ky9NOFJGaUQxYTBWSHF1?=
 =?utf-8?B?alFVMGRpb0Y0dDBjK0VYSmtBaExpT1JMZWxUQ2tSNDhlSEExVUMvd0s1SHVB?=
 =?utf-8?B?RlFNVDlhY2k2dDVVRzNWTGp3ZkMyTlRNbExvWDREQVVodGpLYkIrTzJ3YVNP?=
 =?utf-8?B?MWJSTnBaa1dwVmFGK2l6RjlCRlFLcCtOaTFxZXdKem4yMUN5UmpzSVA4SjVD?=
 =?utf-8?B?VDVpM1FXOC9SZkdOMDc1S0dsQnZ3UVg2ak9WckpRRjZIVFZERjdJOUhNWERE?=
 =?utf-8?B?NVlRZGtDcWxkckwrTEFYaUVrNWZyOS9MYmZIWEE5S2xEZEJ2Y0JZK294d3JE?=
 =?utf-8?B?a1l5TGM0V283ZWNQY2huSXcrZlV5dWFLdkVSMlhxbkpsdEtrMy9qdkdhVERq?=
 =?utf-8?B?ZklCa1ZXZjNYNGRoTHc5RzF3b3kxL3Z3QmFNYjA4NmRzeXptd1Q0eXZkSVBU?=
 =?utf-8?B?OVdzMzNHR3VVdjhweno4NWFMSFVLak9oL1h1MXZCY3ZVaVovT0hBUndFazh3?=
 =?utf-8?B?OGRTZ09heW8vR2MyQW9rZmE3clRLN3VablZWMUxhN3JiQjc0L2lzeENBeFk2?=
 =?utf-8?B?ckhZZjZ6cmpzOFZxT0MzSDVtMzhFVTR0cTZrZ0pscGx0d2JGdTFnTmEwdHFE?=
 =?utf-8?B?WkdaWDkvUXVFZ3I4MzQzNE1uckZyYTdTN2JYdlMrRWo3OWNVTUF6TDZyak9D?=
 =?utf-8?B?VkxpWUxEQ3BqNHJuVlgvTStPQzcvSmFwbzBQamN1djVtclk5UGxMa01JQXlQ?=
 =?utf-8?B?YXF2WS9HRDUyOTJGdU92VzVPc0cwQlJvSHM0Vzlra1RIL2kvV1RtdTFxT044?=
 =?utf-8?B?WGRLQ0x1T2c3NEVqbUFubmJQWG5oYVBqamx2TDNDRmJjWXFPb0tmWE9GbSs5?=
 =?utf-8?B?SGZSd2ZRWStLSnRxNDZwbTZXbVN2Wi9scnpOUk1KK1dKMU14TzMvLzBDQlhs?=
 =?utf-8?B?RUsvbysrNHo0dU13WU5vWnVkaitRSXlWdHlQTVJYUmFZd3o1NFdzakJNUG9j?=
 =?utf-8?B?T2NocVFOeFZLUU8rZjEvZUd3VkFSRFdVemJoRlJzRjU2akNRU3BwWEh2NE1C?=
 =?utf-8?B?QUhTNVBBc0RKWW9ZMmhqVEdBVzNseVI4aDdEc2d2ZUJ1NC9sZXRPYytlbk50?=
 =?utf-8?B?TEZnSEJJayttUGZ6S0hMd2tWQnA5dHJMRlJCdHo4VlY2R3VBRFJTYlZRbHNo?=
 =?utf-8?B?QWhZbkJzYjcvRzMyamY5S0taLzhjL2ZLVTNWUStHSy9hZ0o4MVJoUHVKL2c0?=
 =?utf-8?B?M3lZZFpXeHJ6TjBETWZqb0xPekthVmMyZ2FjbXE5ck5OYUpFRm1FNkdGSUFL?=
 =?utf-8?B?b2hmTHhQTzI0eWpVUElhTThyZWRza2pRN3JVZWZLa3VBQWMwQXdTTXFKdERQ?=
 =?utf-8?B?VnhSKzZpN2JpNGYza2NHTk9jd1h3b3FGYW1oMFhaN2dIWSs4MHBBMVdyRUZE?=
 =?utf-8?B?VmZPelR5M3lyZVdITHN6NytLUnl0bEhvVVZqVDZiMnc5TUIzUXRxMDgvbUJn?=
 =?utf-8?B?cXZhenhxeDhCb3dZUERVbEt3M3FJU3lVVFgvdU9rM3U1YitFNzRSQ0JYOHo5?=
 =?utf-8?B?Yzc0NENMdnJFcEhaZHBZdy90Q01NNk8yYWI4ZjZmMDRxdGw4Um40ZVpkU0VX?=
 =?utf-8?B?M3JvcHU1NjNIZmpjOFBJZjQ4RkRZYWJjdkZWTlExcXE3T3hIVUFYQT09?=
X-Exchange-RoutingPolicyChecked: jiLo+hsXYFUB6mWuvDjaZv1JyR293Lp3taXZ9PR1NE1WtFwsIoppNCQJYPQDWZRYA14cu4xLMlBC/Om3xq3va9oI7tUNviagKLDqZYDbrindCvcUjTs3gwZNhkKQb58ETVzgIa4ncaCBoND83RCPsADzxH74yymlGfh7NKyPCFFiyh1LQuONCmdJs4MD095LHLRvCk/zYypQnotHZ++5BXNVZ5r01KUkha2M1QswPyrz2mJr7we63wQVG4wiNVoDszjIaAoR/uPqq8ZTXIg5lX21aiutDSng+Bq0VQgtZULdCgxMWn7AQC/ZDm+36mgFmmB84JN9MqhI1hcphd3YSg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f694ff75-7433-46ff-26cb-08deb63f1537
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:11:59.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62z0Yvng+jWq/kJjn2iT5ZbqeN2E1EiuercH9BtT9BTcg6/BUWwb0TcODvP9QjtYr61P9QuapkwBezlpdkyPOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8424
X-OriginatorOrg: intel.com

On 5/12/26 02:41, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Allow iommufd to bind devices without an IOMMU (noiommu mode) by creating
> a dummy IOMMU group for such devices and skipping hwpt operations.
> 
> This enables noiommu devices to operate through the same iommufd API as IOMMU-
> capable devices.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v5:
>     - simplify logic and rename iommufd_device_is_noiommu (Kevin, Yi)
>     - use a helper iommufd_bind_noiommu instead of open coding (Kevin)
>     - move IOMMU cap check under iommufd_bind_iommu() (Yi)
>     - reword comments for partial init (Yi)
>     - misc minor clean up
> v4:
>     - Update the description of the module parameter (Alex)
> v3:
>     - Consolidate into fewer patches
> ---
>   drivers/iommu/iommufd/device.c | 148 ++++++++++++++++++++++++---------
>   1 file changed, 109 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index d03076fcf3c2..4d75720432cc 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -23,6 +23,16 @@ struct iommufd_attach {
>   	struct xarray device_array;
>   };
>   
> +/*
> + * A noiommu device has no IOMMU driver attached regardless of whether it
> + * enters via the cdev path (no iommu_group) or the group path (fake
> + * noiommu iommu_group). In both cases dev->iommu is NULL.

Are you trying to identify the case where both group and cdev interfaces
coexist? In such a scenario, the group path creates a fake iommu group
while the cdev path creates a dummy igroup. Both operations need to be
performed, but checking iommu_group might interfere with the cdev
noiommu path logic.

Is that why you're checking idev->dev->iommu here instead? If so, could
you please make this rationale more explicit in the comment?

At first glance, the comment is quite confusing. It's unclear why a
cdev-path-only helper function needs to reference the group path at all.
The last sentence in particular seems to suggest this helper covers both
paths, which adds to the confusion.

> + */
> +static bool iommufd_device_is_noiommu(struct iommufd_device *idev)
> +{
> +	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && !idev->dev->iommu;
> +}
> +
>   static void iommufd_group_release(struct kref *kref)
>   {
>   	struct iommufd_group *igroup =
> @@ -30,9 +40,11 @@ static void iommufd_group_release(struct kref *kref)
>   
>   	WARN_ON(!xa_empty(&igroup->pasid_attach));
>   
> -	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
> -		   NULL, GFP_KERNEL);
> -	iommu_group_put(igroup->group);
> +	if (igroup->group) {
> +		xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group),
> +			   igroup, NULL, GFP_KERNEL);
> +		iommu_group_put(igroup->group);
> +	}
>   	mutex_destroy(&igroup->lock);
>   	kfree(igroup);
>   }
> @@ -204,32 +216,19 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>   	struct iommufd_device *idev =
>   		container_of(obj, struct iommufd_device, obj);
>   
> -	iommu_device_release_dma_owner(idev->dev);
> +	if (!idev->igroup)
> +		return;
> +	if (!iommufd_device_is_noiommu(idev))
> +		iommu_device_release_dma_owner(idev->dev);
>   	iommufd_put_group(idev->igroup);
>   	if (!iommufd_selftest_is_mock_dev(idev->dev))
>   		iommufd_ctx_put(idev->ictx);
>   }
>   
> -/**
> - * iommufd_device_bind - Bind a physical device to an iommu fd
> - * @ictx: iommufd file descriptor
> - * @dev: Pointer to a physical device struct
> - * @id: Output ID number to return to userspace for this device
> - *
> - * A successful bind establishes an ownership over the device and returns
> - * struct iommufd_device pointer, otherwise returns error pointer.
> - *
> - * A driver using this API must set driver_managed_dma and must not touch
> - * the device until this routine succeeds and establishes ownership.
> - *
> - * Binding a PCI device places the entire RID under iommufd control.
> - *
> - * The caller must undo this with iommufd_device_unbind()
> - */
> -struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id)
> +static int iommufd_bind_iommu(struct iommufd_device *idev)
>   {
> -	struct iommufd_device *idev;
> +	struct iommufd_ctx *ictx = idev->ictx;
> +	struct device *dev = idev->dev;
>   	struct iommufd_group *igroup;
>   	int rc;
>   
> @@ -238,11 +237,11 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>   	 * to restore cache coherency.
>   	 */
>   	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>   
>   	igroup = iommufd_get_group(ictx, dev);
>   	if (IS_ERR(igroup))
> -		return ERR_CAST(igroup);
> +		return PTR_ERR(igroup);
>   
>   	/*
>   	 * For historical compat with VFIO the insecure interrupt path is
> @@ -268,21 +267,80 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>   	if (rc)
>   		goto out_group_put;
>   
> +	/* igroup refcount moves into iommufd_device */
> +	idev->igroup = igroup;
> +	idev->enforce_cache_coherency =
> +		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
> +	return 0;
> +
> +out_group_put:
> +	iommufd_put_group(igroup);
> +	return rc;
> +}
> +
> +/*
> + * Noiommu devices have no real IOMMU group. Create a dummy igroup so that
> + * internal code paths that expect idev->igroup to be present still work.
> + * A NULL igroup->group distinguishes this from a real IOMMU-backed group.
> + */
> +static int iommufd_bind_noiommu(struct iommufd_device *idev)
> +{
> +	struct iommufd_group *igroup;
> +
> +	igroup = iommufd_alloc_group(idev->ictx, NULL);
> +	if (IS_ERR(igroup))
> +		return PTR_ERR(igroup);
> +	idev->igroup = igroup;
> +	return 0;
> +}
> +
> +/**
> + * iommufd_device_bind - Bind a physical device to an iommu fd
> + * @ictx: iommufd file descriptor
> + * @dev: Pointer to a physical device struct
> + * @id: Output ID number to return to userspace for this device
> + *
> + * A successful bind establishes an ownership over the device and returns
> + * struct iommufd_device pointer, otherwise returns error pointer.
> + *
> + * A driver using this API must set driver_managed_dma and must not touch
> + * the device until this routine succeeds and establishes ownership.
> + *
> + * Binding a PCI device places the entire RID under iommufd control.
> + *
> + * The caller must undo this with iommufd_device_unbind()
> + */
> +struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> +					   struct device *dev, u32 *id)
> +{
> +	struct iommufd_device *idev;
> +	int rc;
> +
>   	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
> -	if (IS_ERR(idev)) {
> -		rc = PTR_ERR(idev);
> -		goto out_release_owner;
> -	}
> +	if (IS_ERR(idev))
> +		return idev;
> +
>   	idev->ictx = ictx;
> +	idev->dev = dev;
> +
> +	if (!iommufd_device_is_noiommu(idev)) {
> +		rc = iommufd_bind_iommu(idev);
> +		if (rc)
> +			goto err_out;
> +	} else {
> +		rc = iommufd_bind_noiommu(idev);
> +		if (rc)
> +			goto err_out;
> +	}

how about moving the 'if (rc)'out of the two branches?

> +
> +	/*
> +	 * Take a ctx reference after bind succeeds. This must happen here
> +	 * so that iommufd_device_destroy() can handle partial initialization
> +	 */

s/after bind succeeds/after bind_iommu/noiommu() succeeds. or more
explicit, "idev->igroup is set." :)

Other parts LGTM, feel free to add my r-b tag after solving the above
nits.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   	if (!iommufd_selftest_is_mock_dev(dev))
>   		iommufd_ctx_get(ictx);
> -	idev->dev = dev;
> -	idev->enforce_cache_coherency =
> -		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
>   	/* The calling driver is a user until iommufd_device_unbind() */
>   	refcount_inc(&idev->obj.users);
> -	/* igroup refcount moves into iommufd_device */
> -	idev->igroup = igroup;
>   
>   	/*
>   	 * If the caller fails after this success it must call
> @@ -294,11 +352,14 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>   	*id = idev->obj.id;
>   	return idev;
>   
> -out_release_owner:
> -	iommu_device_release_dma_owner(dev);
> -out_group_put:
> -	iommufd_put_group(igroup);
> +err_out:
> +	/*
> +	 * iommufd_device_destroy() handles partially initialized idev,
> +	 * so iommufd_object_abort_and_destroy() is safe to call here.
> +	 */
> +	iommufd_object_abort_and_destroy(ictx, &idev->obj);
>   	return ERR_PTR(rc);
> +
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, "IOMMUFD");
>   
> @@ -512,6 +573,9 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>   	struct iommufd_attach_handle *handle;
>   	int rc;
>   
> +	if (iommufd_device_is_noiommu(idev))
> +		return 0;
> +
>   	if (!iommufd_hwpt_compatible_device(hwpt, idev))
>   		return -EINVAL;
>   
> @@ -559,6 +623,9 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
>   {
>   	struct iommufd_attach_handle *handle;
>   
> +	if (iommufd_device_is_noiommu(idev))
> +		return;
> +
>   	handle = iommufd_device_get_attach_handle(idev, pasid);
>   	if (pasid == IOMMU_NO_PASID)
>   		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> @@ -577,6 +644,9 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
>   	struct iommufd_attach_handle *handle, *old_handle;
>   	int rc;
>   
> +	if (iommufd_device_is_noiommu(idev))
> +		return 0;
> +
>   	if (!iommufd_hwpt_compatible_device(hwpt, idev))
>   		return -EINVAL;
>   
> @@ -652,7 +722,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>   		goto err_release_devid;
>   	}
>   
> -	if (attach_resv) {
> +	if (attach_resv && !iommufd_device_is_noiommu(idev)) {
>   		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
>   		if (rc)
>   			goto err_release_devid;

