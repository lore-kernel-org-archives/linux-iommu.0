Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC952FFFA3
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544901; cv=fail; b=NfGatR/SfMKk1Qu5cSEImwhEiH3csBi6M4RUXUzDGaFUXmkBhRcKnGE2eKylfiaQYEO0FNj+H/i6snrUi9z3T38knP5/N5NHNpeTrly1n+FvKvoYGvo/apdCr+LvZ0X97t7yAvBWKV7nW0Q0Vhrf81QATL3j1OIcO2fO+FiD19U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544901; c=relaxed/simple;
	bh=L6EEhuvfhanA3jdtUsj39ojCaXJUwZJP/uxrWlIuPL4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD4dN/b5+s3dR09+nXj7rBIhoYtKN8Tgoat5T/FEYTsWQDO1TxeHfrxi/QFq+qsOQ9rWdOZYZQST9ui3wA1MCChbNioSYRZzXeKohoEGkJS5hic/x1zbx40VS5gwMZSOb9HcKDR8aWzqUx2rUCHsuL9TaSelTFpdlirfdqWNrWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=feKaL/+x; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="feKaL/+x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttHZqKf8UXCSOCr4XVh8xOm/rF1fJtwJHIkTTiy1Yu0CvUz1yQEIiGmLI04osXBr5nEsyDlX0rZyR2+eSOOvv2WfsEPSYmokG6UYsM5uciD+cLgLvxVIVgpkFQXQ1p4Vx0c+jZEk+JKjRS+HPH+PneleXcspYEid+Q+qavUF/qQ11L6GA5EmuZcJZago4QGqNq7kl8/6I0zH7tpi5tjTV4jfxcPnOCYfTM0B3Pq5kLSwB2TeqOhgLmoUuEgARKxuiAnTGkoR6vBh9QHlBqnkV1dXGB9uYR8E/k07XFNUgMNIeuyDCSC1lAQox/Kw4S9Rb1VZPP/LNgcE5A51/ZVpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BkOyzxN/fb5SjM4LzDxkKl/5M72Am8y1dYAxRR4eG0=;
 b=IAMvDhq2fXKqaLcv+7IRH8ycMiX0aljSdmFXkin2t1zncYMaWTF7B/52bsZLg4M7iqqwfXvR8wSMqwUfu78kTzk8gQ6yKVEzjoRxamoBGTz6Z4PpXwGBCN3WaXAM009TvvLf3lOfKI6b7KYJQws7k61l9784Zdxok7gdZ42plU3sKq/zkNpzLV8ocKnUcB1a8sZwU13JikHS5CwyAvEcziQ4tSCmOoCJAbnlRH85FEtPwu4T2YBv0OvKZsRqm+boj/gRi+3OAtMUemI+mPzmg2GoBhG5wmLwBVNVdIYz13oA+oBlTOYAZ3zeulX7ITJTaKIX0IJYXjRMb14BoAL7Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BkOyzxN/fb5SjM4LzDxkKl/5M72Am8y1dYAxRR4eG0=;
 b=feKaL/+xvC8lwmxEbkk/5obksIgNEk4bD6M1EErleH9NjzND4Jb8AOi2FCpYc0Ak4QbCTJ1egTOXNqa0PWhhM9mZzhjt8eVluMwsuDa6pac4PeGhBRs3LQBXl7IXyOT7IEr5H2/7NTZmf1nfnfde1jfyGrIwr2RuOSJ6meqxcxzWtrfOKSiyfMQPMD18oVWwnpwq+pN3pvhuXkhSGStWi9ehy6FbtZ1GnX6ccuiPF70gA+t4HBybmLEHytfUvPvykkVVyqNEaIPrhXMTVtFE9sTl6ymhAGR99rsFmPN+IUrcwGrJBGrQTDjxiPbnCPW/8ODXmyQN2LWCiIJwIq9pDw==
