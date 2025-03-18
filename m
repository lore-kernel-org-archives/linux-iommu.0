Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F034210F49
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315456; cv=fail; b=HyWtzQajXPklVm+j5IYIhhOImYXsSz39RK+VFiW7ZVMTaBFfrwIsHKvczAdEB57AGm9nnSwJYztFQr9r9oiEs8UWCmphg5Bcn5tcfCQB8mPuMNtYnYo4xkaM2IBcL4HruhSkTh6X8dADXaFmkDX37DHWU4gqPPjc4ZImf5Twfq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315456; c=relaxed/simple;
	bh=3bEQSkfD0pVRWFHM+AUUnVbRT2tPvApVIbnyW4BT2hY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ecEONo3g1t0yQnmaKlmdgMFjr3d9mBhR9NveveRJIBwskWZkDDilFjb9RprqMriJB8j4wjgkERN80tmhYuyGwopNRAxzRmZpHyBX+7DUrJswyiyI6dcjFR4bKEV9RM9qevE4YsdnaImaHgdWT7fJ6IBys0l/H1P/fIyRUfwnfrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LEpYRD9/; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LEpYRD9/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpRWf0PodEKYkoPDMIfjTD95gHFzE/Y4GL3nZxmusFktthlQRYi57glhOPAIZY2nReXuSq4jzIoq49EcaoWdLNCC+DQJ78E0JvbI+qbHeQw46rMr1/Pb8CBrB+/cgBw/0d88qrShsZupuc7lVq8yeH+3jK6R+EAlsT96y0Z+560AMULG4zF7CjN2erzQvLM3JS8N8kpDE0gO+9fg79CT37agQhF2fcUafQjA+H8q+pGTQAeoiZqHRwEh1fRgM0GjVLSQMrXl19h6eE8SO/Td/YaCMUApqsGtI9nBrw880khVgDpk2xHW/CS1/6jSGfM5OpaGTDvmgNfdj2fdAIhG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq/Ec3mOiIWdFMi4PfR3bHRrAWTVu/6k0CspaPAQHYc=;
 b=pjb35GTTJKPz35DMjz/7luzIOQ88FyHDDl09SWPQOAVDIZLJL61VlirXYqwDvJvXd3tib3H9Rx1a9bIlNl493RTdRT/IRa+XNnSgfiSUKhZCjhpUR4ZUpJA/VTl15KoV4QbjxztTzQF6OjKlMAUxzWL/xx3WMqtnkUdf2PMb17bW51SBO1lNf8WXvfUo9cU5qyIzdADZ99FcC5STIwlHdrBNytYaeyi75C4EIbF3h7yH8gHVxd9hmAc8TBQmubpYjzZxFLHVDlAKyml/+UTApWMufC5I4htYXbOZcioe8aPtbjNapR8+U2zwwsTRMPOjEx29rjevKa8UKw1lWrkydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq/Ec3mOiIWdFMi4PfR3bHRrAWTVu/6k0CspaPAQHYc=;
 b=LEpYRD9/Rt3HYwabuHCNEl/CQxkfLAttaxAcvSu7midfjnTk1Ly8AgR3V/2Oa5I/k8YLa5FPUGy5tRFuhAv7uxDL1uwbPT2/OtCG5asmpkuSV13SzDQKQlWcxfJQjHCSjJtjSlNnR1VGnyHPHSouN0SC9GbN1G6Y8JNsxFuIy4CCAFd4lT1ibdHrb8I3P0lb4HRXErNJWEPkTpiqesy89A08YsWIdwvKLbDVq7g+S+4yfBhAJmof4YOPhDuEzOAnvDj0n4lugaBseVrp1zpXeJ7cm2Cgrr9Q4MHqHH822IkRAxfyXBs5gfH5DcXi0kv8x0VMaLjdNeQQQPg87/MsrQ==
