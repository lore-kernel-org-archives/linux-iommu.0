Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891D7324B2D
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537262; cv=fail; b=Q2vs0GEkC+Tp5iUlsf0iwF2TUv6OHdPNaphaAlAXKjUrc2VFbfHTMzzF3tLCXAvwIF0AGBY+aheZ8O6q5Etzg3CcpgqtgGJrwDpzXzPKVJZBg6RoeBw11z/2pqgPoNSQQryTuXd+LzcfGZHL5Gc3VmJsHL8xvQRsuFinXdBniDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537262; c=relaxed/simple;
	bh=obFBVyfeF1i8XOZHqqrsWDTFUWlgcYNE+7ptORm0chY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gI2KvCUB2sMOxZ+bKOZJ80Nwjz0AtatJa8TDHCwtOl1XB8tWEdyw9YmvnEpgV14a5qc9XlYqy7IgdACvFrp6V9f2hkCFuf6irfrW9BJDuvOoxwpGJ31qe9/gTDY1A+QLHBTA5Hm9bvNuICAQihW1FEic6858sQCB/fKkYFfQC/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r6EeZv82; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r6EeZv82"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHfYWEpfW0y8GZxFgBayZCupR/XDxXPV7iB0w1ufpP3cRGTBG+QfTlxsT3bJsEWsQCygdYLWI7X6TXlxxiWjNogdfUMbLblRtLIPZpHjiqSaiaGWSMHulcqENYABM923m5EvC1XJSHHIi5w6WfdogMQtr0/C9imMj9OXCt3f3x8yw7spKMRugH0HFfkpRfYaLtXhv3GRFRapTxoNCQhQMIGMwAmEKwcuijKv5Pvemn3OVqWSqFrz/IGLH7kdiAH2sLk6ih6wbTtiK82ymeuUUVJMpadVF+66Tee8MnZwkGYVstGsN0JGfrwkPtV7zkKBIKbAOZXLd5whQXdPH6bYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrYILHpG+VuXKRxTs24H68y5ORZ28/6vnQoUqj/BMXk=;
 b=okd/RzYdx583EJo/HyxRCJdBf6LCXzSU4W/Svg1d/TQEEIcaCHhLQOSTz9LR47hjPr1igr+kYhLwc5+I1Vno8NLR/WlE3hGcAAStwoQwY4g+o9gpv3IjGfohflT6Z4o2ya5y2tUzkTCFZFtMSBzAElcdEk+0cqfkqwtBo3QoG5NL0+GuqR+ipz26e2ry3G1OtaoVJf97AQ4DCBBXw9++bh/vG31SiP5B6iy6OmBUxNxBfhIfTK7jFLqO1x2WLLHEExpAirnlpb09Y1VBnp8rfZcQsC7xT95Rc7JO4UuWNYaZZXvOB2Q7dwt8AFYy3zR6yOzEKlSuCpSclWIrkPPEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrYILHpG+VuXKRxTs24H68y5ORZ28/6vnQoUqj/BMXk=;
 b=r6EeZv82nQwbMZ+44O6xduTtbbOyD7D+ws83mPPt3WmOnqeaYmYFoPZhgJZqi+HinzK2L+EulmRGfWQsWtA1UUL4rvBIiODUWK9PTI+eud5ywK68GvTzFZvkhgdRQ4bBhAc/dpKWiXY2AfCw5BxclHf4cdIaup9c4vEokZg1Ddz5XNW7Hk2OcRCLBv68U6QiOO5lAZHOrtxsX0n7l/ZVnO35QFXZmCAS6W3SllJzO17FBE7dN5XKyjNt+DSQDoiahjoK+US81IxQVbPtb4kg9nttXYnEPodWNzIXoiyaP5TuKUM//xSY8+iLB/bWX85YKegKLw3O9Cv7vaiI3k/8nA==
