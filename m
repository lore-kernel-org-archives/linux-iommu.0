Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAE25783C
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320847; cv=fail; b=eSvYqlZK8wqZdvConrKSjBnY33Hw6tMz9Tc5fmtedYiOiqeMY7ddMb4nF7tBiM2DFPz8gY7tC3CNzyH8J6EOk57EfESq9eJDrezUHyT4H+hFR2TUTZQO1Vg42tpfTiIxG0MonCrpcwXTRLdohjr6CXcBBE1+mDmjMUTXO2MbtIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320847; c=relaxed/simple;
	bh=ZIynjypR0NGLb7/4s72A7/eZMsfie4ZVQYFYXk3/jBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=evq3xXKM/6xJ/wUHdlxnxh7RaV3/WzePsygwlNVyxU0vOmE/1AE+d3CbCtlPZyeCmrlR51Xjmsw6GZi6kJfkO8Ak/9vNXFxrOxXKI9Zv8Yy7pQ7TgsukocUWxMWAUZK07NSpEKi8ETZ7dDrVJ4xVgO6QW0Pv3tMc2037wGUcv54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eNKtvwKD; arc=fail smtp.client-ip=52.101.57.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eNKtvwKD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOoXLEjot2Yf2bm6AqKQlSzpzswIGru3iI3uiQSSNgORC3vTRZpxeR/32EPHkE0PI1cr59IZEygip982XwxCwbKHS1U1KxXLKMjN83Os1AKa1If+vbsBXjHPNbe1Au5JiVSw5KO0VXlM2w0m35P0Qq5uR6p0XuZiAdnBv8tgJm14ZDa9cz6veXKvS0xP1o1/JTkMAwnljeZL4Om4X2RqFL9uUN9ndLDqPgIiiHJEDQ+AIag3c1XQjnFNEnEfUaR3GwvgW15Nc3qsxquk3TAz71k/7V8NihwQ6QjhJ7m6TEpVgICOIwZ/AYnAXddiGyQcAWPamzJ9aTs4UQuUZD8irA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVSYgqwCXUnUc2sVIjdxHcp4gyn6wWyYnlbJ9uz/cSk=;
 b=w6vhfOzOSPtQwsEiA+WNnHcUYEtYHfGBHsi7E8edtKAolPmfzR8gurdRZRanS3tpOjKLsftwN8n2uW/IXFqAjxq5r+nehCWVTpSHEUCiA4UZsjx7SNxjucCw1c6RET6xWn+ZQtScMurMAJtpngfPPl9J+mIcMveOa08Cf7QS4lOe0b5m+lS+g3v3fs4w9YOYVbjs0sR3LJOQKrBJFzOfnmvINsbb2wxY9CJ1xeSW6mMI1d0PaTnv+H1SIRGDtVzS4Uoop4yNt6TPAqTUB4rkA/j8Hu8YR4o40Fj17QC/EOUdgXozsRf6Job+VsEyU1pyz3sLlCErSwvavohyjXDEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVSYgqwCXUnUc2sVIjdxHcp4gyn6wWyYnlbJ9uz/cSk=;
 b=eNKtvwKD7Z/XQdN7XvNdVyJROH2o3neFJOluxd107Djc/cezjhXTvP+T7EEM3582Tmxto171+L5LoGq1DEJvWh4u+I/Rj0cR19pxOjBgMSY+vrcNqJfgJnR99k8ZjvO81NmS9zl0miuugWCg2cyPCWxYvo/jBH6veiJ+sncZjwTrXIzn5PBMAR3rldJDscl93+VVJomKCS1Y+JFoeNa54zXWWFsjvgJdJ5yP38e/gq+PxF6zOThXOWBVoLL3GLQ6VTifBMilimdERS67VoL0hlJYX6XgSginF1F6BrCJNSJD8i+ZE/ijJpKoStFoS+Tseu7sAOxEpUzXvzjOEqRzew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 21 Aug
 2026 14:00:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 14:00:34 +0000
Date: Fri, 21 Aug 2026 11:00:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260821140033.GH244917@nvidia.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-3-andrew.jones@oss.qualcomm.com>
 <20260820220908.GE244917@nvidia.com>
 <gr2h3ktgacozyo7rdggkxsg5mbdtzcnimaawd24c37hnf2tun3@hqivsenaq5wd>
 <20260821120204.GF244917@nvidia.com>
 <zygm4qm3fjv57nsgcectwikfa3cdnidxnhv55nxv4b6l2kllrs@dt36j4p3zhoa>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zygm4qm3fjv57nsgcectwikfa3cdnidxnhv55nxv4b6l2kllrs@dt36j4p3zhoa>
