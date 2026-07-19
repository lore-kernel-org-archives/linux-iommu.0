Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07AE226D18
	for <iommu@lists.linux.dev>; Sun, 19 Jul 2026 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784461433; cv=fail; b=Et+al7u9RKZWF3OuaBB2Y3UzDD8thlYWBZSznKrrIPxM17fvYWnE01Qv8wQ7PphPlWXGI/9GuCkH1SrpE44Vr9WKHWgeMCWpWWhjwYLELEcT6QZ7cPOItK1wKMDniq6o63oOUbBWFc89ghIxOzag0N3Erc6wlzlg/mysgVOXjwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784461433; c=relaxed/simple;
	bh=REGIjV2+FdiBa89Ji0qL0OjL7w1JjuNFyKcMvTzpj3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aDL/2gYqJfsuOwBbjmoO0BXtMatwJ4P1uiwnAxzuME0MOdj+YH+8fVGLfIqomB0TPkM3jghBpUFAjL4Lz5Vfv5AriQxvyLadRccyviH8+RQRbwtqxLrZabxyx5PGqxYrpywE0Y7Sys+OhMyqwgRf09Rv1VUbWL9O9WYanOTW9FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ddNjeHQu; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ddNjeHQu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8e29HrvTHAI2Hs0CfpmY7uk9GEpg1mm7km5yp3hhKpqhya3CMiTpIqJ7isSLmOwMWRWsPNZQKUpew750+TVlgFPtxHdKUXRICuKqpxih7bTd/uRd92MGok0TGBfltqnAqPFhJWE2yi2MIpHLVK4WslAassPmO87FO4TX3KCDp31gJ4X8k55LDtCmNfec8cnZGlFapo0pUsDVeb2t4MGoGiAfDCrxfLosMfp9ziyFP8vKSgQk6KVREpIJXekZ8dqR1s1eIAfYiwLjix0OW65uHPGQFd31RIqk+N47Msk9x54F+aPqxxxwG0CJexFP/jWKpxCaIvHeBDlppCaXx40HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UjmfBeURRC4lUa93QjRKQua+wbwHdwOvKOy7nJDlzo=;
 b=qJ+PNM+6nhhfDkF8/34InvPPVkHwTIc/Lj62D1QlHz2vS1JnJZT3SkokAKG7KXxQETFQBRsa7EaUcfinIpV1fdSMQhnjPd7PQBUym0y5rHxTN1V+6U9p6PCAEuuNNGZVB7M57ds5juImfJneDoLucZ9J4ugY9wfZUttifHnDCYZY0OiEg6nvUb9gJJiVyBerqX7y/YqOKLpHKi11dafrRaIvFwMlpcQMWS4/k/oqsaEyjKM+4nR1QJZ3QVK53AywGFDsK4q4NKK4hecZEBDp9oIbiGmrgmiMmOc0tlRqcwoj+p+JCmRaNr15T7HUwjZE7YIsvfIKzfKrpR9jPANAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UjmfBeURRC4lUa93QjRKQua+wbwHdwOvKOy7nJDlzo=;
 b=ddNjeHQuUsb1nhewzPdF1jkoPXkn0R9A6L8XmukhsFzE5d3ONFkQw76tK5uXx4SS5NyqSOUZfJL1lHwA4/v6A2RGvpOmYl7AJXgo13xd9Vi6pBd74H2nSJhFBcBrEP2it01nDrNbsu204iqno5LK+HuezOeZ+Wl6FEH29NpeKr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.16; Sun, 19 Jul 2026 11:43:48 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 11:43:47 +0000
