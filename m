Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB822EE0
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GnAoHcux"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfbt+Urr3eecXmrhILJ4GYrG0fRZB5p65kZ+XcmlgV5/XNhlkbXLwnJC4F8uXmaGUA0B1+QA0kMTt51nY+ylnv6SzZKtljzbz6fhmb98klY1bBlpB/xQeAV1BReQ98Gw1Y47G/LAe4o+yhaqMT23yKcKHIlqE6n9giNzF+Nz100nJg7q35rhLPeUdtB5wBSAYktzZT3mp+gsgAmQMlzRSc/dCGWisG8R4S4+Kcu3eXT+hyOGjoKKAfR/OZQNelPS5eECisKHLXphoXda1x3QI/3ywbqtIjYBPTZjn9Qxza679w/sCb39Pu6vs3UxZO7/kFmjCEoNeKPxcGE20CsWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/twPx1SRKNFs8WGlnWpUaBs9d/923pTtZNgbMPvzaE=;
 b=LgmO9M5+gpgy2V11krF7yMh1gCiu2m2megYSgcs0vM1z8Y4/+0GPHdvIj2euGjEgKP6OAsIMuiVprLz12n316MFdSLm/nmEoVB8/jEQSW7LJJhiGCJ7UUXJH0MaKPXANTJ1KUAWBom7Yfy72ac4FHz7KrzIpJa0idiF3000AdTY2mcpmjJM4nu7lwSDu+1yuegnFFsLoDdmpi17gA8bWFNyu/U97mBivpqKVt+1kVQPQXFMwvWFU8X5fm9Jm7vibrWdixJrAVKxKE8Qog5CuK8tia8fynaMEkdIvrZ8qgvKEcS9CecBZkap8CZBHayrsqrnJkzCzmVi14Tyi68pKsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/twPx1SRKNFs8WGlnWpUaBs9d/923pTtZNgbMPvzaE=;
 b=GnAoHcuxCHVDPeLteNQEDYkdnTj92rN3R4vRXZ+oJR0ux56+kqxm/gAfGPyU01uKZPmZQz5LZayYYs2o+GXleeLKei++4yw1AWvZxSrBaBGcQEdqqA0/SkRN6xb/ssRFhZDx5ELjfQHbN+zvbPU8j8mjIvWQ71hug1R85rFsrDzXdPxk1NlQfSHyAZn5XK8wXmYbopnrPz7pYVj1BUzM/bbYx1icfGYH9NvJv7k56jibvUWMFD/VhbzzDrftfApycoBS2I2FqclJetjE+Qy+PUxRFJ3cRK4VOjc5JAvdqjJEwO0CB/kgmBTQmpFolKKbjRdfHDmWU5pmr7FRgazOfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:26 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 00/19] Update SMMUv3 to the modern iommu API (part 1/3)
