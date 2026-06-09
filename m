Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1863CF205
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988853; cv=fail; b=aLJyUjRORIn5Rd5MWm7Qm8Dj1oa6v4L2TlSiB/Vm7eWG/LtNFR/8vA7Rl9OV4wdjuZzoVpJ+TFImEULOQ/DUzY7NQju9buYJVodF7+HOoiJwuaBClGDj159htftt9OoJOcfd465GoxcI4noPbzy+3cThhqjWh9XU2kX8VjmYKuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988853; c=relaxed/simple;
	bh=n5Jtfc6z6V2Z9E+9v9nKtBPHzbA1SIgPevH5wji0J2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=le7u+sFTeetDG1Eocv7rrxCo95G6Iqessp9JtPQCpJdbb1bK7AAgAsKr65nzi4695vZpNYIxj9SOs65onmiwvtdaZIT5D9DUs1MpCxRZpRN+LJ8FbqPPS5PaOfjXwOz2ufRROHk1LGykvtzcSgQloeOL0LLBjrRf+aTyPenIFyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhtVonrD; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhtVonrD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3n1H0j0UtfI+hfYm9yDxkqJ8pp8s/Q/bzLPW91HHgRCs8MKp+Hfn+P4ZvXMeSLJo2AHvgmkhL82DhrlbWyB1rPAM1ifJl5c7ytxyVGDD/4zZDB7p+P2JHR10ZA3u7c/LoYObNsVeKo17erY2aKiTndd//6HjIUitrxBnE+jx498xiDyOTY1QZvCEG+r9bhOxFWSixnvT8DKAMtdfdFKz1oMc9YXp4OdPzW7y02Wt7PUTO62YuunNcmzmL8DEzhZ9CJvzu/MFUeogOt0uRI6xJrnCIkGMJlFOo8O/H+3tjT85KcsPJY6mKsHUSBJwfGeT+nD/WVM69cffNcdlf+lqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8eOdQ47/C63ifCJkaOMdV37o5D70yTP9s87J/oAZM8=;
 b=OCXf5tUSfy847F4lBMfw4GOmikfNk7QDKjGk1z5MFNjvZAFH1Q2qglRoGRqTzSMrYpR8cgDfuTEvxpyKQw99Ybm1TGLHnYVdAMmsoGWbgsJCsDCqemv48k2wf2IP2ZFWdFOYt1mpynMqCCyIbaewl3HF/QAVwpI76P9gE+FLmGTSmMynea1ZI9GMJ+In9dG0fPSwIh34e0UCG+UbDmtdd1dZauAJiTUp6HIZbushUX+A6yQErN0+7YOdTkQjFdQoBHBWjYnMy6YWitLkT+usAaU4G6urtL0YtfycXXjeVziMyvtrOfNPg9gyze9Tg/e5fU8yiHJCj9a4ZMg6hroX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8eOdQ47/C63ifCJkaOMdV37o5D70yTP9s87J/oAZM8=;
 b=qhtVonrDGqkpxqq0H9WrQ9CUApAkZSMKmoXc2HqlRsDAbhSr8c7kyjeq++j4aJAGj3wDO6Wzi+pJlR6yNCQErqgcRxkcQZDGQFz9IxxAro4aYvVpX6ROS5plxbbmXyClMHAyPtvihnT68RBgUtUfAD/QY6LSGC1LK88g9EkA7PP0psF25hEsVvbZ7F+SSstFwi/1oqGWA8nxNJ6BmuUuFuurJ0VX10BIcAVmo9aRqYnJqD6ov+K2DtWnOyhVNUg19opSQFahJUVrpEbzh6GjaMpUfxOR7MZz9DTKeFGGbNUTTp3wMe1fH7Ql1suSzIV5DGOKBoCFWUnpmgzvVxBz3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Tue, 9 Jun 2026 07:07:27 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 07:07:27 +0000
