Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743833C187
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417640; cv=fail; b=cqixZn+/HHxVda7XXqrDJV0MJJlXql11SZrT4HgPLb3mev5Vrz6gXeaamNlSjpkdQllvpcubtD1EUHmzysxqPgP+iXz6+0Q2cItmAk/UXQ1BZtsBuEfp7yNsU5WFtkLSDUrUtQjUaKn+EwROGnoSVEfjEt5zE1uK85qOxuScpGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417640; c=relaxed/simple;
	bh=INO9O/KQ2RDpAahZjIb3OG172QmH9vqrJ5rSjVhDXR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ql5+nnzhNL8EH5KQs7QltbXJ6cpNiwE8kzRk2u8G/r+EwJWAQ4Ji3+LujFj7FLFUyXHSU0uIXZJUmdLoONS5k+xmIvlCmm209wh1nqEfVT6RTfijjCe5uBav6oSL9kMrGIvg5Sw4jYszy1aFfxn40xNbfQyq0Qc6Y/KJDRv4nXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IC5hAKwH; arc=fail smtp.client-ip=40.93.196.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IC5hAKwH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+A7kGYMJ8ocRI5yVFVL+1Tq+JJ8kbqaaHrB0NnYtaoxQIsxEtaqFSKkpN6pvtzCQiIAmXtYrmr6zt0tjFprDlnQoMk4K9AGRzgfWBXyA6ZpHLYal7lBfWfbsKSexPT5z8w81SPbrIt9fUJslZ7ahRGGImdfgXJGz41HIxZUhWBQ4ePTcGDxnKszrFiPZiOsL8CRmWs7CEnmPh9o5A8fHwNEZABv9VNls/3dk7PxNBlnfGDv21fPV7zfURNNYUKmY0sQD6j6qRIXdtLhNxRXUr38dMA04UzjB5+oCb9WicX+gvZDt0j/nXQ7efN6HS/CQaozkGBZTMekf8ey9ZwnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INO9O/KQ2RDpAahZjIb3OG172QmH9vqrJ5rSjVhDXR4=;
 b=WphUe1g49KfCPa8DVOzcuru+uLfIICeoBa8WCoNXNUKgy+mdQOQOYZxQulQTGezvkZLGOqf6gtKDdAIUzlZYaNBlua8X4PZBbd0uXsWeKvlvDdEZVIWMobHRaEgBTUPzPXDfavUTngS3Tc46GGYsaP+5uzO+BCh+l+1qSwJXDeP43mPMgVNwS+QLg2AX/BdVk5Ddr0/HYpNzVkQROSlo7jM3vHtC4YQJF9naYK6VptH2JmYu4Ck6OFrpXhX0m7JupMUgBOMO+xKn8KKcoFSm4EWm7/INWzExD9pUky0+/SabFdKVDMSZEnFMCCf1eUJgWaALXkqAw+OtRDYKijmJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INO9O/KQ2RDpAahZjIb3OG172QmH9vqrJ5rSjVhDXR4=;
 b=IC5hAKwHMdm8jmTpjm13e0OhxGigp/2SKWxbYKC0kEgd2kN2LQqQUAp6K3thjGU9U4zHi+tbpee1m2NNlybTnLUPrUuzvMF8xcrhlGw07CkE/eNkseqpUTzjf7WVpzxEJM3prRgNoN30z+xNPvEw9DHF+g050UgiYa+jYFsDMUlxSy0ar0OwfORHTIeeTJdIKB+9Ajf9Ews+KzH1Hcel7t3itS+UQUgUBcBnSckM+aIj9d4XniBXUx3Lrq+EgjR/Vb7UYmtoJ0BjBtQ/zkClz7/ctk/9TMoMQit1k4t4ne37SLqGahBT9N8jMYkUAqz+3uAFaXS123egdEdufGvvQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 19:07:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 19:07:16 +0000
Date: Wed, 14 Jan 2026 15:07:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Message-ID: <20260114190715.GC961588@nvidia.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
 <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
 <ef58cd8a-504d-457b-b731-f7dfdba0e43c@linux.intel.com>
 <BN9PR11MB52760881132AD4513E32373C8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260114131715.GA961588@nvidia.com>
 <CAAywjhREggcahuWbk-ZqRjoW4v51X-gKw1pdA9TAcp-uO_6Bfg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhREggcahuWbk-ZqRjoW4v51X-gKw1pdA9TAcp-uO_6Bfg@mail.gmail.com>
