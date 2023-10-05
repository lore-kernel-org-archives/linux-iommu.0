Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094CC3FB0B
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BdmCJz9x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnH/qJ18CrzVbgedv8E2dDWATly1A+osLKe+NBeoobHiwwSvaXAY8jxJ3m7psSTyWLz7OUCpFMIyf6sIy423iiWhe4hUbo+VNG79q9Ms+ehgIO6kFLYZPXGXJr/pys1JxjczqH+Qi5cDlMtLnfgN66sasAi9LT64jQ0h94cQMMBQ12NKrtzPLnKlo0Ywu/WMBW54ePISQgb3ne3spcayppIzPSnZDjsCR+ckChKZZIjUwRpOcV8BOiiyunUHDTdm5KDdULCFu97CSUEyDH0jBkgerHlywZW8JkdQKNSkKEZBFcAylBXexOdotUePfx6GE/u71coEwAjyKuIrvHcirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yv4BKKdfsh5c70FtjLy7wdFoHzz0FbhWr1ta1SenGA=;
 b=QuSPYHH6UsXzYm4g+1RgJt1phFIcz9ysyliZpfCTNY2Xz9lgGhC4zyTaZIKgPd0NGhc07qeM0JHuD84TQTaE3mQZ9ujIZmMYg+hu74ckBI7UR/r1Tis3RTqBSnFk/VIx/iB/lj0EmNpnJCHG7fMcSghuQ90OyGqD/3UBCJvUcqZ6CelnEmyQ1ahxQZLoHSeuPSDentfJtVAnXTWZKQe90vVU4gRgGdN1vPm2psLeSOYKTH+paR6SIIY/Rjn9xP6Ru1c8GSP6RL8gChn1sN/Pki1X/MeDzL9bOqlG0XKELpxNoj4L00b497qhV5Ck41uVfdTecvbJPIsYhP0IjiBglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yv4BKKdfsh5c70FtjLy7wdFoHzz0FbhWr1ta1SenGA=;
 b=BdmCJz9x+mzy97rE37rL0/BYw631TzBAzoL+Jtk2X/KifRwAHNva3En2iMeGgdG2uSzkoWZSeSxAqjoK0xbQZ0rt4S7zXiZeCT3x6IuTPDpQE7PwGPW8NTWgA1LKAh5br4Df5HU/jIhnWHqngsuD+I0lepuREJ4FlUTW+PGdT/vUEFLu5rijJsBC9xkVYCnTD05qIJH1zusrGVayUndoPfnvCcHBWPPu72B6hSaMnw/PfpiR8WX8htglZ+kx78tJ9YUTUr1S/WpSCkjDeaGK4f2UweKLfD9c+ZllExsUX0qcykbMDKY31hr/HAnzkuBx1DaqBiuxuR7i5f7sWhrYwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 18:28:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 18:28:24 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 0/7] Convert SMMU to domain_alloc_paging()
