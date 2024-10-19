Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6F193091
	for <iommu@lists.linux.dev>; Sat, 19 Oct 2024 04:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729313513; cv=fail; b=IbHYvnM43rMdz1gHy0PJlvwXw9kZrLd0m1gaxRl94P3+XOamMPB3iNf2IT52iQUvWTNaaUzIjJWiUsS5W1CDHR5UJHdUqmLCF5dGT2X50exazaQOa6q9GtiJQPiijYYapDdPG8gzYw0JQxvNhlIfE4i00i1xnA2x39/M5YlEDI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729313513; c=relaxed/simple;
	bh=FpyZOO93yfpFhpaGGpO/dxYEkW93GgW3AbU1q+ajkOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LF7S/19Zv3neXGvBfsFQcEsWDnCwZ8yFI2KCnwKs9dyIHlbJKfBXjzFFF6sR3cnWL9PJZp4Mv625vPkTAZRlU7K2jPn6MvR6Ji/Kwaq8eOKHUBtvhWgvgAYZ9rRkWI3kR6KRQunu2NsZkFK13JPVv/zP5YpkbFp1y2jD9MTbLJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jYth++g8; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jYth++g8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDIOFanN+gAEOXy+mflSSK9xHFnIvsZMsAyOSH3KQK4DOCU9Sp0b/41FqeTGRgAMwISb10OC9uVwBmWm4GdnN10RzUx0lmSuF789TCXGjyCEsu3OavurEBgXy8tsedXWMP2AHQzwVaoiUrsEzBWzLBWq5a+u/kj2dJu2wV8SDIlLa7/3VuAtCv2dGbzCDiKVZPDOxla1Hn5LU/z+6QrDOx5yqj7JHo1yCRUZaT8nvxIEXPdLcGIBLeNXApQaQUVOvPv6ZAiXFX2ev88r7jX8zaB4hqzSPl7AT2Auzi3PjOZDqmgq1Jm9YqxIOjauP8DL+pFb2/7Lj9Nyg9HOEw9cFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCYyHe16s+9iBjNXYIugoXLiKPMRkXBx8y+bhNKLF+k=;
 b=LkCoAJGb7eZnjQld24rore1rbxXiT5GkDk5pa1AflSxhWfCg/xFAUd1QfqWiZdZOohxGJ2dxA4vjR9+modpmD97JAZGH0qxHRJT/gT4Hvv2t5k7+b1jnrxMhid7i2n6j88iKUycAaih3P6MJtejhXBYnSbQy8yIS8GIjUMbta4/yQJAN4s50prIkKr6uPFuvpyGSAHJ85Vb/Y3WYIFqYq0lZflqvC3O3DHsdrWUPGELRDXmX9LepK7LVmMffQqZo2zli64vlO3sE2mICkBI6d620HDlxEpcU1A+Mvq2xgh0XIRIyaQqNg2Iu20QJhUo+3V8a0fm1O2r282yYXOmsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCYyHe16s+9iBjNXYIugoXLiKPMRkXBx8y+bhNKLF+k=;
 b=jYth++g8jMrZ3X0JWBmEiNnO0cTbQEFOGdO8WiibZ0JrFtZgURpjoTKNazkb8aYPsbhNFyvATIe8PoOvsCm1nTJpzz93736yzs8W50oGu2lwTt0Ze4NXkVaTWqhwzU3Jpc/LTCLc7dkJJId+54bYPaoJndmL6gM3+0OUxgaL2DXcrBsrC/xQFzlJYj6gkhfzyVp+eDsqEEziYIOUzpWGXh0zaOMDmmbP1bChy45luFhBnjUmqH7wwU8CfKMitn9Bg/hGx/4AqPsV63PvC1XcO1oL7d2UE36WxToq/u2BthPWdM72aZxl4vQ2c/itviGGP1zueoWaw5MH4opgBRf5KA==
