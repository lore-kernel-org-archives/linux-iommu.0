Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650B14CDA31;
	Thu, 24 Sep 2026 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278935; cv=fail; b=C08aIiV6peOiyVuIkojD18yZzw8RSLgEV6+y3kdqKSmlrRrT2NvFl33Et9d0CNw+X2Cy/b/4/smPHgS1cmYeILZFSo/Sc5Qo1f3yDa54XPCljsogTww/1b6EwclThDWBDzgCcJOrvDBtdGAcbNyXXEEYHJEbkpdvbrImSPiblbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278935; c=relaxed/simple;
	bh=Noe+9NOlopUBJiMAVPDNiKUtGPD+L68NP+5+co3BfsY=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=N1T3hri6gfY3WASFcRSKP/3YLtFPVvX2boQ6zWqk9WdRYY6OEnDcHJCpENkEwZ3bgvF3hd+tXQDsUHFTD57rIxicF3VQpzAeyFTkyHj5juH8wfBQ7D3Yr23UXTDSzcsHJBEPLgZYgYm27+YFm8xUJg8/KffnUk1GpOFb8HzURVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jmrzMYLa; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jmrzMYLa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpdpSdx+ii/PnJWKDGbBGLMIBnXOj7He+9/AY4bViEwg8WK6KHb4Npv7TJboallDUFIhT1yzeTAMr44ggGLCMssGnmvrpcKtigNE60XJVMYClAJQ4X97bNfyFx7nlz/UMucucRqKsYiCi0dy4buUtb4yj9s0L17uIgN7twt+I9meBHdbsVz6ZTumxGyq8xTJsJAs95xvxtYSd19AemUwzommMnMHuGoITubKio/j3PzmnGuKLh2nWrAG28kF2EEMFX+3omG/V+UF/982GlldAsec9kskwW8eBKPhGPhUfbqmk1banT6EmSkQLD5+uMyz4lXZ7dUHDofALmMa0SgrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwpT8xUBwNqbfWy5hu4m1RcFn6I7gENEHB6yfqjVwRM=;
 b=OK7OWopj+MOAl2SBfLR4WFt9RSJb2un/ZXTuT7lKbOuBU5xp4BtzZPd2v2Jb5FoBSCUBdnRvcQfiOLqUAXav4YR05Buk4MvL2Ohkz08KihgTkC32NO9/lpCJDOsL53G34i/WJ+aS6CrAUeeEFG18utL8+q3oSpjtNwSMULGzjXiVd2Hxch7QDuoRt3dFjky3H3Yj2rUfywz1Yn5cowKKhEfnC4gEAJdZOHGYSp6YLarz36CHzLjxQRUk5fz/wkZ5tw9sUOk9nhSjlD65Rbp4WCGnjzjYooQnMPIXxn5fHokHlK0Tx9u+K5tPUbQaBZO5M/US+zdB9QcQGU8vqKmUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwpT8xUBwNqbfWy5hu4m1RcFn6I7gENEHB6yfqjVwRM=;
 b=jmrzMYLaFb8O7WjOufej/vuNIk35YyfxT6qdH1HaFyqzPV6ceMp+llKsR+CG5CnguHrQFUFowQcNd6enTqka63qEFmSnpLaqRxQc7DSL8bNKiVcbVqikuAhAu2LIyZPoNKF8PNRiyZqmzk9FdMXZum6ZvY8cw4n1Yd9pVQ04ovkFlGUhBYAwWnYSgGTBJzmnafgdEKMMGtlIBqLw49UUmJfPl7agtJC6fODAgo4wbp1B9ryn3IVNhynEVJShNq6ipKphqbr6SFc0oL48S3U1LM584KIQhd5qNiA9c6x1yxXD0kceejsAAxjcLZd6ZLfHtmnP2xC8HTbRcYH+o4wCBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CYYPR12MB8854.namprd12.prod.outlook.com
 (2603:10b6:930:b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:41:59 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 19:41:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v6 11/11] PCI/TSM: Add reference-counted contexts
 for vdevice providers
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, 
 Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Jonathan Cameron <jic23@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>, 
 Steven Price <steven.price@arm.com>, 
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260917140159.1163281-12-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-12-aneesh.kumar@kernel.org>
Date: Thu, 24 Sep 2026 16:41:54 -0300
Message-Id: <179027891417.104879.16761593878106297870.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: PH0PR07CA0035.namprd07.prod.outlook.com
 (2603:10b6:510:e::10) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d54eac0-c7eb-4281-13a1-08df1a73e56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|3023799007|6133799003|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	0qsFg7P9R7DPZ5rnjT9apNBJjUTJjSt+SWxQ6m/Z3zDU+cjlSro9XX7zpt4T5+vb7PByEAXFn2Cqyt0lHcRG0f9rYoEjmQK3wY6kAOEPPvf3C7W/wapr9TuQSbPyrUVi77ZC67H6KBgzkNFvH3gh/FWQhgg7eB5WwyiLG8rf3otjfThUCEZGgkR7PBerrK4p6af8athpzrsfEw3fMEXOzXGa6FsBjwRdU52xbhtfqMabrH1jBfNp6m9zuTWw+jOl3oGL/H5PYU40xZ6CxTFB6sKkubhgqqCKfD61IuSTw2zqSV0kB2Pzf5ANT1EyWxvhV3ue7gDx4oo9rdTotubxAmN6CG6PMSOqUmacgqLWBwl3IcUflxaCa/uO2DFEo4dnFYh1D/MiuwIE8PpuBHbZlXORvI4hjUrM5MAitq9ruKSh8/weX7rxerMOsgp+tYlgkUNyOrUZhJX3YDfMLm/u746doWHhsC58GP+l2XhCYJLeYayU01Zj+dQvd6QQtrNYE5hHQcPztMOUK7jBqFtVtneEoLqTsU6liTnYG6SGNU7OGJRRRZx554Q96NGkt1DtoMv1beFqGLp/ixOD/zpT0lT16AXKXfpb7He8qYvD2XCYpYdtyGhPSV52Rj9H8/8rm5MgdHgqHYAcY6rGyOolr2o3YE3FN6qzg/KeeT/uY8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(3023799007)(6133799003)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmYvbS9oR1dENTFLWTd6dzFiQmFjRko4M3Vic3RZZEFhVlF1UUJ1WHlHUVV5?=
 =?utf-8?B?RVZmYW5zQzh2OTJZLytXS0xiTWt5alF0Nm1nTkJKU0JnaGFsby9zdTFodkVU?=
 =?utf-8?B?VzdxeXpYWU5xNGt1RHVRemZndzZ5Y2lmNGRwVU5HN2Z1c214eGRJUGR5S0d2?=
 =?utf-8?B?aU0rT0VybTBrQjBnQWVkUEpUZjNOWGlzcVgvUXFBZDF2NUVmM3pTc1JnR0VF?=
 =?utf-8?B?bG9LcTRBdkJiY1YzcFVpTDJBVzZ4enVVTDBFbk95dVdtaW85QktvYTJrRXh3?=
 =?utf-8?B?bm1DU0I5bG52a3hkWkIvK296OTMybkdaV29qVjJHV05GR1N1UjAybG52MlpH?=
 =?utf-8?B?NysxZ09SQjRlS2NjU210eWxxRVAxeU9wdnFWajJlbjAxZDVHbERNbURWUWY0?=
 =?utf-8?B?ZGtGU0JuM2F5YzZUeE5vMFA2V1RwdW5jOUovTlFvWUdBRERLa0twOW93L1Ra?=
 =?utf-8?B?OHVaTk15Nm1sVC9DaGFOQmlSbjMxaVdaN3hVa1J2UnVsbkNXaVpyVWpLbUdw?=
 =?utf-8?B?YzZnbTNCdjcwYkVCSzMyYWw2bCszT2c3Y2NpdFR5WEFONHBWV3hsRHcrcTE5?=
 =?utf-8?B?blYwUk9ZbzhyL3RpY0ZzSWw2SmZJY3JucnppT2d1NVhXc3NHZkhQSUs5RFI2?=
 =?utf-8?B?dktOOWVXa0ZlQ0dDQ0srNzY3L0pQYUVjM2lNYU9MY1B1b3JWNXNRNnMyTU5z?=
 =?utf-8?B?MVFYQ1ZVSEcyS1RhVnk0aHBKaVZPajRSZnNlQzFjdFU3Tm1yYmhGYWNPL0lI?=
 =?utf-8?B?OTV6bUg3ZFlMUzM2RVMyamNrZE1SUEtxc3o4dHV6L3Btc3pSVFFUbDdTcEFs?=
 =?utf-8?B?Ykx0dDEyWHk4dFJLRHZiY3VnbEx4MVFLTWlTUXlwek1oZ1A1VGxSSTB3Um54?=
 =?utf-8?B?S0FOZWRKUWRhN2NEVzlMdmJNUnlvdlEvZmh3eEl1U2JUT0NEZmZVWStLd0RB?=
 =?utf-8?B?eHBhWTQ5Y0pISlU2NGZpajhGZXhvM0dnMVNpYmsrTllRdmVUOVBwQUwvcjhx?=
 =?utf-8?B?MEl1bk11YUl4NHFTVGhCQS9ZVlY5VTRSQ25sck1hVEF4ZWhmUU1jREoxSGly?=
 =?utf-8?B?eHdBaWhYRlloeXhRUlB4ZXV3TW4veGFaS0NWVlVqWEQ3eVJBT24ydkkzU1Bj?=
 =?utf-8?B?UkFDRzZWa3pZZHRSWmV5ZlJuL1JmRDVvNHBVb21Wanl6Q0dzM2tOcUVRSDI3?=
 =?utf-8?B?cDE5SkRYeUlDODlhQWRxYjF4b3dKdzlia2N3WDJQNFFqcUoxcWFtV1RmRDFx?=
 =?utf-8?B?ZEZqVDVrVmNPVjhrSUg3VzVRVzVLdzJxNTNCT2lkTDhsYk45eUw2STMzTHdp?=
 =?utf-8?B?cE5EaGp0NnY4T2FPc3Z0TWxSdTU4WTB2QkJUWVpMMUpIZUFWeHZxTWZMeUlZ?=
 =?utf-8?B?eWhFQUorUkRZN3JzN2YxaVN0WWFKVlJ2OWNObk85QnBjOUpMVlo1VHZ3Rkh0?=
 =?utf-8?B?alZBN0NJaHNGOG53enhMc2xCOTFyaGdxK1pzUVFDTjNCencxV2piSit2MGJn?=
 =?utf-8?B?TFBqekNGMlpSbjZyR1Z0U3dHNVBFdkRISnA1U3FaK21tSHp5MVAza2V5eWFk?=
 =?utf-8?B?TXNVQTRYL1YwejNQRTk5cTZvN1VnQUNJam11VElZV1A2VG1lalVsRlgwUGdY?=
 =?utf-8?B?RFlicDVnYU1RSUFnN3RNOHNzcFB3aDNQOENMTFhQZ3RZelFtU2Vib2NqOHk3?=
 =?utf-8?B?Wjd2Z0RLTTBIVjFwTjVlZkExWU9VL3VnYW1ObDVJRUxTczJyWEZhNHp6bkRH?=
 =?utf-8?B?czFZRVpuMUJjUGJlUWtxY1dVVForR2JKZ0JDUDZWaVpyM3hNanJIWVB3ckMw?=
 =?utf-8?B?Q3hPdi9GaUdMemtIanN4dzlxbThUWE9KTzJoclRsdUkrZUdUOU1xTElOanNa?=
 =?utf-8?B?b0hoNmRJS01xNEljL2Z4enRWK2VVOC80Z3B3Wm1vNllad2w1dS84VS9jSmsr?=
 =?utf-8?B?NDd1ZjhOVUV1UUJpcG1CemdDYUhlVTk1R3BjK1duTTZMbzdDc0JvV2ozeDNM?=
 =?utf-8?B?UlIxUjhOSWlVb1JiY1pQbkUvQ3NpYldJYmQ1MS9JbXVWbmxRQmh2TWIxWFlH?=
 =?utf-8?B?T0VTZHRremN4UjUrYXpGYWZ6NlhLK09jUHdQaXZJNjdjYTV2YXNNY1I4NTFn?=
 =?utf-8?B?SGdYa1NMKy9LRjV6WG93N016U1hFMXhhZXBGZEtsVXU3bGpKbXlBZlNqMi9w?=
 =?utf-8?B?bEtmbk9ZMS9WVHdiSXdwRHU5b0FJYmcydGJIZTJrS1ZTTGJINFg1TDNaenJB?=
 =?utf-8?B?N09aOU5oeG56QUJvSEJZT2QxOUQ0bDJaenpUcFdVcTBrQUNqQlVibnlqU2Vq?=
 =?utf-8?Q?fA/LgqDMpuOsRwAJTN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d54eac0-c7eb-4281-13a1-08df1a73e56c
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:41:58.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fmB996FwGIqJf3hIIu12vh70h+LsAMQcfsHc2OHAouUq7t1VLMJJDOU8gTXiTq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854

