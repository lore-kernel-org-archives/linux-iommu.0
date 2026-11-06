Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793954115;
	b=Mb7bq5itQMF5HValZuKn+06U/T7z8EAnyJf5Uo8v8hS68LEN+Vg9EKAL62Bcf9fp1om7
	 XYMO+W35oOXCsupf1Q4bOc+AdhRJLrO0jr0CEAh9jxvJ9iu9EkFqS3mWSZnb39yX6GapD
	 qGWntqb7wOvw5z5taR7XwNGX+BS5Zhb5rK0GdQ19yy4uOL/wsLZRdRJ5sHYOcx4ebph1s
	 HaPtmBn0wVvxCRtKAraqrTKKrr1oY2KeyQZef78a9aIC4nzczK7tYKU3H1PYe32iEF6gC
	 W2KZqACo2IkuCHfEtNZX14vsk2KRFmEaT9kUsgFJ0xlpALj06Bsus8rogo0tPnRFkzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954115;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
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
	bh=odFKr9DE3Ktb3pU+tsU16LPeIzIVirlOOUpDuqxQ2Xk=;
	b=BcEUB+J45bNVnT8Pj3ZSEMwKi/tQdKsULFtJPz2Nx+ucLSlY44DYtiMcZtCmzpuWtTI5
	 GXBBvRTIpQ3uIdhMUMDdSAvPVBOIJz8kwW5SunnehHaiLQhBhwViroFbMnZdNyt7UkwmZ
	 mPvgbuiiSXr53i+rBK89QggLjwGJ/Jd3yBhme3PFfSejS92cjv3ruAtEsmc7e+gbrVain
	 kLiXXVSXvQlcBguWR6IPHSFalamMzzW3BZZO1c16Tb1+g80NuQ4b2iiIlm0+Ez/odL/VN
	 RC7hBzQn86cnI9LxNp92+s+0J6UhGAdjBCfFI6zCB8VPPLJCmCG9IheINjPc7D7cJjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n5YCWen0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.29
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B88606A326
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 08:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6B88606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n5YCWen0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrWsjBThvtx0BeEPQU26OgkPqAz30tqWh7847AdLqW1CPpU+pHbqjYrVGLQe3BR602c0lbfYdbgx5zQ/nU+6BHvZZMjhivbJuOCUObF6wlsNhi7FMxIaXE7LXEBPKyzV3I73IsuBBuIG9p1Nk1mAsfuQNrwuQHrMbWi4DQy548wjl/gY5P3QqU6uePEMYm90OLAmnoPBIpXh5Bg8psf/3ddybLWC56SW3vebBiRj9bn1KEjAgpZ7/hyghPTaz0akbJ3BNyDlfC7RG9uJU/WRBqyewhCNof0v3Oc2ZKP9Gls2OLG16Zfr/h10hIKThg5ZI0BaHdOSpzHDgrcPD8IJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odFKr9DE3Ktb3pU+tsU16LPeIzIVirlOOUpDuqxQ2Xk=;
 b=h55Qp48YrFSlUwCnTnX0mcwzjGB1VMU860HQ8lpqnB8JhHWtHkq9ASdNuUxc4wvfOrQbTscnGc4+JZj5Awd/pxg9cl4ufR1gh4RGXkvjL/1u5ZYuBuPOmph6RobpEwpuS0kxA/zQE/HUdvnOd9KcJp74puborFqwwk5i3C8H6IkymuerG6fRV6cMdRahjQ0Nh2T2zTWD83Sa1Ghczs7Yd17SsxZpBDmwMXy8JbzmxyuyGbQwkRkIdi03DtD9m7U6ZpZggRECwwjDzCPnyLm4OmLVI/aE4ZKf4MQMwqbuDbYI1nqMf7RvbLbBATOiE/jNpG9CCeX4CatFnY9Jj9n7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odFKr9DE3Ktb3pU+tsU16LPeIzIVirlOOUpDuqxQ2Xk=;
 b=n5YCWen04bDkzpB9pgA/sTNEV8HQPiviDQFbwAbIJNcAB4ZaoZVYCFx4VI/v97w/nb7Fx2dkda8sjCWaWhknxmot3Yzb4ZN2IMDoR7+8nJm71/9kVJGyo8NNEQ9Pj7lVwYv1Wx6CY0jFva8PXO7yx9B+q+/7A53zFypbzdBcE2Y=
