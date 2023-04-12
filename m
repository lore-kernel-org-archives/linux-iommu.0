Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0C05698
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 14:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu4MYSxZqLQqL0RnKSEliZPlk657J1G4v2H6HaPx3DRADI9kKy9sdeicL24rQ1VfUlVzYfDJds3LO58z/FA34kC7WupHWxNNohWMQW0FUIrrAL+LDZ/q+mcAamuhfZzUTUJBPCBEydJzVEb3MDzEJUqSeWkPtLw7UvxcP9hiGZ8dueBznlnoDbGpZSLRB5luDTQzuI3fjfUu74SQw1XqGmMbOexNOZ8NTbGK6sdAYpz1ax78KS3nFpactuo9Zp4WWY3Q4toyBORz0D3WI+g/FzKJ35Xd+As86Zu6q5j6Qzh/Y2AwIo2A+/BBrJJuOO+UxQyU87oxSSqAyhGgw0FUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iIBfu283P4S5dt6DzLzPRFFOkEUV7M29h0h3OKFvMY=;
 b=fhUE1i33SyszgLIga8KPTC1BPgJ9huQipae3dOgJBMXi2CzXiSeWGlClJtwb0Gnvbh1l0vxQe/ulZgxtambIx3HIxIXH8hodt+KzuxsrwVeL51vFpJymKH/b2OvjheCI1NFzkqGhftQTO01mPPgr2oWlqoohUoYVp/hmXikonoiKU4Z7CgnBcsRbDDuv61U7bmzcpcdobeNrl8+xIPO2IdZ4torewAZ84y/IQYdptkfaVA4J7js/dQzCS4tpI4R9hsVNtZr0UfE//C6Ayf9R9vtC9U4JqTBy5VqBB2xQUlDtGgtIudBGY7ITklwJ3+qdXJ+wdk03V8uONUe1vNcCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iIBfu283P4S5dt6DzLzPRFFOkEUV7M29h0h3OKFvMY=;
 b=fNrW2a3aFgQqqgz/NEhrsE+ESW6Q8XJ3jKeNmgvYPNPEZ3WKVPHh23qIBg6uRSj+bC6Tdx9Y9W6gau3SYpSw7oc6f+KBDbSXUilEYOXS6SsmFPGWpzuqnDX+tVNghZRMO/HpxF54SOun5gIhhqPf0NEbcLpid5CGDf3wK2h/A3DWfKAWMocZmJpFDIphsXR79rTHM9B6PYD2qsvb+Cf5sS+Y4MIOZ+e6552wvDpVSVvrlIUGfpP63vTZmIGELeJH/DXVTocWAiSV1CjAswWYgXNTVTR9D2RPjbQMTOdgBSi0kToKya3Mn+4hIn9xS4CGTbuVBOGVkDHlt3V18cqzRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 14:12:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 14:12:05 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] iommu: Remove iommu_group_get_by_id()
