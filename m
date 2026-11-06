Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793959473;
	b=tEcuXhtKrXoQKtSQov9F1z7rB0b/Al7blKFjEQP/vrMMdxX1KLPaEz9mIC5cZtRJHgxO
	 vmrfk9EAA69EQX2mtqXtTDxcaDHBvKpGGGzNJjstJmpTan9S4CQERgtn9TwR3FI79rXeH
	 aiV37XKVQK3upvpkc3PpqJx055bbMB5lnQYkeY9WvcASHjOs5kKQlicD12R9sInGyhptn
	 Ck4xp2hI83wfwE3i0klXTyEDN4SIugNeI4qiK/aEJElMFv84UInV5m0AEaq5x7jF+Pq4A
	 7wyZ6gJTYT36S9g1hErQWO0mZQOSR6/009EV1eGpkaE/NbqkiVfoVLpRn+AhGxRDQbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959473;
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
	bh=RKXG0JsCStbPywwENkucgWVA5gGDU7S7/ChdwBriBXw=;
	b=0O/ZK5o5ME2iBda4hkarllbicvinRmRledoFxr1ghhIeuB4MFMwkHDceXUddVY26JsOc
	 X7B7GMkxYDDptwN9vxj+XlGW8MDeE5XW1XceXSWVHfuG+O7jkrrYY8MfWxK7qnU/Su/Er
	 o9Zpymo5reyDIlMkepHdDPUEINuOFVtsA0UDHlchjwub2USnoCUecetwAsbaC+TTZNIi1
	 QcAmCyxqWXI1Kcnl9fx/XKzUt81jmfkb6Vo9vhS1K/nniT176yHB5F9CesPT3VTOpItTc
	 yYYcc1dKWY27P3Bikq+32bhINU+C2Sb1EUN43U2DszhxNGnfyUe7OVs/vOiGI32MTfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=krxbL37O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.0
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D1606A32C
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 10:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 255D1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=krxbL37O
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sa8PCpDheBwNmXn/kGFFyFZFi8QbyTuG3IFRJUWM0aP8XjDjkAt/Vg18MnbGWGwOPHlBLkWOW5euuKWK0plkPx0oTwGG+CC2bEdkoz38BQhpbvgHL1UoexZ9+Yv+/nkp8T4GpPWeWRxGwV8HsKtG3DktgsFqqb1RxywdPJYlB1L16c/LvQAjU94QGcyCGJAdRKuuiMz0R3vVatqXAQ3LdcAaoAHnROMXn8cGuBAqr5TcmRPPyWt5NqSg8uxfDSq/OqnymhOj2l2glb3PMF++/9DP3v3tZndokS8zDvTAOonohjmEe0ofzLX3EQzHCVvd83etxip8C9eWnJCcxsaZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKXG0JsCStbPywwENkucgWVA5gGDU7S7/ChdwBriBXw=;
 b=g2tX7S6HIVZZH2ThpbOx3cmtB9JlrHvj7X/7SgAABVbb37HQsIISmy+o1fGPjaCfd+68mZ3j+/B2TYlmOsW2O0CJLpG+AnCpUyrByzAlb2wcYTvgV2Cnjp0rtWX7xnv+df6GUxPd+i6X0BOJV6p41IGyhet9OaNZTwLj/kq4FV3vnUOD2CXTx1ND6wsMH63KqbpL+pIvMF0X0Gx3ZnrmwJCwaG7W9vGYRwpPAHoVwbckXuMZpI5bCYNl8V1w7jiSSQ31+PxXfzE1MIXoBUwJFzM/FZn+RXUvJzNAKaNCCrNEqDBlCRdwjI3YQxh8lIefaQdv+ySKY6WH+4/z8SxQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKXG0JsCStbPywwENkucgWVA5gGDU7S7/ChdwBriBXw=;
 b=krxbL37OAEDZGkGZDl3bp6x6hWSy2fFSGvAPOX78xYBnIGm7TCkOjrusBtrVKezjp301vedqk+lxixEtKsTXLRrOmrcZhR+Kf05i0ZWtzxINaTbUAbSXM7RloDsBIly/xp0Dza5PxzsVfLlZauWXmw+ujsY0yRL01WKfNZE59j4=
