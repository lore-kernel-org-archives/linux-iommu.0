Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9E3AC0EB
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471580; cv=fail; b=dtguRO8hw+xLNiu0b3FAVk1YYG6wnC4RcMmfINHOsecNI9g9WytFEY5fi3XhPNXgjwoIdenegROUBluvuhKhKzSVC+f70J2im5cpGGwqXeQN5gBN3nPGttMkDIoa5bkOr9TplD6ueOJoVk5RBM/8NqqjVPzYY8Z6wqBzQaC4GCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471580; c=relaxed/simple;
	bh=f23+XIECQCbvEVigSjY2Rb4GZy56Tc4Cqr+643bjT6I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CcDUeUgwZptiyKaVB94rs4PfysTsAXvVpBz/PmSmzM/84CZFxYio1zN9Wj798X8oMwI8xxrO/meka8E2o/EfvgP2JEfhmWAyeLPspLey2n7hct7pCQyuijEugMHPye3C0QqapoWz+rUOwkfKM2MnV+wfRaDAY+gpEHl6Qv9r+V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pu/XdOdT; arc=fail smtp.client-ip=52.101.56.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pu/XdOdT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIqcz0Tu3oQJBatyC9dqmIPfRP8IZjmfkZxE5lGhXBy8NbCVNxkQI7WO0UdLLvkDHhzaBp41CKB23RndR+V0SF3mhfmuWb4YCKR+a3T/5QRXAbpSxCcPn5FaXdFp1ufCttqfVU/DCI9KvJImN6LmWhOv1VDrmEXo6kFbtfcF4ITJLFRN0EciHZITWS1kKZTecVV5GbVyzAmzFxdWxVkXQQ8ABMMOZinJWyly6nr9TzuMFRAXpml02cpOynpu1MLFzXgVkfwyTW+OfuTKCs2xYhk8Av+4OU4VoPnKa35l9YDVIuBTxG9/5vuXdyvKHIm9BvOwnNFGakyb8F0QDGJIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbtGUWaeufLmtZUBwgc/GxMx7LZpPbxXn/hnUfDUMvY=;
 b=UUoLpF7loJxHTTX+DGWMoDNo6BYUlVwwH8HieoBOp6bI0VY+DmaDZdJf5ngUP9KDJooAilLHl6lI6Kky3hdNnMPvoevzQnbnOW0GplN5bZNB0Fptr7ilkgvUlsILM2+ng8SjK3J1oaU/Za8vfgrMw1OFDB3NyRjIM/8GSgRPuD/OdAz6PEARsdf/VG5Rv7ZWNIw2KKYb+hW8g+Cij9THpe/eI8Wp9SXzu1U9IectltSGchnTVkt/ZfOqXuYZuLvH38T+EujKlscJXTzmTRXeI6CecoaMvbAnHaVvON37kMpEvHxCd9Ptn//M4zoq4PJeJcvf0cu6KWTBJLhEQDG0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbtGUWaeufLmtZUBwgc/GxMx7LZpPbxXn/hnUfDUMvY=;
 b=pu/XdOdT2c72pcmmTEbfhe814/KhEmxScQ8y0v3xsQ6gd+mkU9OMgEWklE5kD43N6b58GYcdH6lZgawa3gWZWPLsE0x/K2j45Vu7bs4IFFMJXVpNmM/4uoGZMY487S4EZ9cr0v3MO9FNNmAB0tylTqjqKD5ONS6pfUtApChHRAk=
