Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F123C3
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OI5dC50I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTUKd+gtkrLnG5Ez9BMMJ1RuvnfeWfhLCiWiRsYLoCte32F/975TponIFdGOAtIn9ew+7lSy3RDQ4c3sdqbzD2uxMnYRzRdsgNXZlM7ngY+IFuUIT+2QKKY6l5fCv6nSIXlkfirrIxnYXoFF+IGQhrFcd94xSA/eNeOtbsQvrpVWYWi8mVAw6uyECS2Mop8s5+P9j82EO9z0SM8N/e6rQD+/JWhkAdU2G8Bmp1WQzHpoJ91bd1FaCzV95oQ0rxxc+5stkoinfIfbHC9V3WrW+o0GkC69ZVDl34JxTrRJoZ9pPO8FnE87yHzS8dQZfPB5Ewtk2X5yhFNkjbtLISnSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8FCnY16+iyxVZnd2JcYzVshTh9o5IIQLNsik2aEcds=;
 b=MEQ+Ev9T64sklOc5wlPNHfagwRu6vYj/PS3vA9FCj+431tJU6B7hHwDhGXlkLdZJpQ+SkOH/Rb1E+dfnN+GjM11/xYkV4qtN0u0/1SguNjRbSwi+UgjyyKa9FHnwaqrFhbCmkLt/kez4CjgWDXDKghYNpD950CkdY8CwbZieam18C6LRFNkcQ3PIXDWu6gvOMhUcDnDu8JtNOt8KXnrq2R7Vy8l5GNNbvgfDnKouuQf4JIVjRH3zEwrXe2BzWa9WYkuAfanxOxHWZoeiqOtthlbM12mX/e+Ek1aP7bsU58O3b5ITCjYZBSsQoY6vW+sbPPeK1CB/AyJJEkh/noWd7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8FCnY16+iyxVZnd2JcYzVshTh9o5IIQLNsik2aEcds=;
 b=OI5dC50ILHy0voUuAQC59PGo1xRMrgpGFXYMfHjtmV807166o4cNgxrhuPdcwauoE+I6oHqg47mv0xkDPQSb5xKGcIgnyboPIzooAeArSs++ePN6adiPAmRvegGMeElyPSgJ6ngDIKkSa6uu8PqjVeWjCHk7+2qFAgDHvqb9trgoJ9WgjU2tDYgjfjGI7qh09HWy9OQM598QoeRbMSkW6nT7IyBWh+bekLUgFK9rCIygvHpeQkR+3qnDLgALVTm9r94FJihiMqOs8DN5jN7jOh7He//THxK0Jt7F4DJziCk1aWb+59qTgD3kG/0+I5hOCZ6nH+9PAA4tN4sBJYn55Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 00/19] Update SMMUv3 to the modern iommu API (part 1/2)
