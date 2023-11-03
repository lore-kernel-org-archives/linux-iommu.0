Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D521117
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X2srkHHQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTx7z/1xnKhLvGb54xnAto1IczqolZVjPp0MfnmPRYcnKwiiI1Biwm4W0XKOzETQ0Uae4TJiAv5pvNK7kYEhrO3XaMVw8B3Fb25vU6/iaP5uwYvVvVUE14TRe4tpH+iBZ/k9CcbaHLPFcP4SJZKbtFa2Tywxe25Cs2OSedDyl/lgiiE2UyhXuC1iol9Sh85IzOeHbpXqu8uZVcKBtSvk1EMddv1zj/GlLo2k3VOoyc26CX+dhacX0FoSKVxEX75WKOJoPogBiX3gVngpDECcxaE245XSDiE5/q4hVM5EPuPpvc2VZZF6g9HMbMcotdYRCdU2i5mhL4tTTGWLRd0T6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iHBi1w4wpF5LWDm9lRCHMxwFqVQarkCDilHeSIaWZA=;
 b=SBdORKZ7J68pzMvedbZRoepRxA+KPdZ7ICcDzYBrmatNY4n7hxtBCfhk/GOHxWfLE/ipdosn+s2+ag9XbQPaANetOGYrDyR2t7TGIb0ii0E7ruFxU5sSIdDSKbEeOsZrHmOrGOpVowEoToLOeidoNMBjh7ak9DzOF+aTcKjMpK6gAwyUubiYVv6VboN7C+Zig/wu0N+tqiQxCv7BXqq3tq3+eKppCDUsD/FX1iAeJJt0H5HpMgBi5U7Jo2CjJLXtw6hHM4me/gpo1yGYMcdqx2InlVJpAjOjLG4RuosP0+ZYUD6sEai3evthDwbZbTA3VGmhPsevIzU0mT1ZbUdJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iHBi1w4wpF5LWDm9lRCHMxwFqVQarkCDilHeSIaWZA=;
 b=X2srkHHQE4KyAHpzug6wqhrjxP6NKeKrRYTI22qBI0k98zIzsKiUOYy8FWpaH7I3A8yCzGzMW/YvkMMp8BHK4bmSli3f6y6oJCav7dnukZugnn49MetQIo5eo7124Ep2MimNqOZ4vH50WKDZyVZ/HK8FYq3jUQgRzdAtiEPCINWNSbfVbAA5v1lJ81WxzOfCrD2KoVkPLmxTKXnagzexCcSGhXuxf+PlUM5ggCR2FTDrM6SGuEFI3YKNl7edKYxEFCtLCBA/Xhkt4E/3gXVHE0Co4HOLVWg/NBkBHalOF5NIHaJBBSDCRlSP+RkbppKUGZBNvBSHJWcKqHKQd3ctRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 18:08:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 18:08:51 +0000
Date: Fri, 3 Nov 2023 15:08:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 01/13] iommu/amd: Rename iommu_flush_all_caches() ->
 amd_iommu_flush_all_caches()
