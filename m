Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D63AE188
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557882; cv=fail; b=k7a1wSMzddydNgbRVhwbnZsj2bDzbAb0CalWKr1AITaPYF8qNVWlhgev51pH7TBJHV81PqQY31q1q+nzcWlQvWKC2eCbL0N9i7RrP6pTj3bFuU63FI3vuaHOehp3YW4mU9YqJdkToUO0McrnVRWbl8nhFEUZy8Zz6VQB6gjBrm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557882; c=relaxed/simple;
	bh=2WT03fNuhgf2nC5vKbjwozAZuHok1tOfvj7KUBmi70w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkYI8vX6Deafj3/AW9xR1bIKHVn/ycikVer6sTsmmBbbisiCLe7I9v6HJtikstZfNnwJXvIruvrZPGN3wSGVchvnV0bQ+cWj1/wtW1ZvSynp5h/Yy+uSMaaccAc+kHcRRo7iLeRkSNto9gmZS4d2FRAHjJuiBivULammwlTFSKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n7jhvn5K; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n7jhvn5K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsJzczl1ORq3lpQOhaUBUkvPMNFxQ4pmH2yjZaybm2uUs5mxYnoKeOCcI3HfhI9ZQDPXO3Pcg2WJgMC4sBi2axH5qlerAx3kdbDm3Nhq7Djo6nvQ7fna5II/kZFKrkln2qN89zUOV/J4uWfSDHEl2FHoTfcfnLXtvvHegmPOLCDcL4CvGd14NpxGOvNkgY0pRZzRk3OPrOifINmqxQb2c5/JdUbuWCKQHlsanEwk+xxmeUaZIByt5bt3q/NIGI23cMqv0zxgfWmqfqy6grI2vzlgb/rQhhyzucSZF+y++CEHy/Xmhj9ohO9HWCNpufc4O+nvs34A0Gkikcl9wFkkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUp8wdD+a5KE9ujMhisIpEu7Vz5H5PkA7GinCmI6hKo=;
 b=ANevP6PBjzY1WBrpYg3jwvZOcW+sVDf2pc1zeE2dO3uyBiGQZwSMPt1aVrvZ1a917tiubum/qUYHO7OAx80uTrx8bte3jcXEoyTXOXez1ZWEwQ7NqceMIhDPIHv/kpJtea0a3hYtOaLwXvt+PkLnIp3/+MVQKo1DTGzr2MAyRVjXRjhr9UI0MCaWrwq0vAcb8cfyQJits/ymHPiMcB9Iem8XTNEXQR6LNeU7CS1d2SoIQTaILmGbmAjmLMAhm1B5d42IJkaBAI4nWVMWvGyeSALdnmWVLNP4C5lmwncQbIsGqC1th1OSrgEEBSFursmebFinV5ovor8IqKFMGqIzgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUp8wdD+a5KE9ujMhisIpEu7Vz5H5PkA7GinCmI6hKo=;
 b=n7jhvn5KRsdRwX1jEXMxmb6b+TxmbenxZtpyXyZAGRnAaHezUceAQXQN2t2SeG739bwLQFjtdl5wTGP1g7Nfkskm6w7eN5rBjazuE4bG072E26guIwzj6GMORv5ncwIpg82wskjF76QRA1aoki/YsY4ak3plMjCbOK1N6qmg7W0=
