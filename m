Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B55696;
	Wed, 12 Apr 2023 13:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX3ahZ6gaRUu9PcUAjhxS+zkKODHuw/wLV97eJE79Kj/JYkToxtZc+txpI/5O+4KuizSIQODOt1iaYkk7XcHYaj3RlxJM4QJ/KXhE3vqmRGcst3ucZBffEAG65DbUAKd8IRUA4C9/YL77cyuJOVV2m3tKYa6PpwQsX06Osj0jiUF0ak1WB+pGZnk051poX2JxraejkOOBSgRQOhLarLX0xL34uN5xJZKUZZZZ9vEt8Pemmt47TUG3xnOwpoKWQNzG50B7vf5f6DH8CfNnX3J/K/XRLOuNEklPfVUAt2Ex3NJUiVBlvlEuV/PefAhvVhbxLBr+skE8k5hz0tNz1U/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JG1UftTVi8ptoCVrhdI2yI9BOK5X6aKVB/TJ6K+edog=;
 b=ceLPHYCG5gVXnVRsx/DyHzhlWSnMXWJGJc1gMQOHqJxfMwBQqRTTEP3kueVuqdSXuVs/7TakE4RF1bO1OdjgAAJXrXXKcqTR4yCUyWitVz2Dk2tU6FyhvujmWWz2b6K0KX1rFQnhK9cwSIRolRxnPo9a1stSa634ybtmokaXiLnjl9A238gmY5cY5UDdmu8CrSEI5Fmm0yri3DVisUweBgYL46uByHBUmv/MOhXrODvivZ2TPtXfiJeProIGk3kWNPZAbQML1eZxCc01+wnR0ZWms9qKCu1cKFnnVw3htzkis7aLSlzWQ7IF2w/rZogQ2WZcA1UQV74iRExf4yxC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG1UftTVi8ptoCVrhdI2yI9BOK5X6aKVB/TJ6K+edog=;
 b=nrazZ5kOYLRO08tSwftbbP4VSzSzMsB8sfZjRrkWl1GLDayEbTPQmwXKXTFvyeJo1JPn+38RRXgEUargseFo+U8OWQrsUpUmDvTJiuV7J3CgyZBK7eJI39Qzgxplv36iu5/b0oR1vfhsW+/rH0LKsf7Nw1t7sZp+mWMrIyNejOcRaqoSA5Fl7KtQXnDS3VPjF+wX0FXR3SyFINL5r88Jq9RXTEuEhcEr9mbtgIi8UaISmav2Vk09qsJDJotw3w8ljn9K2i5hZVhLOAjql4jqFTJ0jEEuF7OEX+PFtFn65XO6q/GNaUliAOgzmGROHtcFqbM26LwKdm5Sop88KWXXKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 13:52:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:52:00 +0000
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
Subject: [PATCH v4 10/17] iommu: Do iommu_group_create_direct_mappings() before attach
Date: Wed, 12 Apr 2023 10:51:40 -0300
Message-Id: <10-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:208:15e::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3b8109-aa0f-4b8e-5792-08db3b5d10b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hSrVijm0Cj8xG7A2i4BKLfhRm5zRRsN6QnETPl0kCx24AOmZ1BBtZLCVLUKunQ1AFM0DPluUPgMvGluh4BzhEI+2gVZ10L5g55xQX0S3W+QzFceVqicqng6YAkTLBFlEGMbdineqI9ovSHQjnbsTCnPusPTwxeqHaCD2dodpbLr6L3pv0mYRmB/GsJa3V0zfmYyUcPdUOwver9rGpJnApyQ6zmaOVl4G03M3HwXjKxbxQ8avQrXvccjm3/fnnEONlMvnqNiS2fNGma/UVCeNqc4Zhb1ruQj31H60fSZ/HwPQavGsuTIPEsjOgioTWlYWADdc+Dxg0udkMA6aYOgtRY/9IOo1yVcZ1WRnTcd+LbfWk5TZu2O9Wq76/HE/GlT5QfOJZSM3blVZhrDM+/ylEF/JT7eZi+Pj4J0LUqmKqpmQETTxwdIr5BHzSgkjf/Qms6NKYk9+2ZcJJZXFL6Yn7NjdnWDo9xoWEg9dJn/ORgPBNf/c7MAWiXkq5ZrRrrocw4Semq3RQwFR0ndf1mcKfBIvmrHrEhYdvIBFMGuQsW/TwBqPaCQJSLBWXTLDIvlg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(4326008)(66946007)(54906003)(478600001)(6486002)(66556008)(66476007)(8676002)(41300700001)(110136005)(316002)(36756003)(86362001)(107886003)(2616005)(6512007)(26005)(6506007)(83380400001)(6666004)(8936002)(7416002)(5660300002)(186003)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sStjryz75UNly3wXZzjiQCkJOhnZV9Bwuth28nTzs0D+SCKbRl8C/Hv4Tas7?=
 =?us-ascii?Q?3sb7xoQJSYQXJAgm+mDXYJ74uMXfylmh7+IpQxTLIO3fLlEDy4jJ2BdVh0u/?=
 =?us-ascii?Q?R/BZwP9cwH5uIJacOz75XwD6YVQgeHtkikZYfv5hPyke+Q+MznxmPmA5ItE6?=
 =?us-ascii?Q?4zHsNgKGySrmGYt/cicNkbi97EhxIhTT2B2DX/YWx09J0Ws4TjJp9Snsb3d4?=
 =?us-ascii?Q?/2GpZ697voA/B5iLc6raN/fP+++zJDPK9ow9OjlMNofT1xhBVy3y0aqGmJ7W?=
 =?us-ascii?Q?riCbNAmLbkqq3BEqr9vdmkPIlKZCf5GpzRVYHElYUVKIdzpyRb7Dcf3z86h+?=
 =?us-ascii?Q?xVYUfmxyWtSpT+kXKmaCXbdUFe+PUbfuNVGA4XRv1iw4aKgvRNbDWoHM18Zp?=
 =?us-ascii?Q?Bg/vBc2qgB76iwKE8Mfmr88V6/dqaWwymKYQTV1s6humgcn4VW1nFpZFXxKD?=
 =?us-ascii?Q?ZLy3sHqH0M6UhekNpcyMO8Fh/KraR86S5DwMolMxrAZCyj9K7By1qWrdN3HE?=
 =?us-ascii?Q?78fWUELN1hmY6bxcGeXaP4nWt0YG1Kntsq5fNOdzTTa0Qf0ydUvYOVRCYCuD?=
 =?us-ascii?Q?O0O/JBExpSzbCCSiN2+QKXm1pNdQnUyDnRbz6zRxUBHQRrhXOdVghNFORrUq?=
 =?us-ascii?Q?EMwBeTQ8J0Pq2Y4jvxKDckbrzJ5kFcQrIjGlFB/tUtYKLu5tjXrK8tfJmurl?=
 =?us-ascii?Q?Vbr+O2MP/i8yy7syMyN+k2NdKJj5rEoA6JnyHt/Kibyv2IszSXrzW1hUJu5k?=
 =?us-ascii?Q?Ii8ejpAusqy1gDDWCfJc7HP0LZI9aG0X5hqZ+jT2iiyByroeQcpW//BlXR6z?=
 =?us-ascii?Q?ZhPGs1WeilNTDv7Z4EKVV+MdEIiyY3ZuwmxULbzc//86Opo1DD6RYZrcm9wI?=
 =?us-ascii?Q?G5sLpL1wIZCMaR6IFOeqLHdjeSk5knR3ac8oV75OcQ25wfhBpTDajlUMu9ir?=
 =?us-ascii?Q?XRhFPjXxgBBvI+G6vLLR7xhMNiNLYqs6kdn/iMQHzbTILBWqyKk2FKFjz/wM?=
 =?us-ascii?Q?U/3yP+1wQ6YLoL/XZ10IMa6wg2XWGFPBik1XG33G9TIgsUxhfuc8Dpq9Pv19?=
 =?us-ascii?Q?yJ4LZb8zicXKJZU/VVCZsg46nPYOFzJwLnATykzM7z3CIobBE+Gvgc0HtQ6G?=
 =?us-ascii?Q?w6yWeQu3qc9X5P7lUXQKM9isaAOvjpSPpQL8waiuYTmquYLnG82THnT5gUiA?=
 =?us-ascii?Q?u/MdTNMGGheGvquEVebGq2URxy6aAJmM978yzo+dqYXwndh5maOP0tkvYlrD?=
 =?us-ascii?Q?7iSXbVmQDsIvDlrMiP16J6pQBr2lJ2tlY4acT39HeK83NqmHJTRR5LO3tHJP?=
 =?us-ascii?Q?smXrK/tA+vHw7hWsQKtje1QexzHlmftMF/WESUR5rd6ihW/oEeuk3GxuCMD5?=
 =?us-ascii?Q?H2e23IjrFK8fx+hz3IBqAAuyI5jQxYCaz5YGXg/VZWDamPzUOBJS00E9LJvv?=
 =?us-ascii?Q?Z2kjG3gkWV3v5ET5BcsVX77G+/uid6O22t/ioYVn+F6kVRvIpQQ0pclhlQjH?=
 =?us-ascii?Q?qWorvkLSujL0UdMgyXtGsycAMVSsxqZOV09hCxwhPJLecFUXIsYCbc5Jpv19?=
 =?us-ascii?Q?f7cPxrOmS/RE6ldcvWxNXyzT595TkvRWB3qNn4nz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3b8109-aa0f-4b8e-5792-08db3b5d10b0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:50.2339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RRuxB1q4mikOfSTtYTcFNCJ3ecz4+F0922t+4MH8Ape/glVgmuy5/mY4LZC3sx/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

