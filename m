Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42983B0AFA
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860267; cv=fail; b=u9hBj+Bcq28Yk5i/NW6pdhzRkIn1+Y4Fg/cuj380OW5QxuUOXFsnwcLle22zqwoUJrpA2seNPagL8w2hexIt5DXn0v2jsAbsmmc3y+V4nY3bHR/Qk81qVt7U33xyBwAoQcTVyX27LxRSeXSq5tJXxVc5VyaflLBfYGyffOx7k3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860267; c=relaxed/simple;
	bh=ifBSjmewLJEmieHc/m6Ve2TibXvtu04oDFTgK5512LY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UamrmuVHT//09p052yaLlwJvK1zRnM8dbwPtaf3/kyVWGLcCmLIwT3TFfdxfaVja/5NLxsS5/pnD88QqYSsRLrWbc5m//exa55wc8Ax94ShNqZtsEsjfAWa/dFejo5rp/2hsP02LfSzTMDrgYu6Nj3V6G6g+LUiUnS1sS+UUqgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W/r57ar5; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W/r57ar5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4zYPFB9t6bv/EH6fFZhCGK1KULFAplBdmznwWjqnHgqizyjK8GiYE6FtdtO/C2bEdH3GeIdb2ypRM9qp8fcDom/zCp5kGIxwrRcejMKYuxJHZzhQOwlIqLu2ViDjkqGDoHaF225HNXTmQetES/+gwpKUiyZP5qmPaFPUwiTTdQ1Fnmhg7zj4hFSLemg+/72pEbaBzXpFRh1RJi4MR832/p/Y3zWtElrBYN6yszkR8togUzevogSD1SUViiViE+Z7vD7it/LB7oACUf1Ng0MzpVSVF5CLwhCaosbwhSi+Ev8NN5SYIgW9IRnD3LVt749wg7UIvofsuEjXorXvtwNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuYaBMnDgW2DDVMiyxA6NvKA2f0nC5R7M6Ek/mGiYg4=;
 b=XbtHZvV7ksJQPIXovFGzB21OMjSHMNgt/Xr+mXybHOm0BMbwonTbla4ZKfx1fMRLe8QKKWtVI2XXEzx0YK/3g6DyyEtQqZA0hSRk5xWR+HCuLjWaflIFYUzXnmrXPznRSChvP+V5Aa+N2FV6xq88TohuRtibyDjr5RZFxGXFJwx96IMVYp97XQwxQi8fLlzlaImEA2SoX4Y1e00tu9DWcUt+5WuapS24KaujT8d3uqVtMcTATBnUTK+gDP5d2H++Qa4G+UICLpLjMUMWXsx6GyX+kJ8+dRUe4kMuyCOYK13vB941v3fLDRizuQ9ZHQLexMTBtqPq/8xynPVoJT7odQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuYaBMnDgW2DDVMiyxA6NvKA2f0nC5R7M6Ek/mGiYg4=;
 b=W/r57ar5b8vgr5duWGcB7YJOYCBPniLnotn3kN3QDDb/S1MioFRrWNeeB+HJTBrj1M1d6CehQIpot35oGsSU+l8+YpL174Z1DhZL/dfhM/f1LY9aomBo5V6wyD8xiCtSFF7AQi/bKsseN/br3WDqTaltMAymzzxx39TnGPBu5xk=
Received: from DM6PR08CA0030.namprd08.prod.outlook.com (2603:10b6:5:80::43) by
 CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 30 Mar 2026 08:44:20 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::fd) by DM6PR08CA0030.outlook.office365.com
 (2603:10b6:5:80::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:44:19 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:44:01 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 18/22] iommufd: Introduce iommufd_viommu_ops.hw_queue_init
Date: Mon, 30 Mar 2026 08:42:02 +0000
Message-ID: <20260330084206.9251-19-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: c371c87e-f6c9-4bcd-408c-08de8e3888b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	i3FzjVCYMduT8fHRwEeP+I2N1GUNGYGDca26WR+WUoLT5MpRlixXRt3hW4f42kFRAR13BPpKJOXMKxg62qlz2xWORU5dVYdAIxzNtfp4ihZNqjleuiqdrcvwg+cjAFEvvzn3wpcuEDzghes0KBBCf9gU5tSjcx9+n9seC1MIPEiFtF0GF+bHmMZYOboyByS4w5xNtJoUiVGnbjaT9SfJ5yMCS272BtY+A+Z71ahS7Wf7mScFPAwlm9SC0Mm2Ssc+qSK+1PlEWgZtgJ5s72O/yty+ZNXv6nsX9xN2q3E/YUmVwk0lt61H7BgzOMV8UIKmfKEkAQN+a+aHZKn7OBzh/QxKGIy5ydUW/tvT0H3DCNu3b0CpLyEu8p5ItW9PQrSyi6qsqumSCK+LLeckSuNbIYoNOFFPmODBALR7CF2YqjJuCuWHuoYi59s2HOoRMq2FI6/0XcoDFh3PJ0CAoPro24Oz4cwSMXb1m90FvChhjAx0juZL+9E9HUA4E2P8uI6/qD6DK95/BONDFnZsK1nrUpCEqAA1GVOQLFRwXKBtJtWmv1Db/BaU8nyfq4V/3N4xDW7MVDiztihxWXg82+f1fH/YqjcFiNpRkcJdaMMIY8qLD5ai3KyTyh3dmgezoSAnuFMAoqz4ECbDkCnniTtrWI8lOTdFxJZFXiJngOsVY7Sh3CAPgSnE2t+2uEGLmw0Lm3K44MHnsfBq8pTNzR9oMXOgoIdagAy8cQ137EOQbMrgFB2rBewU5tpM2MfHvjyNZRRHaCCLNwmONQu36LcwqA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zk66W1rDPpWfumvGxhV8C4rPIangToNl5qaPjkgdGHxq7Qcojij6kUhsdZeL6zPthtD86HDCWimJf1ae524lvvAniaJVLPTbyrA90aLU2WDyP8xWx0LrqJ/xKSp/FgmYulkPSaJganFMoX6P6/Xgs8XXmNAu+zE8w5EFJT7OYQ+Ra1X/NBRIiUrV+7Om4yEwIRdfpZYsXmqqDrq55jvkfJ5fU33wDYZKJ74bDvnSdBihUcHYOqfuX7+LmEP5iEJA6YIIhHiH1KvSRfDlUF2a3fVQv77NGb0EtqwbJkgdEkOftfOftvXnm2NO1FAZvykXo2y98vaKFvu6IZeAG9ky/ERyNcTXNJCaumfpozXSx8Dzo72B0lIf0Z8QCby8Uw4v8ST3dvlNnryvp2SGbbB8LAsH493+LzQT+x0htZolviFqdolmvp8kxNKpH/JY6QjP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:44:19.4944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c371c87e-f6c9-4bcd-408c-08de8e3888b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645