Received: from MN0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::21)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 20:14:57 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::7e) by MN0P220CA0028.outlook.office365.com
 (2603:10b6:208:52e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 20:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 20:14:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 12:14:40 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 12:14:39 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 12:14:38 -0800
Date: Tue, 27 Jan 2026 12:14:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, <will@kernel.org>,
	<jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXkcrXQH8pHgE7Ft@Asurada-Nvidia>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXND9YJTwm6om689@google.com>
 <aXjqBy2sWAUMm/aY@Asurada-Nvidia>
 <20260127170837.GM1134360@nvidia.com>
 <aXj+zaLoh/yQmHOH@Asurada-Nvidia>
 <20260127182348.GP1134360@nvidia.com>
 <aXkF+FcsXG928Qfc@Asurada-Nvidia>
 <20260127191938.GR1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260127191938.GR1134360@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: d1309f51-4f16-4577-2bda-08de5de0bdd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0PS+Ok0C/+8m8BOye4VARuQBFWyjFNizNm8ciSUx6VuGWRWvtB/Gz+i15nrc?=
 =?us-ascii?Q?3f0acHZv+QHY01z426KY2RSFj+0cr5fS9EN8DTWadN4qD9ybYAbmLHQQkju+?=
 =?us-ascii?Q?Ro2ffqsL8usHTQ2rKstEL2gT8X4VBLPuTXZbndnOMKPBTEfc3mFaVGwd26xA?=
 =?us-ascii?Q?S4giQTf1bCfM2LhOUMjs2mqq8BQoE8823p3BkdaghkLeH9D5en5uSDLc49Mv?=
 =?us-ascii?Q?O/jXjNujxxXrPmulyCLAWkYbUnlbxzIgNLP606nONg0YdtoPFVo5TIAA+bGy?=
 =?us-ascii?Q?t3On1MRiTV86k6e9Bab9JyDpocjGXpzkcu5jCCEG18ewAOLdEFV0ZNuwkE3f?=
 =?us-ascii?Q?jROLcjkRtXfBw10byFRm68QqwMLagcQWuM7gzKTrQ+A87tEhHpyNpBSd8LgT?=
 =?us-ascii?Q?5rBHquXdt8kjpFOPb63NNzLx1lGerWLn8rkOq+cU0okkyEtw3zzZqQngLTkH?=
 =?us-ascii?Q?YTbTwRCgpu6C4ayPQ+mr0jFZQOt8G1AueeXbrCjs/mShxK504IH+W2CZS+4a?=
 =?us-ascii?Q?WoXE7HPaz9iszF0cuE5ejHUApllyadOM8pt+Ffmd6NcM5ssPzsnmTMespPR7?=
 =?us-ascii?Q?oRD2gJI9CWBRxCWHcusTphVlcQnhsGfW72YJ2URY6s6rGsZCPvum39iHvRJA?=
 =?us-ascii?Q?vbBEp4DM+o3eSsforSL/5WKSPRTRxgOjEm8jVWrfVROO5CbvWjs2pIWO2WJ+?=
 =?us-ascii?Q?uzS+mpqO1NtDQVJ5aMbsB2hXoDvWPeeCpkkNjOqd5wfjf1r5j9OMWY/WBGCr?=
 =?us-ascii?Q?O4i5OLU2OL3Moz3xyk4oirPpLdwo/3eKr/037ssbMtZQ+omJP8qPGt4rMgPu?=
 =?us-ascii?Q?Usn42H0gnNA9b0GLB4g5xp+V4469JqmGQY6j+YP6dG0AvWnXZxsK7gIjD7GM?=
 =?us-ascii?Q?QqVLquECCIHJQWvgKm6dvQTHJaUbzpSoq6QR+OU/J/yB6sbl8GCygQ1NMzUp?=
 =?us-ascii?Q?Hz2vMWR2MdeWJs3+/M+ISDpsEKRCVWvqZxV3SWJadLkFWKgRrYTlk8Z4JJYR?=
 =?us-ascii?Q?MaijV4ssrq8lPCfErf+IFKx0TTxqpdA8Ccd2SlnW0h1nU5EbzQhIvrMECtoH?=
 =?us-ascii?Q?+RCdOpcMMiD/DsAG1C5ayhJVjulZ0nc4K3DteenNCGnesdkKkWvNn5zPg6OG?=
 =?us-ascii?Q?Pm0H6iR6U3Ui+vfXpSfaoB+1Ic0MGB4lguMKhYUSVW6VqOEWqWrlgolMmCLY?=
 =?us-ascii?Q?HRgFc3rQd4jqq9OOQYG/o6fpAyEIYa7F+vgeB8xO3sa0kOrAjEeNLUrC+lwe?=
 =?us-ascii?Q?ppzH7xPTEABYDMZ5AOgfGbKihjMrWfepJgBUrhi+iCbCp021iDvTZA4uZk9M?=
 =?us-ascii?Q?J5TaCYgNCcLCjJ27nRjJcr719t+z4LyN5Pr3TFMWXjA4Dc2ezGW0xyDSlQc/?=
 =?us-ascii?Q?zCaj7iicYNmzaPIHGn9cKigqOr6kgTEqrZXiYYvSifRt9j6Z0VYBkbOvADoT?=
 =?us-ascii?Q?wHtdBPB3VDXQRBkLHhqBDJKb4Jfs+Z3CF/f1pEwzJEKFT79Gv3NHX169N+B9?=
 =?us-ascii?Q?HsnalZ3ilUSYdYduSv0VO0pt+w02Uax5CIdHBAlJOcJqqBqCvF7w2D2hBMcR?=
 =?us-ascii?Q?AWsbMKYly2QbEQw4Je3lRMm788icphKmi1xAOqVrRm8baK+jyXiOitRpmnHd?=
 =?us-ascii?Q?ouocKV+Muy1v+sw/WeBUsc92WMCP1RQ9TLEMTZF251T0jl4nfBO8WcTlYd1c?=
 =?us-ascii?Q?zKfbv81Pnnwn6Vk7QyxYQwy3SxI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 20:14:57.0503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1309f51-4f16-4577-2bda-08de5de0bdd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532

On Tue, Jan 27, 2026 at 03:19:38PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 27, 2026 at 10:37:44AM -0800, Nicolin Chen wrote:
> > On Tue, Jan 27, 2026 at 02:23:48PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Jan 27, 2026 at 10:07:09AM -0800, Nicolin Chen wrote:
> > > > > My understanding has been that this invalidation can run from an IRQ
> > > > > context - we permit the use of the DMA API from an interrupt handler?
> > > > > 
> > > > > I though that for rwsem the read side does not require the _irqsave,
> > > > > even if it is in an irq context, unless the write side runs from an
> > > > > IRQ. 
> > > > 
> > > > Hmm, is "rwsem" a typo? Because it's rwlock_t, which is spinlock :-/
> > > 
> > > Yeah, sorry
> > > 
> > > > > Here the write side always runs from a process context.
> > > > > 
> > > > > So the write side will block the IRQ which ensures we don't spin
> > > > > during read in an IRQ.
> > > > 
> > > > And, does write_lock_irqsave() disable global IRQ or local IRQ only?
> > > > 
> > > > Documentation/locking/locktypes.rst mentions "local_irq_disable()"..
> > > 
> > > It will only disable the local IRQ, since it is a spin type lock an IRQ on
> > > another CPU can spin until it is unlocked.
> > > 
> > > The main issue is if this CPU takes an IRQ while the write side is
> > > locked and spins, then it will never unlock.
> > 
> > Yea, that sounds unsafe. I'll send a v11 with read_lock_irqsave().
> 
> I'm explaining why it is safe now, the write side takes the irqsave so
> the above can't happen.

Sorry, I misunderstood..

> There is no case where the read side needs to block IRQ because if the
> read side succeeds, an IRQ happens and tries to take another read
> side, it will succeed not spin.

Yea, I also went a bit deeper.

It seems to depend on the CONFIG_QUEUED_RWLOCKS (ARM sets =y)

252 config QUEUED_RWLOCKS
253         def_bool y if ARCH_USE_QUEUED_RWLOCKS
254         depends on SMP && !PREEMPT_RT

where a reader will not get blocked in our particular use case:

21 void __lockfunc queued_read_lock_slowpath(struct qrwlock *lock)
22 {
23         /*
24          * Readers come here when they cannot get the lock without waiting
25          */
26         if (unlikely(in_interrupt())) {
27                 /*
28                  * Readers in interrupt context will get the lock immediately
29                  * if the writer is just waiting (not holding the lock yet),
30                  * so spin with ACQUIRE semantics until the lock is available
31                  * without waiting in the queue.
32                  */
33                 atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
34                 return;

And I don't see any non-hackable way for CONFIG_QUEUED_RWLOCKS=n
unless CONFIG_PREEMPT_RT=y, which would be a different ball game
that I assume SMMUv3 might not be completely compatible with.

Thanks
Nicolin
