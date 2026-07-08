Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98093B14D4
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475834; cv=fail; b=H3BRZSWZMq0ENfxTLEQhBkvMBcVjN4wlqGAv3hUv3rch+3/N/XDLfO1GlRUGkp+EIif9/GPG5Xq/pkw7jDDqSvQpj4ZZL/tqEZqxQsnNU+XUPQyywrUK6xc/wbd5O/1vG6lcnrSUE8BtYqyp33DVELlu92pOBoDAkkGcWIEILvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475834; c=relaxed/simple;
	bh=Uwcv/V3G59oUIftYRwbqKybpK26EXIic8WNXdiFxHbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFL5B0vgRaGbNKkItfYahBUI3yB7zM5I4pvHHH3gNRIOrhsduD02fAFzAP3GhPrwjrOcx5xR/1qSbzPOQSUd/pdF7gHmEeh39IW8v76dgKU+bgxw5j2orYPJrjKmbRygLjT8eOsI2/gZysYUZ9vUMGlDVnsdf8dx0zyGJfJS6L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wQcSkgou; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wQcSkgou"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKVvSDEVaRNrg4vzG5nbmK9jAuSdOYJgr+hZjrX2jYL/j3KjWU86lb/FfmTXbscD70MrqtWrDv9AAEXpCsXSJYmVHF5pJMSkm8MSDMazDZxPsJ2opQUuK7d7CUzpT3vK8vwUklEv0G6IEC7OUlS2UuEzcaxp6lklplRhCnedgQ6YOtn2TjfJDFTXcEpbZCWwUD7Dh+wCBnHPP60B3vsvzwdAFdw0CbvpmrbGg24XI4lszZ0KynjtN/mcDuOx44vhUnIAjfrfO3SrJ4LSuaTAxOEE3qJ8FGM/0ELhVCmTTFRGka8ahKUDNvrxk9AWLR76n9WgO52yrjrPTl9WAkYmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw7imDrxLMk4hwEm7zN6vCX65q1APqvkWEoKUdFvShI=;
 b=a+RNjCpmmodJr97SNDW1sbrQ/Th+dLeJ+T0gLkdweMpI+oijHaat+h6rlCnv3Lb02Qy1XoMbSd/z4dYD1MKSYuRlO4tQmGpXKz7yDm3ut9Km0IN04WkocCkPIRxKuYwhOBWtq2tLBOd7l9HPXop+tVo+XB+GFl+NERglE9R54l8QGE2HykZk+TMhp7K5mmmpaRP9RDZsKABIPfFzakUM3LBVDzqXI2DzIGKg/3D7Z+PPYnqMYQ8tZ55DOVWaWhRvYtigijRPIktU6QolOe1o7Zw+UHWJs8Ft5PA6tDXUkGmpUCxcUPS3D6Y74OVde6tpw11t1aenZyfbGu/NWqHvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw7imDrxLMk4hwEm7zN6vCX65q1APqvkWEoKUdFvShI=;
 b=wQcSkgouYEwI9YAe/DknmRxTN+NgkcJqRjEdIdcr1qZOQ2dez+4qhdFhFWri3FIY4iava8ps1/CMgW21UB04oPF+7WprQPpamLBfUOD7j69OrwVnWXNv8nNLoFUWP8OhbSvtwQJ4m2HM30Fv9mQKLtkL8n2QTlaKLTGkGNeExOw=
