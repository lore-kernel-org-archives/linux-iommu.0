Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D8386C0A
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665325; cv=fail; b=nYIK0yLXJuPDdUxmU4IjUz1GZ+WJGlDp+LZq+/2wL/lplDGFBZDSWef0glHuPswOPAq0clUcGitbWR//mucI/myyNCMrCH2qdez9JyHcNplN5wfPpNA0tJcrAPQne1gGqcFcqkacPLqYvQVk3P7WdEaf56BRkjrfnC8BphFyQh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665325; c=relaxed/simple;
	bh=pzOmH3CnKqBS4IeAejjN584EjdKSN9wXcH4vSvYoVTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bN1GP8aliqqBmkebWSvwFlIqwD9dWx9xmsu8x3Pe6k61ArEMDBWpvaH28GLL3NOpY6xgO/25VsC4j8Rwt4RmByNrDPOnoWJxeQEZpmVpCf2qFDbVNEcoioe3yUiUhGM51KTnjX3gG4RNm7PUN5pOiHAphyAvCbY9OTA1Y0OL/sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y/yp+FM7; arc=fail smtp.client-ip=40.93.194.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y/yp+FM7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yp1cMeu3a6vnqO/lRW1xeph8kJx59+YxrhIFukZe/A6hjy2Z97ajjDRuSZo5l1WvXkAmZdxOJskJt3uES6D9es7KrKRrvJ5CgPhfIEFVNcF8Vwao7jrFThpZFjiZqouMu+7DYAO/oUO+AcvmwhhXJZ4idzzBwUiI/p15mQycFtdwcBxSsQLW3NU8qNfEPhUle79ICaR/A6bO3wFvSv04IA/YpAOK50wY5Xuhb8Lgw973V/ZFEQeFdTf4HUTMSIcyNg6J1sWgXMzisTT8IcsUsWG/NjwMKY6nModOzv1ZNnlBmEeFo8kr2gkIhj4/MLMgEdOvt2fXCSekYTsRTRQ2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzAs6xjNc3O0soFXzhPDEGPZ1/TY4FNBdBap42F7MDs=;
 b=Az0gz42Ws1MwjDoRDp2Ynfhc+8mg/at4nIuR33gxng8TTLPKwQpYNf5SEfskOkfV4VrBUIVJOmZxeuZ+3tATQQwNLD3ZiGKU1AQ96D33RoCQ13Croh+TyoPz8z3E91YnwmanOidKFHsajnsIUtBB0lcbIdqxEVItxUqRiWVRL1BzXm5dsrYLTXbujHpgKjhst62nNq+PWxxox9dlplnAGOkVWmMDhIGWzHy+4u2Zpbw92ShOIaWvaiIZ/sWzkthzjrYfRTc51e3LZ3Zxw8kq7SNbfwsuihOAWS7acz03WsKKNEcX8HJRVFa/BRZ050yuk+MwjVHSRcTKJoxlLJQ02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzAs6xjNc3O0soFXzhPDEGPZ1/TY4FNBdBap42F7MDs=;
 b=Y/yp+FM7xC9B0piqAmhmbrbvgBhChRGgi/3lZPv5YNwbjV33L6nuKuqIvUk+9Zbg6Iji8rUP7QZTYJDM/KSdRPrnaN5JfoJ/DxXDF95J0Ekm9ahalCNaVpMr2UXSTCYfIAcm25YxsGdqQ/g1Vz7/KhC3aODe2NkUKDXOmwSurV2ebc5RY+GE9KQcXv/NaVde/Ys9+MwXqqg8Cb10Q4DHKnLqCML14sEBYFEPZoCryeoWsjsAHRtzVLxRrJ5rsBsQSJR8tcvfukh6inzNp9h4vmItZ4LQfugp7F+WDgoKkgJhnjy8Bqcgg84pqsyJCn1jWpDhJBi9ab/s3tMFWt7eiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 06:35:19 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 06:35:19 +0000
