Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAEE47CA64
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308970; cv=fail; b=GdgbeEYohr97jaKrZ9UtiMcAtpihfPgLMZP1NWze1YoajE3AT7pa/dDIj5ocIRlaBrebqUhCrKhROzfviIahstXZGVZL/QG0mRpndgc9lGHR1+5OZn95ahgnSnyOs3xvKbEWd0Wfc0TuCBHS2EADNbRDngXheNkWWT6EO1fojZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308970; c=relaxed/simple;
	bh=nPJNqKy6CtTjFzg5zFfauMorSibOzenJ8UIdvHuIM44=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b+YhY8KrMjaEVPuo86gh24CV4FU8HnL8f0KrwqlBnwi6gZGbry40gUmapwSws+rNK89nhaUTIWDzTsdh63xQcw92Gr4Y58FeRX6J3Sf6KFA1iNKany7NWb6nXRSJej1ao3GUDa4tXnVlnPJMIbIW8h7BzaD5FyeDx4Z7yussSLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aWsvIcs/; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aWsvIcs/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAOVH4BNas13Qv7NZhtgLNTulAkfEyH7HqG9ryXdaN1f9DQzL7cRVxG8MsL8uWgrp25KPOUEe5TnV+mQxS8dmp35ZJuQALMomNjF9QwO01vHrQIzzYtKsHgZVITj+cOerjqj9hG5kGTXXY7xI9Ke8XfWlDh43TpzBtX6tVrNDTcoqbkv3+puMY2l2QbWkSeRYlfVOjbdrJk5qVswSTIVkU8m8cYE6/oVlsLjTu9fQAOfDCaFAEslO2NUYmORDXCBvdwxnxbkH4AFd6JlvqF3c4CyPtJpL+G6NVU3/WXpU75CWkn0uLCrd4RuhPJ7gn09GMT3++BGsVh9c+G/YIbBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBbsFF+g0Bt3IegkoI7tnagKY5Xh/5myYR+SNpsSSLU=;
 b=pVaWA83nBuEcGLpgR5X6gXBx0hjMypvAmfK5u3MitHGJF3WuRsyGTYv6babzWiMbkMBg8Jk1WlbDRpId3gLQzfU5D6bfJL1DSkPkCdoxuucdxlN3pdmkx+OvJhqIKCbTiEpIMJHNJTATjX5peHPHlw3Fgh800jn6r3j5yvHQ/xIXWxt6xRsbNjIk+IpghjAaPYbwsMUGXNiLxpL7WBhdT9fBAEoQK0+HDDiUxVtBlyh/rezEPZ9CSpT19r9Q1WasrU9vuN4ppLFIhYQ+yf6+P7xLE9Dyr1hz8CGiNU7kwm6Qw0xSxBP3iDOI+x4ChiSbcFlFWNc3dMg4vdhJFdpL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rong.moe smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBbsFF+g0Bt3IegkoI7tnagKY5Xh/5myYR+SNpsSSLU=;
 b=aWsvIcs/Tz+KXiAYLqqDogGStogIlJPBI4qnRQ/SkIqu+Tlrw0pEgUgRf2N6NBRXpeCschzwQusyzHbnn5YeHWIzq5LGXCCJM/OwP8umPrZfpT6j+eGjSot8WV38jCW4J5PnYFfDZBHMz+LZCMgVknBF4ZsBpHgb30UAZA3D71Q=
