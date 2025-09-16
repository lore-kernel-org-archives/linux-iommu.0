Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010033.outbound.protection.outlook.com [40.93.198.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09131D731
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030767; cv=fail; b=YX20jLi55mFurfQxFG25aIVjSg03XFj+jNlFEfykP6xBtWxAGfqnaZIiQ/kG7AGs+lxdGwCOb+T3vZSFmKEHc76s4yOuq7FZwHEwnKEeL2FjWr51p7JwiWVLKKE57tbMw+2UleSM+MrWLUQYU9DWNVaqKO1VRBz0a+jsWkyD/jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030767; c=relaxed/simple;
	bh=9iKAfkKFunnEQGl8iNfVZ1WPZwscN0RPdu7u0/Anqxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UxQRcqILr04eDqqCWplAYSnov1DiXkbUJvKn6KiLOYf3yQLCIFR2Uf4jrQ/3WLusIUn8PgO4scIlnkXMDTQkf/oWow6Q0pwdqdp9mXkQuXb8YXh020p/U99YfRVll4Ck/HHGdWmcZ2bOatPMWxVKHtud36lpX0tGp5Or7NtvQck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sIrlRjk+; arc=fail smtp.client-ip=40.93.198.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sIrlRjk+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBl2Kvl8cMT0XWwdiC1IYGOPXE716rofSpctAzCVKzM/QkGQF7s7naRt8t1Bob2spnQcDroVGMNwmcoD03AIMvw3InsCIFEKNwycHmVUagryP+zeOULb7u9YGHvD4XIaevcmFE1w/FN33fMLv90GCxa2OLEoMkDfdItsohe0KHaBCWS/G3jOv5KMxC4ZdnvsI2BnuWuNc70vxuyKqR0CcClZhl6K5Sor/PWz7BdjJv1qzGueudC1xoCMVPkjtas0TuiQbtwbAl9vObXEVQMk/J/rnkSxQPuXFXdYclCSvW5mY0RCt5vAPO7w29duC6YxB7Jvzp54gDl4NblqGuPOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3j83wHDIS74YVfrna8Vc0OqNUt+Xph3vH3jyuB8fuc=;
 b=iOvSFgkKt8MWhRvTX5qFfs/l2J5ce/nbrGyWwNzkwZS+Ba7whRyVR8B31ymDzZJ3L9p2j6zN4Nmnq7aEDNRHXwjRqaU2qxoRmCZr5hp8sswEPy/p5Ig+4qiZAk5fcOYvDgwfW1XUo9Os0zCaAJ/bQ2z24hOkerI1qOYtOnXsL6mCPCLgUiMSs4kQ/nGc8qzWYNnC4Dh3h7pemf/wVVQB7pBOKO3Kyqvx04AHUrbmQSvvPcXFNujJDrWBygV6E/scTwPSVN9gfEJ3ZslVA8y44XAR2i25DnScuIxBv2+XGuuvSnwh7XiR1QraxLdu0Y4+aM/dNnXr2DenmwzEcfX2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3j83wHDIS74YVfrna8Vc0OqNUt+Xph3vH3jyuB8fuc=;
 b=sIrlRjk+/pMS58o0l/t8WBWPrv39GmpK+M4LIHzb5WiZ/zWHZxmw/EK0aFLgVPxjP9LQy/Uw8YzjHxN94DZAPiFAjUmoVQe7hOmAdwUHlX2JxKbGItap9Lcb0/7YrhdjUSsMCAD/m2J25/y8Me6gg6jangfm03lm5F+rq4zCRSOcBTC7Ia2dlL7lPwRBQgzvmrs5hnwneoF301eBl8NTeUS5cwG6lxuiudS5owR9WCqz/WAvEBo2uc/UL81D6IHGSEJJgNPpDU0jHSRWgEO3T6L+zNflAGbxyjNyAvwiB1sywz6sAk2GeitNew1lJkPM3eTQIbxepOfNbPb3EWSj/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 13:52:42 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 13:52:42 +0000
Date: Tue, 16 Sep 2025 10:52:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 1/4] dma-mapping: prepare dma_map_ops to conversion to
 physical address
Message-ID: <20250916135240.GD1086830@nvidia.com>
References: <cover.1758006942.git.leon@kernel.org>
 <f40855cc9733160c9ba842bf6e7cac58f0bf1dbb.1758006942.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f40855cc9733160c9ba842bf6e7cac58f0bf1dbb.1758006942.git.leon@kernel.org>
