Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC91E51F;
	Thu, 11 May 2023 04:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyAMBa2egyWleIe0YVfbvGeOKJczLQd6njIfdZ23k+siHJYEuda/vOItXVQTgPGPQMCSY8UG2SfF2QxV3a6urnkCdKiJyH8tArsgpQcDyjTD/5X5hdf3JzLc07TGE+pRJ6Ot6GMTt1f7ys7jDue+IxI3FAMj9VtUg7fku5gSi/q1hEn+oAx3FXzYsUgzcq4PYoVquV44sRPOL2oQQZA7Kf/T0mqJtEPzOj0H0+uSIREHDKFjftXxJMvetT1Vk01CZNgUSWVbPd3fpzKapeBmyJ/0Y1GAGzNcXtoPGBoccupgzPT4EZUPBe2V2tjIvvn/rNisuhpcmyxNTqPFGEb3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVvJ0ct5tRjPN+GtHfdxo6FCNAcst72uTCr+D68j2BA=;
 b=ZUyjxEAE+4L3yqia8d+70LTNqGya5NCiLOPgF5r+OmNqGBC9HCjEtXrIecomemsh8C4906VkeyK8qmmQCwjYX+QlHHsf5EVM/zcVxI2x5nHQEM1ceMk5vPL4O7QW1Mm+nks6YXCoqoJoewkogHhtxhDyRYsmm6vZt2UsybUDopYR3DarCjdYxAiknPm4T474J/aeoCLyp8ItwebFlBCI1O3Nj1/dIP1+k3PsQC8rq0L6CwCpOMJD2a+NAiUdoWSv6ogTHqTA88YCLUJIjN1Mc4l2tWQaHXImy59gxgXsFAd1TuaKDxCwLYGJgrvteKuNYzpxQhRM6NQZKkOxhZdmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVvJ0ct5tRjPN+GtHfdxo6FCNAcst72uTCr+D68j2BA=;
 b=rPS2umHTZQNG6/KV4E9ZWHetuulnO/Bc6rgXGh+TiYlV90asJPngpt8apTV3x2X5vYfqBiMi/+cXWXxkIhQFMY4vWkCx4mKSDAQ/EsRPjBeHsWCLjh05Vfs7YMA4XGVuaGrI9tFoSL/wdp9iIZi6uMI9AMRDOd7rcBEmt3t9fhtGhjVoRvhCQZPocTlTkiwz5ptHqllOXUcCkkFlQTfuAIprIMn3B5amdsFrxatnB66zH1J2p85IptLvBPzFToXPf4gNhEO0Oa1xbzr9Y0gjclFjvbrutf4pEs/6n/p5zufGOCcNeIYmTR1NzXJVC83qY+z4c3zT8KL0JyKBAZY2Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:26 +0000
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
Subject: [PATCH v5 00/17] Consolidate the error handling around device attachment
Date: Thu, 11 May 2023 01:41:58 -0300
Message-Id: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0128.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 98077b20-2acd-49b7-7d0b-08db51da1b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qm7mueq0RFJ3zaP/l1FIiVtXWEmjVOmsMyrgAmH0cJ93b8GAtE8FJjPumuYbEqsXo6/xYkO59Is0wUlqpryohHGRHI2nYnKLCAUSiyBRdQh5LTZjA0N9c5UeMNvGkhGaHqdDxJG56x5FKUkD05qqGVgG/Z3RfmfZJ6Unfg9l95o4n6HQ5Ype0LnXo8L7sbuCHZ0otzwaCO1RADC+ejFHm9Rvrnui5X4lBgaIT/ccI4rvZj0rJ4atNskpogvFnHc4zN23h9wTJwUxym51673QorA3BgznYP2/ZrIEi2bXK6hRA1EBo88LxcHrRW5aZa9WRWRTO/+c5lQ7PRhuMlRHIi3aU4nJZGkU/11rLC0jqu1xybRpH2I0BhfSy5WBRnf4L5jNS2nAPL/fBbVvbpuH/hEhPGx/x35n14TiwSP/a34U7iq7A7BKQ3wMnz5OBC3QfSiSMtF9MFZH3xrEJUvSa9U+69gou0TRvEx6jFi+sj0pe5zi2aN6MR7BJP8wMAmLulZrYS8Qy7J3z2dy1U/aiJuvWmHHu+FUqypDq4D8tWtmyrlQIHHfK9q/ROKSWdL1JctrdyviMTGp2iiQ2g+Cc7IJjCYS1DewbztLNaCbb5yLwqsze0giIRAx+dns2gdaeHUwlwLJB7cJKYiy76+dPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(966005)(6486002)(6666004)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?flWzVSJTcc66GKtSOKwqjYX2BeJZwB8kKpa1i103B2W9IzHrA13NtYNIFiY6?=
 =?us-ascii?Q?R1TBTabcU95D7TKwqnmPQ1oq3S4cVpTD0IrU/+5jbbeEL7Vqqo3vGzaaTxS3?=
 =?us-ascii?Q?MFJoHBdsKmRz4c6ETLBNH8O1wKg1foxldH0Q83hF8LqY7e1Br+hLf8NcGrSj?=
 =?us-ascii?Q?1TK0nXJMYEtBRcLa6zBmQqp7W00YbLtAbBa/ENuw+tMI9z6Ry6js7bABvrQy?=
 =?us-ascii?Q?rUjxPX8oA30P+31TEYbWYl8WB/EyqXTzS73bff0EzC/S5HkHLnACkbc7jdUa?=
 =?us-ascii?Q?1q/DR1K676Ekhb128WJy+je5ZA0nT29i9tRwPp8UPQ/Y2Kvtjt0XmETGsa/P?=
 =?us-ascii?Q?BXRjDFOc/MukKQ9SnvbiaPUU9lbosikrz04gGZHs1NShSJXKnk1jtfh50Me9?=
 =?us-ascii?Q?OzJt/2zDoaX9svyn6dqhwpz5uaFCB2ZVNEr8EqCsKaHKfLkaiAEBgAJWHBiI?=
 =?us-ascii?Q?6ad0hTWm+SU5LL9DdB4Fv0K4QYCe5UlHGwTU9EkoD0BDGz7EHWZ3F3oznk0n?=
 =?us-ascii?Q?xMy6eD/dGXJvvVChBVFOYr1tr6M47i45+5LJjKsralui6imZ1DFq38mcx5lF?=
 =?us-ascii?Q?YTm3liDqpJWGwWeqDgT/rdGdxpQBcGoNfafYJ5lHpw3azUEmWJbDTd0Dc+cW?=
 =?us-ascii?Q?l0O58P/y3LUv/LSiBNd6ZcLiX0Eigc37rsDYcTqedev+A/UrW33pB+26lHW1?=
 =?us-ascii?Q?sU+HbXTdlv+9aPps30WOfvsG75Ht4Oh7bdnngfOmojdPTJvn0tnVZqIgH5Ez?=
 =?us-ascii?Q?MZEg5f+8WOmzx5QoDt89M5M4Tn9SEelHkj0/cMFsevhMMfDecIULD6ACnucC?=
 =?us-ascii?Q?qV5qUYPq+d7dsthbZcRC63Ur07/sYTF7ZIf76Hl1kMc1QYg4y6vvsRDpxEoz?=
 =?us-ascii?Q?3zAGtItGN4lpQMPNzblDS8JlB2nw+C/3foJ/wGs8bmmMOZLNcDDIVXk4I//J?=
 =?us-ascii?Q?OpKwnsLU7Lf5JQ0UgxFtgZg7Ewoxz5dxthL2/h3HxPLF6ml/71dkNh4dmwqq?=
 =?us-ascii?Q?ddtrom7sYTp5jR51JTSJY/PtD7FdG/O+/+SQdcLRO03DDrgZSJH4A6R/YDCt?=
 =?us-ascii?Q?uHsJqXZCzU35hGN01fon3Qp1KmLGiyP3xma7kLZNiD+z8c0TqORwzhJZuXzA?=
 =?us-ascii?Q?gTA6x2dtEFiLWzficxHc30II4hxPF5yC/B10IOfFKwRG2kbYnxGI+ak3tBQS?=
 =?us-ascii?Q?+A7vjLeUdpHLHbWi9kLx3ahop+8JVMQtjPPtmySNPIhiLhpcjjY+KhNf4iU2?=
 =?us-ascii?Q?faMNISz0tQXIlT6N7Dy6zJbOZQLvOK20JBN5bMjHVdZJ2cCCP/KMpJNk2dTn?=
 =?us-ascii?Q?pcfiby67pgsIDnuZxmUPhJ18NM7ogY5mBm9t/JXJCtndiQSP1Pd97yeATkUC?=
 =?us-ascii?Q?gmltm55Uyl0fStZtaYvfEF7Mp0TAckFd64zDPBbc8uHUsKgXwRnchK/ldIR1?=
 =?us-ascii?Q?iBPR9zicZMDHbqA+lcXW1sBXGbwX3Kk8Nm92QBukDZ+rMSCo5mCaN8EnKl6o?=
 =?us-ascii?Q?gH6CBaafjvZO67jWwOcTUZ41pL3zrqVttupe/gMGHNsVkSeswU06V3ocFbRK?=
 =?us-ascii?Q?yt2FC1aGHOrGF/yIF32f5jsh4bWaivI4DzFzfR3N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98077b20-2acd-49b7-7d0b-08db51da1b27
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:20.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjuV/IzGogTOiOBQHJ01wiRkCW9GtyKcYVr0fvQ3I9Xoxt8ISzFrlbV1vkGiis3M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

