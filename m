Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0043D7D78
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589163; cv=fail; b=kG1kJvVBSJQj28ldpmvn/T++4HHZXyNLPkjn/QSAW5L/Mlh2ldROQUMGUGDcNTO4oAeOFnAl9UneRA9zGVGGu3ACCb1a0k+bkBKTbCcMW/hfw04HHG8zWcYA2GxlHuOJxjwntfcqimWFv61qXuensNdAgRa7oXoaIZPm6zQ1ZTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589163; c=relaxed/simple;
	bh=vUGWIpUAQRt0smF945xEreZOPpGSii4DDL92iLIBLQM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MqvgYbHC6lipkDmFex0/Oo88F/q7dXRFIGLeNTvkbYhz8ksWAJZ1VIScKlaynKIEpm1K8URP1LfP5LaigcJ+DxYr4kxUoeJ/hHPtjSge+JPivqBHxIqWBP2zn6pZZf3s9g4jfoGWSIpfM0tAST1EXT4c4m+yossTcnoIZvnt+zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSJegO6J; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSJegO6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781589163; x=1813125163;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vUGWIpUAQRt0smF945xEreZOPpGSii4DDL92iLIBLQM=;
  b=bSJegO6J0Qa5sQnEB3kQouuB28qDsWRBq9AaQZKGqDvx7cjzAkyvz+XT
   0E4TPPi220khiyMavmnYmxpZenrogLS3WYgvd0Q4M4/VztdmYRu7d+0QS
   Vu8evfddmDqWjLNbwGFZcJtVTk1yYQB8hW2/lNWuWTrxUCIp4gxqzhl7m
   8MRR1limhBkhj4mCy/hdvlayzZGTNlixWi7de/fo9yZkrICz+lVyuiLLZ
   /dGwr0RNC2kPQRadC2O7/iHkZ/sJ6rbGzsq+x67pqoEUQfQEhwn6g+LLH
   cJXp59feyLIXQp73mz2XG6Qvtx42A1h5/UQo2GGbmU62Fi5wFI1hGb9v+
   Q==;
