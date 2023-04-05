Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3412C322A;
	Wed,  5 Apr 2023 23:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My3ePKvEJ1u0oGWHiol2bZ0IfOFdGPab/dhRJFCshHM+iGcRBc+3wTJ2DVIFs/lKweaVIZJRodehAgYUDqwGdbsEw2e035yBFovK3wYRH/Q1QpvbFiLQoi23X723CYqiJeYLURiaa+qP1glyLws4Hi2yBFbh+xEk9lmDr3gYvB95X4aUpNvryABj+Ur5dKPTzhmzOejavHfQezzOZLlkkgjiS0r3dQAeE7q2PQPS42I8XFWgWL3TYXoiYnhVQe/WNWG6LLGfcxsMzcBWgifLRK4jXeVoKcDcd59WlVEma0XbOmG0eIB0SPvG++8PPHv6c9OAvaJMBxLACpHY6P33LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAmZAD5A1f8jzI4hOKERQMmtlDvia3YVe3SkF7IU4AA=;
 b=bBpwqUQfRosKbD1KXV3a4Yctyhst+KwfPaK6DqINggeZQNwvCeSTkn6JK2fAwmt/hIVR2TEpfLAqy/FuGuVEUuznwgPqfl7iW+BFR4hd6qs51A7HuLZGTXKJgYTknDwBDrhwOtqkUZoJJ4UGsQ72AF4yZbOILTqyOnbLJplLbh1Oftnr/jB8pdF3YcbGacJ1zYs2Dlj7z+A8OCHDO8mQYtFKsLXGMKbcdS1hZ7hNOEuGGtL4zxYsHQhSuyPqFsqU/t2gLEHExyoFfJQyLcHzRWvEFgJSd6F+V1hJRbSSaG4QecArHgCyaCTHT9ccHQZ0txVaXUAFyoVoOKQ8XfkKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAmZAD5A1f8jzI4hOKERQMmtlDvia3YVe3SkF7IU4AA=;
 b=ehXm7xMQWhmJJ6T8nM2QHL5xMVNR8CfaXL1ZWX+wY/CsrI3KKnpKJhiuVU5UTuPKUmsD0wjtDA4bFumMs+bPa8t34N8nFitX2rS1XcfACV8jmBa0zppkW87LrwVV/69BNEL0+UcF7YPPgLUz5OWJAbpmUlOAGB95iUyVj6f/reqtQBuOxwWnawIvrxa9OzaIfU4cWkFFkI1GLudTQ/6siceAiFJ5AzEszNQbUnW91MFotS6il9EygxnDSPO0Odd1Cq3GT7BWZK0VfMrN+BTQamzwrnOUuOijwwCib5gQHlptvJ5PY72gC69Ss1peLsbeurlli1pQTzF8BgFybt2lYg==
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
 23:38:42 +0000
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
Subject: [PATCH v3 07/17] iommu: Make iommu_group_do_dma_first_attach() simpler
Date: Wed,  5 Apr 2023 20:38:28 -0300
Message-Id: <7-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:208:23c::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f2a92b-0d6e-4b5b-5c28-08db362ee258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lJS7mNUQxBljccCg+X0tYPYTh/e1Tp/BxqSlmahy2GGZWCZOmbS4VFzUv7AUwVPEM0yQZrORY8fLfAwPwODCFvfuI9W10d40DvyZyy1Yf1SPBbFA2fqQobcpb5VzPD/g9VBiFfDtVYDYgDenRUjydFqfwjM5Uh5H/0sdPEunHK5D656uvpZGVvFL9llNzP8+WtiSYUYSX5bgjGKUEe5iJ1vXxX1/id/uXLV2wHbwW+pkr8PLb782cpPBurakSOEek1SU3IwnVi6xLkmNsoOWmi4SOp6/jJg2D/JqyFYh5myHAbQY/P3kiq98VolyCMLm/Fr+0JaMsS4adi0R41viUg9opqH3uSkbvVJuPX56AbE+JKW2zu9d+G1iaF1d5Vn602z9I/uR6ZqdZi94rCWkPCn8WvCHdBML/zOPFMShZoOSoB9h8n7DABbKEY678O+sc2TfUPRQHkh2v74Yh/CqTD1ZymTJmW+xFKFBmIBKbT/qNkYNoZ7WLwANmGd4NKQ59Np7V3NdoYqNo8UBh6PHBfkBwmGIHfnMfrEpMBaepfCOGyzP4bIkZUDygIBh2hZS+Qo9mESWEOg8VMP8bike/Q2t4STNz9Ehfu6cfQkU7zI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8qEYCQMwWcy/A4qm6KH9rEr7Zf3QR7zTcHUdnN8uT38W6huvOJfWLpKLcwkt?=
 =?us-ascii?Q?KeiNRZYi7hdmWM+SEQwFI5liSQBEEbTW9AK3dYsEfEJGOv2WZMzq39MItBRZ?=
 =?us-ascii?Q?ljrdkwNGnFxYgeBYwCikWE1sropIwgaWeuCoHzJn0uUOEQ3ZmczgBkY+nh+Q?=
 =?us-ascii?Q?saCWigD+zrEfEbbHgAWhrwYx60fiQaPz3NkvZe+wTDz4KLycJDjXktwXLWSp?=
 =?us-ascii?Q?bhSl7sDqgq7ygwvFdOPGk55kBlUOI8c8AZYctP6D6spL8jgyuYaKyuG9Vsfu?=
 =?us-ascii?Q?ae31ddvY7UctFPM9zqBcn+3onU5pbiTTfuFSnltmyGfr5mSZo+IKUFOn5fYd?=
 =?us-ascii?Q?agVpFgMhy9Zxqmz9RMgUBzex6BQIUK5muFvT7JfCrWXS5Ebs1+C6NScLqdta?=
 =?us-ascii?Q?KFz2CvcdtGnXpi78iK6QgdvVqw8rmXARu1qDkSSOCxZM42Aui2cqWsggGpE+?=
 =?us-ascii?Q?CxSuzRK6nw3oZKg6opkNgY/LSK63INorZChoWYnaUvN63+pjLYZeb0MH00H9?=
 =?us-ascii?Q?xkMmEs9zzAQyocyjKcE8XOqp3x0dBQIVSnTfH39c0bGyPiSqyNKA4+renw54?=
 =?us-ascii?Q?71NPjDU6hKghLBbE6Y9jHgEaSl2M1Dk13m9+SUYo7t+wDICKSkGxRyJMOMUU?=
 =?us-ascii?Q?CXJfwv8u6+beShT778GngwQYrXvau31C88kzLNdMM51gNO6Y1HZQyzsKjW5v?=
 =?us-ascii?Q?gOCyzl24rQrthJOosQ/UUbqOV5IkOd8dFjIPK4uUJRg9rXG6H4aaL4QCR40m?=
 =?us-ascii?Q?fV26faPJce2NCfSHMg9MoPucDRIXUpqKnLYfIWqkmPnECtKqpljlZy7+9hJj?=
 =?us-ascii?Q?1746OYrk7nDdRqF9cQ87qP4g8RMM4lBXAlRDgVZaIFqK1CCLCAtgsCKOvh25?=
 =?us-ascii?Q?2Z8ZdfcMAv+jRcpbDJ33b3vRloTha+0YmuaLqYZF3H5Aqpda7TJYii8/8GG6?=
 =?us-ascii?Q?cCpsf8uU6DAz82NaYRwgpiKoPUd5xeiavhsyUnh0SeVzXJ09jl37r2FNdOYS?=
 =?us-ascii?Q?X9jiDWw/0ChsAXjFWBet73wVzUaXFyhAVsNAcropaxh6VtUsYzkgom54u6cn?=
 =?us-ascii?Q?2wT7Dsje2ldJrhtXM1+vlq60ynY9hZfaW6TQVtkF77yAOKwk0TOCTs9n8S7W?=
 =?us-ascii?Q?z5e9fLgvopk12GTm0jp4r8vo5o9emVROHtGYV0dRvGYtQy5/c8A1wIbsf4cj?=
 =?us-ascii?Q?9ihF/xURCJkClqco/qBu+HMAny5Lhp7SJfZaxwq4iQ9Tb9CBZVRchyszJqkn?=
 =?us-ascii?Q?EEx/mDT1C9eAdG/aLTqy1RQwufA4beYREGixC3RWkl3OAEuv0xo9O/tF+k9i?=
 =?us-ascii?Q?3JkXoCMyq75vkYJQkz8KXu+hLSc3AQl6BTh9LaR8yr/R1FM1B+Ga2ueWs7Ae?=
 =?us-ascii?Q?D2OL1BJPyFzchvH0GBsDWRJVg9o6ebGf0MmJff0Egw0LcmbJFErXz0OXuaDd?=
 =?us-ascii?Q?mEWn7a+WJkrtWZLFs1Ht5I5IGXJKiXdEuFJnskPPojggg/fvW2pjJXUQtY+V?=
 =?us-ascii?Q?h09XrnpllJXKPlc60bQH7uJ5SV4i3KY1e2x+TN8JaxbQDryeqrH5lh6rpYhx?=
 =?us-ascii?Q?7DVvVbzw8Hb73rgrcDF/zsuu79jtzfKOc8nR++QL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f2a92b-0d6e-4b5b-5c28-08db362ee258
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:39.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V//GMI6cwTjs0bhgP2cDOEwU1dDDSbFEeHg9i29CWaSNLWBzgHKQHvaqfJJQytsE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

