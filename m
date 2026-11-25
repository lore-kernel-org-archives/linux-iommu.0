Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795646367;
	b=bG6E7Cx4oN5srBZpIIhJM1n/QSChC4oLU/NocFcqe7ZB1EKL2xbdXkzYTWbcWfGSgCEJ
	 aUsYA+40L8dm+fFN8bxvSyjI4VXkNiutTZsMGX+7WJ9ysdMNlbzZ6qWSoBuKwSXM2BEMG
	 t8FKMyJOhEoM9TZFhQHm3q1omnIxeR1GrAqG0pA6EAunSNtXsLoN/7nVDdcvw5CZHEiV6
	 5h7ZwnZJ9wrqfF9EF9CYg5XutJq7ol9pbjlsW7K7MrPKoP0yn96kmVWP0UfOSU7YmO+5h
	 Zq98E457LZl8XSo2d6TGacu/JxePvavPQ1jlgDFIh4UOQ2UOO7KBnNIprF8GRSWn6mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646367;
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
	bh=jZGZD2n8fJCTrN0Urrlp1peiiLSr4aUPv4WxduGq4gc=;
	b=o3WFo00VdGbGm0DAR3sK/jhNzWV9tJYWQuXqdY8Q1OKwiB6Z4Dns3NR0z9Lv4rODlM/T
	 S5Gr/ZMbSsavNgwBbpRr4Mx1p4TNYLC+fJdeXQ5N0oWEqBPW9RhcUm1zF/3i2FoyN5lcL
	 1AZNcXXlUpblRdwcNvFxj5siyd5dddjRvZRzXSnL+xthdu1JGJE6yOcTbhtKa8xHNW1FQ
	 0SVD1SLxEK/5Zl2IOkMDbVnzohKHMxwpLuI0Tfc8DBkJqZ0hyGcu+Pt4MaDOqQbF23SXq
	 piBE/5qcvg0eico97ZP7NNw7sfveyKvHyzHco/GLgCHZ7BcoG+fr+6Wz3hppg+aXxMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mNydlvYz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.57
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD91606A323;
	Wed, 25 Nov 2026 22:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD91606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mNydlvYz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yy81NY3BYqCEfhM0lVvO8p4JeDa9nRPzJnlaGWS3/Jgbbi3TOzOOmBiPs/DYTEMYIVenx287Q1w+xJu5AoH4EJ3icCS7Y43N689qfHsnKlnlgm8S/2IYpa9+PLFEF1VQPCYbvvGnlXaDgqnLHPxgwWi4Rhl5syiV5AXDiGju1XnWdOwV48WBTkZqFVzcjGx/Wuu1WT6ovOC0d0EohVOreASsCcXE7yTrdZkCa4Btl4xb7o/pyvxBvmkWR7LskVVPF6vqqBNpQlccyJJ52JRxrWW0IXph3OVTQod0aCQaBwi28D5D5F2YAJA3kZlPvrDhEFZqSMR2PD17cqyzhoz6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZGZD2n8fJCTrN0Urrlp1peiiLSr4aUPv4WxduGq4gc=;
 b=wCDFYda8ua+yaDonh0rFxqkAT31ckFNzuLLkrVHa5dg1BWo3D8e7w0SUr2hXwM0dKvzSZf/0sAC8WYn3Ze6DYpKG281MSQdq1P8VhI59UTYv7Ssvy2YNr9veHZZMRsX+J4j65oh6ETTy08XDEpQ4G72VOM6lJUXebNZ3l/7jhGo2Coe1Lnwl3ojGP323mBhdsv3CiCRxIADxlJcdPp7UeVjOCysvSNI+/PK+FvIEcD600n785g+hQry8hDkXQUStHG6NpT4ppSBl62V6S3rFmoaFOb8bjsvWOJpYJGDBDk9JKF/pXN9IEi1GCFio8jBaMxO7O+pkuf0wF6HLSey8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZGZD2n8fJCTrN0Urrlp1peiiLSr4aUPv4WxduGq4gc=;
 b=mNydlvYzJYHNCVZ7HACwjjRhgPx7BdAUgwadHjB+lKVlqKOF0QgyW25CUJ0yHAn5aQ9wBRjC2h1xWT5iIXuIFU5Tx4520lVsjAu0/5fajUShRZZi0Jf6StM9ygrPqQJw+pLmVZmPTbGQeP+FCTYhIKGRU1XWssjStFt9CcB2bIthAQON7hmNhvk3Bh5QgXfTkgAVXIeYD0MCI7ZrCRRPeou4L4Z+X2IW5B/blES4uiqFew20D0UkLiyLZsagiqlLbqVzzDX8YvQbz/c+JaTZqSz4tZm+qWfHOxQKo14Qfj37zjjkFGzWC1yvHatT639x9fmJo/ADF4c+NJ6+Gx3VaQ==
