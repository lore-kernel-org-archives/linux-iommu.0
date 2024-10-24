Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B061E0E0A
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780891; cv=fail; b=BXfxQ7KUrnolPzmFSah1xRS0cRsMtKekeVO3n/w/HvEcQA9EyPePuz9x0ZwZVomm93CL4zqnDBcxO+2Ipq3teHnWwo1hRt86+BBDRQo1HczZ3/eTjNVGqowd5Xea9keFlf0nzgxJ6RPn76BiJSJuUZsTNkSh7n6PN1F4yQhezc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780891; c=relaxed/simple;
	bh=3gMo7vsVAYZRd1LK81k2rTD5naU2gbyL/3NcNxhSOZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AOeKR/4S3oFPT/jtojkpEgavkeaPUd3io4QYel9gdGSKJ4t3hS1+sTZjuaAnPpC92h75iUr6rvPRRycuWd9ipmCj4c795uEsICj2NAp9TGL1zsjm0HvNoaPr6aXRx3D5HAq6q1tNUHfz9HeEIZiNXdsPMAE3IiF+of1+nL9vzQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iBAjDCXT; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iBAjDCXT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQ+5DhAKmL4lcnKgGgv/lQFnx/FMkl8mwhB12PYgiGEMlX+MbliAMM7rmy/mbVvC5tcJ1eCEUwmhzfl/lxD3s7ps/9n6a681mJUa3F2GtPl/kAWHTsKz8TmTKnNDfTDDwIfXhk0+rda4Z1BdmpAFhLp9tkG46YCyQ7+hoROBsOB7kZ6h17UwJ1Q0kOXR1lyWjZ8IWKlGFQDYjN6nGEamYvJIG2GFIFT0tOAkXd/TYhhtbAMWIsKl2z52Yp1qjA8+bXcTgatm5yHKzGX0tTy7K7PH3KFC3wknHNrmWzB8AAwye3H+qJ6r6H/KojZ+mJoa7JVgx50FYtCNlz4vwb/LOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GAKU9er/R5TitRrXWL/WxXwK30MHWb6uY0x7ErfqFM=;
 b=HEfkV64peRhxnEIUKGfoLdpjhT1lMA5f3xqumACdqlXm91zt/duQhCU1hto8zkizdsbt1V/JV7FlUeB1kHpHQbpIiivz1pnAUfRqIztIniGdabDlu3micswEfFceBFoAnYdFCxoMrG+vZotKXooClVoejlKXe1mnfaeEtoaCGaQKP5Z56yYdnnxRgoPD4OvDdEwg71KZg/xouYrRC3nKjCn1hlxQ5Iu2gw7FHtw5GBm6XGWfnFXgcXpOY+Pady3YDdLtRE+ROaqzG0OQuIjD62nnfnjnmekATXp7c0+IDyBa7RjayxqEamJAfcOdA5Vv5+e+WqKJ9FzOtfKE1rOnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GAKU9er/R5TitRrXWL/WxXwK30MHWb6uY0x7ErfqFM=;
 b=iBAjDCXTsDtz+a3kFIG6ya3QXz/SSI1XEUdl5xJs9TXbA3e3IqGMCLkuBxHK8q45LqbKy44FsTTWHedOv/QIMzFC1fq5rDvmjK+E0hSrg9VVNiswdClMlqzjFgqzw+qafsqOxG3QciQGLf3cQph56/rPyHVYckoxqnkwKGiFL08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.20; Thu, 24 Oct 2024 14:41:22 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 14:41:22 +0000
