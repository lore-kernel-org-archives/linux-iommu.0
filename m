Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB120388E40
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522005; cv=fail; b=f+/uBZ88T51l713CgSBAuXz4WInicu6fP+JG3xIn4FkJMF4bhVv6qo8w8I/sXJd3TDB3e6jpTM6ySvS9Bk1EBiAyjslFp1bwfcsBwpUX/Trt+JSg/hMwDvReLjobHp45X8v5Ze5B7zYZCELkdI+MzfLItctkjgMy8yJ4i6kcqIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522005; c=relaxed/simple;
	bh=A6vQcyGS/qpm0ndE6Vj+bWAfhz1Y3donuY81v7OsUps=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mJ2jGs07hGmY4eRa3khc6CiwpgmPvoyhoAiYBjPRoe8ICAtvnm/TszcWMb7patEfS9PnRUECopo8CTffdQsa9XnMNSay7wgNiBPFo4ZPW5RB0o5MHC3CZYP/woyMdkLUyznZFlcNXs7IcKHi+id7sGCJZC+IesoA5KEltOKtnTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyIT7mv5; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyIT7mv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774522003; x=1806058003;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A6vQcyGS/qpm0ndE6Vj+bWAfhz1Y3donuY81v7OsUps=;
  b=LyIT7mv5EDnjHh73oc3LbtfJ1EXaeq9lm5N//hxikSkAyxlJ/gzRXWac
   Zwg80qKVLx9dPGFuJVm7YE6k3ut83aU/IjQ8fmhYF2SI5QSTdtGkOuFag
   prB1QiTO/hT286kZg/Tlff7oId+bcXuNPAefevoUZp94GdtfV3T94PU8C
   PiJoD49nO3+PwIAhT6XhoQ4kMJ3y06hiTXlxQsLfN2HsCLUgnPILrlNF+
   aKE9UJDRLBlSqYCfIj9oRbw0GTyi+EPb6yUSxn48t2IpafrNJpvdaq82y
   wHG/Q7COiWVi2lkQ5vGsg8y3wYcfMcDBzAmP1FiKtEi0Ls/rsppYisOwA
   A==;
X-CSE-ConnectionGUID: jh9aBycYR+qBD8FeWQC0jA==
X-CSE-MsgGUID: zOhRtQghRKCfKtzZ2fvU2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="93155588"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="93155588"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:46:43 -0700
X-CSE-ConnectionGUID: MTPkKhRxTnaoL2it1AU5mw==
X-CSE-MsgGUID: qPI1YHrXTpO11blVdkQfSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248381483"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:46:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 03:46:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 03:46:37 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 03:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnD+fuNxvLAQGlp7MHPpq0UL8cL5Fof71dsmj6MzzREppMmf3fnobf8FU0runY9zs8bQLvSZzr8wtEeuPTT4uI0Csnr7r53IThM+BDXGG81UHNND/H3y9cUlWHSaTwz65ltyThqJMWqSh2fSG0foxnQ+HXAvr9XJFQZXbe55pNwvmvvUxrMIyCj46s3uQzmGB3VHd45yfsOYLxqmsgpR6R6cNtreV3SCuBY6JhgJw4CiWt6+CSACqFjjeYK+C1xKyiK45/jrtxSN3JAtR88rmgac8sq2M13AqL0s1qH1LsCNoMQW+rXlkcDSkMYbZYtP9OZk/XHfLKb7SGCvLbLiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9rDUpgeGmt+hNgvqJHoex3VYF81CdJy+oVRd2G/mtI=;
 b=KoJZcZTd53CPHKyvpxrFW3vLji90z7Y6nblT6gFPohmko+5GwCfZFAJsOcrqXRG3gpSuxIZz07yne4+I//2z+yuq7Rs+emxSehz/pRSws+uww2bTRtLRpiQMYnYtRvmeqflc59MMLeQVgXhyRVPa66++xCnrrmsA9bhluwKSKiFUnC+9pKgskVxkIDtNeqoBwVdttD21rGpqA7flC8cqf8F6ZyQOQHCeVJ+/BN5C48rb/ZVpGATZPhgFhpkzsyObHOPuAsOn4ZJu++2PFCUiQSh3MxwUUpSVLn7mMihgNliF17xGrTwRxteord1HLoMgdRG6NDyLCporlBwy+tOmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB6542.namprd11.prod.outlook.com (2603:10b6:8:d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 10:46:34 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 10:46:34 +0000
