Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E210940
	for <iommu@lists.linux.dev>; Sun,  5 Nov 2023 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T1mgBu4C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kw0gcr1qVjndlQeVEQzSVQJ5ghn8VOcck19YWgd8g21jcsZkp80ltDoTKxAkI5cB9XPFEYEoPD5iEl198Ic42GJVzumU2BqWxsNgJBwu0H5NfooLrzIdAr3tw/h2O0V59F7vs7dSKr3uOu+bbvfxS7KeXTu3r8085s2lXj6t9yb7C56Y6zcQ1l+1aXxfDq+XI8XP9az4z3fo2yPPkSKhtzPdt8Z2zu1c17/ptWRRzCoMWRt3/iLICvL72pEqZtgS3kEy0fw0UWz0C/qqGRPbuUvOBXEEjFjvW/jQxSp355YIh3KNypbyApCp/SmxaWU9Mm/fqXrgLRPtq9LxZls3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn4nLzSnJTUPkmIz/E5x2QwGnoaMzXRGjhtrptAVs/E=;
 b=mgEzZ9M/AyhmXz5wkdq8jTzfhOMuOaZDJpqbIC5tNFPKbsYxZzG41mah5UoVjDtpf50xe0FDEGhuYk1PggZwlEDOgFBnQJDTVDVcSN5/M6gLnIxBxiauLwcd+RzboRP4g+Rz6oGayB/n2NYBqERV7oJngnNbQaZunWNroBShbh9TcOkm3MLSlmJWZSh9CTieWTFpaNjEOTvBnvSF7k4aP8pFWznQaM3gMRGFJntacDG3vt0SXtHrX0yHwoGs451jvxIUJg8vxgkX2oSv8q4U3qnQMYkYstZTEkV9yLVfV4kT6kWONtCEeuNr0DPwv0PIJivdd65i+xDn+n8MjUKNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn4nLzSnJTUPkmIz/E5x2QwGnoaMzXRGjhtrptAVs/E=;
 b=T1mgBu4CAdcY5lUesJfD/bX6cFE3Fq4HW4xR9pb3KQhw03VcoeJyE/4AR+zZgpc7RsgPz4eAMVT1+1iJx5lpkniKbYYtrJTdj6QPq9S0EXDKSsmsFReB1ank5v+CYlYxas1+GbFybXL9wEDiQynY/4YwX3+zFmYsXH4YlUZqxThRZ4lJRDPTEcSeRQK9fOlNx95iMdtiEWwDNv/Kdhyri2ell75SvThK2km13mAHtDq3AeE1OUQNkqUDR3ENFWdBjHsZ4EdQ729YhQRHWDZW2hGNFwCjVzNh7DM/0WU0YbRJACLygiIsY4i06SeOJpJ3SXGofd8vzW3UUM06RlCDKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Sun, 5 Nov
 2023 17:59:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 17:59:50 +0000
