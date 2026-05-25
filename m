Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE173806D1
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735107; cv=fail; b=utc9PSjm/MpUPcsrJ1d1hU7tVt2mz4Ka8nIaC+bEkF1iWdmATV8EAaVMp4Cp4YaxS9h1ifXpOE4LRVgnHr9kYmb39Lwboef0Evp8KfTJcLo6U6gBTFpOZGlqR028h5R9YtI+F+wFnlf0xqe6Yi3AsZ4YIyyeAuAhvbGYS4FSEpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735107; c=relaxed/simple;
	bh=Hicg/mnhVyhp0VygffGmwl06G+9sw6MQVjT1n/PbDAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pO449TbSRggDiYkUcqp4ZBWjYuOPhGyU+j9oibNoGj3xw2olOMnXrFVFzGuewAGNk/HR5cZRWMKbCyj1kiXn8rgUs+Lcg+FPTRaGDYZXphsoqCOBmpP5tZTUiNqOIE+24eVsi2j+xpiex6nKig+LtAx6RuqbxgMBWRn1CbuLR1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tu0rW/MB; arc=fail smtp.client-ip=52.101.57.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tu0rW/MB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbcdZ252FNV0GBuDypXvJvEcrfmGSngG/i9k3jQ2FbAMo/gyLP+I93G+gROWCoysIhSfORPJhjjXay0//swkYQ1GXVc9UE5nzbsxjiax+FLnyT4ougGcMw9RjYAwNC+z6CWpftTqqZpB0U7++IoUKlQS5AGsoft4qTaRwhgevBlPPG9Qx8ZBd6gPjNtMna1NEhL/knkC5jEi+OYPDhX+Oq161monPsSXESQB8DMm/1ofJWVR5ISUh4xghSkzZYwRGCCWtrpSC7U6TduxOc7kaUeOJND0WVFPdFpNj2HHcdP741fHgLRcFI7rb61vIqag2isftI0k4a7hhbCyx1goBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWBUZ0cOFWu85E7Y+mODB/8qE9vkwgxADRmEoehmOBs=;
 b=i7JboYaERlQqfmE21S7ZBh9VfmFtGnfO0DaOA5WjeDuHRZepGVMznYSVhQQvB6GmGGmBZYF0RacYFfRmdJm2O8JuzbqF/AEiZmab9d0DE0vauzCWojsiS+fZ/YxZ0pPaAXWVMWHbcJEVzteRrWSgfpajJPCiVYQrzELLt8NQ63LHQOu/MsfPCaYcXIm90e2VjjaI2xnRKOIAJWIYhu/F5KXITTFg311g+3OOGfPM1MVb6pRNic5PczX+FqkOydRTlky7PFtqNuMkcJBorq/tQpOUh4CSG3bRQMgexz8uroM+v8pGNvlRw+AJTmuZqmRUQoutI1z83WAILaQ88QVY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWBUZ0cOFWu85E7Y+mODB/8qE9vkwgxADRmEoehmOBs=;
 b=tu0rW/MBXIBbst/vwllcz23KCJNTjpCmB5RU5hdP4TkgOxM5ATnOyo5DcqfFhgDjuUafkNfmRqCrmBbPUyEVWvTV1UcSHdq6pPKlnlJsQmCFoJr9aznCtKsXZj9DSb7Fs/Cw2T+2cNtoSj+3LdTMRpYebLQ8jW3Us3XJyBmmhClReJLg7tffAhGDVZVpHXOxH3T+MY/r6SuapNlha2sR3KRhsNQO/wsjcGwS5EfoL0TyfUxRjmC1GK8DR+GmpDaUbjhEiPdM0Vc4tEF0iYF3RnrrjY/v+dCwFpCiyhGYvbD96JN/KohZExL2OPeoBdXUDFPL04Rg0KZsSfW7sWshNw==
Received: from CH2PR11CA0013.namprd11.prod.outlook.com (2603:10b6:610:54::23)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 18:51:42 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::34) by CH2PR11CA0013.outlook.office365.com
 (2603:10b6:610:54::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Mon, 25
 May 2026 18:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:51:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:51:30 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:51:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 11:51:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v3 3/4] iommufd: Set veventq_depth upper bound
