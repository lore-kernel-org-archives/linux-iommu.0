Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013051.outbound.protection.outlook.com [40.107.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C073B3BEB
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860215; cv=fail; b=WUnP0yfCPpIafhp/BDTz7Chs3M24JtlWeDKX7tiAfngNoA5QM3LeMManNFLkgoVvhh7lqzuNHYx5/69Y4odBpNyHCfR8mkW/u+YKOqMq2D09AKmFlSZsBodkgJJj5D6fZNTetZAfUOSJk6ao1SwPFY7cmkm2c5HpMRpuWYP63IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860215; c=relaxed/simple;
	bh=2mJh+l/jG0h5vY95lPOCGn306xXCWc59mK3vm3p14wM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HirJrAMC2TaxTs8zXU7QUV6Ad4WZJMPf7pZ4dvf+KFUIAVNvlgEZ1vBiLWTQTBlqp0c1D1OINwVf5WF/B4NPuSW4i960WITQ05zKeVqlEJCLVI8vTCC91gsfwLSWQVrW/o3JtOi6n/sqLjgjW3Lt/3oQql7dBtmf1+cMAyDLWsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kZuJ2GTA; arc=fail smtp.client-ip=40.107.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kZuJ2GTA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHsSpGMxWm8v0UEYClD+tRdmFmfLBABqcRuHXDDfx3CUce4fpMAMNSh3Lj2cOO+KPZADrqWO8C6cOBS3lGN2RJO4C7Vn9GSd15NcVRlbrYcOMzRlSOFaqX3Qc4XGgQ0CNLItQNKb5V/b7GeVNcWOSy7hD3n/QaYuCsjGkIIVUm/kwJchVpk1hk2q66HFUneBKH0yxQ/Dwf4UmjvVR766yvCCsBGGOBaSsnn99NonbyglQRYyv7mFWTFAtmSeVLzLz/MThMvxZZpZrCM/VeV6q1bYsl4EnFeJ3pwNGkeB1RSz5HUg0osorP40L4Udq1xihSFNoQF8oieV2WP2D7Cl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WM/mslrJ8bmilR56zyWcl/no4akDlzwQOmpFilb2xXc=;
 b=OFE9UYIHZzQtJW4E4aPIB82Ke000cRSOPcIfKvGlTxVwJE45O+PghdHgP4pppkBP0eU78ALgTb3MGpEPJs9f2KWS6ozFv7jvSqBrRIsJB7flvS5s70FoXblFcc4kZ45mNPdYrwbpsrKOwbAem7SLqBApvJ/UnZ/p9gE4CXPNAUCz1I4CiJpXXat8NrdRAQe17e6tG9ZI6ZUlnfpgzcQpvFnTBAW3MJi+mnZx/Iw36Ceo+W1Zd/DUm/yLLAEdwS45bs6Pe7TCGgZX3Ehn/4Lr4EK31WPnnBq4wS5Xq96gmzrBDPITEWKFdRUnvJuOFVWCx4NsTGyuR3JXJeG/Cjrl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM/mslrJ8bmilR56zyWcl/no4akDlzwQOmpFilb2xXc=;
 b=kZuJ2GTAfCOHej9ZNsaie81H2vvnPvZ+sVM3+GV+2WW/jC1rPoWepxnpTVscDqp+akDOZkz6JQD/+R4PqZlyZEQ5sR+jAjNX1FDwLnAHiSom9Ljub/OXfexmh1ONZ89wny298gQ0TFPB8ECI2hxmF/+Sq25wdIebYokHkksF9Ng=
Received: from DS7PR03CA0116.namprd03.prod.outlook.com (2603:10b6:5:3b7::31)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Mon, 30 Mar
 2026 08:43:29 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::c4) by DS7PR03CA0116.outlook.office365.com
 (2603:10b6:5:3b7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:43:28 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:23 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 10/22] iommu/amd: Assign IOMMU Private Address domain to IOMMU
