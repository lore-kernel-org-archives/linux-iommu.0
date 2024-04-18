Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893715DBC4
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436549; cv=fail; b=fK5IsLauEvW2b8iW/c7tHkylb0WzApF+VczAaJfcrxlyFV/I1aR5MBSPtHL8oe5tfYn0bUwf14lHMgHjgURXlBYQW9WnGmoOpTIIMWl2/ShLnLLq3q9GcycfS6UuKWwTuYTjaTaaUNU4a0bQ9x6A1UY6yDuMzdx9JMB8qvVCnW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436549; c=relaxed/simple;
	bh=cHw9y1St4aXZ/nSU6lNn9cnmghRw9fiQBDgMwnUosls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFo0v+cIXC7m7Nb+aKjjpUxd2emLFS+6DpJiV5/wE2HyK5DJJJphGyFNEVeaQHBXKoS16QoTI8yR1dJ0/+sj44Bexv1fw+PLttRhvOT+52rqiEYWlAYYf8ab5zx8GB9PBIIvAcEj9LHJ9jjSaB5DbqarxuO26EEHByRwpn/cVtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fy+DLiUm; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fy+DLiUm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF9JkyHlg0BjYgyRagQOEQiZTsry73vsw1n0uHX7l3CFoywmgo+o6js87Is3mkE/bXPNgWzEZyC3P4MPC4mbgJwQ15CzQD2VRcG4Mpd8fHUFBHo85jslCehOwPPkQq/5bYH7ZYbmSPn4tdOrzfBkYavMajNNIIVQoG22mLzpqPrudpauLlHRCyN6qB6Dg6kRGOd+rvAnH1oZU4+nGvx+Z+FVQj5IrRScAn3N9Jf61z7k0pqxOXJcyZzU19Gmk15VwV3NAx1E4ET013+ciMVhdr6Ow+cDiAt/MnpzR0qejXQGGTh2g9QOi801ju9hiYEQUqkCkTdNczuY4ffj6wx+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEpmWWM3OvtEu0Q0W4PtomJqAbdtnemsFN/KAp8ftPk=;
 b=nZ1p3oHa8m6jzLufvdHz9NydC0FZD2O9kj5GPA+CkRdMIrPPgikU3mj1skxO5/x+lzs6Lsr3cPb3qtQJoJlK2u0ZJ79JUs0y574rpefnFBKbeE/SZ8sAz/iIlYbYDzUI+K+fvlDAQejrHv0j4PstCigBAd4/dZYa6/MspbphpEu90eQEs22c+M0jMto6ot3eFNeGCBBDmn0aQgjWjtsyQiFskteze1yRVkEN0BTDtmmM1S2TMQI67SJ+TlXNLvu74qfHmQANloe1K4THWxlR5vrrtkETjmEaOegi6ycMfWpCGP60nzuqzxNtnK7glsQrkM2PctjzirDJfxundbH/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEpmWWM3OvtEu0Q0W4PtomJqAbdtnemsFN/KAp8ftPk=;
 b=fy+DLiUmbzDQGgOrMXFCkFjac1gw45G0U1ltPrpOz2ubFSZD8r98hljV3gtGnHo8I4p31HHxrFnwYLuHBgkzxjNmfgkWkMbNaw2qdAj0EF0AH7KEqqXJr/XN16LCEysiDl1Kuc3EqXn8cVFAX8yD+Sfbm9uYbzBYvFZlHIWUNVk=
Received: from CH5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:610:1f1::15)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:35:41 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::3) by CH5PR03CA0021.outlook.office365.com
 (2603:10b6:610:1f1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Thu, 18 Apr 2024 10:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:35:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:35:37 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 05/15] iommu/amd: Fix PPR interrupt processing logic
Date: Thu, 18 Apr 2024 10:33:50 +0000
Message-ID: <20240418103400.6229-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418103400.6229-1-vasant.hegde@amd.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: c07c0696-22d8-4d4a-819c-08dc5f934b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YRIP+WKny8gW6rfQeGHSX293DX8+2PMsvCmhuawYCrY8YCxXek0yMNiCw+DVxYf1uM6xpBSpmG2EjUF0CywMb39xEIrhcImwcxd+E6RePNRcX8xq2uqfhS3FYD03sLLmo/c/NOzvh7QQIhfzQTZ/0cLVEgscOfcI30KBEwYD08DMwUH5N92IjU2+4EvbP1xRxIskb7JCeEX4lthtTbctMk+uvd3qh7oMNnIe6u1DoQi2RwuvYeYbozpNr0cbZZkHJPdyJZeRBZV5BAoz6RaOg74JGh4m5hFMP9kVWyK42n5YbV1xzayMk0ha7Y/OALUaa6zbGSK8FAak0fHfuMXIdCekWvnesL5jWQUto0AsLp71yoGOiQKg+/3WaRawZRm7y2dBTYPYF4gmdkNVOVUvixoP5vczYKUK13hyvdjTrMcaCsGt/3CEo77mUWwXHGMY5u4FMNqSNE98P5vI405rl06FIByZ0lBp0ugeKXB3Qs//HhLE7VlO8Ye4InJXP6p2DYpoWQmHTW8WcprjcJ8h1hWhjECByZm/mVQUeV3tqliZI4wZJR3SJEp2pRYwEY9UwmUprF9w5Ghrubv5cOK9mYwOvGQV1klrC8Dja028+B+7yN7+fQHq78srL7NMdbu2VyOEbeCmbwlk/P0HMJ/05h61vkdvcwEDfQxOJnhYYcw2J74vlWY44J8EIjPLulL3MHVFwK7IPNdMo0QJap4vng7aWNqBMR2j93sxNaVsjzffI5zlhsSzjHS2eKtXdohz
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:35:40.9063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c07c0696-22d8-4d4a-819c-08dc5f934b6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148

* Do not re-read ppr head pointer as its just updated by the driver.

* Do not read PPR buffer tail pointer inside while loop. If IOMMU
  generates PPR events continuously then completing interrupt processing
  takes long time. In worst case it may cause infinite loop.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/ppr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 1f76ed549ec1..65db1745f40c 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -106,9 +106,5 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
 		/* TODO: PPR Handler will be added when we add IOPF support */
-
-		/* Refresh ring-buffer information */
-		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 	}
 }
-- 
2.31.1

