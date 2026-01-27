Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BCC327C12
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539099; cv=fail; b=M+Bff2l3OHxkPTKIHdtUj31qH9h29zggbMbnLeY3obrjJe5jHJJmdpHRJwk3rAVURJYmUFFLoBKNivzGRT5QZbrW4P2cOugqwN1hpQINlPM3vgrqt3iSPRqc0tNysj6t71tnh6jHCQWL0FEMxlwQUFtvKLuG1CEVoXMIztNFGEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539099; c=relaxed/simple;
	bh=QzHqhII7Pzr3TVyelZen6EPxe3sPZRcxcYbKb7zMWNs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZJ+ZSjDlXgs02pzEmH2SPfIw+yK1eIiDaY7SJ54fDeeBYhI20PZ6PLiU6Id4GhgwK/VYxsSlGrWxdCjGnhCxiDB8Rgefnu9jIYYJCcF5CY9ZWxeQtJltoekJvrb3zpYXPe9b68abxeFL457Lhet89UZjAf3JDlzTqSiXKHNnQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i+BP5U0C; arc=fail smtp.client-ip=52.101.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i+BP5U0C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNYAq1QaHvCm4rEoIndtlnVGCZW8WY8slAExxAjMGTiY2DzF0K1XfHAv8D/HPPOL0gAAJhjQLm8T/JYvcbQWpmQsIudIrlHDMaFgxv3vMeurp/BoIlVND6JCP1TDD/G4yqp7aAmZDOAjXJNHDHbaoMHpL0EDxQEauM93ld2HG9fzzD5qnnTb/KtmNpUWSpoUV6+EzK5v/HzmDeVfy4SuUn/FPQxrV7KRWHEcAsiglltR6mkGKfboxadZJmedsOhXmUp3v5U6dbI1nTgQBmap2XQzguo17aZ3VnfmyeB4RopBWe/Btv6FubzAKnkHJ7rcOZuEQImYzWxJ62ckiuWVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wY3sFJgBDyhAFVCLgGJZhKmsnZsOY3uxMTmBMT7jw4=;
 b=sNb9ErXNv2vHQpsHkz2GLRlPt/f6foyaajL1/bH5mhYy/uIcbSW1Txo9KK8Uft09p7PicKXc+2o2Aq1B9/jd6R1ZpyOTnCqn1gEQox5my/8RhEFISIARTEskuQ/moKFU9dOyOKZja7/UA6qk7jG43xooS2bczRoZcA+lJ6gKlJfEsysvbV+0tT2A/LHKhh/Q+t+yASCGcQ2gFqdA4n0ywGiDCR39ju0JZZt636LflPTzsBygNRcMTM9hmVVX0Qs4yWXaDN3I0d0K3CEVD1lD6f4Wu6IUUCrMBHfy5L51sb2Jl10hNmKEKis5jpZ88J0hnyLD7/bwCNOtnrq1s3eQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wY3sFJgBDyhAFVCLgGJZhKmsnZsOY3uxMTmBMT7jw4=;
 b=i+BP5U0CN5C15Bdom4lyCqC7qRledbaG3Nn0HVK9zzxJjbuLfyaoJzx75cE3SyZsZGqwES9v+ueSsw6Amb0rN6CsJ41NrIEs1azO/4Kptcb71iwajNpbf62kGvPUF7rph9BixeZ6qBKl1BKFM0E/C4hisEtKWFX4E0QetniUtCD3xjKGuw5pcBgb6TEH+8gDsnHgyXv0ZIWQ+WmHi4kFk4vmAURuea5r1Y2Kwosax0IoTbymN5sztpAfKMW4atEEOE7252i26wcayTzGpIED2mRQUxe4oWlaEvgHFwEYISn+p0C3An3Pw5iDYRIMwbspJOGjb9CWD4CQvSP1o46hxA==