Received: from MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::32)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 19 Oct
 2024 04:51:47 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::be) by MW4P220CA0027.outlook.office365.com
 (2603:10b6:303:115::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Sat, 19 Oct 2024 04:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Sat, 19 Oct 2024 04:51:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 21:51:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 18 Oct 2024 21:51:42 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 18 Oct 2024 21:51:42 -0700
Date: Fri, 18 Oct 2024 21:51:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <ZxM63MvPZLwboTk5@Asurada-Nvidia>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
 <ZxMUOfH7GoY71FxD@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZxMUOfH7GoY71FxD@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ea7ed0-f751-42fc-e368-08dceff9bc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YV3iyHm/PQghMDUpGkQXTzaHx/cdiuyBRtIs2bIvbnGoS1BfigjQY4fQJdH4?=
 =?us-ascii?Q?pOQsOZkcgQJvKFKmwsdQhBmwiCM820P5oCtbh8zjqdv0ydBWSDMRLZPy/1kw?=
 =?us-ascii?Q?7YlbGAN24T6VNrYD2sUvxi+TKBl3bfzRl8zGx/Bdu/1Pk7Hfm1w7s2Vp6rcJ?=
 =?us-ascii?Q?UjcXshMNoky8g5jsBirsI/JGFe28HEun2/ZXwZU1iSYBjjLDIrJ185tujMq0?=
 =?us-ascii?Q?OLVV6naCp02JDf1BYdzhte0EEhnnQNH5/Dn3QSTpdZ9ehsOGBT2GvumqU1v7?=
 =?us-ascii?Q?ln2PEUtvuQ2krSSB1w/TpDRv+nKD2ccisme51JYrLw8BVOZeZaQEQRnWtWCd?=
 =?us-ascii?Q?Y32wSUmIIcAEdsRiwhyhpGw1OxohJCqRN1XqY1XgSj0eOi5TnLTJZq6QAk4R?=
 =?us-ascii?Q?G+TGyacOpl502NrWWFRYaWbIl5KPtGWHLn8/VLYhgvafGJKuJwGAyOCtmhqO?=
 =?us-ascii?Q?r2NPfCO11BtwITK7+RDixxH/UenKgMjr8J9zJB4+jnTnsWnV8/WVO0/yzUCe?=
 =?us-ascii?Q?1ChNe61R0ie2Zx/JX05BZ1+x4MclXDMqzhlCcLtDjENttwT7qhmxjQUSfUCK?=
 =?us-ascii?Q?7nWKG24nEwIjnIwpXIO/mzAr7YWQsz8jNctm2xTbWxCqk9oVofeipx1JOHKX?=
 =?us-ascii?Q?ZuPy/sC/0gOfWj6hMWj7bn8DPGg5ZT9urxU4/e7zIjLruvRxlO9jYqco8s7I?=
 =?us-ascii?Q?fUyDhBxgW/hFZW58vaX1ke1pNUR0MwiRurZLM6ZGwBEycVEWBTLNe+tt5+tg?=
 =?us-ascii?Q?iyPPpTRS+ZFw5DlYgLqDINgyWJXvIGTbC1DWHqqUT8mOXEArWngbUPSK9faw?=
 =?us-ascii?Q?9QUfZaA3Q+oRsikJGExhGBv3GPK0tWByJiqObFH/RyJ8n3PzSqNWBhDtEMyl?=
 =?us-ascii?Q?jGZXTwgQK6ibEj0D7ilTP/TuiGl5iuPs4X5qqfvsesEVDq3CRS6o+DXDPJgr?=
 =?us-ascii?Q?zG+m8C/TVqj0EAl3i0kuQPxms/sJcU3h0UQquMM/k3mVup1o4iBt5UmA2v/D?=
 =?us-ascii?Q?6Vuct+xrd1tScGgWSDfAjlNa64VXcUeMPVvoJyj9mLxniMOxuingYNj0sC05?=
 =?us-ascii?Q?Nh0ESVt8eRcqd0zsNUQLc46e8lwrLMRb/zq3ufiexb15HA+dlxxsOx9rWa9p?=
 =?us-ascii?Q?jqjjN3RogeT6qCS8qEo79lRtJrHNjLQ70sMRwtFW6dzCeLPmt0wagowM7MzJ?=
 =?us-ascii?Q?Z2/e3B+W0d+2Is/V9a7PWj6edL3p/aWs6zBRON9acMTBynsiNopHT5UUpxZF?=
 =?us-ascii?Q?WdnmtbtbmScR3asBXJaOx9qLewDrzqrrPbmplgPbTrCbY/CVT4Li/zynE/Lw?=
 =?us-ascii?Q?SFKUQFMgf1/JO4ie6CsRttFgssYdoDPq/lu+6yrWVFdEGgs6OURzUHbuKMM7?=
 =?us-ascii?Q?w58tSt4Hrwgt0UaDBPmnAp/Z4Z6rGaz6zoIjOEnbSCs9qjvnxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 04:51:46.1733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ea7ed0-f751-42fc-e368-08dceff9bc30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249

On Fri, Oct 18, 2024 at 07:06:49PM -0700, Nicolin Chen wrote:
> > +                       put_device(evt.dev);
> 
> then, here it puts unconditionally.
> 
> Maybe we do need a memset(0) to the event, then here
>                         if (evet.dev)
>                                 put_device(evt.dev);

Oh, put_device does that already. So we are fine here. Pls ignore.

With the other two nits, it looks good to me,
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Nicolin
