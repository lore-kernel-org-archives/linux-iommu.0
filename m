Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8536C2DAFD7
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190238; cv=fail; b=jnljOq8ASPTZe4uuIK8iajRvAUZ0Ku3r9jOsGN999N2rCsrz3k4UmYENdVrYY1VjcGMasGaZlsaApfFlAqRamVx21pmglG7Q4J16ZZkOZ1iGjowEGDgDXrOCxgAG2ph3ZttWH1O1oEq5Hei/7qVWz4pyEba29yw/Lqb3Et2vlIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190238; c=relaxed/simple;
	bh=4jCKgGWksTb86QtfoBH//T4gtgWEk1LJpLc9eAKr5FA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dVtM+XOsDf3J1PY1OOAIWfKrel4EyAAZRa5e3NB3NgItJL8gq+Vx+fVqpFVhBgtk8UqUrmJNKA6gStt4wyEOAP+Om73WkthDDDP/Fv+FOZAe5y8S5E7DS/rpjoVbkIwlxKh49XujwCQik96Mu3aDz1kWVtnC7bG51ko/PNZpCAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FsRxGGWN; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FsRxGGWN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vei5PXVXF8d8CxdmptOasyUTpuAXsxU/f3kVjzwuf75U/O5TVGni51D3egPQKXPx2xEVBefgDHX7FHua5YBcoAeI9+JFP3rDpPsgIxiO8stbLYq5nkq4ZxqBrWS1yTOugb9wDQybWteF/usJEonsKEmwsRYV7MFznELtRV7eQ/nRWJrXsYsvKozsU2/CUJULSo5YirIkFLe8lcHhg0cLHqEIw3NPfPGepk0/yAjMbIr+KPxd2YdBOxQFV9OTbgBIx44UQrBSn6oqL6CpNASbq7nhbg9rGkmpNr/ousAWg14korsH+g20cj8oaqmsYXDUOjGneevgLsFFL18NcsW70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt41y1uja6Qjh61bILR7tb5FhhpdKXEcXVg0RwL7024=;
 b=ndGXXRPY+LkkzvBOOplpeIM1/cMLqT1P/hREklY6P6vIp11ciJgoyotX/jW+JvOzwGGanmrcBT80Bh+NhfD1brqjKRt1tkSPrWqZVPqgTa4K4NN6AHVlteoRynkHxxGb5tgAtIeH1u9ZxQ2H4UwNt+Yv4jxkImza0ncwdPdq9+PDhpNrM4b+N0dJEa1ihpTv65DgmoeFfsAeBurI7dCXzWCqu4ZSYNn4odC3pyOE2quazRqEzKd7Cp5NOssk2UXwrc9nPKAvpRlWUSRhH1A2Bu5yZhADYwbQLwctUwY5E27rbOz5kCh3DYD3YAauYy2MnqOKMdRXuxHSxTIw65ekkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt41y1uja6Qjh61bILR7tb5FhhpdKXEcXVg0RwL7024=;
 b=FsRxGGWN5sCVu+/dxyumzZCr4D5aMZI587QI0S/PVBsvyvB/P1yeQhSsmyTxQoJhWUk6WeFy+VMNX+NtZBeJpwFCA8XZFDNW0QG35Ob99HZ8SNlSf2b79xkQUeKFR3UD7WS/o22zkYCP0DGOT5k60p7jGGSrX4b/2HGDjHnt0LgT2wMNh6WZSenbxzq7vFORaw2eJ1VGaLkv+ovX2b/Z3QtA0JHmEoW2bcEiUcu+XoLkuL3roug+2hxFe5AKlJM/CdtalgsIr+Lxs3dGFxtCyuiEYTMFX/MBTwEyp3iT422No5ltGbcYiB80KtTFqmlY/jyaBEnAUF9w3KU2v/jf2g==
Received: from SA0PR11CA0083.namprd11.prod.outlook.com (2603:10b6:806:d2::28)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 23:30:32 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::9d) by SA0PR11CA0083.outlook.office365.com
 (2603:10b6:806:d2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Thu,
 10 Jul 2025 23:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 23:30:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 16:30:14 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Jul
 2025 16:30:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 16:30:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH rc] iommu/arm-smmu-v3: Revert vmaster in the error path
