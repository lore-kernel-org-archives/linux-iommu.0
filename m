Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C013644A6
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261146; cv=fail; b=gdpTcRp8MjAXsQT18Mpgo/F+7t3XRR8bO6CNWBLuviSxvxgElhYT/nUolshrUljW1JfD3PE0LOqIcOxm79wy+pg73I8XadmvUf/gABmxlOsLFr+3on7dIq8BpQ7Q2YLMzQnL3JLDzacgbr7u0q5dwYji67VaL77viL4MTcrnga8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261146; c=relaxed/simple;
	bh=VP66tOCtR7MQRWnACJWUnuV6IkAiLwu/6qgqk5dgR38=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V4NAHP6Owq80DFKSp8n6RtU4ZBBRarwrDraLBnUgB1OiAipGqSMzZizX1/QFtvPPbgljJu4gcQj15OxWWGpijUqpDlhXWrDMYkzpHUOSCX3ReB9/e7N/kP9vOwHjfg3/TNr0symvZDwZu2EcE1j9l75WcPBrc5ISTh4jqu+syQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYFcXsOs; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYFcXsOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779261145; x=1810797145;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VP66tOCtR7MQRWnACJWUnuV6IkAiLwu/6qgqk5dgR38=;
  b=KYFcXsOsnJ1L7SgPap/o/sppeJhJ1+Gs9uS9nRjz2QFduxIgWIz61cUa
   7PbL/B2idZb0s5WlOgCeNcnvKhM98HnW+XvfPk9oslrTY8Ms3MmfoB2Xf
   2fmnXyy8yTSDJFJcPEIIE0758KWIf/CfQvYWcK4If3KBkAV0OQk9LB0d+
   zbO/X5A27cRCuctEQVCNvl42I8AD9fSEikfmFMjZY/Gd/TXcg7qRH5Cxw
   YTuX4F43Dbb6hp2rJ4ugG0RYkSld/8wTK5DuHxQ7ar+cWrkvExWCUFOXV
   FC2iYNSWCB1ixc5+oHxNexk+9BtofCp+BR4HjgOcwd+mZf0yyVNXJKpzB
   Q==;
X-CSE-ConnectionGUID: wMoCPm7bR2yWjwG0ve4U+w==
X-CSE-MsgGUID: 7Og+TTkJSqK/jzpTBOZSqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80268321"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80268321"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:12:24 -0700
X-CSE-ConnectionGUID: 4nXFZHbeSGChSlc4KIgVUw==
X-CSE-MsgGUID: JONdsLccQ0+runl4mJWorQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="237070992"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:12:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:12:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 00:12:23 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:12:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsY3HLQWWZ/6GURw/RILkznYxIHgO1DaNloi5G2ugAYIjnRRrYrWM4ocHZZZtFNswmBSf4e3IdQl7kTCipfW0Qe1ww3c0AjIOEeZA5K1wM6UpIU0Nv9pOm8D2DaP8ENirig79zmaqva4kiPNJ7eNbnu8x2IIqq/q1qy3T9GFLPHDMse1KzbIHITPw2K+9IYo2T6GNwhHMfujQO4KDg+8Y+VhnXj7AFRxY49tDhQ3D+uDZSBpCiFtvkLddNeuC4XhThBM5Th9zAXDHJ00VoMAj/x9p8BTyNeShpoHgoW0L1n/4KZSOFCl6cp4dhbo63FusNJ0GwGq5xUkKyZjwMvstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TxK3hW115abCJ8Sl3ssYV24xX6rSBGTGLq74W0/9kw=;
 b=Ak0xJ1MZfc+aDpckaWqvJ8z9LytSdfA9ETh/OANdKvcvNB4bv9W5yo6Wq9JTVHUD8yCeFDWKiEjNhtLFuY94gJwzh5AJwC5fIrSjPY5mBowQ3XtGhZkqjlIYQU8e7YKOVyoiS8rORmUdDkxYRaG1eDk69JTt1tsH6c5I3kkuSnhh3L0+sxLIaGLsh/eQ3xccscccqyZsXwjiR5CRROIyVJ9QYU68H2zZKcm1B+QxxQaAmz2selzPEEfdnvmLBlNwtfvaFXhSInqpQSQF90vX8VcXkRUCkyQUugjBUlralCY71tpWvauF7JEWqNwcAvs9NGU5k+oRMWybuzc8Y8lDEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.14; Wed, 20 May
 2026 07:12:21 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 07:12:20 +0000
