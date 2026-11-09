Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794205428;
	b=Qkxa0enisKerDHzMEhUME/+VuVxfsbHchUjsvrZ0nC18zyBldBorzK0VDU29LASOa0PX
	 6C12YCize8A68xCyZKHxQ0i9rfog6jriqFhAA1rGLmzRrC2ERs9+a9oANAvRur5fLbSBg
	 xexW7dxuFtNWACiDDtLFW7rYTCeEocP0a7JBbjxWP3BBhU9ngoTNN6K6QckspontbuzKm
	 VjZ2S0RpOzbLutyEPj+j6qnME9P7KJ0Cn634FwfxngkvXvyzm7Ko99P/UbrtUz4APuXCv
	 VymG1PrgJS4oNZ15OFYQg04MwQNm2gruFBjfBel0Pmn/r3VDPoEchclvz5JgA+aunhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794205428;
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
	bh=uLlp4fT2Kgrj4+ZvBml3SXsvDKzygjTVMN0YPiFlpMw=;
	b=e/XwXdltePJDYVIE4qW1SqDQl1SNk6ldym6oWSIqrXvkvk+55/MTPzBuF65K9uDdtmOk
	 RA3bYnp+PAzMFJPa5k9a6S+3xw0vbybMJRp95LlufRDvRuT40b4mpvYN+uR9Xx2zocCh9
	 lrCCCWb03l+2wkCJVkrUheKjVoum8hHX0LGsp77jMIpugeh8TAazLpR4NdJz5l0bdgZ1a
	 FGIsK7ji/Ayn5SGzYwTJ+4EQx95NXSuatwpZrt8QeD7oRCFd6yvLXxVyHO+Dazsy4steD
	 qpX5vYGtymc4nsGXFP/qx5qXszenqmQD02qk+rgS7XFOwL9V2Fwkj3WkWfLqSGVT52g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FHk6bE05;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.1
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB81D606A325
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 06:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB81D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FHk6bE05
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgWJ/z+J8qEzdPfbjEHgcxuFX2Gc0SbFk2k6FJRWgjG1InNzlZJKtmePRTCRN7Mt1/HOi2+5L3J2/gU0Jti/J+QvSiDbpOW/xReheVTPAVYYFtEQFpbyjIrvf1Pw4QAJP4rZApLdGtt+ToQsk6xGK6pdDIEA3NiTEN1++fUVrsVZ9+uIxtaR5Jl9iYP6O3AZ3BpRvqrG5SVo/1gJJAbDAsZHIzPmq16lSE/IYT4I9BzlImA8XzRL+JQI+FRDGPbzqkw0pDp9//ZQoDY9qSiwaTFRI4KMZ7sCxmUDibKuiKRkOapvrhpFLlvzPKiElmPvYDhI3rZT7QwEDAuMzVmB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLlp4fT2Kgrj4+ZvBml3SXsvDKzygjTVMN0YPiFlpMw=;
 b=dg+CrfEZ+YsrSJPu6jfwSzSOmjptqX9NBBOkiiNs7r4KJ508aAxG1qKfqmLo5rVT2mt+dHthdAf//Ez96XmpktebBn8BeIDqPbNdHEE+FzbEOgUdu6SZytaGmyXJ6V1iu1OjZGEq5U1Yn9s8k2FhMbNb4tcRGEEPG50IWO9Ug/bPRMdr4wuZKnu/QogNhA5Ps5LkkCxjawqeql0k+mDpT2mQtwgUJ5Rc7SDOKTFNkpnbanKPWqgsk8sLo5tl2+ZVtAgiiJ/LFS6WlajCG5XCAl+xxkW40jnd7IHmDrAOaBEe6xKQEvv7YLf2r9itJ1c0fXJKeP5+kz7Z/HY8tqxZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLlp4fT2Kgrj4+ZvBml3SXsvDKzygjTVMN0YPiFlpMw=;
 b=FHk6bE05I8JnQyvnKzQu0PpSCtqf79DoBEeReN3MAn9iREKHAbKRUbQMPFrZh77BjDYnON6f0ygXFofaCLJBcZ/C8HRsS+mW2iiijKyfm8ux9GV9UH6slbQ6ZXtmQ2tH9rCWQiSWy1lWsDRriG68/vUATa8pEX3T2RC+DaREkuM=
