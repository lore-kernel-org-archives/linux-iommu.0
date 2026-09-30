Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F374E781D;
	Wed, 30 Sep 2026 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774801; cv=fail; b=R7ig+r1IkYUMBVD0lSk9dYqnKttAm7VSOYOsOnSmU84rbk6ie+uC/FICpyJ8BH9IINFV4aTwrwxmfQCJ6cRbwQbpv1hdx6sOgQ/K+cvHxlzOhm8TZDvNKxxylRCBbFZzSOORgVbqP9IZ93Z6JX3+L1OO/oRXw8GXBJy1Eju+S6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774801; c=relaxed/simple;
	bh=sPg5rI4EMbDKJ3sZp1t+gk4PRlvuGRdRj1MuucrpBCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LbiBSFo9VNPHqsec8DuN+SlTZvdIbF5v/zr4ozqilW1bz6jYBvWrjMyM/L2uQMe9bpvSOTD1WIETE0aJeUQU75GZvSii/6Fes02WtSJx7QS6Ttickfe5cark8Bk6Jt2kXlzPrfZHbzuhRHOW1N/fGkfwVmKwceGMaEchpLxsDE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=02jXwgXn; arc=fail smtp.client-ip=52.101.53.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="02jXwgXn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVtA+bZReSxW2Yfcr0IiGJkA2AbfMiGqwjZzYAE1U7nCPKd8gTQ83TvgswqwSxp2a6wtJRCi0gJUy6S6RdXxktl+GruCRoYEQt12yDALYrMnB9RgDLgkEtymedgTirORx+pmyJ3EBvNJHUXKYr9HG3y41TJnZLiV5C99fK54TFaBXF3uoCY6wnPvzrfKkat1Lqi23VqlNaah3ooCdXupFD1EH0Q7AFMpoWuMGrsSDinSHzrEJiJVgVEUTpAatRVBRI3aKPS33oytgRtXmnZQXEafOwxm84JE/6J35UvYOqKDBsyigBckfwTGHtr+/NQYAyRf6jBiHfJnVt4nCeXBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ3WfWCyHifBzcnnZ/2CMiXd+PUCU+EFbr45GXGSdZY=;
 b=OHnVEE273rwi2jwL1m8CI3Qt4SCGV1doYepEyyT2Ob51j5f5SNYsuXmkk1sjt/t12/lW1J5NFODWImIeXlvnybbwy0rT/YQwFyNsuJbBZOEjy/9ZOtx0X1XCuEVBns9rikMR9BEoiQG1++2ohsbhc298ThQF3He62Q4e/IW7RqnxthCgTHKzmqNmZhruTLMcIVroPZMCsf0r/U76kmxjkG5eIQWeRRmvxaqqzAFIjEPgwHHYyjlgl5CY3H3pOyL/PNB00EYFpZjVaVlSRWYTaXBF8KVcCCCQWmrJmORxG5dmkz4y37Jc4PlhIqiaFMWZicRX/KjjVHedHv4lc74nkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ3WfWCyHifBzcnnZ/2CMiXd+PUCU+EFbr45GXGSdZY=;
 b=02jXwgXn9pN88ss8lPizjn6jpvnrQrs4wpHOZI/K9RuaTpep2wHFefYpBNvWhmyPp8bKu1ksm69pHpHc3FfC+DfnuGsgKNDLQCXklD4u8BBgiDcoWtgUPzx4nDPemQidlGPeZppwTowI2RNjDl4q0jlq0efPCa57ei9VVWdV7So=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 13:26:16 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 13:26:16 +0000
