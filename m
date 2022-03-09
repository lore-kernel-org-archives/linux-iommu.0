Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04657C433EF
	for <iommu@archiver.kernel.org>; Wed,  9 Mar 2022 17:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99B5060D61;
	Wed,  9 Mar 2022 17:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hfZAjEIZQOVi; Wed,  9 Mar 2022 17:58:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6801B60B14;
	Wed,  9 Mar 2022 17:58:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D14DC0012;
	Wed,  9 Mar 2022 17:58:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 155D3C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 17:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2091842C7
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 17:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S23e2R8FsGWu for <iommu@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 17:58:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DAC53842AD
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 17:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRvbNQcGui/5wgyCNux6sZ+uSDmo8vW0iRBJHAcZ7tqgsN06MR3o4YUlGuzTfCdrvJB0vIK3xiFLCfF0hAza6uUvI8B/iyqiFATWims6+LuTRfLtN1qc4DkOccgX/EeDTl7ayX7TfiLrBXYHq1hWpTcAimmkVKOYN+XU2rNByr7Z1zwy1EhTAmWzP819jDuTaA2HPsWaXlnUSppyt/mHLtmncLytOaDblMwHjYvo101AHrxTBFjQJGaP9pZ/EqJ3LLKf2BaHavfHB3KR4p9dJQ6vKkPAWaVTxZVqjMU4QnJanaDol/B67WuigGZcXGudRI1MmEOsw/bvRyVEVgdkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvZsSYlvpGgthuEtuTfJdslChrLU6Bw10Fa/z/3eRlo=;
 b=UV/CeJGoqDOZI+MTD/ZfmiTBCerqla7UMUOu4Gye+X4GkvqzBUnPTkqn5IeO3YbgEfsBzOkBl0YYDAan8ehHLzYnqEZKWCZEQpuJqqN5rOk0c435o/Iv/c7rvDPNy8hzNhN0eJ2X1ijETd/UxMryXlRPOGpmklruTE3lf2QgLzW3HlOIIdE1JLcXYSn/t6Fxr82n3gP4VqRQ7HosDm+PjxkKGCrf5uWOLOEu+4vIP0nIbcRgZ/6yHp7njCOZOemW29XW+8YS+9ATyPnlRAdWRNAHqgllmqPc40unihMTR/1lCn/0XqCcRY7+MC6uO05Ura+57GXDWvUP0Gy34VQrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvZsSYlvpGgthuEtuTfJdslChrLU6Bw10Fa/z/3eRlo=;
 b=3VGP8Smxy1xw3R0OKdIvet6sGbXZJydPqNpgc1XzU3gvcqUNXWaESDJxnJxhp+WWlpZuw2jn/dB5RxCPhzxgbUJpklh6sf/gM0XcaosFn2/QEj6DtUrq3nkMIoPEg4nzAlV593B7JLYkEWMbAZ9fDrOPk42YIqr3VFYUtTCzNAM=
Received: from DM5PR20CA0012.namprd20.prod.outlook.com (2603:10b6:3:93::22) by
 CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.19; Wed, 9 Mar 2022 17:58:23 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::c3) by DM5PR20CA0012.outlook.office365.com
 (2603:10b6:3:93::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29 via Frontend
 Transport; Wed, 9 Mar 2022 17:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 17:58:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 11:58:19 -0600
To: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
 <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
 <tglx@linutronix.de>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
 <will@kernel.org>, <iommu@lists.linux-foundation.org>, <robin.murphy@arm.com>
Subject: [PATCH v2 1/2] Documentation: x86: Add documenation for AMD IOMMU
Date: Wed, 9 Mar 2022 12:58:04 -0500
Message-ID: <20220309175805.1298503-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8793688-748d-46ec-9908-08da01f66727
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1285D3AC15D24BC27F4961B3F70A9@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYz0V7siruAQ8BxGCfv8X3oYruBtnsWLBOnMfIQxHey5cOQBEp/Gvz+HpJ7HlSpbJeFZvpqF/sSUZoR48ZcyEZttoj5GbR79DJADCmivhHMA66NbRwskcDnY3F0mMHKae4Oz8VCJqQ2RQ3k1d4zk5FbYa05gqx7yBViktVXFosiEC6XTji321rNny+mTOzeQBoOzRi5D/qabhGMMRTFY0b0G3Re/YW0HzLQ7I5e9R+CSZPkNw1YBFRlOOiFL94rHacda1mz0/fSSbYk3nZZO0t8G2SRSOfNwGmXi99hqDW7c6mndCh9n9ribUccrbiO8owiNaCMUHXSftZa19h43Konjxe6oONO+swqwlQtiYul/WoKlix3x/7Eq17bfdbh/CeH9Ba+hYW3cYUcqIyhvfOSJqdfg/L+REgN+TjUBpogvClOyTzZbJt8Fd0/WGTtj/zw7XiEoLv3aIXcRaQmhaxPIYL5ZnJqdU5R5GeaGVQPFvL3UC0gIRIF8LzVVbeHm/9As3Vuz7oM/YBIKaO+lBxmcdj/p63lGKgFz0joj8LaD7MLhI8DQZ3j6gO95QhnOVnJqI2KSYZBL6cnxW81tmhkqTYL4qrUcDUDrce0L+QS3GAm4x6AJya67Qp7TChEKtFZjOKy1C/hRrAFh/lp3B3FrciSxEB19ZtXoidJ2jZCJvEK9Qc+OIttfvjBF7UyJCWQvPwrbVtdrv3VLLYq+DoNGEvfh7laiQx7XlyBRhjRechqjZU5LwTOjqwPJXa6FzNlO4IDfZwfKjJmRfWedvi0355fU2RqK0pg43vMchE6pwm288HZSX7Y8eZGSW54u
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(40460700003)(426003)(110136005)(47076005)(6666004)(70586007)(70206006)(36860700001)(36756003)(4326008)(8676002)(7696005)(2616005)(1076003)(86362001)(16526019)(5660300002)(7416002)(82310400004)(2906002)(508600001)(83380400001)(921005)(8936002)(81166007)(356005)(186003)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 17:58:22.9483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8793688-748d-46ec-9908-08da01f66727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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

Add preliminary documenation for AMD IOMMU.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

V2: incorporate feedback from Robin to clarify IOMMU vs DMA engine (e.g.,
    a device) and document proper DMA API.  Also correct the fact that
    the AMD IOMMU is not limited to managing PCI devices.

 Documentation/x86/amd-iommu.rst   | 69 +++++++++++++++++++++++++++++++
 Documentation/x86/index.rst       |  1 +
 Documentation/x86/intel-iommu.rst |  2 +-
 3 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/x86/amd-iommu.rst

diff --git a/Documentation/x86/amd-iommu.rst b/Documentation/x86/amd-iommu.rst
new file mode 100644
index 000000000000..6ecc4bc8c70d
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
+reason and device that caused it with fault reason is printed on console.
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
