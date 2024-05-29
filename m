Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8017F396
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982779; cv=fail; b=g35JsQYZxQAhoBnVGCkR19wtMA+jzAxFnElGydfD2rCKv58Gn9foYBuQA379FU4K5gcsjPB4g55jR9Idj4s9DGDlVKTzJ5t4wfJmVkVmTZz2WV+ap6FDX2QYUP4qMdPjcoHFlRxNC2qmE2vAGj+QjPVplJJeRjOGBQbqYzYZMUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982779; c=relaxed/simple;
	bh=4KhFqD3COd5R6oczer89LUkWSj6wt+HtLyyF9DmBFO4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OpRykIOxi2+PquF/2Z9lckClLXQS2bYCwtMCUMOMIQ6j7fwINAvPK+Gmdevxz0EXJlUfe95hjTE9zOfk1/Yg02yu9HJ1lVweljYOd/1sCzzN398/M2+skPSTHbDQZtaolq/3J6GMS35j4JqEgKjhe4ZLZZhbtjgSSgslCh2OfOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dnPvtSQD; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dnPvtSQD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXlSYzDvGZ7NRq3aymBxw1iTKPjCoOvaMQVAilUJhIr+kN48s3P1NIo/KZrlR+MANJEc3brMC89+4yzzjtlO6gk8GHQwsb+fiIfgShVNldKmiJ+jkkJwS65Bpcgu2Wq71cs9xGCck+nF/slc27zkgk4sCBIyofvIfjMStZYM5EsjnkkNJe41iAvUnuFx6WiuPMhLPrQpmnmtTolRtO9qSr6L7Sg+EV37p0DDSZ8BQN5WJaW88FdYT2YXABvE3zQAn/8363QKQ7LjoNBjadOI+Ry5Vtvwbm47/mFoPG3p2e7szFJNI7tOGrizWiGgvaTYjHpGW6O1pc4OUEICBdaOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/gjGVxfLRqHGgJnFkoSRl88Em1yXOJCQzv7F+Win2w=;
 b=b15xAWllFMJimRNggqU07uLz1A8PwAoDa4Ir0KCHLdxsNEO6yKhmZSlVLpb9vhlc45EOgi6gW2G+wu6Q2moHX2yApgL/WA74Hf2MDlRVCEBbh2ACFko2em8KlNf4ybZoQmB1Xt4mmvLiTaeODYSBUgQCABtQes2Ky6GVUY4yYyyG9Dea3Ke4xlzBSe0DJuXXmXFoeKluHlsJb+aGGYQOFvT+zOGQFy3bzLXzZWlB5JrkpsExgNStz8E1wvBFRGJjtEyewLyt3z8PurNVqELJUM7UWSy5hzZirld2IfMJtWB7DETteuSarcq0Bdxd62qFO9355g/BqkPsVfVnsXjlsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/gjGVxfLRqHGgJnFkoSRl88Em1yXOJCQzv7F+Win2w=;
 b=dnPvtSQDF3bFu8uPUivLkAiNPtR7GKsyeKt6YiQwOo/+8GPce0VnYy+o02kr1QnddbNeOMh8lRn7EIb/ZbZ8waD4uemWMk82OWSL51729iwUXA4roKPu8kSphmcPMYlMArZX+84BtQp3grM+3cuyoyCwVpwdrkpHDHaMtkOVO+4=
Received: from CH2PR11CA0014.namprd11.prod.outlook.com (2603:10b6:610:54::24)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 11:39:34 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::75) by CH2PR11CA0014.outlook.office365.com
 (2603:10b6:610:54::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20 via Frontend
 Transport; Wed, 29 May 2024 11:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 11:39:33 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 06:39:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] iommu/amd: Fix workqueue name
