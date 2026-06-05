Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BCE1E766F
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668757; cv=fail; b=U4uUqMMcQ9oVNjZCWwwIFpvwOHrI3jXBCLB3SLhXB/z1IX2TcRxTfOa5A+SnLBhfl64S/6qO4RKKhPS61EG5strjahRgZ+4E4LjJ/+nxYYsDMDMFpyZsREmaT/7jfTkiFxZ1bFQ/Rgp6co3HJkoV6aCIn89fwSQowqhhYAd/c1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668757; c=relaxed/simple;
	bh=JtC1mLK9y5ZfANV1m7exV5CUPCymkNpfv1Mqhkrn2sM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YLhToJAYt53bW9sIxPwqZL1RN+HVp6rGyAgpGoQDeLVWHAN0GbaJNlMbMHOr2IDnlqo3osREbVDEjAS6yQIRxioJslQPuX3ysrFJqXShj8bGShJRssSp195WBU3eIIbnJFLQ5GStV6yQGbMS3THnLXd/7uYRruS2TxdnigK/8AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oyA95aRb; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oyA95aRb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+34I2iqKxcM075A+BNF8jdudHUT7K1Jkd7NKPgs/o18hXYdbYET0S60PG0LxjgAahOt0qsPf0EHNYu5xpQckCrFWEqwzaYEHmVKBZxtuWr74pCCuLno4nZCim8EcOZ67/snb9+snRK4Zt6qLXvuHgjf7MDf31k7oP75ybALn3QtZIb//IZSO6Pn3UY0SRY3vhmJNg/szeTHfHhmMk6PNXj5Ff14JoR60tjVmZrX9L1oCUaYkgFmm1G6Qr1aA7mmcFXSvDuDxuOj1YM4o1oDL8GqxILgytl3c08sjxJczhWKvr+Z2rFKHJQYpuZglrIdkUnMb2CMuXXiDf8OiYlMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTmfE1M4owI4yoAChBA/kJ3PXX7zegiimFE3uQzGAZY=;
 b=rpEqMX7LJrE29ECT4gBdALVQmIadBDkfm1bXv9PIBb9dAeBXhvlZlBHc6ckZvUUkc0O9EhDAOMt6MK8pvHeAFAka3pIXlCKDr+Ej/I8FUsBHjI1S9H4IPE9FDoqmNR+gEqzxmxk/+9aVu1c1y8jwlgSKLfQllll2avxG5NtlVYF2UIB0xEeu/NhJQCQg5uLJF0wnb16EDPVR7Ndtm/uVW5igrEJetHC5GquOGpB5v01Tksp9QfpAt9A398nM7VXFU7rvpxdE6bdbRfaeBdwqHtzzwyUIsTkZa87LqdoZPNnF2Qrk/LKtl+MsSR1h6A0iGAkVjbsg31oSRBMzga2PtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTmfE1M4owI4yoAChBA/kJ3PXX7zegiimFE3uQzGAZY=;
 b=oyA95aRbMqb3LRj4GVpCs7ZGOaaIkYqrtbOeI74kjESVfG+UuA8BfDLn+GBmrCAqd4ydScy69WKGzwQ3xaQhZBw6dQiZyvNGZ2nZeROEZARhP03MaRILnTflddwsJfQn9RBps6vGyS5a2ExcCCtj//tP6+0AtFEkY1sU/3/abPSlc678W+Mzn0MyYIDZqr/gOA+sCA0U2cEQyILi5p7WloH5nlmVNBe0nuxo0aBtUN9S+16mOzAIFdaqfFOh4ELqkFljbtQSzsLN3LHyAD0HIIDnMlG/VREvbeBq6fpIS8CPpQdrgCtn8p+meEjGuqxFfLrqNuAV8DxvYLFJomnJKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by SA5PPFD8C5D7E64.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 14:12:27 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:12:25 +0000
Message-ID: <175ff82c-d3ec-4259-a933-23b8d754233c@nvidia.com>
Date: Fri, 5 Jun 2026 19:42:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on
 Tegra264
