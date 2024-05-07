Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFE514D6E0
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073149; cv=fail; b=JKyQb+oTj6BNcwA05qsnvIhZM4WKdXV6jGpjAlPj3WjOcNnjfEpLvPf0fhPJS+0p2ji81ICfer8tU1PdMt6XNoaspNpHUlCeDl0YBUWq6dXaGYNnHL1L/40ma9/njkYugFKvf6cxo/huw7P5/YLkGHAdKfN7CN81Tc4nhZ9tNNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073149; c=relaxed/simple;
	bh=2S62IvL0ljz2tEDMbgVhF+vCrAMFHwC18M+Hpsly2Nk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nYs9LjBCKYLhmQKd3lypCnusDZ1mTe7Pz7MnpqOCCvMQ2U9EkzYemlKAQPEoJl02flhy5wh1n4d+lYmzfHkrlJZaZ3KlA6T67oU0kFyfTmh1r7ZfiAmaTM4nfAOfJeh+C0jxds0EnwH8qzWjuco8+KhwWmggFC/OVs0+xmZ5Opk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IUkaj/R7; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IUkaj/R7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGzY4dTMvCFISF+QcZV9j3siT/sTMIJFhovGY/1hmCy+oRQZSY1VdsjzIPIO8EYqD2lyQuhPG/csWjjpWtcKhwKj1qSIZqSIoFr7gdCEBhYOu+Udp+YwJiiqI1FXGhsP5iqWMiXFl8w008lHf9pCKiyieyp0asiTNpXa7AZj2pwF5cR3H8kO0WunXuJgEza7Qffv46HedhgOq9tadi74Dw1DMY90NFz2FlGTDULzyltk5HHbzucJnXUT4sqV2Divh95LBfgokTMfr+Fg4wWDUYRZs8BI5C3jmKxKIYL20zfZkAFJR0jCVrTiRsnzTfgXabJMV9TMQYE2mEi0/qcong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj7LrqOjygi3z1Z2JrElLWZXMTu+A48l2vFz1k27VsQ=;
 b=nAWrpa3hmmHTnnqhrvr1LEsLQI4asJeBxzA2TRIQ2SARuJZSzFkeW7s+gJoSFrkvk+ZpcRQlOcWC7C3vKm5I0kzNhdTO8aVRFIEvFxhuXIjKRZClerZcDkx+KiQYBQ5zNKkx764YIYxPEAY1qRFnucyRbcEIUj5+Rp/mlnd28unbU6eP1WTklZ1MV3LPAuvLZZjchowPYmvS6KELQcRFsXpN328HU7E597dkQA18u0MafpbxIszuFxZTX286LfPtugCvg+DWwyoAUH3Zj9+Hsk+sayzzQ7D+SmpvmSDRa/XTwYKyecpnQElRSl9MGokCE0e2irHDcuuYqdbb1SC9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj7LrqOjygi3z1Z2JrElLWZXMTu+A48l2vFz1k27VsQ=;
 b=IUkaj/R7XC4JiXbNMmuOhphpu1sN/zND90hZ/1MG+ah+VAWYdcHSxE9+Q3t1WfquLM9CxVKJ/FNFsHOu36nnIWl25bm+xixIhLBlnmfj/8CF0n6MCbYFRX5LwJXpJrbZsrpX8fBCUsTYi0npaSJyqH6Vl54duF9eOJgNqD82mLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 09:12:23 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%7]) with mapi id 15.20.7519.035; Tue, 7 May 2024
 09:12:23 +0000