X-ClientProxiedBy: BN9PR03CA0679.namprd03.prod.outlook.com
 (2603:10b6:408:10e::24) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 0637f2b6-4cae-4007-8626-08ddf5284e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RBysmrH89Hx+wb1U+fPHFCC75RoUeAdHyImJHbTsFOe+m/kCx5FLeQffU7d/?=
 =?us-ascii?Q?KIGYPqVyFrdpu5683zHGrQqfAopqpSFULXbGTJxgs5sB7YA4G4xt+j3b/jr1?=
 =?us-ascii?Q?v+QcLO9xCayPNiuFIQgqeFWB+eaTQ0MoDzVEYPEqPtp7gHSvQRgdV0vCkby3?=
 =?us-ascii?Q?zvf2XjjeDU1gyjx42/TneRAgYIg6Z1lSAiY0uK0FV+J5pq/MYNPlH1nyg4An?=
 =?us-ascii?Q?B9bQ/+ytEk8c3anku0yxf02SHicgiwdiXarnDHBqhBslEM4LK4Hyu49DA6Po?=
 =?us-ascii?Q?2OFYyoooceGjIVmXZmvFg0RKtJfmqKtNPC0Uv2Wov20GuKdcqdsn32N1GCj5?=
 =?us-ascii?Q?jvEkh1YQrlKHj5IaqVYXfI2NYxFPQVJJIt72i+ZG360rppLAaFQWIi3r7QPs?=
 =?us-ascii?Q?KOmvk90UmTR70H9ltkzeYBo3EyyUADcaeBRcTGi3ar2A2LHxqmW1Jp4L4TON?=
 =?us-ascii?Q?7myxweOdHNxF0QGkfnXpA+OrCufh2lUDe3zG6wV4Yt0CslMXBRCzOoUfNKvm?=
 =?us-ascii?Q?xxcRPiffasnehj9B7AquzyAmnJ/Ipmckyt1fuCaqspRH1CquvnOJ2UCUgSjv?=
 =?us-ascii?Q?+qLXmSV0fat86vUCLO1lQZhBtLpP1PUUnurv0+vHUJzn036JUVcDRf9cDv9E?=
 =?us-ascii?Q?Ha64TlGW1GCvHqekeBkp5g3JcAjo4Duk6TN1mprf+V2z4aXOerTMIAzQkXP7?=
 =?us-ascii?Q?2cEvKETJDYv0VO49K5kIqUTtJST9ynMuxZrKSQMnMsu6kQDZNp2nUwwO0d8V?=
 =?us-ascii?Q?yb2QUTRgRiI4piboOwBZZ1ZYSyYrCZ/EgDrHXR8xS6QarXZJ5qNm3WXFrhyt?=
 =?us-ascii?Q?v6uD0F3y4tUVJflNInpWeSqY+A3VhLVCd8XRF7Zy+SYN61QWpiqlTCoAx2uG?=
 =?us-ascii?Q?jJaX/3vzr2VTOr4MsXUWvMkII716OIX7Sfg1ZbD/W2XkDccyz0qyA4cW6E6c?=
 =?us-ascii?Q?yC5NxvXm6WenQWkDqLUT5uLPoz0WxjaOQzLbiUSzLKv+tP8J+pkxhDEsp4st?=
 =?us-ascii?Q?tAeM8M5WrE5eWnJNdDicFlogVciPSvnrkgG6x378JRfzZrc2TBfN/SDIDjQ9?=
 =?us-ascii?Q?1mqxeYDV4WzR3fnowf6fOu2DgMUOoG/iqkKPTM79xqI13pwfXUy8kcyaL+ip?=
 =?us-ascii?Q?jgf+Q59w/tJzUBymi+tapgoL1ZtKhnLpqF4+jXn7sNVbBr+9q54CAzTHfBPB?=
 =?us-ascii?Q?3swUKfxE8F+dF4NA4zAfkeLw0QQQYt+nIrpTPrTXxuMIwWMZ0h5IC1VRgCwq?=
 =?us-ascii?Q?7y3zLj10L0yC4i+OBwMfBiuxi/QNa3F6lcPUv5TZLVYmnQx8jlfPmG+mqIKO?=
 =?us-ascii?Q?7+rlrOcT5Nzqz1bc8DI9NYkVcqHEL7SVBo2cRZo0YZXCbas/112jdEhKVaz2?=
 =?us-ascii?Q?ykEJKoltTL8SXcOA6rBQQxD8MTRLQvs03A7cs7LYwOq+iSeQRDX3UT+0kqte?=
 =?us-ascii?Q?ISqGR+1QNJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vav9pOa0D2yASlp8IUaZf0G+9at8REMkNB/2xMRPaX/slT8y8Nc42DvB18IS?=
 =?us-ascii?Q?iZ7QH50oxElPYmZVJYHCfi5TnDnu7R27NGYtjrOGz3kVxR5LeK9vkPZHfp2Y?=
 =?us-ascii?Q?88JbyXsawY+p5wFSy11rC0wYBLZb3maAqY8NBjug6f9BstCtX4rngN/J+G3w?=
 =?us-ascii?Q?bOVl8CG+zVcY6GEUwtKwsXOY9WpA1ry3GwQqyyjkl24cBimph9S6IrVTLUQU?=
 =?us-ascii?Q?Do9aVe0eXyD+sIhXMqzYn2PmFueixpM4/mRZ2iIF47Lf3zBegJdnwRp7B1p/?=
 =?us-ascii?Q?pWf/NJaT7SMgZSXCGlImNdvGBzrQ+31rra36+ktMb8JHH2YsWm7Ihx6tGBtr?=
 =?us-ascii?Q?E2a508FYdu8QWSVhSnJV3tFd/yXH629lEum0tf5i6SvQyhcCp6MgEYGyCbns?=
 =?us-ascii?Q?2pK0NDUvA/gUgOL7ieMYyKRZlZ4lTtvBZ5uBLWa8DfC886FVazwOUZifyBbu?=
 =?us-ascii?Q?trLuqwMDrPrEPjHPU/BJUjSpyc9mUGjCvDu9vhRnDx5j5wIjgkRzXAHsLXKO?=
 =?us-ascii?Q?DnDLSde3x5ZVeeqQyeuddc7ZW3y6D9jx/qljJpVoM6flAwRn2z9NvrmXB8+T?=
 =?us-ascii?Q?h/s3YqQGsCzWxPNXJt46osVlExV4rhoLK3MGFhEbt+FQQvJtPjFuAHOyvqhb?=
 =?us-ascii?Q?b3CsQ4SzYJ2RICAMcI0dx5QBUphKZy6nSp+a+teozKdEVuf8TeUXQREIL1HC?=
 =?us-ascii?Q?6enjfBexMCKqx60H3J4Yu7GD/BbPyrr/PE9jih+O/DFh6neaW4mJS9sOaEkl?=
 =?us-ascii?Q?LGed6UIyCMFLi84rg9VyMUn6sVC1nztTEgQ0DxRhMd2sUmaRTnVO2WD0l5s2?=
 =?us-ascii?Q?p7e0YS5ew/7edENjtU7YPhC6gsZQs3x1DMLaYXHmeXEx4g5ssQt/I+pJ7pNE?=
 =?us-ascii?Q?3QbZxJnK3BpcdA9iTl/BQcYKqhM5paalt8DpHcikQfHdVv8m6IEc7dORCJ6z?=
 =?us-ascii?Q?pNUMdNZBU9eKz733qZscNFXEiItqwYQjEuG3U7a/pVvYR2Cqefm9GYSjUez4?=
 =?us-ascii?Q?GqX3RHf9l7SYbt4ZhCKB60Ay0MD8kgsFpLPeJvwyX5EKDsq8DpTL53oMENrU?=
 =?us-ascii?Q?NU5VTrOMH9PFRU0Ma4cVef9Jtw9TCcplCmnDb9exhzwluweyXCcN/6s93uCm?=
 =?us-ascii?Q?wasUCcYX/63fywZ20XOaNcJohqsfUn7gW2S30AgIlmaQyUK3AT/igHgFQ8WJ?=
 =?us-ascii?Q?FLhaeiiDxr5db1HRO7bDQgXsmkryLYWU9qVBJG9qnbN5qyxh94TcGYnwLICN?=
 =?us-ascii?Q?JPEqkzKc3ywGFONknc9bmWiq4QlxTyRMFIlCJcYgqlvdYgbf5qChRSZ5dE7v?=
 =?us-ascii?Q?FeMhMVrNA8tW4hKTv8oU9YOPBrsfz5h9acLNYQvNeV46LFxVz+90yi/gQpdN?=
 =?us-ascii?Q?IvDAl9vN++hno6AnNLqvpKu28jsh+Hv6EcWnZuxZs0ivrZbNyOYyIgfP1zSt?=
 =?us-ascii?Q?/ETrOnrga2kXmWDYbUqxrRX6uNcNK93+mGnUNXHFVTkSXscQ5r5Kc5PPGSab?=
 =?us-ascii?Q?DprEiQe8ljL/f9F5SmldEktiS2RCOfW10ZBCMrK8sKYS76b7kg0sAkV5uN5N?=
 =?us-ascii?Q?Vx3b/H3wqNyidfsAjjWRW2b4iBNyk6Mw3RHGCMwc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0637f2b6-4cae-4007-8626-08ddf5284e4f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 13:52:42.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7wfNpMIUKNV6mHIVkLPmpTU05FCIwfebXZv/+4xt09DvGsnOVHmcgQ8ccNzyUlC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250

On Tue, Sep 16, 2025 at 10:32:04AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add new .map_phys() and .unmap_phys() callbacks to dma_map_ops as a
> preparation to replace .map_page() and .unmap_page() respectively.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/dma-map-ops.h | 7 +++++++
>  kernel/dma/mapping.c        | 4 ++++
>  2 files changed, 11 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
