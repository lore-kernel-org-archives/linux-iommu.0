Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090C33CEA2
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573712; cv=fail; b=ptHnaGm2Ts1IbxTuWU+qrmX0Bh9dPe+UrxbUTempOPGFXAuPKjrymnnx2ARSLt6jBy4ZlTT057eBDs2hntyVuK2j+CoMLLJAGG6tOR/inFP840zjkXDFTRkMdVJjzDI7Tw95Fw6fZ38e3b7p/2fTU91LAU09x8/nokiQqraSkYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573712; c=relaxed/simple;
	bh=JT6I8raCSavNBaEFEsh0s+8uPTrjOwKiikVcilOUQvA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jr2ueFkfR00773Gtbpm2E9FDN9wIzOZREJv5tLgCkF+R+Iyqsu/CGQBm9FYTGJyzyWUq7Iwa6tEZGAk2hdJyl/5+JhcOiVUl2w46V+uL2pTRuCNoSty/tatj5WPfLnf4qEmLXWuGT92s6bsjk/Ua5n7/TocA9Nfium6cafNCuGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b4+zCsIZ; arc=fail smtp.client-ip=52.101.56.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b4+zCsIZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ne/YU087VH6YCHGY63QyucxOXoPf/k3DtktR9N9GMGeW5NE5gyoFQV68XEPGrUbkghQCXcHZzWwShjHsszJcX2bS0rFcRPyzbUWi+G754ikrvWDnHQIxChA3KuHgviw1CDpujLlqXviyzjjz3oknSCiGRNqYc3thgmE1ni7LCbBvmyLe3jyr4tLG4RQRqJxD+B+m15YthU8C8A98uJI/mU6PQUtCb9OGobP7C6krmhUgT785NtadDmXFH5QtpY7fQkBhgRhDPzpAawA+OUlJXgVE/HI+uhiGeU8WN8m1cpYKRhvLHR3YZkcxVi3YxgONqd5tDFTG4i2JEJ3GqV+V9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbxAslW0u2ByVlGEuerExqc+lwcFHQgTm6X1D2Vmd34=;
 b=mixYpvd++w+EDwtnshktrhl+R12opEuNheATmN8WezYyrbkB7JcNAZ1UAzQlp7IkxaVcEgyO5bpOUyVG0Aj5oN9TAiORSRTdx75BkIEMuHuvo91iIn1WS4xt8qntyp49srCPDfPSxilqG3JqEFAcPSKCXsZ/xBFwJ7W2xXt1JJw6FaoeTzPlcPsPC9LhvTEK5+Q2Wu3MUCUcm9/EFwiL710tZBG4rMnI7eMap+msBYy8eQ7yvKRu5p7X6scNDX3/FyryuPs0YzsRLmtDGIfFKh8kJQZYJiLqFj/e44D+5BAjer9C9sacxYTu1lWSDKNxPFsUlf/7CkeUQ5hTFoPLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbxAslW0u2ByVlGEuerExqc+lwcFHQgTm6X1D2Vmd34=;
 b=b4+zCsIZqnzKKW641WvCmUBfWY/3ePOmOLSllbTzZX3641ihk99dwMPTiiphTx6Hgd+RaE5G0bBwv1MiuDgy3R5ZKHlhUUqz+pVI4m1PBbrFVjM9IDvQ99M4a0T6RpMTVDxwwOPJ+Y0f83P8y1eYuNzW2wT+9ESqTnJpw2xiqUw=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 14:55:02 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::a3) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 14:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 14:55:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 09:55:01 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 09:54:58 -0500
