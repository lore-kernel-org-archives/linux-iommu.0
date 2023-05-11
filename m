Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D61E51F;
	Thu, 11 May 2023 04:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL0ximveC7HgwOhvQVdGRr/Bw9ZS8RyvDNsjTblxZ4EEV0qzYpVnhPtd0XKWsZoHpvYAYIVqRlpvn+Vd0GVW7S6FoKlgbGK6KmSYkrTH6biU94GN0R42vd0/lBOZ+D4F7/qbgIX40GivbAa9x6kk0cYtw31AJuXl7fC0Ve23JQR4oT6iosX7iAU+gzpM6atS2Nm5ZaLqAs7URc/+FbWismPPvHS8NYnOxphungJg657MHrSS8oJDPRBZp8a+BdVP7g+xDYWBoACuAXR5aRj6gLVh4jyfiw8k5zsYJK5e8NwbUEZtBQzJmoWrWEmyQ/RG2cDsMEhy/WPwReU5TuCTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GbOWp+qHhJjokkqGKqqzMqFmVM3MuqUSZqTphMSPOc=;
 b=HmzmDIZDc+8hS9kKpJlIkD0iU5OmWGYl6erLw+AJopgqbiAvBjoRivoT5aYVOwp9sOanRbukJvsVj42hZe+7EuouBP6NbMO8vLJaHPAUVCl7plBLvHXk53QfaBqnuT2TwW49DuUKzy4WJ3wIPfgTMGI2wZPbOlFjPYjYU+kd+BAp1CyzMlYkEBSwrk1jnnszvd6j0nIKLKwiMXU1W8Ja42YTSS1bZSYgW6jG8S64UdJP5OUK/Xj0eKlIwhmtahK/L/SeHvZk1IeypKOVyCbuAIDoAvsMYPRF9IKt9tNrZL6U35QDqTJZH/+dPHtjrk7425L7KotssvcJi9On7YG+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GbOWp+qHhJjokkqGKqqzMqFmVM3MuqUSZqTphMSPOc=;
 b=iNWt204UUmH98eNBRtepcWDHTyoIFJzHzLTMFO3SVBblx4viyYwx48CM6gKWUgzovJeC7CyL6Og31uy7pfN2hGHwdTabXcMJRX5Ix9UGzurpnrYFQLQSyGpwwjInT9k6k9kP1BSujQvlYYj+OyB5hCksqja/rn+KBoLZZRtI6OJ/gqikDFSaNJ3dyE2uTxXbS6GDLuS9jGIhI+bUVO+q6wpv15gewzIvfjbbCo+lisDzivDH1oVUHae6N1WIICmoHjjFxaCY9TkI0+WC5hUZT/bfTpPO1pPwOV6gU9bY8sFcaONcLa6wyrptRoEnRMUtAk4aFNIHX/iXczPLFUdfdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:24 +0000
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
Subject: [PATCH v5 17/17] iommu: Tidy the control flow in iommu_group_store_type()
Date: Thu, 11 May 2023 01:42:15 -0300
Message-Id: <17-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d0f5e8-7265-4643-eb03-08db51da1aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QSxe+rsMLUlzn/zk5Tr5e+frImKlv6e7SlsNsbZCOdCVzoIchwTy0VE8yHZh+a/ThsyGdslipwaKZ/YMou1MaF7BhSgGxunOSxibzcMJs3PMFw69q4zl1+GtomdxjNVc8e6ROlX6V5eXAbbpIcb7MSG1+UYp1mpLEzWisW5qqPDoiKOu/o6GG9nCRwbAtTuxDfBCyU6jxm4dV8LmwFV6eC+Z0/WXb0hhchrFancbCYkqGRXmYG9N1pIJRH1RmsQaVOaFtCzcIhXdJHgo69KdplJZ/EzH4UjTEbOlvJyd//OipA+Nv+ZGoYBO1y/7TdGoHZ6FEj0CJNfgm0alBNraCS3kH4RMCxirBLWnTT60ABd5H/VD7fnMSPNEg3ObYy40sKjwKh7lO9fSPx3CW3BLVKQVuTzTBCcoYSi4Dizt53gNvjZ+El5oFKB0zL1gMKz1GeeJWxe0ghmVIu9GRqCZjiU/0SwD70B6ZZUT7UWuSM9U2kBkU1fSfP93oMXbvuKho1rSnmg2hdoeKimfDY1WHaQKkvroFvEaZz1vYELyoz20/AKtQa6cEN7CmkSQHQi8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i8p2YEZ/qU3jTNDQ9roQixrndXx4KODMCfmoyeqajQjiJN9QDePcHU3D/gQM?=
 =?us-ascii?Q?u4f+La+SnupWWaRA2yBYZ+jNuEmSMHiI2lNfPwMYXsYF4oLjrMIz/bNWXwCL?=
 =?us-ascii?Q?RPL4SXc1OorNQEsgI6OVtgj+Gy1VQlo0e60RvmHN8xgay1f6to4XchhxzSAY?=
 =?us-ascii?Q?CVxZDvavCnu6a7plw1BvPePFsOm3u3NtOOH0LKx99NN7hQ0xaLfqSG4zDYn+?=
 =?us-ascii?Q?chnzcYntv8G+Mok55Ymp+/xk2alzFaZ5HAEhGse7yr/PUsQiVAsvuxXWn/6q?=
 =?us-ascii?Q?d7LguKgCImJSJrjH3kyao0Lnp4TFYTxflRRG1aZLkSxb7qIcWxYDDI6QSia0?=
 =?us-ascii?Q?dxupgdwqRpMAq+4oIpBmU53O6NI3gLiTSrfZDrObV/SK+PGx6NoQKd6f1EqU?=
 =?us-ascii?Q?+wi5U2lszQSc8p0MHRo6IPxoiBOJAy9Ev9HmvKBdypXxS5du3iiVv5hS5LTA?=
 =?us-ascii?Q?hzxvElIOjmPFkhCOtUuhDLqQDpg0K9eLwSyOOaLu0zQ9AY7JWtVCEhy9zfrU?=
 =?us-ascii?Q?MbLYJ0p6ultFKdkkvOBInqyhRbrtQJe/mOQQx9d3JQOHK4Gx6s8CxkvtXGzc?=
 =?us-ascii?Q?4nZD3CNoIafC4SdC7FkKR/9qb7FYrk2yV+H8xkyHh7psOzvzgVFCers5xufg?=
 =?us-ascii?Q?MKZJt2RfNnxW8aRMkD+JFtjSw2K4NVKdB8NtwUqjPjFSc8PKq9iSTVsYjXYX?=
 =?us-ascii?Q?3C97XaRWvs25juCWPETg4b6+wwQtuUxf+IaSIfjR8/yz6V9xtVzMgu5hwFsl?=
 =?us-ascii?Q?4Ibr7JpIqYXanwUTyLh1AVG3GgRhTd4fFIpdLZ1fj6l/EQf5HvzYQyAz1QoT?=
 =?us-ascii?Q?ekkCMNjLzW9xhXxecG8xSq7LRZhtneCdGpqJpGyb3CtoVkWW6zVu+QB8xiZO?=
 =?us-ascii?Q?vkf02A+0Jg7YKg9hQ40iIkmvhK+3AF9ZaKYJdqcn79WL5POqs8ZWoX1j5TMi?=
 =?us-ascii?Q?OW9L+j2rESne0fV9gJJWO94TYo+ziTftJw3ZnIXsSe8tfI60D8XGURGi+FpQ?=
 =?us-ascii?Q?BqLwswZsZh9r7lB/VVObCI4LkgYtInjovs06fDjR93KGQ70fZjjrZA6fj9yl?=
 =?us-ascii?Q?FiZy+duJvg1wFIWvbXP7NlhJ9TSxCQvKJnM4J9xuplBDUbxXVT+e/EYG9SWa?=
 =?us-ascii?Q?shsvaGVwYsEVVP3r3Y24aSE71KCa4khf6+8RCzxVR5DLONhqqk0t5fMAjqtr?=
 =?us-ascii?Q?Kxid1TyFLn1Uq+GhmoMYhsI5pV8PCA9sjhdRhAP0RXrk4g+x0rz1oEcmsGUh?=
 =?us-ascii?Q?RPYwtfz6I894g22CDA3QKXJNz+cX45xTi7DSzg/63muUZ+d4dG/x4oWqWG0P?=
 =?us-ascii?Q?XmUWYmKt1ZBR37cRInUPTb3JeoYN3Z/k2oIeAqQcFyTPveEp7tsfszO9Mtn8?=
 =?us-ascii?Q?X984y/R/FVZbyEvEgTGX9b2HhdqXyzSkQHJA1tMMvhMNJr8MOkylJFMLkZyA?=
 =?us-ascii?Q?dxkr2vvI+sVpv70hfA0Y0TgdGOa7q1A1lHnuEchz7N/9sLvXwNx3UKilfUet?=
 =?us-ascii?Q?V5qDqPFIGYGtsPodj8W0J9Q3BfMwNpX0jwcmPbi1wteZ5xv5GXYCe4DdTOXS?=
 =?us-ascii?Q?U31Z4DMQGZO4xFIEflr9/KENTatJEYi6DfFRqM6n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d0f5e8-7265-4643-eb03-08db51da1aad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:20.0106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlhNlAwy25HWldJ80eqOYdFKHEaQgsq/ou0zpt3QN/FE0PdWPp7Wfa5vdx3Smuxr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

