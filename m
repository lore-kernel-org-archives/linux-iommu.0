Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8AB156F3A
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737354272; cv=fail; b=Gdt94f9SOsHmqVri8cNaMHnbNidQhGid6QAuODAszmlmdIvgA25NwsKErvDgUaZOHRo5F5nXyEB6hleK9TAtekdw+McxiHvyi73M+Fj4OWXn7KDy1Ng2zu95LGUGP4vxwV22ZcFoYnQsDHFdF6VX04IOCPrt5kx4PgKjn6fSybA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737354272; c=relaxed/simple;
	bh=EG4b7NPUp/v8zfeK+DuoyeSij8ZO2sv0ZNa5xk2oGIk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bEsVewtL2lq4kY357OgMmCl506zEADUMWav1umNaVKU5zwvpl9xNKZGQ//PyEC4ZqcPyBKumBYPpr7hj/ox+qlRX+GxyZ1kea4Evu2ckFzWhNvePvIptNKcPXnmJvgRrVZFiapTihvU/poNFzqG0/n3GkQWQ9OL6RRcOgEFacN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qXOePrTK; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qXOePrTK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAo78zWFtW0ccK4ymfK0k+KLoPUkLEfk8sbwQT45AJFHagor1EdVUfthOdLomP2iqJCA93ufDvw+Nj796Mq4IlP/PtYhZqi+hpcOvTlqsHdsSlJy5idOTCCaIhcNdebLVVTImVqP5B5UHHBn58/k6KdZjOzhd4GNTPfnf9ToHDl6Bi5WI3cdpRRNiO0HWwFvXeTrquL//2Ju0kuS53WVWViV1R7f2G7ueG0CBlUw4gBwf47dJoayjyhYcV6TIM37LvacvPF07fIdAESioCcc5va+tAgzb5C1bcK9pUnaqL4L0tzUzedxsgsSIKUs34m/ckFU5tGiGCN9J2Nn+MZTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4rHdD1n96b6YfrlDMR0f41MFiVoAukscIPeXIsVOmw=;
 b=wsgsj0UlNjyYWjTkiFt5IoY9T5hjFvohA6q3Je7IOPkojqyeHXRRDjeA9qUdglL98D7+JnuNERVGHHlDrED2LTai/aRh80A+oLbpSz4LM7Q63I2mPryyI1BNkgl89yUkqCVcj3JE6ZBq364odvczlh6ABFEFYNey04vOa96hFlMhou20K1DkcBQhAW4Tj0BtMb7kqSZqBev/g0ZWL2SAMMRQCoftn6ySXqMWToJTB5Ajqqsvlu1UkQY8dlo5Io1/s84AJkfyJwtOK9/F07CRkdn/mY0rDzbqkyZ9f53vZWRfEgvJrOB6BCCCyYXtvhhHfPU1ELhySi7AWr4ILD015Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4rHdD1n96b6YfrlDMR0f41MFiVoAukscIPeXIsVOmw=;
 b=qXOePrTKLTj/QLVsdlT6GeaPye/gvAkMIht1S85wGfzb2R5V/VcYq5lPQkmQ7DBX5G73E3PBzAIB0dRgQBAb7yikhaWPa5UT3PYTjmqvu748slesFQD2+qksL0RayWw/ZhftnJIR/nIN08cIY/0HK7cih52I8VUNRMtO96s6ZtCTChspzOSe0i0Xt8IquQkURh43bm322E2ZMuu50uXbDNl01/zkpLGehu/d+2H4hbUVPZZRxmhDqiR3QNA7sOYg/Y67cYh8O5cnb24lLuu3KN8frmsjajJiCYiMdzeK0N4ZDkWAKkS/A9DdxwZ/emmlROxxaRM62JVFBdeZhcR3TQ==
