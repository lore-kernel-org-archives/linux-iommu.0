Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D920307
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568583; cv=fail; b=iKFdifVn2PcfwwsuNux2pOlrXggBs07EnM8QVroPQYVgLIrd9gilqOkCPm/t4XeNea1LSWJaMTqlB2Kwaf0mlwlcMat8FwGY97SjJuO7mILfAtGSjgmCLdJ1Ycra9Z1kWBQ2rBWSB6/Kdau6zfVxyuBUeTS7SfTgVSzfZraRSK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568583; c=relaxed/simple;
	bh=XSb5exysWzE0aWW77+xhPp6K4kFqDyio4qG+41zMpyI=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=C3rS98IJLXnkpF2fuBsU2tr+JD/cVv1+iXUHRUrVLSEiklHHp9Y0xpVDWJDafMQgKAP5edeQv+MvianLHsgv6mjkt4uxLf/xR3tj0Rn1GfwiPKyOQwH4J54sx75DAi+SGY2jEucCRfFJYt8LAuJF0HJaHKv6CgqkkdfKeJjyv+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ve3moo8W; arc=fail smtp.client-ip=40.107.95.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ve3moo8W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tjre79FBlEPAYj4+Not8h4UUe9FKtCLiwAzyRe+1e+A8DDTy0yQ3rdfZZ6y6mp1WN79cUvdvc3E3PIAdlHmT9DlM6TgbAGHQWWTduGJ8T0m1epnwQ8p57K451aWsEINBleABGtOBI+OAYcKRT2w8TTcrdK0Kv2zGu4M+tchI1d1phg4R8F8rcvbXubRQdsYp9tIhSk5rV65cHZthnVPaMDCVpARwqHVp0LI6JBt+u0XYGE2h9AlbOwvoVJHRNIO7T7iuza3Uo512l3rFQT4Og8J70iiyTVWOKEsAPoGfGElPkbI+WzCLjFlJeWe4aTdETLdi4WpfGje7+KNUSJ3Igg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoUMABGpfmp40EIDLZ04ZLSxlJnRlT+huWzCxnOUNA4=;
 b=VxAM5xsbIZGiT5Qryb5k/bppiVuc3lZ/OwTrhAT2QnVnReJNe8BOVh4WItlbCXJkKyH2MejI2B2fGUCzsV5wdEK9ox/B+e43MD8ZNw+woZS2RtkaG1VwMVQCTKY9XtKzAh4MU3H3w/TuUGeWRJXrhHlJMZl1S5824xWy8bdZ476ZEonxJCHyKgYj4FpRplOiCIZAoCLLlah7AWHLQ14hVBv9N0O20nlDl9lH/3ut8IMJbMdzShjsPXV/OWYeOABrSH2VbwS9czVK/hDOaz8FrbDJnHILHGDMAMWs2fJluH4BJNSvTjJ7qqhcKVcBuvIrdWQZWGOtuQuR8Tq2Ktp/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoUMABGpfmp40EIDLZ04ZLSxlJnRlT+huWzCxnOUNA4=;
 b=ve3moo8WTNr8BW/BJdpFlbINGGpcwz/iotqYE22/LSBz11xKAfOr9LxDcMKhFPHEaBdatnpFGXfXVyLCbiMiMabSrtQT5cWOtSLQnItJCeDJvLkqiXvBXSxeNEZy+OFchcJmKEPmCiENG7TIKVrSc8A+7tN+3SSQC0lJEAEsYgM=
Received: from CH5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:610:1f4::21)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 09:02:58 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::b8) by CH5PR04CA0020.outlook.office365.com
 (2603:10b6:610:1f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 09:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 09:02:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 03:02:55 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Lu
 Baolu" <baolu.lu@linux.intel.com>
Subject: [PATCH 2/6] iommu/amd: Remove unused IOVA_* macro
Date: Thu, 18 Jan 2024 09:01:01 +0000
Message-ID: <20240118090105.5864-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118090105.5864-1-vasant.hegde@amd.com>
References: <20240118090105.5864-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SN7PR12MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 0723e877-a7d5-4f14-ee56-08dc1804445b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lN7TJ7FzmeF1HV6f4UcIaD8Xw69Rduc2hGCXZolaQgtl2IznSP5n8BjRBC7jhX+qTPpW+BWioGXGh/+HzIhp2gA5vIShcAKfNqng/4CR2IacaWRE8/yYwx6tQOtSH0M2+ohlprDIE7p6MU6v7GaZIbXO0CkMZthbKEpANEqThtznuHv4cybNGkpEIpaz1HY1EcufuIoigcUd542nNgdQFUje8BDJy/SelS3qPfdmW1Sm/x1820aRnzF8KTCziSwC2sOxix7y6Cev2IBXIzHsBVKtjSGzY4ZvJaDNJp9sHcxf7Tj1QjbF3ZhrA8X4sIODKD5w4AjOnKFcw+IBAP59pLU4DFEj7tsme2Mm9Nydx1409wWdjvT6PEShFvmQJeCdiIsGsKD3PoFffhJ/gPM0vlDAp25RIaNHFL+upMN/IvUMnNoAr0AllM3axraNXSbC/9JVCCS0llNG2KJBjwq/IqZ3qA68z2+x8Zl7wiEWQVuKXzJAGzbd0NnuyBw4dsoDOnSB968ohkNuTUHEJJs0uPJal6C/eWPIiAK4NMJ5OizLeial7XPD7uP/R3P2hFqrFkoaaser70Sy7iCAuzHS24ypli02gq8uHMD391Xobb01MgjTHcjt7ooFHDe0iBdneOPqZYtkKfp+R2ZyzrNKKnx0L1l0OXFv2Y63DbXlunGOS2E34yaSFjuBnwJFjxPS5fSsnX8GtQsf3FE1nw0X6yoTki0cjiWHfSJhecTSNAMrPuzC8js+QWfCMR4OwThyToDV2OR9KGpWMSwuln4UuQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(356005)(70586007)(70206006)(54906003)(8676002)(4326008)(8936002)(110136005)(478600001)(36860700001)(44832011)(81166007)(82740400003)(16526019)(2616005)(26005)(1076003)(316002)(86362001)(7696005)(83380400001)(6666004)(336012)(426003)(2906002)(5660300002)(40460700003)(40480700001)(36756003)(47076005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:02:58.4797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0723e877-a7d5-4f14-ee56-08dc1804445b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058

These macros are not used after commit ac6d704679d343 ("iommu/dma: Pass
address limit rather than size to iommu_setup_dma_ops()").

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
@Lu Baolu,
  We have similar unused macro (IOVA_START_PFN) in intel driver as well.
  If you want I can remove that macro as part of this series.

-Vasant

 drivers/iommu/amd/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4280d97fa6ba..6bb4f2dc5194 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -45,10 +45,6 @@
 
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
-/* IO virtual address start page frame number */
-#define IOVA_START_PFN		(1)
-#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-
 /* Reserved IOVA ranges */
 #define MSI_RANGE_START		(0xfee00000)
 #define MSI_RANGE_END		(0xfeefffff)
-- 
2.31.1

