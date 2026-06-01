Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB33EF67B
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346603; cv=fail; b=i4RVqk1BLfQn0HxAdF2f2Zv+fM4qALxRP5hpUxtkppONtgqzHrmebBzr8Ie0hRSOCqJzikjLjX/yFkGbE6cqxKSEVYtmfTnsFvti9ZPNM0TNoAqXbX5ZT9uEu1ZeOVdwsXWVdZUYzpxQaj+N/1vA/9pkCuKtQHba9aGWK5VZ7mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346603; c=relaxed/simple;
	bh=LBJ/6yTPOwHjX7UsuyrRSAlAjZGxpI3jSFzsioHIl+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZhPuvUeDnPlNUoXQp76mRZ7/GKz/furelEDKcnoWu7iJNTMzCeEGtwLlBDPLqCO3DcnrvKP/JhxdKsOUbFglwS1WW1+7zfii5hql9H9YGr9cdpAwW0q3lVIMc3BIeRwnIcqhUFhK5MAa3Y03tFid4EDSF9CXn1U95IRneE995DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ej3ftv4B; arc=fail smtp.client-ip=52.101.53.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ej3ftv4B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgXLd5DfuKvEh9V8f0vEPWQIK4k72HoZWgtiU1H6R5IMrPdU624/pX2HP6TRjV4hBd9W+1r02Zwo8Fwj1y6dHSZs86icWgRzXlYWa69kM52Vg43bbuZ+AG3H7h23Tn/COM7KQB3TDw7dUuJ5VxGMpogCY3Iw2fd9x6esibj35Bp0h+Is/2K62DQUDHVCZpIXmKDCEYlC2DANeON1qr9E9wnph/1PcOav2oRV0JxJu/KoTQkWps8GaugEtddhPRvcRx11AVpiev4bCDgq4jB0IwWaQSj8AFCEVAIPYBySWdNynvXpex5xwVh2nvLHL9DGe9/YcClpMWAUD9ejOUOnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0ec39kM0O9Jy+zGBhfwPm0UbDA/Fbw/7ajsuaIrsPU=;
 b=peITlel51WdQTzfQUoPMW8KW6ueY0pvaKHyCqdMe7/AWC2GNn/XFouzfKhNvG86pxT5/xstsGYW6pIyC4QapvgFbUWvYO1T3MgwwHJjZZGvOFLfcoMQLtPZtOiK4+PUKtGCzO2YqTr3p3yN9mOQj9HFo2NJ9hSs0ZXqybmE7G4Lb4+SEB4E4lmRNopAfVUdXXQsZ+LXxPBZjxf23tnacgC0YP0OMYSxnOwyEgbVcFaj1QdoLEZwejWDeOpbpVV9JXmjTg21jiPOcCQ9+OmES8I3b/wg7ZQuggmTaStjprsBLdoT/GaCSE4or37d0AenoJSLIXVAcRyGao4fn+i4vYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0ec39kM0O9Jy+zGBhfwPm0UbDA/Fbw/7ajsuaIrsPU=;
 b=ej3ftv4BAYVFDn61KDIQM/ZU0UZKG1r6/M7K3+VbwsZlLTeN0huZvSIgeNU6pJvtYLM1NegHu8cYkFfhdRkqQsNvAkVD7Hauful/jw1BrQY/0eaLpOl7Oy0LsE5YeDlKTmIrzkyadB3EdWL7CGXQNfJdTeUp7DLrUjkJ0QmoEp834oTG0aSZ/F4fewNUQZ/WI/HqlfPYfvVGcpM8zydFto9LVaFZQ/Ojwy0QOXRNeUYejX7XHfzxLkwgL86tXD59ufUBZC45lS26DJWTLsPq4gOrdAmFZL5ZILfs7CnSaQIVIVDCnb9PKc0SOQ3q3uw+oYoBMMer3P/VjZSzHuqymA==
Received: from MN2PR22CA0025.namprd22.prod.outlook.com (2603:10b6:208:238::30)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 20:43:14 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::a) by MN2PR22CA0025.outlook.office365.com
 (2603:10b6:208:238::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 20:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:43:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 13:42:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 0/7] iommufd: Fix bugs in eventq fops_read paths
