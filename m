Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0774C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FFF541893;
	Fri, 11 Mar 2022 09:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ihCSfX4jUGq8; Fri, 11 Mar 2022 09:49:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1203F41868;
	Fri, 11 Mar 2022 09:49:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD8B9C0012;
	Fri, 11 Mar 2022 09:49:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBF2AC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C415F611BE
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:49:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r8p2YLzaXY0o for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:49:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::628])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A83F611BA
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDNpmQXWUrQ70UpYPgMOPnNiqsxVzf1oZDPf+/fuQ+EIr+LUt8KJ7IBtxl5qjp062NFLeI/19drsPJr3w9MrV8c3bYDIrHMuLW0neEzS3J/+nkz6vU/mTvKZaOck40BNa59PVeqsivf0N2zhqdi9d5gHKBuDxYV0X7TWTXd/fpXQ/jALGTHC0Vhh1IWRfb/kZf0j7eAgP3cZOKlYxJ7VS5+sXlyt3Yb1hp2TYH5mVeDLJNVxi9fnsevQeCUhYQ5oDtHdCOxSbhSxOEXpQ4T/HZq4B21csM8ZiueJzyxCEcpgTZSPPCdGr5nerCORX1SDco+lF8HIGIYjdxEIIiqQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yth8EEvaNJ4xxlW7OhxmPLZKcoctYPFFnhSC+/y4wh0=;
 b=alDuU+fbpZm00HomyqNyQxmkXp+Y7Ox1yekVNqqbLGamtJLK5W3Z/Zn3Ja1uRUNOOKVhMFe2MFGvz9N39KVvj8qBCtEdDvK+QoVrQqpQSn/iPAsvAKz2ai3UygIVSKl0KgzYHFZ7afqf6d6mnCww8sKyP1fZacMDZymZrqDbX1S/OEJy898QlyQGOvNP1X+H+6M7KnKCzVusL2nqULbmuFTa0QFteEI7bLiO6iyzLk7lRNbhD7x34Mz/qi2MSGHWd6cuQcNKENqBewdPamojqj48f7Qo+RJSPBDnuAn8/jesKK+X41Ar0WISzIx7W8t+jTuC5mBemXN2EHYP4mbvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yth8EEvaNJ4xxlW7OhxmPLZKcoctYPFFnhSC+/y4wh0=;
 b=3s4zkVvP1BSZ1lc78689e0OOaa5UgAh04XE+85LrBEvh3zyAc2wsaUI9VKGH9VTsUogcI05SfeGC7DxEzfFfdczt0Gyl/UaVwZndxN1AgYsN5b/1hLFwCOntKXQOVF7rQ96hw10FB+xlgRSPQjnkqkwTTJtPYeeagsT9nVbKlOM=
Received: from BN7PR06CA0069.namprd06.prod.outlook.com (2603:10b6:408:34::46)
 by CY4PR1201MB2519.namprd12.prod.outlook.com (2603:10b6:903:d7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Fri, 11 Mar
 2022 09:49:39 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::cb) by BN7PR06CA0069.outlook.office365.com
 (2603:10b6:408:34::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Fri, 11 Mar 2022 09:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:49:38 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:49:34 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 00/36] iommu/amd: Add multiple PCI segments support
Date: Fri, 11 Mar 2022 15:18:18 +0530
Message-ID: <20220311094854.31595-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2327efb1-60a7-48bd-1f49-08da03447579
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2519:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB251908347483E2BF7C5CFB4E870C9@CY4PR1201MB2519.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogFIYMe2ZzRsfCYD7J4KDn2q9HB4wh4D1tkWMHgq8XUmUYmYf16Jpo5x7ADogTnO4F/lf7qx9yCw6SYk4lZK4KxjjrDgQ+At2YZT6ZU7Vguexp63Eb1mhbPAZYLVBXl2B5ajNxZyoJoaJFRyQUd6tkPq5eHRXvw2v1dTjlpKp5o2tIe4tIenHf9dcjvh6fac5S84/Ath7UYcujGRX7uhyz2YNHMsuvDWMMqaWaAYqbhVhAo+HiruAqQyF3dOgbrleMf0TuDRtXqnUKlIjDVt8NL8l9HzjnOXZfrh/nKjCBKo9zv+G3zW5d/YPtHVV1QvJicLNoWm3Evu0MR2XvE7UZDYqZv1j4+ToErzBi6VI3oUFXBvjU3e0DHSaUPvjszYUrNaU4BDkiT9uu8Qwi+EiBmWlVDNXYGRZt6K5oZg9aSuASQQp+CZB1LPo27TH6I4sZNlhhiiFKLzQHQ+FzF+k/qsrrJnG6Zxulq9g7jWW2putn3aQUTl3+bNYCzq95xiQZIB2893Tgbb70LOBY3VotsWdyPb3y4JJWa4vlbWeQjNGh1/S1NZH3jro2KJ407qiOwYLu52hko4IIIm4W0S6y3GcfujoQyCBdNQtXib3gFC8g20IvA4qHFvA9GT03Cp+eN2hc2OPmu53bYH9d0akSGr3Ned8qIwOKTrT27retjYfZBUFSW5M0STJ2pyuXzth0DSTd9nf8+wzwCeXxStug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(16526019)(186003)(26005)(2616005)(1076003)(81166007)(356005)(5660300002)(82310400004)(508600001)(36860700001)(6666004)(110136005)(4326008)(8676002)(47076005)(40460700003)(70206006)(426003)(336012)(83380400001)(36756003)(316002)(44832011)(2906002)(70586007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:49:38.9253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2327efb1-60a7-48bd-1f49-08da03447579
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
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

Patch 1 - 12 introduce  new PCI segment structure and allocate per
data structures, and introduce the amd_iommu.pci_seg pointer to point
to the corresponded pci_segment structure. Also, we have introduced
a helper function rlookup_amd_iommu() to reverse-lookup each iommu
for a particular device.

Patch 13 - 28 adopt  to per PCI segment data structure and removes
global data structure.

Patch 29 fixes flushing logic to flush upto last_bdf.

Patch 30 - 36 convert usages of 16-bit PCI device ID to include
16-bit segment ID.

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

Vasant Hegde (15):
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
 drivers/iommu/amd/amd_iommu_types.h           | 125 +++-
 drivers/iommu/amd/init.c                      | 683 +++++++++++-------
 drivers/iommu/amd/iommu.c                     | 527 ++++++++------
 drivers/iommu/amd/iommu_v2.c                  |  67 +-
 drivers/iommu/amd/quirks.c                    |   4 +-
 7 files changed, 875 insertions(+), 578 deletions(-)

-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
