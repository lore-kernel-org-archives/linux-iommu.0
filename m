Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792515598;
	b=cp4nIVN0hcUUhxoNhRlc/2tou2AkWIHpb3G3vgciN+PbWyFQxzFhIXGLQUzBn2AaXYlV
	 I9lzHx+dT3S6eE4j/vDTo79asi2w3lDFIuJqJ1A8XGivCNZhAbKQrUn3qklESLj0245u+
	 kJ05WjDr4cE21qD8UhVbdWidp6SgLTwjsgwdzpJeRRsHkn/MqhNnPf4B6QKiAl9RJhclq
	 i2H6FjRllBa6UgH/yy6sw2i6LmiXu9IOPALmD2otuhtVLk69xy2MeWlku41mCwWwMK5Qy
	 E71f1CnguTkgQkbWTGuPupZdQoEtq4WNyPVnnFdBCJ7LbjaYI+viTj06yGgrZzleNBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515598;
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
	bh=iZYsJK9DZp6FZSpfbfNmBNvtUH4DYpATPXfy0vHCOP0=;
	b=WX48kT/HUuzJ++WyhZRXqdrKyDLZ/YKwnQoEDSSPidQPQN/MjtL6PXkf4TXtmFOT5NTv
	 UnltBXveJJz1Nm4EKxUnusMiaypfddyx+GRvfiman7sLcd7mEDVpe3bbV6NemlXSTa08r
	 KXuOVKkSWAH8GfiaBkqitTf1/NPSQaDMK6t1x2CwAwNgRDZ07MzvC6UT1WDHsJvAvV6Rn
	 BO/5/QxgOLhPS6fEhaEvF7OOlIKzGMs2QBtunYU9XhR/vKnmzWVMZ/aejETCSNMGR4SL+
	 6EVZIm6Iu8gpBokS3oH9vX9jKRuZN/UWAFw35kNEdPCTtG82FVD4QtNDKv1mWE63zNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Kv+QQ8DM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.37
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCE606A32E
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 16:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2CCE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Kv+QQ8DM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvZuD1dImgrMUMDlBJDi2cRi5NkDxsmViDT2hm0S3EDlg3OMulT2eyA3VLn+t0y/zC1l03xUVvPp4Tp9RnfMKfMMB1x5Uf0oEtbQuUwwnt1tAvuQyWiPWYx0MszTInHmPAGPamV6xaXkFOPuv+fQBIJnLlwaLvl/g15dfzAeBEC/5G2L4Vni/ff+oYKSyC7vxEZQPOVeXNI4pwxZzAHdlhKxbQzbXJW0mvfqTbGjhyWsGQblisP0n1/vCO11XDXKlBkI7dKErgEdus0cqZ7D2SpFVuc7NcXl7jgjZUSjK5k98IMM6PGy9OHyzVl8hrSVNs1uFoz1w2zDWVQt/kgvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZYsJK9DZp6FZSpfbfNmBNvtUH4DYpATPXfy0vHCOP0=;
 b=iXuC3jdLkw9YJGNNynhAi2oHXAU4nqg4ljRX/l4A5OMvUIw+DpvaI3WruFTIT/TG/WWjjfOztLGyJfAqkRYZ0WuwvdvKAXfPdt88Xr/G8+RKXqVJCGtMW79REJkfYgxWikqdPrADD8PKn+ratu/+XHRazbh4CI+t+XaHITmJs6pAYdkURZAaVf9mD3zbFOgH63YbsOMJv8KexjJf0iGUxB+B0U0hSc29UlxxjQJ4VPDxPE2yHl14PFn/P2HkGC6Bie6kf1/OUyPOfQjtf2Bvkxi3e6n7c7MehqTkXyTZzxgv+ZqdGRMx8TbPxFCGJgng4bO8RHojtmMqtcVKn/b0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZYsJK9DZp6FZSpfbfNmBNvtUH4DYpATPXfy0vHCOP0=;
 b=Kv+QQ8DMmw+1AA4s6/45thICu5kMKlYlZoC1XEQ67c/nuH/Y9Kb+Fqiyf9qZK9ubyT09sfHrtdThwaxHBvRp1+/Irx3V4w15bFc/8b3t5EJe/uEVIG+E2bod3P8Xasf0iaTp8WaTyxzZr50Sg89FFjZ1PFW/IRL/9gaVJn7gU2Ltjb6UQY7OYNgEB2j6dbJ2Jq8aQ5jlCc4Ofss8BrXHHbFIgDEJXnx8KztBuE3BieJ7VIMal0+ybh8pjqLG8I6a/2gApAmP0r4/UNJvSxooHGW5PJvi/4cWJn+1rz9Qct0gtJNFa7SeqrKbvLSIrv2mOPx7+rV1lps4CAdS4nK+gg==