Date: Tue, 7 Apr 2026 14:54:50 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <iommu@lists.linux.dev>, <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] iommu_pt: support small VA for AMDv1
Message-ID: <ypienrpgwpgpssxzzorydvuwmwxnnmfwj737xs7mbohvurrhdh@yzymquzqv6dj>
References: <cover.1775045213.git.Ankit.Soni@amd.com>
 <62cb55fdc5e08dceeb6d740cb73f75c6bce36226.1775045213.git.Ankit.Soni@amd.com>
 <20260406132812.GE2551565@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260406132812.GE2551565@ziepe.ca>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf9436a-9cb7-4961-b6b7-08de94b5a5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FduBWnHaz/GwzUcB1V4JAo/CPopMjDFOpZY9QPaeEtQoQg4VjDtpPECgmZNZ8HUIaLnMX2LDePVAS6ynVLJRx3bQOnJsTBmIl/T/H1Tuat8PBFtK7EqiqsOWANHhqzEx6ndhqpB+ienvsd8eEONTo1KqGxI6F8lTvbZ6PJe/My2Wzx8gilC9fFNC0/uhZQdrZclszYq/hRemkZxEzxL9h/kQ7BpbqTimXw/1ya7067w2dW1PEXG7zlZK4HlMc3idTiFGnHX8P0mbZ/N6hYkSsX+7SrdNl0VQ9z0/ZzRDFe1PlGTl/UBCTYfujdaDNOENJc1ZXLvqrCzkK2CI+zQvKaPKmEUWNtFFo8T6KNF11StDqc5D4dQjq3WWpRFIbd9xNJXYzlNNiyVBEar51gx8YeSiIWOnXKEYyPvO8PAUiObc73HFCjPBCmcq1cv0AxnyuS7wrcH1GV/aHD6MHp0JiYCyhnT2qWu2GlfJBxV59CzD5/gnvvcoUJORciOweuIq9uMsJvKJwtmUgFoLrb+afBV5CCkNk4HXttOAq4640MfHRBtQfZQ2H+mq84mZcX/t1PRm2kfqnLdMAF4YY7ZSVAFaZkccuBVYXY6ial0u5vbbj0OjJkmWlaKt1tSa6yze0/+aNUDdGAGd6t+9NJjyKoWX5lQiXKlJQQnkPlyCNjOXlJXiio8LsIDrc9uHy312SUO+FoDNNRz8Mz+1jvuclrv32dbTmeatmNonDPtmcJyfQEdrrlaYYPoRjbEcrFblgU6rqlfytM/YxkLcp6WXnQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DODqD/TWZDKQXwXrP7poYXgSTt7ZWgjE7f97Q4MAl+ujDmYjDN0bjoezAQEdJXo3esleBQrvLPFjL0JhRaPlCwcJOeUolKlgUSzS+jeSY0yntrlEbcgiswjalyxn650AbupA+3ghPn1YUQMPZIL4WOOGfaZxKUs0E+Lm10H/fo8412rajiNPvsGZK440sKGCBmIUBAltjZOpe6xWkvc/qL1TOdnYUZCVFdiXUBjjQzeOdoz3R2QhrDNDWTWlKhmNTuF8K8L0JdcDA/2ESDZ3abbiOSSQnGge6h/Nwf0O24HdUAQA5hKExRqfg+A6rH3z8tOJs9j/1FXKg+KAwAHsofUYK+V1zBgxDAElfo9S1T1kaGLomJ3kNVwXxdxNC9FyaL3s6IX3s/ktKyiiTddOM/Op6pOhtCFcIfpAMFVOeKiJtmJTeaal7Tn0BJd9BN5p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:55:02.2116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf9436a-9cb7-4961-b6b7-08de94b5a5b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849

