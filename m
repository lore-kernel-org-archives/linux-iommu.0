Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0B7C433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 17:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF3E840907;
	Mon, 28 Mar 2022 17:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ReSPmD-RPIcG; Mon, 28 Mar 2022 17:28:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8A6B94090D;
	Mon, 28 Mar 2022 17:28:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12B3BC0083;
	Mon, 28 Mar 2022 17:28:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3903AC0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26047400FD
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:28:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ayh_N6Fsn5XY for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 17:28:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::604])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D14594060B
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/Mow5SZL7HbHwwewspnnS1PzS6t+BZH6dhNtoobC5/ixK9fYkZ7/8b9G1RqYiX+c+MDUsI+Ns8+3JP4FGbF3/kwZUYUJ8TybKXHI6o/dU3QndM6jWEPmPPfXErK2DhMjK0RS+bhjQZnpMOS6LonYm1nP6sOIeJ+9aWOSRMI0UU1r3b+iP7lGIQzjK+Bg9UZswMFiAKDmFVkkRz0pUHhmbkOvXIFyFgPbhcY4sK01TIEgtRDje9mvo0e6dSO01AqvBW/yesyD7yVHcdndSM/I/LAtmHBLxOj2V227tqRJKPH8Ornaik1CXVFRnKUol8T3GHF4oPOpLkczNgjpqHkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVUMXMs1HqzE9irLevEFp2FZSbebVpi4jIF8lnt6lEU=;
 b=MHQVe29YMeD1bYKeRk+9Hb/EJU8rltqN+DJS/WTGweiDmGf0AJGKkRvonQ2Fe1xckXIkkg7odlZ54DwcNTBAuLrT6XvRF8P3FdtuchdW76RVkGYvuLPVz9K7D+5h0fxCAHDjflJTY7HYektuHBJvkSArO9pFV9/AGLVndeo/IQuul2O1hjevQi70QjvIxFdXB7FgJZu7huo4l5cs55vBD4QFdQARzRovC8ScuunmMxxb2YxZMDf+nPgpY2Zdf6Ly5sx4cwyeujhXwJQQORTbHV3jKidl/yERA1WFUeiaKuicmfhOq6F6uW3Ag0jMQObxLqJ561JMnkcrWjU8xOlwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVUMXMs1HqzE9irLevEFp2FZSbebVpi4jIF8lnt6lEU=;
 b=qYLljtx4/g86INKw+zekkJS0V/o83xSTDLXFtKEKnxv1sDgU6oqVGl4m3gJOBfR1p4cMTy1tsfzzDryD1oGLkrE9F6xdE3HtKDSc58fvu6YsKYozQ0T5QohNjtLg7yG5vKBApTOzV78WqsomlbPWIAN16ZGQhQdy/CjJtY45q7c=
