Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA57611C;
	Wed, 12 Apr 2023 13:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqD6NBfcdVhL9kR9/EHafmJpy/9f4W6zatsa2eIMXvxwzfjdrWi8pOF79RNw+VBI5cV+DxcpKGKQOhCvwoAg69Uyc9VrtCf1m/Aax7TId+EumrQ8JrWO1msAA7DPY3uqYj0hF3tDgGCF2mNfVYu6/WJoTHQiH5mnH5taezTd/T7qSXYthjL2sKPAHk0TMvHCa/Vv9u3qFTMuPfuUkhRh84xH6YdEHMBvCnjxngnrqvaU6AExgmhc5bcZLQhDpCaX/uTkft2i3GeN6AjzcQiS2nBrvpljOSMHzYgx0AKQ5Ho3seNioNQrR38xKXpUNR54IMjteM3ac3cd3LSosOqg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YJbaXXmYgIPbGOvrlCBPDVzxmGu7bbfqqWxiM8zNGk=;
 b=jr/X6UkO0MC28wl5aTjkhyB0e7vdL/k3Z2LYe5vGtau1SNlAuXQ3EvPXpxoPU/IawKpV9vBZ3H9pkCLQtK0CFhXftkKCHU3Xz7b4b4WrdqrXweyxCk6ggK4J0WUcw9Apr+1COm5s2JDjd3jDwEAZ7FDuiLStrpdqQ9EKH04Sawr3sNwPqFzSK7hX7hwQFdZ/UEmI1a/WIXZpGt4Mg41ztQVRqGihcDbVFLIb56nSmDCBTptnwkVmCEeKpYK115XezUd8O/S7iOM7k/RP9kSMwQJpOV64WohFXtCHYAz27plj44kmGwj3cdOiOn23pCZd806vwqRBzVnr/K75sf5uCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YJbaXXmYgIPbGOvrlCBPDVzxmGu7bbfqqWxiM8zNGk=;
 b=OWANv/EDS1REuuV+q1ApgLvP8Iz6pYrgxmI7oyI0ax9ciF0EwyFrIJJKM+rbIFK1/ydDoioAvSjDKWbe7sHv6JR+WQ2z7H7oeg+S/7tAgEL0XBqVnxmon4SxiFU675+FOL70X6mZetYm9apQhTdcsTi62MCVa4A7XMtaKwTrwv30YCMM2feYaHOFEYbiePl8uiW7dSlOpIKsRiGrB6v4EHK5TgqzbR06fpfDyGS97wY1LcK0Qbmqyo7xnU7JBz9gxBFoT8yX2XUvacTchrPQFjqEbxGpbcxFESkDJlMWB6J32GWD80SpueHMOAOC/aqHYCV/xmKg9NACDkNgddPddA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 13:51:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:56 +0000
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
Subject: [PATCH v4 09/17] iommu: Fix iommu_probe_device() to attach the right domain
Date: Wed, 12 Apr 2023 10:51:39 -0300
Message-Id: <9-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:207:3d::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 9700d52c-bb5b-4085-63a3-08db3b5d1034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AVAcrj5p1AIoYPHg+Dw+GcfVIpFm51F3Nxv4Rb1QJ5R18ybmvqw84s09j2qeS1MXCkzymF9ajPL2iyp6/NQ5hOb+IR+H1sNn0xOai7PE8xPlFe+MCHJKbVcHAUpPsibuQdDOD0Y7rNYbUAs88OUK+IUeaXZ5iyv/FSfuy+EYYT96kTpJkITH6ckeAwQMNMSB6APXCR3Um4ISK3+FBkHLYQPphAg7eDNX/aHkhLdqhJoNQh6eMTSdYjUboR+b/hTfpzCuQ6B38UD3430N7C8xBrgD3PDYBU2luBMELJQrabxYs9kix07z3OQcxb0cKHT84fCEqxu/Z5uIB3BRotLIAo4Jc2FCt4YuxQ3N90IXFyOd3ho/jvkHMvMXb5s1emXiE1b9cVCK3YWm7bcniEA3lAA+Ud/8BED2v1bmygxUZH8sxtiffBeSgU05iW+0EoaEHerTp+GGK6K7U6L2uWQnI1vI8obe2bTh7MD0H8v5uwXg1GweTWGZyUS6tgr2n+18LuAsDAzNjXKMnMcrfizYSC0wwTkWDVNHfEUqRT1IvB+FhdmHhoSKHyMC2+uoimt4XKBJq9/rzUbmKs5z3WiVp3kVERCxeNwt1+G/HrXVDvE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(86362001)(36756003)(110136005)(316002)(54906003)(41300700001)(66476007)(478600001)(6486002)(4326008)(66556008)(66946007)(8676002)(5660300002)(2906002)(8936002)(7416002)(38100700002)(186003)(83380400001)(6666004)(6506007)(6512007)(107886003)(26005)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t76xO5CmYzvEAdZObsxkbSzmFwBvVjsuBFSyy5On9nHqOuYHH2ZTJUWcnchr?=
 =?us-ascii?Q?22nn55EyplFUlu3IL/9dATjai6UEgsWDZwmu3nqQhPGjD34KMgPR1P+TTD9L?=
 =?us-ascii?Q?LbvynigXB4m/0toByC+EZNWIGjV2jucNyOfoU0ptzsJuchTfaUgIy9TR8sx5?=
 =?us-ascii?Q?YEqb0glHgW8TQUXQzs+hnoW0La3k8lV7JsZ3z9VwJzsoQvff+LankwhsahL3?=
 =?us-ascii?Q?bKSeP04JEp73JIe0ADisSDR5JVEQryAaPIKAKLfRFmkL18lrpVGGFhgoX7zU?=
 =?us-ascii?Q?YpSeiDJc6C81gogjPA8F7OM7wAYc5U5kYSTLSiiBAT2QSfDo4BoLAdICCgvQ?=
 =?us-ascii?Q?E7V+AglEsJ4/CoiRz4N1ZSOotsrrBptJP55724WTsK0DtSlG35ag+FiuEDE/?=
 =?us-ascii?Q?VYbd0xZ4RIjZIcJ10ftfDNc0l9x4LrWIhXmzFa2WzEpOHpsNN9yE4pPlEgta?=
 =?us-ascii?Q?+W1H7pmlciuDilO74Gn2Xt71XZZ/lXXrmMfGRgUsPXupnTVMkO/nEboMJlCw?=
 =?us-ascii?Q?fjXvzEj3n/LGpwbDwuNFOwXB4rKk1qgFJwXqcYC4l6PIQdjVtD+E9Q1ySlMp?=
 =?us-ascii?Q?cIxrC6Br/537nbNPaNiFwK6GeDqeZT9sPrvNtBmNucIDz+qXpu5KzhTfe00D?=
 =?us-ascii?Q?EyLxBimw36FcqfAOPdVHdrimgTXZYbctjTkT1vnWOsH8RqbouTlg6IopX4SU?=
 =?us-ascii?Q?atSvEXb/LfWddxHFXsiGJaCH78VrQSjWoTOERUtbmwUiczQVCEAep+kGwTDk?=
 =?us-ascii?Q?ofeK/cyj2S7L91ZlnwVefLOmn6ruaIyuwLI9m2EBtVT2viuxqW9hhv+Y1gXO?=
 =?us-ascii?Q?ezQZy8jb5VI0GdEFI08nTJ2zaGdMMBsUrfISlmZ16B3jv33Lx9nYbyAuxPkL?=
 =?us-ascii?Q?PvtCr9uBYNQLAqnOmovFsC6DPX+gqbXJJpKu2dc4/9BZdqjzrMJICzI5ZNFU?=
 =?us-ascii?Q?/aHHP2Jce5MTXlLn92ZLqyPACARNT4GPAaS69vd7YK/S+UVIukVWFPzvCKB9?=
 =?us-ascii?Q?AmSOmCJOqBOSp8jAdqONfUaY/ebd2t6IZ6mVXMEm4T5JBG0Cv8QBXLShzs1o?=
 =?us-ascii?Q?3hrHaYLnWNFdghuqavPvx7JHM09WhWsQhyC0bda7ovFuTME6BF05xZ/b8isq?=
 =?us-ascii?Q?3tDyjEZ6MD8reuMutfAccitaW0qxIK1v+2YtbMcOYQrL7q7sDp05zfUlZsUu?=
 =?us-ascii?Q?uHpOUe3yd4iU0wh8jV2vC67VBiwfDcNgKeciTCx/o+TJygVYiML28WDK3oBc?=
 =?us-ascii?Q?eV1Pscmwcmuk2BIw8g8X0lD0WGLnJV01iJIUUJJyDYZwwPWLCPdgpr4pYf7A?=
 =?us-ascii?Q?JCLHaW3hLsd5q0FLWSj05+b3Hl0U9CqMcZ3Ym7XQNQFn5mi0GEhdsCCN56el?=
 =?us-ascii?Q?3j++NoIl8hgW42miDmq1ARapbixHQSNqnoBY6GEbsuiiUDmJenTbFMpBZIsb?=
 =?us-ascii?Q?Q1POSmDdTwu0qez9Wtgh5SRpuV2Tc5A8qvBZ2YbaCWJ8tczqDR8So/Yn1quu?=
 =?us-ascii?Q?X5VwS/yqQq8wCZI/ZVsX2hSP4CgjFuZI0Q6mUfS5bNf4I0bsvTuWPYc66cXF?=
 =?us-ascii?Q?r8ARMH7CgiDfNYRRPUpkfjQT2TEQH4Q2WfXERMnq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9700d52c-bb5b-4085-63a3-08db3b5d1034
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:49.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajRion8GwBw8K2mW6id0uE39wJFFp10ms291JeD8/b2PjAtmVqJLI6Hw4yyqozQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

