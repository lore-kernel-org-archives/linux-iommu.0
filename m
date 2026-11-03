Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793727482;
	b=MizKh5oQz+iLcdhRDwAd+BaoDH/Hrs49KvmhhNGnnoZQc/PTddEcpYRQAkU7Da0vQSMs
	 67V1UI7m6LC5MFnTT2bP2knfJkEvdopqSOSua32eRzK/jHXEhtU4sgE6PjnW30w0nlCM5
	 lV5bASWZ/d4NnhlqP3+rnjWlCPcs0hAbWjPL+v29DYMRbcxgOaiCzyc+IDayjamJg1PEh
	 u4d29WizxboXb1YPi4rKNfrB5Bnoh2Pgajonlcr7BbsU5jnQ2LPakHqKUWqrFrwrVTFV6
	 4MQ42wAr09h1BqVHRi8C0ZoXB4uZSlWWbgCN7jhiKnEATDD64DUvR6V+eULy6BQClvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727482;
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
	bh=i43QKafOz1PWWQERC8n1Cv+ufMVMze6Rma/7HGXWp+Q=;
	b=t2Ks4kjVUdzHWsI9gWiqmuGuvMxS5ViSWYJ8ra+iCYOULuI1bu1jzQAqIn503lj8n4Jn
	 /g2ZYPAxmFwfDAnPNx3pMrrUteAb9IkmDvsFBYXCTMxUPhwyWHliGYvXT+oPygzEj60hF
	 onypbrBgRnz84qMYHvcE9rif0fww+os+ZwmLhlY7PbO+ZAZsznIQHth4r97Iopn6ow0BT
	 SuJYzibJzhUvGqj6GQhcbMMjNyEF00SFXdGGU9MVE48OuU2w80N+xq3oKgxKhudV9r6JA
	 lYZ3jKQNIm6p8VSBi1yysn9BRjUZlbsO2zxmeyP2POvCt9ms0KnfD5BLZ7nK5TWWK1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eby5NgVd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.15
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A372606A32C
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 17:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A372606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eby5NgVd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHgXgi1YvHstlv+6WrV+DSI/ADnxC6MkZpWFZWlf65YP9Qd1OZISaoKFJ1Ahl5sx5HQPTZNV70D8+uiRyqHs21fdr18ImtRkb68rlkOmkluyOYSTjI3YfRTMEE1BWzMHV1mAZ9gW1DxCDxKKLPgLQnR0mZhE35knwLsk5RvP3SIDsedV5685jb0SNfzD18Y+QrWEQkO926BR/G6ddNkK/J/t5ZnNdOPIfL5Ps02vDYFhs2RgsgJyJ9vwBP6tGiWzTcBxo5zk5HzmABIkKwrbr1ZQznDx6bIjizmUiWoEHTiUfv00bpk+sLuTmNQFEut5+XHmmhGM3ZZ5l/12eEdwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i43QKafOz1PWWQERC8n1Cv+ufMVMze6Rma/7HGXWp+Q=;
 b=XSYFqnz5I7TNfiblXsYMT78RNgF4mX93rIOYsKc1xOihTIgdpuGmUfLLBxOlFftg6q3ZTBpZIOrpaBkA0lzug0SaoKB/UW994272UN/dnAfBe5jINEj4fJMUpLrVabHrBQ/9MCO+P7IXD9W0Z67Vj5vgmhObMMLd0NelrJfNcl461OQWenBWyNz1KyN5+Q3Dtci0Wi7jN6hW8cqHyQSHgeIvlnzJhF3rMGmM1CHLMCUL3DLUzOgk9uPc3hyNLT9QXgmBXQJLaMlnnUIq/Y2QbsCLwyTY6z2Iwxk7SyakfQ7MxtY9E/tzQ3SlTrdrsjxnX5XbACRQZnOjbkoBw6zaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i43QKafOz1PWWQERC8n1Cv+ufMVMze6Rma/7HGXWp+Q=;
 b=eby5NgVdS8KZ9tHsty1JZaCm8Bi8XAfbbx5tNab+wQzxT9+Ijt3gNL1yzi4biblN9VtUku+nP1dA2TuDnMQsv2PMCPEwSC+4qSXWdaWQ/mvFzMK8GrbZXBpQxNkMBkZZu5g9LMG/xNc/zk85ZYYe8bVZ0ozmHQHIs4KJkUKXF8AtqQWoyEq530IgrBXeXiAbBYa62CzlNzJDs4scBHuHy/DWqfLfrJqWYQRBzYuYLxz6Lw8PQeF0wrs5GUfGea9D0cWt7s/i5853BSyHto9mOaMOyvXDeSZMDhSB34N128NEd15BorojR3Yuzk43gFEtIe/ELiVyBZLZBtCdyo1YDQ==
