Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956D721FF59
	for <iommu@lists.linux.dev>; Mon,  9 Jun 2025 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499121; cv=fail; b=HiFwduBsxGqddpsDD+4yE3e4uMMWn94MK9SiBzvEHihOV/GUBeRO5jkjIqEA4YozPmys8UjYFn2xt7UtjNnkKlZVjY6v2pDoTpycDW3cxPl9DLkUeATDuWD39ZaRn7O5n+nvC7pr/7V/TaqqDxi1/wNMQWxP25rDsW8UQnnUyRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499121; c=relaxed/simple;
	bh=I0T3sXx0mO/rhLh6vPjKp7DlRw7djKSXfA/3b1N0ue0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pY3hUq+o/66qsiNLOk9DaaxXsXyiU4DzXN/1qyxIiwbrmG8vOetRP7Tl7WRbH6xERIFqZSZBOke6F4o95dkFE4/Pdm7irijXXfpXrQK3hS616Yvzj4Gq+CTZF6fnW+KvZAQKxZUrWqdHZNhLPSMhpSuCJLdmnlcpl9Qh2CScd3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bI60P5Nz; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bI60P5Nz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnhDIoaQMsrJg7BNpPiEo+Qk6BkKkus5mkgx1YEZWQ+oqsMoEwMuONY6JibZ3GI9p4P9mss/VMhmHhmoXU12vKbK1ujJMdZF0tI5/OzNBx8BCJCzocu3pwoj4n/OUK32DRc+fQMuwV0Dx0ECi0wOlkhMc0v17NcD0buucvF3nQ2tMyvFDeZbRu68BFjoHVJl0OFtuU8004RLs+0T3h8oCT6Kcp1PLifwbEX6F7bL6eizie76e3SF7MSz3yS/7yI8zRqDDd28aPDHoEiRGN68A+odhTWf/liSrHgjFKI+frDOuN9faE7GKs0UwMyxLNNkuCGKq3EjcEEFummdydtEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJHEgYmesB5hW3J8MyUIjUqx0De4o4mEJaG0LfYUdRA=;
 b=K/JCehlCYSF0DbnOikxozmWHSq37F2wb3/VJzYA8OS3zYtxKwb9I3Tn159rCoMnZQYrZaIgCkdPKMfFe6M+pB8OeH9Gx8Wpm2fvaS0kEEkrxEXkLkHQuigzxP+JQ7U4rt0JJInR2UyJA7La5AGc1qsQtjrnEcWu65w9dnVJLFSCSeH9fbkRV7ijBp1wJNHaF6I4D3zcKbfZg6oeEg9f/UMRBL2cT+nfQEVPLtcaD5kv4kNR9ZlouIun8HQaBI7+Ss6GTC15/DrMIVttZLngsGRX4Mj8PH83qif52KfjDjbmaFBNCuvT8e12yKlW2MRPWOXuDQOgs1eNlzC16LjUUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJHEgYmesB5hW3J8MyUIjUqx0De4o4mEJaG0LfYUdRA=;
 b=bI60P5NzAg7FyPsKsEWXJJGmGilFhs/TG6arIitfpYpPhis8scHdcOAB9cC+laIdoFI/x9JnqPMKVoUWjANInyfk/XZWxWcWYaa5KXN8S9TNjDietoAjxw9T+JPyxfei6WkQRpMX9hbrdXSumqhHIDFaWCeTpgJBImr4zGcbStnYnjQbZCAShnpMvwCa3HgHE6Ym5Z53yzGvTt3pbK1XfQEHSt3fo+IvSkOETEiuZuNwZr1DyH8zC3vefJa1AEFNbk/Q5njd1v15KY6LP0P63aNnZzbeNituKn7ra2/DNY9Pk3AZtTF0U5I0LEOS2RI4hSqRlFGaUZVr+2jLwK4oag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Mon, 9 Jun
 2025 19:58:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Mon, 9 Jun 2025
 19:58:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: patches@lists.linux.dev,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH 4/7] iommu/vtd: Split intel_iommu_domain_alloc_paging_flags()
