Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6293F9A1A
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346606; cv=fail; b=i9BZBmHAhESBzyFIeCQQy/XS+DeuftbyyVjthd5mCHcMl/o8qx9q8xcS67/6e+hvk1CX2oeGVWd4vx56cFOXJPL2AlnrMXiaT/o/thgZuNUe6lkxD2GswaZWGlzMFCxlee6aHiFP5BKcF+tLrLFd82MvitKczhSQwc3pQxR4Jd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346606; c=relaxed/simple;
	bh=MAyfbX8Ix6u/uDaWQ4oIXC8wQYe2NRWHJ3fpGweI+VM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gg6xwTHxWOC01/Z+GBTL63xbSTzR+f+yZqnExMA9W9HB8eZmW2fYztvJ5z3/7Ct2x+JFiQ4aqHyg0CwCtGy6akBn4CK9fNYR+G85HNoOAxfnO/b62tjtPN/Zpcyp+7nMsHVoARb6M95VfATShIpvFs1BujU6E77BhDrozD01LRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JQU7ZdOD; arc=fail smtp.client-ip=40.107.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JQU7ZdOD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsFTCRwUZIvLDoL/FLiYXHAC7z41OwGPaFbJ6xJelSZQyh2lCycu23NADTfM7udAnrZ298kCAXoHpVmboemH7eJT9pYsc9p/RXYxHYOYGUqXothgvtqNCosIM/3CUe4U0i7VBFql05hT/iBukSXHZT0rDYqjQ+D8stWyZgFCHRc4zPScj3iMLgSF2Se4TxkHjl4KTTMuZDPNqsuTs9zAZtT22zbprczrTzTFaMcQZgLOTi7SFJptO8UO8l1pgikY2IQoXs79MqPZp8V1bDcY4iDOBJtdnL+6LN0DZAVib6K1zTMSUNj+imrVX4/AL9FNNNcFe+wPHN6GGkMEwrGk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxghXQ21VnD0zRZSQ5LJYt9ab6slKfobkfTj3pdAsG8=;
 b=Qxbdj74PDHgQ53upcrFRQCen7jOBzn2vjQ0Br2Jq27npwDw3AgIVDtS7noSvHf0fcTP6iMpmWSL7VxqrNrVW9TmSF8ddEne5Hoymd6pmtJgEeZQJ9VOei9Ck6S+rxFUEd4jOYz0X7XW8cNzSCAZ+SsL0COEmS2+QpW0BnM6z4doE4HJ4HjeOAB00/HVvZHGXGNMZXKTMfbKDhjgMzCpKLPBO4kQyuL/sdpmSf9hNXJq9y36cgVeXKtSxy8xgOHfXB3v4m2vfTfrDOQP3DAZ1Pa69metfulkL7fZk0BvhUSsBnI5bDlqz/73v08LO06WqdyAN+ls51SbIpujfQ1BQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxghXQ21VnD0zRZSQ5LJYt9ab6slKfobkfTj3pdAsG8=;
 b=JQU7ZdODMtHky+k70Zz8cW9HliNo8GDYst5npD92wxs6C/mPyBcecXa8JWSfDEZShj4l823XSpIgquY+SAl50Co4I0pQq3LDzTZdUSxdao6dyYxMOnD79+O1o34ESI8Lg++knE7NW4ce8TGmB9qijYTNa0nZ5nUar8H+O0y/hzExTL/xQJtGgX7BLzmkxUnN3nBdVk4zNo/wcYcKtx1U4jVl5gCB8O0MDtxLC5PbOjPkBk5thcwA5G5y8uBmE/g5LrR+hG8k1KhcMNX4MK9mUdlKxLc22RXykljOLEvoDt+Z5lJpVAzSzydB5R+kk5PKthSWopa2Ux33LOlvQt0Y4A==
Received: from BL1PR13CA0382.namprd13.prod.outlook.com (2603:10b6:208:2c0::27)
 by IA0PPF52B16157D.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 20:43:16 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::a) by BL1PR13CA0382.outlook.office365.com
 (2603:10b6:208:2c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Mon, 1
 Jun 2026 20:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:43:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:52 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 13:42:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 1/7] iommufd: Rewind header length in done if iommufd_veventq_fops_read() fails
