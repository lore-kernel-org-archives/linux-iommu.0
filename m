Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EE277CA5
	for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 04:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761278787; cv=fail; b=rgUZ1Xd6h0jfFPAc5IQ3YuKOBoCXN+6ywTQZYNlI2QWNhyEciOny6o/YNDwH3Akqo2ziyuaS4sfcnBZtB9eEuX/nFszsWwXQZL45dqo8DPK7B0Rd6676vVn2dX1Op4oSqlWHr/6ePflG8yEQxoaOmBAqvRcBYaBcUYAJIbUp2KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761278787; c=relaxed/simple;
	bh=JTPaEuYXPtaSlQN+fWQ61ENNN8jGGWhKCNwUSAxGJFg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SH+O+FRNcFoXy0FdgDUTRnQX77ajbgULm5q3VygXvj6aE20IKEMKtFM3+uXSqJ0h2jSE5jx803JJlEOKI6omZhtJyNKrDftFwVl0b0+xgJaw52L1gaykGsi1QfaZ1FrQASboYw6pDI8uEvb/4ZaQZnTU28AUsbMo4a5WiI4fzmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gmE7KVuC; arc=fail smtp.client-ip=52.101.61.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gmE7KVuC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gwi8/7DUj1cpgRi58Qr53z+G63pPkQEDt0hlLafAlr/9DBd1UeG8O2+I5lEyv2BCrUeEnR7BMZN3GuaOpvc8bFYvcA5bSfRfhclKC04HCHaN7Bji+t5n+lEWtzGMnLqiBTAhASGiqMyFNFrPKKoh7a8peG0YR6K21PyJkAXKqSSKc6SGSOotYs6Jme1tJlKOQXRBE+ZeZ9lfjdBhz3f2iCMeBd1xDEWVQcnq/ux1+AVRKvbf7jgvZ+2WLWCiuVNMh8lVtGGWSIJU3NN3LTx7PvvnvBE38Qd5euRQSy/aG8gRosS47LYn5fk7JGlJ/wPif+ibXQhI3m/NloMHlIYPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igk99e5q+WjHX4XTlg/Ng8KvRoXcTPbI4U404/ERv10=;
 b=v9nWvK31bUSGj1n8lW4zophHdFNYBXYfj2aWHXhb9aTKooM5UWPd6CTC4at9qqa2owm0Mi6ZDYYAoccgZzJ3jqjiNq/W/PrP1JlWr878vu/G2oEvV6VDE+NEmIpykQj6MepVmpt0hOcEDGwfBLfSn/QVK6LetsSQb19j8mdCOi0W6iVhqdlU1GPaasFuQbIpvTdAK3vEpa94s9uTpmZdbxBLoqTfKe3QgLwMozLaNV/QrFGP40GdMbAxF5h2SLLlfGaMRU6ioVlHFnZdPcOXCOMr9SRXEevoGfNKy1F0BpCddw1ftGCxBTgJ59UPmaV4KTKQjb9Nsw2FYOFCuwIYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igk99e5q+WjHX4XTlg/Ng8KvRoXcTPbI4U404/ERv10=;
 b=gmE7KVuC1pgGz2DnZxJ8Rg7g6zLQQmEFL7BW+QpTeO66b0YhzeL3Mln1B2JKrDc0S8sTOeQNbTyWx3NFtzGvKsG0w/9nhvMAfh792PwzkPC0sGkEK0WT4wLb2Rr55dCv9o+af3TnXjbq9Etd7s2w6rg8lhgRPVy0L5Aeiym/WgXDe7c7w0+1cLkb8FTrmKniYMy0Xttm75Aux/czvfoHFi1zsjlxtWXZ9osiAVawdhTrRr0qKRgIe2GmTRbCv71Ol303vlWUqXB3tcr0mbP1UytH8dWysl//33vWtt0MRDYaWDtgB/ZiHC95UqUU3LYW78LWhDrZzG2f8YmltBMe7w==
Received: from BL6PEPF00016418.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:7) by PH0PR12MB8100.namprd12.prod.outlook.com
 (2603:10b6:510:29b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 04:06:20 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2a01:111:f403:f908::1) by BL6PEPF00016418.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 04:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 04:06:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 23 Oct
 2025 21:05:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Oct 2025 21:05:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 21:05:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>
