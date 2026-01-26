Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D232D661C
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443787; cv=fail; b=nD0J1vpEQcJDGiapUFu3qfuUBZJmb7rdyLUQRBhFaQLFhyAO1K7AeDlVTnqkWbdg9kJUWExnXoqhpCRL7u9uK5ZvnYKbwq9olaKQCkqf+76TmMBjEknVgul9+yfSZI/utNKWgsbSAAgoyPLqDLH562RPEd8+Ijq93ElQfGLZz9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443787; c=relaxed/simple;
	bh=krslxPgmaNoOAXzclyG3TH1LObWvwlHSF1FRtSJezcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GL8PqX2lIT4puu1pRoiQToVy3yjRnsJ52sDwcI4n/qhoEu2y2R4JOVjtZkxaE5H76W4L/WShyFrQBoqZkPiifxikKu0sZZn+MA5mAW14Sh08u41Dk/hBpBAPTh/RvLFM4rutAQuWEA/N/npc7A+KJRN7uPuhgE8Ytt/R1pD96ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lVfcjKkC; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lVfcjKkC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6M3Qajd0awegL7WLQxbcUIzuxtGv3aqAUdRXpuHhXuo8JHkAnW05D4mj0Yf7cNDHFpQeSBooZAFAwmPhKmwr+KzVab+LaRlHqebN7bLKEmlWiUE3JdAZcypJJnAJOpEbMfl0wxIMW1DRzoe7uTMF177qNiuP6lXQLbGbGyVpJPJJBh5zdUbfSID/9P7I/P1KIEf9J14mnPhpb7QEYAMNM3/xmMJnekDhhu8B5SKjKwWj59oVyynZWsnNd4fwmXP8GcsMGP1B5OrQMNv7MkwVHGXK9v2+1J++TgwyBHVvmk3MrgxtbDFlMEvdviF/OIKLLpXKP85d59Hz3m0UV8rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EpfkrHtwJuurVNeguIr2cRaxJl90ssW2wsI4ZVtlgc=;
 b=kiVzejG0GS79Q5IKzfeswYPV9CxS1xycQxatIP+2GD3S0aXt+PcbBEK3oVmjGET9MxElPQto64sTTZujYRLnch/CCKwXBcnLRCq5v8HWlnti+puwETNelDYA7ryZWx1ZfJESHpWrAW/Q4fljIk4u7TrxUKoTFjsMw2MlIq1PEyFz1K4dvmCNMTDcYBU6n9rNNWnl2JJl3wV9X++lEMlQ8N0iReJJmlZ7yBFVQxlbHTiZ/32fl08JS2WcbdtDsplsiDYPRk+KcTHCfdg0e3rv9eC40+fmTSYo+k8rASa4DIyVL9d0cJKdnVnNtAsEGLZffqLhw4gKpQALL7Di1myOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EpfkrHtwJuurVNeguIr2cRaxJl90ssW2wsI4ZVtlgc=;
 b=lVfcjKkCmbCTYKOA7ULSsU6UDcgn8u4d4oImiS9gPw7bm2KVIerirJJzlEiG6oFFsu1cfZDIjze04jbcHcriMSmhSslwE0O9t/ZPFFvF3fGUsqneYGKB7GQQBfg9CPA0pkaIqHyFJQNeWsPFGNPImeNAt5jLzYZVViiMA97tgjQgq4XncBLtKqQWE4/1r1XD7JxLwbjkWXms88PDuAKuiCzAtILe+vuibSwJbc59/cfX7wR+7cPQpEHWIAthjpJ2AMtychfrmjfEmpJr//c6WcX6CO9tBQovc6S4FM/ghO4kne+vMW3c2XcEqW9aRtlC0xR7CyTvN0s8AT4RUYFNbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 16:09:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 16:09:41 +0000
Date: Mon, 26 Jan 2026 12:09:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <20260126160940.GM1134360@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXOqVcX9YEC-Ikdt@willie-the-truck>
 <aXOrnMLLzZL9BtRT@willie-the-truck>
 <20260123200327.GF1134360@nvidia.com>
 <aXdlnLLFUBwjT0V5@willie-the-truck>
 <20260126152019.GK1134360@nvidia.com>
 <aXeQC3GjUgafuOi-@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXeQC3GjUgafuOi-@willie-the-truck>
