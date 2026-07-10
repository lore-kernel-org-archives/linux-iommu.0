Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7DF361DD2
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665426; cv=fail; b=kHRAx7IC7VizhSVXJZ5Ai+IgIeP5Enes62dColx0H8/RHDLr3126s14q/q+DN8aUKAg59gXuvKuv50T5xzMQyPnqzx6JsVgy8gfXvvHyRLTaDrM8Pn+1oYwvsYRJG58xwNlR7bgIDADrOQt4B24BdH3P5oxgWDyX4aSVgLT9TVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665426; c=relaxed/simple;
	bh=p8d6f8e+hLAOL2CuoAKuNXQqINjOK9LI4FiOzRIabu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ftGY38Eyf5YP+uLMfNlBKeeksEnD+m5tyJwN5W/RO8dpCEDGdSo9S7l4c5dIDjKXZ+u8uNs5KGVj34zRnr7HByNuvWLLPX063Rrs51Gf+7tXIBigbxJX52o9cWlC9Sa3qMf6X5E1dvKC8lotaEV3ThJ9HDm9ua+95yvNXik7gpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h5f7y4i2; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h5f7y4i2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+Xhwj0uJiphPk4Vqb6WKck487aRW2j9pVI46zop9SlcKmVueE/fPrW2UfI/dRc3XN2GQ+dEt58rXn8NNoK74kGHd374QpztnAN7qsRylZ0d7w2Zn9cO8FCGXND7KNn/a63oV9piNWQaQhodtocqZkeYscFmX3Csgy26ghBi84XrkuVgOoh3hI0IhX7h0vOGlaYp92laNjkMpZqQA15ooCcRpBTbCJMQVLoK/pGJ6rTim760HgLsMevjgVMmpiAQru0TMHvAFkRx4lit6Xn7XX9H8QuUl/0WCcuaAk4iUbHu+Xzgrl1CR8N2e2NaTOHD5YcL+wfT+FPCbSMo875zqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8d6f8e+hLAOL2CuoAKuNXQqINjOK9LI4FiOzRIabu0=;
 b=Fv3A1+bxGJOLaXMPzoy+JF2bsrBWGld2IDwC96jlp72Ti0c7gstCz7dl4HiuifZkugl6l9fZ4Db08TicN/WAtyc1Cy8/PpqRulvsE730h9YQynyDJHinCTOAV0/jemJiSw5gPOnsahXBQS5htTPuyeoQUKF6t/INccMTLw7bwq6pyE6PFXznIJARUTdlfptEkdkZgITH1Z6U6jQbIMwcyUUnaN32hMMYM6g2YjomxwgA9r9ktVCqJQ1a4pMe0GHuqjX3geMlgSVchluuG3f6VmnfLVhbAEDggT90JsLHj4zjykw9i9M8AubRGXA0bARO3qvCCroTpObKzF/jjFjl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8d6f8e+hLAOL2CuoAKuNXQqINjOK9LI4FiOzRIabu0=;
 b=h5f7y4i2pR48igtLU34vUQACt44ABHhgYfdYgfuwpwNpM6hpYlIJnZx/YwlpdKazf+3nj+/Ux30fq7N68nWxj3BHpo1nnXg5XYhRozl7WOOHfjiIMWl5swhj886hjZq5mrdhXF1GiWU7gakyWYZ8uBZ/53QX0SnEeknVjNLEV/L42zJWTUPdaqCklH54NbPExSk+DOqvsaAzlvK3D2S13KnNwt5VawB7puxJlj9Tw7GuA8CDdd2IS/JQAYfXRCircVBp7ijdIJRtM41YvU1r0DdY+kwCG6Sa46FWj9qp6HL6YVZCX93UlRBwIt8p/WggKcqN79diaenT27aX3DWQMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 06:37:01 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 06:37:01 +0000
