Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A910940
	for <iommu@lists.linux.dev>; Sun,  5 Nov 2023 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RFFM+A53"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMayEK4pCD4RgrDqPzkbVLMS6mr7Y/BYZPaeicrZOxRhMCC8afp+Un7m0Dmoo8HArjjXSqlXjAoz776u1Ebze1D49zPzQWPpoWpHpl7EP4sGCf8z27b5lQ1GafFWAEraSIvJuQv6N4p6hcIlAts72oeKmAEwwdNOZmeOtAUkBbOym1rAeAW5PLl0QQ++1EXs/uHQReSmcUgiYLEVfqsusz8CjzQ9Q4MhSjTjaj2g76EBDDB639HaHzdKERXs+JAJsd0+iWXjkdLYwsrCKT7bwbZzMl8wNvteMLBHSIL8nCbIdzIpCgaBIDZlHSqe0i9IHms5kFxqNybqDXwkOxaC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eTIIGGZdEVJ/uP8Mhc1I66/nhFqHqSczGTlMPxm/cU=;
 b=HwFS1KSvctadQvbGabVRotSiE5eE1qAmxH9DKSl7L0HSpylX4MpEt5zZUtImhCMhb3FxvC2My2Ifir1qM8CbnequZ8KaP8O+a6+DZIUQqYaalvcrb3Vgbs11olkaPHWsx4I40Pa1/E2na33bIiz/roECezWpy9jK5NOTkZhzk6jgJEfqvhKhSo45c2CBCHINjoEDor+ppl+TM1QzJ3Daj4/wNAUmiOja5dV+mc0afTZTCiELMqpdz1Pu10WLS9F4kugBCmehAmeIb9YxSgvmItuMa0le1HICPsJx/G7CT12qp0TIla4yyFOtpg3uh6cdnG10M4vw1vtbve1bYaQ23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eTIIGGZdEVJ/uP8Mhc1I66/nhFqHqSczGTlMPxm/cU=;
 b=RFFM+A53I41k+sb4RXAzPyDV3+6JZxG7nwxJ7FwmmM5DCjrY/b13IDl5QnDs5qEGQsV51ZKN1eBniXNjPliUSGogJGjfG+kIFDCSrwB42bKyYLh6BwZprzDmydgIDt5Nva7owN1anfERncKzp5E0hkxXgChUZwDSRndfhOtyFcNKGNJFfkRjVsinYdc/0XEo5fWoXi50Vdq8LSQfFSgzG42Ek0PWvv/4DhdaLjRTbvhnV8N2BcuL4aymcaaooXVFihmfaKTQ0o3+HZpo+ansvthdmviYYKE769N5wv1VL2F5rJ9jI5/M7RmYgTebrIgfX9K/enzHd30frU5voMujuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Sun, 5 Nov
 2023 17:58:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 17:58:10 +0000
