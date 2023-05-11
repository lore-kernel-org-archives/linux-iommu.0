Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDCF645;
	Thu, 11 May 2023 04:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBXR00rIZPjpVexZkjBsOZ5073YYeL/Q14rlx8rCfMCFc7p7XMlHtM4De2WSofuwQWeIhDjCBAE4gSytomZKxgVaM88Zsm0yY46IrP1q/h/xmzIqPKgtHkEXqdRG2I6DJWEzyiWsnZcpx3i/lh4Me1APH8i1nvpGEJT7Fp3AKRrwF4s5xWlKEcyxi3X+bGiLaheZV6fzatE12kzzU3ylHzUB+HCcdvnsmBsKL5l/JdJWr967NIykOqgNNtWPcxHn9Ih8vLEK06G0OqxuFdhK/ndQgbtQsCOBVDy1KFf0ARFqpo1XHrtjLe3Oopay+/MIoGEL4NQsq8wkOXFdbkWxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfTEI0zkZVPC6cvwS2WiUeA5LcgScnzfZS3pkrw4Ihw=;
 b=BaU1UXIG8Ikrp9KOZ3+lJCPiSsaMcjxotoir+pO4EtrnLrLcFSoF65yObPV8nBhw8qtvTBjiBuEip9Dw4Nzkqvno+T5yEiPibuQQb8y5RbPtV/Rlw7WWhxN73vJb6krv5UqolcHNhDSCBaAF5wc5lEj1T6z7DWeiRoCqcmqaSvdvJAOuzfzDAiakuOjW3Y+s73oSunfO9MuqI6molpt4GuJjGXsBIL1K28iyz9HcwFi7/BThH2SrHyXnRyHNQUpDm1+rEOcm72VrUnQWGtPMtZw6rlJjTYqvlKVZxV/yfRhfer/PhUILcrpx1PDDjMh3SdBJaiWVIbqpnuVBxZT43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfTEI0zkZVPC6cvwS2WiUeA5LcgScnzfZS3pkrw4Ihw=;
 b=GUePmJ76f9jvvxyN/St/Veb8YDbCQwvanHF/1LoYI6zN8cjLGSjO8ujFX/HegTAbrT+/mpJTlhclP32NEOXn5OCQvy7tTvW4Y1dSCIz1Zq0zHwlanAuSxAB6pz3yQYgmpcX8uCkuFY/AixIMKSFfIW8OJRO2HSqC6+lCEUi7T8ZyxfAHDa/EZHrhPCZ33GmXidLqht8lPNVJwEgt1rwqQmOToNSEqsEFs/YsgfAa8czXnFVS3IoUelPoB7kGW1i6lYm10GJec02bjga8FeGRpsdqimfV9wQxyceTp2CncIgbsBbiqwl05vW5WYYx/KF5BVVxkqPwld8zOwUwclzO6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 04:42:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:17 +0000
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
	Heiko Stuebner <heiko@sntech.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 02/17] iommu: Add for_each_group_device()
