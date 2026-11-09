Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794206039;
	b=MaUPAIi1yXKSMV6Z/RsF/27jm3Vx6CYFQbibbOw5RAaoVKMhwl49yP+NPDmW/9JAbgOr
	 5ECafQcZIEdIUL+22o1YwgTr08F0tcyvm94u8+KjdHEq/vw2Rz7KbEc1xB3QF2XT43UD0
	 BHy5aD5UcFpHiG+X826TGbiYnvM6L4X0xgG67sQjzl/mzbjq5LxWMweJwudhejAdC0elG
	 wWIBNi/aaixp83izirsXKm64n1xOYwGD2jKvQukNyEM6TflIgPRP7tXbIw+VXPLA+C8Pt
	 kJj7RYYPXMQ2963QcGQ2qAUnCJT0ppObEq52kgCRcAxjUo/W6fXy2uPX5Pi3MHt8snw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206039;
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
	bh=TGKKN+hTUqo0yRzfVcAoq3xc/2NXn5d292XI5ounf8U=;
	b=O8JXpYA6aH7G6PqFXtg1/gyKe14NqB2ZHIHI720MDCZ4Hbl2jmpAiNNOzHdJirB2FK6I
	 63A2koKudTHekAXI/CKg/BwX7G/Nc0YL6sL+QnGhvNGaqjaXHqoaq8XbuA1nUEaGdtgLe
	 H9XJq0f+a0raLflk4Lmbj7x3E4SlJguHbmDFbBOZIWxIIciOrTjeJFDzJRqA8hVOQTsUE
	 G9buIaR3DhA0zqM355SI1Uz9j+6CsjjG44KgHG5sIsj3H3XCFfsSXEgKEVtFaoJjzy0cm
	 qaG9wazHszDNVAXR3h3a4aIht6oPNs5NpktAG3NgJCchEB2eksQOSAZ9Huet9SuvxlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q3uO3mV0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.41
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F6606A31C
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 06:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 837F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q3uO3mV0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+UE+z0Tuc7U/xV8OiMrIPk3jp+nZPqWesPah8CONtouiIFLHCGo2HKfWJtbkzTW8xlG+IXcXlw8JzhqeFseHsv2DjKq6QvFDwEkBbmXuDaw7d9YAlUD/jXSy3F04X1a5hXUzMz5+jVlzZcZySbh1GLsexDU7CQeAT5jJZDH6eR57ApCaz63dynsdgY0HTijBgCQqdUDFRY50U275b/f0ZeLIhqVfXlDO/8rL0BqYX5YWNIq0r0agONUcOZbOWVUNMNdUjf2uItGqLpdPA2LJ+GhKNFlyYhJRut/jdL+SG31fw7S+4L6wA0APgNFsf+rtuMxzvNFW5ivGGKWr8cPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGKKN+hTUqo0yRzfVcAoq3xc/2NXn5d292XI5ounf8U=;
 b=cn4omE4EhjdzfrDjHukth4MZt4RTl/R5UwmAErQBBwEzSe6MgxZll9e3PMxbBOPuvJCmrBZD/mS60kwlqLKVVNA7rykSCujd7ClyqLUU5BODzQtRQirZIO8RAKA8uMH6Ko0tr22pups2aYBHRYyD9TWXz6AVeovJAoqPYkURRMByePads+fATd5pXxZFA9zT+G88GJyxkbhhbOul1XnBm7A8VBTBcHnTpwQ9xlZqY1w2VKxdQn1INqrSS7muqnVMacTYcFuIag6pgawLdTR7LvM0al/SusAmG792bRCHfLLA76xcZkC0XMBPSZA46E2hXNQ1xWzm+ahgOQPtUntb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGKKN+hTUqo0yRzfVcAoq3xc/2NXn5d292XI5ounf8U=;
 b=q3uO3mV0HQ4JEDnBzX5aX+YznGACUbpgnDH6ERM8w5RAfqshqLEdeAygxAjese3HxFtTZbbnwo8dzFdIreZzNh1UxOmGaXFz8zCZBlwwycW1EOBefExKCaTi32N4sIWrPRpDCvzW5HbS/37Vv+w5obpXc5chOwO6k0FJDN/kqgs=
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.13; Mon, 9 Nov 2026 06:33:53 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::af) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 06:33:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Mon, 9 Nov 2026 06:33:53 +0000
Received: from [192.168.0.108] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 00:33:48 -0600
Message-ID: <046279e0-2022-4b43-8cd4-b32cf4a8c584@amd.com>
Date: Mon, 9 Nov 2026 12:03:45 +0530
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
CC: <sarunkod@amd.com>, Baoquan He <bhe@redhat.com>, Jerry Snitselaar
	<jsnitsel@redhat.com>, Adam Pelka <adampelka26@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/amd: Do not convert IVMD exclusion range to
 unity range
