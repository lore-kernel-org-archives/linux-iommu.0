Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A75212564
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005185; cv=fail; b=lnO2u4K8nMBOeb8zRN4ZC/aEnY7RKghhd78FksMqrwhv8xN7tTZ4hPPri3FqhSR6WlQM0mMN2EcDSK8k6pw6rclBxFuQ4CmF1va4FwV6IwdHB4kdvsLoo95ofM12RB2sFWa8mkdPCD3R882g6hBE+yAIi7FkTrQGy15Z8Y9LFIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005185; c=relaxed/simple;
	bh=sGL4lRFgF8VpdtzX6Lb5RA39NcDxYS4+cUSzlwIaXbg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hFmvTzbcq7nsZ0Xg4XjaX6FJlByh5m6kFMIyDCN9/zIUddfpobmZDvjlMRPupjz0UJfVMqF7P7QeVqTIqkTSGzmvfYAQguZj9Ui/g+5OO5wpisveW10ekbJNXVjLQCJLbLX6p9fTpC0hpZGnJckpVWISoi9S8YWtS53oQ+gMlFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gGmmbDeo; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gGmmbDeo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs8pD6SILicaJfL30fj9vVitRLF/wB04VHFr5rRigYlwZKRSoqSYj5n1Jvc6IM+Lvfqjds+Isgbe2cMA+LDrTfXl7WWN5Nsq5v6fRz2GDz/7uQVpEubFCqIFksQTAf6k6i14r58/Wyd9JRNfoXplIZmXPzRHnMrTr/wmwo4dmEjskdlDfK/2YUZkiCKqpnRyuT4+IhIeFFuGioIFAYh/0JMVPLtVhHYQy+fyPfBklwvnV6wn1gvjUFGZYtK6eIPLUynpMqxTuaknBcGSk3oM9Ezr7xyZ6cguqmSHSBXjUhN9ad0txsSzaeCc5k+rnFfs3G1tKQJkemq7CzcBBOl8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI8wneZMJn6EPfgSzViguSkjguS+wQW4qRGady0GKzw=;
 b=kNc3Acv2bRyWxlFAbqawwEelMs8aK9CBmkhUz6LvjG5Li6/ar6yeY8GCHWdPo+kjJ61PGWJp+gSwHxvi8iRWgi0WDauQil1Zc6kUCJygPVuRM/HKUzhvYSEs0t28QkVILJr5JGz/LYv5pwxrWcnt5SlRcajaUURFqSJ2c9x1rLOUjwuzIHE0F/JzG7KAJ329grs72cdCwz9v7vOvGdSo1XUb9MQRu+j7mJgxF5UyqRpe0km5vRQRSwy2KNInL49E8dZLmywTa74XEpN66bAZ/qXdOFB7n1uk5/biGGXX5JVYNID7WPs/cSWZ9R91AWK7aVlc03ohoCt3oTL0sM5fLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI8wneZMJn6EPfgSzViguSkjguS+wQW4qRGady0GKzw=;
 b=gGmmbDeoZgvvQgaKMgzTH1ER3bPamdgcC1g7PNSEnoLI6dV9ertH1MVDRlUMHuuexkxla2gw/hASrdTz9cTG48cbtXwH6plYe2ONzQdbLK0dNlk3qRTUXsXpAOt3dQNG5U+ZsRxYYaBng065fAjbL1GoUGaTn5pYyDV1VjrA7oD1PBcaCoB0zLjUfq28MjlPWmojvkIIKKcIqFg8jXjaorMGtfVj6fYAy2YLwSDk+E53u+Vt3xZQbOrT44rnL8glVbJeTsrUhTKzMSi3p1Hwp2583R3TpAv6Hgr4ePfYEQD5cpmY/Mr8E8DGHMg++dFxei81cXcmUvSvqVEDgBO66g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 04:59:36 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 04:59:36 +0000
Message-ID: <6a4cc7af-65b2-425b-b9c1-2d37a892f3b2@nvidia.com>
Date: Tue, 14 Jul 2026 10:29:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat
 workaround infrastructure
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, robin.murphy@arm.com, joro@8bytes.org,
 jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-tegra@vger.kernel.org