Date: Mon, 1 Jun 2026 13:42:31 -0700
Message-ID: <cover.1780343944.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: f51316ad-c7ac-48b7-7ad0-08dec01e6724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	1MbSTyjPVt0tkEhEyp69zv0xasPiZv7cZuuzvcgRa/m53G3Elc1b7Kin+AH93wJd+C6rOs6531reUZ8NDohn41i4h6frkh0wmzvzh2ieSTGiqPFT9QtOHkvUUSeBVlHNKVtSFzlu3ohlNJRjXuHXRnRDwHe9XjdB/ag/oz7thXbfkilnG/cFDHEAzng1lQHEIAsXFsLprJ/MpWYClxjNZnqwMQM6Vs3DCj5j6uJc6k6yndmGJorSO0GmMJFMklU+XEAUVx3ZdB4MilZmgc9D5Ca1HQ8KTptXN9qfCk1ANFopTdMxa07eHO6KEyZMrlOf7c2+SqeM0/CsHj0DX5lZmO4IpGz/+ivh2iZ8ZnC/J0iSyyxp0bAtoR4z1o2ajLpWlNdCmB2YeHgLU08MykjrHAkqcesawpxRvADGLU4/wKhQFRG68dDS+ttf0P9UPdZg/zxapAjXVNn3SliFsPvqwVwKFV1U4CYYkvj7Z2TQEybX/irtqCO1q6MGEGPP0bYmqUr14a5r2x17Wub7oEM/kDksY6EN5jaLj9v1I51ESWMNqEp/Y9mciyXy4N+TO2DZVhI3xLUyxWO5aDQtqsRRbC+SaIPJcdmfnWd2NeL71YpDl6G7ischs41nJO/j1ldEn/XVx7dJVosWfUdjEo9p6Vrgn+UESepe/jyNBYVKMlkqAT1pWtal5MbOKr93QxBziik8LHj/ZKG1ZSOv9N01xS550G9irMhoc62CecaPmIM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	19/QK9S5GxVVbyFvMizLRJVBbIjDFdraATOCUjnHeQ/eA6+A+FxdN+O93JpFk3X+qXsCQ3fsDBgTXBoGJzv4lw11R3nRTKmhLT9kW/5ACCWTMO1lC2JYMi3nTcQI9w9XtRVnw4A5SQjs1gvWqAjPx8c8ZMAHcsCWHafOwA/2ezH7QoxFBqiS8GWUjs/x96kCR5x+zW5J+NzvObRrqqI/3/gTPHMmWU8oYO4+pH9z18YNZ+gl6oLJxt9C30i/m09wpch7nKNp+1qH/DGF9gqg74OXub+lYnse3prSnuwrwK4bl6OVw/y9JiHALbh1Ox8ayuTzGzJgkxdptRyDcQ0wIcqL7gPN+A1eoiS7+f7EiFmhR4jzE10hP3/Iq6ew/NMzsHGPypbxZTYd/nBqtVj05RfBRAPMLPS5uOIp5JzJl0rX7/9Jd9Mv3Js0nrmUjADr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:43:14.3259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51316ad-c7ac-48b7-7ad0-08dec01e6724
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

Bugs were found in iommufd_veventq/fault_fops_read(), where userspace may:
 - Receive a corrupted byte stream after a partial copy_to_user
 - Spin in a poll/read loop when reading with an undersized buffer
 - Miss notifications when the kernel cannot allocate a lost-events copy
 - Receive duplicate faults with stale cookies after a mid-group failure
 - Cause the kernel to retry the same failed copy_to_user indefinitely

Fix them, then add selftest coverage for the vEVENTQ count validation.

This is on github:
https://github.com/nicolinc/iommufd/commits/fix_eventq_read_bugs-v1

Rebased on Jason's for-next tree with the veventq_depth series applied.

Nicolin Chen (7):
  iommufd: Rewind header length in done if iommufd_veventq_fops_read()
    fails
  iommufd: Reject invalid read count in iommufd_veventq_fops_read()
  iommufd: Propagate allocation failure in
    iommufd_veventq_deliver_fetch()
  iommufd: Reject invalid read count in iommufd_fault_fops_read()
  iommufd: Break the loop on failure in iommufd_fault_fops_read()
  iommufd: Avoid partial fault group delivery in
    iommufd_fault_fops_read()
  iommufd/selftest: Cover invalid read counts on vEVENTQ FD

 drivers/iommu/iommufd/eventq.c          | 29 ++++++++++++++++++++++---
 tools/testing/selftests/iommu/iommufd.c | 17 +++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)


base-commit: f25989c19028e8bf81e26e1133a99e3436c3afc2
-- 
2.43.0