Received: from CH0PR03CA0412.namprd03.prod.outlook.com (2603:10b6:610:11b::24)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 16:59:39 +0000
Received: from IA0PEPF00000039.namprd03.prod.outlook.com
 (2603:10b6:610:11b:cafe::88) by CH0PR03CA0412.outlook.office365.com
 (2603:10b6:610:11b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 16:59:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 IA0PEPF00000039.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 16:59:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 09:59:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:59:13 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 09:59:12 -0700
Date: Tue, 20 Oct 2026 09:59:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 05/11] iommu/arm-smmu-v3: Disable the EVTQ and the
 PRIQ in a kdump kernel
Message-ID: <ated3gfYqw3QC0+G@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <fdebf9f372ebabd7a44581a2068d6fcbff058783.1791226953.git.nicolinc@nvidia.com>
 <atdPBqd1-xLNZ1hs@google.com>
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
In-Reply-To: <atdPBqd1-xLNZ1hs@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000039:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f7e9aa-af69-4744-7067-08df2ecb8710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OeRR4KSRtlpvu9DstKF5L//G3nTduch9YMbh+Db6Ks4FJMu2Nf2ddPz2FZEnA308PrXQY4jHGRSihp9M2F/HeA+jfBCvdNcGj2Nh6qCjnEFe1qJYrrlrHU+yMdiwJnc1o6bAWcE+j9YB43PofGNwHvpCQctIrnmcFa2Eo+1Jg8rTSxmWUw8CZAwQ25MRP9SWd6D8hR+VZbd6FYZ+xoRPni8ghSGIGk/P2vq45mQYlfJm7VcKZwa+76dCq2A+ALXxDvRBCCfraTMbHtUwXkXJDDiGZ63WlNqJn1vR+S0kk1F5dxnYyDwRTRjzaA2/FwtWUVFCjltOlwK3myySbEHYMXeYIkQpUUDb9si8M+pNvzkTzMFrQ4nzCpNz7gfmsIzKFi0yWMKCfRTho1nNU37uwMFxzW5H3iWuc9ddPTh/JxtsZfjsOcs2yqtD/9wWYwY8PjgwDv4Ib2Y27VbOVNM/GFf+4BkOZzG6dTubIUXyy/Nram6/Mhnfrz7eyUcdtK8gSyt8UpeLgHC58VlxW2f1X73nh4Zn0p+JcXMwwK8TMBqkzU6rs3CWZNS63Ml0EAcd2UaNNYTIMw4qQwgUW103O7eO+d0AVfFrghIX32Z2Esdpr9KgHrnplWTeNWs/bKqfyJ/7RFWfZCMhjlXw9LyfZMCBkUTxZByDgnPcYS7nxHq7xgZTAJ0v4sHN6ILHawjV2fyvQpmJLxjBKR61dChU7A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Oek2teeSg3SXmRLKDoy/zeUufTnhzeFWU+nPzu/8s1XSiuk1PruEsflknj/1Vxn2uh0W1B8/L7mSqp5Jf9TF4t0xgFtgYkLXWxPRiYGN/sCIWHACWo3kkFHHstfJGIqDg/nf2gC82NIfQVpRZFzJt1rpiONl9Ron1m/Lk9MLz9IEWo6HPFo2aXgAN3sQ2tCo68dXwjxLaP5FP85pFl5X9X+glisCdm9iBCBqJ4vB9fytgmds6uTb0244oLQdqtGqWjDGUCwJDRkZq0iC3eUK3alfjbUfmttGkZ3hYtT8MslqGpXyli0/nl9GEoI2ocyHo2TQZmRZQ60uxcgkvA4Ix59W0yIqOiJX8IkD3zUQvSSXKs6zBImj1MhBuRrJTuCtM1cjnNT6u+4faHkhU7+qJnD434eTypCnu57j+whHaZD2jOROPvnu9V7utpoYzpBK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:59:38.7346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f7e9aa-af69-4744-7067-08df2ecb8710
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000039.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767

On Tue, Oct 20, 2026 at 11:22:46AM +0000, Mostafa Saleh wrote:
> On Mon, Oct 05, 2026 at 12:30:48PM -0700, Nicolin Chen wrote:
> > @@ -5576,6 +5573,15 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
> >  	if (arm_smmu_sva_supported(smmu))
> >  		smmu->features |= ARM_SMMU_FEAT_SVA;
> >  
> > +	/*
> > +	 * A kdump kernel wants neither queue: the crashed kernel's CDs and page
> > +	 * tables might be corrupted, spamming events, and page requests cannot
> > +	 * be served. A disabled queue discards new records without raising any
> > +	 * global error.
> > +	 */
> 
> I find this a bit confusing. If the CD or page table of the crashed kernel are
> corrupted how is it safe to adopt them later in this series?

The adoption code runs some sanity test against STE and CD. But we
have no guarantee that every bit in CD and PTEs is sane.

The point here is that, if one bit in CD or PTEs is ever corrupted,
at least we don't spam the system with events.

Nicolin
