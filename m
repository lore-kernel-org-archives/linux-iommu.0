Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FF31E842
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945603; cv=fail; b=e46+/KiPvrxyInMVeIH/fM2wNRSEImmisdaqM5aObSZUt/1WsRLfu9euWJaj4SYQijwHtTYbgK8+45eVmNTDTk16wXbkzJrVQnZ9l5o91f2a4SGJoecCM8HAyPwOgYFdAfI02599oUcyNOQSITjjl7t2sZCC+N1raMW3qJ+Zp6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945603; c=relaxed/simple;
	bh=K9fMpxfLxW8IcXfTEEy9w4eN4pvf0zetE+Tr/fUdRhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMp6jDOSX/BFlRx0AUnFcLmwqnVXw6qoB+KooMIf+SI2wyGZ6BYkeVlaPbpUTOy2qmXjvmPfz8QrZxC9FJ9aWhpCcLOqPXMaldaOSKCANAdpcOzXWnsPYh9mVueg6RL1ALrMfTG+gFwbCP+0qHDWvXy6A/JpeKueqfD6Ywbn4e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lc9PTRNY; arc=fail smtp.client-ip=52.101.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lc9PTRNY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUVpspzTqjJAyi1NA5JEjlHvj4AI6eqt2pR/sir4izmWgoiut134CiwAzXICOwiRZ44GjXnb0aCA0InL8SY3u+wXV2nQ7xQ/tOy2mzQb8qOdr7oubNaksjxKaSrpLP1wUAQDmNcBk4uCHdd5FuolYkAcoRNNQAZFcSvYFQZwlUkBef9JakuJUcgKxkb8OPkgRBpBjzvlqelQuLGYMDhFg7sItbnoS3kB4lEB5y7D7UTFTGVUC08X5efxJAOlpxg5VhFr69FdbA+a09rgftG182WuCEAuFQhMTspAMF1xZ8sOlPDHgi4jrTIRskLfJUIaJiKrLVE1cC9UcEJgQmuNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKPDMblZtXySMdkSBPumt32oCSe2TIQ/DeNLt6cS1Fg=;
 b=ZqMAaRLA6n3R09PDWLrSUhn4CT+qeaqa5Q1Y63F+W0qjNiKoLCRdNBT79Vxw7Errr0bsAP3f0U0V7ZKL+jaJc7t/gSOCXM3ZxdzVCwOstjd9+EivZRcwB7wSDBF1uVxf2Jc8ADrLoQ2udqrNpJTupCAxZa6eBMq38IB5hbeQJgelw2+uaYCp/zhociVn3U/uHQi24L7xo84OSIfwk1prfL6N5JrVDb+3VYtJyUT1H+23vvs3QoVLkg5uUl/5rYJlW5YnENUGJark9atUqPhxGkplg8xH8fx2AS6+9gobQkBacJLPOSDdcn+0E39F2qMlEH5HmfZS7i0eQ06UKTBHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKPDMblZtXySMdkSBPumt32oCSe2TIQ/DeNLt6cS1Fg=;
 b=lc9PTRNYR666AokrgI00HU+bMzAgPcm7ZLqPvlUpR9cN8A1WjBRbm2HH2qdHJIwve2TxW2Q141GhxsmnPoKkpyudp7HA7fn5C2O+RUBdiAALvC2bfyiqEJcBveORXa1jzpF4BtfWBbTsSYD/acJrxCtF/64itBazToqZprEFoO8=
Received: from CH0P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::25)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 05:19:57 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::32) by CH0P223CA0028.outlook.office365.com
 (2603:10b6:610:116::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:57 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:52 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 24/26] iommufd: Introduce vIOMMU command via VIOMMU_COMMAND ioctl
