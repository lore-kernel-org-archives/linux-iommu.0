Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F417EC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5E0E819B8;
	Mon,  4 Apr 2022 10:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id icHLtl7W-kF2; Mon,  4 Apr 2022 10:00:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 668378187F;
	Mon,  4 Apr 2022 10:00:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32FD4C002C;
	Mon,  4 Apr 2022 10:00:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 152B0C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01D5E410E5
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:00:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7BTLakBhc2yl for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:00:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::622])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88D36410DE
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic0xQwPpQ0Hm30+ph7ZEhwlLl24kFnb4E5Scd2fYcmZVXbVFm4tMXbHLZ9Z9mm7ny0uE0QzsFxwSsEbGi9yhEX+IsCpPkqry+MAmZpWmeZkagrrr6KsV9b92F7Fqqno9IhjA+XaINlannEtQKn8Sw2QQ2enqyQsidAMvcl1uCbyTuPSX2Fh6nn+pQQvHt9sdsztqcF+Ba5imYmeVBkhIRji3n0xI1ctDF6e1wtNtMM2lScEZkanI5CXvuCE2AMHDm2KIJWdbV5fLMuTA/gpZhfDRsNVdRgvGOcWE1eAbxRRfmtI8Ix0fqZeFO4ZvjFDg3QkOnsnYpf1virWBvAI3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipw1EIolEwZf3BEwVO0AQhhMGFQ9rHBCKuvs9TcNBRY=;
 b=DfD8u58fXPhrBOV695Ep2n/ZoJN3+AkbegRE4eOFJoH7fbg2A2QJdqhrItkxZUtYIXApATelhb/uENYK7uutastYDG7VkqZDifA074+fgEjOiB8rKtUVCOOffqzc2myAj6/imrcF64VInbJ1wK0zY+88jPXhTC3W1LY+5Uvd3duPscFHPHBUp2n7sArM//3Bt38h/PWOdKCYwmbXnAOFBY6QNhxHYnCVfQx19zkB7SRk5PceXr3+9OlfHzU2dqBU8XQC7kIQVfRCfaZyQ7fQir+5A7Chr0U/i1sThkqHOhy3hzFUQUL1psEaInViXn4iJ4U0iAUI2YEqcgyA2fWcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipw1EIolEwZf3BEwVO0AQhhMGFQ9rHBCKuvs9TcNBRY=;
 b=wJkWn6BMktz1ey1F2zznenE4dRKPf4fd786kLeGjm6TN/sm7+zJ2diYTeb2OjzX0SLlAJOrFeJquR91UYgyLrBK/69qmHXWIWLGHVdM6vWHG1Lm6+1fIdq+ANaIXaZ/Sv7IVVp7e6PI+wL9ZMdP+5JSS+n3hXQYTwqQtdqssGzU=
Received: from BN0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:141::31)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:00:51 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::31) by BN0PR07CA0017.outlook.office365.com
 (2603:10b6:408:141::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:00:51 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:00:48 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 00/37] iommu/amd: Add multiple PCI segments support
Date: Mon, 4 Apr 2022 15:29:46 +0530
Message-ID: <20220404100023.324645-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c2c5434-cd94-482a-c2f1-08da16220019
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2985870B2C987EC76E7A7D5387E59@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLR6ObWx2OT0bc4nrs2aqYbFiZ6vbt7fSOWrQnIqO3gLjWvFVUzp2FR/2UtLp2Mt+NRO8dl9pE53DQMCwEuPP0HajMzWwecVk+EOgS5xOfsUSOiq98tq1AWa4X/fPhr35PZwGp7H2CbKONIlOJ91VMJnJUCo+aTJfS24swQmlNO8NubPPDmrIzCuP44o+Xbx64gILxBEqSt8cYFxmx89pTRbtMvK/mSVOpm2yfn/IMwjrJa74uqv5LcsnnYDJSG+pbpBjJ6EzU0KwHNfZ4mZkQH6f0H0zfOUz0Jt+7uUn16SBSzVvOx0EE6Ai6eckYe5Aep7jApSCuBapDCq5ugPWvr/4VvHAq8jaxDMc4tppDTLJTGomPYIlqTUvGqqLYXEYtbqu/ovHhxZH2gKZKmLD9k9oh+JXmgz2b9++aPdW4M/4KvGba49PtGNIB3NFP5mr3qjBRN6FsKHSK7rVtWlPxI7V0oBeIumUS+vM2/GBcIcyLqDXweXbJgzLStFSFI3Hn3nTP8hJTCNlSPtcZFl5DWZRO4Sv3Y5MkP+7b90yk/CCbukNIQB0aLHQls1KFGIl/rww7Dajweca0Unz10p7hCwBfNq+g0FR+/hP/naXnKlwkUcKRwa6vWK1Paky0CYSLUkFzNdXn5RY4RB9NjM1O0n+kX3ZhNTCYzdXOUGvyr9L3GQTRN6vUB3dsx2YQsHzvSOlnzyUNcJGp6Q8jR7Dbq3ae1/iseT5IvXpzp2W0+ttgMtpe3b4hEuWCKdc4QyVl8CR0yYSsfIqkoJDPP7VC2gZkXq9rYN3EXa2Fia8Tc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(1076003)(336012)(186003)(26005)(16526019)(426003)(8936002)(44832011)(36756003)(2906002)(5660300002)(2616005)(966005)(508600001)(36860700001)(82310400004)(8676002)(4326008)(70206006)(70586007)(110136005)(81166007)(356005)(40460700003)(54906003)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:00:51.2108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2c5434-cd94-482a-c2f1-08da16220019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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

Patch 2 - 13 introduce  new PCI segment structure and allocate per
data structures, and introduce the amd_iommu.pci_seg pointer to point
to the corresponded pci_segment structure. Also, we have introduced
a helper function rlookup_amd_iommu() to reverse-lookup each iommu
for a particular device.

Patch 14 - 29 adopt to per PCI segment data structure and removes
global data structure.

Patch 30 fixes flushing logic to flush upto last_bdf.

Patch 31 - 37 convert usages of 16-bit PCI device ID to include
16-bit segment ID.


RFC patchset : https://lore.kernel.org/linux-iommu/20220311094854.31595-1-vasant.hegde@amd.com/T/#t

Changes in RFC -> v1:
  - Rebased patches on top of iommu/next tree.
  - Update struct iommu_dev_data defination
  - Updated few log message to print segment ID
  - Fix smatch warnings


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
 drivers/iommu/amd/iommu.c                     | 540 ++++++++------
 drivers/iommu/amd/iommu_v2.c                  |  67 +-
 drivers/iommu/amd/quirks.c                    |   4 +-
 7 files changed, 884 insertions(+), 584 deletions(-)

-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
