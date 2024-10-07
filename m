Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755892AF1B
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 04:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274483; cv=fail; b=lNv9toXodCENqGHt7QEJ5wsC5deeQYqIX04/tzqZMN+nJBD3wm9d5gIxNa5/O+zSQAbfIULmpD+wcblKtEqkB+ZGPJYFW5WJN34SMCEiEHt+Att9XbxK7vcbctKgFtHh9xnsI7pm9XGo8uvYCXJ7Md/BWtCjOEQdZ6ms9wJzleg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274483; c=relaxed/simple;
	bh=uMl/wrHDGEj7w7HjYV+NBW17P+pytqO5UUdfNUqBWjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A77nMARxr4skB9PK47o7hksC/6C1zVAY1I3Mr/mAz0bGXFNRvL3qdK2w2MWaqEW8qJWpCseNCzDca26YC44leGYXnplJ1e+LiSwSNbfpH6m9M1pf3p2k8FoupfnDEymxjbqTMsZ7+DfR9B8VdoyBVbd3L9WbMZOXTACcLby++50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nmftqVDv; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nmftqVDv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZoYfo8yEpBGMB51RySM06Ag7zyvYEyJ8wOZGRPlw4L0N3QIwQmC5lpJJGsnkC9LAw4ZH0Mwbw7jCDyVnhzSkmUjy9qyf6Lc2lD98yAK+ewhNs4B9y97f6GDpANMTy8XiRfpB5Vz4OlJCUPBDcQYwrrTuIz3rPKYcKBDiLJH+LGT5wHUcWbbX1tNAAYWFbo8qt7lkdRWejQCAvmblOoRa72v0s9UcqxPM6USv5K8mE7A0G33aP2nHjmtbP3KUJwA8he5zCWlg8NHNt5AHuICoksXl5UmdUFvSyKl/paqgCm6FnKtHdbpzDjy2htdC5iknRdsrqBgQZetprJOhOtt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/94Y+0rH+GVjQgBkN2ZhQw0vxhxd1YOEj+DBNQwObKc=;
 b=SHkbb/+mnrpKdrCSwsIUqTz9PVeljaIZBjUxY9ZGq9eLr4igVdSEuJWSD0jzTChsdUlFHCeoXnI83SxZ3FOB6Ep4Fwrh/3MWQdIrAuJhK2MYO2RnQZnVbCrcu5Ulh86trU+PxjCNKNB9S0hQQEvkEm3HkbhvpidjlRnuaGXwOFe2dnVKRsFEA6BNT7QqjoU6a7iPPFw62JEBZEl2/9dZz3Cvp3PN62yPfujV2U69o3/oQJtizUudw0P6PEwfEqLQDWQkdpsxb1bkuhnCwMf40IB48ZalLbo8PqYaeAE7H5rJS11nwx5pSGz7U41Ex87F+t+hZAWvVEfbGrzrwNnt4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/94Y+0rH+GVjQgBkN2ZhQw0vxhxd1YOEj+DBNQwObKc=;
 b=nmftqVDv9m062LJlScy/qonRnsW36komAyZMHB9R+L60xSv/dX1GP79Zfldi9n95NEnsRcMVqOeB1LIO/ZPoVdjTjFwaevI1L7IKJ63q1raGCaxjklxlDvJv91/DN4C65lH607ln+prZ9gfWIsH47lk9oku/onDCk9wJGCMaRCw=
Received: from MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 04:14:38 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::3e) by MW4PR03CA0245.outlook.office365.com
 (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 04:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:14:37 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:14:28 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 0/6] iommu/amd: Use 128-bit cmpxchg operation to update DTE