Date: Wed, 12 Apr 2023 11:11:58 -0300
Message-Id: <0-v1-60bbc66d7e92+24-rm_iommu_get_by_id_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: cac810be-ac20-439b-19fa-08db3b5fe4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JSNg8WRtTBD8dENbEfIxmJpk05V90kUx19gnkuRzpQ/cYo6o1dKC7eRLBr7Ol2OtHVgGRtCW48ZijYLGF1XTXwHm1GN1JAC4ZF8kmeJgCcUeakBgNRtY5GD7EXrZHngO6TiPK839OM/yBqMg7zB4oUJ5dIPahJhYP8wkc1EkchAoMzCClyMpu1rsdyP8c2EBSo7qCJKUAEHspslqMnYziim61bWKxoAYJKxlAtdddPo9QgzhJvEPgPaT6wNAkRD8BLSwnbWw244xYrw76Waik52pC+GNJOuKeaId3LKujdI5HOLIKJWyAeLF97gsDvTr7eBoEZRJlNT73bzflbM0snafLxEW1rogM7GSlIx51cC5mDT1qBWPbfBp9X9SphgdvXHGixwu4ZytDx+YU51RtZ8sj0Lc5XPo2LP+j0izcZ70s7JPI+/pWTKiRvb663p05SYKQPIhHLc8x/J6khSufYYw6ZL/Lv97uwpgpwSQLYlMZIwKfQ4BXgX+K9NcWF9IkImUgA9WIOQp5vzUFHfin20HBKUoR7h5QdC+RQfFpSRhRaLRaKRDpbLWQuDjrXmL8+PULBRX7FHz0y1hSEEdlxYFHoXtv3xTu9Gtkua2Tzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(83380400001)(2616005)(186003)(478600001)(6486002)(26005)(6666004)(6506007)(6512007)(110136005)(2906002)(5660300002)(38100700002)(8936002)(66556008)(41300700001)(8676002)(66476007)(66946007)(316002)(36756003)(86362001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4odmqfIWfO9JQhVjpPwKkzMYRi9alIjTnDaz0Fr3fjDxNPiOI2VlRIdlN7QN?=
 =?us-ascii?Q?rvWsVkY7+4U7gY1hueabTverOXE6+R9WB+dw4SUtvk51Xg8Ls22S3SDaZLv3?=
 =?us-ascii?Q?qeid1/vZNHZ9+cbdB9HeAb7/wGvUJTfp2JtvWlkMuL8YaNVsbOssVGCGTtaD?=
 =?us-ascii?Q?T5kEyGcSuNh6ycpw6iDCfRVO8/Wm6X//2mw2ln1/0AGyyqA+WjkMF8L6u8x3?=
 =?us-ascii?Q?cK9DPpCtNjefxeNp5XOMv0fPn4DKAG0Ex39KhdW10h8cWo7RvYZ59eyfoXor?=
 =?us-ascii?Q?RzBI7edqy2li6ZWfF1Hjxed37HFJeMOrWXSk4dUAJQT87N8IP565C2Mhcie7?=
 =?us-ascii?Q?y/N5TsVTAg8VN7lt8DZQdYUBPD00W3Ep0DqJXvmEq2NjU5Cf0FmUEP4A4U2T?=
 =?us-ascii?Q?PD+wJNciIbXRcpCWNYdXrfhMmfbiSEJV2Vi31kcqr6s79timuY+HAgM2Z1Y9?=
 =?us-ascii?Q?8SRqNSAw1U1byCcgJJO15dcR2jw0AyDszeKuCWQsJiwmggOoUx+uLQZ/sg+6?=
 =?us-ascii?Q?TqTAsLjq68t9oN+KnL787v+zFpc+uSVSxyJe+2NdbOuJy6dy1bntSNRQxLwI?=
 =?us-ascii?Q?9r0LyL82uKrX2pmgeZtiwNlc6SaQKWkc8fdo1BoLLZw5UEynYdjyH6+KYRiS?=
 =?us-ascii?Q?CTQVXEQJa5mzcdgY792vlkz72vpDamQ2+gXmAM4bvxseryACvpdRH+HQtemv?=
 =?us-ascii?Q?d1V8vlBePjaGv3Uu2Fpft5+gH91YyeFwqH7AtNvNu1X7s6HFyGDPw8zwAJCe?=
 =?us-ascii?Q?GXekuG63Jf01Tf9VElEa3qAzVIMWn/hXYbf9+JGpOIptqjGlmJy+2tNQdVA0?=
 =?us-ascii?Q?ycttDR+PjHG+cGYG3Gr1dqf3cBEvKr6aHUhh2cYrKvyP3yuuiihEt/JVM/TY?=
 =?us-ascii?Q?kdNQ10+0IPpnx1R2wezICME9iSjg9/pyFVtv2RxEgepUt9nDfA8xwhpiDtp0?=
 =?us-ascii?Q?E8r/JLOZM4nrh9fOO231/Zr+JgbRojVEbAUDaggGyRIR6xOpOd6p6vG3y90l?=
 =?us-ascii?Q?NjN4nwovuyDDyL+6lUW5xO48hpFhxvf8+ha0RlcZfg7RE6kHsmJt2v5giWDA?=
 =?us-ascii?Q?dhPposXPL06Loe00AlVWEeckhFBkTpyqIzJMUhJSZPKtUiA0ynSu4B2Un0ZB?=
 =?us-ascii?Q?rSkHEfcSSTeRvgW2b0NhUAqqeq3newGhZGvL8sbRY4B90QEjd495UlKjBaNM?=
 =?us-ascii?Q?F1fkcOSgI71Rux+VhVQMy6+m1Pqs/qMbVyC0TIA93OPxAO6aPi99HSwQ6ojw?=
 =?us-ascii?Q?nsxfX8Xuy/f8yo6oqmG6mA4xRt/TBc/yqknQKqiqIaBA4op65gyLMWLXDTmn?=
 =?us-ascii?Q?AgQ/E6HWfTPuOy/IJx+yz7w2aNV8XJOFnnUlcZknnCpnkK0DCOf075EYOTFC?=
 =?us-ascii?Q?5YEpdgMcOwHJc7WXcS+m+Y6dyP5Wi1UoEsfnmYp2ba9SSuN0zYXlFmK1gbPk?=
 =?us-ascii?Q?5BNAH0cCfNNxFna9eYlTarhX+WTkENTDRDGVb/iZFhd/uffQxZVTa1+TJpfq?=
 =?us-ascii?Q?gvIBQcWlrIBm9NPBULZGDPeYrXLUTZYCawlfbqYPN2GAlGf7j7Fww3ev6lj5?=
 =?us-ascii?Q?FSNb/k9Wf2Kp9b/AW2LkPQ2xqesMEv8MyzWUEXQ3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac810be-ac20-439b-19fa-08db3b5fe4d0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 14:12:05.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAh2QqvbpqJ7i0RjjVXavADDs7TDs5cverw/wi9FO/3Pf39aKqrtRgEyyJ/F18+w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646

This is never called.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 29 -----------------------------
 include/linux/iommu.h |  6 ------
 2 files changed, 35 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7abee83610b6c9..e0e7c90b490686 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -881,35 +881,6 @@ struct iommu_group *iommu_group_alloc(void)
 }
 EXPORT_SYMBOL_GPL(iommu_group_alloc);
 
