Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB641E51F;
	Thu, 11 May 2023 04:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1hOdgU77i7s6rBvUJ3w0KZj2lV/LqPYKyZmhy/izmdEudQyD0DHYSkwvppnRxDa8ZenlLgpkfAI6+N7lQvq1aD2BaDHSo+ZDbuVtNRMl4lqPb7NMWpvQOgUE58HsF6PPdYGiisc8M2MqBYywYRjzAXsKJif8t6b50qgRNvakb4LYcaozqTCOUsKUg3gQ+6FhRAIjZp0Bwz+7fJ055MFaTiupx4RnEMMk7G9euvZJ+kydmESvH92PJPPf7cKJxlIIE33qOpBzY7Eaq321EqH2dEMGn0sJWjg70/M+/oT+ll24vKS6QZ6GxKhYanh7nU3wUtmgtKBL8FWQetrV6DN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vLdYJ610mvGBirSLUlTnLJJfeMCsgN09nbHRSyj5R0=;
 b=jSA0rJCndu7HkCrVgaKsWqoT3OG1Psfr8KAKejHnRFERqkUdl3ogcR3LVHzi1fK8Nvfv/IsPiz23tPhAKfZQ42twWwA476FSWCm9ziZxiyDe2rgmdO5idfiAW7U9pQlEHcoL0ZSgGufsi/6k/0Z6LrjE6puX4+oOPBVfBrm7oMz1D8KprcwRpbSVxaQTfzK/10zTnN2QqMu88qiWEXKP0+s8lign+QJYC7xQt72rxc/lx1JEXpcOXezKi6C1nKfK9riUjcN1FKghwSTK/vHduM92hl56Nt29tCpuykHymOtZ0m3VyyGk4rbDIc9pEBVmZm2iHOWY5sgQeQMGQsL3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vLdYJ610mvGBirSLUlTnLJJfeMCsgN09nbHRSyj5R0=;
 b=EswSPs99Ni2khdre5sIe+5b3X3HSmIWXQxWaZm6FacEPzlHNbdiK/EbxjsRDP+hvX9t5qKBfpfGpXc7IJ6zae0viGAdO0ugVv6X6EKwE3j90z7AVDX5+7xuFMcX0bHmoWibsfqEGX/HfiLgg4eg4e8rN2pKPCBs0porT2p+wzxfhhtQ+u+rDtku2WACqqxWUIqroqUQiRY7JnsyLwHhVNXYn4YsCAag9HwBDor9Jx4tOGnMjqRMHGglpspit/fyTWcUieBNXiN8zNgLAk1ODSqYNz+bIWzuJo3vj/61Tv6+bQQmXf/+jvDpFAHuHVvkXWzyv3CWwPOXqg4yPwiDNtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:18 +0000
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
Subject: [PATCH v5 06/17] iommu: Replace __iommu_group_dma_first_attach() with set_domain
Date: Thu, 11 May 2023 01:42:04 -0300
Message-Id: <6-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: c31b83f7-0060-4d17-dc34-08db51da19ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TCJFM6hWizuET4IW+aYk/sR0vi0j3ggIGHuw8CGui2Dv0Q+3QfpGKkHoee9lkIIs5XsWURMIe04dskNAD99MC5H5snXzjzD85D6RrehEGsQR3D2H6rs4YssvS83A/RzOeqi+LIpkROjajiKwpxI8yBknVSUxXqulrYS0ZGtbQcBP7Lf2dCwrrZYe4Se3qZ13rjMVkARvW8OKmhpTlJrW53b3jU9m6JaaJiYEmgh0a0Vp5cKEDHUgiSWm07I8WveM7aikr8OIvGtctQ1Z76MEjKJQvDlR4UoUu/xWY2rcczICWog3scIR/7LG3lY4GK01jI2KFvpbBKWb4U/jxhXsHVElz0+QLq77XUTLeWZqNjBl4X0JYUqP5GgQby8FMxjjvXdoRfVCnsalmZpv8IBaVX2Wm20ngOwbvtl9JEfck2Zn49xoaC1+CSiA63HAJLntM7TEGY/CQPq+0ikok5+ksnZ6lTzAEcvtkqDqS9kYwdfDFbmvUBvzu27cIRWQZezbCxVwhCfzcUW6smIpCqC4/6GtZrPJyXD207RkG3L0DQ+Y0rZnZVglK+3krN+DslRlzl5jL+ybOp88mq0Mk69pldpOefvYXpYoIiQFrTPlyQQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8oT5fu9uHsHNaq4zd/LzHGYSXWTAWmJocLPhlo8Fyrl4YAqeQNfY9/ECmy0?=
 =?us-ascii?Q?0iKzE7P/el4aTQ1zCkt0lpDzLRgTXLXW0aY7py78dzi9akFyyxsC85SYrZpw?=
 =?us-ascii?Q?aR0leiZkHvHjhXM9CyjvH2MDM1OfZ+eXjF22D8byA46flLuIc9dzuQlwZtvk?=
 =?us-ascii?Q?t3XQiJQ+OGy9u+5vWO1RvY36WvqwKLvr3ZlU0oAimPnGFiDIsUlnFv0WUNTc?=
 =?us-ascii?Q?ZjmYt2mMI2BZqsbIbXtnw6vOpVrAPQ5gc10iGWygPnkibc3j2OAevYmPwvtV?=
 =?us-ascii?Q?4/sq8dJB2Cs3dECr4MizJYoLl/6vKJaKW2Tw66+D6c+gk5Hffi9GZab6dsPN?=
 =?us-ascii?Q?/IIiriZk561TpbKgTLF56zQOiPJL4qjt/gKUoyjRYi5LDLiMkXAKoNzIcw9q?=
 =?us-ascii?Q?ucKwiAWFbUYq4YwdD1dUVevmzzoRMTDUH3S8YORPNe+bmV1cdokvaVfK94vS?=
 =?us-ascii?Q?j3hzYd46+KBEeuPc5tl7OtJ2VqumrgERaz2AiSI2lS1YmtkFM0rGsUn+7Uzx?=
 =?us-ascii?Q?lMZQbhIRT3hAdfSe3JHIMDY/GblZzJcbwpKIXg3FvNRuq3J9jMh9+y4LvAN+?=
 =?us-ascii?Q?mJ1LWloFWHoL50z0KUzfJNNX9NgGn15rlfv/MJYH2/HOdzh8labGs+06eaSz?=
 =?us-ascii?Q?1IXqaqaEUX8iWNKBeHuyL8yyopLyN21OhU0fteWXjrrz0pox1zl6+CWv1tjF?=
 =?us-ascii?Q?w/1apPvKQFo0aTt+Rdb6apHsS5+M47GnL9Q9smlpmUxf5rZ0LptdhWewmUvL?=
 =?us-ascii?Q?SZwxZ6KkfW4wzcblLB55SEsaOAJmgzu4q8UlK+jge42zU+DUnKiSyc0/hzy7?=
 =?us-ascii?Q?CbUcNz8ep2LVU73Wmbo7g9c/Z+1pMq5jvfmdxstzakwAR+apmBOeE9IT66gj?=
 =?us-ascii?Q?Zrd1XxHINR8VArbHdcZOth74/AQ+fJXZchB2P9nyB19ySuQpOwJHAnkpR5K5?=
 =?us-ascii?Q?CuoqyVWnaxRsXqRwQjXEoQc6x9W3RqR+rJSDkeiFvVfETTTzu6O/eLfn8e9W?=
 =?us-ascii?Q?fb1NHlqIDJzr2DkMYHHqrvfB79MtmB/jKMHh86VU/LdPcjtxZeSriywnbtQn?=
 =?us-ascii?Q?RJPaWrwP8snd4gOBWTISJXeV+1N4O1hRRmav0T7OknrywPi1X5aaLl7VRIGz?=
 =?us-ascii?Q?rweEeGXrPfmq80DD2D6nbc44ge0vOWl9FIZemCfecG5OGjwjuvhipLn88Nlp?=
 =?us-ascii?Q?N4rbdvSw091jmx9QNm7/IvPMyc1Kvwubkck7VB9oOGajMIzl33SkeNjGUKoo?=
 =?us-ascii?Q?EaFR1TiFLlWPd4FXMPeIMHmdszBBe/eNH+W0WS4SVM3gdzKljzZ6UqGEp0F9?=
 =?us-ascii?Q?pXDZH0V0DUz8or5ud+rCdtwsMsYzeGrh15/yQ/IZ3PdKlxRoUi98TjV2MZyq?=
 =?us-ascii?Q?SsF0HJFo2XPKMH3V7DgsUSFGURr4vZnZT4+IEf3kjgfRg1yC7CLrkfNx8c68?=
 =?us-ascii?Q?bcEfY4K8bMWk/7VsaNd954d/ODSQ/fvSz8e4ZgHHOkUvB9z9jKMgc2iB3dm8?=
 =?us-ascii?Q?dWjYrnErZChYPGtxIvl6LwKSroz3Cq43k6naiI0DBbtopZnf8M5D4Jrq7MPb?=
 =?us-ascii?Q?y+MyQc898LiLP+SO1M0KJwkH7pdBbV687DPMOMq2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31b83f7-0060-4d17-dc34-08db51da19ae
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:17.9639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuRul1Ebf/Atw4872UEl5P7g3mpPfiY0dJUWE6zL6hoQktdAAWOJU/msLC32IVnW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

