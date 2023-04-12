Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843E5660;
	Wed, 12 Apr 2023 13:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvNokySD7hs3GMxxCQWsChkfn5m4J6tG3R++wQGlBXaYysqwoGBuAQaimxxjAlu90EykL5mGxGB7g9pFuYWICgIxtG0W6ZCZ5FfJ4+gLsJZcY4maeMIJt2SgaSaqz0dwfNyqL0I6bP2JWVkrGWggBLYk+76s51OkOTK0Y9z2aVHFdVpQyIeuYuiQoV7mkYXO2PoYKNe6KbnyFodx+yYStKfOR3w74B3Ija7LZZq4+HLgLVAhgpEmyuYvXkTCVeMUYGFsT8HUinUedbkoaHwRtzr0RUBt3qP8yFngJjeiluA6YBmdlQAZFg804bN3eYubWO2j9KIQ0qLAp61mHUj6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AChxFRnxisFGnfOGYOy0EMchwL/xXl+2H+dG91ttsWY=;
 b=Kj6OwE9gGhZRJ24KIMBSw89fx2GszovvFeDQ0cr2h6RZ6o1f8ZgYjksImKjTD/jNB8C94qjkUnBxRhNIsNRGDmP+CF0kzI+3t9AGF5Y4+dwepkW4QnDsHq9ukEuuTQiFS5oUnmbiGWLNTosKY3srTr5mYkjJWe5fSQL8lJ2CDkBkJ4pkmCyEjPeSoKCU6ws5URA04vGXlXgOfRM4Q+QRiRIgtF8sVyvg3h5k1/JBLRVnR4IDXeYSoU7uFAA1rSr41120GVEUbgzP29pCdG0Gt6oQTqy10AQOAb2KD6taYh1EIvfsR2mWVSlI5B0Rpy8uZP8BoV3jxBZgzEed2YwizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AChxFRnxisFGnfOGYOy0EMchwL/xXl+2H+dG91ttsWY=;
 b=mthxmfefbZgU+DjxgqSw+oQxZ9gG8+ccEt/Fy8FTMxQNjSdt4qIezkqBUoZ8wXlYM4mcYaB+07j97aeKBcfJcB34UTvkm/5a02eKhWGEJvjYTUMO8DPIUT0LALDc+mhetyVOgf+MsxOw2Qy5P6giVTmo1EZQeVdn1/+yLKfcb7qkVAX+rLnSa+OuJoys32H2LPybX1Yx8Olg/qiSI5ZzPpj2AaGxlfemrQ/HwWTMIvva1x+frsshW7L5CQzua2BpdJLKHZyEV8cZNAY4GfZLIXxasvasx+9DTWLOyPlXQHbjeSe9d5I7xwh3FUIHRA5hwsWzApzGjpAhezTv8MS1mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 13:51:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:50 +0000
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
Subject: [PATCH v4 04/17] iommu: Use __iommu_group_set_domain() for __iommu_attach_group()
Date: Wed, 12 Apr 2023 10:51:34 -0300
Message-Id: <4-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:207:3d::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc2dbb7-e593-492b-a6b8-08db3b5d0f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6khT2uuFqNDKdmZk9/oc7URi+OdD1zWV7AOfXVrCMp90rgWv1u4Vml8YucyuJlcOgccTFhDfsMEAWkeIcHsqXBM+H6LqY8GCpY7jd/CqO8JqHfyGu+wxbdZs4S3WBSXsCz+VDSlJujOXtAOBM32EAV8m3hUP+OJNE9jOnuZygGzKXxX7PUIchNOHyo/XGg26RFAR5m+9fN0MuoNR7+ELO8XNHqoXVH0VCGuZYlnm+X0J3SROJMgPzm4uQoCvRaYavBtKUNnaNB7jfbFOEbtB2G0DGwGwVZcmuEg5t0t4mMXKjPZjJbuahVcahUmCiy3Fows+WOkNXxtPEiGbCbGMHNHbyEDjiPQj3pgDga7tAP4Tnt8SINHBqgifsA+6jCBoWV78Mb0YK6m73b/VZXjFK6jlzXlpItGhuARjePAglaQN3pp4uhhXAujk8eDln5dK5PEuUSnBfTgI0+ZeuIHje3KdoudbP4eMjQ+iKGSA5iSTRoDxibe7y0bhVVRlTByf6uZJ1Ki/fnpGBNrLnvbAeE6rYOpWVCzI3BcVcPjNaaN0puM72GlpRE2l1TUnHrVgHzELlluqs3RC4D2KIY2WQjLUiC1Xtkon4L/zE+7TTWI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(6486002)(4326008)(66476007)(54906003)(66946007)(66556008)(316002)(110136005)(6666004)(5660300002)(478600001)(41300700001)(8676002)(8936002)(7416002)(2906002)(86362001)(36756003)(2616005)(26005)(107886003)(83380400001)(38100700002)(6506007)(6512007)(186003)(66899021)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3SFDxDx91a1+4NVmXr7+l8t+58e+EGL0ozbLJL6x8e1/vl7mwttdKLZpVm8Y?=
 =?us-ascii?Q?uxmOXuNhX2/podtaUeGYtW4tiDnQ3jY6WjerJT9JR27pHLgNFbM8iZZk+Z6V?=
 =?us-ascii?Q?/yyvZyMu0PhmbCHvDq+F/T9WY+R5WjYMhPZguzIbkhxSxcIXH7jXv2cOWBg1?=
 =?us-ascii?Q?tJH31RWEsDHaU4uLhT0JAgb9s2vnNixDw33UTL1cCcrA00QZOE0Ds5/oK1A4?=
 =?us-ascii?Q?nk3++b75ciVf93UEEW4Wf8+fUPT/7F+5fp5mKl6h8M7qF1QYVoQoJSj6d55m?=
 =?us-ascii?Q?+NWpkDxVAfrM0DHjlWpYRu+RAJXBVpCeh7IUcIWXbI0yxPyVlqWHbSs25Yai?=
 =?us-ascii?Q?2ZZE8BSbhnLLkKzYKJpDlDbST3p06CKn5ycdKTnI1yukrfTbndjR9R2h2+4Y?=
 =?us-ascii?Q?pH1FcYi5QzjJkKXSo34Wx6qNfO/tqnqwhi1CWIVvap61m6go3ywKn0S7q8OE?=
 =?us-ascii?Q?VO5qjIaVFIUbduw1qmI/NRecK7D9KkpD/M3ITAK7eI0aVW52i4yY/Zc2vvjY?=
 =?us-ascii?Q?YTpTTIR5BkBeM3jfbQZtxggak+OR4WZxQVReRTLg3ThWcII75KUpUCYl/F9i?=
 =?us-ascii?Q?AEMW2+GtLvOZILLQog3ikXwOrPtPiTH0yXTn1k4U14V+N4gKCS0WOJjWlSZO?=
 =?us-ascii?Q?3Fwxj2TELnPo5hMX39y581CVsJDCIaUYKJbembCf8rFheLe3Dysf/eV13RZ3?=
 =?us-ascii?Q?0UUbN3/OmnCxZE+Jj102P9/fD89lRCMa5FKOMJEsBKnGx8FY8+JPRgrj3M7N?=
 =?us-ascii?Q?4g0VCtZhDgMxZCHYW2tyOrgKheJppHHUtw73EpXdSsVB376TAJupuzjstUij?=
 =?us-ascii?Q?jXc4fvleUkqnwNgNMseGOANYx+Ay4rVdhUpYVgA7WJgZAcHM0bYmZmUfD26a?=
 =?us-ascii?Q?SWRSN54i2HA9CDuCqJ1qHrWgvpMLSppRLYFxjvYTpqhB0PZdsxUULV+f9Yuh?=
 =?us-ascii?Q?f9OR/brOp7FKy4Jk0bi+m7mXsLru/EtSD//+Xo3AOflrEZFr/8w2YNyHKLIj?=
 =?us-ascii?Q?5Y6iHgIsc1dZs7tSelJ+cLVKGYbo8LmNEF1yVLBOqtocFlTyHAlsz5pe/9MT?=
 =?us-ascii?Q?YC/sB0ly6cruumMDneIBmvkHpn0fu220/ceGEsAeK6dycOySYNHJsDOB118R?=
 =?us-ascii?Q?OMy5y9URax97Z5LEjnkyUoETLzr49Fujf0Igp1cJdnt980/YYuSrlTXMz290?=
 =?us-ascii?Q?HibNfkPYdE9UbhzW/JRQfiRpV/+KA7mdEpfLP9n9KS1Ljvii5CAaeZBeR1H5?=
 =?us-ascii?Q?8qSH08vt49UUW/8GyfRdbguMLQD8YaWwA31uV6DP8Han6RUyGPSI1EOm23gE?=
 =?us-ascii?Q?apuxm/ksneCP+cvOyGFtso02KNJ6q9PvuV/+MAxf2WF4CpdNwpAi0zWwFGuA?=
 =?us-ascii?Q?7LTVhvAjcEN83LTwRB1Xe4XfUeL+bk4x0csP8FXEoPmCMCFWkHqm9zF7rqQ5?=
 =?us-ascii?Q?BPvC5jvBnWYLnqe4guNcRFR8d2i6Q2G99N29d5cJ44EIJrN5O3GsIKyzpxek?=
 =?us-ascii?Q?M5BMgpEzO6j9tHHnroZrBFFPbkeEE+rOVNucmDu4PNwaE6McJphTMEfp7wiR?=
 =?us-ascii?Q?BmhDFDZ4lwGnL1lF5NoWdiAoYq5+XFC/0VWxAHIP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc2dbb7-e593-492b-a6b8-08db3b5d0f96
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:48.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKuy4wzlSTICLcoLW/G8oTq6OGotl26wISV6+M+5x6Itjv1wmTmVamjnXfXM6XB8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957