Message-ID: <14839890-3509-47b0-97d4-6c7379079452@nvidia.com>
Date: Fri, 10 Jul 2026 12:06:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat
 workaround on Tegra264
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20260709095613.831769-1-amhetre@nvidia.com>
 <20260709095613.831769-3-amhetre@nvidia.com> <alB0VfK5n3PsE8oK@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <alB0VfK5n3PsE8oK@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::12) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: aa12ea7c-6df3-4fc5-5994-08dede4da5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EnvIxwR0isRAgY3kFLPMiEmvbqqeteOYSaRcV4X6vXBf3TrZLZCpm/wd/Y2cVmTS2VTjh87mdioQkS3kUlwSO4wYpEcDVvtBLjD8Ww1AwzJciO062mp+QAX6qPU/I+rRM79YJLjMK9vGCpm1DKfYuCwtwh/klIcPorgq8c/JgILYJm4bfKRhBaSP6grgTIeLe3Aky00CLzo41wezsKCCKFCHGBdl2KQv9Fbd1rq4B9xye90HLnxO/ICTenmzY1UjZLRTaptoxTjvI5dgVA+peLp9V1ISYaaiR/nDJRdWYjEELuiaz+oIVPagV84vTszKkJIekmGJvbGmfFLGit829I0BPlwB4lhEaeyFStJHf0nJ/K9tGxLuCc4E+/qPIPlTp/PXxd2iBCtXDK4kP8+yWaXSDARLlqkVkzQDS/UKT5i2aytq41SRw0imOlccLls59ktwL0ObpVfde11ZtDmzPY7vnMvwt9Tvg4MtU0/Rv9gLjuk46C10l8jWhNtewJXsOR6mDVseabZRB5zwaH3JoJB/BrxYaP3YjxKLHlolMASGJIHBNDPi0UrFy6MN/3Tn1z0i4YEhP8QIHxONoExVsWgeOjxDoyr2vgHRAAz4VjP+KWJzgw668EXpaKc/JeczEhXt/sDEAxOu09bNe66Hobvux9ZGi2CxxduxpQHWSqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVU2QW9TRmMrUmNHWitvQzNGc0dlUTRNYWVQSHJHTVRxT2tJSDRtV0ZwZytr?=
 =?utf-8?B?cFBqSkdUTXlEdExOZU9BMGUxUkszZXgrQ3dmdGxRbmh6cjZoNGsvek95ZStz?=
 =?utf-8?B?VGNHbFVUTk9jeUlWcDBnaU1nMUprVnhhdy9tcUhhUTAzdnVQVXZRVzhZMXQw?=
 =?utf-8?B?ekt4eGVReit3RkJQNzJRS29lbUhUZ2Y0Z2RMYjVkYWg5Y0lXaWIyUmlUVDB0?=
 =?utf-8?B?NVFQNTdKRjdMbXkrakMwQVc0VlZ5SmRRUU9Ga2trQXp1dTR5amhtYzJZd3B2?=
 =?utf-8?B?bG54ZTVXclFvT29qdlE1ODU1c2laU0FnSGYxdnRDeUtLR05QUFkrbzZIL2lN?=
 =?utf-8?B?enpVb1JOYVRENUJzTGtnZW9xSXA5dlBIZ0ljTkRCRzZraWMrNVRzWTVJTkxk?=
 =?utf-8?B?cFBsY2RZWTlIeGV5Y2VrWGVsY0x0R2xoYm1VNWp4dVdaQ1NhSnlFZElVcVdT?=
 =?utf-8?B?ZnNycUVjd29XaGtiaXpoWUZUdmdDVVdtSm81N1Q1T0RFODN0UDZnWjFLUHlM?=
 =?utf-8?B?bnpmZnZEbXpmbmJld0xPRUtJQ1VVbWJiYTVrdTNYbnBzaVZmelhiMTAzZ0Ew?=
 =?utf-8?B?V0ljbmp1WjFHOE9LRUJXUnRJQWZOMFAzdzFoYURuZXhDSVNoeUY4M3N1N3NL?=
 =?utf-8?B?aVlvajBXL3dsVTg4WEgxd2I4NzZ0V3ZNVlN6R1I4UGtpb25NTDNwK1prSEdI?=
 =?utf-8?B?TkFwTS9mNlZPV3lxaXZacmhkR1NRUFZITzJiOHVJczYwNWpGenphdUVlZFQx?=
 =?utf-8?B?ZG9WRkhzSWJSZzZyd3dXRzNjeG1Jc0ZENm1rU1EyZlh5UTl2dVU4MVlIQ3Rx?=
 =?utf-8?B?dTY3ZzcrYUNvYkc1VFlDaG9QRjY0NURzWGtzYld5Q01uMXEvMDViVXU5VnNH?=
 =?utf-8?B?YVd1ODU5OGoyZE1UTUgwNmRuRE5EeC9qYmdwdTloMUVnMEtyMm9FZUpPZW03?=
 =?utf-8?B?aFl1MncrMmc0YVZ5Q0tDQmNZWGtXaFlDVFNlbjh0Vmxyc2hCbkNZSFRlbjRs?=
 =?utf-8?B?aUNyZ29mTHdMWTJ0aW4wVkpqSWU5RFM3L01ZdFNJUkgrRlhDb1hLTFloWS8x?=
 =?utf-8?B?ZU45S0hSNngzdFY1NThlUHVPMzJ3NWU4RTJNU3FKMitXSTNpZVpEeU1vL09S?=
 =?utf-8?B?cG5COGxucUlnQVJwQ1pUenlQWmdYbzlZOWd5SVViMUxtYldlS3pBOThLQUla?=
 =?utf-8?B?L1pOUitERGN0N2JTUFRTa0hwdnBuUm8xSGx6d09IekQ2c0pmUGVwUWYzL1JI?=
 =?utf-8?B?YkJseU85Mk4wL1JnS3NZckxvdnpHRnpMV2dJUnNyOXJUUURYR2tPWTVBblM4?=
 =?utf-8?B?eXVvYWMvSndYc0txYm82Q09TV2FoRnNxOURvYXJScGlKQ216TjhWbnpuVEMx?=
 =?utf-8?B?aC9vQ0JDNTFkOVRHRlNWdk1KSzl0UDB2bUJSRm5yN0Y5OFRWcW9DUldtRUNC?=
 =?utf-8?B?bkdnd0FrM1JOOUhSSjVrcGNIaFVYVjZKRUVnbjUzdVZPRXJwZXEvRmw0RU41?=
 =?utf-8?B?TUx1MnJaWERyNnU1SWtyUnhHT3owRHF5RSsvVEJ2ZmhKL3hhbjQ1M0VJczBR?=
 =?utf-8?B?dzMwNUhTR3BBSnBIQ3RFQXFvMGxVbmRXM084UnV0cmRrdWszSzJwRDZGSjgr?=
 =?utf-8?B?YjJaemNUbGtzb05ublZLYkdKWm5WTXY2SmJRVDNRZC9PZ1NFaHplRVlzRHZC?=
 =?utf-8?B?YVAvRWlDcWl3WTl0NDNqcWJOUWtER3VkSkVUNkZpOUM5OWZHVmRLNWZNaldM?=
 =?utf-8?B?NWpHMTFMZkVqUno5cjlPRkJFVndFYkV3V3JWdFBTVGl2RW1DSTl4QUhoSnJC?=
 =?utf-8?B?U0p4WHh2WU9HQU5oVXY4TVg1THFoeU9NbVY1bGZoOG1vT3ZNbVl3YlpHYzk3?=
 =?utf-8?B?bkIxWkQzdzE1bDJSWUwxRG9qS1dMY1J2T1pFWGl0a2pqSnlSajA2OUV1ZE9G?=
 =?utf-8?B?cGF4Um16R3Jid2hyU3FyVm8zZmw3Vjlpbkt4UDVQZE10OER5U1JmY1htM3Jr?=
 =?utf-8?B?NXZMWUU3OEJOVzZLeERhdmRHSjI0WWFwcTZHQS9mL2xMbzMwUE1hV3BzR0hX?=
 =?utf-8?B?MXcvQ2E2cEpQWkZGN1lIOVV6TEJHZEtJZTkxeHVnMjg3bTBjaVdMRDBwOVN3?=
 =?utf-8?B?SWp3SVJxVU5ZcnR0Y1RLUXVvdkdtaGJWYlVoZWliTURxRU1PaGgvUndHWFM0?=
 =?utf-8?B?OTZNZGxXK1N3OXMvV0VYSytSaWp0dTdKZnRsZkU5bmVBWVFrNVdHWXdMNUxF?=
 =?utf-8?B?ZE83TjNld2dGMzZCQVRuaFdCUjUzLzBUcG9iemQwN0VtblVvNUR0L1RTdE1s?=
 =?utf-8?B?TlRKV1gwZDdIZTJmelNwZnZTdFFMaURSd1pRSnNEN0RRVWoxR1R0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa12ea7c-6df3-4fc5-5994-08dede4da5c0
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 06:37:00.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sz9s0NOC6Scdgp4m9rDU9uqJ/+3IWURLyqk82u8Wdtyyy39bK/PItJr888AS8srbKpIw3BsGEd9VsNM5t0ZQRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344



