Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793213935;
	b=nvvmpLPUYUG6H2xfO33eMu4d8+bpVql/p7d6SydLFZCElarXHqennJA7INt0dwUe5/bM
	 2AQuDx6T+usT8xId6vZoULMy5Wa80d4CYqUH6fEz0hfMDXWmqOsiDzI5mEAuAL1GeUpHt
	 pzP0BbsfQcSptbOF7wEXzQQ7zY8UI877evoqmbDQN2EpVep053GyG9WatJvcYd4Pzefc9
	 AXLcbiemx4kj7vztnfJ0wJhog5T/SheZO+nFiX/3g0As3y7n396bOwbtlKlGbxqH1EnsS
	 h3ME0PWztc8mqOX4qfoFQ0aq2W8cYflwwo5Rcb7KTNJojtjvUtmucznk54DfqTm0oGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213935;
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
	bh=o8aEBxqc8Fy30RxHL+UX/VR0S43L6JIsbA24LY4P1vo=;
	b=3mYyUcn7uCLO3cIu6NlN1zyymJAMHU9iPfncdUZZBmsaAD7WbHmDA3tY+8JWpqzX2koF
	 QY1DjvfyY5ni1hgVru+dUkXw57GIfhaKZ7xiM7AY+YBKe82jg7+6TNUKrsk2NkoC1P/tq
	 6ezjKpYCWY2L9FQpnprlqXEIEIrg5yz7itHWYCZjif4rTf3Y/H7qL0meaffz3TAMs6qal
	 4pytOOx6diTOZTRe6eE0jlOXJB+Kos8y9p3iJUkl3TTTLucBweSCO3Ykfg5AWvqgHLiMc
	 4IP5/0vfBMjuuJOArq/wLG053rJdiC4W6Rp5nP82aSXln2S7VM8n6kWNzrQomT+Swtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d3MAQNyk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.16
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBE606A320
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 18:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BDBE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d3MAQNyk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvbDjX3tBBQcpJ5uI8w2uXm2MhfIWMLeAo/xk54e6HFxyKgDOIEErq1zdgbJmWfUf0CZJ0Jx9RKRMzCYj38tAXpwyJUDke6U5yhlJNOLNigGkM0zgvrMGO7+s8SzKO0eY66XX9uaQQmgty7l9fdugOgf5FOvvX+X8WRwLqPBOoKfiFiORE9YGaCmshWElPOtH1rRZZ/iw+5Jff/uI36qfQ3rxqyTMM2kcpuM5sB9daRxhKPCZOIvXCjeauqZKqmj70RWGQGnfT2g9xCv9YGMAMYcp+3Rd5ZrIf9DIEu4vnQ+4GiPtuQh9QWL/nTG3MPMZA/9mpQYpB4woBNA8+PGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8aEBxqc8Fy30RxHL+UX/VR0S43L6JIsbA24LY4P1vo=;
 b=INesIpiRdxEwSHzoKJ/mc2DhQgwmof/nfLbeWF6bOtpYk2H5IpuGV0iIi5CXYazZ899fbVtT/qzhFOy3yDI9Gj+cdsuk/nSqv33ZE3T2wuYD2xljvV8kwZoigUDXV0FROJiX/ok9kJTnkb2j8qv/DuAdjnmy5LyuMrEQ5Gx8F1KWUN0tubF0WZOKQbLdCGBErEssOT7z2FyRPN3QnwPmC2e8/97Ucm48kjpqxb8vgMfaNAcOvrDsO++t2mLxLcQWkgFJnv38CjcBa35CWF4NVpAAmj0msMIGwqko+ZGwdTbSkIH1Ufw3bKBFta+k5EFfiyh+JDza2nG+lAY1JTuU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8aEBxqc8Fy30RxHL+UX/VR0S43L6JIsbA24LY4P1vo=;
 b=d3MAQNykPlcpRlEcJw7dLHh36zo+/WReVbopIl9TBESgp7MXuAwEylSLj83vIKQeOn7MkZY1XWisDWDHsSB2TC1Ch3HxENg9P6X8K9BJdJD2g+L3xUSFTq2LG7jbL8fDKvb/J362gZJbmOuMixY1n6XLEQY6vbDxAbsYgiI+FqypBGlG0dYrcQUNW+lyxDdJ4zDHbdnZMGGi41Q2SqYL6G+ECs7I6IhZ4RqbEWu7Jq4i8Y8iDGf5XIdenRAohMbf2U+ZQeKuujMyL4oaa3vEMPUQ8Nv7k37p/dhvnhzw/lpRro5Ui3OvBtpmnCTqFluRCElbV0MPu2CN5bBxWvxRrQ==
Received: from BY5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:1e0::16)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 18:58:47 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::37) by BY5PR03CA0006.outlook.office365.com
 (2603:10b6:a03:1e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 28
 Oct 2026 18:58:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 18:58:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 11:58:25 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 11:58:25 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Wed, 28 Oct 2026 11:58:24 -0700
Date: Wed, 28 Oct 2026 11:58:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	"Yi Liu" <yi.l.liu@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
	<jpb@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] iommu: Fix attach handle publication ordering
