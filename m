Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B335BC433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69E8181A65;
	Wed, 11 May 2022 07:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKJc147aYyW1; Wed, 11 May 2022 07:22:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 386F38174F;
	Wed, 11 May 2022 07:22:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 130B5C0039;
	Wed, 11 May 2022 07:22:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8F6AC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A890181836
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HliU_ms1WVje for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:22:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::600])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D3D668174F
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj/3cG3WKwy7VdhJqETfegfl2Vuu65JQ/R1+pXaz3LMXCptFNQ6lHuJTFzxpPvemeExMpTHHjTJLTUEkunDpRVfcLKa+et+IhSMjH65OQBY3w+4IXJUc0bLMo0oOBvlHhqtmz0HOsdvz01ci3AZYO5ZZHUFFm6ESX0/9jBenChhXiDaJqc3/oABik3NMiHF33pubbNIxXAyqkyPDVAikxpPxwpAlp0I3rWH35Y2lq8D3hsVXNF2KeBXzVob3e2p3rD8/eT37ASU8AlmaPOuttmhB25pukZ0F3dP3ynpSjClcWFOw9mY/gs2jMEs4aZdqcXoqX05l7QYYjFKpE1ywZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdsJawCCjbZAc8HuBmx1W5Tmu0af5JI+mEsfRTcQuEI=;
 b=f/OEMLV5apL5I6cnwhBQd7Ql8tU0hCAxK5q40iuRXHdWj5Os68ZHX1P5Jwxv+cslRVbbGV37t0JHgn+E8xnY8OT+L9mt9MwZqOSvmWbhJ6/fPCAPN5VjjGhQ56swtx0gCt3YrWoxui1x2DJJtyFwAc0JrzVOwA+oXD2RAFad2zUHfxEN6L8TNZHjVk8WoO1Dvg0Rh7158jHXUTF2apYmGh5hiidsJAdP3ix3/EaiTSViZWQhNqtPHMKc+HatEJ9xZ2skhgUvzR7A7oH8TGWuqipcNHywresHsAlDwFyNffJzW+JGAFW4XyZva9GkmJjB0xaWJWKu9b/s1+DtueCHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdsJawCCjbZAc8HuBmx1W5Tmu0af5JI+mEsfRTcQuEI=;
 b=YfsUtvxgNmr08qrv0Ng4BhSkSgAqy1HKRylWBrXzZX7pyk/cvOUOFyNzOBFJ1Kb/Oc3MicW2b9UjanqPf+Nk37/kiXBA/6bGXkdRGKEUj8caFJImzFoE+GKx5Cx5PhbRXCXdYLg0U4W6O6gi5yc9UU01WYFsf5WH7xgbZaIsSq4=
Received: from DS7PR03CA0327.namprd03.prod.outlook.com (2603:10b6:8:2b::35) by
 BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:22:16 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::89) by DS7PR03CA0327.outlook.office365.com
 (2603:10b6:8:2b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 07:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:22:15 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:22:13 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 00/35] iommu/amd: Add multiple PCI segments support