Message-ID: <59d5a84f-eabb-49a4-969f-8f1d0e2e3b38@amd.com>
Date: Sun, 19 Jul 2026 17:13:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Wait for completion instead of returning early
 in iommu_completion_wait()
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260716141622.325032-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260716141622.325032-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0099.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::10) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e44cf9f-c056-4df8-e0bb-08dee58afeae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|3023799007|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bN7FJM1xQoia8oneO9saO3UvjPIeWVhhk+eakNcsVGwS65/Mx2MENTX2+RtGJbFqtkajv5lnzxxzML7Ue8/wcXj+xxZR0/0WEaXHFRCT2oSRTimZ1ziY79qJG2ecobt03M/dwHlBzSo5rW5l6nyLsWC9nHuYU8t9DxgrDYSP6dMOLTGDQV79MCLho29WqQPHPtwcDZiSZT4QaX0KrJ/C95EDOdqTcJgpg+vV9XNlXFT9lPQBGP2ceo3cRDeF/g4hEk4k0CPbwuF7zJ030MRQbkAVng7sMR2oWca5dHRePKHzm6rNUITU7ENVG4cfYCZbXP8k+/3RUuoDF5jEWOqt6p5wyyYGW6ZfgTfzJYPK5ovFhT7miSLemt7ubqLWzXvehISeH6aPJ+8GbUiljDy+KRd1Gov65uUj7aY4O1k8zs95wpKV9yvz0fLMdQEpydFmjw/OkdOEt4ZIQO4zZOKTFUVyFD7NwyxeGGUzDZIGap0luwgFRUJNx7Bx7rmSrg54hnm2gWNITt0foQs9ozVv+1AOHr/3wM7Ej1VBzp+rQFxS3o4l+yb/HlZ3R6JDmS8JOLAhS3e0YFdAnhUJyvGfUyO0nQXRj5UnTAtxACTaNAO03MkcoX8ytygzmoHxQgTfKmbkaOFg5YKmwBwh9DCNJByI5uwTWV68yjE79V/W8Oc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(3023799007)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enNnNXhCZmpwR0dvcnpzTTcwSERvVXNMZXNyTWZCVWVybXRGekZYc2dDbXpL?=
 =?utf-8?B?ekViNjBlODh5cjQ3bE8wcE9JRy96ZFdmNFNzall0WDR5aEtXTHh4a29pek90?=
 =?utf-8?B?emhSSTE1bTFsT1l1dHJzWllkQ3NRMGp6eEZCa1dDY2l0b01LWkJVdmpzQmgw?=
 =?utf-8?B?WlRzNk1JMGZWSy9YSnZSSW91VkVJNWtLNnJtdllRckFMMThmT0x2VzBWZDlo?=
 =?utf-8?B?UkNBa3BZQS9EVE5aWFhTajNLQ1ZGd25GZnVVQjF4cWd5UjNGVjZDbFZxNUZN?=
 =?utf-8?B?YytFVmY0REdwTGMxVTVSaHFUOXl6QkpmY3RzK1FXa2VPUEQ2NUpQWGRia0sz?=
 =?utf-8?B?akNJdFdGQnJKUDNaUlRTbmtOaGc0TUFVZi9MdHIraDZ5ekdSWCtOeW9vMDBk?=
 =?utf-8?B?MWpBMFQrTEtPVTB0UHk0S0Z0OXRzTTlQYnJFQ1I3Q1pZZG1oUjFndXVtb2RX?=
 =?utf-8?B?UmZMYlRyNlR0UmpOSmtJTnBLajZqdk42SU1pdlU0SndIaFYvT0c3cTZKbjJy?=
 =?utf-8?B?OGpiYnJqNXplKzJNN1RGejNEOTBwNC8zdUNyYk9tVHhzOUR6aE81S3RFaUlx?=
 =?utf-8?B?QWR5QU5yN2k1QUdLcVVIekNrdjhxYnR5M1RPS1dHY2hlZ3pqeUY5SkgxNDkz?=
 =?utf-8?B?cnVyM3lXc0g4ZFJoNXQrYXVadGM2Nlp3MnhEandNbUxtWkY3LzMrODlKb04w?=
 =?utf-8?B?eFhmTUl4TGZKNERldHJoVklwNzkvbmR3VUJSV1hKa0t0blVmV29ZL0lrb0Y1?=
 =?utf-8?B?NWpDZEUwUXg2ajZBTHUvempnanRpZTJKZ1M4K29FeUh4ZEt3elRUamprK05G?=
 =?utf-8?B?Uk9wVHphc2VoS0hUWFZXTmN2T1QxN2tHa3F3bWg3Q3dzZlViZE9oNzFCbzZs?=
 =?utf-8?B?aXFvakZJWVJxTlpRc2NWQkFJOFEvOWs4UGRJZkQrVk12b0hFMFR0OGpPSWh2?=
 =?utf-8?B?SGt6cE84UFlhL0dRbDF2a2hZaVE0Q2w1SHdSNUFkUHB5dTQyZnZXMnNDRmZy?=
 =?utf-8?B?R25ZZC81cjZ2NHlXMkdGalVDOHRwcHBQOGtrNnFrR2NnMUx5NDM4cktIREM4?=
 =?utf-8?B?Q01XWWVxL3pweDNLRk9ndWc0U0VFRFJ6RE1EWEhueG51NDhBY1hXa1hVWXd4?=
 =?utf-8?B?QlpDL3ZKWWc3cmJwRVV1YkZCd05hVFNuelpaVnU1MUtyL3g1UE55S2puSWth?=
 =?utf-8?B?bjNBN1ZiT0RDckxRWk1vRUJRUFp2ckQ0MjdBWUtIYnBoWDJxbkkxTXRhN2xv?=
 =?utf-8?B?ek1keEMyWnZjTDhrb21vYUxSUHpyenc2SFFKRGZENngzanJuYWNTL0lyWGta?=
 =?utf-8?B?ZkNGOFVtSGpJZGlZWXFHMkZodzZMM2dvaTFoaHdXRHc2ell3ckJsaDdSaCsv?=
 =?utf-8?B?Wm1NaTc4SXRaZSs2ZSsycWk2cXovQlNPeVZ2dW9XWDl4aytOMmRXVytNSUNu?=
 =?utf-8?B?NzJWQUdKbHY0aGU3SHdhR2pQSmZtL1lTZmhGYkMyczRsVmVmZnhWdW1FUys3?=
 =?utf-8?B?MUxxQVZEbVJIZUpHbFZuVVdHeGd6cjl4cnBYNnoyOHVqb1JVUUtHN2F0UXpC?=
 =?utf-8?B?ZUo0QXZmWmZkOHIwUVc2YTdnQnZ6bS9JSWJpc3I0SG1zN1dWMTdpRnVPSjVk?=
 =?utf-8?B?My9xNnlBdDkvWlV6OUpqTTFkMzN4WU9mL2FKdU1tcStuVzdTU0VsRWFYRzhU?=
 =?utf-8?B?SDc4VThON01JK2thbGpFY0lBazU0SE9jWUQrR1p3QjVjV3RBVnZPRENsM29w?=
 =?utf-8?B?VENMUmltVGdFUjNxV2wzQTVMMkZUazdpUFN3Y0hyQm5hdnYxYSt3OEIwc0Jo?=
 =?utf-8?B?b0QyT2JmQVQzS2V2UmIyZkR2UkE5WENoSUpMa0FIMWE0NVIvRzBSSUduUzlI?=
 =?utf-8?B?OW9GelR5RHloZExnbEthTDRmWFVidXB0amk2VnVHUEhoZW1SK1BPakE1Z1ZM?=
 =?utf-8?B?VzRjTW02WmVFZHlydGhlUUJPUk5uamZFY3Q4UGNnT0p3Smd4cWNSbzNhek9O?=
 =?utf-8?B?QTYrS004Z3R1MjB4YjhsKzcyYXgzNk10amhRcGRnejUvSlNPR0NhbEYvMUpz?=
 =?utf-8?B?OHVCOUNUeWJLaHBCRUZiVUtmZ2dZSFRXVWxqQzh0cnJlUitId3ZUSUdKN1Br?=
 =?utf-8?B?VTNsd2RJQm9URElscGNlaEh4N1NiNUlSazRza2h5cFZmYU13N0xxWVE5V0Yy?=
 =?utf-8?B?dVlRSlF5NyttdEk2MVl4Zkt0TytjaTFqd28wNGtZQlpCYU1BczFFZklPd3or?=
 =?utf-8?B?OFFPakN4cllqK2JlRUlJQi91VHpTS0xHSFVlY01GcENXd2x0cHZ3MlNTc2xO?=
 =?utf-8?B?MDJwTDA5RllaUnRHbFE1ZnZXLzhZeUZpbkUwMDBoWUFNdHFUZEtCQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e44cf9f-c056-4df8-e0bb-08dee58afeae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 11:43:47.6256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81szM8yxdFkRAjY6NYPqYJyoSSIIXNUyFU+PPqdDlTf9k+Y2xEjMeJ4OzKdKRYC/Xfd2NhJBiQDH6Z9Bp+VX/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281