Date: Thu,  5 Oct 2023 15:28:11 -0300
Message-ID: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXP288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: abf5f678-33d7-4fcb-d0af-08dbc5d0dba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RQUxCr/PKSsZSh+jYgW7qO8+FP6KlY0UqBNv6srWYql0PkkI39jCuayq2xZL2yMMUKwsvs+G4S/Ld0tTHa4IXSBlXXn2Npl26Z0g/p7B+66YRGm3bCnTk8qzgFbDroZz6Evc3rMo1nLugTyRZ86yRE19yBZnRaqxtLSDc3PpUQSiyZHcef43Y1rCjJki+qZrrV+U2E88qAZ2n7FXcuYZ87NvGISBlF0GTWRmcwRvnO+Ywt1mvOigRPA7ju5sX8gWFs1us4pGwHFWn0V1qaPlHYy2O4V2GNr+uoaBeEpNulQLVlDM7zGs3kw33wRCbhymfnJFFpWvCayitFO03i2J8EqJ3YpKiynsBh10r9BK5Jt7QNN0XO98W7ZoSCT54l1AW6QsTmnVTHeNRNo8AjtJH3H53w18ddcMNHY3v+tWZO2Bp60zK5gWRfX1kmxCG53K13DHFR40er3s/QBWdqpCa4UjyKxJYU/ciddbYQ2Mjn/ZT3QrI9WFGGkmzqsfUzJTVs8ybjWKRPj3SBQRM2fam9BH9aSVIfoXMsQ15Yy7ZpOdtzT3us87CAvryz5vHhEg6KC1GmuDSxvMHgFH2WO9DTodqS/09VUHM07VL+qkqAuGTEHA6fFFUIJeuPMCrcnPT5dWIjkrzG/kUp3kBOpVwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(2906002)(36756003)(86362001)(38100700002)(2616005)(41300700001)(4326008)(8676002)(8936002)(26005)(966005)(6512007)(6486002)(6506007)(66556008)(316002)(66476007)(83380400001)(6666004)(54906003)(110136005)(66946007)(478600001)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?527kM8rDPttz9iTi4IKZ0XWJfB7EBPTlWPuAMcqLMTRmtFYPmope7N2HPMRs?=
 =?us-ascii?Q?Ng7k83gkEhl/FD2JjNd+3dQqxtZa3HX6jUO3BVv85J+oVfT6GdAoLHAzMVN5?=
 =?us-ascii?Q?cXnTo4wHzZzNmu6g6ivJPFhmmeW0YNdEQeje+OlDhsKVrEtI4YSDaHGYXD7x?=
 =?us-ascii?Q?BAy8st5TWYxVf9SFDOl1MuZzeXLAYjJ7o5yV5/IbOh1t6OAxxIXKmfW2bWit?=
 =?us-ascii?Q?w7hzQtNP85jQ8dLcbGdyGekWSWvpluLEvnnfre7ODnCwf93mu398pcdy+MHP?=
 =?us-ascii?Q?yZDgkUIzqNHahL0biKIwEzuGEiYJj3HlplKhE6Rvnktbu74bJf4LbO85fn+t?=
 =?us-ascii?Q?E+g9d35C8lR6J096pybX002t+gWLXIif+jQXkw4fpo5vohDoQ3jXpLkast2w?=
 =?us-ascii?Q?PpeiB40uKfubwxTciv+QLngNbttUcjnYkMYjaUFulYOfJJ/cxXyvVKPU/98K?=
 =?us-ascii?Q?zhW9nGOJfoxYYny6nVNdQO1l+ahesjdQnSp/Q2F1tnKDlKvdv4NPceZ0mev0?=
 =?us-ascii?Q?iZESJdrYUNJ6TJqnBVxhpd2EZkjItrrhXZ3kjoQ0uOt4OYXQZFtRHdYH2aJr?=
 =?us-ascii?Q?CpuyQMjrsRxXATZahMkXJ8G5gPGur178/xRgvkwjaUn/UDy13mNeR03vhTXx?=
 =?us-ascii?Q?LRV+/PLEfJZX4rU6QkGfO/frqjrNUpcHHjzv76/8z3kHDxqSw8Hr3RBWJuj1?=
 =?us-ascii?Q?WeBhl6Wu7wIzbd7g+eg+K/sdWxwIf6dIKg6JD/b1u9ZwmOuN+clZu9pxqKxm?=
 =?us-ascii?Q?J0ljJa0OaoNVFscGrE646GsbUR49RUhuCXklasNS2WyBjqBI5IoW+MoAtTGR?=
 =?us-ascii?Q?4s8OCcu/Vc9DrNf1Y6WBAei3yYlaYI7jWA/UXzLF7rOxYKh5v27BH4ztW6RB?=
 =?us-ascii?Q?AUY7ay5SKl/qIiGWYJRAQGnLEofZCNV3PS/cHzn/yZmS5D0eNqToEz3IpchQ?=
 =?us-ascii?Q?9LH6gvkcN1RFzE2KCRVA+/3aXwYfB8m+GFHwNba1XWsRpHdi6dui/bHxm4hr?=
 =?us-ascii?Q?NaGyeUT5WUiUw0H/aBSNnxSRym1hTmwKhYApH4Nuwqp4KsYHnCOjxOeGOu3N?=
 =?us-ascii?Q?2SSeBOD3y84h0U8styALtfEnlxA7syC/n+Zvh+T1U1rLRoVALdg/cFCGqIj3?=
 =?us-ascii?Q?8M6nkr6Z8g5uC+TWOKiSv1Q0rYbtyK7WlD9jPP9tTdZAP6KR+pV1v4Dl5wWm?=
 =?us-ascii?Q?7s6NfbAS1JbPQkSluZAM9AY5pKhd74Y7PneBlEMMbgQhmUMdTv6/3fbCVAVS?=
 =?us-ascii?Q?jnsAWY7M6hQ+eybKfY12qKXgW1upYd239tZ/VcSXTRwXfxitUp3idu3s7+nr?=
 =?us-ascii?Q?j9jZShVp7lptGG9h5lGiIu2zpFcQjk2E4u+5tRy/Aitqgd9Yiu1wHp/hhTJd?=
 =?us-ascii?Q?WAybYlb2T/DSNVonmZ1C25EfOPLsejjVrFf4xflPi5pu0OAKtlymGorM8ye0?=
 =?us-ascii?Q?m6OwpsoHJrvvwPgFu0MV+YGExpGsdEHj1zEmtD9NGAROv+RZirJSIkipXSTF?=
 =?us-ascii?Q?gDTmEG2No9nfwFK4w626iBYGlnKCCkpm35C5vdGyAGyvIryx+LBzo4/SD4ps?=
 =?us-ascii?Q?61LwMzOSEpj3dLdm8LD3F8aV1gSIaNLsiolSvafp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf5f678-33d7-4fcb-d0af-08dbc5d0dba2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:28:23.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkT8BfdO1PPlGiXuLEEWH+Ow00wNuLaZxhVpGPGvhZD0FM2n11oWaEAypJZez7un
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

