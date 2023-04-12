Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D45683;
	Wed, 12 Apr 2023 13:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asd9FoPTHmSDcxanFiFUzR+XOQKwh3ugevoLJ9bHCkRVQep4e2AyS8ecFpWBVWBi5TgiF5hlYs7WXl+fWUrHxkf/fTXif22u8y6KFyGs2ZJQKGhTvlIf8v5jYXWbC+h4Ao045+65UZwEhsA6nSoVHf/0myNtXSDMdv3pRFaTQKBetEsiLcPFjgVG5r0jQe7y8piuKZdUAZWGd3pUAB9YgPS9VVkATJ19yQwZBWjiMVeQ7FXj3GWOcJTn606mszNvOFOnvSWbTKsy9WKd116W/rPz03Nb6xwMm6L/n//CNeQiEuH4g/z+HU0PGUQTFtVh5FDd5sXrOnhau4zuhjDHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOXsj6OplUp/CAUPgksZe4ZOf6GpRziZqLG91oxFnS0=;
 b=Rl2FeorfyF9mF10jmWJEO0CNqbHMBCyKxx067bnGXOwHj9MCHmrLNdx2QZekY6RCAmFjtWnIaseXNijD5bJJ+IfUeXjjADk8I7MNolY/7sammkkE5ZLfRLMD3C9VBMlaS/L6Psb/QxWpm57k9CIhzjGcKo3U0NH7/lGPLQKu61/2SEPLawrtxnvcRlv0doYscF4CC3qyMG/V33Cs70bAwRkovsW1JJMGuWJw+MbGNtysggiFim4F+rB/osaz0+Ke9waQdwGWwXDUXYbby5Whv7RqbDuv6yQujCqGxYX7ZCsmt344ww/NxdoeNcTRCWEwWggxDP1Wi4+jGn8aWqBf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOXsj6OplUp/CAUPgksZe4ZOf6GpRziZqLG91oxFnS0=;
 b=X6NUUrxceAboGOlPIKy6uJLFP9T5U+Ki2c9htmRHpcV1FaU5zMuXEZ5w56B80VBX0jyBuNNXX9Hq5DyOgpFqmHl+h87o62V052fOdcvKSVXn2UC6aT17HLLHW3OgejMNRMcZdslXT1UVc7Tas2NGmyZmxZvoCQHVoug5HkHpki0T9j0+z9QeXaC9iBs8KWbOZRgzxaLf5pLxHWqq97+7Hhg7LiH72hTLzteKzCac1q/AXsTlDcaiFlCWuCqwKMyHGds2/bfi7LZNnooMFl3qbEmKZ+10RLuaTC3rF+e9Q3o3OPAEQC6KXQiq4I807/kW63WeT6bZTd/FP2IDk7Izkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 13:51:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:51 +0000
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
Subject: [PATCH v4 00/17] Consolidate the error handling around device attachment
Date: Wed, 12 Apr 2023 10:51:30 -0300
Message-Id: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:207:3d::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9586cf-1c25-4c2e-8ef3-08db3b5d0fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kDA4+xOB8vqRjRvgfLI3pTLKRf9gfef+mmX1+l3oBiVxnV9SmmjxyAk0rpqP0EpCMWiD0I+vK/DzJ60u3/ujD68gHrDEDEI7C9j/Gmg2ZqOKqbypkWGLRyv2TSUf/hDnYApQAt9An/XpoTzWw/6zzf+MsUeCfKN5NLPGSOzaxr4QLnQwS/yWa2MWYk2mUkkwdRClRsVQBlZoeFwgVX7xGI+eTBbxhJvUow5FJno4PIWI7QcZmd9oxUazH/kkSrA1IlhqkChEiOqvDowTa0gv0lKDKNRKtEhs94bhFPc3CuP29lpHfBUr1Whm8K38pKHJRBQMyb83t7yrknstLDK0tJesVO0Ojc6EUjlYBT/ynxNwrxaZWq3bhHz4gVCoisHfiI1Q4CBvcNJOzZv3TXObDtRcUBHCl9PLsP57gOAehxtDUQ4SyAk8lr91JLk+CcW6s33EY0wH4wTRU3IhbQu9+Tx8hBDSengVRgZyRkZYgK2jy9wUSy88Pw0m2MTYAPSizjvnbL/Zw9K+ZcpWOALiNRV9uVGe4bWjeV0qiq1nhXnt5bsutS3Vs3oEtQjktjxGzwesQfHaExZ2CoOS74kWO8UWyxnqllqPneZrxlxmRWzkrMs8jNwPxX2UheGpTrQ26jQBDKm+Lh7s4e1fngiiEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(966005)(6486002)(4326008)(66476007)(54906003)(66946007)(66556008)(316002)(110136005)(6666004)(5660300002)(478600001)(41300700001)(8676002)(8936002)(7416002)(2906002)(86362001)(36756003)(2616005)(26005)(107886003)(83380400001)(38100700002)(6506007)(6512007)(186003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fYlesHJE3wPIbQJ1LYrUnP5WCEOXPfB+5sQtEtmbR1YcktV4cD5iX1x32V/K?=
 =?us-ascii?Q?J9XKH7Mv0ROtaFo9IqNaup9en8rE9wRI9priCRXQvkD8H6BFKhX+KSPxVyR3?=
 =?us-ascii?Q?0GN9KuL7rIj7r7u7/bvIqgtJtFHwEEgpNY9RThXeJvjoQu5VVoYPRNGXXgJu?=
 =?us-ascii?Q?qmmL/jKZG35OGCzPdp7Gvnqlwnu2erj+ppzYOx0J5rRZV26/8HtZ+pu3RBA5?=
 =?us-ascii?Q?PH4prBZqTTmrWtODTwzSd2yMPVrN87XiTBluV937yUabtrEAKmJmsH6wJyRI?=
 =?us-ascii?Q?4xZYaCgQ7r308APEPG6NdUGR/io3SsGI/pnHWGDnePI55sGL2VE64wuOc2TC?=
 =?us-ascii?Q?396AaV12mEAwDgsKYOgtqsm700sI3vC4i/KaIiXrUDg0C7HvQgP3IMW5Xd2P?=
 =?us-ascii?Q?iCUNCB6Irq0cR/0HjqOMcKDzD2IXgj0DY+FnDKo2QSUBwdOl+c1bkF37aym6?=
 =?us-ascii?Q?r07BNDk09ERsTRXhyflo2ds/3Q22hK1NzHjCV+HfNw7vWp+zOLWk/2Gw28P0?=
 =?us-ascii?Q?P1iBwMtRNC0CsoZmG1Ri2tq8sWL/Zc1JtOd4/piZUsrn5j5VQW5ylPjQPEW4?=
 =?us-ascii?Q?++6/qzUw0Q/faau4z+xuAFPauDRSwZc4MEPNaW0SYTt8H/ACFWMwNwTF05vT?=
 =?us-ascii?Q?Tw4pyA+zU/WZ7C03W1NTgPmQqtqkWKLJ5nY7EGHCzam/4QkM+i5L5AeMPZmY?=
 =?us-ascii?Q?1Y4wTVt4hXiCT6enNszTEygAz+/cXqqgyENByaygMG0D1mnjlGEzcAqEBi+B?=
 =?us-ascii?Q?7mPZKY4VxasKMMOXGTVV90OvSs9VJzI6N0EGGu/vUmccyjrjfsV9Tfr6I4oG?=
 =?us-ascii?Q?5C9yY6q2GdvwagwUR/Ib/dIlBgGJMimAMMM0vrcs2umja8VyxHiaz3fb5Kpn?=
 =?us-ascii?Q?9Jr5fUd+XdjJtcpBuMs2ApfrCaVYS9QFTtVQ2UH7DoVRQEYiGqS75pUatxv7?=
 =?us-ascii?Q?GAue+RA2p88vi/mohlESrayDNE10fYsfCoFZGstMk3lDlGhn9MvAJXX2kL2R?=
 =?us-ascii?Q?GBg2vK8oqJ6tMmlcG0SEDxxIiEb6P+G7vlNrxUQis52vc5xcOw/nkx4OeQtI?=
 =?us-ascii?Q?OuCY4A3eg1hB3J7tzKwNs/ao/97dJfqaG4fcFcw5MX4PG2PKyjIJxvPQf2OA?=
 =?us-ascii?Q?xmD+wcsaxpigiLSrjCCXYnTsJDq7yo8R8PrqFqruCQtj5aYMRLFazd3KxMRV?=
 =?us-ascii?Q?1E5WqZJ+s3FOZ6NpvI6DXpXTO6KkC7K5ytEjTmZRfLKMrothy5mnF5zGqF1d?=
 =?us-ascii?Q?0Y+2WHzX8lbQ+sIvXZZt8g4LBAhSCgOfhxdQzhSGe/A9ukv9HR/k1+OH1qF9?=
 =?us-ascii?Q?fDk0rbKKQwbXSNYwKl/Ml/sMxfO5p0hmKHEsNZC5EqqJkWSy43V0Ko5T1BhH?=
 =?us-ascii?Q?u8DFaeYx3S0v0M4okkzRNLwvDYChszCsvBK6f0cbAqHBhRMxiecVwYgui7s2?=
 =?us-ascii?Q?u0rEx1hE6RXZ2fwieDDxV4RwPZd7pmLsDoAgZd8/DJLRxVUgp0y7HZgI5rr6?=
 =?us-ascii?Q?v2iOTib4GUh0WR2DVEG2dPp0IDKdMR11pBPokZXhvKQamBPDVad70Jw2YAkl?=
 =?us-ascii?Q?AgRk8Abzco/kNU3aqdqNmDCty7+f/jkPAAQSEt7N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9586cf-1c25-4c2e-8ef3-08db3b5d0fc1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:48.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RdS+XF6T4PT3fWLKwIaRcgvdGOZ/4N7g6xA2D6sB6hVyXzuwUWrjgv28ESoi15I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957

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

v4:
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
 drivers/iommu/iommu.c | 669 +++++++++++++++++++++---------------------
 2 files changed, 331 insertions(+), 339 deletions(-)


base-commit: 3578e36f238ef81a1967e849e0a3106c9dd37e68
-- 
2.40.0

