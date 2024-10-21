Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC20183CA5
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501237; cv=fail; b=kBLO2dzy79jS5JLpp3oQlSm4HcFw7Ky+whSp79V73AZ4DwvsNM/zorNNxiUGfaYGb2EV+5/Jd4VYVTuAlTYSaWqQ5LFJsrGGddnA+gUx/haSYpj77OuBAPzTqyH19Pgx/Z0718IjHhlTXhPk8/03duJl/kZNIQ6mpbVk3EFg2k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501237; c=relaxed/simple;
	bh=C4bGK4GCRqICy9nQlA6RzfsXdfhshSOwFN/C622oFAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AAKNnWSp23QOwDHT8Q5eDv23+PH5NAcjBJ+Qt2kT3HDiAy0uaLE1hlJOM38YtEIo+Uk3x0uXkYWcQYGxfHFywSZ2tgTa5IIqfN9wF6TCrnL/NmoSYsyChl2u+AQMnF4kD/TsOL+3Pt9fGhZGu8WDQk3y3FrKCrRtPqdmxKLcz1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eoAGqN+W; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eoAGqN+W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4yOPrY60wGUTyuRhy3v4K1INKq56Lxs2tOCFjovg/Xni7f1NOWyr3uP24r+ga6RZ2HU++eI+VX/zrXhn5T9c0MwIxqL7fo5pk1vTWQMH7sDcXNj6OJ/wr16mz+o9doSeEZ3Fxnitk3ttD8w5B0bVLN1cq+jOD8F0RonjbU5oIO5mQouM6k4ipjsJy+1CJHZatMiNW9QVhZydRUpfr9ZAiw6s2IlfNWT49JDHrwXInV1RYwUrfjrdT1bNegwao9789BZxsPDG0AcCD4gJ5kVr32iPt88huXkrxm+TKAPSr0l4tjqy+HNvuQ5s8VBXLhPVDJLeZPPSEoxybzK85Ggjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLo+9KM274Vbvf75zMB2+djxZIiX7SdzMJ3DUee6ScE=;
 b=Q9UEwrXOYZiNG9fhiHU1YX9UBt00Hk5+I5yTfIBCozeE5Fl8Tl/B/ID59KdpoJDGFbO4Tw9RHwfmVDwNHDSzTWWQmcYxdkIxgCRnyETiDNKdc3IEa0JKCcRCQIHgCAMeHjALoWXjLmwRSP0Wi20Jx9uw9MQMVsoiZ9SVJuCOgWd9aEDfGkUy+2cFpXklSMF05qgZ7T+MyHXVvjCjRxOOrvOR+MMlsr6R05KIMentke9L342zN8CWe38BNCbZ7LHgSfkzWjfdjuMBDnJXa7/5rbjcNRgu3Vxnxr66wd8MNBbvVEjONQi9UWJ0/G8wZgo161bM1g7jVaK/DptkuxItfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLo+9KM274Vbvf75zMB2+djxZIiX7SdzMJ3DUee6ScE=;
 b=eoAGqN+W7g/VtjS1rLVeLQxMXviahjruGCNMt/rMHnQs19nW6ez9GQDteRoaJDp2o7tpIBOILmXqxWqulSWPdRbOAoOBMXddK5++smVowLkdhi1PHKBUm2sgUBIkNo7AhOfxYHb1LT7blMIxQYaTS9UI9v5Vmr6VroZezKyJrkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Mon, 21 Oct
 2024 09:00:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 09:00:31 +0000