This is mainly used by AMD vIOMMU to initialize virtualize hardware queue
using guest physical address where the address is specified via
@hw_queue->base_addr.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/iommufd/viommu.c | 125 +++++++++++++++++++++++----------
 include/linux/iommufd.h        |   5 +-
 2 files changed, 91 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 462b457ffd0c..59b31b3e36be 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -353,62 +353,35 @@ iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 	return ERR_PTR(rc);
 }
 
-int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
+static int _iommufd_hw_queue_init_phys(struct iommufd_ucmd *ucmd,
+				       struct iommufd_viommu *viommu)
 {
 	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
 	struct iommufd_hw_queue *hw_queue;
-	struct iommufd_viommu *viommu;
 	struct iommufd_access *access;
 	size_t hw_queue_size;
 	phys_addr_t base_pa;
-	u64 last;
 	int rc;
 
-	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
-		return -EOPNOTSUPP;
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
-
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
 
 	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
-	if (IS_ERR(access)) {
-		rc = PTR_ERR(access);
-		goto out_put_viommu;
-	}
+	if (IS_ERR(access))
+		return PTR_ERR(access);
 
 	hw_queue->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
@@ -419,9 +392,85 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
 
 	rc = viommu->ops->hw_queue_init_phys(hw_queue, cmd->index, base_pa);
 	if (rc)
-		goto out_put_viommu;
+		return rc;
 
 	cmd->out_hw_queue_id = hw_queue->obj.id;
+	return rc;
+}
+
+static int _iommufd_hw_queue_init(struct iommufd_ucmd *ucmd,
+				  struct iommufd_viommu *viommu)
+{
+	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
+	struct iommufd_hw_queue *hw_queue;
+	size_t hw_queue_size;
+	int rc;
+
+	hw_queue_size = viommu->ops->get_hw_queue_size(viommu, cmd->type);
+	if (!hw_queue_size)
+		return -EOPNOTSUPP;
+
+	/*
+	 * It is a driver bug for providing a hw_queue_size smaller than the
+	 * core HW queue structure size
+	 */
+	if (WARN_ON_ONCE(hw_queue_size < sizeof(*hw_queue)))
+		return -EOPNOTSUPP;
+
+	hw_queue = (struct iommufd_hw_queue *)_iommufd_object_alloc_ucmd(
+		ucmd, hw_queue_size, IOMMUFD_OBJ_HW_QUEUE);
+	if (IS_ERR(hw_queue))
+		return PTR_ERR(hw_queue);
+
+	hw_queue->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	hw_queue->access = NULL;
+	hw_queue->type = cmd->type;
+	hw_queue->length = cmd->length;
+	hw_queue->base_addr = cmd->nesting_parent_iova;
+
+	rc = viommu->ops->hw_queue_init(hw_queue, cmd->index);
+	if (rc)
+		return rc;
+
+	cmd->out_hw_queue_id = hw_queue->obj.id;
+	return rc;
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
+	if (viommu->ops->hw_queue_init_phys)
+		rc = _iommufd_hw_queue_init_phys(ucmd, viommu);
+	else if (viommu->ops->hw_queue_init)
+		rc = _iommufd_hw_queue_init(ucmd, viommu);
+	else
+		rc = -EOPNOTSUPP;
+
+	if (rc)
+		goto out_put_viommu;
+
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
 out_put_viommu:
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..c0030677e13c 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -180,6 +180,9 @@ struct iommufd_hw_queue {
  *                      the physical location of the guest queue
  *                      If driver has a deinit function to revert what this op
  *                      does, it should set it to the @hw_queue->destroy pointer
+ * @hw_queue_init: Similar to hw_queue_init_phys, but driver providing this op
+ *                 indicates that HW accesses the guest queue memory via
+ *                 @hw_queue->baseaddr.
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