Date: Mon, 30 Mar 2026 08:41:54 +0000
Message-ID: <20260330084206.9251-11-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 842329ad-2703-4d7a-0380-08de8e386a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HUnygH/Dk0F404bAw0QCjZSyr2bBwMybEtyUiIGhg4V+WUJ7T8qn7tkVxAoGhRJqg1umF1xQaFM0LirBOaS2fMeG2XUz+D7DCFRIDcpGk5JN2YxNq/trXz6KensmJ0xvFzJ7MmWE+L5FdOqbSkVrgcMkjrRmB54ve9KjvJLzcpouW2CMotUOhx2um6rTBqG//WxUbadMThOFOBJ8H0gyYIK4Q/CTnDqgOsJOnA+GwRYA7uVPj7ZtP1SYZSMed+7db6cLG5XAASCTUoux3qLhVMAERs7maOjZI98Qa8u7528dsEFXC/lHsJC+N0dyJjoVjCCsDT2alDL6eruP+oKoz1AEIxk/97+pfxJVozoAKSRNhNYXAXJ/+xZ+7fHMMld35TuWQG+WS+66gC5RQQpujgF6iDtuvZE+5EHsIqfl6GQmx1/8LEMCOkzO3FXCU03rX4UHxIcChZHm2qvvZ0wg5KjtNCFMzQi2fg8s9Y2v6XtLXd4pAHC8GsTdeF4r5K2Sql6okLE3lGEcnlt2YMEHjMb1UBMunuQqKAZF1IULtV3uOI4A1JWozVy5FLasRnMaTXPZUlZdRA8E+s7rtEUHJou+jdux/7B7gt2GF0Y9/bgY4auHrbazPjSiJr+LJc6EidLqY99CZt9wRdVeToyXfvl8pPqXsL/+BX62PBrC7vO/HIPqw3gI6lktDiPlfrxZYl4Su4QZaMB+weC1EtRKK7e2dgtkKVZDFENQz4sFBD7raIwkiRDPRJp4lSDO4cb0lt9+NaB6T8HakTj1pla3pw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4yDz4AqLVAE0DlCZvXBrtwxjJeCsg2F9gb+iVI33PvTdrkDujHSSOLFYwuMy0YR91mefat2/g8cHS1cvM/r5S81rM+10xUckHJ+o50txzC1TfVsHGAEfs/j2MbKjDD/pTIsiWmy6KPzGGdq4e8mbx1dYyFrNKOy8pLNWqfezeWIHA4lveOazQWnPl0sPpz3FizjNy9SkQShNbPW/3tk7nSwsCULGRTQsf6NMeK6cgnFhIJgSckuxr1CHmRN+cBWyaLAw9toNWAM/M69orvnIzL809ClG08Kb/FcvR4+DsdyGzYofM3RFd5vUin3Rl+Kw5w7XjadSDuDElPW+VA07C7ffFYNHkcRAT2UUzzKjkR0+BwKpNP79doyVw7cS1+sSF1SmNvspfPQF6scjkRq4vlq3m2XjAdY5+PA2b57hNvmMDiJKxn3YyMmNmplHOPyb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:28.7236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842329ad-2703-4d7a-0380-08de8e386a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699

By setting the domain ID, pagetable mode, and IOMMU v1 page table in the
IOMMU Device Table Entry (DTE) indexed using the device ID of the
AMD IOMMU.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/viommu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 2a6339076c6e..b7881de0b61e 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -175,6 +175,35 @@ u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
 }
 EXPORT_SYMBOL(amd_viommu_get_vfmmio_addr);
 
+/* Set DTE for IOMMU device */
+static void set_iommu_dte(struct amd_iommu *iommu)
+{
+	u64 dte0, dte1;
+	u16 devid = iommu->devid;
+	struct pt_iommu_amdv1_hw_info pt_info;
+	struct protection_domain *pdom = iommu->viommu_pdom;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+
+	pr_debug("%s: host_pt_root=%#llx, mode=%#x\n",
+		 __func__, pt_info.host_pt_root, pt_info.mode);
+
+	dte0 = FIELD_PREP(DTE_HOST_TRP, pt_info.host_pt_root >> 12);
+	dte0 |= (pt_info.mode & DEV_ENTRY_MODE_MASK) << DEV_ENTRY_MODE_SHIFT;
+	dte0 |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
+
+	dte1 = dev_table[devid].data[1];
+	dte1 &= ~DTE_DOMID_MASK;
+	dte1 |= pdom->id;
+
+	dev_table[devid].data[1] = dte1;
+	dev_table[devid].data[0] = dte0;
+
+	iommu_flush_dte(iommu, devid);
+	amd_iommu_completion_wait(iommu);
+}
+
 int __init amd_viommu_init(struct amd_iommu *iommu)
 {
 	int ret;
@@ -195,5 +224,7 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
+	set_iommu_dte(iommu);
+
 	return 0;
 }
-- 
2.34.1

