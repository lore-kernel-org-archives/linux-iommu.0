Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A714EC73
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699601; cv=fail; b=nytcVHduOZqirBh8eI2Oh3qPai3UXWiNM7p69OXq3otKeaXAh69iz92yYzr6zhUGCRa83SkjIvT+MDZiylYC/b8W3NvInfiaMq5kYhflap2NRlxas+ufP11RBLELeintBu5raMFPMZ2uBumnW1nSNWgBbYt51serNN+Dot0RwNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699601; c=relaxed/simple;
	bh=a2lPeE/dT/v57jpRRfa/Eajpl1HS23JU0U3ZEZbZpAg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAAvAaSueDx3a1tq4ZuNdPXm6BlVeTYtaBqAKJQmWYsEaojWMGBozncG+FTyer5CN/18f4ZyaNeAkd615Vy6IGDpupzv/3VmIeMd+HZ+QuSZU6xtZVqLzaHVfHCamRA1HrKTOHEbPYaFEekWQjrM8rQwioX09w0gK/1flJp3ytQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P+vJ3Gwa; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P+vJ3Gwa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJXhFc+xiKi5wv/6qywApaOZZTY85O7zI8BaS+MrXOc0Q+1WPgJxMXxybKdEVL1yvWc5QQvAOck4T/s16Y3uoi2DQCON3hwvvyVYV4dCb7dtFg8qazE4vixFfe/UTC6PKI++vEvJhX04Csto0DJ5vLcpNxDbcnZppbmwlZl5/aAqz1cpYqjeErEdnYPihCb04r8QI1ldxdjlGQdW1X35JK49nY41pST6IV/v4OAFRu4waAxnlImZP+Wk6o3VQ8BCuFeE8FOxsBY/yUQVXoVN28c4s82qAiYAJsc19ULpBiemA36cUSxN/h6vCZKMuyOHxBNNwwKY0rR5NO4p+KfZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pug1w3n+gXBlyKLfVoD+GG7jgHPHOOw30tjjEC033J8=;
 b=s4Zfo+xZDgrZodmUahugZHBn4EHhG1rAhyHK0lCqcs7qun9Cs7OnCvshxEOKRmec28Ut75nXfRbABXPNnqSyGRfEkv78AHvJK1BeKD1Is9CWIhoOZygH6wxjYDomdKG/NNHgj8u1VCqvK5GX5OFz8WNOBAEjgpieMgA95UXMJNbHc6unBiQfM9Xnp2WLqhTOsOfRWsYayHY8m+HDgZORQjTNj0gC9ojVSPOC1fINXtFmBOn6izsvrsqIO3ID6i0CRCDqdlCFjzbPwguMtpZLQQPH+6nDpQH5Odl4+MGmyJcyTmVPnfE8cgvtbleZeBRHCLyiqbuntr+kEX1jPoIMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pug1w3n+gXBlyKLfVoD+GG7jgHPHOOw30tjjEC033J8=;
 b=P+vJ3GwacXY91VPbyZpn48/0GZn4U2yNj13CgcJKqd078/CUsJuq2GXWlqhpvDdex8H2RG9mMaXl+IwDTXGgW9qGJvf89o15/AbU0CPcbshK7IX1/ZCmE6B/W57BwGVBnJednUYfkD6RID5xFYbHU4bwXvkn0+9mdLbjmTlBhch6aSJAloYLoucVdDbgHwSVKC3MHD9r+rN4z59TPLawnnlZkLR5u39aBOHCO309M/Wm23jGfM9pHiQP8pYLtl4LeS+S3i//Y46czkqwNWzDt9TG7/b7EX8QUaS0xM6TfNTjtE6NBq72LT8aZCVib01wKusOzj3nP9xlFxpvUdLd5Q==
