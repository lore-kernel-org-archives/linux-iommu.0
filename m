Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873E3AEF42
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860270; cv=fail; b=lXyUN9ijTVNLQvA4uD67TRFjHM6DP+TblbGsRZsdxqBwXQlD3pQgGzScOlrNTGiRLEIWyPgxRdTvZsJm+h4zcC5Squ39nPPs8bTXDAKoCN+eaEMRLaM/LEniA5mq1bk6w0/Swnn9yLe/25jj69LAufbCePOg2QJLZbecqfz6jms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860270; c=relaxed/simple;
	bh=72rfm6p19vDj5kXAlQlwjCXixutklzU4guHA99KQRMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhZ8QGAYx2t+/GWsAGF4IuTdUMCGhxcICG58/GNrzNZjkXg7FAclJuyrIvnIZ9m0LnPTnqaNlYZ0EzddZxxHx4ViHiOW2J9FtiiVL4qtnlTDYFJK9210MniriutpDcV47xobiuAyRnNrNd00pvPfEkGBVzELvqbmOSH7bHW8k6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vNfuqe19; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vNfuqe19"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXt7jY2lJtYMnXdSKtK5sa/V2zJ4F4JvjvEKoGallyFg1xagnfZKxnAMIfoYf8f6KFI8X59UIGD09lzx7P+D1cmKUuveHmO9KZozJF42gATeEQ/Z6LP+iYakljoak4ob3nSTjyKUUdD3IHkicjtYuDPFEtgC5N0xz+u1cvzLN8Ej0onW6mN9+BIB6XjYu3QLZ+9h/2FG9NV+7eDIyXC5q66meM4lyROFvkA/iCd92Af6ZnYZeHJqyDw+9U9QPbeJ/APUIa2LlMLdPV3JTir4IwO7P1S8s15aQEhc4vbeRQrLkhEaPc4QiEIXPQwLbnRi8kBeyshVCky6oLm/m2iNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8GFH79h+B9bXlNsPF0JYIllthU9TkffHxweL3wRaMs=;
 b=F0tLYvDyTfPE5W3OGlofBURrkNMbQeKzCZ+Sti/ihlUw1qcMEDbYgOFD5YVR10Es0ymd6Rqw51OI9JTqN3cNgqySKlY/v0FT7SRPGZYePLI9WFbUdPms59GTHY5BKRqhkQSkf7PfCKErWBPb782iuramdIgBt7iBIXTkSnz00flkoCY7a1vSl0bLcrYPUEiPe5RXnkignMK98ZTOH8VzV9rYDq5oL5tO3Xp/oGIwL9qnFzW1Wb5/Hxl9D0ZwDeekXMQLncsVxT8ixHhF4ajq1AdRVd8oY4djDVtOu13DfI/7+R97dgr8IwkVcgw6D/sTMfs6dxuORXBC0NRnW6tkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8GFH79h+B9bXlNsPF0JYIllthU9TkffHxweL3wRaMs=;
 b=vNfuqe19LTmA1w4JqlX0NxaH3n/3FyHNJu5e71Jp09G9D/wT17UfTsAgsx7ZLP7TFa86EvVso0t+51/b+tHCb2xxNCZTxfztKLRG4iUvZ6X3c3Yq49aFVUp7/uuCt5GyUQpNa3UR7P5ngMQtv2ABz+/Dd4McEadT5M1LwdYQz/U=
Received: from DM6PR08CA0002.namprd08.prod.outlook.com (2603:10b6:5:80::15) by
 SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:44:24 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::86) by DM6PR08CA0002.outlook.office365.com
 (2603:10b6:5:80::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:44:24 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:44:11 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 20/22] iommufd: Introduce vIOMMU option via IOMMU_OPTION ioctl