Message-ID: <auJFzc8CRR+OcLtt@nvidia.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
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
In-Reply-To: <cover.1790718296.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e281233-939e-476b-b31d-08df35257eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261026121527099003|261022105027099003|56012099006|11063799006|261009223027099003|261021135927099003|10067099003|18002099003|22082099003|13003099007|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	1blSsE6UMBz6UoXTR1HZ198xFVMz4jNKh9nZKwhnBdVFadW0TBQhGq9Oinoru5WC2QCjHraAkNIlMVo/yeFuKBV45Mw1ttOOM2/5hqRwcjVFXjg6kz/cCOuYZ+IrIr4qKcQ6xBzLIJB2bP/mqi0RW/u7sFmxrTQ9iNbZMQMJX/RUbS3U0xZRGsarz5gExVb5Qkn/TOufU0u6tIzK7EgVkIJZSxQKXLHMl3uRdfjI0IUxY6EsZvoJQl7K+dqcsgcNpp8yum5T4wlxEZMfGOc75OCaORSrBcMK0DL/Eou/5rTxhfN+ovyZoOf5x5GmGxHGhGVSgGT502GebXUZ/u0d7iRcwkRqu/PUGNnTRvHWbPEfMGJXIER79B6mydGSce50vpomP/vbQDPhKdNW+jjsX87lurTkr7NPijw1QJ3ztMIj/3afPAX9tes+8NCi3bQQufmkdoDJYuYjxX+imLco+FU6p1pMtanFTfUCfZkMsVAUBh6nz17PvYYmLzJLFUk4SvgnkDs4pzAzVymap4lZUc3rkbo6K/JdBY9ln+tlkJQyDvpMKrwinwgdPCu4y2Va1q5f9fU2rHSmm4nGrg54+/YB4GicCnC7/BKpZO0q0X3dGMsqIRUTQ3xhV3M4F9p9TxESW6iLR1ZDfYF+PG0C7uOzGBa65R0BUyzMm8p78WzJPyViKAuMbsiEgYG6uataB+yBAZ6fkqr7QJxNmM3DAg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261026121527099003)(261022105027099003)(56012099006)(11063799006)(261009223027099003)(261021135927099003)(10067099003)(18002099003)(22082099003)(13003099007)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9WTn/d1zJLlNDsGChlNXnq4HCzOlCWS5AOowxHEzgui9RW6NGpSqY7XvQmDJ3DEnSgq33fwwQdwqQVmLZTVR4DTDL0kwza2SsiDcXMxh/Ro9ojnOy1e8A5AZoLCLOu4jHIf5S8SVav8HkI5NmrgLArnZ9gJNvK5dGApylNdwLA5lYqCq2qOqGuVqP2kH1bKkqEQVs1k4njL3PXYtT2pyhX/t9cUj5jCpO1C2ZohLQtyWwpTESNy4IVwtdwaEPaNc+qIOz6IVun6TnJZrgHnaaxrqE21KGs8e8rUn90gFQiMSwcGRe399txqh/UpAG769MRjLbE2KQBP2DykstyFzExok1DyDl+uZ3sh/pj37TACDqpnc+dBE2Z0uH2NE7U7z93gcbB3zACUEamoELfca2Hi39fL+3YSHvLy0uStGj9XcqBsWNLRk6r3QywB3Ax5p
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 18:58:46.5763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e281233-939e-476b-b31d-08df35257eba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902

On Tue, Sep 29, 2026 at 02:51:50PM -0700, Nicolin Chen wrote:
> Jason pointed out an issue in the attach handle replacing path:
> https://lore.kernel.org/linux-iommu/20260923233920.GJ2545495@nvidia.com/
> 
> When an attachment is detached or replaced, the IOMMU core can still leave
> the outgoing attach handle published while calling into the driver. A fault
> report looks up the handle without the group mutex, so it can find the old
> handle after the driver's fault flush and just before the caller frees it.
> 
> These four patches unpublish the outgoing handle before a driver callback
> for both group and PASID detach and replace operations. Both replace paths
> store XA_ZERO_ENTRY to reserve the slot and restore the old entry on error.
> 
> This blocks new lookups, but does not retire a fault that already obtained
> the old handle. The driver must still synchronize those readers before the
> handle is freed. A same-domain replacement skips the driver callback, so it
> still needs a separate lifetime mechanism or fence.
> 
> This is on GitHub:
> https://github.com/nicolinc/iommufd/commits/fix_iommu_attach_handle-v1
> 
> Nicolin Chen (4):
>   iommu: Unpublish the attach handle before the group detach callback
>   iommu: Unpublish the attach handle before the PASID detach callback
>   iommu: Unpublish the old attach handle before the group replace
>     callback
>   iommu: Unpublish the old attach handle before the PASID replace
>     callback

Baolu/Kevin/Yi,

Would it be possible for you to take a look at these fixes?

Thanks
Nicolin