Date: Thu, 11 May 2023 01:42:00 -0300
Message-Id: <2-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: cd03c7f9-e35b-49e1-562c-08db51da1986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sZ2CQru6blCvM6JLeuwkWWinCpdBBCH6qeTbHE4X0Pf94xfVUMCcx/um18Zo3qzqXPZFWDg66qII1+sR/g24dhjxQVJPC2pJZ/YAPTMkSg0i1ljc931RCfBje5eje7UP+6Mz4iarpL4k3wEK7Amsa2F8K5dTx1E7U5foW3lMKYDHrlrjpOg6rsa+s9FjJt5AJK5EcfcFxZSesgZe74gu+Et96f8pG7/FuruJx0pR9Q3yHQfv0DFjPkBSpo2OuB+uUsFRL6hnVvK+21o3I1y0eZ//1nwWjUD/s53hYFPpDgmYIOfzhZkcIDCpnzb/RWrn8q42sV/0b4XKS1FA3clOu0dA8+9lucaWSItOO6a6xqLbO7Cdm/4k62hTf11VhpqgAuq71g0Mo+xFcRB4VtobTFTgEEVIxVghbfefuvbr2rW/GNP/aAoBoy41/yaMYkAB8uc7O3Gp78aKn9kHscR+ap0lNBRbnbx/cWMCJhVXfYl0wL3OAsPDl1R2iqtZg6Yz4EzlElQ9zCt+W24tUO4XKLYXEr5s6bUz2rDWxO7EA+u7X5jbVFYOkfEIC7SnM2Nxqki4SenIJ/HrvhvVrp/Z3bgvdZ+RsihVMcq4kvKwUIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(7416002)(38100700002)(8936002)(66556008)(66476007)(66946007)(83380400001)(2906002)(478600001)(110136005)(54906003)(316002)(6666004)(8676002)(6486002)(5660300002)(41300700001)(4326008)(86362001)(6512007)(186003)(6506007)(26005)(2616005)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+sYSlsJGTCNYLX07TieHv0kvyKwK8jMSSJwYB3umyGbQQ77RIzMWZ7N5mx7X?=
 =?us-ascii?Q?dx37Ebn+aK3H0LVeZY3tyKjxTJRbeaSUusc4esEUQhg5KLvRTQoE5WvKK4ZQ?=
 =?us-ascii?Q?ec+xzSKSXLwV/+LyE3fr2ze60oi2fN+LB1d4FIci06QnlHfSJel8c496r7t8?=
 =?us-ascii?Q?7khR2f2bXwq6thJMLFli4iQDQ6LFbOCcThRKu/YhEcQ7PEcJgYw6oNEmBues?=
 =?us-ascii?Q?dr8wTi5UM/Qg7Upo00Y0L50sTzNRXPG0HncY8AFMFTvBIsCyHSimbxIYMJAq?=
 =?us-ascii?Q?H3O4mZC1O2Z97S0tWUf6pMcdfv+1Dlaqc/vVgWp1+fz5CrV+8wBBMfvhNygj?=
 =?us-ascii?Q?0PPwYtks68MizDH6pSrL3r0D8ZtjM0eMoD8V1CNe32kYHiEOX36GnjOHWrxA?=
 =?us-ascii?Q?FkPw7VtEpsChtbMyiQ7sZNaQuEXI4+LgX9APe/JDuhrxXA1ai92x91uNInmu?=
 =?us-ascii?Q?l6iymgN+B/ofijQlcQYRL+GjGMp4XJ9Jc5oqYbAjHwWP0jhHKc40oaUxiI64?=
 =?us-ascii?Q?qp7RbMIqMMLSoltQ2/0xA8VHutSqz+Lg23xcv8dBo+7BAD9PpqRZ4dqudV/m?=
 =?us-ascii?Q?6NLvTdf14fgSukdYXxTnKacUuv1e/7CSRlH0Z1153tlaP232zhV2mVTLNYR/?=
 =?us-ascii?Q?XTABY1G14DZNksxpu3djUWWq8SYe4LecNGopjBPGHidJehS29uURP23GwLeF?=
 =?us-ascii?Q?d/o3r9Z9E8Fw78dmQbLpJnno/Gu4E/GFwp5afcurPb8TKKXN0D5bN0278Uh3?=
 =?us-ascii?Q?MP3PB4orcKrXXoEbfUQI5foUDagUItPcDFs4iIMH4v5TF91+5fhRdyQ3xUIn?=
 =?us-ascii?Q?Caf8sxPgta6ZZaszq/v5HjnrWjIwjWviwaYuAaL5aTClrMBb1kW/7fnmWuSw?=
 =?us-ascii?Q?CHuTk1T9kQVtD5V8wARO9Gj9YRL7WCEqg2CEAj/c/MzEpl8MKHyb1qrdEaGW?=
 =?us-ascii?Q?yLZwq5TkkuBTmLvZi/2KgDuJLKIym/spLPoEZ8MYw4YVaMfM0hCuT05aPu6l?=
 =?us-ascii?Q?SvCQVd6DH88mkUZ1fucXvLdi8dkOIo/0pXmHhooRvlnNQAxY+5uceP6sEZEG?=
 =?us-ascii?Q?Wf3qeUpYI0p2RozIHh6f5cradyVg1rgXVLE+fFkJhFuUA2vi4Zt7QZdkNZEi?=
 =?us-ascii?Q?mtRChBq/uSSO3dx8NTK3MeFHN3/aYooKdqAQHD6mK6+cWL9ruoVoV2p5T/rD?=
 =?us-ascii?Q?FcD5ENBPKON6QMNH5Cd/0/OCi8ledC/Zmp1XGZDCPwVFfk+4KCfxvVgYsMdO?=
 =?us-ascii?Q?gN+SIrAsWxJUVfBa2SH8zWtv2ItcQZYWoExAB4joTjAU6zWAO71zWTdcQVSQ?=
 =?us-ascii?Q?9PdnU9HnZuNrBS28yT9fqioIFXiwbNh97CiEXKtUFvD2olrvz4ioUBExaZ4V?=
 =?us-ascii?Q?R6GgntWfaEuulS/qt4wuSapboTZnRIyYy/Y+f14/0RuVapaYYzL6hN2hGryy?=
 =?us-ascii?Q?gqbqowCzZ675m3LQAFlgTqskcCybfQm+WGTduccDuiFUr621Ffr4QTBvThMx?=
 =?us-ascii?Q?xcKqKi7aKUuu5q6lhCFUd0Es/tll0q+7dq/snd/ZVpqjNT2uDNLdLSsQwMMp?=
 =?us-ascii?Q?8S0hx1kxILZkRUxDn7BlM11s5VSnYPOCgAvcYX1E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd03c7f9-e35b-49e1-562c-08db51da1986
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:17.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTLNkR+1Xqwf6Vd5TGBRf/xwnzHjTqjiR1kuO0mQsbTcwn2nbfxrAfmxTy7TCL41
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