Received: from BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::16)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.11; Wed, 8 Jul 2026 01:57:04 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::4d) by BY1P220CA0021.outlook.office365.com
 (2603:10b6:a03:5c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 01:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 01:57:03 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 20:56:58 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.k@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	"Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/2] iommufd: add hw_queue_init for guest-address queue setup
Date: Wed, 8 Jul 2026 01:56:27 +0000
Message-ID: <20260708015628.255088-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708015628.255088-1-suravee.suthikulpanit@amd.com>
References: <20260708015628.255088-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b47a4a-4b4c-4cba-3da2-08dedc943516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EY958QJon7E324EtfPabftPkZVR86+slGERqfvUi9sEYkTY3UwJ8TiNCQllzwsOiVNsrKk/luyPpS2/CN3TzKDfHWBYG46/AsdMbaN3Zde9lxjzYN7KOBeQhK6/YhUzOwmxMmgjr3e7GvrpqNvERW7icLbxYWTS+ntjW9nS8T558Fa2HFhBr2ui/zRXWKe2NFOhLYlcett+31hh4YpMgeIrgUkUqJFJ4HtN/i4AoIMDtBC6Av5+8FFYyT3IyFIY2niQLGgXPgItB0hQTq1UO3JdyZvd0K8APM6b/a/vGG9uHJa8xCSH2vFIxvz8mT6u6EOb+EhTktuFyLBIrxxvzeJ0pxfLvIJS/YhBSVrN5I9cJ3t8wz7BSrwBKKDf/vLvstsix0GZqMWVGztmyc3ltgoTAX9g+qrcpyNgR2dV41hvs9/12HIonLsC1lN57eUVDYmFc9HIcZ1KAPQW2p9zR7UyYym+yltE9yYtSNUn61kGXpAH6EhZk2GUPZbzraitjrIJ829jBwYVWchbFsMLCuNpswxKiy9xvdJPGs4oK350lVW3ZcFwc8VrN6B38EI8S32z+bvVcTR8TYxnZ0GPmzy/VphuW/QPwD/bPCIyE49ptKyheuIoatlyz1bwFB6/jHWNFc/Ya7MfebLyvXVfT9Pl62OkapjZJWXKGf8XjQw2WU0IBQ9gHjWzsrJf1XtFV0kuvqhgRXnQkyNZ0oGNxFQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VUBrvHU21MY2OWBRDRByj5kuueIIBNOLkLx0dTc65vN/v0y3zwz/WRnlruKP8HBPwetiCNF/uM4NHynFIlGolhqLAWiVOiwx3joyxXxiybKiDEz0OmXzwXVDTz+ZV3GoSgHVkt5NekAywlPFXkQckPXhT03ruhmBQPIo1K9M3du43nAecaKT+WFQQif44cu76OOdfYc4lSzz+lOzNdccmBJ3uHZH1i8oZOL0oyAi4ZgCwUNfm9MKHpgLltbOUkoQrzaypkSmfdyykxmwi+J/Mbczfg1nSYGjNJD7C5J9ch0kiVqcVyI9Vl5S/mmVVhumBUx/pGuSAJXMZFkfgMZOU6UZ6zxUG7OmOAO4Guae0AMr8jKdt7eAUm8xFnHq6HbqtenxDLKOtUMIsKF767CSAeXt3SaNKcKAsRM1HS1TZUjQobIGu8cy4vvDl1gCwAIa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:57:03.6248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b47a4a-4b4c-4cba-3da2-08dedc943516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

Factor HW queue allocation into _iommufd_hw_queue_init() and allow
drivers to provide hw_queue_init when the device uses guest physical
addresses instead of pinned host pages.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/iommufd/viommu.c | 94 ++++++++++++++++++++--------------
 include/linux/iommufd.h        |  5 +-
 2 files changed, 59 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 4081deda9b33..b278cbde360e 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -353,61 +353,39 @@ iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 	return ERR_PTR(rc);
 }
 
-int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
+static int _iommufd_hw_queue_init(struct iommufd_ucmd *ucmd,
+				  struct iommufd_viommu *viommu)
 {
 	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
 	struct iommufd_hw_queue *hw_queue;
-	struct iommufd_viommu *viommu;
-	struct iommufd_access *access;
+	struct iommufd_access *access = NULL;
+	phys_addr_t base_pa = 0;
 	size_t hw_queue_size;
-	phys_addr_t base_pa;
-	u64 last;
 	int rc;
 
-	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
+	if (!viommu->ops->hw_queue_init_phys && !viommu->ops->hw_queue_init)
 		return -EOPNOTSUPP;
-	if (!cmd->length)
-		return -EINVAL;
-	if (check_add_overflow(cmd->nesting_parent_iova, cmd->length - 1,
-			       &last))
-		return -EOVERFLOW;
-
-	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
-	if (IS_ERR(viommu))
-		return PTR_ERR(viommu);
-
-	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
-	    !viommu->ops->hw_queue_init_phys) {
-		rc = -EOPNOTSUPP;
-		goto out_put_viommu;
-	}
 
 	hw_queue_size = viommu->ops->get_hw_queue_size(viommu, cmd->type);
