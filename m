Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C876380FF4
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735111; cv=fail; b=TRucxs6jFom521KkQo3003jlNHpVcUG4U+tDlVei4HEytcioMloXskgQLJFT/zUieu9vPTL9Q0FjnCNiT+gWOVdj1mGB6QZ93jsQAqOwmB4DRyLS6Rgy5rdrLYr2deQnTxWSKaLifyIet4+w75iMu6PnLnIr7Ii3h4Zk/4dXDBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735111; c=relaxed/simple;
	bh=yHb55UcXDznGVm+VjX2Fe5NvMCHB/DsbSFskbw89mtk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmYMmBwbNLPF2vghocAc1WrKD5TqYOjk/n6t+eELoe075jd8nusz/J4FDZXNCtUvL/cnbXaF2zkhJUHJg18RcSAytmqsrjvyiD19WlkaigxRntJrofvzuUXAeSDpCjPwxLM15RTLc2WGl8mqWsYOt17Qip638xGXZGTm8LQYvqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jQUZjSYQ; arc=fail smtp.client-ip=40.107.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jQUZjSYQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghL8exdJm6driBMqcnqx0rfwBqfbtpxsB4kJ+NL3UdZLW5dhGVbqG0WWmO3nxnb5+Xtns+yFGToD088T0UsgjvqbjHm/cmykNjAtpLYVtq6vwn+Z+MP/0VjMlbEPFYkqJLl7615V4PBn36LWmtQ5FYJT9C9+Xwg8Y6dqydKxhjsrkjBduwc4BZo080g0eSvDo6XylniGIBUhuVaQmDZI2Np73x3XdPBV9wuJSz7R5FS7M0fO4E7s58fh+5/W/B21reqUIsEj/pVXwkA7C06DM8OnCCbxMmAalt9qVKAVZpMGGzOTmrY0cvqwVPU8Vz/XzxNJafde0+YaxIJnpEgYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7B61/ftCGGPf5bK9LVmcUwvjGci2iodXWxRWEt8REY=;
 b=MlKnDjr3TWjdJmtEErcxKQVAiQ5fGI8tEAt0cUl0KkL7fWdh5wrPlLV1frzXXQWJ4b82HEXxniKoYD/dAY1RTIFisGX7l2zK5IztgBze6wZZTLyLFoHXlaFRisNGi7HIe2yxbHYgKLHKrMgYFsl/lXn8kikg6pb8rvCtxVpqzRMZ2NhetHO0pP+bBzVhzU2d5QgyF7Ype6YTS/E4FJMqQIvtKS8x3JRlYPg9IgUNdE0orqsZlP2E+GvoEbOAQnk3j0iuk+2K0TMyDJ6XX9c+XF20EtpMyCv5pidZXjKDB5dYUlu/kpgu5wt/Q0cnCjERlO/23pJMM7S++AXemVJS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7B61/ftCGGPf5bK9LVmcUwvjGci2iodXWxRWEt8REY=;
 b=jQUZjSYQxb/5VHEnwT4eLKDWhrcR3C154Rs11ckJDF/hyjdLHicTv17JGFWe3nOvxlfVP0PJCWj0/tskPrk5kZT0Q1A3C0NLdUsM5TRBDHXyLKC7sJRS3XnXBcD5NCcJRt7gptAv0x2ficyCuK+hxakCt0MJ6su/UmWPuVGWKdJwylsrX6bgqlVCI3KiZTyZ23MkLcOXBeQ05ztvXfa0B4TULUfNi+N/zMAtylqvG0w11LndrYdLoe9ocZQ4jo8lX3KtbhQQF5IoDub8ALhL30m0cnPT+wx0Uvq9RiaqYWK0x4MKTpihiDrvdumiTya4Vy7Vg8VDasZBgIaubpxeQQ==
Received: from CH2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:610:54::29)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 18:51:42 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::3c) by CH2PR11CA0019.outlook.office365.com
 (2603:10b6:610:54::29) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:51:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:51:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:51:31 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 11:51:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v3 4/4] iommufd/selftest: Add boundary tests for veventq_depth
Date: Mon, 25 May 2026 11:51:24 -0700
Message-ID: <452156618d1d4ca5d3a6bb2e7b44007d2fde5216.1779734952.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: a89116e9-cd83-4c79-fd6d-08deba8ea98d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|6133799003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	qZtbmRQwmdPIDal46mx3fJk987j3FlYJBpWhi6XUSyklALVphLPOjrfXfZh9N/Mu9IOkUR+Iow24zzFzLAfsUsS+EgD83rX0E0aYnW4VhxR8nPFWfcrk1k5Yg3m4T4m6J6r9uiDJUT/mdHVLNcLm9tCY2gjAQ2I8P2B37pib0gHlt5a23SwQlMkIij3/WAoNAVLZ4aSljg/swz1FIpJPpfvVtfqBnAyg6YZ+Ir5DGdAYJP7cZ+KntcWohIN1DToOxC3xcaF/lf5EU2DnOCRSRydPerjbID3hQ1gwHYo5iST23jzXxvAj8MKJ6yo6KBdZ+7f94ClJhkp/2gLt7OGH78+rCzdzPauw9onQUCd+ascaSJJboX6vEd1AfIQB6ofhig+e7n2dBHA2eXDqcqx0W/Qw4Qywkz5USKtpHace9WwrTModX2FoRCd4/OmIktXQM70fvexCda/CqGs0tmbgWrXNXKHpypjNyxYAcxmmbcg1sG0IDI7B5m6sR1qC1o/tFaw+JFxuVZsRGDSdK/23hFOBIWcZ5Fnii631O0vTQqx/EPMvsc9UjWc9cujv896JgK07AQomC7jNIQSPig0umjONfzlFPTAkiUEaUYwWtAJ85EL2DKZNkxYGGgDImnenYW2RsVGP3LlEYtWHWMmKH+tOgkD91bEQqW6h6fGwGJ6z0AVc+WrHdwRUWScNVnkaALt71z7jhC9xnz0eZEaWTkyh4WMuvtBZPBoaSo7aBO8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(6133799003)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	szUbBf8R+TG0PbjBL4tV2QrZjpYwdk/0P2kH+uIgBjDtcMEaA31Diz9NVEhQR26wtI1P7N0GARbycc+U4h6Wgjl4VCeHR6MCnowXQPks+d6lL8ZECcC9SxGl+7O4Wl2ehUCDsvncqgV7ZfZ3AYQb2PFCmbkNCLFtzDVOuBU2L60fEGwwdssMm6xYWCh7ssR6bs26cz99mJ7yh+KfXmewxL0E66L9TJd6w+P5c2c7qRvPWNiHb0Dr8YOibV/TxPTSLLEXeqq3ZeeP4E7+FIcqH5tn/1YEt2Dh01L4Eb3eHziOdHGzt7GW/vXTNMPIWwvqHqe8rH5Oi3ut8sJbn2E+1p31UnL/Me9UuzzBXo324WwhrLwaIwm6OHukcK/zRT6nk7aigjgXSxe9WufPWJdmaLxTT/y3Fqh/AAqCB2IWzTgcVXEKzPmRzlpNQnFwa4zK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:51:42.4342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89116e9-cd83-4c79-fd6d-08deba8ea98d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

Test veventq_depth to cover a memory exhaustion vulnerability.

Keep veventq_depth=2 for the existing callers.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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