Reorganize the attach_deferred logic to set dev->iommu->attach_deferred
immediately during probe and then have __iommu_device_set_domain() check
it and not attach the default_domain.

This is to prepare for removing the group->domain set from
iommu_group_alloc_default_domain() by calling __iommu_group_set_domain()
to set the group->domain.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 46000ed5d19317..44b74850f7f442 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -365,6 +365,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 	dev->iommu->iommu_dev = iommu_dev;
 	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
+	if (ops->is_attach_deferred)
+		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
@@ -399,27 +401,14 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	return ret;
 }
 
-static bool iommu_is_attach_deferred(struct device *dev)
-{
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (ops->is_attach_deferred)
-		return ops->is_attach_deferred(dev);
-
-	return false;
-}
-
 static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
 
 	lockdep_assert_held(&dev->iommu_group->mutex);
 
-	if (iommu_is_attach_deferred(dev)) {
-		dev->iommu->attach_deferred = 1;
+	if (dev->iommu->attach_deferred)
 		return 0;
-	}
-
 	return __iommu_attach_device(domain, dev);
 }
 
@@ -1831,12 +1820,6 @@ static void probe_alloc_default_domain(const struct bus_type *bus,
 
 }
 
-static int __iommu_group_dma_first_attach(struct iommu_group *group)
-{
-	return __iommu_group_for_each_dev(group, group->default_domain,
-					  iommu_group_do_dma_first_attach);
-}
-
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -1899,7 +1882,8 @@ int bus_iommu_probe(const struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		ret = __iommu_group_dma_first_attach(group);
+		group->domain = NULL;
+		ret = __iommu_group_set_domain(group, group->default_domain);
 
 		mutex_unlock(&group->mutex);
 
@@ -2199,6 +2183,12 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 {
 	int ret;
 
+	if (dev->iommu->attach_deferred) {
+		if (new_domain == group->default_domain)
+			return 0;
+		dev->iommu->attach_deferred = 0;
+	}
+
 	ret = __iommu_attach_device(new_domain, dev);
 	if (ret) {
 		/*
-- 
2.40.1

