Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2901322A;
	Wed,  5 Apr 2023 23:38:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzLw77nFqlJqTbca4dn75IPXA4L8cVjoZViF3TgYSui6KQrSFDNwhICZv061MxXs1qP4sp5d7MuhTizV0JgE3A7cCQTJxykoWg35bFUSVhV9YoM69EdMbOFQVR0PcEXhY1qXOpswFzREEGEPj5UJoxnl8154jt1cQP8IjzuXQWzLH6rRmakGj0jjRT0pk4t7NGlxLpT/xEMB/sGGSb8Ph74iu2iS7lwbhpARRqg+0knTlvNa3Xq9hRKcRlqR+I81sQPtJcTzFtrekzDCYV38L7v/zprRUYVMkeDLLJNXTsy2FzbtP7jtmSCzUCBfuTqfnk+0XQZkFVTtcpy0y06VyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNAQUI4P1GxBKr7gqKj9LbVZA7/9Ya3GRUXbObFiAv4=;
 b=h4ycN860gPCz1F9K9ucxK9iVxZTJiNnK0wdRkOv81W+BvfCv2SZ3Cb0hrRUStMDqViXjgja6hNHAFBtIsOYj08Y96a8QA57rQZ9elFBg+zFUF8a+qas/nySgodMxXQggh4V13TeUxDDeAva8XXSlBaC/W3IvNNT5Aguq+rPK2+NPeRadOS7bmqSF9atsQSIJdcYxa5EVUJIhEP94aihChRQXqAmHTxUdDoYypHDtBpZ3CMfdcpEpes5Y0K7BN81ajGM5CMSaLxdiutqkCeshmK/9rmXx3xTUHzBo1Y9Nt3tPMN8NBE9nSHueT09XJopE2MBJ2Grc7INg64dd7xaxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNAQUI4P1GxBKr7gqKj9LbVZA7/9Ya3GRUXbObFiAv4=;
 b=IcNqsrEhpIAXnXJT7/sjIY62GTAT2GGCcX45AH94hMP6QQ5SBmJ45Z5NcoLX/FGhdqsiIVUVJ+JJgt+CI8+xHGWreS/75Qjrap7I6EgLzfZ3/xNIxnxLSbmMTx5Mq/MErrMkBr8F0hTUGgQfKTk+PZnfHuFv7pmdiUFldf1ejaBYynYN/XDVu2v7GhpUMGYxrIKwUnNkMvm92lBngbjOqndeJpvFQGDSgG76/uvU8MdQ7u9kwzFGwmTUqt9S1RWLd4TGmMUgNF9dO0/TI28l0MaggFYJkHix98piAznvalHcr2s7TQLvsLt7RXt8mzJAe6Gsvu4ffNhLtFS2/A2/5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:41 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v3 02/17] iommu: Add for_each_group_device()
