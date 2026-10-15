Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E425349A2
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092939; cv=fail; b=q38MM9dwtMcKnqa+xX4tHfhZCtSFPP8diNmJteqxGn3LpC06qfj/NCGItXh3QBQgtXFglbFu+XmIgJCIXNqyHcPp6RMqx0C6QPseTnH6nT1pCLEPhEaicN3CbMOfDw8yF0hdQnb6ozEWOzcmhDVxJn7D1uOZ3R5y9mmjXC4QOY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092939; c=relaxed/simple;
	bh=PW6DYsApzk66pA9f0ggjWwV75IKaN7SihyKQehVITME=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=HrqOXPXfSp7cjXrzFlRRiF3oh32peIPrlIkepDBZ0sQR96os2tzquxFYVKwLUdyS59Jqk1xZId+FT9BJ9dIWDotn2dfNiYjP9GQiVNmtGuzFJLUcfMwk+7BMZqbmrkbUdexKjrL+9UNQ/zYJrX9xWCTeH0lpLBn6fKTDoOi0C6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c03mILkW; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c03mILkW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0Esmp0KjdCXJawpicwQbJ+bYcubutL6gxWPvQXdG/Gnc7fSj9n4GoPpZxmNWfYuz6btMZjyGlmAOg+iaN2HC/IVtbyVjKCEjVbaXZTjfzn9sMJaWGO5QdJpTDumEPw/yOtxBbLwUarSnNkRX6Qtt6mF39zNYAhebvZ4xRH3Sn52WLYg/kPOeWxvpEpRPvf+ans2OAgsXqpYLCH7CQa4msxewtxJxZLbCWX9Fj747bDmMpo2N7BjZ/I013894JTzPapts11JgxgG2UXmkm4Cs+pkTSYVMXVVqGbnhW15gDmanctvQ1w3+Qt1tBSTqb8Jgqbq1oaqwTvuI4KY+h62TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FP9M6BM4zIeo2qzHXuHrsKfv8WOOJKkvTU2jzbIpXk=;
 b=lFXqiT0Sh3x/QPzkAi1GsIq2xMFewnx4VM3E7Hg48b5UkQU/1ADlzBLOKyIjUypA4SIoSb7PYAHdn1SYDM5AYK2EQrWOMkrH25ew+Hym5AjAAsMytSTP3qm58AfpD6opL17euZ2gnZDu3m43GTyWoPLFA6HGhA8dH8OBdVxrhSw4Q4TS0bpy1i6iyCoQ//cXmVM7k6oE+/BDzj3lFppAkJqb4JeAYOpJXQLgyGKHNBxFO/NHoyxeUV8NbVXr0Rl53RbsvVoXcgwGt1OXR+LGs2GpDHR0gd50P/2oDBqTTp83+77XFZS++n8vAjCvjJG8AMJNOV8is6IuJKDRfEFEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FP9M6BM4zIeo2qzHXuHrsKfv8WOOJKkvTU2jzbIpXk=;
 b=c03mILkWUuA9cIeBY8TJbRS/SX00ZqdcdRS/EaibhBq7SV8Hd7COvHDf+AYaUDzfgCuRPC/8F1OLyCgDL88MCBLsHuTSAmIcQbEgRgcf4f6mfW1mQPMPcZHwdxZe2oayGd5gfUOkMo53kp3pyYMqBr41ua4bNdCtbJT4QMKorYnjplB8LMq4WHFe2/Ced1CBDWyD5VRhSPAs4Y25gzQ7I0no6POJe2jNt14Nr5+nqWKlQM4HbQmfG9LIri8+wmIeOhH93hg/szT0VVbBikD2bEZpsvNFs15mdNGzXxDshz7TycXoX5kO8cmXLnEN0UyKs+N88Y55zfyVfZvuW50Wxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM6PR12MB4220.namprd12.prod.outlook.com
 (2603:10b6:5:21d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 19:35:30 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 19:35:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 09/16] iommu/riscv: Reserve an MSI IOVA window for
 iommufd
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev, 
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org, 
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
 anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com, 
 fangyu.yu@linux.alibaba.com
