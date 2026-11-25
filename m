Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795584946;
	b=f+zI1e0MTgpDkhrAHCYoBh7Umv5NqrbAW9xALGo8Pv0qMyYS/JiRDVXshNKsb5H3XzQx
	 TCNFPLb2GyTtZrpq7MpS7x3WOI/Fs/0EBJ2nrTH4gTwdz0eOAG2ChItaWIaonYXeRka2c
	 LuSTFWy/YlgPDl4ZUejBXy5FPJ9V10MWre5LBNXUBZZi6/dIpQnmdZwwgntiyTiXY9gRa
	 YsvpwOvnCPRxLW8b35vbQq2aKcOdshkFDW4l6MAc+B9AquodPcDz+KWUrSxodR10Z3zKo
	 z/WSL589K/A0oNdxW0u2YRc82vX6KofQWB1XsofQbm75ixoTnAWrNyIq1LpNkvdfQzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584946;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 CC:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=5G0se/H/hVvaNIdTvRh5XyfopfLe2Lhr0sil+g7hSsU=;
	b=LCUAcAHPoYaWgUyQi5tiZNiPBGs5IFfcUkccbWv58TPl87zQzjYr6tVfrNBa8AFvOss0
	 QFn+ghwBEmkmDYl7aAyERsUmnyG+dab0aPGsHc7UpPtoW99w++ZwW3vq1daYtm6oC4lp+
	 UPaDEY+JQ9jAcCAe08FS/NdApj1PogvkOhZ8nFWl7/bcUJc1b9dWGQI03oqa/r52vL0/V
	 EjpJXvKrapMsLqbI6RU79ZOaa8cL5qJDk0C+UMVdyTTto7/1V6hpgNr/MuJsq0Fz0wy3p
	 45ytiNkXs2LhrGrxyDv5Vm00X3/8F7X42HyL+fkN82Mb93pIQiIhFW7ve6pbYPkyYZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sGrTKhtX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.71
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7F606A321
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 05:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9E7F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sGrTKhtX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFhO3VSiW1V5xuhqg7KMOF9FAQQCTUe6iwyQXgHc9aK5XOHNjEvaLN9I7s6ikGDopWI4xYyHt6oXYJvI4tn0WUY4clYxcwLZYNLsbQbl9kGK3V5D+FzC90/si2vsXl5TtgyO4QM7HlQMMjH9zK6zxIqH0ZtibFSHvd2V+36ga+0LXxYyjtSrvaCnCwB54VijyQuaJhyjjdluQUvcRuHqZQYYgoin+d/WTHDXNdAivvVDKeQK8hhMOBWdhQkCkpXtXitT+3I+hDKg5zeGLDOxd3VxeLHRTzzSaw0l9m3EH3WdRiArv876yL8xVuO7RH2wEh7dOrIoaWKWDrl2cyBxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G0se/H/hVvaNIdTvRh5XyfopfLe2Lhr0sil+g7hSsU=;
 b=t4fu8L8t7zIis5047RyXDqHd+7DiIcVlH7NJtZ2bxCx2Nr/t0Az/FAEZMBY5eI4mnviPQKFqe7oG8jQ4STiLQtZAmEo4qCJSXEO9r0W3llKxsbqA5fcAXFzlbXZ/SIiAAvX8ktmqbM+D+gMma6GrcvHmJ6N8EXvoc3so7IbBe98IjR8LXok8bQ1p12kjyQfhLNOJdfcXcQyQcpRy9XB5A5i/i7Cf6TgPcQQpVTvf2a6bs5yWFQ8P/WGUuF+ePAY5VrqSDmbh9RqTq+5Ibu2E6hRJXF29IVGRYa1wPUpYqxycKXJsnRfjSy9QvgnqTBY8BjElWRmK2fkwDGnYSCf6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G0se/H/hVvaNIdTvRh5XyfopfLe2Lhr0sil+g7hSsU=;
 b=sGrTKhtXgZtKXCzrU6Woyz9eiBdKW1jDbV9GpzsF0/FAUL2ZNaz3W3pX/RjVkdcv3YT+F1XzjhrZp35p9DRbgfktZE+PhobBTf8BOZqqvSAyDt8WlHe2ErFFOcch0JRw5UFGiqPeIul/U918eM1OH+zvgCUPu285Zhh4CfZXCGg=