Message-ID: <012d7ccd-ecc0-4105-b386-d83508ebf891@amd.com>
Date: Wed, 30 Sep 2026 18:56:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 09/11] iommufd: Add the vdevice TSM request ioctl
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
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
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-10-aneesh.kumar@kernel.org>
 <179027891417.104879.282447770434616733.b4-review@b4>
 <yq5a7bk3upx6.fsf@kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <yq5a7bk3upx6.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0279.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::11) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 017d2d58-d9f3-4b8e-ef79-08df1ef667a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|4143699003|11063799006|10067099003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KxT0qeBjRTuzaP5ZKYhKRubP2lTQBi9DY2tVJIYYi4m/P7iI+nikxhaqdKEjwRocUgtOoh69m+4zeJKXsM3kOxeFk0zA6AiGniby30erAWa7KCi/0agjzKXRiLrxRws/vRCygZTyhMw5wS3NcZ/PtLp0l4DODIGByKRJEZHcO5BXxHvViI1ZFFXmw4ai5jPCdfDuT2Aih1pMgL2yt4vIxpiaSPEVH9CaATB9L+cvvSQ5FHIxi8Yu4Qm9c4O0SM30ZeGQB1c9thSrReB5wLL9g11HDLcsO5XzTq9mP6xcwevUwjqe5j/KxlQ/0z6ZMLD+Q3fiG53b79D4bVBx4qe9RIoFPWXYlCxWnSrHYIAP/TBGo/AemVxUtLZpGsIJqrwsQ5RQg+e2cKpvP9lZ8zosDSXwpABQp7TBS6VLM6DkG0He0WKWGrjJ0GLSBhnPhSU+RRPtPrrnaqQ70GYPzRWYHzXa3XnOguNRVV9xkaL2YbAx9tmYpXebp59DTY+MU1Ss236ucLr3COxzZXTyrLAk+FBo0DsqAAMFhlznX1G+n6oSTqRmV7LRbFvccBxi0vifef4msOjz3CudhTf6KlyrtR34KmT10lw17wGWhfM/poRY+/cZLkCXCZTRNPmzQqCKcZbXny2L/riwc13uG+tIe7sw40rSEjem5P4CWCGdbQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(4143699003)(11063799006)(10067099003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnE1ZUN0ZDFVOFk0QjlqSyttVHBxVVJrbW9FZEcwNUVEY1pSOXEveUdyTVg4?=
 =?utf-8?B?bGJXQmx5Y3B2RlFLVmZOS0NwbzQ1YjZlOGhtOWJPTm9WOHU5bFJiN0Yvb0Ry?=
 =?utf-8?B?bzkzWEF3RWFqN0dEWTh6RUN4ZkUvbmpWQXl4eVFnZlEweEcvenRWS3hEckdR?=
 =?utf-8?B?aGlNMS9pOWxKWjdTdXhtWCtVZ3c0RUVQQ3NSOC9vMG1BQUNmS3NIaG44b3c2?=
 =?utf-8?B?QVczWks5TzZBVTVtZDBqZHNZSzFnVDhvdE5QU3RSTjhJeWVPckJiYm9wbjBj?=
 =?utf-8?B?RkRxWnEyVFdRdVFTVWwvT29WZ29aZ1VlYldYZnRCU1Vpd1NURkhQVG92dDli?=
 =?utf-8?B?cWp0SDRqQmg3d1g2M3BsdElDYStwWlVlbEFhWEUySVBIZFFyV253bmFTS2tk?=
 =?utf-8?B?d0hqWXJvUjJWckRzaXh5S2dYdldzT0tUczJXL2pDOEJiS3k5ZjFISW93Zzl3?=
 =?utf-8?B?dlVQV3lOQWs3TGlpSnBVb3RzVmFPWU5DWVAwcXFFdlIyOFFaNFNHMzBmc2hM?=
 =?utf-8?B?ZjNxSk1HTERkbjZMemxybVBhMm4rNlYwdFRndUM1NWNvS091Slg1RTYyNmNQ?=
 =?utf-8?B?amFhT2dXUmF0Q3F4UTRjTUZqVTdSYklUWGV5eWR0M21MREhUVnMxd2FtNWwx?=
 =?utf-8?B?dTBkamlhMWw2dGl5SEJrbU56WVFRUjRYRGxxU0RCYWsyblh4VjJYbGtPK0Nj?=
 =?utf-8?B?K2dNbVgxWFBma1N5UTlrN1d0d05tc3BWcTNOV2VBZDNFd1ZSTk0xUUxtRG5H?=
 =?utf-8?B?VThFSkxHNy84NGExUHAzbHM2NStIeWVvMDlkT1lTR2hOSWFYMHJzUmZ5anFK?=
 =?utf-8?B?TUIxNE10OHZvWXVZQWdHOGI2UTU3MkJnN1p1V0F5QmVBbHdzWFoxNnBjNjlp?=
 =?utf-8?B?M1RkU3ZaUU92M1kybkVYdnhRMTJhL2Y4dGh1UW91ZzA0WVMzRURvOEk0TG42?=
 =?utf-8?B?aU9XRzhiS2dXem12Y0loYUNRZDc2Rko4Zlo1MnNmLytHM2owUmNUbHlORFdl?=
 =?utf-8?B?MnJ2cGdzWUxaYjhmd2NCRE5McGgxTjIwQ0drQVJ5VTl0UnFQWm1NMkJGZjdT?=
 =?utf-8?B?OW1nSkROaVpkR2dCU09QWEFNMzg3bU8xV0NzbnZvaHJLaDUxejNta3BzTitE?=
 =?utf-8?B?dUVHRjNpQlZSbWxqOU1IT2tFVjNhbFhuaHJtSjVsa1gxcm5ZNjhRay9PSE5k?=
 =?utf-8?B?UHRobE1VeVp6cVBiY1NlRCtGWTVPcFREMWROdHVSd2xjSklDQk1ERGd3ZXVa?=
 =?utf-8?B?TEErQy9KOGhDcVlUUnBwVVNPMEJUTTNJcmRRRVlRcS9VVDFnekpBTzlBSVZV?=
 =?utf-8?B?czNVRCtGR3lCQVFHYjdPb01wZXFhVVdhVzc1R1FZaU9lOXBRenN2clpReGsz?=
 =?utf-8?B?Z2hSdVhOT1Bpb0pZR3h6ekw4U2NuOU9nT3hDZFEwb2dHT3VNMmFTUXUxVTlz?=
 =?utf-8?B?UUttRzZjMDRxa0RySElFS00xNlR1d3NXc1pqeWV0S25ZeEtUdkQ2RHk5ck9i?=
 =?utf-8?B?S3ZRbHhXMVpZYXRwSVk2Y1N6cGtLTS83ZDJDVThOankxME4zOHJhS2R5V2Z3?=
 =?utf-8?B?dUk1S010TjJhTURUV2ZXTTdYdC8vSDJYaStEOW4yMllwaVFDV3NkVjhJcVRZ?=
 =?utf-8?B?bndKWEFYZjNpczBxTXQ0RmlYbUlTWjhLL2thcTJGc0R3dkhsTHlBZUJxS1A5?=
 =?utf-8?B?aS83QnRROXNLeUppMFVPeGNlSlZxRUZPdjJheUx4TWVud0k2MVdvd0RFYkVs?=
 =?utf-8?B?RGl2UDdhQVVRckJvTytBdmthTU9jWkQydys3U1YrY3dwaE5Pem1nTkFsSkJr?=
 =?utf-8?B?TVdyMlZLZVpnTGlEbnY3c1lVVzVFSEVsNWpsdFc5M0VJSVQxVExXZUVHa2hi?=
 =?utf-8?B?TEd3ME85b1MxeSs1NU0vNEtxSTlHOEF4M0F3UHljalVVWWJzKzFRVWJDenhH?=
 =?utf-8?B?NnhtSlRpQzZwRi9oamdRN3RnSHVTMTNyYjVyR2dEdXNHelpJWG5EdytPYmJu?=
 =?utf-8?B?RlJ1TWQ1SEJyejdSMmJMdnludmpZNUxnZ1BUbVZkUHY3TE8xSGJRcE1kVFNF?=
 =?utf-8?B?aG1NTU4zNFJYdVZPSklQRnlJeXBmdW1FblNSaEFVeXo0eGg2S1MyN3NwZHZl?=
 =?utf-8?B?Q1VFM0paM055Tk8wd2hGUVdsNWx2S1lNYWQrU3VXaGNGdmh3VFBwKzk3bDgv?=
 =?utf-8?B?RXk5cmJsWjdBRFNweXpHOEllQ2w4a1VGdjByQWFvM1dYYzFhb2I0c2hhVEkx?=
 =?utf-8?B?cGdSOHA5YWk4MThMbDdpNmJVMnNwM2RZWE0vZ1R0ZjZPUEJRUkd3c2tQZno4?=
 =?utf-8?B?WXZMUmlKUCtWREQwQUp5d3ZOY1QwbmtVeDhCa2tPSk52S2hPM0lrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017d2d58-d9f3-4b8e-ef79-08df1ef667a9
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:26:16.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2/mL71dREU7frVnSuoE6j0m8tUKi0oPLRrRnno1VBDE+G+8rvDrmxzA8h5iG/X7AOzhxMnY8PWBX403t870sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974

On 9/30/2026 1:33 PM, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 

.../...

> 
>>
>>> [ ... 34 lines skipped ... ]
>>> +/**
>>> + * enum iommu_vdevice_tsm_guest_req_op - operation for guest TSM requests
>>> + * @TSM_REQ_VALIDATE_MMIO: Validate MMIO for the TDI
>>> + * @TSM_REQ_SET_TDI_STATE: Set TDI state
>>> + * @TSM_REQ_SEV_ENABLE_DMA: Enable SEV DMA
>>
>> That seems wrong.. The hypervisor should not have control over T=1
>> DMA.
>>

(Still catching up with entire thread)

In case of AMD IOMMU, before allowing DMA from secure guest, we have to update
IOMMU host (nested) page table entry size to match the RMP table.

-Vasant

> 
> This was added specifically for AMD SEV, which requires an IOMMU-side
> update to enable DMA.
> 
>>
>>> + * @TSM_REQ_SEV_DISABLE_DMA: Disable SEV DMA
>>> + * @TSM_REQ_READ_OBJECT: Read a TSM object
>>> + * @TSM_REQ_REGEN_OBJECT: Regenerate a TSM object
>>> + * @TSM_REQ_OBJECT_INFO: Read TSM object information
>>> + */
>>
>> These operations will need alot more commentary. Use kdocs inside the
>> enum below to make that easier.
>>
> 
> 
> I will add kernel-doc comments for the operations used by CCA.
> 
> We have gone through several iterations to identify the guest
> passthrough request facility we need. IIUC, both TDX and CCA give the
> hypervisor some control over the request type, while SEV-TIO is more
> opaque.
> 
> 
>>
>>> [ ... 10 lines skipped ... ]
>>> +/**
>>> + * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
>>> + * @size: sizeof(struct iommu_vdevice_tsm_req)
>>> + * @vdevice_id: vDevice ID the guest request is for
>>> + * @op: One of enum iommu_vdevice_tsm_guest_req_op
>>> + * @tvm_arch: One of enum iommu_vdevice_tsm_guest_tvm_arch
>>> + * @req_len: Size in bytes of the input payload at @req_uptr
>>> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
>>> + * @req_uptr: Userspace pointer to the guest-provided request payload
>>> + * @resp_uptr: Userspace pointer to the guest response buffer
>>> + * @tsm_code: TSM-specific result code returned by the TSM implementation
>>> + *
>>> + * Forward a TSM request to the TSM bound vDevice. This is intended for
>>> + * guest TSM/TDISP message transport where the host kernel only marshals
>>> + * bytes between userspace and the TSM implementation.
>>> + *
>>> + * The request operation is guest initiated. The TSM backend validates
>>> + * @tvm_arch against its bound TVM architecture assumptions.
>>> + *
>>> + * The request payload is read from @req_uptr/@req_len. If a response is
>>> + * expected, userspace provides @resp_uptr/@resp_len as writable storage for
>>> + * response bytes returned by the TSM path.
>>> + *
>>> + * The ioctl is only suitable for commands and results that the host kernel
>>> + * has no use, the host is only facilitating guest to TSM communication.
>>> + */
>>> +struct iommu_vdevice_tsm_req {
>>> +	__u32 size;
>>> +	__u32 vdevice_id;
>>> +	__u32 op;
>>> +	__u32 tvm_arch;
>>> +	__u32 req_len;
>>> +	__u32 resp_len;
>>> +	__aligned_u64 req_uptr;
>>> +	__aligned_u64 resp_uptr;
>>> +	__aligned_u64 tsm_code;
>>
>> out_tsm_code
>>
> 
> That is required for SEV-TIO.
> 
> -aneesh