The general invariant is that all devices in an iommu_group are attached
to group->domain. We missed some cases here where an owned group would not
get the device attached.

Rework this logic so it follows the default domain flow of the
bus_iommu_probe() - call iommu_alloc_default_domain(), then use
__iommu_group_set_domain_internal() to set up all the devices.

Finally always attach the device to the current domain if it is already
set.

This is an unlikely functional issue as iommufd uses iommu_attach_group().
It is possible to hot plug in a new group member, add a vfio driver to it
and then hot add it to an existing iommufd. In this case it is required
that the core code set the iommu_domain properly since iommufd won't call
iommu_attach_group() again.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 44 +++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 72c3a9c8e4751d..9076fbbb7d50cd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -416,27 +416,31 @@ int iommu_probe_device(struct device *dev)
 		goto err_release;
 	}
 
-	/*
-	 * Try to allocate a default domain - needs support from the
-	 * IOMMU driver. There are still some drivers which don't
-	 * support default domains, so the return value is not yet
-	 * checked.
-	 */
 	mutex_lock(&group->mutex);
-	iommu_alloc_default_domain(group, dev);
 
-	/*
-	 * If device joined an existing group which has been claimed, don't
-	 * attach the default domain.
-	 */
-	if (group->default_domain && !group->owner) {
+	if (group->domain) {
 		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
-		if (ret) {
-			mutex_unlock(&group->mutex);
-			iommu_group_put(group);
-			goto err_release;
-		}
+	} else if (!group->default_domain) {
+		/*
+		 * Try to allocate a default domain - needs support from the
+		 * IOMMU driver. There are still some drivers which don't
+		 * support default domains, so the return value is not yet
+		 * checked.
+		 */
+		iommu_alloc_default_domain(group, dev);
+		group->domain = NULL;
+		if (group->default_domain)
+			ret = __iommu_group_set_domain(group,
+						       group->default_domain);
+
+		/*
+		 * We assume that the iommu driver starts up the device in
+		 * 'set_platform_dma_ops' mode if it does not support default
+		 * domains.
+		 */
 	}
+	if (ret)
+		goto err_unlock;
 
 	iommu_create_device_direct_mappings(group, dev);
 
@@ -449,6 +453,9 @@ int iommu_probe_device(struct device *dev)
 
 	return 0;
 
+err_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
 err_release:
 	iommu_release_device(dev);
 
@@ -1689,9 +1696,6 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 {
 	unsigned int type;
 
-	if (group->default_domain)
-		return 0;
-
 	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
 
 	return iommu_group_alloc_default_domain(dev->bus, group, type);
-- 
2.40.0