Received: from CY8PR10CA0008.namprd10.prod.outlook.com (2603:10b6:930:4f::17)
 by IA1PR12MB9498.namprd12.prod.outlook.com (2603:10b6:208:594::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 06:23:43 +0000
Received: from CY5PEPF00000E82.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::2b) by CY8PR10CA0008.outlook.office365.com
 (2603:10b6:930:4f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 06:23:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E82.mail.protection.outlook.com (10.167.247.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 06:23:42 +0000
Received: from [192.168.0.108] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 00:23:38 -0600
Message-ID: <dc7814c6-ea90-44b1-8cae-f4d73480a417@amd.com>
Date: Mon, 9 Nov 2026 11:53:35 +0530
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
CC: <sarunkod@amd.com>, Adam Pelka <adampelka26@gmail.com>
Subject: Re: [PATCH v3 1/3] iommu/amd: Drop unused global exclusion range
 fields and init
Content-Language: en-US
To: "Jindal, Akshay" <Akshay.Jindal@amd.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Adrian Huang <ahuang12@lenovo.com>, Joerg Roedel
	<jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20261106041650.24076-1-sarunkod@amd.com>
 <20261106041650.24076-2-sarunkod@amd.com>
 <76c9e2d2-ef9b-433c-9b84-201f43d3b940@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <76c9e2d2-ef9b-433c-9b84-201f43d3b940@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E82:EE_|IA1PR12MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 596e3a4b-2df9-4063-485e-08df3e2a0080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|921020|11063799006|4143699003|56012099006|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261022115727099003|261026130827099003|261009223027099003|261026140227099003|261026135527099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o/93yQ2IUcT1eYPlaI789gNbj6eW6ec/lCgDsQltR/ogBCX0zzDJGFXf7ZcozRt4I7UNb/MLHjjhDJ3nug28NHkKlXOmI3/cft9t9ldfljcks1YajPtrEsK7CJ7dX8HzVq3x+XIORpfDCa4iz4P9xFKjO4Svwl8UUDQ742L1PGp5vOBjTBS+eifaQpjXAV7b26lTriq8Hypxkz6jHEAhMDni2mercltZa+Z/YsU19D5h11Ujtj6aMp5HnNxvS6cdbkYmhfe5TKNba/U+vwZz2HJ6BU7ChqVntKnohfloCbquvv5d6UFzaYzYspxqzq3WAaKSmOjKfh6dMLJLFdrfcsiE+uJrc6TjGCfZJh4VQv0b124x1k7r6WAkuGpHVR/SB0eqj/CyChhefW4/BEnzxg6WdrdYRZ8xkX79kKKSSO5seh7f+pEMY13NTlNtV+Ml3Uto8IN2QN/2FnYshcvyqDDl6UBpmYddeCFzLNO6PPi+Oagz1CO53Yo0TyN2vuSC2ekaCREs2BKiacoQSnZEqvFJLfR0OAA71RazhF+IiiDt9BY3+gj0IE2VdNNrsYw+hGYbisCVW4n1gS4SQb9/6XIhA3DNA8TxH0lX6TWqHhCoQGpmlfsAij5kc80qp01OMwJiv0ECk1CnLtXtSIgVVSXvj+B14GldqNGhEeMf4I4CWHv3INGDNQz+Vnl2obPG+nRChispelWlajyT4dshI6eRCXnaOuKPFhbq+D4gcbEoGX27BTAcSlZM9engayxB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(921020)(11063799006)(4143699003)(56012099006)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261022115727099003)(261026130827099003)(261009223027099003)(261026140227099003)(261026135527099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EY6BY1ljkDCB1LqYfwP8nZANXeTIYIWErdBOyXKZ/YLQU1DmAmqX+AwX2RskpNSUGAW1RS1RED2RzJ7uoQUzv4sOozeb/Ix7EV41fMZyDvtPVQ2waOJMISFLTHLH8UFPJL+PE76PFGiscEfrsMAlgpl9G99bRDKEGITIDT/vDNTwk9EHIPvXavN59qaT///H8GqHC0HFS6mqcoDSYwQ0MeqGAdussdjIqTgoGoN2bnglulMq7vZHVnrW8cH1XTIgw2a3LzJtlRiOMzuZjif4lwck94dew2DlDRGydPdo63TmKqyWNLI7a9DLn5lZJDIYzk06i61I3Usds0fF1DP08tnvvkqgtD5bCMKwdDmwUflMKrcX3uV0UfjYUUuLV9l3lk9sUI5BGZc/azAJisJ8L96JGPYvIexalWzGUVUytwkQShRVp3jGYiKwefkYrRGd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 06:23:42.6971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 596e3a4b-2df9-4063-485e-08df3e2a0080
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E82.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9498



On 11/6/2026 2:15 PM, Jindal, Akshay wrote:
> 
> 
> On 06-11-2026 09:46, Sairaj Kodilkar wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Remove unused struct amd_iommu.exclusion_start/exclusion_length, the
>> MMIO_EXCL_* flag masks, and iommu_set_exclusion_range(). These struct
>> amd_iommu fields were never assigned, so early_enable_iommu() never
>> programmed the hardware exclusion registers through this path.
>>
>> Please note that the exclusion range registers have been repurposed
>> to SNP completion-wait store base / limit registers. So, rename
>> MMIO_EXCL_BASE/LIMIT via to MMIO_COMPL_STORE_BASE/LIMIT instead.
> Reviewed-by: Akshay Jindal <Akshay.Jindal@amd.com>
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Tested-by: Adam Pelka <adampelka26@gmail.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h | 4 ++--
>>  drivers/iommu/amd/init.c            | 6 +++---
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 8241ef922519..678ceddd711c 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -44,8 +44,8 @@
>>  #define MMIO_CMD_BUF_OFFSET     0x0008
>>  #define MMIO_EVT_BUF_OFFSET     0x0010
>>  #define MMIO_CONTROL_OFFSET     0x0018
>> -#define MMIO_EXCL_BASE_OFFSET   0x0020
>> -#define MMIO_EXCL_LIMIT_OFFSET  0x0028
>> +#define MMIO_COMPL_STORE_BASE_OFFSET   0x0020
>> +#define MMIO_COMPL_STORE_LIMIT_OFFSET  0x0028
> nit:
> 1. since it is SW based re-purpose and used in function iommu_set_cwwb_range()
> suggesting renaming to MMIO_CWWB_BASE_OFFSET & MMIO_CWWB_LIMIT_OFFSET

What do you mean by SW based re-purpose. Hardware uses the register
0x0020 to store completion wait base when SNP is enabled.

The IOMMU driver always use reg 0x0020 to store the completion wait
hence I am in favour of using *EXCL* naming.

Thanks
Sairaj

>>  #define MMIO_EXT_FEATURES      0x0030
>>  #define MMIO_PPR_LOG_OFFSET    0x0038
>>  #define MMIO_GA_LOG_BASE_OFFSET        0x00e0
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 8a410d4aa370..13c96feed64f 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -370,14 +370,14 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
>>          * Re-purpose Exclusion base/limit registers for Completion wait
>>          * write-back base/limit.
>>          */
>> -       memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
>> +       memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET,
>>                     &entry, sizeof(entry));
>>
>>         /* Note:
>>          * Default to 4 Kbytes, which can be specified by setting base
>>          * address equal to the limit address.
>>          */
>> -       memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
>> +       memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_LIMIT_OFFSET,
>>                     &entry, sizeof(entry));
>>  }
>>
>> @@ -1022,7 +1022,7 @@ static int __init remap_or_alloc_cwwb_sem(struct amd_iommu *iommu)
>>                  * completion wait buffer (CWB) address. Read and re-use it.
>>                  */
>>                 pr_info_once("Re-using CWB buffers from the previous kernel\n");
>> -               paddr = readq(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET) & PM_ADDR_MASK;
>> +               paddr = readq(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET) & PM_ADDR_MASK;
>>                 iommu->cmd_sem = iommu_memremap(paddr, PAGE_SIZE);
>>                 if (!iommu->cmd_sem)
>>                         return -ENOMEM;
>> --
>> 2.34.1
>>
>>

