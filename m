Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85452E285C
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 04:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421372; cv=fail; b=TADSs7C0Xy+bMvk9dyeqpHvO0h7gNhDhT3nnrG970rtu5GcaK5kGW79VODBK2Yc2Wpq59EeXl6I6sfM4lFylHVSGI27MFRgagIvWqKsuGd1LT3zjztK/88BI0J/Uoq9ucSSkJbjT809RFKXKavNhPNt9AI3IEntku+nBFnqwjVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421372; c=relaxed/simple;
	bh=B1xMGNOR4TrwCO0gZvXu700+v0s0y3B9xxbIOChutUY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SR0LNAyswcUH1GcPsFrTZjUNEtNqQsEil6Wu8YmbANlqXa/AgT1LmdKurTIuhcmtPV3D0/T1GsgjwyJawjF30Vza/EXvT+i47AwI1vK1xb+q7ZQnc9+PdqffLeewpxXCJanb+Vbq2NQLmO2fZXs+hmz8sed+Qa9Hc8BvJ0tXYvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TAV0erLE; arc=fail smtp.client-ip=40.107.200.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TAV0erLE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQ3uVekvfRfrxDacgbhopah7rm7J6wHKSnD0L10wMO+0obkt3F11tNGO9zmZGIGWFouygvCxJxb04T6HVldcedZ1sRzPN9l12XHXTi+xa00RQMjK9/15nm4L48PEttifWOQbR1nh1ZT84QeKzaq66MZllgDcmzN1uBZ5m18kaNxGtU/sZzmekbv8Wo4OXxv/bhqictAQzBBsi2gAiSJ/+6xoDMF3yZOF3wu1LBzxqBI7haGsU//YO44NofzM1irVd2WbZ9PBVJGnxsCRgnVwHfeXkX8VXkZSbXM4RvzNPVzGwjCVCCJXtSgCiGygLIZlarD5iVpYcjBSC+3a8jWsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYjjletDr2OfkN0520cz9KB/1Mp8s089roGP0DWV9Rc=;
 b=tUn6TQ6azpFyTu1mKPRhEwrICbcTA5h1t/FLjOAuvv2cMjn/8+vjImsdcJxiCUbz3rFt7F+g8aVCmV+L5+D1oXdR6CLYQkX52fCoB1RLi6pyQiCnVeUoHm4XntoOmBSdJfOHDZ5J3H5k1o53se51RduHM/SEpTqXMNXOtc41z3aGPGR8QKRb/fTJMSYS5rcp9xu1qh7mMHxm18WxDlLKdBpRUpwkG+CP4XaNq5e0CqHDBAMp0HLNCVKyo5KD1XVbDEZf+bd5xJdeu1bFAnDmm6D4sTmKN0jUtE4tZGARklEIqSoEHnIRrkP5gvz463pfoLk9O3uxfshc0yR+B0WRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYjjletDr2OfkN0520cz9KB/1Mp8s089roGP0DWV9Rc=;
 b=TAV0erLEx9QnKYjzcJidhXnqvMRla+8elywwH8CKdDpT/VhT/3+ShW/ngem9lYe2JreiapQ8ENJZINPs0oiEWr4AQevlgUaNIKIPs9khoaHKsG6XDJAfgvpi5b0ik9aWsbeJZIcOcYGPxZQ0Td10MMQv52+BqFZb2mEM8raPuKw=
Received: from SJ0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:a03:2ef::30)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Tue, 11 Aug
 2026 04:09:26 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::9f) by SJ0PR03CA0205.outlook.office365.com
 (2603:10b6:a03:2ef::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 04:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 04:09:25 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 23:09:22 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 0/5] iommu/amd: PRI related cleanup and fixes for v7.3
