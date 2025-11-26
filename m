Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5978F4A
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764129552; cv=fail; b=ku5AXXHzvy8xePXsc46+YwwLoe27XUIzjFitwY2/aXCLoZfVs4xLfu7xyVp4SI/3OsmHflMt7qJKHD3GhsdMA4dd2zWBqzmdoiUkdfy2PPUR2Vv0gmWLx8CXXN7jLzqtHns9KOa+zsNBV8Uggrn3ySUKWlpOAjYKRjBrBPDiCiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764129552; c=relaxed/simple;
	bh=iZXPKeP/ZRqxViscjxwbyoCeu6krvgSyaMylW+JnDIQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfmK+iGKCg8GwksONOfEqE1wkH+8vXyz2p4wy2QXKG/CsKV+mnjRutnbxfTxizOvvJ9jXq07BsPNqyH8XjY7IkRR0+CrOCtLTJSVAs7DcAJkhwOe3lrgtMFHyIAFIlIvX+Z16JlcMul4AdV3Ixyjxi4gysCXXiPzJSumRXItkUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fq7lCdTt; arc=fail smtp.client-ip=40.93.194.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fq7lCdTt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCy4+L4pirNF11xtm1+hT1ePRIvH+Si1c59kyUZOEbXJfJ6nFwhQzTHzO43zjn09or1ZNOqv+iYDVL0BsOj8pPy09d/p0XyBfJxJr1D6FLAcFTTHVKEeiO2/p33toQu3zbqbPuwd7jpFJ40mSmx/UXYg0crlek9D6CgaQp0aEBdg4SpJYjOotUikXmS1iu3d7eQKSWK3S0eYuoes2OnSfTWqI8jWV0JJScUwVfm3zccvsuXHplDqMaAhby+wQNW5shSY+FF3c4Tnvbu1+jGrP3Pw3TsrwYhdzYABL5zzgEBd9TxgZSxPjCcaXThbY7PNFqwBdU2oPFrf282FOK+dbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK8/wUKX856s5DRsf/gn1L6DSH4hHsw+R9XX0ZovqDg=;
 b=hExA1CDJhej57UnEpVX6DddYRy/gRPZuIy8ST4gYhOfc6DYxXQYR/6pyL5B/jt7aTnH981w+UqM814R7gl0xFRsEbtsXwpU7KgLMC1CCGPIBAekSmWsPh0PT1n1D+bMbpieyH6N/KsPdLZGCTdNd4YmiBnisE1s8inubh5Tgpst19fVOgqi0bzKHDOVc6Z0hcpza5RxQw0nC6FU/GLVvzARbHyKCIDA6RIu8hpBNR5NIpC73D5vBXJM1CW5LIN9znxMRaYQo5HyNWlg/+k42rflIpWH23oRQISbpIq8Syu5HrGLPwmdoCOxE8HUEMyZ8nCcmcGu5aJvfuW8rXhNQLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK8/wUKX856s5DRsf/gn1L6DSH4hHsw+R9XX0ZovqDg=;
 b=Fq7lCdTtSQF8Gjbx5s12qun/zp76flAuVtL1q9KgIqqQNxD08IDqgA2UsfgIxV11sB2LgsQlg7L8jGzkx6c1WrQRrZ4c0kMWqNB0+wmR52QB0PDQqpEmwZ7ZMrmYT5UdMPL3BIzRhgAyhAhCPzMSEaHe2SFEFT9dQ4Kfp86144ZxBQio9b04luAXxCu1A75+9Wz/3PvpM7H/5OBdH2sCJO2HWjSxj84BusUvjjz0ZgwXODmjhDTYUBcxCZBgz+OIFqRkkxdZL/2AeTq5lbnerce4gh05ahuAj6vXBN+JYQ3++qNYsOXIHLOuRPSeZp7+NATQ1SwA2BxlBNUm+x8Gfg==
Received: from SJ0PR13CA0166.namprd13.prod.outlook.com (2603:10b6:a03:2c7::21)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 03:59:08 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::d1) by SJ0PR13CA0166.outlook.office365.com
 (2603:10b6:a03:2c7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 03:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 03:59:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 19:58:53 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 19:58:52 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 25 Nov 2025 19:58:51 -0800
Date: Tue, 25 Nov 2025 19:58:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux
 Documentation" <linux-doc@vger.kernel.org>, Linux IOMMU
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] iommu/arm-smmu-v3-iommufd: Separate vDEVICE allocation
 list