Use a normal "goto unwind" instead of trying to be clever with checking
!ret and manually managing the unlock.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7d2fdd2a11cca1..4d7010f2b260a7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2939,6 +2939,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
+	struct group_device *gdev;
 	int ret, req_type;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
@@ -2963,20 +2964,23 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	if (req_type == IOMMU_DOMAIN_DMA_FQ &&
 	    group->default_domain->type == IOMMU_DOMAIN_DMA) {
 		ret = iommu_dma_init_fq(group->default_domain);
-		if (!ret)
-			group->default_domain->type = IOMMU_DOMAIN_DMA_FQ;
-		mutex_unlock(&group->mutex);
+		if (ret)
+			goto out_unlock;
 
-		return ret ?: count;
+		group->default_domain->type = IOMMU_DOMAIN_DMA_FQ;
+		ret = count;
+		goto out_unlock;
 	}
 
 	/* Otherwise, ensure that device exists and no driver is bound. */
 	if (list_empty(&group->devices) || group->owner_cnt) {
-		mutex_unlock(&group->mutex);
-		return -EPERM;
+		ret = -EPERM;
+		goto out_unlock;
 	}
 
 	ret = iommu_setup_default_domain(group, req_type);
+	if (ret)
+		goto out_unlock;
 
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
@@ -2987,13 +2991,12 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	mutex_unlock(&group->mutex);
 
 	/* Make sure dma_ops is appropriatley set */
-	if (!ret) {
-		struct group_device *gdev;
-
-		for_each_group_device(group, gdev)
-			iommu_group_do_probe_finalize(gdev->dev);
-	}
+	for_each_group_device(group, gdev)
+		iommu_group_do_probe_finalize(gdev->dev);
+	return count;
 
+out_unlock:
+	mutex_unlock(&group->mutex);
 	return ret ?: count;
 }
 
-- 
2.40.1

