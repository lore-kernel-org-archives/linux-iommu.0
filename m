Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793170704;
	b=LGFIdo6gZTdDqX+PJcYqMoLNrXCD869mYHs2V5xHEqeD1Uk3zGreUcCssyHxEtDeUJSG
	 cH2bHEr0TLeiYV7VHncv7uyIqd6a5jnjR3WPYM37oCXaedO1g5boKJIKGRoGLtfdso2DQ
	 hmxCwAjsMzjiQudEsE8c30EgMrFjvMqDKwlS8YZNuuUnTIJpfxXY47ht8EgfHl/bhApvQ
	 V7DbuB85dL4h/0jMwo/6zA3ZgCqKtAHPFcpP1TrdANOxeI3SXC0l6BMvc1sHgOQlwtvgI
	 emJniwhdbLmFuuwN5ae+/Ns8D/RYXVo8ycIJLgEcyXm96mYqPbYLsaQM/6JEMyxNMsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170704;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WH+nmbzPybc2phh7pMmlJ8ZoBKmt2x7DS4mUhTSCn6s=;
	b=O94v/SEeHg4H0ckYw4aRMXo3iXGzqVWdGaAYizHxdewQTKgDsOz3/DDSgGs2nCUBkfnq
	 M+VA1aacG2e7irmuUPK9Bik9YEXaRI/6GBmxITHF1Kh/Tip0yCXdhdsmPPB5EOJxZstlr
	 e3m9ujp8GCuxZibaPnSMrzaB51aRalRUBI37CoCdbVknwW5mij2nQJgDQMx6uPuq2wLK+
	 5J4grTRCblUEgJ25ERp5OuKXRRNLOD6eoBSI/reDw5dnIxhHH2q+DhV4APaMT0kEhQ4YL
	 aHe6HD1QW6US4srqXw/i9uZZA2crDWKOG/oNszSQhvS6+TNDhsQ1JI9eJ3cDcLNWeJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h6rRC9nX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.23
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF0A606A31A
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 06:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAF0A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h6rRC9nX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFElAri0efUdWColtvYwn2b2HhGUPP+kiqDBukCoqaA5mdVLrGo6amVhA5GrlVpgqiJJWWEAY1SZ+QbzzTkszHEmtIFrNwFUjl4Voae6kl/llwrbpDE0zaFts6Tn7hJUHy2dz2oAU6heGGe+7y5V5ReUiZzXBraY0AyELSvv2dJzwAnYVSsKocZQr7UF3EQwrRKRqyd8TFMWLTymHQvmOt/ATZYjgJLmgNqHXTWZEJYKAcOjiSI8iL8icvOimp2ht8kSUh2y0ZrQD4eT0flcme87YNTKu2KOE+MjDzajIqfuFhti1xa2fr7JWGhP99viELhh15/KqVaqLE12Q12ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WH+nmbzPybc2phh7pMmlJ8ZoBKmt2x7DS4mUhTSCn6s=;
 b=l+kijirT+bBW8aaSGDnN18psQnfLSDr5u/4s3dxxPCLvK4cwTItC4KoqzYn7v7JO3zrKHaJLW6S/k4JNEeCPyaXgMZ9tjH2mqXtsPeLGmLy+2AqClMzG5fBfM+plWwby9/zMbmNOv9BCNdPCB7elzYhDUtu9NxKtJBjwVD7Asn4i9sL3xgqf82pPcKx9Ib+DE6OtEvihvgmLOPD6tjuN/UXJ13Kf6ZM4MaQkIQVu0/UJyshRKDAYgJ/WBpTCkHVjRClOVa8+KQG8HLAH4lgCQ0PoeKEFGxCOqGhb8FPQ6pbPobEwBQqWQ6X4W5dRPJ/Ih89DJA+6+lw7FYeNOlaOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH+nmbzPybc2phh7pMmlJ8ZoBKmt2x7DS4mUhTSCn6s=;
 b=h6rRC9nXqX8ERhOnitBKaVsGUNB6yZdoAs0/eNYYh8S+l/VE6e+m4KGxrt5QW9h2kFLlfdSeCcD7U6NjY3S72/uRZAFwBGHNl65GcSLpWKajBp+6k7hKxX6doyDFUnpsnM5HD+bZDdehyBDKcVuW8nbp+gMhWD67leGjnePWm+Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 06:58:20 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 06:58:13 +0000