Date: Sun, 5 Nov 2023 13:59:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 13/13] iommu/amd: Rearrange device flush code
Message-ID: <20231105175949.GM223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-14-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-14-vasant.hegde@amd.com>
X-ClientProxiedBy: MN2PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:208:fc::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bc0c8c-f721-49af-124d-08dbde2901aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9cY1vdRRu8sS93dtE37aHC79DP7Tg1tPLuaXuDIdi1re7cCyFmV4NrXJlCdl4eYAxZ7PLk1BdPIYmjpOD/k/UbBov+VyF/93BlxpeN5X2HF0+MfqpB4zXS+IlG5vN3WiuTaM6h9GyYwEtBg+nICO59kszCg6tIbYvmfm5Ik2sLKwxrZAMLazVtzs+wnNtC1birSt55e/FMr6+Vm1YcMS5dmga7PS/rmI5n36QAQD4CCjR88Hs/0sFt/OgD2+HpyMjBCOE12Q1ln3p6CCDqGW7XmMPHQxe63ZxxtAHlYlziAxlF9lJ8hiQlQmQpNnNPZXq4/dbmMWDE97vmB58I1WYflHNyVXUOw+njxpDmqnzGOcobqCtcWKsjE3GIdgIyQHnd7N9FVrDfgEIgDsOJolMD/tE2ckRwO48qhkVGJzLcx4o5MOxs+n2DwCFPOk6kVMHckgqmsSAivaDlYpPnyQmnpBt4G+AvQlJYNY3vPZhknuGwXujhBh6zKsIQ3GW6BKon21bGTadk3p2D//RdbVOZVgfW6msYuOuFS1xGCcsNk8Z5JOXwdDUEx7HbgW6vxoiVQOgDzPrIV/D8owUy8HA89+u6ThqnMNIGKHQTSSdncQnMUaG2QvBUV1N/5mKIDL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(2906002)(83380400001)(86362001)(36756003)(33656002)(41300700001)(38100700002)(8936002)(8676002)(4326008)(6506007)(6486002)(478600001)(316002)(66946007)(6916009)(66556008)(66476007)(1076003)(5660300002)(2616005)(6512007)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2LfGI6Ik8gVmZQ+ft1XqAsW2g/aRwM+ptHQrbQzsEhVR3slNPk+K5TzfK96b?=
 =?us-ascii?Q?G40kYZwoHiKAgbmtZY0ywGgscJzB/7oew7d8lXVraMNYGcx3gzlLBCOJeiXj?=
 =?us-ascii?Q?LS/dGMQmUQtaxLCMrY4LV9OmondGR2VWUrgPcE1nR2D7eRi2+uOziluDV9xE?=
 =?us-ascii?Q?Pwdf332hKZGDXVWqjKyngOaHvwa7ZCFlsxDBmA3qOQwcy0qkZ+9fg7MH41Xk?=
 =?us-ascii?Q?B2BovDKgbOISP5Q0RABQTthhyYv5HeI//regi0fDejl79sK67ONQ467VsWfe?=
 =?us-ascii?Q?fZiDSk2XJaJVUUuwT7VJeeIQUuBp+tqLk2vz8bjsdSKsliUgqMKIcCCrl3R6?=
 =?us-ascii?Q?2IM84se5TUjkQHGyNtDcWU8ZVXolrtq9KWkrSP4w9LjOHor6NFfs1UNq0AYt?=
 =?us-ascii?Q?219przQ7XKk8BPjzEgbWl1JKoF4x58zgslmSKVHrxj70SzVS+PZyJujJXVsK?=
 =?us-ascii?Q?zbug4/h3x/0L2u81ko6gKF4GWZFF7L9Q5/K7KxAg7Btru3DKNhlt0JrSnagU?=
 =?us-ascii?Q?985rj0u57RobG1YGr0ZJ0+4xJHTpg/EUTdnaQNQjNUjeOLlds0d7CBbCxW57?=
 =?us-ascii?Q?RDvQwBcvoAcJ2JdzWBCoeQEgSUtDwLbgb0qYzJip+Se/nbW1I0Jegyi4TGuZ?=
 =?us-ascii?Q?gHZQBywcowcZYxTDRWIBrjFrs1nmLItjRJFxe1L2JXGMVCFdIeSkC4xz8BJ/?=
 =?us-ascii?Q?ZoFZGwty6t0ApOWC5rJeeVzQAw/YCMS7oT5WtqDqCaFJXz64dieagF2TA+j7?=
 =?us-ascii?Q?QqADs0Zy844TwMQKeEEK4Iyx1HM+TTWSEiIqUNxVFQk7m0+24hciAtKvQyWd?=
 =?us-ascii?Q?EAMDQcvqlMLKxFqSTboqJ6dKzTHooSccqEkqDCukBri7Znk6KES90QgXwQgw?=
 =?us-ascii?Q?ztuJcJq6Qv5H0GjyzYZFJJka/v094T0mHv2PN9oK8toZH1KHmd+2I+wJnLo7?=
 =?us-ascii?Q?w4W/HNMSlrZg737iKZ5iY+HOFKUAq/8lez07uxWXxVmJZIpO3DDbVVn2PNfY?=
 =?us-ascii?Q?TYEi9R3Am+y464LZZ+oWkoJhvxSfPu0Amt2O72j2o+5lx88T7TMfnhfSogY4?=
 =?us-ascii?Q?ouijYEQYCybE6+LhV12ZNHyF1KYi+GSTgynrtZSLgCPYof7zepsFV9Yo4BoY?=
 =?us-ascii?Q?rVGhsKWJCRPPKpFmkXan/0E6Xnhv1xIZGAx4PO6ddsWYgRk7aJ5Bke/PQ7Y1?=
 =?us-ascii?Q?52LA3/M1ZU6YNnOG62yIQD8rbs2QONmmdVdyXluLFPff8piUZld9bEY66pFF?=
 =?us-ascii?Q?JcJhFaKuxry1iHgkjwZVzgsN3BqEr55V3+vnSxLWueQJKAuESJXWJsFjLSkt?=
 =?us-ascii?Q?+zhVQZLqFTO1S32j9mLh7vCBMLRM50mJ/9BvKEYLSR1OVCV67J1uHCr4whII?=
 =?us-ascii?Q?0SogrYAluudjpjflhhKcRKMobO/WDJy4fQmvIWeSZnie8yro9OI0mjeg9+o/?=
 =?us-ascii?Q?q4QjWn9Owl7TOWWVuc3l6hek4iUBvrjMAV4SxDO2OuPbU/lqkRm//bC2vQus?=
 =?us-ascii?Q?pk/tFGLI/wyMlbfBTqFvkRhKE7zG2WVmyo1CTcMFN+/LHDfpV7c/9VcRGIfp?=
 =?us-ascii?Q?iNi/YowozlYtkJUwhaw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bc0c8c-f721-49af-124d-08dbde2901aa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 17:59:50.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVqyx4XBDLgwdD/yFtu7XM68ro5YeOjMoY+sj3CObIAp7Nuq8/9qexjDk5GguJj2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219

On Fri, Oct 06, 2023 at 10:16:24AM +0000, Vasant Hegde wrote:
> Consolidate all flush related code in one place so that its easy
> to mantain.
> 
> No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 105 ++++++++++++++++++--------------------
>  1 file changed, 51 insertions(+), 54 deletions(-)

On one hand I wish to do this sort of code motion quite alot and agree
it helps maintainability to have like with like

But, in Linux I generally discourage it because it overly harms
backporting for quite a minimal gain.

Jason