X-ClientProxiedBy: YT4PR01CA0365.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 184dcc95-b237-49c0-c304-08deff8c91f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fTccslmbVcq/OqnvvHXzWkTG3CUCVRO7Xdi89nrUsxheEvwE5UOjzX5vBpoSoMoQfAo0/W5hSJJljjvnf/32TnqUhbDDMW0u/VBeBes0kSALoxYEE7EmGkybNXY9tytXzcnl1Tw3lqR7iOtTEexqA8UMfS/NBTxepUuI4oNg2VYg70dj7Oep1kb4e8efNZFpvoXgnj/MemYW3Ijpl+dOiQRzxSriaLqC7wkskuH3HcjRUGf92r5Khx6WI+z9Ib+xa9gzaycsF3hdfma94kHHtNnKVXz6sbz6/7okg51J1k8IwltDVoO3qh6JWnHQ8MrMUMZ9Q+uUVtM9RPeg1YdqIFvtqHi8cdqGB+HHcBaiXjqhuLpoQ/YdfJajocfeu5N0MXuEZvdxetIgde6p3IG2N70m1RIJ5A4CFFe1E7N7EcjMMrM1Eanv1X80hmtfPhDFsPeuXa0WlY0+gMi6faYGhloFhVr4B1Rj7tWYkj4cg9wQHHLwICNDZ4me7y9PoiVnAdkt0Kp2ynFzRIxD111xroyqAgIftF9TIq7vMsdBi1xri+7QWmX8T15T3GZGDuO6pOsgO8FGiolSWmRwvvBoYDZH3WHfT7TK/G3MMhx5t4jwFAZWOWwyVvM1HeUuIPhYhL0mjpg+HoBP3/fjMrlO3OMMVVP8B0C6WeRTWZiC2dk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YrIA2p5Abi1fBOdwyaA/TKa502gowI4qG9MHnP36MUploOGJuE8WuAEhQ92W?=
 =?us-ascii?Q?neMPciGIp0m7f4WNvpcSeK34lHptx59P40fKyZM6Io88vH7mM+PO/M3ctKgy?=
 =?us-ascii?Q?k5fYOVt71fD15a1uVR73oiaL0xJO5cyjAmWcWzo6L/1Julpar2vkyaZHMpsi?=
 =?us-ascii?Q?4nEbBl97leD3jV+XiviNRZofxRrSVfKssZ5/jv+qcRbPXlbwqbyNKpbvgOyN?=
 =?us-ascii?Q?dadghGhVt47c7TOwnU5Kb9VMBXgbaacvV4zW1EZcVr+rqzm6DNgX8cJi/uFz?=
 =?us-ascii?Q?lfJSb6EWsK1si0zSquZKO7WwGhDXHaPTR7WU722DAcP9PC3FFFXLCLfg0BbB?=
 =?us-ascii?Q?kOK1JvDIUUIbpcBMXr93NThZlGTbFgxGYXnn77uGpo54d9wUNdQXizYMsJhf?=
 =?us-ascii?Q?RIG/0u/CZnHIrr5/DU1aN8kujr8SsryphTV0az8A+HF7UUwtdeRPvHn6YUtr?=
 =?us-ascii?Q?e0NwHXGAlMLbvs7bG1O/h7m1ObJyuqWL/NrABAH3xIPhnpLnvOut0Osvgbqs?=
 =?us-ascii?Q?oWQ8m8sp0/21bAKappy+SRxIwQIX8or/gSzzW/ukDbLaJFHlKcfEH7Au67Ts?=
 =?us-ascii?Q?R4WTMCbhSYV1K14XIHXrxU8m29JzKkjYPH9l3lXBQlnUntyKxa7JNXvRoMNd?=
 =?us-ascii?Q?FpvA257UetJ2tw7EXzkC7sZGH60kGcDJcwEzzt74wQ0ICPVqDpWbBNjNnU+l?=
 =?us-ascii?Q?bDRdK2i2/+5EVqbGHYnmyZ3ZLaGvHmklzrn3WgFMmVr9TDONpZC0JCn1fWeV?=
 =?us-ascii?Q?7EEVeGsVFqEyBrgbarukc2DJ+ScgIuMNN848rwV2QwuRlLTJQpouuT/kRLGN?=
 =?us-ascii?Q?80DWtMd/ixqVfrT5pldVI/nmyBn6VBW9p23TOjx/DXQNzJhmV2gSIGB7qIx/?=
 =?us-ascii?Q?VyLufAy2+Nf7NV2N5OEIQ8mDSMumUARaSt2Kxnpkq5jSPOIrW5/z9172LDtM?=
 =?us-ascii?Q?UpemBHl2o/IPEPI5l4Y3+Z1YkbXJRjhemV4Q+oo3DyhSoNeCZ285eKwKeeRy?=
 =?us-ascii?Q?qBXoX4RDtBajLoBFzaabEu7Xv3cnFqZAnhUEOn0pmoHTn4XB2Gy0iGbyHH+i?=
 =?us-ascii?Q?aruxNig+lPRmg8BJIVVMYPdA6/qS8hrJG1O+PBqbKdv4hhkfMbnQNLj69S2C?=
 =?us-ascii?Q?T2OtlzH7/T00/fLwFzaTAUIBY6BtulSLEixI4EJmJqvZEImrOIJXmijxtkqz?=
 =?us-ascii?Q?2b5w3bcRocM/o5TmMYRhEVWiREe5NuB2uZEgA2RP8eBscjnc6g8tFszrnlfU?=
 =?us-ascii?Q?MSIb4WjYAsz6zsuTry4JfUtjCx0YCWEyTTVSw8ia/Kbla2JXPeZZQfiaFsfl?=
 =?us-ascii?Q?AFShlXLZgKtcw13hD1sKGGdVhRkh1GUnN0UVCALqPEGjsON/v3yd1+ITQ+WN?=
 =?us-ascii?Q?c75/iDfaOJHl8l/992BGjagzHTcYIxfq7k+ZTOzTXgCFxe+Cj2CS3j/U2pgn?=
 =?us-ascii?Q?79wpqIX6YCXt33Cvx8fgatgqaXf0dcz3E+Jpq907IHmCQD5dRQxcRR0cxPIT?=
 =?us-ascii?Q?rk1yA8ZY27jVOHqAdl2XtrEHwReo9h0rfoW1TmJIw2u1l3O/4ugUtlwBLmcq?=
 =?us-ascii?Q?FcRsPi55JfzsMikowJ4GfyUUrIHBdcE0C2Fa4L25t8kewGZBdvciyyO27fmU?=
 =?us-ascii?Q?uQDo0O+tx+FJ2AvOZYwWorPk+E3IFkyjfVhDpnjje0qT1dxZyUwWwjpuSF6Q?=
 =?us-ascii?Q?AG8XDQBUY5HGO+aC+PC7N1VP0wLS4W3CL1/k+8zBxBgZtQwA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184dcc95-b237-49c0-c304-08deff8c91f7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 14:00:34.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kmPL5vi5ldR18OXKBWKC/0cGaA+OJK+RXYgsy1X72+d1763Z8hrfUHyVNje5Pzz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727

