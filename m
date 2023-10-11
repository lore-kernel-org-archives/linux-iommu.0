Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BFA2510B
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UsPh2jCm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjmjRiUrq2sOC/SD3hnkxRFf2dKH4jwhGYcb18IDzHkS24iEZnalRat2dWZJa66qE3e64h6wtg13Iku7xvCOhMv1f5oi4odw1LkKM6VbIkv3nUtI7KemWWs2lCJORtjUQoHin2bvmhbTYf+a1wTtw8uyQKgZ6SN7DiPQdhYFWJSMofXdmmC+FNAO3vF9/F6og4HkWfq0yrVNNrSz6UHkebO08QlBEGqNepJs3+p9/L9qz15ym92JOBXJpdsyXpWm3rU0no4BU9pwLn/kXG/H0hqEYI1w5fgrdL+jhFrb7M6lOwDCbcMIUEOFXFGVehHuKr1DlkrbKxIOmG1taNwexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Knbc2JI6mPHfH24GxZHT2Q4TBIegwLjYW7znhMWY/dI=;
 b=oEEb95PsQTmJnvQTOe9bS35Vs2zcY6ipeCGu1qMAwH1X+BfBjQGwBtP2dLKJFE2eHBOumtuAwRhTioZbjxoidsRnO6ZSnmxPsvCHPnY7pnd0mobZhibwNhjQTEWUjSr+N/W8EdduVG0iiyUfgS7MbRyJ5BWNcre/gDTw/JLqlHuTijNOfbRbqz/vBbahP+qq2WCDpgKpx11t5R7MeqnQTnwz9Ioy4sQO9YXuDilxxKXiFf8rfmkFdV+xVwICgQri02LJCdpBYkZXVWJv//fw96zEk/PEXJTRoIg/gAfZZna93cwj7NeNYcfQ8BGUWklj/Dv3gyl6+V7A+eWTy+wB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knbc2JI6mPHfH24GxZHT2Q4TBIegwLjYW7znhMWY/dI=;
 b=UsPh2jCmAiA+ThqclHn0HfPHm2MiwUqfqFxXZc1SmznVxxN5APuqqGYD8Vjfs3Z8BqUFumwoEvklp4ethbXJkjv35Hzyor0Zvq5bYfwIBUhd3srqfekNim6EcXLYM33JW2z0nx7Wx98PozhPvxtwE/Pv0RFDCOGQ1RcUYRSnIqE2Jg+gcYvJO6+mov/1wH3N97hRf3Ml76IVuGOIOXLEaFzlojizl0f1NSvKop3TZExMuE3QtJ9y1A6PkieM//AgAOmM5SZCSfHt1b3S07SaeuOvct0h1Z3xp72rJJuqdVkfYWh/zcBQUXTuj66m9eexWmzEzRCcsCJlNiaLPoOa5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 23:26:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:05 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 00/27] Update SMMUv3 to the modern iommu API (part 2/2)