Message-ID: <dda82f56-c39d-448a-b460-c118ff5750da@intel.com>
Date: Thu, 26 Mar 2026 18:54:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
To: Baolu Lu <baolu.lu@linux.intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian,
 Kevin" <kevin.tian@intel.com>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
 <20260206004325.GB943673@ziepe.ca>
 <IA3PR11MB91365DCBEAF527F9D5D1EF22924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9df42fd2-8a27-42be-b827-59d7308dc910@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <9df42fd2-8a27-42be-b827-59d7308dc910@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f53b5e-92ae-4bd7-dec6-08de8b24f2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|42112799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: oYXBAWgAN8H2Jx62uTZxla/6j76FvpqZ+r++Mwb9gYMzH0+4nm0ho1KFaGxtLu2vTIJKpSXPy7U+LNrqkLYKTXxfUNq0AkXPTwd8/1fZSmeudAkI6ofdgv2xqEkAmWKw1fnnU3zAZa623ixWfxxSUheZejLPuzbb4anTcDdVxyT3Yr+d2VDep6/MlxwzrO/Yc66kOFL6oKWdyUsgCZOAmfDTpxY6DOSd3dJ5BLTBVr4Jsz+5gtvQv2WGZEMbpYmU48Bta607Pi2xsjW3FTQ5wThAAHizQ3FLjmYMs31erlTDvjU/SxA9wjNIKoFMEA23nnVMD3BKtHLtJM5geBlNZipgCkMalDbvbtOpkaKvzRmueynq0H0YkMTBMb/F2BDKcnNgOFQKRe++Y1RzDfNgieqfLSxBAq1KtYUaLg2as51388wTqnxOG41tkeUxGTzOphMN+obwt1SN9A27oB7PQKJrZ8zX3Eiokj5he58CpLr3z89DBRbZF3CkLxAAMucr4xr1ASHGwEg5VOqpxaE/stQf54KatFvZXpipAMtcfzqQygQ7q5p5Lc41wy5S6pPwazdX9zELUW/Mvb8oLlnWdWDlyjMcBCZoQqo4bICQysv0xjZEzgDi1Fqsdy/9TQheGmmDwvTU6wKZyswjFlMsKDQFaKxdZl+H/HeSr9Oe3MVD2zym72o3gueZfj4wEYy9kMCAefD1y7tFoHB0vkO9tT4cqamhIFyMz4vD3bd6GQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(42112799006)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1JEQlBUeGZkR1ZMNEltd2JIWjNVdWZnaFlITFZ1MmROcVBBTWtFOVQzdkU3?=
 =?utf-8?B?WlY0WnBaaHE0bzVwTHNtL0VvQTNUengyb0lCVVNFOXNBenFaa1hSZld2emgx?=
 =?utf-8?B?b0YrUjlmc3kzVlRIYTUrOFd0ZkNHVHAzTHVneWNIZ0dhcFZwQkUxZExycjlK?=
 =?utf-8?B?azBRbGVnMEd2bC92MDJOL01oQ2xsMXprUXZ1NDVqeXRNeHR4VjRId2dlbHp1?=
 =?utf-8?B?RmZ4VzJOZ0dQUXlVakxwYXFGY3FuMzgwQm1NUFNHSms0NFloR0lWZmhZdExG?=
 =?utf-8?B?cmJyMkMxNmJpUUtkaG83YUtjWFdsU0Nxb3BOQzVNajRsL2JtMTY3cGpiSm9U?=
 =?utf-8?B?bXUveDZFaWhRaVovSUVRQnR0WmZyaExXb2l5ZzJmQzlVcStCcDdNWndMN1hN?=
 =?utf-8?B?c1VNeXQycGNUMkZiT2QzNGxDeDExMUNCc0J3QVFwRVo0S0wrNkV3Qk5mckp3?=
 =?utf-8?B?Vmp2Um1GbWhEM3lIaVlnT08xUGxqdWgrNG91TVJFUUVHTEQ0Vlg1SGJkTE5t?=
 =?utf-8?B?ZzAxWndjbkpxL1lpY3ZIcms2dG1yN2w2bjFwQUt1S3U0SW9qY2ZyZ2ZFTWcx?=
 =?utf-8?B?M1JwdXZXVGxwZXdMem5rVVptZ1RSTHRLMVdWbmFkSFd6WkZMU2drU085MTZr?=
 =?utf-8?B?dUhNOUF5blVXSGh2RXhXQnJnN3Zra1RDNmV2aWcrQjBneXFmWDQ0cVdiMzBY?=
 =?utf-8?B?MUxPaWhpZXA1SEh4QlBGcmJKUzNOZ0doVGN0UC9NdDlPUHBrcmxRVURUMG5a?=
 =?utf-8?B?QXc0UmYrVDNoZURBS05rTkhNby83R3JMODJEMXZZUmw5OUZzdzArckpnZ3Fq?=
 =?utf-8?B?Y3R3L0hSdDFDVHRWdUxIeEUrNFhzT2FEa3MydmhDUVFsRjlwZk9xeXZqM3FM?=
 =?utf-8?B?TnpUbkE5VkRiMXBJNFRhclJNY0ZvekphNVhzL0RVbmFGc1ZuditlY1lIV0lC?=
 =?utf-8?B?V0dPK3pHM0FVY2lvckJVTy8rN2tJS2ovMEpLZGJhTXpnWlpQN3RlQXlMUHF1?=
 =?utf-8?B?TnFENlhjZVRQMGZaam1xTVlkZi9hcm9rTXhzODRDTllnMjVFeEJaNU16MDZk?=
 =?utf-8?B?Y1NqUUtFMWRzQk9WbGg5UFp2cGUyeFVCVmlVRXpCRkRHcUJGNFhBTU5XWEo2?=
 =?utf-8?B?N1hiOThGL2MzZnI1cDhyd0dPcEZvNkovZUNLUSs2ODZZNjMvMC9DWVhldXVL?=
 =?utf-8?B?NExpdGRabzUrRlJWVStCOXRqYit0MTZBMCtwdFNKRlRmV0k4WElNVTZKcm5i?=
 =?utf-8?B?ODZ1Z2lMdEExc1o2b2Z1VVI2MmIwaGgrZlE4TEh1RUNKV3M2bDhPcExEbWlp?=
 =?utf-8?B?Nk9jL093ZUdza0Vlc3JONE1uSEkwUEYraTZtTS9UcDkrTVYxMWdMUnp1U3F1?=
 =?utf-8?B?ekJHYitYcVQzZFVITS9ZVjdOTzJUQ3dXRHU3dEhiam5sNnM4R29iZ09BS3RJ?=
 =?utf-8?B?WHhIa215QXJUaTBGTFV3OCtkQ3A5c2ZpcHFTSEJNRkRkejVEUFJ0YUkzL0tF?=
 =?utf-8?B?S2lOK0ZvdWsySW81YnpYVnhORGhSWG8vSlp2M2g3OSt2ejQ1OFM5cndUWVc2?=
 =?utf-8?B?Z096NG55ZG1aR1U4VjdLd3NDQ0Exa2lrUFBRZzFQRFVOcXV6LzJrKy9lQlp1?=
 =?utf-8?B?RDVlb2FRaUp0K2Z4L2JuUWdPNjllQVpVbWRFMzFkcTlrQjBKcHQzczdwZm1n?=
 =?utf-8?B?enlTaHVIdmxKL2pIYUlhLzIzdVNRVTFaT1Y0Qkk5QmZJV04za280bjZERkd5?=
 =?utf-8?B?UkpPTzdabi80aUJQb3A4S0xnYkRrWFgwR3hkQVFZRzhBMVh6Y2lGVDgyNmRy?=
 =?utf-8?B?WWw1d2dQSnRKclFyYnlML3pRVms2YWZqRi9RcjlWeHppVVlSbFRibk1ETzJq?=
 =?utf-8?B?RHJLYVJ5b1dZRlh4QU03M1RLREJ1OTcvUnV1WlRCSUFuRVVEUVM1TWExS01F?=
 =?utf-8?B?OWtBbThrdzNWWmRhL2grZWlqd3BXeDNVS2hrVWlZN0tyelZ5NXB5MTlBRjcy?=
 =?utf-8?B?Rm1zNGFxRWtnNGlNWGhtVkt5elBXUzhldmdSd21zSDBadGp2bmplQ3NBdmZD?=
 =?utf-8?B?a09BMTRVV1JNZ3pSM3RMbG0vVW0vQVp4NEpsd0pZZjZ0V1plckRwTkpUZkdQ?=
 =?utf-8?B?QWp6VFozL0RtdVoxNEVoZGJoaHJyZWZjUlFWYUJhb1V5UjVLZU1OQVpaWDBO?=
 =?utf-8?B?c1BnOWpxZTM2T2R0ZEpyZm5VUHlhNDllZ2JOV2VkN1J0OTFyWXk1MVgxRGlG?=
 =?utf-8?B?MTZIMTZONXdsajBpTnZ1MUYrVUxEb0FBYkFqUEJrdHh6Rk9TY1gwc2JNQ0pa?=
 =?utf-8?B?YzRmZDJBcG4zYlVsSzdoZjBYdHBPT21iUHNjb3hPSFZKMXg3aDMzZz09?=
