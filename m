Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B97B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 01:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y11O67723xmkgTWUFgS3E4SJE33MDR/f18GGMRXASIHY6wdqBs1Xe3MasCRMG3LAm2c/PzLgkoYSgvwfNFFFbLO0TkBQ8kV1hfNMpNPosP0cUfj6ivi8cm1FnrYAlSLEE612o2nCGhGzIWdoAMn0X/SdgQu3Uu+NJKBJbjKD5GJMQnz0Z2oYKpvbgkqimhR22oA2/YxgaWgNFQGHen6dU7ZSbRHdCRBYa7O2a2qrmt2jV6hZA9uhnMnPWwGMzR/Na6+B0nFlcdL817P9wowoWw+yor99gW7iktboC2Nxae6D+VCT8Z5AWGsZDZ+NzUoQ44QPPJhwgFXTEcSkX/F0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpK7cmYVMRELDgm1axU11mlZkj7f771hlOVX88B3lrY=;
 b=DJX/2xBx21syrsyDLD7mUOCWcy4Kb56uPllwI0fqP1d4yvaMpc0vfqoXvVZVrwk/C0WD3qB+8/DQm2ozZSApKQT6gOq0z6B7NDw/781G3CaF1DD776Iy2UBc/c/yPlkxozAu/eQ4pIeUP9lHJguW5Ow0t+lpBpqXd23bT7z665J9KOiw9LuJhOBqgkINaukw8/rtFI+iOAIevLUDzDLKMs22XNAvtbDW5d3GfbV363HtZf4maeplGzlkbunPurEhPzNWkbIIrPILUJc8uR+czSouXsXdtpbV2kbjWQCRWGPUDf8HgPV3CuvxafWIdyqVYgO+lObNpoYEDlQkJhvOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpK7cmYVMRELDgm1axU11mlZkj7f771hlOVX88B3lrY=;
 b=NiYh47NhBDaYOqfkJzhVCswnkwkouMdtKOyz7lzlGPPuywRSZvEvpoZf3vjqRW5rin+h7cT3q/DQ/QeCz22aNnNuoKIyUrVm5KPmSjk/o79F0ID2sXXkR7m7xglaFIykt+DhvkDH8nrdOWwtyVpBL6T0hdhyLjy96KEn9CqI1+DTOuHsPIhU7ClLBU8hT9kSEOtkFp2nFZ+05r0TgF7J837ukWynNu/R0CqV99rS5tVBhciBoXcfl1Ysj7v7PFWqX8vkwaPF7KD/o21svJDIU/lBnbzSJGXMQ2GrilnzOzhHa2YDbfDbd6aerphkMlPWDvn4Kbp55RA2UDUPv/Igow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 01:21:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 01:21:17 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Bharat Bhushan <bharat.bhushan@nxp.com>,
	Eric Auger <eric.auger@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Olof Johansson <olof@lixom.net>,
	Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH] iommu: Fix error unwind in iommu_group_alloc()
