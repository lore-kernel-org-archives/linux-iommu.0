Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC81DFE8
	for <iommu@lists.linux.dev>; Fri, 31 May 2024 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135805; cv=fail; b=dnTPVDRvnKw3lAGCSQUZJa9zYlEO7fSUFF6QiA5aJrZwNyQl2vVhTUMzVzMWkwhV60gpHgIJlWzKhymGWDotl+QZkXhAPYsNgIsohBDztl2yk4cwf2qCa2477KO79c94/oMPfqZJRcZ61Hr0I8cNbMTwkSHW9s+placQ6oVFU10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135805; c=relaxed/simple;
	bh=u2JzbRfT7YJb4QWrUH/uF++7OPmSPHbhCF6ClJJMHe4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JFqtLwD/bYtJEcPT+x367VOdI2ZDpKUsKUGo/BSNg/zNgNEJLp3szGtw/buzLpKfui8/brzqQBzoko2BfdgRMm/BLy+x/ZQsWBp3Y5mxdJjx2v7M1P3TdgBk5zn5i32AFYSaEvDRcu4vYgqpXsa53vZ9TVm2+xrJurI8t3fVTRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1QnRsPMP; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1QnRsPMP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBn1oU0sZaA5buDTYKLl1NlxSqJbpdxirK35wLO/5iKTy1+aEG736q075S9nU4pMzUNHo8LjDPPK+jpQYPMg9f4l3wcIsiivrhxkC8q03lUrNA064fSn5tXvos6fS9J1MgtAtbWSX7D7wSNag0bONf8HfxIt8rrSiaMDKPGoeaJqph8Vue2JRGxQxIL8NHzOIm2y9vHcPxb8ALvtBgiu+xPc2hjep7ybUqeD1Vw9224uwsWkUtALduSjZAaCEb6cbSem88oYPK9VZTRkJKNqmojibUbGB27l38+Zlvv2OxVohakWiaNnAF30osIJvESrgkCsKz4m2GSzmlTM8Lps0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/Payp+oAuFbLNLbo9Sa1z+T6X7dsD2+xmGnzCgqyQM=;
 b=SKGqFq24vuDJP9tTOPlC3ElYSQfiQ3Q/HypMnmy3UKZUNPnzNBbHBTw6NhNeRYdYAXIp6106i9E4RFzmLdk9t+TVv7OU8nqmuuTnBefG5/Ii/atsCs9c1Ph3vva+2o/hlX/E3y1y7Of+rlPJuH++L9UMOOMQgzq9uHYxVaZQWlbECTti4ALH/6w6m8x2euPQ26Fjzb37k5MW2+NeIr/FOE9r0nGLqiOde9Uqxi/R5F+YFkvCxnYwLn4XB3WOXO2RzXdauP6jVCov/WxOEz7Rvr1JRkeMMBR4d3ZwEbpGLSjKnVVFsYc5b1bVxnNq1PZK+NjB4uMvYr3ItLHRjgOElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/Payp+oAuFbLNLbo9Sa1z+T6X7dsD2+xmGnzCgqyQM=;
 b=1QnRsPMPBNaU1z2iqmwKKycucXkzLD1m7sNyxceUKuPKfP4GqFAQvGm7SIi3bAPyIgKtULNqv9ezjaZe1LKbI2BBn36qMYPWVlx8zpaeO+9wZlUzjsu+qzWeUXUBc9wouNMVw3fgQe8VSofDUryGlFRbQwWmVt5ekpF3rCFQSjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 06:10:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 06:10:00 +0000
