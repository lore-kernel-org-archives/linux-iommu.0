Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA713AA27
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034291; cv=fail; b=j4dtVsHSKDjwdNJ1yHCfP6baH2uU/+vAaojGSJ+DQRkcRqMb6tYUtAOYPp/SG4tcbiOAn4WqOGh2GH5rjDfeK2BMjmg+RkVv8h5c0hgntFEqbOS6T5I2Nzh7IBO80xwyOp/obnx6AESQ38vf/Qa8mwNIOApC/syw4m7gOwpSk0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034291; c=relaxed/simple;
	bh=/NUM3Jb33evOsN7hN2BhM7pmZDzzbgY/JCkq2KEI9IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bu6IoUjXo/+x0CGkLCix8lHp9Fxjn5/MyyjGPSk7H47qO7RJo89OvjbXqtfee5j1cQP64sXMGm9soEAsEszjIwSivXfVigVMuG0/pAAyB4lgjISZ1i8eFou5AEfU6M1qhaTpw26TdSxiRWBQEG4dx+ZGuQN5hLWHvQUHwgIWeEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oH2L0jlW; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oH2L0jlW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+/e867xygtU8Lx3QEfELAVlEqzwKn90gETlrGF21cRdFsFT0WIEjPufYAaM0KOs9DojqPvYO1js5dS0UWAHL6aOdtqxPcbHwkS0puTh0/SRTcd7s8Uh6shhUcg8+6ti6Z2V7GYDxhuR3VYWVugJfHjXnB/PMzu953jDAMnGTJYnxEb+WxjPOcUQ6JlANGTJMjxkOnPbcl3PPsztf1joPNZ1D5r//5uCUMVXM/AWmPgN/8TsM4wo8d58uJcHPSUgHfohfq5UeF85mvE8V0C1DZaTbYoDjHh0WSyw4KSuiiJFTjpQapOrPCF/S2E/8Fs44+vUj17axTmWKpFvRmYgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHKSGE7bqTwxOThNRGVCJ3L2fkYcFSwXur2DfKNEycE=;
 b=g+ylzZVDP4Op/K2AKwOD6GE74aMBfbQwDmC5YGJ7pxQxTJ6VbO+7QM+GYf0MKdu1m7tIbVzSzH/iurz4/kv9BqMAFzkLzuFCg4Q8spuBdLfQZou5EGNcMjlGDtpdG6NQJ3wChVkthHjDiCuTdVN7vOm+oBK3zR0R1T4lsSie8rM9moydjDtsWxi2E6PsxpMMIY+65EGwYeT7sAdlso0ruU4O6cvweGx+IzBgNE5N2m4v+s/9uCsp4Enr6TaL8USGm1EMYy8wIBvX0hz8spC5H6mlIT2oN4X3AwlYEgrJOnC9Y9LnzvXlagKmzF/oyoIHnUN5vJcPTpBJYyN1oWBx8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHKSGE7bqTwxOThNRGVCJ3L2fkYcFSwXur2DfKNEycE=;
 b=oH2L0jlWOpra+4jlaFcrFts8b483GsVdDK2O0tv9AcTFdlB/ELSJy5lJoYmI9gvwv7BAqkENeAEIE2KsZ8ep9+z8lKfJARZZtm8y4/PauqZKFyqBBvChsMOJeemmnocC3v5e1Q6suqcAcaIA2fW5PVi26EzgClJiD/8Wt/45Gdg=