Date: Wed, 11 Oct 2023 20:25:36 -0300
Message-ID: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:23a::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 519d216b-abaf-43c6-4a38-08dbcab17010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M0WaqRcqmhCQHHVUcaq9AFB5/8DadGSoH6lWeYfmVbFy1XCd023VZ3Xq2MhpfBoQUQpZ/NtU2z5UYIDk9SozV1+wmv12QqRRWbzQi7w5PqfxV29K3yO05SxrDYwd1OCPL5LhU/X7+cCvgSZ2pBIYc0QwWceqUYF3Cz0x4yEPRylhxo5oMQ5Vt1ZBmNMp4qy0C1xvucq9XB/vBDhfyk7xUkDE3Es1y17dLhe1+5vftQ4zsplL64s45Wg1wAgyBqCDM67IgtSKETQTaI53JPjqhqi56QO3eMdIzUK2c96nq8zzdFQrRHgZbMJjYHYEGk7ldlTvOC1j4huHIiNLkMzrlSN78Y+KnhBz6amsKXmL3aBkYRToLeOGE9FFMoFScVp726IMbY9XG/kmw7iFBdRzmPjp9BdsrEXY/ZjqsHzvHeHmTcj9PV5uuFylvEsQe/Tnssj/cs0EvwKCnNzhbEiO2/B6fNPIyKlALOXOj1Thu9SLL/ZEcoU/rP2Mv1NLVzi54C1gLZ6UG3ttMgG2kKydvaDvqeGgIDpzCbV32L8HxC/UR2PxnEdvNARFtN+lGGhPwtl3b8X6LuP2WinUgS08vnHCtiNN0hbS+qZZshfCUiyi8agIlGGeQYi9bMPb00Zh27wv5z2Yge+8Wlgk7ex+O+8wmhzN8QLbkDMqsKm8sZwztAFYV5nQ5miqE0a0nYOL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(6486002)(110136005)(83380400001)(316002)(66476007)(6506007)(38100700002)(26005)(6666004)(66556008)(66946007)(107886003)(6512007)(966005)(2616005)(478600001)(86362001)(2906002)(15650500001)(41300700001)(8676002)(8936002)(5660300002)(4326008)(36756003)(66899024)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8wZKCHtb8scIcnD3C0qmTakCEO2zXyC/rK8oQcObAx6nog6N4gmfWT+1M/su?=
 =?us-ascii?Q?CQ9w333kPl6mZaURz7ou2176jTHEyY2755vxBaMv181EF80Bsa/+09tL543N?=
 =?us-ascii?Q?v1genqHQOGLBpMcU/ik4eDXpI97nKLupeYQtN98C6SaVlFL9kurkMZXpXxhd?=
 =?us-ascii?Q?8PgLT5IRCo1RM4IkEvkuur57GOxf9s2RoKS857T5PO+Atyrb6TPz3OsaK+kE?=
 =?us-ascii?Q?YZa2+Pe8eK0H/OezW1ZM8JCcViy8kCsD5Jz7Zej6bng3AHXYMfevwej9y+ol?=
 =?us-ascii?Q?LsNNNfCp/q2xM5dwGvltPvebIA4UjIYGZQaIqL5zihhLhRJgNQIkbJBhmADO?=
 =?us-ascii?Q?4F4uQvKIOOXB8esYBvZ9oaRHPuhQIc1wo/yNXKcdqRC7ifrIPKIuC4H7fXUQ?=
 =?us-ascii?Q?gBUWv56+00XxEzFdP3WstE5Nqfn7jqlSIWGoKhxdn8VkopNb/Ux5dX6wXqe7?=
 =?us-ascii?Q?g/z9M2MjfgRHbVrgZ/1aNOrpN5mh2BJ9RBduahmTOHlJ/rDQB4rgXi1+Zgm3?=
 =?us-ascii?Q?maOP0uL7njp1d2ANI3a8wvVVxctyPOfFhD71iX6GkD613ntRTEf+nq0txOAO?=
 =?us-ascii?Q?Lit1tee4lPoDQ4qsEdT70+eWBJZdsFU0AYaQMpmmBYoeFmr3Zv4285d2VfH4?=
 =?us-ascii?Q?LysMEpnx/ILq8ORf07L41P5kDP7mhbYOvC9LFzgpjNpKxd+w91+7897L3XkX?=
 =?us-ascii?Q?l+meuDTmxsCSUiHNTwoZXGgvugl+Wj0cp9eXrcxrwF9tuFob25pFhQmfK86Y?=
 =?us-ascii?Q?XBNQJc74cIaSebkk2zQteB1kigkGWbFhcOteNyOcdtuKhDLZXSBnQsr69e84?=
 =?us-ascii?Q?tyzZ4wQmJRoKRyx4uzMMINt5ta+FN1xh7pebcXTl2lB0qS5uB5fe4B/4lnb6?=
 =?us-ascii?Q?EgtrvRGeGEXseTPTBV5zY9v9auP0Z5HBQplwlVIrnkUsQkk8qD5Re4Q7qGTN?=
 =?us-ascii?Q?MlxP6vF+qgwJaFrbgh059RQbFWCRdJfwDD3Qo4y7vGVZsfjnhCSbaJdEJrk7?=
 =?us-ascii?Q?0ius8tFFV078rkviPmFJiQ6poMscWgZ3HHEzT54HgvFedeSJPSvIeVeSyyuO?=
 =?us-ascii?Q?Ii5r+vb7L3pD4Rj34GhBPAGwDaPNvl5SyjKWCcToB3C0/boG42Ugj/55Fdp/?=
 =?us-ascii?Q?rMluG4CFGpT6EeJst3LmMnMpyQ9bcMpIoWp8AqiDNKco2d66MwhjcIsLeUc+?=
 =?us-ascii?Q?6SLfB17QU87KJcCwGIJ6TdIzp2KxjriTuTUPIAYQt0RP+jko5Fx5UqvCKswX?=
 =?us-ascii?Q?1IzrX+e+P8H5/iWYz04g4Pqx/pfkzvhK8ScvG8DUPaAHNB705+2IxRiz358Y?=
 =?us-ascii?Q?f7PJN0qsJZLdQn3qY/qdAkXlDOxj8BEI1moyNO61InlzXcddhvB8ZbGmZYxN?=
 =?us-ascii?Q?+bi0DBRmfKRgD6FAL7kRcrhp7P7o0Dv+DTGBueAn0zIi42NhrdnUB/4bn7Iy?=
 =?us-ascii?Q?N3Qg9IaHBzgTbyZ9WuYg8nWccE6EJx+mWgeFfJkpFwGXLgeqGgH6WTcE5WlZ?=
 =?us-ascii?Q?5NccDjKW7uL8HK2pqZZ4SArqLChtoCF6CyhQX3GESqvu6jtipIEiQ3zpKf4l?=
 =?us-ascii?Q?csfR9z7i6bFMipoj1ZAmAhsnrbzW12Bo9/ZWOFmX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519d216b-abaf-43c6-4a38-08dbcab17010
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uC++tiylts0W1UC9Dsd/L+yMyxu9Q17LcInXcNglc8x7UtxxqnGBfzUMxmAlzLAA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448

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
into a form where it is fully hitless, whenever possible.

Finally we simply kill the entire outdated SVA mmu_notifier implementation
in one shot and switch it over to the newly created generic PASID & CD
code. This avoids the messy and confusing approach of trying to
incrementally untangle this in place. The new code is small and simple
enough this is much better than trying to figure out  fixes.

Once SVA is resting on the right CD code it is straightforward to make the
PASID interface functionally complete.

This depends on part 1

The SVA change requires Tina's series:

https://lore.kernel.org/linux-iommu/20230925023813.575016-1-tina.zhang@intel.com/

(Although if you have only a single SVA device it is not necessary to
test)

It achives the same goals as the several series from Michael and the S1DSS
series from Nicolin that were trying to improve portions of the API.

There are still topics for a part 3 (as yet unwritten) which would want to
make iommu_domains work across instances, split the s1/2 domain ops, and
further polish some of the code.

This is on github: https://github.com/jgunthorpe/linux/commits/smmuv3_newapi

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

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 620 ++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 846 ++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  94 +-
 drivers/iommu/iommu-sva.c                     |   4 +-
 drivers/iommu/iommu.c                         |  12 +-
 include/linux/iommu.h                         |   3 +
 6 files changed, 888 insertions(+), 691 deletions(-)


base-commit: 0f6f4b2cc77710aef8d0734a27206f1e1e9a360d
-- 
2.42.0