On Mon, Apr 06, 2026 at 10:28:12AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 01, 2026 at 02:43:55PM +0000, Ankit Soni wrote:
> > When hardware/VM request a small VA limit, the generic page table code
> > clears PT_FEAT_DYNAMIC_TOP. This later causes domain initialization to 
> > fail with -EOPNOTSUPP.
> > To properly enforce the domain VA limit, clamp amdv1pt_possible_sizes
> > using the requested max_vasz_lg2.
> > 
> > Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> > ---
> >  drivers/iommu/generic_pt/fmt/amdv1.h | 4 +++-
> >  drivers/iommu/generic_pt/iommu_pt.h  | 4 ----
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
> > index 3b2c41d9654d..bc04d482c12f 100644
> > --- a/drivers/iommu/generic_pt/fmt/amdv1.h
> > +++ b/drivers/iommu/generic_pt/fmt/amdv1.h
> > @@ -156,6 +156,7 @@ static inline unsigned int amdv1pt_num_items_lg2(const struct pt_state *pts)
> >  static inline pt_vaddr_t amdv1pt_possible_sizes(const struct pt_state *pts)
> >  {
> >  	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
> > +	pt_vaddr_t raw;
> >  
> >  	if (!amdv1pt_can_have_leaf(pts))
> >  		return 0;
> > @@ -168,8 +169,9 @@ static inline pt_vaddr_t amdv1pt_possible_sizes(const struct pt_state *pts)
> >  	 * 512GB Pages are not supported due to a hardware bug.
> >  	 * Otherwise every power of two size is supported.
> >  	 */
> > -	return GENMASK_ULL(min(51, isz_lg2 + amdv1pt_num_items_lg2(pts) - 1),
> > +	raw = GENMASK_ULL(min(51, isz_lg2 + amdv1pt_num_items_lg2(pts) - 1),
> >  			   isz_lg2) & ~SZ_512G;
> > +	return fvalog2_mod(raw, pts->range->common->max_vasz_lg2);
> >  }
> >  #define pt_possible_sizes amdv1pt_possible_sizes
> 
> This is a generic issue, I think it should be fixed like this instead:
> 
> @@ -1153,8 +1153,12 @@ static void NS(get_info)(struct pt_iommu *iommu_table,
>                         pgsize_bitmap |= pt_possible_sizes(&pts);
>         }
>  
> -       /* Hide page sizes larger than the maximum OA */
> -       info->pgsize_bitmap = oalog2_mod(pgsize_bitmap, common->max_oasz_lg2);
> +       /*
> +        * Hide page sizes larger than the maximum. -1 because a whole table
> +        * pgsize is not allowed
> +        */
> +       info->pgsize_bitmap = log2_mod(pgsize_bitmap, common->max_vasz_lg2 - 1);
> +       info->pgsize_bitmap = oalog2_mod(info->pgsize_bitmap, common->max_oasz_lg2);
>  }
>  
> pt_possible_sizes() always has to be masked with the pgsize_bitmap, so
> fixing it here is enough to remove those sizes from all the other
> places..
> 
> Then one of the tests isn't following that rule, so it needs a fix too:
> 
> @@ -438,6 +440,9 @@ static void test_lvl_possible_sizes(struct kunit *test, struct pt_state *pts,
>  {
>         unsigned int num_items_lg2 = safe_pt_num_items_lg2(pts);
>         pt_vaddr_t pgsize_bitmap = pt_possible_sizes(pts);
> +       /* Matches get_info() */
> +       pt_vaddr_t limited_pgsize_bitmap =
> +               log2_mod(pgsize_bitmap, pts->range->common->max_vasz_lg2 - 1);
>         unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
>  
>         if (!pt_can_have_leaf(pts)) {
> @@ -448,7 +453,8 @@ static void test_lvl_possible_sizes(struct kunit *test, struct pt_state *pts,
>         /* No bits for sizes that would be outside this table */
>         KUNIT_ASSERT_EQ(test, log2_mod(pgsize_bitmap, isz_lg2), 0);
>         KUNIT_ASSERT_EQ(
> -               test, fvalog2_div(pgsize_bitmap, num_items_lg2 + isz_lg2), 0);
> +               test,
> +               fvalog2_div(limited_pgsize_bitmap, num_items_lg2 + isz_lg2), 0);
>  
>         /*
>          * Non contiguous must be supported. AMDv1 has a HW bug where it does
> @@ -463,8 +469,8 @@ static void test_lvl_possible_sizes(struct kunit *test, struct pt_state *pts,
>         /* A contiguous entry should not span the whole table */
>         if (num_items_lg2 + isz_lg2 != PT_VADDR_MAX_LG2)
>                 KUNIT_ASSERT_FALSE(
> -                       test,
> -                       pgsize_bitmap & log2_to_int(num_items_lg2 + isz_lg2));
> +                       test, limited_pgsize_bitmap &
> +                                     log2_to_int(num_items_lg2 + isz_lg2));
>  }
> 
> And it should go in its own patch: "fix pgsize_bitmap calculation in
> get_info for smaller vasz's"
> 
> Jason

Got it, Thanks for the Heads-up, I'll test and send this.

Ankit