Message-ID: <6d7ba8bb-2d41-4cec-8923-d7a14d7675ff@nvidia.com>
Date: Fri, 10 Jul 2026 12:05:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat
 workaround infrastructure
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260709095613.831769-1-amhetre@nvidia.com>
 <20260709095613.831769-2-amhetre@nvidia.com> <alBzEGd3a2MQTpt5@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <alBzEGd3a2MQTpt5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b133676-e8dd-4b2b-26d1-08dede4d6939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|4143699003|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2ZRiXPV9vi+CsviXZGsO3gYRcqZfeZT9YmLyO6mdyzTqcvAkM3EvH1aDZwIVvfzazWrdCNTP5Tnz8Pi/TAmaRT2O7m6yQ652DguDGFBlCEJMCuH1NBIeSqI/EVRizWiTjhgupsLQGg8GSQtKoHa2sm2RKVehQWoupoo0Yz1Bwdc4xGU+XLvpA4v1S5tN3JhW1BnejQrKuXnuJfkSqDnNmUute6KrDmSPOtoW23EvomxdvIuT2+g9l6AUOLoVdk56f+bsxx5PLrjp2wyFozctMP20y0G6hLtO430u8TwHD7chdAiAqoIZdASyuu9X2NhlgSOXXVFvVqYf2+oLziC4uZagKgkj8iR1joiPYi/SLrpvmc4vrlSzb0F6HwPTxKtT8KKQb3qn9RKPsfm5wx4DM70vPk2QwqIhfhmhZDo+r119i2BohJBTab3xw3BtUXrAWoFGM6D+10ypaC+HOdKICWaIBrcNG7r31b+9mWC9wnsxW1ZEY7hDPD1+MzBMeSaKLUJ76QWcc75zy5X/UOSJcrHGQAVjfEoAXoc1jvfrv4Xh6cddVHSqPG7cfeSzi1/i+m2ZhrdiM1uUAbLEN+lefg0uCCcq4/zeYoalml+TceQji6hGjObLoADTj01jqA2MvEShewxHJCvvBah4zk7Z1CKWNN2Dq1gW3TiO7iEBDgY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Umk2TFlqQ0xqWWFHRlYycnYvRlc4cGxncUd2eXpXTERjd1loMTNpQVFJNjRa?=
 =?utf-8?B?YWZhcVhvQkM5YVJ3d0U2YXJBWFlnR2xVbTFmbm05QU5VQ1lBQ2tONWpmT1pm?=
 =?utf-8?B?MjhaVDFnNkZGOGMxUkg3QVRyYU8yWHhKMm1JdGVNZ09zaGUvRlFoN2Q3Wkk5?=
 =?utf-8?B?R09vQzN5UGJjdGt4SFdGMXEzZHJ4ZjYxYkt2TjVaWTZtQllmazNTdUNUTWtM?=
 =?utf-8?B?anREU0pWVGZWeEh2TUMrTmpDTWV3Y04zU3ZxZlUzNTROZ0VoY0JOYVh4OXlO?=
 =?utf-8?B?UHIxN3NxOFlNMkUraTYzR1d0azB3c3BqZ0xrU2ZPYWNwRGprV0dUQUZWeVRF?=
 =?utf-8?B?eThLc0NwOHlqVlVFd3pZRnZlbnJtbUpQY2VpQTVtSDZCNGdjQVVRbWMyb0dr?=
 =?utf-8?B?cTZBdzl3MlllYVl6OFNLY3draUNBTldJR3FDZ05Mb05CUTFQQ2NQKzk2VktC?=
 =?utf-8?B?Y2pDNFpDaGduRDdWTnpTTzhYemxNWmUvdlVmZWxYL3l1dFZ0M3dUNUwyTmlF?=
 =?utf-8?B?dFMxUGpCVTd3NjkvTzRoL2d0RWFLTUQ3WkZERjQ5TERyQnB2bVZGSytFTUxP?=
 =?utf-8?B?bjh5YVdmTjNpditWRVFDWWYwMHlEbWlibnRLNTBEbUJQWmVHZzJTM0NnZGJn?=
 =?utf-8?B?MjN1ZERVK05KQVduR2VJWU5NcmV3TjdpQkVvRVVtcGlPeVhmeVR5Vy9SVkpV?=
 =?utf-8?B?U2orMEgwVExwbXlkVlB3VEpvSU42eWlRbXlpOEUwWXA2cGF6U3JFeThRbEU4?=
 =?utf-8?B?dkFKTnBockRBRVpCemNaMnBQZlMwVnpvSXRwRGlhSjlEU3ljSDVHY1FodlhC?=
 =?utf-8?B?T2pkdnNQRHhIa1I1NlkxTHdHSngvbzM4dktSSHQ1ak4zeU54MllWMXoyeTFk?=
 =?utf-8?B?aFptV0hZOHd5clNDaFZ0emhpZ1l6aGxLTk1BWUJuZitCUjRQZkhzTSt3dWFn?=
 =?utf-8?B?cUJqaHovVjdyL1Z6SUlnK2dCKzkxd29rZnM0TGVGSThuL203SFR3V1NNOUV4?=
 =?utf-8?B?VDh6c0RIYlArYkJSQVBGeEpSWHRDdnc5VTNPZjB5QmtsNGZiYWpxd3dZeVpw?=
 =?utf-8?B?amdTVEJwYlBmTFNUc1Jnbk5yb29od0p4TXZMa3I0SkM1QW5TanA2ZHdtYzVx?=
 =?utf-8?B?cW51ck1JbGVPWVM3Q0ZxMTg0RE5aRkl3YkFjM29uNVA1dWJzcG4weG1KV1Bz?=
 =?utf-8?B?bWlJenBQNGJORlRwVGI0UGlmbTRlUWNSbDZySTkwMGExQjNwRHZkc0lhcDMr?=
 =?utf-8?B?NU9WWWNzeDhhMEFRQkRaQUYzQVM3OFpYT3hOemhWMlJEWGp1anFLZndzWEVL?=
 =?utf-8?B?bW5IakJiSWlTZnlheHRvZG1MR2xjVDBOcU5yRmplMHFjczhSZkJLaGRUT3Ev?=
 =?utf-8?B?VFJpSS9lbEF2QjBPbHNVK0tWeFBPWTcrVWxXRWZ4c0htVlRDUkxrMGFCYkg4?=
 =?utf-8?B?WHRtemlCRSttYVMyYzd3Y1V2QkVlcUdmTTJBNXlFdnZyQmIwRm9OeFVEYjd5?=
 =?utf-8?B?cDIvRDRhUEJHY2NmMmtZeXNhc1IxblFPbS94NENrNUExbUo2YkdwWlhvbWho?=
 =?utf-8?B?UXVtUzgvWmJUamh0WHR5d3FvOFV5bC9TWWpBbUZpTFhibmg0UnZ5dGNXSWpE?=
 =?utf-8?B?KzRhNWh3N2ZhMEhlWG5IeTBEZ3h6OVRJRUlXWEc1eDVBVWdkYmFDSTBnT3ZI?=
 =?utf-8?B?VlRUNmdyN21iYXhNWTlIUkwrZG94OGVVZHVraUI0eHRVMi9yWmNMbUdnSWIw?=
 =?utf-8?B?WTVpbjhtQTRWME1aUk45OS9OMFVaZEpLMVdFVG52VktnVjdqbUlCVFQ0bk8w?=
 =?utf-8?B?L1FlNGI4Q2RSYXptVElxMjg1RGlmdisxWjZ6M1RZSDkvc3c2MlNMa3JYYjA2?=
 =?utf-8?B?QlJhbTcwZTdtSWFzS2R6UGhBajRSVzIwTVJ0OFJCeDByMHU4c0ZyeDdMRUxQ?=
 =?utf-8?B?cVVSaWx3bHVoU3oxYlZ5YUU1U01xSlpHYjhVZFc4VVBUNytrczRGRElrMmp3?=
 =?utf-8?B?a0NNdFJySUFickdYTjNyTlJRN0dnaUk5Yzh5UGFyaHpsRjFuSUwxa0NjMm50?=
 =?utf-8?B?QjdHN2RyZEM2a1N1eDIxRmRvWjVpbkc4ck00eHlhdGlvYUN6Z0tEVlo4SWxl?=
 =?utf-8?B?S2wzK2o5alJZOU55VFZ0R1N5ZjFja2pnNkt0RXJOR3QyQnBkYjU3Z0hqK3FZ?=
 =?utf-8?B?K2dRYmhqM0oxU1lhRThqbnJZQklDb0JrWUFaK2JoSC9KSHZSWXBDTEhKZk5n?=
 =?utf-8?B?NElaT2s5OUU3MTFaVGd1ME9Wek45N01YbG1JTmJvYUJVWlhDRnphQmx3TzBO?=
 =?utf-8?B?a3VUNHNpcnlaL1pIYTFSd2Q3dGE5d1pwMHNVRVFjSURrMlRhRmdaZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b133676-e8dd-4b2b-26d1-08dede4d6939
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 06:35:19.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSII7Ln5rHI0ldYJAZsQzPsy51T/2p8Lq4LbfjWpVpD05bCxM8dG3jYkH/CQTtqbawscCf17dzdBiBBUk6tjGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344



