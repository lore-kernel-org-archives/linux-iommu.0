Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959AFC43217
	for <iommu@archiver.kernel.org>; Wed,  9 Mar 2022 17:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F4A040AF9;
	Wed,  9 Mar 2022 17:59:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C0jKdSJBCF9b; Wed,  9 Mar 2022 17:58:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BB5DE40232;
	Wed,  9 Mar 2022 17:58:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90744C0012;
	Wed,  9 Mar 2022 17:58:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71486C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 17:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 600AB813FF
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 17:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LEb8VUHr1BW3 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 17:58:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::613])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B206680AE6
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 17:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TptIv0yUKmOVsYvJIhQv//l7C12fN8wePJYPzkhGbLWkmgbAweNx0Oko08ydF5FRpZizeP8p6FUJ+xZHYfVPnRswFc7kBSiMEJQwNtlC2uUz/ZJZ8YPhzZA59rLJ0r3NGj3r4D1802T9pEi908SrSZq3bot34adzZKiVqmtusC18EYRXfTJP64dCYcD9QnRbbXetA3dozlsmZOIB/u/+kLHC/64BYZJlhWV7Pr7TFDn2z7YGo1eKt1BboGWsxu0D9V7S/iU0n9QLnoA/an3oiyPglCOrTrmaRqPbq2GIq/P1cIqp3wuwQquGY0TaJMUA+i436RTfv+l0JXM//vEOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjRPfGccae/SCO21pZD78EY6CcSgw8S9OV3B853pBm0=;
 b=mOzOpKQZIwj6QPxgbAJfUGGgiZ6UIuACQtEeavNCUc+zNEOgFNMPDB8NujpRA0oSO6QtX9NhTn+LNf2F6EAJEqsslYS1jnYQM7avXjcQ9aDxrZkTq6MW+NHsBye7AE7PF6R0JS7BsmHQGES4jfJqQ+N7TsAShfCnVwNDwdX6H7yoH9n5ONujVHE5g0R4c/KbWnJ2GT0Uy36RiPc94nGvyv1ywmjrPw8R+Ho+oWJTsWma7fTyeIpmgrG728D1AEfLhrJ0oH27WNCokQuNQuQytKXFPPnX7cJhIJmROUEzP/fFHX2A8uj0JQ+mt7rixQXCy71P+e8qvTtNBLFDUDo+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjRPfGccae/SCO21pZD78EY6CcSgw8S9OV3B853pBm0=;
 b=LoJ9yhT+590bgBJU9RnbLoQOFuQRwzEBXPypjCkKbwwe5W6FHHpbheO/w3BMYeS+JhmjYpe5MoMt32Tj6G+St9UMpG56ihC33cNAWV4YPWdT/hk3zB1MK14OKjYlwmWF9MClD97cqCZv8221/HRJeXd/QueiHPzcgGjTA62cWbE=
Received: from DM5PR20CA0020.namprd20.prod.outlook.com (2603:10b6:3:93::30) by
 MWHPR12MB1694.namprd12.prod.outlook.com (2603:10b6:301:11::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 17:58:24 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::b3) by DM5PR20CA0020.outlook.office365.com
 (2603:10b6:3:93::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 17:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 17:58:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 11:58:20 -0600
To: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
 <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
 <tglx@linutronix.de>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
 <will@kernel.org>, <iommu@lists.linux-foundation.org>, <robin.murphy@arm.com>
Subject: [PATCH 2/2] Documentation: x86: Clarify Intel IOMMU documenation
Date: Wed, 9 Mar 2022 12:58:05 -0500
Message-ID: <20220309175805.1298503-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309175805.1298503-1-alexander.deucher@amd.com>
References: <20220309175805.1298503-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac905de1-f8e1-47b0-07fa-08da01f6679a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1694:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16944A6E46288A0F3B1AB921F70A9@MWHPR12MB1694.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fvUd24HY5pwqhPuIOWl1OVtU5oX7VkLCAHGOzvT244HZWW2RkZAre0Kp2BQvcLjbxSYNzsDz1784GVHHT7+8sKJKJ7L2FZoiAv6AaTKna1GiUrhePRF3A87jqeIIRhrjJkcMcHAint9IYHDPThUoAYAkhBHzdWK2XmJYXGcZyk5Jwl56Y1ZWo+nM7H/83WtcdmwALT/ooL9fbkNU8Q7YBXO4PT2AZXoI8iJH9JRRg7MDdmYh3np4gU8N6va3dZdVj9QvSvBvSn970r4xTZNAWBFdl8K82Lcsh8ALcDBA+oAITwGtDMFvYmilTLxhvqzzH5JhUW0JuvB5jKWoe0g/DhaUmhuIkIi9MkhnmkYRZm/XHss0u32WIIRGemSwINzWae42dPuvzs4tTHOOYddnaYWOWGAdbL82yr5Z0ZyF7DF/dDfEV67IP/e6GVAtLixt113MWR4vFkhUi9tGPXSSFhfVYlSiXuEMxCvRjdYnHiWYVcrRkwXVI8ouYn/dusuoSVHltHbFRFKLAjRZ3bcQwkN3jEsL8DaafWwhDAC9NDBp48+4KYLu7XPQEZww9i2MbR0G7qoWupjZb04Ysg4oVL/V7hAO4x6Ez+wJy20qyIkQNBjFlxwb5F5BS9qxHZSqAjkTf7hnaaGoq1rGn1uMMpYWUa5Dj5e1Qii96uVJzXN2evS0qT2vgskaKc78+rkPVzcjmB5zgivvyjzahqPheQQzdI5F3BF91BlGK/Q8GU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(921005)(8676002)(70586007)(70206006)(86362001)(4326008)(82310400004)(7416002)(83380400001)(40460700003)(2906002)(356005)(16526019)(426003)(81166007)(36860700001)(8936002)(2616005)(1076003)(6666004)(186003)(336012)(36756003)(26005)(7696005)(316002)(110136005)(508600001)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 17:58:23.7139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac905de1-f8e1-47b0-07fa-08da01f6679a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1694
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
 Documentation/x86/intel-iommu.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
index 4d3391c7bd3f..22e1934a1335 100644
--- a/Documentation/x86/intel-iommu.rst
+++ b/Documentation/x86/intel-iommu.rst
@@ -19,8 +19,8 @@ Some Keywords
 Basic stuff
 -----------
 
-ACPI enumerates and lists the different DMA engines in the platform, and
-device scope relationships between PCI devices and which DMA engine  controls
+ACPI enumerates and lists the different IOMMUs in the platform, and
+device scope relationships between PCI devices and which IOMMU controls
 them.
 
 What is RMRR?
@@ -36,9 +36,9 @@ unity mappings for these regions for these devices to access these regions.
 How is IOVA generated?
 ----------------------
 
-Well behaved drivers call pci_map_*() calls before sending command to device
+Well behaved drivers call dma_map_*() calls before sending command to device
 that needs to perform DMA. Once DMA is completed and mapping is no longer
-required, device performs a pci_unmap_*() calls to unmap the region.
+required, device performs a dma_unmap_*() calls to unmap the region.
 
 The Intel IOMMU driver allocates a virtual address per domain. Each PCIE
 device has its own domain (hence protection). Devices under p2p bridges
@@ -68,7 +68,7 @@ address from PCI MMIO ranges so they are not allocated for IOVA addresses.
 
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