Date: Tue, 10 Oct 2023 21:33:06 -0300
Message-ID: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:208:234::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b7216f-8556-4ae2-5193-08dbc9f1aeeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hUvAvTRljCFqIyvMZQJH+0xQu0l5CykDVwDcybj4PcmnCjzAk/0mmrqAD2HU2eV5o9KdJ6N2o8fCFJSHMotxb+jrJ/b5faTX6KoCzjTH1SClHvJyxkFAMstBhpzW1kJ0MQmZhkR267dII1okVnTapimNPLupEIjlkPIn4uH5DABYX0zDOewWRwbN0GR5W4/Vv8KCNBobVHH6n+Zh283Al04AzNHVH3X7PCBuXZZGvZ67ipnNoLnn5trh+DKY2xqwk33UFmeTbBd25Dwn3jRt0zZrt8yoFSrOdU1uViQqtnEehc761A3XQfEdPmUesNNAKbEbg2zn+HylB5hhbAYs2O42IzKR1rmA1hFRZBAkBRZ6U7b4re+5Kanc33BDXJ8euay7aP5EoLC2V9+ScbJCEEmsiVvoG2RIOw02EpWNj1ZcnueS2RF/kOk/8O5Tx07cGXUgSsxSZM6nR23bho7Wd1k1aX+ke4udLSG88KQEAnpmvq6sjrEc7ny1+RsDz2PLjQ4JxLeQVXErRZT3+sI8r53LRsw5r/ySDBsIzad3KXWZgi3jDSoXN47N53bVafIcvHNqCy1udyq+X+LKF2AiktKVT6rMQACGYDxIfUUn3BtqYS1FMK4Tfwi1Q9nTsygOP6F29U/TZutUk6m0SNROawf0MhnelNHAK+4IDbnY1Ua6ke+Wtn2SWH8T7McB2o1L
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(15650500001)(966005)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aMk6P1pBCjE7qcByCRxqUu0dzI+TTywhkKp+g4h9rDWnBKG64F7BzJte/vah?=
 =?us-ascii?Q?9IJusWCW7U4ni1KfsgwUr5A8IoAahJWE9kVXGPkIWdybrFE/WuPcM0YrM6Bk?=
 =?us-ascii?Q?CrVrO4JPwMz8lnJ80YdAwr4aqMkQ9xlmQuUgmOPPgzE/YRFKENE3VXMtIh6h?=
 =?us-ascii?Q?7VRDPaPhcAbqhBW+0gdPgXnZvSs3kV7jtI8Uv195kzoLErvRviG4L1bdpTOp?=
 =?us-ascii?Q?uagtXo9Jc3UiZxKME/4NMtaUgrhcDMCHr6uBYHLw34LaWfaiVi1nJGgcWiT7?=
 =?us-ascii?Q?WOgHEVKG51dsnQM5Muje4trTj+rankmhlWQMZ/XkPQEZ3lzdzxy8ZhRwjP1m?=
 =?us-ascii?Q?hwF7VvKYf1N5f654jcuVaCgWlLDtq0z6Lkfg9KDbSDUFgbgqv5QS4qOKPP+o?=
 =?us-ascii?Q?B5PXCuNa2snLUUlGbGger94E79a6uU+0m7VepHTmpgAa38ZwLouMgGKtyWvZ?=
 =?us-ascii?Q?Fxt8aS3/h5HaNKdrmb6gpcqRvUB3KizHFdUPcXh/6Pz8zSnoWkRT1+hmJblQ?=
 =?us-ascii?Q?plrhHp3XsVYDBGasrWJdYHyD8UlR56SoJzO1GuajsKkZLNWeU1MMBGhh8VMQ?=
 =?us-ascii?Q?TOTNzvzg411Kte4mv+fbnKl92tjTXsVbfNr5Iz2P9GK0sEkt7EUytSkdyYxU?=
 =?us-ascii?Q?VC2j4S+YT6UcBzWiRFrmbGmSd5eN06QeTDwAEYDtqkPRZHt2tnilyQ21yrfu?=
 =?us-ascii?Q?TqHAuQlprdXTTU5PFL0QqloAoykwuNJOZJdhqV2walKjZA6AucoItfP4rO/L?=
 =?us-ascii?Q?jXDbrQVO7I13Rk5YTqWIqjmfBWj+8hgss4j+8QC+sAnGe333GaMYTjiKI3pH?=
 =?us-ascii?Q?p+2pDkz7cA53g9bxwEs1Nji3IA9zHeng67WFxAJuSf3dNDOq4A31fsPQfHzd?=
 =?us-ascii?Q?Ms7i/DO2/bsebFXIHNgvIOah1BB3xu2BsFr6zJDwTliqY2U2sT3S3tD1hV6W?=
 =?us-ascii?Q?7NnmxYkakBqk8j2gtGfamBsY9OPbdQjftRqTxcet6SrqBzsUfxIlHFw2sWZi?=
 =?us-ascii?Q?kzLKcT2Z53yzUsPGAwghC2rqsRseBowTv+ZvsZ+8ejsoGB+dRv1456IJ2mQ+?=
 =?us-ascii?Q?mSRFlq4QsfcK+VXFj/LaVRtLHy8no7tO5b3z8qguLllzQtyzW3i7x/MCIpe+?=
 =?us-ascii?Q?sfwsjuVR69TryoyVWv0OHKEFd/ld77KGXhtphIOqKzQkYhrUdNoG6igXkclS?=
 =?us-ascii?Q?m7d/YYks1Vywfb1oyfTH8GU0O0oVnJOU6FNpQve1PL4Nrj5ceUvCDDFB1OAA?=
 =?us-ascii?Q?sENZmHJ7AM4JqrJFMr6qyjCvWeJxQe2OrbtAFzzn4LWNE1sCNKAyLliPeoPO?=
 =?us-ascii?Q?HH4kTmMrkDpXbkjj6uBGWiAjIKFpYEmAoJnZNwgrvGuE/sn43OAOg2r1DApf?=
 =?us-ascii?Q?RFsWRdjFRVyyqd5wVG+WE06VQ2HuXP4A3lk12ruFUhutxo6UBSeCUPullXe0?=
 =?us-ascii?Q?3mymsOZuVFchCRGBQqWnW9BlYPyFR8tAvOCQR/Az+sdkvmaOf9OwaoGW98fX?=
 =?us-ascii?Q?L96G+rsUndytDwQ1wSpn2S3kcuBky51whICLZTxXFO17qeRb6UE9gy+CInxC?=
 =?us-ascii?Q?FiOl/tQtl26Lum6+KX2KXwE+6twAtqFG5WCho+nE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b7216f-8556-4ae2-5193-08dbc9f1aeeb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:26.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VWr0iM5eW2WlSx1uuZZcgjPdR1Wp5g9TpQT2XV6EOfiO2VTcEMznb2vtMdR10rQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

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

Over all these things are going to become more accessible to iommufd, and
exposed to VMs, so it is important for the driver to have a robust
implementation of the API.

The work is split into two parts, with this part largely focusing on the
STE and building up to the BLOCKED & IDENTITY global static domains.

The second part largely focuses on the CD and builds up to having a common
PASID infrastructure that SVA and S1 domains equally use.

Overall this takes the approach of turning the STE/CD programming upside
down where the CD/STE value is computed right at a driver callback
function and then pushed down into programming logic. The programming
logic hides the details of the required CD/STE tear-less update. This
makes the CD/STE functions independent of the arm_smmu_domain which makes
it fairly straightforward to untangle all the different call chains.

Furhter, this frees the arm_smmu_domain related logic from keeping track
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

This relies on Michael's series to move the cd_table to the master:

 https://lore.kernel.org/linux-iommu/20230915132051.2646055-1-mshavit@google.com/

As well as the DART series:

 https://lore.kernel.org/linux-iommu/0-v2-bff223cf6409+282-dart_paging_jgg@nvidia.com

Both parts are on github:

 https://github.com/jgunthorpe/linux/commits/smmuv3_newapi

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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 695 +++++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  12 +-
 2 files changed, 447 insertions(+), 260 deletions(-)


base-commit: acbc9971cf0d3b9df17ce598fbbfaa2d5d0d7968
-- 
2.42.0

