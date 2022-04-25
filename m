Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C50C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAF6C402E7;
	Mon, 25 Apr 2022 11:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpxYxy0AzaPt; Mon, 25 Apr 2022 11:35:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 29E5A40277;
	Mon, 25 Apr 2022 11:35:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEFAAC0039;
	Mon, 25 Apr 2022 11:35:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53CA0C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3181C60ADD
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tBQoXU1QDC3M for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:35:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9563860706
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+0GUNjfufc5ZYA4S7AH1YgbR/t8mSl9LaINsz8TqaZKdETk+7Mf2IxXxx5c3ua2D2x3Q6x7veVr88GxAx7Z6keahOaO1WvB80urh7PZoZ4c6LnLrk2ANVMORSoQtXFil8iBLRo+yK7GFdCFYFo59m3t7G5E/4oACMEvvt3edvNj1fVoiOVw6ZdCUumq+feq53WxXAOwq9Q5sWxrfqycyowsKjRUl3PV4lQhrl/D4Bo6Nh5fzedjsw3fYgwNAeHqxTmgZ5ZIJt3bhlOcaheNLicaz7OWDEbrGR3r/qFwwIbu1J3QM1kIfpGrpP5sJzoGzPrRezc7eo8bO0DJUiT3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHCPwliMX4I5wtVXEc6GX4ILb0WrIRqfgiKyLftBOAc=;
 b=XPCVxGg85Qrmoop1zp+x3k7iQVIQwPjlhCc+Hlx8puhnRTvzzLKRf15XfjmCKBuSpvROp0fU+/W2/39nifzEDzpx3C9eZHIAuMlMfkAiNRdMmVzGgAUBkd5KqBFitwWjGrT4Pk0UULAdx4oR+UVuWk4mOF7FP7C6FJmoy9oFNSu2bBR5VzRGuzrf4ejQdc9/d9gSyLHYIZd3gWmlZQItCSpHeYQgcbnkdmKox/pr9Dap4jE7tY1hUKbKyRYbWcdn+KH/QbCgt1yrWYzX6E1GZ7vGzzo03Ne1QQ2qKMwsjHsRwqifLnNiHAQE5Z4ubRltDMzINrMBv5kiBbJPCJSSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHCPwliMX4I5wtVXEc6GX4ILb0WrIRqfgiKyLftBOAc=;
 b=bVOpWjmLSWf7C6PvRM85mRuz+R3L2K+k14VaNr8R0uAbwzEDIM8x0UtQFFhPAEBcDN3THEKqh194IFTB9kpZSLW+0E4qTVTQtFwE/59Fpkhop95QWPQUhhvPd39J98qjvqCjzpLjMtspMbbF+wIqaSdJQY3CDVAVQxf+LoQ5j6M=
Received: from BN7PR06CA0038.namprd06.prod.outlook.com (2603:10b6:408:34::15)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 25 Apr
 2022 11:35:04 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::ea) by BN7PR06CA0038.outlook.office365.com
 (2603:10b6:408:34::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:35:04 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:35:02 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 00/37] iommu/amd: Add multiple PCI segments support
Date: Mon, 25 Apr 2022 17:03:38 +0530
Message-ID: <20220425113415.24087-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5437bdd-7536-42be-5103-08da26afa436
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6145:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6145BF67FF72367963B7870387F89@SJ1PR12MB6145.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C26d6ZtiFVFLjunY9+WypCpUuzjiiqj4XmwAH6ZSgE/nZrFxkuATBjjvAqf6vA5YK+zWHAMPtyW2F0l97UAIjinscoDxWfIQhyp0Z5fdvQgxd3PqOQUCCrwJlLyobggS5LEIO5WAZ5zFwX9ni4Cv8NgQP32F77xeUyI0bsXMYqGkdkrBFd+zqF7CJXWM2Q2CFtQm4douv593yq1hf/5361zz49bKa6NviypVQYBk1MlBS6Bp93skkyr5W+1msD1xvjEW4fsK6jFJw+8WLXo8vgIFLx+buM3at712OV+B4BylsE5pMjrt8NlpCbkTT/SJZHsH7acpGUmVvctKMW8xVobBTj7z3bCEOfK3RVMCzZWemOb7HjKhCJIm3pvT1z72h5leYHrlUlHNYzOUn/ljuA7R9ogX5t4keAZa+/FpzOj6ZVCZthP7YWib7BRfLuZkQOl52XDTpQVFyhcHBwf52OuI+cMfw9iuaO0GWwHPaUNfVOyrGNTdAtw+qSveRW4tLx31qC5CUjcmPUt2y8HigZqvomrMabEpvZpeu+RUi2Ivi6hflk0sY31iVqZAtUjqMJqRFRWiysCFzVHBfKYg5MWNfX/qt+O0EKJgmTR/CtWAm9v1zpOL/OXeRC9mE7WQYv+XoRp0vkAUM7b9Au+dlI+Eg/ssLKRNQk9WbdLrgLPXt14rN8Nv9nU7ZQAJsz2tbYIeodd677yqeDZbGHHzN8x1bXxQ9OU8m4YqXCGy08h4x/8zC+tk3CIqDiMsh5BR+a5o4/LMKg1t4baUN5qVTu1LvWBO7QN9aUvB5V1CTn2HZVeRNroXHBYkIpHsRx/w7m4AVnTD56Zv/t4j8KtfbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(70206006)(86362001)(2616005)(2906002)(508600001)(6666004)(5660300002)(44832011)(36860700001)(356005)(81166007)(83380400001)(8936002)(966005)(40460700003)(1076003)(16526019)(47076005)(426003)(186003)(336012)(316002)(6916009)(70586007)(4326008)(82310400005)(8676002)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:35:04.1720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5437bdd-7536-42be-5103-08da26afa436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
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