Device attachment has a bunch of different flows open coded in different
ways throughout the code.

One of the things that became apparently recently is that error handling
is important and we do need to consistently treat errors during attach and
have some strategy to unwind back to a safe state.

Implement a single algorithm for this in one function. It will call each
device's attach, if it fails it will try to go back to the prior domain or
as a contingency against a UAF crash try to go to a blocking domain.

As part of this we consolidate how the default domain is created and
attached as well into one place with a consistent flow.

The new worker functions are called __iommu_device_set_domain() and
__iommu_group_set_domain_internal(), each has sensible error handling
internally. At the end __iommu_group_set_domain_internal() is the only
function that stores to group->domain, and must be called to change this
value.

Some flags tell the intent of the caller, if the caller cannot accept a
failure, or if the caller is a first attach and wants to do the deferred
logic.

Several of the confusing workflows where we store things in group->domain
or group->default_domain before they are fully setup are removed.

This has a followup series that does a similar de-duplication to the probe
path:

https://github.com/jgunthorpe/linux/commits/iommu_err_unwind

v5:
 - Print a warning if iommu_create_device_direct_mappings() fails the
   first time. Fail probe() if it fails the second time
 - Update comments
 - Rebase to v6.4-rc1
 - Tested-by's for ARM32, ARM64, S390