Received: from SJ0PR13CA0123.namprd13.prod.outlook.com (2603:10b6:a03:2c6::8)
 by CH4PR12MB231692.namprd12.prod.outlook.com (2603:10b6:610:50e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 05:34:12 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::8f) by SJ0PR13CA0123.outlook.office365.com
 (2603:10b6:a03:2c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Wed, 25
 Nov 2026 05:34:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 05:34:11 +0000
Received: from [10.85.44.127] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 23:34:08 -0600
Message-ID: <9bb63df8-29b5-4b0c-9758-3fbbdb61dd06@amd.com>
Date: Wed, 25 Nov 2026 11:04:01 +0530
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
Subject: Re: [PATCH 0/2] iommu/amd: Optimize IRT cache invalidation for nested
 VM workloads
Content-Language: en-US
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, <joro@8bytes.org>,
	<vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20261113095017.1835921-1-guanghuifeng@linux.alibaba.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20261113095017.1835921-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CH4PR12MB231692:EE_
X-MS-Office365-Filtering-Correlation-Id: 15052188-801a-4080-ca20-08df4ab5bc42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|261026140227099003|261022075727099003|261102123227099003|261022105027099003|261028144727099003|261021123027099003|11063799006|10067099003|56012099006|261021121427099003|22082099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ewWsQSf9Sm8xNrmjRqcLy9Bgq+nMJHpRVZVh77Sd72Emki/LOpuHtbVSA547QIsabnx1WXaa0CRo2HPwDyHuwh7x6jgjsgAewq0RgE5pmIxJMwFkqSOVLn8WmQt9PK3NlohXFnWVJ7Q0Xmw7fBrF+Ax7zuk4Cv8jHCSV5XUPuG2whP2uBza9eghJXIWlRqoo8USUcQTu8CxdXsqCH6qxw4sKBzIxsLstTMcC/NbNMy+nbomgwra2h8WDUZ5aCct/5OFy9CfGLayXW+RaNXq+4Y0RvLyq9mTCJ/3bBwt3/O6uD2bjCrwnM2TBwqX2SI8RKCKgQ6GvpeLip6E+gL79NwRPxZ7NM1uE5HgIW4l6zZu94axCI/RztjvHhB8qDC8kMu9cVAVcuR3+uSQBzfiqnNUAc6ju9C79/b1pfKuOOyOVIWo52xIGWm7NMppufLpYX5eR8YdrVm8gs3wjhRMPY2AVN5B5PRRluk1cziOob+7+ykSeYKelQsp6ocMGCEI6w7NBRp5QrRr+c1JUDAoksLIIQHRyCzg+rUoOsGkAn0ssk+8wS68PMxsIgzflQcd2OX8k4WMkCPtVJug9Det3L4ITT+YqcpzJlgK6o/DLelk336f45SgPQDbL0nMDHE3Dufr2c1q6jeUbGkjBNFPusFnCpk4myzWhd0KuePg4ARA90zyROKHn/EubvlO1H7T5HOsIXhd2TdNCNtJwwgW3/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(261026140227099003)(261022075727099003)(261102123227099003)(261022105027099003)(261028144727099003)(261021123027099003)(11063799006)(10067099003)(56012099006)(261021121427099003)(22082099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dL/3ZPX0mfxRYWVmVP5RM5pMQBM9Xc0dZUzbqQ0KjPfVUKlZ6UNTYvsAvZJesx+d/IwO86ZPgrVNV5t5PYCRdWpOM2tI3gBQI5XabWOJEeWXXjdEhWEvndk/C+23pIpmulw+5m9aMwrXDe1sj4OnsBeHbpkCA7OdOeyE21nKD7CFLr6m+DQBLBtMNfr2eSeEZlj6JcGdAFVs8J/vY/RJCmCdeVBA4ABT2VTcD5vNwTQTjsM6SpL3oe6iVLe6xx9gcJSAykbGO9duIrKxI+LaIMQ75uHCmb/XnwMp4Q5UWUx/O8x0qbW/Asq+LAz2WtJs0BMPWbO8dUfYFe7lo/nnUMvZLfBtBClWiH4clcvlzRY7LMb3HAE85toyCRnLNCtuFHanPkuOTQcb+9ZSo1GSsCBJpFF3mX7LP6HNvXaUUoG7ES8zS+24ZXCB6V4NhyM7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 05:34:11.6637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15052188-801a-4080-ca20-08df4ab5bc42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB231692

On 11/13/2026 3:20 PM, Guanghui Feng wrote:
> This series optimizes the AMD IOMMU interrupt remapping table (IRT)
> cache invalidation path for nested virtualization workloads.
> 
> When IOMMU AVIC is enabled, every nested VM entry/exit that switches
> interrupt routes between guest and remapping modes calls into
> iommu_flush_irt_and_complete().  A reported workload with 4334 device
> entries shows median lookup latencies of 22-33 us per invocation due
> to a linear search_dev_data() walk, even when IRT caching is disabled
> and the lookup result is unused.
> 
> Patch 1 moves the device lookup after the irtcachedis_enabled early
> return, eliminating the unnecessary walk when IRT caching is off.
> 
> Patch 2 caches the device data pointer (resolved at IRQ allocation
> time) in struct amd_ir_data and threads it through all IRTE update
> paths: guest-mode toggle, affinity change, IRQ enable/disable, and
> IRTE free.  The amd_irte_ops interface is extended to carry the
> pointer, eliminating all search_dev_data() calls at runtime.
> 
> Both patches preserve DMA-alias invalidation, command ordering,
> locking, and completion-wait semantics when IRT caching is enabled.
> 
> Guanghui Feng (2):
>   iommu/amd: Skip device lookup when IRT caching is disabled
>   iommu/amd: Reuse device data for IRTE cache invalidation
> 
>  drivers/iommu/amd/amd_iommu_types.h | 10 ++--
>  drivers/iommu/amd/iommu.c           | 73 ++++++++++++++++-------------
>  2 files changed, 48 insertions(+), 35 deletions(-)
> 

Hi Guanghui,

Thanks for the patches. I ran a few tests to measure their impact.

Setup: 12 VMs, each with 32 vCPUs and one passthrough NVMe device. Each
VM runs a small nested (L2) guest that executes CPUID in a loop, which
toggles AVIC for every nested VMRUN/#VMEXIT.

At a 1:1 pCPU:vCPU ratio, averaged across the 12 VMs:

  search_dev_data() lookup:            373.4 ns
  iommu_flush_irt_and_complete():   172546.1 ns  (including the
                                                  COMPLETION_WAIT)

So the lookup is about 0.2% of the flush path. The completion wait is
the main bottleneck here, and the overall gain from this change is
minimal for this path.

The change is still valid, though. It removes a linear walk of the
dev_data list and the may help other places in the driver that call
search_dev_data().

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>

Thanks,
Sairaj

