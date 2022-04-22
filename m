Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBD3C433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 17:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF00683E11;
	Fri, 22 Apr 2022 17:54:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfLQWz8S9acp; Fri, 22 Apr 2022 17:54:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3C5F2831AE;
	Fri, 22 Apr 2022 17:54:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13DB8C0032;
	Fri, 22 Apr 2022 17:54:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3DD4C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 17:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A14A0405C2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 17:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7rHana-KUvPq for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 17:54:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::616])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8A9C400BA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 17:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPB4HBk9kn5yA0Y1xmP+1RaKAvY4coddHVtjyIroxZj2vDh+S3X/UBBIDBFrA1OrSbtpzqEH52rx3ig0W0RCOMUwk4G2Br23J6OniWQwTgK7C+je6YaXeEp2cVTNFaRifRaNYziKYqdsEpf4EK7zrPB011yLec662LILKpG8AQ/YyTFlycX8o5VCU6YfD7ljPbBZt798HKTcQRUKWPSHP5PzZjrOCtlHdh/IAFPFqI67EA/2mWJ7O6T5sxmv9IwhramvOHH7lnhFaAH4aEWd3tuOgViQ485+6JOmCrQoSG5dzoQhu5tmk6QI4xeW1Fk7rXZZ0/CnUdpODGR5SdJNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQR4MwZihrA3rdZhDY4Q5Hchh1G9Vrj1c6qGMZypLwM=;
 b=ZkQo2DaQ9IKOKq2E2uwKOjH3IX0q9CmyfAMo6rdR1ts/H5wHMaWZ8xI1gi5zMj7cL3zNxkpc56j/a+pJt1wpLH6ezeQz6nfL0CiTAYFCeRIQ4JU/s6lcwsNtFzbz6RrS70N3k6p+KGYvz/rHFcQNwQs2UbXWA70J0aUPwG/TUT+baJZVVUbhkuWTB71KGUIHPypdn7nqPs18U1VV5lhgGVoDpozROTr99KfkJTlbgEJpG2FVoR5hSIWIUnYfpArjt/tjyI8NTncQAn9LDxwVs/ITRPy8zdmegSTmuWCdL5jWJGtcAglYs+MbIRQ+HNwRuBoWm3DEd19VzK6P1xTq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQR4MwZihrA3rdZhDY4Q5Hchh1G9Vrj1c6qGMZypLwM=;
 b=fAQpN3lmlLh6b+zgtyac9XeGuL7JWI6+wWM2du0BNH3+C8S/phQr0mQTtQ/Cb6vlLdHCC3DfkPSELViOgk208Zk2DkjQLoPBjZhm5ORLuIvh/JlrRO0qiFzbPJ/vBc1fVnS0PNrWF+O+1n24eKELygX218AlNpwvDK2h9U82qHg=