Date: Thu, 28 May 2026 05:17:36 +0000
Message-ID: <20260528051738.596013-25-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: dc86b6c7-e257-46ce-5096-08debc78c240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|3023799007|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ejH32d3OUzRutLpevGSp9U20KFmCo77SFvZ5cLBb1z7PrHuetQrbw/f1kcjtWowwyGH4ouN2EaEQELXMgUXTmrEb3sF+iQXElhnE4XC6zmGsS8+4aie0/5EYZBp5ORtLV1g7pkC7eSqBakHlT7pN2uQTIMLlAupjtL28dSw9ZmA/qlgCWS5SlRDEZLbr+lQlXI90HhKXGk7k8IbRGvF1sfJpm2b+Yz20DhaqwhNCYQh5pPs54DMgEZQ7hboYp5Q8WGzKmsDcgt1ZlhKEZzCTEvpggch8ViTIQevZWBsMsVbP46Jj3NQuMDJk8jpq7LlO5AHKO6Grz1GPhX5QMpuR+WTBZiwtoBoiN+3LWA87AD1dJICMSQSlbwufgrKdtYagXOvYHr4mLWljo0Ep+YsCqIlfGmncQ87QnTSYD2Ocdu/cFxo+JoCURO8g30GTrrAIb8OU29HwSXHnIp6iHLWYVwXlo81aZro7orqjyq9/2h2VseifNOQAPcbv8lSH2uzo2vtn5Oq0PxAI1owrqRlDRpMQEBIdnHYqDBVsaKoReMix+rAcq2U4jUk/ApwSgRXyssTtBSwhXMH6TQ2mtvgI0wXc0czegzwNmI9DMAFvCw8TBZ6CQJUQxkKSa+wbIsCShU/TRC/3VehsgWX1OLcNQPDpfuwMmcmZ5xeLsAuz9xfI9adlQ09oWsR06WpgvSkodYcPMHV0Th5bFP3sn2EEFjh08qG/de8m3ZoCK2LDQOM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(3023799007)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xYbafoCIQB5X6IZ6wv0tvV6xC0WFXWHqkU+IxAx0kqPF85FAzd0hgjkEZUcAAjw0ww/XPhR9mvqOfyn0s8qmm3pD420m4OM4/t0t1BQtXhBJEhWHxG2Kxa26UJR/uwMZ6mSzB8hmuBkz+3IfJ7RcyjLB3Z9ktbZC2dt86SzJhWt4+tVUOh6zQ143C6K80AtbIsXODWPkuEjIypaZG1515jV5mXsWOxOK97scC0Mg0U9vacJLDz/b6CDF12+kv18rXtUJPi421MIOliaQOY+C3Ozb0tccjEjV3dmdG+mMvC6yZzmZysR5jWhjjOXPNiAJfztKFGuFULP5KRq3BhhGlIdkuNk9IjxfsLpkLkUzgb9PgGO6Lf2QzDy7Li5MmGDZpuGwSxFuWvVVhrkFAWBFm/k77pxLnNF/o6i5xRTW80ng8RUxjnbRsf5dJLOMTMwk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:57.3942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc86b6c7-e257-46ce-5096-08debc78c240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192

