Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71613959D
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079780; cv=fail; b=lbFtH5Ilr4hMc1K+lu99U057rqLLQUhnKwzwQFfVaJ5sMHQKDX4mFYp14NJHIXdi0mSHAu44XitLieR0zk5azYOi6sEwsNnV0EmLzKYDE4oSi4srlbIn69xOIZSFZAx7ywLD3RVdY5H/aFzSeUdhRp3HZVG69/8jeWflFDnhNSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079780; c=relaxed/simple;
	bh=+WbEk14DKk/ehnt1l4pS6aeb3anxL8lXXdPQR0NK9cY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jh56eWxng2yzoRbADApQ4iJOilGlnIOQRwNH9Wk//HohKHzviATs/eMks9mGPI05nKnwCpq/sa023JJb+Tv5yry/HAdFO6x/JXsdAHbFx5Bz6OLVl48gZeI7zMPvMhh69B7MbXgUuyPoe82/ColBKxW0sdCpUQuEDdfEbEZPdfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tpwtr84E; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tpwtr84E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w10PIk3grRUSxpdwYFniqqdxoMIm/+XvMw9PhI8ZK/b/OVPg88toOowR1s3zb3ayhEfV+eTXhXBydPJkYL8tMnOW3yw7nQxozrAv+Wx4rmNinyh4lN9BmpVGqgUC1ZlfnLfh3oN/WOmrW1j39/5D/6SZI4kmL9T+r+dX83iIs3FupFkyFRedQE4c57PZRLK36jsXSLv++X4e1ukj9fmrl5qytnYfCNvUMiH/146bqb0vqXrx0dv/YFq8PYFRmwLJRk3JglC3oLZpoD1fUU0KfnfHx4KFZwIbtbt8akNoieH+rzMxGKBMmO80Iga7TJbotigc07VpRX7HaZdBCBngYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UseFrwcalr5UbiiGszcGzoDzpB6konfDVJUWxFhpjHw=;
 b=YZ6BWaE0BjDeEP/OEL/fC9C8oQgWJ41juSzOZJgIsh0voFeGdjt/qUXjxWzNgV0fN0srk5aP+Kz1wZ2ZpUfSGg1ArWzbrj0xTUJ9F7TxO0UvuuavEDeyTWl3Ao9Qd6sY4jAaEdQoEYPOSU6AUGi6y9KXmFdqOViDuUQxqTFrOsc2AMOuGFuwwV+KqYoZJ7DjCY+l7Bdsw74P1+fYG7HdDDKMHMii+6WP7tfGQc0HQyY/L9J3aimVF5S/s2BKr/T24b/Vv9ixyG38nRmJs9UUaX8tC+ghcbrMfXVnj9cnHB+ItDnB4NKOPqfnuZvy4pyfodVja4PGEL9iCXm8Ag6o1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UseFrwcalr5UbiiGszcGzoDzpB6konfDVJUWxFhpjHw=;
 b=Tpwtr84EcMh7QSyPnnKEtnrUpCsRTHcOrsyDCSY1QcxuGwCol4uNb5M4v9TpmNZ965plD7hTllLCRL1Pdcix2R6HaWAsbfq55bWbx/aO4dswlaFHYYmlatP3EJirxn2DWb2tqlrzYGpfPOtzISOeL0C8up+3q+7KAy6KdFrMCa5bIj1+KsZa2DkP5wsZ2ol7PnSj0CHgCYG9HdGoXl2dcmDohhRD8e3YlhWyU0cEg9N+M3Ql2Rpc/nTh63SpfBemWyEsKEOns9SQPrrj8Z2q+Cjq6m9637NApiv9V5ozOkcUcCEG6QiHAJ9TRoJwywskrPNU378g5sgf+VqMXZJgTw==
Received: from CH0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:610:11a::11)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 01:15:59 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::b5) by CH0PR03CA0360.outlook.office365.com
 (2603:10b6:610:11a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 01:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 01:15:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 18:15:44 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Apr 2026 18:15:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 18:15:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v8 7/8] iommu: Fix WARN_ON in __iommu_group_set_domain_nofail() due to reset
