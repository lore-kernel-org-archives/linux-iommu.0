Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793706695;
	b=GNBe0wJ3b6o5ICtg4GmyfZ9jkOSAV/Bgo3W/AcCVvFWdKxwUEzmevrcYh1llEMIy9SaJ
	 tMLBOquykj8jMu1SYyB7JxH6DBY0UmhLvbFU3yCW+/veA/q+pTtaZB25Bj5BybHeeB5KF
	 Wh6FpV32KYkGVwFfyjEu6p3Be+La50nKR2pMWgxRXnxEvnj6C74Z+F+f1SZTbS54SvK9a
	 Ls24flfqsYYdXyEPiIEGFonzLFpYtFju8lTbT6kX9dCIVULRLuEjioIVNLO9SJKjb7xtl
	 IwIM6GwgGGkyegsZCBh12P/DolTjB9lg/R2Bo0ARyectfFZb9nOonuTVBNl5rxV0lBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706695;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=18Daivnt6zE9UD//VC7SQYUlk8RVm5hsPyqwDZJVQYI=;
	b=J+UEMhVCffw2xAlqP+kKDb3lfOWbyv6ZY1RKk2e7bxPZxQSk0ZKCysd6q93TK0vgHqdu
	 G92z9gU3uTTp7rmGij4Q36dJNa0nbTuUkJ/ad3bdpG5Qf1fT6afKqAbKQ560qWaNaOXMX
	 Zo6+M3RFJTS/JUOpfwXIqbWPu4tdIHdBBR9gORRMFnTF7MwKU9UzhbUoO6PlZUbReOwVg
	 gJigA3OVRy1arz1WiPkvsr4cWgEXG6gr7ESGyUR2ie7T8IhyjeAkAcI2nO9ICt4Dls5XK
	 CLZwJgHoOCve72pmG+x772v8KAXvEv9Jyy9oz3n/gj2lukOqT+f2zGPp/9eMVJt40WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bk2I9PWe;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C33606D821
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 11:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19C33606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bk2I9PWe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793706695; x=1825242695;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6K5ghJY02mmQZzqOD9p7WWwnADKtYC0ac1WKx79SGr0=;
  b=Bk2I9PWeK5aBwDVQoJGPnHYO/BRCNawdagqPQb9qw3KsTisKFDfn7tXA
   JZIVesdDmqb+Y66x0p5wQ8aP55BkBRniJTgsHH/yVfdMZZMHp8683I1li
   JaLYRaU+5lp1SjVSGaIBzjF7LIpSpMTK3YlU601jTk0J8Arq9/S7lqSx4
   q2JTRXoWXUwfjhFlJcyndb4BiP7QatPNWPvnkaZkDssIXw4EJD2SxUiBn
   Nz5lyn/FfRYrCjnOXBro8wszxXQJjpfaZMgt65Qlmz6GXO4DISEj4AQfA
   Z+DRdS5V/P3m7EL8pUKAQa7OgvQj/erpgnuVfmONKqPl2wKwPLMAVlLyH
   A==;