Message-ID: <19f8ef7f-2935-45e9-8139-4d7030629f49@intel.com>
Date: Wed, 20 May 2026 15:20:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] Documentation: Update VFIO NOIOMMU mode
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
 <20260511184116.3687392-10-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260511184116.3687392-10-jacob.pan@linux.microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: e67b6f61-40de-45ee-ec42-08deb63f2225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|42112799006|366016|376014|7416014|3023799007|921020|22082099003|11063799006|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: h3xRS49xoIClauJUT7XrQB4oWz/M3ya9ZZEQeJJrO5/T6n/hbW20cTDLlUveegrBNtrlIaho+I7QoFVv7eiCoHIcTFXJLfkK2fn6ruNAiiDXSPHXHZBTAkajMp13P1F2fE+yt9iEFHEEfBRH+sF8Z3bkXsCOgqXQHxuBCr+D4eo2XI+aTrOGmQRZqJG3eDkOKysaARC2mmrc/ZDmYnC81ytTGLuxhVpEYs3h0HRlhGyzhIJfS/Tx5L0oxvyQPNwdqJ6NZBDPm5LhyJCVTERZ1K4t5blXe6EdfbSG1GiYLPlPY1Qdp0JyHyieBd5GJUtH4IRR2TRe1oCFkLi4Y2BPrRVGo76uKrVuz2uvKEdPsP5oQstay0d0f6WSAEqKhV5qBx7LNDM5nXX+/+lxaxmmP8szwr2OhAb2k29pTbrH4gxrWrbqqew3kujrfc3nNOiRMgKLOVmobWPd0K82b3Q/Ez1CxBNquXnLPXa+5tZqOlRwNgngOIAKfz48poM4R2W+1xPSkz4/6XK+g3Hl0LMdxBvgBagqbuo/fmnYtuk361o1uFOF5AGVU6S+i+LFA3kEKsANnu9VSpYa5IKvfdzIV5WBCqma58Tq4kYYlWZWSrvy0FTzF3gwgCGHncpaB49J3pfo3w8zhKN8aGhwH4PsLvdRcPcjzeKTsi2PRMgfkoEBC52yT20uTNUDS4bQ9cyXJkZImyg5LaYmpOLEodEGKZy1L3Yvgs2yDyYXPvIA7z0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(7416014)(3023799007)(921020)(22082099003)(11063799006)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGsrWkJjYVJIUUdubGxQcXdWam9RTjBtdEdWcVNpbythczhSMkkxNWpQaElx?=
 =?utf-8?B?akFPbWxzcjNpZ0VFUDh3L2RVZnBnNWI1RnF4dHVYSEQxbUc5RGt2SVVXWHpq?=
 =?utf-8?B?KzhtZ2YrVjRGMGRab2JJZ3MvaEtMaEgrQ1BkcUJGYmJtMFUvOGVsVXdxSndY?=
 =?utf-8?B?VHFuaWQ5bDRieU85cE1yVzZzTktqbXJKM2pCTXNTUElYYlJKbjZjSnFzamha?=
 =?utf-8?B?SnlML1F2bDBiSVRHNktHYUdXdUtMVm1URTg2VzZLZnc5SGloamFFekFaUjJQ?=
 =?utf-8?B?cy96SjhlYVJTaFRxcEJsbFhIaE9sWDJwM0t0S05YdnJtczJtaDVuYVVwUExq?=
 =?utf-8?B?SjFyL256QXpIem5hYWRnMEFBd3Uxbm5kOGJ5RFpVNkJUWk1obUpEUDdxdDk3?=
 =?utf-8?B?dTFmWUo5djZpMVNFc2w3OExWWlFSN2JNZFFOWmJmZTBzT1JMZktjc0ZXVHQx?=
 =?utf-8?B?YXY5enM4MlN6eUlKZk43SzA4NU83UnYzTzVLZmhZVk5vYnBJUDNLbG9MZXhs?=
 =?utf-8?B?OHB6MnM2K3VuSnJXQmdZcnp6ZzkwZWJiNW9FUW5DUGhQZGgvT1BaQkRHYy8y?=
 =?utf-8?B?bHJoVjdiN0R4MWhrd2VMTytETDZrb1RvQ0U2S05IaFdVLy9hdUZpN2tiZWFT?=
 =?utf-8?B?SlFxQkVteWJlSXZmcVUzZTlZVEl5UnZneWU2Q05NeDJtTE02RVVQbTRYL2Fa?=
 =?utf-8?B?eWJSSnYra0txVTdTTk8xV05TckdnT2hWYzBWc0RVZDlYU1JXYVZ4TEpyell6?=
 =?utf-8?B?M2kzaU9KNVp2RUZTcGVueHhnYWw0WWRUaUlHZmg5cWNRUVlaUFVSaktMQzZK?=
 =?utf-8?B?UHNtNFFpd1ZzeWViRWRuTkcwbkkvT2t4MHVMelhXRXBCODBSMlEzMGxCZWxB?=
 =?utf-8?B?a3FXNDc3aWE3QVBDNHQyZjNKZ3NZV0ZmRko5aHVpRDIrVmdlWEVRdkpsQkxo?=
 =?utf-8?B?MGhVTVhTSUhTWlorRSt4bWg4YXE1a3VuNE9aaHd4d1F5VVJHSFpIdXd1WnY3?=
 =?utf-8?B?VzhFb1dQcmRySVE0YklKSGplTmYxVngrdWx1OUhEMFNMSTlDa0crdVE0YVNH?=
 =?utf-8?B?ZVF4bUI0TmJudmFJQ0lITXV4M0E4SEFZZWxFTWxrT0RJZWt3ZDBGbWkvNUxn?=
 =?utf-8?B?VWJUN1ZGQ2kyajVzeW54RU1VaXVpSlZxL2VneE9CUDJ0Ulp4OG0ybmI1b1Bz?=
 =?utf-8?B?eU90WG5ybW9LT1JvNzF6NEtXWGJpc0JRMjJnZlY1WHBwbFN4Z1ZERCsvR2NM?=
 =?utf-8?B?N3VIenY5YUxwVW43aXFiOXhOMjJkSjgzMDFlS0JkdHhIN3o1c0dMbUt1TTho?=
 =?utf-8?B?RHJtVnFMUlFoZXZLc3RkcjM2VVFFaXBCZlE4RmIrMHhobnlsS2o3ajdHYTNM?=
 =?utf-8?B?TXVTVmRFNndQY1FTMThPZzdQZk1QYlZ6WnNHb280TnhhbmtseWlkbkVYUXVr?=
 =?utf-8?B?REs0REx1aWo3d2hNc1FpOTZOdytYa3ZBVDlzWk16OFlCS0hobWQ4SG9GdU1G?=
 =?utf-8?B?S3Y5M0M3NUR5aW9lRk9ZVGdUaGtnQ21BNHdwVndOc2I1eUJ4L1Z4SjBMd0xT?=
 =?utf-8?B?YmRDRmQ2N3JHSXlBUmJ3Z0ZaOWJLbWljSW1OZzkzY0VKY3Yrd0N4RFFBYUMx?=
 =?utf-8?B?a0hmVDZHRktBaTNCbGEzcHUvamZFMFVSV3Z1OTl1ano1UEZhNm1waGl5UjMv?=
 =?utf-8?B?bnJNQkxRRUFnZllpV0NiMFVPbElxemc3RC80SmJkQll4SDBhaDdDUWZtWnE5?=
 =?utf-8?B?eXMwOGdNMkd4REE4RHkrdVp3dDlsTUZBajkrUEV3K25LcklMTWlUbzA1MHl2?=
 =?utf-8?B?WjNieWdKaExPZlBPVU1IREM4UHVCM1o1U2lndlkzeGlrWnhoQ2x4eHRwL29D?=
 =?utf-8?B?ODgyS1pFcVhzbHZkcTZTVHJXQzJDMGM5R0tpa0hyQ2FKcTRIVUlTeHlFRmlR?=
 =?utf-8?B?dnlXeUl4MkYvTTFVS0cwcFpkeitJUVhvU3NGb0lLQWFmLzkxMVhBcGR5QnIv?=
 =?utf-8?B?c3ZDTkdlTHkvQnR0T2dRV1ZjeDVaK0ovS3JLTEVBbW1YQkh3N0VFQlNRS3l6?=
 =?utf-8?B?YkJOQ2U0SEFBK0Z5c1NmUytyV3ZUVTZMdU1wS1RSV3NyRXRKRzFpNzhaU1pr?=
 =?utf-8?B?SWp3MUVQbCtVZDBUdndmcCtzQTM4ci9CbUFMS2I4Nmt6ZFFDeFhrMWRxdEFm?=
 =?utf-8?B?Y3VzQXZKd0NkZ0NlRHc4MURLazBWUlYxZ1N0WWlNVGxnVGoxU2l6UFVrWmE5?=
 =?utf-8?B?VmZKc1hDa3JLdGpNQjZBTzRNbmx6L0prbE4rald4UXlOV1NTQmxjNWRjODQy?=
 =?utf-8?B?ZUlqNWdEc1NldytuQkpDT0Nhbm5sN2wwbkI5OFlCWDFRV0k2cmRudz09?=