Date: Mon, 30 Mar 2026 08:42:04 +0000
Message-ID: <20260330084206.9251-21-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: fa76ff07-7a1b-48a6-9269-08de8e388b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3IY7uiT3poYkA5zU9yKblPt1kfDg/AODa5oojcqO12lU9BPk9F6iiXHMffDVovW+FWl687i5qJrlagRUqDiqBGnsNJ16G1HAhzdZsAR+H7fMBsQMokehbfkQCKqLY3LgXRMlB3Jv6ZbeFmmfFmjHJkOW6l1n1flpkmXQZx8gQi8ninc62zO+Yj28X3+DtOo6WW3nYY85hExIPkBYpHIZmIttyXYvLVJ9zhQleVesmwr99BBQohJAH2duUaMzW34NPWKtMLZ4PTz0Lw8RVJyAD4jI/xH+xnye7KMdlrNhe6dW7+AQ6MFyX3LSpFZhyMXGI1iFI4U+tdR5VukCpfSO4CdQP6lN5Ct+SuGJ4FLT7Wxn4p9/wMU/ExnJcUcYcrAYuBwCGjB35fonmDgzBZi8ngye8zOQpczCS6JxJuBtpHt2ElC8LHLHHwAjX6f6YyIRW7pwgGmEor658FU7e0QBuRR5xl/ndDqMZlTqCSHlwVyBzlgU8egnUFacBUQhIsovbIhlTG7VbW4GVowmgVKBUOwsh6JWy+xec3OJs/bh1MtmLFK3DKuqmn2vP4kvRVo2MGqnFd2Un6lNstbrL4NTcTv1FMygwUCeBVKzxxsfp2F2U9RhG+GsBDdGMoZX0W8vWIF15kmsMD0ITjBX/AmLBae54tJ+ZmGgpExAAQ2Ff19Bv5Pg1TcSaWbHPzA2Nas3LqFCNr+cQLQRU4QMNsEvXdoU/4rQwNDTLLfG9OA0iGqoYoBPmTdHuuLNUxi1XYlPNQ3JaOd4m/X/0rCpe4s8Nw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0bF9wmQhA/P5zyYvRQuWzGyfkq9TUqS208441QuWxR2CP2xUqmTja/CJ6M8vZPOdbcE7Rc3/LNbKMw9+O9XNz7x1ivXdKZRpKcptHLbUkF82QCn0Fdzpdm/R0wiYiSAEbLgPhduxQNdqTCD+7wrBs99LjOcz9od/XRsqYuIQ9oeSyJjvB+X4J/H0zF/qFttSoFm2ej/CMhaZMo0vCc+FTpVIUpMdV+j8C4H3wp2BnPYGViampAFjEGbucpjzYMIuI95Sf7olzS+hFGJKhVHO1Z4v1VCRAD5fy2ibY7s8NHKFGjLIVBXCEOsMQ2jCQHu6Q2OOWQLCLpbRP2VZeUi0eZhAU32ZXw6eLr39gg/d1FiKg5P42i48KjSF4ZzLXcXGRAPwgRlzIersq0HG6gjN3eAtYSDqK+X2L1ZaEJe/XCk7vk3RHuZ8QxlACGdSGRsb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:44:24.3295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa76ff07-7a1b-48a6-9269-08de8e388b92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106

Introduce a new iommufd_option enum value, IOMMU_OPTION_VIOMMU, to
support vIOMMU-specific options. Extend the existing IOMMU_OPTION
ioctl to accept key-value style input, enabling access to data arrays
such as hardware registers.

Additionally, introduce struct iommufd_viommu_ops with set_option
and get_option callbacks to support IOMMUFD vIOMMU options.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/iommufd/ioas.c            |  2 +-
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  6 +++---
 drivers/iommu/iommufd/viommu.c          | 18 ++++++++++++++++++
 include/linux/iommufd.h                 |  5 +++++
 include/uapi/linux/iommufd.h            |  8 ++++++--
 6 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index f4721afedadc..95547630fd3a 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -643,7 +643,7 @@ int iommufd_ioas_option(struct iommufd_ucmd *ucmd)
 	struct iommufd_ioas *ioas;
 	int rc = 0;
 
-	if (cmd->__reserved)
+	if (cmd->key)
 		return -EOPNOTSUPP;
 
 	ioas = iommufd_get_ioas(ucmd->ictx, cmd->object_id);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index eb6d1a70f673..0306f2b8236f 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -698,6 +698,7 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj);
 void iommufd_vdevice_abort(struct iommufd_object *obj);
 int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