Message-ID: <d490c463-55ad-4416-a960-95dfac46e0be@amd.com>
Date: Mon, 21 Oct 2024 14:30:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] iommu/amd: Enhance amd_iommu_domain_alloc_user()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-10-vasant.hegde@amd.com>
 <20241018142726.GL948948@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241018142726.GL948948@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0247.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e397624-565d-48ee-ccf1-08dcf1aed0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkdFbElseDJCRk0zbTVnYTdZbnRnTml0MnVQYmNzb1BFMnZhbmw1UFoyZGs1?=
 =?utf-8?B?MjVLU0Rja3dZampQWEdGOHdWVHVlQ1hFTW1KVDBKQ1c0MEFuSXcrYlU0WDZE?=
 =?utf-8?B?WS9Yc1h5R0tYMEQ2UnlVNnZOaEovL1Q2dkZqeHk4YktRcDNXaldGR1lOUkhH?=
 =?utf-8?B?WEFDNkN5TWJNL0dvbEVOSFhVenlIUVpwb3Mza0pxS0d2cThOMTBMQmJ0VlFX?=
 =?utf-8?B?MDJ6eUp1VHY0RDNqZnlIM0kxZThTZVViSzFIS3dUSDlPVExrcUNVQnRaVVps?=
 =?utf-8?B?OEJ4NkErMnV3bTNuTXNqYUx3T3ZISEFhSEN1ZW9DdzE2b2tXTUhOdHRBZmZw?=
 =?utf-8?B?Z2xoUjQ5S0NSdm1BSUJ2VFFRRFFSUUFBbkxvZ2svbnEraW5IK1g0WkNwWnAx?=
 =?utf-8?B?anFodW1XcXZLaTduelpjdXlEamIzalNibEdEK1oxRUJiTGxWT1NaSlhFdUdI?=
 =?utf-8?B?QjlyWklzdUhqeXZuaFRzR1hPSHFvY0h6cWgrUkdRVmN2bkJFQ3hTM25aNW1H?=
 =?utf-8?B?RjFua3grajJVWG1VZHJUQnZLUnRkS083MnVuUXdPd1Z5ZkcvNUp5QWFQUVJF?=
 =?utf-8?B?NHFXOWs2YlVUOVpEZ29ua01rbE82aWY0MGNZYzlCWVo4dko4WnhGYmNYckti?=
 =?utf-8?B?R2t2Qk9oL1JMOStWMVRySElxcFZ1TzY0Qy8xaVdpME1WM3pxUEpsaWFZUjh0?=
 =?utf-8?B?SUFDN2tsN04zK3F5YVFXQmY1bm8yRElITFVLWnQrUjVydVd1V2wwL1hwSEtX?=
 =?utf-8?B?VmNkbi9oMHVSdGVZOTVwSG9GVDZSWW9RVWE0STRYRXRVQXc0TmVYOEtua1dk?=
 =?utf-8?B?QVpuR3VWR3h2SUc2QWRCNmdyWkRqemhqd3d4TzMrTWY0OE1XalpJY3lSUmFx?=
 =?utf-8?B?MEJsZkVFbDBkeEtqbVdITXJ1MEhpOW9MU3RmMHB2bkZLbjdKcHYrSWxhVzNJ?=
 =?utf-8?B?LzFLaHU5dzFoNGF1dnlBalgyNS9JUVBrQjhQVXNVaUI0azMzc25jcmFOM3F2?=
 =?utf-8?B?R29mS3pjVHk0Z1JKVkxoN0xETit6R3oxYWNPZ0tEL2FJbVgyTUNqNm5iVTQ0?=
 =?utf-8?B?NTFsSzFmbFYwNnJrYis0WDh1YzNoY0JtUFBOTWJITGlrTmlENWk3bGUreVV6?=
 =?utf-8?B?TFJiaTVuUTdtTm9CdEpCMHU5UDVrWWJBbWgrMjg3dEQ1N1U2dlBwMlhhTlc4?=
 =?utf-8?B?Y0xKYWM3SVRib3NINkY2UFVsTUpOOUIvc21VSWY5VzRmT2NiSjUyZEt1QzBm?=
 =?utf-8?B?T0ZCSk02WnNnYVpaR01iNFN4c0JTdHBicE9hRk9CZjdLR29mZ3hDN0FsU05j?=
 =?utf-8?B?K0xtS0pqT0RDVFlINXN1R051V2lyZzVpRUlCT0RvVzdqam9ZenJISTZvbUxl?=
 =?utf-8?B?V2dyL2hzdkFSakdwL0hjM3VLRkJaMlFuUC9QUTJvcXlVQU9PSWNVdDVCamgw?=
 =?utf-8?B?ZGY0SE9EVitCSEFwWi96WHUzNlVIc3dSRmRFTUFmQ3VkOEkzMDNUV3kwdUpG?=
 =?utf-8?B?U0h3czJ4QU11MnpncGk4YnlZUkw2TWVNR3Z4aFVKMXZiR1JuUXVqZGEzZENr?=
 =?utf-8?B?em5pem96NjdJbXBLdHV0M1JZNDVoYTUvWWV2emtVSkk1elBjdW0vdWxpTnZQ?=
 =?utf-8?B?czRhVFlJejgyVVcwUjhpZGUybWowK3ZDcmlWS3V6NzhFQ0xpUE16ZE11dzhR?=
 =?utf-8?B?MFVQdllrY0lBSXdjQUo5ZWQ0Y0dtbStMbkJpcXlOdXRYUDN2eGpyWjFadkox?=
 =?utf-8?Q?HR5u6+uDcU/vOZr4crdI71U3qWDMA5vtmGpoRBO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXZIVUxyenRUTk80cVh3eTBlalV0MG1qK0FXMzZvTlJHKzlZQmthcnN2SHlo?=
 =?utf-8?B?UXlLWWtUMGk0SVR6a0xDTU45OWhYS1lpc0NZR3d4Mi92aUxHdlcvSjdpWGIv?=
 =?utf-8?B?Ym9mc04xK2NuRkNtejRRYWlodXJTclNSZ0FMcFN2bWw0NmZYdXFvcm5GWW1o?=
 =?utf-8?B?Ujh3cyswVUdzTFFjUXBQbHZkV1FBWU9uN3NybXl1V2tucG5zRy81Z3NoUjRJ?=
 =?utf-8?B?bnA3KzFoZlhXWERDdUMyQTVRcW9YNityMW1FZ0tKcnZBM2YzNkxaU2JaYTdt?=
 =?utf-8?B?U2pUNm9mMExiSG9iN0k5K1dKV1J3WWxhWHA4ODAzK2IrRjZ2MnJSazJzME1l?=
 =?utf-8?B?bHo4Yzc3ekF1cXVIZXVMSzVpTWJvVml0dy90N0ZvcmVZTG1IWUpqbHBXTURU?=
 =?utf-8?B?ZVNjZmJFdk9pT255Kyt2S2UzK0I5b0dxV2hmV2F6NnVGaVRQVUczMkNvaXdx?=
 =?utf-8?B?WmZMK0laZVU0RXVvWGlJbUpIV1FVdkNZK24xRWtGTTBaWHB3QWtyZ3ROclRk?=
 =?utf-8?B?OFZNdHBPMXpyWlV2VnVPV1lyMCtiUjJ5ZnZ3QWFHYnErQkF4NitFdUZpUVN1?=
 =?utf-8?B?ZjVFbVlzNmNML3R1WFhlaFNCOWc1amgzeU92QVlYRnlxbjVnVVhRSStFSHRq?=
 =?utf-8?B?dkxDVmtPVFBrK2VVUTRaOVQxeXpaTkcxMkxyam9iSkNvc1FFWmJZRHRUWGM5?=
 =?utf-8?B?YjcwQWdkZERtTndkK0lmMVVKdHloYlAzN0wxc3lDZ21iMm5wRlNDekdSQS9D?=
 =?utf-8?B?Mk9IOWRYUmpDQ0dEM1IwdXhZdStMamdFTjJRSmRGT2ZPTDlwMVR6QXZsRjgv?=
 =?utf-8?B?VjlPZjE1OGFIem1GWHhJeWFtNUlZQmloaEh5UHVGNFN3TzMrNnVDZW1BOCtk?=
 =?utf-8?B?dUtiL3RhN1FCK0RsYUNYSGdCb0lyQWdtOElHeWZnSHBPWXBDWjdjOTlGSmZs?=
 =?utf-8?B?cmk4VWxPamY1aHVuMXBXUUkzVVI2SC9xQjY0RlkrVndmZEQzWFcvVlZxOXBT?=
 =?utf-8?B?dWY4bGc1bUhad3VUekVRVFhFK0t1MHNpMVBLaGRJRWpvYnZPSUZmUnVWb1ZK?=
 =?utf-8?B?bUxIMzlHeWU3RFMvbWgvM3JmNGlFYnZHZ2xaZFhRVkNUNjJ3KzBtZW1PZVFQ?=
 =?utf-8?B?QStRa2xNQ2lRSngwSElLYzU4Tkk1SUVDdDFEaUE4bnBJNldaeWxLSjJCdytI?=
 =?utf-8?B?aytkQlpIb0NpMWswWjB3WlNWL2wrZEZkaVFQMEpXdU93c0FVb1hMem8wY0h5?=
 =?utf-8?B?dWZld0swOXY3Mi9CbC9wUnZIREE0S21CZFpXc2lrS3k3enAxTXpyaC9yS1hS?=
 =?utf-8?B?ZFo5V0hLbS9Ja2V6REVNb1hudlBmODJHZE82M2xnZ3hxalJ4Z01yNGtTTVhP?=
 =?utf-8?B?VXRJTFlEbDlNcThSWHN3WU9SU1M3bGxxYjRvaHlZVCtKVCtsNDh4cWY5WFd6?=
 =?utf-8?B?dG9OMDJyL3VmNjdBSnZoQ040SnMvTGkyRklnZ1BvQmFMdThxOTh4TWJtdUZT?=
 =?utf-8?B?amRFdFNETkRYdExJZ29ZcUZhMXhyRjRoZnRsMTVWWnQ5VllXdDVRUVQya04y?=
 =?utf-8?B?YmpXTnFld0V5aEFlYW8xdHh6L2FlVjdJNzNCWWFKMGViaHBjcTZQWlZKR20w?=
 =?utf-8?B?WjZWdVQ3L0FqQVloc21xSFFVVzRkTUo3M1NVZmVFMGNOelI2QndwclAxbjVX?=
 =?utf-8?B?ZklOM2Fncmc2ZTdtOEY3Tkt3S0xpQzRQOXl4dWlZbUVWWjNJclUzc3NFYkpJ?=
 =?utf-8?B?SUZGcjd4OE05SGFjM2NQb05zdk9VbGZPRDNYb2xiYXV6YW4ycXVxOWtacDFh?=
 =?utf-8?B?SkRDL1VzVmlodU5LdWhyWHlrb053RHZJOVhST0JzcU50bTIrdWZUcng5alJ4?=
 =?utf-8?B?RlBwNEVSR1FObGl0T3g3N1VkQnBTamt5OXR4US9xVkJ6TTBTRTNDV21EY1Bz?=
 =?utf-8?B?QnMwZzZPUDJGRDdmVWt5YXp2Ny9lS2t6NjJOSGxSY3RqWTZWeE5yWkpWbGpF?=
 =?utf-8?B?aUVvU0VJZzQ3QlRpRGNlQkRNa3pLc3hxcU9JTTc3ODZSYnlUVjhGY0dhYmc0?=
 =?utf-8?B?T29lamhkOElaa1JwbDFoUHVEd1ZOOTBoSCtoREc1QkJJdDgyMm5JZXZsRU5X?=
 =?utf-8?Q?NwkpjBKiuEoc7GVePjGtyzBXO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e397624-565d-48ee-ccf1-08dcf1aed0c0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 09:00:31.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SSytb2mzQkNCWIuLyFuf560U2iI5zpfj2Bz80ABjaOoN7nmRq0Q2wB10hTpwzr6tBvAnOUvG2OfcUWC6dCA2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355

