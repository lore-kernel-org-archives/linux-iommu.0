Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F52D3A7C
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 04:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782706314; cv=fail; b=gqQ1hplRrv7g82cc+opKpgNjwElamIM5yRG7dCD6YWH+wbysQ4DeNoadw3c26KfGcVraUpTqu0m+IiGnNv4JFJvc9sAH9sTL0aJye0qXORgTKtBQNPEnESp5FuSUiopnojt0Oo/I5kmJ+Gna3tqMZSjSH109cL7I+GgveyDf1Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782706314; c=relaxed/simple;
	bh=sOWqlvQpmSJnnGW56rADHE+xu0w9er1xi8DTnKUxOTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pnKpKCXh/cEaydcqZFhesblGO5OBY28EUUx9fW2Xx1ITHUuOVaczQ/697Xb5o+bxTxL/VwX3r1UflKPV0C7BBq1MS1wahWnuxVK8eCd/SaBzne0iuIeNewE68NBGyoAguCAhVzweKrIfeU3zQELavn1lUT/R1KcUAblh5RrvTlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mCScHcbJ; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mCScHcbJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYaIhF4T33CzHDXyH0sx9v13gXxrsByUpOWcVEttg1Ha7r3hSRz35Jjw59XQmH8sT2IteQF9KxU07n/Hsg/W1uu3DnsDdvB8XbLgINU9WJfhGayNuY/tPMHgeYRAVvBSoPhfe48wXFQ5OORjLjMNHIHpn/ItODQQEKdltAtJoLwuxAXe/nnDHPz0d/ttja5C4c6PlKyNPzQb6ruodCRp3WSUXMhkeqRFq2jEyEliW+dMCLmu4nZsRu2R9nbOv/zb/MxI2CBYxeZreTRO5koRkjAivP0HxQvlsd/XsADygF0ha03Cut7Dcc9PBv7MP4E28/BtCAeJJK10ktPmNHrB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pz89TBeX3QXzH2bUY0La65de3pffYcMj1za9ZWqqVWo=;
 b=db6eBLsgErPBOLU3U1sHdMEvTZU2/wA13QSrtLr0KYJDZIdiCtg1Ki9tWAIxG0Tht/7VCGojwseGOQuqOkp/XufE6tM6CywSH71hzJTxYJSY8EsgkieBk0llaAoVzdVDHN/rmvvCdERtmd+iGD6Id/nCiYc+qkHfx4HgBlm81bZJkl6p8gbLRAt5+aMDT4Go7tPlv7RHTE/gGZgAH0oPg/E04oI0fz6YsX/kmC1tQEY/cxobCdsxW6KxmxZNUxa++gOWjPhQB8o+TPS4cT8eUAycg266E0u1q2YrSEHApVmmYKwXfeu1sWdF+BuA+loi12AfuLBcHEYYjsftqud63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz89TBeX3QXzH2bUY0La65de3pffYcMj1za9ZWqqVWo=;
 b=mCScHcbJcEVRqEhu9/7gfPLC+J21xSMp90Zv6FABG7WsEoDQVC4djRKaRzrOkcdzyIvl8LlcX88w34NofVgwM74cX8RKkeZlyspTqAsYAII+dVX4mNHGwvnKuFN3NVJYh6hr8CzhxNeLyIeGUm7Y4n+ua2aupRlIBSCiaL5peehMbw3LQV/KyJOSDnWnqfQ7nK1zIG1ftI8zQ0gBpWosdX9BmPgcIn2T5SE4iasY0iGwd4VzxTtW/6ZFtcMNed9Z6zt7BpnO0bGZhkLhQL+sgT7Zf7pKGLctF7xpR4ro1Z9i6/9Q/xQfrOXrsTVbB0lUnRExSNRYMT6zAa+0aPYwsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 04:11:48 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 04:11:48 +0000
Message-ID: <4d33d46e-ab98-41ef-9777-6ee5b5aa44fe@nvidia.com>
Date: Mon, 29 Jun 2026 09:41:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] iommu/arm-smmu-v3: Tegra264 invalidation
 workaround