-	if (!hw_queue_size) {
-		rc = -EOPNOTSUPP;
-		goto out_put_viommu;
-	}
+	if (!hw_queue_size)
+		return -EOPNOTSUPP;
 
 	/*
 	 * It is a driver bug for providing a hw_queue_size smaller than the
 	 * core HW queue structure size
 	 */
-	if (WARN_ON_ONCE(hw_queue_size < sizeof(*hw_queue))) {
-		rc = -EOPNOTSUPP;
-		goto out_put_viommu;
-	}
+	if (WARN_ON_ONCE(hw_queue_size < sizeof(*hw_queue)))
+		return -EOPNOTSUPP;
 
 	hw_queue = (struct iommufd_hw_queue *)_iommufd_object_alloc_ucmd(
 		ucmd, hw_queue_size, IOMMUFD_OBJ_HW_QUEUE);
-	if (IS_ERR(hw_queue)) {
-		rc = PTR_ERR(hw_queue);
-		goto out_put_viommu;
-	}
+	if (IS_ERR(hw_queue))
+		return PTR_ERR(hw_queue);
 
-	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
-	if (IS_ERR(access)) {
-		rc = PTR_ERR(access);
-		goto out_put_viommu;
+	if (viommu->ops->hw_queue_init_phys) {
+		access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
+		if (IS_ERR(access))
+			return PTR_ERR(access);
 	}
 
 	hw_queue->viommu = viommu;
@@ -417,11 +395,49 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	hw_queue->length = cmd->length;
 	hw_queue->base_addr = cmd->nesting_parent_iova;
 
-	rc = viommu->ops->hw_queue_init_phys(hw_queue, cmd->index, base_pa);
+	if (viommu->ops->hw_queue_init_phys)
+		rc = viommu->ops->hw_queue_init_phys(hw_queue, cmd->index,
+						     base_pa);
+	else if (viommu->ops->hw_queue_init)
+		rc = viommu->ops->hw_queue_init(hw_queue, cmd->index);
+	else
+		return -EOPNOTSUPP;
+
 	if (rc)
-		goto out_put_viommu;
+		return rc;
 
 	cmd->out_hw_queue_id = hw_queue->obj.id;
+	return 0;
+}
+
+int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
+	struct iommufd_viommu *viommu;
+	u64 last;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+	if (!cmd->length)
+		return -EINVAL;
+	if (check_add_overflow(cmd->nesting_parent_iova, cmd->length - 1,
+			       &last))
+		return -EOVERFLOW;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	if (!viommu->ops || !viommu->ops->get_hw_queue_size) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	rc = _iommufd_hw_queue_init(ucmd, viommu);
+	if (rc)
+		goto out_put_viommu;
+
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
 out_put_viommu:
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..5285d96f1d8c 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -180,6 +180,9 @@ struct iommufd_hw_queue {
  *                      the physical location of the guest queue
  *                      If driver has a deinit function to revert what this op
  *                      does, it should set it to the @hw_queue->destroy pointer
+ * @hw_queue_init: Similar to hw_queue_init_phys, but driver providing this op
+ *                 indicates that HW accesses the guest queue memory via
+ *                 @hw_queue->base_addr.
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -192,9 +195,9 @@ struct iommufd_viommu_ops {
 	int (*vdevice_init)(struct iommufd_vdevice *vdev);
 	size_t (*get_hw_queue_size)(struct iommufd_viommu *viommu,
 				    enum iommu_hw_queue_type queue_type);
-	/* AMD's HW will add hw_queue_init simply using @hw_queue->base_addr */
 	int (*hw_queue_init_phys)(struct iommufd_hw_queue *hw_queue, u32 index,
 				  phys_addr_t base_addr_pa);
+	int (*hw_queue_init)(struct iommufd_hw_queue *hw_queue, u32 index);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
-- 
2.34.1