References: <20260713111543.1462161-1-amhetre@nvidia.com>
 <20260713111543.1462161-3-amhetre@nvidia.com> <alUtYqO4HFOmVke5@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <alUtYqO4HFOmVke5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c014a5-330b-4246-31f5-08dee164b3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	5yFO0IBZzwWCgR495qsszZUVohztU1rBo94kjBpfV+F42yeAg/9z/MfUO3q7yIhV1VUoTMvPhtPa6CqqVyXeyJn9Vl1uvxCQgpnX0vr1N+HrIP1xZbVcrS2KIPXX8bgR12bPJKse4/1eXC4Az49W9mhB1ZybebmR+wdGUtWmjCRqEK+j9eDdA7H+1SGC4vqQJfyWvKr1X03qfCFzAnBrG2x/SH4W41pU7WNq5I+bdu1lDnHiQRo++K8UsrGR4USG5qAXS97rWEI0TfH02nDdCgxv5RbIh2XWkTLiM07qoCh2VXgas4UMq3DuUBjUs7LS0/FtIKmJnDCnrYT58kRgORc5oXpbC/Sf4uwM9MDAbofziUKJX9bFYPTJiHd/oU6/N47b10g9hZnnBmRh/xHeTIoJoA9zXSeQ3D0aWJ65wShoug1f+RzYkFJ8bVqVJ0aLWGDVuASV4PhQhvWYPY0ZlNwAzfc3mImoQLU+5iEyxQ8P39glLMa2Qnh2pqqLk3qk3+A5hLUhGfNTZdkQWbgX695SoyWUb2S9mrQeHc8qkkboxHZfkCR0DKNQBUBWCUpWX9F2HApYaj5AfMpL6OTYw0QyZ4HlOci+WRREwDCkogmajYvCTF3yf0E2KiPkzx2BjMW/NoCbiFL2W8+BjEsybBmTwb4NW6M4NRieXj1GC5k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QURJeXJIdHVWOUFnT3RWalZ0eTQvK0dhL1FGMG5PSlpNVGduUGJQWjhtWHRs?=
 =?utf-8?B?WDNNTjRiTWxiQ2p0cUd6OGhtVHY0SXhoeUtKUHRXZnBCOTJEWmk5QTc4YVRJ?=
 =?utf-8?B?NFB6WkJuZEhzMXZYM0RKdDBUeWlYSExmRWVGWHdHaDhzSGlsY0pBNnNPVGo2?=
 =?utf-8?B?L3M1bWFyR1RIL1Y5VU1DMGlWSWpnTFlMR3ZGdHhNS2NnQXhuZ3pEemtBN0FY?=
 =?utf-8?B?eDUva0pWd2VPelVySUtPZVNtd0dpd0NxUERyQW9ENTJzM3hhOWUwa0VSZGRn?=
 =?utf-8?B?N1dzQ2lBdjJrM3hSL1o4LzlOMERSR1poekppVktmY0hWNUR1WmxkWkRESjNz?=
 =?utf-8?B?TnVxZWVnaWtNTFhmTHd2RS9kMzVuMERnak1NOUxwbFNXbHB6NElIS1B3RHNz?=
 =?utf-8?B?K1lGZ2V6cXhBWnI3akcrYmNrQUpGQnZORFowSi9uVG4xWHBncnJ5bERvVVJO?=
 =?utf-8?B?cFlXYzkzUXVNQVcvai9EOEI5ZmFEMkZqK0kxcjFRaDRBai9qSFZud2dMZUJ4?=
 =?utf-8?B?b1V1dUpRSjFNd2FrYkxvb3JKLzg1YVlmQmREbDR2MlNTQ0ppYXduZ1ZHT3ZU?=
 =?utf-8?B?UWY5TnFhbkh0MTZUVXZHSTc1RDJkTVRnWWdRK1psTmNCRkRQUThoRVNITTBR?=
 =?utf-8?B?QkFZbGM4ZGE2cHFvZG9pckVDMVBiYkR1RmVJdmlVckt5ZTI4a000M1o3d1VB?=
 =?utf-8?B?bENxTFVRKzJFVEhiUCtjbFVlaE1uakdLYm5Cczd2WTFOMjNYQzVvQUwxSE9E?=
 =?utf-8?B?d2RiOE9STnBoc3R0UWxTYk9BRFR6WjloRWlFT3Buai9BajBBVDhyY0x4RlFQ?=
 =?utf-8?B?d0hnaWFsbCswOWNSbjMwMU4vVFhpVFE4emxVR3A5OVRCY1VxQzlMdTlUYnRo?=
 =?utf-8?B?V3VncGdvRUo4WDExMlA0QzFSWnRjQmZyd3RmRjNaVmxJV0lna0w0cUo4cDJq?=
 =?utf-8?B?S2ZNQUk4czJ0SGd3UnYvVUZmZE9lN2J6TisvYUtuWkhROFZpVE1PVG1lQW9P?=
 =?utf-8?B?Um1WS2tvWDd1NG9ySTFBTkYzNkl4Q1puQUNpOWl1TTkrUEtQT0Q2Q2FJMGQ1?=
 =?utf-8?B?NVZaVTlrNkJBWnZMYkt6RmcvSUhOVDA1UnY5UlgxQ0hxUEtwQkpNc0hZQ2Nk?=
 =?utf-8?B?SHJIeElxTFNpRVdXMW1wYjJNbmJnK05aV3RScDlXekhRU1hrdFZabzRNMEUv?=
 =?utf-8?B?Wjl5ZmpiNVVIVWRaWm96Y29FU0tPYU5kZWRaRXZPTmxLdmZQNVQ3dlplVnVQ?=
 =?utf-8?B?YnNKYU5NUUs2NGxqdnVnRkFoa0pLV25pTTlaeVhWcVc3ekJ2K29MN0ZjREVp?=
 =?utf-8?B?N2Q4bzUvREpJa1BHbXB1a296a0wzVW5RSGo0Ui85OHp1dDJiZ3o0WVZlVmV3?=
 =?utf-8?B?S0E2cGdQcjBGVHJsN1oySnh6SktoRGovMWd5ZVlXZUJRdnRxK2ttMFJEaDlR?=
 =?utf-8?B?b2ZKNXRyZUUreFUrbG1CdTBJWWdqcSt5OGI3SFVqb2NJdzVjOU9BdmZNSXhF?=
 =?utf-8?B?K3R0eU5GRFczVFQ3UHA2TGdhU2xnbnprb2lQd2pCOHliaWJYMGpoWDgwUjZN?=
 =?utf-8?B?WjNrMU8zYnhWRlRrdjZ3blFFK1JrcW5QZzU5d2o5bHVQRUw2Nm5KT0tWWTJj?=
 =?utf-8?B?UUROOVJ5NTR2VkNzZURWOTIzKzM4Snpodk4vbDB5RDdtL3dzR2xiS09ob1JT?=
 =?utf-8?B?NUZCNDc3MEVPb1BNbEticU5ld05IUEkydjNHVW9rL3hKQ1phL2NrTExsUUVU?=
 =?utf-8?B?clFVS2ZqMlFoMmV4b2JvTEFjd0JQWTRjSDlFTWQ4T1BOVWd3OGE3a29ZdjV1?=
 =?utf-8?B?bCtJUDRlTjZnQUdlTEx3aTZvOXMzNG9KcTQvQzUya2VsWVFpejE4ck5KOUVx?=
 =?utf-8?B?UGtlejNrRjBxMk0vdWMvTjdiaWQ5ZDZFYUZtb1JkcUtjTk5aNDBheWZ0UTRQ?=
 =?utf-8?B?cGtYOW9DZ0k5RjZkb09UZzR6NW43dDFHak9CTFp2YVV2UGpSaTNUdFN1YXBp?=
 =?utf-8?B?NUMxeEFDTTBYZ1Nldkt0VExNdm5IRGhjS09SUnZTdGlGUzdWbGVMQmlZZUlj?=
 =?utf-8?B?OVJ1cnRqa3BvNGNPU3ZPQ0ZWYllEWDN3VGQ3VTdDWVA5SngrdjkwSGdwMVZp?=
 =?utf-8?B?OVpGOU92ZFVqbFhXUG83eHo5WWhiQUdwNHRLN1Q1MldGRU5xbzlEaXlLdGF5?=
 =?utf-8?B?WThWZXd2d1YyN1N1M0NPVHN1b2R2bUFITVExNVNJTUEvRERWS3NQL3ZqMFJ0?=
 =?utf-8?B?QVRNbGl3SGZwdngvQVZrSGxxU3Y5Z2d0VDd3UzIwWHRFbWtDS3h1b1Jvc2NV?=
 =?utf-8?B?VWpscWw0RnZhRXN1Q0xvRncrVEJiZ2hDSzMrcEhwOWR5dE1sUkRzQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c014a5-330b-4246-31f5-08dee164b3c4
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 04:59:36.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tn1rzGksXU+gaU3RE+BpCP1HqHvSLpWV/1yS+lH6f0ntvClkVuDfVuBsnHQrHPT7zV0ILc2InEmDK9HfxFVMJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750



