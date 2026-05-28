Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EE30F92E
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945597; cv=fail; b=oZLQE+foB9lnVYimztLGbFh1o/g7UCsxEAsoqlY9R7w3bG0G0cJefIuosz3hIpoA9z9S/fJFL3IeVsHQNYFEdtT6D1mID8z1RkgQNSAgZSCHuXWTPBnX6x/QU2ZllniIvSoBX/9qNbWiWmYo2Gq85sTLp4Ca8uXTje+NspIvvAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945597; c=relaxed/simple;
	bh=iLFNT5uuof/cR0tkfkV0I3EawBYtNAfS/w4qqjE1chg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoJcnaxCZ6jmPQjWcz4zGimtgbDW0ibRBAmxJ7H1U+6Jy29dRKbDSgwWnIASpS6G5myEA9JFOnrZUEWxD5iCToM39ryfPItth9mhhR3aAVpniDztioMVzYc3pildQQdyqnHnDSFX9+aj8FYtExhmHNWyPV1tDUvep3Yo8eCfjeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2ON+th03; arc=fail smtp.client-ip=52.101.53.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2ON+th03"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysWHr2MMSmR2vPTmeLM287bx1u8DcdZoQRxhpXrNQOQfP1GSkKVomqzRrNh+UF/S92/oVljqHI6g0od8R6/ATsmLNmCE51Ws/wWvat5YQ8lIklMVnCMaRmuR488Ox0p8YqVHsh3j4el6yHHenwQoBr2WfRMmo2edQM1tqXbghvoLoJnw/C5+UpMcYXiO85dtNuJ6t8GEr8YIPzuSX2t8FaWdduFPCnQM0E8ILozE+RMDsUZzeik9U3ar/K1A1w3yKR9CAJUIQPbYhu2rfGp1jXm7PRpeWI4myoqKKC9qMwzfh1KugIUs6FnNtnjsoxrISFyuZqMEmyneaAiOW7dlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7F06jwZqnK7p+n/QixpygG1qmq4KGtepiaBzCgZWaY=;
 b=BpXF4Kg2zjIKEhcERdxfVPNxQS1a4zkYfm9ROKsiTOtEpyyC1T2hnGUZqlHR8p87sDe9i6XLuCKrmGy/WDHsDdaU/wEC0TXN7z9c5SXGnaZZCllUCKu8m9y1ur/etmNAttjnTRH0ip4/uVB9KHrBCMSSwVfjKu3DartzdlQK0omcZj4r8HQJiVMC6UvgM8kiElN0bPiO9vPuasHTcFQihGuMv6yQpoPoJluwLU4Jgf49hX6WicV9AbZfDWCW0THeseO8tJLfgcL1TmKN3W+3USu+i/wvcS1SPWtwz1nWEHT5kNgvftP4a3JKrUWFHxwKFGCmPWIhwNf8d0vLnbAk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7F06jwZqnK7p+n/QixpygG1qmq4KGtepiaBzCgZWaY=;
 b=2ON+th03/87fLxEjA6pEtI0U81WayvpSwUSPELh7AeSJEdmtU0vsQgcDKcE9mMPLcKfTV4Bq8Nocw7AW1wQcSXKp5NDfjsF/Sjfj6cc5qGSzhpaYQBLMBMuRTlsXeUaj2ega90JoK0k1ANz/eK7kPGLEgGOh5/CrMEPVDd3KhEY=
Received: from CH0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:610:11a::17)
 by DS7PR12MB9502.namprd12.prod.outlook.com (2603:10b6:8:250::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 05:19:48 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::8d) by CH0PR03CA0354.outlook.office365.com
 (2603:10b6:610:11a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:47 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:43 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 22/26] iommufd: Add hw_queue_init and split queue alloc paths
