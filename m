Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E4D25B09B
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410230; cv=fail; b=XOgcUNiX4kIWnaig3bb3Rgx1daygluUGrBteYaRvGApSe4qmHpXC3h60SSSJqzJKYB5jkXq8tf2pNgmZMq2Z7KIxmzogJq5QwnM04PD+L4vG5jVkxmpbAzHXhziwCb0a+6ejQy0oKv3wwWQPDpj120tlHLhc+StXfYIjfIDdP5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410230; c=relaxed/simple;
	bh=GT0AUSVUCuQCW6gcF+TiFUVddGPKVDiY8pvVplqM7iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yws7jaNmBHjGXSSewWRmJ4s7HoPYB//vlcBzXnd+QNnqK9kY53if4qGFkfOlWY9PnuZ4+IlQkvuvPxZEoKCoBv8C+ykc+x4fttFJVpEEA2mfnI32FcdOfRPM2PTlwk3d6b+pd0DTLnDDSSsFTRhIZrJNYYZksf4jWtCbiL+MaiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UuJfEcC8; arc=fail smtp.client-ip=52.101.57.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UuJfEcC8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9ffXu9YY4dE6Ht6B5RlGoXvr20hFG77AxIwGaUfC9wSqNDjzo2kG305zs9RUj0+cYkpqNXFSFQkh7jCTMvE2yzzD5pVYqcsHpKrvzTROC9KJRkr3nIe2+utSa0Kg5+YtDntekvJWi8EY9VKtJuHrtRRwM0oT0cZdm9J64YuE28YHPkTe6OGMZ+gAQZIEVS2TLkIavF1Q0zOL0V4F+VUAFv2gT2+/HOYA2v3hr84BCjmhnDjx1Cn6kkvnjTur+6gazIyYlFsWsHZDgkU4ri9iD9k26gb0fr/p/MOTZgqTutilofx/C2uRrxSRm+Ui9m628bkJouL+IzfJjKlw1/jFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gov9BKeVnSWW3QrhCMW/hZNf0fugHK+cxQ55e28u2e8=;
 b=PiOfHieL+bi8Rv7dXyd5fYic2ojNd0iUW1JWUto009O00I1p5JP7b6QwR/GngsGMkD8nQkh0ES7iylyvbNyRfLKxEXkqHf70VT6Dn4St3E88nSE8NtQlnpKp9bC2s2daAzFEyU/DANEUcRWGMi2/6l2Cm+3as+WM7GDIIcZqGQ5iYv1Z77l0Zjsm108MAs1NDg7OsVKPa5EOnv121PWSksk7zZRuHEib0eSvVYtMfTLeSMMCBX0Ic6HiMvXuP8x8pZvFfPC84tMREnDX2czsY+vwKwiRzL59yKBzkXkc/hlt7+Mv/tLGvOo1HpVHqOzD96feNUwA8w9TVPMMfK+VUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gov9BKeVnSWW3QrhCMW/hZNf0fugHK+cxQ55e28u2e8=;
 b=UuJfEcC8xGWqztDtC+ChBmAwOQVacCBCu789CRpNZPBEU1pOxqLaHoolUSWJIHJUqBFiH/ntLWe+EZcMLGk/+SbvNk7X5vrsvRLeA2R22hboG5D7gai5/lA37bGv+W0t4NdTijfM2yN2cbPoNylKkUvkZ0HEhkrhED8ofQkdTXj1DtdShCpnEq381jtyqYVJ7KEOYwyt2SOF/d/2/pRcf+m8RGyvKMZNsIDY68l9hS7+CyfdRongIwjlsbPz8Kinai8F8zj4qArHINAhSeHhrFyeIDtvyLv2PW4MqHIa76iNM9LgUBcneNqvCtDv1OsQfLSmlWHyIfg2xuWLeC7M5A==
Received: from MW4PR03CA0128.namprd03.prod.outlook.com (2603:10b6:303:8c::13)
 by DS3PR12MB999217.namprd12.prod.outlook.com (2603:10b6:8:390::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 00:37:00 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::b5) by MW4PR03CA0128.outlook.office365.com
 (2603:10b6:303:8c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:37:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 17:36:43 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 17:36:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 17:36:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v2 4/4] iommufd/selftest: Add boundary tests for veventq_depth