Date: Mon,  9 Jun 2025 16:58:23 -0300
Message-ID: <4-v1-20c73f153f4c+1895-vtd_prep_jgg@nvidia.com>
In-Reply-To: <0-v1-20c73f153f4c+1895-vtd_prep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:208:32f::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f33221-5659-4577-ee5a-08dda790002f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sJY5Cpxr6WsW7HmCQXqgImeiSNCwzzpC7iJHx59XxVyKGcxAhrKNyBCsV2Ih?=
 =?us-ascii?Q?ZrQDGcnPISYmMDRbNutIy7FFJW8sJigwAbXo04A0qQGJmwghPo2AShqCgxob?=
 =?us-ascii?Q?njzFanb4da8CyxWdcO9ourqXArVX0LJbfJNgwWzGl2YTP/59bYKEErdlQ1dJ?=
 =?us-ascii?Q?3g233ZDGEcfF7jLgq5b9j+lPB0zmGRIeoxOg8AMaeK43uGLu0u+0/iNj0A0m?=
 =?us-ascii?Q?wXb3DN6o0Zff4wX+iXbNlGJghotx5HT+Wu/me78UiDB2jvgMMzoGJ+Wf0hYr?=
 =?us-ascii?Q?0KHJmAtBzyuf61ukzSwSCAZJRR4YO7DjfbPV0JUQ8YaKQfuoxRCkVDLRzKeS?=
 =?us-ascii?Q?SUKVKcTq2wAS1o+ye08K7XRfPV0l0+8KQRDs5uTlDJ9IFfvKH9qtDlP8v062?=
 =?us-ascii?Q?BdfgIngJbEbBcObaHH9IGRHlKa7kcdzPqqjzilA3az9Rfsq4c8tEQJBzC4Zb?=
 =?us-ascii?Q?I34jUJc1DiTxLUJzj5auPdckbgCq2tL0x8BNMLgXTbZWKBFS+oG9zgfw5nJ3?=
 =?us-ascii?Q?znHXwhqZ49KPf0QOPxvWcmZUg7+fo5DM5zLGF87pXmwjuC7XcGIMQANlUQMe?=
 =?us-ascii?Q?48Kpsq2CIKfAIT9exuWjH+xitJBF80VM3TcFs49L+oAqQaFGK6zOiCWYWB5i?=
 =?us-ascii?Q?qAARu+3RnVxLz3Qpv7WqDnqWsjHYKoeamb3c/I+k/N+D9iHLI8wCI76p8BWb?=
 =?us-ascii?Q?TQU/88Fik+oPgbIJCYWT2xvUqL2YzZ/kTDaNoRPW1mh0YmxswyhD4CJLtxbe?=
 =?us-ascii?Q?7YuGz8X2ulqNOYxGGyTtyyIdqHmE8Kpsn2Z6/fqgUeTNgF2SDcea1COoMJxN?=
 =?us-ascii?Q?REC0mIg7JvIooLejoR0tjt27n5MLIK5g7drwlMj2D3WjHHkM89mFbXP4dikd?=
 =?us-ascii?Q?z80khe9nCxjbKSUwXqDq4IDXDpP2NlSHYMRKC5SYHLN8+TA2w8QPXUkOhpKc?=
 =?us-ascii?Q?FUChf8RbYwRpmwTPP9br+wUIv8gdAu+5DHJHNtwCRvca7HQJjl/psMpPaSfW?=
 =?us-ascii?Q?OVTA6BF2qN/2QNbgupNnIXfBFly20Us3VZh08Mn/Ttjo5vyVO4FPoHKKqclg?=
 =?us-ascii?Q?0Q1sO1Q2GThCSDziytOBbi/lLFgeJkIB8jkhpcJe2HCUj8xfh0VN80Fjnas4?=
 =?us-ascii?Q?+coFFcTs4LJZWSAqC/l3qTP6tSjPSMgz0P8EaL140zxO82g8mONJ7UOPaNlU?=
 =?us-ascii?Q?Rj6b7wZFrCWhBLEAw4p+Cw3CRe4k3aapwr4Zbmrl3b92/23qnbPUW5BoK/dx?=
 =?us-ascii?Q?k5ES1nrfDufPsZsPjShTQcHA1Ng9H5s3tN2/lu3xjgdue3Cb1Z40ebXodkcX?=
 =?us-ascii?Q?zcl3M9wVb2BNuGVXbnpihD/M6Tq60FTzCnvjKpAtwfk06BU8ryZemoVu6iFm?=
 =?us-ascii?Q?EHlKbbNg1+AH9OG0wK1kiRrfLghcT1Vuq7JV+zbXwXj+s7BchhaHJQwNq1Yl?=
 =?us-ascii?Q?VQAcJEeq3OA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?olGjHlP9BieMMFMp4bLdVHLyBMBgUGF2C99V/R8CJ9oTB+RT1hn9HULZunjE?=
 =?us-ascii?Q?WT4pJtHymKVkbshSf30WmqQTYlXW/b07ZfNP/qQokATr8M5ZGG6L7zjnIpGd?=
 =?us-ascii?Q?rcXDXRlTcysht4FLPVjIOIDnIDbUrTv9Nip4X6BtiatQO5bSHt5ifgfGohQG?=
 =?us-ascii?Q?Domr4uoNUWa2zNS1eLn8HQ+KbRb8k4sK2mUilwbAXSCdnAaaUFnEguqFiBLc?=
 =?us-ascii?Q?ZgQjm9jiwDXneLUoClzOZGD8q0UL2PL0fZ0kRiTwDbsMmF9fHeB8uRYq3iyT?=
 =?us-ascii?Q?e+D90mVpbMx5+61gjUCMX61S90jSXdw8EXajSXlgYwgzOpjzilzT5b+0iYaF?=
 =?us-ascii?Q?GzEO6QRvfsdPRgho0MwuCHc57w4k/VufI1U07Pt2mWEPpH/W8tN2uk3kbNIU?=
 =?us-ascii?Q?cjxCwOG04ufQclsyE9vT7/sbCwhv3jZ18p5UTOC5gfB2gzdGcLgzDlYxaxH8?=
 =?us-ascii?Q?QiJa4qJzm2R6tkVmIg8Ch7cmmAmGw357Wq2SdSIr4HWPl9ytwTjzFm4viGM7?=
 =?us-ascii?Q?sbV38OYv3+X9bFcqyURHkbiZa9bH7byU2WMR/oFKpe4ZTq7FlP/Cmmrdv5mO?=
 =?us-ascii?Q?7rkjIAeZJLedOgNYkWnJTlBgWGXor9ww4NpM9FmPNC3xilTni1nBOQQcnJEq?=
 =?us-ascii?Q?fKqs5obDx8KE4Bnq4HnyhogGoredUIFkLwg5dMCyMtdywjgAB37PXI8t+l56?=
 =?us-ascii?Q?SbuM8nB2jBVfvO+XR+v1PLqLvFonBZKo7tP252UhUAQ70ddC/50Qj/PyAhqd?=
 =?us-ascii?Q?aRoB/qmTCO1HP5obEpCEGsaoCuKLrsOZ6b9bYqSdb5N2JgIPv1lPRLtnuCDj?=
 =?us-ascii?Q?2TLoI056XzmBXg14A2jgmgp/zT6VQe2QtEY8+JOEvdefE81Qo54r9BTbOQtH?=
 =?us-ascii?Q?U9ravbLzK8rYaba7k+71gZhdHfZRHCDAYvk2Q0Z6YxVvdvGw7xU/ROEBk5Mf?=
 =?us-ascii?Q?vOLbMpfe7Ck805JFfYHtELOwH5DqKeypCUkNg1mJ90MHORIEeq4JfrynaotP?=
 =?us-ascii?Q?6lXihWKHq+BGOA68Ce1ouuNxtXeKnXyvyJMU0LgJ5ET3m1RMPFCkG91zmYvd?=
 =?us-ascii?Q?NE4kfC6jpkhvLcEIfmDKs/eG9S1KhHSHrq2KXaDoCXwZggtNPg2E8IumG9x9?=
 =?us-ascii?Q?XEmv9wzVX72pO+s7PowGOLBnXY7/+cPq+yknIDp0T7RhQ9/pAsZNDTCnzByG?=
 =?us-ascii?Q?8WrRoKRIekOkz8heywL/K+ha8AQn5hxlymDM8iUUuaVdqb9CmQKjc0TspsmF?=
 =?us-ascii?Q?0nL+HeQaBrMchGSBKLCsrdMT3sLgiK6Dix3enzA8vrOm0BQFrIyHSEtf8XIw?=
 =?us-ascii?Q?m4s+irR5Wixi8UlZk2OnlVxJGQLJuRBTyBeJDHbb/EYclkrDZYjo+nHEtTfA?=
 =?us-ascii?Q?bZj7KmoctxU/xNJDWdQiaQj6lf+95lNBwB9SiiAAtzDwJ2enhgc5Y0aVY9xG?=
 =?us-ascii?Q?pJZe5k2giINtaqihcLl5TBSexPNbmGekXRf7SgvyIr0Iv1F3iKfv5qiypABR?=
 =?us-ascii?Q?ribEo1S90KxtDkqLzcO3h51l/72KE1zm1eg5CGLu6vLrjyjqPrG5XxTf8RQL?=
 =?us-ascii?Q?z+i3aG7PcNM6HU17LTabISfE0zEH0lQse4tjRNjm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f33221-5659-4577-ee5a-08dda790002f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:58:27.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0W527TGBOHNXcoQ8gyhAW++m7QxpfZ6pQA0up/po423rbtcyGRIKg15FzLHX4V/6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802

