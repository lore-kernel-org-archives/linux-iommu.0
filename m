Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793954238;
	b=KTTAaEiYh37lXSnswuJbsuMNsm/4RkIV9fXpGqhY26MCDNC+MtWfCQPrQ2omC7gTENXH
	 K8FdmRKfd5XIRtM6ngNlMRntpPC8RuH4bp6wVgmFi+3E/4qKT78g6ecDVCcNHAAwOHI6j
	 vehsfr6gPE+IwQ7PVfauIkEUa3yFggbsQEuBcYk8Y1fIqNQUQ4SC74Eea7HLk4ZZDGRtR
	 19/Agulj76Ab0qh+7PlmI28km2Dowl7Myj1PCCRQjFtx+Ppe3srYN7Cm/sAup2jE2RCo8
	 O7slTmSyZ49slajcwPhYbre3c2d88tH3ZNRonFuwdGtg64/oY8aNThu9CE+AZ9g5EsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954238;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:Content-Language:
	 To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LqL7UTglGFgI5r6TbUKZNdHF1lpmLphQvBipz7ZnU/I=;
	b=YBfTn3LvwgPomwn54VrrSO9sYDT0HthAyZaSWpE6ce+56ouYVoc0qCtBOtNyw+1CFpOZ
	 IMohSsXBNH9IXyHPYLddUqMO1mfZtUoCBJEMc03VnLdYgD6uT5nSksa79KYGu/vQn8XjF
	 ZHKICUtv3KXFpFG6+1DPnA56LsZHxV1R+8qGy4+/SJNJE74hYH9nSr/B4XvH82ELuCub8
	 wGIiA/oc3wTgkzxQ1kT0nnlAxJCZ4ZdfWwhBYDmq/0JuZvcYk8QLHe4p5ps5u80FUZj9R
	 RBIh16A4XWLrU403ZtU5XyIAFE346O1egEREDo+2SACox0eI2heAzlvHkIyPfkLxsrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bK3QaVqK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.40
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2C606A328
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 08:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E2C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bK3QaVqK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPQIhskC96++I7H63CgqPh5FsId5/hB2Y9gjhqY3+vbCEm//E9vaNQK2NqOFD6m/k5HzySgnPWzg/JYgCqYo0RTtMi1Scw9ZoHAQuioVrq4u1hFvFQMkSGjFNaynUtI/RjKOyz1SS5knOUKobrtpd2oWpcfCNC7KM2w3mY5bIgBVkHmK6fx4fmZokHmrk3uBscFeVFmMbk1vE0/6MxJ0X1VqBoRiFY+U2XyG1lO/ljWPkycmsqnRBlzUphG+riISEJbpP7MYjzhuCo2CFry7QW3ytVn5aW8SWUjHW2fE0vFicPSsOy6IW7XLgBnl3n4SfsCbaS2jjZ7nqxji9zfNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqL7UTglGFgI5r6TbUKZNdHF1lpmLphQvBipz7ZnU/I=;
 b=u3BtjpET7Fmme/5t8uMtkyFcAQVZhxH3X/J+mwM9+xI1ViXiDzYqU6/ZYr4gCf7WSTnHyo1Rlp8OgfLrt38UD/5L2YwFKEUsBXw1AWBxGAI5mL7dExuhWV1d4O6tB/bbGXET2pEuWcC7YjbQufa/YETEROdCN8v1l3dEZx4vnl0jvbVyxee10KPmSHJt9i47FGoerWfDgyGJzt28413fdnsb4gxOnhR594fHnyXt5XGRhnz3JQl4KrXueSm4m8SIh/l9SkBV2vWOmILUsBCCdj/dwbpmmkwfGQsm8mypAGB8pu8tUpn304TQcecd9QqOpM5B0n6F56RkECypmD6jaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqL7UTglGFgI5r6TbUKZNdHF1lpmLphQvBipz7ZnU/I=;
 b=bK3QaVqKklIXjFEkhd3HMmnseDTc9bYoltaAsa5F6L5mcqjO8mmSlpkbRc9dmuI0y8luLahKOVK8FonhBdTbB5CH9T9YQqGQoUQGR9bYALcWsoXdyLy82yMUSRdrLcHSsqwnE9qFJh5/NcV3F6k1caZw+X6hrWOm3t07Mia/KXw=
