Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B9E408017
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502087; cv=fail; b=i6a0F6KJUdAdq6vaLHT3lKiEQyKdRkF9tf5tQl2ZI3GWJzL4dcD0Mfdl9X+eYFNJU7hYAiNHUKOLt82DrabcQBFERJsg0Ly26oYJLGKXwSW9o7lCHjOW28Ssd5Li8NLI+VZvEgDzHZGw0yb5+H/1eF7pFgh9RPBg/BfM5cdFOo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502087; c=relaxed/simple;
	bh=S6tT3HshJACd4IcsMldnrvYjfAL4dWrIXUTfi98w/R0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gfNOvIrPYeCbZ2q3SMpmp9ZsFniPs2U9jeNHqmq2cSBmhLt9i7FUpIdOFa8P/bW8x0qCZbE8dpXvtOH3OgM6dhsiEfI9x79FtFtjMpVq8miNwLG6h7WSVtZ9r9x/+HMYVS1dPZ2qZ7m8+8LUPX9ujQeuUOGn9y2yeOnSTGlH1Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dp68W/sw; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dp68W/sw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+vZuKZVLV1oVndUPGqvgi5GwiuWkeIja1s53Cn+jeNA33JkfN7DIMrLEIr5MXzUUkeyZqUNyzztIwFlj5eGpj0J15NK5Lq9RdgPnrwQ0ZLkSHrQi7egODIRLfQTbTI1H1Zn9++hFjhSsCDmNWd9hy8cfCS6VWl2Z+Kdl9D674vacA1Ggf15VT5ImOMpzoJIU8kWC5FHaNiN/+4oX+3Cpt5BjdD53+dkYYgTVoKJH03U0IB1LfYXW1CypQqH+uISvzMGVmWFLK/11YbUF+gx+cLrsBsjZdUYg+k5bPN/3g4kmFbdHfO+la46T049/dBUA4A1osbCAgpy6xUJJUhQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn5G5qCcnz6ow9Cdk9A87H7Zyb746Db3KyaLJ+wWTIk=;
 b=y07PRuOC9JWNaXZb+QzlcmWUVQjGxlJez1QbrbZCXQc3B+Vlc6y2FqcdekrymU9c1G8TVecBtpVHtyRauXVH2+ekBYQpnL50MyRs80urs4e/G68ZuKcZsKPcsirEQMU+x/2DUO8yeXK0DwPqKKAggFG2d6jBpJfge5EOi62MD9oMQQV/w9J3Skd42TFW6PF5T7ax0yyfDRp9yw8VwqdJB3KrbyywqA9bYBsmrg+S1duNxoG8cnbcMpbzqNXrEFoMVkJSTJxxDP6OoEHr7/xp7jSkpc4d6tQV1bcBV6ucvh17PrxMJGQQsFhUiFP/SJuMnGjraww/SuYEEO0NwscelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn5G5qCcnz6ow9Cdk9A87H7Zyb746Db3KyaLJ+wWTIk=;
 b=Dp68W/swjhNVtIeY8TRnLLJZukllhanMfYZdaPxkyyU9aWlQtUe2Xvf9LtZwURC9T7ps0N3qEHjzjLOqarTqKqnvtKe34CODN9bKj840zR1DTlust1ng42tAfGmWiy/M+LmMZDQhwTue9Lch6UY3+uu3KKOS/tKgCjqp0yonZGE=