X-CSE-ConnectionGUID: MukklF2vSHiKGhddCYBpKA==
X-CSE-MsgGUID: 9ERGcCfjQi22HTvEn39u2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2457921"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2457921"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:51:35 -0800
X-CSE-ConnectionGUID: yuIaVfF7Qi+jcd+bJegPlQ==
X-CSE-MsgGUID: bfxeke1gQ3yPlZbAUXza/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8193021"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:51:35 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 03:51:33 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 03:51:33 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 03:51:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbgtRGuruz5EKaIk8K4SGHLyLgq9VdNiaGWBNIO3n4tYX+AP175d1yJxduiRv62AjeciRh2Ji3kq4zbXcWcpUEKvcxEBKBwEJ/QFIZzfzHRKe3ir0/VCUoukMrtps2Tr8mMye/0HtskFNm02DiUN1O30TZySGubrQp0W1/mdSzsu2ADK/jiFpMzg5Jj0NyZbDmGcOkWB/gTtgEap1mKPXaQRbxplittfSCIxke+YIFbNkVRoML95mn9a8SpkFUrq7gRKM4opm3tNwpj2LZe8gnDULB+pMGNPD6TKyydx4HwrQPBrztwoWrLSsTqIb/MCNYcEs4KVSYqSJmTkLlYtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18Daivnt6zE9UD//VC7SQYUlk8RVm5hsPyqwDZJVQYI=;
 b=ePuF4+J8fXDi1POOh42+61s8d0L6wO4zlxqBdYvPEA6r0CnK7AX02knc46d4xytceZ3/zR9X0ZVTWbEdXUr/gaZSriBparuPteNgnkDlUMWrCAQ/CzycbUtnfSQnCK52/5fgkLJJJj+lxxjrf+PqwuX4iBR2csZnozbrYNz2WdNz+Bki8tuXus+qCxjBNi03rCPIvSfHpKWLSvj73gM3j2Jrb12eROQ4LnO9wafN4O/+X2aYs75juy7jUWRPPLMCHAO1PPc0ZrezgCwNwZChFQKjj5269Bw8lJ1CQT/uAdF9pfar0r3HDXeLZSsQYeEIAlK7IsLmQsoL7Fs093loJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 11:51:31 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 11:51:30 +0000
Message-ID: <68570abd-f619-4d9d-a7af-d2acf1f9aad3@intel.com>
Date: Tue, 3 Nov 2026 19:59:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iommu: Reject a same-domain replace in the attach
 handle APIs
