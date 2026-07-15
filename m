Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CA1FECCD
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089941; cv=fail; b=ifUwgBRdmDGFMnQyQ8HpvHfODxMObAzwN1DtdF7XUK1jyMyzwhMsWPQQPX6rX35sjnhMDBbwxnF30/ODFl1Cde8s5uIvyqQz3UCFTgclkba3QvPTqOR+1EtILijNyppCAN0bqgbTpW3oPs5DpXUdYrtUQ7f3z7fVP0GnPdy1dwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089941; c=relaxed/simple;
	bh=1Nn+XXNoHMjNn5NM/AwG9ZdRkCNfPnsw3DY/Aw8zBD4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lta4uiYUQ62OxaEs8x7RXgbW9QhCPR0+q8lO2D4LgtP/qn09vJugj4buJsWVnLLBw1rU9lTR3bWgxmgpnrIcDAv3lTlGDZEYvauAp3NTspTcl/DcqAhK98TeDgv4CdzmmJIi4josxyFrvlbRgzhTCDClvJSV59BV7dRp+4sasDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eTrMp/Gk; arc=fail smtp.client-ip=52.101.62.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eTrMp/Gk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlrdjUvxDescnHgAUwvT02fPk3LEb20yrMI+QumlubNQaSiHk2Qggv+YQU3XTj7kSs4B5L4Dn2b/ZqZn97b8tAFrKkcVm7Tv0WlAwSRmX7sbRsJj5qRWARjlnHtv766tuQNcRN2nMsvgJXsR4wrvEz2aI9NwE455XZjHaqT//qIlBTRdFNdVpDW5tUzIymxOA+vDeuaRD6P66NCecndZhdaNpThPf+6oWsH2tZ6q9hhDtrBBaqvINx9hylYXz7fVKgMyTf2ioMXxm7BohDNXSpfPuOCQoHqoNxkm9uRntgp8mIAV50AQHEjDbkZNUoeAcxQo5jTjYAy7u0/kKqJxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVzatFhBkuW0DXEJzAtw68uired0JKJIIGkK8TB37Tg=;
 b=bSUjOlXNQsU36QG+lvwIcFoG8V6SwRhernqH1HQsSxuBQ9cPP5yyLptqNFE2IPtkys+1IxkyW+3xx5HD2YZnnBjBW2nssdCeuU3YhraJfFRzcwvrc8msoVJ+nDOkGD5SVC6Vl02sTLlujrHSaDbx7E8mt2L227BKZ51ShRTv/qv66HM8zHEYY+5/NGePn2aFuWCK3fif/tkjJhfMmE/IeNaf5wnJCuiNyqvJWilM7CYoZ3lhCQJBLStwSE64xQNJ5j4T1XuZDP+0v0IjJYTcjLt/Vek6vbotPFWFmLPmD/LkIMf4J2KbuXYyx6v6dzS+qeFHV6++WUlQokHfExHjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=163.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVzatFhBkuW0DXEJzAtw68uired0JKJIIGkK8TB37Tg=;
 b=eTrMp/GkMDmdM/UF8w4gJu8fNHvj07uGX+qj/a3EDzH7DKU4hhQ1kfmeC2ZG60NaKYTjHX4ARGBhukHGloBx6vlRQ2zro0qTrNwdHxSYSGOlyDqDg9F245V1Kd/X3SRI3cmp8VIh/DwtYCTefgt/aO/Elz0DwqPlkMb1HKIqzuc=
