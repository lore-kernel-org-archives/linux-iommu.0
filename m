Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F43BD659;
	Fri, 21 Aug 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327767; cv=fail; b=QVOm7xf5xSCnIpxeS+q1h/hXy4ZQwIxOFo0bAy49Zoz6qDwsMuW+e6P3glRNwECdwsiH+VkRhFsaLzaHXgu96GRyNb03ip3jNbDiArcCTx9E1rqDicPWH/ySigGiISkuTp+LLQociOkBwMXY+DYCLMKrAQ3qe1oWG2rmXilme80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327767; c=relaxed/simple;
	bh=JKKcVnQTEyVtkqSmWUUKHxwZ+yYd03OUOj1x3vWxuZs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HItsioxOyYCXP4vpMLbtSZO3FubIUFpgSKEaB0KzmbJf06o+fuw50duEK9cTEJ7zChU4OizdIO8KGdKpfxs0aRIviVIwWcRgZ+Sy1gTxcrNmX4imNsI+dNDmC5N7vMyT9AQthgj2a5GzjKDs6RVZDM6cZK/YPOOuGbG6RKd09BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1KmQpAlA; arc=fail smtp.client-ip=52.101.53.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1KmQpAlA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIqvWCpXun7GsIwHUe+Q029A9GE9X6tgRFYcx72fG3c32uLLl89JIezK5PTLenfKtzlrAPXWQvDJ1nYMjIr004pgSPZyJd72nHKBMr9GEAq4rVbWF6nzQMZQ7o+1t0pqF9gvSvWbAq+M3E85LNsqCKDMD8geMd7OdLHmriaRpPUUv5On98QiTWDO7r6mrC5HH39Mz8rp/B3SxT34xgnBoFWb+6zvyKAhFKfzKJgC04fQoVbG9WtN30jinfOEhEyLbTYS3IZn2uJyxjC8Yg/Tj2mMEN2WxnR1eIR04Xv8ysCKFTDPKWYTc8NvqCiOrADjA9twMFzbGwM6PlagsyTj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hyd1GOnhIibbx0nyFeO+EzZMwQ/SQDxiOEboJqsFmxQ=;
 b=ATq6zj/dvM4pMy72OZYm4sudJIofq1oVGidWIvYAk99/CJCE5u6Lk0W2hpMH6DaU30MV+sHipDCAY05D60PZ1XU7KiuAlFORDIBHeejGshIAIjXFL69G8BLdflWzDndiDnxKT2cI0a1gI45F7ZdyiCvPcA26GWOHssnOjhWYgY73WNUYoZIQtfjnpqzhK/1MOWGAkb+nF2MkcVmmIlaQPuvblKXFyxIIP4xnv/UWDMK1k0dY6R1YuRIWhE0mx9fVek8Aw2d/vr7S/zlB18IUlgpLoqWoA/ZIOOyqmq6kxX6v1zYCALOUxIztCZ6xqYm2WmiJ8JdAfbvECbhJLPfGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hyd1GOnhIibbx0nyFeO+EzZMwQ/SQDxiOEboJqsFmxQ=;
 b=1KmQpAlAFk8SKF1F8ZAkDySSmMi/HuGwVgDBanwpaDvhgihtpiUS7C4ZK11UWDIQaA6md0LpBV7MDcK3p63ply4NdIYMAq0RJ/javuDzqKQVhxhKvipKA8TyXemLsC/bodjSaxZpfYycAb7y7EIWdWTjx4Vi4wUMDTL+a0hZRgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:55:56 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 15:55:56 +0000
Message-ID: <42ae4e2d-3327-432c-a5ce-67b27a45b4ae@amd.com>
Date: Fri, 21 Aug 2026 21:25:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] iommu/amd: KVM: SVM: Rename cpu to apicid in IOMMU
 interface