To: Jon Hunter <jonathanh@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260609073204.1760077-1-amhetre@nvidia.com>
 <97b4dcc7-3ed3-47eb-ac38-51fc2dfb6480@nvidia.com>
 <ajIoc+ek3S1Vycxk@nvidia.com>
 <96959efb-051c-411a-810f-927943d5491d@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <96959efb-051c-411a-810f-927943d5491d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: b92f0a5b-85eb-488f-93fa-08ded5948a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	w34XVyfaJnQDrdIFYHVpCBqChlFGAHb4lzUWAS+fxmv6NCLU/Ysxwogch15QyVz/2zofaPpv1UkUIimOKWeo15eDwdpodSytF3M9FXYnf1M7lL78ZdlBt7xOtGaqm+pWbjzlkrRjRZXeNlGrHJ4lUzGt6M6IkwphdgDPQxWlqK2rmMvZdujXTz12HiTWgGtr3QYzQRGWnQuSD9BsB5SQEt7Hn1sE5zZbxwbN8D2oUOYgDLSpXdbwCgHUp5BDFy366QedLfGRcGfcXWcCM3Luk+iroxyS2n9xx4roPy6x/KcMv0M8bnphXFqo+gYsiFtenB/MwJr/Beqbn6MuhWGmlm6Vq/s3QvObCDIrOqkspCVye2236awggKkf1cIncpCJ5RcSj+wxcfoMYFhHm0mrbYgrtJx6239d0TNTeUgcB5mtqpVbPFusAeekXPNeQuFa0IlULcTL4aWBJXdTDI8yrVvK/fwzQHURaJbqPec22HilR3vPGnLUXOx6LIw8haVsxUukZLehj0WqRTM+o1MllA57+6KKl1KJe+VvqyiZkCo/rMFaJ8KLZreUVo1QAi/YOGWT5ZM/A8Vpl+QhUIYH8Ssr7+yNmeVnLkl8m1hxRdcj0GJxedyX6URBDpTODHC8xXTcVxq1kVIulPAIeNiQl0KuU8Z6NN3K1GXIAiB81cQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFF5ZngvTGc2Z0RKRjBnQVNISzlhVGRldUt6emRFVHQrVzdITnB4R1M1d2hk?=
 =?utf-8?B?emh2U043TWk4SmQrNnIvMHFnMEtsT2ttYi9uNGhxWURHMk5TMXhaek4zVk5G?=
 =?utf-8?B?UzRrRmN0UTFUQWQ0TzRWSjdvQTdmSE5QdEtURFFqcVZYNzQ2MG5VY0tmZGtR?=
 =?utf-8?B?WnpCRWhhbnF4Nnd6THlNcURpeUVJRHdQa0RXbHFCSHdrd054eDlyWE9HYUlo?=
 =?utf-8?B?V3BxZk1xQjJVaFRUdm0rWVFBZDA1bkxEVFRjVzJHbkdYYzJLVUlIWmN3bkNs?=
 =?utf-8?B?NEd4VU8zVDBKY1R0ekloTWRlWFF1aVB3eWVHZnBNY1JlallJZjRZZVlnZTJj?=
 =?utf-8?B?Q3NlWlZZcWppeUYvYnlTY05zVjlKZ2I3QzNYODdZM2Z6UXUxSDB1Z2krekRN?=
 =?utf-8?B?UCtDNDd0cmYvWFBBd3dEZkUrbEFRd3FnZEFadkcyWG90RWM5MXF5QnRHRUlZ?=
 =?utf-8?B?WjJpOFlRUmtLNXVpNFFEVm5QRlk5MXppQTBPcXZzQncrNVlxSnFud2Rtc2NG?=
 =?utf-8?B?YXhXV1R2UFRVcWFjT1NhV1d5RU5QK0hJM1lxOS83T09sZThMM1BpRzBPaFFD?=
 =?utf-8?B?T1NzYmlNdG5XVGoraHFyVnlKdlFpZUQ5VmQ3R21TbGQwdkpvSlg5bTlnQU1E?=
 =?utf-8?B?Zmw0RVIyQklWZHlXMWdLUytKOVNJanRwaEwyNnErYTlCTUJQK2k0OE9TU3pq?=
 =?utf-8?B?SGkxQ2EzS0VsaUlnMHYzS1ljMTI1QWtRcnAveGJuUUhsUW5za2tMR3ZwT1RI?=
 =?utf-8?B?bkw1MTZ4NUlVa29oQmNGWVVvVXViS2ZsNitEb2hBVzQ4N1RubmFzdVM5OG1l?=
 =?utf-8?B?c1BsMm1XMjFTY0pjMTFzbmFpT1RoSzBuMVFLTURUc0cwejNSZHIyeEVreWRE?=
 =?utf-8?B?cTZiek5qcFIrRWc1ZUNUTjFIdWdVa0pzK2FCUnhwWjNXNmxHLy9zTlh1RjFt?=
 =?utf-8?B?cVN6K3pGUG5Jek9KQjFkbkpsREZDdUJyaEpCaUFObHQ4V29URVNtVS8rV21X?=
 =?utf-8?B?SDNsYmZmeTJDU1crT1d1MUxyc0ZGdlhTOEN3MXpkcTQvZmxuMUxzaXdid3pr?=
 =?utf-8?B?K2x6dW1Cakp6MDBFdTluUnBvN0RJWUtQMlFrYVBkNzY4U2FRMEgwckxKVHpI?=
 =?utf-8?B?akJzTUp0dU55bzM1eERzdWxCL2VlNGJzQTJWMWphQUxsUTVDcUNBMkFONjE5?=
 =?utf-8?B?UEtQVExTdzY2RStuQWx2eU55ZHZuSVV5MXZIejFkeEM0ZWdMR1R5L2xBRGY3?=
 =?utf-8?B?blo3Z21YbWJYc21oTWVlZmtRZU5ZK1gvcHJ5K3JKOTNhR000TStyWXFFM0JT?=
 =?utf-8?B?dUxLMS9ZQUkwN1JPL1IrejZUeWlmMnI3eGZ2aG9xSmV0M09CVWo2dDFhRE5M?=
 =?utf-8?B?UUhBKzQyWmhON252aGRFOC9Wb01oUXBLZGh6dFBvSDkyVmlLZ0hTZ1FycUhT?=
 =?utf-8?B?bEgzQ0tQS2UxeVdURUpSbEQvdGU3NEhCNmcvWExBN2Q0dVNITUZTR1ZtVDB0?=
 =?utf-8?B?M0NINnltMUJaWlV5YzVRME9EeVVaQXZ3ZmowZC8rY25EWW5leGdSRldMbUpM?=
 =?utf-8?B?TkZNMlcvQU5UUUVucW54ZEhxYWhqT1kyMkpaQnQ1R2t6RnFLV3hQc1VqUmVs?=
 =?utf-8?B?NjRGZGZ4WVFja2Y2djVTcWVwYVBYSkRDT0Q2OTZYUVFIV0FwS2twMUV6eFpN?=
 =?utf-8?B?TjNPQnZ0TlVTMC9DaEV4TGxhVlVJU2NIZnoyZ2JmZ0tST1c5VEZtMTRZckJl?=
 =?utf-8?B?MmgyNUZzUWVYMTkyakwvby9velg3Q3FyMGM0aG9XWjhiSkZDb2k0MzFzRk5a?=
 =?utf-8?B?ZzFnRjcrek1maVJJTTNIZ0JzQ3o3bW8rajk1YTBld3RLU2tGdnFXZ3dIQWsx?=
 =?utf-8?B?Qm5MTkpENXBVNm85UHpGVDEzV0NkUmhMZDRaOWN4WmlKZXVTV29UM0RvTWVk?=
 =?utf-8?B?RTIyRDRFeWUzd3JoVytzZGEvWGRZSmNPZVcvaGEwekpZbm9rVCtOcDZ0T1R3?=
 =?utf-8?B?VEVUYkYycy9mV21BOGZZN1QvcHJuWmNJYUc5cTljbytWVVNEQmczMndDdGF0?=
 =?utf-8?B?azVPbTRLMG4zNHFwSkNxSTduY2twb1FWa0lTMzJSMXdsZmF4NHd2c0wwelNF?=
 =?utf-8?B?OVR4aVBRcFpRbXpselVtaXM4aUxaYlRFRlhic1V3dXp1djV5V2dHRFlNZStT?=
 =?utf-8?B?MSs5YWhkdzR6RStXbm9kc3hqWjlFeitHNDMrYmh2c0hzVUVZR3BlNGs5L0Ro?=
 =?utf-8?B?RkVSaHV1ei80UXhVRjJyVmFDWS9hZnZseDMxQWFHZWhHTStTK0ExcWFoNGd4?=
 =?utf-8?B?MEdWYVN0eFBJOFF6QzNKMWRpNmZRdTRvUXAzNnNjYy85WlRIL1lCZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92f0a5b-85eb-488f-93fa-08ded5948a4b
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 04:11:48.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ula/Buz4BrnPiWn10P5CsojNBt1pwuKVesbXs/JEwc+BdNYvNnA/sofpyK3vsySsinH7CcRZ5XeL7IC1VkNbQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989



On 6/17/2026 1:51 PM, Jon Hunter wrote:
>
> On 17/06/2026 05:54, Nicolin Chen wrote:
>> On Wed, Jun 17, 2026 at 09:28:10AM +0530, Ashish Mhetre wrote:
>>> On 6/9/2026 1:02 PM, Ashish Mhetre wrote:
>>> Hi all,
>>>
>>> A gentle reminder to review the patches and share your comments.
>>
>> https://docs.kernel.org/process/maintainer-tip.html
>>
>> "
>> 4.2.9 Merge window
>>
>> Please do not expect patches to be reviewed or merged by tip
>> maintainers around or during the merge window. The trees are closed
>> to all but urgent fixes during this time. They reopen once the merge
>> window closes and a new -rc1 kernel has been released.
>> "
>>
>> I would wait for rc1 to rebase and respin.
>
> Assuming that they need to be rebased. If they apply cleanly to -next 
> after -rc1 is out, then there is no need to rebase. However, 
> definitely check.
>
> Jon
>

The patches apply cleanly on linux-next-20260626 and rebase is not
needed. Can you please let me know if the series is good for review
or should I rebase on latest linux-next and resend?

Thanks,
Ashish Mhetre
