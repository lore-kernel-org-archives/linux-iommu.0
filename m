Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD273B776D
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221631; cv=fail; b=Y9Dkk1Ral3CS9U1nye1FrLLGzWlAasOcvVe0ZsKRdmToxgnZefW76wPQNfEBQqW89hUW+0PHtxBox1SEes72hWFpp86SHLOZI2Ay48ibpkZJBFMmrg+7hymB0teVRobqe4dPKqg10A6TcWVX1D+wP6aZQs0ve40URhk6j3BfROs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221631; c=relaxed/simple;
	bh=yZZd3JD8RI45BvdCEr8Zmqv1uNa1BzGd3/tJ2M5h8n4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZRrPuPIxKMJOMmXYf/QQxsI1tw1nJsnJDNsxRe/g4ByTNxDOCeU2IPru4sxC3AXDt2dGbuGWVebihgqhahE+OHPYpAT7CcBv69cxlrS1W9eaEbrhnHU6xEq7Is5jdfT2/LKr4EcfCod4W+Oz9Wg3sYFFreoS64ofPL6tsGLEJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BUWISPHV; arc=fail smtp.client-ip=40.107.200.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BUWISPHV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh6JSiSNzz1TnSsG46bLxUT/F7a/LGPL19uBf14y/xDSKQX2TDOqPOez5HF64kRLZ3m7rS/Hqtv6l1+kCOGPcz/RWUec7xvf8ywk3A0eCRctY/OF+vPeUVYSmsyFpDU2frkIdLwFASkJZCAbAvdxrizPYFCemy2zhxi2JFqU5UhZi4FYZUAf1gj61rB9zJ9JPlUnqCRR7Tje475oiFLQCZqYWyTT5uzcD/KVb14P/Bi4U03KZ5EU/cZeu3Scw4qCkK0SGF6aK4Kcit/bbIT+Kaw/Y8rDXK5KNkMb6onIhUmpsVYJU4WvQokJOolXzCLuS9O9pgYXnmr+us7SDRwPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB3+7Yp2REzqVid/Y8/HT4X24WaW8B6QqXm8JN0NPXM=;
 b=nbn4ErsXMZvC2be+VMQhukEvBxuz/NOXwYFUullC9RJJT+YgW95cuOcD8LIPaqjVcMpuqE5IW95UgaR+6ucT1QHRVMLqkmOMUw515o9ncW53GDkVHKQGATDqvxNGpnJZkG+k9390RXxdcFjIlcQoXq9z9Dj7CtD/z7K4g7DOw/LxWihtq+cD7Xf8/gpsN6oPqWK1RM60H2GRfY79iOnyxj+FX2p0wetiJcJ9PkgfxK22zVy3uE/hAiSv9MZ+fosPaSiHamBSmVCPNx3jIKS1w0X6+nRGIOeid70w3D71w8NWVaaoPMsNxnp3uur296npavCzQYGkQNDO3JZVoxlV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB3+7Yp2REzqVid/Y8/HT4X24WaW8B6QqXm8JN0NPXM=;
 b=BUWISPHVkUVgYkY8jwW8e5mUVOy8dTKJ2QxbY/GL0NH/GbTURdS3Zp4De3J5i00OhVZ0kjntNwt4IMEVPaJN12qlIm5FtHLGxrsBGMhGVCdCvT+C6e1cjhBJLqkM8bmZ96REqqtKfn5U4pB3pyA23QlGVOYCOQs9JiNiKCvTDDXRmNm+QTE1DF36JAlUAo8SWL6kn7B5SYklv22PyvgkN73TcLfiertsd3QQCkqTq/E3FTaqZ5P0i2AQiP+vRJE9QLfByHiSms7vANuI+IxaOKXgc4Q5vpRG1VCsp2tHEG3m+wgCsGu8iur498+7pKqDUAtuX6Hcujsea7Zq55VGiw==
Received: from CH0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:610:b3::31)
 by IA0PPF12042BF6F.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 19 May
 2026 20:13:39 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::44) by CH0PR03CA0056.outlook.office365.com
 (2603:10b6:610:b3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.25 via Frontend Transport; Tue, 19
 May 2026 20:13:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 20:13:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 13:13:12 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 13:13:12 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 19 May 2026 13:13:10 -0700
Date: Tue, 19 May 2026 13:13:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH v5 3/6] iommu/arm-smmu-v3: Suppress EVTQ/PRIQ events in
 kdump kernel