Message-ID: <20231103180850.GA223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-2-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-2-vasant.hegde@amd.com>
X-ClientProxiedBy: BL0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:91::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: e5278e3f-84dd-459b-8471-08dbdc97eed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EdZjl9QOtf9TrVye0RGgN0uJp9JRMP9G86vz4Jwbejc/RZQlE1uEEj9sEEu0Z5gy76gHRgMyqikdDnzK7PiKHkiime3jguPVKAPxWkHQOMuvmCoSYmBaKFOeiCLH/LeEeEUmDdVqXCJD31Rkv5UhRLrD+TpJrCZCD1nET98HoHcTjxjue5tP1aFi3SLPgvMSiHGTdUH9j5YrCUruHKSj210pVasS0GduvkheC23XvKiyzF350KiHJL4jGwwn6RBDslJlYRl50erVefsaIFR5R+dFakWIW/mlRaITiuY0swjaKYwQgE/d6SIj2VQ2g4wl0yxmCe5voy6bVuX2yCmodvLGu9AzOXz+EhQk2pfbBnHcTHFNm1QqvTnxZSSlSCcBWzYATH1POpeGv/Rp+ojNarFr2peLeqt8W4Q4e3P0Y/S/l5UwBQUddZASZsw651AyfHAwS5XTQweByS02jEXhn51TV1l9WnlrdXoKDvmEBlwSfjYy4npFtlc+cZC/xbpnt+HVESvn+7sEqe3BmoIJkozQuxSTgC2oLn+dCtZhRushVC5UwGRAgwxvR+iuCJQhGeP0y/HMJ01tRdoLfGkI6At1zT0A8OLH3wFeqmlcWmRHUzf2XkoKem6qeQqtzGPg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(41300700001)(38100700002)(66476007)(316002)(6916009)(66946007)(66556008)(6512007)(6486002)(6506007)(478600001)(26005)(4326008)(8936002)(8676002)(86362001)(4744005)(33656002)(2906002)(36756003)(5660300002)(2616005)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PEUbQCdF7fMzwthXxi848wI9ENe5oMgt2uBfyCW2y2wQr0UzOHiZxmDtMG8C?=
 =?us-ascii?Q?2HMm9ohaYzlGTWQ+w8KuuvcNs+bGg4AO3r8h6chsynyUMuysTGkH/jy2OaeH?=
 =?us-ascii?Q?AwwCgMoKV0TLqUrVGWgKHolNd+FqCDIzVjLDUnCWrl5+rv8PSumMkLylrq7N?=
 =?us-ascii?Q?Pj5LCbaChnCuF1hIHbIdYrJd595Sy4yMokVG3xrp4VqTgOCEZOW3r3M6RItx?=
 =?us-ascii?Q?v0sE77P1XnSRNEnk7UTiL+OfvTdVLUTJVeALcOUpKXKZ1Tt9HyQ1aUH+gWOd?=
 =?us-ascii?Q?ryITUWktFnbdqpHQDk/fFaKrDeWalxMySRWmXF5HNU3geVVA0ikvb5zFZ+tU?=
 =?us-ascii?Q?6zx97pZYN5DHyYFkD/qSP3dajtG7+ZrRLQbFEUnNp2STLay3Z4MTVlNfzI78?=
 =?us-ascii?Q?EAtT1mymkZGNIoFbWCcgr7LxAqzm6zycB6l54oZBK5aIiVCtniHa5MljZ/ah?=
 =?us-ascii?Q?TZaaXIgbG3OFgvnMdH2YY7a52jY3gy2b127tOvB3NrW/2aHC09Trg66D4DC5?=
 =?us-ascii?Q?cNhNc6wLOegpppIXuGpWo38IjBCWx9OFy6zNbVbCwRqB1lLS7+1ZdvOJ1Bnm?=
 =?us-ascii?Q?afM48ksYW7niFI/4zx/nsk6ykb/fcTl7NKQpipBDR0AHPtiGV1+S8to2zheC?=
 =?us-ascii?Q?dZG1yXmDHCIt2N74OOrhXonVUrWgEZAXMSiK+DShiRWHhsoqEavZj3Gy4PHb?=
 =?us-ascii?Q?5gmrSNHEoQEeqw/3b2J4C0YnqM3s6mH0o8+Fwn0W74upuBTdD6YpxThCr7ip?=
 =?us-ascii?Q?je5ChxexSHKmu0eBqmY2z/a8YzQ1I82onvDdvqKjsoNepO1rNxrTxqnvwk08?=
 =?us-ascii?Q?VpSrAlytm+1C4TbLKbUCWHnMNZZvTOBtclh3/TBju2sm2yu59RQpBubUYRf5?=
 =?us-ascii?Q?EuC0RInaNfaM5k3IMJ++V5NizuRaUmWAkaJm6ikc3oRmAhsCUSMGblOmp/vm?=
 =?us-ascii?Q?8BmxDMLUhiPCleJCUYaD09DNM6cN86EXtRpboqdzdEX3t4QmoZpUVWebFp5z?=
 =?us-ascii?Q?jnBxRYsonynIhDBQHamS6n/chZLv2AHnhMzvNupZK6aDrEM9O0ta35dm+oXV?=
 =?us-ascii?Q?0Wix+wTsODd96mdTpDtxw+4J5fupAchbqiAK2SWtSrs+19s1t8l8Vu3gmXIi?=
 =?us-ascii?Q?qU7SxhoondQxFKVLUKJ6PPjEZF4HvW02bP3aOHKoq+fGVLQjp87B1UpE20eG?=
 =?us-ascii?Q?BBnEtFH6eJAH4LIAB6v0r44VyQ/0uJ/+fy4U6pPr8acTvY0168gOf8i8xqWN?=
 =?us-ascii?Q?atK8B0jR9Zdy2j0v9Qz7MUuFi02tULgy99hiZ3Lw63UeMnuc/lDgs5IhBUFx?=
 =?us-ascii?Q?Bj4+sUixWpZFCnxHOlkWKbHbefQIRa9tc2IayZD2fZ1PHfxbgif/jXt3Wz/K?=
 =?us-ascii?Q?ybk74GrCVWKKQx0dz1bZTuVnp8jSWD07IBlchzboja4NKW3KCulLAkZe0O/W?=
 =?us-ascii?Q?7W59tXigobORHOHK1P/mAjpM9NLbbYc/csuYJiwtPK2NcJgtJm8z2/kW93pd?=
 =?us-ascii?Q?1ta12pIwXpFoNJnXvDdE9nVJFyxLkUTbIFQZ+rehv7B/U4PRlHQ6aBddqzM+?=
 =?us-ascii?Q?M+dxWM8NbRdQAvINBigUUwf5lU+xtXSWHNzNTRX1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5278e3f-84dd-459b-8471-08dbdc97eed7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 18:08:51.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSYfovWbmNHWMjZUq5vGPCgDksKdsmGyODORjp+zXi6qmWCFyAX8kL4iMZhDYip2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108

On Fri, Oct 06, 2023 at 10:16:12AM +0000, Vasant Hegde wrote:
> Rename function inline with driver naming convention.
> 
> No functional changes.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       | 5 +++++
>  drivers/iommu/amd/amd_iommu_types.h | 6 ------
>  drivers/iommu/amd/init.c            | 8 ++++----
>  drivers/iommu/amd/iommu.c           | 2 +-
>  4 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
