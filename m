Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BCA8BF0;
	Mon, 28 Nov 2022 14:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azUpoctk+2zaCcvYOizyaEn+RNkeHjCwG4JRBE2rnlwmx6RM3qmLeVsz4WSt54ddvqGJlS2rqkrp2kQZ8R574cjumMuCg4EU0RD9PUKlQVNCjiC1ei02T6o2dZZUOSIvQsOT/ZaJgpGDDOFwjwSEBxbmG1dUqYzVoVLHRSO1HTBXlkmd4n1dj1fdbo/cviSlkEOL9q0p5x0aythOphoE4/ZQGxBmhUyRyDWWHmFanVlfGL8zddo/ZJve8SK9EqCTeyWThT1gsXZYc2ZH1W3YGNnqj9DslpY8e8QG9LIjC61ajWYgEyHG1EU77r5CN+kS8rgAnenIcHuwdG3Ab+lNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIi1/Tu4/nWqLhsSNwSE4xGoggYTQAQqZv/np1+KqoQ=;
 b=SPvw0bRGl3tmw5pVkcHayFZI1HCNAZB7ATih5G1FC7KFKUYdk5miZCN7HBYWCMAHcGqfqh4+ZZtxjBmVPCul3dl+judPk6Pe+RHrRxgQOPzZCh0CI2gVclw2nRO6+HVZZxJOhEWstACBsgCEnY5aAI4KgzNQMJIDhnYjgEGjyTCwzcbQ421zp9OnAwx56UaokJDi/Zs9Uw0xTZwbg3IVRk5631XLrXFR7gFkvP/MxTB7eqsKoBDBc/rji1SoeUCl/bHCrRsMZ0BEk2RPUQ2mLQTtiPHCD+yH6x2petBa27qhF0sX9qP+aO0f9dxxBDa6ADCi+25mhersWu4JWo/PKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIi1/Tu4/nWqLhsSNwSE4xGoggYTQAQqZv/np1+KqoQ=;
 b=GEpmDm/4SqFFKEDQJVVcSuOHZY6nD4w7ag5eM8SmWZ9vHJW6xCWZm4RvSvBrAiE4cH+gNpZEZDgEzHgFvjxCwG8w0aeeJsB7YijogvUI864k02ZvZn/8pFJzRxLqNPGnyn7kwXhcSpx66xwVIVhQypyboVw7//GmFCaXPjRvuLtgLvfXm160xJU8E0vf9OwXsr5Ti+Bpn6KGk8zHUCwKwYhE3NomElXBMmPbBwOc0V1ZT84AIGlgUDCxUlMT0oKd2W1eS608g58RNC4UFzXyvJ3HprT9B19vpk9qqUyaHZrPpEemFe9PvXHlQl/krErdSOashttb5rZulMAX0h63Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 14:06:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 14:06:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Maxime Ripard <maxime@cerno.tech>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/sun50i: Remove IOMMU_DOMAIN_IDENTITY