X-Exchange-RoutingPolicyChecked: XrN82QHPdtaR+o0Hfsv9KXc85dnuBw057095S69OS3Pz9Dd7AbjAFkcoKP9cdFlLJM4BU3l9slIShd5RoK0zHOez5J3rqt6HezpJ6PwIJOvZdjalPebwjT3Xan5wgvPe6V1/xmGidTsvxE9p32puAkpPcQCUOl+KRfHOSNaPkIoEHxk2JlF+SQUp3dzLmf33C2BCfz6wkkY4Su2n0oVd4cb1JdZeW3+8cUozg4XkIGwexwQsa4w9Q7uYiLZ6XeSejElvKp5BAQo5GvtuZLK05cAov+6eqX89JtW9iDqbcdEESXvR0x5hCSZaC6z2zewKUrJ0hiKPZX2P6MxUXZ8VMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e67b6f61-40de-45ee-ec42-08deb63f2225
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:12:20.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HILdyN7rYIYiyXRZkQ4y/v8PaAwjXoh/iqd/atWNM6fyUkoP2zGW5Hr/KeMcnZXy1cOxKSvBqY4Hd/1Ynh9zLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8424
X-OriginatorOrg: intel.com

On 5/12/26 02:41, Jacob Pan wrote:
> Document the NOIOMMU mode with newly added cdev support under iommufd.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>   Documentation/driver-api/vfio.rst | 46 +++++++++++++++++++++++++++++--
>   1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
> index 2a21a42c9386..d97017d80b98 100644
> --- a/Documentation/driver-api/vfio.rst
> +++ b/Documentation/driver-api/vfio.rst
> @@ -275,8 +275,6 @@ in a VFIO group.
>   With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a device fd
>   by directly opening a character device /dev/vfio/devices/vfioX where
>   "X" is the number allocated uniquely by VFIO for registered devices.
> -cdev interface does not support noiommu devices, so user should use
> -the legacy group interface if noiommu is wanted.
>   
>   The cdev only works with IOMMUFD.  Both VFIO drivers and applications
>   must adapt to the new cdev security model which requires using
> @@ -370,6 +368,50 @@ IOMMUFD IOAS/HWPT to enable userspace DMA::
>   
>   	/* Other device operations as stated in "VFIO Usage Example" */
>   
> +VFIO NOIOMMU mode
> +-------------------------------------------------------------------------------
> +VFIO also supports a no-IOMMU mode, intended for usages where unsafe DMA can
> +be performed by userspace drivers w/o physical IOMMU protection. This mode
> +is controlled by the parameter:
> +
> +/sys/module/vfio/parameters/enable_unsafe_noiommu_mode
> +
> +Upon enabling this mode, with an assigned device, the user will be presented
> +with a VFIO group and device file, e.g.::
> +
> +  /dev/vfio/
> +  |-- devices
> +  |   `-- noiommu-vfio0	/* VFIO device cdev */
> +  |-- noiommu-0		/* VFIO group */
> +  `-- vfio