Date: Thu, 10 Jul 2025 16:30:03 -0700
Message-ID: <20250710233003.1662029-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c2e405-c302-4a7c-dd30-08ddc009c38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DuUaiuIWOD72RdIhCSbLCGZgdvCmeBvz+1C0boO/W5IhbwXAod86ASq5kjeK?=
 =?us-ascii?Q?IltbUkqyO4RJvQG61/3rJ8UEP3wjDFLm+gQ3Kt9nxR9+5fFnE3M7vHv9LCsH?=
 =?us-ascii?Q?zDqZb0nQqvMGrDJN7dX6pjn0sEp/GvUKrm2YMuHlZNOQiu18v4FI8K778lKi?=
 =?us-ascii?Q?oXuA5EFaKF6I60dHjYC6A6GiJQffraq8aNOsj37TO3sNZKljKVdiaSRoRcb9?=
 =?us-ascii?Q?MPUYHznIjT0T+7Ns8+8FScA/ctCLAfdxuOoYOKdyEs9Q4XX7it+9qHmXibQI?=
 =?us-ascii?Q?qz4mWcGmONWJAXAXPBwwMFyKJAmS4TCrIMt6gG8p3aXLKNGmikNCIiS8fY1Q?=
 =?us-ascii?Q?aqI8xvAwtZAR6/mU2NmzN+YEnwCOo1aBp4GshM9MYDFfk0z5jdne8AeCi238?=
 =?us-ascii?Q?FbzLN5Hpeet6oIcVa9+1HTxKHb3zSeJ9f+zgKPQfnWKPPqp0Pbdsj2Y7ToXm?=
 =?us-ascii?Q?ANtaCVrHP+F1jhSCHUXyZKjPNJjPRytvrYYnVi7UxlN6SMSXci1cKYi0M3Ag?=
 =?us-ascii?Q?4eo5icgo7VXXO41fhQOGKLMeeMop/3lBqh/FYS3+dgQpaDalKfznQydeJunc?=
 =?us-ascii?Q?axpyAHhUDojuAYDZ0WAiYHVlMcFFmZ9RUcNZ2kK1fPzeFbj3crNnpNHuu0+g?=
 =?us-ascii?Q?HmFdT98o6A9LdwgkUBHcPkyMadMFhik6KG9OmgMVV1Cdj3LpCjP0H+/GkXOT?=
 =?us-ascii?Q?9gSaZ6wj4VpkBNY+HwJmLAlxnQUT6LcDjrlKy0KDKStvo85eOhwQ2he3vz5S?=
 =?us-ascii?Q?4ZkswHRh6wQd+Eud1npeZIxrhImCwhH7pgy8HtVPVhtu46dx+/pYQ2be6O4i?=
 =?us-ascii?Q?hg5+T3ojbVkvJyL3KtoycTfDJOLEZAgFQpz2y0OFcd3TFxG5Uey/aETs2Qix?=
 =?us-ascii?Q?gJq9QbET/e9JQUqdVkZs0zeQTnpZx4dJgnMQ72Jb284H38wIkXcBuGjU6ftl?=
 =?us-ascii?Q?1743q1Mdp6SiESO7i7APAVUFBZ0A+4MC3haYXpp3LqOUKjQNiw3M1dH/OgdW?=
 =?us-ascii?Q?GQe0CbymQ1iIX2GgKrIQ8rksZoTuAPp9vVf+/XGinfUOm7rf4smUHivEMcmI?=
 =?us-ascii?Q?EL/SYXxoLUsqOC/Amk8esivMz9MnbZ1jlyROOMmvE12zAySgAceSRVrHenRi?=
 =?us-ascii?Q?k5d2Gvkq7jVE3t4MW9JJsgyoDhCGlPy7Aq1izhrElt5uM2EBMLvaYaq4YeW7?=
 =?us-ascii?Q?8a3nvxfyPhdGB9qFbbLWP0ThpPfcxvYDtqzbmf9Rh+AyxyNVQ83B3Dd/TR6U?=
 =?us-ascii?Q?BZmP0XihV/ksgDlCQp+5SY+4/Jc6XfRHdh76I8QcjkVc3j9vsU0YafPc9v+t?=
 =?us-ascii?Q?N1bRBid/7acZZsylyyxDVxRCNyjb7iVpb4yqP3OQ3af8wSbOTKJj4g066ea9?=
 =?us-ascii?Q?ShgZMAuKrkAtry1ZuuuYJ+ZKfES+r4FcqVmtXE452WCgAA/XiJYPYIn+jtZX?=
 =?us-ascii?Q?qrvt9nvYqdZGftCGD4N06fGV/YP+NHkZkkITUhbKkN6hynyztDD2SOoN14/3?=
 =?us-ascii?Q?Wufl5rtyE6rxhpAJSx9KlG6bFuV4avoZFcBc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 23:30:32.3161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c2e405-c302-4a7c-dd30-08ddc009c38f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897

The error path in the arm_smmu_attach_prepare() was introduced with the
arm_smmu_enable_iopf(). Due to a rebase issue, it forgot to include the
revert of the vmaster.

Move kfree(state->vmaster) to the error path, to prevent memory leak.

Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 181d07bc1a9d..3c79cdbbd9e7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2906,8 +2906,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 
 		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
 		if (!master_domain) {
-			kfree(state->vmaster);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_free_vmaster;
 		}
 		master_domain->domain = new_domain;
 		master_domain->master = master;
@@ -2941,7 +2941,6 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		    !arm_smmu_master_canwbs(master)) {
 			spin_unlock_irqrestore(&smmu_domain->devices_lock,
 					       flags);
-			kfree(state->vmaster);
 			ret = -EINVAL;
 			goto err_iopf;
 		}
@@ -2967,6 +2966,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	arm_smmu_disable_iopf(master, master_domain);
 err_free_master_domain:
 	kfree(master_domain);
+err_free_vmaster:
+	kfree(state->vmaster);
 	return ret;
 }
 
-- 
2.43.0