Date: Mon, 25 May 2026 11:51:23 -0700
Message-ID: <04cad2bc0388b98d95a805774f0ac62bba6892a0.1779734952.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779734952.git.nicolinc@nvidia.com>
References: <cover.1779734952.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: b20f3076-19cc-456f-e181-08deba8ea949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	MZCv+hi6gGwN7980TCZUJcUDhgq3PpgQdgOMQdbN3UjT8nnlzW/m3uihuSSUVcOx7+SKd7zN7tr2yxeHCTKJLqylZ3gqq6o0RaYTlDd1VAAUdsTACQ28707ETtgWaTeVsZsqygT2QFim05YA1GUGE7a8HVLrFBmBm7NV6Jvstjhpr6pjRTXbXjsmWo/HoN8q2DRY8lhmurvVUJh40IE9Xk6pda3FirjNR4wyLzVbaIns/RTFHDnXq2MwK9zcnsvvi0M56F2sYj3+nYru0tWmAL7MiVj8nk5IpGJxlsfqeDbLP3qCodu/AlVFJebgixxdW3W2PqPySSzmjQRTYvmP+/gGpHcjZDOf62HbfB4akEKIzZlJ1BETc9Zhq9hBmVkdl5QbbziodJEyoSPV6LXaTf7fABLqE8VfJiVW90swfYPqEhgW4ymV5nhRq2FjjyZLiV093qkeSWMx7RKoi1K8LByU5j4lD+crvsceM8Gt3pGvVZ+BYezoXdQk60UiZcUzIDIMo4hOvXcAgP9QJ4hjcuFQAg0yHtSODGqB0mgWCQDUDIGuYKhPLYI78h+0CPKJuEw7oTPz6t5M3N8quNG9aMxxbAoSPM7jGlnKk2+fYOpvs/KYtc0naA/QxGfkAi6rVQ/EhUNInmZsda5d98eB+svn/YzwpSHdwULQ9b4CeY/Wt5Nwkjl2L2g96aGT1qrV4IqdUvvCMkCX9mMybE1r75GISKnVr1ARm+AhdIUkdjA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y5dmDTa9Vkgknn1WKra+J3yPpSAGuSMTb00RAcGSZYBpMftC6yED7BUNriD/eMy1sfydDNU16Fu1rnxvE38/R7RYFm8qTvnmXX9SLP7er6ncPK4ZxEDPC7OHo/4Hoqnkqs28/+FwP3fOkJSQd0G6jY9oyssp2YH5PDanvbfef0GuARjKC88ZPTsUN/NkgVcScguQ3LoPT62QazDy/hMBqFjrshY+D9N/iT93LAaT6j6OsrKDHnqyL0glU1W4863mEIek6u/u3uFvOCF31FSRDoOr6iAX7BihiyJ58QuawzVjwDMvl+d2MdYEWag2Ar3kWZ2CApzqnfD2i3Mla2vWrM0azXONr50ffRzQIorhkMe8kzceMQr1Nd72vqPivbrNRXMzwSzNhCLv99pnIsZws/uubWprt2yuMOp6cnSZ1X4qJG5gXOpFKqRxRK73cyra
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:51:41.9924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20f3076-19cc-456f-e181-08deba8ea949
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470

iommufd_veventq_alloc() accepts any !0 veventq_depth from userspace, with
an upper bound at U32_MAX.

This leaves a vulnerability where userspace can allocate excessively large
queues to exhaust kernel memory reserves.

Cap the veventq_depth (maximum number of entries) to 1 << 19, matching the
maximum number of entries in the SMMUv3 EVTQ (the largest use case today).

Update the uAPI header accordingly.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h   | 4 +++-
 drivers/iommu/iommufd/eventq.c | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index e998dfbd69603..8d07bb30af617 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1267,7 +1267,9 @@ struct iommu_vevent_tegra241_cmdqv {
  * can have multiple FDs for different types, but is confined to one per @type.
  * User space should open the @out_veventq_fd to read vEVENTs out of a vEVENTQ,
  * if there are vEVENTs available. A vEVENTQ will lose events due to overflow,
- * if the number of the vEVENTs hits @veventq_depth.
+ * if the number of the vEVENTs hits @veventq_depth. The maximum @veventq_depth
+ * is implementation-specific; -EINVAL will be returned if the requested value
+ * exceeds it.
  *
  * Each vEVENT in a vEVENTQ encloses a struct iommufd_vevent_header followed by
  * a type-specific data structure, in a normal case:
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 78689fb52d24c..1f1e415285b1a 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -473,6 +473,9 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 static const struct file_operations iommufd_veventq_fops =
 	INIT_EVENTQ_FOPS(iommufd_veventq_fops_read, NULL);
 
+/* An arbitrary upper bound for veventq_depth that fits all existing HWs */
+#define VEVENTQ_MAX_DEPTH (1U << 19)
+
 int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_veventq_alloc *cmd = ucmd->cmd;
@@ -484,7 +487,7 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 	if (cmd->flags || cmd->__reserved ||
 	    cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
 		return -EOPNOTSUPP;
-	if (!cmd->veventq_depth)
+	if (!cmd->veventq_depth || cmd->veventq_depth > VEVENTQ_MAX_DEPTH)
 		return -EINVAL;
 
 	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
-- 
2.43.0