Date: Mon, 28 Nov 2022 10:06:28 -0400
Message-Id: <0-v1-97f0adf27b5e+1f0-s50_identity_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:32b::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 516d2402-9f5b-4dd2-1b4a-08dad149bf0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QMqDHs/YdkL7/Qy/jK3cKkJjNkLalOl6+Bm9lECq207N3xOA+srEW1kTTn4JJRP9VcYeqPeEMlOu135YfbXVZawhS5rTK/p12T5LqZC/4FO0sLDX3YLV6eZGDDpGGVWdNjsQtp+McTsq39A2g3utx1gBdK6A7rB59eD/2AlslFWB/DxK74AHD/3HmFYch3yImUfyfyn0nEabYrID5yfV5qeVBrl7p6CGvKnz4byP2xzp8FCYbo0UKB+tGgEtECegbybkhupf0/dsgX5ht5i/dzd54EUqSc2x7/hnrf2+EwPuHpSqjpEzzcyAfci79HBB/WUnvQfmCgsBflXzQanJygIyVV9YRw44WGYC9eEGwXCrLkwKwlKehfaGSv20ewWUO8uPDa7Dp9jYAjuDulpWnTHZ8agknOa1HmT9asB6Uf+0byq+AGUhSTC3llCgVjN5BFlV0yAqg+VDHxDnxlh18ZyNKSG/I+zErNDwPmGezeA1N6F0gmXbtJIFrcgA6G1D+mzrVv+kfAGV0IUH+Luu6wjsFcoGOmXiKGkn+rV1p+qRjlJtUYQmZUqBPXYglRLckKRnKxvYqp1s4gp52AEagYoRPiVUwqnzfjjiU0lwjPRka7gP1aWKjRfWBXCCb1GgaZX7cyBlgrrbsDks6GpIZmHDRGb199pqAs3r9U6UwG0fs5RNGfWzCvXaeGuhTlTmkeOlWQp0gsKWkDkYfxE3wg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199015)(5660300002)(7416002)(316002)(36756003)(26005)(6512007)(110136005)(41300700001)(2616005)(8936002)(66556008)(186003)(4326008)(66476007)(8676002)(66946007)(38100700002)(2906002)(921005)(83380400001)(86362001)(6506007)(6486002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DNsom48lpUPs4z00UwkcdubMTMzUrajT3Ety4i7wYYyuT2onBj8UizXG7ILl?=
 =?us-ascii?Q?v1K44iC0T+AcOy/XlCHy2eY5Y73m2+bGI03k29hGzYAzFEMLogylMruDyhZ8?=
 =?us-ascii?Q?G/8hIYp6B0J4zFZspT2LlWshKL7S4NuW8bm+x+1yWXslGtO3+FuuE+D3B4pS?=
 =?us-ascii?Q?XokMmYXWWrn1BiinPJTWyKm6jrHrQKZZwvtuvuRQmLxamBQiNVQzOVco2gc9?=
 =?us-ascii?Q?i0RUlMATi9a0MvLpmHwzBRQ7B6gOScErJf9rKrfgPRBNtJuEpokpqIphkqTd?=
 =?us-ascii?Q?Q2wP9gPTcmYhQQPpd/q8bDHMw4mbZEdsiJXiHMgMRKbO4nyWYU0wxZivgX1s?=
 =?us-ascii?Q?LcOXfQJ7mlJxim2CCXRDjRFEde4+MQ1ckglAMPYyQMVSCLVNaUkzVjWdgP6W?=
 =?us-ascii?Q?wkGtISAAti/QUb69bXFBwwBwS35boC5vCIZsK9f9NIijpSVIz9WRQryyleLy?=
 =?us-ascii?Q?I+6xMHXmG2/M3sIqFmQk5ZZ3EM6DhPbTa+ksU/VKggKlSc9tLkVAGy/bBOmt?=
 =?us-ascii?Q?cn6pGrpur22n2Yr8EsHkoYCkylUlMQBNSLqsn+lqP/MdqWaN1E8N23/AYLHW?=
 =?us-ascii?Q?PDO7rhfToMFohreGVyj/ZitwwNmIjFBeEXPHWsfHz5bRSf+UA3laNynByJS3?=
 =?us-ascii?Q?5ADpW45T8gggSOekGQgGRFA2hgre+mKQQHen3TVDiqAfbJ7gzUwVbcJsBt/R?=
 =?us-ascii?Q?eLJOI/mcwF4H8cIhDix6xIeYNa7e7tEUXA30zwbvHSNQoQBGBfuJ7+DifQZ9?=
 =?us-ascii?Q?aGN0ovpyDsIJN3xQgAxVpCbUufYgDObfOia/zZGedN3b/v7oSsHWssfmGtlb?=
 =?us-ascii?Q?/q/gnZUgLFtRCjHy0phNxABAluU8RG8OXKdqnXtoPjTn+I1wmsZR5t2jA1Bg?=
 =?us-ascii?Q?Igi6JHpjobzISyPgvRwhvsxdqZdIRCDP0WFE3D2BqJuPNSENWpdhSOpK4ZPX?=
 =?us-ascii?Q?JhGmoIKQXtz+bq4B2GNSPG1aCbYRTrV1Bezh3v/4I+wAT3JpVr+WcWG7n6I3?=
 =?us-ascii?Q?tkc3pfvs1BFMrbzizJ+0GfAS+4+0veLKzKfrsVoFexlPMtGfB025OsCnArQr?=
 =?us-ascii?Q?mmB0T5FW6MOPVkpftHwSQDoEinYm7wXd4ULwCaH5gvgvirIS2DHD8In8mVtW?=
 =?us-ascii?Q?HEtAHvVQgqd2eTSHWU2rvX3iVJ62oWdDFr86THIBJf1dQ+r9iJzUUfRr9xsP?=
 =?us-ascii?Q?0ZtUQihOd7o5RzdbJguwztYbIEobMFGFCVkfHSBvOgaxWrnMzykJg5I1pzF7?=
 =?us-ascii?Q?mcSj28La+Ei5mUS350qG851YUNoCRKjNEkQDxbq0YiYQ8OO7SNoggS9v8ydZ?=
 =?us-ascii?Q?k45UlvthT4O48jNYWjS+2vdMzNWpBVVkrEj2lqZ0YbVLeMCY+vum7cZIEdCp?=
 =?us-ascii?Q?0Tm/4iDIl1iPCrj57QJvb1hOSF+vKnjKdyycBIoeB+x6b3FmivE5hPEFYbsb?=
 =?us-ascii?Q?B03G+XZ9zmTQDjxG5F45j5gGXamnNXF/Mjd2UGn5E0NTrZqSSfuwsNOZBz4p?=
 =?us-ascii?Q?bYIui/CnPT/nKj0q3XgLyOQApwAWoONYlyMJrHCj852GuwjPEgj5CjYBKr/I?=
 =?us-ascii?Q?ZLnt1TZrIZ74nRKhbgI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516d2402-9f5b-4dd2-1b4a-08dad149bf0a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 14:06:29.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiSJ8CTm6E3eCA23Kqz2nBUfWeaGzYVbKgvXAT6kNjNDUr/hvQpN8V6JdnzRUwHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904

This driver treats IOMMU_DOMAIN_IDENTITY the same as UNMANAGED, which
cannot possibly be correct.

UNMANAGED domains are required to start out blocking all DMAs. This seems
to be what this driver does as it allocates a first level 'dt' for the IO
page table that is 0 filled.

Thus UNMANAGED looks like a working IO page table, and so IDENTITY must be
a mistake. Remove it.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/sun50i-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index cd9b74ee24def1..0843418434ff3a 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -601,7 +601,6 @@ static struct iommu_domain *sun50i_iommu_domain_alloc(unsigned type)
 	struct sun50i_iommu_domain *sun50i_domain;
 
 	if (type != IOMMU_DOMAIN_DMA &&
-	    type != IOMMU_DOMAIN_IDENTITY &&
 	    type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 

base-commit: 328827239b9ce3a95b5c0d33e8875651580de053
-- 
2.38.1