Received: from PH8PR20CA0021.namprd20.prod.outlook.com (2603:10b6:510:23c::26)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 22:39:19 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::85) by PH8PR20CA0021.outlook.office365.com
 (2603:10b6:510:23c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 22:39:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 22:39:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 14:38:57 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 14:38:57 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 14:38:55 -0800
Date: Wed, 25 Nov 2026 14:38:53 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Johan Hovold
	<johan@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Mark Rutland
	<mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Sonang Patel <sonangp@nvidia.com>, "Ankit
 Agrawal" <ankita@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 4/7] iommu: Let a driver mark an IOMMU as confidential
Message-ID: <awdjfURhj5tMHE/a@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <0f84aed0f943d1a66836ee9c21fdd5f1669f5c46.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.12731230432671430516.b4-review@b4>
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
In-Reply-To: <179563006502.253973.12731230432671430516.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 75691c49-2f4c-4e19-e4e9-08df4b44f153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|22082099003|18002099003|4143699003|56012099006|11063799006|261021135927099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Yyw7Yy6gJb3PJrCAcxy9+DzQ2F9sYHrqnmhiC8oU/mu59eH6Y43wi3Je8QAgC3ZaQgN+sGGDfhWzWamp9D3yfQ2RyZ983apE89meZ02rKtVdWzBgqj76SlokViXmPlrvst7YYDjZyFeaFbt9lavJuwQq4emt+dB27unRyAx9009RpLPPTHmQ2YEgatYrxOBQtAevrJprFoEM7CGr5yRiXde1IejdbO2+jb+crwYqZqsq8kOSjKECJtomuvLxvrzjsF8HmVJwtf8oyWJv0MOJWt/tmhNbDEuPOw0/f9mlDi1zcYCGrXVXpOyXKqhuiwTtcfptnbKQcydM8k7uJnfCmUo6a/cqsB4SmqMN4p8UFnpJ+b0xuNy1+RREj/Gg83q7zzaXo1v3BXwSacalIChChOjQQU4L6ClLJjYDGebt+bAz23T2UJpxNRJomPYpAHi4hbtgTx+EENPMB+7f3u60aED7o55631qJ4YopLpfxGwdo/UGFvXcpTtAPsqCijOk0fVNC9yTgMFrGlTjPOLTous+gTXhbFUlhR/YOyxLpSdYfOh3SYXm6yv9PV1FiOOm5dD5S80tq7HkjLRfsycPGvDjA2dZte+A/RDbUEinTzgnrydLCnrzyRrp3S5NMzZ3ZI1K2QSIs0+wp7VXG7Z3cUK/ZmP8HxNaARlZziWVLigySGAP6UB6r3sTmdVUDTok6Sz8R/2MhLJC66HU+1Zqvvg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(261021135927099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	036BoIYxS4+zlh3PIk+Jd2po9owdUQbps5zqV9HyNQwB1krpOHfqBeG32Ee38A1CRXTEWkjJRq/AvKlRHtNzf/7EYZpfni6cmH7SNZubbZ92vvZRx5gqx7l848MqjVW1oKaFoiZjqN5g8pH3q7PIg9m6S4WpfrkvaBJ5oq4/o255zw9GPrzY/dpGwUnt+8KEL4zJTTXUrxN91ZvuDPdiaUSEiYhAgOLxgrPxIkDlhre4Ka3fZ9qoikqTYu2BiFth2r41/SDGbw/MpcbvuQBEwnRpaVwYvEzYYVVccV6KzEwO1Iiey5m8p+azA6vNWWAZEpKRXYqqDblJaI956cnHJ7d6bdfpcrrqcrj/LiwNCr+Ed2oer4Nno2hSbpq9MO12H3aQZ2zU2oko/YdaIIeeWOuTOPjLGGxRUs44s2OyPoNdBERRspVXS07CAtGbpv6Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 22:39:18.7253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75691c49-2f4c-4e19-e4e9-08df4b44f153
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460

On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > +void iommu_device_set_confidential(struct iommu_device *iommu,
> > +				   struct device *hwdev)
> > +{
> 
> I might suggest "cc_private" here to keep with the naming theme.

Ack.

> >  struct iommu_device {
> >  	struct list_head list;
> > @@ -833,6 +835,7 @@ struct iommu_device {
> >  	struct iommu_group *singleton_group;
> >  	u32 max_pasids;
> >  	bool ready;
> > +	bool confidential;
> >  };
> 
> And Linus isn't a fan of lists of bools..

I can add " : 1" to both lines, if it helps.

Thanks
Nicolin