Received: from SJ2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:a03:505::14)
 by DS4PR12MB9746.namprd12.prod.outlook.com (2603:10b6:8:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 18:07:37 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::66) by SJ2PR07CA0024.outlook.office365.com
 (2603:10b6:a03:505::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 18:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:07:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:07:11 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:07:11 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 10:07:10 -0800
Date: Tue, 27 Jan 2026 10:07:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, <will@kernel.org>,
	<jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXj+zaLoh/yQmHOH@Asurada-Nvidia>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXND9YJTwm6om689@google.com>
 <aXjqBy2sWAUMm/aY@Asurada-Nvidia>
 <20260127170837.GM1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260127170837.GM1134360@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DS4PR12MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9d55c0-5315-4007-755b-08de5dcef408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lZl4781RGRFDoSsKT4mVgbGJiGDXSCNIY33KzqoCD4+G+qqhQC/6yoG9zG/F?=
 =?us-ascii?Q?kL/XzqmoQsfCceUnGJs+K41zD2Fg07cjV4H9yV1FpzhIIrQ7m/w0x3QazGTE?=
 =?us-ascii?Q?kMBGFj3yBOh0VKLLeer4dWqryocBNgpBf42cmJMdoSOLm+gbi+OEPgPDWFvc?=
 =?us-ascii?Q?U7SEjTMQTNA7ia7VUb3rhiIbCj1mn+sp9MHWy2A/NX5ilpiQMxEdgmE+0qjM?=
 =?us-ascii?Q?TDGvreuU1Cf4kJW+ppkcSwPK9oSh7P+ll0d3fTpGx3X1cUDyAfHztjouua3T?=
 =?us-ascii?Q?JI07FXufwEDDeUUpoJNYx37LvMHWuwjaKE76FtQk+zGSWZ6alMtw5S9g8q2C?=
 =?us-ascii?Q?/mraDfRNPWFFk5rcqtPZmQo5my9VfZ2Eql2QTtZX4vNFkYhCAAGjlXvLXeQN?=
 =?us-ascii?Q?/Nu6aNd/pF5opnHvb0zR2Chi1p3DQSkRXWaeDSSb76I+ykmLcd/pZ1r9HVDB?=
 =?us-ascii?Q?jXqaKOABjqTTqiwciJRXXnVyFe6Xac7eMfeVRT0zD69CK1N7Iaw7yhLsihxj?=
 =?us-ascii?Q?nT6Stu/9gvNhNo/4DUqmWBYA1cztMY8sr4eVR7D5/ef0DhOO98+wcSSmxdDu?=
 =?us-ascii?Q?BiwCZ1SNzABTqjMM9HNAyvvXC26iZ80F4+pbr73bnQ+UrvqbeScjSCQ1ZcHc?=
 =?us-ascii?Q?1lHPTuutbBOfo6zGDiqMIlW5+g2JMGywH3gZ97OKXYIUqFhu8R+7xB6eYjJ2?=
 =?us-ascii?Q?Wcd9pjbD0mCDrp6ofqsq/xQ/gg6FwVeg0cOuIxHu5ed/jvNkVGQT2/+T/M5Z?=
 =?us-ascii?Q?AhscO1s7n3+2KubgPU8VDvh1gmGNfxTRe/8bnqgGJ2jA6m0fnfA6Pz3oiG3a?=
 =?us-ascii?Q?5h6TCI8M1fQ0VsWVP+2HX/WVh6T0HPhk5v7CSyqNd9XfajFuAEbQtUE3cI8s?=
 =?us-ascii?Q?AILYFAUPaFEccc9aFCcNkFzrHI4kjMuxWubj1qAarYSEo/qaaLR3rDsJPduj?=
 =?us-ascii?Q?dU8cyYm7VnKZAtsp3j9c0XKdpn+dI6mHbqRR6qfN6c+HZgTECvJSJSLl6Y4P?=
 =?us-ascii?Q?v9Wd0WNNDIy0dKjeJH20sA4+QdTE7JkZI2Ckgx7PmDtV1r9XEz2Ylo73bOSU?=
 =?us-ascii?Q?TpyyI4BfVUM842C/aPAdwRFIySnxCjBpleqPT+Jc0/elaT9TB2hBjom6FZwo?=
 =?us-ascii?Q?ALdV2BgOkxPyljqdT1l/urbESf6+FBu4INn1+00HlKSVfD32XjSqPdNGyHTC?=
 =?us-ascii?Q?rYtc4DcnD0UbL1L3/MnQ1now4yVJyqoO1o/hP59c56zcXpy2of3ZyI8bCpq7?=
 =?us-ascii?Q?ynuSo9WZjNq0a8OvwtFaTxkeNfBZnwSJZU7weAl+SgrJrYaAkUax/d8GwSNY?=
 =?us-ascii?Q?t9Qn0Wr21o3vjc2yyi4k/Ug60UOw+BPkVTbKmR5S44pYl4sa6ymaVxcZPTPj?=
 =?us-ascii?Q?PjhO2vC5LhABAl7z7BQOvzdhPG0pX+oOHlZhLQj2NlmC2eNddiHwQBB8oeyf?=
 =?us-ascii?Q?AlIENuxbR1BZIrpMD4c3E4JJndTCycT5JzF4qdL9k9YybJ3jgqCbTHaxa2+0?=
 =?us-ascii?Q?xgFwdlMQ1Iz48ANMDimOZmH9x38lNx/Bb598ad3jbphRCk8Z6FPYp06DluqN?=
 =?us-ascii?Q?+B8ymCPHY/Jmt+uVQZGJyRIGLRtBXJBRvMIDQ177s5xo+5Fjj5xLoLJHB3q3?=
 =?us-ascii?Q?QqazsM5ne0krAmcHCY5pDBvT2lgWBn1Lx7eLMP8c1zV17cbc1bIIbbIAVjZp?=
 =?us-ascii?Q?EZHsMkwTMegKpRqb3aijFidmJfE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:07:37.0730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9d55c0-5315-4007-755b-08de5dcef408
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9746

On Tue, Jan 27, 2026 at 01:08:37PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 27, 2026 at 08:38:31AM -0800, Nicolin Chen wrote:
> > Hi Pranjal,
> > 
> > Sorry, I missed this!
> > 
> > On Fri, Jan 23, 2026 at 09:48:37AM +0000, Pranjal Shrivastava wrote:
> > > On Fri, Dec 19, 2025 at 12:11:28PM -0800, Nicolin Chen wrote:
> > > > +	/*
> > > > +	 * Avoid locking unless ATS is being used. No ATC invalidation can be
> > > > +	 * going on after a domain is detached.
> > > > +	 */
> > > > +	if (invs->has_ats) {
> > > > +		read_lock(&invs->rwlock);
> > > 
> > > Shouldn't these be read_lock_irqsave for all rwlock variants here? 
> > > Invalidations might happen in IRQ context as well..
> > > 
> > > > +		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
> > > > +		read_unlock(&invs->rwlock);
> > 
> > It was kept from the older versions where we had a trylock. Jason
> > had an insight about this, mainly for less latency on invalidation
> > threads.
> > 
> > Yet, now we have a plain locking. TBH, I can't find a good reason
> > justifying this. And it does look a bit unsafe to me. So, I think
> > I will just change to the _irqsave version. (Jason?)
> 
> My understanding has been that this invalidation can run from an IRQ
> context - we permit the use of the DMA API from an interrupt handler?
> 
> I though that for rwsem the read side does not require the _irqsave,
> even if it is in an irq context, unless the write side runs from an
> IRQ. 

Hmm, is "rwsem" a typo? Because it's rwlock_t, which is spinlock :-/

> Here the write side always runs from a process context.
> 
> So the write side will block the IRQ which ensures we don't spin
> during read in an IRQ.

And, does write_lock_irqsave() disable global IRQ or local IRQ only?

Documentation/locking/locktypes.rst mentions "local_irq_disable()"..

Thanks
Nicolin
