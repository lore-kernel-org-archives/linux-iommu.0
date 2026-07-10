Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F023B62B
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695876; cv=fail; b=khsrU49EZkZR6wBsW4ugvfwrec7ZjALmsDqUZ4pE4X0SO9hCKxM9oFjaIOFpeXg+vLODbaOyFvLwJ1L4K543iiOOySERcNhFMzbGqoSrrKr4RLHxIqd69KN9MtUKD8NJnHXiq3laJK1quhtJPISXbpsD7/Iw3gc0QT/baOiOdYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695876; c=relaxed/simple;
	bh=B5ZU/xcIEqUutOTMHW/23PDcyqpX/tUdbdmyOwR3dHU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUzyspOJ/zcJ6SWYa9jT+0Q1wdHB7ih4Q1Ek2BRmFPDx0iuA41340X5t7OL3K7LghLqXn/Z0iFXKqSxabnJyyXeMRUvTu7TJ/hPrBoPICrveB+YFCDDmNVrXizFkfS+x7D9bBX2gyXFD5xkjYu2AknP42URBAupX0+57T5mfTp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Waf2NNU+; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Waf2NNU+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1hi7Yi7pW8bqlg+JmBdnQ83J2wlSGCMKwriGoBiQ1T2tiY3wX7w1TVom/ndjaupNbtJK3YaZVfnXA+JyMFfo5bW0pZmVrBBBHk/XBAKKnpO/LqpH7I/hYHFOI/OhMK7pxH7g16jxE+XSkQEkor4waY7bBGGYs8B1xdsFhHaTywV6YrfcxhYIggcqw9bWpvPvNSdu+hhxeKSMW6BxHsd0zHwezNEfKpIithk7fikxIh884Se7xZ3EOLPOuaraYHRy7d04C98HtceJtfPSz+5hJSzx3UoTN8ETFQqvB1mvA81VjNK5++WiZ8D6r8sK1hRweHoRfofjj0UA4x2zdYnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxdPwugCxCUEqCTjP38D08ScvtBH3l9ITKEim/+6+dw=;
 b=HPQkQR9i0MtKe+AZvTC2N5csGD0mdMSI8hkYeQSvxwyMMXEGIyyUFzP52O9Z8Apkv/YztYUvELzooZsQ9Wqmt1TwLEyNX1z1DuOy8JHn3Dz48yBx+Fj/dN5KQk7MG4wPOSlaICgNJ76NaJ2YQkK8W3y9LhuCNcMBNtbjk4EZLShtHil8TaYODNf59rlZEt7zIGn7JtoABs8mmxtvQOkmSJgSOZOiusDVmCEQ2IfLjHq4BY1xhI4ucm8OcPKu9ZtGI/JZgTUhSJ9dy+DjIESPXL5vi7YzWlhTMhZxIu0cw8X5t0WsjTuOWNYC8ALJ8ak+K2J36rTsK8EaaY4mcJhn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxdPwugCxCUEqCTjP38D08ScvtBH3l9ITKEim/+6+dw=;
 b=Waf2NNU+BLnVCzksTYNXoEBhDZzqAmqD0+2lWLQCi/Gvn1Oz5z/+uxb6oJHTq4RMWsF14Sq0Y00UpRf4ZfRu2tuLRLFxKvMJe6hM9WmdwDaEItrdApiG/jQ6POgHZaYLs7B1bP94giUB5zcZIXPK1qS1rEJVGsKb7rpVluFxw58=
Received: from BN0PR04CA0083.namprd04.prod.outlook.com (2603:10b6:408:ea::28)
 by SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 15:04:27 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::ae) by BN0PR04CA0083.outlook.office365.com
 (2603:10b6:408:ea::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Fri,
 10 Jul 2026 15:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 15:04:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 10:04:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 10:03:24 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Fri, 10 Jul 2026 10:03:21 -0500
Date: Fri, 10 Jul 2026 15:03:11 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Tycho Andersen <tycho@kernel.org>
CC: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<joerg.roedel@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] iommu/amd: Fix IRQ unsafe locking in gdom
 allocation
