Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0680402BB8
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522068; cv=fail; b=o+0a6XOKXj3jEJ2KMVKqfIACrwLcdzyU+Ng8LsnkyOemHR0kpHyOSrP/p9ZhwXHmDC1uaa23urTeJy/idBQe08zJ0trDrZKfxb/c7uTmiVMi2yvkFk6JuqvdGsB1y/wyj0dRxGI/8SuUwun3uiYXXXlMjfEbLnUX4pMub5mxMko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522068; c=relaxed/simple;
	bh=b2V8s+fW49YUeGY3qq2JmE61S2yy3W5YA2dmGLZMBCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBRpQ0fLB3soR2493ITwtt3dRKhok3ZFa2YU6H0mZq6/z6p1q/TfOG+ZJLXlsu8NrsiFxnMikdrnnR+st/9SnnoBLgPYKcFeKRj5Q34GlwBB+1zULQE6wuK0oPT9+gzkQUiqeEpGTCRilo13e/xXg4Ob8PSyhLSAuIXyDx4HqH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CmRGBcQj; arc=fail smtp.client-ip=52.101.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CmRGBcQj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myTDZfnppVSr4KG+Wi/rAj1ciKwaqAxHdfWxJLTcmPdp+Qd/JfhLi0AdV2qy6OO2qHYSAopOlIhY3jCuATMTrGJy5ynuEpOxcJF9AUgOLt6towLk6+h9l1VSyEJKvPoxqc0ro+468Hi+68pIvU3fGABAxIgbpOGuupPxEY0Jv+yz9F4/1l9l5vfca1jWO9wTpaxCTyY3fMSM3OEjPHmInqI4FGWVaorKN2cpS6i237q9m44K2yxdMgXJRtvCQ2/3JvCWMZ97pww41J+mhtZb9KUlBXNwXo+PTHSd3Qa+VoqYzhImeNAZQl5tq6rJHG+ZUiwENCx2Eb2UCRX4hzIaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex6Rg1IQ5rGQOORM8KUxa6zu/9YU1wgr2KOIyqArPTc=;
 b=vIoAk1Ri6HYWsQWoi8YIFazhhVCHEXw/rRVTgyJwNPO+Ai41s8MUhhaRiBRPP+so1bjDPktXisa73wZ8iQEx1tYDNDUk3yeW0XFlkacEQTV9lEIeR/G1NVNKJv3axCN8ZOQL9cqes2D096A4Q7st+UJbZnes/1e1TEXyUDmzMhGkSOd/B8c6Hmc80EF5ZN1u5davENyC3rpL6LUdjl8VZhdXcUABI3JVE60bNV6zQXprCejH5NIQ96QI9zyJ+BfSd6MUhrINn1Yh0YZ29r7c5AOMR5LOnDw1s42haaOKBMh+GWpvLTiGANyXdujYCymHGO+c+8jgGE8Qvo2LIhoFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex6Rg1IQ5rGQOORM8KUxa6zu/9YU1wgr2KOIyqArPTc=;
 b=CmRGBcQj458sAwodnCWmk0ds+9Oi2y0qHr3ZOnMBIxfP9oDdLIbY/CQkyAC4fY24dnYekYR42629e+J5EyS6zkbvmSSeRwWaEEb2Wj39ii7jOAsbYht1pKsVeSDU19lsUA+8zNonVSHRwAkBBblWo0gmNzzdfAfrMhIwrJ7KQZWnX3YZQ6hVa3UNlOMKFNdlpqG5UMMJiw4f36PrWsF1EYkH7KSskVfK5u3G9f5AMH7HI34Z7iVAMa5OXK+IKJaNc2lAlekdjBd24ZqH4X647I6lvgfHk5d0mXJ7chCGbbcSbr9eqNWec/nQUXF1mE+nbrEG/uKC0d0diOZCAksNHg==
Received: from BN9PR03CA0796.namprd03.prod.outlook.com (2603:10b6:408:13f::21)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 21:27:42 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::7e) by BN9PR03CA0796.outlook.office365.com
 (2603:10b6:408:13f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 21:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 21:27:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 14:27:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 14:27:19 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Jun 2026 14:27:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	"Shuah Khan" <shuah@kernel.org>, Pranjal Shrivastava <praan@google.com>, Kees
 Cook <kees@kernel.org>, Yi Liu <yi.l.liu@intel.com>, Eric Auger
	<eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 1/4] iommufd: Set upper bounds on cache invalidation entry_num and entry_len