Date: Mon, 1 Jun 2026 13:42:32 -0700
Message-ID: <78f8caeb6a5d667a26b870e3068cec47dd4b5be1.1780343944.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780343944.git.nicolinc@nvidia.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA0PPF52B16157D:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f69deb-4cae-4b81-6bb7-08dec01e67fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	L/C+MGgKF9F/bn8UC6/VQOvFdKKgKST7rlSeiXDvkz9pUcgMVgexDsZ//mYy0eeVNrMXUwTADt74jR/up2Y42wdl35LrburTsWC/ig5N1QPiEE7OkGkx1djmv4mG5D9QrN5S6jbFd72gZAJtugqEepqTXSXQyrbu0LfCf8M0rqXmHFOGqTizWPRaRZ+BkWbjshioRmlSWDvU9ji4ABD7aIMYZ3fzgMOMEYDMTyspugvlmjug5aeVJMmnawo9/DgfUXTwtp37EIdcgZbbeopGc+C3CTbLQup540GVKQy18raPAjR0aeQMCCCrfg6dJgnbVGm41TIv4bOlRk7v9LLF37MQ/g7YrnM5kE4u+KTt/DwvKJXMTTS3SpcMQCWJJia0BgSTG/oJ6TbU0Z9+k9iPj/ho7H9rmvMbiFybR5tM8cl2aN/aYqGp56EQpgyuz9obKCxqU19dmjsQ1DBBqaIztrFPwxHFN9h1IPA1B98gkVEKfAtFYTCju+jV17hTagd+j7pnej+bSOV6Fe4sja/bv9bed4/gUA75C1+QuxBvUHCrcXUYBk641h3dpi+yrCUOqQ9ZYZK0t/EhOVVviSctLCgv0S3awqihj0P3YVlFwBM3zeYYt3Q7CwwcjAfPCtb+RLxfCKi9xDkDPcrSeBOcRsm4oyXikVSGXwROq/9YiWAhizVZNOKuswwYt5tR2tnyw2w0WuD7pdLdyqLtbyBnDu2H3yiggeq/S97lGPudSpw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dqquKG8ZK1UOHeUzS6w1m3C4EvZVceYMLP/Obx/+9pZUnt3c9+VU99IB3WtJXRg/gnLZnXSwCz7NOLpOJtBkLNx+avZ1Z618FlnQ5TDXlMBzDs3qY1VEnRdI4SC+8iGrWkmE5R//aRx4O8/+PzC5pRlnqY6jHtFm/sTqa5BafYgxCWIUYf79QYkDexqU/U0Und9g3qf/2LdPcGCzi3gn1TDnbl5zAEnSyaWvOTTtvrh0sZ0yAetjB2eHg+Fr6NKZ+oATFlB+/g5LQ53Vb0zI2oa7h+/YzScB+AGj9Df+sZBNmmXGAmuGiZ/gx64l8xoujpwqzX4q3FZrGvd89vFpFfRwsUaJXhFBoM9Wn/jEkLvhqNCDD+rYl0hFf2Sw2nItTu/843rwBwyM5XGyZ/YGnXKad+xT2sHYFhxW511wZ5WNbf2ZcbWZQUMotPsB2C/I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:43:15.7448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f69deb-4cae-4b81-6bb7-08dec01e67fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF52B16157D

When the first event copy fails, rc = -EFAULT will not be reported as done
is set to the length of the copied header.

Rewind it to report rc correctly.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/eventq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 1f1e415285b1a..896f45be0d2ee 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -336,6 +336,7 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 		if (cur->data_len &&
 		    copy_to_user(buf + done, cur->event_data, cur->data_len)) {
 			iommufd_veventq_deliver_restore(veventq, cur);
+			done -= sizeof(*hdr);
 			rc = -EFAULT;
 			break;
 		}
-- 
2.43.0