+int iommufd_viommu_option(struct iommufd_ucmd *ucmd);
 
 static inline struct iommufd_vdevice *
 iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 5cc4b08c25f5..ae36a6e8042d 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -391,9 +391,6 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 	struct iommu_option *cmd = ucmd->cmd;
 	int rc;
 
-	if (cmd->__reserved)
-		return -EOPNOTSUPP;
-
 	switch (cmd->option_id) {
 	case IOMMU_OPTION_RLIMIT_MODE:
 		rc = iommufd_option_rlimit_mode(cmd, ucmd->ictx);
@@ -401,6 +398,9 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 	case IOMMU_OPTION_HUGE_PAGES:
 		rc = iommufd_ioas_option(ucmd);
 		break;
+	case IOMMU_OPTION_VIOMMU:
+		rc = iommufd_viommu_option(ucmd);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 59b31b3e36be..51585337b8e4 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -477,3 +477,21 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+int iommufd_viommu_option(struct iommufd_ucmd *ucmd)
+{
+	int ret = -EOPNOTSUPP;
+	struct iommu_option *cmd = ucmd->cmd;
+	struct iommufd_viommu *viommu = iommufd_get_viommu(ucmd, cmd->object_id);
+
+	if (cmd->op == IOMMU_OPTION_OP_SET) {
+		if (!viommu->ops->set_option)
+			return ret;
+		ret = viommu->ops->set_option(viommu, cmd->key, cmd->val64);
+	} else if (cmd->op == IOMMU_OPTION_OP_GET) {
+		if (!viommu->ops->get_option)
+			return ret;
+		ret = viommu->ops->get_option(viommu, cmd->key, &cmd->val64);
+	}
+	return ret;
+}
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index c0030677e13c..8096b7e59088 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -183,6 +183,9 @@ struct iommufd_hw_queue {
  * @hw_queue_init: Similar to hw_queue_init_phys, but driver providing this op
  *                 indicates that HW accesses the guest queue memory via
  *                 @hw_queue->baseaddr.
+ * @set_option: Set the key-value option for the specified vIOMMU.
+ * @get_option: Get the key-value option for the specified vIOMMU.
+ *              On success, the value is returned via the provided value.
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -198,6 +201,8 @@ struct iommufd_viommu_ops {
 	int (*hw_queue_init_phys)(struct iommufd_hw_queue *hw_queue, u32 index,
 				  phys_addr_t base_addr_pa);
 	int (*hw_queue_init)(struct iommufd_hw_queue *hw_queue, u32 index);
+	int (*set_option)(struct iommufd_viommu *viommu, u16 key, u64 value);
+	int (*get_option)(struct iommufd_viommu *viommu, u16 key, u64 *value);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f71a4b979d52..922bb7511045 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -306,10 +306,14 @@ struct iommu_ioas_unmap {
  *    iommu mappings. Value 0 disables combining, everything is mapped to
  *    PAGE_SIZE. This can be useful for benchmarking.  This is a per-IOAS
  *    option, the object_id must be the IOAS ID.
+ * @IOMMU_KEY_VAL_OPTION_VIOMMU:
+ *    Specifies key-value option for vIOMMU object. The caller must specify
+ *    vIOMMU ID for object_id. The allowed ops are set and get.
  */
 enum iommufd_option {
 	IOMMU_OPTION_RLIMIT_MODE = 0,
 	IOMMU_OPTION_HUGE_PAGES = 1,
+	IOMMU_OPTION_VIOMMU = 2,
 };
 
 /**
@@ -328,7 +332,7 @@ enum iommufd_option_ops {
  * @size: sizeof(struct iommu_option)
  * @option_id: One of enum iommufd_option
  * @op: One of enum iommufd_option_ops
- * @__reserved: Must be 0
+ * @key: Option key to match with the value
  * @object_id: ID of the object if required
  * @val64: Option value to set or value returned on get
  *
@@ -340,7 +344,7 @@ struct iommu_option {
 	__u32 size;
 	__u32 option_id;
 	__u16 op;
-	__u16 __reserved;
+	__u16 key;
 	__u32 object_id;
 	__aligned_u64 val64;
 };
-- 
2.34.1

