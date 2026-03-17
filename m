Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23418288D2
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746254; cv=fail; b=OL2UP9i0SfWtWYM0HscozaljZDdiVPuDuArCY98i15XqsykVz3carb6LHfkm3LuP3M2DiO7vfP57qKtYpKT98SHstpuoDOJgQbYalVFAVohDwCEQXLyvuNC2sqQBj14hnTzhhOCdfocT/BzxC5eawVHdP6yhY93AgXtfybuUMCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746254; c=relaxed/simple;
	bh=m9TMgS9lYBpEBh4XTgBMwv0xUF6fpAoglFCT4AtTJNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJ50ZLa63UNlFKmcv6hK9cFdKrWK2fkVDfl4x9DxVLfgSkuXkc+FzcYW1HBPeEYqp6W4TRsSTVjmK9hgdot+dDm5JAJC0/3uNUtRLMcyLDicaXmGwr3H3ZYMr7sxf8sQlSQSqhOtDbYajPYRyIdkq62m2s3tHZsgYP8pEQYr6bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ti9g2I0D; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ti9g2I0D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttOtynaHe3LmuV0cZuyASFaWXn43plW0LFMdIqQuzEqdoB0vkwzcyDQ0BcQ7jstUVM3b54qEWGawvd2eFlPqKyQEei4BHrVUn9d0junIAz7H1J6h1z7ma8qH6FygyMVcasNqCaE0yQbcdyCHbNZ/PvIrM4zwcM2KCLaiXylKitT8y3Hh2vqr3RavjHm3yNTJdebr3bVPQJyGmR2m/3TeqCZeZDGV7hJF3wY8fsTbdtCZ7iTHxn9BmQa7iwLLQr8QCtwPo2oinxmPBYn+BvEH4tXZ2qVwAOIgIPAZeAMF3VwBP39qzCivMbueUzUd+yGsvFEM3v3/0rQdvUX7Pd+kRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZx0fvySMDA4lTjZPQ42C2YoxVZIXTF7ig/cxzHKLuY=;
 b=eM08QMkhQaaYmiarZnnR6XCyC97g4Qd2bKkAuuKvBA/AR8hZegt8yJngS3ghSecwT9cFEC6tzmolzKvcHhKWTjm2rRNScR0ZmJcAIzXXwob9BhL9IEyYW4eocLesFbhtmvhL45q8QfQP/smj3kDi7EzciMk4SO82KsuUUJkwWRx6NbbqmO627QwI/ox0uu0NZT8G7Hrh8TP3rBcVZvBl07gepzJds5V1N/B9Cz8BUZFg5t8gKTozo8OzLcteypCStl0EAnZ06KatLCvpS3AeF/ofCOQlb+rGBnPiC1ZRuY5Z8YXav+TMZbrOr2/+ygnD2raTJH2P3xjYZZBao99hGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZx0fvySMDA4lTjZPQ42C2YoxVZIXTF7ig/cxzHKLuY=;
 b=Ti9g2I0DSLTcQw5S8YnENlO2VUtOsWW73iYSNf2MFndGTeM4AqDEiyEOikdXnbBPfDq3cJ/TOdrSGEGlaHe3FXfV0bMdqQeicKdFT3WvbHQerrrUoDG4+rIdSqhALonJyokhvzqZP4PxqrkNOp6MZMYAbBwzRv1LOUENKZrJZI5fhHEuH8WJy+7QCmLfqGYR0vhw0cVwPcoo/4uIk2Y8IoO9Dxo7oBW8wcjCP9wUxRpabz7yoCa9+wz2xgs6NV+IwJGkD5Au1brFVIqQ2s7fuV5HNByNAp9EC714UFBIwlcs5hNgGdRTNod7f7FVLgIVzD/ro85qRESt9GZi/mbY2w==
Received: from PH8P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::23)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 11:17:26 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::c4) by PH8P221CA0043.outlook.office365.com
 (2603:10b6:510:346::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 11:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:17:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 04:17:11 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 04:17:04 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<skhawaja@google.com>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v2 2/2] iommufd: Report ATS not supported status via IOMMU_GET_HW_INFO
