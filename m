Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793954732;
	b=UAR4hHSjNbLVDVTrSZN3oIc08vP5Kdse/J3N7nNEj19wD0NHsyd/K5zQZUJlc9T3oinj
	 s6IUPJAfCarFu/pkGGXFDC0/f0hZGlLN9I8p/PXdkr17oDFC0kLK621sGBop4MPAqLAnJ
	 xQa9kZHjjww+rCKvoB6B7Nrq+MRfD/s/SjeHt3+FHIpE1VDaMi0iZgoMHYAIFImtDn8vw
	 Mc7cwQxYOTwJ3Yr5chNos+KEsnqYOIXoUtzxWWrnU0uerlS6HBbRZviPgPP0LgxhbkceI
	 x/fVY79UF6DI4c9E8NHLFHaqGlgzXFANUOwNz44uiaHQ4QeOV3Ygu8ykJO3pfFA5Yyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954732;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	bh=kBRfj1z5BlyawISwz7H3OEHQ+vdsYRMXpvosCJ5XB+M=;
	b=3t3YPpGRO+5SMLc47x7rO8cO+HfL0Hniyc9ndlZQh+y1NEKI7d9HrsswcwFx4wPVmRBR
	 vTKblKoHVo84eVF8ROr+uHcf31Lp+frGM2FIQG3R79mfskU60YXqjG20QNF1hgMJFE46Y
	 F/YnqMVwa1w56xrg+J8IQ1OBz+8B5rlUqDWX3TwlwInwY6D2zsCBtkjtb/C21vF4ITu4y
	 qy+WtmUlGbSYsiDaY1oVdMG8YYLwEBZAcQsFXNjqmYxhsenJrQ+yfzFOKau5bEWgxilEk
	 m3sN4+1v1IpMfyFbf4BeMqNUkZ1hezAlQ91SPoRBKagf99qx9F1UZShTDfk/TNKzEgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lAoGlYIz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.46
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9BF606A32D
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 08:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F9BF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lAoGlYIz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ywp4B6vkU/yCrFWFobECHx0xgSWFtDtaIYvjSzE5ngmztqjbUgO6yKUDhNONiu8WhoKa6xtHq8LewcGb0Im0EG5d2UiDjzuUN30oqAEuQ7tR0DzoRb1XzrRZw2xyj8qFKDoiMdENLR7X13Grq4eB2p06EXFrYgDeCftgW/PpwaAUZcI6tAfdGd3LRE9d79KWv7ETNhe3Qcjib5Pd8i2KDcYtp6xBtRPlSG85G1vf/r/LjBt0RmOEtkTl13s6w2GRLF1C4WwYHnpN1cCldv2tvREh0AS9zAzcS4rO6iOyxmi48zVL76Ij8iek864E2UeGEE05DyrWo2oG4faj20dK6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBRfj1z5BlyawISwz7H3OEHQ+vdsYRMXpvosCJ5XB+M=;
 b=rKYHGrly6+RrmRrDtbI5HmOV44ZbfYBwDYGW//gjgqk4r5RxJwUQP0oJj9aSSITreI28O3s/3UYH3D5of7BRPcPThrVg5B6N+lj3jPFR6OWnFBXSexNWNsiIkiGiCRkWLF43TnL9qnfXpoeQj6yuWfTMtsFUm5D4s9Q3QYpGQp6xkcdC1MSJR14Rm67eluwf/LCgeMyu7DSEaqbFRp7X56GgSWv6Ag5nvOJJnOLylgivyBtK5UyTBAngXOGeCS7qjrAW8mnWSFGAOSANf/HU1i4zCvhIsdlwqedAVZe7OfZviQdkFod1MqKwcYKFbMsawzRzLfHIa+mC48+CfZYkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBRfj1z5BlyawISwz7H3OEHQ+vdsYRMXpvosCJ5XB+M=;
 b=lAoGlYIzqgX6tIxuRTnuyLXC0byIqJePLPYzvHviVUO7+5hQtKLd0pzx/dBOsyLiZSfsv0bNm4W6JenI9UvHDqTUtc2r51uHTzAexHwgXqM8eL3Psjh9TfTBulvwgC9IuJr70KH2j5/9URBrJCNG50sggzLpil+AIJnjpF9pdYQ=
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 08:45:26 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::9a) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 08:45:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:45:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:45:24 -0600
Received: from [192.168.1.149] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 02:45:21 -0600
Message-ID: <76c9e2d2-ef9b-433c-9b84-201f43d3b940@amd.com>
Date: Fri, 6 Nov 2026 14:15:19 +0530
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
Subject: Re: [PATCH v3 1/3] iommu/amd: Drop unused global exclusion range
 fields and init