Received: from BN0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:408:ec::15)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 10:42:25 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::5f) by BN0PR04CA0100.outlook.office365.com
 (2603:10b6:408:ec::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 10:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 10:42:24 +0000
Received: from [10.85.45.224] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 05:42:21 -0500
Message-ID: <191cb112-6c11-40b2-ad0f-08a7f41b86da@amd.com>
Date: Fri, 21 Aug 2026 16:12:19 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iommu/amd: Do not request ACS when IOMMU is not
 going to be initialized
Content-Language: en-US
To: Rong Zhang <i@rong.moe>, "Joerg Roedel (AMD)" <joro@8bytes.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, Huang Rui
	<ray.huang@amd.com>
CC: Ankit Soni <Ankit.Soni@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260821-amd-iommu-fix-acs-v2-0-982472452638@rong.moe>
 <20260821-amd-iommu-fix-acs-v2-1-982472452638@rong.moe>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260821-amd-iommu-fix-acs-v2-1-982472452638@rong.moe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c4a3c1-f081-4db5-dbc7-08deff70e34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|6133799003|56012099006|10067099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	4JGv8IpA/qq9kbsWGZVdnu6+vblhZsWUTPAK5fpLSHWX8UgBxuUdbSe4/ae1BveIytAybPRJkNwvT4KXBy+oc9uPUT+DOyIFhGhGfmA21T86izfHt5j6VODs1C5h2AnQkT2330wDTaTUwhp5ek99XE0p8dOBo/kWuEghtZBdOKCmemgRasjiCQ+dEBU+3gku5GOO7ennB5//zqWRyANNe+DuR4FuFUxbidfOiVjilinh8gv4F05cv5aecf3olSKoBa2D6HYC9ePGHA4IR/tcSbiI9vUUOCwi4TDhRvJUGm6Dn4SspxuGJvhWwKxXctU5UBlg5AHy9Ev9qxZiPJzxjvDHb4enltkKq7JgIIII5cX1mrphFtsSj2jhkbPK2knD7nFfD3ckHgv58MngQErRauqCHpUF1Bvo0Oazduz51iMyHUh+4Gh9xbH9u+jbrtzOanF8LzZEz1RvFHs/AYIoR4+ErqdgE0XwXZasGlRaHJ8Iu3xuy9LO+dGhone4LVDW0/X03OI5v1+oq1DFt1Da6vqArQ8RxjEtfWcpgIPC2HkZ5USfq6cpvipZP3lcmTYV6T6fbzPtsD+koawig/r223QX6yWL4djuG5kcwfdHZnB3+fsS7N8O58/Cyb4ds/frCWZpBlpXqHzE13+As6FPF7OOgGgBlNgniw61xZAlEycL50SPs6o87znqQ4SPihe8CVPHqy73cHF4z6jORodvZA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zub3hk0ERSHV42Pwpr77+mYPgh6E8uYkVGX/ZpdMTa+apf8WMFNdDyvFUhn3xPfQ2wh6dxRUby+kZTI/qmGzTUVEOaKvlpsqHgEeqMFwWw+7nRXus3vUkQkf2yxLl9hWhALwPhD1Ep23S7Rz/sQvbSYSTZ2EeI/x3FGOYq6Qi6csffgsNoHnrDH1IeHea8bemzysk3TDY54xnOC5OkfqrZUn0RXH+QMcWtwN1H9S8P0cFfrHHop81oN0Mj0sHGb0+2WPnS4OQeGHHhgFMNijE8iNjqwMKsjCCjnIUbdOI+bjxqTk2xHUxl6Gn24MBs3eXfYEhRqFQV0ZnSPUIhOrEhKuJe4K5TNeuOANjdS9qDFSe7EuUYxoHYipLpFHtTKfpvpSeQKmhjnfxDsapzJFEzJj4vG+Bi01W8U4mnd9Bjt4P15PuQdV5WdLFUzDkQG1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 10:42:24.7525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c4a3c1-f081-4db5-dbc7-08deff70e34a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406

On 8/20/2026 11:55 PM, Rong Zhang wrote:
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
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  drivers/iommu/amd/init.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 40726dfef273..a720796cca3b 100644
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
> +		} else if ((iommu_detected && !gart_iommu_aperture) || !amd_iommu_sme_check()) {

Looks like you can drop the condition
(iommu_detected && !gart_iommu_aperture)

It was added by the commit 6631ee9d00, which set iommu_detected = 1 and
gart_iommu_aperture = 0 in iommu driver. But it is later removed and no
longer present in the lastest iommu code.

Latest code can have following two conditions

1. When CONFIG_GART_IOMMU=y
x86/kernel/aperture_64.c sets both iommu_detected and
gart_iommu_aperture to 1

2. When CONFIG_GART_IOMMU=n
amd_iommu_detect is called only when both iommu_detected and
gart_iommu_aperture are zero.

Thanks
Sairaj.



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