Add the global statics for IDENTITY and BLOCKED to the SMMU driver and
change to use domain_alloc_paging(). This allows SMMU to finalize the
domain during allocation.

This is a bit more urgent as I noticed while looking at Nicolin's patches
that the disable_bypass module parameter no longer works. The system will
boot fine but the domains will be set to IDENTITY now. To fix this the
core code must request BLOCKED domains when using ARM DMA ops with this
module option set.

This series fixes SMMU, which seems like the more important one of the
two. SMMUv3 needs a similar repair, but it is more complex to get the two
global static domains into the SMMUv3 driver. As SMMUv3 is primarily an
ARM64 driver this is less important since the normal DMA API flow already
substantially establishes blocking domains via empty IOMMU_DOMAIN_DMA
attachments. Regardless I have addressed SMMUv3 seperately.

This relies on the first few patches of the dart conversion series:

https://lore.kernel.org/r/0-v2-bff223cf6409+282-dart_paging_jgg@nvidia.com

To enable the BLOCKED global static.

Jason Gunthorpe (7):
  iommu/arm-smmu: Reorganize arm_smmu_domain_add_master()
  iommu/arm-smmu: Convert to a global static identity domain
  iommu/arm-smmu: Implement IOMMU_DOMAIN_BLOCKED
  iommu/arm-smmu: Pass arm_smmu_domain to arm_smmu_init_domain_context()
  iommu/arm-smmu: Convert to domain_alloc_paging()
  iommu: Compute dev_iommu->require_direct sooner
  iommu: Restore SMMU "disable_bypass"

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 133 ++++++++++++++++++--------
 drivers/iommu/arm/arm-smmu/arm-smmu.h |   1 -
 drivers/iommu/iommu.c                 |  49 ++++++++--
 include/linux/iommu.h                 |   3 +
 4 files changed, 136 insertions(+), 50 deletions(-)


base-commit: 4dbf5230cbdc65dd71a8df9e0710e66f2997057c
-- 
2.42.0