Date: Mon, 13 Nov 2023 13:53:07 -0400
Message-ID: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 650f1cd5-77e7-4793-b948-08dbe4717023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OzU/UePIbxlieTA07vF6xCUqA0dJZzi4IKlE7sZYmxVr5JGTF/XdvAmtXJPPpHKFXynLAlBBXaeSlTHxk8xEtT5EWrmJyyjfCRNLrQ7f9uMYhKzMy1bK0a2ZWD+2VIvTrPLxR9sECzyHiYdj31DViEuGI2ZV2y9TKGFM/qJKTteiRVBD1ro1rrOUq1SFhTfutbDQQvOdGxuRMvE+L0BnavUmqMRtKhXIn4qsyxaHVv1Fmp6Urmd2c6x6KyZ9tmspdH47Fc5LCkcLsSm2q0hg0/I50MNSeOyIHZSGl6PqGbemN93XEmSlxNGbZrQnyjfDfLt6dh2Fx0iB1Rzmz143Y84DvQgYznhuHOipswTy8IbAT5RWo1NRsOIXG5qWBVSgYpxYCJGFGOOP5YYLLxafaT9I8WiHZj1Wo9b1VD8CVdhLSDd6sjUtUiLxM9zH/g0n7d604PQQibdsbBC8g2DaeWd6yP1oCDm5MMrohyY3m1ZoOxAchSfzma8DTyyY2zm192jRqSk3A59lsAUuDRpvYix2enpN0N9jdTda/6qII6DXjZM82IcYvaX4zuHF7gXZNx0/e80gPU16NewtIJDsQcrlQ//pSj7AfQXIz01is4pQgL04oujnsASkwRyOyR2JH4S8UjxH+jQ1ltWN0nO6FjhcXj77IAc7eSiNI3t+NTkgZh2i6EHAFUCVEfXmSVaq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(966005)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(15650500001)(2906002)(83380400001)(86362001)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EvafDgWEFQ05kzY/OFaPjwx/SBeNYxqQVNkQ+Ti21DY8BVAmiG5tK9iuMRhB?=
 =?us-ascii?Q?HZxCRxxSEk9h0GLo7iA4ZtJe3abgBLIEWCxrJq6Cb1AGJmctDfqYAUmQqPMV?=
 =?us-ascii?Q?7FysyNkRugOqGlcHwux1X9d6OaAKLVSQSTutp6UmDq7e2Tk18JbFw7ndypyK?=
 =?us-ascii?Q?ntmuUfPr8JLSS4QK10c+vp6ygngeQU9m4WPw+FjIlMIv+l4Y1HHM6d1BFVug?=
 =?us-ascii?Q?QTaxWJCPEzaGXVjKqHadlnFD/NHF3FmJfn+VjehPDmuRIAhu6h19OIB4QWOG?=
 =?us-ascii?Q?6CwQ1qiSmUqGPGGaxlx6MeXNQDEADjguWJZ80atUp2UkldifD/UmEKAlAfRn?=
 =?us-ascii?Q?ClOnEBJ5tPohJ2SZmDA2JIlAt5xdkKVNBf1PIUPhTFZrGWqes2bGXpVj1+4W?=
 =?us-ascii?Q?tEBH6pCPhKE4cUBQCg4qWFPrKJ4uK28hu07jNdIO3kuzzjIXlAFFYUxZiLZx?=
 =?us-ascii?Q?2zqv+oZiSeJ8YUdPdvOXyN1OyuxEDs6CgZRO+9umQHdowGK8cj9yYq5ru+JM?=
 =?us-ascii?Q?rW2wrbKi8wSHDOlcL6aZ/89dKuhE10QWUlf18vouQ9SADVyw04s0VHG1Tttp?=
 =?us-ascii?Q?Bsm//kCGEAOwLDOvQyzzFHsAlfO3C8l2oJnL5+o+vm/i5O5siqiblRoCm0iO?=
 =?us-ascii?Q?PySPo5UYdbqKTUKRVppT54R6XSuIZutT0f/49u0UvcXnLan6OhAb+Koa49Sv?=
 =?us-ascii?Q?Qgyw1pvXFcYA2iRr7geqkhvCNbdUBjhcrlGdYS9r49FfkoonZSJ2zMkPyb++?=
 =?us-ascii?Q?15+r5K3Ri0T0UGPtJDrIJUMb/1nzXL3Mh9UNVEIGrMSBXIXk2ga/LcOLAX/5?=
 =?us-ascii?Q?sLPqeYfJXSqS+GkF38xk6qDcA+0TglOAMuiI4ERE1NpaT9DVbJQkcmHVfqr0?=
 =?us-ascii?Q?QD5ZaeuRj8PcAVQrnIGOSKTZ4RcgidKZ33ZhloULjX1ylFvChNTJTG5AENmj?=
 =?us-ascii?Q?iKGoom26bgNd4fU1e8ncPO9k3EqKYZFq4mBU3ONI3AteKbABVeLD6tES4NDN?=
 =?us-ascii?Q?XMv/kW+FOE7MLhoDBZgVJzzlDAmvVp8XTann9vtOxxY3UF90S0SyGUhpQG7J?=
 =?us-ascii?Q?V8UGsCI0opioo5JCAUu4DVqU3+QWsmKPtvQZrX6Lo0RpF5O8jJY45fDawAts?=
 =?us-ascii?Q?MI6dy/m5wRDfuZ0IoNlQnn3rQ9rMLLBFR3t/Lh9Km/lFSwdLjNt80VBPNg75?=
 =?us-ascii?Q?JOBdQcu5TA+GWJzdSP69q5vEDYkY7sRdoDIArEsdhOGXaj1k9KaMfbUiIL/f?=
 =?us-ascii?Q?W6vs6IT4g33d+tMwD7Pn30xH8Dd2OeEAamrms/2PVeKiqAreOLEsQu6FgYQg?=
 =?us-ascii?Q?wbsj2YV+OR9rFqCljavTBf7aUy8DI3bRiI1rirxAWLZ31mXVVgVZZvaVADi9?=
 =?us-ascii?Q?HTIdcVQlsqlCq9T9rksXcLoSl/3jWyv7cbVYwXhDEKYACtIZKJf/fwBoOwoE?=
 =?us-ascii?Q?lRZVdPypWPUoknPhybmhDoSd8lEPAV5F+EhNbM26lEk4FiNPDwEPAHB7I3TV?=
 =?us-ascii?Q?3XZRVotevvQSPDtfFocIMW9tfjrUTTLEk1Oro5wMy0v3+ORvKSM3sE7HqkS5?=
 =?us-ascii?Q?3V0fdYTI5oTwlF25uFY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650f1cd5-77e7-4793-b948-08dbe4717023
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:26.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaF8wbXAe/5IlN+a+JWA5Y5KE1tjsWJ8eze11pAJfd877xD4t6shDO9HfvGarYRl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

The SMMUv3 driver was originally written in 2015 when the iommu driver
facing API looked quite different. The API has evolved, especially lately,
and the driver has fallen behind.