To: Will Deacon <will@kernel.org>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, nicolinc@nvidia.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-4-amhetre@nvidia.com>
 <ah87dzHOOTNGBBmt@willie-the-truck>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <ah87dzHOOTNGBBmt@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f290a7a-4b12-41fa-8418-08dec30c77d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|3023799007|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hu4+JT77HFimnYx9RFaEfUjr+skDCtsd+tqbwe/464ZdAz/yXlABxzek3VVoW56e6gRfdM2Djl68Lo4Pm17Njow7BofguZojBwWSfE5aVv/XXz9K//KgNfFQJTFS5+0iY8CKX3SgOWShcB+EkHDgm96OHXey8ItFLJbUk6R1oESSXku6GWrTexI6oa/r7hsqSM93kbOB05mPhTbm7b7B+mYuh/y25D/BDFl9nkJk83OWA5ThMcB3/qO9xDjpiZn2dyliAxAGm/uyMU97uXglP/Ch50m0HHVwQHQzhMfXiXSPInUiDBUfHOHD6THSQ/1JTMyU57t0ysPqMHE+3+whLybqqYRP7NYHjIyD4maq64giVrMqtHVDdQcggyTRm59QP7pYqZHnSrfZYi5aOlQg9DP8y1KcGtmdOASoDeQc2ESxWwAoUMPEMJhbGQOUh7FB2hE0wdXIDU9kB7F7ijeEXGsv1yykKz3hS7mHTIKge86Wgo0RL6Pvy/K08tE9qaUDKQEEaM3bLJL84+rJTkzJPkx6Pt8GVmuh/z1IZS8oL0PZ+/2YMx6U6doDRMM1XwTgEVs792AZMDGsluYU/uvWRlamI/b0E0KdndbmNTbkx8PO8axc3/to94VNIz+l3s4BHrjoLfLzbYX0YAhhrO7KP0XcbqgvolJE/RgrpeCkpP3lS9yusyOa4wRKEvVv8vwr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3023799007)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0N3R1R5ZFU0dGw0VEFlMUdOKy81aGxXT0k0dFlvYWFqL0lyRXFJT0x3L0NR?=
 =?utf-8?B?cis3MVk0SGg0SmJvMDc2alFFM1dER3d5TW03b1VZSmtkWVU3Rk5vd2hEeDVx?=
 =?utf-8?B?N0lwcFhsRVZZeWlQalJ6Sk9rdHJRZGx1enRoYnJrU1lqaFNmNmh6NGJHSnBw?=
 =?utf-8?B?R2svYjlYL0J6VnAvR2o5RXY2TTlWOTJZd2xkQkFsclA0ZGNGclQvMGQ5TEFG?=
 =?utf-8?B?RHg4MnVKVkV4aCtvU2JZT01rcmR2akJ0SjBWOGdrbTNmODM3YmxRZUFPZDJL?=
 =?utf-8?B?ODRLWGx0SVZWalVNWlNxOE9IamdrbS9oYUk3UVE1bXl2WUh5clNkQW5vY0px?=
 =?utf-8?B?Yk5JSGNpdUp3dXlnczRqUytYNnNHTVY4UjF0R1ZSRkpoVFJldkl1enYySUt2?=
 =?utf-8?B?c1dyeTdacVpnNm1vcm9CQm5EcTVkMGx4OW9xdkJ4dXM1TDkzekR1ME1EM1pn?=
 =?utf-8?B?YXdwUVNMWHdJVmZoS09tcVBiN3kveGR0azUyaG5VUHhhMVJmaFZ1b0tXKytq?=
 =?utf-8?B?bk9HZjg4YW0vT1NyV2VEZzlvS2dJcUNESHNmUEdGMVJITTdQY0ZYOTZNaW9O?=
 =?utf-8?B?ZHBEVWpaVUJsQ0lvcTI3em1mRWsrMlcyQ2pZVHg5TjBjSlJnOFJqakhsTmJV?=
 =?utf-8?B?TFM2TXpBenlzUHp1Z1dKVUtnVUlBTWNLMC9JaXQyRGtFODVWUWl1MjErVDg5?=
 =?utf-8?B?LzBoSjlXTHAzMU15NmJwbkI0Q2huZXJONEUxbFBVZXZoUENVbUdoNmRZcWwz?=
 =?utf-8?B?aVNwQUhyY29JNVJqNVJaeE53N3V2cVFyeTd5dzdyNjZURURwaDF2MU1jUEQ2?=
 =?utf-8?B?eVZFNWJyQ0d2S3l0RTFyTitzK1VPaTNYME5vNWh5amN1OFlqODZQNlNLMmNS?=
 =?utf-8?B?MWJLOEFrc2xWVm4wZHV1cG1qOVhqNU1rS3NrL1RiRWkrbzhLUmdaNHk4TDhu?=
 =?utf-8?B?Z3VNRkJhZFNRYVc3S0RlaUpTdlBGdjZKSzMzODZOdTQ3TW9aZnN6cUh5VEJS?=
 =?utf-8?B?MjZpVFVVSkNINUFVejd1SC9EUTNnTzh6S3ZzczhpNjJLbC9TMm9QUmkweWps?=
 =?utf-8?B?MG1uUkZKUk1Kc0xZSkZCelA0MFFuY3RXUWlSZG5CYU9BajlRckpHbEpvRS8r?=
 =?utf-8?B?N3BBcVNFSDRvaXFEY1RMM05CTmx2aWtLTm53bFNOVVI1UXZUVmljWXZoVkN4?=
 =?utf-8?B?c3g4bFBuZXpSdlVxTHpaR2dXTHhPdXhMQmRBdEZUVFhGVGtzeUg5aDVsY1pr?=
 =?utf-8?B?a0JaWFpoM09TbkEwcythNmdGanpYeHI1bXFmWTRNWldoUW1XVHFLY1ZhR09w?=
 =?utf-8?B?cGlvYjRQMlVLQlR3Zko4dEdPR3V3cG14TEZ4eFB2SHRhdlQzRjNOQU5zT2lT?=
 =?utf-8?B?OGM3eXlCZXhXbG9hdHNuVGpkckJIUlozYXBacTF5eEVjRkh3UnRlcWpsZHVk?=
 =?utf-8?B?VkpIcDlUOHZkOXRUZ2RFSGppWW5EdHZCR0xxeTEzTGRDbUtKTTVXY25Jd212?=
 =?utf-8?B?MzVTRTJTS3NtU215NE5HcmdQUHhSc0VQM0c0ZmJWTTZlRXRMU1hqdzBOVG81?=
 =?utf-8?B?NEhiRzl6NnhBOGpyZHRKOEV3QnpHNUNWa1ZpQ0ZkTDBFOTNDVFVwaFdtd2FP?=
 =?utf-8?B?bHR1MnJZdmwxVDRIL0JtdmpLc3RNdG1ZYVhrMUtFVkh2RkxuemlraXBkbWdu?=
 =?utf-8?B?ZlFJdU5UT2JJVURlYUVwWTNXUVBnWEpxOVFwSlFqdDlBWG52dG1sVHJ4T3ZS?=
 =?utf-8?B?eWxvN1Vpc3dVZTV1bFQ3NjF1eG5IRmRpZ0diL2J6ZGhjSVRMUXQ1Mld3ejNK?=
 =?utf-8?B?cnA2ZWc0Z2ZZeng1ZHlacmxDTFBSWURidWFMYUVLWnlFMXJPSHRXVXZaYUhM?=
 =?utf-8?B?OUNiN0pkSm94eDNseGFoZDg1aGJCS1lCSFdXdVM2dnIyRGtHMStKZFdxaXJm?=
 =?utf-8?B?bUFaSXVZNWl3Q2QwSi9VZWh3Y3g1V21IMUFoQlVvUy9MQXh3K0JlZ1RJWlY2?=
 =?utf-8?B?aVZTUHJWV0Uyc0pWQlJFQXdYMUYvMEc0UWF1aVJReHU1b0xmODJOcG5pV0p5?=
 =?utf-8?B?VFpWT0VNNEd5M0t1WlhiaU9OOGo5cVp5eGQvQW9zdTJwTm5KcHMrcWJmTjJO?=
 =?utf-8?B?VVB3S3ZFYnpJZnBpcytRaWJ5ZlB2VndLMElWREpCeGdHa1JhblRpVW1hTndp?=
 =?utf-8?B?cmNZTDRKeFBwV2wxMGFSaHNSN2Y2aVduTXRxMHVxS2hKR3dUamZ1MDZqeVNQ?=
 =?utf-8?B?aWxoYUR2ZFNPZEw4aVcrRUFwSy9ZLzFqVnZRSGdMT0ZXV1V6V3BkTWNBWmZs?=
 =?utf-8?B?UGE0ZVRIbzRQMTdLeHY4NWhFMlgvclBrSlRHTk40cDBTcjUvQTRiUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f290a7a-4b12-41fa-8418-08dec30c77d2
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:12:25.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+gSDlsDiV43spinDgqBAwLr4UpNQWIiNWsSIpOcLmuHk4OHcuXFfyAdSkONe0EDFKrLdoU8ntsq6umLd61VFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64