It should always attach to the current group->domain, so don't take in a
domain parameter. Use the __iommu_device_set_domain() common code to
handle the attach.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index af3af752c255e4..c68cf551d05dc4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -105,6 +105,10 @@ enum {
 	IOMMU_SET_DOMAIN_WITH_DEFERRED = 1 << 1,
 };
 
+static int __iommu_device_set_domain(struct iommu_group *group,
+				     struct device *dev,
+				     struct iommu_domain *new_domain,
+				     unsigned int flags);
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
 					     struct iommu_domain *new_domain,
 					     unsigned int flags);
@@ -405,18 +409,10 @@ static bool iommu_is_attach_deferred(struct device *dev)
 	return false;
 }
 
-static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
+static int iommu_group_do_dma_first_attach(struct iommu_group *group, struct device *dev)
 {
-	struct iommu_domain *domain = data;
-
-	lockdep_assert_held(&dev->iommu_group->mutex);
-
-	if (iommu_is_attach_deferred(dev)) {
-		dev->iommu->attach_deferred = 1;
-		return 0;
-	}
-
-	return __iommu_attach_device(domain, dev);
+	return __iommu_device_set_domain(group, dev, group->domain,
+					 IOMMU_SET_DOMAIN_WITH_DEFERRED);
 }
 
 int iommu_probe_device(struct device *dev)
@@ -449,7 +445,7 @@ int iommu_probe_device(struct device *dev)
 	 * attach the default domain.
 	 */
 	if (group->default_domain && !group->owner) {
-		ret = iommu_group_do_dma_first_attach(dev, group->default_domain);
+		ret = iommu_group_do_dma_first_attach(group, dev);
 		if (ret) {
 			mutex_unlock(&group->mutex);
 			iommu_group_put(group);
@@ -1117,7 +1113,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
 	if (group->domain)
-		ret = iommu_group_do_dma_first_attach(dev, group->domain);
+		ret = iommu_group_do_dma_first_attach(group, dev);
 	mutex_unlock(&group->mutex);
 	if (ret)
 		goto err_put_group;
-- 
2.40.0

