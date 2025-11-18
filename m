Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159B2D9487
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763445917; cv=fail; b=shjjB7+8A+oGssgL6eI8ycz/RWvkfxf0YAnVMLHatg7ck3q4Cfc1h8RWXrgb5Ueu6Pqckgo/YqdYfZlZYPeW/G//hnZ0jxJxVXu16y7+85dBoXhLUxEQVJK5fWiYoP5HBmwaL6Q5jUR1pgaoYKOS/mumX7LV5Cl0i9rhTJfMBiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763445917; c=relaxed/simple;
	bh=Dc8KWejCHxPja6O8P84psVW30+Cj46EMSWlV/8i2AI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HHJvPYXxCBWMWILzZVrC1TbuFJtFY6zH7A1IClolafsLsTXAXYMomWdt1SomsWfnOPuV+y9EGhSVsF9rKtMk9sC1wW5+75t2UyJlNLlEpWyO1TcvgbPF9bxPQKGJ7iFEgulj410DWPiLmmFgBgLUDZIzQjjwyPkwrlzTSRlTWcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0+LPM/W/; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0+LPM/W/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rp5tV5h2HNC9ogtoOZQK/sTckz1H0ikeXWFAgp+IeMf/kcOIB7zuO1D9ScedFcI5fOnuQpSInWnl4rjbGhtM6AXyFkqvtcp5m7nrnbDrhvqeUdzWlRjXIF2CEXzghyhPJ7EnN2gO6PzAfO+qIUTL4NICQ9/uAR64K5Y28Ms7O/GZo9DLjJZIVDd6oj4ylmrIqs0ZMFWn3nOcHfb0JkxxD/K/vtfElS3mGZqz/CfGcncBEwRz6G8IkVSFNppBnDLvox1jqujZAJ0wf0xI1vra899bIPE4UKnybNggoFE+AbmlM2s69xEVO+qfq0HfaYrKkNg9zBV7OcS7pR+9x3BG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMflpH945qeD7aLpYepHVErn63qkgxGOoOtjRieiGd0=;
 b=D9OcPtaQPv+m3RCk7mARUyl2IhYqF6EWGEOj3KgM14drziEkFK6fgF+NNuDqnSOnjE4G9sYTSpzZy8vCS7FjRXWOH/oEXvV3e48u8s6Fc2QFFewKJyBVucXiwNh/HTFtYmgYcAg746IVP4ofnIeByWcqw5CduA7uRWqmrxOoQT5pW291RQXghvK/qBZcdZCfHqckCT5DbpgyQB9ZtYQXlOXOik6IXBCu1l0VsZMqUoSZPj3VQKd55KSphpjQ5w6jJUjp3976XZHxKZ+Aar12i1orEzCr3dMWH2Zze0MfGmTy1l4utRBvaAyc/dbSGxm5dkfbqRYTG2kKLOhFFHEm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMflpH945qeD7aLpYepHVErn63qkgxGOoOtjRieiGd0=;
 b=0+LPM/W/kemwLsmu90Cp0XANyy5xKY/fpEOiJqawFK6dWKHLC2pkl1mb12hXCeDtRnQXT5SotNWx4rvhLQ1ax5c7jcZrifknxQrQy+nCWoDGGdYk+8+XElYddXEPU3mGKeclu7XXtX38qxaxCsmFlSRRKnCSYzHAOzOgQdDqOts=
Received: from CH0PR03CA0406.namprd03.prod.outlook.com (2603:10b6:610:11b::14)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 06:05:12 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:11b:cafe::2) by CH0PR03CA0406.outlook.office365.com
 (2603:10b6:610:11b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Tue,
 18 Nov 2025 06:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Tue, 18 Nov 2025 06:05:11 +0000
Received: from [10.136.43.114] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 22:05:09 -0800
Message-ID: <ff23e8d8-180a-434e-a198-b00d16884abd@amd.com>
Date: Tue, 18 Nov 2025 11:35:01 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] iommu/arm-smmu-v3: Add a usage counter for cmdq
Content-Language: en-US
To: Pranjal Shrivastava <praan@google.com>, <iommu@lists.linux.dev>
CC: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz
	<danielmentz@google.com>
