Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A119BA1
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QI20mDZN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrLhGm5lyi7uCMbVsy1n7LhqFrM8uy2N7rJiFhh+pCBGxoBHaYqg1vXunJZrjdJrI5wdJmCWXh09Xae8qQewz1kDcI9yjQo0sUEgalYNCIyh9JvZ6utI3JBXDT6SBAEy3Kq9NwmOiZxz0exqzn5A+l0i+XNBnrSPcVH2JzKdM0G8JpM247JJTOgsh+54wGUBUejnzKWLKy5Pgdaf/bSrMeaPDOzyOerW9atgYFxOEACotlgZgYuH3QiA8AJjNsIgFmlG68gdioEG1Q9kZkWxetX1vaMWc/ElCTEcpBHKpe4tAW5jL/QKXEbWF2UBNnYT63stoioq6QZCFzgX5nN4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP2Y4yHHj9K8d12fBw5YkhfhWX651gpby1CqDrr9TDY=;
 b=AUCtsxmRKtg2ZA8lpHVIvMrHeZ6zl4gvjt4H2/RR3+qqZtSapAEwI3ONITaQVn0KTiX94mwr7LE8K0of/26rczgnOz6hQ5PHjKf/hbaprHyOzIl5/iG0N0Iw2ZfML7p3GBKTIeb3Otaus5Z5Nl3LlE0/+v2fjaNMYFqiaINQBz3n12jbKtleMS+O8u2eLNTr492H5mACGKnfSc1QvrzCGXefwJIy6CYDhp5e40yewY1K+OxijhRjAf0k46640N4qliPvXCYzvqIr6QsqUc6glJI+SWjmmCWCdBRF9s9+hXWkDwPjdSwRZSnZY7PnysQ84IgUKLHQW97VudAtprqx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP2Y4yHHj9K8d12fBw5YkhfhWX651gpby1CqDrr9TDY=;
 b=QI20mDZNDuOcOimUoXf/uhanqh8BRHWc1OmMIVZ+QcKKMtIctANAvNSBvHL090V45nQkqzMr1PnuKvzCUH2/3t75ws+v2fqcRtsV9TjYft1IVkccwSZMFkaaOFv6mn6SuMoWPjJBF7KmEVDoPBR0D+CyJwJSXuO2CGdT0DldMJgkDRG+PPOhPhSmwYveIl7U9jqMWVo0Msbw9ZKXXjCb+jllDbLVJopg/aRIRgsvN4bg5xbWyMf4c0p5nypp9d6+HTSFHoxTidDsW4YvWLHdnrkf7O5v0CPQ3ggawMgQr9JelS9fbDibpQLrlJMLaZCWVtMAC05XfTfBOrTYMpnZpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 23:36:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 00/27] Update SMMUv3 to the modern iommu API (part 2/3)
