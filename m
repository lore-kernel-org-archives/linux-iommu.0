Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486E5696;
	Wed, 12 Apr 2023 13:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ytgzk/K+JkGv2puDUyskRpuyyZm6CTYwudivl5wCeMHsjv6Es5P6ZwconaeY+409aIpJqg4PGJNsg3Ycg5zeieWN2hdBa5MS69QygrnZC88W+RYsqiAWAh8qTZNHRZ/YxhAIEBh1AWZeV78+OY4JDX3TsNI0VkFMHjojrMhhCA9aR6rbU7iQzJc11myA92FTeNBZ6f6elsYBg6E+X7rxiRWB0k4JhMVFbyFdLV/l69Fluu/Pd4oYpIcv5xdxgJeAsY1nWuvtFumuYWr+bce2FBcJz+FzbGNEGO7r6ze5WgLdB11Ko21R8XqlOgHC70IeyhaUEWBsKqXRRtZS5x79Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNAQUI4P1GxBKr7gqKj9LbVZA7/9Ya3GRUXbObFiAv4=;
 b=gkVhJA1eStFQoVWDdOC8vRyDuHemtg1Rw2BjhreOfnHVwhyLdm6RGlwUSTp0JEp7KJeL08ogejnWjF86JSzI1OTTAISUjC5dcg+jTcZQ/xSRmOZwqiy6Uu09hCreAeyLOdZwpB12UT9NYW1PbaTXmi0OzTqz/KD0suF5rUgnf0AJ+CiAg1FVzdIZFbJUhBF6Xjfbw3wjzi8ssFLTIbCAWCwvokYQ0+YWEvhwBK4LyTrF4DMeRtuaNHDcxqAzBSjTfQzlsA/6GPjusNDHDYl/iN9iPA9r6inLCo3ExyH8GkPa9lfX1nxIhZ2NfSmsypo5CYH8ICKMANe6yEncAnwdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNAQUI4P1GxBKr7gqKj9LbVZA7/9Ya3GRUXbObFiAv4=;
 b=DWz9kXK1yfNyvWtp00khl6fBpH88XCkfvvE62Ozxt/aj3vTi+5qNiWMTWqmbwmWjP+b0DZDioREg7anpf5vBEh15VQIxYouLuYssVnj2ut/8d4rEZN9FqKfjDQrFluCY/IIPAJO7TrcAKmTD1IIxKR1NJpciwGzUvKkcI1ckap/eZIZjMb2j+p5RjPBQiva2Ygl/5zVHf1X5wX19HdtZU7stzyJmtiN+UmJp/+7vgX08HWE5pU0NZBeEcCZ7u8PKQj7jeKRBaNGKpNZLOTyDJQC6+eRKjtr465pihYuZeJeThIrnhvRFcDifoiQbF/HZOIel13bVpCiaUA6mhbQ93A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 13:51:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:58 +0000
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
Subject: [PATCH v4 02/17] iommu: Add for_each_group_device()
Date: Wed, 12 Apr 2023 10:51:32 -0300
Message-Id: <2-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:208:15e::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1f704a-3d3b-4a1e-d7b6-08db3b5d1049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5me3pVk1vhKjQxB6529H35pyog2F63M2/tuIndiuaU2rtkKXx+Y33A3/QilgNI+Pog3CZgBXdOKV6ICEa1pgnz9tv2TyqxfKv7LwfrrNrO0Dp6yQKeI5gJ3eWfJdLmm+i14/J7skmCS4rZDchjuuFw5/sokVyXoCjBpl0ozVPg5ksMBM1HABBO6HONVyA1jon7J488HdPUznpZVGheP6rz+OAbQLclBQWq0K5VuEG75aUpN8jNwjCzelSk6oe9CjYklLKG39kXtloUrmE6CDuqu20HpsZIMmPNAxNSHrqdsXPkimP5BG3ziOXCcNYH584kUTB/Dc8G77S3wEYj/bijJZ5QfTRDBTT4EKMtH0uoBe2Rcdq0sTnaXvo+1Qt0y9e6KaPcwATc10enz/agK8uN9p23r3G7knfvO6OFYt5cweN+sMLR73CQtaaU6tKP+DDcKm4VFtKaKSYGVokuV0J1ZpQDSOgK9fMsm7mZNzGY2DBP5JSJskJdeKhzkeOPL/tgj7udZgnPOt86eJZMbmxy+5cF4tWO/H9sASs6ebpif7N8pPCj7OgfwnF0frTiHDblZZOfBnB+EyycSjYYJP9GG+EDWAnzlX+kEzBrgNA6s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(4326008)(66946007)(54906003)(478600001)(6486002)(66556008)(66476007)(8676002)(41300700001)(110136005)(316002)(36756003)(86362001)(107886003)(2616005)(6512007)(26005)(6506007)(83380400001)(6666004)(8936002)(7416002)(5660300002)(186003)(2906002)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sezpqk2Jxo7hNa5rmNCe0RGl8Mhg7GQGNGrdmS4vkcLbBOhLd+PGuIQ73b87?=
 =?us-ascii?Q?fYVP9ilMXM3aj8/HfGsuDow62UGLoNc1b7HlcHVkmY89yxcYUOPhGTRhbfqR?=
 =?us-ascii?Q?qn0YYsgcsqHPGO9ERCAKJk1rSP3oPj4r+yflHGM6z+TcrvkoLdaqfrNJjSks?=
 =?us-ascii?Q?jmzQAO7TUo8sfJTPstZV4dEFFOVhIhEQgYjNnG6DME+9uzLtlBE37jRM0Q3N?=
 =?us-ascii?Q?RuOoelMq9NhcOjKhzoNDexzS6qIw8oPlaSQiU3K8z9o1W+AxF1mbeKGyVUZ5?=
 =?us-ascii?Q?PuJSoHeC4xs2VihXfaDDloBMCa8ec2sd3y2Ax5MwpgWLjvSoZugX/f/wmQ1a?=
 =?us-ascii?Q?0bwztb2qzgajyBSQdCMnk4u7Czs885bvFIJFvrKT2L9ayetfAf4YTpRXdLBi?=
 =?us-ascii?Q?AeN90lVumc+1wCYeOTcbJFqmOZzc1cRimnMgQROtrfZsi45RGiircAtDgzpe?=
 =?us-ascii?Q?4jM5F4mBx8+V355Hy/YCwyxaSiWQQhj1AUnaQ6K429+CgWOhWO6k4YJi77p5?=
 =?us-ascii?Q?Fdjj9eTpqux+Tex45Rh6BGpngG7Nez4po2HvU1VVUqNFvYsR0401/R9+B4EB?=
 =?us-ascii?Q?CbxLsAjN8/sQyseeq/mpLtDCbAB5eZM9o3EOEYbYBNrwL7K2eScLavR1JzfK?=
 =?us-ascii?Q?4uB5WoHaMezWGuKkYOzn/ylCL4+RsJw+2YvWHfeG1GfQIYJO9ZtR2W8/rwfS?=
 =?us-ascii?Q?/Nf0r/UTjTGwKfAItn9ombBJdFY+UhNGYUYoxrgTAXkTviSVgrlbzatDXyQD?=
 =?us-ascii?Q?L7RjY9fuGqNG0V2PV+V5Dg4beFXFVZPQTgq4e3fIW40mYR9svJ6QOZ8Wl3NI?=
 =?us-ascii?Q?VsTSVfY04HO/haHJkyB0WdqH+LdeCB7QsNqasieREXsNHzu+Dv0Amm8/rEwQ?=
 =?us-ascii?Q?lhe9k5bDPy2ifdMSTENRVY4EYgxNQsOa6CEdd+3AaYwlYrsEwvJst82j1/kq?=
 =?us-ascii?Q?wQJI8J/T/wuGRPisAUTsvGMWbIEEYJbEcZG2uHVKDYEElY05XowDBqIO2eD1?=
 =?us-ascii?Q?g2hBPBZJ64bxspHuq8wTJCFbHoHjhePLIKIbqres1LrOuryglcoUXEjMhNSv?=
 =?us-ascii?Q?4JA0qiGCUmeCHVV8Tn7EzyJOPyHyGJU9CJIJ2cDdB1IjKk/j0CzoDl5R9r2R?=
 =?us-ascii?Q?PIEm8zpZjWNUOB98Ttmhc7IpWhvllQovVdT92aPzHWX1Y11unL35kIGLdcZ8?=
 =?us-ascii?Q?2vDIoY3E1Imy0GWvlYBylI7k0OADm/USswnx4c+HE9aNv5iV8YMzuof3fEV2?=
 =?us-ascii?Q?1H3aHBh1QNsak+2YJc/BBfq0+riUXroreqpsZOTqecJqruFOBa++R9Z+HBeT?=
 =?us-ascii?Q?X7GI0+uaB+JMBo/TSTYSYXE9uZoRhl+NXBxmOy4Ta+8voZE/on8nf2JT78Nc?=
 =?us-ascii?Q?+1cGP8GSa+46V/WdXtYYr9kyQxePOEXWF1mzaj4cJzE/sN1SMrE+DI1mrtNE?=
 =?us-ascii?Q?A687o32PZlGoiKzLm3/C9Vek8Q/o89cNRgi4/kR8s/e7kW9DudrLy+adta/c?=
 =?us-ascii?Q?XuD0EDNTZAeChIw+R7xSS5CR5y5adhO0OOMw6zxoYQvF8GCwkHomKwOxs5iM?=
 =?us-ascii?Q?GsYle3K+yDD4eb+VatitbEQ8db/0RF+mHuNZFBwS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1f704a-3d3b-4a1e-d7b6-08db3b5d1049
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:49.5237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seySxvVHAPIj8OdbzIW291KL93BuT0XPK/C4IXD6XDzQGJxsS682S6Q8iU4U/8e3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

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

