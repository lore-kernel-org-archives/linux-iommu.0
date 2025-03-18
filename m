Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0420D50F
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305507; cv=fail; b=ZgGEbvvIoTpRXVIqCBCKF0l90bSkmJqcsa47DoLWYtKDtU3gLQP1+MsXMyQDkuF1ZCylkQXsyVOIqJdUFGS7j5yZIMeWrCjIzRyUKLo5Prh8dumMJtDQxDVF6T4y2c5/LPb2HRY4ILHn7HPw3FgcqDKgUtJO2ob4yYd48cabImM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305507; c=relaxed/simple;
	bh=KohwlgZlllUmqz44JYoEal754TT2BXz0SK4nVoiCDVE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eTVI2tY5xluhmk0F6iiDcjQHTD2xn6RkvLmPOy1WnpiBLWFjlffkJVW1AkRSiiW6NpR3Y0u/9nHXMPrF6LFlUzDhrYfbcf1PAewHnvlZ1lfikwai4I8BDDRDzOjgpGuW9CQM7ZDmpZiYRFqdC/qWmV0LaGks7GlRwai3L+vkZFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxCoXSXt; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxCoXSXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742305502; x=1773841502;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KohwlgZlllUmqz44JYoEal754TT2BXz0SK4nVoiCDVE=;
  b=hxCoXSXt7uUUrAXloImThDhcX/9lfwfEQL72/tQvhh6B0cUXQbkQjf6b
   I1YAqyVVUQ/4Po6tbCU8DBIZERBsg9ytr3MBHTxBHRbTt6ZBiwdtAqsRk
   g+cBwH+Qt/fGPfsvvy9SEUHRtePH3swWBAiDlcbQ3uglbTOZMNuBigw2u
   jC90FDeeBYjbPzoONPA85RQiTiEQSfjqAb5JUKWusaWNIHSU3oIxnWCqI
   rQaigzQLusgiJZL31HZrPyT4c/nL79OX5PhgnUf4rxCCGI3kMZErAqS4n
   rroHbE8Y10afhsf+vOFrkwSy2OCsNXtphwtUSi5uUpfOOvh86OzKOFG+u
   g==;
X-CSE-ConnectionGUID: xj3VR2NzTw+3lA5+01XIbA==
X-CSE-MsgGUID: Htf9GljjT46U59/2NIpd0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47093617"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="47093617"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:45:02 -0700
X-CSE-ConnectionGUID: DGHDEl5fSGuij8ofj4j25w==
X-CSE-MsgGUID: UwLWt4O1R7+Llz64wpXB1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122762182"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:45:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 06:45:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 06:45:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 06:45:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWXe8qCxNoO0+q8bpnfVjvuPC44ylZivB+7HiY8OpX0PqYdNHeo0PsXPkN9Uyc0/GokYib64+JrwJG318WI4RETMUFde3tTJUpk3rj+jRlRaAMsw9pLJcnwipcLriuoj0kyVFFrRdSN1Cqww9qUmRRDXpD5xnkK5k7Lq9f9TRmiCVYCq+mVhqETDdiOlHthfSM7GYQtpFU3iuSIoAaKGcp6eEGxJNCUE0vrmTnXtKBRYP+/etT/VeCtoAnTgOTGbtDdYhbW9Qbos+PmxAAdFK1WMXdfVu+EaJl51PijoJaoDUxrMTu1l0AlYYLEY7+7LDBYz/oIxeqCJAivkunevCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laFZNebEst98reY6txRR1Q9CrIEATFzoGVidDcLL7NI=;
 b=JWEzRkCgZjXM+fl6GQJM0EuZscKXw906hhIUZ4x06MgHmGIejORkfqFQ4TXuPp+Sk07N68ChsxdxD2oT9kxf6ky4bcIxeGsCaRh0o7FDc9r+UiLYxhQEBfBswCQctJXUnBbnpCuAXzXjPut6KYRT3w75Zx5xTg0eP7pbfa7Qt1OmaCghCT2sKB3yHmJX2OoBsywGetde8ux1sYA32u4/y0u5Dr5+FnT1KxoOvgPrkD1NigTYzktL3KhneyWKVcZFEdWscxnEI+ff+50INKCeqpJKcd7yKgUM5lxyF4rBAJaaCxTODh7C7D2zPoc6GZ4+2u/LyVhJfB3VP8sqtpTs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:44:45 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:44:44 +0000