On 6/3/2026 1:52 AM, Will Deacon wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Jun 01, 2026 at 10:48:45AM +0000, Ashish Mhetre wrote:
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
>> index 1e9f7d2de344..78c96a2b652b 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
>> @@ -350,6 +350,26 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
>>        return 0;
>>   }
>>
>> +/*
>> + * On Tegra264, arm_smmu_cmdq_issue_cmdlist() doubles every CFGI/TLBI
>> + * submission (see ARM_SMMU_OPT_TLBI_TWICE). The doubling decision is
>> + * taken once per cmdlist based on the first command, so a single
>> + * batch must not mix commands that need doubling with commands that
>> + * do not. Split the iommufd batch whenever the next user command
>> + * crosses that boundary.
>> + */
> Again, I wouldn't bother with this comment. You probably _should_ update
> Documentation/arch/arm64/silicon-errata.rst, however.

Ack, I'll remove this comment and add in Documentation.

>> +static bool arm_vsmmu_can_batch_cmd(struct arm_smmu_device *smmu,
>> +                                 struct arm_vsmmu_invalidation_cmd *last,
>> +                                 struct arm_vsmmu_invalidation_cmd *next)
>> +{
>> +     struct arm_smmu_cmd next_cmd = {
>> +             .data[0] = le64_to_cpu(next->ucmd.cmd[0]),
>> +     };
>> +
>> +     return arm_smmu_cmd_needs_tlbi_twice(smmu, &last->cmd) ==
>> +            arm_smmu_cmd_needs_tlbi_twice(smmu, &next_cmd);
>> +}
>> +
>>   int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
>>                               struct iommu_user_data_array *array)
>>   {
>> @@ -382,7 +402,8 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
>>
>>                /* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
>>                cur++;
>> -             if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
>> +             if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1 &&
>> +                 arm_vsmmu_can_batch_cmd(smmu, last, cur))
>>                        continue;
> FYI: Sashiko is unhappy with the existing code here, so somebody should
> check that out:
>
> https://sashiko.dev/#/patchset/20260601104845.995005-2-amhetre@nvidia.com
>
>>                /* FIXME always uses the main cmdq rather than trying to group by type */
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 08684bd40a6d..f38c21b56f28 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -698,10 +698,10 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq,
>>    *   insert their own list of commands then all of the commands from one
>>    *   CPU will appear before any of the commands from the other CPU.
>>    */
>> -int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>> -                             struct arm_smmu_cmdq *cmdq,
>> -                             struct arm_smmu_cmd *cmds, int n,
>> -                             bool sync)
>> +static int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>> +                                      struct arm_smmu_cmdq *cmdq,
>> +                                      struct arm_smmu_cmd *cmds, int n,
>> +                                      bool sync)
>>   {
>>        struct arm_smmu_cmd cmd_sync;
>>        u32 prod;
>> @@ -820,6 +820,26 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>>        return ret;
>>   }
>>
>> +int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>> +                             struct arm_smmu_cmdq *cmdq,
>> +                             struct arm_smmu_cmd *cmds, int n,
>> +                             bool sync)
>> +{
>> +     int ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
>> +
>> +     /*
>> +      * On Tegra264 (see ARM_SMMU_OPT_TLBI_TWICE) re-issue the same
>> +      * cmdlist with another CMD_SYNC to satisfy the erratum.
>> +      * Callers must ensure the batch carries a uniform opcode class
>> +      * so that checking the first command is enough; the iommufd
>> +      * VSMMU path enforces this with arm_vsmmu_can_batch_cmd().
>> +      */
>> +     if (!ret && sync && arm_smmu_cmd_needs_tlbi_twice(smmu, &cmds[0]))
> Can you move the arm_smmu_cmd_... part to the start of the conjunction,
> please? If you make it a static key as I mentioned previously, then
> hopefully that should mean everything else is moved out of line.

Okay, I'll fix this in V4.

>> +             ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
> Sashiko is also unhappy here if n == 0 because we probably shouldn't
> be inspecting the command array in that case. Generally, it's a pity
> that we can't handle this all a bit further up in the stack when we know
> exactly what operationg we're trying to perform, but I suppose with all
> the different users of the invalidation commands that's hard to catch in
> one place?
>
>> +
>> +     return ret;
>> +}
>> +
>>   static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
>>                                     struct arm_smmu_cmd *cmd, bool sync)
>>   {
>> @@ -863,6 +883,14 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
>>            (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
>>                return true;
>>
>> +     /*
>> +      * Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE). The batch holds
>> +      * a uniform opcode class, so checking the first command is enough.
>> +      */
> Again, please drop the Tegra264 mention and just refer to the option.

Ack.

> Will