Date: Wed,  5 Apr 2023 20:38:23 -0300
Message-Id: <2-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:208:d4::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 454f30e7-a481-441f-c169-08db362ee23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NsYjbG3E3zeFS7JDeGZmeLryDsP1a1cJ00oC7XlGlUEfN1By/VKbYRlms4kjwAXfxHDupXUJPmSMpVEEY3usTgB/Ucc4HUN5lSE6F67/uURcLCYSrqAX/BVtNuDsJKFD4dO0tL8RHgNIx4GvQyST4UdhTr5AsmmZP+OYCSKjDQiBPpfU0yNMPjubwTiDW8vSzuIusT66P18m1Qb/ytZtSALMiPBOr7YHQjD+LmPT6pdqf0QDUwfOx+WCwYk8CL8KRcCIXF/pmljxlCtjwzpZegU/0F6yjhARj5yD/slIpjx11w0MVX8IvYsXzOVCKFEvf2bDmenFrEqjzXMFjHTdKkIsTNM6HSU7FhewLthuR0OcAUE8yF4g/bpucQut0CQKImm9OYinSem5/MOzPdjFNbNTXJ6Tka0CbgCz2gMHVxsJqONqiyT+Yaa/7gGrYsfM3oBh0rpbQy7oEuMn4EBGhiusSTlPfuKXOwgk093Y74lu5DUVH1eO8CEDX7MKE0lOtoqci5+sCEPHY0DjLcih7IXojxtLBWtfd62O+td5UER3ssxopfGvUJ1lCsApEY0BcrMdjZCFDtJLuk5GtKrdej+jMxOuYGPnk4H7/CaXcyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dvCv6ywhRNU5rCBfZsqPu3Fx6othZtY4oP6ispClPEzeVeJFqIir7VOhtH7M?=
 =?us-ascii?Q?Gs0rvGfiwUIJpE5RDZQJrIZFP70+wcc8dyymQuvEWHa6cz+izdbUKTyOYa+6?=
 =?us-ascii?Q?HLBj7GwDGzD4abvZ2bmxulHHKdA7VYLNVFLFELEYyOdJWZMQOJj33vh8fsfa?=
 =?us-ascii?Q?Wn+xxYpipDfofcHwCLsST+1Nuv09GEXWJsOft13j+AEBZ0F3X5/FwYgZtMIw?=
 =?us-ascii?Q?uJRwfBwF1ERuOcuVspUKpSR1CRasX1K+ic7JdomBxM163NNk/tTE5WMEo17g?=
 =?us-ascii?Q?X6WtP1wFKF7gkcqBTGJT5WO06CkmH/mfhs+gIyuDTFvBT5Bm/+pGCatCm36J?=
 =?us-ascii?Q?/K6r/SmO1m85xu9pLlLhImbpHMIBaYQI0tgBqc6+3CWYNPObjxdAt8nYRi7m?=
 =?us-ascii?Q?8Eaqag8PcDexGYK0sYgESstr1CH4N4WKVEHUh7BdEQ/NldWgT39FkIDRaHMf?=
 =?us-ascii?Q?GjDbJNIs4/t+qIbwovYmDqY3fg0zQ69yUQkKVjO/1ocooNZQ/vTRGGRMJqzU?=
 =?us-ascii?Q?KOeagJxjXhgMI7RMvQXT+dYaFn8z3vQtMxF1bnQZzP8ocBtaqzRimTdPz9e/?=
 =?us-ascii?Q?Uz425I4p8ADDar9+paCSeJuY+q3tt2SacqRB0fpsOIrZrwiDro+LrCnhu4DO?=
 =?us-ascii?Q?EY0UOIrcBTCN2czEP9dJUiNfyroZh6yNApglEVy/IQIwZcKfS+mHH705JnvY?=
 =?us-ascii?Q?SbEpNLXTcqfJsuiED6DHh9eMjTxBcdMPPcqNA0C4j0YsGI9AIt+zsMoVJTWI?=
 =?us-ascii?Q?eagGnNc0BJvzFOzdoQ1j8VH3QNNC+YNt0HhEppF6HMkY1NF41i8qbnZBQ/yc?=
 =?us-ascii?Q?GGF5NLgNy2T2lwQzqoUE10YzhzfaZ/SxXmREqsYdAG2b9IGZSDzK143NuJqE?=
 =?us-ascii?Q?pqLQi4OZDK5hinQUhfsQRF8MNrGMkHA0HesXOELEwa32S72giO31GcXUcr61?=
 =?us-ascii?Q?M+r8Ct7f9jrpJO6XtMs5Vo4sli6TRR3FRWSYxGxrJdrskY5sF8ba+Wphf9kb?=
 =?us-ascii?Q?eJvR/lf3dab/rA7DzgHLMg/ZncVs+/DzP7exBmBkzkslR3VmNiznoEZXUHu9?=
 =?us-ascii?Q?RNGgjFBqqxGku8pyOnPJdfX8OQMGnj3WbzYmTfGAeN06sHs/PXnzeSHSSsvc?=
 =?us-ascii?Q?kbAU02VTVH0Iz+VE64Tv+n8uNiG2BmmN+MQxHL1JjMS43Jw2uOn2compH33K?=
 =?us-ascii?Q?10HbVNPjM1Fvx5H34m3xVFFC1RgeGvYllnetF2u4Kkx1VHadn59Xh7QTbSwC?=
 =?us-ascii?Q?qDeGSbn/zB3SRjlnOBjQ23c6iKCnl4avmLFoj+Qp4mSC1hG460OFLAyb0LWT?=
 =?us-ascii?Q?yHEQw2Ipoh+Jzii1iQsH1Vw7gjdPDyITDfTSYlmGLHbSKtYgUVFuvD+P3eoB?=
 =?us-ascii?Q?Eb/h7niGkHW59szV2Np6HPXbg7u1L3729jCFgt+SB9KRVxQ3IOPMSJfj9+2B?=
 =?us-ascii?Q?dUjdOyRn316SEHCKlGBEqPjIjZ3BZzpUgflBF84dzF7Yn3g2N3bP5PBVpKOc?=
 =?us-ascii?Q?KI2ZM1usfj7Nppn7ZepsJC6zT1rI09MhMepm+XvEruZDI4ON+8eF3TAN5sMa?=
 =?us-ascii?Q?BUlXpkDCe22uKfQ/E22kkC3YF7XgNP+AcXUUbMjT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454f30e7-a481-441f-c169-08db362ee23b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:39.6256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQboTgfVcwgxsB2yQT42ImMM4axWaIdwx+bB4T07MChfOun1QEnVgy0zVkp3ayj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

