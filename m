Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7A2C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 17:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 257B540911;
	Mon, 28 Mar 2022 17:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eCJ0k8yw10OJ; Mon, 28 Mar 2022 17:28:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0EEB540907;
	Mon, 28 Mar 2022 17:28:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF369C001D;
	Mon, 28 Mar 2022 17:28:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66DDEC0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4636760899
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OYPiUjw56sDj for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 17:28:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::60f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CF7C607F7
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu+VMvWUpGBPkkteruSikd8bizGxzvDeXGlkRfUx0kBCVIALAvstTmOb4H5tP7ynIdIDTq74NWVO7VlURLS5+t2DjxKEcvgY5vIsJ8kEFys5dmsg39XP3byuSVGXvtjpjGdEQu6/23KOY1FPnQ+d+wvNHpcfXP+5lGyzezkJueKujGSpL56Hhm271/tNHMvJMLRJutqsg3/WDUT5bUyzurxD+YC6+W4K1uwzvxjPTM2huJ9H//wOA7jYa7lNwnMF+NT1PF1l5HKkjOoeIQewN9loYyHCLzdeLY2HQoD8l1RyIIgFdKF2tnat8IAcoVTxr17pP+2OPPhUp+h0xiwB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD6dFuRviy6j/GEsp0EBlmm/FpNfFwy25uFYexSkFKw=;
 b=Kwqh1BRYkb0hQjfekQ4Cv1E/wVh0zd406RWWkcLdoqN2kYmOLpASLwkywHQ0beTnd5tzWtapCnPcXUi7wnvp2EYCHN5KK3lQpw3/7aqZCY18wkHH1uRXIopCLEkgr2sU9uzs5e3OcZ2ytUXw06EHGCyH29ZSRiLyxxZo6q8WDFJAXVJf3q3EDIyRZgSf+mteStt3dISx1uCPlNjzIl0mP+mSTIuJkMynUmnmkyQx5JG4723P8MoP4niEI1rIjUuOalwfvuiTKLS6tVav8WRMwgPL1whMF/Cri9VosOkmh4lES7GYEJ+lmnaijQLQgbtxsgieHBdc+Kdr8i1i/dfXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD6dFuRviy6j/GEsp0EBlmm/FpNfFwy25uFYexSkFKw=;
 b=ukWbaQwXuGrUVM3wBbzyl83JG2H1foxvH/zNAJZxeLXBl6vu/mkC2GkVV0OZQmjC9Iy/yeIMXgdjvEaE98aJSgaUMjEIWpYFWGmDzNBnJLoQBszaoMZEF0e8qTT4jTfaZVVAtxh4JIzb1uV3cyDHBuu8SySznpgiH37w71viUjA=