Date: Wed, 29 May 2024 11:39:00 +0000
Message-ID: <20240529113900.5798-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0a0806-0765-4649-c6f9-08dc7fd402db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?25RCiNcqI8Da21PP1Tnk1zQs045fNQNYS3BoHBYElH9uSRydAto+DIRUv1eN?=
 =?us-ascii?Q?LNWUXpnokF+cB0Hm8SHfOeUBQg9/Jn8aCzjuDppg5+CiMPNlWv6DUokf/01F?=
 =?us-ascii?Q?mPcfDN6RfuY7wVnFNQ1JEdJMwvFx/pgaFVOD5a094QEES4uqoy8CyB6cggp5?=
 =?us-ascii?Q?7lIgILwVy8Mqy1TaKWs5Q7E9QHKH37HyCn5vYFNF31D6y/yucxF5VBQmVg/D?=
 =?us-ascii?Q?dV7D9JBneyyd8Ety91PkixVNLN+Fendd8LBm4gA8fqtvEnz4kYj1ymmd9aLq?=
 =?us-ascii?Q?IL5HHO1KTKKrJYyJO3cHhmDpyzeXn43vC2iXRWmMPe5dxS1jPl6F91/FcFYI?=
 =?us-ascii?Q?H4jwOUUaU0pIHY5hi45neo3aSXT/2TUSBDUpu5rdoANFxHUtHI3lZI7pCH4d?=
 =?us-ascii?Q?ZUdwTBL7C19dWrihiRZMbniJ7xzbDSSXEGuonNRQda8puhdPlTJ3nxIUSRfA?=
 =?us-ascii?Q?D0+g3wTA4CfR1GVpF812uTM4oSrGhDUgY12MReOnlg4YukLh9NM7/i1ikU6U?=
 =?us-ascii?Q?3JOrWCOnX07pcTJuy/OpBnecFLmIMXG87crcRZyhd0P2EqpMdh6qjHawJZ5q?=
 =?us-ascii?Q?WD4kqc/u882ofG9An4zF6vvnjsl/oA0gY0n9JA/9vHOYS3cuZctWhIa/hU0N?=
 =?us-ascii?Q?wSpnfuq1G2Jv186XWmBt8T0yfrJJ+JRTGPARtzq7C2X+H4u0QHzQ0urohTKB?=
 =?us-ascii?Q?Eepz2pzRKrmCPCSkU6h0n8WWogd+PsAJongeP1P6v84L366RKKe6XvhfSPTa?=
 =?us-ascii?Q?AZQmOHX2vG5t756efzLdPlu9M2brfCiu1q5qPVoL8qVHXF22mFQKGpeCF0OU?=
 =?us-ascii?Q?TSYu7+p5SYm+KWL0mxhzY8JGSgsihV8G4ZlX4dIFeXXM2sCWZ1YHHBhitLok?=
 =?us-ascii?Q?23R8y0/sdpndRT5UOjD5cONM2upFZlZgr4dAJcC1udYTH6NsKWQXIlQJAX25?=
 =?us-ascii?Q?4yHnAtMuwPPMUkHtQ6N9N2FXE+L8j+aSq9eKee59KLFo5tIkrAtu7Nt5ZRm1?=
 =?us-ascii?Q?JE/trjOxg4sOGb0f1G7NwR+BiNQGOwnvFD/uvjEUdwtA2DGNXcR+YjK8JBKZ?=
 =?us-ascii?Q?XaGggDYadtLEY0CxRfKrLU4fgvi9ukmxiLSePlVcywsH0kv6RxS6F/OzFSIZ?=
 =?us-ascii?Q?XI+5EpFwn1i2Mm4C8c6qu/def9y19uS5DKx6jHlaT5xdz2Ffb5MDhNN53sGu?=
 =?us-ascii?Q?ReLThrUrsZBrNG+86mi/JtZMAbVkkhnFYhvtxC4RU53lt67fHSU9MzCO0S9+?=
 =?us-ascii?Q?NDBx5w5Gd/R5gFcC7K8mfldTK3hdrSp0LLyGQIvdwlLQSmQh4y6afOEpp0dR?=
 =?us-ascii?Q?hCX+tcqfo4SV+Dnla+Pe7JOmk60FI5ZedliBeiDNK3tWAdeLM638cIqHsfpG?=
 =?us-ascii?Q?2Tj24r98NXUnb3KzlMxzd+e815iA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 11:39:33.6894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0a0806-0765-4649-c6f9-08dc7fd402db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173

Workqueue name length is crossing WQ_NAME_LEN limit. Fix it by changing
name format. New format : "iopf_queue/amdvi-<iommu-devid>"

kernel warning:
  [   11.146912] workqueue: name exceeds WQ_NAME_LEN. Truncating to: iopf_queue/amdiommu-0xc002-iopf

Reported-by: Borislav Petkov <bp@alien8.de>
Fixes: 61928bab9d26 ("iommu/amd: Define per-IOMMU iopf_queue")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/ppr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index b3b690410f2a..7c67d69f0b8c 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -222,8 +222,7 @@ int amd_iommu_iopf_init(struct amd_iommu *iommu)
 	if (iommu->iopf_queue)
 		return ret;
 
-	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name),
-		 "amdiommu-%#x-iopfq",
+	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name), "amdvi-%#x",
 		 PCI_SEG_DEVID_TO_SBDF(iommu->pci_seg->id, iommu->devid));
 
 	iommu->iopf_queue = iopf_queue_alloc(iommu->iopfq_name);
-- 
2.31.1