Convenience macro to iterate over every struct group_device in the group.

Replace all open coded list_for_each_entry's with this macro.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .clang-format         |  1 +
 drivers/iommu/iommu.c | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/.clang-format b/.clang-format
index 0d1ed87767337e..0bbb1991defead 100644
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
index f2c0c10af32c4c..b315cba0d4ed0f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -68,6 +68,10 @@ struct group_device {
 	char *name;
 };
 
+/* Iterate over each struct group_device in a struct iommu_group */
+#define for_each_group_device(group, pos) \
+	list_for_each_entry(pos, &(group)->devices, list)
+
 struct iommu_group_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct iommu_group *group, char *buf);
@@ -468,7 +472,7 @@ __iommu_group_remove_device(struct iommu_group *group, struct device *dev)
 	struct group_device *device;
 
 	lockdep_assert_held(&group->mutex);
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		if (device->dev == dev) {
 			list_del(&device->list);
 			return device;
@@ -707,7 +711,7 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 	int ret = 0;
 
 	mutex_lock(&group->mutex);
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		struct list_head dev_resv_regions;
 
 		/*
@@ -1131,7 +1135,7 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 	struct group_device *device;
 	int ret = 0;
 
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		ret = fn(device->dev, data);
 		if (ret)
 			break;
@@ -1935,7 +1939,7 @@ bool iommu_group_has_isolated_msi(struct iommu_group *group)
 	bool ret = true;
 
 	mutex_lock(&group->mutex);
-	list_for_each_entry(group_dev, &group->devices, list)
+	for_each_group_device(group, group_dev)
 		ret &= msi_device_has_isolated_msi(group_dev->dev);
 	mutex_unlock(&group->mutex);
 	return ret;
@@ -3242,7 +3246,7 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	struct group_device *device;
 	int ret = 0;
 
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
 		if (ret)
 			break;
@@ -3257,7 +3261,7 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 	struct group_device *device;
 	const struct iommu_ops *ops;
 
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		ops = dev_iommu_ops(device->dev);
 		ops->remove_dev_pasid(device->dev, pasid);
 	}
-- 
2.40.1