Newer AMD systems can support multiple PCI segments, where each segment
contains one or more IOMMU instances. However, an IOMMU instance can only
support a single PCI segment.

Current code assumes a system contains only one PCI segment (segment 0)
and creates global data structures such as device table, rlookup table,
etc.

This series introduces per-PCI-segment data structure, which contains
device table, alias table, etc. For each PCI segment, all IOMMUs
share the same data structure. The series also makes necessary code
adjustment and logging enhancements. Finally it removes global data
structures like device table, alias table, etc.

In case of system w/ single PCI segment (e.g. PCI segment ID is zero),
IOMMU driver allocates one PCI segment data structure, which will
be shared by all IOMMUs.

Patch 1 Updates struct iommu_dev_data defination.

Patch 2 - 13 introduce new PCI segment structure and allocate per
data structures, and introduce the amd_iommu.pci_seg pointer to point
to the corresponded pci_segment structure. Also, we have introduced
a helper function rlookup_amd_iommu() to reverse-lookup each iommu
for a particular device.

Patch 14 - 29 adopt to per PCI segment data structure and removes
global data structure.

Patch 30 fixes flushing logic to flush upto last_bdf.

Patch 31 - 37 convert usages of 16-bit PCI device ID to include
16-bit segment ID.


Changes from v1 -> v2:
  - Updated patch 1 to include dev_is_pci() check

v1 patchset  : https://lore.kernel.org/linux-iommu/20220404100023.324645-1-vasant.hegde@amd.com/T/#t

Changes from RFC -> v1:
  - Rebased patches on top of iommu/next tree.
  - Update struct iommu_dev_data defination
  - Updated few log message to print segment ID
  - Fix smatch warnings

RFC patchset : https://lore.kernel.org/linux-iommu/20220311094854.31595-1-vasant.hegde@amd.com/T/#t

Regards,
Vasant

Suravee Suthikulpanit (21):
  iommu/amd: Introduce per PCI segment device table
  iommu/amd: Introduce per PCI segment rlookup table
  iommu/amd: Introduce per PCI segment old_dev_tbl_cpy
  iommu/amd: Introduce per PCI segment alias_table
  iommu/amd: Convert to use rlookup_amd_iommu helper function
  iommu/amd: Update irq_remapping_alloc to use IOMMU lookup helper function
  iommu/amd: Introduce struct amd_ir_data.iommu
  iommu/amd: Update amd_irte_ops functions
  iommu/amd: Update alloc_irq_table and alloc_irq_index
  iommu/amd: Update set_dte_entry and clear_dte_entry
  iommu/amd: Update iommu_ignore_device
  iommu/amd: Update dump_dte_entry
  iommu/amd: Update set_dte_irq_entry
  iommu/amd: Update (un)init_device_table_dma()
  iommu/amd: Update set_dev_entry_bit() and get_dev_entry_bit()
  iommu/amd: Remove global amd_iommu_dev_table
  iommu/amd: Remove global amd_iommu_alias_table
  iommu/amd: Introduce get_device_sbdf_id() helper function
  iommu/amd: Include PCI segment ID when initialize IOMMU
  iommu/amd: Specify PCI segment ID when getting pci device
  iommu/amd: Add PCI segment support for ivrs_ioapic, ivrs_hpet, ivrs_acpihid commands

Vasant Hegde (16):
  iommu/amd: Update struct iommu_dev_data defination
  iommu/amd: Introduce pci segment structure
  iommu/amd: Introduce per PCI segment irq_lookup_table
  iommu/amd: Introduce per PCI segment dev_data_list
  iommu/amd: Introduce per PCI segment unity map list
  iommu/amd: Introduce per PCI segment last_bdf
  iommu/amd: Introduce per PCI segment device table size
  iommu/amd: Introduce per PCI segment alias table size
  iommu/amd: Introduce per PCI segment rlookup table size
  iommu/amd: Convert to use per PCI segment irq_lookup_table
  iommu/amd: Convert to use per PCI segment rlookup_table
  iommu/amd: Remove global amd_iommu_last_bdf
  iommu/amd: Flush upto last_bdf only
  iommu/amd: Print PCI segment ID in error log messages
  iommu/amd: Update device_state structure to include PCI seg ID
  iommu/amd: Update amd_iommu_fault structure to include PCI seg ID

 .../admin-guide/kernel-parameters.txt         |  34 +-
 drivers/iommu/amd/amd_iommu.h                 |  13 +-
 drivers/iommu/amd/amd_iommu_types.h           | 127 +++-
 drivers/iommu/amd/init.c                      | 683 +++++++++++-------
 drivers/iommu/amd/iommu.c                     | 545 ++++++++------
 drivers/iommu/amd/iommu_v2.c                  |  67 +-
 drivers/iommu/amd/quirks.c                    |   4 +-
 7 files changed, 888 insertions(+), 585 deletions(-)

-- 
2.27.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