Received: from SN6PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:805:106::30) by CY5PR12MB6059.namprd12.prod.outlook.com
 (2603:10b6:930:2c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 06:24:26 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::e3) by SN6PR2101CA0020.outlook.office365.com
 (2603:10b6:805:106::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Mon,
 20 Jan 2025 06:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 06:24:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 19 Jan
 2025 22:24:15 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 19 Jan
 2025 22:24:14 -0800
Received: from Asurada-9440.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 19 Jan 2025 22:24:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH rc v2] iommufd: Explicitize struct iommu_hwpt_pgfault padding
Date: Sun, 19 Jan 2025 22:24:11 -0800
Message-ID: <20250120062411.1589-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0fc41e-91cc-4674-fe62-08dd391b16cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IOzCkcM5nNzE9kqPnwe0o4QDTdqCiRRQ5P0l+d/+3TjTOuvmNQY9CnIQJ01d?=
 =?us-ascii?Q?ggwPhge61YI6X+gpoCZqSYuZcb58NzdidDxKU1JXvx/lnk2MqiHZ0S8VtoKl?=
 =?us-ascii?Q?D+19Josxv/KO/gSTZ88lpIiYD+9diM5SRpYkMa7fT77ADADGtiUE7t2EPvOJ?=
 =?us-ascii?Q?NJCMRF7Wd/hydu0Zfgfoh8IMzSvK7Bkfso6WftK6lDYmPrDSbMF8J6F/zcQD?=
 =?us-ascii?Q?jjNpD8ZxvD6YqRYL1japYXTDsoCpQWKimlnRWKzfGoQZzgD8R0saiODD4C6K?=
 =?us-ascii?Q?UyjZH5PW905nbU1kacjtWP9CPB2AKNqmhIVFAmAvg7XQDUPr6GNasTfiBKOV?=
 =?us-ascii?Q?ARXJGQSod8lfiOFmZB2M8EKyKmhx5zsO7MajWGnsCT5Wuhbr/LODQwOGj1VZ?=
 =?us-ascii?Q?F26wvgj84wwaYakFScJ1EoYp7bLuBsTVl+6EjJ9fUemwIzQ/BEI1HXZ0dHaN?=
 =?us-ascii?Q?hw7/r84zQ2MgHXZnQTIQVeCpiX2g4ZWqlQCShiyJPnNWEBSlNy9SgdO1yH8j?=
 =?us-ascii?Q?FopYaL2+YwZ8Lh+xaYIGujoB1lealyzYJN6DMNE21XBSlvq5B3PF31gjp+oh?=
 =?us-ascii?Q?xQyHV3I7dVpfBPXw475zmBUuPIhrGFnKyyD5ySk/urCK3Wbd/lnQOwjAl0IE?=
 =?us-ascii?Q?v8X69RORyAYNJhvm5azbhSa9P6C+JAwt+PxxeLC5guRPW6zJBUYwyhy59yOX?=
 =?us-ascii?Q?M0V8uQswjWAKeJxOwbxqJBqOPtBCT0U4gO1THlH7zXuLHlWET1EilOn76V2v?=
 =?us-ascii?Q?XLQlpipKL2GlGnWs9sMdWYmHG2+ksmLCw8fciHD/WmPyUZ1Pp8DQphdsKBWn?=
 =?us-ascii?Q?1q2eR472GLDok/EL7DCeqROlcMxCn+76Vrp5//ymn9QKtJFbBE+b8VPZsVVF?=
 =?us-ascii?Q?I1JMsULDoPmRvHA3optUOYFHJZLAHtxyyit2+Tt54tOCuZppfjFBYt5JZglT?=
 =?us-ascii?Q?I5AgMCxVL2zadFPcjV9XMuYRtrBEi8VQFR4y58TN7NmnNFLKeACBCaPuVCe9?=
 =?us-ascii?Q?XiVJPIknWcudxuWkaHz95N4f432flGuOseQGis9Tx9xgt+CMvy/vTmlaihYi?=
 =?us-ascii?Q?oP+IiLbeGDpANulQbN6wA9A6XLhktjgSbv1qS+3W/YFts2bTSyb0NVP7w9bC?=
 =?us-ascii?Q?wK+x9KAncPGoLTAKw/k3UUkqbvFxhMJPqMFXPi0yFMNmWJrCySYE9T5PsAJ/?=
 =?us-ascii?Q?BaRCm28F9E/4EPbc09dp2kgn+PcRFDESOIRs6kEPUeubYK5SC/iqPq24FZbA?=
 =?us-ascii?Q?2IJZBunT89HuH4tfQJ+Shxs0JH1rs9NXQuyeyvTe7ZE0iX3FcVGafSdl745I?=
 =?us-ascii?Q?P+88DmwShKEsvpYFwPZLNZxo6nKPY9tYWr/oQDOsgd/b2lI/dTEZS2T7y70j?=
 =?us-ascii?Q?oNWCdUnxdAQ4p6UNIBAr+u7QpmMP6+khvmxYv13gmiXerjUKKci5uzvxaBuZ?=
 =?us-ascii?Q?dSDnzacqJ1k2g0sJxaHNqYXfJ7dKx5OBnGOLzIJYBkTZlP2bWDoHsAQYYjca?=
 =?us-ascii?Q?/ybZDA15v7bDBHM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 06:24:26.4596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0fc41e-91cc-4674-fe62-08dd391b16cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059

Though the padding could be done by the compiler, add a 32-bit padding
explicitly. Update iommufd_compose_fault_message to set it explicitly.
Also, change the __u64 addr to __aligned_u64.

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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/fault.c | 1 +
 include/uapi/linux/iommufd.h  | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index a9160f4443d2..52003bf1ba68 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -253,6 +253,7 @@ static void iommufd_compose_fault_message(struct iommu_fault *fault,
 	hwpt_fault->pasid = fault->prm.pasid;
 	hwpt_fault->grpid = fault->prm.grpid;
 	hwpt_fault->perm = fault->prm.perm;
+	hwpt_fault->__reserved = 0;
 	hwpt_fault->addr = fault->prm.addr;
 	hwpt_fault->length = 0;
 	hwpt_fault->cookie = cookie;
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