Message-ID: <53e0c403-fd0d-4f12-a9a3-2093fa7e922c@nvidia.com>
Date: Tue, 9 Jun 2026 12:37:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-v3: Detect Tegra264 erratum
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, robin.murphy@arm.com, joro@8bytes.org,
 nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-3-amhetre@nvidia.com>
 <ah85c4u011WNJQgE@willie-the-truck>
 <09a501ff-d1e8-4035-95c1-a6df9f0cb9d0@nvidia.com>
 <20260605141053.GF2487554@ziepe.ca>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <20260605141053.GF2487554@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc5a157-2677-48a7-7088-08dec5f5c375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wXLdVPJflbUJZZdenwPB5L0yERUOkcTxOL0rkKgh25Nph6Ig1FotBiaWW7GRYiW2Uurp/0Wz8mdWfU0MR9bbBxNq+RGOAJB+lMPlZrLm6bKfi8Ok3z2aQWHsA51Bx8IUXENhpphnC2FlVzpRsbr9zxKQwEmdHmFwSNS7ho8Wab/N0xpxt174RT2mVZubLYDdFL+5Nn6qCfnbzysEOBYeLBYAt7E7eM0OXCG2M1Rlir4esjSJXAVdUfdTnHYSFhkH+C0D/OrcDBtwXPQ3rDusaGMoIok6fRMF4j/VsBQUPl7qC59o0vRQn6juaCvr26dhxRWJ1HBuzD+iPAcQ4okJBrWwScL3OCiDJGF48v/GGmgv/F1TTbr/jV+vBV4Ysu/+4p28fePkO3U+sMoxQB74WDI8tpEQbnrHNcjxa4pAR7tOcYxbNKBUgliEND//1EW4aG58mGaXH2rXiUKOL7daGk2YDthGK7DkWcUnWXEIH/w6lq3W1ru1CJDiic5OwsLvOCtG3pbZuDFrVG+HmXThaXRl358Pl3FdpryfvrVxn0ib0YUS+TSUt3bZx5XxBkp3tmeOS7tFfTI8yZzYK+1o6ZA+XyCBjzji54LCGyzhmqLPEh0YJprdbvnV2Csqd/dpP15j24ANjaEPETRFYHNPnVFnhUfv+OVAsbRQkY79TLfW/5fScd+dJc9f6YIel2Zy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjNBRFdsRkdHTmdQc1Q5b3VMNW1Rd3E0UWNVTGZZVkdFclFESjRsRmJ3aUZU?=
 =?utf-8?B?S1NlelY3M1lKdEI5U1F2cFJ5RW5xZUovMzM3b0I2ZnlwdWZOMnlMZzV0WXdF?=
 =?utf-8?B?QkZRYWdtcGN3cC8wNm54VjBpbEtrSVdDQ2pwQ2J4NW1UNWgrSENGQXZDcHh0?=
 =?utf-8?B?eW9LWVltU3c5T2gyZGxaWVlrM1U0aDVxNi9ldWQ0c2RXekoxT1NPMUw5M2xG?=
 =?utf-8?B?c1hFOWpMUGhKOTg3dUhRbkw1dW4zeFRvWTVyZzJGTFVLT215OTFkSi82d2pG?=
 =?utf-8?B?aHhuYjdzUEp6REtxYXl3bHBvNFFnSHdOL3ZnYktQbCsvcDhpejdUby9hSXZB?=
 =?utf-8?B?SWZlekp6QkpIVVQrVlBuR3N4UEpSMndZOEhxU2d2NDVEY3djMzdaaWtvU3ph?=
 =?utf-8?B?RmJPZ2ErYzdWNmJxK05oVEh0Skt5NzRPZWp2WE5RL1ZSYlVBL3hCQTR4N0pv?=
 =?utf-8?B?c2dILzZpaHhqZER1SFJidGNKRmFYU1FjUU1OZUFWRWRuQUlyQlF0N3phdXNO?=
 =?utf-8?B?MGplVGdMWERSZGhRRHN2YmVmTi81SGdVbUxsUC9PSUxsL1lQNXpNRC94RzdZ?=
 =?utf-8?B?Y0cvN1EzSUpZWmdEeVR3MlIxZk5hbHBLejUybFliYVpNTGtZcUtpQVZqMm9q?=
 =?utf-8?B?OHg1LzdTNmdKNStDSXlGSmtGaVl0dWVseFozRGpadkt6bWVUeVVRNENJUVJS?=
 =?utf-8?B?MGV2bnNBMEF5cStyVTBETzZiV0gzd0pjQTNGYlV6MXBVTzJyNDVSSkp4ZlNk?=
 =?utf-8?B?R2lQZ0NGQm1lRVB4bGZsTzcvVTRhaGkzRGRQcGRKZStnUWxQS2dXc2Q1dTZ2?=
 =?utf-8?B?cE8yZW9XNmpISFhjaG92Nyt5TEdqNkt0U0t3RXY0OER1UmxQN2Z2SzZ5TXdR?=
 =?utf-8?B?TWZBbFNiNmhDU0RjWnNuSDl0eWN4c2Z4c3pLblBRZmRtRmJ0SnNuc0pDVElI?=
 =?utf-8?B?NTIrNE50bjNvb01uRmYzektFVWpHWEFsR0JjL1d2akZGYmpnZWF6L3Fqd3Jh?=
 =?utf-8?B?T1FnMW5nd0VOcmpKci9LWWk4OWFzUTVDd3N3b3hlY09XRFJKWmNiVWwrRGht?=
 =?utf-8?B?aFJ6NkFJN1RmQzlBSTZWcm9xUElJemtuR0hvNWtjY3VwbVhoT0lFb1gwUVZ1?=
 =?utf-8?B?YXVGWkMxS2FvWUtyTUl6UnBhUWtSZTV0eXIwNkhrdjBtemJUWEl3Z1NyWUJk?=
 =?utf-8?B?UkZzN0JiRG1ibUJRcXdFcU9qSmJzNXkxcFlTeXJPcjJNZEJDQVM1S1FiQjJh?=
 =?utf-8?B?Rzhoc25qY2c2MmZNYTZqZ01sMUhjdjdQNTFiNmZtNWp1T1UydHExaVlENHUz?=
 =?utf-8?B?UlBMa0NMd0krTHZ2T25Ka3RFVkJScGxQZXVOdXR0dmQ0OGRNTEFtQ2xnV1BS?=
 =?utf-8?B?R0VDdDlwd1VvTXhFaC9tdHQ2TldoR2o5Wkx3VUgvN2oyNktFeWpvd1lOWUhJ?=
 =?utf-8?B?TWg5ekJ6MkNVT3JpSGZTNlB3ZFR0RFpSMEE0UmNRbDY5ZTRPT1VmK21DM0R6?=
 =?utf-8?B?T002dnVndExWWlh5MVV2THdmNTJ5eGRVWDRnZURHaGpjL004OVN6K0xLeVlV?=
 =?utf-8?B?TGx6ZlB3eGo2RXJhekdPUzR0eHBsQ1pWYmRJREpRQlpZd0YvMHJJRmtkYUp5?=
 =?utf-8?B?aHZ1VjNZam1yVU15TW5Na01UQVBYVWN0RDU1ZmZQb3BRMDZGWTV5NWtsSElL?=
 =?utf-8?B?NjVEY3VJcXRmOWw5WEtEQTN5MzRpL3R4QXR0N3A1eTlra1VLRXkzdGthZHFJ?=
 =?utf-8?B?SEt0NG5yM1R6SGkrSXJtdGpKL0lpRk0xRkhzQTY3WHU4TlBkaGFKZGpQSW4w?=
 =?utf-8?B?YkE4aWJ1TmRWZkx1eUQwYXRWeVNFTzl6ZldzaUFHbDNLVGhtOWFRT3VyUnZv?=
 =?utf-8?B?bHNQVlNMaE9MNVZWREIzRkptR09hL2thTW9SYW1oVTFoWm9WTEVYWkw3VTVB?=
 =?utf-8?B?OXNtTFhIdkZDWVhmQi9hZnoweU1wL2xpL092RWFtZGJpdFpzU3VYSG9sb0ND?=
 =?utf-8?B?QVZya2MxWGNwdkxjS1Fuek9JbGFOcjBtS3RGbEFHY09xMXVBVklQeHY0YWQy?=
 =?utf-8?B?NlVmNWxCTFFiUzFRTFV5YUxIVGh6TzdWSlNLMEJRdDEyQS80dWRWZzJwaFVO?=
 =?utf-8?B?Tk9TOFNRa1A2SFZyMGJaS3RHNXkwL0ZOK2FGU1pCQUJCWXVabUtNakpoZWRY?=
 =?utf-8?B?T3F2Zm9FSFBuZzdteFYrcFdMbGE2d0RKajRpcERTVEdaQVBPWmlTKzc2S2V0?=
 =?utf-8?B?U2lWQ2RyOVRFRVMyeXY1NGJSelZ3Ny83NzRQQWlHRnRkSkd5VXNoUzRsS0dn?=
 =?utf-8?B?UUJqVlY1T3lNcHdMZ0JLQjUxdmhXM2I0cERtcjJqVHZVL2hTaVpnUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc5a157-2677-48a7-7088-08dec5f5c375
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:07:27.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mUckAP6jJ8AAulbOoEXL4QaI0bxipNp8BbmdVd7RgSQNzvYmd+kX0hnzR+vSFuHkecoycd2XRlM/SfuZIDkKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256



On 6/5/2026 7:40 PM, Jason Gunthorpe wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, Jun 05, 2026 at 07:35:35PM +0530, Ashish Mhetre wrote:
>>>> +{
>>>> +     if (!(smmu->options & ARM_SMMU_OPT_TLBI_TWICE))
>>>> +             return false;
>>> Maybe we should make this a static key?
>> Okay. Shall I add just static key and remove option bit, or
>> have static key alongside existing option bit such that
>> static_branch_unlikely will precede the option bit check?
> You'd have the static key and the options. Keep it simple, enable the
> static key once if any driver probes to set TWICE. Check the key
> before options to get the best code gen

Okay, I'll incorporate this in V4 and send.

> But IDK if it is really worth it, there are already lots of branches
> on the performance tlbi flow, and we didn't do this for other tlbi
> affecting errata..
>
> IDK if we really care about branches we should also be doing things
> like disabling the range/non-range paths and ATC based on what is
> actually in use..
>
> Jason