Date: Wed,  1 Nov 2023 20:36:18 -0300
Message-ID: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:208:fc::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6aed2f-5427-438a-2197-08dbdb33694d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EzUknjCBRdRC+CzfNQ3TfGLFD/ji+U7O/QOwWXBTHLVG990WY6dRCZPbdRfIHawgE5S9cpL0EgPQBtAA1PPUiVCLHvi35P+ivgmQo+5hQWN3n55+rLYmRDP5pQOzMirIBWp/D2lQa9pqJUq1wZDHTRxHY3GdYdxKKcNOYhDOEMkR1ex7EZxZdQpi00yKmts9/yTlYN4EnsCRglbjUmr+mND2Hp8+ora7TBX31GmPfZYv2hYtiNenqRXKwXqDGQTaxsrQCz9N/bhfsTwd+Wk0YDJOezxk2mWuOVNg3BdkdOFh2UsYo8x/pysuhZLqnx3YhTgeu5N/FI3ZqiE9SU2D1EhZV5beUbn1MQeI1E85GKvRqujLGFZGtapfXz92fqvQ3ASTQHihkA0Put5MkCyKvsLoq9AaQYlBKco2AXZFm/mC6WdCQnVhq1T9ivH/F32HpElhjnlyd9hhJ6mALYH0DEUT21HWmdVbDIX1wL7hTsY4MEsLBdP0+FYAO3ov0ZIDbzslnGJjS+HGCz57RS8/gC0RqUQjNfBKdvntHS/Xo4oBFK1E/cv/HmZLageSoGWZlZZbcBlhPYQldiCi1zba36a87rtZK30DUicJTvnnh30kIs44CaYpmmyC9QAsJF5QoJ/Fc4s8tpDuo/ABqy7pQk9n0R7ZjUKGGYOn4gZSuUS+rnWEcZs1VZpX/SNeTIK+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4326008)(8936002)(83380400001)(66899024)(86362001)(15650500001)(2906002)(38100700002)(8676002)(36756003)(5660300002)(41300700001)(26005)(66946007)(6506007)(6512007)(966005)(478600001)(6486002)(6666004)(54906003)(66476007)(316002)(66556008)(110136005)(2616005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vtVaDtOZVSFOCbJhK0+3lu7WzLhtpisgIYbfnt6SWPFOk6s/v/M++0nBvawh?=
 =?us-ascii?Q?aWql69/1gmlXCQNyyoXSdiETep5e1CSL3/X9C6bQdXuEsJFJLEWOw36A9hsy?=
 =?us-ascii?Q?I7zxE2uUD8g0w/aev5TwY+7iLEVvheqWgV1Lu0L2BjlpcTVx+rSVBov2dwvw?=
 =?us-ascii?Q?AtGdZziV+/FXAN3NmdWXhuVidFAqvj/m0tJriUAdBoUsbpW/iDQP/yVsuaCf?=
 =?us-ascii?Q?QQqP9lgsr5QjrtzkuGowtWcLvUc8zBYmaNkzHQTEvOba+GXThEdOv8pCtZxy?=
 =?us-ascii?Q?9vGoxpTV6Q5vHJBfDkjwqHzMx/taCq7oN4eWp2zcwxVohYiEpSUFPS9Pn9tv?=
 =?us-ascii?Q?UOP7USmAnOaRm4r1LGOGoeqgywge6f7jo65tcuPMGWFfoP6vohjjZVlVWM+3?=
 =?us-ascii?Q?/bkFCXl/tizoZt32pIrlW9sgEUoaq63ggTHIntGHu452mckE1fKir1oscmDU?=
 =?us-ascii?Q?ALiYXk3I1GfX2MePgert+j/IvpgiGmZAn1kZ/0HYejlU8iNoMgVImNltoJvq?=
 =?us-ascii?Q?VmdyZ2PYH48lhgWr2RYb21ryPnl8a07CTogMaJo7gtyDoHbrH4BrMVu3XSDv?=
 =?us-ascii?Q?0Xe1IRZ3Rzz4wqzKWXEQYNJc51dMF5eKGRFq0LiAtwOi3I79bjalkqPdbyog?=
 =?us-ascii?Q?73sT/pemoNLkidbfLYAQWRFcfjDdOk0Qkh+fQh69ThnTO2GS3ZDO29wUiaHq?=
 =?us-ascii?Q?dSQilEjwbGQrwrNUDYRsgJfYVr+ilbNZaX8DNInfm4WE9n1T3DiCX6CCD7CU?=
 =?us-ascii?Q?rgEZhje/Obd3AYnIW+UHXwl0Xt8VIBMZ6QDOtedkbje2Zrg9xqJadXPzgw0w?=
 =?us-ascii?Q?FwnvT5HmfeRqCnnt7XFxhod1RKSEfLa6dj9huyTfIfMdVl+FF/1QcOuyNB2i?=
 =?us-ascii?Q?opAY12s9TRxm4H7QNmC5emRDegjcfNUNf9hUlw5KK2rVOqW/41hv7AunWA3k?=
 =?us-ascii?Q?XgGNSQTf/ZT0am+ipJ5Ava/pX6zJEYgfMYaAkhZ8ldchWxvogIWCV1hlQSqX?=
 =?us-ascii?Q?Li97HBQlbRRLd4jU8rNNDq3xxOUqdcBgIzofayEykEwa1kOR3AiJU5FWo7Jk?=
 =?us-ascii?Q?Ay8SN5xAz501kc994NZjTempYxRH6ajtwK4s60meMK8g25+gfU6U1++Ku2U5?=
 =?us-ascii?Q?awFufZyO5ScYYOeQ6aOhhB72Tia1dzwLkNicfRUn+FlMxGmJ6Lklnt4joM3f?=
 =?us-ascii?Q?28QKJQ10HJwKyz49iVafzm2iQdfQ8KxDEG0tMHRI7TSGe27agbbVI+WO5ZH4?=
 =?us-ascii?Q?cMtepIqNMxXFiJPSggjLwk/8QXtJuU6w+zSzzsddPKkZF3Fv2nkmmn35njBE?=
 =?us-ascii?Q?2t6aX2qHv5lFuRAbZAunf1sn3E9cCxmlvMFphexJRFNVnPX3Zj7o/Xz9WNuS?=
 =?us-ascii?Q?mr4aZVbX0Z1ERZRqgNpMHvjklzUndqjfponZu6UrEACQIlkk59fuTOA9oBmf?=
 =?us-ascii?Q?Pw5BS8gHzeYofDgl3CH4ao7vsjB1SzWQgdiedan8Sxwgjg3Akw3RwlROMYJE?=
 =?us-ascii?Q?pLuCMgogiwTZKAjEKQrdhuZAJ0H7PDZtXWFoTUtSSylJMCfXLxl28ZQNzkyH?=
 =?us-ascii?Q?r3DA1nJIwWBAo3OjLpKgiewuxat/UObxoYIZ9epW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6aed2f-5427-438a-2197-08dbdb33694d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:46.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yUXQjx4hdDZmmYYRno5rKB6k5Y+ZCnfucdvfnPLo9UI7GnZ5TU7S2I4qC4nXBbJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301

[part 2 had a fair enough set of changes to freshen it before people look at
it more deeply, I'll send fresh versions of everything after rc1. part 3 is on
the github now]

Continuing the work of part 1 this focuses on the CD, PASID and SVA
components:

 - attach_dev failure does not change the HW configuration.

 - Full PASID API support including:
    - S1/SVA domains attached to PASIDs
    - IDENTITY/BLOCKED/S1 attached to RID
    - Change of the RID domain while PASIDs are attached

 - Streamlined SVA support using the core infrastructure

 - Hitless, whenever possible, change between two domains

Making the CD programming work like the new STE programming allows
untangling some of the confusing SVA flows. From there the focus is on
building out the core infrastructure for dealing with PASID and CD
entries, then keeping track of unique SSID's for ATS invalidation.

The ATS ordering is generalized so that the PASID flow can use it and put
into a form where it is fully hitless, whenever possible. Care is taken to
ensure that ATC flushes are present after any change in translation.

Finally we simply kill the entire outdated SVA mmu_notifier implementation
in one shot and switch it over to the newly created generic PASID & CD
code. This avoids the messy and confusing approach of trying to
incrementally untangle this in place. The new code is small and simple
enough this is much better than trying to figure out  fixes.

Once SVA is resting on the right CD code it is straightforward to make the
PASID interface functionally complete.

This depends on part 1

The SVA change requires Tina's series:

https://lore.kernel.org/linux-iommu/20231027000525.1278806-1-tina.zhang@intel.com/

(Although if you have only a single SVA device it is not necessary to
test)

It achieves the same goals as the several series from Michael and the S1DSS
series from Nicolin that were trying to improve portions of the API.

This is on github: https://github.com/jgunthorpe/linux/commits/smmuv3_newapi

v2:
 - Rebased on iommmufd + Joerg's tree
 - Use sid_smmu_domain consistently to refer to the domain attached to the
   device (eg the PCIe RID)
 - Rework how arm_smmu_attach_*() and callers flow to be more careful
   about ordering around ATC invalidation. The ATC must be invalidated
   after it is impossible to establish stale entires.
 - ATS disable is now entirely part of arm_smmu_attach_dev_ste(), which is
   the only STE type that ever disables ATS.
 - Remove the 'existing_master_domain' optimization, the code is
   functionally fine without it.
 - Whitespace, spelling, and checkpatch related items
 - Fixed wrong value stored in the xa for the BTM flows
 - Use pasid more consistently instead of id
v1: https://lore.kernel.org/r/0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com

Jason Gunthorpe (27):
  iommu/arm-smmu-v3: Check that the RID domain is S1 in SVA
  iommu/arm-smmu-v3: Do not allow a SVA domain to be set on the wrong
    PASID
  iommu/arm-smmu-v3: Do not ATC invalidate the entire domain
  iommu/arm-smmu-v3: Add a type for the CD entry
  iommu/arm-smmu-v3: Make CD programming use arm_smmu_write_entry_step()
  iommu/arm-smmu-v3: Consolidate clearing a CD table entry
  iommu/arm-smmu-v3: Move the CD generation for S1 domains into a
    function
  iommu/arm-smmu-v3: Move allocation of the cdtable into
    arm_smmu_get_cd_ptr()
  iommu/arm-smmu-v3: Allocate the CD table entry in advance
  iommu/arm-smmu-v3: Move the CD generation for SVA into a function
  iommu/arm-smmu-v3: Lift CD programming out of the SVA notifier code
  iommu/arm-smmu-v3: Build the whole CD in arm_smmu_make_s1_cd()
  iommu/arm-smmu-v3: Make smmu_domain->devices into an allocated list
  iommu/arm-smmu-v3: Make changing domains be hitless for ATS
  iommu/arm-smmu-v3: Add ssid to struct arm_smmu_master_domain
  iommu/arm-smmu-v3: Keep track of valid CD entries in the cd_table
  iommu/arm-smmu-v3: Thread SSID through the arm_smmu_attach_*()
    interface
  iommu/arm-smmu-v3: Make SVA allocate a normal arm_smmu_domain
  iommu/arm-smmu-v3: Keep track of arm_smmu_master_domain for SVA
  iommu: Add ops->domain_alloc_sva()
  iommu/arm-smmu-v3: Put the SVA mmu notifier in the smmu_domain
  iommu/arm-smmu-v3: Consolidate freeing the ASID/VMID
  iommu/arm-smmu-v3: Move the arm_smmu_asid_xa to per-smmu like vmid
  iommu/arm-smmu-v3: Bring back SVA BTM support
  iommu/arm-smmu-v3: Allow IDENTITY/BLOCKED to be set while PASID is
    used
  iommu/arm-smmu-v3: Allow a PASID to be set when RID is
    IDENTITY/BLOCKED
  iommu/arm-smmu-v3: Allow setting a S1 domain to a PASID

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 604 ++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 837 +++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  94 +-
 drivers/iommu/iommu-sva.c                     |   4 +-
 drivers/iommu/iommu.c                         |  12 +-
 include/linux/iommu.h                         |   3 +
 6 files changed, 875 insertions(+), 679 deletions(-)


base-commit: 7c78f62b6a468ff2160a1a8ae725eb295ba7ec24
-- 
2.42.0

