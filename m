Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674559;
	b=v+STUL1d08JHIL4lE2vxuuOvz+Ck6zSXPjXKV0KEPzdy577nwCmnLwJ5dCbg1isufo+6
	 HNJgDPCKoBOyIwjjLIcfZORfjsxHmCWHMNp6+AU9LqWsbkHc+7P3uDhbmm2QJUFJXBBYA
	 ft9PPy54IPd4wuQEai42HswKlSpmMAl21biaLYXjC9xDY2/LvMm/XWoSv4ty0VBL/cOaR
	 mCEjK9FrbV39cp52rwy1oNHoS4ofBYBIWebocpto/37dZCMwY0bQuzboY6c7Y0kssFlCS
	 4ETuv4YCexqnvj1vghbd/G6cGAASRXM+P5N9tp6j7XUjp6+WizrMsYTXnDfU2o72R9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674559;
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
	bh=F4ZjwhF4C2DQYgzFR2tKGDpIMldOOSF7cjJlrKan/Cc=;
	b=Yi0hl8r7VOmb6aovOofoFMQVoVrTPwAaTdFi2clNe50K5dnOYU8FLKVV1ZlDxTFbLAgQ
	 JNSmBqej7pkhTGzGTasl8xjkkideVC0eNiWVZfddqQKGceuaevV5nUpRWcmahdVRIOhPw
	 TkfeajU3IEw3236Sy4kV1dZlhVv0RwSIeXWbVfiaYBEd2w1lS/FnhiCDH2Ll7cryJ5Q+Y
	 ncbnbXm0uukECCfV9fSoo0eKgihOIrE0MR+x0lYkE4V8G87xVo/Q0kskWKhNo+BSHto1m
	 WmP53UMx/jZLFB7OAu7K8Q/0eKXlmX1p6rlHB0HVF2CaagurHFa+XSNe839VXsC65/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VtqKxHFp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.70
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65378606A31E;
	Thu, 26 Nov 2026 06:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65378606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VtqKxHFp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPXwIjmznN+ozcRY6s1bRnp6wjyLXAdL0lgBWXHuzXSOhDtQrogIvcqenV7VPphuQ/oQvJkJaaJ2JhON+D2M3ena6eylADuHR9Lf5T7wMJUxP+pJGG9Bi/jDBmOdfuAtHkwJ4ZKTEUP2XliyEgQOT9M3g3cGBNIZ/CNyYRZjUp7lx4YDzeyt7ybBfy5av0E/y+d/AD2M2+afZj3wNj0sCwHw9O3ljYsI8WPc7dsMwHAIKbROinfE0tH22stCBbRxx42CbzFHeaGXFh0em9Aog3DzGaDZbuy51xMKtiBHB+OcUIS6WLZ9MwGWBcu0MTUqysoWnEpmkZcbMY/zm8n2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4ZjwhF4C2DQYgzFR2tKGDpIMldOOSF7cjJlrKan/Cc=;
 b=VRnQPIYTRxl0NaQzGk+AcYs9LOleO4Q+ru+qTEqGN5buXTrc3C0u44IxgjFsK71FvHz+Rs2/D/pwQkcdByWGTw9h1+Sx1rDt/kiPZk9XCM0LHzeu6/XgEz12VPeEr2Qi+cwZop6lWbTiuI7mXl0dng/FmhhaKNgj3Dz7esBNs4O+Cwj3VSqHhGXU3V/6ABLpVTM2J67jQ9Bgb8UKpeikkngDeCaETQf/YZQ4yG0D+5yhayzBNcZFGy4huWxhwfhi2nzNKywWPm3gdLVFu5d5FLRs5T2zq/ms+1yB7cj1/paIHnpypomOVlnEBxc9t+iRm4DkvFDxB9TZWKywQLoI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4ZjwhF4C2DQYgzFR2tKGDpIMldOOSF7cjJlrKan/Cc=;
 b=VtqKxHFpMOFsELcSX0Mw7YxPQvOF3OqWgIFqajt5LhcoxdM71oOtBA7uclTEY2Fe9M3KiWbKTFz4korMzeMxNYCdT+WfAjk5hcYbmLc2Fand1yTKuIW46oRH6/mbuyZyvKtwA/QxI6Ij2UAgsgZXofBCc1gcY3tK90Q6I+qHt60+at0tVCboJ0Zji0heH6NbyM3LY0lig0m2ypPK+68RbauBbMV4W4OSibmvNIijPAyb9o4nVR0Q1SrOviImjQHX55gkts7ys9QikDzeaQ3MWDvv9FFDUIK8wF6ycp25VZ1nIJ+hSLxEvuYpVJ0L2urNHxG3bc+tOF6BetkQCGrZIA==