On 7/13/2026 11:54 PM, Nicolin Chen wrote:
> On Mon, Jul 13, 2026 at 11:15:41AM +0000, Ashish Mhetre wrote:
>> Tegra264 SMMU instances need every CFGI/TLBI command sequence issued
>> twice, with the second issue executing only after the first issue's
>> CMD_SYNC has completed:
>>
>>      TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC
>>
>> ATC_INV is not affected and must never be doubled.
>>
>> Add arm_smmu_erratum_repeat_tlbi_cfgi_key and an
>> arm_smmu_erratum_cmd_needs_repeating() helper that gates on the static
>> key first and then range-checks the opcode (CFGI_STE .. ATC_INV), so
>> subsequent changes wiring the workaround into the CMDQ submission and
>> iommufd batching paths can share a single predicate.
>>
>> Rename the existing arm_smmu_cmdq_issue_cmdlist() to
>> __arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper that re-issues
>> the same cmdlist a second time when the predicate fires. Register the
>> new condition with arm_smmu_cmdq_batch_force_sync() and add
>> arm_vsmmu_can_batch_cmd() so iommufd batches split at every "needs
>> repeating" transition.
>>
>> No callers enable the static key yet, so there is no functional change.
>> A subsequent change will enable the key on affected instances.
> Maybe add a small note (better in patch-3).
>
> Note: since guest-level VCMDQs issue commands directly to the HW, a guest
> kernel enabling the cmdqv feature on NVIDIA Tegra264 must apply this WAR.