Received: from MW4PR04CA0170.namprd04.prod.outlook.com (2603:10b6:303:85::25)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 08:37:10 +0000
Received: from CO1PEPF0001885F.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::82) by MW4PR04CA0170.outlook.office365.com
 (2603:10b6:303:85::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 08:37:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885F.mail.protection.outlook.com (10.167.249.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:37:10 +0000
Received: from [10.85.43.226] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:37:06 -0600
Message-ID: <c6457876-ee0d-41b4-82e5-ba6c0f7d2fb3@amd.com>
Date: Fri, 6 Nov 2026 14:06:58 +0530
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>
Subject: Re: [PATCH v3 0/3] iommu/amd: IVMD handling cleanup and ivmd= boot
 override
Content-Language: en-US
To: "Jindal, Akshay" <Akshay.Jindal@amd.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Adrian Huang <ahuang12@lenovo.com>, Joerg Roedel
	<jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20261106041650.24076-1-sarunkod@amd.com>
 <f5188f91-d159-4162-9f99-4a5f3ca11cea@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <f5188f91-d159-4162-9f99-4a5f3ca11cea@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885F:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: f9464700-b66a-4fe5-7378-08df3be125fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|921020|11063799006|4143699003|56012099006|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261009221227099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	TUOKh4mDiKSZOHYFArQhlBnes0J831CT8wfmJUSAEnkYuYUAkNOc4zz/fSXc3P6QbhIrr4D0TfSoEtx3x4wwb5futMGnXlDJG2Vi7aXhg81h5QhU7pyLHuVsPZVNi9BGV6J5UkwmuLGTY2AcZnEP8EuyRjEehUW5XjzXxuurIUzw7JniVhQ6KBfcNEDYoKJVu3wZozsmwqNckeAtKQ0SmIOeGJHMOqNOAYkHewrqWvunkLPxp39gUeg5Jzo/Ag5FSEuaaJMhsUwi2PNLKDOOUu/sMDpgoqvYdCQGOSyZhGY06sqWUkLInRtr7BPdCBu3cUQU+RkuLO3L4E/RaBmI+Bthp4wksCwD73tYe2qfkqyaOp9eucB5vBq9zsxXQPwa08K6qaK7SzTTtztSuPXDDhPCvPcPwhXDAhr4Z1qbJBzBR/mGCm3S8rg394IVvsSNms8wCQJ5enkn/LZxFRoVV3jOWJx87m67cQgXqfF1NKoUhEGzpTAYk88GNgip2aDDF7WWB+/8LDuri22WmXne/wpxPIqTzpyYjV50m/ett4tB24ey3shAz4GE0XlJ9Eu8w09RKHn12tt5ooBwwgfhNeJgB3VD8f7mbKnqFRNjitW7V1eYAHTmtrBiEZXrc+o64kQg++Y59sFEehPMSe8Db+MuUgUOixaue/cMt+JmVhlPDZZvWdCbWMeLwd4qtMJOlK9bASGpCQZ+0HCz3gV7CQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(921020)(11063799006)(4143699003)(56012099006)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IMkEX8DfvDNQkl/1tJKyu/gJiOSg5xq6oB1Zq+uZ7A7yZ288wyLTXsaBr8nSoBjf3pa9koEm+nEOMfWPXMy6KOzpo6WmMTFx+BKMbBT60TYyVl8lquThFustCzBW7JO4hM0bBXmuTrDt+19SbS+GO0jiEFnKoXg6XaImYEbg5GatahX+sjjjvxW8EwaK8cLab2YSg+unU26ITZS74nXAY+TWRTxbYmjOYxNQkwf5dxbcrXsIrENLbrrwA4RfOmims3WUgExVxpDjjGjvFKUjM0KtxeaXqS1cCiNg9wsv/EZDJIcYksa1Upyj/Pb2CiDaLyDTISLyKsqP1u4ENMpKzhiVDehE9E055XRf3mixtC3qys1YLDj+1TN3v1DMzWDJbQrJ4u3hYC0eiZc8OruMxGByZBHN4j2B3ayIT3Yncpi9+ud8lu+U8XYjZksk0RQl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:37:10.0163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9464700-b66a-4fe5-7378-08df3be125fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005



On 11/6/2026 2:04 PM, Jindal, Akshay wrote:
> 
> 
> On 06-11-2026 09:46, Sairaj Kodilkar wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> This series refreshes how the AMD IOMMU driver models IVRS IVMD entries
>> after the hardware exclusion range registers were repurposed.
>>
>> The first patch renames the associated MMIO offsets to reflect completion-wait
>> store base/limit.
>>
>> The second patch drops the workaround that forced IVMD exclusion ranges to
>> r/w unity mappings; the driver no longer programs exclusion range
>> registers, so that the workaround is obsolete.
>>
>> The third patch centralizes IVMD flag definitions, renames the unity-map
>> structures to ivmd_entry, stores the raw IVMD flags byte from ACPI, and
>> derives IOMMU reserved regions (including exclusion as IOMMU_RESV_RESERVED)
>> from those flags.
>>
>> The fourth patch adds an ivmd= kernel parameter so up to four per-device
>> IVMD-style ranges can be supplied from the command line when the IVRS
>> table is wrong or incomplete, documented in kernel-parameters.txt.
> if patch 4 is dropped, you can drop mention of patch 4 from cover letter as well.

Thanks for pointing it out

Sairaj

>>
>> Changes from v2:
>> https://lore.kernel.org/all/20260424092213.16976-1-suravee.suthikulpanit@amd.com/#t
>>
>> *Patch 2: Report an IVMD exclusion range as IOMMU_RESV_RESERVED in this
>>           patch, instead of leaving that for patch 3. This patch stops
>>           forcing the exclusion to read/write unity, the range has no read
>>           or write permission. iommu_map() rejects that, so a tree checked
>>           out at patch 2 does not boot. Reserving the range in the same
>>           patch keeps the series bisectable.
>>
>> * Patch 4: Drop this patch, ivmd= command line does not have any real use and
>>            complicates driver
>>
>>
>> Change from v1:
>> (https://lore.kernel.org/linux-iommu/20260420170033.6780-1-suravee.suthikulpanit@amd.com/)
>>
>> * Rebase on top of patch "[PATCH] iommu/amd: Remove dead code for exclusion ranges in IVMD"
>>   that was submitted by Yu Zhang <zhangyu1@linux.microsoft.com>.
>>   (https://lore.kernel.org/all/20260331152550.479841-1-zhangyu1@linux.microsoft.com/)
>>
>> * Patch 1: Modified to only rename the marco.
>>
>> * Patch 3: Reintroduce logic to parse IVMD exclusion flag to allow
>>   reserve region of type IOMMU_RESV_RESERVED.
>>
>> * Patch 4:
>>   - Update the sscan function to scan start, length, flags in hex format only.
>>   - Fix apply_ivmd_cmdline_entries() to not free the cmd, which points to
>>     the early_ivmd_cmdline_map[]  on failure path.
>>
>>
>> Suravee Suthikulpanit (2):
>>   iommu/amd: Drop unused global exclusion range fields and init
>>   iommu/amd: Do not convert IVMD exclusion range to unity range
>>   iommu/amd: Rename unity_map_entry and unit_map to ivmd_entry and
>>     ivhd_entry_map
>>
>>  drivers/iommu/amd/amd_iommu_types.h | 22 ++++++------
>>  drivers/iommu/amd/init.c            | 54 ++++++++++++-----------------
>>  drivers/iommu/amd/iommu.c           | 28 ++++++++++++---
>>  3 files changed, 58 insertions(+), 46 deletions(-)
>>
>> Base: 945b3729fca6176fdbb83e38c8116b0132c68fbe
>> --
>> 2.34.1
>>
>>

