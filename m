Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3601EF0B9
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402674; cv=fail; b=somsCVj82qcCv6BtPCS7VzIvPpbD38QuTNTmdl8kr15gYnP0wTK9V1l2EhmE+eGwvNEhHYKJ2CDmT4OaVlw9M+UvAs+KAS+fyKea+sS8s9SZ7cOUjqsdUEf0+2uf3srevQCh6H5Gh7WNFEkBSXx+HcmFO0y8jfNsrpgXUgyLqqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402674; c=relaxed/simple;
	bh=LtLZyP9j0hZzCjMdW/u5G9C8nHYoHI0XoyL+FHgNb7c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GsEvO+C/5NPPb1RcPEPF1HOUjl3Rt4i/Ilb33c+Oy+1Xn+I2CB6kw8aLyxDOOguvje1QT3gYrgd6utXxpc8WmihghWYpfnOj/T7en1zEBbYyNslD6cIUKg8PK8tzww5pflQgFmvMAKfpGUCVYFqdnYhZ+QMhDAWPRhUyHrBkiBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yu2SV6+f; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yu2SV6+f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lShf9NdlqI/Z3GT+Vvv5JZ2F6viX5ZcdCAamDqKqE8B0Xqz6vT1AAmOkWIjx3Z0KEYVYNI0PAVqaFSDV5SGj8kt2QVqPgWLsIDdqRhhpH4fMs6tax76HuOQwa2reAkPwkb1CCdkQR7Bk8xvW79yHiCw9RHYU7+duMr5v89AdRlwHy/qI/B5JelRsdZYqtYQvLlIOGB6jnCfUCSziIYkvr+KcnMCi227CYTtwU3M7XCjNY7cnLYZcImOuBKf7nJAwWsSwq+CGJIZ0y8JLyu3Lae0v1sh/3hFfo85drMQpC3MIKNPeeEfUtAhBOQ8sPAY5BD2kdHFB5RE+LkKf1bAVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qO8L1TuS0mthOn8YxPUdOqJSmWgzyi5qSturhHl1m4Y=;
 b=MkU7rVzlDfPveWCWx7usIeJXxnhRqQbSrSW8L7krn25LLf6+Oy9VmVa3hrJH8p898Avm/mDtonrWcphaIGXkAkURImBhYUgZaANZH4dvlMNTn9u50zZs2noIauhFe6J63mjkzELA+7biDyF4ApaM7RIg+ZvSdQEb9eo2IuU1d8z+bpNrPVyO0/NlCe5UpGYZhMck1EiwsVNAaMCKHJI22hGNftjDEmFtFsIRhHZBeeZSmGbPZE1KN+VV/X2nvsVjeZyV/Zs4txkohMPlBJfjfgceJdnwY02Coa3LtYIq75Sg903YcpnVuRlkg2rVcWsXHPM2uK1uXRHuOSGJAIbdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qO8L1TuS0mthOn8YxPUdOqJSmWgzyi5qSturhHl1m4Y=;
 b=Yu2SV6+fwu8z+H3WRvLEeQUPTnJxiMN5+FbVroGu/1soEz1KHd5PcNS3Z5Of6bBMXkmt+excgkqg+ZOAs0TXwBbGlZVcEDABD8gOkfpql7i5nam6T+uMbs7ZCVW2JbI1eBT0jkxsIU8naz7+4kRxRq67SVtxdSfb8iUHHjp0eTk+XKJQ/Ir8cNvmdLmdmIuKwhr+GBfNzQiXxzv3EbtjxDtzZp38xm4AESNthKvcoRoZe7Ld+C5ULAMxwGsFBjV2tHJf0qimfmooa32vur7xcES8f6Is7aPn3eIaBuFzFFaeEYBNkEsE2g74SyYKwJMuQLAQOU9xpGIfLIs0UW6hsA==