v4: https://lore.kernel.org/r/0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com
 - Update comments and commit messages
 - New patch "Remove iommu_group_do_dma_first_attach() from iommu_group_add_device()"
 - Redo "Replace __iommu_group_dma_first_attach() with set_domain"
   to avoid the flag
 - Drop "Make iommu_group_do_dma_first_attach() work with owned groups"
   since the fix happens implicitly now
 - Use __iommu_group_set_domain() instead of
   __iommu_group_set_domain_internal() in most places
 - Make sure iommu_create_device_direct_mappings() is always called to
   update the default domain, even if the current attached domain is not
   the default domain
 - Make the error case for inconsistent iommu_get_def_domain_type()'s
   always use iommu_def_domain_type
 - Handle errrors for the first default domain attach more cleanly
v3: https://lore.kernel.org/r/0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com
 - New patch to do iommu_group_create_direct_mappings() before
   attach on the hotplug path based on Lu and Robin's remarks
 - Fix to return 0 if the group has conflicting default domain types like
   the original code
 - Put iommu_group_create_direct_mappings() before attach in setup_domains
 - Split up the alloc changes from the setup_domain patch to their own
   patch, implement Robin's point about how the iommu_def_domain_type should
   work
 - New patch to optionally do iommu_group_create_direct_mappings() after
   attach
 - Reword the setup_domain patch's commit message
v2: https://lore.kernel.org/r/0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com
 - New patch to remove iommu_group_device_count()
 - New patch to add a for_each helper: for_each_group_device()
 - Rebase on Joerg's tree
 - IOMMU_SET_DOMAIN_MUST_SUCCEED instead of true
 - Split patch to fix owned groups during first attach
 - Change iommu_create_device_direct_mappings to accept a domain not a
   group
 - Significantly revise the "iommu: Consolidate the default_domain setup to
   one function" patch to de-duplicate the domain type calculation logic
   too
 - New patch to clean the flow inside iommu_group_store_type()
v1: https://lore.kernel.org/r/0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com

Jason Gunthorpe (17):
  iommu: Replace iommu_group_device_count() with list_count_nodes()
  iommu: Add for_each_group_device()
  iommu: Make __iommu_group_set_domain() handle error unwind
  iommu: Use __iommu_group_set_domain() for __iommu_attach_group()
  iommu: Use __iommu_group_set_domain() in iommu_change_dev_def_domain()
  iommu: Replace __iommu_group_dma_first_attach() with set_domain
  iommu: Remove iommu_group_do_dma_first_attach() from
    iommu_group_add_device()
  iommu: Replace iommu_group_do_dma_first_attach with
    __iommu_device_set_domain
  iommu: Fix iommu_probe_device() to attach the right domain
  iommu: Do iommu_group_create_direct_mappings() before attach
  iommu: Remove the assignment of group->domain during default domain
    alloc
  iommu: Consolidate the code to calculate the target default domain
    type
  iommu: Revise iommu_group_alloc_default_domain()
  iommu: Consolidate the default_domain setup to one function
  iommu: Allow IOMMU_RESV_DIRECT to work on ARM
  iommu: Remove __iommu_group_for_each_dev()
  iommu: Tidy the control flow in iommu_group_store_type()

 .clang-format         |   1 +
 drivers/iommu/iommu.c | 683 +++++++++++++++++++++---------------------
 2 files changed, 345 insertions(+), 339 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.40.1

