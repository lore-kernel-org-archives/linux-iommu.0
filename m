Return-Path: <SRS0=xpAE=N6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9500CC4167E
	for <iommu@archiver.kernel.org>; Wed,  8 Sep 2021 22:59:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4E461090
	for <iommu@archiver.kernel.org>; Wed,  8 Sep 2021 22:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B4E461090
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3854B80D6F;
	Wed,  8 Sep 2021 22:59:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jFDhkJgQbFRD; Wed,  8 Sep 2021 22:59:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F1A5580D84;
	Wed,  8 Sep 2021 22:59:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC026C0011;
	Wed,  8 Sep 2021 22:59:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 182BAC000D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Sep 2021 22:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05BB540364
 for <iommu@lists.linux-foundation.org>; Wed,  8 Sep 2021 22:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FqWNft0EaxNc for <iommu@lists.linux-foundation.org>;
 Wed,  8 Sep 2021 22:59:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::603])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3D1D401BA
 for <iommu@lists.linux-foundation.org>; Wed,  8 Sep 2021 22:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4nRibuF58rgCsJfRBv76wF4EI1MUP4dUgDnD6U9Fi1ILZxB5fHN00GPTRm74yr78FkU4vNFrp8IipJq7gPWK1Mc5uAjbfFntFTgAWl/XDoEx44bdx+U7ITM7dy5NKzT0L4XP7Et1U9S5kObXxBEAyfO2HCGK2KVsdTCwcln8JTgTM0pAyJF7waa+SKUcqlLEMYhhjLk/DRmG8z7O35BWyEMjOU++9cyiWn1uFsLENCKQOR3czjUYFAk6nRkgnt3MSgxBnDxpGzzY7K+oh+iRbH7CwNmbLnZpVlamJhaKbfh0vwKzZWi6VgfVOVfXFsuawFM+U80C/ew0fZ6UiI74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SHft1xeMLhkBPYDzYQt8LaIvbeLOAmhTGlhraPgkBIY=;
 b=dMvOs05b7NiYSMsx5eSUd4Jplx+iQEq1Ysz5wQBGCAFjEFbYk1Rviut7sk+2X9bdEPWG4rVFZYiYIikurakc/lG/g7vAguTXuIB0ebisrFCXZtuzAtqtR1y5jrKMcL4QGk3Rl1di7bg2NEt/yOrcOF38KzeJY9B4b0M2MjSVTtRGSPTMQ8E64xxelr3hN9wX+ThsClOUHw5cMT/NfIM2bYhxzEOypRhr4ua740CCsskTr4zFbdvOFbC03UGRn50N/BrvLsT//L0o0TahznbdYItJh5ruH3yNPvBNEq7LhNj2wWFl6SS3IX0gdwGrCUUxCjJvTHtZPkXqgBXxkCXYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHft1xeMLhkBPYDzYQt8LaIvbeLOAmhTGlhraPgkBIY=;
 b=Gitot9eQ8Rj1LNdG4PgLOWNalhBn5T8ewnVfxRY9p+UfgN1j+//B6z9LQxgb9C5P/eMqwt+L++bYbtUW6RLI7tefHhe2PUpcSrpzZH0CwWZ/vzLm/oCRGUJsghqJ3xLbph70y1yPNrG6IUscx4qPoK3GUfYDAm+pFmNBmaYzXuQ=
Received: from DM6PR03CA0058.namprd03.prod.outlook.com (2603:10b6:5:100::35)
 by BN6PR12MB1332.namprd12.prod.outlook.com (2603:10b6:404:15::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 22:59:09 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::99) by DM6PR03CA0058.outlook.office365.com
 (2603:10b6:5:100::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 22:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:59:09 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 17:59:07 -0500
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>,
 <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <linux-graphics-maintainer@vmware.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <kexec@lists.infradead.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 2/8] mm: Introduce a function to check for confidential
 computing features