Date: Wed, 11 May 2022 12:51:06 +0530
Message-ID: <20220511072141.15485-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0629ace2-90b4-4d3e-3846-08da331ef9d5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB352587FDC77118C9935F3DF587C89@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lblhqwvCgMHdtKxXLs5Rlb2Bek1kbp8NTSEuREX1iLNjykQETJqaTzOjDjVMUE2W9J+j0dA2SdsUW9mVLLC79ScZYczBZlU61qqSgY0zExH5H+1s9Evd5DHqpVa7qq3/jgQg4LazEgRbnLJsIoX2IqK5uVVlk6hrHcZTL0R2iZp/ueflPwKwoXiYsSDUOTqKfexncOsqIYhOsKOWhhy3a8pX6Ppq+g2f5IfXk8ZuAxTqIVrw4O5vpkiSPgVfxzuj8sXqhsie52szHq3MNtzllbH0hg+VRHMX9fNOhbFiFfJx3Uu3fH+0bywS3jIa2LD9gY1CZ//+DRcMm+KCLTuX0c4xbT4NeIGwZiVH7iR3K3CJmiHbsh/ViCTi0chvtBge/xHxqkSa/cHesSdgT82qq2F4isARa4KwG3oBiJiBQQow/1Vg3q3QBalEsoB/xSJ615D0PBgj3XZcduUjHlGlXFPNivseIji6cxw7u6AydTgUo7CisFuzEUEBzwm0SpppG/Ytc+8r5UlrUM/STkKZ2ZdAUN8G9IexTAne3g0o18czw4ufob29oFi8ORgBgYzJ3hYNdBHmFDipOOfo1NDJfmmcKDCSHuwBrELyZO0I2kNPn3qOP5ySs9LpBJWpaUVvoD1oCH90mxqggl1ASTcpGhune5EIyRW4/xN/GMelRe5S4EZCBbZ2YhIbdLp3FtFaUxlvjTyp2nG4IsGVQpcBV7+jvKk74/AQyi3fIvCmSUoJHeASqBdGMA2HtembK2TbcnzVOXjdms6ej6Ijy3E3oTlVxr+dFDHKyIONQcowG79Fs1foTug8WTfBePPWpWZVLps420MAGcbSirjnDvjHdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(44832011)(70586007)(40460700003)(2616005)(8676002)(1076003)(5660300002)(4326008)(82310400005)(54906003)(8936002)(316002)(70206006)(508600001)(36756003)(966005)(36860700001)(6916009)(356005)(426003)(86362001)(2906002)(83380400001)(26005)(16526019)(336012)(186003)(81166007)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:22:15.8944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0629ace2-90b4-4d3e-3846-08da331ef9d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
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

Patch 1 updates struct iommu_dev_data definition.

Patch 2 - 13 introduce new PCI segment structure and allocate per
data structures, and introduce the amd_iommu.pci_seg pointer to point
to the corresponded pci_segment structure. Also, we have introduced
a helper function rlookup_amd_iommu() to reverse-lookup each iommu
for a particular device.

Patch 14 - 27 adopt to per PCI segment data structure and removes
global data structure.

Patch 28 fixes flushing logic to flush upto last_bdf.

Patch 29 - 35 convert usages of 16-bit PCI device ID to include
16-bit segment ID.

Changes from v2 -> v3:
  - Addressed Joerg's review comments
    - Fixed typo in patch 1 subject
    - Fixed few minor things in patch 2
    - Merged patch 27 - 29 into one patch
    - Added new macros to get seg and devid from sbdf
  - Patch 32 : Extend devid to 32bit and added new macro.

v2 patchset : https://lore.kernel.org/linux-iommu/20220425113415.24087-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Updated patch 1 to include dev_is_pci() check

v1 patchset : https://lore.kernel.org/linux-iommu/20220404100023.324645-1-vasant.hegde@amd.com/T/#t

Changes from RFC -> v1:
  - Rebased patches on top of iommu/next tree.
  - Update struct iommu_dev_data definition
  - Updated few log message to print segment ID
  - Fix smatch warnings

RFC patchset : https://lore.kernel.org/linux-iommu/20220311094854.31595-1-vasant.hegde@amd.com/T/#t


Regards,
Vasant

Suravee Suthikulpanit (20):
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
  iommu/amd: Remove global amd_iommu_[dev_table/alias_table/last_bdf]
  iommu/amd: Introduce get_device_sbdf_id() helper function
  iommu/amd: Include PCI segment ID when initialize IOMMU
  iommu/amd: Specify PCI segment ID when getting pci device
  iommu/amd: Add PCI segment support for ivrs_[ioapic/hpet/acpihid] commands

Vasant Hegde (15):
  iommu/amd: Update struct iommu_dev_data definition
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
  iommu/amd: Flush upto last_bdf only
  iommu/amd: Print PCI segment ID in error log messages
  iommu/amd: Update device_state structure to include PCI seg ID
  iommu/amd: Update amd_iommu_fault structure to include PCI seg ID

 .../admin-guide/kernel-parameters.txt         |  34 +-
 drivers/iommu/amd/amd_iommu.h                 |  13 +-
 drivers/iommu/amd/amd_iommu_types.h           | 133 +++-
 drivers/iommu/amd/init.c                      | 687 +++++++++++-------
 drivers/iommu/amd/iommu.c                     | 563 ++++++++------
 drivers/iommu/amd/iommu_v2.c                  |  67 +-
 drivers/iommu/amd/quirks.c                    |   4 +-
 7 files changed, 904 insertions(+), 597 deletions(-)

-- 
2.27.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