Subject: [PATCH] iommu/arm-smmu-v3-iommufd: Allow attaching nested domain for GBPA cases
Date: Thu, 23 Oct 2025 21:05:51 -0700
Message-ID: <20251024040551.1711281-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 8407674e-7c2e-402a-aa8b-08de12b2afe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WzG+LN2RqHGaeCUH+pGxGCtUQNRDG62ma4iFSedf78SUvYwE/T597OWFOsCQ?=
 =?us-ascii?Q?ASbo6XnVTIV+HXMDKAELewzaf/iZ3qQpcCkY5zYpCQCBPLXMOUqt04yLxlTm?=
 =?us-ascii?Q?IDUYjjBd6MlrG4EAlLCRDXkqRPaNKuM00EXcDBgB4QXhz89LD5UyLgoGLbdQ?=
 =?us-ascii?Q?YLR3hLJYjztBYyciuyU1l2lwyy+QlxUltfb7AdQYFTRjP6lQrnXsJpINkscS?=
 =?us-ascii?Q?7zP55clG3qsOVwpFnm9i4x4j+Yf8j3P3HjI1ddVNOcF8I4SZD9Zg4AOhDhom?=
 =?us-ascii?Q?rS4GnwJjC0F1kERoBieIixxEF1hq2giuhGMekrskRm2KHdMD/Mog74QGJwXC?=
 =?us-ascii?Q?mNhoJhcPUpvcyZjfFR1sXxLyyy8GNZAkFivVXLR5IoRg+5ajRc9UDY310b/b?=
 =?us-ascii?Q?oDAcl4Pxgp3JS/e7f4oEVOtVdSAd+s34NsJF30HFqnbDhBiaiUs62fdzPckb?=
 =?us-ascii?Q?qpUHRiYdBlbeLqhXmjllO4U2CsIB+Ct9CnMYdhv1UNrh1Xrp+D5+ErO5HGCv?=
 =?us-ascii?Q?cqaqXxS0lLMOOxxVdNEgDD6xQMvLREsSTD0494Nz6zANQWXIFZuHHWBoPx6F?=
 =?us-ascii?Q?7LuBpMk2d7bSpt4taxTm05g8ogeEmZrGYytjhdbx0Przx3Dyq/8x2KXSd9bl?=
 =?us-ascii?Q?gN74BYhCw8oDW898dKu+8/+9g9UqFt9gM+BVzIelqp450c8pOXtjuuA3WN/P?=
 =?us-ascii?Q?W7lkcxxIPcevBLTAb7hnEbjLGzZB0r2dtFaIFwTLvJNWkoOBjFYz/dmKtdhL?=
 =?us-ascii?Q?35ckOMerjre/vwVIFifjYpN+9EaNQU6F3JB1EuFElGQwSQRBAnPOGj6WE6Vn?=
 =?us-ascii?Q?tspE+sHSFz75Qh+rdKCz+Es9ShG8yOEi2lYM/hJ04x74rbz6pOefeX1lh+AQ?=
 =?us-ascii?Q?c2QiVyte0tyeVmTAG5puDVG5qMR3WgxxdAybZDgYoOElmLYPYkrX/3SpOXDX?=
 =?us-ascii?Q?LmuX6AzC6lKXjI3qV86CmBYmSfnC51Dg8XfBhNDXKpDGT98/m0NvzlZ7qPT5?=
 =?us-ascii?Q?llhj2ldT+OstvF85To6j/quvdJ/W+WW1bHDj8Hm2YCQUupaNU2OFMLRe5xLx?=
 =?us-ascii?Q?qfHqeblcraiH60SzhI/HptcLqu9mFaanqNXUYn8t/HIGA4sLhkxnn6/9Hift?=
 =?us-ascii?Q?KjlaHgVMVE3f4B3w9Ph9PMDTt7RH4OrIBOd7tXPy7LbaAlJb8K7hdVdLXU+H?=
 =?us-ascii?Q?jXjnkD6Pklp1FECWXuVX5D6q+hipCoiFMNw4gD1Vstnj42CQN7SNCrgdHsiX?=
 =?us-ascii?Q?xUG5EU6/x+NQ0evCWtM9sb07tIUD18bCvuu6rksgAPG4ypUAIFF65VBanGSB?=
 =?us-ascii?Q?xhgzDk7ORLQloqToywR8mDu5g6P9X23lHyn5aKv9DHdP2QboicQqFC9Cg90M?=
 =?us-ascii?Q?xEGMmtEKfG9TUcs7ssJfGU3K57utGBHdmp2TVW/cq81jnNsWuS4FQGsGxqTH?=
 =?us-ascii?Q?ceObLgI2RZQ9hgwVNBfma7DiIg93lG6AJm4dux/DK8Kk1yBL1KAv1HsXdbP3?=
 =?us-ascii?Q?EEoy2tMOintQSRjuDzPl+lA963khjOksQI2AgUBz9zRCBgWRJt0ErE0sbyWI?=
 =?us-ascii?Q?wL2Dr4GsdN+KPg/7lOc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 04:06:19.6045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8407674e-7c2e-402a-aa8b-08de12b2afe7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100