Message-ID: <5xftwnawaah53yk7445pqdhtwtjc754jqjgpkxuo7tdwfqoihk@3nlvntrun52y>
References: <20260709195736.3070536-1-tycho@kernel.org>
 <20260709195736.3070536-2-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709195736.3070536-2-tycho@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SA5PPF916D632A9:EE_
X-MS-Office365-Filtering-Correlation-Id: e5be5713-3c97-40b8-a1fe-08dede948946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GB6rvAo2T36hLm3U3SiVW0bSLx+QkOcMpDrlpZc+5MdErbRiIiuMTmgdVr6bnqJMi8ROriN9J1tyh1fHrj6rXrKgyqDMFR6+8o6a+jQd+oMUHtoRcWqhKKQ6GJ3YGmzbVDd8vTD9lqIs9Z1aUXsZgeX/5npUJRogPeK1DqU7kbTsUyT6HcnQZd61fWOcPq8CjyiUOWluKh7b0uRROrpHY/wGTbyV125b0hZLsOP/kimG3F8/M64xvk5IqfCnbvo7JvXFUW6FiP4Gk5lAr6s8hD61dBZ+OspfV2Iz6+aF8kbqSpoPeK5NHONSts3+5cXgx0oJSQ3DoDMhwHEDo9P6dxu1GpIkx8N29U7ARCHzRGmo36xp4+CN+NJU0gmr1Z74OV4Gb0iBx2Yglc7SNHaTc1OYUCn+WfqHmn+3Gyf0fQzIdjha79D5jaxnPjggSaNcH5kS6HzqlbYwwolJNO8iwYcLhYZWaGjw1SVJhdjEEzch8uMq59g1RVY2HELKC2Il7vXafOJjdfAUBWwyeIy8noutDurn4FJgESq31z0vGvhxsX+CqjhV5G6MElU7tyMnDF0R9Xe6UdNAbProTF04uhO8eg33R1VNyJs07KNqvDxesEbTmZSH9clPFbEKVCdpTsjzK9kdmEq4m7XHeEA36FV/Z9u2QhAi29xa9er9RtPWOPxYmTnSeksFhpSwoV/a/52s8T4IwkDG/N06DVglLA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	guMWY0ei35jIS1FHo2fP2Ngb+pin2T7DC2LeMAYsQOIA1jsDZc1zmdzQWpIUgF+jL1WBT0Bxp2/xflZR3lTrXeupFDSLrgA45cxzLw3LlABqVROwhldv0PHTfzoXh0IwqdNqr4fss9mCQsLPb2abBmTkmF1lkiqmGBnsENMRcVIEFK65F36nFXpeTSi1ooGYirguaTTT0ZhCZuF76Tpjy2kp/ocS7+m3EbhTzU/D1ZTktHabERHxCwUo7kPgYKmNCtmP6VEs/nbYDbWMkABFZR38E+7WRm7ZrEjYNAxJlY6CNtkSCFPrddSnxzD9KyGlgJWCsVwnmv9Vwo1KCBNvWW0wLfJg6JcXAxdSaVuDWf8DC8M86knUX+TdzvszrBP41DrExi9MGe1wVUAXO3mPSZtcXHVhlXwQONLLIk1ndHvdRH/RXJmrEFoc2Q62Mhke
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:04:27.2424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5be5713-3c97-40b8-a1fe-08dede948946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9