Received: from MW4PR03CA0218.namprd03.prod.outlook.com (2603:10b6:303:b9::13)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.28; Sat, 15 Mar 2025 10:24:46 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b9:cafe::5a) by MW4PR03CA0218.outlook.office365.com
 (2603:10b6:303:b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Sat,
 15 Mar 2025 10:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Sat, 15 Mar 2025 10:24:45 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 15 Mar
 2025 05:24:43 -0500
Message-ID: <2370bf6a-dcb3-4275-86d6-1d67329c01e9@amd.com>
Date: Sat, 15 Mar 2025 15:54:40 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] iommu/amd: Replace slab cache allocator with page
 allocator
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	<iommu@lists.linux.dev>
References: <bc412a4f-5031-4c6c-a1ef-8bce170afbc9@stanley.mountain>
Content-Language: en-US
From: "Arun Kodilkar, Sairaj" <sarunkod@amd.com>
In-Reply-To: <bc412a4f-5031-4c6c-a1ef-8bce170afbc9@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: a69ec87b-1a80-4c31-273e-08dd63ab9b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1FOZElLOVJSTTdxZXh3VTRDRHpiUXprbis0Qm9SUTN1TS9BTldKRm5NTGQw?=
 =?utf-8?B?VkFIbm4wNkxqV0xrRGk1ai8ydmYzQ2ZhTi9zdk5hOER5MUJONk1ZNDI5dU1G?=
 =?utf-8?B?c3d1Y1d4MnNUNTBuUGFwOUpMQk43anRzZm94K1hybllmUmFoSHkyUE4zdG9u?=
 =?utf-8?B?V2wzbVhJNTVBZGl1ZVFEN0dDSWNPZzhaY1ZveEY3RHdkTUREQkN2REJ1V1l6?=
 =?utf-8?B?MFRIUEpUZjhzaDlGTzZINEpZTlQ4S1ZjMjU5UVVvUy9Od3BDNTMzN09WN2RY?=
 =?utf-8?B?YVY5SnNBTGE2eTJVM2FlejhkWGtrV0FEQkhDbm1SRnpEMkVGTzEwL3RmK3pj?=
 =?utf-8?B?djdFeEZmaDFlQVF4blpGdDIvZVZXZnJ4Nyt1NHJrMXpGK2RxaklwOHZsUEhz?=
 =?utf-8?B?VTY2Um9iMEFsTUQ1U0FuelNxYmhZTmpyU1hubEY4eG8xSGU2UkRNclJ6TzVp?=
 =?utf-8?B?OUZQT0gxdUx0VjBUODF1UGNHbUhoMjhhZ3BhcGxhV3pCZnN4cGM2ZVdCVVFG?=
 =?utf-8?B?dExBSjhtTFRub1RWQlF0NlJBSzkydzk1RmdiMU1nMm1SZ28yZ3pjRTk3WTdq?=
 =?utf-8?B?dUdmUTlJL1B1N09wZyt3Vi9jSVFpditCcWhjaXo5d2NZY1lmVmVOSlZTWVZE?=
 =?utf-8?B?cWVab1FOaUpPWFBKc3R3NDZGZVVZdTJZOTRGOUdzNUZnRjhuZlhrbkNRU1BM?=
 =?utf-8?B?SUs5QmlZanFISHdKa1ZRdHZWV3k5ZjVxOUhzemFPZmdrWm5xVXZaYjIxSEd3?=
 =?utf-8?B?VTNYc296amtnMEZCMVJjTHhiY3BoZm0xbVdVOTh3QndIU3hlMkV4R0FuVC9F?=
 =?utf-8?B?TjZKZ3Ayc0w0bjhkdTVCc0s0YVBtc0dJbU5vZGdtNGh6b2FOWnl1a0hrRHNV?=
 =?utf-8?B?S3pSOHcvWDlyakJ3Zk45R1E0Z0svSmJNL2FreW5LRDFsNFpHTWU5b3BReXlU?=
 =?utf-8?B?QWtVU0F6TDdROHV0RU5xYVcxcUJ6RW1GQjhMTjdpejFEWDBFSlhQR3h2K2k2?=
 =?utf-8?B?RjFzckZQQ3ZENVN3TTg5R2V1dmV2ZGsrVktpemIzcnlDTnhsTUs5LzRpTTZL?=
 =?utf-8?B?NWVSUVVBWjRycElxSHkvUzRiY1VSMlhZQkJ6M2NjVlZnYzI3NVJkWk9Zb24y?=
 =?utf-8?B?eGRxRGsvYm0zd0hyQmVaL2NLNGNhSll5RkYvdTBScElKSnR5bEh6QWlVaFhC?=
 =?utf-8?B?bjA3RExHMllkYjhyZFpjT3FqWHg5cGpOcERRM3VrNE1wSnVpNkx5RjJURjRO?=
 =?utf-8?B?bHMxelZWMEttNVdYdzlOcnRZUTc5Y2ZBZnordE1Hb3FMa0l0cVI0S1Uwa1Fo?=
 =?utf-8?B?OWJ4R2VKOGpYaHhaYy9HeStRK0lhcXkvOTlEVkJtS1lNeHhHWDRDUGhHa1c5?=
 =?utf-8?B?VzBEQnpRYWtmYlRKYmNJQXppQzM2d0JtUGlIVVBRMUhCS2JIVmZpU25LTjNv?=
 =?utf-8?B?Uy9SVG1FWmlDUVF1YXJlNXRGMDVuWDdDWXBIQlp4SmNvTm1iMVh2L1NJWDh4?=
 =?utf-8?B?Uk16YWp4eUxGR2xzblN3cnRORFA2ekJ5V1U3aXYwTXo4azVBMTJUWkowaFZE?=
 =?utf-8?B?eGN1TDc4d25LLzc1UWJPUXpKQmU4d2N4eXk4Y1kza0ZrZ2lGNU9GVmljTWR4?=
 =?utf-8?B?em5DRHl0RzdjemREejRSR2E3QTNjQllCSG1uWUd1ZEM1TzQ1c1M1MEI5bFZ1?=
 =?utf-8?B?TFNkTmJTSG9tVU9YemhGaTRCS29XcUR1UGJsM3JPRFFCSE9FQXZvekVPbXFw?=
 =?utf-8?B?RVd5RzdYU2Y2OElEam9yVkJaY1lOUTlsaGJqamdiWWFpTkZ6WkJCajNuY1dP?=
 =?utf-8?B?K0Q5OFRDRnA0djA3SkYxOGR3aGRFYkRJV2tTZUI4WUhvYk4zMkV5UitUZGZL?=
 =?utf-8?B?RnBCT3ZPZS9aS0MrWTBvVnYyaEQxekd5UWlPZDlMQ0FScFpaeWdMUTRYUmsv?=
 =?utf-8?Q?R1TNHHhq0Yd2/j6ezbQwixNf+NJ+nUo3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 10:24:45.5363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a69ec87b-1a80-4c31-273e-08dd63ab9b92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910