Date: Mon, 7 Oct 2024 04:13:47 +0000
Message-ID: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 11128d7d-a509-461a-b454-08dce6868efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tjpk5lteM1JYpRdum+dXvvW1kfGQ9BSqdcmGl07PSvPtj2EMNBUPI6kNAc+c?=
 =?us-ascii?Q?6t0YAUJ1LfrWR2DTkX04vkdAmeEzgoe7V8oT89KVUVmMxQOqZ1SUcEZo6S1T?=
 =?us-ascii?Q?pisOqk17l04a3DiTOG/gi6WKYvAqBynN80HrOHmSSHRefouXKlty6kl+sps7?=
 =?us-ascii?Q?ZT+26u9k9gL4E9oZOjfX/Eri62NJO3J7tc/zuGBd/YPRK43TAaGA7kHKhiDR?=
 =?us-ascii?Q?mLA7rTMsJMF247ygR8uzK3PsTS3E8GMBCJXGhtWgfe5w8C8Pzvvp/WU+OrNT?=
 =?us-ascii?Q?QODWOvNg/ui3oRyR3Bzb3Xemo7dI01yXmFkHuUNNg55aVKHt9PnYTXFUKHtk?=
 =?us-ascii?Q?CjmHh0wV88WgaKeF6N+gbzCY9CHsQa4jFOvscOY4eDLXD59ftaZvnNbiJXGn?=
 =?us-ascii?Q?ek482AZRqOV/ewlk/nLe8T7n6xSoTZI9+PLcjL1BZ8o2X/eX4xgDnvy4VmkV?=
 =?us-ascii?Q?yu/U59GtpxqpV/318XPxuFxCi6hEcNbFuTByLaZR3jEy2DrdqwNuxYdYKhzt?=
 =?us-ascii?Q?b49NaLJtD7wLfvs4yHoK3fF6GbuKsQLXMAfxiP/yiXtQbBF3sXvh6rpmmqCx?=
 =?us-ascii?Q?A1iQ8ivbloe0VxnuB/XkrE6RUgY3mKXb5xIiSPPOtXx2lY88jWFVoxgCFTD6?=
 =?us-ascii?Q?Jl30qzfSkJ99GjPHxxaC4cSlNEAueiDy6CLICzI3VuVv/tu/wDcqqg3XvvBt?=
 =?us-ascii?Q?rYEPtVEeC6xadOpOMoD4gjQjWUDXUHeLC3ZAQLZZURagYK5q8NagkD6JJiLC?=
 =?us-ascii?Q?7GUJiGOC41nrrrT1TrUyLVLhYPw2SE9pTG1A01q65vhAftWPLdGXOpBmv/cB?=
 =?us-ascii?Q?lDwHROQQBV3aO6janfIArWOK3xXsW+8mCfuNAAo2kOn5cueX5fT4jUT8pQDX?=
 =?us-ascii?Q?AkWodU4YDg/Swel42SluvGSQ1Td/nR09O64GlHRFpAqYkNC5Tx7GYXBmZU+9?=
 =?us-ascii?Q?mRozRirXH8iPjFauejAgVMaKcSNhkph9EeUIM66694MXludbruDTOnEjxP+E?=
 =?us-ascii?Q?Ls+gKbXbnQyDCuy45cIsoY8NATMhybS8gaNii7ZAUKpnsGYLmMvp8KxFzs1K?=
 =?us-ascii?Q?K8ZYyG2HtlWswqWwPFmheTkSlDHF+7Q+WeNk/rPatWyYJmGF+p9KaaNGXbjd?=
 =?us-ascii?Q?J8b+iUZBwc7qm23uxEmD/MVFtihK/jW/mqmEKpetTO2w8jRTd72in3Z8hJ5b?=
 =?us-ascii?Q?z+MP6RlO/CCsBCe0bb1RQDYVNM6sflZXvIS9UojyOSQqZqwuttpSTIKXjmgq?=
 =?us-ascii?Q?gQmra4VcnCMW1LMKV7OEnIbmKUl1RPNgVIR6nfSI01AJ6qCrrwXf/YbM8PwX?=
 =?us-ascii?Q?gTsQmlj9z4CmCOKSb9okFe1H0jK4edZMidX6zwy4i1szr3ZM2qetA/h0QnW4?=
 =?us-ascii?Q?7Y1k0S/EZvA/kzoQ9ckhUVQq1ZDt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:14:37.7293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11128d7d-a509-461a-b454-08dce6868efc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877

This series modifies current implementation to use 128-bit cmpxchg to
update DTE when needed as specified in the AMD I/O Virtualization
Techonology (IOMMU) Specification.

Please note that I have verified with the hardware designer, and they have
confirmed that the IOMMU hardware has always been implemented with 256-bit
read. The next revision of the IOMMU spec will be updated to correctly
describe this part.  Therefore, I have updated the implementation to avoid
unnecessary flushing.

Changes in v5:
* Rebased on top of v6.12-rcX
* Patch 2: fixup logic in update_dte256()
* Patch 3: Introduce make_clear_dte()
* Patch 5: use make_clear_dte()

v4: https://lore.kernel.org/lkml/20240916171805.324292-1-suravee.suthikulpanit@amd.com/
v3: https://lore.kernel.org/lkml/20240906121308.5013-1-suravee.suthikulpanit@amd.com/
v2: https://lore.kernel.org/lkml/20240829180726.5022-1-suravee.suthikulpanit@amd.com/
v1: https://lore.kernel.org/lkml/20240819161839.4657-1-suravee.suthikulpanit@amd.com/

Thanks,
Suravee

Suravee Suthikulpanit (6):
  iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
  iommu/amd: Introduce helper function to update 256-bit DTE
  iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
  iommu/amd: Introduce helper function get_dte256()
  iommu/amd: Modify clear_dte_entry() to avoid in-place update
  iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()

 drivers/iommu/amd/amd_iommu_types.h |  15 +-
 drivers/iommu/amd/init.c            |  23 +-
 drivers/iommu/amd/iommu.c           | 355 ++++++++++++++++++++--------
 3 files changed, 285 insertions(+), 108 deletions(-)

-- 
2.34.1