Gaunghui,

On 7/16/2026 7:46 PM, Guanghui Feng wrote:
> need_sync is a per-IOMMU flag shared by all domains and devices behind
> that IOMMU. It is set whenever a command is queued with sync == true and
> cleared when a completion-wait (CWAIT) command is queued. However, a
> cleared need_sync only means that a covering CWAIT has been queued, not
> that all previously queued commands have actually completed in hardware.
> 
> iommu_completion_wait() read need_sync locklessly and returned early
> when it was false. This breaks the "block until all previously queued
> commands have completed" contract in a multi-CPU scenario:
> 
>   CPU2: queue inv-B                  => need_sync = true
>   CPU1: queue CWAIT(N); need_sync = false; then wait_on_sem(N)
>   CPU2: read need_sync == false      => return 0 (no wait!)
> 
> CPU2 returns without waiting for any sequence number even though its
> inv-B may not have completed yet (CWAIT(N), queued after inv-B, has not
> been signaled). CPU2 then proceeds to, for example, free page-table
> pages while the IOMMU can still walk stale translations, opening a
> use-after-free window. This is a logical race in the meaning of the
> flag, not a memory-visibility issue, so barriers alone do not help.
> 
> Fix it without losing the optimization of avoiding redundant CWAIT
> commands: take iommu->lock before testing need_sync, and when it is
> false do not return early but wait for the last allocated sequence
> number (cmd_sem_val). Since need_sync == false implies no sync command
> was queued after the last CWAIT, that CWAIT is FIFO-ordered after every
> not-yet-completed command, so waiting for its sequence number guarantees
> all prior commands (possibly queued by another CPU) have completed. The
> common path with pending work is unchanged and no extra hardware command
> is issued.