Message-ID: <agzEVS5SFKHPb6/u@Asurada-Nvidia>
References: <cover.1778416609.git.nicolinc@nvidia.com>
 <6e5828f3288aed6f9e9f4e0ca54e7fbd9f439274.1778416609.git.nicolinc@nvidia.com>
 <20260519174453.GF3602937@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519174453.GF3602937@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|IA0PPF12042BF6F:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2a8a63-bba6-4a76-20e6-08deb5e31e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|11063799006|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ahuy7FS79HYwot0kA5noQefUDA7PsxW1LtKZURRXIoTvJS6i4PB4qKqigF6oXQERvcCmDqgqeo3wng4pJugWQdpTyXL4D/sOUSWpQLnKB7f8XKE6ZWVMUUGzDziC2/oy00ArOjki0Z5qO0BK2rBFA9QOgnc6pc4eNOhkBbL0GukkQjash1a2ZEr7e9Yxm9y5y3PmsnVqhCSZtr52RA7lV21IZ2jd0edLpEZF6jAFWaVD6P/BxRXgVq2NQmxWw/1e64jvbfNSsE46evrtnjhPsFkygpVFwT0HVM1sTkfdD4SaDLrk28aZV/WxwBAGeRazshL2mqVb76hQ55h1r6qhANlQmFMl9opXvVt6xnC2CqtVdWTMbUKBuOCZG2WoIpo+YmF+cpLeDVvsWqxAD6Ih20/5mqQZaUqoDcoyVxqA2xTGiK4Im6k8IwynX6VHSVzpB1A+KenyYTPscI2WF1wkHmNub8vOe60IPfnXyUoLRtS9pR/nOc7JNClnQLWa0L6CZXKNypOFNSex6kE0sq2InQ+B7npY8ROBftp0jG/5dr6bUQx4lFxLs5eOTOQMdwYIMqFbSDB2USQeod9WCmWIOJ4PtJcncrW9JN5u6n5RPGRqry2Y82Vpi2KrR5aDBjuSLOhIrftcwhRyDdvrXvGWH6T4wazSLZTia8oU9inMyObsGXA1+aTrnvz86XcJv2TBBe0UACe9W5NWvwMI8NiVqJ8u3o8EyJl5e6hOQBCCgvw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(11063799006)(22082099003)(56012099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dDe1/e9b1O0bmudet1P1Bs1Exjw1hcckS+WebgUeqfzS1rl5lJ4fWzhAZDqt9jdpeyBTvTnSKutC30basAjH63q/B2XNyOmTrTDxYig9iZc1V+zq8wwuD84r1dmzK57dtNw3jVA7IdLwFAHbwbZWjhFiwO3hdtBjFOc7tZAdDavINn5+uTgFwxare5YGAGVsXG7gQrCtYIt8NmHv1jA8c1hLSocdzboWyLjl5raz/cxjagCdBFOnmGFS4DmWVoZbrz6lHE36/1gCrsDaakjO8ln9rym9m27XJgtJYehSQJomHEQ/tSJnlrnVId0XeRquXD2EXqinsq27U45ThEglM69GzJ0GMFdXnhWVHUOa5RTxndt8CrZWcu++fgPpqhkolswFdRJMvrWz7+mWVbyjtdHfVFyf6GtyookPwVphQZZhPSqiQOGVPCQaxQeHduYv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 20:13:39.7411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2a8a63-bba6-4a76-20e6-08deb5e31e06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F

On Tue, May 19, 2026 at 02:44:53PM -0300, Jason Gunthorpe wrote:
> On Sun, May 10, 2026 at 02:23:02PM -0700, Nicolin Chen wrote:
> > @@ -2364,6 +2364,14 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> >  	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> >  				      DEFAULT_RATELIMIT_BURST);
> >  
> > +	/*
> > +	 * A combined IRQ might call into this function with the queue disabled.
> > +	 * E.g. kdump, where stale HW PROD vs SW CONS would drive a bogus drain
> > +	 * and a CONS write to a disabled queue.
> > +	 */
> > +	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_EVTQEN))
> > +		return IRQ_NONE;
> 
> I don't think we should be doing register reads on these paths. 
> 
> Why not load a different irq function instead?

Yea. Perhaps we could even entirely skip their IRQ requests. Only
gerror should be kept in kdump case.

Thanks
Nicolin