Date: Fri, 24 Apr 2026 18:15:26 -0700
Message-ID: <7747294dd3536683d5ce7734e052431c2ceb0d7e.1777074513.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777074513.git.nicolinc@nvidia.com>
References: <cover.1777074513.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dc721c-8adc-4b72-fb30-08dea26835bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	PcBgf1bVFj1HSJ7Mqfx+Sfgp1QN+KU/3YliF5HTopnk22iPjz56pncFqVw4zPsWDbzXUq82/tFFmH9bRNXyh9uM1HtdXF+7xe2inS6Z5dNsyLe2GUL6bUI3chG8uslUdQNmzVcmt/1cOWdOy12B4CM88n6Cej/5XIJ2iRhUrRcu8XzYjmXMmOOevTzrVOBg4Ep/0iGzrnuVx3L0AF3HdXwT0zx8esKfI17dfzA+Q0op+FULux7C1DnjEbRYC+qbq9QX6Xl+0WBZSK/n5pkTObQxo5an8jDK7JEoBn8LFwEbGbAyVJCnIy1ltoGX2NebQMzPPMTrpnZMH/0/Rj5D2DqVUrOddfpMsfHuFZgNqDQfNPWn5KvMzwq+pY0Oh+xe+YmflYciUAgPLI3fZJEgztaFCAd/kEbZQE7pCJdQoOYUKdl9u1ZycsUCgKAVaUAy1JJq7ZSoZy8kSxknkcJkMijikuItcB3GfWg0R4Av1zQ5tbrQKvKtRSG4KGEULZU/DVf8jUSztvZgePk+iFrmSzostK/HnePltBKePSWrOE12Fr14uxjGwuWORt2ojuaz9MTsk/sDkiXw+EDSACMe4UaR1gsm7KWnOUiFpuNGYhhBUQq7tUL/SrEbe+2DV3N2C+RYYg2WkngLPrdNClxzjLfxw7KcrKzDSSb3BYl/xZ3aEG9Waz8DLmfKdeVlvRtqmrW1Up+SY3if1dBS7RjsCOC7+61InelhRQeqj+BSCoOzfdnfYZWQd4Vh+cLVRYwhuv1xvo0JE7nun6KidKFA+lw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	twmBm7z3S8lww/czA6q3acuBwI77rkGKEfiYjiUwvoR9Hgl3ulJi7nYyEYZcTdDBbf6WCGiFih8JqFF6KkvJi/MApOVpKPxu12u+HJLYVf7LyZ2GELvmwUqjv3yzKNNfa2K2G+Mpzes7NGdaeRETSoeoOlhjhN2b2SvzptrUwun2VcxyBAnfEPwHUi6w3Sy6Cy+esKCUioOTs2cUD49s9/aXuOrv5BG3PUSs/dyG/s1+47eGGkqRUALK7ueJj8EQubWr0VzpsBIAz7h74che1LK55oPJpQZldMe8eW42+WO6rzKJRK0qb0jcS/aSHlPEzRktK7q78eLXyqltxLOMwiEJD/UhRmO6NCkxBT+LoEUwP25EBF+Qnegi7IEWlHGOTVOr3CyGhglujS/6iUAS7t0UH2ejF0t/0RSXJskHqAN8rGZiDruQDkA/TVpJgteY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 01:15:59.3674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dc721c-8adc-4b72-fb30-08dea26835bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

In __iommu_group_set_domain_internal(), concurrent domain attachments are
rejected when any device in the group is recovering. This is necessary to
fence concurrent attachments to a multi-device group where devices might
share the same RID due to PCI DMA alias quirks, but triggers the WARN_ON in
__iommu_group_set_domain_nofail().

Other IOMMU_SET_DOMAIN_MUST_SUCCEED callers in detach/teardown paths, such
as __iommu_group_set_core_domain and __iommu_release_dma_ownership, should
not be rejected, as the domain would be freed anyway in these nofail paths
while group->domain is still pointing to it. So pci_dev_reset_iommu_done()
could trigger a UAF when re-attaching group->domain.

Honor the IOMMU_SET_DOMAIN_MUST_SUCCEED flag, allowing the callers through
the group->recovery_cnt fence, so as to update the group->domain pointer.
Instead add a gdev->blocked check in the device iteration loop, to prevent
any concurrent per-device detachment.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/20260407194644.171304-1-nicolinc%40nvidia.com
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0f32bd954a72..f21d352a67f70 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2469,9 +2469,10 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 
 	/*
 	 * This is a concurrent attach during device recovery. Reject it until
-	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
+	 * pci_dev_reset_iommu_done() attaches the device to group->domain, if
+	 * IOMMU_SET_DOMAIN_MUST_SUCCEED is not set.
 	 */
-	if (group->recovery_cnt)
+	if (group->recovery_cnt && !(flags & IOMMU_SET_DOMAIN_MUST_SUCCEED))
 		return -EBUSY;
 
 	/*
@@ -2482,6 +2483,13 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 	 */
 	result = 0;
 	for_each_group_device(group, gdev) {
+		/*
+		 * Device under recovery is attached to group->blocking_domain.
+		 * Don't change that. pci_dev_reset_iommu_done() will re-attach
+		 * its domain to the updated group->domain, after the recovery.
+		 */
+		if (gdev->blocked)
+			continue;
 		ret = __iommu_device_set_domain(group, gdev->dev, new_domain,
 						group->domain, flags);
 		if (ret) {
-- 
2.43.0

