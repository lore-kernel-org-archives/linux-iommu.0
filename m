Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494BA17C7
	for <iommu@lists.linux.dev>; Tue, 10 Jan 2023 10:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMkxU+YtSDp55Xa5GC7wydBa38C1bBfg0ohMCLFu4D8FJaJsmc+TEv0XiNallhFOj+hv3R4jGLcC+X8T4L+CQ7tjwWNy/4x1/HA4j13GYvFVXHnH433pSLgM26OheOxZx/5MQSPldR4MowjbJpC39buQB8zg/oDsyX14w9IllaEN4eCJm8+VZLDhYBCKe0Tbu39O+3VdqNjrFqWg2/tV6MfJjbfiC5DDuf82JJ9LARO+35Z5j13uOQgIhJkYhRKVXwteiEqn/3HE1NXVOn3CQTFaxduMsMBWrh6oczUyB9Bx7b2dwhyLFDn9u7yPZR3PvdEA1J3Pmg1xv1KMyqOn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDpSSBVPFEIxdtyG+QlcWEbiB9p0LD5pv640YWsCDYo=;
 b=CjB7cSuSeScmvY+mKZWvV3zZ7Hhtr8hEq4yhJdcfhW8T/C4psDtQGHXRmX1SQ31TxqIFF9HEsgH6zjdIQsXvZdKJANXTMTUKpLbmUHES2EuAduuWZaAk0luKyNnIdt9q0z9us2WkHN2LdIZfT9k9Q5my+41GECAo7y+UW1cqj5xBRD29FTI4vwaQXehJQxWz+1m6RKAs6yb4B4knKxYLniE/BSeoXaDPQX9jDrDY67fD2NPpKtOieLK5Vo2MpPXqSj5TqvoWBxJnET14RJTZD8XP8iBXtYST5T9OxrtaYwvmyv6GiMtcfBqajDAP/Rxee/jfLLdFhn2f8Z5KxHIXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDpSSBVPFEIxdtyG+QlcWEbiB9p0LD5pv640YWsCDYo=;
 b=nGYJtM5MMUYl+N5TX+PmYLy1i2b+MlS0ljLjKgkQ8RsrJCftqBfEYFmc6YIXXJnl2QZj+G3GYuj0kxSt8PPHER6oDBXIcxiIRKm4iLuHVBdQDDnKiwKfDFWYzFF2kid1yvNCn1vZw7ZAch8iHVmgteO18eAfGZyw5hd30bD4ASI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by DB9PR04MB9235.eurprd04.prod.outlook.com (2603:10a6:10:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 10 Jan
 2023 10:56:29 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 10:56:29 +0000
Date: Tue, 10 Jan 2023 12:56:25 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY even
 betterer
Message-ID: <20230110105625.ououvyfj2g6ttkmf@skbuf>
References: <d6dc41952961e5c7b21acac08a8bf1eb0f69e124.1671123115.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6dc41952961e5c7b21acac08a8bf1eb0f69e124.1671123115.git.robin.murphy@arm.com>
X-ClientProxiedBy: BE1P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::13) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|DB9PR04MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad9407e-c0e5-4bd7-4f33-08daf2f95382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LrAoW+nuouG662wqehAgkxQSTCERdaHauHjerO5YJfyJl0f2/uHdQRMw9vL//687E5dACp3RkpPqsdYHghvDOfRPb7nMB+nj0F742zFEQ5xCtVrgeqD2598yrNJJTFDen1jb0XtySBRN6BrDxcwo+Mrb9tT9DVGhxwh6q/rfJFRHAWh/bH4qVHnPfJte+3QUX5GcO7KNyVAyunfyRsyfddYxmi1O43mgWkxGbufE1DYGjQ3rR2QfVdrOPdAj14ci/3wtmtt47rHpqtpVbUHt/R2g1zt0uav+6fISOxGK3UYZXavvO7phG6KxiIh5bGq3BrG2A9pYa/pY7kDkOHDm8kH1cSaeQGpqw5jmI4OgnyRR9RAf9FcewZ5uboM2WHSRGDcmrB5tly/wJEfl2jLbrGTFjFa9CfmXVoD+9OsWo5PykISkJ7aKfJiH/HeHthTUAe2sgtg57c+h8repG4aLqOA0Fr1Utp38KYr15N8rjgNSKByrX03HYIAXNbTQSr//YBPAkjie6k8ehx1i+fOdl9GaJkZlDzWpDPDp+o+ziY2n04ysAaYSpGhPYUCRh3hu1yDPv5vs4wdKiGz1GL1+VYNZfS6+fYnR5chvXylZbDPWnMszkonei2wVRBoQnhSjpeKM0RWa2KDpl9mNEZXcCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(33716001)(6512007)(26005)(6666004)(9686003)(83380400001)(6506007)(186003)(1076003)(38100700002)(86362001)(44832011)(8676002)(8936002)(41300700001)(4326008)(5660300002)(2906002)(66556008)(6486002)(478600001)(6916009)(66946007)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D3GpVY5jkVWhT38XjeeugZmxQIMKqJkxCC5tygryOeEfpMpTIbmlNNzz23ll?=
 =?us-ascii?Q?WfBlgap6229vmPAAN55yMkYs1+K78E6UcSaPY2xEXshQCi+Vsi7VQjLJT9A8?=
 =?us-ascii?Q?nlLRo5cuWJk3fTID8l0PGyHruRE+Jz10dX/cJj/c9e5FY580dR4rd9pXC2Qb?=
 =?us-ascii?Q?LuqAmXqbnzH/Tc3UhuNlK1dLy7y3GM61gBXAwnaAwyuZnqIntseV+0cMI7x5?=
 =?us-ascii?Q?G2QVbAKn5+gSKin4GEfiVz6n3zGhxqStrQSbvySLKbR6gbDCfaHoP0eVA1pR?=
 =?us-ascii?Q?k/JA7zRBN41CJBvmI6EwEOWjGQRvpW6IjQQgnZqdGv1dytGH7M/sbKnMmLEW?=
 =?us-ascii?Q?LTcqXqf2sBlaJtGmhqXg8Hp53m3lPiaXF++WHM93fBjvdRJNZuY6uJbzP0E6?=
 =?us-ascii?Q?eVFEQTeNbg7NUkOgp9LnHPK/2sCw4pS9bL1nEzAUVIAjk2veeBqw84qpEEbd?=
 =?us-ascii?Q?WT+RenVu7f+pwOyIduAk5OUU11qzCu558ounNOC6OFwQaM7bUNI0Z5r1CQ20?=
 =?us-ascii?Q?ZELuo/qG7bFopW7Kov5gYfyvf+DB3ctng+TI0vd1qaquO06/ZxNYgtGFmj4C?=
 =?us-ascii?Q?XC44tEf2wykM/iATHvkxKnqDM0j/4wto9FiqEHWUn9rVr/siBv/2dQz/l5wx?=
 =?us-ascii?Q?yU6WqT1hwoTkwXO0dUQ+Wg/LBBr9vIj/VRhxIZP4M2ywJsunWY4ofOCZDlMI?=
 =?us-ascii?Q?IWYe1Fpy8Dd7hXfS8djlnIh0swflwEI+4jr3nQVv+rpnxrnGM7raEytBMYVs?=
 =?us-ascii?Q?S1bh1/qGp6v5WNHkjAGIqj6lta14E1ILDTNVgz1CPa+G3G6+9aXYlxBl0HnL?=
 =?us-ascii?Q?0N3dbiQ4G+a5VL4CjtlngFIPRp7QdB+jfUcYqjhdbIa0fiWy/O6Xz9hhPf+a?=
 =?us-ascii?Q?18B903sUpFY72ox2ZMtOnr2PakQfSX1J9DZwecFu3l2daEcs1sHq6cWZidnQ?=
 =?us-ascii?Q?zpHaFT2q5PFg7UxiD5noxLAaxOYEUE3QThgALQ6y0WdewHr6Oq3MV8MRjN/O?=
 =?us-ascii?Q?d3mvNPj8qcNOUA/0sgkHzgy229XiQrCy3Q0IzGeIy6CSLOJCiNYqOts4aZHP?=
 =?us-ascii?Q?5AN2xfIbGZCtE9dJQPL2C/5UO9/ISZfFBa0I5db7Vrm9nSRhohv5P8kDo2Wf?=
 =?us-ascii?Q?XX0/a9kjQkPc2yM+b8VHHz15nJC314LG2TPp6qkRYXXnq3Rx4KHHYv8zBLPT?=
 =?us-ascii?Q?+UxIUE6GVrba3fu5jjiDyJuzz+R91Lq2hJbeVjkde1ZS9LRoSNuxSpvXsncY?=
 =?us-ascii?Q?pXDMqIwp64S3cvfBvO/0OxrkGwPJcYq4itfN+kWfRzs8rYv4Jlyj3fFS3NJg?=
 =?us-ascii?Q?sy4CJvdHGyJ9EL9ZVx5NTYKzmFv11OX68pycoctKfr7qaEzzY2JozjZ9gOGc?=
 =?us-ascii?Q?bmDk/7OwIXPdCPzKZ7Nk0XzVjGc+0rkURsShtOwSvYmREFeXyILR4nGUDjlk?=
 =?us-ascii?Q?8E4CR/XMrL9nzagGx6uGsAn2BoXw6+6g8/AJ6WNXI03h6yL8CeCzl40Tw6zQ?=
 =?us-ascii?Q?U8mP2O7/X8KF4pdct7hwmg8r0BqL0Z9MNqPVLoUA1IKOGHv1nOHWI+EBY0qk?=
 =?us-ascii?Q?WLeiYEsBsorXKVBHgoXssHZYYwWPrnGpXFWVQ4x07eKvB/EZHnzc9hlrHc88?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad9407e-c0e5-4bd7-4f33-08daf2f95382
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 10:56:29.2861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCRjhR1v/v0vJ5U8Q9vCndy9OVVzLgJuIXNUFE4w7wTgMfp+bsRdPxF18BuWOwi8ztudglPBxrZe5wGfEVkwww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9235

Hi,

On Thu, Dec 15, 2022 at 04:51:55PM +0000, Robin Murphy wrote:
> Although it's vanishingly unlikely that anyone would integrate an SMMU
> within a coherent interconnect without also making the pagetable walk
> interface coherent, the same effect happens if a coherent SMMU fails to
> advertise CTTW correctly. This turns out to be the case on some popular
> NXP SoCs, where VFIO started failing the IOMMU_CAP_CACHE_COHERENCY test,
> even though IOMMU_CACHE *was* previously achieving the desired effect
> anyway thanks to the underlying integration.
> 
> While those SoCs stand to gain some more general benefits from a
> firmware update to override CTTW correctly in DT/ACPI, it's also easy
> to work around this in Linux as well, to avoid imposing too much on
> affected users - since the upstream client devices *are* correctly
> marked as coherent, we can trivially infer their coherent paths through
> the SMMU as well.
> 
> Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Fixes: df198b37e72c ("iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY better")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Could someone please apply this patch?