Date: Thu, 21 May 2026 17:36:35 -0700
Message-ID: <acfa370fa4e89e4626f71954bad7ad2bd64cf63b.1779408671.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779408671.git.nicolinc@nvidia.com>
References: <cover.1779408671.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DS3PR12MB999217:EE_
X-MS-Office365-Filtering-Correlation-Id: 59781b85-e9c0-4bb9-a5d2-08deb79a3c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	6jcHm3QC5GLJXFTE4exPfjHyId6f0o6hAWOH5OKKBaWpxNi+OFlf4h9zg/B+ui6Tu/KKh6ZSnYnMHTBh73yUjuOE9Nqp1l1SYsn5CkiDFKXMMnnphRRXMFLDktGN+ZN8qXngnI68cw9X9V/CuxTZx0LJ/5FljtZaCX8EbOJVbKaMSd8V4A8B6iLJBe48f9AkCteh9NBFkfehlLoQ9VehWMuKeueyQlNI7MO+OwttCWR16mOjYC1MmMlCtPD5N2ASfLFdnerZjywQrpjyWOzujBn1XzIUJb1RvZctjezisc7JBzdRlrlR3LCUslzjlD6ujR9RkXzWDzhc+8kcVQDWBM2QXkVik6vXdtn63K/yYvGuB8PXTtA7BUXG8XKFJif58UZqiKvVlbFhXNlsuKiNbOxjQVPMC0Wp7LBYMj5/+a5USf7soDC6Uuq2hPDUoy0uE6c5Ynqf7wUnZ1LqyuLBFUEFO8HHO596UHPWVfjp0cqiEJxsqniYhlh4yKCoLGhZh890zP8WJeRKrYMhCsaJ42GPI70hBIBRN02GX/tHXWsjgirlmgXnJ9GH0WuWU+yALP0xKBKyKU1E/HQt6HDCVxgJMTwGI+14BwscDnR55NbHezq+kzHHaQ8+BZDpNVO5sDZ+bfgfvNVKOqWiQ3CpiXVyoOBtpIez8mxjoLCpY0OWZ54LhtMEyTkVJMX2Qh+J8+Vfus9fWZwtc0JEPs/5I9UNufG+vIaanuokT/9pHd4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6oOnuRzRqSsd+ULxQ7rHGXhtSmDHfmrDcPSJBD19nX8ON+lKpnEBh7N9AstVqpJlhdwjeznA9wpwNcucyRJcu1h/LOo0kmM2yKtjcVrpcoI5EBX5Wjh+CYjrwQeuiB+iyRn078nzJ+eJ0bWKYLAIl70wT0Gz5nNofTLgFdmPrA93v83s0LW4MvOUIdEHFMshpzwBRpwRecTsiggLv0eOIXXAnevBJdOpvcykhZS+C5jOOEwHYv56Mq4mQ1t9qa+X3W7b2hFgjKeJZyATCBtX4dz0ybYfp4T3ROC11tLF5sOhs2rFLJTYHsO/PZZHfzukRwW4e3k8JV6PJewwv5/Jy4vsdN5UuFjTB+HKWtzBvj6HjQjdlpwAznLVBvm0TTUB/G7ApSS4RdC31KpycaRos89in6Un7u6TQvDMJiiEVfbvGqzVenhQRNvbFizI0S0F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:37:00.0946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59781b85-e9c0-4bb9-a5d2-08deb79a3c8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999217

Test veventq_depth to cover a memory exhaustion vulnerability.