Date: Wed, 8 Sep 2021 17:58:33 -0500
Message-ID: <0a7618d54e7e954ee56c22ad1b94af2ffe69543a.1631141919.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1631141919.git.thomas.lendacky@amd.com>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66d45662-8a16-4741-b832-08d9731c4478
X-MS-TrafficTypeDiagnostic: BN6PR12MB1332:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1332CAF32444BF581BFFC56EECD49@BN6PR12MB1332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: me1ISZsQ9Q/ZTy9AcUK/cEFHVLwQh0tIjmGXIgWFCAEjrStdEI4h7+mBgZvBgqhiaqcwmzjwAgLd45ztzGxCQhw0QpNEHVIpiVGBFDMYiPc8yLs96/fcOuHR1nKE7Yf0GP11gvAuY36ozQrM6D9/BvcyyjoirO4ohYha5qDorqVSWEOL7Ez6r0lVVBUKIqc7FBP6YIh2sKVYnNNMgTQWxXkaXkS2paL6os2xvaIE9dXqFq/xElrkRB52vwJsLLNK2ILJbEv/1m0Qoo+UBgFLiTCcfrAzrmPiZwNMaVunb2K2bmhD2E67AyFWuuf1aXajoY+i794Gnfbxds3NmJVnnAe5TXyUMpB1gkk/3rq4hKkqjrF3HnV48cETGMHWJJ691VzxFPRihwMfkRTIDc4y7S07Yd2GVfIFn+9PoNiLbXftQKDzz/UbgenVpLoDVn6qnoLgjQTFgM2CXVAJ79qQ9xYhYuXf/5NuGqpBdcAXfI1liqKi5Zhq66BOeFpPIEe7FhuMfO3Wh08Sx3+ENPR1YIga4yKIPJX7yNIysySqpOwbV2bJJiCyalGTda/Py+quF0k9dPc7bxZna+rIjOLsVSt6JnGIl4P51c7vjoI1YA9TPybeKWVUi3/PwrauZfvf/GwBFsn1keq5WJEn/OFN7HnRzK7lunaNps6BlouTt+RHdVuJync/Qj/4HnpnQlbV10j9n0EiajL0SCvrq156q1Z9CkEzv9HrKij3oVmefBtzlNfhM76JuXVsMhaT46T3ini+znIj3Q0HZvU02R+cYHhZgbSXojT32L46c0KfuIw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(426003)(2616005)(478600001)(70586007)(921005)(36756003)(336012)(47076005)(4326008)(82740400003)(316002)(7416002)(54906003)(110136005)(8676002)(356005)(2906002)(81166007)(8936002)(7696005)(186003)(86362001)(5660300002)(36860700001)(82310400003)(26005)(6666004)(70206006)(16526019)(2101003)(83996005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:59:09.3747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d45662-8a16-4741-b832-08d9731c4478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1332
Cc: Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Christoph Hellwig <hch@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Brijesh Singh <brijesh.singh@amd.com>
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
From: Tom Lendacky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

In prep for other confidential computing technologies, introduce a generic
helper function, cc_platform_has(), that can be used to check for specific
active confidential computing attributes, like memory encryption. This is
intended to eliminate having to add multiple technology-specific checks to
the code (e.g. if (sev_active() || tdx_active())).

Co-developed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/Kconfig                |  3 ++
 include/linux/cc_platform.h | 88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 include/linux/cc_platform.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 3743174da870..ca7c359e5da8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1234,6 +1234,9 @@ config RELR
 config ARCH_HAS_MEM_ENCRYPT
 	bool
 
+config ARCH_HAS_CC_PLATFORM
+	bool
+
 config HAVE_SPARSE_SYSCALL_NR
        bool
        help
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
new file mode 100644
index 000000000000..253f3ea66cd8
--- /dev/null
+++ b/include/linux/cc_platform.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Confidential Computing Platform Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef _CC_PLATFORM_H
+#define _CC_PLATFORM_H
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+
+/**
+ * enum cc_attr - Confidential computing attributes
+ *
+ * These attributes represent confidential computing features that are
+ * currently active.
+ */
+enum cc_attr {
+	/**
+	 * @CC_ATTR_MEM_ENCRYPT: Memory encryption is active
+	 *
+	 * The platform/OS is running with active memory encryption. This
+	 * includes running either as a bare-metal system or a hypervisor
+	 * and actively using memory encryption or as a guest/virtual machine
+	 * and actively using memory encryption.
+	 *
+	 * Examples include SME, SEV and SEV-ES.
+	 */
+	CC_ATTR_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_HOST_MEM_ENCRYPT: Host memory encryption is active
+	 *
+	 * The platform/OS is running as a bare-metal system or a hypervisor
+	 * and actively using memory encryption.
+	 *
+	 * Examples include SME.
+	 */
+	CC_ATTR_HOST_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_GUEST_MEM_ENCRYPT: Guest memory encryption is active
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using memory encryption.
+	 *
+	 * Examples include SEV and SEV-ES.
+	 */
+	CC_ATTR_GUEST_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_GUEST_STATE_ENCRYPT: Guest state encryption is active
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using memory encryption and register state encryption.
+	 *
+	 * Examples include SEV-ES.
+	 */
+	CC_ATTR_GUEST_STATE_ENCRYPT,
+};
+
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+
+/**
+ * cc_platform_has() - Checks if the specified cc_attr attribute is active
+ * @attr: Confidential computing attribute to check
+ *
+ * The cc_platform_has() function will return an indicator as to whether the
+ * specified Confidential Computing attribute is currently active.
+ *
+ * Context: Any context
+ * Return:
+ * * TRUE  - Specified Confidential Computing attribute is active
+ * * FALSE - Specified Confidential Computing attribute is not active
+ */
+bool cc_platform_has(enum cc_attr attr);
+
+#else	/* !CONFIG_ARCH_HAS_CC_PLATFORM */
+
+static inline bool cc_platform_has(enum cc_attr attr) { return false; }
+
+#endif	/* CONFIG_ARCH_HAS_CC_PLATFORM */
+
+#endif	/* _CC_PLATFORM_H */
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