Create stage specific functions that check the stage specific conditions
if each stage can be supported.

Have intel_iommu_domain_alloc_paging_flags() call both stages in sequence
until one does not return EOPNOTSUPP and prefer to use the first stage if
available and suitable for the requested flags.

Move second stage only operations like nested_parent and dirty_tracking
into the second stage function for clarity.

Move initialization of the iommu_domain members into paging_domain_alloc().

Drop initialization of domain->owner as the callers all do it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 98 +++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 72b0769c391008..6987a46c2e8421 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3267,10 +3267,15 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 	spin_lock_init(&domain->lock);
 	spin_lock_init(&domain->cache_lock);
 	xa_init(&domain->iommu_array);
+	INIT_LIST_HEAD(&domain->s1_domains);
+	spin_lock_init(&domain->s1_lock);
 
 	domain->nid = dev_to_node(dev);
 	domain->use_first_level = first_stage;
 
+	domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
+	domain->domain.ops = intel_iommu_ops.default_domain_ops;
+
 	/* calculate the address width */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
@@ -3312,62 +3317,73 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 }
 
 static struct iommu_domain *
-intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
-				      const struct iommu_user_data *user_data)
+intel_iommu_domain_alloc_first_stage(struct device *dev,
+				     struct intel_iommu *iommu, u32 flags)
+{
+	struct dmar_domain *dmar_domain;
+
+	if (flags & (~IOMMU_HWPT_ALLOC_PASID))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/* Only SL is available in legacy mode */
+	if (!sm_supported(iommu) || !ecap_flts(iommu->ecap))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	dmar_domain = paging_domain_alloc(dev, true);
+	if (IS_ERR(dmar_domain))
+		return ERR_CAST(dmar_domain);
+	return &dmar_domain->domain;
+}
+
+static struct iommu_domain *
+intel_iommu_domain_alloc_second_stage(struct device *dev,
+				      struct intel_iommu *iommu, u32 flags)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
-	bool nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
-	struct intel_iommu *iommu = info->iommu;
 	struct dmar_domain *dmar_domain;
