Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112B38D41E
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305622; cv=fail; b=Y41gmMZG5rrVUhkk5+fS4i/2XS1fOU8tBoo82AgNaWgKVvbEFU9Ygqth4Fr5aNZFsRzPLMg+c+LsoXQIIjU7w0e+eWwLJbmM4NXu1m/fQ3JJlXCByah+r6c8GE1hLpS3XBkN3r5exA2DPAN7TX5kiohvPYuhq4GTWD3bMwKaRVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305622; c=relaxed/simple;
	bh=wuOTXpyA/nBVVBQYl2HjJ8v9z7rt5hr14dLdslKpLsc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ePMGTbCxGRi6yK+yAmLZCSqMObhFSn86X5CKT0PQi9urJSAeVBxNAsdJRvkhRbtDPrIUVLyx3MBNt2qbZvF7R6YurfZ24j6Xb2zkIzQUFQIvqYr9h3niSq4OJsOyDnzWp/gHX0HJR4tAwjEYpmHOxGcOnNz5rz9bIktMeHycC0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SjUxC6w2; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SjUxC6w2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h975SzKTB6YYewXhlhRb5tPJwcuh3dj45V728TrYr3j4Zsm89mQV+b4z/p0rc6HrkZFJ3TcsB8ZoRLnReho1KLTCDoZ+njWLuY2JXOxmSE6O5/6sf1yZlEAJVf2uqvZktwL62WNauKHlFTrJTdzoXL6/vxNw/dPZXqaUdxFMpULJNXCDU+r5+bQRxU+o+VM2smqqaXNrltfHACGQSf+wKzLyH4CBUraCT/UR4QA2/1TO7bLi6LYDG5098mV2R+48cjRewOGEAvjp72C+MGFFc2xecTK64iPOrbXuJYBU9idZuOGFCyBkt//X22PdsNyNVhbBqMZ4zSQNm+PrwG/m0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7l6kkw/7sjRfOV2PODTdW0wKJFifeacc3j1/KcRC+Q=;
 b=LSD1/2qzfe3r/Vsr0Qomh5CPAxRAJs6JutpQiNCGg8BwOnMigBPS6j/cNxNvyNKZ73hY00Ug96VzFSknH21iW+TBwXCKosPbzahH3Gc/3A166KL1BsTgs3WR5SXm7rx8w+OYXYpEGFYynSLGHxAwjwgNJLYrzRMUCE2s231wDnKpvqXoFK8wT7pBTRJ/kT4c2NMPIwRXayqGK/EoqG72bGo+em7yvra2iDhmEp4XwjW2CEQhplElM1ShTDkuRKZe0CT8tWSKBSIXlHqUIqOhEtj8YIP+GtdNbL1g95A0B+I+zPlzd+l63xSacpAGtY0r2IX3uV5UXQ6kvRehAgxiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7l6kkw/7sjRfOV2PODTdW0wKJFifeacc3j1/KcRC+Q=;
 b=SjUxC6w2bGQ4XZ/BDtlfF36LQcdhp624bZ7GGSXGYt5Z+zPF6rMqR7Cmq27Xfx7OJrVhuynWFmaT+y/BcG/lb3ZMUlXc89aDtfgqNyZb6DVkPmWeqoHRICKKeUhiHkq1mH2GoXf4rAyTP1QJ/qOdZc2n3329UOQIrG1OJq7NjVOzo+TZghMUxLTK5HWlA0YvuQ0jNyOAyWMNNBRfJgXJfKPejWHAHt9nFR+27RM4xxstDlj4mC9JAE39O2ML1AbSU592L5efNtUfkaXy5M/L48aZaFElH5QU98lmF/XeUAQLojBW1LKuOqv0To4raHdWGRq1XwM65RXQpkbr83BLmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 09:20:17 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 09:20:17 +0000