X-CSE-ConnectionGUID: 7eEf+UnQSJqqxdISnqfZgQ==
X-CSE-MsgGUID: gaqXi0scSUO+sfVHu3JxfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82356563"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82356563"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 22:52:42 -0700
X-CSE-ConnectionGUID: hqcaxqIRTJivfMaetFRg0Q==
X-CSE-MsgGUID: WQ42gMLKS9OZ0EmosgTMgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="245278012"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 22:52:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 22:52:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 22:52:41 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 22:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkry8sQGazAWw86RyX1zjQygjL1CijuClLtyN5shAcvuOTAjXJ0NokKzvGAoDXFWMgNRQwZ67yQxtyg2+jIUUFwt4XDzshJHJl2hPGx2cB03bL74GGdDPnXexCymC74aqtHg9Es6mc8MdlaLv8FlGhaMzIuE8EAaLQXKFDQl8bhNT8cCNB5z9+VDjJAtiZ/0CTxWXp/hBhafGucgVXHt4YavDHx3k2HmI2KxsoVU1Ti0ta4IVVO7vruD3dmRDn8PtF6+wl2X/fjUg8Z4Hfi13aYOBda0Hh0BbHNL+GNzCyfzsD4UuDSx6lTWYMw7ZNciQzs13UxStkjzBykBx3PdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQSxudvPbcS+Il6Zh4/FvTfxuKFmXSE0EqxdicbD/zs=;
 b=natkh0Em7MvcVX8p/iOFzBIIKUNgLIL+VnS5qGN8L6hs3kMLAH7fBWg2xk8oQO7Qws+oK4aWMoehCFj3zWKFbHzGucXDDYVEYfcqXE57z/Cvyl38PYO0S/SwR8DLBuyFhjP/VWTfYu5+sIiRJeYCiqq2xG5LNx88JS2N3UHPvaLHpEQY2giIXQNy6TwtsFcSsT3ZzwVa6SWJCY6OAfdlCiGLlugoXEnjjO9YILYjNC7wgDBp5VewjOC84IpZfXF2kDLnKuco4SBFmosPSbQgGOcwhamJ8YcoctLOqfe6wcvt9FdAC9dEQt51v100Z0t2/wy4BiN6cywvBleEb4EusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by IA3PR11MB9181.namprd11.prod.outlook.com (2603:10b6:208:571::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:52:39 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 05:52:39 +0000
Message-ID: <fb86804c-5a2b-40a6-859d-88810731e70b@intel.com>
Date: Tue, 16 Jun 2026 14:00:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/6] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu
	<baolu.lu@linux.intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
 <20260611172658.3421138-5-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260611172658.3421138-5-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0039.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::13) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|IA3PR11MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: f9478fc4-480d-4b79-ce7e-08decb6b7952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|921020|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: r7f5YF3E8enOcwmbM4+YFrjmsnyjpqC0NdD4iUB/rwWh8ZxQFfVVUt5Y7HzyGTZtZ/y7kLTKRUGKDDtvKXdY6/r7SX/Pz61vDuWewKdazZUrDA8OCPxCCaiwUCAOn4wJ69JARB+bS/ZF6OvZhXyvngG017n+NubiJgTWr0HcTTwNiO2wLA+vbHJNncxZaH1GoIR301kMlGOb9Z+qWSz4AkMtWXJcHl3wAtpnPQSJksm/w6HPhvWe8gRBnbAEv3y8T2X+OjGZEi56JArxbZWMeQhDcJ3hZ6ybnapDnDkxqcU1YqSa3DUqEf2XLNnJiVyFy2ALYhAVCdSeFtJzt1EwGKj8bET6janl2DUAyzvehWtbIHgs9zdYzvzXVN7PZF4xPpQhqNW9dLRtanwmunx32miSEK5pb5YniLKbkinYNu0F8W4ZwrN/s5lxe1YUU1dGlbwnBJzfME7kc3zbr5CaA+SLT4brHeqIGAJ3umBce3LC0sL2Yiied6EtsbPfpfO+UY3tF9iVC2T82z9BymHY+DJ/3SKh7qO4Tx6+YfWZqqkwMk57jW/7+PCbX/ZGxkq65GkHtwofE+486IP3C/V9deImHlgbt7/u7ajycMuYtieFY9fVl0wdxB8V6c5Px0NxW1PmG3OlhsgBhv4ivOrO/U2D+SF8j30mLZchM2C5Y+fzlSDG22IjDOlejwTRy3VVdlwxrERx6/gJicyFsrKJPSa4SkrUAiCt5oI/fZtBoQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(921020)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEJ1bVlkdkhzYjNmWFpZOG94WExPazhPWTg3K25EN1N5T2t1bitjRmtpOERX?=
 =?utf-8?B?Z1R4b0FxMGFveFB4QVl1Sjkyc0FhOHFpYjUyckJ1SGFBbFdGZlh1OGpOZTdz?=
 =?utf-8?B?ODB5c0daOTMzOWtxZkN4VWIzWU1jZTgrRDFPa2FLb2d0dWlwOS9kc1RNamNB?=
 =?utf-8?B?MUs1dm5OVm9UaTlKWElMd2w5Vy9pSklPSmtlbHBBQm53TnRLZ2RveUt3NUpM?=
 =?utf-8?B?dWkvWExFeHhvSnROcXRmRmRrbXpxL294Nzc2Y2lNRXRPUktvWStma2d0Q1Nt?=
 =?utf-8?B?YnQvZU45c0pFeXp0QTNMaFQ4NGFSeFFCZlhiamgvV0ZITVpZTXVGN3l2T2U0?=
 =?utf-8?B?aytwY0xJVmEyRlU1dklyQURHamdkZmZpRStOd2ZGdVcySVdqMFhxaEZYVlFs?=
 =?utf-8?B?SnFXRVRLS0EwS2VPRUpCZXJZVEdvS2UyY1lMeG11Qk1jZnF4WDZZRFhqUE9D?=
 =?utf-8?B?Z01rVWszRUxrQVJSMDFCaDBOZEU3UEhBNUZRNlQ2ODRyZlhjZlVLcHVZR0dR?=
 =?utf-8?B?ckkzeGc2VVNjdkxyb0lFUnBRNm1yNGtPVzcxSkcvdEVZYXV2WmlEV2NrVGRk?=
 =?utf-8?B?djZqaDUwZjNDRHFIbExmTWJ6UGFqeWxYWkxLOHJpQ2w5QlovNlRXa09XNmxR?=
 =?utf-8?B?SWhrTmNXeVhWZDY4SXBERE9KeGVaMlNpc25pT0ZFNXc3R0VQV3dnWlFUSWRa?=
 =?utf-8?B?TDFtN2JINlJmb2ZueWpGaWxDWHVIZmJ1ZlRxQTJhMXFRSFkvT0oyVnZqdU9a?=
 =?utf-8?B?akU1QzE1UE1SWnUwdWVRbHhsbUtyeG0xTVRITFlJWFdJczlraUhQeWliR2xs?=
 =?utf-8?B?VFBDWCtkZ2VZbDkwRTY0dG9rRWRFV3Y4TlRKTW9nUjIxM2RFMHdHUEtTRXEw?=
 =?utf-8?B?N1o3dWE3YWhYelBlTUpoUFVXQk5Gc09Jb1o5RWlaWjFPK0R6OUVMWWIvbXY2?=
 =?utf-8?B?bU1FUHBTbGNDM2NGaGVoeUI0eDdMZlZ6VHpTVG52OWs1VUxLZlZZWmc1Y0NI?=
 =?utf-8?B?MDdRekx5aU9ZU0t1bXdINnN3RW5tTTZVWEtjM1dCK2xRVkVZdG90R2xqOHBY?=
 =?utf-8?B?SEFlbmNJTTZIcFprc3NuN2FnYkJ5Wi9PMlNzL1RkOWxKNWRWMkxBdWlSNU5J?=
 =?utf-8?B?UGpQZXRYb3JjZG9FTDBEOXEvUTRFMitHdlJSYi9KeUhmaFlPUVFxNVo0bmVw?=
 =?utf-8?B?VmVhNkFPWXRVL2RtSEVZdEdVZnlkNTlwR0lYRkJKYnNYYUNnWnRJQVVabTFU?=
 =?utf-8?B?eDVLaHBLMVl2YXZjRnAzQXNBc0l3R1lLUUZ5Y1V6bXVJOS90OEVsTFVDS0M4?=
 =?utf-8?B?RUtGTHhpbWtjaHJJOUFNN2czaVlEclRxamMzTXQvNkg0dUZlR3BOcnpYNlU3?=
 =?utf-8?B?Q3JybkJaeURlMTNsdzJzNnQvaXFldjg0YVQwcFc1dW1UNVFkQkRXWkd1U2Ji?=
 =?utf-8?B?UVJKZVNkZzF5NEphZngzTTJWVlZVVjhEdVU2ZWRYYktNakdNUm1TRFBNMktv?=
 =?utf-8?B?OHpwa3BsSVFtYmZZWHNTSUVJT3ROVFdiY0JKVGVqSjR0TUxZYzhMMG9CRUhk?=
 =?utf-8?B?bjRTdm5tM2JwRkJMS3JabDFERk81WHNmMHNZaUhJSGRQM3ZocVBraU5RU205?=
 =?utf-8?B?aWcvY0NMRE9ESSs5WWxUdS9HalpZYVFWZ3crRjhMbysvbmNGSHRkSWhyLyts?=
 =?utf-8?B?WkxUNndseis2aEEwMXNIS0RnOVJGeml2aUhhc3dZM3EvRXpIdTFtMlNQZGhE?=
 =?utf-8?B?OWRaVXE1dlFaNkN3UlZyWFhJUUFQaERLbUMzeTNJNFA5WnlXTldQbTJiMjl6?=
 =?utf-8?B?QnROek9Ta001U0JtRVJBKzhHSUxxclhyajZqYnI1VkVmQndSeUlXWVZZLy9Z?=
 =?utf-8?B?WVBJL0k3a2ZGdC8wOFBRMTl0TW9FU1Q1OHdHQ0lzdU1NemRnWG81bGR1bFk5?=
 =?utf-8?B?V2RnWXFZTUV6UnhvZTU2UC9Uelo0ZE8rUHU4WFltMDBidXRBSEVUaWYvN0VP?=
 =?utf-8?B?ZVo2NlAyNDVpT2ZJRGVrYUdHZ3FDRG1aYWMvbkRKbmR2bk1sd085VUNnZWdY?=
 =?utf-8?B?ZUk0TkNucldRNFZnNkZOZzBlSEllSjhlNXRQNjJ4a294cGI4a3Fab1hQV3Ew?=
 =?utf-8?B?UyswcUp6Ni9wbWpBSUIwamtnL0diSFVpVnc3T0loM1lnN0lkUUdNaFEyeEp6?=
 =?utf-8?B?cTlnWUZLenhtdWNjL3lzL3o4N3BpSlZVWDNoNWVuZTFCTVZWampuWnVsNU9D?=
 =?utf-8?B?ODA5blhidEY1S1BsdUxnbDRvNThyZm5La3JVUnh0VjRHUG5KTmh1OGwwOC9a?=
 =?utf-8?B?blloSnk4d2xtWUduVVlnMkR3eFhFTWZ6ZDRybFF0djZjNkgxbjRSdz09?=
