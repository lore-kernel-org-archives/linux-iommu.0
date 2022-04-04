Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B25C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17E9D80060;
	Mon,  4 Apr 2022 09:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bf36fJ9wT1T1; Mon,  4 Apr 2022 09:43:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B74A18290B;
	Mon,  4 Apr 2022 09:43:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A5E4C002C;
	Mon,  4 Apr 2022 09:43:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9D21C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97CB74002B
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wLat1a4KCWeK for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:43:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::628])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 713A140183
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKh5rzT0WI52Ojl7+8YT80irKW+dGEM5jQ28hAyhTCmGMFVn8PunYUsQxVnXK5/P/jIPI7vk1D+P+2WCQwHtbOYDLzaZREMuzxUNF/inhM2K2ey5B2jgnl2xXnDuHuQhgbxlymxjuPCjMDynOUPuUcOGZkMWXj7Q22Ad3hkC2ztRVWotLrNOvrFFGQ7IazDXFDkYMd1G2r8H1acws083xyJ2a+j1ix/ThssFgGPmpTMR4nPl1TuZXRjRcQvu2QJjvN2JzZgo6HbGNdnaIBJmPZKIZr/2sFROHBo8yPRc3znf+kx45BJq2fwdrkhwSLY4sXdwWP1EcPaaGuvjjLD7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipw1EIolEwZf3BEwVO0AQhhMGFQ9rHBCKuvs9TcNBRY=;
 b=TBh9sAGT0a0RhrsbKg6S90/5WGhf4QHrayPiklW/K/+nrGHusP7bVe9cefhaHvP5s3ps9z+RZpLcNl1yE7j8KKkS7tb4SY8+Yb23u+JGDD+JRVxLjknn5R7t0C24Uls6woMmJ8me9Xpd6Lq3aTw6IpAaUrT8YF8G4noynEguCd77J+goocaSRskMqyUu4FMBUXOB40rxTjzoqFz1QnNAPVS+zu4XSfmB0EeKS20wfQf/CQvUwwt2rFILukiqn97CsoXck35C8Lz2z4oG5O+ZIgsTA7XWC8TzrSWxh+qQ9mL1OFWpepa7QNluNb1vrQISBzpR1wLNiY8CIrJSN5x/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipw1EIolEwZf3BEwVO0AQhhMGFQ9rHBCKuvs9TcNBRY=;
 b=ve2YXUgoSjhC+wzaDJP/tM+ZTmndTKYjgkirrLZ0LZimi5L1T8n2d2IzJzOOvqexpZSNS0+oX8hqhUQId0sDuJPjbQHYRpmK/UdeWjMC3zYZB2kq61T8mEXbiVPVukM932YQP5F2j6DUj4uSDZOCF0STB5fD3PkQm2yxWb4JDzM=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by BL0PR12MB4692.namprd12.prod.outlook.com (2603:10b6:208:82::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:43:20 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::e3) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 09:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:43:18 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:43:15 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 00/37] iommu/amd: Add multiple PCI segments support
Date: Mon, 4 Apr 2022 15:10:52 +0530
Message-ID: <20220404094129.323642-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c9559b7-2853-4c9f-7065-08da161f8c88
X-MS-TrafficTypeDiagnostic: BL0PR12MB4692:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4692E68C8017669586A1801487E59@BL0PR12MB4692.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuB/H49Q/cREl5U3V4J7yS4jmUerRddys7jkpi9hjIiIgGwBeEvj7PO7MH0NOpM9XEbUCe8XJOVkPq2CMQhP3jlKDAOKJSjupU9TCcRxlUJ9AcbvDw2TqfFeYoOVecYtJM3+l4S6e7DwhoC9Pyev98lYnRYYG87M9EyrSDN7aHIKy69ftCFE5r+mcn+PKqX3c5UxF3RfVfk7SEBrkXXTm5DDHSffPt/PO1Yzm2gCRCE0rTdmcnFPz0ghw46iop8Bysm3KJ72mngYoGjsaONFiokZlnGu2m32627ZChAkgje2D2DOonmZ4CKKXUfQoY5ePR52AIUVDaS3sdYuNudTJEXc9QJw9BWMUgmhS8Nb+Knk6XTjbsJ5vfMsfAx4gUs55REdpuG2+QfKYrjcqMAastQRTtudX1zi6Hgv+BglUZ6dd21cedbNotXw+CmgFAbHlv8HUSW0F/y5diApDjjgH4xP0phcuYHRhnRpGnHVV7UumtOjc+NOa4dCrm84Ik0/HFrHVX3iQyNjlGKYjAoleOK/g5kgHivdB4hO5pb5dPtdMLSah8Q2pgNmiezNFqcwJGjpTaID3xJpN5OAqd/bLLYEesm/EUZwf1NR42tlHIy8+ITrvYKM9kX5BPJPScSkPVn16jWdX6HH7RPNYYS/2LaBpWs4hRQj/w3BdEg1HGiesEJYYEmnu/vtLjSGK1Iq1JszgAq+73vkaG4jHTZxrQpbtnatfwkdo/BFVwO7owpbOFLhbOurrbckZnkoRQ5SYwpU/zVXyhl2gZoXy8D+fTMXvu2bwK/5JYgWlnQ0L5k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70206006)(70586007)(316002)(5660300002)(966005)(356005)(8676002)(4326008)(508600001)(110136005)(36756003)(54906003)(47076005)(336012)(426003)(186003)(1076003)(44832011)(81166007)(40460700003)(16526019)(2616005)(36860700001)(6666004)(86362001)(26005)(2906002)(82310400004)(83380400001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:43:18.2020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9559b7-2853-4c9f-7065-08da161f8c88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4692
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
