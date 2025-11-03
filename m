Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54131D73F
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190928; cv=fail; b=R2f9q/7DETP1NazNxCAhmoZXnMSs/cErMqRcvKDXyxJrfCHdQL7aoRNzPgqwcZRvVbpc/pZAKMbhjErQ7zevtIU5Qim5YcJhE2W32rGR55YE2oRPOR3RMm5Z0WHfSYcDFWpsV+f+bh95cffwNZaJuxZUiJeQ0P0NgvGp897hZ20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190928; c=relaxed/simple;
	bh=Bk4KOfxSJ2VJKodSmLZt6CqnCscD4v20nasxWCIXuUo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r+yYvRQm+TgufaEVIfgqP4Z28U3/Dwvqa5l3TkU3b5cKrc3H0ovtOxpvi1CkxmAej2YDxZDzMpZtkP/ma7LqgPDORzuA8n6kLsUC7FZ32VTIZmAKuhD7XnVr/Q/357JCaERSDr0fQn/XSt6cxXJuzsUw0QxjctPG+ZZ472CTQGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HE/LJa4k; arc=fail smtp.client-ip=52.101.193.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HE/LJa4k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZVGggyV0+OEQ1bW8fpsm4IDtzWjbXpsulIERKM+UuguQR6E6cwYQ2LkwgqjXk2xVpxmy0dGsx1OTbD3y0lxeN6uSmAovCJn934XJkfX3WeUozHV1/NDtAZAbp84eMltvyRgHxxo25p0EWd9nrWEMhI5xwW/ZcF9lEH83WHirMabx9/qI4nhLWJpm61MKy1qdIKyXlv8pS+/q6L3rPc42yp2+Mdd5HoaUmhMUQLID2EAbQrAuXU/J1nqL7uQcBer9gsq4Do5yiW/IeDXKZ0UrauS5YimiWcBhKkGnD4MCftX2EcAtDLQ4R2XJFMI0/g2UkwRMtgLPxHAjxuzTaGhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TaFPKM3LYUM5KAFWnkEQp7ML7TornS9PC60qHw95Yk=;
 b=g93MEQMVb6ZAn1eSIc7MK5ixrUnggyGseQ+QVLH+0Pqy69VuYu9CFAljnJyrfg0jRLQ4QYSfSyBluMvYOg36OSeY9dm6VLjMkRnKFvNFQyNKVMRQ4O7e01G1DsVlIARGEG81bplBT3LxLHAMeLg7BqqJpXLKzFcCk7tP6X5IoVL4TU9xWi9YXq/pXCiFx+ZobX3W8SucjNDLPTDRTaMYJ0vWEGlaXUUL79mVBh0WHyt2Kp0gm4j7Qh33FQvTrQGL0WzgRl3NowZrYJg3ySFs7LgMb+KyRO2VgbQ5ggIkDvFbKfNGwITkzB4+hNokhfv0CH7cE0Ss7SPl/DeVi+jtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TaFPKM3LYUM5KAFWnkEQp7ML7TornS9PC60qHw95Yk=;
 b=HE/LJa4ks+Um+8W+6nnIQrP9whl6u0P4t0F0L+TwnFo8iPGYYMqgfjZH22QFevZpwq7C48CKOMLker+BFGFmuw5m1rbTDadKWUh7KvP40VolSI4u6YS9afDwdbOVNtGkhXzufBKAdq2fwRy7vJz8deMYFyTO8Rkjpmge1GaQkuVHphtt1LEXy1HD1oVWC7H/J705NVL94VsCPCSRuztV0a5+/lYvFgW8nLU4Z9bzpBIDB28tHryrIjMTysQg30Kg6UmHE8MKWAjRgs1kUVa5h/vMIqnbZa1GFoZkh0ZJkZG526yR2+QlxZvtAFxR1NXZmlswaOKX1xB5I0l6Hj9EPg==