The error recovery here matches the recovery inside
__iommu_group_set_domain(), so just use it directly.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 40 +---------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ae396c1d075862..2b1fc060305ce6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2177,52 +2177,14 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 	return dev->iommu_group->default_domain;
 }
 
-/*
- * IOMMU groups are really the natural working unit of the IOMMU, but
- * the IOMMU API works on domains and devices.  Bridge that gap by
- * iterating over the devices in a group.  Ideally we'd have a single
- * device which represents the requestor ID of the group, but we also
- * allow IOMMU drivers to create policy defined minimum sets, where
- * the physical hardware may be able to distiguish members, but we
- * wish to group them at a higher level (ex. untrusted multi-function
- * PCI devices).  Thus we attach each device.
- */
-static int iommu_group_do_attach_device(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-
-	return __iommu_attach_device(domain, dev);
-}
-
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
-	int ret;
-
 	if (group->domain && group->domain != group->default_domain &&
 	    group->domain != group->blocking_domain)
 		return -EBUSY;
 
-	ret = __iommu_group_for_each_dev(group, domain,
-					 iommu_group_do_attach_device);
-	if (ret == 0) {
-		group->domain = domain;
-	} else {
-		/*
-		 * To recover from the case when certain device within the
-		 * group fails to attach to the new domain, we need force
-		 * attaching all devices back to the old domain. The old
-		 * domain is compatible for all devices in the group,
-		 * hence the iommu driver should always return success.
-		 */
-		struct iommu_domain *old_domain = group->domain;
-
-		group->domain = NULL;
-		WARN(__iommu_group_set_domain(group, old_domain),
-		     "iommu driver failed to attach a compatible domain");
-	}
-
-	return ret;
+	return __iommu_group_set_domain(group, domain);
 }
 
 /**
-- 
2.40.0