Convenience macro to iterate over every struct group_device in the group.

Replace all open coded list_for_each_entry's with this macro.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .clang-format         |  1 +
 drivers/iommu/iommu.c | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/.clang-format b/.clang-format
index d988e9fa9b2653..bece1995f2c159 100644
--- a/.clang-format
+++ b/.clang-format
@@ -254,6 +254,7 @@ ForEachMacros:
   - 'for_each_free_mem_range'
   - 'for_each_free_mem_range_reverse'
   - 'for_each_func_rsrc'
+  - 'for_each_group_device'
   - 'for_each_group_evsel'
   - 'for_each_group_member'
   - 'for_each_hstate'
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8cdf47279704c2..501257bd02fc3c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -67,6 +67,10 @@ struct group_device {
 	char *name;
 };
 
+/* Iterate over each struct group_device in a struct iommu_group */
+#define for_each_group_device(group, pos) \
+	list_for_each_entry(pos, &(group)->devices, list)
+
 struct iommu_group_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct iommu_group *group, char *buf);
@@ -463,7 +467,7 @@ __iommu_group_remove_device(struct iommu_group *group, struct device *dev)
 	struct group_device *device;
 
 	lockdep_assert_held(&group->mutex);
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		if (device->dev == dev) {
 			list_del(&device->list);
 			return device;
@@ -702,7 +706,7 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 	int ret = 0;
 
 	mutex_lock(&group->mutex);
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		struct list_head dev_resv_regions;
 
 		/*
@@ -1155,7 +1159,7 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 	struct group_device *device;
 	int ret = 0;
 
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		ret = fn(device->dev, data);
 		if (ret)
 			break;
@@ -1959,7 +1963,7 @@ bool iommu_group_has_isolated_msi(struct iommu_group *group)
 	bool ret = true;
 
 	mutex_lock(&group->mutex);
-	list_for_each_entry(group_dev, &group->devices, list)
+	for_each_group_device(group, group_dev)
 		ret &= msi_device_has_isolated_msi(group_dev->dev);
 	mutex_unlock(&group->mutex);
 	return ret;
@@ -3261,7 +3265,7 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	struct group_device *device;
 	int ret = 0;
 
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
 		if (ret)
 			break;
@@ -3276,7 +3280,7 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 	struct group_device *device;
 	const struct iommu_ops *ops;
 
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		ops = dev_iommu_ops(device->dev);
 		ops->remove_dev_pasid(device->dev, pasid);
 	}
-- 
2.40.0