On 3/15/2025 3:34 PM, Dan Carpenter wrote:
> Hello Sairaj Kodilkar,
> 
> Commit eaf717fa1c3f ("iommu/amd: Replace slab cache allocator with
> page allocator") from Mar 7, 2025 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	drivers/iommu/amd/iommu.c:3200 alloc_irq_table()
> 	error: we previously assumed 'iommu' could be null (see line 3195)
> 
> drivers/iommu/amd/iommu.c
>      3186 static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
>      3187                                                u16 devid, struct pci_dev *pdev,
>      3188                                                unsigned int max_irqs)
>      3189 {
>      3190         struct irq_remap_table *table = NULL;
>      3191         struct irq_remap_table *new_table = NULL;
>      3192         struct amd_iommu_pci_seg *pci_seg;
>      3193         unsigned long flags;
>      3194         int order = get_order(get_irq_table_size(max_irqs));
>      3195         int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
>                             ^^^^^^^^
> This check can hopefully be deleted?

Hi Dan,

Yes, ideally check should be
nid = iommu->dev ? dev_to_node(&iommu->dev->dev)
The caller ensures that alloc_irq_table is called with valid iommu
But we need to check if iommu->dev is valid because it may not be
set for IOAPIC.

This is not a bug but a redundant check.
Please let me know if you want me to send fix for this
> 
>      3196         u16 alias;
>      3197
>      3198         spin_lock_irqsave(&iommu_table_lock, flags);
>      3199
> --> 3200         pci_seg = iommu->pci_seg;
>                             ^^^^^^^
> Otherwise it will crash here.
> 
>      3201         table = pci_seg->irq_lookup_table[devid];
>      3202         if (table)
>      3203                 goto out_unlock;
>      3204
>      3205         alias = pci_seg->alias_table[devid];
> 
> regards,
> dan carpenter

Regards
Sairaj Kodilkar
