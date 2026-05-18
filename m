Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A2364934
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071351; cv=fail; b=mCAbgRJey4h6nJBhRPRI2oeTth717Dwz+ps5AmCkOCUAI/N7ZNRoIlSKdCwL6BcZr72ZXkyIol3gd3Q8Hkcu2RJCeoWYQUr0gxdk/olvV43Bm3x6IUocKpdR4VTRr6E20YObCGFI9QVGmZN1GJtu4/xudplwf//Q/NLtfI3xk/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071351; c=relaxed/simple;
	bh=W9r3svj7h9ZmnQJ/oq3Di0WApOClTemi1pKGKha0yos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMzsYfvD15D8S1fUKTpgxUrHeCX282OD0EfwYG48+T7soCO23ggaeUij4O0ZguhKOcfKEO8bFxHEeWI72K1e9cjm4bR4cA571PKTslBCf6sLImftcDCJHgE5iDWsR53Xuec4dn7O6qhXt9M9A48sCaLY0Ux5aICzK4H4kYE0lXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NX8H4Z1b; arc=fail smtp.client-ip=40.107.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NX8H4Z1b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjsBDcGcRhNu6Lanhc75+4PXE1OIB3zmf+NA2g7BIsX0b0sXSG2RaiaxPjwC+8EjNcfmZKiCc16WP6Fdc6IVpJDSgcVevNw4piN2YjF7xdMLHfQ4/RMyK2Qd88y39ZKNNHRUtGD7EfKPlftXXTgbPnXkpScaziokmTGeCF0QhXRnbwpGLXE3RU/ILi0wEFdcQlPZ8t/V2u8uKvTZ7182OLXL8SDicZ6N4E5PClo7ejXZH1TOZGlmyIzvew7/x/xCSORZvOBB/sfHoG3qiiM2cZdCOxy9G5+Vc8KprbvW4S2rnfUrVJsRtnlWcTHUthq0Pv4t4EvV6JJ4Q673QnyNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gzw2F0Gwg+eov9hENGXkCe3auqhSfpgxzskXWN0L4I=;
 b=kwtgozlccEDeJsR6RadtpXTa+Z3hnof8Wt26xnTggsobAsbPw4NwDoeKIeys4nTxrvRUsBj32BDPtsI4/52m7BqzQQfYuqSez6FUiKNbWaWOj9wtjK5/lLQpyO9XoIGkTAVqlAj0n5THQ5PN5k0s+d5PtDjHrhpeGwkD2mlqXdaLcDJzK9QC8aoak+/akRRn7vek2k0TPdoREWKY+a2HBT4YvxYqHdiPZbNHqKohAdL+gjwEHbt5kuV2EgsEJy2TwR6d5vooZHTP4Aw20K8Sv8ApYqHcUviKS/N7VBkv8BTIEc6fSrpV1hWTr7MHJhsyjKqWJZuxojmrcJPPHTIHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gzw2F0Gwg+eov9hENGXkCe3auqhSfpgxzskXWN0L4I=;
 b=NX8H4Z1bU2z4ouxuCfu8cw7HZYi8SlWsO+cW+jmmNw91CeTdM6vqiu2eLlMtAaJCS/MH8qEOalxLj7ao0JbQQ5Duezh7fHnzlhRJw3vShG5iSTSgEgtmWNi62M1x1xIQybsZz1Zv7R01SMJJDOl9RHbVicj/9aZj/x6/S7Iovg11wrLZvkn01VzC07XO7QFe7z70U0kXoci2CRgFFNaGl+SNdemBnOqMDDI/P+JB95UjyCOsM0Q0YFCW8Nzm3IxQuW9faDbCf8A2HpV5KrGcbrR1a/W+McLhTywpRo+VavmFtBxSQY5Ox3/HmU+bDwBTSzQrf+BzaSn3uvvRFS+eJg==
Received: from SJ0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:a03:3a1::9)
 by CY3PR12MB9701.namprd12.prod.outlook.com (2603:10b6:930:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 02:29:01 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::e3) by SJ0PR03CA0364.outlook.office365.com
 (2603:10b6:a03:3a1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 02:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 02:29:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 19:28:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 19:28:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 17 May 2026 19:28:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v1 4/4] iommufd/selftest: Add boundary tests for veventq_depth
Date: Sun, 17 May 2026 19:28:49 -0700
Message-ID: <ae05ee2e773ded83ff84d3efb448c2cecb58acb6.1779070992.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779070992.git.nicolinc@nvidia.com>
References: <cover.1779070992.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|CY3PR12MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: ea351d73-2986-4a2a-66e6-08deb4853925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8hOpdRCZ6lrFpUYWr1o1l5ipiIQFfauT2aMA5ewVIulDMIcl/xLCLosflXnhxdTLNpd6MkOO0SrMqLESnN03WnJh02wS7xRBy8bEFhwh5QTLq6PLNpkKt7bHBhHNkMyuMmcsaS4oDTR0xcIlB41EgOkEPeehidNQrotYhFQnirKsbbyEi+pyhwbY9W8N+lxXOgUt5llKK4Wa9kTwWozzaC3gVCQo35x4TmJzumLU1Cv33GIECagzH1VOSmEH/pe6Ujc1k/4I9C5ba3hejyvVbJVsyLZD7mpGJy4+Mao6+/OgXjhQI7Fq9RHGnMgIrW5lXcXYec2SNZKFehHNtis/fzK4WpSpwYtIzL8jR7NJibRM5/8gYA7cSDr8msQ8EffIDeqsXCmt096E7kt3/UDYJwWqLHSfwdmyGhyz219txTEni9ZFaXK/UBcavfx589OgisE0G4xEDIWsq65PyMn3KLF4lGeojLQGezDDsBV9trMVkIZ9h1oO5uKCmwFHZW7Qbf+dvb27HiVDixudWM4RTFsPlE5ukDWzTw0mWqBmoA5ITTC8udGNWkt/na33aD5x2xcbDHyYqbB0dVCLfSQ7OXWYoFcO6bCJmsgs3+PwGAgU4fD+d8XiA0xcZnEFPx19poxrCPSvRJvJsUQ97giSz2wro4bWw7efOxcCeg+StKfF9p5IeHUjU9y/eBvOzzZm1IUvR3OwjkEtIHTyRhVivQzlzV4DMUVkZ1WbCm4hN8M=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C9oJSOGhAAkqI2PUAzMizjK6SCC4Oip0uO4TgcSkdftnXv8MFrjKMs0E2zA4ziWj8lWx5MwyYXaCkAOkz3shd0qt4FzeJzW/wxatR+Y9/ju5iy0QOM787k81Frm5kvgb6BDlF9+4Soor7kg9Aapd8J04V0SvwotkbDpnufLivdjlO+zVKY8LDF9OSCUeQHWFk0Ygtp39o+848DUHvSWWG6LIkF8skjiTlTTPGp3MNoQipin0CP6Y3YCNfxzSMN5m5eGFRnh+fmNh6tfuqS4rklAyhrwxk7gvetlIYioYopWBFGZe3qDuG7vKVRUo7w76M4N7xJRwK6S1byVkR/GAp1C4jFH3fwDEshy8SJRrbq7y8/6f0bW+Ii+92Y2YQlS3kpvKSWRWk9bHmujKrmjFow1ioZdcBouapvJoikvy9FV5OaurRUbKcjSlX7Jx2sFt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 02:29:01.5409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea351d73-2986-4a2a-66e6-08deb4853925
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9701

Test veventq_depth to cover a memory exhaustion vulnerability.

Keep veventq_depth=2 for the existing callers.

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

