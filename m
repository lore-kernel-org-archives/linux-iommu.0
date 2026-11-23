Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795426532;
	b=t0OO372NDRZ6Xsj4umcMFczIG5Sv4WJokN9fP5yO1PdsnUUZg9CrtPffmiTY3J9dVku2
	 aRTMNk95fPxXjsL8zgKwjrUKLzr/v334ClAVrpag5MzzmnFvueZ85Hzey73wRTmKhrM2e
	 4/025oAlqDq1WZRgjf0hHmZv7/TiwKNdawQli3HTHF07VHeDV4C59yyjMFmT4TfTMqQ4e
	 e63vNn6vpUeFPA+nrC51wcS6NnKIz5Kt70SLuzLIBjgCk/Jo/ZNXwE06SbhHh+zHUvJ+0
	 3w6wBFuyUSnEl9ScQe8i7yECAJAcb7feQ1uvNes6a6beAATmdD4dThjK5rWAppinp+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426532;
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
	bh=Z7QCGyWk9AMjRk9rFWPksbyiMPkHws2G9hkgNI81+Nk=;
	b=XlTBOs4uz1dbr6fsRI+A2Dk02kt9iVh2nVFFMCkjsoA+6VwPXBkArObSTh0YDmivcStR
	 1P+tJojpaV7stbEzil/6smpI2ezLfFqJspTdRps+sSMt1eHAm3WO1ILaJOwxpOMUS+dW0
	 Ty3wVDOKHs1FX/Fakcv7rlevO8xuopG3pzGgs202XmJfp9A5tAX4OyF1bNzRw/LWyxGcU
	 MfWqGL27P8SCD+vUfxF9lLwOntvVOOcytZ3hgHt3AUcgkSDOv8l93ZBI2b3gt2ITfsVAm
	 7pqoPdufdyNNJW4QKtQS8946/SRu2IM3lqdCgGhBxNQRwbavMvLxqxAkIhDcmOVHSBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eqBFGtF7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.5
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D1606A699
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 09:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A08D1606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eqBFGtF7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUiqh31uLAL5yekX8YX7PFnt8MIHNCnAHhzymI1Hf6dfJy14ryC6dXRe8wB/zlgz2lFVkYkJsINnkWkQQ047s2Eop7Y2ozx6lbfczPPvBhY3qwbe/c39FZYNASxCPHAcbtuvxruvdpeCA/0iUgXAu54Ww7pCw64Bp5Z7hcFgQKwoCmsBeTrv7BDrM/MLIiI2UdJ9fRynTkeozwL2uBsc8ORrQEGF/RxlPyBOWFJR6yh5XNBca/PTVCEmyTkBeJNGyQSwVUiQKAPe3u8idbCHcYl0xIpKWmRAOJgeqh6PCp/KpEFL33UaNZnsuuM9hhgBHbYDqkhfHGg268cP0AfMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7QCGyWk9AMjRk9rFWPksbyiMPkHws2G9hkgNI81+Nk=;
 b=cq/XUAVo54auF5c4qoPlo7G45lvmDe23PFTWsi4cXmnBQvyvjAfI3KeJ753bDuzwMzFpNetPjueHMBIvCT6PM06q6aoEzDo5a5HzFi3UCQRhOz0wmwhdNftfPvt7ivtZN91CCmoPZ8XDSjccw0KA18QARvnDrrvJKDb0wapQEUYeI+fnaiCKEB5HM2UP9P+Dfz8wcSAgzO5RDr1d//D01nIGdiRM0NWsSdXygVH9DXA3T+8V0uHUOlJCeUtgjpzb8Ry6o8KszkaeQV12oVcSGgotp93v/r83R3dXBDNqgKwxowtkzp50MW44QJC9pKWxffCc0zBjfbKVKKwonCEtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7QCGyWk9AMjRk9rFWPksbyiMPkHws2G9hkgNI81+Nk=;
 b=eqBFGtF7dOlKdTbSY6fN6jdQsVAkFiUWqMsXuXOBq+cVmKJBm7HBCa+bL8oa1gVPoKcaQaxfZiUCqy8YL7PKMYr3qykG7U749287syn5gQOpJ1gDg17G9DF8Hp7apOkv1r0DVMYKssT9B6RtWDMjWf4SLwvDvUDOCDRuGn/NO9I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 23 Nov
 2026 09:35:26 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 09:35:19 +0000