Message-ID: <76242acf-e8c3-4c44-9558-2751112fc5dd@amd.com>
Date: Wed, 28 Oct 2026 12:28:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Remove iommu_group_mutex_assert() from
 amd_iommu_clear_gcr3()
From: Vasant Hegde <vasant.hegde@amd.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Max Zhen <max.zhen@amd.com>, Liang Wendy <Wendy.Liang@amd.com>
References: <20260814104029.71021-1-vasant.hegde@amd.com>
 <20260817135155.GB1415075@ziepe.ca>
 <d5e053c4-34d4-417e-ade5-f7f461f9e426@amd.com>
 <20261027182407.GH1685504@ziepe.ca>
 <63ac9043-0658-4535-b42d-0e29eb37ac88@amd.com>
Content-Language: en-US
In-Reply-To: <63ac9043-0658-4535-b42d-0e29eb37ac88@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::13) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea56c35-1206-4321-0e94-08df34c0d5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|261026140227099003|4143699003|11063799006|56012099006|261026121527099003|261021121427099003|261009223027099003|261022075727099003|10067099003|261022105027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	z4ozfq6d+PdReZDgTKyC9Kbn07t5CPcQapgdhTeAd8xZdY/SzZOR4a0nm5HvZxgUajKuPaSr8e9KZrz6a56JoFOqNSStIissb64RGDrAwplS6teWWtaF3d1HrZg76LRJYKLaRiEoexwIiojfiIj4jL8GDx/iT7oDxQNpAUHN67F3deiCQN7OHYcs03hRQYWhssF8RSCipLTl9yP2qaE6R+gXnARXn6Ao6G8EIBEk86LPv4yG1HOzQikVWzshdJAuKUV0mKq+RuN3f4f8PnL/ze/u902CUvqDt8lawuWhstIe/Pl5vS+lUSRZmBXWzJ8K9cU2Mp6erE7+0BfkOy7BYyTCjj4K5T99i5PBCMp2QGBwRnNT1xeNUQca5YMZyjUN94nzxUfYq6Tv1TOVyRTuFZai5WY3tzQLpsTItx2Rrwx8B8gW/P+EARGoVXKE5Zh8ubo2LyowdHs1lbiB10eirKQt8hiBo1b0AGV75mNRzIMa7yPmPmYuVBkxzSr1fA9R9PKaN+zWKdguy7iHtEkd5zrkAS/IhgqS+Mfq8NoCyjenFaCAIbPdaaDR1HaWIqWxfgX/0VmvQL4IfaIYZ24WqNvsauE53w2MgZUHQlWA689h5rc8W6CpFw/D1pZjMzbEnC6W0PFk1QM0XJwDlrsgc096WwsBR5gZF+TAGwOHodQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261026140227099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261009223027099003)(261022075727099003)(10067099003)(261022105027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGVsSWF6S3lzY2VWckMzTHFYZmtadnZSL3hKUFNsbXpoSE9WYW00dFpEcUxX?=
 =?utf-8?B?bXEzbnNubnhINmN1cTBjMlo3eHNXTGpsdEk5NFVyellrb0NmSmt4ZzRZdHRs?=
 =?utf-8?B?U2dHdmluTXgxZkczN0xZSXMrdWRQclV0SGdXUnlzd1RFd3pYV0dabnRucUhx?=
 =?utf-8?B?aStEMDRPSmk1djhNekw5YzdjdEYxUjM4Q1FRUFkyeC9iMWRGczFKcmFFaW5x?=
 =?utf-8?B?YTMyMm43YkxOREVkbzArT3o0UVRIOGlYTnhzMU01RzI4cGpPVU9OZlVUSnFK?=
 =?utf-8?B?TFRSWXJsYWtKajViOEQwUktxOEM5ZW95L2JWT2t1OGR1WFM1REcyNUxoVW90?=
 =?utf-8?B?L1QvT3FpQWZCcGN4RDdBYzlRWEZoTTYwYUlaRXA4dm5mdGdrckpKQnhQSE82?=
 =?utf-8?B?NWo0N1VObmRKNXVSL1d2bmNMdmU1U2xUMStRRnhnSnpBSGZXaFYzWUhWVnBJ?=
 =?utf-8?B?NmUvWjhrRDYrK1MybHFHcVlGaHJBZ0hXUE9veHdMY01HbktWNHZVTDBwdHZO?=
 =?utf-8?B?RS9kSU51WWZtcGZmVzVUWUJjZVBDdVF4aVB5bGFnZ0ZyNlZhVitWaDVaM1hh?=
 =?utf-8?B?ZFNURWprNk5XTzJvb3phMjBtQ2dZaFlqOFBrY3c3bEpabUU5RDgzL3VnNXVq?=
 =?utf-8?B?NTFpQm5tbDBIcHY0ZmpVMVlNVjduYW1zT1FlR3Mra0k0dFVpbXdZelorN2Fj?=
 =?utf-8?B?TEJWMzhqNUxTYXExc2g2WTF5MDRVaTd0VEhENWJoYjlHMGVnbU0zVVhJV1lR?=
 =?utf-8?B?STNlK3R6ajBjc0ZFOTJBUXp5Q0lReFlBbEp1SnYra2xQMVJuVFVpbkR5OFJm?=
 =?utf-8?B?bkp5T0tBUnU1ZGQvY2Yxd0tyVWhxbkNGUm5aWFIvVDcwbnBMQnBZeUw3Zm5V?=
 =?utf-8?B?cWVKZGU5cGdWcFQvbXJPMnJORk5jNGFKbXI3RkQ3enZzYmpmVjFvTXZRTlE3?=
 =?utf-8?B?MkZERlZHVFUzZ1paYWx2Z3J6cDN5c2gxNGl4dW11aTBrY0ZvYVIvaUVWTmI5?=
 =?utf-8?B?anhmL2hVaGFCMDhOSlROaDBEcUFRU1lMeWtMTTRQa3Z2VkwyYnFRQUF2ZUxp?=
 =?utf-8?B?RE9iSDlZcExGZW9qa2JNVWRWQ2ExeTg2WlpHTVh1QWprMzlwcnpLb0VpV0N4?=
 =?utf-8?B?VXIrUWtlY0lsQ05NUCswTDFiRnJFK2ZaRDhsTy9PcUY5c0JCeVZLeE04cTFM?=
 =?utf-8?B?UEZ0TGpwL3lHdVpkRXVOcC9HaXJqM3pnOFM1M0Nza1Nvcm5uUmtTL3F1aXF6?=
 =?utf-8?B?M3gvRGhUdmVWNmFqanlxbFFEOEJ0NHgxVk1jdG9NcnJKeWFOa0MybHByYnNR?=
 =?utf-8?B?YlRmOExsZnBtRXdJS09tajNKcWFDd2dPWG56VWdlRi9vOFN4dTlzRWdXWjR1?=
 =?utf-8?B?ajJnRHBLSDU1Z01YQUtTN1VURENKZUhMRjRhUlRGUW55azFYUUsvMzY0citw?=
 =?utf-8?B?N2ZoL0R4VEY2QUxodzRwUDdJZWVPRUIwclFLRmlXTHk1QVlFQU5Hblo2bFFu?=
 =?utf-8?B?ZWREQU40d3Y0c0EyU01tWkprU0JTbFVMM0czRXpsa0Qva0R1T3RBNkdHbkhV?=
 =?utf-8?B?MGFyakxMWUFtNVNTc29vSVJYaTNZRzd4OWdneEZ0Q3QwSUk4K25zV2lFWkNE?=
 =?utf-8?B?T2tYaTBUWlVpbUtXdTBzSEthci9oWW1lYlhmVlU3R25JRnFadjFyeVZXRWp1?=
 =?utf-8?B?dnpPbnNVVEcxSkl4RDhOVlRGNlZPUFRkRUhFK3k2QkQzK3dJU0xTdTRrQ3Zw?=
 =?utf-8?B?dG1xSkRDd0l2YWwza3lCYVoxVXBnelVLOE5VaTdwYVhsVnZMK3V6dEE5dFFu?=
 =?utf-8?B?Q0ZoSUZBVWpZNmZIcW1HZEFla2ZZY3AvSGNOUUtwK1RicFAzckk0bTEvTGZ3?=
 =?utf-8?B?aCtYWmdaNzFpcnhUZkpLOUh1bnowdG5uL1RQSCtmYmZmSy9sSGVWa2kzeUlr?=
 =?utf-8?B?aEdqZmhQdllwWkNkRkVkRnZweTZ6dmpYK09rZlhEQXByZDMwQTN3bTNNU2ly?=
 =?utf-8?B?UklwbVVmSElkb3lvQWUwQ3drVU02VkY3ejBNQ25Ka2Rsb1pqU3V1d1pMWnlx?=
 =?utf-8?B?MnQvMlluaC9CNC9JY1hoeDRjbG5oalJiY0VPWEQ0TDJzUDErU2gwSDUyU3lj?=
 =?utf-8?B?dmN0cjVGeTFRTzJiQnJyY21OS0hLb284cndtYllzQmhhRE9BUjRZaitXZkdP?=
 =?utf-8?B?ak1JRjFzQjdEZTRtQkdkeVI2TG5iZU5qSEJ4ZmVLQTRxRGlJdC9JQjJlU2x5?=
 =?utf-8?B?ZFhhZkhQVGxucDluT0NJbytKREw5eTU4NmVuVXNzYkgvWGhsWDhDV1FPUUN1?=
 =?utf-8?Q?rW+U4KRWbO/zr3heJP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea56c35-1206-4321-0e94-08df34c0d5f2
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 06:58:13.8641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gwnj/nL4VWgAe5wI+AJwMg1nd/3tX9qnUG2iB7hmAnqCyQR7lLdSx+So4aN57o5wOD6LWjzljoQKcuZcz+Vj6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235



On 10/28/2026 11:42 AM, Vasant Hegde wrote:
> 
> 
> On 10/27/2026 11:54 PM, Jason Gunthorpe wrote:
>> On Mon, Oct 26, 2026 at 06:29:39PM +0530, Vasant Hegde wrote:
>>> Hi Jason,
>>>
>>>
>>> On 8/17/2026 7:21 PM, Jason Gunthorpe wrote:
>>>> On Fri, Aug 14, 2026 at 10:40:29AM +0000, Vasant Hegde wrote:
>>>>
>>>>> Remove the iommu_group_mutex_assert() call from
>>>>> amd_iommu_clear_gcr3(), since PASID teardown via the mmu_notifier
>>>>> release path is a legitimate caller that does not and need not hold
>>>>> the group mutex.
>>>>
>>>> Why doesn't it?
>>>>
>>>> Right below this line is:
>>>>
>>>> 	gcr3_info->pasid_cnt--;
>>>>
>>>> Which certainly needs the lock.
>>>
>>> yeah. I overlooked it. Its part of dev_data and domain lock is not enough.
>>>
>>>>
>>>> In the ARM driver this async release notifier was pretty tricky to
>>>> lock properly. It just updates the equivilent to the GCR3 entry to
>>>> make it disabled and doesn't touch anything else. This is locked in a
>>>> way so that concurrent domain detach doesn't face any races.
>>>
>>> How about sva_mn_release() path just cleared GCR[PASID]/flush cache and then
>>> iommu_sva_unbind_device() path (amd_iommu_remove_dev_pasid), decrements count
>>> and removes pdom_dev_data structure. something like below?
>>
>> One of the considerations here is the release of the SVA should not
>> trigger errors from the iommu driver if the device continues to use
>> it.


Actually we will hit IO_PAGE_FAULT if device tries to do the DMA. One way to
solve this is to have dummy page table. During sva_mn_release() will switch to
dummy page table instead of clearing GCR3[PASID] and then in
iommu_sva_unbind_device() path clear GCR3[PASID]. That way it will not produce
the IO_PAGE_FAULT. Does this makese sense?


-Vasant