On 7/10/2026 9:55 AM, Nicolin Chen wrote:
> On Thu, Jul 09, 2026 at 09:56:09AM +0000, Ashish Mhetre wrote:
>> Nvidia Tegra264 SMMU is affected by an erratum where a TLB entry can
>> survive an invalidation that races with concurrent traffic targeting
>> the same entry. The hardware-recommended software workaround is to
>> issue every CFGI/TLBI command (each followed by CMD_SYNC) twice, and
>> that infrastructure is already in place behind
>> arm_smmu_erratum_repeat_tlbi_cfgi_key.
>>
>> Neither IDR nor IIDR flags this Tegra264-specific bug, so hardware
>> detection is not possible. Tegra264 is device-tree-only (no ACPI/IORT
>> support) and already has a dedicated "nvidia,tegra264-smmu" compatible,
>> so DT-probe is the only viable detection path.
>>
>> Enable the workaround on instances matching the existing
>> "nvidia,tegra264-smmu" compatible by calling static_branch_enable() on
>> arm_smmu_erratum_repeat_tlbi_cfgi_key. Document the erratum in
>> Documentation/arch/arm64/silicon-errata.rst.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>
> Sashiko pointed out a concern at PATCH-3 regarding the static key:
> https://sashiko.dev/#/patchset/20260709095613.831769-1-amhetre%40nvidia.com
>
> It's a false positive. But perhaps we could fold in an inline note;
> it'd belong to the missing description that I commented in PATCH-2.
>
> Nicolin

Ack, I will address this in v6.

Thanks,
Ashish Mhetre