X-ClientProxiedBy: IA1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 8175c48c-00e4-4ac6-2f80-08de5cf54fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XjyIn0uLw07KtOUH7y+t6OE+OotYiqRIvMpusWT2PM7jL8ZJ1V2dMNWcr14F?=
 =?us-ascii?Q?S5bu4eWSGOlDZGQWakGAtzs31H9Y+o3DjJp8fQfYHrwN5HKup1XDek2SoWfh?=
 =?us-ascii?Q?Pdmn6g8ICNGiY5yiDgbYQx2EpMt4s96FWCmgcSL0cpNHHzT3teg3iFdP0BTr?=
 =?us-ascii?Q?66VxPN3LMNRRbKgTLlEKJSmiFxnLlw851zxX5rZfkA+T00nYNhrfT4bmradI?=
 =?us-ascii?Q?gVdEjVlK8tj38PgxoOL1n0UOEkVOxqljovF3ylV5q30TDY6RzR+m9Vz/J0na?=
 =?us-ascii?Q?sO1kIeg0ImyzGyHOGaN0hwnHMHr7WIN1Mm2f0ktWJ4LXFAnXATsmw/ZqfvK3?=
 =?us-ascii?Q?Hf4Q8/5E/z3sw2tU51MT4GRlpgtC78y5gWvArLCRktO8T899/UH0jMc8Wkrl?=
 =?us-ascii?Q?s1uqLfYwkrLZX43nWTSSfaOsyyv4boNWkQe1qnaKCkog5+rJNcPzbBHWdkqm?=
 =?us-ascii?Q?MNKF4m8OJdtHeG5yQUeJpWRTk/GaLPHRDhtKbZSn2aPDl6iNBEm0o56WK7+S?=
 =?us-ascii?Q?/zqb5EhVPbpr6p3E5iDe+vbt47vCN8kuDlDjp68Ic29fzErLPhZhd6DMV/+U?=
 =?us-ascii?Q?QCEBTWnaJpiylLQbwDR1SkFzJQealjscEBr7PvJW8XQZavjVFASDvX2zpw4A?=
 =?us-ascii?Q?NNL0i1RaMOQ2XK2qhIoHZ8Ll12F4bz+mNueSNYujo0Q9SDlEYri3GE9RlD/1?=
 =?us-ascii?Q?C4bXcWJl7LwDziA/WMC/jFJJMIFG6fgJ5ei3IzhCAfkDUvF+0e6oQzWxd5Oa?=
 =?us-ascii?Q?2Lf0l+SKMdZs7ATAwXVEBg1Bwp4PG2mG1fTCS84LxwZD8Qw4ZOj8uBqbHP6W?=
 =?us-ascii?Q?4wRceMhgLtQtVbsGDyxKHSzDvGWhGdqblkrHwzD7IieebT9qvB0owyk+HOWq?=
 =?us-ascii?Q?jCCGRHzNh9NK5E4qL4NgvcBdABjGnKmWIBpPgmWtj9ZmfdWj4IfEzSFYgZ9x?=
 =?us-ascii?Q?5GhkNxidY0Qe/+zAphlVKJbwu24UbdfFGE7ftPAdHZ1DmUwmd8ir9bRCz22e?=
 =?us-ascii?Q?74jIdgK8/0fdSDoRtG6okweHtxEa6mKuG4MRAzh70KuEEGfjXfT6JlFGQQhW?=
 =?us-ascii?Q?y1v1UXTgyb0Dh3lFQKRFx+iNT+AxAFRlOxq1glLWrVFjkHHZa03UP0mD27Re?=
 =?us-ascii?Q?d9tQQp/5l2SvbQ7Tyc7B+yNLLj0fjwjEZwTVnPY5Yu0sQ4l01RI1ilO/bWPv?=
 =?us-ascii?Q?TYJrEaPCN2CxF/ozjBuqYDkE3hZPk4egwNuJXpTji1HOAWlnMrD+ebjQckVs?=
 =?us-ascii?Q?g/Rx6jQvMrrGfoOI+gUQblFTnKe6Qr7jnFISGi36kN550xgVgK3b5z+Y/3L9?=
 =?us-ascii?Q?e0Hjy/+kQaJEsWg/yDF8XmFOsOP29QsD3/0qDoGkX/hgbFEw1TrI2w5pn7vJ?=
 =?us-ascii?Q?0J24LcPaj1dQvbwA3CQWTZuuyXnM6QKo3nCsZvhqElYGJRwcdgY+QMzxhA5A?=
 =?us-ascii?Q?9NByqdiPdbPvWJYknsg6M6ujaI95a2K86bcpdLIrW3fKClnQaPGfKhntxYzl?=
 =?us-ascii?Q?q1iycyvIoR8ksu9Zke6fRfbf6uiPaf8sd8aGzgKuajvg4863u4aia1oDmnm1?=
 =?us-ascii?Q?vc45k6vDKLUWd0/0EVg5v25nJV5q3dXRwk3Xj/eB4nSc48aWcLjfk/iSjpnI?=
 =?us-ascii?Q?oA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NEQHXYH7G1WYe9WxEQe6XvgNXUcWyhS9dLCUm0CMWP9nSuhBmPmYJ5fu17y3?=
 =?us-ascii?Q?V+TXjdp/lgbDOPFUFBy3Ullk/1mTaqucWSGUIWq5iHaRct6N3kxhltLKUmgC?=
 =?us-ascii?Q?qviUNvo/DGQayQjEzQVQSA+lSqj2PPKHfkVkjmaw5z40qGDQBQXVdSMdnYCP?=
 =?us-ascii?Q?zXzlqC3Y13Y+2RBHNS4PeRAuHTawpaqfqhe7sZLBBIPbslJA1zNlWS6WPP7Y?=
 =?us-ascii?Q?kqyjyRza8TY+zv+AuWBlkPDgPTXXq7e18siVE6rexe38Jetic0hnegvDvxaP?=
 =?us-ascii?Q?VoAK74AaeHb5I0hCdV9t1teeh2dc6QopGmNWTTbNHsMfgikhexos6dCNOTkA?=
 =?us-ascii?Q?1CS1IoZpPlaPhCroc1ctozWEYlGAsplCyVQLr3lOKdpUjTlrnJNB78WCXP1g?=
 =?us-ascii?Q?+XFzYkuvbrKcYpyymccdgPfCjdHXuStpQTfDQSWMXUV1tvg2ntWLvh1ZcCpL?=
 =?us-ascii?Q?BtfzZ6P+b48yv/FDnQTaK2UqUpi5D1UADxjqk6ngj10ZOr+dvzlEVtME85Bf?=
 =?us-ascii?Q?uEjudyg8IJMJuUdB8JdoiH/zDNncze2wK5crKnS/RSOrsg5OWxwt5kuAmC+i?=
 =?us-ascii?Q?Ri/IT7OzXJoU5PAxYuMSs/BBBDnnub9VSeqFw2Jmfv8JRXZx7xa+L5Rq+QBd?=
 =?us-ascii?Q?/tTHUAem5ABzPE5ihPY1GIlKe9LK9hRzPx/T3+U6P/ahnnQWXksol6XB2qgG?=
 =?us-ascii?Q?oZL5/QoTX1JYeDY0mhYv4r0LywDQYtdiOrRRIsoXUkczv0AwWcJfbEz7JAib?=
 =?us-ascii?Q?kuf/IVEKB0dqKc3ocTIkTVrx0U5oGcJQo7zSHHY3GnmzjJNQVJvJbImaKZgl?=
 =?us-ascii?Q?KGyQeVhgGcEeW4DHu5BNsUUMYV+1aI04/5f4YKqaBXLmXmJ5Ml6exeh+xowX?=
 =?us-ascii?Q?S7GWPGILa91JlOQ9aW55zmq5d56n5shPQdjwxSLWzZ9NuGO+j0jaGJaY891B?=
 =?us-ascii?Q?DDPSqGYWpEWpcZNy8AhwQxv6zNlhkX7cNG8k9oCQ/khzNXZu4MQQOMJ5nesH?=
 =?us-ascii?Q?JDkfm1s5s7WCuQ0dAo7OgGQV/2XAuK/RiwP2HVINQF9LFzWxP0RV9yQnGt0Z?=
 =?us-ascii?Q?1J+iBdymuTEbABbORsGg3ED/3/tq6jzhsLhAxGM3lSObRAsboc90Rrk3jcax?=
 =?us-ascii?Q?qpC1rcxwBUjQHZat+bkC/ml8PWCK7zkSlYnC7FzeMIkNKX50WRV6D28JFvsJ?=
 =?us-ascii?Q?vESjk17AX/66f3zjVfaI74yfdxFCDsXtWDSY0s/BeenYMZean6TaGGQvwPRf?=
 =?us-ascii?Q?G4VDGJvIhIGk8j8ZgByZjGOd4GDtii7yVdUeItFpeErX54WCK24fq5D8wd1H?=
 =?us-ascii?Q?fnv9NnCt8+a8xFaFPmX1stxMreAzAVR9j/g97xV/dajDKl5zGlbKH2Ox42/w?=
 =?us-ascii?Q?zUvJegZc6I17oQdfyzgocblSv/IKnM5FObM1qCAWYKcSPn9KyZmguMjwDPgW?=
 =?us-ascii?Q?MVY4zmdGoRz7Ot8h4hM2j6YaefJrY85I2uAb5RHSXfBJgzTkdtw0cTB6Cicp?=
 =?us-ascii?Q?VHP5nL1Fg+UW3iTj04QZ+v6cGQz+UQM3ybLsaUNDjfhfm4lvTLVlRkY2jTvk?=
 =?us-ascii?Q?pauNycEWdn6vNnr0LRA/8rUjoRYxWmGdLIwZ3QuJFuEH/jn5AqItfCcTcmDy?=
 =?us-ascii?Q?GlYcej7MJTXQ0d/b+8za4UQlzn001SaQQCQqX4ZbqNzmbvW3bW93T6giXzYQ?=
 =?us-ascii?Q?bqz144Z6hhgywQpH+WWgKV8JW51qjNdUAhfvOKVqmlwp4cUe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8175c48c-00e4-4ac6-2f80-08de5cf54fe3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:09:41.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vM6FYgWuM0VNvInoMIjVpkJZVNMrahDsrqe/XZbwQ2Ibu3y16DGf5ctK3YPV9zev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

