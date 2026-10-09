Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093B3D669A
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535546; cv=fail; b=H5eD/QHwz5/pcEnjFYpcdd6Kie7TdCFPnKuqoES26BZ2DJiglCJl4pFDuEXUpdK3VlfDqvuNoQxwp6omvwFjWKZ7bZMBtQDAilvZYPbHin8KwoddnJRsxOvN8SAssYqnJx9jETHSs6JAF1e7E3wAS5dI5w50CcJPGYuLdYoJrP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535546; c=relaxed/simple;
	bh=nHNta5e9VpZOiGivzC01lAZnEMeuLrrc84vbJ9RpC/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoKZU9Hfmjoi6bpeZdvanNxVaa69JYEotFck1kGaZttcKXUn4AvuuJ13wYgeGmz2D1oK8iCRijfSb5K1KPle8ZwuUuT9+IQqSCg80ksMjxMbwBAlAkRMBgz/7DvgEeDWoMEv1qT17rzqqnD2XsJTluoq6fkZZzUt6P7TlocpMR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yJAp0iYy reason="signature verification failed"; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yJAp0iYy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIpy4kNx1Q+Qb1/BlR4cdSKFSR9RapNONnu4Ro9ZxtYVM5zFRoDpeotKtbjmZuD/u07cTDHKJB6VBPggp+bOqUR/rOzuJkBWovCkqQ4t1+masG3gGUITs4OpzY+GTlFLUoAPSbz+AggH4XK4L9U2GgTVQrJZuoRbHjttKRUXeM6OV8gbbIWpqw9XffYa/NMSNhXAPmzOfPTlJp6C4MnGRx6PWP0J5rrpdMjcsIf0u4J4oJ+LWk6K5wuJUan93mX/VXWudnoxpAxbyL+9t/+oM36OK9WDja9bvL8lHldVkB+LglJfGlxGjM2l52G6EhyGRHxDsSkrezUvLJ9lk4SyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEDZZmGEAkrUqIMkP/5M35srJzyIy2g+lh9zMllMYb8=;
 b=FwSrEKc+E5QXzVJuobw+68cjnMwTjKvShXsCDgSfTr4J35wo5S3NRso77r6RvJGtj8fFXTPy1NpKQ94qj/u+3CGk9Xv3lkQm/agsi5x2SNUlSfWiFslGhOcpxrn6HIWfF4sJfzveqkHGQ+hFB+/q9g6ztbNLzgpNX9uRbqCcpYF2CPL4IwFNfA2VF4maVJDGoXNcgFtvfHWRyK3rlxMLs4UYpBJo40BUAiHulTdP+hCGulbVTBeYPVZHEM48vsGmX/Lto61X9ZfA5Mm6bLuNfAWmWWUzD1AsClIkOSNhog5oQfKaJFDfageHVh2GsVylrYuoojikE4YFmz5GAQ0FSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEDZZmGEAkrUqIMkP/5M35srJzyIy2g+lh9zMllMYb8=;
 b=yJAp0iYy1XzfjuSxtl8wBrsea9DPKP9ZW7Z2rZaMlSSe2HSbRRBy6grvt5EYCqaoabr6LBGZ1VJ7gTRnVcOGZNA6LdlyRwX2w7sLyt2lX2y9uOVcRpmNut+VG4q6YWOpBtN325pTPagHap+WI12rc62Vs/CcknyjRan3mH3hpMM=
Received: from CH2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:610:4c::26)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 9 Oct
 2026 08:45:38 +0000
