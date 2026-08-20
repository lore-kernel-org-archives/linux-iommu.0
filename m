Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4A3E5A0A
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216888; cv=fail; b=VhhImm0WRx63ARfHuxVKN/6T9ZXwHQL2ZZB9cTPKlbHw0yZVPNiWaovYdky2bE5/t1VvQgelivS0VluDeygkSvfJfkhQy3VBYhQQXT+i88S11Pn3YG06vLQw6RV6BXbZCHGGXIb4SWRUkZVybIIUzcV7u8YzeKsI/619DroANNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216888; c=relaxed/simple;
	bh=dn5KdqUEu//ZSVtg9sydjHjQiXaNVV6Kvg0KN8Qodvs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k19Go9AMYWCBMUB8jNIPUV4La+k5IL8LEDz71QEpWJc+BdYMgruSqpsy1604C9DyiOw1sjeL+UBFpxkjZ16ZXs8iLUnK/Oin5wFRueMhCmfscE/7FQWqZQTMYGtMYkRTGNyfcVbeDh1JKp0EOpDwfLn3tM+hDEQp027dHF+2s24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L5USe+Fw; arc=fail smtp.client-ip=40.107.200.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L5USe+Fw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLPy6ldOpUFK5wJ4OXyspxt+gledlxbVunX2p7rgB81ytM/D/nsIG/uLdv9GMvQ01R+zx4fPFbXYxlCnyM4QMcRpEP+UR/dqnzzsx7npclLpJi6hf1UlOz/NzMCmY1BEjK0HojvwgFchrFa3S8DKC2PIRqefsidp6Xr/0b6LZfv8l3fR2deYD7SCVJyZulsRdv5fCe4Vbe3HqN7pMSGKk4GukZzLDkvIwbyCQPQnsBJeP2UnqHJknI5uTfUeOHjdvlValnDmghXRE4ghcbHJbLoigWr+de6Hsw3ZO+GHAisqFQ8jxBAJNCv8w1Pihkq/BqOMKIVkQk/wowlqfLpTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sueu9n+Icwo70R2KLTRoPI74+dBZ8NrynIVeVfs8U7I=;
 b=NmYQdpdkOdcjV7T0vtnkx03YHOIaQdj/ZZfISFwiasBbG7ducZ9Y7j1daVUQwuVEiFkVzUNLELyDsmZOECGTf6Z01ZayFHzo2twASY3RY3MCEPlXOW/NzR2E9+qhqJvzgwm55JvrZdWvHdAxNq+XHHsNWITC/kY0bmSrYjMjBLY9ZkK7iKJoYOjCjxaiu2s5ECOxlQ2+o0qKKRN6mwPFEv8znAcy6oLmSNvQ7kN1psTmESPdCC6kWsMlILXn33zLe227Jf5LvCxfVA3XbIt065u8cCXd0ZkLtD4V628gBzWUaE8H7hw1VPKDNqFncZ3z80F/4Omhf+mpPoDA8rR2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sueu9n+Icwo70R2KLTRoPI74+dBZ8NrynIVeVfs8U7I=;
 b=L5USe+FwfWBiGyVsYnUBjlO5Lya4KippoiyP//joRGk8pRYkP0RgCXQiKQSaVeBtNmQ6bIPu9wagvkpRD34i3t8OJYbHadjMouewI49iL52y6VuV7ySRmN+YMRyXqU9Rbyqv0GaYv0A268jtyDyapJqYzKvLtda4JqttIUKCMJ0=
