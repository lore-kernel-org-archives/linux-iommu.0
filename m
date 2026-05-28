Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C83672AB
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006460; cv=fail; b=pMtBmSWBSkJKFrXX8fTCjOvQVAZi+Qo9TNyY9jxLvYVIORV/VhTyTW0EGae3/jSYd56H8Be5UeCD67w8hZJR4sKmU30NRPfTu3uYbOuuf2i+P4ckt8Vz168hx+TnWe9ijwTubeWFHOvYI+UTDC4ZE84G6av0mdxLO/5yx2Uxnzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006460; c=relaxed/simple;
	bh=8KjkUvYgeooygNaQdpdSXcrxCFlIdH1BerZpjO4q1xM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDGrBWojqaQC6WhHYqeqsSkUgR6EIqfJjKniwr2ga8bjMOCeCdDlV9EaIGTuPgK7vRh10WsmUGq9nCNchx8cbePhQIU96MUEyLkJc3qroo1KBAcVtzqVEyVh/9l2/9ZKb/r6dikI/CvL120bfz8z1tpj3/gd8YiulJGZH1hH65M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8cFD2fp; arc=fail smtp.client-ip=40.93.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8cFD2fp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIyHsps/YZfl1M30Gy8Kxbgrpt0IfFp87XhrlfYLGVWqwE30u+E1mM3a46bfMgVUAqAQb+rgaKB20x7l/6SKk7mQJl5SnKa1ArdKWjMb9rHDmWJx89Xo7j/a0YeeS+gcgdR9FW9maATGi3eSDPXdAYZKMoyN+u0MjppW4MF1pJ6J2iaqQ4e95JqzflA7XVGcbcdcMnach4SlGYahwybqac3rr+yKrc+IVJDrMeuFt/6z0fh6FNYme1bH4EKaukRJngCFaGKENgd4zDw1XJsYo6XtRIR4RRLAzxaolHuXY5ljw2HB8ehoF/WbZMGG/6ofQY8oZU569Q5rYRSNtqbLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFcemdiuIEethHAaRtPGcR6AjPbwfGlp0P1zo4oyo2U=;
 b=pfV5GoBwtMJg7RbrjzF6McQiIPcD8UwgwrKRHOGR2J+n1nPrKf+5PSKUFNznl/owhbUvPTq+l7jjHsNEffDGEdoUyoZRJ13New6g67x0hSrVeAM4XztEvtISWkOG52CdaHaYf93NlONJp8pqaQdj/Ex3IXWF7lbTUx19OgVCjKDsqFwbsuppM3kAVxRX2GygZPU3IoOoFGcr62P59dkM+wDGLMVfInsMOvKbJtsyESCVt+NFVbI5L+nsgtgXud0AJrB0OFOARTql8kqTGIVMpAq6BH+ZX9Ez8n4EBgx7726aEn3mGZfUMq+C5VT77javFTKp3cN/ZIhjrvH48wV7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFcemdiuIEethHAaRtPGcR6AjPbwfGlp0P1zo4oyo2U=;
 b=V8cFD2fpcuGWPO7+srASP1UgCo1a6EZRNqrQoIpIFcQ6Q6brRu6q4SvxkAEUMN6qH/fgyBAwbw63Wlq2iw2694HVHSZlBVdulIjSZ4mXqSAeAA/JvFv3YPC9Q8d8S0DHVZ1uUapmBFuw4JSQDjw6ZjwYK1+NSIC9voowNUapC7tgGDxNzXdSAZML8hXnuaPWkf2MTKXCN66QYrPQ8JMNDbF606Tl+K5YkU2L8WWplI7bJXRNii4HBZaae5TOF3PEwwy0nMOIdE7SeSIj1mrJUDfssD+HTFzoqjZDoh1dzX1gOTeIpwerIuug2Lj2YInEgaaF9D7jCXrptX1aWjGvYA==