Jason,


On 10/18/2024 7:57 PM, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 02:01:34PM +0000, Vasant Hegde wrote:
>> Previous patch enhanced core layer to check device PASID capability and
>> pass right flags to ops->domain_alloc_user().
>>
>> Enhance amd_iommu_domain_alloc_user() to allocate domain with
>> appropriate page table based on flags parameter.
>>   - If flag is empty then allocate domain with default page table type.
>>     This will eventually replace ops->domain_alloc().
>>     For UNMANAGED domain, core will call this interface with flags=0. So
>>     AMD driver will continue to allocate V1 page table.
>>
>>   - If IOMMU_HWPT_ALLOC_PASID flag is passed then allocate domain with v2
>>     page table.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index cb6a72564c23..87eff85c0c23 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2404,6 +2404,20 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>>  {
>>  	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
>>  
>> +	/* Allocate domain with default page table */
>> +	if (!flags) {
>> +		return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
>> +					     dev, 0, amd_iommu_pgtable);
>> +	}
> 
> Extra {} ?

For multi line I preferred {}.

> 
>> +	/* Allocate domain with v2 page table if IOMMU supports PASID. */
>> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
>> +		if (!amd_iommu_pasid_supported())
>> +			return ERR_PTR(-EINVAL);
> 
> Depending on what we decide this could be
> amd_iommu_v2_pgtbl_supported()

Sure.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks
-Vasant
