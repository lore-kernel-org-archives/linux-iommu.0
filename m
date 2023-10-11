Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A432B741
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IwJVIR2J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8nTpzw/l7/u+EEH6vK+bn8NwnF+QYCusQyQjzPJEd+88DgIOcVUvtHt2z3Naw5zzKayci1dUDVBo05aBk/1zAK9xLcXOuHAQwn7z7/L/sWjEy6yFHguiTWh3Pym6h3qGEST64qHXdDQ2S4/6l16avx3g8h8U3Ui4guhKgQGxaHe1HB9j2rFw9rQwAdoFdXatfbcFbvDqrdWKzEh0wdX/HZLNv9XhLXHo2H+Se8wdWQLMvshqKKJNGadSle4p1Vl8kLraUD7r+45HMyJ0rVBkO2xATkJgKIQmIyWZbukoPov9kt1GDNNy8EdFEHeOWPNZL4uZfBH/L0IAjg4hAKprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nuw1dvdvpjKmN0pGaLmUCOQNM9gnEw2izq/8rixVPCg=;
 b=GAaxxo6n0BBcz+BReFbntstXtyCaZenZPYzmGFtoOMrIGSqpW5RzZptss5fzF3pFTrti42q0yFywbYMIIq7cewq6mp/SdYE8/0J7RhJh9p7/ehFueFUBvFVB1zy/6RToeHnN9HKEh+/15YPCIeOnEurDRi7Dfej5eOTZ0COdDiHXsbovYNYinS8IVpj41UhIf3gKBfhJrOrhHznAKuFj7EoFeu10wfEvBJPBNjoBKWU1SxgwakjFrZMaCLkLJYnydAk8p7J7rCnXpsyOTeVnsPwyyumMJ5LBHEmURwbHAbxo6UU+Fe4hdpDOJzuhQcAPiQ08vqnJ3++i/FvcDNZ+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nuw1dvdvpjKmN0pGaLmUCOQNM9gnEw2izq/8rixVPCg=;
 b=IwJVIR2JSPZBH+n9eEQzh1ApvVIEmCyMH4Aiwv5OL6e5MBopfcetC4nFz494XIUyeivpgW+4dAlWrHPQkhdqdfZdS9mRDLgCu5dHX8FTShloY5foCXQXDI9EQ0YJ1SErQgj9Jd+kDCxzi+bpiyz8lKdqaNEkyPlKiqfwomwA3BbbdiZfTVDAlioakKuav3iImN/m315Cnj1eHHyVoSbAEUr7f4UGRJvlct0s97dBUbEXPk27n8R10ABZop2+5G+uKbf44b8z2o3+ZE4yx6JVfiZxinqRbyt1hagRfIbGdN1epaJaj64nhkkms/VFPnoF9MbhJr82LTUm+ZKlsg7CbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:15 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 19/27] iommu/arm-smmu-v3: Keep track of arm_smmu_master_domain for SVA
