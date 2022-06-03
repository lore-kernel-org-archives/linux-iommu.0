Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F47DC433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Jun 2022 11:21:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BEEA41608;
	Fri,  3 Jun 2022 11:21:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yVbkef3vT1hc; Fri,  3 Jun 2022 11:21:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CEC07415F1;
	Fri,  3 Jun 2022 11:21:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A92A9C0039;
	Fri,  3 Jun 2022 11:21:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A48BBC002D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CD50415F1
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:21:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QXnWQgQRPy8B for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 11:21:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::613])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1B71415E2
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/4MdY8DkI6JM9i1XVyibo7DpuvkdSeCWN9n+7KQ/1yOcU8RbactRZm41lu9oN2FN/8UfK5RpQTsddLqgvvAC/Zd5qt6IUAqGBEJ4xB8qSP0QHB/jJ+jM8gSdDG7l5PtExsZ7eMpOHp81kgOkGQ8F1qyvlIEgh5rOA0OFn97Ng/BSe1NKRkBaXtHX+fGth87w3iWqQ/2Ib6VbKCa8Q88OHYAtbTRguiRXjwQ+BhASnx/FbyVDnbL3GcB6WBqsj78uvGDCGQUUBgq7oeiEsgL3P2yEGNILfztkVNrn2UYQFs2JWKUFdYUZyODiOSAX3qxZnJ++JvsR+9wsExyRnwv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHjqZTCKIgXGhcMpsgV6LaGqXDxANumAi1f1TYPDk8k=;
 b=aB7wYvy23DopeR7ydbC6qChhZ1zBjlQ+q0b303UU9aBD/awLcFFzcyGoRVirrEHQVFhxzzclQ2O7XrkoOxmAT8h0cr7QylFWIAWZn1MYOJHevEoZWnNO9lH+wlp1ryuO4db52mpQiLoZDgeCxtCv8QVqogyzjitY9GHkJ8jmEeHTs4awxv/ESyjK2AGlHrutetyNvrr4fLpAmmAwO2x4ONrg3GvZsV9IEQi/u85ujMTIn/ZkNjNC20JouwQkJn51A92BQBL1IQH21C2y3k/rYmcd7QUm1zH2TgDB6bIWjprKvlU/o9gqPJcolpmubVVupCOaTRU2/3f2vz4WcDSTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHjqZTCKIgXGhcMpsgV6LaGqXDxANumAi1f1TYPDk8k=;
 b=ar9WB7k4KyXgZ/OFo7x6DI8GmHRBL/Fa6uj5KuolzEqkQKlq+YMPFkBbyY488EU0y0cMdwjT0PvFIrt+lKE3BamFtk+SuWrV4GC0++kNp4OnqHF6/B8YPqNQsA6MQL9te0qiezAuziSZUUZUOyxo+camxn5LlkBPHgcK9kglq1o=
Received: from DM5PR20CA0027.namprd20.prod.outlook.com (2603:10b6:3:13d::13)
 by BYAPR12MB3094.namprd12.prod.outlook.com (2603:10b6:a03:db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 11:21:33 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::61) by DM5PR20CA0027.outlook.office365.com
 (2603:10b6:3:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 11:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 11:21:31 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 06:21:28 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v1 0/7] iommu/amd: Add Generic IO Page Table Framework Support
 for v2 Page Table