X-Exchange-RoutingPolicyChecked: lEJipEWbTw9nYStPvUW8gypCKImdO6hZqW7d4lpfOB8yvkZi/Gn//sUakQ1/DJOwa/XIu9vXUlBUR9nDkvCwR87RPJa30xcLDQIkGBg4xSvhckt7BEIi3ScYacNuH472CZ/lJqbkGPxPmZp84WJikx663FoOpaN70+pC/n/Cqoh2Col6v4NknlYlgrmKLmyqE96q64Ke4WJdZUYshyZHh5DQ2dFXs51MsoXEDsWiLXn1LS2RXp+Cm98vIMeoS4y8GhAvpSj7fHqFsEAXjiPmisAao5gbrWxIn6nC5qSjLzMPpz4QV2ZxAorjCbYWnkM74olUVKl6BemwJEe4MUz95Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9478fc4-480d-4b79-ce7e-08decb6b7952
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:52:39.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZW4Egpq1vW+TykMcBlT2/ChF95gv8APOnoxl7f+S9iwcki6TuPOeddvOinAqkDhxaBF64kCLJ9XqPsjYfYNdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9181
X-OriginatorOrg: intel.com

On 6/12/26 01:26, Jacob Pan wrote:
> To support no-IOMMU mode where userspace drivers perform unsafe DMA
> using physical addresses, introduce a new API to retrieve the
> physical address of a user-allocated DMA buffer that has been mapped to
> an IOVA via IOMMU_IOAS_MAP. The mapping is backed by SW-only I/O page
> tables maintained by the GENERIC_PT framework.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v9
>     - Make no-IOMMU GET_PA length a real upper bound and reject zero length,
>      avoiding an unbounded scan while holding IOAS locks. This matches the
>      bounded-range semantics expected by the incoming
>      iommu_iova_to_phys_length() helper.
> v8:
>     - Fix comment on start IOVA range (Kevin)
> v7:
>     - Fix commit message (Yi)
>     - Avoid duplicated tmp_length settting (yi)
>     - Handle race with dma-buf revoke pages (Sashiko)
> v6:
>     - Limit search length (Baolu, Jason)
> v5:
>     - Fix next_iova exceeds iopt_area_last_iova (Alex)
>     - Rename IOCTL more specific to NOIOMMU, i.e.
> 	 IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA (Kevin)
>     - Add header stubs for iopt_get_phys()
> v4:
>     - Fix ioctl return type (Yi Liu)
> ---
>   drivers/iommu/iommufd/io_pagetable.c    | 78 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/ioas.c            | 36 ++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h | 18 ++++++
>   drivers/iommu/iommufd/main.c            |  3 +
>   include/uapi/linux/iommufd.h            | 28 +++++++++
>   5 files changed, 163 insertions(+)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