Date: Wed, 11 Oct 2023 20:25:55 -0300
Message-ID: <19-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0041.namprd20.prod.outlook.com
 (2603:10b6:208:235::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 4076ea42-cca6-4ce8-2fdd-08dbcab17127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6mWfsUORkMLlhrdlyiF9zd0s2rBYTnaALuuqZ1s25ncWAbAn66PFcCZnvqTjxvKChtXw5uBEQJwvhJSSCofQo4BYnjCyudARdw4Ff405d5A3Uvc/evxN+q50SpvMDi/oVu1/Iu9LjCjtAEkjBYK1INZOdOfPwYL1AUJ90pK3PM4EsXNhZaI5rCmpTk4u0W+u9k2ULD4FxwI8obBytW+t6wv/lHqdYSzZCHpDUQ7+wf/szwSerAtRO+pHYVrNVUqbQls2syMfDFUNsK0aVBgYpnF2+mpvzM7u9rAYHLBJCW54ReSzhSL51GHlkaOcSiu7S1OXXGm1MpmgV2xnusUJ17qg3OzLo+uTTfxaWV/MhrzKy4E74tFcyIZ91gjymdHD3nrwk82FLR8ShrZlWvkcYiazzIADjVlRDSFJp1jaQ6Sy/1OX/BAZstAkrN58BWD0bQrDxNi7nl6xmcltl7gVxdM92t3qfnMEl/rEPOKGjc0OVxXbKidsE12sTrxqlV29aND8qh0iNZ5K96tbxX9nYx2I4IflUaIUUjGveoz5dYJOTuJuZUczpIRiUiuF2Z/L
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g7JT7+apIdNPG3WL93OFdoPZJUS5VDOV7cbVbBcDAwA27HE1SANbqI4K7wdE?=
 =?us-ascii?Q?FRPBSSt9VNplsmZz9eQ4kYh0+B3zUM6xzqDIvrBgxE8WbOkfLdq2pA2ibJ6J?=
 =?us-ascii?Q?TndWg5lcbJ21N4O8wuKXG99eN1hurD105FYxI2fyrXXV/bY/imxOlPF2MB1F?=
 =?us-ascii?Q?hy1dxyKzWqy8PqNeD0g46l1W4jWiHicb5JhRVKAuu20VjUKsJJy/7NOmT5Q/?=
 =?us-ascii?Q?nbXrbgw4RjDGOs4peC69HReXI9VKT956JjA80wfd8X3KTBhj/fyQyuvE1/Kz?=
 =?us-ascii?Q?SJnd6hXiBK6Po4Lcj6BfP+ppPZvDFlONOVlBiK+USbOh+eowo/OP2Fit37Wx?=
 =?us-ascii?Q?f2MXH5Jszo2ma0VgL5nvB0AK/GSF4LKvomMP7XAGBi8EstA7ZQsDOEODR91D?=
 =?us-ascii?Q?J26+udfLXV3hp1/SxdA02oDCS0r5/mJiqab0Xz2MnFFAge6Vp7UNt0izItoj?=
 =?us-ascii?Q?KNn0HBAdHUNcTFUqSKCNH1eI0p0JH+03J7o6XPWI6I+MLy7q+4feRkvCz/Bq?=
 =?us-ascii?Q?1SgFWj4fOckjS5LGOs4CM+s8JJc7HlIZXSijIaaN+UFQykuLSoOyq2EXlWYZ?=
 =?us-ascii?Q?ukO2o3W5rMLhD2ZLJDqVTi/DXhcIHER5rcJw8jOKgE1RuCmRjr9+r686MxmV?=
 =?us-ascii?Q?jqte3Pi3cjV/rpLX6JpgFDNjYVr5HEZ74D00GnCRFGIpKyWJ5SzOIV2MvxZO?=
 =?us-ascii?Q?Iyqap01He5wTl5y7UbG4H46z4/jNfE/Hwsdx241pLd8H5ErUxasyssMJ9V9L?=
 =?us-ascii?Q?o0IJFXn3/3AxtPRV/WV8vhZa4lgPQi5Ji3yUqfQXxQsdnlseLIBHv62GGGfP?=
 =?us-ascii?Q?42VQrUrKRcxuQdgXMmuSCT66OviDi7uYE/dWKDY6V4BxFHNQD9SYvrJ2jvey?=
 =?us-ascii?Q?w6d4q2Cn4eacT9XSQ66ZXz7lVjqQ+BCHfhwr3xKjxkTIlJzBH3iu4ngftQN+?=
 =?us-ascii?Q?7m9TuTQ3Ky81lJpGpm0TVXx0uR7804fs5Aez8nAqJyMkWNWrUBBR7MQFeRuF?=
 =?us-ascii?Q?pe19e6qdEfY1UWz9/QUd/lC46jDmvkiaqN5BLJzD+AKxd1kilZIatVWxGBSe?=
 =?us-ascii?Q?YD4I7wvCRf3ZCBr3sB3j+ZX5Mpj9Y/l9F3CQY0+21ldUnLAqwY8Qyh5arB9s?=
 =?us-ascii?Q?At3UBQnLI0b7rF+3GtcL5+24p+0tZMcmU67tIJbG9wWBr8ZU1C1qjT8MqomB?=
 =?us-ascii?Q?MbHk5ovnErl+Xo6AVDyXLkz+or58ZLCwLZS5JV+G/s3sA33Y0fD1aa84hfaj?=
 =?us-ascii?Q?kkkN6VuEYCWk/AcecF969BUH63HaihmMpWe2r2jmg5wkjc28Q8hxzjUOCK/T?=
 =?us-ascii?Q?S/z4BjA8qietiidOnlMHXASJ8aghoena4flzkXNqYw2vWl2cZRQnwoPK/r68?=
 =?us-ascii?Q?HSvltpt7UQX5llTE5C0XWMhOIJM6ITjCrpUuKf8sVFbfX/kfLiKhPScY+u79?=
 =?us-ascii?Q?qxaiHsMX2N4xMw+ppBKEyr+TZBfZ0BzIR2TFHVkeqA5ZOsfaiwE5HsyhM463?=
 =?us-ascii?Q?xQv/K/LzPancuZAMQ9K/cYc3axrBhK0gupRbifnb0GhUqlRozFLcablTG3o1?=
 =?us-ascii?Q?Lu+hR/C2rlDImmseVPHsLHpRMfM6DBzhchKyr4Pt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4076ea42-cca6-4ce8-2fdd-08dbcab17127
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:06.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3ov6dO2aK7QoNgMU4GvdItc3LXnXJ/xSzPlpkFhCBhZrcAQ08xZ++FInet7GBah
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

Currently the smmu_domain->devices list is unused for SVA domains.
Fill it in with the SSID and master of every arm_smmu_set_pasid()
using the same logic as the RID attach.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 08eac534cffd36..540666986a0a39 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2724,6 +2724,8 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	struct arm_smmu_domain *old_smmu_domain =
 		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
 	struct arm_smmu_cd *cdptr;
+	struct attach_state state;
+	int ret;
 
 	if (!old_smmu_domain || old_smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
 		return -ENODEV;
@@ -2731,14 +2733,32 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	cdptr = arm_smmu_get_cd_ptr(master, id);
 	if (!cdptr)
 		return -ENOMEM;
+
+	mutex_lock(&arm_smmu_asid_lock);
+	ret = arm_smmu_attach_prepare(master, smmu_domain, id, &state);
+	if (ret)
+		goto out_unlock;
+
 	arm_smmu_write_cd_entry(master, id, cdptr, cd);
+
+	arm_smmu_attach_commit(
+		master,
+		to_smmu_domain_safe(
+			iommu_get_domain_for_dev_pasid(master->dev, id, 0)),
+		smmu_domain, id, &state);
+
+out_unlock:
+	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 }
 
 void arm_smmu_remove_pasid(struct arm_smmu_master *master,
 			   struct arm_smmu_domain *smmu_domain, ioasid_t id)
 {
+	mutex_lock(&arm_smmu_asid_lock);
+	arm_smmu_attach_remove(master, smmu_domain, id);
 	arm_smmu_clear_cd(master, id);
+	mutex_unlock(&arm_smmu_asid_lock);
 }
 
 static int arm_smmu_attach_dev_ste(struct device *dev,
-- 
2.42.0