Received: from SJ0PR03CA0153.namprd03.prod.outlook.com (2603:10b6:a03:338::8)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 09:14:39 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::28) by SJ0PR03CA0153.outlook.office365.com
 (2603:10b6:a03:338::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 09:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 09:14:39 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 04:14:33 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [RFC PATCH v2 0/5] Add support for AMD IOMMU GAPPI
Date: Wed, 8 Jul 2026 14:44:03 +0530
Message-ID: <20260708091408.12106-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da62447-fe11-4026-4bd2-08dedcd15696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|7416014|56012099006|11063799006|921020|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	7ZRldYcltgcCx5j6Kd79ZetgC/nPuauU/hpgT2gq46cJekevRY0GwaX2U+dZAcABSznNDRJ1XaDloYOqyxOLwOtnOOXPRfwBRiJvv8FXb3/Y1w6ikqCc7EuWYAdqDhQ3Y640Z1uZrVMJU+x7zmefom/IaTpd5xNVZo68BO5fWn+PEcISPBUOcNad5eDpUzXwkeGmQZKr5myEoD98xckeuwcDs7q5pJyrDKSy5gL65jEZ222B/qYHJNRH4Q0adTg6ITquZ4SF1UFEhDxwpnnYJ3JB9pvz7jIW78P47amyhb1nOQkZGdOkFqas8MZoJiGj0ETefq4s1lOJbmzoUPrmXjK2PinVtDkHcces447QcQqtL8A7jYdYCC3MCQFvXNSqwmQYmxreAQMMPYcnfW4amtX8f/HrZxfCIyrG777s2Wy5U62oEkmsuUST952tDZsymQ2kW/gbkh6SRorKHGlpFGrvEn7TclKgo0p2KURDTNGsnG+MS7FzCwweB91sjXUkEjCsSAa1ghjTkI4cGEILrM1nNy4yxoHsTxMSHf28SMvTSYS41lkMZediGgcJ4jW7PZlGwIFJ0ymUhzn9cgXqG9LbRTDqJHvkSiML7N+gT3vKjmtYNgqlX7Wy3PNiSgGeJxvpWJ2gJ7LHIxNUg8XYcojhWCoQbW3Ws4CHYqnUsiDSX9M7upBDqCsScBy+EkJGP6od+OTfZF+jSifLBe93KhtPRUWL+PLOOl/LMJxc84fsHaSyyeIcWVMfGxA9rwwZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(11063799006)(921020)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pbXurgLkl0rEGLBAIRTCmFeSb8L9iNaH/3dqCIiNjaRVYswteTTD2uBTtz8R6ViaIc30ALflEqmHXkm5Wegj+NKnfjlHrGzh+vNPkDqDHrUFpuRbEs1zwbA+i6G56HWA/Ax/mW/zIB0cLsC1SPe6GIAkbexy2crnZZyRC6mhpwtqBydc9sJWoD9PmtTg7+ijohN4rpbUd5+FgFT4esT918XzMgBA2je4G1ddYDzcQSIp1XMtCg9n/hLC5SaMbTAvrJyj/hmG1iLwp0y4So+FnIXSt83KWTjTLhizvkj4Gw6gQA0u5DALmFoaU0bRQf9O9ii3/U1/nr3o+2s82Eoh8I15UvSjBwk+Bwm+mabnWUZaQF54UlcPxVPDcV4SCKMd/40rYIfkI2sF0yR/E/UlrdWV0UXgI3VV4myohIbpZdzdQ33VKelRNvqosbmWiGqj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:14:39.0828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da62447-fe11-4026-4bd2-08dedcd15696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

Introduction
============
On newer generations of AMD processors, the IOMMU AVIC/x2AVIC feature can be
enabled using the Guest APIC Physical Processor Interrupt (GAPPI) mode, which is
an alternative for handling AVIC guest interrupts to non-running vCPUs
(i.e., IRTE[IsRun]=0).

With GAPPI enabled, the IOMMU delivers a posted interrupt to the physical CPU
described by the IRTE destination fields, with the wake-up vector in ga_tag.

See section 2.2.5.4, Guest APIC Physical Processor Interrupt, of the AMD I/O
Virtualization Technology (IOMMU) Specification [1] for more details on GAPPI.

Implementation Details
======================
GAPPI reuses the posted-interrupt wake-up path introduced for Intel VMX: the
IOMMU sets ga_tag to POSTED_INTR_WAKEUP_VECTOR, and SVM registers the handler
with kvm_set_posted_intr_wakeup_handler().

SVM maintains a per-CPU list of vCPUs that are scheduled out. When a CPU
receives a GAPPI interrupt from the IOMMU, the handler walks that list, finds
vCPUs with a pending IRR bit, and wakes them.

The IRTE destination is chosen as the last host CPU where the vCPU ran, to
reduce unnecessary VMEXITs from GAPPI deliveries.

The first patch refactors the SVM/IOMMU interface: apicid (formerly cpu)
denotes the running vCPU's host APIC ID or, when the vCPU is scheduled out,
the APIC ID of the pCPU that hosts it on its GAPPI wake-up list. Explicit
running and posted-interrupt flags replace the old ga_log_intr boolean, since
apicid no longer implies vCPU state on its own.

Advantages
==========
With GALOG, the IOMMU can generate only a single interrupt via MMIO offset
0x180h (XT IOMMU GA Log Interrupt Control Register) and appends vCPU
information to the GALOG buffer. The hypervisor must scan this list to wake
the vCPUs, which can introduce significant latency and even cause buffer
overflows at high interrupt rates.

GAPPI avoids this problem by distributing posted interrupts across multiple
CPUs.

[1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

-------

Changes since V1:
https://lore.kernel.org/all/20260626105906.14577-1-sarunkod@amd.com/

Patch4
    - Disable interrupts while holding wakeup list lock inside [sashiko]
      avic_add_vcpu_to_gappi_wakeup_list and avic_remove_vcpu_from_gappi_wakeup_list
    - Unregister posted_intr_wakeup_handler during module unload [sashiko]

Patch 5
    - Disable GAPPI feature during kexec and suspend path [sashiko]

-------

Sairaj Kodilkar (5):
  iommu/amd: kvm/svm: Improve API between SVM and AMD IOMMU
  iommu/amd: Configure IRTE to use the GAPPI for posted interrupts
  kvm/svm: Introduce per-CPU lock and wakeup queue
  kvm/svm: Update the per-CPU wakeup-list during vCPU load and unload
  iommu/amd: Provide kernel command line option to enable GAPPI
