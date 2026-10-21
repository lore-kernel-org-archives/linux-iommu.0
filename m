Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792564414;
	b=bZCbzK6/TF9/OrXFUwlQVGFFTiX3suN1YZVQXVyqDLAaU8mDEIv33rci5XOLCJEy98oL
	 EanmuP60gP0FxRYamKB1/p4obsJm1/RsQ4sfV0esjeX1I/0Q6+abNlxs7ZbpiSLFWOQPx
	 whOAS5LVsO3qZzWxQY6yT5bG5gCGkfE8yFwqock6SFKJfGM6FEasa8f8ow+pQlTfHn/lm
	 dpohLHAao2kKnALzHuCltUfXGwtGLhK+tzZb7YkN1JRAA24blTPe4YWp4mmECX6i7m2se
	 HGvw99DbyIvIKGJSUMKlyCn8Wx51nGQwcBAAyEyHWVGlTbhK4NuKzMYn/7ohBySsV6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564414;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=aBAgSot5H9jUvIaDfZxQG/vSA8fxqZOBo3R1F8vEZ9U=;
	b=UQ1PWWPSvQT31Z4f7QYhNRxdukPwFW5ftZX5O7k9fRn85CX21QnTisJ9+mRfIrfwguhk
	 hFhQSxYSyTOemv6yTSuNllB98q3V7LIbBnXIuv1S0NFGj/jI/Oh6/U+4rmwfWSQDDOsqi
	 YxrJNNG4ZO0mXuiRGFoU7/82TDvU7KfSENi530/qXzlrn8zlm9bg75DiO/nuSSVjpzN1w
	 fS28siCvKA7bTsc9dOTCs939LQlZZJC7w4h/UhL/GZzS4JqDaZtQkZf4Q7UUI7QlpQzGI
	 oXF1BA7IAWjOCeQz1FkEJ6gw4GLxRU5x17rmeZ8XK2xJ4Z5yN2kkr0aLf/lYzUfiZDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A6Pzix4I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.33
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26268606A327
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 06:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26268606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A6Pzix4I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soT0fnTk8WTvDzII8m5ceLtC1EambHOEXdPQtrpL4b3d9XUkHNExP17ox5CBnnwGwsbHX9sXZnF3FDKFH8PwOVuI1eVKR8Ca8Uo8cjSSE97wQx+hs+qzv+pK3l/LIx5AB7t8aLd1vCSsEyA2iQ97I4UZEq3eRBBZJuW1x45prOHge3+lg6+5hPXjT1kHwOMxa+oqIt46eOyB/YSclCBaUbP8Yge06SNydfJa/pVXkXRT/Az4UTGFFeJ08TZq/Sx84LHcnVqoEz5uyA6zlrMydVzOMedZ/2hWjefRCZ2TsvReZDHfHiK0x/4W6W/Z6JKnoKdFEOfwMxVDkz9cp+hlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBAgSot5H9jUvIaDfZxQG/vSA8fxqZOBo3R1F8vEZ9U=;
 b=Ky5+/M///+x3Hz0/D92Dm1HMhFiLzOe+hChadIdGCZszcledoiBFSohytWbYrDQ2haRArFmOnC7jAbxFpPS4wRtMuLqxX7FLrftVwbCVTAtGQ/7TTMlSaJYagjXii43s2p3T+LgM0aoATpv9dGPdXiedGpOeDRLdqY/pKE/VRrU/NUMpcN0B0RzN5aht8d4z2rUyS1x49RthRlfQPpZwGOPstBFz9vySxNy0BfYT4/GO1Zt1gWFBV8nZ2Svbe7KNWr57GJvyeeLtcbpWldpVIcgqGexk3uzjbdJvZwzbEUn+572O5w/vY1Yq7YWdem1bWL4dq9fJ3Ur0K8ZQI7OytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBAgSot5H9jUvIaDfZxQG/vSA8fxqZOBo3R1F8vEZ9U=;
 b=A6Pzix4IA2N6D1ttjQpbiK3wtWgTGpGWDkpfn2TsL+Ok0U00PLtxMuwORjeqyZl0eB823CKY506WM/On3k9Rcbr/s+Suhy1GBXBHQdympk22zLzdmPCvaEoFAzfAgiPjJ2Xr4StTd0TU9WxvE3ixsJwS5b9zlMJfg2SJnRPz2xE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by LV1PR12MB999306.namprd12.prod.outlook.com (2603:10b6:408:3f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:33:31 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 06:33:29 +0000
Message-ID: <dfc3edc2-534e-47fd-ab3d-2a66e57e47bb@amd.com>
Date: Wed, 21 Oct 2026 12:03:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 22/24] iommu/amd: Add translate-device-id alloc/free
 with vIOMMU owner
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-23-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-23-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::8) To BL4PR12MB9505.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|LV1PR12MB999306:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9cde62-b951-43dd-8ef9-08df2f3d3868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|22082099003|18002099003|10067099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	16VAyouj915QhMyv4dzs3bfrrygVulfZOscd4g/MR9+elrZi9AbP1j1gAfp98/2G65l5p8cgT9mii4Le7GzyGI0O4Zxuf5Fi2xY1CNcROcwEz5hkN7zxTBdgmqbKFZwG38KJaPUC5sYkWmYrrZ4tZm+yy/1V0V/IHUmo/tvCyKdDZ2obpiKMGlL1YKrzvAve84wchHSrXTIwWeZmTS4mZ/tbIZMR4mYdAiWXacrv5qI+IGz+Of5F+jBXLV931v6pGfdPAStHJxbxmUiKa4z7lyk+rxPLvMiSkR6bRf30JVTmliQ4FprNMxfGrPJ/zUt3EdPqLZnVyz8Tnm7tfYZnXv4JLNEz/Jae38i+TOV8u0DXqgWqNlO68uJvC64z8ys9oNFW4VJZ2PtgIzokEU79q4ajhXd1dcC2H94R2WRQLh+APdo4EacA6tabU5+gQ+3fOfYPY52McFkCvEx1OcYcY27Banye7QC14vBPshYovhUoAFWjdV2+SwSPe4dEkaEtsvlpKxVWHXvc1RHzp/49YnuhlZVYrm+fEWfuC50T+FMTtxoTZy5p7sJtKN3em3Pt/wAdM9D+ksqOYO/f3ScA2rGf+7yqDtP58GMMrvUZ1xxd/Fw/ty7v0PFFPK2bJ5BqoWYo96787/qqnrSRz4tP7WTtnkhh4Ti+Wd+98LIvQrE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEEzdGpXUXB2MVZ1MWlzb1RMMXJNZU9JNWxWaWg5RjRieGptQjR6U09MZ2ZD?=
 =?utf-8?B?OXgrTEFGQ1Vvejk0T0QycWpBVnV2ZWppd0pEWnFpL2lmdzByS2ZGeGphUE1D?=
 =?utf-8?B?VWNZdWszYzhYN2YvdzJ4WDlzTU42ZXpCakhqNU9jc2d5aHgyWElmMWszZGZl?=
 =?utf-8?B?aldCQU56WGhzQ3JkR0FOTUZIRDFNWDlIZGtMdHAzTmxxaWRpYU96OHhHVmc3?=
 =?utf-8?B?ZkFXM3k1VFk1NEhsVUE2UmFiM1ZjZWk2cGtrTkVwZDFlVERhd2hkMmlhaE9X?=
 =?utf-8?B?WjF2N0EwUUtDSjFhazVyQnZUQTJIT2FKY2luOENrSjFRQW9LZU1TKzhmREZU?=
 =?utf-8?B?K2M5cEVtRVN5aWlnQjN6bUtLbTc0OTdIZ2NwVkR1M1BUZlRqdGQ1T2VPUHRr?=
 =?utf-8?B?bVlMUjJSdXBrZng5bWpkckFTTUV6SkxjTUdKUEg2MlBCRFdMb0xuTm1Xa1FF?=
 =?utf-8?B?NnNNRGNlNEZlVEZDcVNpUjF3eG9uSjNOM25OcndTR0JpeFJTYzNxbUNxNzI1?=
 =?utf-8?B?eEczaFE3dEgyTC91blZIbnNlUWJHRTV6amExZlZGTDAwTEZ3V2hlQVhLaEpz?=
 =?utf-8?B?aVJWV04wK25KY251Z29aWk50ek0yV0lJSCtMWHJ5OUhZQUhCTklHM0t5VXJL?=
 =?utf-8?B?WjFHSnNoeVg4RmtXNFo3OEhLQyszdmZieGhYdCttNGFLck5leXBSWTR0N2VE?=
 =?utf-8?B?bWhrMXBJYUVQeGlCK1FHZlEwQWs4cTVTSjIrcFIxaFRwMk5vY0g2SWd2UXRE?=
 =?utf-8?B?YjQ5UWZCMm5RZTdHN0s0OHR3UDJpRmpjbGM4RzlDYnpwdHBZVlJ4QldwMTVY?=
 =?utf-8?B?b3hpd0dFQ3ZUcG1RNEFGUktlSEovMWkycVdONGJZZ0hsdGREVElYZ3hJWHlM?=
 =?utf-8?B?V0dJL0Y3elNVM1B2d21QOHp5aXhwSllNaDZ3U2w5d3NJeXpSQkdlcktoMmV4?=
 =?utf-8?B?RWdnZzQwelJhc1kvemZrNEVYanY0RlZHVzAvS3JJUHpLWGNFUWNFM3dtaitO?=
 =?utf-8?B?NUVoR0JTMXc0cWI3MU94N0JLWFFtZlVubUpJemNMSUtuM0dycnllczdSZTQ3?=
 =?utf-8?B?a2h0dVE0WitsSjF3T0l2RHdjMDlBaFB6SkQ1aHc5QVpDUmhKVXlucFRtYTFw?=
 =?utf-8?B?QkRHVmhtMjlWdW0vSGthcWlpZStna0YwbWtzd2Y3NG9wTWV2Sm1jazFWaDY0?=
 =?utf-8?B?dkkrbS9nSmJPM0tBZ2tiRCtibGVwM3hrLzZmN3NibWk4WUhyYTMyRnNvckp0?=
 =?utf-8?B?aE1TS1J6NTJ4U1Boc0VJUG1GcHpzR0pZNndYdXhDdmtLNUg0MSt2VGlkZHZT?=
 =?utf-8?B?a3pRSXFiSG1lWTNRSk5TOVo3cXZtVlJ2QTZDWXJTNGduSVVlK0ZJeDZKSitE?=
 =?utf-8?B?MHo3Tjc3YVVEcVl5TmtpZ0ZpUTNiZC9FVGc4ckZZTldHKzF6bWR6OEkrU0Vm?=
 =?utf-8?B?YVdPM2JoellxZjM5dEJFZ1RYVHgzZ3hWaFV3KzZTd0o4aUdpSjZHM2ZDSTVr?=
 =?utf-8?B?QnZXak9FbEtJZXZRN3hPMFRKa3NCRlZxcjlRZlpqY1JuQTdTdlUzOFVUN2N4?=
 =?utf-8?B?ZnJKS1lzalJTaVNNU0h4d29XWXdBemRPTFdMTENid2ZGZGcxbS9kOXk1Ti9r?=
 =?utf-8?B?cEptSEczL0VqQlJVUm5nQWRLZHV6RkR2MThqeFRHNlE2cmhwWmgrY1JPTjFy?=
 =?utf-8?B?cWE0UTJSbnRxblQ1bERyZUpJQURxbC9mQ05rN0NtR2VESFgvRllna2FTUFdG?=
 =?utf-8?B?bDUzVEtLZUE0NHRzQndkMTFnWWkwUE0zWTFGR1JCd2trVzUxUGFJY0RwU0Fs?=
 =?utf-8?B?OHEwcVdkKzZzNnV3dlFpNUd6M2M0UVE4d2cweWs4ZHJobHBuYnRkSi9yZnRF?=
 =?utf-8?B?d0dKbHJuZjhENEdSWTNRZmlRQm5GWThwNzJNaW9PQ1VCQmk2a25YNDRpcjU0?=
 =?utf-8?B?NkNXOGdmU0xmNXl6YVRvTU5WVG0razVGR1dtdW5wZFU3dWpjVFdXckdDTWVq?=
 =?utf-8?B?UzVFcVJjdTZHc1g3SzY3bUxZZU0zeVFTT0xVNTN5Qkl4S3dKVkdEcGpEeWdG?=
 =?utf-8?B?U0k5NlpCWU5qV0ZCM0piajRpRHc0a0ZDUlZCbFdOODRjbmt3ZElBWmxvbWdV?=
 =?utf-8?B?cnVrYmdxdkJXMFZDRmw1Zm5XdkZPL3NRZkNqNEh6OHdKeUNqamtpTFN0Tmoy?=
 =?utf-8?B?a05qR1k5VVhmWk1rL3IxWGxhN213aHFqU3o5akNKSndqMlZ1QmpNVEF5TEo1?=
 =?utf-8?B?WTlxbzIweXlrbkF0WFU1VmUrenEzc25ESWhmWDZKTzg1dFdYbVV2NFkxUmJT?=
 =?utf-8?Q?UoVFf5CUpMp7Op4eKj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9cde62-b951-43dd-8ef9-08df2f3d3868
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:33:29.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rs2xYWgjxt8R4qOnc/jcPr3W1PVWgoOLNNfCfmDfxvS1n6EldgHT4Drh/NkXzfmEeGgbK1M+mLh/lzeeNJrDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999306



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> Extend the per-segment translate-device-id pool to record the owning
> struct amd_iommu_viommu in the xarray.  Add amd_iommu_trans_devid_alloc()
> and amd_iommu_trans_devid_free() to allocate ids from last_bdf down
> to 0 so each id indexes the device and alias tables, then return them
> on teardown.  Free loads the xarray slot and erases it only when the
> owner matches @aviommu.