Received: from BN9PR03CA0092.namprd03.prod.outlook.com (2603:10b6:408:fd::7)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 19:51:09 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::fc) by BN9PR03CA0092.outlook.office365.com
 (2603:10b6:408:fd::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Mon,
 20 Jan 2025 19:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 19:51:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 Jan
 2025 11:50:56 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 Jan
 2025 11:50:56 -0800
Received: from Asurada-9440.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 20 Jan 2025 11:50:54 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH rc v3] iommufd: Fix struct iommu_hwpt_pgfault init and padding
Date: Mon, 20 Jan 2025 11:50:51 -0800
Message-ID: <20250120195051.2450-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: 461c4c9d-011b-457b-52ec-08dd398bc89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iyZfzz+xvfa5c4pdTJQcstFuwImbTMKJ2IAYic0SKdcmI34bAWJh+GeY5HB3?=
 =?us-ascii?Q?SqxKG8Ajc90G8+6ql5KsdOnWG9mJcUOH3+zOUGya+HrES1sTp5G9TKBmzlFR?=
 =?us-ascii?Q?dwwNth9hUIuMPlM6emgQUjpgd9vx20kbII6OtvgEBenIG6PhG3XY2XVcnLne?=
 =?us-ascii?Q?XCPT3iRqJb8VRiZHVI5s9/SOnRsDYT8X32Inu3RR3aJlSRdiOu0dIWxah0J8?=
 =?us-ascii?Q?une5jAxKOCGb4mCFuZusdSphajrRWMWMe1sY14Rb6vRvWq9rHTjWTty7iAHD?=
 =?us-ascii?Q?3QZvXNAPpuqY2Y0u5+RLDQctpJGwqOwSzXv9tbTrs8dO3G6ibjz3yCO1036S?=
 =?us-ascii?Q?TP519zv3PwpPRn97AJinkoNFhcx631GfIToImJzMz8tnHWNullN422Qtw1YS?=
 =?us-ascii?Q?1lLxzZahKNb0pNpDJNAqIu7RAlKdncsCbQjoTrQqMeTk3muNZCNVBrm8g7Xa?=
 =?us-ascii?Q?kSO5+A6PMDcwQZ1RDNPgUefMVpFCziAqe7c8enJL07aQXuTLuFlgR//nT1vs?=
 =?us-ascii?Q?l9SyJFA5dGUQmnLETkL3aExn5eEWORhWMq9rpV31xwzondMbG5SnzKCAfn0R?=
 =?us-ascii?Q?UZdHTqDwTgIBSwsw+kr9WT5a3x59OSuWHSYfEb7IQY1HxREClkvkJM+kDz3j?=
 =?us-ascii?Q?ULf4h6/3L5FFD0Y7MVal6gY47+YWJTL4gg5aStECvgd1qQPkNvAvuhnVoJaP?=
 =?us-ascii?Q?GnydRBUiBx0DnDjGllgJHG7dOFpBYWevTmWXtLVzmFuy+SKboVUbw7t8gtWM?=
 =?us-ascii?Q?YKgEOxKRjlCR/VWGD/gFfAbDOqLiukSh7g4NEGY4Nt52vam0t9qLedsyYYc0?=
 =?us-ascii?Q?aYr2r7IPH3Q7wB+O87xnYRh3anbPA/eQYIdL7mSN9qWUxxiv1xkz8WbKjsjB?=
 =?us-ascii?Q?k4zdB0sAV1LEv3IQndysFKpHp7iipUB+V/tmjpcIM1UsaAdUBehiN3i7PXJs?=
 =?us-ascii?Q?ae1/rRlgiKsjWhsiwlkMmuQw/WFVy3cs0gn05AnhNe4J3BcudXefbAcBCMVZ?=
 =?us-ascii?Q?HZLp7N/n9z3zo2qgiXJQib8aIJz7hQVQqeCTD/CPl96nGn9xT/K0kgAMujGW?=
 =?us-ascii?Q?Lg0qrimdBWRQwuktU55lNvrIIAVtigsi2fHw9tlf5mrL/YZRoS3c4OYwqIfS?=
 =?us-ascii?Q?J4ZaEqTyN7fdvGWQvnkud9OlkurZPLqblsra8MVDMqpZzCEs1re0G1LO64Vu?=
 =?us-ascii?Q?xUgHXEgkI7yQJeNQzpZhTZcAdWvZNdcNQYKPMwFWgrqpG81m/LSNkzlqeHbR?=
 =?us-ascii?Q?/GgS3ZUxCFhe91eEgj0hehJcz1zQNUS3HPkIMiEdy/YJ3NXL0dxL/i8FCwEl?=
 =?us-ascii?Q?Eyf4p/eHfvWgW06v8GtCPdJYVTro3sL0NJh0/+HbkJn7QcBgjzBfo9mRvip0?=
 =?us-ascii?Q?76qZsy+u5IvpEBSTOpk4tt8txcHxxzEn5ffYIFxQoSr7k/FkFGEKzrMNdTvz?=
 =?us-ascii?Q?xI/7F8t0LVFkJGJNi4/wxwemKoXSobdAdr9TE/EoGCdQGMCYt0ycDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 19:51:08.3372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461c4c9d-011b-457b-52ec-08dd398bc89c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486