Ack.

>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>
> Some small issues; please fix:

Sure, will respin v7 fixing these.

>> +static bool arm_vsmmu_can_batch_cmd(struct arm_smmu_device *smmu,
>> +				    struct arm_vsmmu_invalidation_cmd *last,
>> +				    struct arm_vsmmu_invalidation_cmd *next)
> @smmu is unused here.

Ack.

>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index dd7475c50afc..eb8374cfce2a 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -42,6 +42,14 @@ MODULE_PARM_DESC(disable_msipolling,
>>   static const struct iommu_ops arm_smmu_ops;
>>   static struct iommu_dirty_ops arm_smmu_dirty_ops;
>>   
>> +/*
>> + * Repeat every {CFGI,TLBI};CMD_SYNC command sequence so that the second
>> + * issue executes only after the first issue's CMD_SYNC has completed.
>> + * Does not apply to ATC_INV. The key is global and is enabled from DT
>> + * probe on affected hardware (currently Tegra264 only).
>> + */
>> +static DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
> Since we defined a static key, it would be better explicitly add:
>
> #include <linux/jump_label.h>

Ack.

>> @@ -860,6 +900,11 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
>>   	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
>>   		return true;
>>   
>> +	/* See the description at arm_smmu_erratum_repeat_tlbi_cfgi_key */
>> +	if (cmds->num == CMDQ_BATCH_ENTRIES &&
>> +	    arm_smmu_erratum_cmd_needs_repeating(&cmds->cmds[0]))
>> +		return true;
> 	/*
> 	 * See the description at arm_smmu_erratum_repeat_tlbi_cfgi_key. Batches
> 	 * never mix CFGI/TLBI with others, so checking cmds[0] alone is enough.
> 	 */
>
> Nicolin

Ack.

Thanks,
Ashish Mhetre