Message-ID: <8cb9ad12-1426-43b6-830f-277d3b3b6a02@amd.com>
Date: Tue, 7 May 2024 16:12:14 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/amd: Fix sysfs leak in iommu init
Content-Language: en-US
To: "Kun(llfl)" <llfl@linux.alibaba.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Vasant Hegde <vasant.hegde@amd.com>
References: <4d516a6500ea0760e13cc19e2b14e663aa333518.1715048443.git.llfl@linux.alibaba.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <4d516a6500ea0760e13cc19e2b14e663aa333518.1715048443.git.llfl@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e635798-fab4-4dff-8156-08dc6e75ce2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1VPNFFmRjVkNkk3MksreTJaYWVuMnNqUGlZRUkxTksvNzBXUFR2aEoyU2RO?=
 =?utf-8?B?dG1nem11OExPZHl2L29QenlpNTlCbTVEdjVnZVRHSzVmVzNBRk9TYlcwdlFj?=
 =?utf-8?B?QmF2bGZhUVdOQkhSZXA2eU1YMzU0dHJyZmFPZmh5N293UkJrVkVjaU8yNnZX?=
 =?utf-8?B?MmlLRUltUzU3UUZCWFcwL3IyS3dDY2xMOE1iNmVzS2d2Nm42TW1Gek1ZaFpU?=
 =?utf-8?B?MFphNks3TXpNaDNqcytRVCtjdzNQdTM4QkZWZmZ2SjRJbUJXM2RqYU1seUJZ?=
 =?utf-8?B?ZUVOS3VzRkxleDhzN2hxVTYxWUQrOU1QTHlKTjVZaURzN3MrMWN5YUI2b1g3?=
 =?utf-8?B?b2liY2dyaXAyb3Fjb0MvWkdLWVE4clFCNVBxM3lMdU5QR1crQ0tIZ2lrNFBT?=
 =?utf-8?B?M0FSYmNFVmRKeUk5RlpVMGg3Um55QS8rNEZXRG41NXRYT0d6TU8yV01mNExo?=
 =?utf-8?B?REd5bzJDSDdqS24wcjJITngrOWJrQ3I5TXcyMUZteG5BeldSbEJVeXh1aDM2?=
 =?utf-8?B?eFJIcG5OMTFQK0h4T3BjU2ZKSm40dy9Vdlo5cWN4UXRoUDlXT3Era3ZLMnhX?=
 =?utf-8?B?R1g2WkFFUG5FYzFyekRWRU4yRDh1S3l3a0J6UWFGdXVsK012TklublhJaFRX?=
 =?utf-8?B?disxb2V6U2RvWFArM2tTM3BXNmpFKzRGOVpLMFl3R2lmYmkrTHFLM1IzcmFE?=
 =?utf-8?B?K0NqT2NtK044R0hBSVUrNGRMSDZldlBYUkVyMGhsL2xTYTRrVk04OVE4SlpF?=
 =?utf-8?B?Z3Z5N29ncHhNeDFoaVEwVGVXWjVSOU9TT09BaWo5Nm5pSzFiS3o3UjRaWnRT?=
 =?utf-8?B?TkdoWVFEeEV1aDRJM2szT1JBNnFYSkliT0MvZm5Udk1STStLclBjbWZtTDh0?=
 =?utf-8?B?cWhSUzdDL1QyMFhlVEFEOVlpMUlKZjFrcHhUUVFSOEpPeEFNQUxvNXN4ZWxD?=
 =?utf-8?B?ejRwb2Y0THl6WG1QbHFzcEhPOHFzTmFsZU5qZ1hNcGtuWkVBWjlJcnpjcDd4?=
 =?utf-8?B?WkE5eW0zdStscmJRc29EMzVJT2QxOVlzM01qQ1haTWlZakJWTkp2MmJvLzlQ?=
 =?utf-8?B?WlpqeDc5VThrYWtBaEgvaHZxZk9DR0FFeStIdG1FTFgwQUNDTWVXMmo1d3pX?=
 =?utf-8?B?QWgydUU4Q3NrVHEzLzZTaDlTbDBtU3U5aytSaHdacWlpR0Y2b25wdGZLckt6?=
 =?utf-8?B?amxzVmhRM25TdVBaZlUrbmZ2R21HdGY0MWU5SWNtOXRjbHN1bDZ5bVQ4bVJJ?=
 =?utf-8?B?ZVFzaDJvMWg2WW1LZnFSRE4zMDByYnNDbllaZmZJdFBUR2k5bTFLcmNuOFBX?=
 =?utf-8?B?NXNDdGhBeDh4d1NVWGFtZkhHR2VnY2ttZGtmRmF4ZTl6Y1lrak5PM2VOaE1Y?=
 =?utf-8?B?RjI2MFF4TzZHL2ZycUphbEZQMUYxVjdoKzNaKzdrNVZrcHJYOFBkbGxnL1hS?=
 =?utf-8?B?MnF5alN6RGl5dDBBNXJIVWdTU2FYbkV3UVJ3UVdJakxja2dsM0pkdXdqWWpC?=
 =?utf-8?B?WkM4b0N0NWhZeUg2NlBTcDNvMktVN05oSmVNZFZ3MjZHNWhrdWZYRWNsc243?=
 =?utf-8?B?NC92ajVxd1dqVHNFN3FZT2dOaEhpUWxjRE1qQWx1T0NyRnBjdGdOUlhKTmU2?=
 =?utf-8?B?WjFjcGp2K0RBeC9MeTgxR0E5cFM4QjRRYWs0aUd2aGh6ejZZdE91MmQ0cU9B?=
 =?utf-8?B?NkZXV2pTakFOQzZ6dTZEbzI0LzVoQ01UMFREaE85M1JYMHVQcVJSUG1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkZHb0xYN29vOUxiMFNrTGhOdXN6VVVoL0V2ZDlhQXFJcHZxVUw3TUZOSmlj?=
 =?utf-8?B?YWoyTnA3N3JRNzNCSllzM29IRUNRdlNseURCUmRZdmJ2cWdGR0FQbElzcWFC?=
 =?utf-8?B?Vitqd1ZIYWZ3L2x4K3g1SDhUZmFnRmVneFFIYjd3RkhoTUlPcTJhR3FNN085?=
 =?utf-8?B?emx4L3YwRWpvdWlwbEUyNStUNDdkaTBYR250dm5LQVdlSFR4cDNZZzZKZWVa?=
 =?utf-8?B?U0ZKekxLZ3U2MjBxNU0zRm5QU3IzcHhFMHBsWFZ1Mm1FQktlamF1RjR5N2Rx?=
 =?utf-8?B?N1pyd1kwQWEvTGFQYWk0NjdNTWJObkFNWitYUUN2cWZHRmFLU3ZaZUswaVov?=
 =?utf-8?B?OEdlMC83a1hMNmxtRFRUckRuTmNmK1RnNTFaU3JSYzA4eEZZVytYSC9PcWcr?=
 =?utf-8?B?cUd1K29GVFhXZTRDWXRmb2ttK0RsVyt4TStodjdMRWJldWdFcHFVdU1FNHgy?=
 =?utf-8?B?NldoZUM2a2c1bHR6cFZlbjJxQUk4eEVuQVhYUTRGK2ViSE04ZVBBWFpYdTdk?=
 =?utf-8?B?dXZIcHE3UTQvZEhKZVcyZWl3WW4wY1BwM3hDM2lKV1hvZDFCV0VsalNPNjJh?=
 =?utf-8?B?QlUyVzNwZVNSMHBqTGEvTWhmV3NHZyt2RGIrNG1OL0k1WEZkRHlzRHJxa3Vu?=
 =?utf-8?B?YVdYSysxZ3FZeERFV2V1b0xMMC8yUFF4K3d0Nk5sbzJwT0h1Sms0SmE3SWJQ?=
 =?utf-8?B?b0FMNFZUUjRPOTAwenZhQ2xEdjMwRkgybmgvdS9TWjBDM3dKUEVEZERFYTZo?=
 =?utf-8?B?SEgxYzBCeFIyNjRCWitlQ0dMYjF4UGZ2MEtpeTV1YTQwK1ZmVDBmQmhuTzI3?=
 =?utf-8?B?cVIydXJ2L3FlZyt2MVlaVi9hWGoyeGlpb3ZxbUZXK01WVDArN0hkVlRpYTln?=
 =?utf-8?B?eFBZZURSTjBtcTRPQzBiUGFPQ3ZoS1Z4My8xcFhXR1hXYW5BSEhBaXliVGtE?=
 =?utf-8?B?OVNVaXQ1YjgrakVVaWNuOVN4blltcGYrSmFtenFRM2xqQVhUeXFseVM1UXhw?=
 =?utf-8?B?cDZCcjhrUzk2aGNZZTJmUkhOU1pPTEVUN3htU0I4SVlnYUJpR2x3d0hFeFpl?=
 =?utf-8?B?dW9xN2krNi9aeGM4OVVXVE5peFRLVWtNOXRvSzNNMEI4U2JHS0dvUjBsS2NK?=
 =?utf-8?B?RU1VeTgzS29qdWlIcFFpZElrQ0RMcUxXb3pzUXIwYnpmQ2ZsTFgydml0cEFT?=
 =?utf-8?B?a0pnRUpkUGR5NzV5Y2dhdTZ5R2l3U05OSGxZSytCTk1UaTJlU2txKzZybUUx?=
 =?utf-8?B?T3AzYmoyZ08rdFl4bW9pY1BrYnFMZlRyUlhIWEg5bHBFY1FIcU9Bajg1U3JN?=
 =?utf-8?B?TkdTYkNvY3d3cTkvYWlpRnNuWHd2Q3BITlZIbi9XN0VmUXFGMmFla1B2dlBV?=
 =?utf-8?B?UUt4MjRBQ1ErQkZSUytUVk4vcTJZN1pqUEtkaHQycmQxOGp4R0huQU5oWHNV?=
 =?utf-8?B?ZHcyb2hsRlp4TktWVUFlL3JqWmg3OXhDNWRoSG9TSnovQWNBczhnMWtjU1Zt?=
 =?utf-8?B?T2FrMnVydFRHeEJoTWNwZzE0cHpZcUdoRGJrQWNtdDBJcHNoVm91ZUlwY2Nz?=
 =?utf-8?B?TE5wSFBVWVdVaXdyQkUxbUhhV2dncW8yTU8rVXRBRTB5VXMzRmt6WU13Z2Ni?=
 =?utf-8?B?cVFKY016VG9QOFp0MlFWbnRLQjhtTUNhL0hLRTNVa3MyK1pZaWdoRUMzeXYy?=
 =?utf-8?B?UEtVWmxRekFralppS2svUE1uRE9DN05KOElBWkxwYVhIbTVBc0twODBqYStW?=
 =?utf-8?B?eUVQMnpPbWx0c3ZINllMS0taVGdadFZ4Q25MWGVOeC90THFsVzRNenJvWmx0?=
 =?utf-8?B?aGNBYWloMG1yVmNGeFNGZDV0R2NIQ0NzaUM4K1dveEdsZmd4WVpTOFFDSDJy?=
 =?utf-8?B?dEFPd1J1RlZVS3g2VjVWS2p5WmZGVzdyeTZERmZvSGdzRGxMaVRpbmxZNDhY?=
 =?utf-8?B?TVdrQlF5WDRFbWNDaTBkT1lWSE9zM1BVbTdUczVMR1AwMnJ3TVJ0MEZIRjls?=
 =?utf-8?B?ZUYyZHJaWit5UkNUWk9UMmFQZ0h1ekpSMnJIS3RHZjRnYTJtdDZrdiszaHc4?=
 =?utf-8?B?eUs1cVpqK3JpYUZwUzBFQU9qVmZ4ZlB4VEd4bnd2VFNYR2tJRTV4UzRKNk1j?=
 =?utf-8?Q?GoLU6A5GiybItVYGnmX7ImhIt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e635798-fab4-4dff-8156-08dc6e75ce2c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 09:12:23.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6lgspUkNNEaxE9GuUfi6+v0DXGN5XgHOaokWZN87u3RUkmEU9YDEQ0spzXTux02HfKiWxEzFeQGiTwWy+we8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125