> [ ... 32 lines skipped ... ]
> @@ -676,17 +679,21 @@ Description:	(RO) Return PCI device name of this device's DSM (Device
>  
>  What:		/sys/bus/pci/devices/.../tsm/bound
>  Contact:	linux-coco@lists.linux.dev
> -Description:	(RO) Return the device name of the TSM when the device is in a
> -		TDISP (TEE Device Interface Security Protocol) operational state
> -		(LOCKED, RUN, or ERROR, not UNLOCKED). Bound devices consume
> -		platform TSM resources and depend on the device's configuration
> -		(e.g. BME (Bus Master Enable) and MSE (Memory Space Enable)
> -		among other settings) to remain stable for the duration of the
> -		bound state. This attribute is only visible for devices that
> -		support TDISP operation, and it is only populated after
> -		successful connect and TSM bind. The TSM bind operation is
> -		initiated by VFIO/IOMMUFD. This is a "link" TSM attribute, see
> -		Documentation/ABI/testing/sysfs-class-tsm.
> +Description:	(RO) Return the device name of the TSM when this PCI function
> +		has a successfully initialized TSM-backed vdevice binding, or
> +		an empty line when no such binding exists. The binding is
> +		established through VFIO/IOMMUFD and remains visible until
> +		the provider releases its context during vdevice teardown.
> +		Merely connecting the device to a TSM or acquiring a context
> +		does not establish a binding. Bindings of other functions
> +		managed by the same DSM do not affect this attribute.
> +
> +		This reports the binding lifetime, not the current TDISP
> +		(TEE Device Interface Security Protocol) state. A bound vdevice
> +		may be UNLOCKED, and TDISP lock/unlock transitions do not
> +		change this attribute. This attribute is only visible for
> +		devices that support TDISP operation. This is a "link" TSM
> +		attribute, see Documentation/ABI/testing/sysfs-class-tsm.

Should we just delete this sysfs instead of torturing the code to
implement it?

Why would anyone ever read it? What purpose would it serve to read it?

Leaking the iommufd vdevice outside the iommufd world is a horrible
idea from a lifetime perspective. We should only do it with an
incredibly strong reason. A debugging sysfs should be deleted. We can
create a debugfs around the viommu if that is really important,
somehow I doubt it is..

-- 
Jason