Message-ID: <38881be4-d3e8-49b1-91d8-04b03fac2937@amd.com>
Date: Thu, 24 Oct 2024 20:11:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] iommu/amd: Reduce domain lock scope in attach
 device path
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-7-vasant.hegde@amd.com>
 <20241017133244.GP4020792@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241017133244.GP4020792@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e23b2e7-2b22-4011-91ab-08dcf439eda3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUQvSERkc3dsSnl2d25RdFE3bFFJM3NUdzRVdklRR2dxWUIrZCtYQy94REVM?=
 =?utf-8?B?L3BuOHBSZjFwZFRkM3pWVmZSVkF5M2JVVTQzNDZOV0szU3JtRXIzMktxbUlN?=
 =?utf-8?B?ekpVUDZGNmdEbTB1WEJyZnArUjQ2SGYvYjJzdTd3dGdrbHd1cyt0SzBPbE9K?=
 =?utf-8?B?R1lwTGgyNjNrMlIyZUk5UjBuYjlpVC9KdGM2ZFVCZXlLK1VZeXc5dEltRnhF?=
 =?utf-8?B?R3lUSXZ3UWQ3NHJISXlxaThRcUNwVHNtbFEwMU05TUFtOENIb2lDUmJvYXph?=
 =?utf-8?B?TlhHekk2VjZpT1VTVDNBOHlNK2xhd2g4NGdjRll3eHp6MU9OdlNPUDNQNHlG?=
 =?utf-8?B?dHo3NlpPM0ZxNjJnQUlyejVNOU40KzNIYXdxY1kvZlFpSDJCd2RNNHgrd1BX?=
 =?utf-8?B?emRNbGo4SGM2RUhhRlZOQ1d2bjd0QWNtUzk4WVNIMldxaG5vRURiYU4rbUpB?=
 =?utf-8?B?b3QyeHg0ZFFwTEtCL1BxUldBODFhNEx1Y3htMkpqVStvaGY2Vy9na2UxM2Ez?=
 =?utf-8?B?Rnp0dHlGNmk3N3dldWlxdlQzRzRIQ3ZkZmpoK2R0SWM3aHdjbTFEVm9SeFVs?=
 =?utf-8?B?Y0tWbTJ1WEZkWlJxV2F3c05oQXVsWWRwUHRnNmpqbXBwektBM3VEK1VVUGYx?=
 =?utf-8?B?RkJqWlhsNEdlc0dsdDhzZGk2NXV2Slc3UFJQcWthcjhURUtuYytzUlo4eTNZ?=
 =?utf-8?B?NE54Y1oxY0w0VExmNTRndmplYTlsdzlHem9CVTFDV0k0RDdUN3B6RXlRcHVj?=
 =?utf-8?B?Y2thbm5mVmdIK1p4L3FHT01GNVJpc0RlY1d5bW95SVF0MFlIZ2pIc3FwMm1h?=
 =?utf-8?B?MUFCaEtSbWVRYjhDRU04ak9OOERmQm9RMTVQS0VpcGdZSVFmZ3Rza3lzbGNP?=
 =?utf-8?B?ZnZMU1RYR2pQK3VWendCS3doTmt1dSsyY0pHZlF2dE45OExXUllDYXlzUFZi?=
 =?utf-8?B?c1dkbE95OXJia21QRkIrT05aU0lRL0x3OWxXSmNxQmdJZzYzR2M4d0luaTcy?=
 =?utf-8?B?R2F4Zjc5QzFnSldzeWtRU3VkVnpHMS9UenVvYk55aTBydmlVbm05Qm9CdEt4?=
 =?utf-8?B?UEpWVC9GLy91SnRnVFI5YzZ6V09VR3hNUGNwSW9mN25idTVZbGNmd2tnWjc4?=
 =?utf-8?B?NFRUYmpZcDlNTkdFNTVSSzBjb2dzTmN1Ukt6ZDF5VG1MN3dOMGo4Q3dEazB0?=
 =?utf-8?B?aWxNT3J1MTV2b0NWSkZlTnFFSUJEa0lyeFN0L2pyQU5yYmVUMFUxTlZpNDZB?=
 =?utf-8?B?Ym9FWmxRdVhuRzNnUVJza0s5eVZFM1lqL1BYYjhFYzlMV2FlaDNFcWVBVlBH?=
 =?utf-8?B?bnRTMkZGWHhSOFR5UHkyUWdxMERaU0thcVJqNlFmcGh2MHlWckJMS1ljWkpO?=
 =?utf-8?B?b0ErYXE3SG1hQ1hZOUV2UXpWYmk5QVVKRzArbTJnUitPYUYyYmtaTnlaTkhE?=
 =?utf-8?B?d1JZTmw5TUF4R1BkZWJkOGM4UjArTnpJdnFhRnZyMlgrOWliUWRUeFZ0MjZ6?=
 =?utf-8?B?eUVUdkpCZnduZndHOHBraTVFTWo2OTU1TTczcjlrNWo3dEt2TmdjaUNNb0Vo?=
 =?utf-8?B?VWdRelJ5VzFRTGNWdUkrNDdza2h2d2ZDUGtVQmd3alRNa0xzNVhjS3BwN2lJ?=
 =?utf-8?B?eWhJbEpuWEREZmhYK2tOMVFRNnhXVG5PY0ZJbFBnYnhaNThSTjR1OTYwc21o?=
 =?utf-8?B?ajdBTU80KzhSemJTNmxUcDNKSW1GZjRiVU5pNVYrcU9vbXV3WjZ0RWhkNStQ?=
 =?utf-8?Q?Fgw9tgoLt7xoKyIKdNZa3i4ToJIlQjP7R86O8Tq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUtSM09kUGM1UUZRRVdaT3NadGt0V0xLckwvVE5nZTUybE5admlZQTBjWXpz?=
 =?utf-8?B?ZTdtVXZRQ0FZRGhWL2JCdWdVeXFSdDhiWWdybmZPSHpGWTFUaVRyMndkZExX?=
 =?utf-8?B?ZFJyRjBrcWQ4L3RBS25wdFNOQitUaGhGWHd3aXFRaXVoOWhFQnllcWZpRlg5?=
 =?utf-8?B?Ynd3UWJiYU13Y2UrTFdDL1B4OUo5OTBOMVJvUm1OcHFBVnYwMmhuQzQ0ZG1Y?=
 =?utf-8?B?TUQ0cSt6OUxGSzFCM2pnbmtRbnhreGgva2w5ckplZElXNVovS3h4a2NZcFI3?=
 =?utf-8?B?WnIweVVRRFpxb3dzWGtFRlZORVZ1UFhDRU5FWVB4d3MzWWtSNXF4UGY3bU8r?=
 =?utf-8?B?MW1pUWt5VG5jNWduUjR4RDE0V2tjZ3pKc0JFNUU3NDdHbUtrNCswT2dUbm1h?=
 =?utf-8?B?aTF4M0I4RFlRRVRLclJZQUlBNnRjM2lxWndVQ1ZMYW5oRktETVZZcWxybk5N?=
 =?utf-8?B?bTRMMnNrL0NQM1RHbkRPcnVyNWI0ZHFFYlZseEd1aktzQ0RHWjZ6WHltdTVK?=
 =?utf-8?B?YjFEMkhNUlhiYXR6OEx4aFdxdERvS2ZvL3NvRVVzYUpmMzZKTVBlVnRZcW9V?=
 =?utf-8?B?WFU3OE5JaHlxK1pQQ3R1OVN5RzUyQnZFWTBwdUtrQ2RwODNVeXZFYzBhUE5Z?=
 =?utf-8?B?WWlDMUtCdjNRNk92NlpZeDR3TlFiRHJCSUV2UGlva0lqUDBkdFVHU3dYTW14?=
 =?utf-8?B?SmdjeUY5RGY4MjRSdEpuMUcrU281Y0FWd24zNUdLN3ErQWNQMVd2YmZxRVhz?=
 =?utf-8?B?dEpxMlF1U3BINE1pNkYxTXR2NTFvcFA3Y0tXWkxMUTF0dDBpQXdzVmxaVVZB?=
 =?utf-8?B?N2FGK0FoM1VDMVVGeVpyVVl0aGF0QW5WZDVpcVV2QldHNDBKSFgzYzJ0MnFs?=
 =?utf-8?B?L0xENnJ1OHJIVk1VMzF6SGlRbUNPd2xhSEdsZEN2K1RIa0NXKy9zc0Y4dERm?=
 =?utf-8?B?eW1DaFN3STBtamt0cWxybTFHWjFOdEtBcVBhL3cxMU1LZnc2Q3VqQTZhMFhp?=
 =?utf-8?B?R3hEeDI2eStFWlZYd2dqOVhDR1BWZjVzeUhwSWFMUmR6aUhxWG5XRHNZVXRG?=
 =?utf-8?B?ZzFzSkJmWVljWnJYcHRvT1dCQzArSE9wdnNUS1ZnY2hBeVNQYVI0Z1hsZ3JL?=
 =?utf-8?B?K2toSXQ1aHJsd2tGNW1SM1ovTDZnUFU1TWFYSVgxV04vOE5kMkxGcGxvd2pL?=
 =?utf-8?B?dEUxZUhiRGNXSTE3SWFxcDNZdG4wK1RaaHdIdFB6VjdwQzhzTjQ1aEVvaUNL?=
 =?utf-8?B?VlBoMndxYXdZaGFVY1k4NDZJamFpenIzQzN1S1N4NHFCWGVzMkljL3FHci9O?=
 =?utf-8?B?MnJEZE44R0dvN1dIZmJRbEoxNHJnYnk2dFhiK0JKdjNuMmFpM1V5VDdWTDBE?=
 =?utf-8?B?OG5ES29GV09hU2phbjEvREJxWFRhbG16Mm8vQ2ZyNmhRVVdtZVF4Ly9ocVFK?=
 =?utf-8?B?RGlzS0poVnNFd3dmczI0ek9HcU4wTDBIN3lXWHFxZ0puZ3E4UStsbXk1UFJy?=
 =?utf-8?B?SnhnNVFRWlJ5ZkhWT1IvVUw4UUdhcVF4Y2xYWnFvclFGYmVEVmczaENGcEtG?=
 =?utf-8?B?N2kxSDhIc3VYVURqZkNtS080NkhJeHgyL0xDeU45UnNDVFo5M2drTEZlZEhs?=
 =?utf-8?B?SlorekxmSm8yQ1JPRmJ2M2lUUW43dFVTVndyRkFpandJeEtpVisxZFJ2aUo5?=
 =?utf-8?B?b2F4c29qeE9ySGlqWHdRTXdxR3dGTkZvamJGWVJlTTg5ekIwdXhEMVdoNStC?=
 =?utf-8?B?SnRhYjZ4a0QyenA1UlB3VXRRZWVub0svL2k4S2dnemZXbU9nWFppOXMxcTNu?=
 =?utf-8?B?dGE4eXYwUGZuT05kYmpVSzVTVTBHK2hianRla3hLaGplL3lORFltSC9NVEpT?=
 =?utf-8?B?V01aSmRKbDA0VVUvUGlWOFhWbGg4S0V5NHZaS2lYekQ2R2kreU1aTVIxYlZ1?=
 =?utf-8?B?S202WGhUNFFvaHpBMXZrZkNWck5aVnJ4T0xsK0RUNUI0ZFAxRWM2dkFpaVg0?=
 =?utf-8?B?RWtRbVJPblUxMHl0aWQ5YU5YRDlpeXlkS3NLZUpXWHMrYjZzMHc2eWNMbTNK?=
 =?utf-8?B?RUVuUENuWFc4WWtrei9xT1lXbWxxMzAvdnNyd3NvcXRWcTdsSTBPSG9PUWJW?=
 =?utf-8?Q?SHaWzW5fuGWKip87kjQ/kr/JN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e23b2e7-2b22-4011-91ab-08dcf439eda3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:41:22.0286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zOxV4lBz6qL0uIwsyaf9bgFAFZgzq9D17gzq8ja3r0r29psaRKSTzdG5JLIp/p45pmlpCcbiHDLBQoe1/QC1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853