This work aims to bring make the SMMUv3 driver the best IOMMU driver with
the most comprehensive implementation of the API. After all parts it
addresses:

 - Global static BLOCKED and IDENTITY domains with 'never fail' attach
   semantics. BLOCKED is desired for efficient VFIO.

 - Support map before attach for PAGING iommu_domains.

 - attach_dev failure does not change the HW configuration.

 - Fully hitless transitions between IDENTITY -> DMA -> IDENTITY.
   The API has IOMMU_RESV_DIRECT which is expected to be
   continuously translating.

 - Safe transitions between PAGING -> BLOCKED, do not ever temporarily
   do IDENTITY. This is required for iommufd security.

 - Full PASID API support including:
    - S1/SVA domains attached to PASIDs
    - IDENTITY/BLOCKED/S1 attached to RID
    - Change of the RID domain while PASIDs are attached

 - Streamlined SVA support using the core infrastructure

 - Hitless, whenever possible, change between two domains

 - iommufd IOMMU_GET_HW_INFO, IOMMU_HWPT_ALLOC_NEST_PARENT, and
   IOMMU_DOMAIN_NESTED support

Over all these things are going to become more accessible to iommufd, and
exposed to VMs, so it is important for the driver to have a robust
implementation of the API.

The work is split into three parts, with this part largely focusing on the
STE and building up to the BLOCKED & IDENTITY global static domains.

The second part largely focuses on the CD and builds up to having a common
PASID infrastructure that SVA and S1 domains equally use.

The third part has some random cleanups and the iommufd related parts.

Overall this takes the approach of turning the STE/CD programming upside
down where the CD/STE value is computed right at a driver callback
function and then pushed down into programming logic. The programming
logic hides the details of the required CD/STE tear-less update. This
makes the CD/STE functions independent of the arm_smmu_domain which makes
it fairly straightforward to untangle all the different call chains, and
add news ones.

Further, this frees the arm_smmu_domain related logic from keeping track
of what state the STE/CD is currently in so it can carefully sequence the
correct update. There are many new update pairs that are subtly introduced
as the work progresses.

The locking to support BTM via arm_smmu_asid_lock is a bit subtle right
now and patches throughout this work adjust and tighten this so that it is
clearer and doesn't get broken.

Once the lower STE layers no longer need to touch arm_smmu_domain we can
isolate struct arm_smmu_domain to be only used for PAGING domains, audit
all the to_smmu_domain() calls to be only in PAGING domain ops, and
introduce the normal global static BLOCKED/IDENTITY domains using the new
STE infrastructure. Part 2 will ultimately migrate SVA over to use
arm_smmu_domain as well.

All parts are on github:

 https://github.com/jgunthorpe/linux/commits/smmuv3_newapi

v2:
 - Rebased on v6.7-rc1
 - Improve the comment for arm_smmu_write_entry_step()
 - Fix the botched memcmp
 - Document the spec justification for the SHCFG exclusion in used
 - Include STRTAB_STE_1_SHCFG for STRTAB_STE_0_CFG_S2_TRANS in used
 - WARN_ON for unknown STEs in used
 - Fix error unwind in arm_smmu_attach_dev()
 - Whitespace, spelling, and checkpatch related items
v1: https://lore.kernel.org/r/0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com

Jason Gunthorpe (19):
  iommu/arm-smmu-v3: Add a type for the STE
  iommu/arm-smmu-v3: Master cannot be NULL in
    arm_smmu_write_strtab_ent()
  iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
  iommu/arm-smmu-v3: Make STE programming independent of the callers
  iommu/arm-smmu-v3: Consolidate the STE generation for abort/bypass
  iommu/arm-smmu-v3: Move arm_smmu_rmr_install_bypass_ste()
  iommu/arm-smmu-v3: Move the STE generation for S1 and S2 domains into
    functions
  iommu/arm-smmu-v3: Build the whole STE in
    arm_smmu_make_s2_domain_ste()
  iommu/arm-smmu-v3: Hold arm_smmu_asid_lock during all of attach_dev
  iommu/arm-smmu-v3: Compute the STE only once for each master
  iommu/arm-smmu-v3: Do not change the STE twice during
    arm_smmu_attach_dev()
  iommu/arm-smmu-v3: Put writing the context descriptor in the right
    order
  iommu/arm-smmu-v3: Pass smmu_domain to arm_enable/disable_ats()
  iommu/arm-smmu-v3: Remove arm_smmu_master->domain
  iommu/arm-smmu-v3: Add a global static IDENTITY domain
  iommu/arm-smmu-v3: Add a global static BLOCKED domain
  iommu/arm-smmu-v3: Use the identity/blocked domain during release
  iommu/arm-smmu-v3: Pass arm_smmu_domain and arm_smmu_device to
    finalize
  iommu/arm-smmu-v3: Convert to domain_alloc_paging()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 720 +++++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  12 +-
 2 files changed, 472 insertions(+), 260 deletions(-)


base-commit: ca7fcaff577c92d85f0e05cc7be79759155fe328
-- 
2.42.0