-struct iommu_group *iommu_group_get_by_id(int id)
-{
-	struct kobject *group_kobj;
-	struct iommu_group *group;
-	const char *name;
-
-	if (!iommu_group_kset)
-		return NULL;
-
-	name = kasprintf(GFP_KERNEL, "%d", id);
-	if (!name)
-		return NULL;
-
-	group_kobj = kset_find_obj(iommu_group_kset, name);
-	kfree(name);
-
-	if (!group_kobj)
-		return NULL;
-
-	group = container_of(group_kobj, struct iommu_group, kobj);
-	BUG_ON(group->id != id);
-
-	kobject_get(group->devices_kobj);
-	kobject_put(&group->kobj);
-
-	return group;
-}
-EXPORT_SYMBOL_GPL(iommu_group_get_by_id);
-
 /**
  * iommu_group_get_iommudata - retrieve iommu_data registered for a group
  * @group: the group
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54f535ff9868af..d9e8fc4512d6c5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -460,7 +460,6 @@ extern bool iommu_present(struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
-extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
@@ -747,11 +746,6 @@ static inline struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 	return NULL;
 }
 
-static inline struct iommu_group *iommu_group_get_by_id(int id)
-{
-	return NULL;
-}
-
 static inline void iommu_domain_free(struct iommu_domain *domain)
 {
 }

base-commit: 43a31380ed6e16ad08675de5e68b5e4d05cf8716
-- 
2.40.0