Received: from BN8PR15CA0037.namprd15.prod.outlook.com (2603:10b6:408:80::14)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 16:30:49 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:408:80:cafe::47) by BN8PR15CA0037.outlook.office365.com
 (2603:10b6:408:80::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Tue,
 18 Mar 2025 16:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 16:30:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 09:30:29 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 09:30:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Mar 2025 09:30:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@ziepe.ca>
CC: <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <sfr@canb.auug.org.au>
Subject: [PATCH] iommufd: Fix vEVENTQ kdoc
Date: Tue, 18 Mar 2025 09:30:22 -0700
Message-ID: <20250318163022.709490-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f58bd9f-e135-4e49-4335-08dd663a3d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zNX1X5YZbvwigu/tRtxjnXcOh/7qxVFjr68xsZSsk7/DGBmg3Hl1167HKyOX?=
 =?us-ascii?Q?pxWHjWWKI9N0NybjfZlTtBHMHCW0YcIqT+h7IxbB0VLwPUn8gPQdHWXkDhdw?=
 =?us-ascii?Q?EcHkDN6mO4XVQ+wFGwqJY5ua3AExYhV8EdgNeIitjLcAWP3p3IqggOo9utrX?=
 =?us-ascii?Q?wNTGP1a/0nLcKmDyJg04a/dTtUKjBFw9V9FVaQIB+s6dXXudTMcMFLF0cAB2?=
 =?us-ascii?Q?Xqn8yN8lCiaU8PXzZRmBGXoKSJTy7Zs2yOd8b6drGlXN35VN555fOtqCjObc?=
 =?us-ascii?Q?4gcD+FSFF/xCx876qIQWaygLpamkv+HspFrnL4U85ZoFQci6m4s3/RVVT1JL?=
 =?us-ascii?Q?oZRqSHLcF+hAjfPvW9Us+zxxY2n/X3rSqOb7+4HfR41VB69SEroV+d9sAtVK?=
 =?us-ascii?Q?N4++j5ag8mvMCfbAKTkbkdyG5GWPh9xcusNfvX0r2DR37jY8RK/AW5m6/McU?=
 =?us-ascii?Q?FEWtchq4N9TS6ozHCkjwM7mUJPBJwMAYYjXZfe/BefM7YUwXHxuhPkZuriLM?=
 =?us-ascii?Q?k+VXnIrLsj1IOzLRYgvKN6UXpOMdNxEvkPETCJ1Cudcf2+uPZYSRxO7134XS?=
 =?us-ascii?Q?LwgxjGI+IQ4lE074vhNbbncldzoCGSJZ2pp2VPFa1xlqPNHwwwWXXz4q9eVz?=
 =?us-ascii?Q?t8UfGU3VhK2LpJS40ZRMU6MLxt4FAtkbcgmMMrsXyyengy6sAhOSdRzczrhO?=
 =?us-ascii?Q?oS6rTop7bAJXiJx8Pg9lc6UFXJpFI5toW+5ULjbMENHC3wbwT901Hzer7Ah/?=
 =?us-ascii?Q?jqh8BAcQ7/hSUsG3Vfg+HOTa3eWeHC2162d4r5TxHnrkO33eRO0Wu6pPf52J?=
 =?us-ascii?Q?VjNAm7tXq9+P+XIZNnlR32iBzig09b5eeEA83YBr87OS+ajs034B/ytagjbf?=
 =?us-ascii?Q?Tbo0yeuyqZZljitybehaIRXJf9WNeLAf8UWvykAKNJALX79B5nZApBvRPQj7?=
 =?us-ascii?Q?nB+MmKQPsn+zI9oJEzBIH/TGrzhxO4HC1Exm/cw4YmWL4K/joYArfsPUXTk+?=
 =?us-ascii?Q?j7cX/+P0wO3ibqOG588953xoa+KkATTgVq/gwnS6JtFa08fQ9rOhanLg/rXq?=
 =?us-ascii?Q?SqiVyXf21ailJ6Kr8Lstf7gPzAbP/GNBJI9HNHY3qtvbxLon45OzfTaDCfxP?=
 =?us-ascii?Q?T0S9Y3L9PpjxD3AjXFgeWor2iLQ79b5FfjYYWoiJtTDhcFEJvj/q9kWeYBqn?=
 =?us-ascii?Q?WA00zTcR7/Qf7FlRo2BKIsLEo3bJ530sNo3vofKdoFnxISkYjZwW3z2Lqg3Y?=
 =?us-ascii?Q?XLPq9tX/MxgQVztAV634ZXAclOqYZ+PYIyXOr7t58Ms3LsA0VJEP8cQLwA/J?=
 =?us-ascii?Q?bh4pu+Dw6K3mo+VsYaLU3xDqAL5XXETh4LYw+Xgc7tJGYdqMZKejwl50DpWL?=
 =?us-ascii?Q?b04MZBR0TOW2HXOVzIT0c0jgW7VaIp/7Tk7yQj4QhAtXsUiucGTgMk9gdyKn?=
 =?us-ascii?Q?BIpKXEkonlpFdmCCVabOIOGEAuUpxRyrYEFVUIYlj7omyoReePu0wS0hmFJA?=
 =?us-ascii?Q?h5VnDlTnzm+dRqw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 16:30:47.8418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f58bd9f-e135-4e49-4335-08dd663a3d5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

Fix the following warnings in veventq kdoc:

include/uapi/linux/iommufd.h:1024: warning: Enum value 'IOMMU_VEVENTQ_FLAG_LOST_EVENTS' not described in enum 'iommu_veventq_flag'
include/uapi/linux/iommufd.h:1024: warning: Excess enum value 'IOMMU_VEVENTQ_FLAG_OVERFLOW' description in 'iommu_veventq_flag'
include/uapi/linux/iommufd.h:1120: warning: Function parameter or struct member 'viommu_id' not described in 'iommu_veventq_alloc'
include/uapi/linux/iommufd.h:1120: warning: Excess struct member 'viommu' description in 'iommu_veventq_alloc'

Fixes: 50c842dd6cd3 ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250318214534.5476f9ed@canb.auug.org.au/
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 5fc7e27804b75..8719d4f5d6183 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1017,7 +1017,7 @@ struct iommu_ioas_change_process {
 
 /**
  * enum iommu_veventq_flag - flag for struct iommufd_vevent_header
- * @IOMMU_VEVENTQ_FLAG_OVERFLOW: vEVENTQ has lost vEVENTs
+ * @IOMMU_VEVENTQ_FLAG_LOST_EVENTS: vEVENTQ has lost vEVENTs
  */
 enum iommu_veventq_flag {
 	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
@@ -1086,7 +1086,7 @@ struct iommu_vevent_arm_smmuv3 {
  * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
  * @size: sizeof(struct iommu_veventq_alloc)
  * @flags: Must be 0
- * @viommu: virtual IOMMU ID to associate the vEVENTQ with
+ * @viommu_id: virtual IOMMU ID to associate the vEVENTQ with
  * @type: Type of the vEVENTQ. Must be defined in enum iommu_veventq_type
  * @veventq_depth: Maximum number of events in the vEVENTQ
  * @out_veventq_id: The ID of the new vEVENTQ
-- 
2.34.1