Received: from MW4PR04CA0200.namprd04.prod.outlook.com (2603:10b6:303:86::25)
 by DS6PR12MB317717.namprd12.prod.outlook.com (2603:10b6:8:414::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 08:35:09 +0000
Received: from CO1PEPF00018861.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::ab) by MW4PR04CA0200.outlook.office365.com
 (2603:10b6:303:86::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 08:35:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018861.mail.protection.outlook.com (10.167.249.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:35:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:35:07 -0600
Received: from [192.168.1.149] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 02:35:03 -0600
Message-ID: <f5188f91-d159-4162-9f99-4a5f3ca11cea@amd.com>
Date: Fri, 6 Nov 2026 14:04:57 +0530
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
Subject: Re: [PATCH v3 0/3] iommu/amd: IVMD handling cleanup and ivmd= boot
 override
To: Sairaj Kodilkar <sarunkod@amd.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Adrian Huang <ahuang12@lenovo.com>, Joerg Roedel
	<jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20261106041650.24076-1-sarunkod@amd.com>
Content-Language: en-US
From: "Jindal, Akshay" <Akshay.Jindal@amd.com>
In-Reply-To: <20261106041650.24076-1-sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018861:EE_|DS6PR12MB317717:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5e9014-be6e-46b1-3237-08df3be0de19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|3023799007|10067099003|13003099007|921020|261026140227099003|11063799006|261026121527099003|261102123227099003|261028144727099003|261021123027099003|56012099006|261021121427099003|261009223027099003|261022075727099003|261009221227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	tyhpdIHLu+YbfwLz5w8TB+rJVoyaJEPV8xGUJ8NEpfZw8S3EmHlans9JvLQYsCISsnvUbeV44hSr83A6J9E7R8jrdImBYMbpxJy+TV2U216BXSQNVvImRD1IFIKIItMfmmzSy5HdvgS4G6hJTRistvCjS/eKQYP1G9IlstIUZKukS8lFO0aMvdjzqgStP8rC4zlCI2pAZ3bXXpd9UPHiFeiu4eHLd+nKxMqZqpNRaxKWhozpG8Gj56fcQeIA5ZjUZ5MT5osK1T5j0dmmM09n5mDWuM4a4B4XUT1cohTbxcWSDXmbhqLEp5zdWi4hlQJro0NRtFNld4Wn+oXGAQfIdqwpLI7scxZU/Ynve4CfX6Q8F5mp8HdULuQDiCWEGKdPiBeuQPxlWW5kmQXxT0z0Ottyp0EcBkHgTIlhVw97dTfuCxSKFMDbdZUDV2hJ9MXmksiA8eHqroBRNVwoBS0zQzpN1SKzq+rozeKRQOx+pV+wU7FAbJqQem/nGwGaJyy5dcb5pQxSpv11z9ycTade3CVrGDsf3otZaajVpRKtDY5QJ8sBP7E8u1NJIQwc6/iEDw06gA2S2WXx49II7CDsI53XLK495Bp42tUSr77HfuUvtNcpFSkCkOHqL9hKPSspBUhjcQq2yANH9beM3+0EJ6v96EzBrpEO/pPKAl4cxL+MVZcj4kJUrDRs5xx/GFKAkBR+ODDSXcq3JlQyF4oQHw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(10067099003)(13003099007)(921020)(261026140227099003)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261021123027099003)(56012099006)(261021121427099003)(261009223027099003)(261022075727099003)(261009221227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BOFdzaH16xmj8X/8kFlbPPj4jJ/XsETKGDOnpVebnAHkfcwnNfidq024qI7boAfwlZXRRx6ssGhrHL/5NNowWnwZt7f8yUBZrM5FSiBfQdeKbtMPf//sqmKvkUpvvQ827QYbZ5kj3ytnQWdO8eh2y+g1hVyvRH0NJqUuvFQrq/5uk+YD/qdWpAQZlyHpH4fw+oHa+VxCU+14/umnPQGlleagxesmuQLwbARaNahpGnrHYFNgG9fWOIeodIf8PUPyjhllp8ydohY3Nx3HH5meHaGhjxQmuJvvDNiYd3tibMFKxm7hE5NFwzdtpIWPeWHUf8XqWyq75xgwScjYKyksYiA2VSbQsBmOohCF5fNjPrE5vpQVL+s5tN+5gH2wuc1/By+FZGoPQSKRFlvTuzeOgwwXr0njj5q7ClkdpvhQZDSp7VqSlCTJvtvHW+tVTy97
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:35:09.4008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5e9014-be6e-46b1-3237-08df3be0de19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB317717



On 06-11-2026 09:46, Sairaj Kodilkar wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> This series refreshes how the AMD IOMMU driver models IVRS IVMD entries
> after the hardware exclusion range registers were repurposed.
> 
> The first patch renames the associated MMIO offsets to reflect completion-wait
> store base/limit.
> 
> The second patch drops the workaround that forced IVMD exclusion ranges to
> r/w unity mappings; the driver no longer programs exclusion range
> registers, so that the workaround is obsolete.
> 
> The third patch centralizes IVMD flag definitions, renames the unity-map
> structures to ivmd_entry, stores the raw IVMD flags byte from ACPI, and
> derives IOMMU reserved regions (including exclusion as IOMMU_RESV_RESERVED)
> from those flags.
> 
> The fourth patch adds an ivmd= kernel parameter so up to four per-device
> IVMD-style ranges can be supplied from the command line when the IVRS
> table is wrong or incomplete, documented in kernel-parameters.txt.
if patch 4 is dropped, you can drop mention of patch 4 from cover letter as well.
> 
> Changes from v2:
> https://lore.kernel.org/all/20260424092213.16976-1-suravee.suthikulpanit@amd.com/#t
> 
> *Patch 2: Report an IVMD exclusion range as IOMMU_RESV_RESERVED in this
>           patch, instead of leaving that for patch 3. This patch stops
>           forcing the exclusion to read/write unity, the range has no read
>           or write permission. iommu_map() rejects that, so a tree checked
>           out at patch 2 does not boot. Reserving the range in the same
>           patch keeps the series bisectable.
> 
> * Patch 4: Drop this patch, ivmd= command line does not have any real use and
>            complicates driver
> 
> 
> Change from v1:
> (https://lore.kernel.org/linux-iommu/20260420170033.6780-1-suravee.suthikulpanit@amd.com/)
> 
> * Rebase on top of patch "[PATCH] iommu/amd: Remove dead code for exclusion ranges in IVMD"
>   that was submitted by Yu Zhang <zhangyu1@linux.microsoft.com>.
>   (https://lore.kernel.org/all/20260331152550.479841-1-zhangyu1@linux.microsoft.com/)
> 
> * Patch 1: Modified to only rename the marco.
> 
> * Patch 3: Reintroduce logic to parse IVMD exclusion flag to allow
>   reserve region of type IOMMU_RESV_RESERVED.
> 
> * Patch 4:
>   - Update the sscan function to scan start, length, flags in hex format only.
>   - Fix apply_ivmd_cmdline_entries() to not free the cmd, which points to
>     the early_ivmd_cmdline_map[]  on failure path.
> 
> 
> Suravee Suthikulpanit (2):
>   iommu/amd: Drop unused global exclusion range fields and init
>   iommu/amd: Do not convert IVMD exclusion range to unity range
>   iommu/amd: Rename unity_map_entry and unit_map to ivmd_entry and
>     ivhd_entry_map
> 
>  drivers/iommu/amd/amd_iommu_types.h | 22 ++++++------
>  drivers/iommu/amd/init.c            | 54 ++++++++++++-----------------
>  drivers/iommu/amd/iommu.c           | 28 ++++++++++++---
>  3 files changed, 58 insertions(+), 46 deletions(-)
> 
> Base: 945b3729fca6176fdbb83e38c8116b0132c68fbe
> --
> 2.34.1
> 
> 