Message-ID: <07b715e3-72d0-4943-bfe8-80a9739eeb75@amd.com>
Date: Fri, 31 May 2024 11:39:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu: Make iommu_sva_domain_alloc() static
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528045458.81458-1-baolu.lu@linux.intel.com>
 <fdc3bffa-7149-48a4-949a-dd469c6c2726@amd.com>
 <cb8f4a3f-75f4-436a-96dc-301b6d65a55c@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <cb8f4a3f-75f4-436a-96dc-301b6d65a55c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 27910867-1cdc-4979-e895-08dc81384de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWJmVVRsUWwzdWZpVnpjTXMzRUxWSHEwRW5Va2ozVlZXaTU0TVJkeldMU0VZ?=
 =?utf-8?B?Y29NU1h5WW9qYlYrSmJDbFFpZ3NndTFlWGdMZHZEeG9FN3o3NTFqWXZQV1R3?=
 =?utf-8?B?aEs4SkxraDU5L1ZTVnNJdVNnbmdWR3l6eXkveXBPd28xVWJELzRDK1NEQU4z?=
 =?utf-8?B?Z0NCazh6N1hRSFN2V1piRlNpMisrdi94OUlmUy9jYllCRFlTMmdMMllXLzZJ?=
 =?utf-8?B?MVRUK1l0VWlibERVMDFKc2pFT2tNZklzejVpSmJUMjJBTHQ1ZlZqWHBTWmpD?=
 =?utf-8?B?dkxwUUxBYzJySUM3Nk0wakNyWFVYQitEN2ttamNLTGxrdmJmZ09yTjRkWXRO?=
 =?utf-8?B?NWNwcUVEc09xQnJQRkpVYjRtNllJUXdyVmtBMVN5amhyQUlZRzM5SUFIcTlz?=
 =?utf-8?B?b2FQb2ttT3JWNE00Yk50dXRGKzVsM01vaWdmbEYwNGZ5RjhRdVY3L284eS9T?=
 =?utf-8?B?aHhKSGZMcGNNVVM0SUl2Q1dDTkV1UE8yYUg3OGZCakRoSnhpOHpnQ2F4R0Nv?=
 =?utf-8?B?YXA0d2tmTS8vcVgrNnE2VHFOeURsWGNobUtaMVl0Skx3ZlF5VXF6eEJpNXpy?=
 =?utf-8?B?MHgvaTlDQkhWVlJOdFBVNy9KckRrbGFxVTJYeDVaUHEyYlFPUm9xbmlRTFk1?=
 =?utf-8?B?TnpFSVBXbDA0MWtHZTJVVWhYRDlPS0VtamFCOXFDUk1US1k3eUJNQ0s0Wktk?=
 =?utf-8?B?eG1aT3NTYkphYUxDVmVHM1dHNytZZk9SUTR1ay9aN0FnaHFoRURPa2VCZU4v?=
 =?utf-8?B?Rzg4S25OcEJDdTFwZVBtWW8ycVduZENESjA3TmtwM3EwT2Zwb1ljZFlHWlpz?=
 =?utf-8?B?M1hRQnFNYW1kaStZckpuOU5yNnFqWUJOSEdhc01VL1p1RjV2QjcrZGNySnJV?=
 =?utf-8?B?VDFEWnhuekRzUUpmNGo2aXl0Y01XeVRTQkxiQ290dGtheTRLcWcwZWhGeVBL?=
 =?utf-8?B?ZGIvK2hZWTM3eThtWUljeURmckl4N0o4c0NReTV4VEV3TzJHMGxUckFaeUEz?=
 =?utf-8?B?YjhNeC9wNlUvY0RuUGFEL1VlbG0rM2xpU0taQzNnUUNPS2QwWjY1WHlpMzFX?=
 =?utf-8?B?cmNWeExmVUgrY2FjN0ZMcDUrLzdCYmMxeTYxLy9KdlNqYlIwMFpNeFdjNkRB?=
 =?utf-8?B?MjV3dzJwTG5hSzFkeVdKQjVoWE9zeEhzdWxyT0RvaE1FVXZicHJNUXNvWmNE?=
 =?utf-8?B?YS9rNVFNZ1pOUVd0T0t2a3h6bzVMa1VoN3RFYmwxQk1ueHA5QldLcVJncFUz?=
 =?utf-8?B?MEEwbnZFUXhGSzdRcjcycU5QbU9WQmduSWdqNHNUVUhaZHo1UUYwUEZBSFE3?=
 =?utf-8?B?U0xoWHE3aDk0YWYwZzc5S0YvSngwQnBad0NwRWFTNnRwamhNdFM3K0cwdEg2?=
 =?utf-8?B?QVlpTWVCTHUySTJML1E5WEFzQ0xOQlFPUFRvQ1Q5cy9ETllsUkNKOGFlS3hl?=
 =?utf-8?B?T2JKRFpoUGV5NUFGYm9SRkNIakEwWG1BREFWRmVtRUZIZFJEeUxCUnZBaUpn?=
 =?utf-8?B?QlRHclljQmlaMnVOM1FFUTAwQUl6d0NMejFSUFI3VUN0djJMSWpDSnFXQWFq?=
 =?utf-8?B?RThxdDcyTW1BYkNxOVJLUm4vOUl1TCtGVkhma3d3Znl2VWp0NWJhSml3azRM?=
 =?utf-8?B?TktXZTBmRTJzTUNDT1AwMG5TVHQrdU9zZE5ieFBmWkxwNkVaWksrNzNtdzg1?=
 =?utf-8?B?bExmQU9sOGZTUC9tWFFILzN6T21ZMVZqMHY0blNRcy81MkV5M09tUS9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODAvNG1QSEdkc3VmdDNjay9JajhUZFdzYWZaYTF0UXNYbnpSR3RwS2xRemlQ?=
 =?utf-8?B?NjJrbVg3dmFycUI4SThZTG5UL2FsWjBabC82a250Zi9GSlRRM2lZdTQyaDBN?=
 =?utf-8?B?WXdMdmR1ZEJCOWFabW8wWGRQeEpzbm1uSytVejJFaTZlOHVkOXRoSE5PR1dV?=
 =?utf-8?B?dm1sN29DWjJ0WkxyQ1VUL2lZYlg2QTRZWmdCSXk5RlFlUE81UUtYLzRnZ0xE?=
 =?utf-8?B?MktJYjEwYmYzYTV5ZEdQNm5WVFlrOHd5VlJtZFA2YXpBZitKaUxadVhzQVZt?=
 =?utf-8?B?aE9QdzdWaG5yWnhVWGg3RGVHZGQxWUVQenlmT2hXZjZDOWtLaUEwVFN1VlUx?=
 =?utf-8?B?akNORWh1dEVxand0K2RYZ2YwQ0RlbmdHM05tS3YyRVRGeEZqUkM4a2VHSTR1?=
 =?utf-8?B?SEt0MWg2Z1Jmc2hLbWgwS3cvYWl6N2tWYjdaU2pHSk5NUGIyLzcyVlhmTVJW?=
 =?utf-8?B?OEpGakd6WjdNRWtTbnFvV3hMYW9Xa1kzaThyb1JiVWdFMTQvWWZFQXptaFZV?=
 =?utf-8?B?UlZONVNrZEZlTkNUd1h5WSt0Zng2SFFNZmo3SHJlem1RaDkxUkNwR3R6bVhZ?=
 =?utf-8?B?NmNaaktYQ1pVOUxsODhLTXBlQ3NuRjJpVGtUWk1pcEhOZW1tbldMdnRCT0R0?=
 =?utf-8?B?dnpzb25wNXpVT21DY0dKb0x3MU53NENUVGp6TkV6RWx6Vm9pT2h0UlVCOG1U?=
 =?utf-8?B?VUJleE1oRGJmU21iaWlqT29TMEtuQm45R1RHbEIzakVxNjBNNG9LaHZDbVZD?=
 =?utf-8?B?blpQYnhoOUFUTXlYRlBObFJRci94VWdLQmUraU9vcDM0ZzBmMGg1SlZyRDdY?=
 =?utf-8?B?dGVHTEpITTVSWHdDUTNLT0V1VjlPMFoyNWZkbmw2M2VxNEtPeU9CMUhLekVT?=
 =?utf-8?B?QVMweEJtWGQ2QmhKQzlON2FYejFIRmcrb2FnNWZEWE93RTZxTmZPMFJLY05I?=
 =?utf-8?B?Ykl1UE9xbmdYWmVETmt4RU9Dc0JoMHVIbVdwZFVFajdFczkzZjNUWG10RVRq?=
 =?utf-8?B?d2RhMnV5bzNFTVFDZVVKejNNcStnZkVVMlNTNTlYZndLZ3pZOHpMSVNMZFBE?=
 =?utf-8?B?K2tTUldJbFBIQnVlOUtHa3BqZTMvdWVIbW9udHJUbG9tVWxVU3AwOVRHZTFt?=
 =?utf-8?B?ajMvODNUb0lvNjNvVDNXM1dndExOeEs0czlzWVpScGthcGw5Qm9TMmNpRXh4?=
 =?utf-8?B?b3FsSGhWamoxWjhsUFJQekZzeUtpaGlJU1lUMUZMbTJudkZKaVJCdk5CTXdU?=
 =?utf-8?B?WWx2TFVOQm1ITm5xQjJRSDRQU3NreERRZmQzUFg3Um5tYXZoVk01dlh5T2N2?=
 =?utf-8?B?SnA4SGtVZkRXOWZ1dmdxUkNFZWNLenBSeDBRU2wyZytYTkFKc3RFUTlvY1pK?=
 =?utf-8?B?WTJsNHhFaDErbHR1VUthbE9nbHBjekZWMUoyaHRBRy9RVmlPS3I2YUMwYlZw?=
 =?utf-8?B?aHJxWTZ5ZHE5eXNRczhSZ1k2eGhMYnp0Y01iN0lkWlJTTm9YMmNTQ3JFam80?=
 =?utf-8?B?TjY5T0ZldU5Bd3VVei9oc1JLR0tWRll6bzkweEZGdzB4V3BFNWYvZDg2N3J4?=
 =?utf-8?B?T0NtQ3dQdEQwd3g3NFNlWkowUWxyMzYrNGFTWFY1aW9Oc3J6VkRJVmduZzA3?=
 =?utf-8?B?K1ovelJ3SnliTjQxNmhiekI1R0VBVnp0aWdNaWFVVnZSUUx4eEhlN2JQZkRP?=
 =?utf-8?B?YS83dEJUdHRXTUFGNnVpY3lhMTV1S2Rkd25oQ29LSVEyZUVNdTZWTldrSks2?=
 =?utf-8?B?TWhIem96azE1bGJwaHRpdnpEenNyNms5SjJESy9xT3loV0RvL1IvZGgyM1Bq?=
 =?utf-8?B?dzRjM3JmZWk2TGI5VWF2cXJwM0Y1Q2h6RTl5UmoreWhDc1VsaXI4R0g5V3c2?=
 =?utf-8?B?enlDNGN4VDEwbEQ0OGMwVXdNNitsZVVpYzYzUjJQcCtwaVB2clo3Y3Fia3Bp?=
 =?utf-8?B?V05mU0NHV1FVc1pzakwyanNOTWtOWkl1eEF6K1dmeE80cmx5S1daaFBMZnRi?=
 =?utf-8?B?U1cyQVhSNlhJbU5IODVWNWRRVTJIMWNrVmVOZTcyNmJsNUYrNXlxdFVFZE9n?=
 =?utf-8?B?OGp3c21YTkx6bXYwV1QwN1NvcE4rTCtvbzJZSStwVE5xTkxrU043bTZLTlho?=
 =?utf-8?Q?iLTRwKzi2S+3/TYrMlUQbizh+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27910867-1cdc-4979-e895-08dc81384de8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:10:00.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+sMu7T3xRyjyui1ZFlZE8Mfq2mZg8gSj76EeK4R/aBPw01uhiTu6LmXYGqZQU8F4xPVQiI7A4TtnBORDT7DVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815



