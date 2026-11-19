Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795118110;
	b=OH4vm5XnJL/c6Vr0myLrDkH79zBDuO1+HGwmc34GR94nKARacHEa4eI4XSIa4xVEhbw+
	 sPS24IH4VuUZzud7DvIEkKHZPGSGRZ9w/RuAvxhdqt+KUx5mzFfVbCyXEG5HaouHw8Adl
	 eo06ySQo2+1usxhZx+XeHpFLQMVkF9NuyG9NJ5NKUSN0+iwOyCmo5t7H94RQG7D8NYuHg
	 cV5qSBcCVXm8FuylnoyFWOdZJUTkJM2SUUenoQMbDRaQYhgI7+UXIOjPXUEUtiU68mA+8
	 hX6ZIofaKgMwjZy6ZkF0/k/RrucklaVS1G8DkQWy/X3Jdpnl2zhrrln7qxTg481KPyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118110;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KaokTRWuBAgSyrH+wa4hKzJ5/87gjw0RZ3cfo+rjqgk=;
	b=AyQnd7ulHeMEj1Iz+T+ANhPiwhFqfTk08UTTt+3eghbisESf4b+y5Gm0kUvhYmmf512A
	 5LLxwUADHIh9mqYB1jg01PvkjNwAvnqZf5x9/rMLAOzhfuOCRUoz3ExLLO6EhnQIwh0mG
	 C+kabbtBfDH7YP4BIE7nb8SqDlvbreI6njI1HGdPdCAvwmL6VbdJD+iLQR7EUfjzI6zb9
	 YeU4eNDpEER7a9X7jOHEjdWNyKBvs8ayQ1vOp8O7SO5sa2PrVmUQz8UBcHDPl/X1Zjngm
	 3oekR6G9m1jeUiBMD+jx/l/sSOFGxJ+hXYOodLeoSrurgO1Yzcv5YWCRFggxmCBS8DQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BSVvFpPZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.6
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A6606A334
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 19:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE2A6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BSVvFpPZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1c6XbNRhwwfY2LX/VBKhOdzZKGr7O8UIeUZTpAWN7SVM8+gSxOnVZmbdrO1rhrLAN5TZeRkX3WkTilBFgGD8usY21YMv9GVfTyqdgxdF8vEZVpxINp2QwgENpwV1d+yH3rh/qm/B3XBinnFi0eTZdvJJA4fFAkHv4HPGQHeclTcU0egDqygyhDSzbS7M3FMt8/x45wo33T6JoZ8v7ppfAqo3MXUly3CwBK9g08LLj3rffJkuNP6mLOqgLDKa/mJOKkBYNhvwr6qxGILWZGhYOSoLczxeiSpqKnk/kknIArgkLl75h/l0rsmXodrg8ZQfVyTF994IyaDoXwhfMhb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaokTRWuBAgSyrH+wa4hKzJ5/87gjw0RZ3cfo+rjqgk=;
 b=xEfL/Nstc+ZCoL8AsmZG1VXYZjVvAfxAEZirgDaJ+LwWkSEQQBq6S2/JLgGEdLIKiyK1ZW0+YOjjFHCibsPBijszXTX9IpyCS3Ic8kk5FwNPAeCUJ0RG0T51+LRopxci1/KJFQkohUzLs3c4KdECUy7Lr5qimT6kqNzkGzwdtbw0h/tZ7j/fYeNZDqTTRD9Nbx0maA1ePfqduCXeqx06IVN/C0zrA0XrdMKeMayDiZagNBSlgKMWFFcfca2+HGFSCYs1uBISdPCTSp6xUm4BhHAjsvTBA141M3yTcBhbVTOOieNagJhxIeo/09JSve+NHtQGJ2KqZaK1h67VZWNSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaokTRWuBAgSyrH+wa4hKzJ5/87gjw0RZ3cfo+rjqgk=;
 b=BSVvFpPZvNCkopg5dyTeEvn8ODzNRcWA80aiNtZZza/sJ3h5BJb4l86v0hwWovRnvJ7faBxOuf+ETERqqYyd1C0pX4JZ69f0qwsY5zLnPNVV4JLDu9E1pVjp36ZA5iUOi9gQXmvSPL97Nb+iHpnfNIhRAe3oLticDKsfV/TBSLcIzHE5LI9Ym5a4xuuyjSGgciuV4djFEqpHJ6SnWk3v9/7N4oCuIjF0HpS3a3/Ax5VkYNvdyI9qSDTjiZYVj9EoYU1FTLM6ZmZn9mX4qJwyCYSYKalfCa3GBIBU3pzv4tEhuNemR4ITIf9RYU2/nUXf/zlm4fENhoYtuRgQqYcaWg==