X-Exchange-RoutingPolicyChecked: P03PNPWcJxXFhj+lAxW4DBbGVx/v1GJPxnY5BsS1H0TE/r+z79pD4PA2kqzSmKz2t7NiuO/GlWjlK5+pOp48T0ZNjD740nd34Ln5j/w1BwwhvkgBIKGTwJYh11S58Fy8vBnR4rE98IS21d02idVEe98lQ6dC544pVKLPbb+xOVwF4cAoPeu8j4XN3FB5HVEMCSxcVqCD90h4UpXDhqFNyZ8oE2GuXo5+eLcpW6p69VLAhGPfjYCCvTIsHL2ZQjIO52xL2838NB2FBFucDgb+hD69T7Z055IPTZnuUB6BDGpiCPPR/SXqhCTOMeo2WfUvvMrr/Eq7HWAnQGxBJannsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f53b5e-92ae-4bd7-dec6-08de8b24f2c3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 10:46:34.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gQ5SjtQJz7zikrYNbLAmpT4cdwPcTkLq34Xti8RnFu0LZuXTS6IaTvQfXC7hcEPieOccYJszft/cyOtQlfW6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6542
X-OriginatorOrg: intel.com

Hi Baolu,

On 3/23/26 10:54, Baolu Lu wrote:
> On 3/23/26 09:51, Duan, Zhenzhong wrote:
>> Hi,
>>
>> Kindly ping, any comments?
> 
> This series looks fine to me. I will queue it (with the typo in the
> subject fixed) for iommu/next if no further concerns. Thanks!
The series also looks good to me with one more nit besides the typo in 
the subjects.

I think it's better to name device_set_dirty_tracking() to be 
domain_set_dirty_tracking() in patch 01.

Feel free to add:

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Regards,
Yi Liu