Content-Language: en-US
To: "Jindal, Akshay" <Akshay.Jindal@amd.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Adrian Huang <ahuang12@lenovo.com>, Joerg Roedel
	<jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20261106041650.24076-1-sarunkod@amd.com>
 <20261106041650.24076-3-sarunkod@amd.com>
 <74c0a0d2-e728-4b6c-ad7a-0ea76f4ddd9e@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <74c0a0d2-e728-4b6c-ad7a-0ea76f4ddd9e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 97132d67-7938-4b46-738a-08df3e2b6c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|921020|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZPtRD2EdQnKi8sPpJ9kUrIxivEq+gl1YTgBIKpHQ8fINFr5Xn7RilnQoj63RSq1qM38iJr+FFWESH0lGuh82jXuCL8T+Pw24HcRjdq/EZYxPMIJVSn7VPWJV73Nt8hJfqZ/dpv0GP1g998w8D6vl+MYhGG5//cKvDRkh6jHBoLFkMRG3Ovpt+m9dcrUQRXdiDuj4v6A6E7o96Ezj/3jIL/MPW2Zn7fOUxB8xz4kehIpRpKjmcFWmiqb4LzFUHjYwZ81UKBN4ueP3AJh+bXaVWF0Cz55nlk/fAQc00qslcEomSP9pGoCxCIw+shkKWSYcAyHHO1WcB8jnwui8Ko1hthKt2dAwNVNUTGn8lRwrmJxxJc/SkadJPBD4EwlVfjnsSY89///eH6XAoIJrviRlltzm9SBb1bxumvcmveliYUbBWPTxJZ6bRc5W3HrHaQrs5TTKoNZAm5HMd7wvYr8FMk97mnbx1TnyvoPtNd0xQryq5PTnN6QK5O8C+NLQggOUws9x2hhH6n5xXVTAWRJB75G06veyktUU51qYEKJjgrD5QkOPS3GG1ZjDSw0SbpH/Nw8Cd356DTXfpH6mXKNMoOpqWWTEvvjylQeVXKi1a5fy6f9bFzOW0uOx1Wfleh+tiFxEgu225PLFmxTNarqMwJjD2HA63qIaVZ3dhRO57kMJe9W/2Uaa+wuJRhN4EyLgXKVRvVTIekJFJdimaMigPk5ieNfHuIqdNM4lcdQsbIuvbmUQjz2d9YpBzXMHORL8
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(921020)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Sb0A7iihz0a8lKDsABsLcwhbFWNVlx6xY1iW4AKV27W915OA+V7dYDcpHFB+O6A2+qqp7aN+ZDlzfAKdu2wzxoDLZp0jvmRr7XMQj72W3yvEfLihzEfrQ+UF/2QryEvQ8snm/NgAQx5AaGW3JKnbcTb8uqosz92Z3sCPv1Jx2xiHhbcJ+lOs4GQHBSGbOv5XKWjfJ3hIKUeZUAlOS0V5Quru2Z2qVdXNUXhfn7SYucMjykpT7uzgNFllOU/CgbMxHulme33hQKWgdmswBujHtS6G0fPq0mKYGWItnkjXBsvSaOWtsN2ITHmG7T+qLVpG/qJXsFvE+9opFDuJFhkoLv5RXYeFUuM6EayWDtOHTZ4ZNEFAPKGKKN3JGGlm9DfHTRuqvvCfGzAfVOzmuYG7Nnrlt1bz6GRMAh8weoM75cwt55T+rjoQxBtwyJt7Z6FZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 06:33:53.0442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97132d67-7938-4b46-738a-08df3e2b6c44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491