Message-ID: <aa82eebd-3e54-454e-be62-6be33d8ee9f3@nvidia.com>
Date: Mon, 1 Jun 2026 14:50:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on
 Tegra264
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20260529140830.629738-1-amhetre@nvidia.com>
 <20260529140830.629738-3-amhetre@nvidia.com>
 <ahoA05k2zBumGqi/@Asurada-Nvidia>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <ahoA05k2zBumGqi/@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: b3129b04-6b28-4e6b-9820-08debfbefe8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099006|3023799007|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YEl6VTObBF7BIMCX7wIqzeJYQRmwgROX+GgRTy8UVzz+Zr+P79207ZlweWx/s7Abg/jKyxtRWF2xUbnyk1mp7sNHJ14LPXqM5BehLoIxf55slp3xfApsp5zUz1aG3Gf4TmBSNHsRlZWYwTqsSUC0NiFxd8zPVpD2nuGDaPnfWPW6zoziS93kU9XBvUozyhb+k5VLK9G7Clj4LRPBOqMY8yHAl/XwI6ZPzHjoCqj1DX6DbjX+NBF8+8vFgesA2KGtYQvJvtuT9KImHmpWzZBXGO51V1a8VwxCOr64KOuqPTnIp/4d1pp2OBLu2jUdA7hf4IV8ul3jHzwIvOqQUnjhIQa5q6zT0S/uHboVB7bgX+5nrPtKvd8l4HsFXzL0j4w/eBdVxnl17tsCztMIVwYsNQo+DdlcxSJRElVNljxjyE8hDgfMC1Voe1EiKYrUcU8+j0PTat7qxVQv2ijFEEPOQ/SPgXbFe1eO1GsNYNoWMJSubfyVBHXkS/OXvafA1b5CQamZRzEvsWqwIhgI/TK2YOiZGr3gbkzaiwpGMJ6hNdllMswTyXGr1EripeBnGCRnEEvkbL7RmNM9fbitih7FTWk6eT/40vwfDwT2WuYAcHbvHFw0b4OGpsiTS2dBvLchxMkkF6Sx6DFQ/1ORRwY6IE0A0dI/o62d+9/1d+BwtW9xIpPh+LYxh4KXrt3fMSo0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(3023799007)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czJhZEduWm9yc0RiYWdPdlYveDNzUUFCVmhTd0IxQlFEdWE5azhlQXh0eTZW?=
 =?utf-8?B?WGtsQWJyaTFpa2syTndEY0lUbmRsc1g1UzM3K09UK0xDUGo4R0dteERFeHUz?=
 =?utf-8?B?eUVUaHFJVExvYzZPRFVoTGZKc0Izenh6WUhSaE5aT1JKTlNGTDJBckFVaXZ0?=
 =?utf-8?B?d0JOaVRVNmFWS0tVN1JZOFdlWUpzZllBZzNsSkJCazVYSWRNc2RHTGV4U1Fs?=
 =?utf-8?B?c3V5bDBoQVNUNG1UTmZPTTBZTUdpK2F5NjFobUZDOENIaVFtMWNrU3RWOHJs?=
 =?utf-8?B?aFc0M0dOV2NwelZrM0crUCt3d0tvUVVYZmxJVWJ0TkNsSkFrY3FqMHdYekFQ?=
 =?utf-8?B?SGJFZCtVOXdvVWZIVzc5aU1GVXZsc2FIcmw0MmtoREl5SnpvU1JIbnRZQlJU?=
 =?utf-8?B?SXFaejA1a1plN3lEd1JDSDkxRzNaU1o2dFJTSmMxanFvU2lSNUZjWmtyOTdy?=
 =?utf-8?B?a21GMlhRZFAvUnlZcy9lcW1KMWErY1M5aGZ6djQvYU5DSXZsdlR3VUdka2c4?=
 =?utf-8?B?TWlNR2VFaVB4ZFQxNzU3NGVLUWFkWjFYZEJkRVYrLy80N3I1eFRZMGdaUTVi?=
 =?utf-8?B?Qzg5NGxiT05BWlBvQTBjOVRwMnJMaVcrSVJBbHljcUNvNmVBRkJ1b2JrUmho?=
 =?utf-8?B?Qk10VkdiamQrdHd2V2YyS2VUQWNnOVVoeUNJdkVjbi92MVAwTkNtMS9lNVc3?=
 =?utf-8?B?eU1vZlYrbEQ4cUJUVk1HSEt4aFc5SHJRZVlmQmtOTFdvM2FYM3J2QUlYbzhs?=
 =?utf-8?B?T1J1V2Z4SnNocHZ4dEZ3Z2ljR2M0ZXQwZ08wQWk5V3FlZy96UXovenlmOW1z?=
 =?utf-8?B?K2FpMXR5SG1mTVNJSXFDTUV4bjdjc2JQZVFEM28rOWVmbmlpcTBCVXEzTWlC?=
 =?utf-8?B?a1VkWjJGQ1NtYzViWkR0UWQyZ2UwMlZoMm5WNTdUdlFJZWN6djZoeGVyWTA2?=
 =?utf-8?B?dFVRa2luTStGN2UxL3VaY1c1dVJtS1pqa3JqbHR2d0U2cS9QZVM3S3dpNGJI?=
 =?utf-8?B?T25iWjVWdjQyTVJjRWt6NGRISkVkWVd3eFRxVWo2YlNpdVJCYnNOYnRYYjQw?=
 =?utf-8?B?UTdlZGgyaXJ3c1dRaEtHaVJZQmd6bGZGRWhSNTNRYmxDYVU4Z0NJQzRYN1ox?=
 =?utf-8?B?Y2tvQlM1SVhTL0lsU2JqUVBaSDNITW9NbTZiUWJmcnVxeDcxdVRrdGcxMS9v?=
 =?utf-8?B?MURBSDRTblFEMFMwbXY0Y2J2T0tTT01PaGszb3hzbTR1bmJ6N2EzL2ZQMzdL?=
 =?utf-8?B?WDRabnlsaEo1SDB4VGJzVDBJdnd0c0lYY0lOYWQ3clFoMjBkSDVQeklDZTBX?=
 =?utf-8?B?OE1JVkJ5N1lGcjk0QzE1NHhqVGF0U2MwWlJDZW1kcTh4UXV0UmxQbGFUVlVz?=
 =?utf-8?B?UGtsTXdHZnhZTitlaStyUlI4elhXcjJCc2c3VXRMNVpwY3ozcjVwL2xqVzFv?=
 =?utf-8?B?S0ZySEVCWXlPelQ0VFBOcHRRenZ2cVZKNDRlWFFnbjhhcXlKNXFna0x4T21L?=
 =?utf-8?B?Z3pURVZKOWUvNnd3ckpwaFkyL0RlMGlvZlI0NWRkNUhISXN1WXNEZnVISEta?=
 =?utf-8?B?Q2p2L3VsR0tHZ05pYTBSRzVlQWZGT00zNFlweTZxVjIxSk9UVmhlTmNQZHhW?=
 =?utf-8?B?TFlMSWZsaGlBdEhsQkl0UnlCaTJLbTFPSGxHU0lCNFFoZzl4S0tzQmxMSk5m?=
 =?utf-8?B?VHJWYXJDeEtMdHFNNkxFT1lVbzRweCtjUnBtVWVEWTYza2RFaW1sU1dHVHQ5?=
 =?utf-8?B?KzZmLytZemgxOC8zZUZEZG1RMFVDVlhDR3pKdGh3SGdNSjlQdGxBVEJKQkxS?=
 =?utf-8?B?dEhxUklad3JLMGkxSmhCWHhVOXpoWVYycVo4WlBqTlVQTk53QlJTZjBYalBZ?=
 =?utf-8?B?c0F2L0d0ZFZwSGthU2RmaXVnZEFQMnoxckJ4cTd5R2RHNThiMkZVTHE2RHJC?=
 =?utf-8?B?T3hMQ0tpRGx4ZEpYL2ZNYVQ2aEd3QmVlSkJONzFIQU53YnVIejJybnU2aHJs?=
 =?utf-8?B?NXl2ekpCV29hWWdVbkcwS2t4b01aZlFTWlRFcm9hTXVhTkw5QlFPVGs5ZGZv?=
 =?utf-8?B?aEdFNkozS3JrV2V6NU9vNlpON2xIbTdYZFMrQWwvSUJJZi9lSXlpZXpSMmIr?=
 =?utf-8?B?b1JPSi9GY0RkMi9lV05lemlpdHVqSFJ4V3VhSU5GNkFJUTJ4NWkyU1lkL2RH?=
 =?utf-8?B?Unpxa2s0dU8xWXZLU1JFOFA2bDAyL1FkV2V1Qnhoc0JpN2w4VmZ6RC90NEc0?=
 =?utf-8?B?S1RoL1dtUVFJNU0wSFd0T0htUGxQUFErZC9zMGdmQkNhd2hnNFJpYllCZklQ?=
 =?utf-8?B?ZWEzMDhObDl5amJLSEZYd0RodnE0ei9SVE9yenQ5Y28rNGs1ZDRMZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3129b04-6b28-4e6b-9820-08debfbefe8d
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:20:17.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH+Pkf4oC8KNWf1bOQoeKdNSP4VL0H7b5ifhGdxQenDjuh5/+thAdOUO9ZvN1+CuF5NOW3kQoVY4adK+k1PKiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553