Received: from CY8PR11CA0044.namprd11.prod.outlook.com (2603:10b6:930:4a::9)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 10:59:34 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:930:4a:cafe::42) by CY8PR11CA0044.outlook.office365.com
 (2603:10b6:930:4a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Fri,
 26 Jun 2026 10:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 10:59:34 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 05:59:29 -0500
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
Subject: [RFC PATCH 0/5] Add support for AMD IOMMU GAPPI
Date: Fri, 26 Jun 2026 16:29:01 +0530
Message-ID: <20260626105906.14577-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fdf201-c368-4120-772e-08ded37201b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|7416014|1800799024|36860700016|13003099007|921020|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	usc57Ck9yebvydI8b7/MWLmj80MZNRa3b+415R8f4MLXxQ/jOpryE0WxTpw91pyO5bIEh7ZYLG9UiG4TjomlFmbQ+v6lbr+UFk1osnaXSvJ45KVs1P/yE+kvTEQb9UhPr065gI2eyn9EUSHN6N2Q3s9XttWQhfN4fJhqmX2wclJC4t6De4UTuaa0ttJWysR/YqWRsdigq2i7I+aq9WeDBYyHHg0poKOQ1MNXnn6fMHSLffKt2J5x59XODZ2v9xAdiTSFeOf1JX+vqy1hM+LmQGjuKH7XKbRHaNrj758a9Nxr5kbCWr+gWWFeGXSYypzYnTjB8vvRMRYSKlB4dOOa75avQD8nDjJmLD20/KevczhrGyuG4UbVWmpRjnLTsOt9AcaVCZgd4Ru6y9i0qiI+aL54osTdSCkbZbuQhdgrS+e1fOUronPni1LDVhUSAF7BG0mMBD3regDNsdp51Mu2nyyCgrc9dmOGIHtLLAR5nqM8Z2DI/BB+RAsQ4wGj6SESs//CS/g9TrGZ/u5XBVpHDJjScnqI5y3p8ulAeOuVt2e5E2oYV8kXER0qkze7O4r3a3Ck+6Wg7YKRppb00xgmDa9PfGKo8Skn7Vlv+LqBcroQu3CDXA89nDIwIX0+mL4X/ECUc/K7dsYXHPqmx3gmWMHUI81zOXeqUjtWoCMpNLqaZYpaA02s/Al/9tv58PQ7HizxnOAeNGvCpDWqUbuj2yvrcYL1wKfrIOmBkOMXhfItcnSJEi3GIo4Rza7NeG3L
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(7416014)(1800799024)(36860700016)(13003099007)(921020)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/cY6QOWwkY7/0xXVvnyJcvWTzcgm7juYzXrHROXzaMbKVULZJrIOHytsOxSbKrqM+6Z1DZ4m6GmkjQFe0nXFyaPGrHIq1K2EwoewQZNlIqG1yK6OIygyxfJ8dnKeHMM40fG/PByX4i8r6uFiFb9o+o/XlkLOo5bpUzIM7mjkJtZ1Q8Hvm6svwGpka0B1AEhSmD0uvQJEBe+tRFqGVt7ZMaMeBFeoFmhjWPAtf+6CcvKeyT7ITTNBZLvwMB53Ek/9UaYQb/iKbEhCK/BsYM5GIAX4KR6gg2f5n7dyVSN7yZctcPsSraVTV8l085jQ1D4QNxoQt7YkCbsD8TMEc8WBK1UatgiG21rT4yDCgsa71ERQP1K+KngzWIW3AILGFEHklyOudW9LD7/pUzvLygGv8Z2Nznn7eav6cz5Gn4izTh/kUL1y3REOynEyjR7v+bWw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:59:34.1172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fdf201-c368-4120-772e-08ded37201b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825

Introduction
============
On newer generation of AMD processor, the IOMMU AVIC/x2AVIC feature can be
enabled with the new Guest APIC Physical Processor Interrupt (GAPPI) mode,
which is an alternative mode for handling AVIC guest interrupts to
non-running vcpus (i.e. IRTE[IsRun]=0).

With GAPPI enabled, the IOMMU delivers the posted interrupt to the physical
CPU described by the IRTE destination fields, with the wake up vector in
ga_tag.

Please see more detail about GAPPI in section 2.2.5.4 Guest APIC Physical
Processor Interrupt of the AMD I/O Virtualization Technology (IOMMU)
Specification [1]. 


Implementation Details
======================
GAPPI reuses the posted-interrupt wakeup path introduced for Intel VMX: the
IOMMU sets ga_tag to POSTED_INTR_WAKEUP_VECTOR and SVM registers the handler
with kvm_set_posted_intr_wakeup_handler().

SVM maintains a per-CPU list of vCPUs that are scheduled out.
When a CPU receives a GAPPI interrupt from the IOMMU, the handler
walks that list, finds vCPUs with a pending IRR bit, and wakes them.

The IRTE destination is chosen as the last host CPU where the vCPU ran, to
reduce unnecessary VMEXITs from GAPPI deliveries.

The first patch refactors the SVM/IOMMU interface: apicid (formerly cpu)
denotes the running vCPU's host APIC ID or, when scheduled out, the APIC ID
of the pCPU hosting the vCPU on its GAPPI wakeup list. Explicit running and
posted-interrupt flags replace the old ga_log_intr boolean, since apicid no
longer implies vCPU state on its own.


Advantages
==========
With GALOG, IOMMU can only generate a single interrupt using the MMIO offset
0x180h (XT IOMMU GA Log Interrupt Control Register) and appends the vCPU
information to the GALOG buffer. hypervisor has to scan this list in order to
wakeup the vCPUs which can introduce significant latency and even cause buffer
overflow under high interrupt rate.

GAPPI resolves this problem by distributing the posted interrupt across
multiple CPUs. 

[1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

Sairaj Kodilkar (5):
  iommu/amd: kvm/svm: Improve API between SVM and AMD IOMMU
  iommu/amd: Configure IRTE to use the GAPPI for posted interrupts
  kvm/svm: Introduce per-CPU lock and wakeup queue
  kvm/svm: Update the per-CPU wakeup-list during vCPU load and unload
  iommu/amd: Provide kernel command line option to enable GAPPI

 arch/x86/include/asm/irq_remapping.h |   4 +-
 arch/x86/kvm/svm/avic.c              | 136 +++++++++++++++++++++++----
 arch/x86/kvm/svm/svm.c               |   2 +
 arch/x86/kvm/svm/svm.h               |   5 +
 drivers/iommu/amd/amd_iommu.h        |   1 +
 drivers/iommu/amd/amd_iommu_types.h  |   6 +-
 drivers/iommu/amd/init.c             |  23 ++++-
 drivers/iommu/amd/iommu.c            |  41 +++++---
 include/linux/amd-iommu.h            |  15 ++-
 9 files changed, 192 insertions(+), 41 deletions(-)


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.34.1