Received: from PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::15)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 09:07:59 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:510:348:cafe::22) by PH8P220CA0030.outlook.office365.com
 (2603:10b6:510:348::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Thu, 20
 Aug 2026 09:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Thu, 20 Aug 2026 09:07:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:07:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:07:58 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 04:07:55 -0500
Date: Thu, 20 Aug 2026 09:07:53 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
CC: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Do not reallocate GA log buffers on resume
Message-ID: <k5brbvuoqzz6k2lhyw54lusicjws5q3q7lxqs3bbalax5qz7fw@z6vxf6ftl5zi>
References: <20260819032349.20354-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260819032349.20354-1-kmehltretter@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fa802d-49ec-4533-6d25-08defe9a87aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|11063799006|5023799004|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JSgobjOSK7jlkjB63jYneH1Hr+zpafAc1dMLXB5DP1oRkemNW00gfnv6mk+wExzDaZh8zd66zq7nHTIAbWOYsWW1sZjoF4DP+rrUB/TmUJ5X6uxrFZot2D6GjPR5/4ER6SN1w6FTLdt0jKpfUb/KceX/Cu1KBBxpquxWd5LOL0lgzLbMV/BEFE29NgW4c6T9qcG5TqQ/VZ3/BH/yLWtv9K2fuw38gxQxa2lBdJs9YZ46JCZR1FVvJVcPRwYjKxtPUb6NbULHQkxOLpupWyA2n5WjTRXOsKrUokYSb3MQVyB48lBLSwF7tQbCgD6RjyjqYPnbx6LbS4XoT+AQaEDSy4VYgj/FKazCRFtrWiQPT0oITOxT4hEk+m3PM1g63KwSGKd1/3nqASaDew42w2t3SzDNijgxy4dKC1llP+lruQ1JiLbpGB9mHcXEhPA3IWYm9rVtCEjdbVKYTPTmPJFTHrplmhW+kc6DrYIOSufOVGkPcKc/e1Hh8ydsQBhxJwmN/ukgmPuvaybYfPIAu6XmMyl6BK9n+JO4ZQV5wG83Q/p1OSBWGQOw6uBWKYe4jNB2chIMRubMUDKvSD+dw68GjfCxgBNDMaEA0iKSHUClFNYVDAggCEld2tnYAiqbUmgn+7xlLnmU+2XQHdTrNAOrIqKR4jgw3VHJvj6xRBDrn9hlPUoyaL/AId/HyrjhY4CgXnLnOIWDH0EqMui4nP48oQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(11063799006)(5023799004)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Nm+ztY/zGpW/IcWbeJhINAjEai4X7IKHZpJ1C7wO2do8c5YcE/xxFa+V5mT0SJlgMxFCOQUBbCYLuLOJLgCrFQNKatvIOosbFIcI64ewk1rVIN0MyiV8Jd6lC40pzPN3UN6uWzzoy9e5n1RzkLxyWjH4aLE+4+GGTAtG8oTqXZe5XykX6FNKOUSpOPhBiNNov/pE6LK3lyykuuyKcHq2N+WSXBDwNAHTza2bpBIqi83/cbHCuCTfQGdnWFNeLtkOKYImRyo2SDvFTeWhBieRlyWHPBaUjs3/XOZcp9p7hQp1IcCm5VGWeVKpLfX0CKpwk610VWF2kMtvMfMHCFIBsxWU+FSdb0qrUcmNQu0CfkiiuB7Ni5CC51e1XbVcGU+S4yuZkhzabqbXi4zuZIRzuflmU38ymOZB3sju6q7xP7ba4M5BO294lhCDZKhe+GQ/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:07:58.6999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fa802d-49ec-4533-6d25-08defe9a87aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230

On Wed, Aug 19, 2026 at 05:23:49AM +0200, Karl Mehltretter wrote:
> Commit c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC
> (AVIC) Enablement") moved the GA log allocation from iommu_init_pci()
> to enable_iommus_vapic(), which is called on every resume.
> 
> iommu_init_ga_log() assigns iommu->ga_log and iommu->ga_log_tail
> unconditionally. Each resume therefore replaces the boot-time pointers
> and leaks both old allocations. The function also uses GFP_KERNEL from a
> syscore resume callback, where interrupts are disabled and the non-boot
> CPUs are offline.
> 
> Return early if both buffers are already allocated. Clear the pointers
> in free_ga_log() so a partial allocation failure cannot leave ga_log
> dangling.
> 
> Fixes: c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC (AVIC) Enablement")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

Thanks,
Ankit

> ---
> Tested with custom QEMU with GA log emulation. Stock QEMU does not
> advertise GAMSup and cannot reach this path. After five pm_test=core
> cycles, nr_iommu_pages increased from 17 to 25 without the patch.
> 
> Testing on AVIC-capable hardware would be welcome.
> 
>  drivers/iommu/amd/init.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 40726dfef2733..c6b106d5921e 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -909,7 +909,9 @@ static void free_ga_log(struct amd_iommu *iommu)
>  {
>  #ifdef CONFIG_IRQ_REMAP
>  	iommu_free_pages(iommu->ga_log);
> +	iommu->ga_log = NULL;
>  	iommu_free_pages(iommu->ga_log_tail);
> +	iommu->ga_log_tail = NULL;
>  #endif
>  }
>  
> @@ -956,6 +958,9 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
>  	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
>  		return -EINVAL;
>  
> +	if (iommu->ga_log && iommu->ga_log_tail)
> +		return 0;
> +
>  	iommu->ga_log = iommu_alloc_pages_node_sz(nid, GFP_KERNEL, GA_LOG_SIZE);
>  	if (!iommu->ga_log)
>  		goto err_out;
> 
> base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
> -- 
> 2.53.0
> 