AI (Claude Opus 5.5) generated comment (seems correct, copy-pasting as is)


The pool marks a RID as used only if it went through
amd_iommu_probe_device() (plus its PCI DMA aliases) or is the IOMMU
itself.  Are there RIDs the hardware uses that never reach
probe_device()?  For example:

  - IOAPIC/HPET RIDs from IVRS special device entries


With this patch there are two per-segment xarrays indexed by the same
thing, a device table slot: pci_seg->dev_data_xa and
pci_seg->trans_devid_xa.  The translate dev_data and the IOMMU's own
dev_data are kept out of dev_data_xa, and that breaks the DTE locking.
The interrupt remapping code finds the DTE lock by devid:

        static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
                                      struct irq_remap_table *table)
        {
                ...
                struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);

                if (dev_data)
                        spin_lock(&dev_data->dte_lock);

                new = READ_ONCE(dte->data[2]);
                ...
                WRITE_ONCE(dte->data[2], new);

For a translate slot search_dev_data() returns NULL, so this
read-modify-write of data[2] runs without a lock while
write_dte_upper128() may be updating the same word under
trans_dev_data->dte_lock.  That can happen as soon as the pool hands
out a RID that also has an IRQ remapping table, such as an IOAPIC or
HPET RID that is not reserved today.

Could the two xarrays be merged into a single per-segment "DTE slot
owner" table? Something like:

  empty                       free, the translate allocator may use it
  xa_mk_value(RESERVED)       used by hardware but has no dev_data
                              (IVRS IOAPIC/HPET/ACPIHID, IVHD entries
                              not yet enumerated)
  struct iommu_dev_data *     the driver programs this DTE; an owner
                              field says host device, alias, IOMMU
                              self, or vIOMMU translate (with the
                              aviommu pointer)


My comment:

I did some analysis and may be having single xa_array makes it easy to maintain.
Any free slot in dev_data_xa is free for translation DTE. We can have additional
flag in dev_data to track the translation devid vs actual devid. So that we can
add checks to catch allocaton/free bugs. What do you think?


-Vasant