Jason,


On 10/17/2024 7:02 PM, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2024 at 05:34:57AM +0000, Vasant Hegde wrote:
>> Currently attach device path takes protection domain lock followed by
>> dev_data lock. Most of the operations in this function is specific to
>> device data except pdom_attach_iommu() where it updates protection
>> domain structure. Hence reduce the scope of protection domain lock.
>>
>> Note that this changes the locking order. Now it takes device lock
>> before taking domain lock (group->mutex -> dev_data->lock ->
>> pdom->lock). dev_data->lock is used only in device attachment path.
>> So changing order is fine. It will not create any issue.
>>
>> Finally move numa node assignment to pdom_attach_iommu().
> 
> numa node assignment should only be done during domain
> allocation. This is important because the domain can be mapped prior
> to being attached and without the right nid table levels will be mis
> allocated.
> 
> However, that needs your other series, so let's just leave this as an
> future direction note..

Correct. Once these two series gets merged will remove this check.

> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index d74d3b65c939..a738d2d7f0c4 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2016,16 +2016,23 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
>>  			     struct protection_domain *pdom)
>>  {
>>  	struct pdom_iommu_info *pdom_iommu_info, *curr;
>> +	struct io_pgtable_cfg *cfg = &pdom->iop.pgtbl.cfg;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	spin_lock_irqsave(&pdom->lock, flags);
>>  
>>  	pdom_iommu_info = xa_load(&pdom->iommu_array, iommu->index);
> 
> It would probably make sense to use the xa_lock to protect the xa
> instead of overloading the pdom->lock. Then you don't get forced into
> using GFP_ATOMIC here. That could be a future direction.

Right. We can do follow up series.

> 
> Anyhow, it is already a big improvement to narrow the scope of this
> lock quite a bit
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks
-Vasant