In-Reply-To: <20260925151659.419512-10-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-10-andrew.jones@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:35:27 -0300
Message-Id: <179209292716.4133959.2758345963634439485.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0272.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb3b0f3-e345-4d3f-ce93-08df2af3788c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JtK4OxvHrpMYHM81YT8gTFrC/+Onq0Tl6X52IYOtRu4hGXgVdf92Ntm3J7YorgDeFoVjCFS/nKR4r/q98IdQDzmf+2/gxCZ/i/ybjinl2z7q5rouf4kXwdP7IuWT58YKg3lSrjwGFk6wA8Vk9yObw5PPCeaXrf+pz12wnkuskJa7+ShCpD5BB0cjrCDXyJLnPYN4y7UBceUiocMHsmThgsWtb4VZkRwiSsAqQlw8krhHiykEtXNvQcxwKjNIe6PkvBEa19YPl6Ml8FiKtPeQReF74QlfzDebyrv2HKpXmjWKADBvCnJxmYCQOFl9vT8YMcvsriGmJxW+QlxISQG06i553yiLoUNSIYKSEk4SWTAbcNUZF9mVb7plmSUUmq5QnKgmwasJxdA6ZRAgPKwwZkxwIxIpBRYaNilFtU3kaLYCut0M4WHbIpn6D4UEnGW223aO9DQB22coV8Em8ioIOZtSm17NJp5a1FJohQJS0CMZRySdKXSBIzHWFd2vsBoKNqypKItUsWh8U+fskydOL65UCBt3KzoNRx/A5Fxp6FffFmhcaJMsImhVv5EDhU5QEzewCNUIUo1pKh7j2kT+3HFKz6DdD/HYJUex9thlK5GP5+JsM4GAHGl0QNu6U/3qgE/4zCVSmL2y5FNNhi7z5LtStoHUIt7jhH+893k0OV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3p5OFVmYTltaHg4WTlCcmdXQ0RYMmpMZTlXejdBbCszdE9tZUFUY0ZoeGRn?=
 =?utf-8?B?UkFSUnorOHdkRUtSbVl4QTRLQ0EzL3UvUFRTRzJRUjdqYWR5MFh1WFIvZWcz?=
 =?utf-8?B?UmZFWGxJNWhXZDFKM3VjaEhFY1lpSDZ0dVFZcTQzKytERkxxajBad3pnS1du?=
 =?utf-8?B?Z21KdEIrWUtsOEpOU3BrVmhuZVUyT3ZrTnVCZGRTU2dXblhnY2llVy8wVG9V?=
 =?utf-8?B?elU1ekdlWXQ0OXlYd2o5bUUvUCt4a2dxQXhSNDdsQy9ScFJhVTlEVHduTjlq?=
 =?utf-8?B?ZFB5MjhXT2RtZ1hreHdIT1VLZGVmd1c1OFNjLzBsKzhHVXVQbS96OGwvRW5j?=
 =?utf-8?B?dWVRNnJZK2hvZUlIak5GVSs3c01lS3hJTzNNUVlQNE1CL09kbmdreUNpRmxa?=
 =?utf-8?B?a2VtUlhDT0RZYmZHWGl1bzBnRnQ3aTBENmhKYVVzV3krZnB4QnZkV3lkY1Jz?=
 =?utf-8?B?bXRleDJtckFWa3E4cFdNZTQyaVVUTTVScGRSY0F4bUJOOU04V3lOOWFVU1hL?=
 =?utf-8?B?NjBXQ0JkS2VORnc1N1JhUW8zSEZZc3BtWVlYZHcrRFJpNC9FKy9BYkFrWWFF?=
 =?utf-8?B?d0N0NTczUE1YV3BXWnpSSS9YcGM3ZVR1L2laWWNSTDVZWlRML0EvUVlMMSt3?=
 =?utf-8?B?cWVGaWswekVmMS9LNjBqMk5VVHM5ellhWUJqQXFsand6RnBBdEN1MUZpdjk0?=
 =?utf-8?B?eG9oQnFXV2oycU9mU09JNEVPR3BReUtNeTdFMHNsR0YwRURNenBEalRGcVVq?=
 =?utf-8?B?Rzd6aU5Pd0w5ZytsOXNUbHlEdmREUndhckxSR25LU1pDN0V3MTRkNzFsVVM3?=
 =?utf-8?B?eStlRVJWdU9ESkM4ZDVwTzlnbnVqSjJyT3BydS9EYk9oM0F1NGttWXFkbmFI?=
 =?utf-8?B?U2JsWWRUc1U5cCtPQzRVOUo0bmNWdi9vbHpMUU92cEliREpIUjVGNE9IMWRT?=
 =?utf-8?B?enZ3Q2tTaWRZbkRRZ3RZV0QweDloUytodHVSUWNFWEtUNUJaNjlPOTNTTkNl?=
 =?utf-8?B?c1ZhMGplNGZkNjZ0blNnMjFBOGRyQjFJTFI1ZUZjQlk1OVowMHJBUHBVL1Nq?=
 =?utf-8?B?U3FwVFZoemlpbGsyOGhIaFAvcnpjWWVsWXpmUXFkQldTbHAyUUFzV1l0OXNv?=
 =?utf-8?B?VExUMVZsYVRaSHcvMHRNNUE5ejBIb3VYeW5JYzZUZi9sVlplRlFiKyt4cEtn?=
 =?utf-8?B?enplb2t2ZWhUY0RxN2NodzdiTWlHaU15MU84ek0zSmt1WHdhUXlpVWlTOElM?=
 =?utf-8?B?TlZiNUQ4b3VRL3hyK0x0N1B4VHFUUTRTVzcrbm1ocW03NUp1RDhwbitYa1JE?=
 =?utf-8?B?ZGlsNVN2aE5kNWRKWFIxUXVNb2NLUEZMdmdOY2I4WFZqclFNUjM5bnpOOXpX?=
 =?utf-8?B?eG11S211eWt4TFJTMzUzWDVsNThpTnp3bEZhR0xicGVOTXBXZC91b0Z3SW5J?=
 =?utf-8?B?WW13bHRNSEU4NTRNSjF2RnIvMGFsQloyODlJRlZyYXplS1hXZlBmenozeWlw?=
 =?utf-8?B?ZnZGRHc2enFyZGRiVmVtSVRENkpmUjdZNkp1a2VpKys3ZkVsMzJiUXF6OEI4?=
 =?utf-8?B?cnlmcVNESjNjTGs4am1mbUIzMElwZStxSGxFcEkyQ05EcjcvRWJQV09GYW1z?=
 =?utf-8?B?RC9GeGZLTkpjYTJHNTZqNW1PLzc3NE53aitiNDk0aGFsR3JVdWFsL0MvQVA2?=
 =?utf-8?B?T0l0TWU3YTJHdmlUa05KeUkwbDJmYlh3N3Zqa1BZZmNwVU1DWERCbVphVW5I?=
 =?utf-8?B?RXBNOWtUNmZZWFM0bGw2Snk1ZTUyQVhwZlVHMEFWNW1XOEozSnp0SnMwZUNZ?=
 =?utf-8?B?aGZ5dlBiM3h0d1hsR0w5dUJjNXFGZVZGSUtJZEh3M1YxVXpkYy8wdlZCYjVM?=
 =?utf-8?B?T2xQNngyR1E2eEpYMmNMeUNzZ1JBeU5GdjBDb21hREZ2cWZFbmRvVXVyeXhI?=
 =?utf-8?B?UlE5bExWeXl1Vm5oWlFTRHA3M1BDajFqY3ZCbjloS0RobkU1SXpuSkJSRnpP?=
 =?utf-8?B?TDgrV1JUaDlaRlBjUFlBazRXcXFaSUU5enMrQWdodU16K3NweXFhalBjZmpo?=
 =?utf-8?B?aFM3aFloZjR6L3hEL1VkNUUveUpoWGw2Q2pnbFRGK21vdmYxSW1mc3ZBNXJn?=
 =?utf-8?B?VVFFNk5GS3hzZ1Z0SDV3RW14bUFjMkFzV2lwaGdPd3QzZ1NvWENSTTZVUm9i?=
 =?utf-8?B?b1h0OEQ4akVMMmNJVzR4SHRLTHA2aXVTU0JtOVZ2TFB2Smw4d2s1VFRtckJw?=
 =?utf-8?B?WTJLVWNYY1lkb2hPbUxPdzF6a25TVXBxNVVwVGtwVHJOMnJFbVpzSFpONHJH?=
 =?utf-8?Q?5+Iqt1AKgVm+VhF6wg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb3b0f3-e345-4d3f-ce93-08df2af3788c
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 19:35:29.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+UFjuoiPTrGL5LSBWBzp9iOOXH+NnorkywABX4XE/JEzS+RsMixHaaNSegtkTsM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

> iommufd requires an IOMMU_RESV_SW_MSI region to allocate stable IOVAs
> for MSI targets. Advertise such a region when the device uses an IMSIC
> MSI hierarchy so interrupt remapping can map IMSIC pages instead of
> falling back to physical addresses.

This commit message is close to useless. Please describe how this
range is actually used, including how the guest would interact with
it.

> Reserve one page per possible CPU, sufficient for each supervisor IMSIC
> page. Use a 16 MiB base instead of the 128 MiB convention used by ARM
> SMMU. kvmtool places its guest IMSIC at 128 MiB, so with IRQ bypass the
> domain-wide guest MSI address match can also capture host-delivered
> MSI writes to the SW MSI window and misdeliver them to the guest.
> 
> 16 MiB falls in a hole in the current kvmtool and QEMU virt memory maps,
> away from their guest IMSIC windows and RAM. Keep the window below
> 4 GiB so devices with 32-bit MSI address registers can use it.

And this is a good reason you should not follow ARM down this mad
road. Nicolin had some patches to allow userspace to select the SW_MSI
range instead of using a kernel hard coded value, which becomes a
sneaky ABI. It would be much better if riscv starts off on the right
foot instead of continuing this mistake.

-- 
Jason