Date: Tue, 11 Aug 2026 04:08:55 +0000
Message-ID: <20260811040900.8572-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1dbf87-858e-4def-1d9d-08def75e54da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	DJjU+4Guo1l1WmBL6vpqeIusnJ3sygwkOPSZJvmsZZI+ArM16J34VTC97S7axoQLN+IMX140uwYGIYDtU8yGAejLFflPbEc69QfO758Ni8K00C/mk8SEw8JPfJMDrJdtK8Cz6SnR6BG2ChHHmb9XNRmNS6EuY4pom6xxutCcn7knHKTrQx2ykpytUfweK7eonvDwAt39YchTRz2SL7hycb5wBY2iEbDNqQhdy/2N/0QwRox0DKhgEptkECpazPAqeeMb47dTSW9oeitkeiBAFDZ69fn6xVibFjcmlawh35wfmoChI3bWlStuanKJQcn3e0M9fMZzqPmIvQd3qpRhuy/ynIkhBqSv1J9z7k0KHtVHdL3W8Wj3v0I9kGF7YY8UGhOq/iirl5MNcJoQsnafJy0FMa+GsQ6bYPi+hpvRcmm6VnpFQ2ow+PQU3ZYD+P9NxBIG/JyLb0DXvwIyWE+Rp8AU5rcVJNRLSmkMn3Kqvvz3osTkLBRpLwpgErfaN3L6EozI/da84zMTWlglvw92nPtUujcmyZvypBo1VuMit1r19F8LsZqay1sDSaksGjW8yAiyBYwjMwZsUgnxH+fdebIMWsb13HX3Am6g2wCGPVejIbFVNGiVYaNTdsfY9K8yNUF4Lu1TA1rCIR0iqKhyk+SP9RRvRMk+6TaUVzqA/jHmIDa34MMirem75oI9czca7kU2E9uJeF2jdw02b/J6/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v/C2aSvcnQJMaqD4LpzFj/QJ96SeZ3+lkwpVXukQxxIrj4JwTvAz7+u0/6kI6uzz6YowVvr2r29eGtALurOozRGjWWCI6KDpNyeH6IGlRprhExt7KVafpnyB6I2R/5f3mXoJlMuWUJYRJIw5w+ZECujtXbRorYeIPM9jhpZuoNH8DNGncWef85SZVSCU+WdcxBeoK4rD6tHxSlwxp3Ujrf/6C1TsUl6YxAE4hrCa9DL8JsNW++J60bHpkeJTGE6JtSNHX6LGLdlTT+CbS5EsXsfje5oskGC0RhRzcRr8jrZLrNT4g8sYIkMVwEK7MxY2f5FHOqr6aqfUaZcgBHeXX9y5XL9jQ28KtmDXKCL2M1jETurOfyt8hfShxZfDDgd+1+EKp9kAUylff46Mnijy5EbMf3SQMtSq2uTxxI0JYMU8KOq2kEw7ekqY16EUeCiI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 04:09:25.4753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1dbf87-858e-4def-1d9d-08def75e54da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296

This series does few cleanup and fixes to PRI related code.

I will have followup series to re-arrange PASID/PRI enablement code
and then eventually enable PRI support without PASID.


Joerg,
  V2 is rebased on top of iommu/amd-vi branch (Commit af3b69b16383). No other
  changes.


Vasant Hegde (5):
  iommu/amd: Fix incorrect device ID in invalid PASID error message
  iommu/amd: Introduce PPR_TAG_LAST_PAGE() macro
  iommu/amd: Fix missing CMD_COMPLETE_PPR response for invalid PPR requests
  iommu/amd: Rate limit INVALID_PPR_REQUEST error logging
  iommu/amd: Fix GN bit setting in COMPLETE_PPR_REQUEST command

 drivers/iommu/amd/amd_iommu_types.h |  5 ++-
 drivers/iommu/amd/iommu.c           | 63 ++++++++++++++++++++++++-----
 drivers/iommu/amd/ppr.c             |  9 ++---
 3 files changed, 61 insertions(+), 16 deletions(-)

-- 
2.31.1