Received: from DS7PR05CA0073.namprd05.prod.outlook.com (2603:10b6:8:57::27) by
 IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 19:54:53 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::c) by DS7PR05CA0073.outlook.office365.com
 (2603:10b6:8:57::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.2 via Frontend Transport; Thu, 19
 Nov 2026 19:54:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:54:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 11:54:36 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 11:54:35 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 11:54:35 -0800
Date: Thu, 19 Nov 2026 11:54:33 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<joro@8bytes.org>, Peter Shier <pshier@google.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v3] iommu: Clarify uAPI errno for unsupported data types
Message-ID: <av9T+V268uF447sN@nvidia.com>
References: <20261119192355.2428207-1-praan@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261119192355.2428207-1-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f3e7bd-0fc9-442b-df3e-08df4676fa54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|261026121527099003|261021135927099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	psG36N2x+LSZ6nKgtk7HqHmCL2hIXf5/f+NZ4QTZff1q/+QcQAc+UJfXFnhsG95p2AP8ClMtt4K+nQzKu9e8InW2uoUOc2H+BzBNR9tKaZLXJxHbuce2DWkWiZMs1RHQ36Bbi4eOIkSGCC8MHGs3hoLtaRgkEDIzjP/QWJWqskJkljqvQgy1ftBVpDplCgVdzyhU9WpBRg32Ycr7IpkPujLKJZYWOR4Q0OqP7ZD77/rMhihP0gyg32wVHqkTQdD/KPskjJWzFcETD+/49koJ8tr2q+dhMPP+3z7onTjRh9TlH6tkNwp9DmwbPAVeFxX8h7RiIuJuTzkzL0Cb+qGbx49+Ric3oDaVeh/3VGjW2VQwEUsU1X2b/XfEkQ/Bklk6AMoabwOrFJPtJ/1lZejSZ/EQeEXSFX5W5ljHNRImaSZVaiLjX7fXiweQpgUKsYihO9A9AJ4RDGKG8iaLbAj3CIFtXyXY/911aGUgf+FSl53XSSkUA9Kp6+MTOGzL6c9MtOktYQRrOjyWUqHWOdfS1XeJDbcE3U1q11BPwBQulpvM9PtEPAo7v7AknMG6Lu8IVeJ+HiUqq4Kju04+Iz0zN4ZtJcJTPa+1vEeJ6/wYWMwEC6tDioJ9P0KrEDyGkfHADM0GWvYl7kD5BXTpeuC10WNoORbBALS6AfkUdLTTB00VMSAFKEsPXnmsVGQf5yqaMnc4pmum3XQD3JXdjguOMQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021135927099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cCHw1LkTpOJCv9i5Hb4vlBUpl9mpOy5je0/ngkTmQwvZ3fNLo4iTSkLipmJ7MpMQC+wMYSRnf1oFskpeTjuyDj93f9Pn4lzmi1e/IDNrzeOltNXZvDk49cXHRU7pKoMjB/NrHxvFQZc54Bm7pckIKXlWHpof0cgK/xXT7bzsbsiLTb0NSMI6aSzEFeK2Tne74IvRb1z+7mAyKsB2MBx9kKRfawt0TA2xmCVMo0qudYDVWlo8Q2J/WWsDyqZ6dALPGkOIAl58FyZOHSBeMVZzctmopnsItwIHM8zQkzGStgTXdigGWzfAq6/qwTdcJslikAzG4pvgUXUtEVNdsT9ntyMkH6+cGkAWkWK+hA6yKL7q+ASoeMOxya4gF/N6+Aa0xjngQwer67NMGglfD0u0y323aOkMdTZSl0l4+gmqx9M/1Hj89lIj6vPCU8e7nFIb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:54:52.8332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f3e7bd-0fc9-442b-df3e-08df4676fa54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354

On Thu, Nov 19, 2026 at 07:23:55PM +0000, Pranjal Shrivastava wrote:
> The IOMMU_HWPT_INVALIDATE uAPI says that an empty request array "can be
> used to check if the given @data_type is supported or not by kernel",
> but not what to look for. And the iommu_copy_struct_*() helpers and the
> Intel VT-d, ARM SMMUv3 and selftest invalidation ops reject unsupported
> data types with -EINVAL, which means that the request was understood but
> a field is not correct.
> 
> Return -EOPNOTSUPP for an unsupported data type instead and document it
> as what the probe looks for. Since arm_vsmmu_alloc_domain_nested() uses
> the copy helper, it now returns -EOPNOTSUPP, like the other nested
> domain allocators. Update and extend the selftests accordingly.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Acked-by: Nicolin Chen <nicolinc@nvidia.com>