Received: from BN9PR03CA0181.namprd03.prod.outlook.com (2603:10b6:408:f9::6)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 10:02:24 +0000
Received: from IA0PEPF00000038.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::20) by BN9PR03CA0181.outlook.office365.com
 (2603:10b6:408:f9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 10:02:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000038.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 10:02:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 04:02:23 -0600
Received: from [192.168.1.149] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 04:02:19 -0600
Message-ID: <74c0a0d2-e728-4b6c-ad7a-0ea76f4ddd9e@amd.com>
Date: Fri, 6 Nov 2026 15:32:13 +0530
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
Subject: Re: [PATCH v3 2/3] iommu/amd: Do not convert IVMD exclusion range to
 unity range
To: Sairaj Kodilkar <sarunkod@amd.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Adrian Huang <ahuang12@lenovo.com>, Joerg Roedel
	<jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Baoquan He <bhe@redhat.com>, Jerry Snitselaar <jsnitsel@redhat.com>, "Adam
 Pelka" <adampelka26@gmail.com>
References: <20261106041650.24076-1-sarunkod@amd.com>
 <20261106041650.24076-3-sarunkod@amd.com>
Content-Language: en-US
From: "Jindal, Akshay" <Akshay.Jindal@amd.com>
In-Reply-To: <20261106041650.24076-3-sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000038:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8566a1-9816-4ebd-737f-08df3bed0e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|7416014|376014|18002099003|22082099003|6133799003|10067099003|921020|4143699003|11063799006|261028144727099003|261102123227099003|261026140227099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	9n5nR63dtJkRFv90ZFoXmLnt9k3qOHiXZuLF3JqpQLODVo1EAAwtD4jWfXAsSqDgW42Ztb8Ey78WcvPgBVwamU92mBJBilXw+QIuEe3XHq/Xu7BwhdU/LJVSQnDSnhuXgUoIu2E+ytj7HuCdNpKQm1yelSgi34HRPaRv21lKfT3oYqBRFXy88lAzfpY7fN8TxdtVPdB1D2snKCnS4wDmLARk8tU1x0OXA7kiuQGAFzKUjYo8zr9TiEfCrLTLELc7vPbjhUzNStQ2ZkFDWLU5Ez9QzhmJNsyUe7aNDjWfWE6czz0pWFp74ZjM0SuzfDFZsa6OhAd/KvxdHVOvSCaBUqzsNnZoDpaEBMLR/YCqMHPwEf9olhqUUtKmWonaa6pMoCqSvOhjqaknpZqJqsa0VSl1EybPt6vdwc9bYOt7xyFnUsy6PH1CPI8R8CmKejeFSPoU7CNGvemB67woUKTCKdsZq1mXkt8y3Mn2E1Bj0e9H+AdPhsJj5eE15yEmIgOcUTgq8b7YgMpogce6d0mD+eU7IF3/PNfeI2tvwSfMSk8JwhxG6ooz+CrTd4ElyBoSef+VJQ3MajCsysFaBZCrNXSrWgHaopvmpJ+qxxbYzhIn01moLBcUm3mfHWeBLTgs9KzFOAEq7blWOgzbawUSc/Ido3TiWy4EWu0tKDebA61lZ7dQIQdI4l2pwQ2j8E7CVyOfA8mnP+sF5F273m8S7Jix+IrPYzGKLAeYtoPkgaLQNBHxqNUDv7pCn32ON0x+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(921020)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T9y4zTTRGnfHmvfW3WBVF4gMC4//rIMSNI5u4v3ngZDH0tohbmuX9TFx2HqXxRZSqc0ppqZAGQzpEBtyM5U4V5jW66L5CuDdY1+ax/qEDPAMYa2ElaUmcYdOKNnXz97TXFyvuKKeuw1XGbA5lrGxENifEEAMDANvIVbGdycftjWCqI+6mNgDiJPUMk3gJKxsgga110fHR51fJlccmCOZh2rqFfw+LE4EkK286Px/KCtaFpFPMcHt1v1AbPsIQo2F8w4gmWsIh1bGlvQoI1mGkjpr75gYgwfP4R5lScisRz3Jj3gRxTB0SnqQnbV4A8HKu1mRoMdV482ggYlPpGSCQjQ4l/3B+fvW/MAOW7AqAG4K8eQak/g3U4fF8nsHpS7CfPt9tVC8QZO3GS6LlydAjaui9mTNt9ngY4F5qy0S9sVfb4kPxhyPJAEmYRf9KwY0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 10:02:24.4894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8566a1-9816-4ebd-737f-08df3bed0e6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000038.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391



On 06-11-2026 09:46, Sairaj Kodilkar wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Original problem was there could be multiple IVMD exclusion entries
> conflicting over a single exclusion range supported in older Linux
> kernel. The fix was first introduced in commit 387caf0b759a ("iommu/amd:
> Treat per-device exclusion ranges as r/w unity-mapped regions") and in
> commit 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
> , where IVMD exclusions are converted to separate unity_map_entry objects
> in pci_seg->unity_map so amd_iommu_get_resv_regions() treated every such
> entry as IOMMU_RESV_DIRECT with R/W.
> 
> The driver no longer programs the exclusion base/limit registers and
> relies on the kernel to keep the IOVA ranges named by exclusion IVMDs
> unmapped. Stop forcing exclusion entries to RW-unity. Store the raw
> IVMD flags in struct unity_map_entry instead of a pre-shifted
> protection value, and derive the reserved region from those flags.
> Exclusion entries are now reported as IOMMU_RESV_RESERVED with no
> read/write permission.
> 
> Reject unity entries that grant neither IR nor IW with a FW_BUG
> message, and warn about invalid flag combinations and unknown flag bits
> 
> Fixes: 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Adrian Huang <ahuang12@lenovo.com>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Adrian Huang <ahuang12@lenovo.com>
> Tested-by: Adam Pelka <adampelka26@gmail.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 12 +++++++-----
>  drivers/iommu/amd/init.c            | 26 +++++++++-----------------
>  drivers/iommu/amd/iommu.c           | 21 +++++++++++++++++++--
>  3 files changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 678ceddd711c..bcb88b476167 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -368,9 +368,11 @@
>  /* DTE[128:179] | DTE[184:191] */
>  #define DTE_DATA2_INTR_MASK    ~GENMASK_ULL(55, 52)
> 
> -#define IOMMU_PROT_MASK 0x03
> -#define IOMMU_PROT_IR 0x01
> -#define IOMMU_PROT_IW 0x02
> +#define IVMD_FLAG_UNITY                BIT(0> +#define IVMD_FLAG_IR           BIT(1)
> +#define IVMD_FLAG_IW           BIT(2)
> +#define IVMD_FLAG_EXCL         BIT(3)
> +#define IVMD_FLAG_MASK         GENMASK_U32(3, 0)
> 
>  /* IOMMU capabilities */
>  #define IOMMU_CAP_IOTLB   24
> @@ -880,8 +882,8 @@ struct unity_map_entry {
>         /* end address to unity map (including) */
>         u64 address_end;
> 
> -       /* required protection */
> -       int prot;
> +       /* IVMD flags for the entry */
> +       u8 flags;
>  };
> 
>  /*
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 13c96feed64f..1f0ca675df1c 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -70,11 +70,6 @@
>  #define IVHD_FLAG_RESPASSPW_EN_MASK     0x04
>  #define IVHD_FLAG_ISOC_EN_MASK          0x08
> 
> -#define IVMD_FLAG_EXCL_RANGE            0x08
> -#define IVMD_FLAG_IW                    0x04
> -#define IVMD_FLAG_IR                    0x02
> -#define IVMD_FLAG_UNITY_MAP             0x01
> -
>  #define ACPI_DEVFLAG_INITPASS           0x01
>  #define ACPI_DEVFLAG_EXTINT             0x02
>  #define ACPI_DEVFLAG_NMI                0x04
> @@ -2636,6 +2631,13 @@ static int __init init_unity_map_range(struct ivmd_header *m,
>         struct amd_iommu_pci_seg *pci_seg;
>         char *s;
> 
> +       if ((m->flags & IVMD_FLAG_UNITY) &&
> +           !(m->flags & (IVMD_FLAG_IR | IVMD_FLAG_IW | IVMD_FLAG_EXCL))) {
> +               pr_err(FW_BUG "IVMD type %#x devid %#x range %#llx+%#llx: Unity set without IR/IW, ignoring\n",
> +                      m->type, m->devid, m->range_start, m->range_length);
> +               return -EINVAL;
> +       }
> +
>         pci_seg = get_pci_segment(m->pci_seg, ivrs_base);
>         if (pci_seg == NULL)
>                 return -ENOMEM;
> @@ -2665,17 +2667,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
>         }
>         e->address_start = PAGE_ALIGN(m->range_start);
>         e->address_end = e->address_start + PAGE_ALIGN(m->range_length);
> -       e->prot = m->flags >> 1;
> -
> -       /*
> -        * Treat per-device exclusion ranges as r/w unity-mapped regions
> -        * since some buggy BIOSes might lead to the overwritten exclusion
> -        * range (exclusion_start and exclusion_length members). This
> -        * happens when there are multiple exclusion ranges (IVMD entries)
> -        * defined in ACPI table.
> -        */
> -       if (m->flags & IVMD_FLAG_EXCL_RANGE)
> -               e->prot = (IVMD_FLAG_IW | IVMD_FLAG_IR) >> 1;
> +       e->flags = m->flags;
> 
>         DUMP_printk("%s devid_start: %04x:%02x:%02x.%x devid_end: "
>                     "%04x:%02x:%02x.%x range_start: %016llx range_end: %016llx"
> @@ -2702,7 +2694,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
> 
>         while (p < end) {
>                 m = (struct ivmd_header *)p;
> -               if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
> +               if (m->flags & (IVMD_FLAG_UNITY | IVMD_FLAG_EXCL))
the original names were more descriptive, suggest keeping
IVMD_FLAG_UNITY_MAP/IVMD_FLAG_EXCL_RANGE rather than shortening them.
if you insist on rename, may be send in seperate patch?

>                         init_unity_map_range(m, table);
> 
>                 p += m->length;
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 56262f6b1f70..699b5f530f11 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3120,12 +3120,29 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>                 if (devid < entry->devid_start || devid > entry->devid_end)
>                         continue;
> 
> +               /*
> +                * IVMD_FLAG_UNITY, IVMD_FLAG_IR, IVMD_FLAG_IW are ignored if
> +                * IVMD_FLAG_EXCL is set.
> +                */
> +               if ((entry->flags & IVMD_FLAG_EXCL) &&
> +                   (entry->flags & (IVMD_FLAG_UNITY | IVMD_FLAG_IR | IVMD_FLAG_IW)))
Here EXCL & UNITY are flagged as invalid combination
Above UNITY & !EXCL are also flagged as invalid.
Suggesting revisiting these conditions.
> +                       pr_err(FW_BUG "%s: Invalid IVMD flags combination: %#02x for sbdf=%#x. Ignore IW/IR/Unity flags\n",
> +                              __func__, entry->flags, sbdf);
> +
> +               if (entry->flags & ~IVMD_FLAG_MASK)
> +                       pr_err("%s: Unknown flags: %#02x for sbdf=%#x\n",
> +                              __func__, entry->flags & ~IVMD_FLAG_MASK, sbdf);
> +
>                 type   = IOMMU_RESV_DIRECT;
>                 length = entry->address_end - entry->address_start;
> -               if (entry->prot & IOMMU_PROT_IR)
> +               if (entry->flags & IVMD_FLAG_IR)
>                         prot |= IOMMU_READ;
> -               if (entry->prot & IOMMU_PROT_IW)
> +               if (entry->flags & IVMD_FLAG_IW)
>                         prot |= IOMMU_WRITE;
> +               if (entry->flags & IVMD_FLAG_EXCL) {
> +                       type = IOMMU_RESV_RESERVED;
> +                       prot = 0;
> +               }
Since in case of invalid flag combinations, we are going ahead with region allocation,
will it be beneficial to add a pr_debug emitting relevant details passed on to the
iommu_alloc_resv_region()?
> 
>                 region = iommu_alloc_resv_region(entry->address_start,
>                                                  length, prot, type,
> --
> 2.34.1
> 
> 