On Thu, Jul 09, 2026 at 01:57:35PM -0600, Tycho Andersen wrote:
> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> 
> Lockdep complains:
> 
>   [  259.410489] =====================================================
>   [  259.417287] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>   [  259.424667] 7.0.0-g51db1d8d2113 #54 Not tainted
>   [  259.429718] -----------------------------------------------------
>   [  259.436516] qemu-system-x86/10143 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>   [  259.444670] ff3b2b1c60305170 (&xa->xa_lock#25){+.+.}-{3:3}, at: __domain_flush_pages+0x17c/0x4b0
>   [  259.454485]
>                  and this task is already holding:
>   [  259.460991] ff3b2b1c98504cc0 (&domain->lock){-.-.}-{3:3}, at: amd_iommu_iotlb_sync+0x25/0x60
>   [  259.470408] which would create a new lock dependency:
>   [  259.476041]  (&domain->lock){-.-.}-{3:3} -> (&xa->xa_lock#25){+.+.}-{3:3}
>   [  259.483615]
>                  but this new dependency connects a HARDIRQ-irq-safe lock:
>   [  259.492447]  (&domain->lock){-.-.}-{3:3}
>   [  259.492449]
>                  ... which became HARDIRQ-irq-safe at:
>   [  259.503705]   lock_acquire+0xb6/0x2e0
>   [  259.507790]   _raw_spin_lock_irqsave+0x3e/0x60
>   [  259.512748]   amd_iommu_flush_iotlb_all+0x20/0x50
>   [  259.517996]   iommu_dma_free_iova.isra.0+0x1b8/0x1e0
>   [  259.523534]   __iommu_dma_unmap+0xc2/0x140
>   [  259.528100]   iommu_dma_unmap_phys+0x55/0xc0
>   [  259.532863]   dma_unmap_phys+0x274/0x2e0
>   [  259.537238]   dma_unmap_page_attrs+0x17/0x30
>   [  259.542000]   nvme_unmap_data+0x13e/0x280
>   [  259.546473]   nvme_pci_complete_batch+0x45/0x70
>   [  259.551524]   nvme_irq+0x83/0x90
>   [  259.555123]   __handle_irq_event_percpu+0x92/0x360
>   [  259.560466]   handle_irq_event+0x39/0x80
>   [  259.564841]   handle_edge_irq+0xb2/0x1a0
>   [  259.569214]   __common_interrupt+0x4e/0x130
>   [  259.573882]   common_interrupt+0x88/0xa0
>   [  259.578256]   asm_common_interrupt+0x27/0x40
>   [  259.583019]   cpuidle_enter_state+0x119/0x5d0
>   [  259.587877]   cpuidle_enter+0x2e/0x50
>   [  259.591962]   do_idle+0x153/0x2c0
>   [  259.595657]   cpu_startup_entry+0x29/0x30
>   [  259.600128]   start_secondary+0x118/0x150
>   [  259.604601]   common_startup_64+0x13e/0x141
>   [  259.609266]
>                  to a HARDIRQ-irq-unsafe lock:
>   [  259.615384]  (&xa->xa_lock#25){+.+.}-{3:3}
>   [  259.615386]
>                  ... which became HARDIRQ-irq-unsafe at:
>   [  259.627039] ...
>   [  259.627039]   lock_acquire+0xb6/0x2e0
>   [  259.633071]   _raw_spin_lock+0x2f/0x50
>   [  259.637250]   amd_iommu_alloc_domain_nested+0x140/0x3c0
>   [  259.643078]   iommufd_hwpt_alloc+0x272/0x800 [iommufd]
>   [  259.648813]   iommufd_fops_ioctl+0x14e/0x200 [iommufd]
>   [  259.654547]   __x64_sys_ioctl+0x9d/0xf0
>   ...
> 
> Since amd_iommu_domain_flush_pages() necessarily holds domain->lock to do the
> flush, switch the allocation side in gdom_info_load_or_alloc_locked() to
> HARDIRQ-safe allocation. The IOMMU_DESTROY->free path has the same issue,
> so switch that path to HARDIRQ-safe locking as well.
> 
> Fixes: 757d2b1fdf5b ("iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain invalidation")
> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>

LGTM.

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