Message-ID: <721a92c6-fbf3-4f92-9812-3765dbe4af6a@amd.com>
Date: Mon, 23 Nov 2026 15:05:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Reuse device data for IRTE cache
 invalidation
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261113095017.1835921-1-guanghuifeng@linux.alibaba.com>
 <20261113095017.1835921-3-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261113095017.1835921-3-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0113.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::13) To BL4PR12MB9505.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|PH8PR12MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a74533-003d-45bc-0f05-08df49451703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261022105027099003|11063799006|261026140227099003|261028144727099003|4143699003|56012099006|10067099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6WS6GLMVowcz7TDKMjhe5zcsbSfnop/Kuv50PkLJmHp/v1hjDxmYTsgsfsWrze4Dnk+sVdpJqEgpPBFgbZpyNVHr9zuvs9oKtrljwYFeIoz7a16rZWfF6Fpt38m87txACRBNP3bEx/+v8NB1bQkCsbi2Zqbp9y6J70SoogY0jmLBj0SyFCbBFjcW3cwXga11TlbXNS6noixL82e7gMOxMaJFRVMk6DRLEc6X6/tdyo4r8Aa2BokYLXIGsYPRzcD4DpHeApQrjjs26+F2HU9AWiaY+WCoXrS9tYubHB+pApbmX690SYV0CXvAFLOwTyL9LDVT9bNF+Z12vtqJTncZ15jburiv8aPRdpZVEcT2Sfw36GePUUTRKBgtnGDDKxqHshdTzP1QzuTi31tvnjv7xWNHAo84RkLMYHz4WJ4+nnYA1/yGdt0L+OPw4A97dMtbLT9y3Aci3QTI1E/mZLGAR5yiCgVMhYsfMXxEIcnxPy6BrqUxuMGarSswgkj6X0N9reneVBfCZ6Fl2kitWXYESMvUqPBYBKxr0oa2886tZ1C2CstKqrLAzp8En8zFOxfpAiKYz7npiX8U0pMLWI4f6J06DxDdbGk6fyTQnHMkuYFHYD5OJXlnYE8N5fI/BCw6AKmUTuWRkv1gBezbRRv9lOPDFNcVkdBZpo7GWc82two=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(11063799006)(261026140227099003)(261028144727099003)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LytIc3drUVF5a1RlTlBYTlFLcEw0d0thU2JrNVE4b3JhamJMRis1YmxIVS9W?=
 =?utf-8?B?a21XaDBSc2Y5QS9pY2gxcVV4TElMcHY3Ymx6cUQ1VEM0UlV1QUk0T3pETnc3?=
 =?utf-8?B?Q3FmRE42aEY5aThxNzAwdU1lT3ZBdGRFbFhzMXlNbnl4UmlEcWRPMys4N0oz?=
 =?utf-8?B?cXg5Mkx4WEY3OGdXUkVjOGdiM0s3MlRONU1DdXcrNlZwTWhOVGpyQ2pRRThq?=
 =?utf-8?B?VndYaUp1UGdtbTdpZmQybHFBd0ZqZkFmTlh2Z2toazhHbGNWUkNzejVoOGV5?=
 =?utf-8?B?SFJreTFjWVN2Mis3Vkp3VTdOYTNBUmtFUHVEd1BYbUtsTWN0VXhLMmhWUExi?=
 =?utf-8?B?bmJ2QS9uVmRud3FNM2NkWVZHemJCRDVCaU02WlFGcUZIOCtJdHhmOUZZSmx6?=
 =?utf-8?B?S0dKbENVcXFWcnFXREVNZ1gzRURVQzBRdE1YcnFJQ0xtSDczSGNLczUzQTdh?=
 =?utf-8?B?SDRwMUxWYTc2cXhpYlB1RzdvRmt2dTl4aHBUNkgvRVJvOFB6bW1yY296Witz?=
 =?utf-8?B?ek5UbDl1Y2hRV0FJVzkvT2VYbHNxVWlSR01EekZOZHZIOGVYbWx2YmFsaVFB?=
 =?utf-8?B?ZmRyZmtKelNsL0g0MU9Uc1kydjNZSEFuOG5waGJLSVF5QnFOdkRUR0taRG85?=
 =?utf-8?B?c0w4aUFIL2k3ejJXVncvcjk3Z3p3dUlhNFcrdU1SK1hkMjZTa2NCNGpyZ1ky?=
 =?utf-8?B?ZjBPdnQwUExWaVA2aDJGSTJrV2xjaTA1bWkxdmpkMFhoNGlwdXIyWCtiSDhK?=
 =?utf-8?B?bVQwRm12Tms3c2lXUXB3M0NpNm4wa1ZDNFVDaGlZRkJXc1IxNjdYaXlVQjR1?=
 =?utf-8?B?RkRDdmRMK2ZEdmRVZmNRZWgrcXhaZ2IzL3dNWUNHcTZFUXV1K1BJc2FydFdL?=
 =?utf-8?B?N2RUVDEybmE5N0NNbEtwRStNZUxtMTNkSlpYSWh2czVOY3o5QjFzcTlZeEVJ?=
 =?utf-8?B?dFRFV2kzazZ6WmdLd0M0S2NwdkR6ejRWRjdVNkdiRHNyNzN4MkJubVFhR2lO?=
 =?utf-8?B?cENBQVdhY3FVSnVWVWlzdWFEVzJQbjlyd0x3bkd2UXRmckJ5VWRoTUw4cWdW?=
 =?utf-8?B?SUpLVzJ2THJOb2VRazVlWU53UFdVSGRKUHBWNmdEbTlCeWRnTWpCSEZDbGJT?=
 =?utf-8?B?ZTJuV1RwTGpqS01zZCs5QTFXWnpnK0RSRFNxSGhneW9TS2ZZZ2c3RWttYVpQ?=
 =?utf-8?B?ZjUwY1RMZjR6ZFR4R091cXM2cWF3K0R6d0JjcXdlUHZTOEx3MFFHV3N2SVd0?=
 =?utf-8?B?QStGV3NqbCsvaDh0OHEwZWZQOTZyM1p3TDdGckdwSjBqZEdnb3puWHY0dkFJ?=
 =?utf-8?B?Qi9kd1p4VUI4ckhlTERYWFZMMTlFZHlQWUM4V2ZUNk0rTTJkdnhpeFJKRDV1?=
 =?utf-8?B?WlNTMlBQamswRjJhTmV5ZXAxRkhUQ0pySzFKdkgweTBmVWJ0cnNkWks0L3l2?=
 =?utf-8?B?YW1yaVFWQzV5cVRCZlo5azcxMU9HandKVzFQYWl3ZkdrYThLWC9JekFHVjN5?=
 =?utf-8?B?ZGJoMzRsU1M0MUh0SXJ3cGY2UWRPZkxsV1ZRdFZLdDVOUE84Si83ZFhseXMz?=
 =?utf-8?B?Q0tnTERQa3FZOEdvbHZpNFU4bHIraW1mc0VMVGkzNWZlSkZJc1ppNkhTT2F2?=
 =?utf-8?B?dXpwaWt6b1l1T0xKZVBzTUdMd2htMU5yemUyUnhUbkNzMUErMXFSYktzUFpu?=
 =?utf-8?B?azEvTlBhZ1BCOVB5MXZTalpQNkFrYS8vUXB4R2MxdU1VL1BZVkNlcXN2UUhm?=
 =?utf-8?B?QkpFWmYya0FaY2tVck5GdDQvekduU3Y3STVkOVBlRm5ROEZxZnhYRVo4a0xo?=
 =?utf-8?B?L2dOVjFFQWFwVTZ1Rm9QT2hXMVMrYWVQS0NBeU1LSkVGUlkrRUJxWVJoL0dD?=
 =?utf-8?B?MGRad0RoMi9WeHdOZDVhWnZ6bWs3Sk5ldCt1UUUwNTFxWjNnVWU0VDg4NjU3?=
 =?utf-8?B?cEdDRHN2dXFXQnJ3RlRXN2NYSW9ISW01ZUZEaHIrY1BHU3dQQ3grQm5uNlZ2?=
 =?utf-8?B?S0c0LzZOVFJ5RDg0cEx1TWt5K0RIaWwwQzZoOHhMaGhIWDI0SnV1bElTdGdm?=
 =?utf-8?B?S09INXB1TTVObjlEYXFMNG9FYlJPaVRRN0ZlSHZrRUtZK01udTRjcUxvWVpP?=
 =?utf-8?B?MXcxaFJ5c3NWYkFtMlNYOThIRDJ0ZSs2UkFoem8vOUxyRzNWVjVFUXRhcm1N?=
 =?utf-8?B?NVRvZWR0N2VzWmptUG9uVE5DVjFXQ25iWkY2U3JqNVVickdCbWpmajV4SjBs?=
 =?utf-8?B?aVZPUis4MEs3ZStlRjNhelJWcXFtVHFlMXozd05wcGJMTVZib0w0b3k4Rnd6?=
 =?utf-8?Q?fPOcSlFXoQNta2IMU6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a74533-003d-45bc-0f05-08df49451703
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:35:19.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDzO1rNEl72RZkvfy/x46SzfVRgQ0YAGt4TPk8ttOSi2BqW5NjnrAilnzWSLl4Nw37k33zx58B6apa6Tron9/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675