On 11/6/2026 3:32 PM, Jindal, Akshay wrote:
> 
> 
> On 06-11-2026 09:46, Sairaj Kodilkar wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Original problem was there could be multiple IVMD exclusion entries
>> conflicting over a single exclusion range supported in older Linux
>> kernel. The fix was first introduced in commit 387caf0b759a ("iommu/amd:
>> Treat per-device exclusion ranges as r/w unity-mapped regions") and in
>> commit 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
>> , where IVMD exclusions are converted to separate unity_map_entry objects
>> in pci_seg->unity_map so amd_iommu_get_resv_regions() treated every such
>> entry as IOMMU_RESV_DIRECT with R/W.
>>
>> The driver no longer programs the exclusion base/limit registers and
>> relies on the kernel to keep the IOVA ranges named by exclusion IVMDs
>> unmapped. Stop forcing exclusion entries to RW-unity. Store the raw
>> IVMD flags in struct unity_map_entry instead of a pre-shifted
>> protection value, and derive the reserved region from those flags.
>> Exclusion entries are now reported as IOMMU_RESV_RESERVED with no
>> read/write permission.
>>
>> Reject unity entries that grant neither IR nor IW with a FW_BUG
>> message, and warn about invalid flag combinations and unknown flag bits
>>
>> Fixes: 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Adrian Huang <ahuang12@lenovo.com>
>> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Adrian Huang <ahuang12@lenovo.com>
>> Tested-by: Adam Pelka <adampelka26@gmail.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h | 12 +++++++-----
>>  drivers/iommu/amd/init.c            | 26 +++++++++-----------------
>>  drivers/iommu/amd/iommu.c           | 21 +++++++++++++++++++--
>>  3 files changed, 35 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 678ceddd711c..bcb88b476167 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -368,9 +368,11 @@
>>  /* DTE[128:179] | DTE[184:191] */
>>  #define DTE_DATA2_INTR_MASK    ~GENMASK_ULL(55, 52)
>>
>> -#define IOMMU_PROT_MASK 0x03
>> -#define IOMMU_PROT_IR 0x01
>> -#define IOMMU_PROT_IW 0x02
>> +#define IVMD_FLAG_UNITY                BIT(0> +#define IVMD_FLAG_IR           BIT(1)
>> +#define IVMD_FLAG_IW           BIT(2)
>> +#define IVMD_FLAG_EXCL         BIT(3)
>> +#define IVMD_FLAG_MASK         GENMASK_U32(3, 0)
>>
>>  /* IOMMU capabilities */
>>  #define IOMMU_CAP_IOTLB   24
>> @@ -880,8 +882,8 @@ struct unity_map_entry {
>>         /* end address to unity map (including) */
>>         u64 address_end;
>>
>> -       /* required protection */
>> -       int prot;
>> +       /* IVMD flags for the entry */
>> +       u8 flags;
>>  };
>>
>>  /*
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 13c96feed64f..1f0ca675df1c 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -70,11 +70,6 @@
>>  #define IVHD_FLAG_RESPASSPW_EN_MASK     0x04
>>  #define IVHD_FLAG_ISOC_EN_MASK          0x08
>>
>> -#define IVMD_FLAG_EXCL_RANGE            0x08
>> -#define IVMD_FLAG_IW                    0x04
>> -#define IVMD_FLAG_IR                    0x02
>> -#define IVMD_FLAG_UNITY_MAP             0x01
>> -
>>  #define ACPI_DEVFLAG_INITPASS           0x01
>>  #define ACPI_DEVFLAG_EXTINT             0x02
>>  #define ACPI_DEVFLAG_NMI                0x04
>> @@ -2636,6 +2631,13 @@ static int __init init_unity_map_range(struct ivmd_header *m,
>>         struct amd_iommu_pci_seg *pci_seg;
>>         char *s;
>>
>> +       if ((m->flags & IVMD_FLAG_UNITY) &&
>> +           !(m->flags & (IVMD_FLAG_IR | IVMD_FLAG_IW | IVMD_FLAG_EXCL))) {
>> +               pr_err(FW_BUG "IVMD type %#x devid %#x range %#llx+%#llx: Unity set without IR/IW, ignoring\n",
>> +                      m->type, m->devid, m->range_start, m->range_length);
>> +               return -EINVAL;
>> +       }
>> +
>>         pci_seg = get_pci_segment(m->pci_seg, ivrs_base);
>>         if (pci_seg == NULL)
>>                 return -ENOMEM;
>> @@ -2665,17 +2667,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
>>         }
>>         e->address_start = PAGE_ALIGN(m->range_start);
>>         e->address_end = e->address_start + PAGE_ALIGN(m->range_length);
>> -       e->prot = m->flags >> 1;
>> -
>> -       /*
>> -        * Treat per-device exclusion ranges as r/w unity-mapped regions
>> -        * since some buggy BIOSes might lead to the overwritten exclusion
>> -        * range (exclusion_start and exclusion_length members). This
>> -        * happens when there are multiple exclusion ranges (IVMD entries)
>> -        * defined in ACPI table.
>> -        */
>> -       if (m->flags & IVMD_FLAG_EXCL_RANGE)
>> -               e->prot = (IVMD_FLAG_IW | IVMD_FLAG_IR) >> 1;
>> +       e->flags = m->flags;
>>
>>         DUMP_printk("%s devid_start: %04x:%02x:%02x.%x devid_end: "
>>                     "%04x:%02x:%02x.%x range_start: %016llx range_end: %016llx"
>> @@ -2702,7 +2694,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
>>
>>         while (p < end) {
>>                 m = (struct ivmd_header *)p;
>> -               if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
>> +               if (m->flags & (IVMD_FLAG_UNITY | IVMD_FLAG_EXCL))
> the original names were more descriptive, suggest keeping
> IVMD_FLAG_UNITY_MAP/IVMD_FLAG_EXCL_RANGE rather than shortening them.
> if you insist on rename, may be send in seperate patch?
> 
>>                         init_unity_map_range(m, table);
>>
>>                 p += m->length;
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 56262f6b1f70..699b5f530f11 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3120,12 +3120,29 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>>                 if (devid < entry->devid_start || devid > entry->devid_end)
>>                         continue;
>>
>> +               /*
>> +                * IVMD_FLAG_UNITY, IVMD_FLAG_IR, IVMD_FLAG_IW are ignored if
>> +                * IVMD_FLAG_EXCL is set.
>> +                */
>> +               if ((entry->flags & IVMD_FLAG_EXCL) &&
>> +                   (entry->flags & (IVMD_FLAG_UNITY | IVMD_FLAG_IR | IVMD_FLAG_IW)))
> Here EXCL & UNITY are flagged as invalid combination
> Above UNITY & !EXCL are also flagged as invalid.
> Suggesting revisiting these conditions.
>> +                       pr_err(FW_BUG "%s: Invalid IVMD flags combination: %#02x for sbdf=%#x. Ignore IW/IR/Unity flags\n",
>> +                              __func__, entry->flags, sbdf);
>> +
>> +               if (entry->flags & ~IVMD_FLAG_MASK)
>> +                       pr_err("%s: Unknown flags: %#02x for sbdf=%#x\n",
>> +                              __func__, entry->flags & ~IVMD_FLAG_MASK, sbdf);
>> +
>>                 type   = IOMMU_RESV_DIRECT;
>>                 length = entry->address_end - entry->address_start;
>> -               if (entry->prot & IOMMU_PROT_IR)
>> +               if (entry->flags & IVMD_FLAG_IR)
>>                         prot |= IOMMU_READ;
>> -               if (entry->prot & IOMMU_PROT_IW)
>> +               if (entry->flags & IVMD_FLAG_IW)
>>                         prot |= IOMMU_WRITE;
>> +               if (entry->flags & IVMD_FLAG_EXCL) {
>> +                       type = IOMMU_RESV_RESERVED;
>> +                       prot = 0;
>> +               }
> Since in case of invalid flag combinations, we are going ahead with region allocation,
> will it be beneficial to add a pr_debug emitting relevant details passed on to the
> iommu_alloc_resv_region()?

Sorry I made a mistake here,

Here's summary of what I wanted to do,
1. Reject UNITY mapping if IR and IW flags are not present
2. Reject exclusion mapping if either UNITY / IR / IW flags are present

Thanks for pointing it out. I'll update it in the next version and move
all the firmware related checks inside init_unity_map_range(). I'll also
reject this condition as it does not make sense to add the region with
invalid flag combination (a region cannot be both UNITY and EXCL).

Thanks
Sairaj

>>
>>                 region = iommu_alloc_resv_region(entry->address_start,
>>                                                  length, prot, type,
>> --
>> 2.34.1
>>
>>