Received: from BYAPR21CA0019.namprd21.prod.outlook.com (2603:10b6:a03:114::29)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 04:32:15 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::40) by BYAPR21CA0019.outlook.office365.com
 (2603:10b6:a03:114::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.3 via Frontend Transport; Wed, 15
 Jul 2026 04:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 04:32:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 23:32:15 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 14 Jul 2026 23:32:12 -0500
Date: Wed, 15 Jul 2026 04:32:03 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: weimin xiong <15927021679@163.com>
CC: <iommu@lists.linux.dev>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, xiongweimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH] iommu/amd: fix grammar and typos in comments
Message-ID: <4qwivdxrruelzxbqd4hmsfecjvmptxl7nzwu63k5cfqja3q7ql@s6opowatnxww>
References: <20260714024445.188383-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260714024445.188383-1-15927021679@163.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb0a246-ff13-4f6c-0f02-08dee22a0c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eVBXfHZIpRVcJnxYrq46mbXZ64yg1NaXV9UxbZz1j/XxJLI1UAG7yHYZ8JERZdZhTQdGcVn4FSXGE3izk1YnvYnhzy2IVXOgD2tyXNQv5MPNGf81cuVL1Tk8ob/htDjf1J+9K3kRkFE1tah0eWeVRlvvhW5xgD9jK3zDU8jriAgbBO+0CYF53ErLiFbXE3AStgi3HIBhh/VebAimld5dAidHvm6E9aW5HGQ0zIeuhrYvmoIr6WTkcARKLIwHhyyd7VWrZaZjsuthKP2GIvOvyYQWngW1soE/9S3cHbpBwFmOsC+ulTQ1QYyn+hnR5qFbmUeDlDhZYZEvu7yfKew6ShaVXATu/yRkUKVDGXveWaboDM2HB4MPpoI9/qtA/nDONhut6uT8r3Hf5u5oMbHUiV8NAZA2BmGJhQW7HCkdkvE0T+A/p/VLiw+L6lXCXrrhVHCsU3d0aLOBCF+EqzhUTKdDgQTFr+ZHv/jbnnpMvCLG3MTS5UlwVtpHjP6tQqUa2ZMl749FCobP0ZPwTw3TIY0SD4UXvU4lFfNGNIS7i9PDyBg/BCjDu7v0SsJ5r4H51ufHT3JzfPdpjgJZf/wNCCtGyrdSLDsi2X6VhdNs6Qp/L0vC5zirn1CWv37P0b10SoPAeD85bCNlRqNm28aSmKOAruQkB8uwzrxNP2DueQiPIJdJ+B0KexEboEIaFwMu65c78/ThYJMYgRl2MMiYkw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0/ysBDUGFBPN4Ni/uZvVMR3d8DyNvBzqY5BsjkNO+lgsajUcmFsllJV+JWwt+cHzYO6VR9wIpVv7LuQgiTO2TJgVh2/4e+WHjQLR40BlDjDvd7vitG5ofbyiP2kvWRWXCfRpqw8CWM/oBzi6emXeuWmxYOnFYMorSs0QKtZcAU7H6nV7Fm6ruO43w/JlFWIc9XcoGgjjraiK5P8oK8TPM156gB6Ov3w1t0h6K1QnhWLEMMrYKD2Y5gSXuEbWoVdFKfARHQNC6tID/5N8iJg+zS9ivPdJXf7zGMbyS2epDS+uZU6+8pw5lOPLS3bBXnzDlccxIa2IlgZFHuU5kKSNWJGdO+42x+o1EBZIESKPL2viVvU8+y1akcjHJQ/g9w47WF0Itw3ZUclTz5FM186UfyzmnR1zg9Ni+IimIe9E2LSrY4xfyuKFKlh/smlMdF7l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 04:32:15.5256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb0a246-ff13-4f6c-0f02-08dee22a0c4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687

On Tue, Jul 14, 2026 at 10:44:45AM +0800, weimin xiong wrote:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> Correct possessive "its", article before acpihid, and a couple of
> mangled sentences in IOMMU flush/irq comments.
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> ---
>  drivers/iommu/amd/iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 563f9c267..824a585df 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -456,7 +456,7 @@ static void clone_aliases(struct amd_iommu *iommu, struct device *dev)
>  
>  	/*
>  	 * The IVRS alias stored in the alias table may not be
> -	 * part of the PCI DMA aliases if it's bus differs
> +	 * part of the PCI DMA aliases if its bus differs
>  	 * from the original device.
>  	 */
>  	clone_alias(pdev, iommu->pci_seg->alias_table[pci_dev_id(pdev)], pdev);
> @@ -505,7 +505,7 @@ static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
>  }
>  
>  /*
> -* Find or create an IOMMU group for a acpihid device.
> +* Find or create an IOMMU group for an acpihid device.
>  */
>  static struct iommu_group *acpihid_device_group(struct device *dev)
>  {
> @@ -1268,7 +1268,7 @@ static void build_inv_dte(struct iommu_cmd *cmd, u16 devid)
>  
>  /*
>   * Builds an invalidation address which is suitable for one page or multiple
> - * pages. Sets the size bit (S) as needed is more than one page is flushed.
> + * pages. Sets the size bit (S) as needed if more than one page is flushed.
>   */
>  static inline u64 build_inv_address(u64 address, u64 last)
>  {
> @@ -3687,7 +3687,7 @@ static void fill_msi_msg(struct msi_msg *msg, u32 index)
>  	/*
>  	 * The struct msi_msg.dest_mode_logical is used to set the DM bit
>  	 * in MSI Message Address Register. For device w/ 2K int-remap support,
> -	 * this is bit must be set to 1 regardless of the actual destination
> +	 * this bit must be set to 1 regardless of the actual destination
>  	 * mode, which is signified by the IRTE[DM].
>  	 */
>  	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
> -- 
> 2.43.0
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
> 