Introduce a new IOMMU_VIOMMU_COMMAND ioctl, to support vIOMMU-specific
commands. Initially, the ioctl support set / get operations on a specified
index to write / read value. This allows write / read access to a
particular index of a data arrays such as hardware registers.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 ++
 drivers/iommu/iommufd/viommu.c          | 39 +++++++++++++++++++++++++
 include/linux/iommufd.h                 |  5 ++++
 include/uapi/linux/iommufd.h            | 34 +++++++++++++++++++++
 5 files changed, 82 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6ac1965199e9..5cf839a4405a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -692,6 +692,7 @@ iommufd_viommu_find_veventq(struct iommufd_viommu *viommu,
 
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
+int iommufd_viommu_command_ioctl(struct iommufd_ucmd *ucmd);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
 void iommufd_vdevice_abort(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8c6d43601afb..194f6409ce53 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -432,6 +432,7 @@ union ucmd_buffer {
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_viommu_command viommu_command;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -493,6 +494,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VIOMMU_COMMAND, iommufd_viommu_command_ioctl,
+		 struct iommu_viommu_command, val64),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index bc58d240fafd..53f9a7d2734a 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -477,3 +477,42 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+int iommufd_viommu_command_ioctl(struct iommufd_ucmd *ucmd)
+{
+	int rc = 0;
+	struct iommu_viommu_command *cmd = ucmd->cmd;
+	struct iommufd_viommu *viommu = iommufd_get_viommu(ucmd, cmd->object_id);
+
+	if (cmd->__reserved) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	if (IS_ERR(viommu)) {
+		rc = PTR_ERR(viommu);
+		goto out_put_viommu;
+	}
+
+	if (cmd->op == IOMMU_VIOMMU_COMMAND_OP_SET) {
+		if (!viommu->ops->set_command)
+			rc = -EOPNOTSUPP;
+		rc = viommu->ops->set_command(viommu, cmd->index, cmd->val64);
+	} else if (cmd->op == IOMMU_VIOMMU_COMMAND_OP_GET) {
+		if (!viommu->ops->get_command)
+			rc = -EOPNOTSUPP;
+		rc = viommu->ops->get_command(viommu, cmd->index, &cmd->val64);
+	} else {
+		rc = -EOPNOTSUPP;
+	}
+
+	if (rc)
+		goto out_put_viommu;
+
+	if (copy_to_user(&((struct iommu_viommu_command __user *)ucmd->ubuffer)->val64,
+			 &cmd->val64, sizeof(cmd->val64)))
+		rc = -EFAULT;
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index c0030677e13c..ec3563f4c09c 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -183,6 +183,9 @@ struct iommufd_hw_queue {
  * @hw_queue_init: Similar to hw_queue_init_phys, but driver providing this op
  *                 indicates that HW accesses the guest queue memory via
  *                 @hw_queue->baseaddr.
+ * @set_command: Set data on the specified index of the specified vIOMMU.
+ * @get_command: Get data on the specified index of the specified vIOMMU.
+ *               On success, the value is returned via the provided value.
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -198,6 +201,8 @@ struct iommufd_viommu_ops {
 	int (*hw_queue_init_phys)(struct iommufd_hw_queue *hw_queue, u32 index,
 				  phys_addr_t base_addr_pa);
 	int (*hw_queue_init)(struct iommufd_hw_queue *hw_queue, u32 index);
+	int (*set_command)(struct iommufd_viommu *viommu, u16 index, u64 value);
+	int (*get_command)(struct iommufd_viommu *viommu, u16 index, u64 *value);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index e08de6ab8209..a2195b1dfabe 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_VIOMMU_COMMAND = 0x95,
 };
 
 /**
@@ -1131,6 +1132,39 @@ struct iommu_viommu_alloc {
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 
+/**
+ * enum viommu_command_ops - viommu command operations
+ * @IOMMU_VIOMMU_COMMAND_OP_SET: Set the command's data
+ * @IOMMU_VIOMMU_COMMAND_OP_GET: Get the command's data
+ */
+enum viommu_command_ops {
+	IOMMU_VIOMMU_COMMAND_OP_SET = 0,
+	IOMMU_VIOMMU_COMMAND_OP_GET = 1,
+};
+
+/**
+ * struct iommu_viommu_command - iommu viommu command multiplexer
+ * @size: sizeof(struct iommu_viommu_command)
+ * @object_id: ID of the vIOMMU if required
+ * @op: One of enum viommu_command_ops
+ * @index: Command index to match with the value
+ * @__reserved: Must be 0
+ * @val64: Command data to set or data returned on get
+ *
+ * This multiplexer allows controlling commands on vIOMMU.
+ * IOMMU_VIOMMU_COMMAND_OP_SET will load a command and
+ * IOMMU_VIOMMU_COMMAND_OP_GET will return the current value.
+ */
+struct iommu_viommu_command {
+	__u32 size;
+	__u32 object_id;
+	__u16 op;
+	__u16 index;
+	__u32 __reserved;
+	__aligned_u64 val64;
+};
+#define IOMMU_VIOMMU_COMMAND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_COMMAND)
+
 /**
  * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
  * @size: sizeof(struct iommu_vdevice_alloc)
-- 
2.34.1

