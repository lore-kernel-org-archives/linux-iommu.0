Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E24F1AD3E5
	for <iommu@lists.linux.dev>; Tue, 24 Dec 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735039835; cv=fail; b=I4aE1KR1at+5PX4M7TA/31MsWjAi+NbXaUAUa0Xj62DSKN/K1QFfE7CeKqF3mZQqkriOLV+Q64qq7LyqYDG9tqHAjLxry3afLIIUfOLuB8HwHn0CzeTrhAd0MqZEd+wqW3qS3hJdCQVCbOyp8+nc0Rf6hG+ZJ47hQyqfOkobOoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735039835; c=relaxed/simple;
	bh=snJAedJRAfU0FfLhy6cNAk4tJuAsJGkEdaZGVjgUJm4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FuP36fNVTjGi84XjzTMpW2Zxj4LwsMWxq8PFHXJCj4GJoeG7jmy9YySSONicXyZseOVsgrQTqBgAvUbk5iGIEQC2fIu1ihHntE++9nqJ8znTrN9jPw/bg4GTkH6Ccxt4Qga+KG5E5HSbfZzE0ZVjNiHBBAyVrz+4Fv2Wh/OGaYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPdWsC2l; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPdWsC2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735039834; x=1766575834;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=snJAedJRAfU0FfLhy6cNAk4tJuAsJGkEdaZGVjgUJm4=;
  b=cPdWsC2l8/VTKeRkNNo+2C7I54M/iwcvMPAjlj/Apw4tg7forGAqa5B1
   qiMbXmgqIHoKygm/yJeND/8iW9dvwIoKF+D7ORrl5EMJYpAzTk345U45z
   XA14ne4Oy9cE6UdOg8UYZyI/yFJdk89PWhLDcrOKbklrzCUCxNar9gMB+
   oKZDsXHb8gLaV+YtT1jilE14j4CaoWtFEc4zI1BJNy579ShCunW34n6Nm
   mi5q8VFZRBXaaOd+S1K7s0ThK2BI1c16Z01E0u0s3DCBW4D20s0CTsZ8W
   f3OKv8oamfbea+xdDxEQ0iOTqpYJP/uvjCv/WCRq3IHu72h+Sm/itoAg6
   A==;
