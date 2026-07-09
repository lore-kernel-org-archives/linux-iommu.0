Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA20406268
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591008; cv=fail; b=YNu6XrmBsiRmfTccTrBGCjwrOTS4h3TYDVLpnjnB+0O2VXK+XYEOkqrn5R//+khwltx+IPbO44ZiVGD2Ms9WMdkpJ/6tgXyFZUtbp3Xi+pE6RBu5QkL4Y0quWtD6ock9ScMGzjLcahbkjBH+Xm505lu2w1vJp54lHo3kmYoUVls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591008; c=relaxed/simple;
	bh=P57JaIwr2rey1zM8IhJtDwke61H0X1LW7taNqpoLcb8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aRE75oXtWWFXZc72I3takjUES9Nudc3s82VoOmSE0TJrBAsnmYjc/dkx1j6hg0eRN+BShbO/AezDkgZcmLqtw0ZHLhEJDtpPqmEM49DnujLGKcoF/XWFzMGR3bm3KiOOsJOZvnX/n76U2aTVDpo8O02QQJP/RtPreVRCiatiZNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pXL65e1l; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pXL65e1l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exQ009TXP0YKGwo4nXcriS5bgl6eX7k0HEhn8yUSMLMLOSUJ0M65D6oFkqnvXlUHGlbeTJ3pNH9XkxOk/h3dxkNXfX3g2gyRbJNRQ56bJ+8xBTQXEikYIQlDT1ZaTFm9oMy39GORtAzwOfbGymwE8h2YkDe2WfEZKazQybK3yu+zlaMSv80Fn4a6O/4QqPjRVLmMQMzN+jAlAWrOSK7xsLAckcNvrv8PDUNR2G6hmS3FIof5KhHfxWWbSfCBkrHj7qN3ABORgZBto9LV8ka6jI5Xa1k7e/lnEHwBZRA9ugdBI4bBhC6KoBlg77rYV504z0mN/EN8fQHUGaQTUDWopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jaMPIM6KX+UST2o1FwG6tW3QIGROy+dkeeNMng5ZTg=;
 b=llEoaShweoFNXrwcIjtx5DAHkI8glR6+EWHb7zPjQLg/NF/nBF1mYZ7s0hAYk7isCA7Yf7PAh172iaw5MIUECeTLJ21a0axXdQy9xbBMV0O+fdH0GY0KkammrbolpO6F/hEswVmtcxl1MrIRfz8TRGkKa2ghuQi45iecvorkz+jCvQJpAYR96ohIc4FLamQwi0jqnOGgA4z4fgkI1koLcEYvkjlqGylOa8UQ6WQTOcWHX4jeaKPNprvjw11JNoKsIX8GHMyybfUvZWuucAVXIMB3jR8dOzc00BF+MRVC4RYviDVGPh7xpLmrnCn/pHGfr3Oi2uBpBFycpGRSKQJMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jaMPIM6KX+UST2o1FwG6tW3QIGROy+dkeeNMng5ZTg=;
 b=pXL65e1l8GEAw56fNYdDCgwR0lVnTdnZ53vIPjteFAZLv877QIzD26Jd70HQmBwr9tvqaa/9CCGiBIHM8V2Kk8rXsUjSPY3pWQm26EJqItbi5eiNDESgLmBOmLJbf6o4AvHGPmMFAnjcmLHauQAFzRXuWmc0GiBlwEXyr4TG+2Sn9lSvrXp7modwV+ZeIZUgsDqty4LQs17a24k3XgSgm1REQ1j2XIG3TqK6GHImn1ATOt+UD5UjbWqGitckUKvj6+xxRUcvPha8foxBhZtsyIjeT5eijdWAewX+CGq8gXmUPM7ffTA3jq3NKzZ9K2Wj5KJ8WlFETaf+dRT52pVOXA==