Received: from BN9P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::10)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 17:28:48 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::10) by BN9P221CA0028.outlook.office365.com
 (2603:10b6:408:10a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Mon, 28 Mar 2022 17:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 17:28:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 12:28:46 -0500
To: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
 <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
 <tglx@linutronix.de>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
 <will@kernel.org>, <iommu@lists.linux-foundation.org>,
 <robin.murphy@arm.com>, <vasant.hegde@amd.com>
Subject: [PATCH V3 2/2] Documentation: x86: Clarify Intel IOMMU documentation
Date: Mon, 28 Mar 2022 13:28:29 -0400
Message-ID: <20220328172829.718235-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328172829.718235-1-alexander.deucher@amd.com>
References: <20220328172829.718235-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f3e3d0-47c8-44d0-39fd-08da10e06afe
X-MS-TrafficTypeDiagnostic: DM5PR12MB1884:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB18846AE2C5550E6D789E3EA9F71D9@DM5PR12MB1884.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPN9ZD83f3wW33/3GLaCRDE7qmuAowo9SXKt59YdJCYlDAkhBsLSXcqCs5I+ocq8XVtcBneE/sdnIqvptzmyLmCIQdMXycsx4hl+NHt5VZU23zE2Yt7Jode1Bnl0TzauZlKwp4BsJzrpEFZ/DIvVye/qgJkLRXsBbv0dhB2FwYQ/B2bI5+smi3icqOtDt2cUdwft44e70UsXMeruwNilwIA7RINRnkbFejs0ylud3N+k/mo5DzNtdGZ4u7+OyMZhjTwv3LrbCrbvL+Jvs49Wdx5/E3KCravDBclA2MZjFfdtvSmNQSneMhE3pJH17euQPOsBObe+NOu9+LBqd738Nf51H3+bZpaiHWddIQx6Rih/qdlKPUyfhfQd7ljetncXn1s2TG5EowyKxCi9H5hsIJKAdlzPzgml/I2sHan6qnsbtT/5mXAdztn2/fNupcfv3E9GB1VBXvaVq8O5kmlDavdqMmHjFpnonhcbbpWu13E8eS5YfILkXTSkpBlW2/24lRQFAp+6b492cJtl7qGV/kKq4Z5Bf3/jMY9D+iIxLfht2BgJccIkk1XDuoiTrA1IQz8T3FsbS5jB0hbjtvY/cFANcBTziTdrC9ujDrNgrXgEpzCR4nbB5NallokmGcxlNKJON3l/58nbRbtHttXFf5UnGQWUgtadvbd/f9KbFFMqfd6ui601ISEjcN059SMK/r8OCmbp91mwmYPMzmnWMdEH2UTR0Y3/UosgxkGrCmk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(47076005)(356005)(921005)(86362001)(70206006)(70586007)(4326008)(2906002)(7696005)(36860700001)(81166007)(36756003)(2616005)(8676002)(83380400001)(16526019)(1076003)(6666004)(5660300002)(316002)(40460700003)(82310400004)(186003)(26005)(508600001)(6636002)(426003)(7416002)(336012)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:28:47.9173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f3e3d0-47c8-44d0-39fd-08da10e06afe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
Cc: Alex Deucher <alexander.deucher@amd.com>
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
From: Alex Deucher via iommu <iommu@lists.linux-foundation.org>
Reply-To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Based on feedback from Robin on the initial AMD IOMMU
documentation, fix up the Intel documentation to
clarify IOMMU vs device and modern DMA API.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

V2: Fix spelling error in commit message
    Rework ACPI section as suggested by Dave Hansen

 Documentation/x86/intel-iommu.rst | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
index 4d3391c7bd3f..17d8497e506b 100644
--- a/Documentation/x86/intel-iommu.rst
+++ b/Documentation/x86/intel-iommu.rst
@@ -19,9 +19,8 @@ Some Keywords
 Basic stuff
 -----------
 
-ACPI enumerates and lists the different DMA engines in the platform, and
-device scope relationships between PCI devices and which DMA engine  controls
-them.
+ACPI enumerates both the IOMMUs in the platform and which IOMMU
+controls a specific PCI device.
 
 What is RMRR?
 -------------
@@ -36,9 +35,9 @@ unity mappings for these regions for these devices to access these regions.
 How is IOVA generated?
 ----------------------
 
-Well behaved drivers call pci_map_*() calls before sending command to device
+Well behaved drivers call dma_map_*() calls before sending command to device
 that needs to perform DMA. Once DMA is completed and mapping is no longer
-required, device performs a pci_unmap_*() calls to unmap the region.
+required, device performs a dma_unmap_*() calls to unmap the region.
 
 The Intel IOMMU driver allocates a virtual address per domain. Each PCIE
 device has its own domain (hence protection). Devices under p2p bridges
@@ -68,7 +67,7 @@ address from PCI MMIO ranges so they are not allocated for IOVA addresses.
 
 Fault reporting
 ---------------
-When errors are reported, the DMA engine signals via an interrupt. The fault
+When errors are reported, the IOMMU signals via an interrupt. The fault
 reason and device that caused it with fault reason is printed on console.
 
 See below for sample.
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