Date: Tue, 17 Mar 2026 11:16:03 +0000
Message-ID: <20260317111603.101456-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111603.101456-1-skolothumtho@nvidia.com>
References: <20260317111603.101456-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7a154b-67e4-41a5-af6d-08de8416c521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EKaRYcioMSqGH8ld8lmHCWcBxWmxnawcoGX7x1DgP6tIsYZv0aqGzQduUw7C6E7y8OhwPNS9KZj4UxtkGEdUQAxvR7WpgTFqxLSSHJj0GSlH5tikI6H+qol3CsyDKfcEiyVojm2fLk9QlIJpMBl8nYFP2c6ZbS1JaNvCepgvALQVN+73+/UzCi3Jnc0fsErN+7x1mckxMkHoUqgUysZqTq2OVQ5O88vJrv0b9sRkCsCV/sqGBtaoHTPSamQMcfI3KVDKzEZlAUpCsOVlsViVytXJf6T3w24TRvk4xHt97gf0QVjiYqSkXmiq7xC4NcYQI9cIujFvPeH/dM18Z5vujoKehq/gM13lKRXyPj6prvgGfbEpQlghbRtT6U/3tUJoFG5sfS9GpIOym9kr24tKC6Ht6BpWVIFr652qsUXVB82N29wlXdD4QcHBkz5N3U1b8oF99dGm9ezMJWn+ew5Yi0URLdbxAOLmmwfz5/HrX1TQD7a2qExdHBBXYgzSK04y5lDdwhnHJpMql2H9khhm18mBWK0TwTLCXbIOKHswyshBlCWTeYHuXd2O86id5PQ84+7ESqRTV+AiXPVoyTOn6GNkML4zx+uRQvVVHHTQumorSxtT1YB5anevU3rq9ju2w/zbdjgKB/vgry8vKEMuhawtealKVPCYwPWlyFvEfEK5nPTuEfKN/Rgt7GSnGpqRJwABpQjmmrJ6Zft3cA8F+JbC6kvUhVStspykEns2XKmcSft12tOpK1/77w41z6faNp1Q/fFQySju6ljFSDH8aQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fdUrSxNbyfAGu+rxs3HDyVW+kznMJnpa1pNVS+LeZ/lnHBwxZN47LM9YoiYr5+JYfo/4iAPg6piwGzPEFkEM0JobMbxSCnWc9go4cRmDariARB7UQg8F5lePWz2q5JtA7aguEJRn3TO6NhBApmypBxuQekdbStjKp/TSMei5k5y+Y4p5qKMzGrA05iUj5++uflF9Jm9KqncPABE0L4udDWYcvLNkEI5wm4zXUFmlFrcROOaENnh6hw95TsOc+ZpKNew+Hrf/eCAsbhIbfcZBGyW7SZktIiEONm7LjJrquRn4JNoF33egsSxeHTTW7MDQ/wSucKW6jzS6NJFYDjV8TbiOttZYnX3lj+TvL5eyTfgKNktBPGluItVB6XaQuBZjCJta0Phx+gMHSMEfAd8dXZ1/KSsPri0Elwia/UsKjqhX5AoYQHUq5qpISbkXQKgP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:17:26.3321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7a154b-67e4-41a5-af6d-08de8416c521
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

If the IOMMU driver reports that ATS is not supported for a device, set
the IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED flag in the returned hardware
capabilities.

This uses a negative flag for UAPI compatibility. Existing userspace
assumes ATS is supported if no flag is present. This also ensures that
new userspace works correctly on both old and new kernels, where a
zero value implies ATS support.

When this flag is set, ATS cannot be used for the device. When it is
clear, ATS may be enabled when an appropriate HWPT is attached.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/uapi/linux/iommufd.h   | 4 ++++
 drivers/iommu/iommufd/device.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dafbc552d37..507ee9bcba01 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -695,11 +695,15 @@ enum iommu_hw_info_type {
  * @IOMMU_HW_CAP_PCI_PASID_PRIV: Privileged Mode Supported, user ignores it
  *                               when the struct
  *                               iommu_hw_info::out_max_pasid_log2 is zero.
+ * @IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED: ATS is not supported or cannot be used
+ *                                      on this device (absence implies ATS
+ *                                      may be enabled)
  */
 enum iommufd_hw_capabilities {
 	IOMMU_HW_CAP_DIRTY_TRACKING = 1 << 0,
 	IOMMU_HW_CAP_PCI_PASID_EXEC = 1 << 1,
 	IOMMU_HW_CAP_PCI_PASID_PRIV = 1 << 2,
+	IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED = 1 << 3,
 };
 
 /**
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 344d620cdecc..92c5d5ef8d00 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1624,6 +1624,10 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	if (device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
 		cmd->out_capabilities |= IOMMU_HW_CAP_DIRTY_TRACKING;
 
+	/* Report when ATS cannot be used for this device */
+	if (!device_iommu_capable(idev->dev, IOMMU_CAP_PCI_ATS_SUPPORTED))
+		cmd->out_capabilities |= IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED;
+
 	cmd->out_max_pasid_log2 = 0;
 	/*
 	 * Currently, all iommu drivers enable PASID in the probe_device()
-- 
2.43.0