The iommu_hwpt_pgfault is used to report IO page fault data to userspace,
but iommufd_fault_fops_read was never zeroing its padding. This leaks the
content of the kernel stack memory to userspace.

Meanwhile, although the padding could be done by the compiler, explicitly
add a 32-bit padding. Also, change the __u64 addr to __aligned_u64.

pahole result, before:
struct iommu_hwpt_pgfault {
        __u32     flags;                /*     0     4 */
        __u32     dev_id;               /*     4     4 */
        __u32     pasid;                /*     8     4 */
        __u32     grpid;                /*    12     4 */
        __u32     perm;                 /*    16     4 */

        /* XXX 4 bytes hole, try to pack */

        __u64     addr;                 /*    24     8 */
        __u32     length;               /*    32     4 */
        __u32     cookie;               /*    36     4 */

        /* size: 40, cachelines: 1, members: 8 */
        /* sum members: 36, holes: 1, sum holes: 4 */
        /* last cacheline: 40 bytes */
};

pahole result, after:
struct iommu_hwpt_pgfault {
        __u32      flags;                /*     0     4 */
        __u32      dev_id;               /*     4     4 */
        __u32      pasid;                /*     8     4 */
        __u32      grpid;                /*    12     4 */
        __u32      perm;                 /*    16     4 */
        __u32      __reserved;           /*    20     4 */
        __u64      addr __attribute__((__aligned__(8))); /*    24     8 */
        __u32      length;               /*    32     4 */
        __u32      cookie;               /*    36     4 */

        /* size: 40, cachelines: 1, members: 9 */
        /* forced alignments: 1 */
        /* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));

Fixes: c714f15860fc ("iommufd: Add fault and response message definitions")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
v3
 * Cc stable tree
 * Fix iommu_hwpt_pgfault init in iommufd_fault_fops_read
 * Drop the "__reserved = 0" in v2 since it's redundant now
v2
 * Add "__reserved = 0" in iommufd_compose_fault_message

 drivers/iommu/iommufd/fault.c | 2 +-
 include/uapi/linux/iommufd.h  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index a9160f4443d2..d9a937450e55 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -263,7 +263,7 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 {
 	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
 	struct iommufd_fault *fault = filep->private_data;
-	struct iommu_hwpt_pgfault data;
+	struct iommu_hwpt_pgfault data = {};
 	struct iommufd_device *idev;
 	struct iopf_group *group;
 	struct iopf_fault *iopf;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 34810f6ae2b5..78747b24bd0f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -868,6 +868,7 @@ enum iommu_hwpt_pgfault_perm {
  * @pasid: Process Address Space ID
  * @grpid: Page Request Group Index
  * @perm: Combination of enum iommu_hwpt_pgfault_perm
+ * @__reserved: Must be 0.
  * @addr: Fault address
  * @length: a hint of how much data the requestor is expecting to fetch. For
  *          example, if the PRI initiator knows it is going to do a 10MB
@@ -883,7 +884,8 @@ struct iommu_hwpt_pgfault {
 	__u32 pasid;
 	__u32 grpid;
 	__u32 perm;
-	__u64 addr;
+	__u32 __reserved;
+	__aligned_u64 addr;
 	__u32 length;
 	__u32 cookie;
 };
-- 
2.34.1