References: <20251117191433.3360130-1-praan@google.com>
 <20251117191433.3360130-6-praan@google.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251117191433.3360130-6-praan@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5627dd-dcfb-44d3-1946-08de26686f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1lMaHdiOTNpdVlOSDI1OTVpVWZudEtOZkMwdmU3Vk5VYTBJUlJNNmNmd1hj?=
 =?utf-8?B?VndoZTVsUkNacWJvRklCZmFhOWlEOWw2a3RXQ0VxVXF5T3BYSDNHeitCdk93?=
 =?utf-8?B?SGhBNnpyVzZYM05wcXRYNU5jcmwwSGFwc0NEdW53bEV1WndYSDdFYlNBZ2tI?=
 =?utf-8?B?UHBJMkI4TkF1YW9tSE1iakhpc2JOZkZTRkxMdzZoS1FoWklSbEpodzViVmFI?=
 =?utf-8?B?SG1IUDZvc0VNQkRTZW9zbkRITkRNdUtTeVJQV1kvdERjMEsvamJpUE9zWWhZ?=
 =?utf-8?B?anRMZG8xdW92dlVuZUJCRDJabit1RE8xbE81ZEtyVlQxMUc4UGpvWmxsWlRX?=
 =?utf-8?B?bmFzUEl3N0wwNmxIZXM3bzNHS2lDZjY1SG5UOTFrZEVOZWttVk0xNzJDd3Fo?=
 =?utf-8?B?d3NGOUt5MlV3ZlR6QnArQXExekNVbVNsb1hlS3VYN2hGN2VVUGg3SmhUWkND?=
 =?utf-8?B?bzBUc1JJUUdtVDRnWFNVa2o5VkxCK05sU1I3b2swQW1Wd0lPQ2t3OFZCNlB5?=
 =?utf-8?B?U2p4SjIzZFpxbmZFQUFnTUgxZTQzQ1VXY21YV1hiQnVSTlQ0N2lmbEJzdWFF?=
 =?utf-8?B?WjFobmVhbnJKbzBBTUptU3phT3NkdGlVWFNLYVlRUDBXeUUrVm9LQ1VHWnpr?=
 =?utf-8?B?c3ViMERIVWJPNklPWGo5VmZqNDR5Sit2aHBxTnA0K2g5ZUNqK1FkdXE3MkMy?=
 =?utf-8?B?eUltSUtSWkVwVEMwYjJUeExwaUZYc1Y0ckVjZUJzM00rSEdLcnJVb0VWZ2Y1?=
 =?utf-8?B?UWZ3NTNadXAwSHpIdG53VE9oY05TTGo2SjFNZW42NDhqa1pBNE1OWFgrV1Q3?=
 =?utf-8?B?amxvYmtjRG00Q055cjhpcW9TWEcvZHR6UU16UXdxY2J4SGU0WXphTW8xazRB?=
 =?utf-8?B?ZFZSOXFSdkVJaWh0cGtCSVhPeWIxd0NaS0gvTnd0RVFhQ3plWGg4R3lsbkxv?=
 =?utf-8?B?RUlzV015NlhIZ3ZoY0x0Ni9zT1lkUmY5U0E5amt1THVPUW5INFJtS0NScFRu?=
 =?utf-8?B?aHJ6dmd4NVVHSS81bDRuQU1VQVFtVGVqVnRNSSsvSDVXYkxIV1hwSXBBVXdv?=
 =?utf-8?B?d0hpZWdWOElPUG9zaFZKWlArMUZ1RzZ6cnpKU0hsamhMQ2pDVjA4ODRoRHln?=
 =?utf-8?B?T2VORkFsZEFsMG03VnREbjU0ajY4cWQ3TFpCSS9DVzVlV28xZEhyZ3k3NHMx?=
 =?utf-8?B?QXNDRnhXWU81SjBNeHBqQW9EckNVSUN6R20xcG1BeThOUkYvUmgwYlFQQkFT?=
 =?utf-8?B?ckFNcTZGT2NnamJFSUdtRUh1bDYzQjlsZ1p2NGsxS0FNMXJzQmNRTnFiV1hR?=
 =?utf-8?B?RkFjYU1xaEg5alNtcTFXczJsOWZlbXFDZUREU013UjhPc2lWamNiS0dqNHFp?=
 =?utf-8?B?Vlc2YWlHcm84Z0JWbSs1bk1LeWhGOThpb1dzVnhpdFpJdUNxSnB0R1JtbFpI?=
 =?utf-8?B?Ukw1R0hqUkx6MHJ4czlIcUlmV2U1OVRXcFlHZklCOFpGaVJ2Mnl4NkZRMlFP?=
 =?utf-8?B?aHJIQ0J2c2VUOFo5aXdPN2Y5SWFKZVFLK2RKZFN1RFlwZUN5RkxZRmlUYVFE?=
 =?utf-8?B?T0o3dk4wTHErUktTNk56YkVxMFVZZ1pqdEt0NFBaRFBBWFhiaytpKzlaNHVK?=
 =?utf-8?B?WHVNdUIvYk9BUG9DVGpMaXQxRXhUNmZ1UnBSTnVCL1Vib201WW5oSlgxUmFr?=
 =?utf-8?B?NmszeWwwRVNpWXh5T2F6blNIMGFkcG9KakVKTURFUDdydmpyNlZDdTFmbUZ3?=
 =?utf-8?B?elVvSWp2TThqSmhZczl5ZnRYc2ZqZVJyWFRiKzlDUDV2ZGdsdTFCd2JMWUZP?=
 =?utf-8?B?MmdDKy9nbUEzZ2VlK0VCQTBHcnVCdTNNTUJ4ZHpWRnY1cURzK202aHhyWlJk?=
 =?utf-8?B?Q1VFZElGQUJEL3BNZWFZUVFtcGg4OHB3Ym9IUDhNMTU4TktIT3FUS2U2ZWl2?=
 =?utf-8?B?bXNmN1kwRmRUNXM2UlNMWEo4U0Zlb1ZXUTRHRHVKaTErV29PeXBqVWNpSjIw?=
 =?utf-8?B?YTU4R2F3UVNFVmdZRUJZbzBFUk5lOFZCZkwveTFxYUZEUzNRYXltUXVheU9q?=
 =?utf-8?B?OTFiWHJ3OTlUemc1ZURYVW5GaDRoRjN5M3A1dnV0eFB4Njl0MHZmMHZDTjE3?=
 =?utf-8?Q?5Pzk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 06:05:11.8296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5627dd-dcfb-44d3-1946-08de26686f4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301

