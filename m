Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ACE3D091B
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014227; cv=fail; b=LlKhNKmhtaQK677yLeC/ASfeZgQtOcuLIsTtRuBEx/36NHs0fDC6hcXN76iclml1z+H83KufE7WD/FYVxhJo6hXhRVSdvu4r7Q1nIOHg5CBrm/factcTt6+a/zhaYP8AaJRTPP/YqzqGhtMdpnlbBJ0t5k3B5z/G+iBzusGVqUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014227; c=relaxed/simple;
	bh=bbAOpJh1FCY50a2zQbDjWoYvCbvGELNYtMS6tU+otqI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3f8aVK8ma1P/aR7iqMKkJeT+KZiIYst4jIf5UO2/LVBCo0VK2yNSy7E/FYIQ1VYogUHn5bWi13ZXBeBvTsvz637S6ugOShpedk9X/cMsJpPc849PxAi95HPEu65lH6/Sqyoh43i2PiUqHTZQ1c7STpksO79Wg0Q9+w7GlAANLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GMYi7WZ0; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GMYi7WZ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovZ/9Muaif1HsahGWkaIsqFkdW/b8mTVzCasaKQUOJ1Qck9q2ujDT6xumQkFaQ3uJrWM7WelhcbfnciT3oGedKLTRTupBi5cf2tuOezSXN6yQtD7UdJJgFqBnZCqdONli3JfyqvrM6UHbXLI7Zbv5LDFn3rqA0a9ek0+L0MdtjYOd8btgrJoLvad3r+X6kZI3efbui0mxSazM0MotO8BSuZXkg8ai2X5gYLidDZcI//nVwYjW8+x6NLKsFwXzoSZXpyExYBRuNb6kgNTaKMppkR4Cp0UyPTUeck8rizjuEZYcbwUNULiO0FsGs8SD57fflKQTrzlHM0aad2AGZIjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0pE4EzBs2xCv808Vb+FEGgIq261PIMPqDIcUCWguK4=;
 b=MY1I7OwR34qgaNRkca6hjlTjjlZ3vRYHFa9wBbKDSFzaH9hO2BPZAd82lNzJ7TC6GJ4iAP8+uIHOPiFQ3chwgnf2uRWyCqscqLtSqGW7YPG2DuyC33gDtIvZRhxAA5L4SwgFwvFGJYRdPMmZrKqo/TWazR0Ie+lZCWHtL0fHmBznd60XC3knqFqLhGfCvo9m9uFok1fRDKRUyH4PaOKHoG9dPU7C7974W/evwWYI9XEEZ2I8rvk8VH7GpPgAN6gK6p3AJ/qYcV1r1TqWgBGAnlj8Bn+0AKS6RdmNssyj7bH4xdLUYK05m8iJkp7mnTVYYYHuUHRZ2dpks+40RkobsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0pE4EzBs2xCv808Vb+FEGgIq261PIMPqDIcUCWguK4=;
 b=GMYi7WZ0nxZ1x1XSe1OAni10uEdedufsNpwf6XnmAan73JO2TSJRNpSfDho/z+ENCd0uIOTDaRnc/lcz4q0aqdEoK9goeowCfppbG/4jlVLnl+C0dTRSHystT2xln+CJs/eqZ3AURYdimGrzHV5+AAnoLr1y0/7d7s6F7VBUc7Y+mODPCKZSI+PfyinJA2q+Qws/jEn7aX+fLdvGLgcLIXNcoRuxFQXFFd8uSlG4bCm7OJFi69kHxe68dvupEAS+6bP+IhuhAkPrwlK5iWamEsf2Q277I2P/3BduiO3MTQfADFdOpHDNtTqbKJSUTergqc7VsZ1ernGfd8w4LcS6FQ==