Thanks for finding this sysfs leak.

On 5/7/2024 9:32 AM, Kun(llfl) wrote:
> During the iommu initialization, iommu_init_pci() adds sysfs nodes.
> However, these nodes aren't remove in free_iommu_resources() subsequently.
> 
> Fixes: ad8694bac410 ("iommu/amd: Move AMD IOMMU driver into subdirectory")

Actually, this commit only move the code into new directory structure. 
The original commit was:

commit 39ab9555c24110671f8dc671311a26e5c985b592
Author: Joerg Roedel <jroedel@suse.de>
Date:   Wed Feb 1 16:56:46 2017 +0100

     iommu: Add sysfs bindings for struct iommu_device

> Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
> ---
>   drivers/iommu/amd/init.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index ac6754a85f35..624ea2549f64 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1678,8 +1678,15 @@ static void __init free_pci_segments(void)
>   	}
>   }
>   
> +static void __init free_sysfs(struct amd_iommu *iommu)
> +{
> +	if (iommu->iommu.dev)
> +		iommu_device_sysfs_remove(&iommu->iommu);
> +}
> +
>   static void __init free_iommu_one(struct amd_iommu *iommu)
>   {
> +	free_sysfs(iommu);

As part of the clean up, we also need to also call 
iommu_device_unregister() before iommu_device_sysfs_remove().

Thanks,
Suravee

>   	free_cwwb_sem(iommu);
>   	free_command_buffer(iommu);
>   	free_event_buffer(iommu);