Date: Wed, 15 Feb 2023 21:21:16 -0400
Message-Id: <0-v1-8f616bee028d+8b-iommu_group_alloc_leak_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:208:2be::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: b448835f-2541-4ce5-ca80-08db0fbc1a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GL5I4gzitSAL6uKn8zBwxSVQVFqziDVimHurkBYF5ZBmppGxTfgqBOcuHipVQzxhosHjjXWX0BDzas9jT09vLGnz6GffO5azlj+yfbV3zhIH3e/XUoNBuBm2v8M9CIUxJlR1R8O3P+GqqMHtnsbkyR2ww0nI6e/eMvEdoHyWxxTS6zG/+OGbZSUtCrvX6b2HIulmoeKN/tG1hG9RS7PUl0FK9NPBdbCmwal7lyAA9S5MG4Rz/VvyxwWAlSlCVVFTFrPN1Wn0p+lHAwh+zoZ5XvQOYh2DJlYue5XXD4e0FnQWtrH5fw6+Z5O94hGpWSO8YYgTIBIlJaWTAUAJxv0cv1F9ksanq7CKQg/910xFt76uDkKSQogP3NNYk62WIDgFSyGp2kkk9A+h3q81CK3tPURtGga8zACS8JD0qLJCrZidYmZV46Wtf7Cy8vIclIg2MLiG+XXOs1YBQQagkUPSGJCowwTLp+uQTSwYJINojiqFYh8WQ/TA74GuvpTCk7oMNs+qLGMF7q74NtvL+7y6TuZxatV8YhgvxMzyU/PK7CsXfNiBKMOgPs7y9tL14r7KSngKbJBScdtNiSQJ4bvZNx6FvIZ6m0/M/v/RPsJIZ5w6eHf0lZdCNBHcszfnnZYN4MrieH+MKQqlwOEUsKCkmmNrXj3ze9VogfNuwsa+UExMMAMFDLxczu6Agxgr4IUd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199018)(2616005)(86362001)(2906002)(36756003)(66476007)(41300700001)(5660300002)(66946007)(66556008)(38100700002)(8676002)(6486002)(478600001)(110136005)(83380400001)(6512007)(54906003)(4326008)(186003)(7416002)(6506007)(8936002)(26005)(316002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DsLzEWMAcePsOHs6vJqWUEWK69M8zfvnqAU6FoL1s985frlTIGIlC+PTahzk?=
 =?us-ascii?Q?xDjVYyc1O/CFNcuY2bYDN3Ty/tH5HjKgC07fGTzLRKa0//C0UvFwD/k0V8nm?=
 =?us-ascii?Q?0mh8IcG+zpisnO9S204fbfvtHS9W0bsxJo589n/XB6NqkTHvb9NX64vpk5se?=
 =?us-ascii?Q?7ScXZv/CUJjgd8QO62kwffoys2gBz2mjSTONaGDrczCgEThbwzkSFBSygb1g?=
 =?us-ascii?Q?iR0qpmfFqlQvtJHQ9OKq8BuRV9BInVWNzr3u+MSQnVPtDsMqNa4hxUecCJbf?=
 =?us-ascii?Q?NXoxhbdK9SmrJhYC8moYweMzTIueg7xNVmKaIONj2oTLcgOAaYLLRbfsLn2U?=
 =?us-ascii?Q?A1p3ZtsQgmLYDXsu80SdPNfFZ76jIQD0WZEyNk0Hyy4s5Jf3PNAfTdEB9Y9f?=
 =?us-ascii?Q?3H+5t8c7GBjO/dOAhPhyl1tovhFTAbfuML3+/fUkKeOui7zLAXx9fNoD+kFb?=
 =?us-ascii?Q?xb2VEjZ0aNF93s9216NpeYxcSPVODQNR0Nma+SKMEGklZ8DGkhAQUe5x1YFT?=
 =?us-ascii?Q?3ezBFCngH1sv+jVBREo7FLlYrweGNL7HZ5ruT0tg26Pi2tLjnA0YuPHAvEp7?=
 =?us-ascii?Q?WG5ASEoXEVqGBjiz6MCaZX5PM/hlU9u1BN0ZS0UTHDwURvLZ9I2v0OkCuxBY?=
 =?us-ascii?Q?2JOPeDAc6vtVrl3Gk8hiKvug/M6m1rRyJrCDNRaq0sZAlO8M4U1U/XiOBL7P?=
 =?us-ascii?Q?KMGaCjXugml9NrcLqpR0cwlt3k5WAtL/zAk6O+nuJ2oaDcGj8Y7uaadd+yWF?=
 =?us-ascii?Q?LyXmdDzTA7uAcGy7Clxff+GGIdqw7K0HkjvaHbmaCaYMjlwA/hOzQA7h7jKA?=
 =?us-ascii?Q?RnZd3TJsIoqjmac2e0EwsRn+oOVTE0vlwUzMg9zbZlUDCAwhuGHAJagCqFTj?=
 =?us-ascii?Q?YeEDiSgeLzDByynn7h7hoi6Xduyi+RhSiE9DRkIk1y0NtAWG5us1EDJoAn7s?=
 =?us-ascii?Q?mcUC3Wvv2iZt2Z8eJCh8nwnfsPgichqwXc3gjtkpxWfNisFpg0koGu9xI6qQ?=
 =?us-ascii?Q?tM8gkk875cCQL9uzMY3xC/3eCr9L2XwTxHKmO8hnWWEEyG0SAVv0BtN0jX3/?=
 =?us-ascii?Q?GXS3P+wcc0/KiAE5+qSSFYn5Fsm/NMSGVN7Slm376hnQ8/YCo9Utr1DeVeX3?=
 =?us-ascii?Q?e/pYdTaLGtq7JxswOPBQGHr/wZFjHqojoZqCY644EpviU0BMRpvHDNfsAn2B?=
 =?us-ascii?Q?s4orZ2FHdGFhQYCG+DbZCkfd+5aU1mXNtdS6w5h50jfpJa/C3ucnvXa9ujt2?=
 =?us-ascii?Q?+rK0DdCSpyHLd72AEB6YlgCc0Z2zwNlJQ8FwMfreoT69XcdrEc/rBNyI5cEG?=
 =?us-ascii?Q?c6JGCokv1gVdsvUxvCSzsTgL1+62FwTgRJd2PkhcNIBWN2np49u5ZTsvOJ6o?=
 =?us-ascii?Q?txGQ7vBO8cqTibt023uwTMKijjqPU+clR4pa7j5FGDyrj8soYaK9yiYypCDH?=
 =?us-ascii?Q?/qvJQoKZRIuwuqhyJhGIL0O350yxcZlRpYR0n9nNu2bTWP3+UflTvkvyuEqX?=
 =?us-ascii?Q?pjYh71pbUfixr168NhSHbFWJs+L4aFMuWlBfZNHcVHedmrWiAsM5WKh15xEY?=
 =?us-ascii?Q?XyJ56K3tJukV5T1fmh5IxuaofKzvP8sdIvQtUJ8R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b448835f-2541-4ce5-ca80-08db0fbc1a7b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 01:21:17.6583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGDVNZjaEmu1FBZ/V+n/VMkeRzwunaA9T1ChCNu9Ly64wA5+aEbMSQ/gVGqC/IeO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949

If either iommu_group_grate_file() fails then then the iommu_group
is leaked.

Destroy it on these error paths.

Found by kselftest/iommu/iommufd_fail_nth

Fixes: bc7d12b91bd3 ("iommu: Implement reserved_regions iommu-group sysfs file")
Fixes: c52c72d3dee8 ("iommu: Add sysfs attribyte for domain type")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dd9b60897c8673..e41c9df1504ba3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -775,12 +775,16 @@ struct iommu_group *iommu_group_alloc(void)
 
 	ret = iommu_group_create_file(group,
 				      &iommu_group_attr_reserved_regions);
-	if (ret)
+	if (ret) {
+		kobject_put(group->devices_kobj);
 		return ERR_PTR(ret);
+	}
 
 	ret = iommu_group_create_file(group, &iommu_group_attr_type);
-	if (ret)
+	if (ret) {
+		kobject_put(group->devices_kobj);
 		return ERR_PTR(ret);
+	}
 
 	pr_debug("Allocated group %d\n", group->id);
 

base-commit: c643eb52cb7c1f6747ddc60d8a187a3ca0746a12
-- 
2.39.1