This is really good finding/fix. Thank you.

We went back to investigated when we introduced this bug in kernel. Looks like
its very long standing issue in the kernel and for me its pointing to commit

815b33fdc279 ("x86/amd-iommu: Cleanup completion-wait handling")


We have to add Fixes tag and CC stable so that it gets picked up by stable branches.

Currently we are testing this patch internally and we will get back to you soon.

-Vasant

> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  drivers/iommu/amd/iommu.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 563f9c2672d5..29dc18d3d22e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1450,11 +1450,23 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
>  	int ret;
>  	u64 data;
>  
> -	if (!iommu->need_sync)
> -		return 0;
> -
>  	raw_spin_lock_irqsave(&iommu->lock, flags);
>  
> +	if (!iommu->need_sync) {
> +		/*
> +		 * No command has been queued since the last completion-wait.
> +		 * A concurrent CPU may have already queued that CWAIT and
> +		 * cleared need_sync; need_sync == false only means a covering
> +		 * CWAIT is queued, not that all prior commands have completed.
> +		 * Wait for the last allocated sequence number so that any
> +		 * command queued before this call (possibly on another CPU)
> +		 * is guaranteed to have completed before returning.
> +		 */
> +		data = iommu->cmd_sem_val;
> +		raw_spin_unlock_irqrestore(&iommu->lock, flags);
> +		return wait_on_sem(iommu, data);
> +	}
> +
>  	data = get_cmdsem_val(iommu);
>  	build_completion_wait(&cmd, iommu, data);
>  
> @@ -1464,9 +1476,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
>  	if (ret)
>  		return ret;
>  
> -	ret = wait_on_sem(iommu, data);
> -
> -	return ret;
> +	return wait_on_sem(iommu, data);
>  }
>  
>  static void domain_flush_complete(struct protection_domain *domain)