Keep veventq_depth=2 for the existing callers.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 17 +++++++++--------
 tools/testing/selftests/iommu/iommufd.c       | 19 +++++++++++++++++--
 .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 5502751d500c8..b4928cbd4d9c8 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -1060,12 +1060,13 @@ static int _test_cmd_hw_queue_alloc(int fd, __u32 viommu_id, __u32 type,
 					      base_addr, len, out_qid))
 
 static int _test_cmd_veventq_alloc(int fd, __u32 viommu_id, __u32 type,
-				   __u32 *veventq_id, __u32 *veventq_fd)
+				   __u32 depth, __u32 *veventq_id,
+				   __u32 *veventq_fd)
 {
 	struct iommu_veventq_alloc cmd = {
 		.size = sizeof(cmd),
 		.type = type,
-		.veventq_depth = 2,
+		.veventq_depth = depth,
 		.viommu_id = viommu_id,
 	};
 	int ret;
@@ -1080,13 +1081,13 @@ static int _test_cmd_veventq_alloc(int fd, __u32 viommu_id, __u32 type,
 	return 0;
 }
 
-#define test_cmd_veventq_alloc(viommu_id, type, veventq_id, veventq_fd) \
-	ASSERT_EQ(0, _test_cmd_veventq_alloc(self->fd, viommu_id, type, \
+#define test_cmd_veventq_alloc(viommu_id, type, depth, veventq_id, veventq_fd) \
+	ASSERT_EQ(0, _test_cmd_veventq_alloc(self->fd, viommu_id, type, depth, \
 					     veventq_id, veventq_fd))
-#define test_err_veventq_alloc(_errno, viommu_id, type, veventq_id,     \
-			       veventq_fd)                              \
-	EXPECT_ERRNO(_errno,                                            \
-		     _test_cmd_veventq_alloc(self->fd, viommu_id, type, \
+#define test_err_veventq_alloc(_errno, viommu_id, type, depth, veventq_id,     \
+			       veventq_fd)                                     \
+	EXPECT_ERRNO(_errno,                                                   \
+		     _test_cmd_veventq_alloc(self->fd, viommu_id, type, depth, \
 					     veventq_id, veventq_fd))
 
 static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index d1fe5dbc2813e..2e8a27dab0bb8 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2986,11 +2986,26 @@ TEST_F(iommufd_viommu, vdevice_alloc)
 		test_err_mock_domain_replace(ENOENT, self->stdev_id,
 					     self->nested_hwpt_id);
 
+		/* Test depth lower and upper bounds (mirrors kernel cap) */
+#define VEVENTQ_MAX_DEPTH (1U << 19)
+		test_err_veventq_alloc(EINVAL, viommu_id,
+				       IOMMU_VEVENTQ_TYPE_SELFTEST, 0, NULL,
+				       NULL);
+		test_err_veventq_alloc(EINVAL, viommu_id,
+				       IOMMU_VEVENTQ_TYPE_SELFTEST,
+				       VEVENTQ_MAX_DEPTH + 1, NULL, NULL);
+		test_cmd_veventq_alloc(viommu_id, IOMMU_VEVENTQ_TYPE_SELFTEST,
+				       VEVENTQ_MAX_DEPTH, &veventq_id,
+				       &veventq_fd);
+		close(veventq_fd);
+		test_ioctl_destroy(veventq_id);
+
 		/* Allocate a vEVENTQ with veventq_depth=2 */
 		test_cmd_veventq_alloc(viommu_id, IOMMU_VEVENTQ_TYPE_SELFTEST,
-				       &veventq_id, &veventq_fd);
+				       2, &veventq_id, &veventq_fd);
 		test_err_veventq_alloc(EEXIST, viommu_id,
-				       IOMMU_VEVENTQ_TYPE_SELFTEST, NULL, NULL);
+				       IOMMU_VEVENTQ_TYPE_SELFTEST, 2, NULL,
+				       NULL);
 		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
 		test_cmd_mock_domain_replace(self->stdev_id,
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 45c14323a6183..25495d8dceb3d 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -712,7 +712,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 		return -1;
 
 	if (_test_cmd_veventq_alloc(self->fd, viommu_id,
-				    IOMMU_VEVENTQ_TYPE_SELFTEST, &veventq_id,
+				    IOMMU_VEVENTQ_TYPE_SELFTEST, 2, &veventq_id,
 				    &veventq_fd))
 		return -1;
 	close(veventq_fd);
-- 
2.43.0