Received: from CH0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:610:b3::13)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 17:37:48 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::3) by CH0PR03CA0038.outlook.office365.com
 (2603:10b6:610:b3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 17:37:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 17:37:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 09:37:26 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 09:37:25 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 09:37:22 -0800
Date: Tue, 3 Nov 2026 09:37:20 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jpb@kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] iommu: Reject a same-domain replace in the attach
 handle APIs
Message-ID: <auob0IV+h0aiW8u2@nvidia.com>
References: <cover.1793602084.git.nicolinc@nvidia.com>
 <b7dd43ba78b7342a2e0356870502746a8b7f34aa.1793602084.git.nicolinc@nvidia.com>
 <68570abd-f619-4d9d-a7af-d2acf1f9aad3@intel.com>
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
In-Reply-To: <68570abd-f619-4d9d-a7af-d2acf1f9aad3@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ff8705-180a-4ad4-eee1-08df39d12d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261021135927099003|261022105027099003|261026121527099003|261028144727099003|261102130727099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	zrjI5gFC6c9/rctCHHh0HiB6TxGN7SWYSF0eiQul0NVRYV7mp3Q+faqljdjusg8HM9px/ne8u6srOjt749baUj9deTPMxLxwqT6XaLwaCdtOed/5/Tfe0GxegHAbW+mPGNZ8+vKPpfgo2CuD7aH4OypqqEBCFOiME0OXF8EREQ8+ec6VyEu2y6KrBGRIPLZ5yxZWLOYxGFFqOG/Tjsc9RhKqOgQALrONZa64OCUcl48ORrtcbzWZGnF6FN+wa6ZJUYNacfTVFudInwAV+Q8FtWZR0w3c08HvmlKBxQka7HOtB/XkRQs5lzBU1HFe/r1y2x4uQZABVMy8zdnuqLbrF0W5s1MmxjfHmjeFZAbwP37F2ZOIHBn8lb5UoS/KsmG43I+OdtR116dx8QmGpzKPqcFaGfdhtUhZ8TDCHJjnzDjMON/eaAy5zpfHvil0v5d24oHfvPl5/kuF4nczi2QZ0/QT+U6fs5sSpgPkl5ruDgD/d3InpeqLACATbGjIZKQ+3/GoKbDi8hGO8SRsyRzBRzlhczyQlXasj8ETOqUxf1EnHLnV2U4Omm764P024/xHOHneiN1HnPqJj2FCbyDPW158etKhFWFBu4DsRV6ulOVF2kSNnzOf2gTONTVnL0iBKJO63rGLHZflw1convdGsQv2pAKfOPfkiBNsvn84jQQF6EWEmfH100fI3mnh4sDMuwAr/vb9d/JbvG+9O7i91w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261021135927099003)(261022105027099003)(261026121527099003)(261028144727099003)(261102130727099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HpL2DZkPEcMp5lJcVkEu8U4o0iFRV7/tdTwfVhEYvmz1TSGdpMGMPwVPmBwnoPrbYZzH2ZlI4qfJl28qnTpnx9OiThko+/USOWFk/kyCyih+C4xRc6Mu+qGgr01NRQ/ijoSDvB+5F9WoYDvgUxaZnZiAYtxbXlOQQqIgTfIBlM9DGdb2scaKNFF3aqD6xzJMVDpuv/VgmRsA4JilMmcQ/fxImh55VKyy27aC/W9hkjcqci5NKwmLvMaPaf2l3wxtx76EbhXEXqC6CI6BgpXy7aJrHDqv8QUlF6wKhPMt1LHeC4CZDTTGky312js5zCocdqfSYJ9SWAy0Ffeasz9+qusWZoLhLrZbtqSlj39wjBzC7a2dW12bRfO6tF8XOr9XIbJntl0UgWdNDlvd9Mf8xCdPsohdogk89eU3304yrhzFJ5ZWndF8+u3c15Wq4c5I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 17:37:47.7526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ff8705-180a-4ad4-eee1-08df39d12d2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856

On Tue, Nov 03, 2026 at 07:59:52PM +0800, Yi Liu wrote:
> On 11/2/26 15:04, Nicolin Chen wrote:
> > @@ -3716,6 +3716,10 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
> >    * Caller should always provide a new handle to avoid race with the paths
> >    * that have lockless reference to handle if it intends to pass a valid handle.
> >    *
> > + * The @domain must not be the domain currently attached to the @pasid. Such a
> > + * same-domain replace would skip the driver callback flushing pending faults.
> > + * Then, those faults could use the old handle after the caller frees it.
> > + *
> 
> 
> Not a native speaker, but this reads a bit ambiguous to me:
> 
> I parsed the last sentence as describing intended/acceptable behavior
> rather than the hazard being guarded against - "Then, ... could use"
> reads like a neutral continuation rather than a warning. Might be worth
> making the use-after-free explicit, e.g.:
> 
> A same-domain replace would skip the driver callback that flushes
> pending faults - this is a use-after-free hazard: a fault still holding
> the old handle could dereference it after the caller frees it.

OK. I will respin a v3.

Nicolin