Date: Sun, 5 Nov 2023 13:58:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 12/13] iommu/amd: Remove unused flush pasid functions
Message-ID: <20231105175809.GL223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-13-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-13-vasant.hegde@amd.com>
X-ClientProxiedBy: MN2PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:208:160::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 08455153-b1b2-4e63-7700-08dbde28c5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hkpScKtIvsp6t002KunAASHv0oBENc/jlN011L0//tAE2dv6vUKrCIadgTcKVQRIKXZsyKowC2mRnNIV8rJ7e6lm1aSSdXq2GhKlCLvPsGgLxePK8SafAFmxiwUpGcUGSr+PB4UIDqa2ULywWSdWsserTxlfag+DHoFY/mxr8vaYxpBhl01Fk8mffUbVHdBlSJp5f4nYBwAZ8cENYeRvIbl3ACXmDdeC6+OdrOwbE6arBSgPL9nP7aLkdvvce3aTvoArQJy6N6oChoQTa+onwEbzQYEGBuR7Me5BDvJ5JVIbMJ3KESqnoYITVXFuiscFbbWann6L1Yd5U5gfMDH/SWwr/L7FvnMkffQ3uda3dBBkXf3V6/kLOXu1Ui/EmDuFO9B0bkjuwxZTqsN8rGwZecPEJAx+lGjhE9GiqebK3uIVQohAj/NhvaPRIIczlge+mal1ko6G+LoR4Wx2/EOhy4r3r1JnM5Em/L9cD/U0VwwlixzSQdYLyotzx+iTX3h4CIJoT0woTDH/+qbl/2RHKFf3usX/XRky4z+5zOBIzx9Is88kH2OIfj256jPhl6i3/sG0kYmi5p1IVgLcFENK+ExwE7LriGYVf6I1SZ0T/c6A2OgwTg6Ozurd7Ccaue0L
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(2906002)(83380400001)(86362001)(36756003)(33656002)(41300700001)(38100700002)(8936002)(8676002)(4326008)(6506007)(6486002)(478600001)(316002)(66946007)(6916009)(66556008)(66476007)(1076003)(5660300002)(2616005)(6512007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BJhoJ/lPoRQK8qLnlFGl13QzkVCJ12HVd1jA0XLO0KbaOB/FMi8W3vBSlHk2?=
 =?us-ascii?Q?Cl4FYy3UmFm+l7dyA9mmpf+FgxKltxKrR2k4Pol4+5QGYPjuM9s5azpgt6sn?=
 =?us-ascii?Q?LulbI4a0b1/kUgQNyWWaL+/8xS7XhDmv4cgsD9FSa+taO7fVmZmo49TQV6tc?=
 =?us-ascii?Q?qbOaBKkloyb1p6tX4MI2RVEOcR2b7xCdKzhda3l+CAgxxqmmsL+7l4tPEqHW?=
 =?us-ascii?Q?v/StRsB2gQdgNrF0K43RF7kZuycOj0hlfQFmmDVp1b8Iz9Or4vnl9KzmFbtl?=
 =?us-ascii?Q?CmhnT4uo8mMtWbJIh87CzfOmhqXCz4tLdpk81/TsYnNYfxgEzKC/ovLgAvJa?=
 =?us-ascii?Q?FYdRSZ39gfMnDSG6xH/MkbpbJ5IokSUASwYd1OEaOuvr7XeBhnYfkBJjedub?=
 =?us-ascii?Q?Gl3P8+CmfyuapcN/fvB5Hcw34WbY1JbQG/0QCeEPq/c78vHh1/z0qPB2Cnpa?=
 =?us-ascii?Q?+hsj+zHKxHMi/nncUXJMLblJsYlIrtrV6ONH2ZmPNLbXx3JARz55sDOx7uv3?=
 =?us-ascii?Q?f6YGsESuaVUmT/PACONuB6c+JaRjsGe6D/AemkU/dzrpgg15Gh+MtErz/Le4?=
 =?us-ascii?Q?DmvwnogyDEbZcljzMq6PER4vlnBX9iz9AmhKJfdWeawRvrifAS6AH9XalWlw?=
 =?us-ascii?Q?rUsq7MuRpfublDPMoW/pSyiqIwByPPT1VCjHYGpYbNNDL5DGSLSXVC5QEcYO?=
 =?us-ascii?Q?3YPuLEsuDhW9+hb9w5/Yly7QzWTICj4yxo+ZyWVLqqRC81YFlieGM1sKRDYB?=
 =?us-ascii?Q?dFWJAZaNpQOC3QI1GQjpuW0uQHTcCpjY6ACOawMUkfMcrYxeM/Vbssv4VrSQ?=
 =?us-ascii?Q?bSxEVBCkHoSudO2Cx9x42j10sjur/B1zmCghYmNni5gWmgnL9gXT7ku3LD1H?=
 =?us-ascii?Q?POtNY6eNPOlmsNZOvOe4dkGknn9R02pfEsM9f3Q29DgA1q1j8RBSTWHRKFKi?=
 =?us-ascii?Q?h2xMLi3A/e6XVOGlUMS5/w0OtUIuBDa1z2PY6Sz2ziYFkt+eKTagBKwggvyY?=
 =?us-ascii?Q?E0s1vXi+r1xkxv1pY8TqBzOhAXqI3GsMa4yK5BrGBD5VIy/44dNEfE3kZ/1u?=
 =?us-ascii?Q?yrvAQzOOgQkcZzgDp2zPSawujoK3ZWVcbbX2/HARfAWDFbXsJnWKE0ShNnXK?=
 =?us-ascii?Q?RGiOxzhsLMKgQWectWM/e5uhhNXOCZgJFsZS0BmeSPdYACJi3cZ26ulWRT35?=
 =?us-ascii?Q?iVkqpTzF96SHAYkudwOE90WJBTQluA83yjiHoVQJtl6ySBkFGccHQGp+qyIc?=
 =?us-ascii?Q?zFRQQ4kOe3ftu8qSqeGmbrfqMdT0G7uytK6TsbcEzECsJTUL/ebBRE/T+5CJ?=
 =?us-ascii?Q?43IxrzJ0m60Gd8+IlrNWU/g4b3i3Z7fRsjZyWqoC32wQ8awfjrbVOL6dZZwi?=
 =?us-ascii?Q?4LMpoRCYO0UPoE0ZwfRo0BsMt8IxdVH/t6g0/oC3IJuGyw2E+CykocyupADW?=
 =?us-ascii?Q?SDYfZd243H0DMDhW4fKnT9uPMzc+01l1JCrSGiZIaT7T0KbFFWWL9Ke3vnUa?=
 =?us-ascii?Q?NUNC/Hg1Qss1275ljMj48oSD2090DLyAewWJpNA9bwmATXTsPb3KiHAP57e/?=
 =?us-ascii?Q?02iYdWoM8k4yLC1Vssw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08455153-b1b2-4e63-7700-08dbde28c5bb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 17:58:10.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHjpOtdGUl0N7sZb1owSZMTR6KShBM6+8ghahzIeV4wWxgLWYGvPIKfGHnHcHHmb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219

On Fri, Oct 06, 2023 at 10:16:23AM +0000, Vasant Hegde wrote:
> We have removed iommu_v2 module and converted v2 page table to use
> common flush functions. PASID related functions are not used.
> 
> Also when we add SVA support we will be moving to per device GCR3 table.
> We cannot use current flush pasid functions as is. Hence remove these
> unused functions.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |   3 +-
>  drivers/iommu/amd/iommu.c     | 100 ----------------------------------
>  2 files changed, 1 insertion(+), 102 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 088890f9618a..38b3f4562f3b 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -53,7 +53,6 @@ int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
>  void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);

Maybe this addresses my earlier remark about _pages?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