The iommu_probe_device() path calls iommu_create_device_direct_mappings()
after attaching the device.

IOMMU_RESV_DIRECT maps need to be continually in place, so if a hotplugged
device has new ranges the should have been mapped into the default domain
before it is attached.

Move the iommu_create_device_direct_mappings() call up.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9076fbbb7d50cd..f0dcc7a559b55a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -418,6 +418,8 @@ int iommu_probe_device(struct device *dev)
 
 	mutex_lock(&group->mutex);
 
+	iommu_create_device_direct_mappings(group, dev);
+
 	if (group->domain) {
 		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
 	} else if (!group->default_domain) {
@@ -429,9 +431,11 @@ int iommu_probe_device(struct device *dev)
 		 */
 		iommu_alloc_default_domain(group, dev);
 		group->domain = NULL;
-		if (group->default_domain)
+		if (group->default_domain) {
+			iommu_create_device_direct_mappings(group, dev);
 			ret = __iommu_group_set_domain(group,
 						       group->default_domain);
+		}
 
 		/*
 		 * We assume that the iommu driver starts up the device in
@@ -442,8 +446,6 @@ int iommu_probe_device(struct device *dev)
 	if (ret)
 		goto err_unlock;
 
-	iommu_create_device_direct_mappings(group, dev);
-
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
-- 
2.40.0