Received: from BY3PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:39a::26)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 09:56:38 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::1c) by BY3PR03CA0021.outlook.office365.com
 (2603:10b6:a03:39a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 09:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 09:56:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 02:56:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 02:56:16 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 9 Jul 2026 02:56:16 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>
CC: <linux-tegra@vger.kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, "Ashish
 Mhetre" <amhetre@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/3] iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions
Date: Thu, 9 Jul 2026 09:56:07 +0000
Message-ID: <20260709095613.831769-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 061047fe-4f97-4bde-b470-08dedda05e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	g7X5qOLuwna2oQ2NXnH3Die91RPFcgiIOPglUnhToXpcv7vkp3pyP6keSURKp/YftOOQNiZeSj/4D1rjwXXjaU/FyGrQowpevtu53tAld5FSMXLnQF+ErlheUGHVznsVWygJCX22ivTXZV/XhVOrX7PMruPoHdGf5saPoVmyYDHUxTs40hHml5bEuse+vX4zXJlwCI46N2hIha3MP69bOEzdGhOttgckrm8C5LmXlPr3fCIwve4vwghjONKybxaLCWOKmzmOFJGIq4Nga+Kd2+80m0EvZeMQYdXKdGTAz/6jrlM5YF2mHAxEo3PuvfRRnme1PBEnQ+nYK4WIWhQFOaT5UN06OWXzT46QSVDR+ynS5zYkXpstwdKDd/gE7FwQVu6C9LC9BhI5nlLJCv2HWm7UqtGBWdCk93ke/MThq+7foT8K/T0Sa+QwcDaccri9BmW5oyArn8F+/jCT7NBlhPWbuv2AEXUNPS9EhWSFwQVWhPt0OJNJ4F9Q2NHnn/hQIk+X3k214tT3zTAvfsnkdo2SkBw4kC+Wi70FYrrO2La2cu2wo1+WutFe7bHXFj82D0hU9Zoejfud84a1mnsqENNRYwV7Ak5IAn1zIlJE8cxvmm8sQlsj4n/NEbKb2Op5uW5k9YNCiP0ZIeVzCgVEw4HX8peH1rEojY4sKTMm/6Sfxn+3eEpXNwjaVuuKqh4MmNKdcjpVsGFHitCgJqQ6+w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p6K437J55JzgkojpfKfh8eP12bQlfJRnt7dcttLgvY2HpkxzaRCKftlof+N9H3TRqyKU/oJsvrohkYCzWhoDk2qEeMXddV55M4W4LdeRm9DVR+8e41QquNehiU2trlbbAdcq6EbprHczBhyH+3WrlH9wxx5cdcj+lnKQ25nPQ+hEAo9AJC/o4KkIVP0SDdWwf8i6T03oEGle9cSuhoXLhDhIkOTSviblmTpulbkqarh9DkMdY38AHBTiaX9r481slHjo+dk4LebhW4fqihOJ0z2VgEMQ2MmZXvJqlaqz7TihPHgJQ61ViNSqomKR7kZqRmoUNPkiyPqDIMZ/18QY6n+w6W0ZKdey7UqfCI/nmSZuaxNehBZSh6Zst258zpOlUNr6htMTigH/1c7uaFWxLuyuEzIZ3dQqI7mduylAcpzjMj5hBpCxXyt7je3GRHbx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:56:37.4125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061047fe-4f97-4bde-b470-08dedda05e16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921

From: Nicolin Chen <nicolinc@nvidia.com>

arm_smmu_cmdq_batch_add_cmd_p() carries two distinct reasons for
flushing the current batch with a CMD_SYNC before appending the
new command:

  - The batch's pre-assigned cmdq does not support the new command.
  - The Arm erratum 2812531 workaround (ARM_SMMU_OPT_CMDQ_FORCE_SYNC)
    forces a SYNC at one entry before the batch is full.

Lift those checks into a new arm_smmu_cmdq_batch_force_sync() helper
so that adding another force-sync condition becomes a one-line
addition. No functional change.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 23 +++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..76efe479e80f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -847,16 +847,27 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
 	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
 }
 
+static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
+					   struct arm_smmu_cmdq_batch *cmds,
+					   struct arm_smmu_cmd *cmd)
+{
+	/* The batch's pre-assigned cmdq doesn't support the new command */
+	if (!arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd))
+		return true;
+
+	/* Arm erratum 2812531 */
+	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
+	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
+		return true;
+
+	return false;
+}
+
 static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 					  struct arm_smmu_cmdq_batch *cmds,
 					  struct arm_smmu_cmd *cmd)
 {
-	bool force_sync = (cmds->num == CMDQ_BATCH_ENTRIES - 1) &&
-			  (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC);
-	bool unsupported_cmd;
-
-	unsupported_cmd = !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd);
-	if (force_sync || unsupported_cmd) {
+	if (arm_smmu_cmdq_batch_force_sync(smmu, cmds, cmd)) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
 					    cmds->num, true);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
-- 
2.50.1