Received: from BN0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:408:e4::7)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 17:54:41 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::b4) by BN0PR02CA0002.outlook.office365.com
 (2603:10b6:408:e4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 17:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 17:54:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 12:54:38 -0500
To: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
 <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
 <tglx@linutronix.de>, <joro@8bytes.org>, <Suravee.Suthikulpanit@amd.com>,
 <will@kernel.org>, <iommu@lists.linux-foundation.org>,
 <robin.murphy@arm.com>, <Vasant.Hegde@amd.com>
Subject: [PATCH v4] Documentation: x86: rework IOMMU documentation
Date: Fri, 22 Apr 2022 13:54:23 -0400
Message-ID: <20220422175423.44491-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a85a8ca9-e774-4468-7f29-08da24892cc2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4247:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4247CC91EC03AA32D58DDA4AF7F79@CH2PR12MB4247.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVNs7BA6IiGoUjJOe6L8HY0Lb7cTsOVINmcW4ZQ1ZRZw7XJOOC97vAw5S7E3RNNRK6LxH3Dobwrfi8MgfAPRb8+JwsDkpI5Qd3C7HjhUJBW3q3s8kOdwEfhoFEKN0H17u9OZThtCaewIL81FJEoYpXMqigJMDSBJ9Vj/EyBYXMpxCdNbRmgQufbhw1EyyTcD19i+13lLfQFrukjOY5rOsm5WVd9E4S7IKCMHF6lEeDAkMjrY4cbRSumDLewXkcOi3vxDYrygojkyBpT6deIrCm+sGRD/5cFw00f12B3daHbGJ7i8Mq9/KUmL0aymyrsRcsJVcifg6KhpvT17XbMUlPuXQDK57QpDraewEo+Fx2ip3Awx96v5nHdvoXth7T6ONNu8sW4I9dRSnpegPcxa0SbQEBTwGewYUls4dYOCPNyJlepRMS2CQGAFtO3860f5f5qwOxdxkEFCrhPDTM9tzw+UyFW/tMa33ZOoJPV8BPV1ewotP+MJH4OoYRIlJkvdvdiOwmD4tiq6uB6bt7q98UceBMjp3r0P7vWzwhheK9Wak0ipyW/QzMr16iSaKtje1MwWut+jI9xKgBMoM/c+eR4ag11e4BwPpAZiwU4zYNb71ELcwgTSxkwtLGzGjOidWu8EEp+42XMfkZ0axUSTwI2OHcGbWEqE3XMliV5/eQECoxtPhfZL5k7jhqxnnVkJwuYzZbKl1bRKiDFh7HiniKXC/1PeYf5xx5JijUUEKMeiXIeQ4mll4899pcczBoTzkRx81QzKjM7Esn+6mnyFkkoS50f6pgKdECDgFauYIFHKS1pO2yOIx9VWHNJeICcTQelYBFcOryqFPncAVvObM82ei7Z57SsUmIG5n66ieUo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(70586007)(186003)(426003)(336012)(47076005)(16526019)(7416002)(6636002)(40460700003)(2616005)(1076003)(36756003)(26005)(83380400001)(7696005)(82310400005)(110136005)(81166007)(4326008)(8676002)(356005)(921005)(36860700001)(86362001)(2906002)(6666004)(30864003)(316002)(8936002)(5660300002)(508600001)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 17:54:40.5628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a85a8ca9-e774-4468-7f29-08da24892cc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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

Add preliminary documentation for AMD IOMMU and combine
with the existing Intel IOMMU documentation and clean
up and modernize some of the existing documentation to
align with the current state of the kernel.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

V2: Incorporate feedback from Robin to clarify IOMMU vs DMA engine (e.g.,
    a device) and document proper DMA API.  Also correct the fact that
    the AMD IOMMU is not limited to managing PCI devices.
v3: Fix spelling and rework text as suggested by Vasant
v4: Combine Intel and AMD documents into a single document as suggested
    by Dave Hansen

 Documentation/x86/index.rst       |   2 +-
 Documentation/x86/intel-iommu.rst | 115 ----------------------
 Documentation/x86/iommu.rst       | 153 ++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+), 116 deletions(-)
 delete mode 100644 Documentation/x86/intel-iommu.rst
 create mode 100644 Documentation/x86/iommu.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f498f1d36cd3..6f8409fe0674 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -21,7 +21,7 @@ x86-specific Documentation
    tlb
    mtrr
    pat
-   intel-iommu
+   iommu
    intel_txt
    amd-memory-encryption
    pti
diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
deleted file mode 100644
index 099f13d51d5f..000000000000
--- a/Documentation/x86/intel-iommu.rst
+++ /dev/null
@@ -1,115 +0,0 @@
-===================
-Linux IOMMU Support
-===================
-
-The architecture spec can be obtained from the below location.
-
-http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
-
-This guide gives a quick cheat sheet for some basic understanding.
-
-Some Keywords
-
-- DMAR - DMA remapping
-- DRHD - DMA Remapping Hardware Unit Definition
-- RMRR - Reserved memory Region Reporting Structure
-- ZLR  - Zero length reads from PCI devices
-- IOVA - IO Virtual address.
-
-Basic stuff
------------
-
-ACPI enumerates and lists the different DMA engines in the platform, and
-device scope relationships between PCI devices and which DMA engine  controls
-them.
-
-What is RMRR?
--------------
-
-There are some devices the BIOS controls, for e.g USB devices to perform
-PS2 emulation. The regions of memory used for these devices are marked
-reserved in the e820 map. When we turn on DMA translation, DMA to those
-regions will fail. Hence BIOS uses RMRR to specify these regions along with
-devices that need to access these regions. OS is expected to setup
-unity mappings for these regions for these devices to access these regions.
-
-How is IOVA generated?
-----------------------
-
-Well behaved drivers call pci_map_*() calls before sending command to device
-that needs to perform DMA. Once DMA is completed and mapping is no longer
-required, device performs a pci_unmap_*() calls to unmap the region.
-
-The Intel IOMMU driver allocates a virtual address per domain. Each PCIE
-device has its own domain (hence protection). Devices under p2p bridges
-share the virtual address with all devices under the p2p bridge due to
-transaction id aliasing for p2p bridges.
-
-IOVA generation is pretty generic. We used the same technique as vmalloc()
-but these are not global address spaces, but separate for each domain.
-Different DMA engines may support different number of domains.
-
-We also allocate guard pages with each mapping, so we can attempt to catch
-any overflow that might happen.
-
-
-Graphics Problems?
-------------------
-If you encounter issues with graphics devices, you can try adding
-option intel_iommu=igfx_off to turn off the integrated graphics engine.
-If this fixes anything, please ensure you file a bug reporting the problem.
-
-Some exceptions to IOVA
------------------------
-Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
-The same is true for peer to peer transactions. Hence we reserve the
-address from PCI MMIO ranges so they are not allocated for IOVA addresses.
-
-
-Fault reporting
----------------
-When errors are reported, the DMA engine signals via an interrupt. The fault
-reason and device that caused it with fault reason is printed on console.
-
-See below for sample.
-
-
-Boot Message Sample
--------------------
-
-Something like this gets printed indicating presence of DMAR tables
-in ACPI.
-
-ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @ 0x000000007f5b5ef0
-
-When DMAR is being processed and initialized by ACPI, prints DMAR locations
-and any RMRR's processed::
-
-	ACPI DMAR:Host address width 36
-	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
-	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
-	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
-	ACPI DMAR:RMRR base: 0x00000000000ed000 end: 0x00000000000effff
-	ACPI DMAR:RMRR base: 0x000000007f600000 end: 0x000000007fffffff
-
-When DMAR is enabled for use, you will notice..
-
-PCI-DMA: Using DMAR IOMMU
--------------------------
-
-Fault reporting
-^^^^^^^^^^^^^^^
-
-::
-
-	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
-	DMAR:[fault reason 05] PTE Write access is not set
-	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
-	DMAR:[fault reason 05] PTE Write access is not set
-
-TBD
-----
-
-- For compatibility testing, could use unity map domain for all devices, just
-  provide a 1-1 for all useful memory under a single domain for all devices.
-- API for paravirt ops for abstracting functionality for VMM folks.
diff --git a/Documentation/x86/iommu.rst b/Documentation/x86/iommu.rst
new file mode 100644
index 000000000000..d51fd8f89382
--- /dev/null
+++ b/Documentation/x86/iommu.rst
@@ -0,0 +1,153 @@
+=================
+x86 IOMMU Support
+=================
+
+The architecture specs can be obtained from the below locations.
+
+- Intel: http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
+- AMD: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
+
+This guide gives a quick cheat sheet for some basic understanding.
+
+Some Keywords
+
+- DMAR - Intel DMA remapping
+- DRHD - Intel DMA Remapping Hardware Unit Definition
+- RMRR - Intel Reserved Memory Region Reporting Structure
+- IVRS - AMD I/O Virtualization Reporting Structure
+- IVDB - AMD I/O Virtualization Definition Block
+- IVHD - AMD I/O Virtualization Hardware Definition
+- IOVA - I/O Virtual Address
+- ZLR  - Zero length reads from PCI devices
+
+Basic stuff
+-----------
+
+ACPI enumerates and lists the different IOMMUs on the platform, and
+device scope relationships between devices and which IOMMU controls
+them.
+
+What is Intel RMRR?
+^^^^^^^^^^^^^^^^^^^
+
+There are some devices the BIOS controls, for e.g USB devices to perform
+PS2 emulation. The regions of memory used for these devices are marked
+reserved in the e820 map. When we turn on DMA translation, DMA to those
+regions will fail. Hence BIOS uses RMRR to specify these regions along with
+devices that need to access these regions. OS is expected to setup
+unity mappings for these regions for these devices to access these regions.
+
+What is AMD IVRS?
+^^^^^^^^^^^^^^^^^
+
+The architecture defines an ACPI-compatible data structure called an I/O
+Virtualization Reporting Structure (IVRS) that is used to convey information
+related to I/O virtualization to system software.  The IVRS describes the
+configuration and capabilities of the IOMMUs contained in the platform as
+well as information about the devices that each IOMMU virtualizes.
+
+The IVRS provides information about the following:
+
+- IOMMUs present in the platform including their capabilities and proper configuration
+- System I/O topology relevant to each IOMMU
+- Peripheral devices that cannot be otherwise enumerated
+- Memory regions used by SMI/SMM, platform firmware, and platform hardware. These are generally exclusion ranges to be configured by system software.
+
+How is an IOVA generated?
+-------------------------
+
+Well behaved drivers call dma_map_*() calls before sending command to device
+that needs to perform DMA. Once DMA is completed and mapping is no longer
+required, driver performs dma_unmap_*() calls to unmap the region.
+
+Intel Specific Notes
+--------------------
+
+Graphics Problems?
+^^^^^^^^^^^^^^^^^^
+
+If you encounter issues with graphics devices, you can try adding
+option intel_iommu=igfx_off to turn off the integrated graphics engine.
+If this fixes anything, please ensure you file a bug reporting the problem.
+
+Some exceptions to IOVA
+^^^^^^^^^^^^^^^^^^^^^^^
+
+Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
+The same is true for peer to peer transactions. Hence we reserve the
+address from PCI MMIO ranges so they are not allocated for IOVA addresses.
+
+AMD Specific Notes
+------------------
+
+Graphics Problems?
+^^^^^^^^^^^^^^^^^^
+
+If you encounter issues with integrated graphics devices, you can try adding
+option iommu=pt to the kernel command line use a 1:1 mapping for the IOMMU.  If
+this fixes anything, please ensure you file a bug reporting the problem.
+
+Fault reporting
+---------------
+When errors are reported, the IOMMU signals via an interrupt. The fault
+reason and device that caused it is printed on the console.
+
+
+Kernel Log Samples
+------------------
+
+Intel Boot Messages
+^^^^^^^^^^^^^^^^^^^
+
+Something like this gets printed indicating presence of DMAR tables
+in ACPI.
+
+::
+
+	ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @ 0x000000007f5b5ef0
+
+When DMAR is being processed and initialized by ACPI, prints DMAR locations
+and any RMRR's processed
+
+::
+
+	ACPI DMAR:Host address width 36
+	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
+	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
+	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
+	ACPI DMAR:RMRR base: 0x00000000000ed000 end: 0x00000000000effff
+	ACPI DMAR:RMRR base: 0x000000007f600000 end: 0x000000007fffffff
+
+When DMAR is enabled for use, you will notice
+
+::
+
+	PCI-DMA: Using DMAR IOMMU
+
+Intel Fault reporting
+^^^^^^^^^^^^^^^^^^^^^
+
+::
+
+	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
+	DMAR:[fault reason 05] PTE Write access is not set
+	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
+	DMAR:[fault reason 05] PTE Write access is not set
+
+AMD Boot Messages
+^^^^^^^^^^^^^^^^^
+
+Something like this gets printed indicating presence of the IOMMU.
+
+::
+
+	iommu: Default domain type: Translated
+	iommu: DMA domain TLB invalidation policy: lazy mode
+
+AMD Fault reporting
+^^^^^^^^^^^^^^^^^^^
+
+::
+
+	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007 address=0xffffc02000 flags=0x0000]
+	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007 address=0xffffc02000 flags=0x0000]
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