On 5/31/2024 6:29 AM, Baolu Lu wrote:
> On 5/30/24 4:52 PM, Vasant Hegde wrote:
>> On 5/28/2024 10:24 AM, Lu Baolu wrote:
>>> iommu_sva_domain_alloc() is only called in iommu-sva.c, hence make it
>>> static.
>>>
>>> On the other hand, iommu_sva_domain_alloc() should not return NULL anymore
>>> after commit <80af5a452024> ("iommu: Add ops->domain_alloc_sva()"), the
>>> removal of inline code avoids potential confusion.
>>>
>>> Fixes: 80af5a452024 ("iommu: Add ops->domain_alloc_sva()")
>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>> ---
>>>   include/linux/iommu.h     | 8 --------
>>>   drivers/iommu/iommu-sva.c | 6 ++++--
>>>   2 files changed, 4 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>> index 7bc8dff7cf6d..5cdd3d41b87b 100644
>>> --- a/include/linux/iommu.h
>>> +++ b/include/linux/iommu.h
>>> @@ -1527,8 +1527,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device
>>> *dev,
>>>                       struct mm_struct *mm);
>>>   void iommu_sva_unbind_device(struct iommu_sva *handle);
>>>   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>>> -struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>>> -                        struct mm_struct *mm);
>>>   #else
>>>   static inline struct iommu_sva *
>>>   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>>> @@ -1553,12 +1551,6 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct
>>> *mm)
>>>   }
>>>     static inline void mm_pasid_drop(struct mm_struct *mm) {}
>>> -
>>> -static inline struct iommu_domain *
>>> -iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
>>> -{
>>> -    return NULL;
>>> -}
>>>   #endif /* CONFIG_IOMMU_SVA */
>>>     #ifdef CONFIG_IOMMU_IOPF
>>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>>> index 18a35e798b72..25e581299226 100644
>>> --- a/drivers/iommu/iommu-sva.c
>>> +++ b/drivers/iommu/iommu-sva.c
>>> @@ -10,6 +10,8 @@
>>>   #include "iommu-priv.h"
>>>     static DEFINE_MUTEX(iommu_sva_lock);
>>> +static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>>> +                           struct mm_struct *mm);
>> If we move move iommu_sva_domain_alloc() before iommu_sva_bind_device() then we
>> can avoid this forward declaration.
> 
> Yeah, but that means moving 144 lines of code. That's why I went with
> this approach

Ah right. I didn't realized we have 'iopf_handler' in iommu_sva_domain_alloc().

-Vasant
