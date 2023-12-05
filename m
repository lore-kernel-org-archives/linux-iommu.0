Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A555C8E4
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LcaQW0zG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5AdClBd+daL0UTDA/XlcX/HQ994Zbpo9l52U7jGigHZUSjPaNZU36P545l+LFxu6tj/zDDCjNllz6S6FCo3mrcMLhfUh4gDe9fHe8QrWvjkk6QT6yCdCxx6nNh7cfDB+vkhAK4ds+ZjFl9r+BOM/HA0dnEwlg1vnD1Oc7HYO+mOUkCpiGIvgmh6xgbm4f+w5gfnz2oGbAi2OI7rDcB3Os/hHWdCNrSuejCUNHDURN2GOOwCzYgEYEE6nruXtY5Vuz+37WVDBeXC/HYkhDSVki9XkSgGH6TdRhmVv3L5hEXexHEtY0ZMLTcwscNEXc29wVuolKpmuB4IH3lnL93H8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY+5c6yBq/Ev4Ay3x5/UKtDbo0mtyFF+/JwgsG1r238=;
 b=YX+JKUcM6LA67sqQ43WShFgvZjpQkC/BWPCwU4cmSNJuTPOhz3PLzZbpQ9CsOs5xE9cQqs+gTjD0a6JjqX++YtdI9W709fcGtOYMxWWyk/mvqveaeS2zKltgoXFob/PE8Bn78zgmWQVQbhjxIuf6kPVpsHoJ4WgiSVfNAwe9M/+dK1Wi9wff2fYJ508rYcf+4i1d+Wkt6uzFhBlXDes6FnwfLbKURE2uGi8rmtigk/DrK6S6frqAScaU3h6kEu7kjuSdNfkMATjpBfFytPyWUPt4QNrRSU9hULNhG/M2rdGtzdeK26R7BjlFdSD6oOoZhYxXHfNjBjKQc2LottAsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY+5c6yBq/Ev4Ay3x5/UKtDbo0mtyFF+/JwgsG1r238=;
 b=LcaQW0zGAY3YX9WXl0ZGH/BYYNSjB+mVcwlkQ21z3mrM8Ec6mZpAd7DuYHVkHMz5yxcGCKNjey+BqsWDeD6ToEQ/K9sxQoAj/pCmxryfwTyHQf38kXta9/Wh89OcmGFHXqe6GNS7advJC90/XAV6wK9a60LcHR6cFh01acqZNQZ8bYA7OMOLdvAp8l48L/XCo0kE9aWgIjD4FlsbhsNXt77rHPLp6YLlkEbCf/MRrcIBwRew5538YZO9p/FtNBqXa1M1EPvWYWYbopLk9tYEj/8FJFc9xjw97/be432izLCW3yWFwnRrGNkJ7LYuy/HgUrLL0j+b8XOM3KEvDAnaFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 14:48:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:48:58 +0000
Date: Tue, 5 Dec 2023 10:48:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>
Subject: Re: [PATCH v2 10/27] iommu/arm-smmu-v3: Move the CD generation for
 SVA into a function