Received: from BN0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:408:ec::20)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:38:13 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::a5) by BN0PR04CA0105.outlook.office365.com
 (2603:10b6:408:ec::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 18:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:38:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:37:47 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:37:46 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 10:37:45 -0800
Date: Tue, 27 Jan 2026 10:37:44 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, <will@kernel.org>,
	<jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXkF+FcsXG928Qfc@Asurada-Nvidia>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXND9YJTwm6om689@google.com>
 <aXjqBy2sWAUMm/aY@Asurada-Nvidia>
 <20260127170837.GM1134360@nvidia.com>
 <aXj+zaLoh/yQmHOH@Asurada-Nvidia>
 <20260127182348.GP1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260127182348.GP1134360@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2439e2-8b27-4890-dd32-08de5dd339fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iHaK54AGD2cABX2yuSuY/9gw6U78ZCUweZvzMXlQSlghJuDcg6ihfsXHAtG5?=
 =?us-ascii?Q?VfN5t2S7xhM2roWozzR+MBKLu8r1oeTot8b14Jqsp3lvRM7EEpwk01aYUCDD?=
 =?us-ascii?Q?KlSJa7xw8w/JM9hUyTeTjUp5GhluPx6ub5eboFmls5tL7Wla6jE6CVQsbNJ1?=
 =?us-ascii?Q?co69fKUpOf56IbJseVJHLVhq3pykk96oOfPVvo8TMDeEMVPrHMoVBtfm/7AL?=
 =?us-ascii?Q?J0L5Dim1tq9AxLpdl7wwOFWYT7cvR67Ux674TgYYWw0jRculQVjdpREcOLuQ?=
 =?us-ascii?Q?qdG5q4uItJ1pJl+kyQJvcwM92Oe1t0sUcyUYScyRJeVTwv3Es99vqkyvbd/x?=
 =?us-ascii?Q?bLWP0+84ifW6Ml67bVGFidrRbBsu7Fblz/ZiuXca7DZQZF79FQmeGlCDOzDQ?=
 =?us-ascii?Q?0Pnz345sa2jKHAwY73EXCSlUA7ofafYEbm8VWC4CYssbmGgAAke0qKvFTcdu?=
 =?us-ascii?Q?W3H3d3vvwBH/8KcPOafnqhejQXBV/Cg6KCCSRfjdx8YORtrZ+luMT92cFzqs?=
 =?us-ascii?Q?s/0RyM9eGLSKoksUECgcNDFA0Bjn92dC/px1VhgSYujHd66n/lk0aRVfw7jW?=
 =?us-ascii?Q?RO8qVFLBK5L3owAeip9XL23cgskyiBWVKigjxABVDhhynZyeLywojBS4abWw?=
 =?us-ascii?Q?3Ij/kFVYkw36HZJ7o0ax3zSM6rOp0W5gaSCri1QX2dzmr/LQgnNS6RSweASY?=
 =?us-ascii?Q?1FJa+zbuZblSm65ikNCRD8AA3IMlBDXWrVw5Kx9kKH0YlXMd0IVx7aoQU4N8?=
 =?us-ascii?Q?xTrID4nfQOmAfmd3IC1VfmUSTwavT3Ntkt0U8eo6RNts4R4pXr01235SDS6S?=
 =?us-ascii?Q?Xxc1RH93YSp2EHvywW6o+0nz2Nvm1n7OpE1/kzHLfAxI+KnirvwClR7VFjNY?=
 =?us-ascii?Q?HeENaJhsUMd/KmrVATG5naO5WBPiczfxc5POoSGG7aQyriylsClrr+X3IHh1?=
 =?us-ascii?Q?nlUY4hOl9bhmBXK8FzeGeFGfpBxrxxYppPFE1QHR2m9QMjqajAm3bduhKj0t?=
 =?us-ascii?Q?sgh/TihRg1bol2IcV3NnQ0Y5cZTj1FB822mTEX8m99uqfVVVzAiqpkLHZ46D?=
 =?us-ascii?Q?buvIbrZmkYS0Zb8VeyXaxZlPCsxnMKjnjdo5EmoIorxj83jSgmERmngsr+xX?=
 =?us-ascii?Q?TLrbvqK4xk5r6rKu1VBlj6kTitkpeLVFeUWTvePzvOLXEqf2zWjwzBtXayyC?=
 =?us-ascii?Q?QhuiYUgA9UT7MxsJhxeqkuYgchq4o2Y5pD5ZHsnM/6RFZiEqbXKFL7a2rty7?=
 =?us-ascii?Q?OKj6Sq+nxHQq2XZ5buqt6pnM6U1H3URQCFMMgSKqQPeXKgDcqeKQ1ZiPmz6j?=
 =?us-ascii?Q?OuxRkXjx0nPjAYvY9FoGZTufKZDKKcg2Ty6KOL5xb96CCxZy7NAuEd8lq7Rs?=
 =?us-ascii?Q?GkfrwK0dIo5GMmD4Cq4pDa5Xokk+sYLOIeAyzWUKGkLeWq482dDatEg/i0ie?=
 =?us-ascii?Q?R1zYGZFkIHSCUeSvXtR5uBH9JXFWDq9ix5KUX8q8A9OUwdAXjYfQUYhh4IwU?=
 =?us-ascii?Q?ZiD8WyHa+zpRKbARar1JeiNsW3ybqCO659XR2q+XNCWXHwsPh3PvDHH+8qEP?=
 =?us-ascii?Q?UMuutBwpk44eKZ7zFHoIXCWk0r4xLHABqKyY4MUF1JM8FHrluKV1Ydri+IRt?=
 =?us-ascii?Q?KGhX4f9MJUwtiIWiQXjaH98+FucAxqdJ09ZkLvr4H6Fmbzb2p5xf0dHMoflP?=
 =?us-ascii?Q?DP52Qch/tNW3HSEiMdDSnta9zAY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:38:12.3709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2439e2-8b27-4890-dd32-08de5dd339fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459

On Tue, Jan 27, 2026 at 02:23:48PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 27, 2026 at 10:07:09AM -0800, Nicolin Chen wrote:
> > > My understanding has been that this invalidation can run from an IRQ
> > > context - we permit the use of the DMA API from an interrupt handler?
> > > 
> > > I though that for rwsem the read side does not require the _irqsave,
> > > even if it is in an irq context, unless the write side runs from an
> > > IRQ. 
> > 
> > Hmm, is "rwsem" a typo? Because it's rwlock_t, which is spinlock :-/
> 
> Yeah, sorry
> 
> > > Here the write side always runs from a process context.
> > > 
> > > So the write side will block the IRQ which ensures we don't spin
> > > during read in an IRQ.
> > 
> > And, does write_lock_irqsave() disable global IRQ or local IRQ only?
> > 
> > Documentation/locking/locktypes.rst mentions "local_irq_disable()"..
> 
> It will only disable the local IRQ, since it is a spin type lock an IRQ on
> another CPU can spin until it is unlocked.
> 
> The main issue is if this CPU takes an IRQ while the write side is
> locked and spins, then it will never unlock.

Yea, that sounds unsafe. I'll send a v11 with read_lock_irqsave().

We can also pass in iommu_domain to arm_smmu_attach_prepare_invs()
that you pointed out in the followup series.

Thanks!
Nicolin