On Mon, Jan 26, 2026 at 04:02:19PM +0000, Will Deacon wrote:
> On Mon, Jan 26, 2026 at 11:20:19AM -0400, Jason Gunthorpe wrote:
> > On Mon, Jan 26, 2026 at 01:01:16PM +0000, Will Deacon wrote:
> > > On Fri, Jan 23, 2026 at 04:03:27PM -0400, Jason Gunthorpe wrote:
> > > > On Fri, Jan 23, 2026 at 05:10:52PM +0000, Will Deacon wrote:
> > > > > On Fri, Jan 23, 2026 at 05:05:31PM +0000, Will Deacon wrote:
> > > > > > On Fri, Dec 19, 2025 at 12:11:28PM -0800, Nicolin Chen wrote:
> > > > > > > +	/*
> > > > > > > +	 * We are committed to updating the STE. Ensure the invalidation array
> > > > > > > +	 * is visible to concurrent map/unmap threads, and acquire any racing
> > > > > > > +	 * IOPTE updates.
> > > > > > > +	 *
> > > > > > > +	 *  [CPU0]                        | [CPU1]
> > > > > > > +	 *                                |
> > > > > > > +	 *  change IOPTEs and TLB flush:  |
> > > > > > > +	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_old_domain_invs {
> > > > > > > +	 *    ...                         |   rcu_assign_pointer(new_invs);
> > > > > > > +	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
> > > > > > > +	 *    ...                         |   kfree_rcu(old_invs, rcu);
> > > > > > > +	 *    // load invalidation array  | }
> > > > > > > +	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
> > > > > > > +	 *                                |   STE = TTB0 // read new IOPTEs
> > > > > > > +	 */
> > > > > > > +	smp_mb();

> If we do that, can we drop the smp_mb()s from
> arm_smmu_install_{old,new}_domain_invs()?

I suppose so, but domain attach isn't a performance path so it depends
on your preference for strict pairing of barriers. Currently the two
smp_mbs() are paired. Can we reliably pair smp_mb() with dma_wmb()?
Are you happy with that clarity?

My view is attach isn't a performance path, so having extra barriers
is fine if it helps understandability.

Jason