Received: from DM6PR04CA0022.namprd04.prod.outlook.com (2603:10b6:5:334::27)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 05:26:36 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:334:cafe::1) by DM6PR04CA0022.outlook.office365.com
 (2603:10b6:5:334::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 05:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Thu, 15 Aug 2024 05:26:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 22:26:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 22:26:21 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 14 Aug 2024 22:26:20 -0700
Date: Wed, 14 Aug 2024 22:26:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v11 7/9] iommu/arm-smmu-v3: Add struct arm_smmu_impl
Message-ID: <Zr2Re6vgO3SnnEUB@Asurada-Nvidia>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <8f6fd78b4c4358e65e9d171d90aa4a3dac392f09.1722993435.git.nicolinc@nvidia.com>
 <20240814215246.GX2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240814215246.GX2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a70423e-74eb-43eb-cbfd-08dcbcead4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ZWVGFFjAzUSUIqxCBcDcGwTAkTwX3kBOQALUFJv+zO0cwTiUdtCK0kYiUQ+?=
 =?us-ascii?Q?enH4CuyoY6627W9j3JuBnkSRfu1j60eUhCW7lE0XfKSooifkTJ+U1ClGG/z7?=
 =?us-ascii?Q?1g7qR4ceF5rrZYvzDfLgNNAMCVMhtd0AvkAyPuz47oKDgmXZNkc7QPlzYra+?=
 =?us-ascii?Q?GXZO2VciD+//JGjpDX/B/xmJRIaScOULvCj7w38cLPYVQbRAv3LUZL/HS0h5?=
 =?us-ascii?Q?7Es43Z0/BSsLr6zFH5g0WYMpnVuzhZuFvJi9QXoqlTKVBhcA/CaRthS1aaT8?=
 =?us-ascii?Q?+IVkg3m4ywEak11mv/LHeDhDlC2MX0wV55ozwXOtPOEzXWZqb1y8pIMv2m2N?=
 =?us-ascii?Q?EPvWNgTOCpSbL4FKgZ5AAkqq4/Q/q03WY5hMYqWuzgrTSViPpytYAMePrY++?=
 =?us-ascii?Q?0eBwlshpb0pWcCsWwKvV7msTp1dyEC/Xc0fJUZT4HRkiwUcbvaQpMNSkoRHs?=
 =?us-ascii?Q?E+97/x+XaLcIfX33+zyOOXcsyJdQ3S1wLypZb/FW/ykNz9gQN46lUJ1rBmIm?=
 =?us-ascii?Q?NRzF2FoN7XnAHlObkSEmmVJc+B42hdg7va3yu55cPe8GJoSjmN4Dv9Hs30tw?=
 =?us-ascii?Q?CCxwvJgtMs2mzbW+hP3RtUV71luaMgXT3IFY3+T5NI5iGg62zP8B4hqq8uOI?=
 =?us-ascii?Q?2vyNbcjE/QlQW7L8MHvxCBFpEqyHLi+mNT5euAaXNNj41HSPJrKbqRSTzsv/?=
 =?us-ascii?Q?u9vBDJgm4w8urvtJAyn8p2mIZfryAr52COXfZ4pxDIpAkRTPCcDUPU9qDiOb?=
 =?us-ascii?Q?eqjSWdcp69/Aet6ZrYdQtfPWA1oiTMGnv8vFpiYI09xcArisiJ2qc7fZuxyK?=
 =?us-ascii?Q?0lOLQJkwDzdzh+cJfmixnI5YD6mM4lYNoabUBzHhzl55TqR7qNcMxUbgt63n?=
 =?us-ascii?Q?2i0rA+kgGGd96BnN0JU4TTXoMbH91qMFetlUjrCK+1Kib96OMp40WAKv5UHy?=
 =?us-ascii?Q?4PLZvsvKjpWmfgGWr6LV62SnrZ3Vj2jc6XGdBpo+KdpQjp672mqF+hTnj9R1?=
 =?us-ascii?Q?281EDMNGB7aIaPbtwM/M6f3iv0DgaePaJoSo/FPTiBhbvqNOGGmruS6nKB9Z?=
 =?us-ascii?Q?tjT33kVslLtb1zOECfRi0LnZuHJ6eroD5IzbR5dToVWtI4r9qCflgd9KZ7p9?=
 =?us-ascii?Q?Hqw/4ZtSw3cod/JBv5zcVLRXq9I+6J25jFqhH/IgWtpZZAHbdNNL+awAB4sg?=
 =?us-ascii?Q?A+TA5WC9Ch6byxnaHzESN4GkjpUpIaO1S3dsogrX1In+vr0SUskN/g7bHjXf?=
 =?us-ascii?Q?cKw+TiTD4LTEcEfYHPIN4435SOKXrspxN46Kp+I0pAyopWB7XuR3D62q2AH2?=
 =?us-ascii?Q?+/L6+9COK9VZTVdlCZwlCSiS5t9uEXTGFGXRwekiesMU6Dck92LzW0Kr5/ZI?=
 =?us-ascii?Q?6JcIlnso+RNPp5RYQzzerS10+nHwkLt5f1m9Gn7IfI6eBknG5/RQOC6c/+LW?=
 =?us-ascii?Q?JtMH4plvgu0ut2s8RsDGCcO44SyCeU+n?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 05:26:35.9256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a70423e-74eb-43eb-cbfd-08dcbcead4f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

Hi Jason,

I've addressed all the comments here. Two additional replies below.

On Wed, Aug 14, 2024 at 06:52:46PM -0300, Jason Gunthorpe wrote:

> /*
>  * Probe all the compiled in implementations. Each one checks to see if it
>  * matches this HW and if so returns a devm_krealloc'd arm_smmu_device which
>  * replaces the callers. Otherwise the original is returned or ERR_PTR.
>  *
>  */
> static struct arm_smmu_device *arm_smmu_probe_impl(struct arm_smmu_device *orig_smmu)
> {
> 	struct arm_smmu_device *new_smmu;
> 	int ret;
> 
> 	new_smmu = tegra241_cmdqv_acpi_dsdt_probe(orig_smmu);
> 	if (new_smmu != ERR_PTR(-ENODEV))
> 		goto out_new_impl;
> 	return orig_smmu;
> 
> out_new_impl:
> 	if (IS_ERR(new_smmu))
> 		return new_smmu;
> 
> 	/* FIXME: check is this ordering OK during remove? */

I am not able to test-verify this. At least CMDQV seems to be OK
to remove after SMMU.


> > @@ -4560,6 +4602,7 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
> >  {
> >  	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
> >  
> > +	arm_smmu_impl_remove(smmu);
> 
> Can't call this if devm has been used to set it up, and this would be
> in the wrong order anyhow. Just remove it.. I guess the devm was put
> for this to avoid adding goto error unwind to probe?

I got that from Will's patch, and I think so, as it does simplify
the unwind routine.

Thanks!
Nicolin