Message-ID: <aSZ6+mY45RCXoKP0@Asurada-Nvidia>
References: <20251126033602.28871-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251126033602.28871-2-bagasdotme@gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 306006ca-4165-462a-d83f-08de2ca0261a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CjfkvEkQX1cckJ7G0vxTr3qGx9UnC4Jsz5fcNke2fpuArBDEs7rVMwnylE9u?=
 =?us-ascii?Q?f+NkiofP9KyfOjIe7IGVJ4aU6nel+goH31MqHC2yhazmKsTCTEM0FjLSB+D8?=
 =?us-ascii?Q?uK5G9jl4X6zom5kEmheFtXVStd0HXJRwDYuJLebAMC1ehdik9mGollt8vPDD?=
 =?us-ascii?Q?oud73nTeb2+xEwoaBMn6/slFMzysNclpx/IlhwnbKqljWHgtu+CXtx6sneOC?=
 =?us-ascii?Q?xwd3kHPu/X2i1QVyNKE1iKwxDDmO+PCTyqqD5YKqSBwFRn4fdB/nhyKhUz82?=
 =?us-ascii?Q?lbg3beqHoV0SL4d6m9HQefeSPy9jP6p/QVklmcgy6d9wRTfC9q5cbRAhpPEA?=
 =?us-ascii?Q?Z/8BFBUkdgPZYDxC4IL7YAfVqr2ljeEuPgfe4CEyNxWHSh7lQ1PEnOhA9u11?=
 =?us-ascii?Q?NsN1U9I3W3YBockhT/dV2+gyEbCqNwXLxarp8qBkMXZW+kpdByo6Io+dQl0C?=
 =?us-ascii?Q?7ghAR0SyqPZfjQmZ9JnfXph6r3c0HfBSq2C3jablXzsg6Nnz2mlT1trFmxFh?=
 =?us-ascii?Q?dSUjVGPx6RikycICcAm0GZxm6X2rhpdYorxy5zi/qzezU3xGBlCb2iWuWJ2A?=
 =?us-ascii?Q?BhaegCyv+JuGeGZdTYXeZ29x43QyxF8pRqd6HdrIXaCQVdCqlDan1MgRF8u6?=
 =?us-ascii?Q?JzPihRNaRJHPbuHc5Nmnfh7X/xJir2auqRKlRmdJIOdnDI3xpMw+dTToSxqD?=
 =?us-ascii?Q?XcaA/4S37zBa/RhGEH3QPx+98cb+sc39EsXv2qaqSlavMh50QlXh6mU2qmr2?=
 =?us-ascii?Q?G8/tH71cFjpCFivCIwmirUrPuhZJhYuiHOuaGAVX6Mer2L0jYbq5b3AO7GFJ?=
 =?us-ascii?Q?aOG0Sq6XpVmvvKgnl8fPcRA80V7TgpovKODq+BnuN7larvxzUsLr/0ekpmzr?=
 =?us-ascii?Q?ufg7+2vgvVrzBuv5kiUDVxYDt6D0giQ7BV/MjbglRRRjYYlxHSc1fPJC874N?=
 =?us-ascii?Q?pHnfIS1ppp6c+TnVj38faGLZCY6VPGptOI4eIyhOgtXQqH5ykGDgpfATqDgp?=
 =?us-ascii?Q?VEAOteseJ3a8HnC5MBPDeDhsvr4gXcGnZaYlS9eGnMgwvGqogzubgIt6wzI7?=
 =?us-ascii?Q?ezJd42FPwwNoQVvtTTCdvLlRk9NNJXy/xyOTkxiiRDP26sPEKoemiSJPNfOC?=
 =?us-ascii?Q?nkFmTRoDlNkdxfTtIlgpMzObv0XEjw2RxEF5LYAZC+MURKbKUA3H5VaHp/Ab?=
 =?us-ascii?Q?V5YzWtvLpVYeq+IfBk7HIKzABLBOtEZleHZgrfqt3YXkz86UMiY2aep46rNp?=
 =?us-ascii?Q?ksO4Bt3noRU4Xtum13ceZk+Jy7+pr9s2o0NV/0BZeYd1/kG1XDNhf2dq7PXY?=
 =?us-ascii?Q?ZClZh2UddbCkp3lEEnpxVFbdbf4rcqqPIoxf848GVRxF6p0loTR8BrYlIp0G?=
 =?us-ascii?Q?AI+siO+QhFBegAoNrf+F0XVBp6OmJ3zKfCE4IVSaMGQ/qGxOWPc6F233v0Os?=
 =?us-ascii?Q?x/JYQrFNwqOYMdpH1pjsG9PDJMHsFmYLz9sE+NyNn+mVo/kG7CFcIzp4km+G?=
 =?us-ascii?Q?/x9AuIuuDoA5LR0rWQWGNu6/UVCJKqEw9aFOtioSHVhba4/6UzKzp9Cs3yJ3?=
 =?us-ascii?Q?/aiSDcfqQeaq578fz6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 03:59:07.7449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 306006ca-4165-462a-d83f-08de2ca0261a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061

On Wed, Nov 26, 2025 at 10:36:03AM +0700, Bagas Sanjaya wrote:
> Stephen Rothwell reports htmldocs warnings when merging iommufd tree:
> 
> Documentation/userspace-api/iommufd:335: include/uapi/linux/iommufd.h:456: ERROR: Unexpected indentation. [docutils]
> Documentation/userspace-api/iommufd:335: include/uapi/linux/iommufd.h:457: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> 
> Fix them by separating vDEVICE allocation list from preceding paragraph.
> 
> Fixes: 9f0b286fe40130 ("iommu/arm-smmu-v3-iommufd: Allow attaching nested domain for GBPA cases")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20251126125920.207fc959@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks for the fix.

I was about to send a v3 over a fix :)

Anyway,

Acked-by: Nicolin Chen <nicolinc@nvidia.com>