Received: from LV8PEPF0000005A.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::74) by CH2PR10CA0016.outlook.office365.com
 (2603:10b6:610:4c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 08:45:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000005A.mail.protection.outlook.com (10.167.245.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Fri, 9 Oct 2026 08:45:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 03:45:33 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 03:45:29 -0500
Date: Fri, 9 Oct 2026 08:45:29 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Rik van Riel
	<riel@surriel.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>, <liam@infradead.org>,
	<maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
	<ashok.raj@oss.qualcomm.com>, <jgg@ziepe.ca>, <kyle@mcmartin.ca>
Subject: Re: [PATCH v5 0/3] iommu/iova: convert from rbtree to maple tree
Message-ID: <mcki6p5d6u7ofhiucoz6vi3jdldzmc7yv7n3ppoiwdjbwuriji@e2ezt37ga6i7>
References: <20260818152505.1057922-1-riel@surriel.com>
 <arUZwesREX05SZ0J@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arUZwesREX05SZ0J@8bytes.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005A:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 34581e92-94de-4ef0-81fd-08df25e1b17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|7416014|18002099003|22082099003|56012099006|4143699003|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	m8I8gh1igZVoR9Cr4T2fqwG6D76WUii+rE7+b1667WRI8POnHaMUfja86J+s0/ld63rNUdriIapR6+HTGsEy5j3/CwQTfSIqG1KysHQWVJzaoiJkFwo/9GuQMAwiig2VXuJZLgqnLtDnwHSrc9/sSRxb4EzWogihFCRzS32NlgpiNYcSDk2izjJlaknOYrWbzyXITmsxJg/rzm3IlBQZRkAwdGmepl9f+3PdJNyf6mpCYE5RT/HtRioAxq9gBCrt+zh1wiiU8Isms6KNbjuCQo+/cUGDx35dBXzjdaU2WvO4XVU8YUY6OUpT9cVswDJf31oGzlbOi1XxWVGOVkwh24gZEl/fsrQzpQhesKqFLEkHcMM9m6LyPM2tvpq+Wr9z2YPUfa/k00YWodsNLw7bibx1/1UsynZXjjtBShermgw5FQwADRzriirGv9tyJJ4tvVNaMkwfqjPD2Lnl6UYkMeFjTUjSv7+vo/93+EYqTZX7sloNU48vwWMrwlO2/UX4zbEI8kRdwUMxoBPPy9EhewpzduLgvprRHbw49GNhx/fr+XP/kqmcRGrJ46kZXpyHNSC7Fj9zl7IL4pVG4oz8aDfAOJYQ+ela9/huWbR4TPinSssVSohxg5KJ6m7nDQk+pE6CoB275hoRsocIO0Len+U5aS4HrHTvQ27nomiJHOGg3tEIhdobQENLXnQsGFMic4a6stPXTrkR963d6E8JCg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(7416014)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	trPC7N5tb80dn6n7hNF4degu86iyb3+mA9+YeOFZeUWgJ6R85tfTcxDq7IOdlfH6qHbY0esppLMTuDE8X5tPXAmYJHCfRpXzRSkOOycjDboTKoFibQe6pNeA6RcG2/q8qX0Y4eAZDkccn3FIHIvYIfn1gum0ER0DCUR4s+1J7rI4P1+1SMG/Eii4i5FmsB9X++m5nI0R4+a1odA9B5IyriGY8tBNfxiFd2Oe+jCNZMsUO0EIGyWrPN4U7RBMUI4iWy8UKRD+ilylBOHYBBpcqMyXALp6qpAV51l/9kfwRmgKht8I9niqYA8p8zCtiOsCltAMHGD8PLGX89c5KP9ce4RI9c0aRoqFVKAzrzMHdAmduBH2j0eDNWZjL95HOdLGSjtcjNq1x4VmzaHxdps8ddLGnQEMoQB9G0zggxvtb/aQ1GrglKXI8h5jjSv5t5vT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 08:45:38.4933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34581e92-94de-4ef0-81fd-08df25e1b17a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

On Thu, Sep 24, 2026 at 02:52:45PM +0200, Jörg Rödel wrote:
> Hi Rik,
> 
> On Tue, Aug 18, 2026 at 11:25:00AM -0400, Rik van Riel wrote:
> > Occasionally production workloads at Meta run into the linear search in
> > alloc_iova() in ways that cause real issues. For example, when enough
> > CPUs at a time fall into the linear search trap, systems have been known
> > to get stuck for so long that it causes soft lockups.
> > 
> > This series indexes the iova ranges in a maple tree instead. Its gap
> > search makes alloc_iova() O(log n).
> 
> Thanks for working on this, I really love the idea and more efficient
> allocation complexity. For long-term maintainability a few things need to be
> sorted out, though.
> 
> First, I will ask AMDs IOMMU driver team to do some performance and regression
> tests with this series.
> 
> > struct iova loses its rb_node and shrinks from 40 to 16 bytes.
> > The maple tree keeps its nodes outside the entries, so total memory
> > use ends up about the same as before.
> > 
> > Patch 2 handles the one thing the maple tree does that an rbtree does
> > not: erasing an entry can result in the need to rebalance a tree, and
> > allocation of maple tree nodes.
> > 
> > iovas are freed from atomic context, and GFP_ATOMIC allocations mean
> > the erase can fail. When it does, the entry is marked IOVA_DEFERRED
> > in place and the struct iova is freed. The marker keeps the range
> > reserved until iova_drain_deferred() retries the erase.
> > 
> > Ashok Raj asked on v4 whether the marker store can fail in turn, since
> > the WARN_ON_ONCE there reads like error handling for a case the comment
> > claims cannot happen.
> > 
> > Code examination shows that, with the current maple tree code, the
> > IOVA_DEFERRED maple tree store will never result in an allocation,
> > and cannot fail. This series adds a test case which allows us to verify
> > that maple tree property continues to be true.
> > 
> > Only a corrupted tree, one no longer holding the iova at its own range,
> > can reach a store type that allocates. The WARN_ON_ONCE is more of an
> > assertion than a recovery path.
> 
> This is a lot for the interface contract between the IOVA code and the Maple
> tree. We need a way to test and enforce that the maple tree implementation
> adheres to the requirements of the IOMMU code going forward. You mention that
> there is a test included, not sure if it covers all expectations this code has
> (especially when the expectations are different from the ones in core MM code).
> 
> The last thing we want is regressions in one of the IOMMU-layers core
> componentents because of changes to core MM code.
> 
> 
> -Joerg

Hi Rik and Joerg,

I tested this series on two AMD EPYC systems with real NVMe devices
through the AMD IOMMU driver. Base is v7.2-rc7-104 (ad8d485e6658),
patched is base plus your three patches. I booted base twice on each
system to get a noise floor. The first table pools both boots; the later
two show the first boot, and I only call a difference real where the
second boot agreed.

  system 1: EPYC 9996, 2 sockets, 1024 CPUs, 4 NUMA nodes,  1 NVMe
  system 2: EPYC 9965, 2 sockets,  512 CPUs, 2 NUMA nodes, 12 NVMe

Tests

  1. dma_map_benchmark, the upstream selftest, varying thread count
  2. a depth sweep, varying tree depth on its own at 16 threads
  3. memory at scale, 12 NVMes holding 12.58M live IOVAs
  4. fio across the 12 NVMes
  
1. dma_map_benchmark

It reaches alloc_iova() as long as the granule is above the 128 KiB that
the per-CPU IOVA cache serves. At granule 64 pages the live set is one
mapping per thread, so the thread count is also the tree depth. Strict
mode, min-max over all runs, EPYC 9996:

  threads    base             patched
  1          0.2 us           0.4-0.5 us
  16         0.8-2.0 us       1.4-3.4 us
  128        1.8-226 us       1.7-18.6 us
  512        1,772-2,926 us   4-1,387 us
  1,024      5,532-7,431 us   2,480-2,954 us

At one thread the maple tree costs about 2x, and the ranges do not
overlap, so that cost is real. At 512 and 1,024 threads they do not
overlap the other way and the series is 2-3x faster. In between they
overlap and I would not call either kernel ahead.

2. Depth sweep

dma_map_benchmark unmaps immediately, so the only way it grows the tree
is by adding threads, which also adds lock contention. To vary depth on
its own I used a small driver: real dma_map_single() on an NVMe, N live
mappings per thread, replacing one at random each iteration so the tree
stays N deep and fragmented. Fixed at 16 threads, strict mode:

  live IOVAs      EPYC 9996            EPYC 9965
  in the tree     base     patched     base      patched
  16              1.39 us  1.13 us       930 ns   777 ns
  1,024           94.5 us  19.1 us      58.6 us   14.8 us
  8,192            206 us  31.1 us       132 us   20.7 us
  65,536          1.95 ms  34.8 us      1.25 ms   26.5 us
  524,288         17.6 ms  42.0 us      15.6 ms   28.7 us
  1,048,576       66.9 ms  47.7 us      99.8 ms   33.7 us

The live set grows 65,536x down that table; base grows 48,000x with it,
the series 40x. Tearing the full set back down takes the same time on
both kernels, 3.42 s against 3.42 s on system 2 and 5.4 s against 5.2 s
on system 1. That phase is hardware invalidation, so the gap above is
tree time and not device time.

In lazy mode the series is slower to build a tree from empty, on both
systems: at 16 live IOVAs 26 us against 54 us on system 1, and 15 us
against 27 us on system 2. It is still slower at 1,024 live on both, and
at 8,192 live on system 1. Base itself varies a lot in lazy mode, so I
cannot give a clean size where the cost ends.

3. Memory at scale

One device cannot hold enough live IOVAs to clear the noise, so this is
the 12-NVMe system: twelve independent trees of 1,048,576 entries,
12,582,912 live in total, no allocation failures. Peak slab, three runs:

  live IOVAs    base          patched
  98,304        1007-1011 MB   982-1082 MB
  786,432       1053-1055 MB  1045-1070 MB
  12,582,912    1861-1864 MB  1610-1622 MB

On the first two rows the run-to-run spread is as large as any gap
between the kernels, so I draw no conclusion there, which matches what
your cover letter says. The last is clear of it: patched is 239-254 MB
lower, 72 bytes per live IOVA against 48. The gain is capped by the
maple nodes, 1.47M of 256 bytes at 12.58M live.

4. fio

No change in IOPS, bandwidth or any latency percentile, in either mode.
Block I/O cannot reach this allocator: NVMe clamps its transfer size to
dma_opt_mapping_size(), 128 KiB here, which is exactly the largest size
the per-CPU IOVA cache serves. A kprobe counted 805 of 12,367,841 maps
getting as far as alloc_iova().

Summary:

alloc_iova() is O(log n) in practice, on two CPUs and by two independent
tools. The series costs about 2x on a near-empty tree and wins by orders
of magnitude on a deep one, which is the trade you describe. Memory is
the same within noise below 786k live IOVAs and a third less at 12.58M. 
The costs are confined to microbenchmarks on near-empty trees, No regression
in any real workload.

Tested-by: Ankit Soni <Ankit.Soni@amd.com>

Thanks,
Ankit


