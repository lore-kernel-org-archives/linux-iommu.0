Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5387FC433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 17:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E30BF812C8;
	Mon, 28 Mar 2022 17:28:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D7s_nyI49v7z; Mon, 28 Mar 2022 17:28:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D103780D8A;
	Mon, 28 Mar 2022 17:28:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2519C001D;
	Mon, 28 Mar 2022 17:28:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F433C0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B69E40907
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:28:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mcr8EwqRyXRO for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 17:28:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::605])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1483040147
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn+hEelpX45pwWerAEETcDfAERcjDWhyrmymAxbEQtkZ08PLvq07jA0e1++oHKDsdO2waZW4Ppjyjk8324qOeo44KCJiNkABwGcusqH9XvbgEXJVYnd4YwM1pBMtyKO+Oyu13ulIGRoUqfHmx7DNplmgjHIKihwhpyzD9tuHFn8p1DK6q10MmBSye2YuGZIaSv855PCsFN/IgkEXnQZp3ymA6+WykumDl7YGnA2ZLPVao2czm+roRq1k1oc60157iEJZCZrNhKcxAtwwAkExS7sz6wC0hQbOEah8KDpWkqOiwylG52V5dJmUY0+AG6VR6SV/M6tLEPrudUPMlnEyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQPj50rciPaPQPIyTRgZvr8KCtgIs//AyIn+iR6C4j8=;
 b=blX94PvnzioxttrWViVg35Y11fJ4u6mU1CwjoTsAuJqnu20QyWJKdS+0xlYKMcOb36CDZZfjoaLkBY9PJzLnaboHRiA5ZSGryKlw28wj/emU8BlYr6DAwMFtYRezkdYICUyYNv8fR3WCTctKf+4H+nao2k657pRHWRUSOqo4G311YrltGUyZdjRIupAtHIsxLSQMubTtbu/as2bvvmjToG9vHu1KpzvoPlHyrUcqsk3L5xCQqLcKZLhlC2UgZDeeYOo2cH8YfSWn3aDNCDDOxE/Nuf27jFe9mWFEkhBQSj5qNIcTm9eTfTja2W0gr9r1RgMLraA1vhZxKypB33i01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQPj50rciPaPQPIyTRgZvr8KCtgIs//AyIn+iR6C4j8=;
 b=GM/hJ6IH0bGFiSJ4/w2AeSFHEHB9KavkNnlrURdLix2TpV1LxcNnikaluD7Dzx+A25+n7++Ya+klEn4uh2+w2vJmkVyLGktxKoLv+pOcTwfbzifzHJdw7Y9/zy8bnPozChrMt4C/TMvuEloJGyovxeilDJfaAzXXmu4PDCTIjE4=
Received: from BN9P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::20)
 by MWHPR12MB1293.namprd12.prod.outlook.com (2603:10b6:300:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 17:28:46 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::5b) by BN9P221CA0015.outlook.office365.com
 (2603:10b6:408:10a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Mon, 28 Mar 2022 17:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 17:28:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 12:28:43 -0500
To: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
 <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
 <tglx@linutronix.de>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
 <will@kernel.org>, <iommu@lists.linux-foundation.org>,
 <robin.murphy@arm.com>, <vasant.hegde@amd.com>
Subject: [PATCH V3 0/2] x86 IOMMU Documentation updates
Date: Mon, 28 Mar 2022 13:28:27 -0400
Message-ID: <20220328172829.718235-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d841889-5488-44c2-15df-08da10e0698f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1293:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1293A2EA389C671D0CBDBA35F71D9@MWHPR12MB1293.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKMJ0V3HsYZSIJUOugiwQNGyymrx4uD9z99IRijPOtgpb3pbrka/Oz8tvStmpzWKfl78dun2cfxB/7luPNL/HRRuVLVZoqjXEk0+gDMycbNZNNqyOg3v2MvtvcvaUHQbGoZOvubooLGsCCTtaXk5mZo4q75jKRmwu0KfwTbXLpp9En1Ho62DOfwwB1uHvSLtHbwQL/nQEYJioQYVrWm8zyhBheycdstcno5q/zg8GpnpvHOjhufs39PDuBVzkj3kvdLFkJ3K4xeCtLzDn0Z0isUPeajUwUwJoYHzOUQ8t+aaHdiDt8nJHUz0z6EglFej/5aedQYpfyh6AjJNx8nVEw4d6KpVOq5hcgZPs6jE4H0O9QzqEcR1uccBge566HLyI2DnphricRvLw0nMlt3MQp3ux/lSNawTFQgL6QyvqWoB4y0Ui8Cwoyq0QeqY3GIgKwYCTo1WbxWW02BW7Hb7mObHkHq5EL2X9/vKKbtfTxNX8supkO1+nsBP7hO/Pg9YP+fp4axbwPr1g/UsW+p5CxnKx0orOMid68vf4ZGz2vd853pDnUmc6M5Axr7tCaaNuoNlYJ3UE2bQvKW9wLB0XnRP8vE++ulRjzq70L9O+c2AKuxgry4hvL8bsbHJvzlSsWChfpAi5DS+Sf8TVWH+fxfcpL87GdPmF38kRmAWd1QgTumXCIrnpRDHmweDxIrTpykY4H0tvFVztgSofEFqSjKUihK9t0Xc6ZWOCRafqm0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(4326008)(7416002)(47076005)(36860700001)(81166007)(70206006)(70586007)(356005)(8676002)(1076003)(36756003)(921005)(5660300002)(110136005)(316002)(83380400001)(2616005)(82310400004)(15650500001)(2906002)(40460700003)(26005)(186003)(16526019)(4744005)(6636002)(336012)(7696005)(6666004)(508600001)(86362001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:28:45.4956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d841889-5488-44c2-15df-08da10e0698f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1293
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

This was originally just a patch to add an AMD IOMMU
documentation page, but grew into some cleanup of the
Intel IOMMU documentation page.

v2: AMD documentation rework
    Add Intel Updates
v3: Further documentation reworks

Alex Deucher (2):
  Documentation: x86: Add documentation for AMD IOMMU
  Documentation: x86: Clarify Intel IOMMU documentation

 Documentation/x86/amd-iommu.rst   | 69 +++++++++++++++++++++++++++++++
 Documentation/x86/index.rst       |  1 +
 Documentation/x86/intel-iommu.rst | 13 +++---
 3 files changed, 76 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/x86/amd-iommu.rst

-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