Received: from PH8P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::9)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 28 May
 2026 22:14:12 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::54) by PH8P222CA0028.outlook.office365.com
 (2603:10b6:510:2d7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 22:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 22:14:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 15:13:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 15:13:51 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 15:13:50 -0700
Date: Thu, 28 May 2026 15:13:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 08/11] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <ahi+HFgBDYmByAtb@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-9-praan@google.com>
 <ahiaApzK1/nBwr2R@Asurada-Nvidia>
 <ahix0vUm03lxDwAC@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ahix0vUm03lxDwAC@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3079a1-f67d-4818-271c-08debd067286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|11063799006|4143699003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	DLvL9c6DKWHe+5wY+lIqzYSVQw5qAA1EZV98HajALyBFmPzT4jhW37Skhjp7g+nO2VOR/F/QVzN3w0OVuUgU1jPBkkl8ymXtLWy3I5c43HAXtuLnMUsrgK27MFg7DZ+VEzG1jBZvmlHp/FVfIHN3Gve+uXnJnN1BejwiN21KLpZM6jPL7T75SDCj7nr5O1yUi0s4t3w0Ju67rdm/O9HsT9Zsr8j/ptKtepMDg2cbN8nIvlcf3x4c/8CiA+VDGRVgcFl2yt4OIc0bXZdK+X8x5ji7TjR8dN84YDDf+YFZibvka5Jc+JE12BK9tD7msPp3A5Mn7KfBW/hK12DLqjMd71uec7LjWTgXLOxBBDIbVNycU87QEpvtWhtUU1fmZSYhVSTPFLBgODaAGU8DnaWamk29nOsW3mzNcIWMC4EE5pruH57rljBP8QfijkVcNiaxG2mRUT/fQyfif1Sg0UhZoAiimM1p2I3YXqe9giGLzzsE7y6hdtWjwgAaGdzJB42HBHNhlJUMyTVK8mGkgG/csF1do+jg84cqINKys9MKF9t/Bj3Fny8cPJ8zH9BgWdEmZXqUihHvcyWPyP7EGPc1gUza0znytBwzRuQhYb3HIISNKu42pci2UM3VXVo5N10wNvEY/MvK+KcLXN1+wp4bUqVg3kZObXPfSyMBXpiHXe6MnLxHeRfAQGYUji0Njm7OCg0eapH/FpwYdyonaH8OFenKAn6PQRry2sBcKQr1t6M=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(11063799006)(4143699003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1t1tq+PPZBHNDQDE15HxlwdXAfbopBEKkEUWvlHlK9l8YCyZ2HG6Co2LOpXCFmhRe2HdPg4iTOMQWBJ/pflWOHwnjXXlMoaG+0bWaWbEzZEVPTVj4p3f0mi4V64WjzApQTUFzF2su/4R35g7OlbIFCfQAFvKPr4Gu3prn7+JtsexPSRBU/Tno0Jwqws8XNT+HzfBUy7/6LKTySSaIwGVSuFHPHYSvO0qWyhMfNAvHuxFfbALEdcGT3ACVaNWMVZZJWGtGO1xXFQIUr2fC8IchggTxNnABAVDHD+fHFkg5fpDDzpqiMkSSIdXDpGUyU6cvEnA0j3IJSGkeMgkhyKrB4zq4PBqVAkiyiELQnp/Ce3+LGks1gLF2+IN19KR6YjAjLj8LyjepU3N/b26rzW/8Bj90agSWJd9bsayZxKJpSavpeqpmfJf4tQqL8tqy9k8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 22:14:12.0483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3079a1-f67d-4818-271c-08debd067286
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770

On Thu, May 28, 2026 at 09:21:22PM +0000, Pranjal Shrivastava wrote:
> On Thu, May 28, 2026 at 12:39:46PM -0700, Nicolin Chen wrote:
> > On Wed, May 27, 2026 at 10:14:04PM +0000, Pranjal Shrivastava wrote:
> > > @@ -789,7 +822,8 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > >  		/* b. Stop gathering work by clearing the owned flag */
> > >  		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
> > >  						   &cmdq->q.llq.atomic.prod);
> > > -		prod &= ~CMDQ_PROD_OWNED_FLAG;
> > > +		/* Strip all metadata flags */
> > > +		prod &= CMDQ_PROD_IDX_MASK;
> > 
> > Should its prior atomic_fetch_andnot_relaxed() call do something
> > about the CMDQ_PROD_STOP_FLAG as well?
> 
> Umm.. No, the atomic_fetch_andnot_relaxed() call must leave the STOP_FLAG.
> This block is the owner-publish phase, which occurs *after* the Point of
> Commitment. If a submission successfully reserved its indices before the
> gate closed, it shall be allowed to finish.
> 
> If the owner thread cleared the STOP_FLAG here in the global memory, it
> would prematurely re-open the gate, allowing new racing submissions to 
> leak in during the suspend sequence. 
> 
> The algorithm works mainly because the RPM callbacks are the only ones
> that are allowed to manipulate this flag.

That reads plausible to me. It would be nicer to leave a brief note
inline.

> > Should it handle a secondary_cmdq?
> 
> No, I don't think we need to check secondary queues here. The STOP_FLAG
> being set on the primary CMDQ during the suspend should suffice to 
> indicate the entire SMMU's power state. That's why the function takes in
> the smmu ptr and not the cmdq.

But if we don't set STOP flag to the secondary_cmdq, wouldn't the
drain() timeout on the secondary_cmdq that does not elide?

Nicolin