Received: from PH7PR10CA0012.namprd10.prod.outlook.com (2603:10b6:510:23d::26)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 17:28:38 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::51) by PH7PR10CA0012.outlook.office365.com
 (2603:10b6:510:23d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 17:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 17:28:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 09:28:11 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 09:28:11 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 09:28:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>
Subject: [PATCH v2] iommu/arm-smmu-v3-iommufd: Allow attaching nested domain for GBPA cases
Date: Mon, 3 Nov 2025 09:27:55 -0800
Message-ID: <20251103172755.2026145-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 8337a84a-9f6f-4900-24c6-08de1afe6cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wf9ROA6NEN+lX2bhE7LeMBZGZ6yf7Jo9l77j2LBaHa6qi+F/Y70CAX4ukhk+?=
 =?us-ascii?Q?or0YVn16qxurJSekytuS4dbcDqC6BhAmc9YXccUt7JfO9qHEOkjI9qcFHTwE?=
 =?us-ascii?Q?UFa1An6ladsktpqLvi/d8l5DU8rBzgsIdAyT7+aAE7y4SpLd/kbHBZD5oaIf?=
 =?us-ascii?Q?QZYm6S0FmdFQxizI0v6ZYg1mj9Qoa2L+KK/KNNd3GlstG/Ydp3Gu6uc01ity?=
 =?us-ascii?Q?N7EhhQ3mskP+rw6Mtz/hf5xw2wMuFrzr6wjZ98kShZldbedToHHC2gVWdvBC?=
 =?us-ascii?Q?17x70zppP8hYi/dp6LQzsHDrMG2ka2ifLSiUI0b63aQJ1p73botSSB5xwuqH?=
 =?us-ascii?Q?5kyYyT2o43/rIYZc7/sELO8DFmPUxS6LMUlTzKhCdNCN52meWdZYCo6zg15i?=
 =?us-ascii?Q?a/LSk5jVV+zLStGu5jMLjkamH0o+RDuqU4SLOfV90t3yO5QQ9fiBOsfKPEl6?=
 =?us-ascii?Q?uQpSIPgkGlNw4vz8UkTGZSEvRdeWRe0Jn1FoAp9vcyPjbgp/Ti2iE1ld9bZj?=
 =?us-ascii?Q?XV4m6vNbQZGqdlMPEOBJHN9ByIZ0A8ibCT66OxnYI+PHMlb5VALAgSrTmkEW?=
 =?us-ascii?Q?VHozehJoDgxDfncRr0AmzD2/ZV34p54HBYl6KLhuP75bmU2aV8bNd6Yk/K1D?=
 =?us-ascii?Q?2GsDycW/w/mBH/Xs0P3NkjjhuPe7Bzz92/sVcmnHMFropPhgR9qm1yS8QHQ2?=
 =?us-ascii?Q?Xs+/vRh+Cvj6YormZsYn0DHkjS1YDcCmX40lFFuO6ERh8KxNdVit20ff/M4y?=
 =?us-ascii?Q?Bj47Op0ttqxjt0PfYK+n6LB7idXFMj3zMd1jE4vQLiu7Yf78h//uGuSMZwXO?=
 =?us-ascii?Q?GiIjsgiHa74phZZAz0+akswWfMBG+XGHrPVmxQjWo0FWkdzR9VFZUOBjWJOu?=
 =?us-ascii?Q?P9M9ry0FnpO46GdeKx1zbt4etr+eKndc8nVqqDakkvqVrCTC0R4iSrj+hj+Q?=
 =?us-ascii?Q?RYTMNL4iwdkvw+h4S5kDaXrtP7jbysZ4yrB7MlNfVbl92bU6liXmN+YxmtMU?=
 =?us-ascii?Q?+4X6ToAKnIUfFAjiUJXgz4TS5ZEDo4CTMkxBqEzCgCvnwjpvGRtwpHqVL1cd?=
 =?us-ascii?Q?gkxDTd5uHng8a9XfgtivrZlHf7Xmnj3mkXI0R+nkxW0wUcPe+3sIzqooOscq?=
 =?us-ascii?Q?eNYHoIkiCxlU8pqSF48S2Vv0MXqkthHxoTfcxHqGrEY9hNRlOq/KXv3SuZed?=
 =?us-ascii?Q?j7Q/SH9Y+KTeBlt/ZdH3tPBsw3biOSyCAhSaJvEEGm70BUeRW8Q7OTKGH36k?=
 =?us-ascii?Q?kX+htrD5tvf7c/y+U2bQm5S/XHm8HMlSI+2NZZwvRT9CbPD+Eb6GUQQ6TDnV?=
 =?us-ascii?Q?a28ciKku1191s+epfMSo7hGfyri/du1MniE1jwV4vT9KHEqp+T3ImDC3LlIL?=
 =?us-ascii?Q?/N0HED71wNpy0fQjEs8a9Uy35S1Ud1Vi7w+nlymuQGpq5SNRO9+HgifIllwu?=
 =?us-ascii?Q?2NaREYKMdtIde1YVuwtWX2Zpabs8I14OTZ04CeMJAgLBFN5ejPCTVXzVYZ6e?=
 =?us-ascii?Q?przPnfDaGw+3AQoHyNpdixeU7CNW/7DvWbddSPtA9PVH1G4e4lAGxbUQeaa7?=
 =?us-ascii?Q?hdpKUbBZflFbXfNaWhs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 17:28:38.0937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8337a84a-9f6f-4900-24c6-08de1afe6cc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277

A vDEVICE has been a hard requirement for attaching a nested domain to the
device. This makes sense when installing a guest STE, since a vSID must be
present and given to the kernel during the vDEVICE allocation.

But, when CR0.SMMUEN is disabled, VM doesn't really need a vSID to program
the vSMMU behavior as GBPA will take effect, in which case the vSTE in the
nested domain could have carried the bypass or abort configuration in GBPA
register. Thus, having such a hard requirement doesn't work well for GBPA.

Skip vmaster allocation in arm_smmu_attach_prepare_vmaster() for an abort
or bypass vSTE. Note that device on this attachment won't report vevents.

Update the uAPI doc accordingly.

Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---

Changelog
v2
 * Add Tested-by from Shameer
 * Skip vmaster allocation instead of bypassing vsid=0
 * Revise the uAPI doc to note a corner case when CR0.SMMUEN=1

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 13 ++++++++++++-
 include/uapi/linux/iommufd.h                        |  9 +++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 8cd8929bbfdf8..e5fbbdbdea242 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -99,6 +99,8 @@ static void arm_smmu_make_nested_domain_ste(
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain)
 {
+	unsigned int cfg =
+		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
 	struct arm_smmu_vmaster *vmaster;
 	unsigned long vsid;
 	int ret;
@@ -107,8 +109,17 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 
 	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
 					 state->master->dev, &vsid);
-	if (ret)
+	/*
+	 * Attaching to a translate nested domain must allocate a vDEVICE prior,
+	 * as CD/ATS invalidations and vevents require a vSID to work properly.
+	 * A abort/bypass domain is allowed to attach w/o vmaster for GBPA case.
+	 */
+	if (ret) {
+		if (cfg == STRTAB_STE_0_CFG_ABORT ||
+		    cfg == STRTAB_STE_0_CFG_BYPASS)
+			return 0;
 		return ret;
+	}
 
 	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
 	if (!vmaster)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c218c89e0e2eb..225671603ade6 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -450,6 +450,15 @@ struct iommu_hwpt_vtd_s1 {
  * nested domain will translate the same as the nesting parent. The S1 will
  * install a Context Descriptor Table pointing at userspace memory translated
  * by the nesting parent.
+ *
+ * It's suggested to allocate a vDEVICE object carrying vSID and then re-attach
+ * the nested domain, as soon as the vSID is available in the VMM level:
+ * - when Cfg=translate, a vDEVICE must be allocated prior to attaching to the
+ *   allocated nested domain, as CD/ATS invalidations and vevents need a vSID.
+ * - when Cfg=bypass/abort, a vDEVICE is not enforced during the nested domain
+ *   attachment, to support a GBPA case where VM sets CR0.SMMUEN=0. However, if
+ *   VM sets CR0.SMMUEN=1 while missing a vDEVICE object, kernel would fail to
+ *   report events to the VM. E.g. F_TRANSLATION when guest STE.Cfg=abort.
  */
 struct iommu_hwpt_arm_smmuv3 {
 	__aligned_le64 ste[2];
-- 
2.43.0