To: Sairaj Kodilkar <sarunkod@amd.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Adrian Huang <ahuang12@lenovo.com>, Joerg Roedel
	<jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Adam Pelka <adampelka26@gmail.com>
References: <20261106041650.24076-1-sarunkod@amd.com>
 <20261106041650.24076-2-sarunkod@amd.com>
Content-Language: en-US
From: "Jindal, Akshay" <Akshay.Jindal@amd.com>
In-Reply-To: <20261106041650.24076-2-sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: ba229a96-dd33-4243-aa22-08df3be24daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261021130227099003|261021123027099003|261022115727099003|261022105027099003|261021133027099003|261022075727099003|261021135927099003|11063799006|261021121427099003|921020|261022113327099003|261009223027099003|261026130827099003|261026121527099003|261026135527099003|261028144727099003|261026140227099003|4143699003|10067099003|18002099003|261102123227099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	HQqZapbU6NJPss7HH9u0sOYtLTMKEEq277gQU6Z9xOujMmnUgvH4keaqq0suLn7xFP7fhsoPmcusHdHg8wbh+fCjJiNb4iu1ctc1Vuwxk69co54ADz/8BfNEm+xV2AZlsl/RP9y0X8iyvBCF5DBlgo815KgbXoC5VrNyzZDLGsApa4PfsLJ/vxeIL0WB2iaHFisbo69p7gZAgSh2V1tGL6ilycqJYioIUzYoFoPzDmveN8/vKrpZBqVf9MLSYbug5bnXCHojVJUCjNh58jSqJ8LdixvmzsKFvvPswRGNbPK46R5fG2r/nd6ZuLViD2C/7dC8ipMCfHJvQ/j6oqLD1SQM/ZE1ukag4BcPl3STB6seVPhriw5viR4zULMs8iLVONC7ZovSe92Eh7D9om7nwKO1FVBmQ1500NUFcfS6/c2OYLxYDjxrC2ZmH7KmO6GPEtF0mqKOlGAy4V7Y2iGKwUvR2V8gknHu42JhsPTJOorJzNgGt3XWlyvhXhbTM4BZdN6lJUvqD+3mkmIeflSnsfsqq8HNbD1uh9W0TIABE4WBwat45qXpHeZuN5DbHmJx5lkc+NOP5obg0vKAprLJg6kpk2iHblfTngyBatfIPdG+36SNL4iVQI5dIzCQ9qy11F+PaG36zROYGYOipCx4bBzgdQ3m8rT2JE1FqayE+Z9XXjn2YXcVLi/7x5nwzuDgmFuqrKYmTYKSFDpa2z3fPadWqpZ+ZNPHFu1UeI+mObUdxEyPx2vLs4KrSWw/jges
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261021130227099003)(261021123027099003)(261022115727099003)(261022105027099003)(261021133027099003)(261022075727099003)(261021135927099003)(11063799006)(261021121427099003)(921020)(261022113327099003)(261009223027099003)(261026130827099003)(261026121527099003)(261026135527099003)(261028144727099003)(261026140227099003)(4143699003)(10067099003)(18002099003)(261102123227099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	avs8uwMFCvyB41ln+rOtmJYp8HR3Rn/Zoarrx0pHZio5vWMbHr2FcibUqcsDEUufn8Gr4TQie3v2OEY72T6ZeBiQlBAdBuciDsSWvustQT9X8uLKMkHcw7IDMg4e6kB8mdaEN3pPR39CJwBkB+Oz5AObtNVPXXccLIZ8M8HS9PDi2XevGNNg2TwQEHSN0bpTRuUT8pckUmNU9b2UP/5IDH5GfqhQ9QKvK5vs+E0C9Wcl/Xy6V+izL0Xf3To2tEHh1Oz8TfldgQw+VQ2ZC/LAFdjjzfHjZNrTmP/P45dm0QcRoFeOvp6zjm3iv+IrPmnelcNSjkJWI/VOuWgvbyYi1M8eQ3gCxuzX0XPyIhRUyhGTNzjTEBhfNSSGgRQbZ2eMJhLTxnEegRjtUhwmv6PllPR6vB3qCXOvkTif1Mw/n1+M4hQxAz4jZs7fdqTo26w+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:45:26.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba229a96-dd33-4243-aa22-08df3be24daf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017



On 06-11-2026 09:46, Sairaj Kodilkar wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Remove unused struct amd_iommu.exclusion_start/exclusion_length, the
> MMIO_EXCL_* flag masks, and iommu_set_exclusion_range(). These struct
> amd_iommu fields were never assigned, so early_enable_iommu() never
> programmed the hardware exclusion registers through this path.
> 
> Please note that the exclusion range registers have been repurposed
> to SNP completion-wait store base / limit registers. So, rename
> MMIO_EXCL_BASE/LIMIT via to MMIO_COMPL_STORE_BASE/LIMIT instead.
Reviewed-by: Akshay Jindal <Akshay.Jindal@amd.com>
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Tested-by: Adam Pelka <adampelka26@gmail.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 4 ++--
>  drivers/iommu/amd/init.c            | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 8241ef922519..678ceddd711c 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -44,8 +44,8 @@
>  #define MMIO_CMD_BUF_OFFSET     0x0008
>  #define MMIO_EVT_BUF_OFFSET     0x0010
>  #define MMIO_CONTROL_OFFSET     0x0018
> -#define MMIO_EXCL_BASE_OFFSET   0x0020
> -#define MMIO_EXCL_LIMIT_OFFSET  0x0028
> +#define MMIO_COMPL_STORE_BASE_OFFSET   0x0020
> +#define MMIO_COMPL_STORE_LIMIT_OFFSET  0x0028
nit:
1. since it is SW based re-purpose and used in function iommu_set_cwwb_range()
suggesting renaming to MMIO_CWWB_BASE_OFFSET & MMIO_CWWB_LIMIT_OFFSET
>  #define MMIO_EXT_FEATURES      0x0030
>  #define MMIO_PPR_LOG_OFFSET    0x0038
>  #define MMIO_GA_LOG_BASE_OFFSET        0x00e0
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 8a410d4aa370..13c96feed64f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -370,14 +370,14 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
>          * Re-purpose Exclusion base/limit registers for Completion wait
>          * write-back base/limit.
>          */
> -       memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
> +       memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET,
>                     &entry, sizeof(entry));
> 
>         /* Note:
>          * Default to 4 Kbytes, which can be specified by setting base
>          * address equal to the limit address.
>          */
> -       memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
> +       memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_LIMIT_OFFSET,
>                     &entry, sizeof(entry));
>  }
> 
> @@ -1022,7 +1022,7 @@ static int __init remap_or_alloc_cwwb_sem(struct amd_iommu *iommu)
>                  * completion wait buffer (CWB) address. Read and re-use it.
>                  */
>                 pr_info_once("Re-using CWB buffers from the previous kernel\n");
> -               paddr = readq(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET) & PM_ADDR_MASK;
> +               paddr = readq(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET) & PM_ADDR_MASK;
>                 iommu->cmd_sem = iommu_memremap(paddr, PAGE_SIZE);
>                 if (!iommu->cmd_sem)
>                         return -ENOMEM;
> --
> 2.34.1
> 
> 