Message-ID: <86c4cba9-5e50-4886-8253-0829e7620a85@intel.com>
Date: Tue, 18 Mar 2025 21:50:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/21] iommufd/device: Move attached device tracking to
 handle
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-12-yi.l.liu@intel.com>
 <20250318123406.GJ9311@nvidia.com>
 <bafc2cdb-fea5-445b-a7a0-5a1fb390e3f3@intel.com>
 <20250318132652.GS9311@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250318132652.GS9311@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0a54b6-75ec-4719-84f5-08dd66230a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTVUU3A0SXVDVGhXU3BiU2pid09DalY2dWk3S2Q4T0RDTjE4cXFFWDBnOG5W?=
 =?utf-8?B?eXkrRitBc1FLN2NJd1ZDdmJNZ2RSS2JwcFRzUEpBUFQvWThNZHVwaHNpS1Fh?=
 =?utf-8?B?N0htNCs0NjZCdG1uYkNoU0FQTjh5RVp4NkVsQkdwQk5EQUNJWUtPVXgwRy9D?=
 =?utf-8?B?WFd1K2xFZGFUbXZRREJITjFSWFVnVXVyTVR5c1JjbVd3cVI4Tktid1ZGUThJ?=
 =?utf-8?B?RWVRc1JDVldNTGFYMk96YUV5SldNNWZ6M0hhdVFFc1M0R2ZwYU1UUlBzUG1V?=
 =?utf-8?B?elMzTVVxbW93bmJ5VlZqOGUxSjJsNGozK0ZVNERING1sUUc0N0RZMnl2MWR0?=
 =?utf-8?B?ZzhzWFhWNmhnWFltd1hOOWlwa1U5MldMa2ZXWmpUK2YyZHlSbWZyOTdsMVI0?=
 =?utf-8?B?blJaUENseDRPZ1B6cnJNREFQOENlUksxcVpsd3Z4UVNNOUsvaURocHVEeTg3?=
 =?utf-8?B?MHE5ZEpBSENhSXYrTXBpRkpBRTYxaWpPRVNLZnRGeGV0Qm1mT2h6dTF0cTV3?=
 =?utf-8?B?WFcwZk1MRklVeTZTZjRoOGUyQ0RtSjdadFQ3dWtIbGJTeFZlME1xKzlDUEFJ?=
 =?utf-8?B?dm5VeEJ0UElaSVVXejRsc1RkUWc0TXRzWXptZ2lVRTc4Wmw0M0pLVThwUzk3?=
 =?utf-8?B?dUpiL3JtNzdON21xMjBxTWVhVnY3bmZzMmhQUFd5RkxoYjF2Z2t6aUliazUy?=
 =?utf-8?B?ZFlFRzQ2MlhHWVY4UmNwdjBVd2t0S1k2MEN3MXhUV2hHNzlYYUVnY1FubFNw?=
 =?utf-8?B?OC9tN3d2TFdXaWYwM0pvVGVUVVQ2bTRReE1VSS81VlZEZ3UyeU5OQks3K3No?=
 =?utf-8?B?NTZGWGZBZVJLOFB1Q1BLVU1jZmpzbW5JM05Tb21GakdmMWd3MlE4bDZoMDFR?=
 =?utf-8?B?Q01PTjI3SHhsY0FXMDRFNzFrYndEaUloTlFIT2tKbmpTbmhIK3NhZVZEenlZ?=
 =?utf-8?B?dzVrV2ZZUVV2aDV3YlJUN1Bwa3h3U3M2Rm5obVlEdnNrQXg5amFCa1FOQmNp?=
 =?utf-8?B?dlg5SVM1Y04wNG8yRUJYaGhhTmJwa25HY1Q2cU0zMGVqQzQzcUk3bzh3WE93?=
 =?utf-8?B?SExwVjNOOTJ0b3JFdXpiV1ZZc0I3VU9zMExwOW03LzFRNWgyK3R5ZGt0L0dB?=
 =?utf-8?B?SGo2RDk3RkxGc1ZqMjRRZEc1MzZMYWx1Z0NkUGJhR0hsMnNQdktQWHIxcnVn?=
 =?utf-8?B?bGo4ZDJRTUtxYVVwZGczcEd5ZXJUWGQwUEg1NHptYk85RGlld2FiSGxCeUlt?=
 =?utf-8?B?TWdqSUVHcUFNTEMwaUVKbjlTOTRkUUVvaEpocW01S0xDWUgrdWlPRllTVHU2?=
 =?utf-8?B?NUNjdUlQdFE3dkExelBVcG94NWVxcmw1bVd2V3VNZWNESjVncC9mZDYvMTVx?=
 =?utf-8?B?dTRsSnNmZlo1aGRYMEczd1NhekVLWWo4VWdwdlNyd1JEbElBZ1BoSlNDYWE5?=
 =?utf-8?B?OXN2MGh0Q3E5ZHlkUGt5OVlVYmlxMEJKLzVjZnI5aEZackRiQzdMb251NXUr?=
 =?utf-8?B?OVhUQittamJBOFVIVG1QeVhRK2JEczhEd0dIUjlROFlRL0ZPd3E4N0NpNUMw?=
 =?utf-8?B?M2FjNm0zelFOVDBiWUNuQ3JRL21NVVFVWmRhdklDME1uT1VLVEx4VzkxcDNU?=
 =?utf-8?B?ZWRqM0x3cHFzN1plT1BiZDJreGJpZ0FVMmRmY1RvUndvSnd1T0NVWnozZEVk?=
 =?utf-8?B?WXdXdE9tUk9CcWk3TWJwT0VCdU1hQXRseUJpS053Q3lXWEVBRHBOeFV3SEM0?=
 =?utf-8?B?TlA1cUtGaStseDBTb0tlcW9rRkwwQWlrS2pOVE9ldkxOMjh1Q0FHYlNpUTEr?=
 =?utf-8?B?WmFYdHlxUHB3SnJ6M2w0Z01kQ1dhdlN6V2paLzRLZFZIOHAvVXJCeHF5NWFT?=
 =?utf-8?Q?uudVA2A37Mefd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckljODJUdlpZUWlvMlFTUE14TzlUSm8vZ3BYOWE5c0xlOWZNbVNEWnJRSVhz?=
 =?utf-8?B?WnBGRTB6SE1rTHNFSUpLSzNRdnJNanlnaWxPQmVJVUlYdjNTNmVZZ1NiTEFw?=
 =?utf-8?B?blJGMTRuQTZsWFZkdUdUNVJzSFA3bU9xcktsNlpoT1FTQjZ6Umw4S3UwVWJy?=
 =?utf-8?B?aWZGQ2tvUXQ0dGVmZVZSOFpuWVdINGJMSWZ2YzgwVVZUNThyQVFuMUdLaXJ4?=
 =?utf-8?B?eXo4a2xVRzZMeHArWDNpQUdtakRaTUFoaEdYbkxCZExIM1FmamVzQXdHb3Bx?=
 =?utf-8?B?MXI1R2E3SFNzZWpZbjRvSDVYcnBEY1oxc1IvSGZ2WkVQOWFCcnAxWlBRL2ZX?=
 =?utf-8?B?YXdxM1Nnekh4bW8ySEVReGNpTTFSMXllM084YUJOM2dQekZ5bldaMWh2cTNU?=
 =?utf-8?B?Sk5qdWcrUzBFTytpaTR3YkgrSVBRb2x0V2N6bE5ac2xOWUE3VmNnS3EwZUZq?=
 =?utf-8?B?YjhUVm9Zb0F3akw5R0xIWHl0bXdCZG53QkRteENzRDlnZWUzTFdzZzFER1lu?=
 =?utf-8?B?SGV1azdYbkZOYmJ2SE5YTS9sVnhpaURmM1pUY29sbHhLZ3FZbnE1MzNJYVVo?=
 =?utf-8?B?VTlrdDJmV3NvTCt5MkVOUkpSSmFKcEJNNkw2bVdZQ0d3MTJlbEV3UTdOWEs3?=
 =?utf-8?B?WDhPVG1vUExHcEpJYndKRy9yK1RxenRzajN3YlRLNUF2RWpYTnJkN0Q2OW1o?=
 =?utf-8?B?SFV1TlpuL3VyeWhvcmQvQkpyTUZzMEhVbHhoc1NUTmUzcS9oT2hITEZ3empB?=
 =?utf-8?B?NzJKRGVzRGFGYllmRHJxSEVSa05JdnBEaWcyTWZGYTJKdXNsdlpLZFR2VEMv?=
 =?utf-8?B?OGVNbzJYOXFncTdtOXRqdC9ZTUJIUTJTNVFIV2czV25tbkVkWWd3MFhPR0wy?=
 =?utf-8?B?MjRsOTVqMzA5Vy9yVVE3dHA3RFlJWjBKVjVibGJGMjg0UytXYkMxM2pydlR5?=
 =?utf-8?B?RzRld3czWTRBZ01RNmV6VEswN0ZXbGlwbFFCT1Fjck1sQStiSjN5bVBWUm5R?=
 =?utf-8?B?WE1QemNVN3lYc255TzFQR0pSLzJVaFNzMGlHUGxIWk05VnpVeVJvb0Ric1Q4?=
 =?utf-8?B?Z1R2eUQvTDVPaSs4cnRNUWJCMVJ2U2s0czU1cWwzMzI2eWVJQ05xbUUwWitK?=
 =?utf-8?B?dUdFZVo4N01IZzV0b0ZBRUJxeWNPYjJkWmpuakI5cHpsVldzVDk2RlZwb21Y?=
 =?utf-8?B?bFgySTVyZU8zNzJLTjErZlE0bThZSjNQenI0UTJjVlBScHE3ZGNUdTBBdk1P?=
 =?utf-8?B?ekxqZGUzRUtocDJZaktkalpncHl5VnhGRTdRblhocW5URG1OTHQ1S3FkU1BL?=
 =?utf-8?B?c2pTWElmaGtYVlV1OGhHVTFpRXBXSm1vQTJybzZ2VXg5blgzRnBGTU5uSlRy?=
 =?utf-8?B?UDRYUnlQdVJUV2hlVkdkenNyR29XYlo1QjNNY2lIZ0did1k5bjA1anNvMEJN?=
 =?utf-8?B?UnZWUEthMUg1djlPWGNrNDRTNVZuMzJkaGExdFpBelNaYVFweXNzRmFUZGwy?=
 =?utf-8?B?eXZraFY1bkNwa3V1amFWU2pjUVczRXNqRGt3Q3hNZ1dibXFqZHZLeitscHNj?=
 =?utf-8?B?RTZwSDQwMkNkVVAxMk9Xam5rd0Jaa0NIRVV4WDd1WTZhSmpKQ2FpSFcvdVZ1?=
 =?utf-8?B?V3FOa2NURG84TGZ6cW96OG9jdmhrYXBQeDd6eUN0UmdBcTFRbEFSN2RwNUpa?=
 =?utf-8?B?UGVFQTdLMnFjT0Q2QTF1VnlCTUluQlZxZnpYdnI2d0lhczJDbWVJdGE2SUl4?=
 =?utf-8?B?Ynp0WTM4ck84L1o5QkpzRE1XMkFXTVdXVFF6citxN0x6ZjZKUVQ0K2xXQTl2?=
 =?utf-8?B?ODJycVFBWEhCa3h4YmdtcmN0YTMwWEpQMHBFNEc5TG94M25Qbnhlbk9VZXM0?=
 =?utf-8?B?eFhPd0VvaDd6N3diTWZFN1BqSndxUUw4bkRYQUlJZDRCT09OQVdlVmhUWDgx?=
 =?utf-8?B?eGFwZ1BxSkRFVTNmam1aSnpQSk5pYjE2VUY0bXRJSTUwRTJRN2cvTTZnclRV?=
 =?utf-8?B?bnlZWVdZZk9jbnVNclFlVUdaWS80ei9wb0dZMnVBOVJhMHd4cFFJaUcvK09n?=
 =?utf-8?B?UUFXQXVyRE1WeGtaSVV4SVk2dlhkZ0pGMkg2VlFqRzBvTDU4TXFtYzZ6OW01?=
 =?utf-8?Q?mNPdlzibosaAs/LlAhHBPzpqu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0a54b6-75ec-4719-84f5-08dd66230a9e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:44:44.8137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrDWEXxz6zeZMdxZUnAZ3/fCu5kv+glyxnk6OuoZcKhBN9QwfZ21D2FhXdMqAAEalM1ff0muCdOPbEHO6rj0oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
X-OriginatorOrg: intel.com

On 2025/3/18 21:26, Jason Gunthorpe wrote:
> On Tue, Mar 18, 2025 at 09:25:56PM +0800, Yi Liu wrote:
>>>     	struct iommufd_attach_handle *handle;
>>> 	struct xarray device_array;
>>> };
>>>
>>> ?
>>>
>>> I think I'd just accept the additional allocation and not try to make
>>> handle re-usable. Every unique attach gets a unique handle allocation.
>>
>> If so, we also need to loop the device_array and add the attached devices
>> to the new device_array of the new handle.
> 
> Why? Just don't use the handle for that, as above, the handle is still
> a pointer that you allocate, and this pasid_enty is another pointer
> that is allocated once.

I see. How about making a new structure dedicate for tracking attached hwpt
and device_array? Like the below. Reusing iommufd_attach_handle structure
is not mandatory.

struct iommufd_attach {
  	struct iommufd_hw_pagetable *hwpt;
	struct xarray device_array;
};

-- 
Regards,
Yi Liu