X-CSE-ConnectionGUID: HayzuGiPRZ2EgUdCji/+Lw==
X-CSE-MsgGUID: T8xRv/UVRRyHGoYLnklm4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="45999242"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="45999242"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 03:30:34 -0800
X-CSE-ConnectionGUID: BIbKxHBnQzGcFPxn6MjpLg==
X-CSE-MsgGUID: DTKZcO/4QUOq/AhkMIEPxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103561238"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Dec 2024 03:30:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 24 Dec 2024 03:30:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 24 Dec 2024 03:30:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 24 Dec 2024 03:30:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZJkgbOvggz3PeFUIf6o7wZAHA3ujT0oZ5LjNifkbkJyMuRJcXnNmDbPZSd7C10BArvhws7oE75LMxVFQFteUkgudB8ozTdLGv4SP6ITMVV2d1UP6OrUYmHmbWj4+mxHvpXhiy+G+X4R7XbXAlGfv42UR5TZzJxdoP2myrunR47AwQeci8DdIw84118VBvcaARM0uVKkeLsHCLo+MHNE756qnvhvNdlTVwQ9LgykZ0glX0qOSk5X5H/n87s+NNj2Zl8dScYzBbVvLtj4BIAkk2szmvos9ppUf3WJn/+pkfiepz3et0klHCLn4t0USbBEFA492Dr0NOQfZ/mfY0gJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD+06LbglkqYuWhW43VlfrvEpGKQiB+xgLLA/IeHuTs=;
 b=otMKhezHyuLSQOxoBBjTWKSW4uxah/Wb8MQPx/1R6OxtWgQgfAxcFyFNsc2312QY2lJa9eYAWFR+tAPCC9r+99tiTjWaHYKuoOaC/pbsyIUFupsMobMoFB/Zxj/uojmwNJjhSgYV2NlcomCRIY0A64KsEXD3MimHtJzt/1NT3Bv8XcDxPviINqL58AtfT9e3c9g/HKwRp3bMqOcLsi82FdCd5baClTu2xHM2ssEKg5jzNkMvt23tH4sHRoimCONeBxHmpT1WmoNH+ssW+IBR2MQk+QoTP4T84e4IlTNH/bn2CMw7qHQcteGe2JNloGQ0THriK3y0Bab7kaOO3Ojf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB4779.namprd11.prod.outlook.com (2603:10b6:806:11a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Tue, 24 Dec
 2024 11:30:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 11:30:11 +0000
Message-ID: <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
Date: Tue, 24 Dec 2024 19:35:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB4779:EE_
X-MS-Office365-Filtering-Correlation-Id: 654c14cb-cd98-4037-636e-08dd240e53d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MThCSnpUUWRYWlNTWmxwVXYwN0dVZkQ0YndMbzhNUG5NYjB1NFFwbEZYNFdp?=
 =?utf-8?B?eElaZzNqSDNsYlh4NUFaOHBNaVE0ZDh2SzU1cjZDWEJSbkJxWVpDZE1CNFp6?=
 =?utf-8?B?WWxubUNDV2hRWWVnaUF1cVh5enMrNHhZb1RFRU9jM3ZmQ3dka3p6R3Z3SXlZ?=
 =?utf-8?B?MFprU2k4ejhxTXY4M01FZktTNDVORlV0WlN6ZDZsbVhTWXV6aW9EaFpzTzJL?=
 =?utf-8?B?dmthU2IxUWFsT2RVdTI1bHZwNHJpTWpYS2hYQjBrU2I1SXluWWVZWkNRZnBl?=
 =?utf-8?B?MTdMRERBcVE2dGZMb29pMTV2dUtsamlTR3pXcTV3SFVzWmthQ1lORWRNMFFV?=
 =?utf-8?B?Q0tRdW1saEdUQllzcFhXdE5RbWFuZUwzZWp4RnZweHJLNUNUM3VDL0ZNY0Z6?=
 =?utf-8?B?elN2Vmk4blpSNDkvamVoUTJRaTV4bzhPdkhpNTB5ZDFqVHRuNXpTeWhDRTZI?=
 =?utf-8?B?Y0xDRHNzUGFaamxHczhEOXozNTREd0VWNXE0MjZOcGdKdWkwckNMVGhwTHZV?=
 =?utf-8?B?c2ZuZ2dOMEd4ZlFuOUhzZEIzR0JMblJGc1RwRUVXRmZmang2N2MwdFZDT3Vm?=
 =?utf-8?B?Rkd2dmdaSFFKSVZMeUpMcWhyNFFKZS9HQU44MmVBNFRENFJrR3o1WXpub213?=
 =?utf-8?B?c3ljbC93c1dYQzk0UUoxc0RkaXpzNm8zN2xkbWJsWVpiVXRKQVZTNWVGUXA5?=
 =?utf-8?B?VjVHSVpOcEpxNVMyQWU2S1o3N0dHdC95cHYrU3N5SGV5Nnp3RUp1ZVVPRTMz?=
 =?utf-8?B?VFRrS1VVWVNaWlQ4NDNuUVpjU085OGRxYXFrVmw2eWlhR0xGbXJYaGpSNHhD?=
 =?utf-8?B?Y0xLNFB5dnU2bVV3NGs3bWJqeE9yb3hPQm8xd0MvRDNsSVBPUlA5bzFxYUFX?=
 =?utf-8?B?cDZKWWdVUjE2Rm5zeStuVUFQQjZpL0g2V0dLQkZQL21oNFI5bDNNV0VHb1FQ?=
 =?utf-8?B?citxUXYwc1dPeFJ3MHZQWnd4T2ZyRzdTckJ2VXlxd3dEWDQ5WEFBd25HY21D?=
 =?utf-8?B?MSt0WXppaFg2eGVsNkh2Tnk4Vld5eVc0REpZMEs2N1BaMFZJVnBTMExEaHVo?=
 =?utf-8?B?cUMzZW1vUk9oNWs0SU5CY2dFc25QdG1ZV0hHU3RyUVRQazk4RnNmaS9Wam1n?=
 =?utf-8?B?UXVXcVZIVzZ2NG5uMEs5cURrOWdoUDhxWlFiaklDdHBSMGh0clFNYkdhUFNk?=
 =?utf-8?B?cEl2WWQ1N1VhVVhJYnpVbUx5WldkN1FKN1lnTmUwTHNqdExhVHd0UUtHQnFC?=
 =?utf-8?B?YmYzL2xEOHpUZjhseXRjZ2dVY2hZVm9jQW9zY2pDV2g2WUxRZGtxYStJTHZL?=
 =?utf-8?B?MGo4S1o2V25ySE13ZGdSaEpsU21WWGtBT2hmb2hGUlJzanJ6bUR6bCs4aFFX?=
 =?utf-8?B?UzJGWk04bDRtMEZoeUNyMjM0LzU2cHM4cjdXeGEyTnJ2MDRoNVhQUE9OTU16?=
 =?utf-8?B?MlBERm1ML0t4RUFFUWRmN0Z6QWhIazhJVFMzaW4vdkVLUnBPUi9SQmdSS3ov?=
 =?utf-8?B?ejdJSUdpamdQazhGS0xrRGU0R09TcjFVNDdpczFVVllIOHRaeExIK3dWK0ZN?=
 =?utf-8?B?WFJ2M1IrSFowQ2w5Z3RROXFLN2RDUjUvMmg1UjhlT2lleFlubUpvSTFVVlVF?=
 =?utf-8?B?ZmtGRDgvT0JHSUpEdE0rKzhNdk1kZTFzWXdCOTM1aWpoY2RHYjgzR0FXb3pJ?=
 =?utf-8?B?VUx1L0ZhejBBRzRpVmQ2YjRuRVoxSmxyT25lNXhabk1CODgzSXBYWjNpbWdn?=
 =?utf-8?B?R3IvdzNFUGV0eEEveDliNTcyTDAwYzZvTlkyMVpub0RBblJ3eFdjVVNBbHdF?=
 =?utf-8?B?bnhvWWE3Wk5jdm41UThWV2YvQzZmbWN1QU5LdW1FOWdBQWVwZEdRQW51Y0JC?=
 =?utf-8?Q?sPha6MuhRmSel?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3NjTXlmenFhZkl1U3NVQmJQK1hwalRqZDVseHIzK0padHRlK08yc0k2K0lB?=
 =?utf-8?B?N01ZN29LMVJ0bUFmWHBpWXIyMlk3Y1dXL1VHVGJMSnVRYkFPWHAwY3dmdUlt?=
 =?utf-8?B?ZENkd3I3ZnppZ09iYmtlYTBLN3pjRU5LZVd1UmUwUGsvbVNqN2J3VHBqRDZF?=
 =?utf-8?B?c2ZFWGJ2M0sycTl5V0NHZklLSDJwNndadG8zS3NubHFVcTBxaXRoMnlZR1hX?=
 =?utf-8?B?NHRwN2FhV1ZIdkxWd0lHUUx6MVAvMSt2OVlQd1M1YmQza1lHWnlzYW5menJS?=
 =?utf-8?B?NXpBMmtxN3RiSHptanBiektPREgrS2xvSittRUoyNXBEUnMydXYwZDE5UC95?=
 =?utf-8?B?cERSK1gxRWM3UmNkWFl3RVhsb2VHSy9pMHY4Y0NoZjdjMXYvRUxHeWlMaHlq?=
 =?utf-8?B?TUJhS29PU1ZWSURTVGZ6emtVTEdOMHhCV2VQRUtxajlTbnA0dktEeEtlamNN?=
 =?utf-8?B?UlhLUWpzZStKOVBrdGRUTG9rMVFLc0Vsd2pCRnl6UkczdWkxUHhYRTgrWFA2?=
 =?utf-8?B?S1FGOFNkWGFiellDbTViRERMelQ2OVdiaFpLdU1qbFYwUTVjK2tnRmgwdzFn?=
 =?utf-8?B?azVTekQxcTRzMFlDYUU2SDVyc3IvSE9oa0VSOFRoVnZEK1d5eUlyeS9iWmJJ?=
 =?utf-8?B?NHRUODluRTFhckVMblNzUnBVZnFLTm8xeTNwajFoU0xSTnBZaWVvOFFpNTgx?=
 =?utf-8?B?UVR0cVRMU1pJSlVOaHRkYXhEVkRrMzNVVUFrR3JMclA3TGtvelRVT1liTDA4?=
 =?utf-8?B?WkhwRDk4c0s1V1pNZTh3NHM0Y2pWK212Vkh4OVNFTG1qVXhranlhMnhnMG1B?=
 =?utf-8?B?V05zRUVnSXNobitjdmZqY243RXE4UE5XUTNZM1J4c0t5NzlDdVRGY2RYR2M4?=
 =?utf-8?B?bVg5VmdiQWdvdkJNVjhZSWh3d092ZWlsblVDUTQ4SG9OZUVtd1dPdmtBeHFD?=
 =?utf-8?B?TmJCbTZZZzR6MDlGZ3A4Z3FuUmI3dGk0K3dUS0FvL1dTZmJpREsyeFJtRGVT?=
 =?utf-8?B?TjY0RGdUY3l5NityZHBaYk5sTG1iTVo2OFNYdzhZWnhFMjRmVmhxeGprQWdh?=
 =?utf-8?B?NHNTQklrKzNwSmhjWGg2OWxmUmtucGNtKzBObVVma0ttUnZ4QkhiZ1BvbzU3?=
 =?utf-8?B?ODlaZWtZaXErd1MwZVZwb1hrL2F3dSt2VVVRRVZNbjNETUNpZDIwY1ZlNFdE?=
 =?utf-8?B?UGl3ZkJwbUhESCtmMDczOWFERzJ5ZzR2RXB2MGJrK1h6M3A1Tk5pWlFEdHBC?=
 =?utf-8?B?TFJ4UTdBVG1ScWpVa3Z5K0tMejVwOTNsQWVsRmtRU0J2NmdYcVVIV1h4MWFS?=
 =?utf-8?B?aGlSVFNuelhaR1NPZmZjQ3NzZ1ppL3FEeVRBNHN3MjYxczlxSlpBZUlmWkxG?=
 =?utf-8?B?WEVFd282TlVrQWJSL2NqMmwrS1ZFUitQbjRDVmpOVGRnZVRtZ3IwQlBJWmI0?=
 =?utf-8?B?RlFYeUFqYzRBYWl0V3A0azZmTWJzZjU2MGNYazJFa3VFbkJqbE5ocjQyNmQw?=
 =?utf-8?B?bTQremtjQ2diUTM0bFEyNTBJSm5Ubkp3T2ZUSXI0Tk5QVkF3N05mdXJmRkRF?=
 =?utf-8?B?d1RiS1BsRUcwemE4cG00MDI5dkI4b2hYRCsyUWUvWldNQzdPaEVZSG9uU2w4?=
 =?utf-8?B?QkFIYm1kcjBLL3R5MzhKTmM4YThwei9KMUVwVlQ5T2FQNFphNWJ5RndXalBn?=
 =?utf-8?B?TUhYRkdsNVBCS0tRQ0RKN2xBMEVLS2NIblprUjR3LzFPNk9mY3lNUkNUS2xq?=
 =?utf-8?B?VlJUY1BrQzNZQklGdXFXSXN0cGtGanlSN0FtYTFiOWF2bjBNQ2MyZTNoSTFP?=
 =?utf-8?B?Kzl6emNEampScFZJYm5sR3I3V1RIT1BWMG92ZHdCcGFOT3Q2UXNnTFdrR0dL?=
 =?utf-8?B?dkkvL25GbTY2SHphb2JMTDRQMGd6b3NpL1orbFBjNFMvNFkvVGw5NW56elph?=
 =?utf-8?B?Tm5OY3FSQUVrZFFFVGFxUk9VVTdGaDNBT3U4aElwRk94WUZONTNSUDJOUHI1?=
 =?utf-8?B?Q2U1dmR5OVhSdzA5M1dZdE9mMmFneGs3ck5XZ3J6RDNtSGRxck12ZHVWdVN6?=
 =?utf-8?B?cnAwalByQjl4TVI4NjNhaXBRYkZtU05JUmY2SmxoT1NtV0tmc20zY1VUS09U?=
 =?utf-8?Q?uKsm06Cu2IE3rJA4GBY2GgahC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 654c14cb-cd98-4037-636e-08dd240e53d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 11:30:11.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIDoTjzxm1nNehBFvbdwFQTnnxF0ENE3qNGG/NdIqTRlDEFgz/pF3lDcdDv30yMLnGO9qJE79vClvHilAdv5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4779
X-OriginatorOrg: intel.com

On 2024/12/23 10:51, Baolu Lu wrote:
> On 12/19/24 21:27, Yi Liu wrote:
>> Intel iommu driver just treats it as a nop since Intel VT-d does not have
>> special requirement on domains attached to either the PASID or RID of a
>> PASID-capable device.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c  | 3 ++-
>>   drivers/iommu/intel/nested.c | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index cd5e339fd5bb..0a622a89d876 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -3347,7 +3347,8 @@ intel_iommu_domain_alloc_paging_flags(struct device 
>> *dev, u32 flags,
>>       bool first_stage;
>>       if (flags &
>> -        (~(IOMMU_HWPT_ALLOC_NEST_PARENT | 
>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
>> +        (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>> +           IOMMU_HWPT_ALLOC_PASID)))
>>           return ERR_PTR(-EOPNOTSUPP);
>>       if (nested_parent && !nested_supported(iommu))
>>           return ERR_PTR(-EOPNOTSUPP);
>> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
>> index aba92c00b427..6ac5c534bef4 100644
>> --- a/drivers/iommu/intel/nested.c
>> +++ b/drivers/iommu/intel/nested.c
>> @@ -198,7 +198,7 @@ intel_iommu_domain_alloc_nested(struct device *dev, 
>> struct iommu_domain *parent,
>>       struct dmar_domain *domain;
>>       int ret;
>> -    if (!nested_supported(iommu) || flags)
>> +    if (!nested_supported(iommu) || flags & ~IOMMU_HWPT_ALLOC_PASID)
>>           return ERR_PTR(-EOPNOTSUPP);
>>       /* Must be nested domain */
> 
> It's better to abort and fail a domain allocation when
> IOMMU_HWPT_ALLOC_PASID is set but the iommu lacks pasid support?

in concept, yes.

> Another related consideration is the support for page faults in nested
> domains once PASID is available in user space. Would it be reasonable to
> support page faults for nested domains?

yeah, it's good to discuss it.

> If so, perhaps it's time to open intel_iommu_domain_alloc_nested() to
> support IOMMU_HWPT_FAULT_ID_VALID when PRI is enabled on the device?

IMHO, the PRQ support for nested domains requires some more facility. PRQ
can happen at either stage-1 or stage-2, iommu driver may need to tell
it and forward to the correct domain (nested domain or parent domain). Or
the stage-2 is always pinned just as the VFIO/iommufd does. Hence, any PRQ
happens under nested translation should be due to stage-1.

-- 
Regards,
Yi Liu
