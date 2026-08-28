Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009343CDBB7
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899497; cv=fail; b=oWLulKvQsZO0ARvZdVFIE2p/CkKg0sNA77dxb+ihmGkgqm8PYknOwXmqcBuJpZHfpFx/QKX0WSqTS+PAPNTG4MM9Kkof1xUdeKq/pk5IOIIrAPQa51pn5VihHr74HYi0l52I/ZpcfRnSJVmiat4e6Cn4eHRMXGSGiLs1tGUjpos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899497; c=relaxed/simple;
	bh=jUcu+zzACulfzI4PCQ7TcczUULDhfHgAJ1v9wv9NGzE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbqK3k2hOD7FE2IMcuzmboji0ZKFRGgkjHC9mSr3OULGXWHtnKSQZZDkMSRekQFLNxRizEzyiv6iqfhEYtrztQwD6HDz4LG1RlOBpzLYoI7NxovAl2dDdfbZIYpexlcrN6xo7U/aakEfo1fBIO6CNblMBBm9kHyxU5i08q2vNz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TpJ5ZdlQ; arc=fail smtp.client-ip=52.101.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TpJ5ZdlQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5WpMMqtiRqjysVJ2cWmLE+WBRzJFI9fKwK+mmWpV05JY9hlHo5ZSfdKUenXNwdPPbSisggLH/O5k9uhGnhdSvZx2HbYLEXcDIeBxk3OHTMCsqiIFoHmU3yKJatewMiCe7JlPqjv9Z+eVkTNV+iaruGWFNODPNnoMQxqWfNNdan2ckypAZ5dmiWqPNjk7JjwdI4A1kHWTYHr9Fyjtmf/52uNscAN8qbZA2CJFzV7r9RYTeZWYpUrzqmAD5wySMC5t5MdC1Sb9G1VWYD4JQ2ybDnVXQkkTUCIDbHAnWFx2M8B0DIQlQieWON1KUjtfCeEfu6/k1YFbfC167mbnAZimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUs8gUr1BNrjuqbizXy37EhM8odVgG3DuCHAq7ZPZmw=;
 b=NuAK54hLj9+giV9/49uwI8kej0i+W+/YPhV35w9rWe6F4x5ykJCvJHcLd8/pDdZlaPDiX8mgfHwrLY4TqfAnlIOH/cW0It7gNU3uPhmdiYB22qoTRlv0M8R62/UvmzrkayAN4rCjfsC1LDG4gkdfOy7cmKbc+HUvNa0kroM2XT/XMYhLTHsHypezsXt40QmoRrWllErj6zRVzlErnHnLdCMPuMZXeMaErAy6kJeWmwT77eGssaXhPt0eU5J4RMp7r46tshqomR6lHVkAiJQCYMYJdKqZwnEVp5p3yxmaFofePs0GI4J2g0nyg7ZLyMJiM0tTkYGc73XkzikLLvIj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rong.moe smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUs8gUr1BNrjuqbizXy37EhM8odVgG3DuCHAq7ZPZmw=;
 b=TpJ5ZdlQzNoGgo5jq6BFU4+whJT2V1cCqoGi3bcVkO7Wd+FZsK9ebRsRlyfOGja4VkNgIM943FD/gIz/h6SNb2QnhPE+qEKTk3kekoGapMF3KTPqEXE6p8rL20m5XkaTM6TSp6VisSoLV5hOif5Akxxp5yMx7sYKLczqf743mBM=