how about noiommu-vfioX and noiommu-Y? Just want to deliver the message
that the two number is not 100% identical.

> +The capabilities vary depending on the device programming interface and kernel
> +configuration used. The following table summarizes the differences:
> +
> ++-------------------+---------------------+----------------------+
> +| Feature           | VFIO group          | VFIO device cdev     |
> ++===================+=====================+======================+
> +| VFIO device UAPI  | Yes                 | Yes                  |
> ++-------------------+---------------------+----------------------+
> +| VFIO container    | No                  | No                   |
> ++-------------------+---------------------+----------------------+
> +| IOMMUFD IOAS      | No                  | Yes*                 |
> ++-------------------+---------------------+----------------------+
> +

not quite the above table. Why 'VFIO container' is "No" for VFIO group?

> +Note that the VFIO container case includes IOMMUFD provided VFIO compatibility
> +interfaces when either CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER is
> +enabled.
> +
> +* IOMMUFD UAPI is available for VFIO device cdev to pin and map user memory with
> +  the ability to retrieve physical addresses for DMA command submission.
> +
> +A new IOMMUFD ioctl IOMMU_IOAS_NOIOMMU_GET_PA is added to retrieve the physical
> +address for a given IOVA. Although there is no physical DMA remapping hardware,
> +IOMMU_IOAS_MAP_FIXED_IOVA is still used to establish IOVA-to-PA mappings in the
> +software page table for later IOMMU_IOAS_NOIOMMU_GET_PA lookups.
> +tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c provides an example of
> +using this ioctl in no-IOMMU mode.
> +
>   VFIO User API
>   -------------------------------------------------------------------------------
>   