Received: from BN9P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::13)
 by CY4PR12MB1192.namprd12.prod.outlook.com (2603:10b6:903:40::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 17:28:47 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::ca) by BN9P221CA0010.outlook.office365.com
 (2603:10b6:408:10a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Mon, 28 Mar 2022 17:28:47 +0000
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
 2022 12:28:45 -0500
To: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
 <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
 <tglx@linutronix.de>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
 <will@kernel.org>, <iommu@lists.linux-foundation.org>,
 <robin.murphy@arm.com>, <vasant.hegde@amd.com>
Subject: [PATCH V3 1/2] Documentation: x86: Add documentation for AMD IOMMU
Date: Mon, 28 Mar 2022 13:28:28 -0400
Message-ID: <20220328172829.718235-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328172829.718235-1-alexander.deucher@amd.com>
References: <20220328172829.718235-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f91862d-1f30-4ec3-41cb-08da10e06a82
X-MS-TrafficTypeDiagnostic: CY4PR12MB1192:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1192585E40511DBB7552B793F71D9@CY4PR12MB1192.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f94ZUAbix410WKy2elmkGbkZlLaWROOyaJ5R3jV14HrVrliSL2MHsXB988drS3kknu68AEhKagHAZSg1Ukd5fZtW7sitb9hXgUm8HyIVRiMlggjkqhjYPqy2vdyiRF74Qz2qfGlhdrokArD25MB5nVkZtq1OiAWWer/q4BqhlxeENdyf0vujemJ59offQE/rwBjIjlF/EnjXhCZjBH5gDtksxaVB8QA+KtveN00yAIGd5E9fPP5K3bYufG9gQ7zkOXpaEaZoQE9iXSet2iXLwROKgpZB3YkfakkYIA5O58flLabCMGjOicSZtTECFUXipfgMe6x3awKEPbQDJJ4AUFua8YWmBtA1pMDyYCZoulCinO3X5CktANThtCvNVixVR7glvsDyIv27jI7/4nPsBov3Ouu01YkAjuSmROA+rq2qtpkZf8FwA3haUEr+B4HXOg4nEqVkruW+SITuKunKHJW70r+5yGHSs1sufv8nFawmcAtl1r1pLE3c4KX7svPp+Q0BI+S3i/hn5DR6jOycnxPvnvbgQJtHGIiQQ5r6k7Mg5iFu9PyitgGg2i/zXo5bFsgrKRRR/PBXZnTn/unFQVwk8dHJZqayf7MzJ/2Xh7PDwI+6IVYgefSJ4qfDNQyKIC9hVrfLwCR/uF54De19ADmwuUm7Fa3OD6i9A132WqPjBYeX6KpMZ4T8Jew+Hk8bQKZTtlPms3sl2ODvInR4vK5eIwKd6UYV7GvlLDTj0FmdmzNdu2Y34gG3PMBgu6zkEN7+LKCjP3wcmS/WBzuQYSS3MLk6/q/qyMNJixbOJAyPNkS+6jdl1nP8pP4sPpEC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(336012)(82310400004)(86362001)(7416002)(8936002)(2906002)(356005)(921005)(7696005)(83380400001)(36756003)(6636002)(16526019)(81166007)(5660300002)(40460700003)(2616005)(26005)(36860700001)(6666004)(110136005)(47076005)(508600001)(316002)(8676002)(70206006)(70586007)(1076003)(426003)(186003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:28:47.0580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f91862d-1f30-4ec3-41cb-08da10e06a82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1192
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

Add preliminary documentation for AMD IOMMU.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

V2: Incorporate feedback from Robin to clarify IOMMU vs DMA engine (e.g.,
    a device) and document proper DMA API.  Also correct the fact that
    the AMD IOMMU is not limited to managing PCI devices.
v3: Fix spelling and rework text as suggested by Vasant

 Documentation/x86/amd-iommu.rst   | 69 +++++++++++++++++++++++++++++++
 Documentation/x86/index.rst       |  1 +
 Documentation/x86/intel-iommu.rst |  2 +-
 3 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/x86/amd-iommu.rst

diff --git a/Documentation/x86/amd-iommu.rst b/Documentation/x86/amd-iommu.rst
new file mode 100644
index 000000000000..3b1fb8fec168
--- /dev/null
+++ b/Documentation/x86/amd-iommu.rst
@@ -0,0 +1,69 @@
+=================
+AMD IOMMU Support
+=================
+
+The architecture spec can be obtained from the below location.
+
+https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
+
+This guide gives a quick cheat sheet for some basic understanding.
+
+Some Keywords
+
+- IVRS - I/O Virtualization Reporting Structure
+- IVDB - I/O Virtualization Definition Block
+- IVHD - I/O Virtualization Hardware Definition
+- IOVA - I/O Virtual Address.
+
+Basic stuff
+-----------
+
+ACPI enumerates and lists the different IOMMUs on the platform, and
+device scope relationships between devices and which IOMMU controls
+them.
+
+What is IVRS?
+-------------
+
+The architecture defines an ACPI-compatible data structure called an I/O
+Virtualization Reporting Structure (IVRS) that is used to convey information
+related to I/O virtualization to system software.  The IVRS describes the
+configuration and capabilities of the IOMMUs contained in the platform as
+well as information about the devices that each IOMMU virtualizes.
+
+The IVRS provides information about the following:
+- IOMMUs present in the platform including their capabilities and proper configuration
+- System I/O topology relevant to each IOMMU
+- Peripheral devices that cannot be otherwise enumerated
+- Memory regions used by SMI/SMM, platform firmware, and platform hardware. These are
+generally exclusion ranges to be configured by system software.
+
+How is IOVA generated?
+----------------------
+
+Well behaved drivers call dma_map_*() calls before sending command to device
+that needs to perform DMA. Once DMA is completed and mapping is no longer
+required, driver performs dma_unmap_*() calls to unmap the region.
+
+Fault reporting
+---------------
+
+When errors are reported, the IOMMU signals via an interrupt. The fault
+reason and device that caused it is printed on the console.
+
+Boot Message Sample
+-------------------
+
+Something like this gets printed indicating presence of the IOMMU.
+
+	iommu: Default domain type: Translated
+	iommu: DMA domain TLB invalidation policy: lazy mode
+
+Fault reporting
+^^^^^^^^^^^^^^^
+
+::
+
+	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007 address=0xffffc02000 flags=0x0000]
+	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007 address=0xffffc02000 flags=0x0000]
+
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f498f1d36cd3..15711134eb68 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -22,6 +22,7 @@ x86-specific Documentation
    mtrr
    pat
    intel-iommu
+   amd-iommu
    intel_txt
    amd-memory-encryption
    pti
diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
index 099f13d51d5f..4d3391c7bd3f 100644
--- a/Documentation/x86/intel-iommu.rst
+++ b/Documentation/x86/intel-iommu.rst
@@ -1,5 +1,5 @@
 ===================
-Linux IOMMU Support
+Intel IOMMU Support
 ===================
 
 The architecture spec can be obtained from the below location.
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