On 11/18/2025 12:44 AM, Pranjal Shrivastava wrote:
> Introduce a biased counter to track the number of active cmdq owners as
> a preparatory step for the runtime PM implementation.
> 
> The counter will be used to gate command submission, preventing the
> submission of new commands while the device is suspended and deferring
> suspend while the command submissions are in-flight.
> 
> The counter is biased to a value of 1 during device reset. A cmdq owner
> or a thread issuing cmds with sync, increment it before accessing HW
> registers and decrements it with release semantics afterwards.
> 
> A value of 1 represents an idle (but active) state. A suspend operation
> will set it to from 1 -> 0 representing the suspended state.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 69 +++++++++++++++++----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +
>   2 files changed, 61 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 1d6c60bee7dd..d6e75d1646d6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -794,7 +794,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   	u64 cmd_sync[CMDQ_ENT_DWORDS];
>   	u32 prod;
>   	unsigned long flags;
> -	bool owner;
> +	bool owner, has_ref = false;
>   	struct arm_smmu_ll_queue llq, head;
>   	int ret = 0;
>   
> @@ -808,8 +808,15 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   
>   		while (!queue_has_space(&llq, n + sync)) {
>   			local_irq_restore(flags);
> +
> +			if (!atomic_inc_not_zero(&smmu->nr_cmdq_users))
> +				/* Device is suspended, don't wait for space */
> +				return 0;
> +
>   			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
>   				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> +
> +			atomic_dec_return_release(&smmu->nr_cmdq_users);
>   			local_irq_save(flags);
>   		}
>   
> @@ -868,10 +875,35 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   		arm_smmu_cmdq_poll_valid_map(cmdq, llq.prod, prod);
>   
>   		/*
> -		 * d. Advance the hardware prod pointer
> +		 * d. Advance the hardware prod pointer (if smmu is still active)
>   		 * Control dependency ordering from the entries becoming valid.
>   		 */
> -		writel_relaxed(prod, cmdq->q.prod_reg);
> +		if (atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> +			writel_relaxed(prod, cmdq->q.prod_reg);
> +
> +			if (sync) {
> +				has_ref = true;
> +			} else {
> +				/*
> +				 * Use release semantics to enforce ordering without a full barrier.
> +				 * This ensures the prior writel_relaxed() is ordered/visible
> +				 * before the refcount decrement, avoiding the heavy pipeline
> +				 * stall of a full wmb().
> +				 *
> +				 * We need the atomic_dec_return_release() below and the
> +				 * atomic_set_release() in step (e) below doesn't suffice.
> +				 *
> +				 * Specifically, without release semantics on the decrement,
> +				 * the CPU is free to reorder the independent atomic_dec_relaxed()
> +				 * before the writel_relaxed().
> +				 *
> +				 * If this happens, the refcount could drop to zero, allowing the PM
> +				 * suspend path (running on another CPU) to disable the SMMU before
> +				 * the register write completes, resulting in a bus fault.
> +				 */
> +				atomic_dec_return_release(&smmu->nr_cmdq_users);
> +			}
> +		}
>   
>   		/*
>   		 * e. Tell the next owner we're done
> @@ -883,14 +915,23 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   
>   	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
>   	if (sync) {
> -		llq.prod = queue_inc_prod_n(&llq, n);
> -		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
> -		if (ret) {
> -			dev_err_ratelimited(smmu->dev,
> -					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
> -					    llq.prod,
> -					    readl_relaxed(cmdq->q.prod_reg),
> -					    readl_relaxed(cmdq->q.cons_reg));
> +
> +		/* If we are not the owner, check if we're suspended */
> +		if (!has_ref) {
> +			if (atomic_inc_not_zero(&smmu->nr_cmdq_users))
> +				has_ref = true;
> +		}
> +
> +		if (has_ref) {

You can merge  above two if condition as follow

if (has_ref || atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
	has_ref = true;
	....
}

Thanks
Sairaj


