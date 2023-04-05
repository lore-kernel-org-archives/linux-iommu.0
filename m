Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA555D51E;
	Wed,  5 Apr 2023 23:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhmGLvXGC4CNkqSeIb2lI1As5s0ra61JO87vfPLJeMFL4hkuK5npBSC9HtQhwmLd0cYH4SjvgB79DaZC8xdiU9u5na1YU6WOMSFcZcN9IKAEH2fCLTWjG3QsBqgC3Ei/KmoRlELW5sMk+tg4mlB+eyRRP/2Ccp6gxOSdLxzDGLizvlz1zd4nfuNQCGg7aLc9h3D2TrfK7hTMCo63KqUxir0TZtJFrirvGq6YNBdMWyoEO6OlIA/q0J/41i+zF5PcrlaEX1xkcEOcS/cBH5imnTAO6vuVxE5qwe/N3L26bPQvzVsdy5hfCr6fGw+A/5jIG6draIqjBiv0xgQg7nUFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W9sd/REI7oacZTMKA2qrMTikQBrVteCRAW4DJKiKkw=;
 b=Za/7JpxpEf2Qx59qiL4Eu79+meU6EmbfluUiJMOkdwuU5zK2jnYFu9q+hgtAhaIw7PcgZPcUANpDUOh98DdtlmHCxr0z+twg1vWeeYWTcKbihVyPj6WZIdxOwV9O3bcLPN3Q9eKzSLFICqamsfeDpAVDH9ORBdISkJCRm6ZtDy+Ecep0nJz8Dz3RwbSd1biymotA540d2+2sUWKIBtdxub/jy6NVpvI3pVg24KWxrtgIbkGHZG91y5sbYgO5h8DMEfweo5SweyaVtvHG/JVFjFidGYiI9TlvGTMP/cCtgWqjoBdB0KFXouXNM+IAn9inj6Kdq0BdBIgl9/7R6J1lBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W9sd/REI7oacZTMKA2qrMTikQBrVteCRAW4DJKiKkw=;
 b=ZuXC2nf972bhbcexWBZ2i6xX6GwdQtEJL5uCZbnxqP9NtRKpOlXF/Y8ts64w2OmDlYdjO7BwTCrLKhooKnIsWz8Ydn935g4Qw9zTehaS36FiuxZF9A/6KVHU4PvoH7jEh4wnaIAcGrhW3PundKVIa/YsgiX5VSMvtrPAXVec7TC9wcXHOTsN9b1a2kDLgr/8EknVZy3UwuuCEQdStpKBvTdlmeH1p/Y2rNGxTne5nrCztgVLhIPoKX/o9vNgK/ZwaNFxHbRKq23av8kEZEMcoYNPrNWa6dN161XHH8F3MhIUrD3o31IxFJZmIF2flLw0eXKm7HYgM5fMG8ZvWMYJrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:40 +0000
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
Subject: [PATCH v3 00/17] Consolidate the error handling around device attachment
Date: Wed,  5 Apr 2023 20:38:21 -0300
Message-Id: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:c0::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e52d2b-6549-42f0-c44f-08db362ee21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Im00owR+Fq35sKkIwliNqBxFpcWYqwbKhsHCJnOojvtLeD/viQu5vj0KANtNHxFJcBNjoqSYuEhKbWqNm618laQ5jZGSjKZrkXxTgCa2EvtvoX/sIns0UWFAvguOqQxJNdVA/FgqUnecYDI2YJZd/cB4PtY1o8o+DoY7Il6VmEah7UHQU32qhVRKXD8VeGYIT3JFU6eKJfNoQygI0rnlkyagw+VHPig0SyuSL2L075H/6csFgvRlJUWr2IPlvYcHG/xTmiMboQ7foHeoQSUgMXLSELBTvF5/CmlIMueG512eORoYszVnzZ07FeLwITh08dcyhvM3LdqfhPZrKG+hFrYKORDhgepJoSdg9fFubBDZcgigmdGDRSFuZLgMyES+Wis49l9x/Hu9vFU8MB01/iy1gTT7oZGvi25eiypfK+EyGwiw/mZWa7RelyD88bKqweVs+VZQTqBSQhS0PA+Mp3MH596we4U/VfRZktqgGBN7jURfOBQ+r73P01HA3KqCJk1IctciHa/+KJUqqNfy+/KepeGcYVEoPCi68IQZowpheCi+lpAIekKtRU4Ukpyxa9HnPBqr91g+Z4aOoa9qAtrEN/HnWbIluRYDECTCuB+XgmfXGkFBlW1I1bEO5xoNVXxEUIORJ+HjBvRSF1Cb3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(966005)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kfIAJiCIiov7CsuYY53QPsDANrFd1IQZu6JzpzRXHjsczqsw6TM/c+QJG56Y?=
 =?us-ascii?Q?enRqoOxBkzijdmKhPMLorlgg+kyWRMlSh1kzcRSyvZz17s6fnQRvdQ+F8Dpq?=
 =?us-ascii?Q?KJsvePXLwP1uykcZRX7v9d/h7g14TKGjB0dsYczCvgmNk91PNFzcUVlP9MIk?=
 =?us-ascii?Q?iCdPa0SCQXXgCmqhoxFKuEhNAcw2VdwJFGFhUSYWXroA+Nc4x5tGXT+jDW0M?=
 =?us-ascii?Q?xz4c6SPwe1K2Do6oCmXoPNYMLUtcHGdVTm3eqc4dxZg4Fbf5gaa5P1f2FdPZ?=
 =?us-ascii?Q?kLmiaz6w8US/DRll6FOIopxqjREBnVBrFwg0rc9yUmsHbCMB/l+y6esyn/5E?=
 =?us-ascii?Q?XL9f4QIfFCG43OEoEds6lWmkBZlkx9vqCvJbz1jvf0n7vO1tYAGJ2XagT6QD?=
 =?us-ascii?Q?bsdSxN9kPUDXmXjTyoHc05ZgGhrDIhu7FdcCp24EOGY9IkgMOD8ALn/VmT+y?=
 =?us-ascii?Q?JimebyhZj/ZTTJX3r+L95SnUgtKi2QHl7Jvg8qTN7dQDXVYfaplq+6o7i0zI?=
 =?us-ascii?Q?PkPF4kqAtceg93f8uGv0yLnJtW/Fq1JbLU92smcdu3Ku49XwCRBJRKjSY4p6?=
 =?us-ascii?Q?Xul6f/0Qj49z6xla0N6pEQbudWCP0t2Z5hzwH/RvF4IfBsxqEkCJQl+RGTiZ?=
 =?us-ascii?Q?np9JpKj1xMJ9oXQep7zW5ncj/EOTNJqxRZyFKa7lV9sKbod5aTDhMlsMD/LE?=
 =?us-ascii?Q?SqSwP332CMPqi9ibn2jY94Vqw3W83ZyJUJWPvj8/XhcDob9pVj1jzupxpfah?=
 =?us-ascii?Q?/fyjhuqLICgP288zQAUHNGjh35iC+ypr96VmLPHzwCqwNnU7y2ez3QmKX8Ha?=
 =?us-ascii?Q?APQ1AIuAGyMhwviflZTlji1cj50E7M3v6sEUC64Na7uKcSrXO4c6nHtZ9Lhx?=
 =?us-ascii?Q?fg99rrzji2CjKGCGI4qAeYdvwUBauYJx0IMiq9eVYA6siOYlVAcbCSgcblXA?=
 =?us-ascii?Q?uJ+gpB4Br+2+EXBL5geQOA8IQNGMXFInAywLqJr3VpYr7hYL/6RkChyh/YHI?=
 =?us-ascii?Q?LY7SAskDn6V5BM7Ey0itWyAhotfHOhuOeG6vRuOuDH/ZqqvUzm2lQZpDidCP?=
 =?us-ascii?Q?kJXhv+OgkAfKeyXbZ2gZOt3Kf4V8gynNZRKQc8/hPhnJqXqrVBHqJoK667eW?=
 =?us-ascii?Q?/EQFkyFATyJS567AVWKR+B0Nq9n/wNyUepIoeGXGAcEg3LBBz2yTX4h0frm9?=
 =?us-ascii?Q?lKebUEHlfjNnp9e4waZzFKWoDcorRLyvHPYl/bBygVlzgSLxWerSbevXo0td?=
 =?us-ascii?Q?iqOJl2uRRn0P8F01b/KevJl+ih0koGkPMJQUhkYCWLoFBaxLPgG1hA6X0hiv?=
 =?us-ascii?Q?ceTThdEWBmaImqjdNM7ekhlwqx/bdpG1FQuY6iYrZmqwkMrg9qggQadqnYQU?=
 =?us-ascii?Q?h11scsXRqLlvewmUZiFkVjVw9c2M0ghQQbALio29HPPhCjttricwZDqssd7T?=
 =?us-ascii?Q?h+nboxepaWqvrObJ10qAhShW+YgZeTUzBvPaQENjOsfFCu1XsCB7ZwPaGh5I?=
 =?us-ascii?Q?IdKgGey9bgaR9hw/WDRIXFaVaB+OQZqgjsjUFfI5TN2VJlwKfqqXqBbgGOnq?=
 =?us-ascii?Q?vm5FK9fHxvBZelaxog3Mdjr6hpt/Tary3AUeUZNK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e52d2b-6549-42f0-c44f-08db362ee21c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:39.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ysz/ZWPlPUpJVRYzPaC/MZ4gsP8hFJHpGkS0zMTrMziqRcQ+W5ubVvGg4hSdL26v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

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

v3:
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
  iommu: Make iommu_group_do_dma_first_attach() simpler
  iommu: Make iommu_group_do_dma_first_attach() work with owned groups
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
 drivers/iommu/iommu.c | 636 +++++++++++++++++++++---------------------
 2 files changed, 325 insertions(+), 312 deletions(-)


base-commit: 3578e36f238ef81a1967e849e0a3106c9dd37e68
-- 
2.40.0