Received: from CH0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:610:e7::34)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Fri, 28 Aug
 2026 06:44:50 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::9a) by CH0PR03CA0239.outlook.office365.com
 (2603:10b6:610:e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 06:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 06:44:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 01:44:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 01:44:49 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 28 Aug 2026 01:44:45 -0500
Date: Fri, 28 Aug 2026 06:44:42 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Rong Zhang <i@rong.moe>
CC: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Huang Rui
	<ray.huang@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iommu/amd: Do not request ACS when IOMMU is not
 going to be initialized
Message-ID: <qpkubjsl6eldhdtd2xdy3eb4beq7zt64nqxltuukowhhbcj3cu@2aovfbjfcajj>
References: <20260823-amd-iommu-fix-acs-v3-0-dd768e09d771@rong.moe>
 <20260823-amd-iommu-fix-acs-v3-1-dd768e09d771@rong.moe>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260823-amd-iommu-fix-acs-v3-1-dd768e09d771@rong.moe>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2db800-06ba-4bf0-35a7-08df04cfdba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|6133799003|10067099003|56012099006|5023799004|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZmW4zPrWz/CV5huctxz+P6J/CgYQ3s15l/LntnNIU61/s/b9oT0ksLkr7h1ut6T2XMBNVXVtPs0XISMM7i8Ic1SG0Zsc8XzC91tLesWoxirgp4ddiZkqDmLhrs5oYBtCdbpttUjaztDqrXNEYGScrgzrVAbbrSrUwK3AsUN8nOt/9JciCwEmTc8IuKsbcy47q3ixE1WuM120kFg4sjIr/3Qz+3rMprlhj1Z3X7O4CaJcvfdHfEaWN8C6MwnobYnxHaD/SGkIZLjk1HCNo3lZUFfPOe0Y0wILim3gVTL3ExcxC1tpig29uBIsmOPjYNyi0t7XDpZz/eHa4JmLyD92wQquRZH6q/4ZS9BueixkqIucVT5dJE1HIBw3IgMIUHQsjXOzi2l5AWgPmqSXQ3bi4gfVuChxXXydT5SM2PRAzeVUuLegKbkkZLQ+K7dWzLVT+AJUOPVk4EFoH9IWs0sfiSvhIkC4J1EJKf8gbigLdvqdtYqeYUcnYweSwUPj7Af2dJrxCIKWMyIWJufA9fnMrMpaHLvljfSCMmnf1I/zdbjS6ZVDyR2QIfvysHx4tB/R45rrJGEzMaHzWd/rdqI0KRKXNTLt9BVXF4+/cePyd3/HIvN9rNir9haSSAOjV4OxiBt4SrYoFTnbo6NmWVAe18pTg2T4EvyWj37YKoO1idjmHcB5z9hTMfCSjoaGsGcH
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rdNyOhzpvqCfLQUSOKpRZ4qesJn0DrEmQkLBmBvBah5/AJgdcAYsqpbfFAnrSWncjeM3bhAxc0+YresOg00EZkBjnNUi6rMQjIGFLy/Gnr685zupzEt9GvMcHJT6zcGhhfgIHXHX9LSBXU+t+4AInB71azOlDFesCA+Qgb0yA9sXEYWzVVc7AwPmlpqHsJJas9okG/cqxbxCQOW6pFVJ32RVQGVuJA/gBJkeB3OMP7wuANirkMYEMY4I1w7xNKXhIe4bsA3QrVOXli3uovL4H1tqYfXPv4AMFPDYtAcckYjzkbNtNXnmdMOXbpFXqeVfiRrDnoUWn8ehqWzxTLMtU+a5fJm455F15NetGoS764lDzflsC00YwzBGia1E/cK5mpG8ZO88pXM7RjYjeKSsFbFcGVa0BOn3ui9nYPfZ+ZMYwD7t338J7OGEn6Fndswt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 06:44:49.9497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2db800-06ba-4bf0-35a7-08df04cfdba9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

On Sun, Aug 23, 2026 at 06:20:15AM +0800, Rong Zhang wrote:
> The AMD IOMMU Initialization State Machine has the following state
> transition diagram (only the very first states are showed, and the
> `IOMMU_' prefix is omitted):
> 
>    START_STATE
>         |
>         v
> [0] detect_ivrs() --> NOT_FOUND
>         | ok
>         v
>   IVRS_DETECTED
>         |
>         v
> [1] amd_iommu_disabled? (amd_iommu=off) --> IOMMU_CMDLINE_DISABLED
>         | no
>         v
> [2] early_amd_iommu_init()
>         |
>         +-- [3] amd_iommu_detected? (!iommu=off && ...) -+
>         | yes                                            |
>         +-- ... --> IOMMU_INIT_ERROR <-------------------+
>         | ok
>         v
> IOMMU_ACPI_FINISHED
>         |
>         v
>        ...
> 
> [0] always calls pci_request_acs() as long as there's a valid IVRS table
> and no Stoney Ridge graphics. This is not optimal as ACS is not required
> in an [amd_]iommu=off boot.
> 
> In a normal boot, ACS is requested due to amd_iommu_detect() requesting
> IVRS_DETECTED.
> 
>     pci_request_acs+0x9/0x18
>     iommu_go_to_state+0x106/0x1a20
>     amd_iommu_detect+0x1c/0x50
>     pci_iommu_alloc+0x26/0x40
>     mm_core_init+0xa/0x120
>     start_kernel+0x527/0x7a0
>     x86_64_start_reservations+0x24/0x30
>     x86_64_start_kernel+0xd1/0xe0
>     common_startup_64+0x13e/0x158
> 
> This is intended to ensure ACS is requested before the PCI core
> initialization, or else a !CONFIG_IRQ_REMAP, nointremap or intremap=off
> boot would be broken.
> 
> However, in an amd_iommu=off boot, the state machine still requests ACS
> at the exact same time, as amd_iommu_detect() has nothing to do with
> amd_iommu_disabled.
> 
> Even worse, in an iommu=off boot, though amd_iommu_detect() bails out
> early, ACS is still requested due to amd_iommu_prepare() requesting
> IOMMU_ACPI_FINISHED, which is called by irq_remapping_prepare() thanks
> to CONFIG_X86_LOCAL_APIC (always set on X86_64) and CONFIG_IRQ_REMAP
> (enabled by defconfig), unless nointremap or intremap=off is also passed
> to cmdline.
> 
>     pci_request_acs+0x9/0x18
>     iommu_go_to_state+0x106/0x1a20
>     amd_iommu_prepare+0x15/0x40
>     irq_remapping_prepare+0x43/0x60
>     enable_IR_x2apic+0x22/0x190
>     x86_64_probe_apic+0xa/0x50
>     apic_intr_mode_init+0x70/0xd0
>     x86_late_time_init+0x28/0x40
>     start_kernel+0x6f9/0x7a0
>     ...
> 
> In both cases, [2] is still gated due to the [1] or [3] check, so that
> IOMMU can be disabled per cmdline.
> 
> Technically, it makes no sense to detect IVRS at all in an
> [amd_]iommu=off boot or if IOMMU is not supported due to platform
> settings. This is probably why amd_iommu_detect() bails out before
> requesting IVRS_DETECTED. Apparently only bailing out there is not
> sufficient, and the bailing-out paths should really have been parts of
> the state machine.
> 
> Clean up the initialization routines by moving the bailing-out paths and
> [1] to the right place in the state machine (i.e., before [0]), and
> always requesting IVRS_DETECTED in amd_iommu_detect() to initialize the
> state machine early and properly.
> 
> Note that the condition (iommu_detected && !gart_iommu_aperture) is
> dropped as it's dead code since the relevant code being removed. It
> meant to detect what commit 6631ee9d0099 ("x86, AMD IOMMU: add
> dma_ops initialization function") had introduced, but commit
> d7f077697533 ("x86/amd-iommu: Fall back to GART if initialization
> fails") has removed it. Later, commit 78013eaadf69 ("x86: remove the
> IOMMU table infrastructure") ensured AMD IOMMU being detected before
> Intel's and led to iommu_detected == gart_iommu_aperture in any case.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> ---
>  drivers/iommu/amd/init.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 40726dfef273..0fd0801a873f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3470,6 +3470,8 @@ static void amd_iommu_apply_erratum_snp(void)
>  #endif
>  }
>  
> +static bool amd_iommu_sme_check(void);
> +
>  /****************************************************************************
>   *
>   * AMD IOMMU Initialization State Machine
> @@ -3482,7 +3484,13 @@ static int __init state_next(void)
>  
>  	switch (init_state) {
>  	case IOMMU_START_STATE:
> -		if (!detect_ivrs()) {
> +		if (no_iommu || amd_iommu_disabled) {
> +			init_state	= IOMMU_CMDLINE_DISABLED;
> +			ret		= -EINVAL;
> +		} else if (!amd_iommu_sme_check()) {
> +			init_state	= IOMMU_INIT_ERROR;
> +			ret		= -EINVAL;
> +		} else if (!detect_ivrs()) {
>  			init_state	= IOMMU_NOT_FOUND;
>  			ret		= -ENODEV;
>  		} else {
> @@ -3490,13 +3498,8 @@ static int __init state_next(void)
>  		}
>  		break;
>  	case IOMMU_IVRS_DETECTED:
> -		if (amd_iommu_disabled) {
> -			init_state = IOMMU_CMDLINE_DISABLED;
> -			ret = -EINVAL;
> -		} else {
> -			ret = early_amd_iommu_init();
> -			init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
> -		}
> +		ret = early_amd_iommu_init();
> +		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
>  		break;
>  	case IOMMU_ACPI_FINISHED:
>  		early_enable_iommus();
> @@ -3695,12 +3698,6 @@ void __init amd_iommu_detect(void)
>  {
>  	int ret;
>  
> -	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
> -		goto disable_snp;
> -
> -	if (!amd_iommu_sme_check())
> -		goto disable_snp;
> -
>  	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
>  	if (ret)
>  		goto disable_snp;
> 
> -- 
> 2.55.0
> 