Date: Wed, 3 Jun 2026 14:26:53 -0700
Message-ID: <447fa93663f7526eb361719e83fa8b649464483d.1780521606.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780521606.git.nicolinc@nvidia.com>
References: <cover.1780521606.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4da638-c59a-4fb0-caf0-08dec1b6f21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZFKwLA50GXzzppehhzpk1H5UlzZ01DiMHBZ3hgPTF/QutVA2rbpDKD8Q25Iyz/bBQix5sP9bP5npqJbCxWIZNn/dSKvJulVW0K9waQKW/oPrTQ+y47rf/eK3lQlyZjO6Bkf1bohMHw64svV7/lz8h6OvZ6M8Q9VKF6SfHW8FEPvkk21UdIqEEVB7WevGo1AJtIDWnX0sqOIHkyaDcPjpS2oH4H2L8YFnkOYJmtDAYR7KsAXxd1+GmWEgT8xMkJFlZXR9Jc2kl6B8YOAlbZ2mQ6LDZe6PQ+27eTHhNmHUweKSAxmZClrAC9scJDwfARrUl331Sm/ywL1VlHyBPivbCoXOltZLHLjbbKjOqz78dSeyURD7iR3k/QnZ9RauMkMJxrvCwIwtY5+JX8xYnmPfaJH1FJ7a+V1JP/CaC5Lfsrlskvd0UI4B83ROyB1XjfTsknzr2PF8T98El95rW6kqzmn7LW2DEMvD7o74ATg1/aakGFNgKAQHHvOhRyTOYWL+VKEXmRS7sf5c5EtzQgoJux2xB6ahhakOA1yBblmC3irDlbsOiu9sBICGNXo1PSf4guOJI+HBTSzZ/Q+1TN4EpzhWqQPQnsYnIdQRoA8oMGa6BNY29i1nJR9SRgquS85v9/k2r9ysmrsO6M54dGdEZmVzMx1Wj9U5IRbz/wdEdq8sUdUZisKJwHwAM7E1eHruoEeN2TVIVfaP/eGefYHBZJrsJUAJYWrAyhOOgpL4CNQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LccMkQ626uEalGgjixkKMmpPqhl9FVvODL7+o/VEU6//cfC9/kkVNEUBqGZH8ay/SRThTWbYtGuhhMMJeRqoGNFDsPIWmQq01s+aaQz4w7pyJ8ri02mdnNOGQn975JbK8d4riovcQvMqOs4k/rAKGnnsWTSdhqTyz1E9ZTa07hlVInqPOIOM+y6qcYa6mL6wQdU6O8hHf+nsQRyK587QYpfp5PU1B2izVrI+oxreIvyRWSdxQ5Os33yGOEGEHoUru1PUhb+63eLOmOk+04Bq/aJ1pjB83u6qS96Gf06nW8F80qh/L233xo/4lrUaT9CZ8LlXyA7tlQ7h9PsCA0lHMun8Gsng4DUPyuSqoidzfsptLkVwEDkyr1w2y8KtjfM0BXlrDv/nSHiVH2L0CrsELd5YUaJcipYWA2ZlQ996FCVS0mshVSO9VOFFh9YuHxkP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 21:27:42.0935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4da638-c59a-4fb0-caf0-08dec1b6f21e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485

iommufd_hwpt_invalidate() takes a user-controlled entry_num and entry_len,
each bounded only by U32_MAX. An entry_len beyond the kernel's struct size
makes the copy helper verify the extra bytes are zero, scanning that excess
in one uninterruptible pass; a multi-gigabyte value over zeroed user memory
trips the soft-lockup watchdog.

A large entry_num is the other half, driving the backend invalidation loop
with no reschedule. The VT-d nested handler, for one, copies each entry and
flushes caches per iteration, pinning the CPU on a non-preemptible kernel.

Cap both in the ioctl. entry_len is held under PAGE_SIZE, above any request
struct, and entry_num under 1 << 19, the order of a hardware invalidation
queue and well beyond any real batch, bounding the per-call loop length.

Fixes: 8c6eabae3807 ("iommufd: Add IOMMU_HWPT_INVALIDATE")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index fe789c2dc0c97..623cc608ca0cd 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -489,6 +489,9 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+/* An arbitrary entry_num cap, far above any realistic invalidation batch */
+#define IOMMU_HWPT_INVALIDATE_ENTRY_NUM_MAX (1U << 19)
+
 int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
@@ -507,7 +510,13 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		goto out;
 	}
 
-	if (cmd->entry_num && (!cmd->data_uptr || !cmd->entry_len)) {
+	/*
+	 * Bound entry_num and entry_len so a single call cannot pin the CPU;
+	 * entry_len also caps the copy_struct_from_user() trailing-zero scan.
+	 */
+	if (cmd->entry_num &&
+	    (!cmd->data_uptr || !cmd->entry_len || cmd->entry_len > PAGE_SIZE ||
+	     cmd->entry_num > IOMMU_HWPT_INVALIDATE_ENTRY_NUM_MAX)) {
 		rc = -EINVAL;
 		goto out;
 	}
-- 
2.43.0

