Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6612C52E
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212103; cv=fail; b=RB//MO10/2BcIHWk1/1Y0uN+V1Q67ZMTgUFMSkByo/+ds8IcX15ErXTGEmAvznobTnt/W5koXZElujAeKmVvguPPFKXF0ywJWRavYgknongOA9LsHjfoGRl2589Lft1sRP1X+cc6CW73g6n7EZbv/W0/uwB96GyMCxMw9MbaqZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212103; c=relaxed/simple;
	bh=XCCTGbWR6A3JqJoioRi7yUp8mQaId4mE667OXzQr3rE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsqju3YGuQEhvB5WE2xM0X6tbS09+6P5v5oakemCxD2mvF1o7idjxn8LdD1apz/ZY65GBHC3zZifzwSE+Jwb/t/XWrakKf4CAPHN8yi4lgS8dcWEzOowHZoVTQThgZIKIOJzzHHTQZmxJo2Skh1ckvO4azdlhDphmCOnPOM6FPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OKTXMWYZ; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OKTXMWYZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUEvTwVXgl6V/4I69KCsKE6E0IKsM/XZvWHeWZ6fkDlS62TnRhaLHI1XDjQg9SPqaCNSCzdzhuUufiuxh8En8bAUpolrswTrVgbHNctEARufF2Xf5oBrVIXXgbcUYDgb0+KnOUSFx0+D2Go33+jg2wUG7CdLUJMAVv3uydxmkmER5xfrQ8nXqLHhG3bfou351SW1Z66uOsYedb8DK6dA5tYlwODVqSiOqNvnE/eSJpxX6vWLcPPQmkjoAGYnSagaM+n1Q7+eKtQTuNvY8GjrZZZ2TcfFvkJMm0/NxpIeYX6rCj4ZIEx8bQGTQ65CXWm5ex9d3vo7C3Yg3BzcB2aEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAZ3INXQqwznZqO3NbDkfXH28flyNcJ3W1y+Es4aLNc=;
 b=bj0thn4xTf56d09xahASF5OHLfXgn3VoD3HXcpEVsudrA3Fsih6ZakCKnfJLVA8uC1JQWIFZiMB60Xpj8VllcESskqCrFvyjzn+52pPfIowqnB/wcglabjND///O95m6sb8Wdbu/ya3FD2MYx+Mvog3CTHQdfd0+KW0UbgaFaDiGb+SUcw4Sn1Gg7nXabjM1GMXQSF7vSD2nV3CxX+9/3hvwj3rCHpm1FX6avSnBiKRC89pgZK3tdRF+R0D0daenDjyAof4Dvb2mktTqi6/X0KReomfNBelLmIatsaGbD2z4LFjoZ2DsIJExcgBj/eRdDMpMx6gwKbIjcLB/h+TbpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAZ3INXQqwznZqO3NbDkfXH28flyNcJ3W1y+Es4aLNc=;
 b=OKTXMWYZxAy0oID8si+6SIPms+yTxbkTQortX3jDUs8GJ7ZCv4SVlbm4LGKMRVmI+Brmvs0+mULSj15VpVeGNy3uRxAwJezW2pKwyMQ3KdDXQG9Ole8bCYylsQI3AIrxFHZkq3po7hwNfg63j2HPayk7ZREnZu9x8ORs589ZVG0ooOU6VVmBqaMupnYDUTQ9GLIAnsHBYyvG+efn3BcoZAEnJ7jmrmI9WddCf0+7dDeSpVRu8xRi327r9LPvMsQE6l2u9IDzf6hRoJQrQJAIyzQplY4Q1wGPIYGfaxqN11B6eJrjGSUtNd/2Z/uf5Qy4+hfHVT2re8mKuMTkzsvwrg==