Message-ID: <20231205144857.GC2787277@nvidia.com>
References: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
 <10-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
 <ZW6S8CPK5UQ1mYpa@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW6S8CPK5UQ1mYpa@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:208:23d::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: c98ed2cb-74a2-4acf-4f3b-08dbf5a14ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sFX9ng6vvckPIgECDn9F6rBZ3YH7aQKDvenvfBItgwUvLV0KPbt9KWIvwh9VX9tm/Vk5M2QViqgnwCVrLpYRXwDLjedbUNdTZKUlj6y22ywQ6TsKtqe2gutSPHl4ypSsPReFR/GHh4YAgzJs8HQzJjre2lz7XAJ+gNLjAR+qjyOo/25loIrR2yA98uZbUKBRR+LaAp7WDtCETDK7WATIe6QzWJZA5TqLdE/YJOLdye79gubNVV/+0s0UV7LzBj97eEJnxfK70kWmtMAqqLhyGF52fla6ibr0Vfr4q1nmL8i/bwhatIh/HLom4SMltexGCgD0FltCM3Ey9Ov8TT3ksKEb74JBHR/vG6oz7Z94ztgmnCAMq6IfcAv7PaGFGspYeWPusq2Sme86COmk86z8zkQaZAcEG2LZECL4Ud0wJqYd4lipP6YvbNOZwP7l7+pe1AeUCoyLWuRLw69M7yMtwz/URXRwLVnhE0X6x0SLiirykmIvXhVmC/ZZZZpqvqKWbb1OOiHirykiel3mDk4HV9JbfhUAD3Lri/d549vRrr/rPZzboBRpGkHr4K7M8ZeT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(33656002)(2906002)(5660300002)(83380400001)(6512007)(26005)(6506007)(1076003)(2616005)(478600001)(6486002)(41300700001)(36756003)(66946007)(37006003)(66556008)(54906003)(316002)(8936002)(6636002)(86362001)(6862004)(4326008)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fANb3oLCyUxv5h9GRzElm7MVTfC0BmTVzqyBAxxUMB6C1GbDVhIR7CMcgl2S?=
 =?us-ascii?Q?WsjrQnZy9AXEjlN6bCRfgH9BP07d4fH/tYY7VwehUxl1XaMtcFZ/jRnu070H?=
 =?us-ascii?Q?aJn8wPjk0jHRvIPL+ig0+TDLmZjPv/zNSrBOlRtMrXzWam6H+tHB19f+aouU?=
 =?us-ascii?Q?mxF//ovJQt24OipBvaz/ft8G2jCTd+ZL/4ZD+EHVGWlorLPEqEw9TOQjxSMT?=
 =?us-ascii?Q?O+9PF1O5j2jTLye0yAyRqgvx0Wv3n41XoMuW6Rfo/dhJtDauqh4L0DPaSZwj?=
 =?us-ascii?Q?i7V2E3Z0i8HGU7hJwjV3bO5IxdfSy+0Zo5dTRC+C9V1qJxWYUZkIKPOnR1EU?=
 =?us-ascii?Q?WJRPDC9DyqZuFiZWIMKTT/Qw2UPDTnft7/JqFptR1vNiW5w2MCm7sma8m3m/?=
 =?us-ascii?Q?vPO8+8vTiHY+fRSzTLzMNF2pL0kyTWmrB5e7WmFI4hgWmt5d/f+EY26FTVH4?=
 =?us-ascii?Q?GGDaNSpLToBFeNhWi0X8w7a4JeNl3jRCARE/s9BIYoRBnQjRETXQveV91LDm?=
 =?us-ascii?Q?9UOaEmj0XCUe2XW5a6yfQl8dVL+8DnN89BhK1jOohDyd3anJ2hWvfORxFV5R?=
 =?us-ascii?Q?zwlx2Nh64AndZ6gJ/sXm3OTvAMz8FCS0QhzNz5KxAHtYUv+hYpP56NQYAmPf?=
 =?us-ascii?Q?6jwacC5wzOgTl3gswy2KSDSL0vSfAtM7b3f5ewc0cwyDkA6pQyZVGc5ZTdVV?=
 =?us-ascii?Q?F/9O9hUtmRMlDyS5Z+lCWvvgSVm+vomRIe50W/FKA5OS/N9ddx9uD0x0WtG2?=
 =?us-ascii?Q?St+qrBD4XgEChyagGUTPTOWnRvmW/7GAXBuHiUY05P5Us+I8HRV3hTnuKj1H?=
 =?us-ascii?Q?1C5msgGWuWNMUvxJArVKExkzLhMvBJdfLAI3yjg5rf4cL0vr+oIUVFmPNg1L?=
 =?us-ascii?Q?5pBHpcmVkzjernleqtwEBSLivufvdKcsSBbn0t4tye1jWmwuD7cUqACt1GtQ?=
 =?us-ascii?Q?ShVLvUcU6oxSDi4L9sL2HHEvyWkT2tsnesiAQL6sejndxD2jhPPabN1B5nF5?=
 =?us-ascii?Q?vCBav3N5FVqbnMVTvYHi5+ZmbRfoAJhLN2K0FRlDDwXakhCdMpTdmqEwK61N?=
 =?us-ascii?Q?ZV6SRm7wEvrTMAb8wQ7j9x5O7zX7bPebpEK3sZjQUywEAN2flS7YsFsWgxZ4?=
 =?us-ascii?Q?zRCEC1ANexnkObJC7kiZc7UxFi8zq1b0k5nNO47lB5DcIOa8l0Xep8244lPP?=
 =?us-ascii?Q?TrSDABR7FsLqwg1ihbZGF86AYs1lBepqWNrXEBBGkb7gZtZKj6kgk4ipnf96?=
 =?us-ascii?Q?Od7/4X4S6LJMXN3t0a+lyDrJPit1cGkqg5wsWmzPf9wyC2c4kFe5ED4uTCxK?=
 =?us-ascii?Q?Ynb+aksdj/JTsxNqk/5D6INRyrmXLP0y0UTWQByASzruDZ9WfFa/8SdcJIrM?=
 =?us-ascii?Q?KA/08q2RQd6U3AxQHAHwH0aNHlz0xMlI9aREYhyIXq/e8B9bWfxMMwADuGn5?=
 =?us-ascii?Q?aJ10ZZnRV9tZFkqrTmARNjsX3U6lMdjJGxDLaQRK3rhRSIEdBMZL/J0PmE2i?=
 =?us-ascii?Q?dv46KniBeVtYWWeuNLNHu3/iiStaMSqS3ygeqwugZstVC2k3oF5yKBqdl9fZ?=
 =?us-ascii?Q?hatx5FQOeU5xUSg1e5j763RUkrXvmnZUoPv5llru?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98ed2cb-74a2-4acf-4f3b-08dbf5a14ff2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:48:58.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv8e9Pi/z4n+IY83e2RgXLY6sr3tDIOQp6ckosgEvjzJq1YKolGyr+8dqw5vDNcT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489

On Mon, Dec 04, 2023 at 07:03:12PM -0800, Nicolin Chen wrote:
> On Wed, Nov 01, 2023 at 08:36:28PM -0300, Jason Gunthorpe wrote:
> > Pull all the calculations for building the CD table entry for a mmu_struct
> > into arm_smmu_make_sva_cd().
> > 
> > Call it in the two places installing the SVA CD table entry.
> > 
> > Open code the last caller of arm_smmu_update_ctx_desc_devices() and remove
> > the function.
> > 
> > Remove arm_smmu_write_ctx_desc() since all callers are gone.
> 
> It seems that there are still two lines of comments mentioning
> arm_smmu_write_ctx_desc that should be removed or updated too?

Yes, like this then:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 50911116460669..824e725f905d71 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1109,7 +1109,7 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	u64 val = (l1_desc->l2ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
 		  CTXDESC_L1_DESC_V;
 
-	/* See comment in arm_smmu_write_ctx_desc() */
+	/* The HW has 64 bit atomicity with stores to the L2 CD table */
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
@@ -1343,7 +1343,7 @@ arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
 	val |= FIELD_PREP(STRTAB_L1_DESC_SPAN, desc->span);
 	val |= desc->l2ptr_dma & STRTAB_L1_DESC_L2PTR_MASK;
 
-	/* See comment in arm_smmu_write_ctx_desc() */
+	/* The HW has 64 bit atomicity with stores to the L2 STE table */
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
Thanks,
Jason
