Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C6BC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 20:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49BEE82835;
	Mon,  4 Apr 2022 20:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0j-lpCqy9RPL; Mon,  4 Apr 2022 20:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0DFE2827FD;
	Mon,  4 Apr 2022 20:47:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B2ABC0085;
	Mon,  4 Apr 2022 20:47:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01736C001D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 20:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3D578280E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 20:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Vq198mCtcKP for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 20:47:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C330827FD
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 20:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbfIaPjxTV2sW62awVpJbYlhaajeW6O4MYvV5f8ktZ2VhsfDDk0SegGzZRoZWriqv/BJNi+lnPicapYSsNYrinQdynGNvIGgvxftt8va27C2xD5A48QNKhQ+3P3qGEX52TWJ1J53otFtG6eAivzFSr+JygOODosjUhocd7AVDMIptP8KgVAAYYjvCSFubC4Y7M2wHaBxSEV0uTgkl3ZD8aYZ7rFtgvshJNB3k0RQrmgmN+3LARXTEWkGgzq/HcHY7jyGEb8gCDqREQJ5Mcmo2Cd1DrdMuNVyJMumwgVdKq9g06gQfge2mxMeExfbEVdpY3QMA8EbggFQsNGOTSBJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDY8rceRpGa3zaQsjeriXFqtawkmJXs+Bnz070b7r4U=;
 b=YgYtmMvsw+jCI9lJeVC2HMMoCAg0OdAKQs2HpDscYfploLSzn1tlEdG47ye7BPJEPmmKJSEGa14IxDiHQH2EuiVc5uqGC41OhGHvaRjpJHCEAo/+JXKn5PC6o5pwnrR4pHEnZPs5t581RBi44Lt1YaUKmRU14Stn9oP4iQWEoIbqICRUA2dJl2j8kjYpVuKaKTdxXjFtC2PVjVJ9hzozwois4aJFI0Le2tpjEDjuQ88ds/cWgd40hnbNO5vaJQQ8SbyagJPA/AJTdP5Or+pgzddZWHHIeOh0WkBE9OWetxmTZwQUqPHWFVgqdNImUxDgeM2xrg7jPIWwI/6Y5hMFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDY8rceRpGa3zaQsjeriXFqtawkmJXs+Bnz070b7r4U=;
 b=5ksGPDvdKv/MEKsOucF/TskflQSYSFr5yFy7ltl4oprcRgNZ4BwrSx/Ik8egquyFfUS3Y1gqBoYG7k6HuAMef84vZCU4Y50EI7agR+FfOZdDqkWFt/Ftl8NWpgbg3milR+WW6xB/QPgqJhTfj4EPMCYaVKjSmEGseTFXcI7Yo8E=
Received: from BN9PR03CA0501.namprd03.prod.outlook.com (2603:10b6:408:130::26)
 by MWHPR12MB1839.namprd12.prod.outlook.com (2603:10b6:300:10b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 20:47:35 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::8c) by BN9PR03CA0501.outlook.office365.com
 (2603:10b6:408:130::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 20:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 20:47:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 15:47:32 -0500
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 0/2] Fix issues with untrusted devices and AMD IOMMU
Date: Mon, 4 Apr 2022 15:47:21 -0500
Message-ID: <20220404204723.9767-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee9ee406-8356-40b9-5bd7-08da167c5858
X-MS-TrafficTypeDiagnostic: MWHPR12MB1839:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB18396E8B3BAB1796E8155F7CE2E59@MWHPR12MB1839.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plesJ/uUXjc2ZTat2zLTXVBktm1Skt9hkMM1pfv554bP9QxOfamovFGiQ80Nd14+25H7GsVYu/VHPEJRCwd0vLXmuHTODfnSUNNZdncSWPsphSLZBbmjn5pVO3Tqf6OZrp7V8SkaDvM2HK3KSltPuXF5viYIrNSSdsjKqLb5Ia0mQdZ29AM7u7nq2gfGvB1WhIA/gPbFq38L/VbcTqrsdIw6woioUguI64Y9bftRj+gAcWR0TXTYhjFuOBrctaGTBhMjcfm7s+gike2wfiU49Wl6JeB3Pez8IwR5uqtdZUKDpQsnBjZS3UyjKyn7z3pX+vMLR2/SdyxDIjSV94m+eO5W94/C75X2hjJ2j2W2ENQT1X8w5PlVb4pM763SA0Bv1BtpIrGIgLOEm/uVufJ+y9PI16cgQxtuzPjWnb42J4os3noyNnf0gaqOM8yJsufC+phJ4e/Bc7Jg8XbBIY9ZQf/EN9AkkKzYgNSQGEReOyyaqY4iEGSYRw1j0LJ9CkvofEfOA/M18LYHSh8qABpV4VAbMqyvCl9y3KpOB+RYpo+8P4u2A3grBsyyZtmxARTD16HmuKwW8LPmdVJV0RX2EUA0X4te9wgpWmCic8fumJ5YINUBEuoVPBq5ldLYpfdYEs60w+BpLw/kAUoLHFdpoFCqpiUadDNB+Mn9PwraJY1Era0uXnP3L2brYOsysAoz05llupbs6+oNoknd8ecgvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(8936002)(5660300002)(356005)(44832011)(81166007)(6666004)(508600001)(110136005)(70206006)(86362001)(40460700003)(316002)(8676002)(70586007)(4326008)(336012)(426003)(186003)(16526019)(2616005)(26005)(1076003)(47076005)(83380400001)(7696005)(2906002)(36860700001)(82310400004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 20:47:33.9506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9ee406-8356-40b9-5bd7-08da167c5858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1839
Cc: Hegde Vasant <Vasant.Hegde@amd.com>, open
 list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Robin Murphy <robin.murphy@arm.com>
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
From: Mario Limonciello via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

It's been observed that plugging in a TBT3 NVME device to a port marked
with ExternalFacingPort that some DMA transactions occur that are not a
full page and so the DMA API attempts to use software bounce buffers
instead of relying upon the IOMMU translation.

This doesn't work and leads to messaging like:

swiotlb buffer is full (sz: 4096 bytes), total 0 (slots), used 0 (slots)

The bounce buffers were originally set up, but torn down during
the boot process.
* This happens because as part of IOMMU initialization
  `amd_iommu_init_dma_ops` gets called and resets the global swiotlb to 0.
* When late_init gets called `pci_swiotlb_late_init` `swiotlb_exit` is
  called and the buffers are torn down.

This can be observed in the logs:
```
[    0.407286] AMD-Vi: Extended features (0x246577efa2254afa): PPR NX GT [5] IA GA PC GA_vAPIC
[    0.407291] AMD-Vi: Interrupt remapping enabled
[    0.407292] AMD-Vi: Virtual APIC enabled
[    0.407872] software IO TLB: tearing down default memory pool
```
This series fixes the behavior of AMD IOMMU to enable swiotlb so that
non-page aligned DMA goes through a bounce buffer.

It also adds a message to help with debugging similar problems in the
future.

Mario Limonciello (2):
  iommu/amd: Enable swiotlb in all cases
  dma-iommu: Check that swiotlb is active before trying to use it

 drivers/iommu/amd/iommu.c | 7 -------
 drivers/iommu/dma-iommu.c | 5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