On 11/13/2026 3:20 PM, Guanghui Feng wrote:
> Switching an interrupt route between guest and remapping modes, changing
> IRQ affinity, and enabling or disabling an IRTE all perform a linear
> device lookup to invalidate the IRT cache for DMA aliases.  Nested VM
> entry and exit can repeat this for every posted interrupt route.
> A reported workload with 4334 device entries shows median lookup
> latencies of 22-33 us per invocation.
> 
> Save the allocation-time device data in struct amd_ir_data and thread it
> through all IRTE update paths:
> 
>  - modify_irte_ga() and modify_irte() accept a dev_data parameter and
>    pass it to iommu_flush_irt_and_complete().
> 
>  - The amd_irte_ops callbacks (activate, deactivate, set_affinity) are
>    extended to carry dev_data, so amd_ir_update_irte() and the
>    irq_remapping activate/deactivate chip callbacks pass the cached
>    pointer.
> 
>  - amd_iommu_activate_guest_mode() and deactivate_guest_mode() pass
>    ir_data->dev_data directly.
> 
>  - free_irte() receives dev_data from irq_remapping_free().
> 
>  - amd_ir_set_vcpu_affinity() reuses ir_data->dev_data for the vCPU
>    affinity capability check.
> 
> This eliminates all search_dev_data() list walks from IRTE update
> paths.  For non-PCI interrupt sources (IOAPIC, HPET) whose dev_data is
> NULL from allocation, iommu_flush_irt_and_complete() skips the DMA
> alias walk and invalidates only the single devid, which is correct
> because these sources have no DMA aliases.

In iommu_flush_irt_and_complete() may be fall back to search_dev_data if
dev_data is NULL?


Its fine for set_vcpu_affinity() path as we know it gets called only after probe
is complete.

Otherwise patch look.

-Vasant