Received: from CH2PR02CA0015.namprd02.prod.outlook.com (2603:10b6:610:4e::25)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Tue, 24 Sep
 2024 21:08:17 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::44) by CH2PR02CA0015.outlook.office365.com
 (2603:10b6:610:4e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Tue, 24 Sep 2024 21:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.0 via Frontend Transport; Tue, 24 Sep 2024 21:08:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Sep
 2024 14:08:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Sep 2024 14:08:03 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Sep 2024 14:08:03 -0700
Date: Tue, 24 Sep 2024 14:08:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V2 5/9] iommufd: IOMMU_IOAS_MAP_FILE implementation
Message-ID: <ZvMqMcJkWj0Qfaef@Asurada-Nvidia>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-6-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1727190338-385692-6-git-send-email-steven.sistare@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7cc698-1b8b-4384-ee6a-08dcdcdd0327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8C8CJRHiVcFivISRYAoPjERvHdjja3PHwXNyhL35Hx9YkaJFg/MSVyB1o132?=
 =?us-ascii?Q?/W8Dr+BRBp7T/LH1vlHeFaZpFzQl1ln323BhAV9MMj7E2g5aJSnCP3bsOJkN?=
 =?us-ascii?Q?jtY4DvCHO3mB6PFU+wdWuIeItUuhrIHiD2le06xc8BnSSTY+DEjq610xxIz2?=
 =?us-ascii?Q?NmkYb3AvAJ9a55En/NOVgeM2ZLUuKJo7vhDMyxyMloGG4pggJhB6ZNOK0z4O?=
 =?us-ascii?Q?mqDFkxETBOsPU5KbicPKcSzI7Namlnj4+0LH8bMX9m38L/yaGi0QAKyCPVOU?=
 =?us-ascii?Q?ibWZKA4jCE3GkU1hOt4EJlw+3IrDO92IGsndzenb/zW0ON78azCcOkutaDQ3?=
 =?us-ascii?Q?Y6F51PNuPDwJZh4GtykVNc1+s95mqyYOHjPKVBGUzaQTsmZBT5XOY3pNqiLW?=
 =?us-ascii?Q?7Hs+ESxG/1MbgdBTsDUc2fuu54ZwOhFuTnmVugEjIF1Wa1VL1PGjU1YvLmor?=
 =?us-ascii?Q?GoG5fs3DByXs4ECjljaofDGszg+l5f9umD+WyXH+muFTmfkOW5ygFsVl5ATK?=
 =?us-ascii?Q?T+Tcs2HNurn9N32RbNHis7sYU4oKY7f1thbXZlIzYUwc9KOsZgy7FwpgYV4f?=
 =?us-ascii?Q?FHy+SupF6bt8oFrvh8ujZPYGUOsZnUd8CfkFzv3vSNmqDIAD0JaLm6RSxsYq?=
 =?us-ascii?Q?oyo67ZnLtPBJsEUkPcaJfSPpVzEsZo5ku3a6kMPccnnDb62Ny0q69BXoQ5Qc?=
 =?us-ascii?Q?IX/D4AW0eiTdbTuVj+HRJVyFhx8f8vB89WidK0OURjyvnLkLYd3uClqu5sZ3?=
 =?us-ascii?Q?zYlvjf8KG0zCkYB3rM6Cai2vNqNKZY9Gzbv2DEsi+9DUFKY0ZY9lF0Xyk3O7?=
 =?us-ascii?Q?kdCNTx3a+R+MoMqCHegY8YpSKG93a7cBabM7A/ZjLaDJLWrumoAUOgUXxIpt?=
 =?us-ascii?Q?nc00pB4xiuDRqkthmMmvfzdB8PkQFuN7EkoUxZRh2cwAVSOoPa1sCYY+KvTI?=
 =?us-ascii?Q?9rHcIkxUVqXKiBXUDl2yph43e2r5IBZPyisGS1U4pOIqCQLUcUsYhzIYCAVx?=
 =?us-ascii?Q?ARe8jNVS8f80b5FDPRgFVlY5R3iLzcs+m0QQB924JQVdY/iz6p+M848TADWN?=
 =?us-ascii?Q?1QXCIRAQGbJ2jQIuzpzpjEszOAd8hOdaHS0Qnwo6WhO9CpNflzEIkxRpKGVc?=
 =?us-ascii?Q?nN9iF5tW/QJ9VA7gVEiuBb1Je2uj/AuC8rSsMgC5xmI1V+1ePDWuCBvwUpJ6?=
 =?us-ascii?Q?s0w+39fJm3xcly+4A4ICtSRgExfTg8lWiWZ/Bf5vbVLq4J5TuBUO8sEwOURb?=
 =?us-ascii?Q?Wk3ZEPHKA5ZGVI9PAk1oPE0m1GYbEoQtRAOANZ9DZ6u4v8JzEC8ENKEWjTjX?=
 =?us-ascii?Q?cj00YygCNeqpZPk8eA08Y2eauuQFSxa9kN/65785jIwimhTiaTcfPRpVwxJl?=
 =?us-ascii?Q?X+usARHIwGlStX9HwBJ7jGzRCPTazVnzc6wFZyC4LfFYKc/uRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 21:08:17.6568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7cc698-1b8b-4384-ee6a-08dcdcdd0327
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155

On Tue, Sep 24, 2024 at 08:05:34AM -0700, Steve Sistare wrote:
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index a0a66f1..1e14a0f 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -259,7 +259,10 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
>                 /* Use the first entry to guess the ideal IOVA alignment */
>                 elm = list_first_entry(pages_list, struct iopt_pages_list,
>                                        next);
> -               start = elm->start_byte + (uintptr_t)elm->pages->uptr;
> +               if (elm->pages->type == IOPT_ADDRESS_FILE)
> +                       start = elm->start_byte + elm->pages->start;
> +               else
> +                       start = elm->start_byte + (uintptr_t)elm->pages->uptr;

	switch (elm->pages->type) {
	case IOPT_ADDRESS_USER: ...
	case IOPT_ADDRESS_FILE: ...
	}

Would make it easier for us to add other types.
 
> +/**
> + * iopt_map_file_pages() - Like iopt_map_user_pages, but map a file.

Could we just write "Map a user FILE to an..."? It's not that long :)

>  int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
>  {
[...]
> +       rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova,
> +                                file, cmd->start,
> +                                cmd->length,

We could merge cmd->length to the previous line.

Thanks
Nicolin