To: Nicolin Chen <nicolinc@nvidia.com>, <joro@8bytes.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <cover.1793602084.git.nicolinc@nvidia.com>
 <b7dd43ba78b7342a2e0356870502746a8b7f34aa.1793602084.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <b7dd43ba78b7342a2e0356870502746a8b7f34aa.1793602084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|CO1PR11MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b6e4b6-89c3-449b-a4ab-08df39a0cccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|376014|23010399003|366016|10067099003|18002099003|261102123227099003|6133799003|22082099003|261102130727099003|5023799004|11063799006|4143699003|56012099006|261021121427099003|261026140227099003|261021135927099003|261022115727099003|261026130827099003|261022113327099003|261022075727099003|261022105027099003|261009223027099003|261028144727099003|261021130227099003|261026121527099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 2b31/gG2fTLjwxIKm7DGX2jw4gd+edohlJ95AqwMorZzBl1+XUapE27vDvWDDNyI9r4VuTjQRp8MpItkm98tqZAeuYJo318eLCHNaUb+EmOC3rdxauXYDT812VoQGrS8Rbjui7gECir+9QyJF6aTHGj+GRm+7LZVUYQJF54wBqdNIUDNl1h7EwkRTjvJ7UHMgo311B6gwxg6h/bUOxuIzCEbZQxf6uBpYmmzWYgsBVuwq3xjQWcmNwTtZNjUix1cjiIa69/ayr+sM7ClcLyaMgs95UF/wg90x2iOEEzhAbhjdeTbMUNTOmAEQTpfcltnJmhstP/WaF0/HJX5dftZRvaeIyHCXifVCCVoh5vY4NuXoxl9na/tWqmGHiW74p46Zd/1zsXnbPgBZvl1QluswAneuv0EN+4G/sCe/XdmMBhjCxf0i8uKXNkmcrowd88JaY5PuNN7J5Jkws4t0+jzsg/XVb0tv2/cz066/Pya79nWp3aOO/1Htr0BgAWrpPgiVS3Ag6DLGD0YTldW7Hp6Wu7r2Fb3PTodVBqAQH5WkUzOj56UqlfJRB9h33IglPRhKkqiL53DJKVNsulQM/oXY9SBQA6fbHyt137bwSIc17NipoSW8DEL/whrKvIhnnaI2K8VMjowLCO1vVtmLndnqdVTZnETHsG8K0bn2a6PxrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(376014)(23010399003)(366016)(10067099003)(18002099003)(261102123227099003)(6133799003)(22082099003)(261102130727099003)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261026140227099003)(261021135927099003)(261022115727099003)(261026130827099003)(261022113327099003)(261022075727099003)(261022105027099003)(261009223027099003)(261028144727099003)(261021130227099003)(261026121527099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUFPd2hPUjZBQXFYSVI4WTNNTUVvYUNzVnU5MEtVTWZrZ0s0cEU4V3I5b3B6?=
 =?utf-8?B?WFZFVUJGK2RSRHd0SVBCVU1hSUQ2TkMydjhPemY3SlZBOGx1aHlua1pGNGVt?=
 =?utf-8?B?cjNvay9zN0k1NlJXYmNNY3RkWWlYRnpoYXE1WjkyTHlwNzR2SFlGMytKd29k?=
 =?utf-8?B?UDgrZTl3REFQWjlLakFJZXhEMzl5MjdiL1V1QXJpTEh2eFR2STJPdEpxK3Ns?=
 =?utf-8?B?aE1lSU4wR1g4cStNa1VjWVhXMXl5RHZQVmljWlZPUVEwNFc5VHpQM3hMcVVy?=
 =?utf-8?B?SjVLcTZLNTRZTWJid0RNNm9EMlllQms2eldtRnJHTkR2MHFKNU1TNS85blNB?=
 =?utf-8?B?eDdYRCtHY2srQ0NoeGIzQVJmV1ZkMzFvL1BGRXBMRGxpRXFxRDdGdm1JVm8r?=
 =?utf-8?B?dVpPT1JPT2JIUVdNcHk2cFRsdzRhL0tqL1ZDa3dLY080ZWY0bER1Y0ttWkcv?=
 =?utf-8?B?UUlBdVNRNFhrckcwUDVCT3YzdWNnM3VGYzlJL2FVVHdWMmtYNHBQK2VhZG1P?=
 =?utf-8?B?V0I2RE5HenBvc2V6dmJGcTU0RVlSMmZiTVZqdDVKaDliem9aK3p2NUtxcm1m?=
 =?utf-8?B?eC9TL3ppaDg4MVk5bXlDN2R1T2FFeERtTi9OY1NRSVlaaW43bkVsVWl6Vi93?=
 =?utf-8?B?cVhjNlIwWHFEQzVoRktuaXo2bnlmQjhhaURWQW56WmFNa3grdnVPUTdLbFUx?=
 =?utf-8?B?cHBFejJoYm1DSXBrRkl2andQb0M0bzlhdW5XV2xUbWNlWmI0dmtzK3ZZMDRa?=
 =?utf-8?B?TlYzQk9mUTI2T2tBS3pHaHlPY0RpNWp4MGtzQ0J4NzVteDFzV1Jia3UzVWZx?=
 =?utf-8?B?Rnh6UndEejJBcWYyZ2V3aWpGRnFlZWtsVmtGcjc1NUZFdmJWaHNlSVUzeDBz?=
 =?utf-8?B?L1VZYXFSS1k4UEdidEsxOFZ3all2dWFwVmhSVGg5N05SMnJvTUV5ampTSWZ4?=
 =?utf-8?B?SGtrMUZXd0E1M1Q3QzFoUzVHcmNGU2JNOGJwOTdCYUtONmZENEFpeS91ZjVM?=
 =?utf-8?B?SFQvK3BHMk9KZ0RtSElTUEQza1ZpWUFNTDl4VjdtSjRHZEVkOTkvTjZ2SWNl?=
 =?utf-8?B?S0xqRVk1NDRmSW8zbzk0R3pNZmhwUjdqVWhDd3ExU0YrcFBpNHRBamg3bERr?=
 =?utf-8?B?L0pUOEhHUlh5Z0M0Qi9CNHFFeG13YlJVL2FGNkpMbXltcDVQeWtNdG1ydU8z?=
 =?utf-8?B?NmVqMldVVVRJMVZWU1B0ZThmQTRzSXBUeUc3VWFkcDV4OExuWnRGWElwMytF?=
 =?utf-8?B?RjlrYVZGRVhKSnRXbklkUnY3VXpOYUxTTHZHTE5ZOFkzOW1KKzB3NCtpRFg2?=
 =?utf-8?B?U0F0ZTkyVmlGWmoxREJLeXFvQkZ1WWlHQzlvTURQWmdPbnF1T2dJUi92S1pk?=
 =?utf-8?B?dzExTzlEdldzUWc1UW9XbUZqS2NaMVV0S0ZYeHB2dFJhUlJZaVdYKzZ3bXND?=
 =?utf-8?B?K2wvbFpvZXQzNHVqbTNnZFFWNWltcUw3bW1xeUlqRThFTjdQNW8xYUZVWWIv?=
 =?utf-8?B?MnZvYnFFbHdCOEZkWnlyYXh0eXZMd0grNlRiRkZXeVBXeXppS0xtMlMvbTBZ?=
 =?utf-8?B?OU43QUJ4bjdZYTlEV2pETEJsd3hiQmZTaExpS2wrby94bWdaNHJ5VFRIdjcr?=
 =?utf-8?B?ZUNFc2YvZUl5MVVuWGUrd2RqaWt0SVNiSStFTlFBdGdVTndXdllSNWw1dnAv?=
 =?utf-8?B?WUJQL09qVGN5TXF2NjFXTVBIYkxDV1laUjdNWkMyY0taaDgzR0h1YkdOd3RB?=
 =?utf-8?B?QUhweWlmYW4wSHNSa2ZGMzBKOFpwMTVGZ3VtMHN0T1lMSG5kMDRmRXRyeXB4?=
 =?utf-8?B?VW9VVjV0ZVZyM3c2bVBjVXdFM1hPaVZPNFFNOGRLdDBPSEt2RnJoenBtZ291?=
 =?utf-8?B?eXhGcGRVYzB1WVcyVkF0dDZlZ2VXUzM5SklDZTJUNk8xSWJjc0dYVnRyM1ov?=
 =?utf-8?B?aWZqOGh0NmVvcUt1VlhCR1QwSkpSSEptRDBQQ0ZoT2NBSzh5eTRUUThRTjA2?=
 =?utf-8?B?U1hBU1BXMGk1UGIrWm5DVGJGNlpZM3orK2lWTzk0LzQ4VC9HRkFSNjIxT3BT?=
 =?utf-8?B?cWNpN2psVndMSTFoS25iUDdBN0c0UG5HeWpwMDFJS3QvWjgvT3JZeVFpUXpp?=
 =?utf-8?B?L0VyWjh5TnF5eXdPbFloUlJWS1daaWxGQ0JJaG41L1RoRTBPNVQ2ckJGSWk0?=
 =?utf-8?B?MWI3MWxuTU5wWUZ3NHNCcHNLODh2L3RwVWt3Yld4NklxbmExYzBpclhqTUpk?=
 =?utf-8?B?TmxaUTBrbGsvL3c1eG1oYjFrTmFSNjVSSWlvczhQM1pJc1pxbXlYWGtOemU2?=
 =?utf-8?B?cHpCa01hZGQrN1g4Nklmei92WkZVbFVFdFpUaEUzNURZMEsxNjIxZz09?=
X-Exchange-RoutingPolicyChecked: BtI+iAmVNqNn+M2IaaySeOewR6z6ecfU2ZHSrQOSS5RM8mZ9S1dBtqQp2LlXzsXyRpBAaPpIlAEbXWRXKQNYPr7dImeHpmWkZFuGojWVm6hXFteiTzZDakZoXsZiacc5EskAs2lkK5JHB6VmLqejXGZUkj0fzg3gn2Mm1ZqEYXCbl7STbXThU5K1v8J4tM00jhMrCVbbcPjCOR2pxXwIs0T19xkv87ao3ibasrUOQyOBruzoFUmK7+3lQpcgap1u83YJyl5P6eP0EL3XMsjncrA8dAKVCOpV6LKBrv0Os0WFpXSi+Qkr+V9xICKzJk8BDgomSw9RXfAVWOSHCc3Wpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b6e4b6-89c3-449b-a4ab-08df39a0cccb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 11:51:30.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCCo9JENjrD0N0FDCCmirEGudJV3dlh080CSTEdxXEkXhBH0hCL9UsdAsuNXcT+iBfePyD7ug+3/X450rfMrfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5089
X-OriginatorOrg: intel.com

On 11/2/26 15:04, Nicolin Chen wrote:
> Both iommu_replace_group_handle() and iommu_replace_device_pasid() skip the
> driver callback when the new domain is the one currently attached. In that
> case, nothing flushes the pending faults that may still be holding the old
> handle. Then, the caller frees the old handle once the replace returns, so
> such a fault would hit a use-after-free.
> 
> No caller does this today, since iommufd_device_do_replace() returns early
> when the new hwpt is the old one. However, it is only a caller convention,
> which neither API enforces.
> 
> Reject a same-domain replace in both APIs with a WARN_ON, and document it
> in their kernel-docs.
> 
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 34 +++++++++++++++++++++++++++-------
>   1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3fea48d3538ad..a9bc4ca5dbb4e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3716,6 +3716,10 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>    * Caller should always provide a new handle to avoid race with the paths
>    * that have lockless reference to handle if it intends to pass a valid handle.
>    *
> + * The @domain must not be the domain currently attached to the @pasid. Such a
> + * same-domain replace would skip the driver callback flushing pending faults.
> + * Then, those faults could use the old handle after the caller frees it.
> + *


Not a native speaker, but this reads a bit ambiguous to me:

I parsed the last sentence as describing intended/acceptable behavior
rather than the hazard being guarded against - "Then, ... could use"
reads like a neutral continuation rather than a warning. Might be worth
making the use-after-free explicit, e.g.:

A same-domain replace would skip the driver callback that flushes
pending faults - this is a use-after-free hazard: a fault still holding
the old handle could dereference it after the caller frees it.

>    * Return 0 on success, or an error.
>    */
>   int iommu_replace_device_pasid(struct iommu_domain *domain,
> @@ -3785,15 +3789,17 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
>   	}
>   
>   	curr_domain = pasid_array_entry_to_domain(curr);
> -	ret = 0;
> -
> -	if (curr_domain != domain) {
> -		ret = __iommu_set_group_pasid(domain, group,
> -					      pasid, curr_domain);
> -		if (ret)
> -			entry = curr; /* restore the old handle */
> +	/* Same as iommu_replace_group_handle(), reject a same-domain replace */
> +	if (WARN_ON(curr_domain == domain)) {
> +		entry = curr; /* restore the old handle */
> +		ret = -EINVAL;
> +		goto out_store;
>   	}
>   
> +	ret = __iommu_set_group_pasid(domain, group, pasid, curr_domain);
> +	if (ret)
> +		entry = curr; /* restore the old handle */
> +
>   out_store:
>   	/*																										
>   	 * The xa_store() above reserved the memory, and the group->mutex
> @@ -3985,6 +3991,10 @@ EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
>    *
>    * Caller should always provide a new handle to avoid race with the paths
>    * that have lockless reference to handle.
> + *
> + * The @new_domain must not be the domain currently attached to the group. Such
> + * a same-domain replace would skip the driver callback flushing pending faults.
> + * Then, those faults could use the old handle after the caller frees it.

ditto. Otherwise looks good.

>    */
>   int iommu_replace_group_handle(struct iommu_group *group,
>   			       struct iommu_domain *new_domain,
> @@ -3997,6 +4007,16 @@ int iommu_replace_group_handle(struct iommu_group *group,
>   		return -EINVAL;
>   
>   	mutex_lock(&group->mutex);
> +	/*
> +	 * A same-domain replace would skip the driver callback flushing pending
> +	 * faults. Then, those faults could use the old handle after the caller
> +	 * frees it.

ditto.

Otherwise looks good.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> +	 */
> +	if (WARN_ON(group->domain == new_domain)) {
> +		ret = -EINVAL;
> +		goto err_unlock;
> +	}
> +
>   	entry = iommu_make_pasid_array_entry(new_domain, handle);
>   	/*
>   	 * iommu_attach_handle_get() runs without the group mutex, so unpublish