On 7/10/2026 9:50 AM, Nicolin Chen wrote:
> On Thu, Jul 09, 2026 at 09:56:08AM +0000, Ashish Mhetre wrote:
>> No callers enable the static key yet, so this patch introduces no
>> functional change. A subsequent change hooks the DT probe to enable
>> the key on affected instances.
> Nit: once a patch is merged, it's no longer a "patch" but "commit".
>
> Instead,
>
> No callers enable the static key yet, so there is no functional change. A
> subsequent change will enable the key on affected instances.

Ack.

>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 76efe479e80f..15b9d0170520 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -41,6 +41,7 @@ MODULE_PARM_DESC(disable_msipolling,
>>   
>>   static const struct iommu_ops arm_smmu_ops;
>>   static struct iommu_dirty_ops arm_smmu_dirty_ops;
>> +DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
> It's an erratum; it should have an inline description, like the
> one you had at ARM_SMMU_OPT_TLBI_TWICE previously.

Okay, I'll restore the description I had for option bit here.

>> +int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>> +				struct arm_smmu_cmdq *cmdq,
>> +				struct arm_smmu_cmd *cmds, int n,
>> +				bool sync)
>> +{
>> +	int ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
>> +
>> +	/*
>> +	 * arm_smmu_cmdq_batch_add_cmd_p() can flush its current batch
>> +	 * with sync=true and n=0 (bare SYNC) when the next command is
>> +	 * not supported by the batch's pre-selected cmdq, so the
> After a second thought, this "supported" case is not reachable.
>
> When a batch is init-ed, it's given an opcode (same as cmd[0]'s).
>
> If an opcode is not supported, it's init-ed with smmu->cmdq that
> must support all commands.
>
> So, adding the !n is more like a defensive play. But the comments
> here would be misleading.

You're right, the unsupported-cmdq force-sync path cannot run with n == 0.
I'll fix the misleading comment. The !n guard stays as a safety check 
for empty
batch_submit(), where we must not inspect cmds[0].

>> +	 * repeat path must not inspect cmds[0].
>> +	 */
>> +	if (!n || ret || !sync)
>> +		return ret;
>> +
>> +	if (arm_smmu_erratum_cmd_needs_repeating(smmu, &cmds[0]))
>> +		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
>> +
>> +	return ret;
>> +}
>> +
>>   static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
>>   				     struct arm_smmu_cmd *cmd, bool sync)
>>   {
>> @@ -860,6 +883,11 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
>>   	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
>>   		return true;
>>   
>> +	/* See arm_smmu_erratum_cmd_needs_repeating() */
>> +	if (cmds->num == CMDQ_BATCH_ENTRIES &&
>> +	    arm_smmu_erratum_cmd_needs_repeating(smmu, &cmds->cmds[0]))
> The comment above is useless; arm_smmu_erratum_cmd_needs_repeating
> doesn't give any useful explanation either.
>
> Like I suggested, add the missing piece of war description to the
> arm_smmu_erratum_repeat_tlbi_cfgi_key at the top. Then,
>
> 	/* See the description at arm_smmu_erratum_repeat_tlbi_cfgi_key */

Ack.

>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -1211,6 +1212,20 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>>   				struct arm_smmu_cmdq *cmdq,
>>   				struct arm_smmu_cmd *cmds, int n,
>>   				bool sync);
>> +DECLARE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
>> +
>> +static inline bool
>> +arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_device *smmu,
>> +				     struct arm_smmu_cmd *cmd)
> smmu is unused.

Thanks for pointing. With static key, smmu pointer is not used anymore.
I'll remove it.

>> +{
>> +	u8 opcode;
>> +
>> +	if (!static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key))
>> +		return false;
>> +
>> +	opcode = FIELD_GET(CMDQ_0_OP, cmd->data[0]);
>> +	return opcode >= CMDQ_OP_CFGI_STE && opcode < CMDQ_OP_ATC_INV;
>> +}
> Maybe move this to the first caller in arm-smmu-v3.c? Instead, add
> its stub here, so we can drop that DECLARE_STATIC_KEY_FALSE. Then,
> DEFINE_STATIC_KEY_FALSE will need a "static".
>
> Nicolin

Makes sense as iommufd only needs the classifier, not the key itself. 
I'll move
arm_smmu_erratum_cmd_needs_repeating() into arm-smmu-v3.c, leave a
declaration in the header.

Thanks,
Ashish Mhetre