-	struct iommu_domain *domain;
-	bool first_stage;
 
 	if (flags &
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
 	       IOMMU_HWPT_ALLOC_PASID)))
 		return ERR_PTR(-EOPNOTSUPP);
-	if (nested_parent && !nested_supported(iommu))
-		return ERR_PTR(-EOPNOTSUPP);
-	if (user_data || (dirty_tracking && !ssads_supported(iommu)))
+
+	if (((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
+	     !nested_supported(iommu)) ||
+	    ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
+	     !ssads_supported(iommu)))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	/*
-	 * Always allocate the guest compatible page table unless
-	 * IOMMU_HWPT_ALLOC_NEST_PARENT or IOMMU_HWPT_ALLOC_DIRTY_TRACKING
-	 * is specified.
-	 */
-	if (nested_parent || dirty_tracking) {
-		if (!sm_supported(iommu) || !ecap_slts(iommu->ecap))
-			return ERR_PTR(-EOPNOTSUPP);
-		first_stage = false;
-	} else {
-		first_stage = first_level_by_default(iommu);
-	}
+	/* Legacy mode always supports second stage */
+	if (sm_supported(iommu) && !ecap_slts(iommu->ecap))
+		return ERR_PTR(-EOPNOTSUPP);
 
-	dmar_domain = paging_domain_alloc(dev, first_stage);
+	dmar_domain = paging_domain_alloc(dev, false);
 	if (IS_ERR(dmar_domain))
 		return ERR_CAST(dmar_domain);
-	domain = &dmar_domain->domain;
-	domain->type = IOMMU_DOMAIN_UNMANAGED;
-	domain->owner = &intel_iommu_ops;
-	domain->ops = intel_iommu_ops.default_domain_ops;
 
-	if (nested_parent) {
-		dmar_domain->nested_parent = true;
-		INIT_LIST_HEAD(&dmar_domain->s1_domains);
-		spin_lock_init(&dmar_domain->s1_lock);
-	}
+	dmar_domain->nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 
-	if (dirty_tracking) {
-		if (dmar_domain->use_first_level) {
-			iommu_domain_free(domain);
-			return ERR_PTR(-EOPNOTSUPP);
-		}
-		domain->dirty_ops = &intel_dirty_ops;
-	}
+	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+		dmar_domain->domain.dirty_ops = &intel_dirty_ops;
 
-	return domain;
+	return &dmar_domain->domain;
+}
+
+static struct iommu_domain *
+intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
+				      const struct iommu_user_data *user_data)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct iommu_domain *domain;
+
+	if (user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/* Prefer fist stage if possible by default. */
+	domain = intel_iommu_domain_alloc_first_stage(dev, iommu, flags);
+	if (domain != ERR_PTR(-EOPNOTSUPP))
+		return domain;
+	return intel_iommu_domain_alloc_second_stage(dev, iommu, flags);
 }
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
-- 
2.43.0

