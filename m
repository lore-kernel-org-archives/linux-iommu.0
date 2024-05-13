Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7050291
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582731; cv=fail; b=tI++qCXYACNfUv95mPmezXuh1ec+wHSM7+9s/nUckv1RP9kZBS38+zdz7zIU1Tmil61F6PKcw87daMcYDyXex7nKqrd2IS+UKMYel8CfVZ+QBVyc0Fxkki3gBKZ0TdIROUXKSm3IbRPFTRJbwZvKpVsYPeFMaJTIqt+cXusGgS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582731; c=relaxed/simple;
	bh=7qPkeXtrfKG35Sk6Xn6vd/c8Ina/42aTLPTpWJZ7aHM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nHAtuCB3ppT0OgfGPjq4wJ/5kEZTLlr3cJJJx5d3MaMdciepoq/X5L7+kFBH6L8jeptZb1LqWZhZ434RlV4mNMdmJLsHQs67NBqCdTn4JfA0zdomfcJLDm7EuiupliLDznynsnAMN1sF2QTy8lFgHb1P623JxHeA6jqQZWA7f5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F/Yb5pY9; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F/Yb5pY9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjfdu51JXioPrLf43VLxPd6s+rLY/iDO80CkaQuqa8Bm9lDS+LbiLFKo218UCKw+AlO7s88CNzt8Xs2G/xlpMtPYZkdR1Up7CSwZaSDM43jehXrnIH6ZeXHSpxIJWGLxMxqQu9oLm5keQ+SNGPTpZh10YCjH/O+AFti+StzKKZW2Plzjgr+V6ig629IkdMjyoVVioQrJpMc3gQzpCwGAC9G38do4AYgfBQVundaHwIGv2B2l40yLO5rISgoEYkMtWnYY3yLGXL2sfhtcailWh5zQtKzBua2i0+DfseLUwZEojfvGj3LbQxIQtyMhRapqZ7K0fp5YI++xjN2fHNNVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eBqRsCIaNVoCC/OfYelHst/HlXfviTSk2BGerUSOpc=;
 b=XJZ4zWe70371u29zSXdTeOp8ivu90K/8X6T993CJAvmXTOdyfqtkEXOGseDPY9b3ACJ9LjauBPt1y/v+FByCD2qPd6nQJ04WDQ/XDmJcEe00lffOmS6P/CDP7MCmwP8VEMcAKOx88Q/UJgitOzqF8o6NCg605j0k6FIbUrG3KANjQZ+rrMOoykVxeLS5YQ3d+xRfyOgxUBaZ2Re5Hqcx/WK75ryQiiNDJlG13dt3Z1jQAHDNORTjoqjKXGR0PtPke+NLniXiVOrW6ylUu13HQcIoza4TZo45pWyqHiTMLqXThyaot1L7yUIZETr39Z9Bkx7APl3if27Fs5G994jIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eBqRsCIaNVoCC/OfYelHst/HlXfviTSk2BGerUSOpc=;
 b=F/Yb5pY94bJ7bwDXA+F9+BrA9d+4LMw6s5of/+CBJ3B1OiFBlhNvNpzJVv/xOnj1M3cg3D9DoS4xG0Eoi0seDVHMN68pOVAsMjhq/ycizkDtq/Jcxc/QjBRYmwfYpgb4v4QFVfIx8ETZLDo0Y9QpUS13miS/GVC5Qszu/aH8fck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Mon, 13 May
 2024 06:45:26 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 06:45:26 +0000