Received: from MN2PR15CA0049.namprd15.prod.outlook.com (2603:10b6:208:237::18)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 20:50:20 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::a7) by MN2PR15CA0049.outlook.office365.com
 (2603:10b6:208:237::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 20:50:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 20:50:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 13:21:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 5 May 2026 13:21:42 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 13:21:40 -0700
Date: Tue, 5 May 2026 13:21:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Pranjal Shrivastava <praan@google.com>, <iommu@lists.linux.dev>, "Will
 Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afpRUaciIEGvD3Bi@nvidia.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afoWrn/RXxDmcHsS@ziepe.ca>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ecbcaf-7baf-40b2-484a-08deaae7eb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zeh/xqFoMA+DPDT3aF+hO3rmccraoyFWlVzxxW0vpXV+v1Lx6aGc2CqjzmrH7j6+4b1Y3mKEpjrZg1odfaDR8I6JOQiiP7h+46u+aqw8Cy4YZZYAgSX1zPqVnLcgwdL59gK3s2gv9vWWMyt0VcxPolkQ2eT38wRA0HN28lg+7h2OPx9f/t8pkbNo+7irhT/dOMX4X3LvUoSjw5CWjfDo9X9DZMjkrLcPSTwMFoErSmmnPrxtAOP/jqwpwobrOhhphHhxGzFttzppLwxAJiA5cC86etxgyu5qvkE6Jb8dnqoKtqNtb/Zys6pUZ9JHFUbY07RHHNkh79hKznmO7USh/6mXtXLgF9uNQK5l/iJMvVfqWk9WmxVcVCBWyvXU258lp41F5DKcRVZLx8TJjBxYIGvlRo4nVhpmMA/6Fd/+Uev2+IfVr1Wf+2xQVrsXXm+uqhipGB/S9qzfWku0yh6e04k2VeCywNWidlS0tgDnDhhfQ+Ak9ezeCOfy4EPIv2RPkVWx/bLC3PLt5HpEoAYUnat31k6FE2noIKtcal9xiAuVb7d22VrEPne28PD4brjJsgWO09OwW5cEuZGNlJ09oTTBy2ux/EfG/9SPKVO1LM1HG8bncGI1x5RAUqdETcUTeSBkhoNCowhweRe9hGX3R8QjZ37EQAVyUmwjo92USEw1Qq8h6OWp29TUOfx3GNfl8Zt/xUNAh5UjOhGCCBTpLyuTYmySdAorMZknqSOy6+s=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ua65ZG8L8mUM4kyQSAN5GQ+q7AJttHupYRJcL6rghRKs+FMYtNGZKK4X7KjxtuMBfAnjI1hNCUyvKejd4qOt6FdcrXVo/fuZEFxdJ9fKWvDgGqWU/+EMOMrCC4b+dlss3ZysjoXBEEGjfDQKekkFTz30ixNGwtA37wnZIfhmwxjECvjh3I6oOTVwyjEMKUPr0YWwXTT/OjDv8dZZYEEmLECouIeqOq/ExsEqpjIP5+DzQ1GbW1C/lQN3POJceFzQLwWFEBC8ZUEIz+6XcdkcfX38LLCufBfk9sLcmALcR983Ivpqe8Jk46B82MBT30M/W7/N59H6xMUrD1aQZ6EP0xZeY1CnM4aOt84TMvPwH/wp2iz56dKkV9PoRJ4c32w3PmC00IVt4KFCH/VLimjME+A6Og5qr+CQWZatabscTo2IV2Gr4+Jq9QhFm8F2CkKc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:50:19.1354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ecbcaf-7baf-40b2-484a-08deaae7eb33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098

On Tue, May 05, 2026 at 01:11:26PM -0300, Jason Gunthorpe wrote:
> On Mon, May 04, 2026 at 07:33:07PM +0000, Pranjal Shrivastava wrote:
> 
> > > > The issue was exposed under heavy load when running a VFIO-based DMA map
> > > > stress test: iova_stress [1]
> > > 
> > > I wonder what's the real reason for pci_enable_ats() to fail:
> > > 
> > 
> > Yes, It's the dev->is_virtfn case (the one you suspect below)
> 
> Oh.... This is a much larger problem then
> 
> The VF should not fail to enable ATS, that is a meaningful bug, I'm
> not sure why are are just discovering this?
> 
> It looks like the PF unconditionally calls pci_prepare_ats() during
> arm_smmu_probe_device(), so how does this happen:
> 
> > >         if (dev->is_virtfn) {
> > >                 pdev = pci_physfn(dev);
> > >                 if (pdev->ats_stu != ps)
> > >                         return -EINVAL;		// maybe this one?
> 
> ??
> 
> So, I think the right error handling for a case that shouldn't happen is
> to fail the attachment not to try to continue it broken?

Inspired by your inputs, I found that pci_prepare_ats() demands in
kdocs:

/**
 * pci_prepare_ats - Setup the PS for ATS
 * @dev: the PCI device
 * @ps: the IOMMU page shift
 *
 * This must be done by the IOMMU driver on the PF before any VFs are created to
 * ensure that the VF can have ATS enabled.

But it returns 0 directly on dev->is_virtfn.

I wonder if this function itself should just fail if dev->is_virtfn
and !pci_physfn(dev)->ats_stu?

Then, arm_smmu_probe_device() must fail if pci_prepare_ats() fails.

Nicolin