X-ClientProxiedBy: MN2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:208:239::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 195ddb5a-6c21-4739-d976-08de53a021b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cj4Zqm48AAmy4gkZcB55B09rkfX71fY7LFVAYJpfUYFiHlVQz5IHor7+unUi?=
 =?us-ascii?Q?wxQf9sotT/9J6Nm1pMKF7fL29IbtYQjmNOK24vrWNM2ILEkVp/zgnDWXHN3H?=
 =?us-ascii?Q?b7vjQR4yi11Lwkj3rrZowusJ8qRkn4wmFu0mbp1dOoXgHxSYkRUVtsfQ07WN?=
 =?us-ascii?Q?Lz0ZKNFLSmcAh+7k18nNSh5P7NXSJjOgqXN6Y1D1W2CSt75Lt/5srfEWqWq4?=
 =?us-ascii?Q?OH5ATDaegKo78Z5MaBdd9zVnnhRUPhS0NO3vs2MYowA75Bb9sJgPtlWsAmWN?=
 =?us-ascii?Q?8fWlDT6xGEyTQGggzUHDAr1b80t6E+ZFS0TKNtv6S1VFCIZ6tq4r1y8BXi42?=
 =?us-ascii?Q?2DHL4VP1W0z8yONEzaImz3Xsx4z7s/fcGVpqJCR250dVFc8pvqpPPoKTEo3B?=
 =?us-ascii?Q?BkwBShYkWrxvgDZWSywGdLcZcr+8vIAQM4G4nLtes55O+jlt1cLJ21SrYLWu?=
 =?us-ascii?Q?+BahJkHU4gkEgcgXTPa3s/QG2SCzBgdTxw7Q5Ur63dsQEryzxiUSVlskirju?=
 =?us-ascii?Q?s4geBxaZPZes3fY1GYay/tj3FGxQtQTtt4BM7OG8gsCPiocEuFUAmvwBK6q6?=
 =?us-ascii?Q?rAIxbHukCIpuG1QZe1xM4R0/JYNNBjnmtUvzTeH1jhdqeSjp6VfRKoUdayy0?=
 =?us-ascii?Q?IchDYkeTmaJoTX5tYE/B6q5qlEzeZcMvbQsPVSglAFtaI9jmuACm6vh6J5Ig?=
 =?us-ascii?Q?SnK6Sdqrvvz1ASVrn0OtgDlbwBU2amKLEA8D9azoJFm93Cu76+678Ika+APG?=
 =?us-ascii?Q?yD5WJt86FEQkKocT265zVsfKuTwguM2Z2F7B7PX0rbQo+lpx4qbl/+lBtQH3?=
 =?us-ascii?Q?1InmHhmgqYBi9ON2rqnRhZp2VFtQavvgSg5kXEAE0q7zsOmaxhyUXWW8HwJu?=
 =?us-ascii?Q?rSAydswSy1/Dx3VVUdAFhdFFtk0RihZGfLIamLpQiOiG+mOZcCJAhw/+X/E6?=
 =?us-ascii?Q?HoK1svVONvx3f5xyW3JUpU/uwtlTQuzhMPJ7+/XI3LQKKhPqSVKfcGzEDH6U?=
 =?us-ascii?Q?QlLBenCZozVTqhbH148pErmS8jrIvf05fnR2bI0FtqVQTXF3JEaYDyxxsYcq?=
 =?us-ascii?Q?+DzJSi3lzDE4qZqOTOepisxAGAhUALNNlNxmVxyCpnG85/BSyeMck4wSKJBC?=
 =?us-ascii?Q?7YJ2pCbI+E92jxRtw1zX0Hx5T14uMnqgp9QvzsCVpDqUbjLydh5KwSBDZG09?=
 =?us-ascii?Q?LI0OVlOFdy6O/EzOskK6f9CN7AthxkdAkP3ztyLy1sqyJVsL7ErHh7P4Zbfl?=
 =?us-ascii?Q?lMqAbu9+y3ogp/ru1NJp2ocFam4WCofw/0rw/d6DkhDh/G2CUMfJxf/iyyh3?=
 =?us-ascii?Q?NXoJVkhJRm7Q5aCJ2ZNj8ekdjm3+BIT3jgtkQ+Uh7ET9DI5XXxa69JFGgYQ1?=
 =?us-ascii?Q?We3JHpDvs7BFm7JB4nf40EffqhN4clU+5uY5lqu8kbB1W/l+eiTxlyw85MwX?=
 =?us-ascii?Q?oIu3koYFl8KBoPwSPVl5lluyehrvGcT4Mv76fisAxiI4spO53TO4oc7tuCKo?=
 =?us-ascii?Q?6brFj1pIuLBd5dkFElTLm1vmWMGAzoCE8LpqC+WZO0oMBjzjBLm2mirM7V99?=
 =?us-ascii?Q?9E0N7sWk5Zwhi/RM6LM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FkiNN0Qt0KhzWfUjrf4htWppWl21njr6+vi51kA5znpkC6rFykdZ7NnLuQHn?=
 =?us-ascii?Q?2voAKskbUxZY0sr/wBihVSPobGCv4BFWTUKpm8eee7S1WF22w3mMNsjZshbK?=
 =?us-ascii?Q?ImZAv2ke7M1rOoVLHoXawDhGEzWztk63yAjkzFpe8C5jIU2QGi2faDoqa3un?=
 =?us-ascii?Q?AV/w0PZfmNVvQY4uT6o5RzoABYeNQiqAXSbtmyfBDEIOwlsvNxD8/cUPR5pJ?=
 =?us-ascii?Q?cXBfgu63WPMpo6XbPP+HlJwf1oVLj7nl4roWY5tja/DyssiZ8bsYbKsPAqga?=
 =?us-ascii?Q?oRJVAfDc99QmcF+E7oCVs//SJxlrrKIhYYD5DRmr1ELQ8YESkuRadyzj0MTW?=
 =?us-ascii?Q?8XIAON9vFxZvgz6v+8Audy3c/y6j8qHOKOmxr+wyaxII/CHF48jUR/Dn3ysr?=
 =?us-ascii?Q?DOYGboxG1b5+X/ZLuMuVkVSKxHDdO1KlLKt/JjesT5MUbNFf55nGE//GdXhp?=
 =?us-ascii?Q?g7SOfCiXfwVH8sAAOjgsNF277uALofi1EvakAjcN2kB5F/Q22EgKg1AXvkRW?=
 =?us-ascii?Q?OxKvwXiHJcfJKuF2zZabtdjiBV936CJHTazzjbDlWx/h6RjU8KZcHfRekEZ0?=
 =?us-ascii?Q?HqjuNXCV4mX2XwJbjLvBbaxQa7bM13tFYSjh5JFrIPh3xpUmf5BzfziaXHgk?=
 =?us-ascii?Q?DngHXTbzccOZ4APfKe/ySEtZgQSDxV9KoM5pjoinU1I5qVEeu+ltcZ4zlSlh?=
 =?us-ascii?Q?kFnm6B1zg5GyWcje0/0eyUrT1CC6j58gfm00Lik7pk8fvzwx7V7963P+ZWbz?=
 =?us-ascii?Q?NHXvO32yLGKDKh/LXg5t/17amQNtjURCRacQdu+9VPK/be4s3cWApl4aj3Ej?=
 =?us-ascii?Q?sz/5WMMHO73FjlrU3tb1tJu5PFMe0S7L0PPB/lRNWJhlUMaBxP60MIvY1Bve?=
 =?us-ascii?Q?N/iRzoTttfy3xLmKPedzYiNC16LtPeEwekycalCaxRiiyNI5UDq2BusMg2fZ?=
 =?us-ascii?Q?qPNG2hj+uZ2vOEtU4Hmlbs1zNI+d5/BFQ/icKBOonabvwf9m6hr6pwtYITTs?=
 =?us-ascii?Q?5WN1YLKpTd4DfWWnRaOpei6IMtM4jaA6063s2920uSzbOOd3Xgcwk9vMCfXh?=
 =?us-ascii?Q?uIa+n3b6a+EQM28FVqok/BFV0Y5L6hRjrpctHm2/bp9pYrRXsxb7rysD5X0x?=
 =?us-ascii?Q?2QVdsPnrUU4ajRQq774GzFQslbFlX6M2n1WhlfHMJZjK/GoA2RgGImBwT9QB?=
 =?us-ascii?Q?3mjjqpxzG7EkOT169uZ4ftp2teiIjQAA/cPDHmBFJ/Phh5p766wHBr4r8THR?=
 =?us-ascii?Q?zocaBY2ySEWK55AJW2F2MruTVSJQyaNzZZPOinN2f2XvztIL4qqeH4/d9xwk?=
 =?us-ascii?Q?ppyqKY4UbtXlGYwfqh+rhXqASyRPi80m+gZtlHGfakyJHT1egFPqa/gQUyqD?=
 =?us-ascii?Q?/Fo6rxkO0aKwCHM5A9iRLow3IDK5UA1zGceaTTwLnayXgjNOhSZkvY/vnGWn?=
 =?us-ascii?Q?1JkWkXBJ9tWrzStBfbFykgPoDtKtAJrIwjQ+UGNH7sML2ba2yyMvQnAMkbtO?=
 =?us-ascii?Q?3jQgYYKkS0MvutV0ApCAQTQJEHs8VDYZEH1OyHDMHAOO1JtC3Nn1wlr9lRuo?=
 =?us-ascii?Q?C0uagv0nmAG1JSP9WwTBBVxEDBUAzEMMgqxXqbYdPZc4BguGhA3eM5MPTvJe?=
 =?us-ascii?Q?ZGn04N0CV20rQ6KzHMlBQysDny795uehwgzzCTGT7ZvxjOqHWvGW2A1fzqlJ?=
 =?us-ascii?Q?A7Cul2nSzebueOrwqpVxp/xWmw0Awy0x2JoSfRI+GNLGyUKPCoX8SeaWuTLd?=
 =?us-ascii?Q?4RadQ/5vSw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195ddb5a-6c21-4739-d976-08de53a021b3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 19:07:15.9834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7fCFJI/rS5KEEf2QBIZ4xnG/eWPMb1klmbeJqDLhe/4yY7ypaB6jSuGLjo3Xncm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797

On Wed, Jan 14, 2026 at 10:51:02AM -0800, Samiullah Khawaja wrote:
> There is no immediate use case for first level, as I understand we use
> second level for all our VM use cases. But looking at the code and
> specs, the first level is used for pasid compatible domains (using
> IOMMU_HWPT_ALLOC_PASID flag) and it will not be replaceable
> hitlessly..

If the VMM allocates using the NEST_PARENT flag it will always get a
S2, and that is a reasonable thing for the VMM to do.

Jason