On Fri, Aug 21, 2026 at 03:47:17PM +0200, Andrew Jones wrote:
> On Fri, Aug 21, 2026 at 09:02:04AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 21, 2026 at 01:07:03PM +0200, Andrew Jones wrote:
> > 
> > > > What I rather expected was for riscv to have a PA window that is very
> > > > big and not just one page, eg adjust iommu_dma_prepare_msi() so you
> > > > can pass in the entire PA space that you need for the affinity
> > > > changes. Maybe this is a list of phys_addr_t ?
> > > 
> > > That's more or less what this series does. 
> > 
> > But it does it in a completely different way, and I'm struggling to
> > see any justification for this.
> > 
> > Again, just pass your list of PAs to iommu_dma_prepare_msi() from the
> > irq domain seems like the easiest and most ARM aligned thing.
> > 
> > When you need a new IOVA for an affinity change the PA's are already
> > mapped a simple offset calculation is that is needed.
> 
> Ah, I see what I missed. The proposed batched API would guarantee a
> contiguous IOVA range, so the descriptor could cache the IOVA base and
> then the riscv IR compose-msi-msg could simply compute its target off
> that base. That would indeed eliminate msi_iova[] and all its complexity.

Yeah, that is pretty simple like that

Then you just need to teach everything downstream to have a list of
phys not a single phys and thats an easy to understand delta

> ARM calls iommu_dma_prepare_msi() from ITS since there is no SMMU
> irqdomain and ITS owns the MSI target.

Right SMMU is not involved in interrupt translation

> This series adds a RISC-V IOMMU IR irqdomain to replace the IMSIC PA
> with the corresponding IOVA, so the IR domain's alloc callback is
> the right place to create the mappings through common
> DMA-IOMMU/iommufd code.

But RISC-V IOMMU is also not involved in interrupt translation. Beyond
it could remap the PAs which represent the CPUs, but you are not using
it that way since it is statically setup.

So I'm not sure why the iommu gets an IR? Isn't it the same as ARM
where the IMSIC itself just has a wack of PAs it needs to access so it
calls iommu_dma_prepare_msi() to do it?

Jason