Message-ID: <8da8c8cf-6815-4d8c-b21c-6efe3a7a4dc3@amd.com>
Date: Mon, 13 May 2024 13:45:18 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/amd: Fix sysfs leak in iommu init
Content-Language: en-US
To: "Kun(llfl)" <llfl@linux.alibaba.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <c8e0d11c6ab1ee48299c288009cf9c5dae07b42d.1715215003.git.llfl@linux.alibaba.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <c8e0d11c6ab1ee48299c288009cf9c5dae07b42d.1715215003.git.llfl@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 6090f13c-1968-4837-4794-08dc73184568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmtEQm96a1g4RVJzblNIK05tSUl1eE1RTGZSQmx0ak5NZXV0SFZhb2ZSSzIy?=
 =?utf-8?B?ckZJaVAvNWtvUzgyaHhYQXNFVzZtV1k2L1Z6akZCTjRBT2h1RTJBVTNiWThV?=
 =?utf-8?B?anh3ZnNEcGhrc21UTUNMbmdRSzRFQUticmE1NDJZenJramQrT1h4ellzWlBo?=
 =?utf-8?B?ellob040ekdZZHI5czhzK3lneXJFZFZlUUd5cDY0ZStBN2JHcEVEWDZ4QzVQ?=
 =?utf-8?B?UmtGY2Nqb1U0L2pSWklzRHFuU0tjVFhnSVNZSjBHNkd3dkg2TUpFRGV4bGVN?=
 =?utf-8?B?VU42eDJMcE9mVFdNQUtscjB0ZWdLSzkwMTQ0aXlUNmNhTHl5c25LQzZWY2F3?=
 =?utf-8?B?WTN5aTJ6cGdHamFDMTZKalZBN09yWlZXS2hMTXFTYlY5bS9XQUtqNjdXQXc1?=
 =?utf-8?B?Z1MxcGdmVmhOa1JVMXkwcFpMSzlySXJnYzBORzdyYWh0RDhBMDVSVGdOMmNr?=
 =?utf-8?B?MHRuR0VneWQ0ZXIxR2RIRGczT1kyQmlNVHptdlJ0SmR1TENtSWIwZzJPek80?=
 =?utf-8?B?anhUWVcwV21lQkNXeUFFcmJXbUZEQ1RPL1JoWktXblh4YXRkZk9pNzNwVEZB?=
 =?utf-8?B?Mm53Szd5dkU5Q1M2ZEZKWFA2dHowaE5FRENabkZ4MHNTZWQ5S3JtbmZ3cG1G?=
 =?utf-8?B?UWRoVUNBV3FNQ3d1bHpKOGpOa1Z0TEwxRk8wZzJieXV6OGlTNkliQXVadEhF?=
 =?utf-8?B?blpJNmhMWGpvaHAvTlBmRDJpUk55OEUwRmVmWXdseVdxS3MrS01yTkoyeVMx?=
 =?utf-8?B?ODVUTWFIZ3RxY0czRWNvZXpCWVE1UDNtbnBYQ01XTTg0aVFady80cFNlemJK?=
 =?utf-8?B?M2Q2Zy8rNHZHdHBrYVhISXNCbmRYenpNWDNDakJpVk5oVFFDL2pqTmtmcWNB?=
 =?utf-8?B?WDk3QlFWSG95VUxQK0IxcW5ZNjZTRVZuU3NiR0hVcGYvTDhuT2liVlVubWV2?=
 =?utf-8?B?MHhFdDBGVTAzUzAxWGRPUVdZS0NCYjJRUGNGdnYxS3Z6eWpPQW14bmYycHRn?=
 =?utf-8?B?UlNjdmtzVGVPeFJ0MVB0aTRuL3g5UWRzdTRaVU9zUUpUSncrVVNHeU5qWlpa?=
 =?utf-8?B?aHgrUHlXZFNMcmZ6c3phNmJXSWlUUkQ0clp6VWhjVk1YelVsa2dNUWkybW9I?=
 =?utf-8?B?eWRza3ErekpOamtWSkNZMVZ3WHdHV0pqNm1jRzNYZUIzakpBVENyblJ1R1Jh?=
 =?utf-8?B?dktMc3BpbUE2Wlk4d2tBUTJNQkhpVlhaZ3BTT25kL01ZalhTV0xiQVVMNTBO?=
 =?utf-8?B?WGVVOHh5TGhMZXZVZWd1UTZZR3hVWUxkYnN0Y3BqdG1WZCtyVk5CZWxlT1BI?=
 =?utf-8?B?b1FpSDBLVEZGOGN5RjIyT0FDZnRFVEd5b1kwT012d2lkdUpCUHltUXEyalB4?=
 =?utf-8?B?Y2hXTTloUWxVd1lhUytCaUkyU1FUT1RYTTFva3ZNNml0dHNyRkZjb2IwQXhj?=
 =?utf-8?B?b3gzOVljWkIvd05rUjQ5SVI4eUtZSng5OXdGc1dJbXFMYU15Y0dTaHdibHR0?=
 =?utf-8?B?VWhDT0tncXlmUG0rRzk4Z1lkZlhPcWtLT0hmQ2gxTXVjbFZ2QjF1dnpYUG5Y?=
 =?utf-8?B?RmhRSE5MSUFiMmp0YnpkcVVTUlNEcVJnZHNKOFg3WGxZTEJMZUN6UTU3cUN4?=
 =?utf-8?B?OEZ3dkVPSGkvT1RGdGlvb1Z4NktDRTRHa0hsQVRSNFRhODNUaWhwYXhMdk55?=
 =?utf-8?B?aVJNVURtUzZqN21IYXo3bVFpRkZmbXZFWDVwT2d0WHIybGxCSDFrSmRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFAyTkJHMk9wUWd2b3gvS0RXNFc4bTUyOUVQTkZwUHNuVDZzS3dmUFQvQWY0?=
 =?utf-8?B?dmVrd3ZGSGVHamUxdW5BYXkwR1R6N0w0VXNKNFhkd0I0WDFqeWVTb09UNGdi?=
 =?utf-8?B?c0o3VlBRK01Pbjh0RkhtdjVjbW95ME1jM1dpZUhrOCs3T3EyOFIrdlExdGtL?=
 =?utf-8?B?dGhmUWlrZTdiQ3pOVmRLUitKMGcxcjBXSEk5b3RoeHkzUTVPYm1ydnd2QjlK?=
 =?utf-8?B?bEQ0YlhqTjR3WjgvcnoybnhmeXBRY3dkNVZYZXFGUjVNNDBvc2lwZjJoNjR1?=
 =?utf-8?B?Mm8wUy9VR1EzdmZNZXJYeHFMVWdJTDgxcDhEUWR6QWViN1draGl1K0Z2aVM2?=
 =?utf-8?B?Q05hSkFleW9zVzR4K3VOdTM2bGdYWEVPZ2F6bm4vL3g5R0UvTURPMnZNSTBV?=
 =?utf-8?B?cWpqL21udmZEeHIveVFLS2M4alNlMFg1OEdITmpNTTZEOUhkeGgxTElYZnlz?=
 =?utf-8?B?YnU4d1lzQ3hUT2R3WWo1QUxWRWtnQ3dCZHlQMXpLK29xWFpFcy9TMHNOdXNr?=
 =?utf-8?B?WkxLS1Awb0dZRGtnMUp0cEQ4UDVlZC83aGRHS0x4RnhlSzRoVWpvRTUvYWtP?=
 =?utf-8?B?OVdWZWVaVU9ZdFMzSGtQTUowaENoOVhXUmN5em9teHVpRzVvVis4bjhTYTBF?=
 =?utf-8?B?WHJabWVGYUlVU0ExSjJPOGNsQ3dCQ1p1V1pkSGZtR1ZkRjZ5MGN4RjExdzlJ?=
 =?utf-8?B?aUJMdk9BN3dLbW9XRXJ0aldWeHdHdVdFZlFnV3hiNGp4SUZQYVVSTzhuMksv?=
 =?utf-8?B?THhKZnZTZGRncDVwZ2h2K0tHeHV2K3JnNzg5NytlbVEyUnNOSWFaY0hzemlW?=
 =?utf-8?B?OFNzb09adnIwdXRZQXIveXo3Z2p6L1k1TituNW9OL0Qxd1RNR1NGN3FYSFlv?=
 =?utf-8?B?dUgvRmlpM2ZwampyR0g4RjhERFp3ODBrY0FaWlVZZEhMUjJ6aEJjcHlCK0Fy?=
 =?utf-8?B?UzUrYXpJREo0cXY5WVZaUUdORzh4a1h5RzVXaitmTFF0eGhMSUxDdVhvVGFT?=
 =?utf-8?B?aldxclg0cGFGZFdtV1VzZ1RGazdjbktHTVBKbkFScXRKSFRHN2xWd1hZZXlr?=
 =?utf-8?B?eEJpVjAyYm8xL2c1akIxdmtFNHVaZHhORDFDd0ZBR1JjZDRnS0ZucTZmaHhw?=
 =?utf-8?B?MW92ejExdFkwaWc0MlhMOTMwMlJoVGNmN2gzRGN6UXdNRWJyamtPc3ljY3BK?=
 =?utf-8?B?Wm5XU1JJVTFkSzFZOHlmVlloV0d2a2tOWUlpajF5a2xpcnZiODd5ZWR6dWR2?=
 =?utf-8?B?bVkrdVBsMGg3ZzB6THNiSkVDWS9MeGJTYTVhTTdFcy9vSmVvVzJoZUZwQTRL?=
 =?utf-8?B?SU9TV3B6SkZLUFplQzJkOE1sZGluc2M5aTZBZHM5aHhoWlZGRGtmQXorbzlk?=
 =?utf-8?B?bUZRRExxZG5XTno0RmhTa00wN080MjZzaC9PZUQvUHdoTm54eHNwbzhyYktO?=
 =?utf-8?B?OGNBUXJNR04ycjVmTTlRUDBMZUZES3IrZEl5Y3BaclpHTE1VNEVMbFhNcWpi?=
 =?utf-8?B?RnVITlJHODR3clVaWExHTUloVHAvMHVoeHYrZm5DRklzODEyeWV6N0NCQkkv?=
 =?utf-8?B?bUVHOVFTVyt5R0J1YlQ5aEY1aVlyMVVGZ2FsbWlEUmw2OUdVak13M083eGZo?=
 =?utf-8?B?RHhZWG9vd0pEUCs0ZlRHN04xSi9UMU1WSnN3aFFmV1JhMXlUcERxc0RzUTBE?=
 =?utf-8?B?MVhHbG1XV2c0amZHVThWNzVZZHFpRVhGVUVxc1J0WFp1Tk90NlNPb2MzNnRS?=
 =?utf-8?B?Z2FhRXpRZUtIMGdGaytkVEgvN3F6ZnVTWEgvNzdNYTh0UHVWWUdYMVZDZUtL?=
 =?utf-8?B?dURuTUhQeXA5OUU4Z1ZZMi9sMDZ2QzJ2emd5RXh0RGEyS05PaldNOERjc25r?=
 =?utf-8?B?Q2hORkJ5WWhZNC9FUWtoeGtaaU1FckJEOTRhc3ZyN2lpQ1paNFBpNDJoaVln?=
 =?utf-8?B?cVc4dHo1VTNGWm50OWVSVk5tZzhhZjRIbE44K0xMcmZEQWJoUmxsUW1mVGdh?=
 =?utf-8?B?Skh0L0xJU0Z0ejhqOXJiamttS2dJQis1MllHTGpaY2VHWDYzZUt4RG9rS2o2?=
 =?utf-8?B?OFl0YmMwL28rcG1tblM4RE1QN0tJVDJnNGt2K3MzNm81ZWk1Wi9peTJNUzA3?=
 =?utf-8?Q?LEXX8MGDVuYbEnHnxyCrCb0Xj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6090f13c-1968-4837-4794-08dc73184568
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 06:45:26.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXJSIGT9g+yYSkSntEVn6m7V3xTYnrPY1t5Qrps1EKzLlLR7mgBzhNvYKQpeoDSyxMVdAPvn0ys7/nP90EuXtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238



On 5/9/2024 7:42 AM, Kun(llfl) wrote:
> During the iommu initialization, iommu_init_pci() adds sysfs nodes.
> However, these nodes aren't remove in free_iommu_resources() subsequently.
> 
> Fixes: 39ab9555c241 ("iommu: Add sysfs bindings for struct iommu_device")
> Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