Date: Fri, 3 Jun 2022 16:51:00 +0530
Message-ID: <20220603112107.8603-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9042ae07-cf72-42f5-5d90-08da455335d9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3094:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30946FB5E0B0C38A5497442E87A19@BYAPR12MB3094.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yonVYCxwZkbJuL+CVkeIxLJ1WSlK3SgT3GbAgmRh6WnqIRSCm2tkIibfcv5aSoQ28VWor8tIaSc2vWTxUJzJgnxF8xvsPfLBCQ4tJFApeA+tKx3yGseL/e12PBLB5H88a7VxWH10sIXB5LVwzULHYOd4Jq0Ri8Pw4ga40lNB4oKIguNdsxj3apo49V6pzLkDae6lIOSMGxxn3qXVlIp1TYLDdMKVqo4sDSTUHo8id/lAzmkDXtgmhOynj9OzQ6BNXPFMBoc4Z8EdGW4GDVWmqIu8JHUdKh+9X1LV35EcslHczX92Y54BQMskTsCu0R04Mo6Uj2LJprMxK7si7tSYWoAzvAjXK0bSarnAgBqVylVlVN+qfPpVYn/e/Hl7QJGCmXn4+ZuMllcs46CfpOcksAGIAxgbWyPRiSjlZ8efjot4p4uepBZcfCoAZjppv5wXUOc85NR29pbTzw/5NFMcITOkhcj77Fx92W4dK8oyAAqvMZ3OQc3wALzoD2I9sauaEugPj9i+tdiHJ9IvFkfCFhQWq0ib1ExKygTJbUBXrWH+l93Q7stACzwrLvTpIiIDnK+D0brbCBA+S+2omrE37AZXXR2kBX+/UbTzaZ/S+VWBj2/ESQCGRyosUrUVdFGHa2nOUjHKa2bVlwYO6G2ipeyOhO1+y5Et8o5PlGDZBsIsicPuCuLdgweAWHHFjXM5d8oc5Q4Mqp38YKhxocA/XVk8C3bPgafs9RqK1CtWu70znr95xlsl81bKm94VmtNOnT/7hRfOl7WYHv1jPew1Qk7C09qpy1VgnhZDVF7RY0b1IsaIR0EsddxWeWvsRXdfg7JvTjL3nqTxVW6Hr1wp5iV4gtrL7PYepOsvdKDyXzhxJv0jbSK4gGaFvA8FB1bgck6Nsj3AMpW1Lm9ELtdVwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(356005)(40460700003)(8936002)(70586007)(70206006)(8676002)(316002)(44832011)(26005)(5660300002)(4326008)(6666004)(81166007)(54906003)(6916009)(336012)(86362001)(966005)(186003)(426003)(1076003)(16526019)(2616005)(508600001)(36756003)(2906002)(82310400005)(36860700001)(47076005)(71600200004)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 11:21:31.2511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9042ae07-cf72-42f5-5d90-08da455335d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3094
Cc: Vasant Hegde <vasant.hegde@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This series introduces a new usage model for the v2 page table, where it
can be used to implement support for DMA-API by adopting the generic
IO page table framework.

One of the target usecases is to support nested IO page tables
where the guest uses the guest IO page table (v2) for translating
GVA to GPA, and the hypervisor uses the host I/O page table (v1) for
translating GPA to SPA. This is a pre-requisite for supporting the new
HW-assisted vIOMMU presented at the KVM Forum 2020.

  https://static.sched.com/hosted_files/kvmforum2020/26/vIOMMU%20KVM%20Forum%202020.pdf

The following components are introduced in this series:

- Part 1 (patch 1-4 and 6)
  Refactor the current IOMMU page table code to adopt the generic IO page
  table framework, and add AMD IOMMU Guest (v2) page table management code.

- Part 2 (patch 5)
  Add support for the AMD IOMMU Guest IO Protection feature (GIOV)
  where requests from the I/O device without a PASID are treated as
  if they have PASID of 0.

- Part 3 (patch 7)
  Introduce new "amd_iommu_pgtable" command-line to allow users
  to select the mode of operation (v1 or v2).

See AMD I/O Virtualization Technology Specification for more detail.

  http://www.amd.com/system/files/TechDocs/48882_IOMMU_3.05_PUB.pdf

Note:
  This patchset is based on top of "iommu/amd: Add multiple PCI segments support" patchset [1].

[1] https://lore.kernel.org/linux-iommu/20220511072141.15485-1-vasant.hegde@amd.com/T/#t

Thanks,
Vasant


Changes from RFC -> v1:
  - Addressed review comments from Joerg
  - Reimplemented v2 page table

RFC patchset : https://lore.kernel.org/linux-iommu/20210312090411.6030-1-suravee.suthikulpanit@amd.com/T/#t

Suravee Suthikulpanit (5):
  iommu/amd: Refactor amd_iommu_domain_enable_v2
  iommu/amd: Update sanity check when enable PRI/ATS
  iommu/amd: Add support for Guest IO protection
  iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API
  iommu/amd: Introduce amd_iommu_pgtable command-line option

Vasant Hegde (2):
  iommu/amd: Fix sparse warning
  iommu/amd: Initial support for AMD IOMMU v2 page table

 .../admin-guide/kernel-parameters.txt         |   6 +
 drivers/iommu/amd/Makefile                    |   2 +-
 drivers/iommu/amd/amd_iommu_types.h           |   8 +-
 drivers/iommu/amd/init.c                      |  27 +-
 drivers/iommu/amd/io_pgtable_v2.c             | 407 ++++++++++++++++++
 drivers/iommu/amd/iommu.c                     |  90 ++--
 drivers/iommu/io-pgtable.c                    |   1 +
 include/linux/io-pgtable.h                    |   2 +
 8 files changed, 516 insertions(+), 27 deletions(-)
 create mode 100644 drivers/iommu/amd/io_pgtable_v2.c

-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