Received: from BN9P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::31)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 17:11:16 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::7d) by BN9P222CA0026.outlook.office365.com
 (2603:10b6:408:10c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 17:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 17:11:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Mar
 2026 11:11:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Mar
 2026 11:11:15 -0600
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Mar 2026 11:11:12 -0600
Date: Tue, 3 Mar 2026 17:11:07 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <iommu@lists.linux.dev>, <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Message-ID: <4yddupv5soxmatbmcqqs4ndsffbls4r6eagoiaebalnlikx2jw@wtdby7qs6nz6>
References: <cf1a1e3d96c3571ac5caa528caa84751d40be1bc.1772208939.git.Ankit.Soni@amd.com>
 <20260302235715.GY44359@ziepe.ca>
 <mqobyculj4g3mv2ipf2rbacbw62ew2utq2kini5hql5r22khhc@btukh6fex6zb>
 <20260303120554.GC964116@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303120554.GC964116@ziepe.ca>
Received-SPF: None (SATLEXMB04.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 462bc566-b4a0-41fc-c7ac-08de7947e13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	o5UXmdlQuRcJBkJPjC9KqoyEW86R4qkIKxLBRbR/uTOETrK1T5UxkKejDXtBo/Wix4zAbjR819RGj/48q5amfzAgZTzvafKC7gQ/2zaxA9M1Upwy1UqXXBJoATGvYj2pxA7Aaz+IGvaYyAVvKxZw1YGiLBuHqPAazOfWL3Sr6KxdwR8aUDscxpC5Uj2W5doMRv8JrW5/2pkypBp9QY126o0WdMmw90pXFGS/TEhMG8xm+Pf5E3thf63ylaam7tI1iGZ6anjcy7ckn74XdmwRya76IrBbmlKGKrCgQaghc5bvQy2+81k7BNuVtOJzyFkstox09rMoQBm4j451MA41W9POpQMsXvQ/mCPP70GlbL6apr+9JuWwFwon8+2ihx17hw9IrZWnxvVahZ/oOKRMW5l3ahlPcQ9GiOJ64pz6MYnwCXJlhOONjYhRvB5002lXU+PI/55wak4aMJjMLWk2Z+x2ZFphIjk2MuDrOmnzJx8bMglAU0LPpBGQQu2JWrCxf3pae1NaaY3BKHF5BOKK2TX2wBhzbOavYYSRk9kseV2D8D7MBp4si5WFmFgciOncUy5qvy1/ZFHnD4pSJrRUadfiykxkpJxMUaliuRFtO8oU1LGE/3sLdNvBK99YyRxcbBPM4jvdiY21ZeyWKOk714pktQExlCsBQpk5QboHU8R+OjN5ajT5YgREgQ0m4pIG8nClc9nsmAQvGZAssvrG4wAxDr/SzIPRyNdF/yVbkOTpaKAw/McdlsDGhWEh3Uhq6wzedhleuC6WmwrmU3RSRxod+AQi7xBci2RQboXp6I2OkHMLFXthdGHcC4w57GCv8CssxjFS50u88c1P52dhUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iUI9IF5UonhH0TFXK2cWGMCRr8xJMNiXOWjWot94OwyGdx4viM9kbQwwZGqBmnIMWTX0NpQQpNNwvvDwmffTWJkeiKlWn+/ovGoJfear3q3HHGOqX+FNkB2uPpCVhqIUx4gwXTknPTwSQK/GVHMAeiFpe3jriBtn7Fn0+xMJSvuFTDjhIFuT7NNFowwkH11kuj3Gsl1E5AxZL6Io8nSEfX80ZukNWtYSgsl/qFj2MbRVOP29FR3WPyeYmIMBmfC0wQLIFPhh/34z7TuCK75pUps1Sza7OBYG3AHJRcgPuaXxX2hQhLc+WCy5YJjVAAVcqmexqs8/hHorYgTWuMZftyplDJo9zN8gSDTh8ADG/3WWNtTAP0ZWkTvIq8T/isqHlEvcDYNZWRvlTFGV2GveQ8UQs7u+/wUIun+KE+H/ne0UVteZ4lfWiK2j2TYr59W2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 17:11:16.1437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462bc566-b4a0-41fc-c7ac-08de7947e13f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

On Tue, Mar 03, 2026 at 08:05:54AM -0400, Jason Gunthorpe wrote:
> On Tue, Mar 03, 2026 at 11:47:21AM +0000, Ankit Soni wrote:
> 
> > > > +	/*
> > > > +	 * IVINFO[VASIZE] encodes the log2 of the maximum virtual address
> > > > +	 * processed by the IOMMU.
> > > > +	 */
> > > > +	switch (vasize) {
> > > > +	case 32:
> > > > +	case 40:
> > > > +	case 48:
> > > > +	case 64:
> > > > +		return vasize;
> > > > +	default:
> > > > +		pr_warn_once("IVRS: IVINFO[VASIZE]=0x%x is invalid, defaulting to 64‑bit VA\n",
> > > > +			     vasize);
> > > > +		return 64;
> > > 
> > > Why check and limit it like this? 
> > > 
> > 
> > I’ll replace this with a macro and send that in v3. If you have other suggestions,
> > I’m happy to incorporate.
> > 
> > > > -	cfg.common.hw_max_vasz_lg2 =
> > > > -		min(64, (amd_iommu_hpt_level - 1) * 9 + 21);
> > > > +	cfg.common.hw_max_vasz_lg2 = amd_iommu_hpt_vasize;
> > > 
> > > This has no restriction, you can send it whatever size you want.
> > > 
> > 
> > The intent is for the kernel to respect what the VM advertises in IVINFO.
> > If we ignore IVINFO[VASIZE] and use a larger limit (i.e. from EFR only),
> > driver can exceed vasize what the VM allows and break the guest.
> 
> I mean if FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo) is 35 why
> not just pass it to hw_max_vasz_lg2 and be done with it? What is the
> point of limiting to only a few values?
> 
> Jason

I got your point, i added the check to match the spec, which defines valid
values are only 32, 40, 48, and 64.

Ankit