On 5/30/2026 2:40 AM, Nicolin Chen wrote:
> On Fri, May 29, 2026 at 02:08:30PM +0000, Ashish Mhetre wrote:
>> +int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>> +				struct arm_smmu_cmdq *cmdq,
>> +				struct arm_smmu_cmd *cmds, int n,
>> +				bool sync)
>> +{
>> +	int ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
>> +
>> +	/*
>> +	 * The driver's batch invariants keep a single submission's
>> +	 * opcode class uniform, so checking the first command is enough.
>> +	 */
>> +	if (!ret && sync && (smmu->options & ARM_SMMU_OPT_TLBI_TWICE) &&
>> +	    arm_smmu_cmd_needs_tlbi_twice(FIELD_GET(CMDQ_0_OP,
>> +						    cmds[0].data[0])))
>> +		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
> https://sashiko.dev/#/patchset/20260529140830.629738-1-amhetre%40nvidia.com
> Sashiko pointed out that the iommufd path might mix commands when
> calling arm_smmu_cmdq_issue_cmdlist(), which is valid I think.

Okay, I'll update the batching for iommufd path as suggested by you in
next version.

>>   static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
>>   				     struct arm_smmu_cmd *cmd, bool sync)
>>   {
>> @@ -863,8 +909,18 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
>>   	}
>>   
>>   	if (cmds->num == CMDQ_BATCH_ENTRIES) {
>> +		/*
>> +		 * Force a SYNC only when the batch carries commands that
>> +		 * have to be doubled (see ARM_SMMU_OPT_TLBI_TWICE).
>> +		 * The batch holds a uniform opcode class, so checking
>> +		 * the first command is sufficient.
>> +		 */
>> +		bool need_sync = (smmu->options & ARM_SMMU_OPT_TLBI_TWICE) &&
>> +				 arm_smmu_cmd_needs_tlbi_twice(FIELD_GET(CMDQ_0_OP,
>> +									 cmds->cmds[0].data[0]));
>> +
> Also, given that this does "force a sync", I think it might be nicer
> to go to the force_sync path. One of my ongoing series also needs to
> add another force_sync condition, so I think it would be cleaner to
> have a helper function.
>
> Maybe try the following diff. That arm_smmu_cmdq_batch_force_sync()
> might be added with a preparatory patch, but it's up to you.
>
> --------------------------------------------------------------------
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 1e9f7d2de3441..4c9ce974d31a8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -350,6 +350,18 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
>   	return 0;
>   }
>   
> +static bool arm_vsmmu_can_batch_cmd(struct arm_smmu_device *smmu,
> +				    struct arm_vsmmu_invalidation_cmd *last,
> +				    struct arm_vsmmu_invalidation_cmd *next)
> +{
> +	struct arm_smmu_cmd next_cmd = {
> +		.data[0] = le64_to_cpu(next->ucmd.cmd[0]),
> +	};
> +
> +	return arm_smmu_cmd_needs_tlbi_twice(smmu, &last->cmd) ==
> +	       arm_smmu_cmd_needs_tlbi_twice(smmu, &next_cmd);
> +}
> +
>   int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
>   			       struct iommu_user_data_array *array)
>   {
> @@ -382,7 +394,8 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
>   
>   		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
>   		cur++;
> -		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
> +		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1 &&
> +		    arm_vsmmu_can_batch_cmd(smmu, last, cur))
>   			continue;
>   
>   		/* FIXME always uses the main cmdq rather than trying to group by type */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a63155e9e7f28..9b150e3145034 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -820,33 +820,6 @@ static int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   	return ret;
>   }
>   
> -/*
> - * Returns true if @opcode is a CFGI_* or TLBI_* command, i.e. one of the
> - * invalidations covered by Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE).
> - */
> -static bool arm_smmu_cmd_needs_tlbi_twice(u8 opcode)
> -{
> -	switch (opcode) {
> -	case CMDQ_OP_CFGI_STE:
> -	case CMDQ_OP_CFGI_ALL:
> -	case CMDQ_OP_CFGI_CD:
> -	case CMDQ_OP_CFGI_CD_ALL:
> -	case CMDQ_OP_TLBI_NH_ALL:
> -	case CMDQ_OP_TLBI_NH_ASID:
> -	case CMDQ_OP_TLBI_NH_VA:
> -	case CMDQ_OP_TLBI_NH_VAA:
> -	case CMDQ_OP_TLBI_EL2_ALL:
> -	case CMDQ_OP_TLBI_EL2_ASID:
> -	case CMDQ_OP_TLBI_EL2_VA:
> -	case CMDQ_OP_TLBI_S12_VMALL:
> -	case CMDQ_OP_TLBI_S2_IPA:
> -	case CMDQ_OP_TLBI_NSNH_ALL:
> -		return true;
> -	default:
> -		return false;
> -	}
> -}
> -
>   int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   				struct arm_smmu_cmdq *cmdq,
>   				struct arm_smmu_cmd *cmds, int n,
> @@ -858,9 +831,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   	 * The driver's batch invariants keep a single submission's
>   	 * opcode class uniform, so checking the first command is enough.
>   	 */
> -	if (!ret && sync && (smmu->options & ARM_SMMU_OPT_TLBI_TWICE) &&
> -	    arm_smmu_cmd_needs_tlbi_twice(FIELD_GET(CMDQ_0_OP,
> -						    cmds[0].data[0])))
> +	if (!ret && sync && arm_smmu_cmd_needs_tlbi_twice(smmu, &cmds[0]))
>   		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
>   
>   	return ret;
> @@ -893,34 +864,48 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
>   	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
>   }
>   
> +static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
> +					   struct arm_smmu_cmdq_batch *cmds,
> +					   struct arm_smmu_cmd *cmd)
> +{
> +	if (!cmds->num)
> +		return false;
> +
> +	/* The batch's pre-assigned cmdq doesn't support the new command */
> +	if (!arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd))
> +		return true;
> +
> +	/* Arm erratum 2812531 */
> +	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
> +	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
> +		return true;
> +
> +	/*
> +	 * Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE). The batch holds a
> +	 * uniform opcode class, so checking the first command is enough.
> +	 */
> +	if ((cmds->num == CMDQ_BATCH_ENTRIES) &&
> +	    arm_smmu_cmd_needs_tlbi_twice(smmu, &cmds->cmds[0]))
> +		return true;
> +
> +	return false;
> +}
> +
>   static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
>   					  struct arm_smmu_cmdq_batch *cmds,
>   					  struct arm_smmu_cmd *cmd)
>   {
> -	bool force_sync = (cmds->num == CMDQ_BATCH_ENTRIES - 1) &&
> -			  (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC);
> -	bool unsupported_cmd;
> +	bool force_sync = arm_smmu_cmdq_batch_force_sync(smmu, cmds, cmd);
>   
> -	unsupported_cmd = !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd);
> -	if (force_sync || unsupported_cmd) {
> +	if (force_sync) {
>   		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
>   					    cmds->num, true);
>   		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
>   	}
>   
>   	if (cmds->num == CMDQ_BATCH_ENTRIES) {
> -		/*
> -		 * Force a SYNC only when the batch carries commands that
> -		 * have to be doubled (see ARM_SMMU_OPT_TLBI_TWICE).
> -		 * The batch holds a uniform opcode class, so checking
> -		 * the first command is sufficient.
> -		 */
> -		bool need_sync = (smmu->options & ARM_SMMU_OPT_TLBI_TWICE) &&
> -				 arm_smmu_cmd_needs_tlbi_twice(FIELD_GET(CMDQ_0_OP,
> -									 cmds->cmds[0].data[0]));
> -
>   		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
> -					    cmds->num, need_sync);
> +					    cmds->num, false);
>   		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
>   	}
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 08d1abaf31ae2..e6afc832c0078 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1219,6 +1219,37 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   				struct arm_smmu_cmd *cmds, int n,
>   				bool sync);
>   
> +/*
> + * Returns true if @cmd opcode is a CFGI_* or TLBI_* command, i.e. one of the
> + * invalidations covered by Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE).
> + */
> +static inline bool arm_smmu_cmd_needs_tlbi_twice(struct arm_smmu_device *smmu,
> +						 struct arm_smmu_cmd *cmd)
> +{
> +	if (!(smmu->options & ARM_SMMU_OPT_TLBI_TWICE))
> +		return false;
> +
> +	switch (FIELD_GET(CMDQ_0_OP, cmd->data[0])) {
> +	case CMDQ_OP_CFGI_STE:
> +	case CMDQ_OP_CFGI_ALL:
> +	case CMDQ_OP_CFGI_CD:
> +	case CMDQ_OP_CFGI_CD_ALL:
> +	case CMDQ_OP_TLBI_NH_ALL:
> +	case CMDQ_OP_TLBI_NH_ASID:
> +	case CMDQ_OP_TLBI_NH_VA:
> +	case CMDQ_OP_TLBI_NH_VAA:
> +	case CMDQ_OP_TLBI_EL2_ALL:
> +	case CMDQ_OP_TLBI_EL2_ASID:
> +	case CMDQ_OP_TLBI_EL2_VA:
> +	case CMDQ_OP_TLBI_S12_VMALL:
> +	case CMDQ_OP_TLBI_S2_IPA:
> +	case CMDQ_OP_TLBI_NSNH_ALL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   #ifdef CONFIG_ARM_SMMU_V3_SVA
>   bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
>   void arm_smmu_sva_notifier_synchronize(void);
> --------------------------------------------------------------------
>
> Nicolinc

Ack, I'll add force_sync patch by you as a preparatory patch and rebase my
changes on top of it and send it in V3.

Thanks,
Ashish Mhetre