Date: Thu, 28 May 2026 05:17:34 +0000
Message-ID: <20260528051738.596013-23-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DS7PR12MB9502:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0a947a-780d-4fdb-4622-08debc78bc9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ts6m3wWF5AQDseHO9EBaigo/fLuPVWtWimbnrtTneJSw53GxCTObt6u8HaUOHhX0d8Jo5AG1R+RqpZzCVqwfnFrGspzLdewrHJKzdOxk3QeP4uB37t88SvovccAMWwkm0rFczA3576r8+pDA4WFX0bcDeHjDOFO/rRmXhNTIAmfLQk3s2FgDLcK/dpuXAojA93/87/b6BNvWeLT/Yyz5vFRp33Mpbx7dw3ra/dUVd94lgA37JQdlG+SbafpnjT0TSVObpvvgfD2xAfVx5aaora4AV8Ua2xUmEfjgJbpLGGwsg4vTpP4LGOniLrIc50Cr25a6ftElWi0X/CS0SmLmV+rRn8giYEqfRAIqBs6r3M95RZW5oe06EHG9sr5x5310UbgBqbclF4tJ+vnrwc60KNk3QIlNrpKlXZM6GszBWTKcP5WvelS6kBC2TvdPMi5kYUMyvSW8h5on1GKWe6FmE2Jz4yAjbFMQFLvyWix/iHpeL4aCR9H8eH5Efe77xAEirQv5WbcRpaQqNtgHwWRXw3qSlgqn1PYB/0423R5mgzdUiFvOUZO6M2wTAc0zzLkc0eeHxn5sq4oGh4Qy0mFJfRKs6HXPUC6rOVf24g6slFOTC76vViA9ITQhrt6y1zVklnkYfJVdhlBkfQ9XQt/e1iuvw+215M2XnVzItjB0LVNP4k0h8yTZ9Cr6Z1EgQnNaIL2OUT28bR8WFAPINMw016Wycmu0D0PkBQqrMViuLT0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BxchjsE8YobIHm79jeTKY+pcKRGRP3pDw1WSvyL8rj2dhRpw901aMhIF6IYy1f5CwMGrHKRIcIy4OVwVWn8WmeBZ+JjOjmz18e3zdwHiRFrKLfTk58pfHj+/ZKk3Uo0DNeK9TiRloFAFwB1f9UjfmS/8YQOkCigTunCPhLEvbHTEkl0n5ctbXxprI7ZpvTh/35GyDfrlcnfO4eLFcQXdWkXV6PehI0NMg66esnch+ZeS55Uto9+VPguLdj2W68dBMZ9se6Ze08/6F9BUS0IiYiErwKxS/IyuEpjyeG3CMcvKrx7Ue1USqVxueKunKQIZSTw5rmt/NXpubu27ICCXlSGAp4MbOWQQEW/NMpifg4kg5HoispgNmgByDSfv3cqkvebH8M8yi+y0nztqNwN1d8YZLobnI2LcXNVM0x3tlubzFr10oNao6IBYRhEc/kHf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:47.9395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0a947a-780d-4fdb-4622-08debc78bc9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9502

Add iommufd_viommu_ops.hw_queue_init for vIOMMU backends whose
hardware uses a guest physical queue base from hw_queue->base_addr
instead of a host physical address.

Previously, HW queue alloc always went through
iommufd_hw_queue_alloc_phys(), an iommufd_access, and
hw_queue_init_phys(base_pa). AMD vIOMMU instead takes GPA from
userspace in hw_queue->base_addr and programs hardware without host PA
resolution. Splitting helpers and dispatching from the ioctl keeps
one uAPI while making the contract explicit. Each vIOMMU driver should
implement only one of hw_queue_init_phys or hw_queue_init.

Refactor iommufd_hw_queue_alloc_ioctl() so shared validation and
viommu lookup stay in the ioctl, while setup is delegated to
_iommufd_hw_queue_init_phys() or _iommufd_hw_queue_init().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/iommufd/viommu.c | 125 +++++++++++++++++++++++----------
 include/linux/iommufd.h        |   5 +-
 2 files changed, 91 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 4081deda9b33..bc58d240fafd 100644
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