To: Sairaj Kodilkar <sarunkod@amd.com>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Eric Biggers
 <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Kiryl Shutsemau <kas@kernel.org>, Li RongQing <lirongqing@baidu.com>,
 Marco Elver <elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260821055611.27138-1-sarunkod@amd.com>
 <20260821055611.27138-2-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260821055611.27138-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::14) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 27254e83-4bbd-4c15-5179-08deff9cafcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	R1D3SdgcDkfsSaddycQ+ldCHrVsAeRlyTd+riPHAIejFqQ/pF9m1CkUiuVEsebdGF5KFL5YDC7cdUAPDz3xM5mIoB1GGeBB5/ydziIV4pDDB5GaxkWJoOO4oQVCUeGZv7O7izSaiTaUwiMoKh8cjzy+WqZh8eBKj+GZ4KUQZH1rNlXzeF6hP6UQuldNcnOeY+Sn+5X5Zf0tOoUZmYaKQNrfQdjYffSWHQsSZcIWg6KJRQy2TRGfMhTWGw2aeU70ELdSNRaLKkzzVh/J9YRcGJWaINhGgjb8iFNboit++Xe3n2Ras4XBvvZ4J3HftmcnMPvkIdIgJzQm0p4T/FCfP39lsRFqj7oaTK9/h4Sn+rUgO+8n4JAeGMpFO2WHpOpB7/+ZaIDNg3U08v0VTousFGbDQzDI2CYmdeGF6A3l5uKAHnhBZJG82IBIIXCoJoCDPNI5xUFrQMw2WdHFPA3kqa8sIuPUQ/z0tXDGagrmww5w8XSpNOrwpNrJGVMWqzH4UyuWRHh7q38JDJGqzzBQc78vwGSqgaHY5wFKe0kRjMKam4fXunWOLrpbQFEUuOOYR8zMgoc6PP6N2H7zLruWr6exCCcujKuKxe98yq9ghlQkGy1viMod0TTsexNgB5J5MZs1yP/AK8z41lLFidSAIGetSlmSyhW17SvihPXV9EtJMyZXRYlYDe+DFgiysW2p2SGf5sLEGx9rb+e48oRFuMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWFIeWszaitlaEtzZk1NVjNVajQ0QWxodmxzcFVraTNZTk50SWpzZHl3RVlM?=
 =?utf-8?B?RjZXN2taTXBTR0lqaXVRN1BLNjVneFEwR2pRaVBkdHFWaXBrYUdXTzJSTGxj?=
 =?utf-8?B?SzZHSUFieVV0cDl6TzdpVEFPZlBjVDhFWEdrVHBheDNBMVpHRlJjWW1jaytz?=
 =?utf-8?B?TStSMFY0aGQ4Q2NEZ09MNW9TY2M0dDVvcWpUd2ZKYTZoMXFjTDhNSExzd1RZ?=
 =?utf-8?B?Q1oyeEYvdXNpVEsxZk14QmxtZGs2ckZuVWtISFhxd0pJVzEybzhQWHF0YVlr?=
 =?utf-8?B?eHJkZ3VMMWs1UG9wWWExUVhBd1k4aGVNVFg1VkptWnkxQitNcEZOUzU0T1Bp?=
 =?utf-8?B?WHpzOExQOWtmUWJnS3V2SFZmMlFKT01Kb1ZTdmh5UTdSU2VaZjkzZkV4eGtk?=
 =?utf-8?B?Zkc0NW1INXhFaFloeVV5bnR5bU5lMG94eFhSRkZkdjYwL1B0QjIrUXdlODBG?=
 =?utf-8?B?NGhzOVg1aFFLZU94WDRZUmxORVdpSXFsZ0wwTDVTN2NJN1c1VnNsTU0xMTZH?=
 =?utf-8?B?c1NzQTFpc0hBMTZiRmkyVTZBM1FQR1kzUXA2WGVzU3Y4ajhBUmpyZjg2QVdD?=
 =?utf-8?B?QzFQd3FjRjRPUnZlMUdhbTkzLzJ3WXY0UGNsWGd5SEdUUzdtWnRaVUFzSHBB?=
 =?utf-8?B?Q2NZT3lkdnhUMXEwU3JQZ2JvUjh4eGFaSTdqVG5heXUra0ZQNEt2dVBPM04r?=
 =?utf-8?B?U1owWjVjQTN0eU9iTUF4dXB4Z1NRUmUwNTcrK0xBY25hUHlIQ21waDg0enVS?=
 =?utf-8?B?ajlFMlNPeTgxZGQ2bk1vY2I5RUUzcmVuK042cTNGVUUrTGVxd1lUaUZoVVZX?=
 =?utf-8?B?dUp2cis4bHE3RWlXU2ROUytzd1pUTVhPa0o1YmR0SWRwOGtydkpJUlhFeGk4?=
 =?utf-8?B?ZGlBRDl1T2tIc3c0OFBCbEFHeVh6aXMrNHRWd3g3VEN5RTM3bHowbUdmb3hJ?=
 =?utf-8?B?OGF0aWlWZFRaMmIvNG1DZWpyS2tXMnJrbGRRT21na3ZVaWtrMERLeW1BVUVy?=
 =?utf-8?B?VFhCcFVCL2hnaXVVeGpRUXFneER1bnRKWnZOM09XaXQ5T1Bwb2hxZzhiUkw1?=
 =?utf-8?B?NDk5YURPbFdSUjMyRm1SZzJ5V2FSRGFOZEZCZzNycGxXS0JvMHd3VEp0ZnNX?=
 =?utf-8?B?cDNZc09mTlJwMGJyVEE1Qk43RmVvL0NLTXRNUDYwbHdCN3IwOFNXUmh0U0hS?=
 =?utf-8?B?cm5GRS9ZSFoydjZrNXNpZ2d6UTI4N1ZmTXNOTjBmcFVHR1Q5Sm1rWGk4OHgz?=
 =?utf-8?B?UXUrdk03U21NZHpoN1Q3RUkvUE01TzdsalNneTdFNmM0YnhHL09FZ29KL3dl?=
 =?utf-8?B?ejdUcEZuL1dyRm5HcDVHcHBPdWpFSmZnSkFQZklITzVTVzN2Uk5tclRJZUVk?=
 =?utf-8?B?b1VtMnZIalh0cXVUL1luRWgrZEVNWnJOUm5HTlhiTVdFVFJkZlEzbkg1bjEv?=
 =?utf-8?B?UDJIaEN5YVBmTGN1WDh0L2p2YlFBR21pU21YWkVMV1F3MUZwUm1MR2FHd2wv?=
 =?utf-8?B?K2MvN0ZZRFR3ZjlZcTJkbm01SWExWWxRek5ScTlOWDVPa00xTW83b0pwMDlO?=
 =?utf-8?B?MFZLUkxFK1IrL2R1SVlCYnFsZFBUNCt4dk1HSVlLUFBKL05xUU1NUk8zenpU?=
 =?utf-8?B?WEV1d2s4cTJ0TWRSdmZSR0V6Wmd6WWNITFdydkFIWVlnWFQ3Z3FDYUx6MzM1?=
 =?utf-8?B?bmkyaXpYSnUzRUU4RSswdjFacEUwMDY3N3JXNkdnaFcrWnNVVGxGdTZsRHJX?=
 =?utf-8?B?ak1BRmVwY0VYN1JhUlBaNW1zTXZJRG9EU3BPckg5bkpFZFhwVTZVYVNlTDhn?=
 =?utf-8?B?YlN0Y0xPVHpEb3FhdUp5SXg1My9maHU2L1BCNHYxcGMxZFFiM2FXVndLbmRU?=
 =?utf-8?B?NTJsK1hSNUNReENQMDgxQVhqeUZGay8rSmNMYkNDNG5kaHQvVHVqRTcrbU5t?=
 =?utf-8?B?NDFBTG9BQzJ4VEhNQ0Y5VTJYamJwaU83aEV1MGMwZ21iVmJnMWc5SXhVMjVk?=
 =?utf-8?B?ZktES1d1dmZJejRSZkFrSFRxeS9uTW9JZ2I2U1lQRThpZjUxWk5GdXhWbjcy?=
 =?utf-8?B?Y1FUaWdxTVM0cVlWM2FrZ0Qvd29FbXhmWktMK1RhczIybjloRWxiTHZ3OUg5?=
 =?utf-8?B?ZU5ZdmQ3dTRqQ2tBZUJhTThoc08wM2h3anZLU2Rpb0hoNWJaaUNPcHhUN2FC?=
 =?utf-8?B?c2tBUXJCOG40NEhlUEJOeDVXem1sRGxSRG1xTEFGZnQzNGJVMDFUWXpSdk92?=
 =?utf-8?B?UzJ3TUttV3Z5ZHVVSS9Md0xjK2NIcDVIVjhKS0YrK1ZLaU1POEJQNzU4U21l?=
 =?utf-8?B?K3BLL1RSdUM0Qy9iLzZpOHpEMkZMc3FwVHk3MWxQVDAyd3ZqdUpHdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27254e83-4bbd-4c15-5179-08deff9cafcf
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:55:56.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECxrEpqfkR3/DvHodoWOl/9juL+p9MhQozzayfeU7BPDOLFSccQcBDAS3eY1DZldJ7N8cUyBgs7OkpteIRhTeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952



On 8/21/2026 11:26 AM, Sairaj Kodilkar wrote:
> The cpu field passed from SVM to the AMD IOMMU driver does not hold a
> linux CPU number. It carries the host physical APIC ID used to program
> the IRTE Destination field when the target vCPU is running
> (IRTE[IsRun] = 1).
> 
> Rename the field to apicid everywhere in the IOMMU interface so the
> name matches the hardware semantics.
> 
> No functional change is intended.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