A vDEVICE has been a hard requirement for attaching a nested domain to the
device. This makes sense when installing a guest STE, since a vSID must be
present and given to the kernel during the vDEVICE allocation.

But, when CR0.SMMUEN is disabled, VM doesn't really need a vSID to program
the vSMMU behavior as GBPA will take effect, in which case the vSTE in the
nested domain could have carried the bypass or abort configuration in GBPA
register. Thus, having such a hard requirement doesn't work well for GBPA.

Add an additional condition in arm_smmu_attach_prepare_vmaster(), to allow
a bypass or abort vSTE working for a GBPA setup. And do not forget to skip
vsid=0 when reporting vevents, since the guest SMMU in this setup will not
report event anyway.

Update the uAPI doc accordingly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    | 14 ++++++++++++--
 include/uapi/linux/iommufd.h                       |  7 +++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 8cd8929bbfdf8..7d13b9f55512e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -99,15 +99,22 @@ static void arm_smmu_make_nested_domain_ste(
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain)
 {
+	unsigned int cfg =
+		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
 	struct arm_smmu_vmaster *vmaster;
-	unsigned long vsid;
+	unsigned long vsid = 0;
 	int ret;
 
 	iommu_group_mutex_assert(state->master->dev);
 
 	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
 					 state->master->dev, &vsid);
-	if (ret)
+	/*
+	 * Attaching to a translate nested domain must allocate a vDEVICE prior,
+	 * as CD/ATS invalidations and vevents require a vSID to work properly.
+	 * A bypass/abort domain is allowed to attach with vsid=0 for GBPA case.
+	 */
+	if (ret && cfg == STRTAB_STE_0_CFG_S1_TRANS)
 		return ret;
 
 	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
@@ -460,6 +467,9 @@ int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
 
 	lockdep_assert_held(&vmaster->vsmmu->smmu->streams_mutex);
 
+	if (!vmaster->vsid)
+		return -ENOENT;
+
 	vevt.evt[0] = cpu_to_le64((evt[0] & ~EVTQ_0_SID) |
 				  FIELD_PREP(EVTQ_0_SID, vmaster->vsid));
 	for (i = 1; i < EVTQ_ENT_DWORDS; i++)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c218c89e0e2eb..a2527425f398b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -450,6 +450,13 @@ struct iommu_hwpt_vtd_s1 {
  * nested domain will translate the same as the nesting parent. The S1 will
  * install a Context Descriptor Table pointing at userspace memory translated
  * by the nesting parent.
+ *
+ * Notes
+ * - when Cfg=translate, a vdevice must be allocated prior to attaching to the
+ *   allocated nested domain, as CD/ATS invalidations and vevents need a vSID.
+ * - when Cfg=bypass/abort, vdevice is not required to attach to the allocated
+ *   nested domain. This particularly works for a GBPA case, when CR0.SMMUEN=0
+ *   in the guest VM.
  */
 struct iommu_hwpt_arm_smmuv3 {
 	__aligned_le64 ste[2];
-- 
2.43.0