Received: from CH0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:610:74::24)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 06:29:13 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::21) by CH0PR04CA0079.outlook.office365.com
 (2603:10b6:610:74::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 06:29:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 06:29:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 22:28:49 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 22:28:48 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 22:28:47 -0800
Date: Wed, 25 Nov 2026 22:28:45 -0800
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
Subject: Re: [PATCH v3 5/7] iommu: Introduce TDISP T=0 state for confidential
 IOMMUs
Message-ID: <awfRnebqhJZxkzzh@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <07ea92910895a2b0db33afefaa3a0ef182b2968c.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.9155049351516451537.b4-review@b4>
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
In-Reply-To: <179563006502.253973.9155049351516451537.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 8058c252-8e4b-47ac-3e5c-08df4b869608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|22082099003|6133799003|18002099003|4143699003|261009223027099003|11063799006|56012099006|261021135927099003|10067099003|261102123227099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	5V1nYUsOQK/dilkfLyISzOGkSnZxvlZuMZGsakS0F7DoLJoZ7Cwo9IdIm5t1BxS2m/DBIU8Mez2igSlWB5EWCNSm9lVq31y+kHz0u/UfQlmQIlLD2+CqfbtlTT4jv8/vgRB7FbFT7NPTZQsJ3s5hcCPER6iTr1Ntsuyu6rgwqk279C2ljhe28ILtppf1OS14taFYvZcBp1lK+cakIWv+dXbhsaZC8k+xEhYsu6P99ZOLj4fUrIqtwStyPN1Xb/OxzXmD9ZQezCGjeBQVOlFk/NVLgnqL9z9v3GAuixyXIjyl3EMBG+xkaMRCZF/kwKMrUawFXq03bWi/mHBLo1zYnM1TyLRrrgt5hVhVVqgsmC3LGUUu1D5fYhRiG0pCraU3wVpqMhlw35spcj5LFRLCJvkoCwZ8eCT92TWYkWVF2cZuubrQ7S7EvQJRc4QK9UkDV0ewB3TMiEK8WqaHtKC9m77YajyZ8QimYO26+OsfXJRj68j7KHlOLAopZl8bHOymL8DOSbV+HmuSblPUkCz/FyewlDySL1W+ZEARAvwMntjN/aNsoywxFCvGPp0jlsovqsJyHBx95iu/bCke++PImDBcYJ7I2ER8COwCRW5KuYk0grQ5zyQIDYlhxsNwsOlyQayqWX2xHa4gWoMPhVEhk8oAWZpwwrVbShOSRGSIykwaQ0MLu+3jUtLGO6XbVPOQch+Y1orTuRD/jCQpMhxLMg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(22082099003)(6133799003)(18002099003)(4143699003)(261009223027099003)(11063799006)(56012099006)(261021135927099003)(10067099003)(261102123227099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1h7hUfzf2ZEjMyN/LbXG+00dO01Us59etP64QWnUNihD7pr5oB3YLJyP2dixjaU40OU5vFeJdI8cIpDO9ylL9HPer+jjqysTQ5wlEbWwn3DmttGiagvojdhF27iihYaaOtQAxczUd3Gnf6gAazq+l1cpOEF3wuxt7hlH2ki/YAm2NezOjds9pF72TZWt3EB0DTimEWZcQGGtpWGMpCfMNxdOLYLqVZ6LC+USOWHx6PkeInADYSvpNvZOR2OHt9rkiI5hRRllKG2oKNOzIXID/JGdQGvm0Bvq3cuNLkRSf/OiRSgLrzosGu7vLNHSrG1sm0SZUpISGZxuQumtPDu3rQqXzHhZUMT3VHSocU6AWIaEvQsBumORkbpqk2mUf4hnRx0+Ad/JFWPsIH8nr69Wie/etQxvzin43zCGYkC2NNixjgMyl1Sf2l0mQKujaBoH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:29:12.3237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8058c252-8e4b-47ac-3e5c-08df4b869608
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876

On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > [ ... 139 lines skipped ... ]
> > +static inline bool iommu_using_t0_stream(struct device *dev)
> > +{
> > +	return dev->iommu->iommu_dev->confidential &&
> > +	       !dev->iommu->tdisp_t1;
> > +}
> 
> The logic looks OK, but this naming is weird.
> 
> All PCIe devices use the T=0 stream by default, so this function
> by its name should return true for normal PCI functions
> 
> I think this function is trying to say 'iommu is bypassed', that might
> be a much clearer set of naming to lean into rather than focusing on
> CC.
> 
> 'iommu is bypassed' means you can enable ATS without having to involve
> the IOMMU driver because the hypervisor will activate it in the real
> HW.
> 
> So the names would be more like:
>   iommu_viommu_bypassed()
>   iommu_bypassed_enable_identity()
>   iommu_bypassed_disable_identity()
> 
> With kdocs focusing on the main property 'a viommu that is bypassed
> means the hypervisor sets identity translation while bypassed and PCIE
> ATS controls ATS behavior'

Oh, whether we drop this patch or not, I realize that we would
still need a helper.

"viommu" reads a bit too wide than CC. Since "confidential" is
renamed to "cc_private", maybe "iommu_cc_viommu_bypassed"?

Thanks
Nicolin
